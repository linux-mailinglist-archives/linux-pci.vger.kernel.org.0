Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0033CF4EB
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 08:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242619AbhGTGRA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 02:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbhGTGQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jul 2021 02:16:50 -0400
X-Greylist: delayed 58640 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Jul 2021 23:57:20 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AA3C0613E0
        for <linux-pci@vger.kernel.org>; Mon, 19 Jul 2021 23:57:20 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CA891100B0521;
        Tue, 20 Jul 2021 08:57:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 985B230119; Tue, 20 Jul 2021 08:57:18 +0200 (CEST)
Date:   Tue, 20 Jul 2021 08:57:18 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210720065718.GA21556@wunner.de>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
 <20210616221945.GA3010216@bjorn-Precision-5520>
 <20210620073804.GA13118@wunner.de>
 <08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com>
 <20210719151011.GA25258@wunner.de>
 <a70a936d-d031-7199-4ed7-30753b3e7cfa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70a936d-d031-7199-4ed7-30753b3e7cfa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 19, 2021 at 02:00:51PM -0500, stuart hayes wrote:
> On 7/19/2021 10:10 AM, Lukas Wunner wrote:
> > Could you test if the below patch fixes the issue?
> 
> That does appear to fix the issue, thanks!  Without your patch, the PCIe
> devices under 64:02.0 disappear (the triggered bit is still set in the DPC
> capability).  With your patch, recovery is successful and all of the PCIe
> devices are still there.

Thanks for testing.

The test patch clears DLLSC because the Hot Reset that is propagated
down the hierarchy causes the link to flap.  I'm wondering though if
that's sufficient or if PDC needs to be cleared as well.  According
to PCIe Base Spec sec. 4.2.6, LTSSM transitions from "Hot Reset" state
to "Detect", then "Polling".  If I understand the table "Link Status
Mapped to the LTSSM" in the spec correctly, in-band presence is 0b
in Detect state, hence I'd expect PDC to flap as well as a result of
a Hot Reset being propagated down the hierarchy.

Does the hotplug port at 0000:68:00.0 support In-Band Presence Disable?
That would explain why only clearing DLLSC is sufficient.

The problem is, if PDC is cleared as well, we lose the ability to
detect that a device was hot-removed while the reset was ongoing,
which is unfortunate.

If an error is handled by aer_root_reset() (instead of dpc_reset_link())
and the reset is performed at a hotplug port, then pciehp_reset_slot()
is invoked:

aer_root_reset()
  pci_bus_error_reset()
    pci_slot_reset()
      pci_reset_hotplug_slot()
        pciehp_reset_slot()

pciehp_reset_slot() temporarily masks both DLLSC *and* PDC events,
then performs a Secondary Bus Reset at the hotplug port.

If there are further hotplug ports below that hotplug port
where the SBR is performed, my expectation is that the Hot Reset
is likewise propagated down the hierarchy (just as with DPC),
so those cascaded hotplug ports should also see their link go down.

In other words, the issue you're seeing isn't really DPC-specific.
However, the test patch should fix the issue for AER-handled errors
as well.  Do you agree with this analysis or did I miss anything?

Thanks,

Lukas

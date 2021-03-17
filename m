Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B633F8AD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 20:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhCQTCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 15:02:01 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:38433 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbhCQTB7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 15:01:59 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7DAFC2800B3C3;
        Wed, 17 Mar 2021 20:01:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6E2D02A294B; Wed, 17 Mar 2021 20:01:51 +0100 (CET)
Date:   Wed, 17 Mar 2021 20:01:51 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
Message-ID: <20210317190151.GA27146@wunner.de>
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
 <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de>
 <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
 <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com>
 <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
 <CAC41dw_BJBMdwyccdvWNZsdAzzh7ko=q4oSpQXo-jJDTfQGkZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC41dw_BJBMdwyccdvWNZsdAzzh7ko=q4oSpQXo-jJDTfQGkZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 17, 2021 at 10:54:09AM -0700, Sathyanarayanan Kuppuswamy Natarajan wrote:
> Flush of hotplug event after successful recovery, and a simulated
> hotplug link down event after link recovery fails should solve the
> problems raised by Lukas. I assume Lukas' proposal adds this support.
> I will check his patch shortly.

Thank you!

I'd like to get a better understanding of the issues around hotplug/DPC,
specifically I'm wondering:

If DPC recovery was successful, what is the desired behavior by pciehp,
should it ignore the Link Down/Up or bring the slot down and back up
after DPC recovery?

If the events are ignored, the driver of the device in the hotplug slot
is not unbound and rebound.  So the driver must be able to cope with
loss of TLPs during DPC recovery and it must be able to cope with
whatever state the endpoint device is in after DPC recovery.
Is this really safe?  How does the nvme driver deal with it?

Also, if DPC is handled by firmware, your patch does not ignore the
Link Down/Up events, so pciehp brings down the slot when DPC is
triggered, then brings it up after succesful recovery.  In a code
comment, you write that this behavior is okay because there's "no
race between hotplug and DPC recovery".  However, Sinan wrote in
2018 that one of the issues with hotplug versus DPC is that pciehp
may turn off slot power and thereby foil DPC recovery.  (Power off =
cold reset, whereas DPC recovery = warm reset.)  This can occur
as well if DPC is handled by firmware.

So I guess pciehp should make an attempt to await DPC recovery even
if it's handled by firmware?  Or am I missing something?  We may be
able to achieve that by polling the DPC Trigger Status bit and
DLLLA bit, but it won't work as perfectly as with native DPC support.

Finally, you write in your commit message that there are "a lot of
stability issues" if pciehp and DPC are allowed to recover freely
without proper serialization.  What are these issues exactly?
(Beyond the slot power issue mentioned above, and that the endpoint
device's driver should presumably not be unbound if DPC recovery
was successful.)

Thanks!

Lukas

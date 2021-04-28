Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC0436D9B9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhD1Ol3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhD1Ol2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Apr 2021 10:41:28 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC1CC061573
        for <linux-pci@vger.kernel.org>; Wed, 28 Apr 2021 07:40:43 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 751403000064C;
        Wed, 28 Apr 2021 16:40:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 691D92DC693; Wed, 28 Apr 2021 16:40:41 +0200 (CEST)
Date:   Wed, 28 Apr 2021 16:40:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210428144041.GA27967@wunner.de>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <4177f0be-5859-9a71-da06-2e67641568d7@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177f0be-5859-9a71-da06-2e67641568d7@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 06:08:02PM +0800, Yicong Yang wrote:
> I've tested the patch on our board, but the hotplug will still be
> triggered sometimes.
> seems the hotplug doesn't find the link down event is caused by dpc.
> Any further test I can do?
> 
> mestuary:/$ [12508.408576] pcieport 0000:00:10.0: DPC: containment event, status:0x1f21 source:0x0000
> [12508.423016] pcieport 0000:00:10.0: DPC: unmasked uncorrectable error detected
> [12508.434277] pcieport 0000:00:10.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer ID)
> [12508.447651] pcieport 0000:00:10.0:   device [19e5:a130] error status/mask=00008000/04400000
> [12508.458279] pcieport 0000:00:10.0:    [15] CmpltAbrt              (First)
> [12508.467094] pcieport 0000:00:10.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
> [12511.152329] pcieport 0000:00:10.0: pciehp: Slot(0): Link Down

Note that about 3 seconds pass between DPC trigger and hotplug link down
(12508 -> 12511).  That's most likely the 3 second timeout in my patch:

+	/*
+	 * Need a timeout in case DPC never completes due to failure of
+	 * dpc_wait_rp_inactive().
+	 */
+	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
+			   msecs_to_jiffies(3000));

If DPC doesn't recover within 3 seconds, pciehp will consider the
error unrecoverable and bring down the slot, no matter what.

I can't tell you why DPC is unable to recover.  Does it help if you
raise the timeout to, say, 5000 msec?

Thanks,

Lukas

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24734633BB9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 12:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiKVLqm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 22 Nov 2022 06:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiKVLqU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 06:46:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE06AE7D
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 03:45:47 -0800 (PST)
Received: from frapeml100007.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGj7N11nQz6H7Xj;
        Tue, 22 Nov 2022 19:43:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 12:45:45 +0100
Received: from localhost (10.45.149.88) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 11:45:44 +0000
Date:   Tue, 22 Nov 2022 11:45:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Chris Chiu" <chris.chiu@canonical.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account
 when distributing resources
Message-ID: <20221122114541.00005ff9@Huawei.com>
In-Reply-To: <Y3xvcvqgFbYMIIpl@black.fi.intel.com>
References: <Y3tlRIG99P/amO9Q@black.fi.intel.com>
        <20221121224548.GA138441@bhelgaas>
        <Y3xvcvqgFbYMIIpl@black.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.45.149.88]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 22 Nov 2022 08:42:58 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
> 
> On Mon, Nov 21, 2022 at 04:45:48PM -0600, Bjorn Helgaas wrote:
> > IIUC, the summary is this:
> > 
> >   00:02.0 bridge window [mem 0x10000000-0x102fffff] to [bus 01-02]
> >   01:02.0 bridge window [mem 0x10000000-0x100fffff] to [bus 02]
> >   01:03.0 NIC BAR [mem 0x10200000-0x1021ffff]
> >   01:04.0 NIC BAR [mem 0x10220000-0x1023ffff]
> >   02:05.0 NIC BAR [mem 0x10080000-0x1009ffff]
> > 
> > and it's the same with and without the current patch.
> > 
> > Are all these assignments done by BIOS, or did Linux update them?  
> 
> > Did we exercise the same "distribute available resources" path as in
> > the PCIe case?  I expect we *should*, because there really shouldn't
> > be any PCI vs PCIe differences in how resources are handled.  This is
> > why I'm not comfortable with assumptions here that depend on PCIe.
> > 
> > I can't tell from Jonathan's PCIe case whether we got a working config
> > from BIOS or not because our logging of bridge windows is kind of
> > poor.  
> 
> This is ARM64 so there is no "BIOS" involved (something similar though).

It's EDK2 in my tests  - so very similar to other arch.
Possible to boot without though and rely on DT, but various things don't
work yet...

> 
> It is the same "system" that Jonathan used where the regression happened
> with the multifunction PCIe configuration with the exception that I'm
> now using PCI devices instead of PCIe as you asked.
> 
> I'm not 100% sure if the all the same code paths are used here, though.
> 

I wondered if it was possibly to do with fairly minimal handling of pci-pxb
(the weird root bridge) in EDK2, so tried the obvious of hanging your PCI
test below one of those rather than directly below a normal bridge.
Despite shuffling things around into configurations
I thought might trigger the problem, it all seems fine.

Note that I can't currently test the pxb-pcie configurations without EDK2
as arm-virt doesn't provide the relevant DT for those root bridges yet
(it's on my todo list as it's a prereq for getting the QEMU CXL ARM64
emulation upstream)

So no guarantees as I don't understand fully why PCI is ending up
with different handling.

From liberal distribution of printk()s it seems that for PCI bridges
pci_bridge_resources_not_assigned() is false, but for PCI express
example it is true.  My first instinct is quirk of the EDK2 handling? 
I'll have a dig, but I'm not an expert in EDK2 at all, so may not get
to the bottom of this.

Ultimately it seems that when the OS takes over the prefetchable memory
resources are not configured for the PCIe case, but are for the PCI case.
So we aren't currently walking the new code for PCI.

Jonathan

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4F7C92DC
	for <lists+linux-pci@lfdr.de>; Sat, 14 Oct 2023 07:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJNFxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Oct 2023 01:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNFxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2023 01:53:09 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE1EBF;
        Fri, 13 Oct 2023 22:53:06 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39E5qqtp120288;
        Sat, 14 Oct 2023 00:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697262772;
        bh=Z55w+i1elXlTVNwXAdZ8wM5eZmX5qrwAzNPWjD2l6LU=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=IoCsulLvRVfgrFh0TCgJ2sea9zjBhR/b+WWovMSLIwfYwQ0u/8sQCC+SWil1sYjOO
         r9u0kzuKpf/iWyFdQC9g41EjntpiwxiaEKphCiTLOBP+1OYyicY88UkbujHGV16Awa
         IY03weBX/UHTJfBMfoqHzkJMlzqir0siLOOjsDTs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39E5qqCY086527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 14 Oct 2023 00:52:52 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 14
 Oct 2023 00:52:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 14 Oct 2023 00:52:52 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39E5qmIc021652;
        Sat, 14 Oct 2023 00:52:49 -0500
Message-ID: <c11f4b9f-8cbe-1fd0-886b-f36547dc8d3c@ti.com>
Date:   Sat, 14 Oct 2023 11:22:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
CC:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20231013184958.GA1118393@bhelgaas>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20231013184958.GA1118393@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14/10/23 00:19, Bjorn Helgaas wrote:
> On Fri, Oct 13, 2023 at 10:36:01AM +0530, Siddharth Vadapalli wrote:
>> On 13/10/23 10:33, Siddharth Vadapalli wrote:
>>> On 12/10/23 22:13, Bjorn Helgaas wrote:
>>>> On Thu, Oct 12, 2023 at 10:15:09AM +0530, Siddharth Vadapalli wrote:
>>>>> On 11/10/23 19:16, Bjorn Helgaas wrote:
>>> ...
>>>>>                                               msix_prepare_msi_desc
>>>>> In this function: msix_prepare_msi_desc, the following readl()
>>>>> causes completion timeout:
>>>>> 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>>>> The completion timeout with the readl is only observed when the link
>>>>> is down (No Endpoint device is actually connected to the PCIe
>>>>> connector slot).
>>>>
>>>> Do you know the address ("addr")?  From pci_msix_desc_addr(), it looks
>>>> like it should be:
>>>>
>>>>   desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE
>>>>
>>>> and desc->pci.mask_base should be dev->msix_base, which we got from
>>>> msix_map_region(), which ioremaps part of the BAR indicated by the
>>>> MSI-X Table Offset/Table BIR register.
>>>>
>>>> I wonder if this readl() is being handled as an MMIO access to a
>>>> downstream device instead of a Root Port BAR access because it's
>>>> inside the Root Port's MMIO window.
>>>>
>>>> Could you dump out these values just before the readl()?
>>>>
>>>>   phys_addr inside msix_map_region()
>>>>   dev->msix_base
>>>>   desc->pci.mask_base
>>>>   desc->msi_index
>>>>   addr
>>>
>>> phys_addr: 0x10102000
>>> msix_base: 0xffff80000997a000
>>> mask_base: 0xffff80000997a000
>>> msi_index: 0
>>> addr: 0xffff80000997a000
>>>
>>> Also, the details of BAR allocation from the logs are:
>>> keystone-pcie 5500000.pcie: host bridge /bus@100000/pcie@5500000 ranges:
>>> keystone-pcie 5500000.pcie:       IO 0x0010020000..0x001002ffff -> 0x0000000000
>>> keystone-pcie 5500000.pcie:      MEM 0x0010030000..0x0017ffffff -> 0x0010030000
>>> keystone-pcie 5500000.pcie: iATU unroll: enabled
>>> keystone-pcie 5500000.pcie: iATU regions: 8 ob, 8 ib, align 64K, limit 4G
>>> keystone-pcie 5500000.pcie: Phy link never came up
>>> keystone-pcie 5500000.pcie: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [bus 00-ff]
>>> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>>> pci_bus 0000:00: root bus resource [mem 0x10030000-0x17ffffff]
>>> pci 0000:00:00.0: [104c:b00c] type 01 class 0x060400
>>> pci 0000:00:00.0: reg 0x10: [mem 0x05500000-0x055fffff]
>>> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
>>> pci 0000:00:00.0: supports D1
>>> pci 0000:00:00.0: PME# supported from D0 D1 D3hot
>>> pci 0000:00:00.0: BAR 0: assigned [mem 0x10100000-0x101fffff]
>>> pci 0000:00:00.0: BAR 6: assigned [mem 0x10030000-0x1003ffff pref]
>>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>>>
>>> The value of phys_addr lies within the range allocated to BAR0.
>>>
>>>>   call early_dump_pci_device() on the Root Port
>>>
>>> I invoked early_dump_pci_device() within the pci_setup_device() function in
>>> drivers/pci/probe.c and the output is:
> 
> It'd be better to dump the config space immediately before the readl()
> since the PCI core did change some things in the interim.

I dumped the config space just before the readl() and it is:

pcieport 0000:00:00.0: config space:
00000000: 4c 10 0c b0 07 01 10 00 01 00 04 06 00 00 01 00
00000010: 00 00 10 10 00 00 00 00 00 01 ff 00 f0 00 00 00
00000020: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
00000030: 00 00 00 00 40 00 00 00 00 00 00 00 17 01 02 00
00000040: 01 50 c3 5b 08 00 00 00 00 00 00 00 00 00 00 00
00000050: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000070: 10 b0 42 00 01 80 00 00 1f 20 00 00 22 3c 73 00
00000080: 00 00 11 10 00 00 00 00 c0 03 40 00 10 00 01 00
00000090: 00 00 00 00 1f 04 00 00 00 00 00 00 06 00 00 00
000000a0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
000000b0: 11 00 00 c1 00 20 00 00 00 40 00 00 00 00 00 00
000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

BAR0 was configured with the value: 0x05500000 within ks_pcie_v3_65_add_bus() at:
dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
and can be verified based on the previous config space dump I had shared within
the pci_setup_device() function. But, looking at the dump above which is just
before the readl(), its value seems to have changed to 0x10100000.

I am listing down the regions of config space which have changed, based on the
comparison of dumps taken within pci_setup_device() and just before the readl():

Within pci_setup_device():
00000010: 00 00 50 05 00 00 00 00 00 01 ff 00 00 00 00 00
Before readl():
00000010: 00 00 10 10 00 00 00 00 00 01 ff 00 f0 00 00 00

Within pci_setup_device():
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Before readl():
00000020: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00

Within pci_setup_device():
00000030: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
Before readl():
00000030: 00 00 00 00 40 00 00 00 00 00 00 00 17 01 02 00

Within pci_setup_device():
00000070: 10 b0 42 00 01 80 00 00 10 20 00 00 22 3c 73 00
Before readl():
00000070: 10 b0 42 00 01 80 00 00 1f 20 00 00 22 3c 73 00

Within pci_setup_device():
00000080: 00 00 11 10 00 00 00 00 c0 03 40 00 00 00 01 00
Before readl():
00000080: 00 00 11 10 00 00 00 00 c0 03 40 00 10 00 01 00

Within pci_setup_device():
000000b0: 11 00 00 01 00 20 00 00 00 40 00 00 00 00 00 00
Before readl():
000000b0: 11 00 00 c1 00 20 00 00 00 40 00 00 00 00 00 00

> 
>>> pci 0000:00:00.0: config space:
>>> 00000000: 4c 10 0c b0 07 01 10 00 01 00 04 06 00 00 01 00
> 
>   PCI_COMMAND = 0x0107
>     PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_SERR
> 
>>> 00000010: 00 00 50 05 00 00 00 00 00 01 ff 00 00 00 00 00
>>> 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
>   PCI_IO_BASE            =       0x00 low 4 bits indicate 16-bit addressing
>   PCI_IO_LIMIT           =       0x00
>   PCI_MEMORY_BASE        =     0x0000
>   PCI_MEMORY_LIMIT       =     0x0000
>   PCI_PREF_MEMORY_BASE   =     0x0000 low 4 bits indicate 32-bit pref
>   PCI_PREF_MEMORY_LIMIT  =     0x0000
>   PCI_PREF_BASE_UPPER32  = 0x00000000
>   PCI_PREF_LIMIT_UPPER32 = 0x00000000
> 
> We can't tell from this whether the prefetchable window is implemented
> (but I'm sure keystone *does* implement it).  If PCI_PREF_MEMORY_BASE
> and PCI_PREF_MEMORY_LIMIT are read-only zeros, it is not implemented.
> If they are writable, it is enabled at the same range as the
> non-prefetchable window.

Yes, PCI_PREF_MEMORY_BASE and PCI_PREF_MEMORY_LIMIT are writable.

> 
> Similarly for the I/O window; we can't tell whether the base/limit are
> read-only zero or writable.

PCI_IO_BASE and PCI_IO_LIMIT are also writable.

> 
> So we have these windows that look like they're probably enabled:
> 
>   io window   at [io  0x0000-0x0fff]
>   mem window  at [mem 0x00000000-0x000fffff]
>   pref window at [mem 0x00000000-0x000fffff pref]
> 
> No idea whether it makes a difference, but these windows seem
> misconfigured.  The default should probably be to make them all
> disabled (as in f73eedc90bf7 ("PCI: vmd: Disable bridge window for
> domain reset")):
> 
>   PCI_IO_BASE            = 0xf0
>   PCI_IO_LIMIT           = 0x00
>   PCI_MEMORY_BASE        = 0xfff0
>   PCI_MEMORY_LIMIT       = 0x0000
>   PCI_PREF_MEMORY_BASE   = 0xfff0
>   PCI_PREF_MEMORY_LIMIT  = 0x0000
>   PCI_PREF_BASE_UPPER32  = 0xffffffff
>   PCI_PREF_LIMIT_UPPER32 = 0x00000000
> 
> The PCI core should reconfigure and enable them as needed by
> downstream devices.
> 
>> I also noticed that the value of desc->pci.msix_ctrl obtained from
>> the readl is always 0xffffffff irrespective of whether or not an
>> endpoint device is connected. This isn't expected right? The only
>> difference between the cases where endpoint device is connected and
>> isn't connected is the completion timeout.
> 
> Right, I wouldn't expect that.  PCI_MSIX_ENTRY_VECTOR_CTRL has a bunch
> of reserved bits that should be zero.
> 
> I assume MSI-X actually does work for downstream endpoints?  I
> wouldn't think anybody would have bothered with
> ks_pcie_v3_65_add_bus() unless MSI-X works.

Yes, I think it is supposed to work, but it doesn't seem to be working right now
considering that even with Endpoint device connected, the readl() returns all Fs.

-- 
Regards,
Siddharth.

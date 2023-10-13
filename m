Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FD87C7CE3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 07:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJMFD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 01:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJMFDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 01:03:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C9C9;
        Thu, 12 Oct 2023 22:03:22 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39D53BxY127196;
        Fri, 13 Oct 2023 00:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697173391;
        bh=lwW4nwJHn4M3/aZupB7mYnc/t55OrDG40S1UAJWJXH8=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=dChlk3FwxB9if6OZ1lmrcszsKHm64ziRC9dqCp5MgtaBajVNZL64Mn1yHMZN7tkoP
         vRwf3jmPkzx3HAxZNwAcCwAK9rmT5Yw1Cbm4Ms/2IIfs3JhRB/IQfbJkcCciDrjFAK
         gUzDOlYeXy3dv5d5bgMK/54WaM6HAlC6/Kqs6XmQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39D53BbO024064
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 00:03:11 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 00:03:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 00:03:11 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39D537ad024571;
        Fri, 13 Oct 2023 00:03:07 -0500
Message-ID: <5613f8e1-9c73-18c3-8a19-9a164b09b577@ti.com>
Date:   Fri, 13 Oct 2023 10:33:06 +0530
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
References: <20231012164336.GA1072823@bhelgaas>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20231012164336.GA1072823@bhelgaas>
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



On 12/10/23 22:13, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2023 at 10:15:09AM +0530, Siddharth Vadapalli wrote:
>> Hello Bjorn,
>>
>> Thank you for reviewing the patch.
>>
>> On 11/10/23 19:16, Bjorn Helgaas wrote:
>>> Hi Siddharth,
>>>

...

>>                                               msix_prepare_msi_desc
>> In this function: msix_prepare_msi_desc, the following readl()
>> causes completion timeout:
>> 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>> The completion timeout with the readl is only observed when the link
>> is down (No Endpoint device is actually connected to the PCIe
>> connector slot).
> 
> Do you know the address ("addr")?  From pci_msix_desc_addr(), it looks
> like it should be:
> 
>   desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE
> 
> and desc->pci.mask_base should be dev->msix_base, which we got from
> msix_map_region(), which ioremaps part of the BAR indicated by the
> MSI-X Table Offset/Table BIR register.
> 
> I wonder if this readl() is being handled as an MMIO access to a
> downstream device instead of a Root Port BAR access because it's
> inside the Root Port's MMIO window.
> 
> Could you dump out these values just before the readl()?
> 
>   phys_addr inside msix_map_region()
>   dev->msix_base
>   desc->pci.mask_base
>   desc->msi_index
>   addr

phys_addr: 0x10102000
msix_base: 0xffff80000997a000
mask_base: 0xffff80000997a000
msi_index: 0
addr: 0xffff80000997a000

Also, the details of BAR allocation from the logs are:
keystone-pcie 5500000.pcie: host bridge /bus@100000/pcie@5500000 ranges:
keystone-pcie 5500000.pcie:       IO 0x0010020000..0x001002ffff -> 0x0000000000
keystone-pcie 5500000.pcie:      MEM 0x0010030000..0x0017ffffff -> 0x0010030000
keystone-pcie 5500000.pcie: iATU unroll: enabled
keystone-pcie 5500000.pcie: iATU regions: 8 ob, 8 ib, align 64K, limit 4G
keystone-pcie 5500000.pcie: Phy link never came up
keystone-pcie 5500000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x10030000-0x17ffffff]
pci 0000:00:00.0: [104c:b00c] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x05500000-0x055fffff]
pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot
pci 0000:00:00.0: BAR 0: assigned [mem 0x10100000-0x101fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x10030000-0x1003ffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01-ff]

The value of phys_addr lies within the range allocated to BAR0.

>   call early_dump_pci_device() on the Root Port

I invoked early_dump_pci_device() within the pci_setup_device() function in
drivers/pci/probe.c and the output is:

pci 0000:00:00.0: config space:
00000000: 4c 10 0c b0 07 01 10 00 01 00 04 06 00 00 01 00
00000010: 00 00 50 05 00 00 00 00 00 01 ff 00 00 00 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000030: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
00000040: 01 50 c3 5b 08 00 00 00 00 00 00 00 00 00 00 00
00000050: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000070: 10 b0 42 00 01 80 00 00 10 20 00 00 22 3c 73 00
00000080: 00 00 11 10 00 00 00 00 c0 03 40 00 00 00 01 00
00000090: 00 00 00 00 1f 04 00 00 00 00 00 00 06 00 00 00
000000a0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
000000b0: 11 00 00 01 00 20 00 00 00 40 00 00 00 00 00 00
000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


> 
> Bjorn

-- 
Regards,
Siddharth.

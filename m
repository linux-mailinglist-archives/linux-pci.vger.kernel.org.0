Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381D7232BC9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 08:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgG3GOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 02:14:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbgG3GOu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 02:14:50 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5D81B31CC97EB0805AA8;
        Thu, 30 Jul 2020 14:14:46 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 14:14:43 +0800
Subject: Re: [PATCH] PCI: Put the IVRS table in AMD ACS quirk handler
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Donald Dutile <ddutile@redhat.com>
References: <20200729230242.GA1974304@bjorn-Precision-5520>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <74348feb-5646-6d33-1a84-532f9179df78@huawei.com>
Date:   Thu, 30 Jul 2020 14:14:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200729230242.GA1974304@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/7/30 7:02, Bjorn Helgaas wrote:
> [+cc Alex, Don]
> 
> On Wed, Jul 22, 2020 at 05:44:28PM +0800, Hanjun Guo wrote:
>> The acpi_get_table() should be coupled with acpi_put_table() if
>> the mapped table is not used at runtime to release the table
>> mapping.
>>
>> In pci_quirk_amd_sb_acs(), IVRS table is just used for checking
>> AMD IOMMU is supported, not used at runtime, put the table after
>> using it.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> 
> Applied to pci/virtualization for v5.9, thanks!
> 
> I added this:
> 
>    Fixes: 15b100dfd1c9 ("PCI: Claim ACS support for AMD southbridge devices")
> 
> but I didn't add a stable tag.  Does this cause any issue that would
> warrant a stable tag?

We don't have one when I was sending same function patch for ACPI
subsystem, so I think it's OK to without a stable tag for this
patch as well.

Thanks
Hanjun


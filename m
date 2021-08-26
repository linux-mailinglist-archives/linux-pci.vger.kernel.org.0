Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C83F8E7F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 21:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhHZTNV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 15:13:21 -0400
Received: from foss.arm.com ([217.140.110.172]:52386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243307AbhHZTNU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 15:13:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3CE61042;
        Thu, 26 Aug 2021 12:12:32 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2039A3F5A1;
        Thu, 26 Aug 2021 12:12:31 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] PCI: Set dma-can-stall for HiSilicon chips
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20210826182624.GA3694827@bjorn-Precision-5520>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <225e905d-b7b2-c740-de94-2f4aece75f59@arm.com>
Date:   Thu, 26 Aug 2021 20:12:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826182624.GA3694827@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-26 19:26, Bjorn Helgaas wrote:
> [+cc Will, Robin, Joerg, hoping for an ack]
> 
> On Tue, Jul 13, 2021 at 10:54:36AM +0800, Zhangfei Gao wrote:
>> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
>> actually on the AMBA bus. These fake PCI devices can support SVA via
>> SMMU stall feature, by setting dma-can-stall for ACPI platforms.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>   drivers/pci/quirks.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 5d46ac6..03b0f98 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1823,10 +1823,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
>>   
>>   static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>>   {
>> +	struct property_entry properties[] = {
>> +		PROPERTY_ENTRY_BOOL("dma-can-stall"),
> 
> "dma-can-stall" is used in arm_smmu_probe_device() to help set
> master->stall_enabled.
> 
> I don't know the implications, so it'd be nice to get an ack from a
> maintainer of that code.

If it helps,

Acked-by: Robin Murphy <robin.murphy@arm.com>

Normally stalling must not be enabled for PCI devices, since it would 
break the PCI requirement for free-flowing writes and may lead to 
deadlock. We expect PCI devices to support ATS and PRI if they want to 
be fault-tolerant, so there's no ACPI binding to describe anything else, 
even when a "PCI" device turns out to be a regular old SoC device 
dressed up as a RCiEP and normal rules don't apply.

I'm taking it on trust that stalling really is safe for all possible 
matching devices here (in general, deadlock may still be possible in the 
SoC interconnect depending on topology, hence why it's an explicit 
opt-in even for platform devices), but TBH either way I think I'd rather 
have this as a quirk in the kernel under our control, than have vendors 
attempt to play tricks with _DSD properties out in the field :)

Cheers,
Robin.

>> +		{},
>> +	};
>> +
>>   	if (pdev->revision != 0x21 && pdev->revision != 0x30)
>>   		return;
>>   
>>   	pdev->pasid_no_tlp = 1;
>> +
>> +	/*
>> +	 * Set the dma-can-stall property on ACPI platforms. Device tree
>> +	 * can set it directly.
>> +	 */
>> +	if (!pdev->dev.of_node &&
>> +	    device_add_properties(&pdev->dev, properties))
>> +		pci_warn(pdev, "could not add stall property");
>>   }
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
>> -- 
>> 2.7.4
>>

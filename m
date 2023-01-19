Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C626734D9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 10:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASJzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 04:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjASJzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 04:55:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25A665D106;
        Thu, 19 Jan 2023 01:55:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 666DA1758;
        Thu, 19 Jan 2023 01:56:30 -0800 (PST)
Received: from [10.57.75.229] (unknown [10.57.75.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 521673F71A;
        Thu, 19 Jan 2023 01:55:47 -0800 (PST)
Message-ID: <8cfad7ad-a375-3ca8-45fe-a1753e77dac5@arm.com>
Date:   Thu, 19 Jan 2023 09:55:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] hwtracing: hisi_ptt: Only add the supported
 devices to the filters list
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     mathieu.poirier@linaro.org, jonathan.cameron@huawei.com,
        yangyicong@hisilicon.com, alexander.shishkin@linux.intel.com,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
References: <20230112112201.16283-1-yangyicong@huawei.com>
 <252ff08d-55ed-b733-6b66-4ea40f07e501@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <252ff08d-55ed-b733-6b66-4ea40f07e501@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/01/2023 09:10, Yicong Yang wrote:
> Hi Suzuki,
> 
> Any comments or is it ok to pick these two patches?
> Hope to not miss this cycle since there's one fix :)

Apologies, I will queue this, once I clear my queue.

Thanks
Suzuki


> 
> Thanks,
> Yicong
> 
> On 2023/1/12 19:22, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The PTT device can only support the devices on the same PCIe core,
>> within BDF range [lower_bdf, upper_bdf]. It's not correct to assume
>> the devices on the root bus are from the same PCIe core, there are
>> cases that root ports from different PCIe core are sharing the same
>> bus. So check when initializing the filters list.
>>
>> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>> Change since v2:
>> - Refine the commit per Bjorn
>> Link: https://lore.kernel.org/linux-pci/20230110130833.53474-1-yangyicong@huawei.com/
>>
>> Change since v1:
>> - Add tags from Jonathan
>> Link: https://lore.kernel.org/linux-pci/20221122120209.25682-1-yangyicong@huawei.com/raw
>>
>>   drivers/hwtracing/ptt/hisi_ptt.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 5d5526aa60c4..30f1525639b5 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -356,8 +356,18 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>>   
>>   static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>>   {
>> +	struct pci_dev *root_port = pcie_find_root_port(pdev);
>>   	struct hisi_ptt_filter_desc *filter;
>>   	struct hisi_ptt *hisi_ptt = data;
>> +	u32 port_devid;
>> +
>> +	if (!root_port)
>> +		return 0;
>> +
>> +	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
>> +	if (port_devid < hisi_ptt->lower_bdf ||
>> +	    port_devid > hisi_ptt->upper_bdf)
>> +		return 0;
>>   
>>   	/*
>>   	 * We won't fail the probe if filter allocation failed here. The filters
>>


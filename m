Return-Path: <linux-pci+bounces-12399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FF963793
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 03:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7851028541E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75D7134D1;
	Thu, 29 Aug 2024 01:20:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139510A24
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894430; cv=none; b=gGRqkhpz1zemGvk3CYQJDHO06cekoZ0gW3jJVNZN6c3xnYxih3PrGCeQ8jG8YtOq233hbvmW/qoyMaIH6AvcvFfRaPmJ20U/jCkXVdX42Q2KxXzUPpeK62BKRPQS679WxVuNUsGFuiJteSBIRgi0SxsyxXzGAN8OUvEUjty5LPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894430; c=relaxed/simple;
	bh=z69j2nGSTqDx5+EZTAwMDwvkNx9FUvo16mJGNT98cQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iydrkO819rOxY4NKIuzkG/De7DcbxAiZpP8YMx5RniNk4eSM5UOXSFi3HFzU5Y5Yemakt1adsl3uw43WZpLvo98Bs+E2DplEOGOj7lEqkxeZ8gKcnQ36YhykJdAysr3trPQgm1BtdpJn/CxjoNSAjTdPP8cHnlQb02hp1er/wHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvNkP3Fvrz2Dbbs;
	Thu, 29 Aug 2024 09:20:13 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 894571A0188;
	Thu, 29 Aug 2024 09:20:25 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 09:20:24 +0800
Message-ID: <37c7dc6f-f994-4620-a9af-6c90eba7ebdf@huawei.com>
Date: Thu, 29 Aug 2024 09:20:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] PCI: kirin: Use helper function
 for_each_available_child_of_node_scoped()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
References: <20240828073825.43072-1-zhangzekun11@huawei.com>
 <20240828073825.43072-2-zhangzekun11@huawei.com>
 <20240828131117.00004d1b@Huawei.com>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <20240828131117.00004d1b@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)



在 2024/8/28 20:11, Jonathan Cameron 写道:
> On Wed, 28 Aug 2024 15:38:21 +0800
> Zhang Zekun <zhangzekun11@huawei.com> wrote:
> 
>> for_each_available_child_of_node_scoped() provides a scope-based cleanup
>> functinality to put the device_node automatically, and we don't need to
>> call of_node_put() directly.  Let's simplify the code a bit with the use
>> of these functions.
>>
>> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> Hi.
> 
> Looks good.  A passing comment on another ugly bit of code in his
> function that you could tidy up whilst here.
> 
> For what you have covered
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>   drivers/pci/controller/dwc/pcie-kirin.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
>> index 0a29136491b8..e9bda1746ca5 100644
>> --- a/drivers/pci/controller/dwc/pcie-kirin.c
>> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
>> @@ -452,7 +452,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>>   				    struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> -	struct device_node *child, *node = dev->of_node;
>> +	struct device_node *node = dev->of_node;
>>   	void __iomem *apb_base;
>>   	int ret;
>>   
>> @@ -477,17 +477,13 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>>   		return ret;
>>   
> Looking at this function I don't suppose you fancy also tidying up the oddity of:
> 	kirin_pcie->gpio_id_dwc_perst = of_get_named_gpio(dev->of_node,
> 							  "reset-gpios", 0);
> 	if (kirin_pcie->gpio_id_dwc_perst == -EPROBE_DEFER) {
> 		return -EPROBE_DEFER;
> 	} else if (!gpio_is_valid(kirin_pcie->gpio_id_dwc_perst)) {
> 		dev_err(dev, "unable to get a valid gpio pin\n");
> 		return -ENODEV;
> 	}
> 
> Where that else adds nothing and it could just be
> 	ret = of_get_named_gpio(dev->of_node, "reset-gpios", 0);
> 	if (ret < 0)
> 		return dev_err_probe(dev, ret,
> 				     "unable to get a valid gpio pin\n2);
> 
> 	kirin_pcie->gpio_id_dwc_perst = ret;
> 
> or even update the gpio handling in general to use non deprecated
> functions.
> 

Hi, Jonathan,

Thanks for your review. I will send v2 to tidy up together.

Beset Regards,
Zekun


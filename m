Return-Path: <linux-pci+bounces-21145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EBCA3051D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 09:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9B57A1112
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 08:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350F1EDA1C;
	Tue, 11 Feb 2025 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="thYsnYIe"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E71E885A;
	Tue, 11 Feb 2025 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260927; cv=none; b=ekEI7IXVI+QrH5L0ue7fEAedVzdPM0LmvkYVHqe8fJeN4M5KfQtXunBG7o77QC1J6AYJ9nbEIfK5qiXW+8wsKvRQfPt8yxzRc63nJUjY5nLy3HkWiYHWmxs6zed2CJW0lXY6lHlAql6185RRwyNoGySoUWLGsjPwhoCZD5Vp+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260927; c=relaxed/simple;
	bh=7yK13TZFsJtF0t0OHmAlmuV/NwIr9+f/1XjOsqVyKxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VbgzVznRemcGwqMm38KV7/5zUCIGKbGAvpScMI/Qqnqw8ZN+N5hoAbzfSzekyzXfAGU6NySGJOElwJSBIjDaEg12eUHjwyLFaq3dEA7aaMEIYfmIfzUDTgiMadDdkw5SzU07gur2+a2Vz0+2dtq6dsNUJFzR0yCdXl/zPkzorW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=thYsnYIe; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739260915; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eHPDAundgcYY+YEOK6ITUkjYkkUi8bL66U1XWOeqKpc=;
	b=thYsnYIeNBpNQwcFYkN66iW5+pwTuFAMhTdfl756ATq2UinUgtw6iCLm1XP2sHfWx/k9Gvuy7r7eWgC/9DoQHiPvWYPlXLie7glVG91W+128GWIl5ena7fkABPL2CEUeco+k4ADN/e7JdyRYuOBTHDlBlBXPQcK6FgqIMPbfvrQ=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPG4n1E_1739260914 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 16:01:54 +0800
Message-ID: <2fedcf43-05f9-40da-a4f7-1b836f30b0df@linux.alibaba.com>
Date: Tue, 11 Feb 2025 16:01:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] perf/dwc_pcie: fix duplicate pci_dev devices
To: Yunhui Cui <cuiyunhui@bytedance.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20250208104002.60332-1-cuiyunhui@bytedance.com>
 <20250208104002.60332-3-cuiyunhui@bytedance.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250208104002.60332-3-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/8 18:40, Yunhui Cui 写道:
> During platform_device_register, wrongly using struct device
> pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
> still, accessing the duplicated device leads to list corruption as its
> mutex content (e.g., list, magic) remains the same as the original.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 19fa2ba8dd67..4f6599e32bba 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
>   	u32 sbdf;
>   
>   	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
> -	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", sbdf,
> -						 pdev, sizeof(*pdev));
> -
> +	plat_dev = platform_device_register_simple("platform_dwc_pcie", sbdf, NULL, 0);
>   	if (IS_ERR(plat_dev))
>   		return PTR_ERR(plat_dev);
>   
> @@ -616,18 +614,26 @@ static struct notifier_block dwc_pcie_pmu_nb = {
>   
>   static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   {
> -	struct pci_dev *pdev = plat_dev->dev.platform_data;
> +	struct pci_dev *pdev;
>   	struct dwc_pcie_pmu *pcie_pmu;
>   	char *name;
>   	u32 sbdf;
>   	u16 vsec;
>   	int ret;
>   
> +	sbdf = plat_dev->id;
> +	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
> +					   sbdf & 0xff);
> +	if (!pdev) {
> +		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
> +		return -ENODEV;
> +	}
> +
>   	vsec = dwc_pcie_des_cap(pdev);
>   	if (!vsec)
>   		return -ENODEV;

pci_dev_put(pdev) should move ahead to aovid return here.

>   
> -	sbdf = plat_dev->id;
> +	pci_dev_put(pdev);
>   	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
>   	if (!name)
>   		return -ENOMEM;
> @@ -642,7 +648,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>   	pcie_pmu->on_cpu = -1;
>   	pcie_pmu->pmu = (struct pmu){
>   		.name		= name,
> -		.parent		= &pdev->dev,
> +		.parent		= &plat_dev->dev,
>   		.module		= THIS_MODULE,
>   		.attr_groups	= dwc_pcie_attr_groups,
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> @@ -729,7 +735,7 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
>   
>   static struct platform_driver dwc_pcie_pmu_driver = {
>   	.probe = dwc_pcie_pmu_probe,
> -	.driver = {.name = "dwc_pcie_pmu",},
> +	.driver = {.name = "platform_dwc_pcie",},

Aha, it is very difficult to come up with a name that satisfies everyone. The
original name uses the '_pmu' suffix to follow the unwritten convention of
other PMU drivers.

Personally, I think the original name is more appropriate, but I'll leave the
decision to @Will.

Thanks.
Best Regards.
Shuai


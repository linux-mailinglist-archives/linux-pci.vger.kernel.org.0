Return-Path: <linux-pci+bounces-21146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 876FAA30533
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 09:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E3C1885B3A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5C1EE00D;
	Tue, 11 Feb 2025 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F5i+BGWG"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE91EBFE6;
	Tue, 11 Feb 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261115; cv=none; b=c6VqxKgFPdQ3zH5SDukj4N0eOPt9riZQMgyscrgs1A5EkJftgYPdKQ8/vd5+5tLXul/vmO0Er3MgJYGUQAYLuP4FohEBE4VRlZPrz7CljKFvihji1MXq68gzQNtoPLXU/dUH6MuTkkyHGN6Xh0fFbFYcO1j6E36X0IgNI0eEfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261115; c=relaxed/simple;
	bh=KNU0Db/TA+KJGjPbWUHiMYaQOxX9S4MROwmmDeMDDPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WcoQClG8JietCLvq5o14uen3WJVPWo7Dkvq9jOMp/3I/xjX/9f/3PqKZAniA6wX90C90dn0rNd7QMPsK12oy5oGMC5sX2tgHlA1C7psi1VBvzC3hysM2cj/JXfHtxUR56deHPQQVtS1Z2LxUjoI8nA5ATrfnRLrT1e0fyuf/I1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F5i+BGWG; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739261108; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OWNTXIBLk44jOWCaxqVWXnPJfTyD2vfL7kKmjrg4X+s=;
	b=F5i+BGWGARxq5pStMKTz9LoluBAdOsdyXL/EH2kJTFS9K0k2opEC2QQzbEUCiv/60zFbRPC8zEtMfplsWnP1mpptw8xYlriH0WXYNg5C4D6r7wMGrvcqOx48ohEt9mP4934K6qb/A998nFcZQNHtN2LQZmYjx71lqEQtQQD9JSo=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPG-wH._1739261107 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 16:05:08 +0800
Message-ID: <d1db3047-f478-4d8f-b9f6-e7a5820d5a29@linux.alibaba.com>
Date: Tue, 11 Feb 2025 16:05:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] perf/dwc_pcie: fix some unreleased resources
To: Yunhui Cui <cuiyunhui@bytedance.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linux-pci@vger.kernel.org
References: <20250208104002.60332-1-cuiyunhui@bytedance.com>
 <20250208104002.60332-2-cuiyunhui@bytedance.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250208104002.60332-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/8 18:40, Yunhui Cui 写道:
> Release leaked resources, such as plat_dev and dev_info.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index cccecae9823f..19fa2ba8dd67 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -572,8 +572,10 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
>   		return PTR_ERR(plat_dev);
>   
>   	dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
> -	if (!dev_info)
> +	if (!dev_info) {
> +		platform_device_unregister(plat_dev);
>   		return -ENOMEM;
> +	}
>   
>   	/* Cache platform device to handle pci device hotplug */
>   	dev_info->plat_dev = plat_dev;
> @@ -730,6 +732,15 @@ static struct platform_driver dwc_pcie_pmu_driver = {
>   	.driver = {.name = "dwc_pcie_pmu",},
>   };
>   
> +static void dwc_pcie_cleanup_devices(void)
> +{
> +	struct dwc_pcie_dev_info *dev_info, *tmp;
> +
> +	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node) {
> +		dwc_pcie_unregister_dev(dev_info);
> +	}
> +}
> +
>   static int __init dwc_pcie_pmu_init(void)
>   {
>   	struct pci_dev *pdev = NULL;
> @@ -742,7 +753,7 @@ static int __init dwc_pcie_pmu_init(void)
>   		ret = dwc_pcie_register_dev(pdev);
>   		if (ret) {
>   			pci_dev_put(pdev);

Should we get a reference count of pdev in dwc_pcie_register_dev and put it in
dwc_pcie_unregister_dev?

Thanks.
Shuai



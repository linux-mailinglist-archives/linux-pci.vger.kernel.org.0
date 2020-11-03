Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D163F2A3A9E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 03:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKCCwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 21:52:47 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16007 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCCwr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 21:52:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa0c5ff0000>; Mon, 02 Nov 2020 18:52:47 -0800
Received: from [10.40.203.207] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 02:52:34 +0000
Subject: Re: [PATCH] PCI: dwc: fix reference leak in
 pex_ep_event_pex_rst_deassert
To:     Zhang Qilong <zhangqilong3@huawei.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20201102143045.142121-1-zhangqilong3@huawei.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f09c0801-d584-3c27-d3e7-ca59a64a30d1@nvidia.com>
Date:   Tue, 3 Nov 2020 08:22:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201102143045.142121-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604371967; bh=Z7+YlFl7n1M2EaARg/7FhKF80dsOMACgR78/A/MOYUA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=DGexuQjxmtlKoe06P6hB1rIvpHUvxLiSkq9Ji9HCVjJKYzQrLVo9/7kDza6eLzQhn
         JmMyL1ZhVz4QZ94Gf82amuqh/7LpyUQynLzY++AHh73MeHrgJfPLKYslqrqnFE4NoB
         XKfP70286j093yYrbzqZyZrPsizQlVxJxNjgjJ9ZCZURdaA7BzA3GdrcRSl/ut9OyO
         Pw3ZsHwITncKtWL4WukpqA43cATh3xjt7tFUgHRtCCQIYVwvZlydafR0RIjhiYkOIU
         hyIp3V5LWXCPfWfKHn207H1UvAdR6jjWPO5a1tsReBy3VeFBeOP3dkfNGlBL7D7Gqx
         tUW0RnAHiNu4w==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/2/2020 8:00 PM, Zhang Qilong wrote:
> External email: Use caution opening links or attachments
> 
> 
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in pex_ep_event_pex_rst_deassert, so we should
> fix it.
> 
> Fixes: c57247f940e8e ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index f920e7efe118..936510b5c649 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1662,6 +1662,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> 
>          ret = pm_runtime_get_sync(dev);
>          if (ret < 0) {
> +               pm_runtime_put_noidle(dev);
Why can't we call pm_runtime_put_sync(dev) as that is what is being 
called in failure cases anyway further down in this API?

>                  dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
>                          ret);
>                  return;
> --
> 2.17.1
> 

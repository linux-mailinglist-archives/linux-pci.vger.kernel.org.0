Return-Path: <linux-pci+bounces-25349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D83FA7CF57
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 20:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBDA188C6A6
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A7F13AA2A;
	Sun,  6 Apr 2025 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="aHWWTBMf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA7C8CE;
	Sun,  6 Apr 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743963041; cv=none; b=G1MLFzcrc5JoKd2qjOwyIRY6ZcKQ8brIJj2CoJH5wmyIQq3BGa8EAjSAu5D3VgXJlOfZ4UmVoJT7vvyH73kjKvzwwpocRjCZEbzsAVisnU9/I3xEVyujMmptPcRbTfyN8Vj7i0GQMNk0DSNZRmOS+FakE7fOUmgG1MR2Rtv4+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743963041; c=relaxed/simple;
	bh=xAi8IWjQ5lnxzvNs2hBOLffbnbOjTT3CiChzZc7QPzk=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=VeTvBEAifpOWqE8L7Vil6qRqzdlHcHhwhoZWms5ad23daxvUcMMOoL5shWCC7Zv37EV0ug+gI99l/l4PO5aIuUB2pPHy5docKwLvhFCwBAk4KiEPKA4n80c5/ItbUVBCKQP1BZLB+ZrFk4cZlKmtnSpDTuCcdBr+GTDJbHqwOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=aHWWTBMf; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 1URtuNKRAgxs71URwu8qOr; Sun, 06 Apr 2025 20:10:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743963030;
	bh=FMcqQ3hkFh8qYYDl8Bm9WQ67CvkgwTUHqVnt0jyw3KA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=aHWWTBMfVBort1LDm0osb5MjbFRAw7w1nCBpZIKTlh5A0PAerTli5oyelg2RfR97G
	 a3olTNkm2byFHQPNRt7BwuOvKLXB8ABkdiXL7NLH3ZUAzGqMvz3eVAByXwJicizSHy
	 1Y8JS7dLK9AZFKsfndJ2EQfbVOakDhy8QdQVulawx79qELsfrN3M/hXfPgi2CyR8bv
	 kNe263bY1dxkCU1FBgtcZo8yhx0fgyhRe8uv+nXOH4Z8Y3RWf6O7z6rguzpCP2CbWo
	 bW0OWXuNAOCL9k7Wk8cbjx+a9t03p1z97/4mNp86GtBkbWHcle6VHWxNc1tGfBhkSu
	 tv0hVIS4c1sSQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 06 Apr 2025 20:10:30 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c51bbf38-0c6a-418f-b1e2-763d621186ff@wanadoo.fr>
Date: Sun, 6 Apr 2025 20:10:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: tegra194: Fix debugfs directory creation when
 CONFIG_PCIEASPM is disabled
References: <20250406134355.49036-1-18255117159@163.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: 18255117159@163.com
Cc: bhelgaas@google.com, christophe.jaillet@wanadoo.fr, jonathanh@nvidia.com,
 kw@linux.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, thierry.reding@gmail.com
In-Reply-To: <20250406134355.49036-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/04/2025 à 15:43, Hans Zhang a écrit :
> Previously, the debugfs directory was unconditionally created in
> tegra_pcie_config_rp() regardless of the CONFIG_PCIEASPM setting.
> This led to unnecessary directory creation when ASPM support was disabled.
> 
> Move the debugfs directory creation into init_debugfs() which is
> conditionally compiled based on CONFIG_PCIEASPM. This ensures:
> - The directory is only created when ASPM-related debugfs entries are
>    needed.
> - Proper error handling for directory creation failures.
> - Avoids cluttering debugfs with empty directories when ASPM is disabled.
> 
> Signed-off-by: Hans Zhang <18255117159-9Onoh4P/yGk@public.gmane.org>
> ---
> Changes since v1:
> https://lore.kernel.org/linux-pci/20250405145459.26800-1-18255117159-9Onoh4P/yGk@public.gmane.org
> 
> - The first version was committed incorrectly because the judgment
>    parameter in "debugfs_remove_recursive" was not noticed.
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 27 +++++++++++++---------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 5103995cd6c7..f048b2342af4 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -711,16 +711,27 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>   	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>   }
>   
> -static void init_debugfs(struct tegra_pcie_dw *pcie)
> +static int init_debugfs(struct tegra_pcie_dw *pcie)

I would keep it a void function.
If devm_kasprintf() fails, which is unlikely, then the module should 
still work correctly. So just a return; should be fine IMHO.

Usually, errors related to debugfs are silently ignored as is does not 
prevent this to work.

CJ

>   {
> -	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
> +	struct device *dev = pcie->dev;
> +	char *name;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	pcie->debugfs = debugfs_create_dir(name, NULL);
> +
> +	debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
>   				    aspm_state_cnt);
> +
> +	return 0;
>   }
>   #else
>   static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
>   static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
>   static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
> -static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
> +static inline int init_debugfs(struct tegra_pcie_dw *pcie) { return 0; }
>   #endif
>   
>   static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
> @@ -1634,7 +1645,6 @@ static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
>   static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>   {
>   	struct device *dev = pcie->dev;
> -	char *name;
>   	int ret;
>   
>   	pm_runtime_enable(dev);
> @@ -1664,14 +1674,9 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>   		goto fail_host_init;
>   	}
>   
> -	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
> -	if (!name) {
> -		ret = -ENOMEM;
> +	ret = init_debugfs(pcie);
> +	if (ret < 0)
>   		goto fail_host_init;
> -	}
> -
> -	pcie->debugfs = debugfs_create_dir(name, NULL);
> -	init_debugfs(pcie);
>   
>   	return ret;
>   
> 
> base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963



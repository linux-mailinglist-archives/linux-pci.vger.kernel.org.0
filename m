Return-Path: <linux-pci+bounces-25429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB23A7EDC1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 21:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EF93AEB0E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90C2185B8;
	Mon,  7 Apr 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RVfK8XZc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63B207A3B;
	Mon,  7 Apr 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055071; cv=none; b=PbHJusP+Xtb6SDvqKP2Kp7TJJrTHbpIDZR1epNvMjA+q7vkVRfbhZDje8XesS5Raczf4zHj6BCmkaoVe4LUR948UBX7Txebtz+077jn5gjeF8uyn6O7m0yqzawBsA8kKohnLK6i2lT/HzijR90RfKurHucSoVaSUpyBjOc3n1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055071; c=relaxed/simple;
	bh=ykdXOXYPhfXKcuSe927Li4LYTVxGhqdkJW/S09fMzMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVaXJxiMDZ+0cbDDst+n8XMXqIXWNYCkscbTCZRNtsEns5WWSOdadwlVvD1XNDjrEDL4YMCLSMS3BXbcPSlnxwCjMICoAnxS00fvRKPntkORU2rQTZ7U+s0K3mf0ChFnGX1sB0XQbOM3ZxtmJR5DZXD8ZayVjFE/wsh7Ivep2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RVfK8XZc; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 1sNCu3YszXgNw1sNFuRDWl; Mon, 07 Apr 2025 21:43:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744054995;
	bh=jYI/aBTguCV58Oiva5TkpgZBIYz/I1yQfCxZjQNaaJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=RVfK8XZcSAc05YwVfXANfr4txDIjG/KG59ddrbaveVFvpWHnGzM3OR+7jKE7REvua
	 4RP7pSrlc7u3WsdGEfb6HFaMcHQpe6mFQRu/FhBIDtJbug91fs4Pt3ZvKlPOwMDO8D
	 QTduYoSEdrkDAv0BdWDSD4VI55omDBHHXVOsw0hiMworRuoNhr24nev9eutogvTldA
	 b7ulBfKchtGrf9+zm9kvDTj0FhJ/K8YMPq8UO63ta8MuQ7RyErwbEGpbZ6wK+s1LiV
	 b8KxQFd/NDS+UIF5SFRakaF1cTfLWXxHoUlqrbX5DAfn7xzGH5bLaYtqHGHSRquEXh
	 Gw9x+tr09MnFw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 07 Apr 2025 21:43:15 +0200
X-ME-IP: 90.11.132.44
Message-ID: <580c1b6a-ba32-48ea-9fd8-59884d0dbcbf@wanadoo.fr>
Date: Mon, 7 Apr 2025 21:43:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] PCI: tegra194: Fix debugfs directory creation when
 CONFIG_PCIEASPM is disabled
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: manivannan.sadhasivam@linaro.org, thierry.reding@gmail.com, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20250407124331.69459-1-18255117159@163.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250407124331.69459-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Nitpick: PATCH is missing within the [] in the subject.


Le 07/04/2025 à 14:43, Hans Zhang a écrit :
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
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v2:
> https://lore.kernel.org/linux-pci/20250406134355.49036-1-18255117159@163.com/
> 
> - Maintainer recommends ignoring the devm_kasprintf return value. The
>    module should still work correctly. So just a return;

Note, that I'm not a maintainer ;-)

For what it worth:

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


CJ
> 
> Changes since v1:
> https://lore.kernel.org/linux-pci/20250405145459.26800-1-18255117159@163.com/
> 
> - The first version was committed incorrectly because the judgment
>    parameter in "debugfs_remove_recursive" was not noticed.
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 5103995cd6c7..bc419688527a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -713,7 +713,16 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>   
>   static void init_debugfs(struct tegra_pcie_dw *pcie)
>   {
> -	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
> +	struct device *dev = pcie->dev;
> +	char *name;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
> +	if (!name)
> +		return;
> +
> +	pcie->debugfs = debugfs_create_dir(name, NULL);
> +
> +	debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
>   				    aspm_state_cnt);
>   }
>   #else
> @@ -1634,7 +1643,6 @@ static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
>   static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>   {
>   	struct device *dev = pcie->dev;
> -	char *name;
>   	int ret;
>   
>   	pm_runtime_enable(dev);
> @@ -1664,13 +1672,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>   		goto fail_host_init;
>   	}
>   
> -	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
> -	if (!name) {
> -		ret = -ENOMEM;
> -		goto fail_host_init;
> -	}
> -
> -	pcie->debugfs = debugfs_create_dir(name, NULL);
>   	init_debugfs(pcie);
>   
>   	return ret;
> 
> base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963



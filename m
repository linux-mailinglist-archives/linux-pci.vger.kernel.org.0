Return-Path: <linux-pci+bounces-25326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E80A7CA35
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 18:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA833B2781
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73722535D8;
	Sat,  5 Apr 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Lm+A/M6F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3F156F20;
	Sat,  5 Apr 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743870227; cv=none; b=rrOwtKwcs4K36Xsg/tZeQpvwaVG4MfAZfkXTQNESacASb0gjQ4dhaS+guHD/rZZ0yoNB/5VS9zhjDC+/2gOAGvmrkkNKzeGWg7IlNlI3J/6I9wu0L9wcLFS9lwJdqkTeFvqqcAxoAxKETJdM2v51+QqPTydIISce8rA73QWx2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743870227; c=relaxed/simple;
	bh=U8/92TQg+GZ8k1Y8xxenbWikuxiwCkpnyeA42/KioUM=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=DuBgdaYkXQVSy3WdYGyo0j3LA5yD5zVf0VG25rjTFuW31yWy0Hbl97S6ULnk+Hiu4p78SPqlsUSkA/kZFSkbq6hFu370UKxzAqrr6K04Dn0vPzloRJerUmtnIrqq8t/ElCn/jDjRp8w96/fCQwwszqYOnoJdfylhdUjt7WIxSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Lm+A/M6F; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 16AQujHB2B4qz16ATueFIa; Sat, 05 Apr 2025 18:14:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743869691;
	bh=PMs5hy77UDHTud4mAKxiw5m0lSdqrg7l0TCWcb/Kf1c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Lm+A/M6FhcWWTUFBQLrfwyGVyYoZrKAUQqERyJYPKQ1yYc5RoHFez35SBba908sFr
	 2PDnRHRuEqdtQCiWJSyY41hCi32HUmnB9hS2v09l6roFlrx6g1P+ROTOUm8MnwmyvW
	 p1u7T+gQRYW0alXO75PVlRTajw+ZclgysJi+I0gY+0B/xBihJSIsb+TaEP8pe+aaGb
	 CU+4CgZ5GTP9LpMDZ9k0tdqQj/XBb1ceJaNtnU+q/D9HLm/iDZoVM+nmN0B85gh1Rp
	 ZPJ9WoHK2A1yGY9QYXhIC4WRqzt6kJib1mSZkPYKFuNJsR2HD/m+jraHANzqimYfkN
	 uu5/rUTdzg3PQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 05 Apr 2025 18:14:51 +0200
X-ME-IP: 90.11.132.44
Message-ID: <727b55b6-ccba-4498-be95-027a9f67dfa9@wanadoo.fr>
Date: Sat, 5 Apr 2025 18:14:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
References: <20250405145459.26800-1-18255117159@163.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: 18255117159@163.com
Cc: bhelgaas@google.com, jonathanh@nvidia.com, kw@linux.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, thierry.reding@gmail.com
In-Reply-To: <20250405145459.26800-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/04/2025 à 16:54, Hans Zhang a écrit :
> When CONFIG_PCIEASPM is disabled, debugfs entries are not created, but
> tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() unconditionally call
> debugfs_remove_recursive(), leading to potential NULL pointer operations.
> 
> Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), which is
> stubbed for !CONFIG_PCIEASPM. Use this function during removal/shutdown to
> ensure debugfs cleanup only occurs when entries were initialized.
> 
> This prevents kernel warnings and instability when ASPM support is
> disabled.
> 

Could you elaborate?


debugfs_remove_recursive() ends either to:

static inline void debugfs_remove(struct dentry *dentry)
{ }
if CONFIG_DEBUG_FS is not set,

or
to a function which starts with:
	if (IS_ERR_OR_NULL(dentry))
		return;
if it is set.


So what does this new deinit_debugfs() add?


Which NULL pointer are you seeing?
Did you actually manage to trigger it?

CJ



> Signed-off-by: Hans Zhang <18255117159-9Onoh4P/yGk@public.gmane.org>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 5103995cd6c7..d762e733c2d8 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -716,11 +716,20 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
>   	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
>   				    aspm_state_cnt);
>   }
> +
> +static void deinit_debugfs(struct tegra_pcie_dw *pcie)
> +{
> +	if (!pcie->debugfs)
> +		return;
> +
> +	debugfs_remove_recursive(pcie->debugfs);
> +}
>   #else
>   static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
>   static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
>   static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
>   static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
> +static inline void deinit_debugfs(struct tegra_pcie_dw *pcie) { return; }
>   #endif
>   
>   static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
> @@ -2289,7 +2298,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
>   		if (!pcie->link_state)
>   			return;
>   
> -		debugfs_remove_recursive(pcie->debugfs);
> +		deinit_debugfs(pcie->debugfs);
>   		tegra_pcie_deinit_controller(pcie);
>   		pm_runtime_put_sync(pcie->dev);
>   	} else {
> @@ -2408,7 +2417,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
>   		if (!pcie->link_state)
>   			return;
>   
> -		debugfs_remove_recursive(pcie->debugfs);
> +		deinit_debugfs(pcie->debugfs);
>   		tegra_pcie_downstream_dev_to_D0(pcie);
>   
>   		disable_irq(pcie->pci.pp.irq);
> 
> base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963



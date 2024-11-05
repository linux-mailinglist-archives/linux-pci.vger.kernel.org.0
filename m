Return-Path: <linux-pci+bounces-16088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D8F9BD9C9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 00:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380C1284136
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 23:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49703216456;
	Tue,  5 Nov 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8ydKuoZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9211D31A9;
	Tue,  5 Nov 2024 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730849715; cv=none; b=flnWIp15AB0ebjaF4zDLDPoLbE2D54MO4XP43jFKGwjB64bHp8kthWYRbXy7Ouc8WnyoJipwpGCca8kpjdS85rzORUxU44bVfmNnWXLRDnqxHD6tpFcenfLiBRnAO31QKq1jUaxATE3mfbU842ofN5G/wvqwaQYIaOJA9Fr6dI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730849715; c=relaxed/simple;
	bh=EkLwGAD+vkQfJXaeXFFexTFClHB8gkvGZzJT+rMGMb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tNFUnh8m02eCoejk6CINQGXnD7AtHl5xKu90oIOHDNguKAIq4wRkehbtiGpTn2nNpS/Cjtj5rMRUgSyjZOcCTGm2hyPt6yl+PClM17sumDvGsalFzFOeRvYoK08oQM7nobq3oDU2ZQ8a0SeSdTDPCD+tsZT5mmTPKYWWhjOQCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8ydKuoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF22C4CECF;
	Tue,  5 Nov 2024 23:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730849714;
	bh=EkLwGAD+vkQfJXaeXFFexTFClHB8gkvGZzJT+rMGMb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S8ydKuoZN3G8z4EUhrNgUlPaoxuqLwov1sbZ3LCb7eKt9f4xy4xTgGxsNTKEEBT8z
	 5jnVRXoy/Fo9hZ+O72hUTG2ZOiPMv9lerDTCFyNlYG/6wHeGJAbvUPEgdQa8iv/+fT
	 UPPOKHhQYb28JnnCr0Pll2UwGEJ2M2QEdaJ+UkGTyXyHbctXRyQHVBka6Cv9a+yGLb
	 ErszweYPujZR1Z6TrfDFc+5RFV9CfLLE1VsSXhuxIyf6o6okDFTNpTFsY2BBQGWBKy
	 nfeHXLXP4KrQiR06qAUSlH6A5Etsok8YuXLhdc7FHL+OjzgCMGKGcQvh0Xdu3M5oxf
	 KPArUQhMj1cmg==
Date: Tue, 5 Nov 2024 17:35:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kwilczynski@kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	frank.li@nxp.com, mani@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Message-ID: <20241105233513.GA1495684@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>

On Mon, Jul 22, 2024 at 02:15:13PM +0800, Richard Zhu wrote:
> The dw_pcie_suspend_noirq() function currently returns success directly
> if no endpoint (EP) device is connected. However, on some platforms, power
> loss occurs during suspend, causing dw_resume() to do nothing in this case.
> This results in a system halt because the DWC controller is not initialized
> after power-on during resume.
> 
> Change call to deinit() in suspend and init() at resume regardless of
> whether there are EP device connections or not. It is not harmful to
> perform deinit() and init() again for the no power-off case, and it keeps
> the code simple and consistent in logic.
> ...

> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}

Not related to this patch, but what's the reason for waiting for the
link to enter L2?  There are a few other drivers that do this, but
most don't.  Is there something else the driver needs to do after the
link is in L2?

>  	}
>  
>  	if (pci->pp.ops->deinit)
> -- 
> 2.37.1
> 


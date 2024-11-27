Return-Path: <linux-pci+bounces-17407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A570A9DA637
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5387E163C46
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63D1D4615;
	Wed, 27 Nov 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeE2RndM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEDC1D5169
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704884; cv=none; b=Gb7YZya9L5Gk9xM+Q8llBhJYaEmmCbB5oEH9QiOpiLoiKR5dVRfMSbTIND0dyhin+2dA5k5iA395LGY2E1+z2z7AjbtYMFexcL0oBVKszHi6uci0odH1NE4/5BRNN++aGFhb3cOMjkO0KT92dadx9+6qF9wNCHbfnR9N0C78P3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704884; c=relaxed/simple;
	bh=on/uFSvH0WFJfSPxLO994BjwJ4E0+PJmQ7buTab0NgA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Shnrg4vdebhnWjr4Ul2Nw+gbzxZLW5qzI0wZ70b51YnoK6IYSGGsKrGHSOhEt6w4scX3+INlJwSnHOSRVYd0irqFPaH6OZsPk/WfMfKi9K4bSWZNWTTavfgBUKb5LZcYW0PjayEXRvk2rDTn5ih/u4gd3TqD70wehUsdT+HFBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeE2RndM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732704883; x=1764240883;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=on/uFSvH0WFJfSPxLO994BjwJ4E0+PJmQ7buTab0NgA=;
  b=eeE2RndMx7JloSGTLry+etEKh9zN9gqq5E0eEaQsHfo8SH+tEpLK4Eu3
   Wyy5FgLrexuMmNpoDt24NL2Ro0BXje6+ulKpiwbCc/WVkGpCdERtJCNLU
   lqjiMidpYTHrtHz0PrlvhPwTxjdvuYcaEC2oS8J/UvpHOTs0TEhecLRoj
   n/qls3B7Kqb/yC0agWY8DHO60uqDbGkwlqcMehYreNW5wkagBE0vccP5h
   4i+YxV1469xgAVaguv5Q8RSy7nmczbeLlSslObl+HWiS94VD2i3TC9LYF
   ERTkfayNT7Kd8RD1J763zG7a4Wt7YL/X9VtcPfhBw4erXHbNoup6ZbBsj
   g==;
X-CSE-ConnectionGUID: qU0m1U66Q2ychdjz0p0xYQ==
X-CSE-MsgGUID: gkVlfFRLShiX1EQvMzaLBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="50430626"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="50430626"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:54:40 -0800
X-CSE-ConnectionGUID: qJdBR+MET6CoGRahOuRrFQ==
X-CSE-MsgGUID: Zy8KJdVJT124RcNVlRH4VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="122742252"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:54:36 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 27 Nov 2024 12:54:33 +0200 (EET)
To: Ajay Agarwal <ajayagarwal@google.com>, Jian-Hong Pan <jhp@endlessos.org>
cc: "David E. Box" <david.e.box@linux.intel.com>, 
    Johan Hovold <johan+linaro@kernel.org>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, Manu Gautam <manugautam@google.com>, 
    Sajid Dalvi <sdalvi@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
    Vidya Sagar <vidyas@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Save downstream port L1ss control when saving
 for upstream
In-Reply-To: <20241127033758.3974931-1-ajayagarwal@google.com>
Message-ID: <2aceef41-6d65-2eab-8339-07f874be6f41@linux.intel.com>
References: <20241127033758.3974931-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Adding Jian-Hong.

There's already another patch under discussion to the same problem:

https://patchwork.kernel.org/project/linux-pci/patch/20241115072200.37509-3-jhp@endlessos.org/

-- 
 i.

On Wed, 27 Nov 2024, Ajay Agarwal wrote:

> It is possible that the downstream port's L1ss registers were not
> saved after the initial configuration performed in the function
> aspm_calc_l12_info() during the child bus probe. If the upstream
> port config space is saved-restored due to some reason, the
> downstream port L1ss registers will be overwritten with stale
> configuration due to the logic present in
> pci_restore_aspm_l1ss_state(). So, attempt to save the downstream
> port L1ss registers when we are at the upstream component.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
>  drivers/pci/pcie/aspm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8..769a305fad63 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -99,6 +99,19 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  	cap = &save_state->cap.data[0];
>  	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
>  	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> +
> +	/*
> +	 * It is possible that the downstream port's L1ss registers were not
> +	 * saved after the initial configuration performed in the function
> +	 * aspm_calc_l12_info() during the child bus probe. If the upstream port
> +	 * config space is saved-restored due to some reason, the downstream
> +	 * port L1ss registers will be overwritten with stale configuration due
> +	 * to the logic present in pci_restore_aspm_l1ss_state(). So, attempt to
> +	 * save the downstream port L1ss registers when we are at the upstream
> +	 * component.
> +	 */
> +	if (!pcie_downstream_port(pdev))
> +		pci_save_aspm_l1ss_state(pdev->bus->self);
>  }
>  
>  void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
> 


Return-Path: <linux-pci+bounces-3205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEB84CAF0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 13:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A503B1F23066
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D2E58AD0;
	Wed,  7 Feb 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsOUVtjB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FD76C63;
	Wed,  7 Feb 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310476; cv=none; b=OpD0ezMPYoigebkw0QH6Z6Yt0gVZKxtF9jNbEfR7/yQiDXR3jwdhBiOyJtxlpxWuODN1Scr4zfmwKwjTlpqqqSBUEgJyRzannGxG3F31kKFFwQ1ycuasGzUqHfhr+zSRl7Hy0dC02S6OYQwOB+FZKxS/9ZPFto+VVfzcZdhpy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310476; c=relaxed/simple;
	bh=9Yl8cw6GMttrCBds2aQn0pjodVh3El22SlfJLyDMMzU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pb7vMNHXOgHHNmBq8pXcJZHPJE+H8mQEWIt2qEPXBHsEGviYC/o7HvAktGL7NOjTcTNi9ODOwIwQtGGCQ51+0eSVKKjB+kd9VGUtD09/9eZqfiAfiMaC9Xhn+/NJhKjtMFQabS7k7YYPzBpDcWnNGhcaABkrNSEl1roYw19JCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsOUVtjB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707310474; x=1738846474;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9Yl8cw6GMttrCBds2aQn0pjodVh3El22SlfJLyDMMzU=;
  b=DsOUVtjBvqB1iSKNXRlPh26M1vcRicXk7srlE5WYftap3xxp3M+dnpFv
   csN7LcUcRYUfsLiK+fYlRI34GDUwNT1cOU0gUX4AxjGaXXFz+crKZi8Sh
   yt+5d7dQvzr/HREwHTjjKpWOvz72o7Mpvpy7R7Pklsn1NhNSQwMbX5J15
   JUi7NALaU8c+7ijjueaGEjrjwAZ/fLJ0idhGaq6eUlZpAq7vu2rnF9C5Q
   xYA2W02dM2ByxCEQXMjBpOLS9Qyeay/y4knFsFH5uqNvnFPoEVAkM0/qG
   uMSD1aXuKd+MSPMSIET+PJ8XeRqzdXkVGaSIDHpSx15KT1RKS5u9L5u80
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="861631"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="861631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 04:54:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1356227"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 04:54:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Feb 2024 14:54:24 +0200 (EET)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
    David Box <david.e.box@linux.intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v3 3/3] PCI/ASPM: Fix L1SS parameters & only enable
 supported features when enable link state
In-Reply-To: <20240207111854.576402-2-jhp@endlessos.org>
Message-ID: <a1e50e3d-43a4-09ae-50be-39dfd7ab9fc0@linux.intel.com>
References: <20240207111854.576402-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 Feb 2024, Jian-Hong Pan wrote:

> The original __pci_enable_link_state() configs the links directly without:
> * Check the L1 substates features which are supported, or not
> * Calculate & program related parameters for L1.2, such as T_POWER_ON,
>   Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD
> 
> This leads some supported L1 PM substates of the link between VMD remapped
> PCIe Root Port and NVMe get wrong configs when a caller tries to enabled
> them.
> 
> Here is a failed example on ASUS B1400CEAE with enabled VMD:
> 
> Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> This patch initializes the link's L1 PM substates to get the supported
> features and programs relating paramters, if some of them are going to be
> enabled in __pci_enable_link_state(). Then, enables the L1 PM substates if
> the caller intends to enable them and they are supported.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2:
> - Prepare the PCIe LTR parameters before enable L1 Substates
> 
> v3:
> - Only enable supported features for the L1 Substates part
> 
>  drivers/pci/pcie/aspm.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a39d2ee744cb..c866971cae70 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1389,14 +1389,16 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  		link->aspm_default |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
>  		link->aspm_default |= ASPM_STATE_L1;
> -	/* L1 PM substates require L1 */
> -	if (state & PCIE_LINK_STATE_L1_1)
> +	if (state & ASPM_STATE_L1_2_MASK)
> +		aspm_l1ss_init(link);

Your commit message didn't explain why you need to add this call here, why 
isn't the existing call to aspm_l1ss_init() enough to initialize what is 
needed?

> +	/* L1 PM substates require L1 and should be in supported list */
> +	if (state & link->aspm_support & PCIE_LINK_STATE_L1_1)
>  		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
> -	if (state & PCIE_LINK_STATE_L1_2)
> +	if (state & link->aspm_support & PCIE_LINK_STATE_L1_2)
>  		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
> -	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> +	if (state & link->aspm_support & PCIE_LINK_STATE_L1_1_PCIPM)
>  		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
> -	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> +	if (state & link->aspm_support & PCIE_LINK_STATE_L1_2_PCIPM)
>  		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;

It would be simpler and cleaner to just AND once with link->aspm_support 
to clear unsupported bits from state rather than doing it on every line 
like that.


-- 
 i.



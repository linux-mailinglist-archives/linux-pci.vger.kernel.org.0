Return-Path: <linux-pci+bounces-3215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558084CFA9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1380A1F23EF8
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B4823D2;
	Wed,  7 Feb 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbhH6HJl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC23610B;
	Wed,  7 Feb 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326397; cv=none; b=dsFHLYR0FR6iC0EZeypuoo0l4lz9i2TwzzDtlWedwAV5dPT0gKq/mzSJwkTk1KYzJid83Yf5cW7hkIdPlLMl7PvSfTfgiJSRqPKBBoJuoqFwZ/GpEaxW9inBPKnF/8Nmn5VzBemhZK6MmIDiZ248MD8375msC/Z48l3+TWCbWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326397; c=relaxed/simple;
	bh=MiaMJjGhdRxBo5/5ob32mMaJd0GwNFZdaUMQeJpPO7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KttcTggfm6d0xd5/rSKQxfE6byP3MqBWHxCnvjbKCNqD1/cml1ych+iW4MME3Xws/nn1444thto3QCzKVItP82a7OwvQmG2naCBNVJL2q0VMvZ5nT9AtgjHmyzvgQSt3HMBAfwWN/E+pCEIBqe55+viwPSAn96zGA5rW+y90R4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbhH6HJl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707326395; x=1738862395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MiaMJjGhdRxBo5/5ob32mMaJd0GwNFZdaUMQeJpPO7k=;
  b=ZbhH6HJlvYPoXwR3p3Pfqv8H+qczja0oVoI4L8HRMpBSaa1Efqmgd9Y/
   wKldIQwQR3Rleiix5IRQoT3b15Td0RM9WUaceLn8BmdVMz02JvhNstvHx
   snTqO4NPSD8x9JYVnLd8E5LP/rnKv+qbCTsvId4OEvBcI6Kg9riIwgTlv
   YWd8ofa2bV9LZl+Q6Ng37OezWTzJozIK1niBMjEDJdF5Uw/BRr+tp5ByQ
   WQMe5RDsv1gPLnghiPrDkQqvYCK+YrtbRo5X90j1w6vdn1StvUGMMC77f
   1BXQ4pXdm2NsJbud6jc7HZurk1Q+7nfsdIHcACIzdzgMYuk3LQn8KGPof
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="925335"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="925335"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:19:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="24636188"
Received: from srussjr-mobl1.amr.corp.intel.com (HELO [10.209.91.249]) ([10.209.91.249])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:19:54 -0800
Message-ID: <42539c3f-a802-4b07-afa6-396520eeba94@linux.intel.com>
Date: Wed, 7 Feb 2024 09:19:53 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI/ASPM: Fix L1SS parameters & only enable
 supported features when enable link state
Content-Language: en-US
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Johan Hovold <johan@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 David Box <david.e.box@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org
References: <20240207111854.576402-2-jhp@endlessos.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240207111854.576402-2-jhp@endlessos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/7/24 3:18 AM, Jian-Hong Pan wrote:
> The original __pci_enable_link_state() configs the links directly without:

Since you are referring to the current version of this function, just start
with "Currently, "

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

This is a new change. Explain why you are doing it?

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
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



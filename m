Return-Path: <linux-pci+bounces-21348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DDBA340CB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C357016796E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A91487ED;
	Thu, 13 Feb 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBOBopqe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA84221555;
	Thu, 13 Feb 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454734; cv=none; b=quNFI5sKeiYQKMjI4eTg1op2CL4SSj3NugvJ+2kSZ3Zp1YC8+QC/hOfIN2e5qsV4nYR6lv3ok50pzJ8NaEQngCUHzOmfwl5wsjRXmfz84k8jSavwC3KpSQpWxe2Az+j7WMxIOtxWAmZk4WqlI8vlzdWRMR6bFrGorKNU2jS8Th8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454734; c=relaxed/simple;
	bh=hPyij9w0+TSS5N0ObgF86Lemn6NDwDx+jt3IirxrcuI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jVVIhTsTUuHjonqs4U4fWvSEMVvZKBpHrvLx353noNm6+LbrfLK3vtQIcldbxJ71cRuu+6Qx+SUSNyt2Wac2K8C8aYYDe3piNd/LjjPaEBmrVWVsNqKvg0akfzYWgn13v9vcKUTRDO3Wkc2Rvwe2408AwAdN3lqF2hmQonBlRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBOBopqe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454733; x=1770990733;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hPyij9w0+TSS5N0ObgF86Lemn6NDwDx+jt3IirxrcuI=;
  b=CBOBopqe8hPzYhwRhfSTJLFe/Ik0qgd1r69do0NAo7yMDk6Dmd33eY1S
   rulolu9vzg7PbSV9mWWPG56TJ7Uc7mqfbTiE+EMtFPYatQGMGn+U8ms35
   sRlxpS85HMI1w4+a2SmSxA5DMBHtNvnWH+eRmSIXaKE68B+KCsB6jnGIN
   w2A7kaTN3XDly0UVkBHDN5OdXnyy7TmZNXpAzrJcnX/5gQPvvfKr6w4BB
   UPW0zNUgOdBM/tdKFbQn+F6Ao2LbcQhl6Fp90rm1mM2VZy8iJ+35m1oJB
   jea5rQWBOeDdPiKtltD+7RmSpnVqzWUzS2t2WRGe5UNfl57aJUWSptP7p
   w==;
X-CSE-ConnectionGUID: oX1Goor9TViCeaVIwEmwSg==
X-CSE-MsgGUID: 07yO4N8VTDOt82PaYpHg/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50370767"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="50370767"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:52:12 -0800
X-CSE-ConnectionGUID: a/CaCx9GTWySUKAqSkvuvw==
X-CSE-MsgGUID: 8VguVIf8TDKDfLiOckraDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144096049"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:52:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Feb 2025 15:52:05 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Alex Williamson <alex.williamson@redhat.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI: Avoid pointless capability searches
In-Reply-To: <20250208050329.1092214-2-helgaas@kernel.org>
Message-ID: <7dbb0d8b-3708-60ba-ee9e-78aa48bee160@linux.intel.com>
References: <20250208050329.1092214-1-helgaas@kernel.org> <20250208050329.1092214-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Feb 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Many of the save/restore functions in the pci_save_state() and
> pci_restore_state() paths depend on both a PCI capability of the device and
> a pci_cap_saved_state structure to hold the configuration data, and they
> skip the operation if either is missing.
> 
> Look for the pci_cap_saved_state first so if we don't have one, we can skip
> searching for the device capability, which requires several slow config
> space accesses.
> 
> Remove some error messages if the pci_cap_saved_state is not found so we
> don't complain about having no saved state for a capability the device
> doesn't have.  We have already warned in pci_allocate_cap_save_buffers() if
> the capability is present but we were unable to allocate a buffer.
> 
> Other than the message change, no functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c       | 27 ++++++++++++++-------------
>  drivers/pci/pcie/aspm.c | 15 ++++++++-------
>  drivers/pci/vc.c        | 22 +++++++++++-----------
>  3 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..503376bf7e75 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1686,10 +1686,8 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  		return 0;
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> -	if (!save_state) {
> -		pci_err(dev, "buffer not found in %s\n", __func__);
> +	if (!save_state)
>  		return -ENOMEM;
> -	}
>  
>  	cap = (u16 *)&save_state->cap.data[0];
>  	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &cap[i++]);
> @@ -1742,19 +1740,17 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  
>  static int pci_save_pcix_state(struct pci_dev *dev)
>  {
> -	int pos;
>  	struct pci_cap_saved_state *save_state;
> +	u8 pos;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> +	if (!save_state)
> +		return -ENOMEM;
>  
>  	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
>  	if (!pos)
>  		return 0;
>  
> -	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> -	if (!save_state) {
> -		pci_err(dev, "buffer not found in %s\n", __func__);
> -		return -ENOMEM;
> -	}
> -
>  	pci_read_config_word(dev, pos + PCI_X_CMD,
>  			     (u16 *)save_state->cap.data);
>  
> @@ -1763,14 +1759,19 @@ static int pci_save_pcix_state(struct pci_dev *dev)
>  
>  static void pci_restore_pcix_state(struct pci_dev *dev)
>  {
> -	int i = 0, pos;
>  	struct pci_cap_saved_state *save_state;
> +	u8 pos;
> +	int i = 0;
>  	u16 *cap;
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> -	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> -	if (!save_state || !pos)
> +	if (!save_state)
>  		return;
> +
> +	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> +	if (!pos)
> +		return;
> +
>  	cap = (u16 *)&save_state->cap.data[0];
>  
>  	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e0bc90597dca..007e4a082e6f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -35,16 +35,14 @@ void pci_save_ltr_state(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +	if (!save_state)
> +		return;
> +
>  	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
>  	if (!ltr)
>  		return;
>  
> -	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> -	if (!save_state) {
> -		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
> -		return;
> -	}
> -
>  	/* Some broken devices only support dword access to LTR */
>  	cap = &save_state->cap.data[0];
>  	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
> @@ -57,8 +55,11 @@ void pci_restore_ltr_state(struct pci_dev *dev)
>  	u32 *cap;
>  
>  	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +	if (!save_state)
> +		return;
> +
>  	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
> -	if (!save_state || !ltr)
> +	if (!ltr)
>  		return;
>  
>  	/* Some broken devices only support dword access to LTR */
> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> index a4ff7f5f66dd..c39f3be518d4 100644
> --- a/drivers/pci/vc.c
> +++ b/drivers/pci/vc.c
> @@ -355,20 +355,17 @@ int pci_save_vc_state(struct pci_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
> -		int pos, ret;
>  		struct pci_cap_saved_state *save_state;
> +		int pos, ret;
> +
> +		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> +		if (!save_state)
> +			return -ENOMEM;
>  
>  		pos = pci_find_ext_capability(dev, vc_caps[i].id);
>  		if (!pos)
>  			continue;
>  
> -		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> -		if (!save_state) {
> -			pci_err(dev, "%s buffer not found in %s\n",
> -				vc_caps[i].name, __func__);
> -			return -ENOMEM;
> -		}

I think this order change will cause a functional change because 
pci_allocate_vc_save_buffers() only allocated for those capabilities that 
are exist for dev. Thus, the loop will prematurely exit.

> -
>  		ret = pci_vc_do_save_buffer(dev, pos, save_state, true);
>  		if (ret) {
>  			pci_err(dev, "%s save unsuccessful %s\n",
> @@ -392,12 +389,15 @@ void pci_restore_vc_state(struct pci_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
> -		int pos;
>  		struct pci_cap_saved_state *save_state;
> +		int pos;
> +
> +		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> +		if (!save_state)
> +			continue;
>  
>  		pos = pci_find_ext_capability(dev, vc_caps[i].id);
> -		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> -		if (!save_state || !pos)
> +		if (!pos)
>  			continue;
>  
>  		pci_vc_do_save_buffer(dev, pos, save_state, false);
> 

-- 
 i.



Return-Path: <linux-pci+bounces-3142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63B984B54F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 13:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4119BB24DF0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64B7133422;
	Tue,  6 Feb 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EB/7Ztmq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8E133986;
	Tue,  6 Feb 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222563; cv=none; b=h3GxhoUA7nzd9pVLFwwaIqJWPKsLDDI401GKJuO8g0Ha+XUaJ17bsgbWba50il9Ji8C+QymleK+HS75VAwx1ku+/75l/iFalznxMXqF8saUzA4t5uLfWozq3MGKNByHVQuzsU+i57dbTDp5gdOqTTywH9xiBqjH9fn9dbUqMQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222563; c=relaxed/simple;
	bh=N3tSWxq5d5518zQa7I8VL2vhjsdygSC917jFzsn8AM8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ILg7LdaQ2cK9ni/5sKYmFmkm4cMnRJ+/+YQlAIeE2PZ5YphNNcC+nvzQtv9zDl0m7fO/2UYpdVRURSKSVs3bvSVlWbE7V8WXXPmLtzeRLgMOlOAFf/0CkDRMtgpYE6MK2T541Jxy8l5RqbC/LPRcMGZaPKq2uxUEAqE35ZT8IDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EB/7Ztmq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707222562; x=1738758562;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N3tSWxq5d5518zQa7I8VL2vhjsdygSC917jFzsn8AM8=;
  b=EB/7ZtmqYdkc9V+BzpYDef6YRqOrnrsGf1smuYUDYMD1lBoEEWcc8r9C
   WK6Qf1+yPPMOX1UuE0VlsPhGhuNvd4endf68z1GDNaCBLi94vTojXaf29
   w9oVzzl1u9MFC17dGT10HF+tr1TIdgqx2FYZNakGYsN6M+I2tbXYFFNbT
   y/Yype/QjlP7JLBexiYOp6XReuLoIhGdljOIPO+4f1BlytYwziKeOJcRl
   7tOMxn76CDPWYPW/Nl1c5Qf/jgbWJskNIxipS3ryhJkbOMwMrMjzcODRV
   jji27u24cPQE0jO4l73JIAgTGyS1gxcc42uTj8G06RRNNf7lEHcZR7rG5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18157132"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="18157132"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5606667"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:29:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Feb 2024 14:29:12 +0200 (EET)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    David Box <david.e.box@linux.intel.com>, 
    Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
In-Reply-To: <20240202071110.8515-3-jhp@endlessos.org>
Message-ID: <72b9ef46-851b-3555-0a43-8da4d4ab0fad@linux.intel.com>
References: <20240202071110.8515-3-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Feb 2024, Jian-Hong Pan wrote:

> The remapped PCIe Root Port and NVMe have PCI PM L1 substates
> capability, but they are disabled originally:
> 
> Here is an example on ASUS B1400CEAE:
> 
> Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> Power on all of the VMD remapped PCI devices and quirk max snoop LTR
> before enable PCI-PM L1 PM Substates by following "Section 5.5.4 of PCIe
> Base Spec Revision 6.0". Then, PCI PM's L1 substates control are
> initialized & enabled accordingly. Also, update the comments of
> pci_enable_link_state() and pci_enable_link_state_locked() for
> kernel-doc, too.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2:
>   - Power on the VMD remapped devices with pci_set_power_state_locked()
>   - Prepare the PCIe LTR parameters before enable L1 Substates
>   - Add note into the comments of both pci_enable_link_state() and
>     pci_enable_link_state_locked() for kernel-doc.
>   - The original patch set can be split as individual patches.
> 
>  drivers/pci/controller/vmd.c | 15 ++++++++++-----
>  drivers/pci/pcie/aspm.c      | 10 ++++++++++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..66e47a0dbf1a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -751,11 +751,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
>  		return 0;
>  
> -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> -
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
>  	if (!pos)
> -		return 0;
> +		goto out_enable_link_state;
>  
>  	/*
>  	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
> @@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	 */
>  	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
>  	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> -		return 0;
> +		goto out_enable_link_state;
>  
>  	/*
>  	 * Set the default values to the maximum required by the platform to
> @@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
>  	pci_info(pdev, "VMD: Default LTR value set by driver\n");
>  
> +out_enable_link_state:
> +	/*
> +	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
> +	 * Section 5.5.4 of PCIe Base Spec Revision 6.0

I don't understand what are you trying to say here? Are there some typos 
or grammar errors or something entire missing from the comment?

> +	 */
> +	pci_set_power_state_locked(pdev, PCI_D0);
> +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> +
>  	return 0;
>  }
>  
> @@ -926,7 +932,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  				   dev_get_msi_domain(&vmd->dev->dev));
>  
>  	vmd_acpi_begin();
> -
>  	pci_scan_child_bus(vmd->bus);
>  	vmd_domain_reset(vmd);

Spurious newline change.


-- 
 i.



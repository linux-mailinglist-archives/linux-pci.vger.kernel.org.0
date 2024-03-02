Return-Path: <linux-pci+bounces-4366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2BD86EEF3
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 07:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5DF282076
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120CC1876;
	Sat,  2 Mar 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MY0dzUOB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182BF138E;
	Sat,  2 Mar 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709361132; cv=none; b=iThf4qGuWMxBx4tQjC2qUcgXV+RDQ3YlZEb0doK3wvPobxUIbWAGLbvsoHqmzA0BWInUp6E2nw0DIEeeh5k+j3urlX6EnWdXLv+6ymk+KEER5MeVRrhkk3N+NM7mKOTeS91+ONTk8jpd1TG9hSKjgggGRzg50wuZ6jL+ozxI/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709361132; c=relaxed/simple;
	bh=FbAmZ7xpSXxFTpXQSs7ZwhOOV6ODYY3quidsJacMLSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et7V9Dmah9FYZB1dDyFmVaStsvzwMr6B/crXAcakM6NQP7X/YbayayavbpZVHeUUS91ydaivk25bmQsLDX5Qk+y/v1y2rSDjMxqNf51dvH53R+FGSd/ukieBGl5UrlkGsDvDTUMccj2nMhUDpCYJgbMg7aPWnwicKUOGwibmpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MY0dzUOB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709361130; x=1740897130;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FbAmZ7xpSXxFTpXQSs7ZwhOOV6ODYY3quidsJacMLSU=;
  b=MY0dzUOBcczEhRBKouz3Dk6uOyKCjGwExWBf/EIMiFyF5yIXv+2tMuOQ
   Lj0FRK5J9tZV7KY4U8kWU2qnj01sP9CiNPFeMN/mnzowatqZK54CPXy7c
   Oly/UiBsRwAAEBlzFxTvJfsvOffVBALD7OxdO7S6qAtap/Z2P7ZCWtp32
   FMe2CjKzf8Mf/bx0pVL48EUbTfQqy+W2DzMe2isHm/crFyForMznqYf29
   xqxj9kgZ0cSUGC2qu6YoECsqu4eRMmuhKexRVWPeunov8/Fq5dSVpRQFx
   IVWzV3ekbpAdgkLyXIzyZE3rRcOppnbua3u7KCr2TTH6GnvyIxiEkGd/P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684310"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="7684310"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 22:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8796071"
Received: from doney-mobl.amr.corp.intel.com (HELO [10.209.53.18]) ([10.209.53.18])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 22:32:08 -0800
Message-ID: <5b5daf03-55ab-45a6-99aa-390a4f4163d4@linux.intel.com>
Date: Fri, 1 Mar 2024 22:32:07 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
Content-Language: en-US
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Johan Hovold <johan@kernel.org>, David Box <david.e.box@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org
References: <20240216062412.247052-3-jhp@endlessos.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240216062412.247052-3-jhp@endlessos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/15/24 10:24 PM, Jian-Hong Pan wrote:
> The remapped PCIe Root Port and NVMe have PCI PM L1 substates capability,
> but they are disabled originally.
>
> Here is a failed example on ASUS B1400CEAE:
>
> Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>                   PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
>
> Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
> Substates by following PCI Express Base Specification Revision 6.0, section
> 5.5.4.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
Code wise it looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> v2:
> - Power on the VMD remapped devices with pci_set_power_state_locked()
> - Prepare the PCIe LTR parameters before enable L1 Substates
> - Add note into the comments of both pci_enable_link_state() and
>   pci_enable_link_state_locked() for kernel-doc.
> - The original patch set can be split as individual patches.
>
> v3:
> - Re-send for the missed version information.
> - Split drivers/pci/pcie/aspm.c modification into following patches.
> - Fix the comment for enasuring the PCI devices in D0.
>
> v4:
> - The same
>
>  drivers/pci/controller/vmd.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..6aca3f77724c 100644
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
> @@ -775,6 +773,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
>  	pci_info(pdev, "VMD: Default LTR value set by driver\n");
>  
> +out_enable_link_state:
Nit: Since you are also power on device, may be a generic name is better? Like
out_state_change or update_device_state? But it is upto you.
> +	/*
> +	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> +	 * PCIe r6.0, sec 5.5.4.
> +	 */
> +	pci_set_power_state_locked(pdev, PCI_D0);
> +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  	return 0;
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



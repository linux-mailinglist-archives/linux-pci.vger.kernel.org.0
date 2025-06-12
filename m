Return-Path: <linux-pci+bounces-29506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D6AD64A8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 02:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C1E17E9F7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 00:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D609F1E487;
	Thu, 12 Jun 2025 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuKVS4Kp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79BEACE
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688820; cv=none; b=EgGUGCvMA1FG2a10ijRBjxhBqfA0Bb6LO35+fu8+aA2niGuL0DGHXLi9pG9lzSYvawULTPLL+jta6uddIqbTcQzHd4W1YMXfk7ZRxHuhllnwyiq74INVcNtiuosgp6lZmE6jB7dY+S//Y1w0L0VN5xLI9zZgCcFFNNID/59O9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688820; c=relaxed/simple;
	bh=dDnsxtAed7SKqWKTBpBs3aCQrie1Itna6GVw2K4XtJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtnZiyNmuW30/DnENpgbbtIG2qy1naeWjo+aGFst0sygjwyUzMTuTp+VOmaqMD22v5h3OQqp6u1g3sbbrw+h1pBalQ5/zfv+j/6XMxnr+u6ab8VpSkJTmURQTBtPL/YpBCwR9SIP0grlGwjJUHP3TVlSbFEFJPTowBovAaMNtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuKVS4Kp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749688818; x=1781224818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dDnsxtAed7SKqWKTBpBs3aCQrie1Itna6GVw2K4XtJw=;
  b=BuKVS4KpzlhGL+WILM7gB9wQiTtg/pUe/EmYhWEnIar7a0Ma8I68wmAN
   YekZVYiewAXTT3iPhXlIh2aREgz2qUz33ekewz8W9pjbp3Wp6Yxk8lGnA
   +AvLO2fTGPgnFxgijx4RHlXvAsYG/jEZrHoReDxgVyhABWJf76BPFJd2D
   OFGOdyrtHAPE0MZXTGDVFSf2cHdu7C/pdkO6xn/gdHk50gsUDHXyKm/Kw
   mWh0gWMoiFqALsDd3SeK1QY+TuQ9rsv51M3f5/brsK/ySor9mmfGV7Xaq
   QOMBmkUAu9qWsNXNbaymzknynRgI+nG752MmS6/ifc1U1Bm2YY/xr0uGV
   g==;
X-CSE-ConnectionGUID: hTpbBJw7SJKrxKz8nPwi1Q==
X-CSE-MsgGUID: 20KkyzqYSlSXkwMsOQFLRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51948700"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51948700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 17:40:17 -0700
X-CSE-ConnectionGUID: NwhZQt4LQumIws2ld4u6zw==
X-CSE-MsgGUID: dZwpKVgpQ4iNhcS6shbAVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="184577996"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 17:40:17 -0700
Received: from [10.124.221.27] (unknown [10.124.221.27])
	by linux.intel.com (Postfix) with ESMTP id ED82820B5736;
	Wed, 11 Jun 2025 17:40:16 -0700 (PDT)
Message-ID: <ad1f0761-f9f2-43f0-8e91-337383b22c54@linux.intel.com>
Date: Wed, 11 Jun 2025 17:40:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Set up runtime PM on devices that don't support
 PCI PM
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 bhelgaas@google.com, rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, linux-pci@vger.kernel.org
References: <20250611233117.61810-1-superm1@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250611233117.61810-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/11/25 4:31 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") intended to put PCI devices into D0, but in doing so
> unintentionally changed runtime PM initialization not to occur on
> devices that don't support PCI PM.  This caused a regression in vfio-pci
> due to an imbalance with it's use.
>
> Adjust the logic in pci_pm_init() so that even if PCI PM isn't supported
> runtime PM is still initialized.
>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
> Reported-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m40d277dcdb9be64a1609a82412d1aa906263e201
> Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> v2:
>   * remove pointless return
> ---
>   drivers/pci/pci.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3dd44d1ad829b..160a9a482c732 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3222,14 +3222,14 @@ void pci_pm_init(struct pci_dev *dev)
>   	/* find PCI PM capability in list */
>   	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
>   	if (!pm)
> -		return;
> +		goto poweron;
>   	/* Check device's ability to generate PME# */
>   	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
>   
>   	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
>   		pci_err(dev, "unsupported PM cap regs version (%u)\n",
>   			pmc & PCI_PM_CAP_VER_MASK);
> -		return;
> +		goto poweron;
>   	}
>   
>   	dev->pm_cap = pm;
> @@ -3274,6 +3274,7 @@ void pci_pm_init(struct pci_dev *dev)
>   	pci_read_config_word(dev, PCI_STATUS, &status);
>   	if (status & PCI_STATUS_IMM_READY)
>   		dev->imm_ready = 1;
> +poweron:
>   	pci_pm_power_up_and_verify_state(dev);
>   	pm_runtime_forbid(&dev->dev);
>   	pm_runtime_set_active(&dev->dev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



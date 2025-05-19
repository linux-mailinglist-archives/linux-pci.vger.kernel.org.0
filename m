Return-Path: <linux-pci+bounces-27976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B1ABBF05
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 15:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6BA17FB8C
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256CB27935B;
	Mon, 19 May 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mp1wwhuc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CE26FA74;
	Mon, 19 May 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660904; cv=none; b=RQ5TgSpEmq2QE6cObSssf8KxIg/giT1AcMBWmB7WbL49jvGsL3BhqTzwqnNPzrbVK+gnm1yzQgiHIJ40nrQ7md7Bwun8HHS2ju/FRnc6RGyaoGledI36XVoudTEFTEwHuBFuwT6MR6LqO9j8OsyMkozbpD1c33IICLNfICEc+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660904; c=relaxed/simple;
	bh=69JNpM5fMS+HBTIz2jvNUWelHCPlrISQpoxsagPaMK8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ELc2b7+5fefHflbRcxOq5zVukRZ0Ofu6EtV+SDe6twFF6LHfneT8EmfqAY3yzdMpuIu+IzaNgY46GfTxdTiW9eSWvOe3ri39Qbos1Qszx3g9Z0Chb2hpcWzxrhWQC23i/2cP6QrPjshcMIu2+NjE4fPPbQoDr0P3bYDTCDuLFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mp1wwhuc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747660902; x=1779196902;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=69JNpM5fMS+HBTIz2jvNUWelHCPlrISQpoxsagPaMK8=;
  b=mp1wwhucw2hWCe2W1qLf2wKTnfDrQRE9kf7N8sp8EHHn1NAuXRZgXcRi
   i6uwK3FF4/2kyCPWjzErkwihW0Bq0wd/ncajjAWCv/7LeOKYTw/V6+3tL
   BHeHFsfd4o0IT4ArtfHzevOUl2UMJTg0euweFR0RSEZdmpB9ZqOZwGRAv
   L4aDzgqDSPcQJzWyfcbyTwLI94w3Ci91J0ZWALcIuJZh+A+4FHzduqkxX
   8mF/pNf+cQUblXvo3CpenGWZoRWzXrATD/Qw36njOsYvzZvZsjsL9LqRG
   62zQMKUJAQohwtsDeLBrhHSH3kfbGWjeFtcBZUXDw2ead5qy0AuCaNBtB
   A==;
X-CSE-ConnectionGUID: PdoVvpReTCWxDnkPw1dHhw==
X-CSE-MsgGUID: ZMpsBLe/RXGKoItWYIOauQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="52191986"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52191986"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:21:41 -0700
X-CSE-ConnectionGUID: AV9u1qR6Q8m54A5siYqt8A==
X-CSE-MsgGUID: UA7qCkRSR6y54OVukpdkBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139208350"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:21:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 May 2025 16:21:32 +0300 (EEST)
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
    Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
    qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
    Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3 04/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
In-Reply-To: <20250519-mhi_bw_up-v3-4-3acd4a17bbb5@oss.qualcomm.com>
Message-ID: <649c2bb2-d9a3-66ce-8bc5-2735195aaa5e@linux.intel.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com> <20250519-mhi_bw_up-v3-4-3acd4a17bbb5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 May 2025, Krishna Chaitanya Chundru wrote:

> If a driver wants to enable ASPM back after disabling ASPM for some
> usecase, it is not being enabled properly because of the aspm_disable
> flag is not getting cleared. This flag is being properly when aspm
> is controlled by sysfs.

This sentence has broken grammar/is missing something?

aspm -> ASPM

> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/pcie/aspm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	link->aspm_default = pci_calc_aspm_enable_mask(state);
> +	link->aspm_disable &= ~state;
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;

I disagree with this change.

The problem currently with ASPM driver is that pci_disable_link_state() 
and pci_enable_link_state() are not symmetric pairs despite their 
misleading names. pci_enable_link_state() should be renamed to 
pci_set_default_link_state() and if the symmetric pair is needed for 
pci_disable_link_state(), it would have to be added separately.

I've some (rotting) patches which try to do that, in case you want to try 
to solve this inconsistency in the ASPM driver (I can send them to you)?

-- 
 i.



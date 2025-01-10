Return-Path: <linux-pci+bounces-19629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E2DA092F0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 15:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13491167E43
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FEB20E6E7;
	Fri, 10 Jan 2025 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5Aibxud"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E520E021;
	Fri, 10 Jan 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517996; cv=none; b=q7gCNA4m66D49kJ66LoabXZp8GVzZOpQpgd2vLaFtJ6U3DKJWpqiv14PYDABxCfMsZ+DECXIvPLXyqBVr2XNtEaMzojrDtefoma/NrjBbtBSWCmy/d0x83ijb18dc1nfbLb02v9efyLH05brqh+q9QdlTt/NJIgsHPujDs1W8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517996; c=relaxed/simple;
	bh=FyKDcPK19DGqRMycLR+Y9MPxySJF0EGrn0Sr04PvVSQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WRRBbo2vWrbXp80H/9wVWHQFOSECeQ1EOdPHsd/EyYaUqxI5K03qs/UBp7zsodHV18DPe5vK4ROAETs07qM4CITEOlhB9+RcjmJeYnz/9FapWki/T0iyIHiZ7FopFLZToQ6/nHO8Ipb92Ngt+CALoEHri0YN1gMF6kGgUO4zPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5Aibxud; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736517995; x=1768053995;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FyKDcPK19DGqRMycLR+Y9MPxySJF0EGrn0Sr04PvVSQ=;
  b=l5Aibxud36rW5dIkPKlxd8Uo5p0SOORLlMv1oYSupo0XhGZoURZAI7UF
   7pfrEa6pEGWolxlE1QshYVrCHqwQJfs2CHweym92Rw20mnhZtWd8ex53q
   KpN60gNSDptZw8CYHkpS80lGpD+4a6+uZ/0XmeTu3mlsr06oc0N30/Wiy
   xXmgvL60cTLgxd7RM54RBGXNrxm/cvmCH1+J3Wxj6/f2XCsS6XWPPPSRD
   W7GmEoAmpfu0gLbw7teqtCYlau9ZXtCTCyTYuivbyxloK8Snajy92ybyo
   Eo92KA55ek6/bRq7JfKpD6/DySSI9LjHQ4bIo89AzHbv21dAq30QgruTW
   w==;
X-CSE-ConnectionGUID: 9+kWMMQbRE2G+7MlxD7eZA==
X-CSE-MsgGUID: PPnYB9WzR36OHieLfEimbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36693945"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36693945"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 06:06:35 -0800
X-CSE-ConnectionGUID: jNVTu3CLSRuvAIpNvUYVYA==
X-CSE-MsgGUID: 7m5TwMfXRVyb6r9rttxqPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103622650"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO localhost) ([10.245.244.158])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 06:06:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Jan 2025 16:06:26 +0200 (EET)
To: Jiwei Sun <jiwei.sun.bj@qq.com>, macro@orcam.me.uk
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, guojinhui.liam@bytedance.com, 
    helgaas@kernel.org, Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, 
    sunjw10@lenovo.com
Subject: Re: [PATCH 1/2] PCI: Fix the wrong reading of register fields
In-Reply-To: <tencent_753C9F9DFEC140A750F2778E6879E1049406@qq.com>
Message-ID: <d3129f85-eeb4-021c-09d2-5877c9671a8d@linux.intel.com>
References: <tencent_753C9F9DFEC140A750F2778E6879E1049406@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Jan 2025, Jiwei Sun wrote:

> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
> PCIe Link Speed"), there are two potential issues in the function
> pcie_failed_link_retrain().
> 
> (1) The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just
> uses the link speed field of the registers. However, there are many other
> different function fields in the Link Control 2 Register or the Link
> Capabilities Register. If the register value is directly used by the two
> macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).
>
> (2) In the pcie_failed_link_retrain(), the local variable lnkctl2 is not
> changed after reading from PCI_EXP_LNKCTL2. It might cause that the
> removing 2.5GT/s downstream link speed restriction codes are not executed.

Thanks for finding these issues and coming up with a patch.

These cases seem two different problems to me so I'd put them into 
different patches, which would also make it easeir focus on 
describing the issue in case 2 which is currently a bit vague (when 
looking how de9a6c8d5dbf managed to break it by removing the lnkctl2 
change prior to writing into the reg).

> In order to avoid the above-mentioned potential issues, only keep link
> speed field of the two registers before using by pcie_set_target_speed()
> and reread the Link Control 2 Register before using.
> 
> Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a..605628c810a5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -118,11 +118,13 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
>  		if (ret) {
>  			pci_info(dev, "retraining failed\n");
> +			oldlnkctl2 &= PCI_EXP_LNKCTL2_TLS;
>  			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
>  					      true);

I'd prefer these get fixed inside the macros so that the callers don't 
need to take handle what seem something that is always needed.

>  			return ret;
>  		}
>  
> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  	}
>  
> @@ -133,6 +135,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  
>  		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
>  		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +		lnkcap &= PCI_EXP_LNKCAP_SLS;
>  		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);

-- 
 i.



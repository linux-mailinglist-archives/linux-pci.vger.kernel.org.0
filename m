Return-Path: <linux-pci+bounces-6678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7E38B2A5B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 23:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7715B2811BC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 21:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10C153BF2;
	Thu, 25 Apr 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnEhW8Ui"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17966153BC7;
	Thu, 25 Apr 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078911; cv=none; b=sdH8irzn8Kq2BROPwdcfYuGQ8zxGTOJSLhQSj+LM86F3axHa9E62jkN8w1Y3IsUTzw/bb6jO+j6LJ3ofvl9BYocokf/U7tktJtA/97sFz4lZNnYP8hBp+hSIoIdp8gtoo4T9obOKV7JvQA/45WbnX46bChXCG/gdY0WSzYZswyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078911; c=relaxed/simple;
	bh=A2dKCGsB/Ici8fMlijpabSHqnvQKwWrWdSSIk88w2yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxTIzHgyV0iTFBqVI+wrB4hs1/ZP2Q1ffr/pc3kl4vxQoPU/e8QGlHcH6hpWE+DFwP1fotU/0tqswgzcZiqgKALT52gvGInq5HGF/cNQmaYIz3PeZ1M+mnxWcg1gh/VJxbFMJInn+ecPxDwYqeyIAYo2+VPiduUj16bJzWD4cIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnEhW8Ui; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714078910; x=1745614910;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A2dKCGsB/Ici8fMlijpabSHqnvQKwWrWdSSIk88w2yQ=;
  b=RnEhW8UiwHrjJaj+FzhOLpIdVMRRVtWVA38AOgAU4igwYbksPWWcFUsK
   0y69nqX2sAheOVypXYMcMvc0PTRAUX2ubaAQdpCftjvKIFSrKqunILsz8
   Ar/RF6ghKV8nuY+DP8k9YZStlVabQKfAPCT3Xlb8BtnYYRn8XKQY02YeT
   cwCOgeldNga/mQyTorTK196bAEtH/Z6+/Y6QG/Al+n9auWw0K5Pg+XBso
   D5JzbH6WquMgS2qajBImc4LWxXmYoxL93g2eyPY0x8xYvlxBUSckX6S7a
   nZYvKS4CE9mzCCefl793fCv0S+aBFNa3dSfra0iKdnGc92EBmUznHI+3j
   A==;
X-CSE-ConnectionGUID: ZqN86O9vQM2KbSJxDo5AfA==
X-CSE-MsgGUID: ibPDEImPSqmvjMbACHEb7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10331472"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="10331472"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 14:01:49 -0700
X-CSE-ConnectionGUID: SijPsIOcSD6JjPyqCYF1fg==
X-CSE-MsgGUID: JrO6dyC7TOasSciPvgFpvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25209874"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.132.135])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 14:01:48 -0700
Date: Thu, 25 Apr 2024 14:01:44 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>,
 David Box <david.e.box@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, <paul.m.stillwell.jr@intel.com>
Subject: Re: [PATCH v5 0/4] PCI: vmd: Enable PCI PM's L1 substates of
 remapped PCIe Root Port and NVMe
Message-ID: <20240425140144.000049a4@linux.intel.com>
In-Reply-To: <20240424105814.21690-2-jhp@endlessos.org>
References: <20240424105814.21690-2-jhp@endlessos.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 18:58:15 +0800
Jian-Hong Pan <jhp@endlessos.org> wrote:

> Re-send for the version information.
> 
> Notice the VMD remapped PCIe Root Port and NVMe have PCI PM L1
> substates capability, but they are disabled originally.
> 
> Here is a failed example on ASUS B1400CEAE with enabled VMD:
> 
> 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
> PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
>     Capabilities: [200 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+ PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>         	   T_CommonMode=45us LTR1.2_Threshold=101376ns
>         L1SubCtl2: T_PwrOn=50us
> 
> 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
>     Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> L1_PM_Substates+ PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> According to "PCIe r6.0, sec 5.5.4", to config the link between the
> PCIe Root Port and the child device correctly:
> * Ensure both devices are in D0 before enabling PCI-PM L1 PM
> Substates.
> * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON and
>   LTR_L1.2_THRESHOLD are programmed properly on both devices before
> enable bits for L1.2.
> 
> Prepare this series to fix that.
> 
> Jian-Hong Pan (4):
>   PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
>   PCI/ASPM: Add notes about enabling PCI-PM L1SS to
> pci_enable_link_state(_locked) PCI/ASPM: Introduce aspm_get_l1ss_cap()
>   PCI/ASPM: Fix L1.2 parameters when enable link state
> 
>  drivers/pci/controller/vmd.c | 13 ++++++++----
>  drivers/pci/pcie/aspm.c      | 41
> ++++++++++++++++++++++++++++-------- 2 files changed, 41
> insertions(+), 13 deletions(-)
> 

Hi,

We are running some tests to make sure we dont have issue with other
platforms and trying to avoid another hotplug scenario. Please wait for
our Ack before merging this patch. Thanks.

-nirmal


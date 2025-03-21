Return-Path: <linux-pci+bounces-24408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D7A6C560
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC2CA7A27C7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F531EF0B1;
	Fri, 21 Mar 2025 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpeJdxgz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150728E7
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593660; cv=none; b=hxppeJQiAwIFFn+qITSaJDfsx/YPL/Lr+TZlPSHWobrXS6osw60kNrVK1GU+bB7Ed35Q7IlVEv31aqQYOM/xKP0s7eYudTkBGaFzZhC1aJHSxAuIASyLLcoTZ+x8/4dnuvdmwdngj04A9V4dCxtU1zkmPOpfY2oWdldhl609DTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593660; c=relaxed/simple;
	bh=l7IInD4cjEJ/3oPOv3agmrfw9e0pgn1NDKAqHr4Dtbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epLtXRW6exR3NDurR+pl/AD9qPwF/d65EcQbkgUzziqEYkko0a5AhToK7neNZuQBiJTGhTN9md1XJAjMYX6/gaRSzjQXINYujsc7hQvP55RcrMN1fzoSOEyHopT5mFpPvHkcFSLa0nTPaHdjwHG0+Bg76kK749PcG2jEVWtDrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpeJdxgz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742593659; x=1774129659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l7IInD4cjEJ/3oPOv3agmrfw9e0pgn1NDKAqHr4Dtbs=;
  b=hpeJdxgzqIb5ewVgpwSIwMiZ5bgr2koQP73B3x3/blx6+DyluXhpqAMf
   Oy9N2GHAdfZTFrN2rR2zhkwWFUlcU4MwHgh2z0kBTosC80q4iI+SFG1iM
   Ead2wcdK2gBQ0DWfW91+b5mbxgwmuPQP/sYK2ievpTQbbOLfeRv6lC2d6
   v/nWIc5shaflDwx8pO4dNqfaZrwRiRAuqixNqv1NDWEq8TGvq1uSVMWZI
   D/HzXNafALMy3UYOTDtM73FAXnaz+70ER9VDCWDrTkNKF9EJUEXX0UhSh
   3DTKhSfYfTNCfWgSc/eotGf9QP/jBM/+54uwj7m6c0vdvSGsnrbyvn0yO
   w==;
X-CSE-ConnectionGUID: eV5qBYAzTaS2TaadHGMtmA==
X-CSE-MsgGUID: GVHVtoPDQT2R9c6IQ7vLtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="47529959"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="47529959"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:47:38 -0700
X-CSE-ConnectionGUID: IBuhSUy2TlKDEeGxsQnouw==
X-CSE-MsgGUID: 9OZhQG0bSX6Uv6/2seRFZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="123678551"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO [10.124.221.233]) ([10.124.221.233])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:47:37 -0700
Message-ID: <bfd75767-7743-47d7-939e-f0c5204ee647@linux.intel.com>
Date: Fri, 21 Mar 2025 14:47:36 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>, linux-pci@vger.kernel.org,
 Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-6-pandoh@google.com>
 <85bd0cd9-c09f-464d-9397-ced829df27d7@linux.intel.com>
 <CAMC_AXW6QgDV9bSiYR5UpgSAii+YSPLk_xCdYHZGjudDZpGstQ@mail.gmail.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAMC_AXW6QgDV9bSiYR5UpgSAii+YSPLk_xCdYHZGjudDZpGstQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jon,

On 3/21/25 12:24 PM, Jon Pan-Doh wrote:
> On Thu, Mar 20, 2025 at 6:00 PM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Should we exclude fatal errors from the rate limit? Fatal error logs
>> would be
>> really useful for debug analysis, and they not happen very frequently.
> The logs today only make the distinction between correctable vs.
> uncorrectable so I thought it made sense to be consistent.

You're right. From a logging perspective, the current driver only
differentiates between correctable and uncorrectable errors. However,
the goal of your patch series is to reduce the spam of frequent errors.
While we are rate-limiting these frequent logs, we must ensure that we
don't miss important logs. I believe we did not rate-limit DPC logs for
this very reason.


>
> Maybe this is something that could be deferred? The only fixed

I am fine with deferring. IIUC, if needed, through sysfs user can
skip rate-limit for uncorrectable errors, right?

But, is the required change to do this complex? Won't skipping the
rate limit check for fatal errors solve the problem?

Bjorn, any comments? Do you think Fatal errors should be
rate-limited?

> component is the sysfs attribute names (which can be made to refer to
> uncorrectable nonfatal vs. uncorrectable in doc/underlying
> implementation).
>
> Thanks,
> Jon

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



Return-Path: <linux-pci+bounces-7112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D13FC8BCFE4
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5FDB2320F
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6313D502;
	Mon,  6 May 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eny5UMju"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F413D29A;
	Mon,  6 May 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005089; cv=none; b=BXAyZ+SFeEyiqRpHUKRgdL6lLxTo3HjVJGPd/3VptZRORT6c0rvAPvPIsp+1eki4v9Uj/Kno5pElxvKnSCol7QYdFLU7uYF0nKpLiITtNJJV13y1hB3+mnjcp5g6o0ix5oC4YQzrlNd2E/rRfDaZAXl6b5tvIv1TVeAnm9O+3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005089; c=relaxed/simple;
	bh=QuPPpZCjbh9KHqVSDM8dTOKWSpW1SL8LzLyaE7eo07g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FeZPLXp+Q37OxBEutKLKHlzgdONKqso0iyr+exhmeG5NqIGHnQp3fuPvkhDwcB40FqJDh3g92279GqnYsjBzC/hPxrYJnoIMjbsviPVGe2QL2OMaI5p0si9M0AA+i2ZbQHeyhXOxkK/Qrxn6eRkM/eONrzqfwnZhz1zan1+U0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eny5UMju; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715005088; x=1746541088;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QuPPpZCjbh9KHqVSDM8dTOKWSpW1SL8LzLyaE7eo07g=;
  b=eny5UMjupkN8TKmwZjzDWLUp4BIWOlYhJCFs+/MQikWg+1pfQTgHMjiG
   vmVGIRy4H8AzuwQ8960Sgfs5gu8zPsyrP5bIjyb8M2VOeK2P8QZ4IovCm
   7OueY2GrJ3XkySAzsjEJEMu/bIp2nD5DyWwXvUksmpc7jehbg7Gv6erk1
   Hot0tl4yw4hm5GQg8S8mJUEsWLhsIpEYNTazQkk8xWBsgvhHrTiD2t1kO
   wuQqEqI2r3+WwRFvrC9YpcfDdBW4+aYnVv0Moqyhqh9KHwj5+6VCdzoYN
   FUc+d+G3PZrSVGpvu0RmaEqdIEiT6a2/W/87NqFAqTowafkdcuVjqvt9n
   g==;
X-CSE-ConnectionGUID: 5xDGAX0BS1q1oj4vGEwL1w==
X-CSE-MsgGUID: uIdOGG3SQZyGFqRg5mvkRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28277591"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28277591"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:18:07 -0700
X-CSE-ConnectionGUID: z9ZDgbHbTQubAn77ZjhLaw==
X-CSE-MsgGUID: QkMpvQWNQ1WnnIcE4Oi1Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32766651"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:18:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 17:17:58 +0300 (EEST)
To: "Dr. David Alan Gilbert" <linux@treblig.org>
cc: bhelgaas@google.com, dave.hansen@linux.intel.com, x86@kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: ce4100: Remove unused struct 'sim_reg_op'
In-Reply-To: <20240506004647.770666-1-linux@treblig.org>
Message-ID: <948a3829-96da-2708-60f8-f25546683436@linux.intel.com>
References: <20240506004647.770666-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 May 2024, linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This doesn't look like it was ever used.

Don't start with "This" but spell what you're talking about out so it 
can be read and understood without shortlog in Subject (or looking into 
the code change).

> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  arch/x86/pci/ce4100.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
> index 87313701f069e..f5dbd25651e0f 100644
> --- a/arch/x86/pci/ce4100.c
> +++ b/arch/x86/pci/ce4100.c
> @@ -35,12 +35,6 @@ struct sim_dev_reg {
>  	struct sim_reg sim_reg;
>  };
>  
> -struct sim_reg_op {
> -	void (*init)(struct sim_dev_reg *reg);
> -	void (*read)(struct sim_dev_reg *reg, u32 value);
> -	void (*write)(struct sim_dev_reg *reg, u32 value);
> -};
> -
>  #define MB (1024 * 1024)
>  #define KB (1024)
>  #define SIZE_TO_MASK(size) (~(size - 1))
> 

-- 
 i.



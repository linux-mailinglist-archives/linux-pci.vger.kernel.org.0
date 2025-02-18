Return-Path: <linux-pci+bounces-21764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22293A3AB4A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139633A61E7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 21:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57D1CDFD4;
	Tue, 18 Feb 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLHG70B9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9B2862A5;
	Tue, 18 Feb 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915079; cv=none; b=eZ84T+Spsm/LgkTRvBUveoVA74vslXNAlRqDLl2kfhVTjRvBE/Q2JfS9x796bHaCkIT3QscOm4uvnqL8LdI4l1x0m9LxCpb15SWVupQWUbFOAJYm8J6pzBrgH0ehOT9JKZlNFeR9liYWMcarEiuR7tjPK3vqWoFTApDc6vmucnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915079; c=relaxed/simple;
	bh=W+pJ7fkzR5SYWeUg2yaBW1+rHQotkuFqRrRIpePuwnQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jy6b2kxXa48C5PwEnpImsnIMxOUySR7bDJy6z6jWYyufPcrrWKIdby4eAbeuV7aESXbGCX7EAgOhQjeutu7mNHwW9Rs2ku+O0ppe30de7kaSfh4LZ2MuhAu3byL52II04xEpbQ5SH2c0KzG2RTQqJEMwdIxKSRUofC8bJjY99mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLHG70B9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739915078; x=1771451078;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W+pJ7fkzR5SYWeUg2yaBW1+rHQotkuFqRrRIpePuwnQ=;
  b=mLHG70B9NQs1PX2yQIZtmDXXdyG5asDqN8EFAwbN5XA6yD2t2ivQgJIm
   kJjgIlzICY64UbwpNVpeXDprDncaQRd96Ys9cxuz0jXhbHwrSHmc3XAJU
   H7sMxDpKj1HmxvBEfhxPYnXBeGWwaf3lyHM0BOAXeo0wuK4o/nOdNxaFT
   Jz/9IH9H3ouwZ0iKAdg+RPmt0rj+zuNX2zVFfImVmCR0jKi785i93n6f1
   rN5pNDRmpqyXmeLx9RMLtGViAqBsbhSN2Ki2trtfTwUoqd5NuwtO7Yp2D
   0rSYW/kd5Tf2/cxZWzgQeaW4d37+6tcIP9j1S+lHjpNJvwMtE6YJpmKRh
   A==;
X-CSE-ConnectionGUID: L44NtO3KTJqNIpG39P5D6w==
X-CSE-MsgGUID: auHiXmMISCiNNmFJBiPHRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44392115"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44392115"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 13:44:38 -0800
X-CSE-ConnectionGUID: ZnrSGHdBQiKOR5Q5AX3MPw==
X-CSE-MsgGUID: abLMHqF7TBqct4g1dE2xvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115414299"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 13:44:36 -0800
Date: Tue, 18 Feb 2025 13:44:36 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v7 3/7] arm64: dts: agilex: Fix fixed-clock schema
 warnings
In-Reply-To: <20250216-astonishing-funky-skylark-c64bba@krzk-bin>
Message-ID: <c5755f14-3efd-d4ef-4e34-6446608dedfd@linux.intel.com>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com> <20250215155359.321513-4-matthew.gerlach@linux.intel.com> <20250216-astonishing-funky-skylark-c64bba@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Sun, 16 Feb 2025, Krzysztof Kozlowski wrote:

> On Sat, Feb 15, 2025 at 09:53:55AM -0600, Matthew Gerlach wrote:
>> All Agilex SoCs have the fixed-clocks defined in socfpga_agilex.dsti,
>
>
> That's not what I asked / talked about. If the clocks are in SoC, they
> cannot be disabled.

There are two clocks, cb_intoosc_hs_div2_clk and cb_intosc_ls_clk, in the 
SoC with a known frequency. These warnings can be fixed in the DTSI.

>
> If they clocks are not in SoC, they should not be in DTSI.

The two clocks, f2s_free_clk and osc1, are not in the SoC; so they should 
be removed from DTSI.

>
> These were my statements last time and this patch does not comple.
> Commit msg does not explain why this should be done differently.
>
> Best regards,
> Krzysztof
>
>

Thanks for the feedback,
Matthew Gerlach


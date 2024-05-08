Return-Path: <linux-pci+bounces-7222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A708BFC8C
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1A11F21967
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BFC81AD0;
	Wed,  8 May 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwDyz1/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF8823BF
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168719; cv=none; b=gIGu6gCgzznzzaLuEJbTcz5DqL2YhkMstvT3luEKRL87rDVPQuXn9qLEnB/uL8bEIT6czTOlG2r8He3VN8rrA5NJ8ulrtpa84GEdJ4ucmOn/Kh384rDGocGJpFdoOGKMz3VE1nft3C88Gckp+/wZQl3RjhEu4CotKJg13AL2nOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168719; c=relaxed/simple;
	bh=Z2+oS4Ans8JqBprbt8lhZ5VM4SNNrnzMJHmgefB0DiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X7oeESy1jrQyYU2ozsQbHI9xKRVu9T3g0qzyJsRPN3pPZ2jqfG/6vWTzbKrh4ZcNnZdFy/5SZdqky07/Yx57TW5HqS764erbKzKQT0VeocPPU/Hew5Zr5aDLX6l0OZowQxsoc6BdlhjzWLszGl2eS0pgYZn2gGhliIlqnmoEwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwDyz1/Y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715168717; x=1746704717;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Z2+oS4Ans8JqBprbt8lhZ5VM4SNNrnzMJHmgefB0DiE=;
  b=AwDyz1/YCvGlj8So8qPXaCr25mhzBHqNKBDjpTViAEVjj0Oml/bZ4eer
   tT5GV3eiYcDvALc2Uu2HCNPYwV/PcIWUzdbx1RSoaz/vdVsiopav4WQ9S
   KaofwX2zZkB+gBqNHiaCX7g5xnbnpAgVuwAdrwxWiwDdp/fempSQsjjcc
   qEgDb8dHWD4P5bvAjkDgfFTgXBDqooimtzJP3gNFkFCvL16XqBYXH/NXO
   O9ZePdml970ssazgZqsUTe0Riv/nuCdJO38yoyD1y0gs3FFeaXf0n8MWK
   G6XZLKyHlsmxSHNcQYTEKVypNUTUvrTIowrfYQ01tHcQ50q1x6B6wfMOs
   g==;
X-CSE-ConnectionGUID: nDwhCAB6Rxq8XgcYXwwM/w==
X-CSE-MsgGUID: nbFpfOdsQdmzCHpGURZZjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11234266"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11234266"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:45:17 -0700
X-CSE-ConnectionGUID: S35w54SuRoCUdApyHuxSMg==
X-CSE-MsgGUID: F9EBuTF0SeeggaJXrlMq5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33697459"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:45:13 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Rodrigo
 Vivi
 <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, lucas.demarchi@intel.com, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
In-Reply-To: <ZjtapMK6kadLqHCN@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1715086509.git.jani.nikula@intel.com>
 <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
 <Zjow5HXrXpg2cuOA@intel.com> <ZjtapMK6kadLqHCN@intel.com>
Date: Wed, 08 May 2024 14:45:10 +0300
Message-ID: <87o79gjznd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 08 May 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Tue, May 07, 2024 at 09:47:16AM -0400, Rodrigo Vivi wrote:
>> On Tue, May 07, 2024 at 03:56:48PM +0300, Jani Nikula wrote:
>> > It's confusing for INTEL_CFL_IDS() to include all CML PCI IDs. Even if
>> > we treat them the same in a lot of places, CML is a platform of its ow=
n,
>> > and the lists of PCI IDs should not conflate them.
>> >=20
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: linux-pci@vger.kernel.org
>> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> > ---
>> >  arch/x86/kernel/early-quirks.c                      |  1 +
>> >  drivers/gpu/drm/i915/display/intel_display_device.c |  1 +
>> >  include/drm/i915_pciids.h                           | 12 +++++++-----
>> >  3 files changed, 9 insertions(+), 5 deletions(-)
>> >=20
>> > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-qu=
irks.c
>> > index 59f4aefc6bc1..2e2d15be4025 100644
>> > --- a/arch/x86/kernel/early-quirks.c
>> > +++ b/arch/x86/kernel/early-quirks.c
>> > @@ -547,6 +547,7 @@ static const struct pci_device_id intel_early_ids[=
] __initconst =3D {
>> >  	INTEL_BXT_IDS(&gen9_early_ops),
>> >  	INTEL_KBL_IDS(&gen9_early_ops),
>> >  	INTEL_CFL_IDS(&gen9_early_ops),
>> > +	INTEL_CML_IDS(&gen9_early_ops),
>> >  	INTEL_GLK_IDS(&gen9_early_ops),
>> >  	INTEL_CNL_IDS(&gen9_early_ops),
>> >  	INTEL_ICL_11_IDS(&gen11_early_ops),
>> > diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/dri=
vers/gpu/drm/i915/display/intel_display_device.c
>> > index 56a2e17d7d9e..3aa7d1cdd228 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_display_device.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
>> > @@ -832,6 +832,7 @@ static const struct {
>> >  	INTEL_GLK_IDS(&glk_display),
>> >  	INTEL_KBL_IDS(&skl_display),
>> >  	INTEL_CFL_IDS(&skl_display),
>> > +	INTEL_CML_IDS(&skl_display),
>> >  	INTEL_ICL_11_IDS(&icl_display),
>> >  	INTEL_EHL_IDS(&jsl_ehl_display),
>> >  	INTEL_JSL_IDS(&jsl_ehl_display),
>> > diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
>> > index 85ce33ad6e26..5f52c504ffde 100644
>> > --- a/include/drm/i915_pciids.h
>> > +++ b/include/drm/i915_pciids.h
>> > @@ -472,6 +472,12 @@
>> >  	INTEL_VGA_DEVICE(0x9BCA, info), \
>> >  	INTEL_VGA_DEVICE(0x9BCC, info)
>> >=20=20
>> > +#define INTEL_CML_IDS(info) \
>> > +	INTEL_CML_GT1_IDS(info), \
>> > +	INTEL_CML_GT2_IDS(info), \
>> > +	INTEL_CML_U_GT1_IDS(info), \
>> > +	INTEL_CML_U_GT2_IDS(info)
>> > +
>> >  #define INTEL_KBL_IDS(info) \
>> >  	INTEL_KBL_GT1_IDS(info), \
>> >  	INTEL_KBL_GT2_IDS(info), \
>> > @@ -535,11 +541,7 @@
>> >  	INTEL_WHL_U_GT1_IDS(info), \
>> >  	INTEL_WHL_U_GT2_IDS(info), \
>> >  	INTEL_WHL_U_GT3_IDS(info), \
>> > -	INTEL_AML_CFL_GT2_IDS(info), \
>> > -	INTEL_CML_GT1_IDS(info), \
>> > -	INTEL_CML_GT2_IDS(info), \
>> > -	INTEL_CML_U_GT1_IDS(info), \
>> > -	INTEL_CML_U_GT2_IDS(info)
>> > +	INTEL_AML_CFL_GT2_IDS(info)
>>=20
>> Why only CML and not AML and WHL as well?
>
> Why do we even have CML as a separate platform? The only difference=20
> I can see is is that we do allow_read_ctx_timestamp() for CML but
> not for CFL. Does that even make sense?

git blame tells me:

5f4ae2704d59 ("drm/i915: Identify Cometlake platform")
dbc7e72897a4 ("drm/i915/gt: Make the CTX_TIMESTAMP readable on !rcs")

BR,
Jani.

--=20
Jani Nikula, Intel


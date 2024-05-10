Return-Path: <linux-pci+bounces-7353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E4E8C234A
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B60283BB2
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD01708BF;
	Fri, 10 May 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxgeHBcO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35416F828
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340300; cv=none; b=UWDxDGeoxK4ij1x7L6ObCwOFNJVkcoWfswt+T+HFI0HXIldAvs0aoFHTH0QcM7nbIzDjyPa262i+CuPpK/CaNCWDuxkKsqMk0OSEIIzgSzHkqA8szDQF/GeH68JY9Paur28BfwroBtXL1nMlnzGyCUgcKhormXWznww204VDiwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340300; c=relaxed/simple;
	bh=k0sopvIhiy6f6+kwNT/Kt+0l33MxuXLxebeKhFV8NrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZuVevRiqEw71anAdSNQ55/X5DNnF9WK8ZyV5nMOIvA2xJkv00fIsOqKtLuReu8RIKpP9C2FcPIMYYrdURp6GEGTXIsi1jER45DUr1H8s6JK8w9Pjz4Wwpwo21ayOblR4ECaUN67wkAi5oLmy1D1HV4MYvMqCHfcGeSttQ6vdniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxgeHBcO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340299; x=1746876299;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=k0sopvIhiy6f6+kwNT/Kt+0l33MxuXLxebeKhFV8NrU=;
  b=SxgeHBcOnIMNyLZFpvHe4wIg/pE4gcL5WDgmlbvRnES5UkPyhuTv1yNw
   WIWRDllW8lk/LwK3dLMpUrBQy7vN47p/fFBVJtNJaPB3wCM3n7BEAZyMt
   5klpiJGRbuRBnCpe40XT3rQSvf8XXvdA/J+HO7ofYASEhE7orfd3Y6yY7
   PaaS7yOOBQesw6IMQki6tlVZgy8RfDK//JwBWwgfxkruuH2sT1BjItT9J
   WuIG0/TtG6fvUG2uowyCUMTL0D39YS6zKSsbcnHVCLAYaGUyqP14OS1kt
   NkVGlUIXV7EpLQnSYQKwgTrolwloDAmawR3LjhDOxYPdgz+q/A3mkcswM
   g==;
X-CSE-ConnectionGUID: pxX1R8uLRrmYWKrbAqiL5g==
X-CSE-MsgGUID: c3b/Ewr1TO+ESBnalz1ZpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22714171"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="22714171"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:24:58 -0700
X-CSE-ConnectionGUID: 6UL5MSW7RfiydE2PeyzcuA==
X-CSE-MsgGUID: dBXpu5ifTr2Swg24+9L/Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34028111"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:24:55 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
 lucas.demarchi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
In-Reply-To: <Zj34KTmYP6VNQ3CS@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1715086509.git.jani.nikula@intel.com>
 <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
 <Zjow5HXrXpg2cuOA@intel.com> <ZjtapMK6kadLqHCN@intel.com>
 <87o79gjznd.fsf@intel.com> <ZjtprkZVSQ-o_qch@intel.com>
 <87le4ihsmr.fsf@intel.com> <Zj34KTmYP6VNQ3CS@intel.com>
Date: Fri, 10 May 2024 14:24:52 +0300
Message-ID: <87ikzlj4e3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 May 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Fri, May 10, 2024 at 01:24:12PM +0300, Jani Nikula wrote:
>> On Wed, 08 May 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.=
com> wrote:
>> > On Wed, May 08, 2024 at 02:45:10PM +0300, Jani Nikula wrote:
>> >> On Wed, 08 May 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.int=
el.com> wrote:
>> >> > On Tue, May 07, 2024 at 09:47:16AM -0400, Rodrigo Vivi wrote:
>> >> >> On Tue, May 07, 2024 at 03:56:48PM +0300, Jani Nikula wrote:
>> >> >> > It's confusing for INTEL_CFL_IDS() to include all CML PCI IDs. E=
ven if
>> >> >> > we treat them the same in a lot of places, CML is a platform of =
its own,
>> >> >> > and the lists of PCI IDs should not conflate them.
>>=20
>> [snip]
>>=20
>> >> >> Why only CML and not AML and WHL as well?
>> >> >
>> >> > Why do we even have CML as a separate platform? The only difference=
=20
>> >> > I can see is is that we do allow_read_ctx_timestamp() for CML but
>> >> > not for CFL. Does that even make sense?
>> >>=20
>> >> git blame tells me:
>> >>=20
>> >> 5f4ae2704d59 ("drm/i915: Identify Cometlake platform")
>> >> dbc7e72897a4 ("drm/i915/gt: Make the CTX_TIMESTAMP readable on !rcs")
>> >
>> > Right. That explains why we need it on CML+. But is there some reason
>> > we  can't just do it on CFL as well, even if not strictly necessary?
>> > I would assume that setting FORCE_TO_NONPRIV on an already
>> > non-privileged register should be totally fine.
>>=20
>> I have absolutely no idea.
>>=20
>> I'm somewhat thinking "CML being a separate platform" is a separate
>> problem from "CFL PCI ID macros including CML".
>>=20
>> I'm starting to think the PCI ID macros should be grouped by "does the
>> platform have a name of its own",
>
> That and/or "does bspec have a separate 'Confgurations <platform>' page?"
>
>> not by how those macros are actually
>> used by the driver. Keeping them separate at the PCI ID macro level just
>> reduces the pain in maintaining the PCI IDs, and lets us wiggle stuff
>> around in the driver how we see fit.
>
> Aye.
>
>>=20
>> And that spins back to Rodrigo's question, "Why only CML and not AML and
>> WHL as well?". Yeah, indeed.
>>=20
>> If we decide to stop treating CML as a separate platform in the
>> *driver*, that's another matter.
>
> Sure. Seeing it just got me wondering...

I sent a new series with just the PCI ID macro cleanups [1]. I meant to
Cc: you and Rodrigo, but forgot. :(

BR,
Jani.

[1] https://patchwork.freedesktop.org/series/133444/



--=20
Jani Nikula, Intel


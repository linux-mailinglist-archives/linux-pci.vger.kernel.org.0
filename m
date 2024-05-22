Return-Path: <linux-pci+bounces-7741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFBB8CBE45
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE41BB21B52
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0B7F489;
	Wed, 22 May 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSNvxMqb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2C54720
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371013; cv=none; b=jSfuRGiG1VHXgQ36qkuFpUc7s/VISP5zB34Qo3pnsWeuJVztw3kHcKr1M5OjiAG+7ucBkaYYCRdZ9BjMZbwbbaOh5GKXfRe4pxZoUb7fma4aX0JDIjlmu/aExBTzjXileZDKNs6lVKyIbHOgNTZF75G4/qt7jZ4oFqfLIV2/uYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371013; c=relaxed/simple;
	bh=mjMI5jn7GDB1KOVdd12Y1631VJlZG67v4e1IULzb7Hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eBM7jigKPM1f5ai/eq1e6ptafSJmh1Ti1x1kWUxSn9DveEoyAFR6nz+RP8H2V8yI/Q+Zm2yAzzMqty/UPz50UUr/Khxuq/VUi+mOmrKvu2UEOfNihLcpAg0PcPzLrU0Das79j5m9z0Im4F9jrYyUYAMoshzubkABXuy23RqBU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSNvxMqb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716371012; x=1747907012;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mjMI5jn7GDB1KOVdd12Y1631VJlZG67v4e1IULzb7Hs=;
  b=dSNvxMqbfioH3vLMNoofVuSQ1+OqY2iI5Ns0Vu3NMXAyJJO+zk1/79Dg
   Y0MrMHX7D/LHvLML8dRcz4QsG4SFnXPSn34X3BX/jEBkNvPPGyyVed2u4
   9vMeC4cgOodk18EDaEGLGy89RZCED/K1SSlXucpmH6KoOiFZxg99ki0kj
   3Gegi+8f/dOqVGeoENdO1mQGPyTmRzqNnb3wM5WrSEzmmBzdaiZGSLkfH
   LtT7Ry1eTWxUnT4biYq7vqo8+B6vQcTbCf9sdZPSVmcucMdiuLpJ2Jaeg
   BzU4YXUiePJyNVvayWhpTB5pu8ZFg+CIexneQMSbLPLqlM6gcIw9G9Uvg
   g==;
X-CSE-ConnectionGUID: xoTbUi6bTDKl8ztYpLg8mg==
X-CSE-MsgGUID: H+XFxmqMTHaWmpPGoShGIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12728099"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12728099"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 02:43:31 -0700
X-CSE-ConnectionGUID: iHs1xWFuStKABTrq10synQ==
X-CSE-MsgGUID: zcFovMXvTq2IQ/WHrvl6/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33284685"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.230])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 02:43:29 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Lucas De
 Marchi <lucas.demarchi@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 1/2] drm/i915/pciids: switch to xe driver style PCI ID
 macros
In-Reply-To: <87y184sm72.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240515165651.1230465-1-jani.nikula@intel.com>
 <87y184sm72.fsf@intel.com>
Date: Wed, 22 May 2024 12:43:26 +0300
Message-ID: <87ed9uqj0h.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 20 May 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> On Wed, 15 May 2024, Jani Nikula <jani.nikula@intel.com> wrote:
>> The PCI ID macros in xe_pciids.h allow passing in the macro to operate
>> on each PCI ID, making it more flexible. Convert i915_pciids.h to the
>> same pattern.
>>
>> INTEL_IVB_Q_IDS() for Quanta transcode remains a special case, and
>> unconditionally uses INTEL_QUANTA_VGA_DEVICE().
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>
> Bjorn, since I asked for acks on the last ones, I probably should here
> too. :)
>
> I'm hoping to stop mucking with the macros after this.

Okay, well, I pushed this to drm-intel-next, since this doesn't really
change x86 functionally, and you weren't all that interested the last
time. Hope it's fine. :)

BR,
Jani.


-- 
Jani Nikula, Intel


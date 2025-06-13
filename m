Return-Path: <linux-pci+bounces-29654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7152FAD860A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 10:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB53B7EAA
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247D279DBC;
	Fri, 13 Jun 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAYWQDjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCB279DA6;
	Fri, 13 Jun 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804701; cv=none; b=ptMl7qygjDzTXBFYMD2NeLYUcGyKxaOvB8T/wmjeZxDoGDGPBNVzjTmwenaA3+JdFqIRoZeKtMJAc3sWihLT5QCkWulq8ptieQI27Y9uTUQRdh4z7cOh0RupdFsktAgQ4Ip/IyGK6EX0SAoJsOX8+/BmG86t0ERx6JGnQnnb/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804701; c=relaxed/simple;
	bh=4dvU2gjTBAobluxvnHDFcItktqR+5ChasN0aGjgKaKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TF+CL1X33sxw0VqtEuxr3jb9iDssc9X7A3EbESabllYS5bQypE7xtvrP24WRopbaODEJsnEitLuRSOADTb6xhjheuJ5PqfcRLTFF2NFwhhfBsRcfAtQhb6sU/Xl3UrBDR0Oi9rk601w22W+jpBT3WcnxDQYE78zs3mn4Qq2qOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAYWQDjD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749804698; x=1781340698;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4dvU2gjTBAobluxvnHDFcItktqR+5ChasN0aGjgKaKI=;
  b=bAYWQDjDkqgi8W41nfXsD1GhZHc4vEcptHrcwRhlbYzs7p38uM/FRHY9
   QI07SMAxI1j8YzAT+3A3xox4j6T5WDx5/kCRLw/4dvrB7gCYsUrcPGeUM
   5Or/jMlTJwCF9tVnwbSHcrTt0AljSpxDJLPrZMoMV5Ca26pjAG/R/Fn/k
   kVm5Zzh+lhEWkw/4s1/v1bmFadgHTs+qEplVvRsPzDVnphKTVWxulJOLY
   CvwJSb1IjkEXK8Tlx3lXlNqBNVMtTilFT/z1CPBfL5uJlk5FjJUrlE1bo
   7edJ/NKsfKL8WTu2ls85/a+WJfSnuVj9IHa/k2TntcNrGzpGMC1k43DNP
   Q==;
X-CSE-ConnectionGUID: o9pnfUYGRrqHAutgH0cHwA==
X-CSE-MsgGUID: HMom63YgR4GFn4jvLO1IUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="74547609"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="74547609"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 01:51:37 -0700
X-CSE-ConnectionGUID: agVmFPqcQfiQWHXPtV8Rmw==
X-CSE-MsgGUID: gWFTP0HTRC2RODcDIuxKFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="147619241"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.26])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 01:51:19 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Shreeya Patel
 <shreeya.patel@collabora.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Qin
 Jian <qinjian@cqplus1.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Tvrtko Ursulin
 <tursulin@igalia.com>
Subject: Re: [PATCH 01/20] bitfield: introduce HWORD_UPDATE bitfield macros
In-Reply-To: <20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
 <20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
Date: Fri, 13 Jun 2025 11:51:15 +0300
Message-ID: <5493fd6017de3f393f632125fad95945d1c4294c@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 12 Jun 2025, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> Hardware of various vendors, but very notably Rockchip, often uses
> 32-bit registers where the upper 16-bit half of the register is a
> write-enable mask for the lower half.
>
> This type of hardware setup allows for more granular concurrent register
> write access.
>
> Over the years, many drivers have hand-rolled their own version of this
> macro, usually without any checks, often called something like
> HIWORD_UPDATE or FIELD_PREP_HIWORD, commonly with slightly different
> semantics between them.
>
> Clearly there is a demand for such a macro, and thus the demand should
> be satisfied in a common header file.
>
> Add two macros: HWORD_UPDATE, and HWORD_UPDATE_CONST. The latter is a
> version that can be used in initializers, like FIELD_PREP_CONST. The
> macro names are chosen to not clash with any potential other macros that
> drivers may already have implemented themselves, while retaining a
> familiar name.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  include/linux/bitfield.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 6d9a53db54b66c0833973c880444bd289d9667b1..b90d88db7405f95b78cdd6f3426263086bab5aa6 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -8,6 +8,7 @@
>  #define _LINUX_BITFIELD_H
>  
>  #include <linux/build_bug.h>
> +#include <linux/limits.h>
>  #include <linux/typecheck.h>
>  #include <asm/byteorder.h>
>  
> @@ -142,6 +143,52 @@
>  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
>  	)
>  
> +/**
> + * HWORD_UPDATE() - prepare a bitfield element with a mask in the upper half
> + * @_mask: shifted mask defining the field's length and position
> + * @_val:  value to put in the field
> + *
> + * HWORD_UPDATE() masks and shifts up the value, as well as bitwise ORs the
> + * result with the mask shifted up by 16.
> + *
> + * This is useful for a common design of hardware registers where the upper
> + * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
> + * register, a bit in the lower half is only updated if the corresponding bit
> + * in the upper half is high.
> + */
> +#define HWORD_UPDATE(_mask, _val)					 \
> +	({								 \
> +		__BF_FIELD_CHECK(_mask, ((u16) 0U), _val,		 \
> +				 "HWORD_UPDATE: ");			 \
> +		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask)) | \
> +		((_mask) << 16);					 \
> +	})

i915 uses something like this for a few registers too, with the name
_MASKED_FIELD(). I think we could use it.

I do think this is clearly an extension of FIELD_PREP(), though, and
should be be named similarly, instead of the completely deviating
HWORD_UPDATE().

Also, we recently got GENMASK() versions with sizes, GENMASK_U16()
etc. so I find it inconsistent to denote size here with HWORD.

FIELD_PREP_MASKED_U16? MASKED_FIELD_PREP_U16? Something along those
lines?

And perhaps that (and more potential users) could persuade Jakub that
this is not that weird after all?


BR,
Jani.




> +
> +/**
> + * HWORD_UPDATE_CONST() - prepare a constant bitfield element with a mask in
> + *                        the upper half
> + * @_mask: shifted mask defining the field's length and position
> + * @_val:  value to put in the field
> + *
> + * HWORD_UPDATE_CONST() masks and shifts up the value, as well as bitwise ORs
> + * the result with the mask shifted up by 16.
> + *
> + * This is useful for a common design of hardware registers where the upper
> + * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
> + * register, a bit in the lower half is only updated if the corresponding bit
> + * in the upper half is high.
> + *
> + * Unlike HWORD_UPDATE(), this is a constant expression and can therefore
> + * be used in initializers. Error checking is less comfortable for this
> + * version.
> + */
> +#define HWORD_UPDATE_CONST(_mask, _val)					  \
> +	(								  \
> +		FIELD_PREP_CONST(_mask, _val) |				  \
> +		(BUILD_BUG_ON_ZERO(const_true((u64) (_mask) > U16_MAX)) + \
> +		 ((_mask) << 16))					  \
> +	)
> +
>  /**
>   * FIELD_GET() - extract a bitfield element
>   * @_mask: shifted mask defining the field's length and position

-- 
Jani Nikula, Intel


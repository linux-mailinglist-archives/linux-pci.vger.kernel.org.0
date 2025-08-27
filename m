Return-Path: <linux-pci+bounces-34814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D43B37684
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671272A5406
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1C1DE8AF;
	Wed, 27 Aug 2025 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsUQePlI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130FE19DF6A;
	Wed, 27 Aug 2025 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256971; cv=none; b=FebVH28fgykKSxRLShy6zN7MVj5PzXx0C/0FdyIRfaI6FjQtVIIRpc9pmEHRa/ymFeEaGJCnJz0vb76/szkChS5sIx0cQxiio5MJteO5m7+RtzWSoQTVMkVUjHnUmoBb6XXtuw1TfUK8c175A46Zf3tzzIunv87I14YB87S65EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256971; c=relaxed/simple;
	bh=niYjYnyBVkUaS+VEAYBdmWbeRY8+WA3IC2YXvYSH4F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ3tervChRrYp/yh7k0LtAw1O9xMzX0bF/YhueFQjRnB6Xb+zTPze9DzCHt85FSumrYlC9VDH3aN6/bfW5xF3mhvK1bTSpRznICAfMx0PEn+0AjQEyjjPiEwx+2EYPItAYS8Cwegr51uD/IfDEDBz/E8QPwXZmvUe4SCQK/TUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsUQePlI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47175d02dcso5201166a12.3;
        Tue, 26 Aug 2025 18:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756256969; x=1756861769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYru9aDq9lQqkQVO+bwcYPZ+KioVEL3wdcshlzZLQl8=;
        b=bsUQePlIR9gg1Gpp62JnbKgmkkcgGtENrHiZIBRaQtpx5xT2YMTjWBMDQtbWQ8kDLc
         b8JCTzGwMYIV97NMwIS7ZhcRrH905hGbLyOTmS/hklPke48UDyovYrBosBxP7RKjotWS
         OWNR/GEHXqiHW3ZlkphVknYKwo5ybqv6BbBDVexSYPeDU0u/E1rI/+Hm2L4aPHSyxj05
         nyTiLRWnl+b6gUFY+l0G1peE+sgwI9VC55zWXNFNTnInW8/OTnHV8k+BFwSdtIOVSIL4
         REn7RADiOe8izY/byKUHpvCehYgOkiGJ9NKZWR0gTGqIidEjRmbO2R7estr4f/IH7jEz
         JjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756256969; x=1756861769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYru9aDq9lQqkQVO+bwcYPZ+KioVEL3wdcshlzZLQl8=;
        b=EBhdnr3Dx3N7EICrbEtw4gJov/TdwzuV262krBLjbGNPI9mKBn+81meMtel7gxakpT
         D5VHhXqY+UnsjIIeyUHmL0yJtuV81grLABUqy310bfPhdhI3IUvcR6K9PE/aOllpoBDl
         sNcprCmGjwJ5D93/DYfmDwOb/UWYIXAQ0IZNWqrhY7LNvkUzMY2UUNcPJ0ruUADw1+u8
         5ew/gT7WmXEGJeaxPnFA04RTaO8eXmiGiu3IwOmtDxqr8YjwtNYmHno56bmB/WdEP+Bm
         y1/mleNAklbnmkPwMTxtvTbS+u8AZc0PurpjqqLUbXKmkAhZf6k4y8SRxGEimH+q+uh5
         55CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsmc17LoziqMqd9H8/ThRpxSngnfjHjtUBfnCaFMne2CB6oMrSfUOoOOCnI+DukjddlJhKgAOE/Mg+@vger.kernel.org, AJvYcCW23glR1QVyERMWhSAOL12IkjbRCs/fs/TnP1kLfOAmVU1FCuMxj9upFtsjA0CNei72iUiaAPwBHeEweM4=@vger.kernel.org, AJvYcCWF2waGmpaDezBmhyvs7VyPvpHJTWFqxFos0Va/ld12Jn9x3Qkt6L3u90dLlgurJG3Cc2g4j1Sw@vger.kernel.org, AJvYcCWL9D+fqsDscAtsBgA2uRGzjUDdiQ/GAZr8AQ9uWCcwPfbKF9t0SeqOeTpiQXLQCk5GlGCUVEov4Z5jt6nt@vger.kernel.org, AJvYcCWjIcbzBdYTYvIUWgEsDKJQm5q7mVOManBSYPp5kpl6gdazyV3ad1ArcYwucFh0GNuVxrV723Zthos=@vger.kernel.org, AJvYcCX2sb8jGWTBWzxEaglGy6bVhe7r9jG2Bqik+BgIgi+VnHZrRgqjq9bG5ChwqYWEPqHjqG5W+ppwFPmOrFk=@vger.kernel.org, AJvYcCXBJm92BPicg/VlMgCulS9C4ejjeY6xuEI8lZ0VQ6uj6/rdFAGoVKQtgVqgL/UtGDb4w4nV1MWJrBtr@vger.kernel.org, AJvYcCXRzQTnR6pJ6EVa7BhYGt3rPHFP1L+lLeCVZOiJwSpSkKslnD0EKFYLgzDf3rHgsUb9yKKJb1JOe8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3mqJD1yACJW6SB+1ncL7fhqjzv/ry/tqy8msdOr3dqZn6Wmu
	cT7urGvuEEAQ1q06ErHktf55zTAq0v6RLXci0D6JNCSwO/H85PB2o2aI
X-Gm-Gg: ASbGnctKLv9wLp3PFtNM320SFCxshcdoorOi1/5+boAEOMrH2Ll/DAa2tJ1kZzFfP5M
	IM2DPA+p7BL/I8LajBj5g1okOI7XQE2CwuxWUuKtLNDFv2XL4G/gC2rJuTraAxMBB25P1pTF4qE
	XRJJi0lG4GS/b6xIH8XoHCjGbOIc2ZI6K2Mnmvn/B61+QKhE50jNGR4exJJWnxKyYj1Z21FWepv
	P3xTnNsH7PfKGc+vzLhFEGVm37BUC4ZFxoJYnLPLaFGa0pysQ6JcRxLJ5jQGD34m2uEofBb3Q0b
	m9H8XYhOjTLyT7BUBp4pkgBVOcGSuuoBLncS7BYWnutivzFIlxBg10oj5ZKIEx6WBf93CnGRMqf
	eC8sKwjyH4qLcOw3pky74sjLjvPNivQZ5
X-Google-Smtp-Source: AGHT+IHkfsVuZ+4qDUB9kGWXKNs3ixhtdzwAG20w+Ik2IkMK7IqkqBUunACMn5yLzf65+cgJRTumCw==
X-Received: by 2002:a05:6a20:7286:b0:240:d7a:9591 with SMTP id adf61e73a8af0-24340d1c50amr25873828637.46.1756256969084;
        Tue, 26 Aug 2025 18:09:29 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm6847632a12.35.2025.08.26.18.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:09:28 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:09:26 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Qin Jian <qinjian@cqplus1.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	llvm@lists.linux.dev,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v3 00/20] BYEWORD_UPDATE: unifying (most) HIWORD_UPDATE
 macros
Message-ID: <aK5aujavDc4PvvjO@yury>
References: <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-byeword-update-v3-0-947b841cdb29@collabora.com>

Hi Nicolas,

Thanks for the work!

On Mon, Aug 25, 2025 at 10:28:20AM +0200, Nicolas Frattaroli wrote:
> This series was spawned by [1], where I was asked to move every instance
> of HIWORD_UPDATE et al that I could find to a common macro in the same
> series that I am introducing said common macro.
> 
> The first patch of the series introduces a new header file,
> hw_bitfield.h, which contains two new macros: FIELD_PREP_WM16 and
> FIELD_PREP_WM16_CONST. The latter can be used in initializers.
> 
> I've cheekily added the hw_bitfield.h header to the BITMAP API section
> of the MAINTAINERS file.
> 
> This macro definition checks that the mask fits, and that the value fits
> in the mask. Like FIELD_PREP, it also shifts the value up to the mask,
> so turning off a bit does not require using the mask as a value. Masks
> are also required to be contiguous, like with FIELD_PREP.
> 
> For each definition of such a macro, the driver(s) that used it were
> evaluated for three different treatments:
>  - full conversion to the new macro, for cases where replacing the
>    implementation of the old macro wouldn't have worked, or where the
>    conversion was trivial. These are the most complex patches in this
>    series, as they sometimes have to pull apart definitions of masks
>    and values due to the new semantics, which require a contiguous
>    mask and shift the value for us.
>  - replacing the implementation of the old macro with an instance of the
>    new macro, done where I felt it made the patch much easier to review
>    because I didn't want to drop a big diff on people.
>  - skipping conversion entirely, usually because the mask is
>    non-constant and it's not trivial to make it constant. Sometimes an
>    added complication is that said non-constant mask is either used in a
>    path where runtime overhead may not be desirable, or in an
>    initializer.
> 
> Left out of conversion:
>  - drivers/mmc/host/sdhci-of-arasan.c: mask is non-constant.

+ Michal Simek <michal.simek@amd.com>

>  - drivers/phy/rockchip/phy-rockchip-inno-csidphy.c: mask is
>    non-constant likely by way of runtime pointer dereferencing, even if
>    struct and members are made const.

+ Vinod Koul <vkoul@kernel.org> (already in the list)

>  - drivers/clk/rockchip/clk.h: way too many clock drivers use non-const
>    masks in the context of an initializer.

+ Heiko Stuebner <heiko@sntech.de> (already in the list)

Guys, can you please take a look? Would be nice to finish the
consolidation.

--

I'll take #1 and the acknowledged (or at least reviewed) per-driver
fixes in bitmap-for-next in 2-3 weeks before the end of cycle.
Everyone, please send your tags!

Nicolas, please ping me if I forget. For the rest of the series, in
case of no feedback from maintainers, let's wait for one more merge
window, and then move everything altogether.

Thanks,
Yury


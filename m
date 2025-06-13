Return-Path: <linux-pci+bounces-29735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D63AD9038
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EBB3B9F4A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975C1E1DE7;
	Fri, 13 Jun 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTTUQp+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889C1E1C36;
	Fri, 13 Jun 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826354; cv=none; b=utXtxWPwl+pA7seKB+r/M0H+x5P6s80mz+3EWg2itqs05dOOjPkDsPy8J7VBsNfyXzmyVms8JYNT9+rFITQrK60Q+C76e0U/fTNeYldpKUIWgKRqTPm9m6nT6ZIE2HsTPFq3iN/yBNJMjwwis7UeqoHYHiku5r6ItwWTVjX/8jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826354; c=relaxed/simple;
	bh=Q9XbAxGbPKwPgpFGLC6BiXPwoGl54z+or5xHNF9dw1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfhmBGT4bOEJ1v8jyEbBNGa0Gljnagkz/+5vOJtDQ7FXY8mgb+Tmy83Z3oyrZ4vgG/ObZ9Js2K+iivCiiZzmPuo7oZaBKIfdZ8TzZObZjVW8A+XEtBV9CYzuYTNw4ye255x8yre8lBYTOedPg8/4CHkQZ+L+tghct5TSdgZThoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTTUQp+6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747e41d5469so2466237b3a.3;
        Fri, 13 Jun 2025 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826351; x=1750431151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nX9ttAjMiBk5GnAWKnbFZ+j4zoLGHNZodgimLxzGDTU=;
        b=jTTUQp+606vG66KHI3WiyWpDzIKpz4cu8AalziZ9DIgPy62Z+j0Z5rVci7SRKLTcYI
         jyrbrrQP1bjNVn42hF3vs/m7mAICQHem0mNhZqOlcnzfjDtveUrOyNmxI4GNCHq52J+j
         0ikQkJYDo02yuw+dk0JsAkLTi20u6t+Va31GnhvmTiMIfZXipLNiFpzRew3mw0ehZE9G
         63pAoFi+gZK26Zei/lNRdoFrsZd6Jfb8H8on1mDC0ZJkCK2RXzr5obujM2LOIDHpeINF
         NanblWJSmCkJa+f32qNjwWLAiCElfup8IWRg2BWq8fpI4a0Qr/RlNrXRiP/xyMCvWc09
         Ee9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826351; x=1750431151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX9ttAjMiBk5GnAWKnbFZ+j4zoLGHNZodgimLxzGDTU=;
        b=O7BCRCsiYhgC7VNVf4LFxnV/UxO2sPiAigUQQGXFiEeWKNU3RrQbU2PzjJjBVC7x3H
         KFP5Oac1XsQQmBJQkS7r2dAMeh0ZeyMzwVaXdBrWJpx+qXIzjHzJZ25OngYL6Jv1qTa0
         vje77lBE9L+B6+WBSeKDkrVdQ1UXPzuuNL2MgzdqtF8uuv9/9WiTHxOx1NFN7etE63oZ
         O9nFGUresRPM9rMid8MI4CXZC0q8GLWAS9CuQWUmwSRG49KXr/ebtVFh+GQr0/wA2Swq
         1swxhdk8xLM3Zow3AIhPpdBqJhBK0Dmg8vpniSwnuvJPQLBCIi20brmwsZ7U0sKZuV1h
         aBcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsCc7DzKC1nKkjSKYs7ZdnLcAkqd6W47+wbseeap+mFLnHuV3/3bD5aJRVmZhnWG2wiqK5p7JMadQ=@vger.kernel.org, AJvYcCVNCyEy28Aw9FLa7Hia0xgpOk1lA1XntjW4785s4RtWImWTGxQtyZqir+VbELNRUjdqxFuKr80LlFd3@vger.kernel.org, AJvYcCVYo8FsTp8kGdqb5W0+S8SXZJvNmr4HrSxFOcFQxjryUrbLyNi9lO5fHkKO+QMuGe6Wa4kWvU1wnmwn@vger.kernel.org, AJvYcCVuT5Bx0W7fsYRU1U/hPP5AXLLTxDxR4kxpoy/n0qLjnZKUnL9W0RZHt5+bt9TpTQWFTKdsTbfOn87iJ2I=@vger.kernel.org, AJvYcCWvfNgaC4PWZ6eVk9nrM/lkoL7Y5FZS2SR6RiiGvPCZy5NE9qMxXaTA3Qdt8gH85+ZHun4OSq9W5Mg=@vger.kernel.org, AJvYcCXt+A2K8knd/buRanBtUQUoam5V0IHVhbfPUJ8baLxE7EJvtImPl908e8W6J0RD4l/WI1bJNx8J@vger.kernel.org, AJvYcCXtdHQlmzl6Ec/HymgCw7Y1C+29HyML40DdWdR32pbaZWXtfJfPIjkc5lsGtcpYp4Rqp2RqZfHEddsNWkk=@vger.kernel.org, AJvYcCXulk7a9ihm4yAYO37oHuhwjQZwJd/SVi9JpnWWeyKj9/KuWQNXch3+1jBM+8W+tx+1YVCdcxukIH8I/vv/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxql/qfGHfWb+kFlPhgA9E+VWjlK5Kf6MUGrTk9xQ2KSWgMol2X
	5lVkaiFBNH1EvzFGA4bU1VkRI4RORg+Mj/3LwYAxMFx7KixqlxrZzpUB
X-Gm-Gg: ASbGncu2Rg6sNhV5rMMzPlA+URr/WXHKsMGC7vgsj4XQ1S2NBYqVjZNiKhakG42M/hm
	0JMNHz+Soinc13zl5csCcXy3SEPwcOtz/GpKyGLio+q8W58REKTPE7Cw9dDiTB/LMvSP/uURDAA
	wix6GCq3Up1a2p0wDr3nXi9KbsXWi72u64y2MpOO0TXP4TqKpeeLvDRQMZ7hpzueka5ase6gkVg
	mCxVVKsUO1aJFB0gdNgulQe8prhKdgssy6OBca/ky+RhN8nNnPO0zwKqRJ4ZFXXdBRwYyPhibWz
	jWjMe2rUy0M7cW7Aq9QSvEcggwDA9QxCQtsQcA+SzMz9UDxjGN0FVor+FjhqpQ==
X-Google-Smtp-Source: AGHT+IGmduwXbHVfGIDlskqKLcCBNDCHGWRFnOFCbxfY7iXbpVq03NTOlkVGcUndD/CI3gBb8mRMVQ==
X-Received: by 2002:a05:6a00:2d8d:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-7488f7e38f1mr4843190b3a.20.1749826350828;
        Fri, 13 Jun 2025 07:52:30 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900cbf58sm1723692b3a.148.2025.06.13.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:52:30 -0700 (PDT)
Date: Fri, 13 Jun 2025 10:52:28 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
	Justin Stitt <justinstitt@google.com>, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org, llvm@lists.linux.dev,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 01/20] bitfield: introduce HWORD_UPDATE bitfield macros
Message-ID: <aEw7LBpmkfOqZgf1@yury>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
 <20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
 <1437fe89-341b-4b57-b1fa-a0395081e941@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437fe89-341b-4b57-b1fa-a0395081e941@arm.com>

On Fri, Jun 13, 2025 at 02:54:50PM +0100, Robin Murphy wrote:
> On 2025-06-12 7:56 pm, Nicolas Frattaroli wrote:
> > Hardware of various vendors, but very notably Rockchip, often uses
> > 32-bit registers where the upper 16-bit half of the register is a
> > write-enable mask for the lower half.
> > 
> > This type of hardware setup allows for more granular concurrent register
> > write access.
> > 
> > Over the years, many drivers have hand-rolled their own version of this
> > macro, usually without any checks, often called something like
> > HIWORD_UPDATE or FIELD_PREP_HIWORD, commonly with slightly different
> > semantics between them.
> > 
> > Clearly there is a demand for such a macro, and thus the demand should
> > be satisfied in a common header file.
> > 
> > Add two macros: HWORD_UPDATE, and HWORD_UPDATE_CONST. The latter is a
> > version that can be used in initializers, like FIELD_PREP_CONST. The
> > macro names are chosen to not clash with any potential other macros that
> > drivers may already have implemented themselves, while retaining a
> > familiar name.
> 
> Nit: while from one angle it indeed looks similar, from another it's even
> more opaque and less meaningful than what we have already. Personally I
> cannot help but see "hword" as "halfword", so logically if we want 32+32-bit
> or 8+8-bit variants in future those would be WORD_UPDATE() and
> BYTE_UPDATE(), right? ;)
> 
> It's also confounded by "update" not actually having any obvious meaning at
> this level without all the implicit usage context. FWIW my suggestion would
> be FIELD_PREP_WM_U16, such that the reader instantly sees "FIELD_PREP with
> some additional semantics", even if they then need to glance at the
> kerneldoc for clarification that WM stands for writemask (or maybe WE for
> write-enable if people prefer). Plus it then leaves room to easily support
> different sizes (and potentially even bonkers upside-down Ux_WM variants?!)
> without any bother if we need to.

I like the idea. Maybe even shorter: FIELD_PREP_WM16()?


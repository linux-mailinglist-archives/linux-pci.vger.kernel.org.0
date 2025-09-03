Return-Path: <linux-pci+bounces-35343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82098B41159
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 02:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCEF3AD9B5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65321991D4;
	Wed,  3 Sep 2025 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huDgh31A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5ED28373;
	Wed,  3 Sep 2025 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756859435; cv=none; b=NAcSYDWYYrBHQ9xWhiDCdRGFv4PXJDPW1lH7ZuQmScEHUny92iEOz9BXlije2Ca31OdS4cxCxB2JMSvt5SWeAsnamhs0DDfRj9TldSxDvA+JRwElJ3OjY7u0GLe4nM1g3CEnDUNq5pHTXn7gH/Su+qIk3udA/C2YDj25Wr+NtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756859435; c=relaxed/simple;
	bh=kN1SVeqqtF7jjk4r9ClxSGmVc8Agt/K+EhDBYCzp8ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPlk6NapYMJq3O7apg4stnRVrfr6KKp+uC+P1kRMPWGrcLtoM5uSUVQgvHfRlEs/zGZIDe00Crk7Vu3w+3HH84ALmuYp0iTD8RSaEIMoGLs79uaZHLbIUjLt6UZDzNUv7scdjdvgbZdqLxbQtYIq+zyEaBPb5ENbtJGtxL0/2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huDgh31A; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso4666374a91.1;
        Tue, 02 Sep 2025 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756859433; x=1757464233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmMfbXYYghLau518ZkBS9EQ6iyJ6tyWuJVdbkNRuMJc=;
        b=huDgh31ARc1zjpSuTcEszPnxeXc9AKySu7L3CPRypwhJEev3uHHu7Hb1AK6NHj8gfL
         7mzaLEfytoYC2fIviYqLghGXeocHw76lP87de955rZtFfsxFQrR2flng/WQ1IHrliBgj
         ewXRPZi6ykEsBMrWA70vVO9vKCrRbE6tB6Rfr0V/wcv9E9PcgVglp67Synb9oxXPfbUb
         YPW+T/3vG5jkJZvGfAXCLQtBJJiixKdO3jAPPms7rgB/tuZc0mNXHnGaCzihwRPHalmR
         Wkj5VKRSlynicZLkOB5qgc5aBxEH+YMiDCnKoMNg0dHHF+R7ucvrQfsGf6bBbrLN0XlC
         6K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756859433; x=1757464233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmMfbXYYghLau518ZkBS9EQ6iyJ6tyWuJVdbkNRuMJc=;
        b=BU7t0LHClP/WsMAMB9pbhGACljp/YKSVOPScDpvcxt1L4Os36d/cfYg22CAomO619i
         H+Do6t/Mm6Q48Nq2SbzbK+gdonLINpMst0gLtPQ1u5AUKtdjlA5Ojlo/0Hv1PR4NHhhx
         KSM1krpwkpYIcxQ0KwREMiCrMwkWTut46aoi8hOxawbnVNhjjmdRQvD8U9WQm1Ux2x3y
         SzOhwlAO/ttgkv/G+78XUHAiiicIOou3DNRmdxGbLh24j3w2C8I3hIPnmwIqwA17FH+0
         VGZP+34PnjZe7bCIu6zfv38fAFHaL9GNl2Pw7RZwNIRej9FGDdGI/YWW/N5HeLI0DQP+
         xqDA==
X-Forwarded-Encrypted: i=1; AJvYcCUv6l1kqGPlksG2tkehWP9dkkFZUviZgV0BWcDcKtBcYmh7RsqoZaK3Erkw5VMIk8UbnP0mVKTdVcZ5bSk=@vger.kernel.org, AJvYcCVNG3V8J2CTN34aF2nev3ast5xDbiEAVXDK9zubOfbrvxFuqbT+5XxxsiUGnQTgUDzEqRtWwVi8oNQ=@vger.kernel.org, AJvYcCVTVtczB6Xs4h0EyMVSUvVAJiZtsVJu+IuOdf6Y2nlEIfl351vsbchC3RnFKETlSCa+SaOQfYIwvlbg@vger.kernel.org, AJvYcCVUP8Cic2Bre0RPMp81MW67LXllXAaTwSiLhtjfbFNgZvt8N0NEmxZ9OR3QQW94jXB9uxOs+mitkQtDB9Y=@vger.kernel.org, AJvYcCW9CK4COPo9DltvCTXW02qDbZBKefFcB38uV94m2dQXULlUJiGQI1OXTptFSKhxOy7hEztLg0f9PaM=@vger.kernel.org, AJvYcCWOHkB5zUiSYmeTuH3J/0Ak+FtoCMFIXjuIVMGDvLjGSZvMcZRpoWJHO1vWSue6Dgzcp0S7AAJEaaR+mtSq@vger.kernel.org, AJvYcCWpgbVe+irAdm42j6Vue9kSqSLFoPIweQWPJeKCvVZMPKd2/YDAe4Y6Wv/p3EHt5G1OaA4Ziw9WIfZQ@vger.kernel.org, AJvYcCWu4OOz4PW+97vu7iIOeLOu9QnF2HtscNKDB74BH2N3uc9J5ceN0Nbu8dp7fZNd9HS/q8vOunCN@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjkPY7a0sto9YTi7clsatyWPbcV7ZBt5PXQST/oOk2aVHjEp3
	KnanfOuvnZSmQVvDmBV6Ac7ClwHAm7h7yM33hJj8e2yVTZlJPuR4SET6dO8brb/B
X-Gm-Gg: ASbGncuIUWbxNzUeV/rfC1wnjCJOr+9kYblifRaJxY47rmIvHmPQ8yNb3Er/iGDxn/9
	MNHSN8ErYvxDFJ4ux4R2MlDW1AO7mhg0LZSBQ03mpgpRQU7VQ4BHr5v+BBFpIqZS0QrXQikSpZ4
	ik8C371hzuHyHe3ts9jhMn1jXdgHf90zJjKTQGiMVthWUgg/xXqFWDbwdsv7ItFFLjbQGqPUpH6
	zOnH5Chi4kK8MJ+PdWEqRT61pVgj9Ur7KnhIoytGKWsW3Yh0m6+ugrCO17+k9mK+Wil02QM/n/M
	7FH7MsL7GVweIOH1H0lPtDMRCcnSzjSRoIDUmj/Zl20I8srdVzRxtahdm2wPS19jK8L6bk1AhZD
	o9H8VPBatWoyOpHkDqLsbkg==
X-Google-Smtp-Source: AGHT+IHKuGow4ZFuttu6aoYR+s2VkdzBbs1o2jEf8YSpdi38rlMbKdEgFtFxfdUZ56XgWRNUklItiw==
X-Received: by 2002:a17:90b:1b12:b0:323:7e80:8818 with SMTP id 98e67ed59e1d1-328156e5627mr18724374a91.37.1756859433210;
        Tue, 02 Sep 2025 17:30:33 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e23858ecsm3480217a91.14.2025.09.02.17.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 17:30:32 -0700 (PDT)
Date: Tue, 2 Sep 2025 20:30:30 -0400
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
Message-ID: <aLeMJjfhisYSIEph@yury>
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

Applied in bitmap-for-next for testing.

Thanks,
Yury


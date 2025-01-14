Return-Path: <linux-pci+bounces-19715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F0A10358
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E921886182
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 09:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C9240229;
	Tue, 14 Jan 2025 09:53:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3C22DC43;
	Tue, 14 Jan 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848432; cv=none; b=ZNJBFrztzboVDXqNEEi4gvOXReeJWyIZW/ECkbUOdLSXOCZ0arpKsYdn57gcSfAIaYtpH5Qpgn976jKkV8B8/yIW3V8jZ/IEvbLbJlWFtBP8JSIoBni35t3yHwMH01Y38WkaBQVpJnJFwz1V0Y72Ayb5QQWCFpxTfYUGp2jtWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848432; c=relaxed/simple;
	bh=QernjPqux5TLywytSMeNCq/y0tyjCAqIRMJpaKFr7ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUO9Nont2fFRSM2kiBuutlAPytfUvsdddZeesUpyFeNSvAYpcE4hTpcVqI/sCaQRE/ac6MkO0CJ2BMy4qomRBU3AEwwNia/iPgWzkINaAdV+Vv6jfwcLMQjeSlrfUHAcDFSzFn/ml+X1tzQkLhfXhCF4bZpstt7ofWNWhrs8z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso94481615ad.3;
        Tue, 14 Jan 2025 01:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736848430; x=1737453230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSeUkptft34AkNx4jU0RBWebPqQDxIe1uPszewCoC+U=;
        b=vUlXjZYtEv6gXEiFWS6OgZOXx1qYXiwxyAoRuEPbZOjyUteHfs15nkS2m9tL5YyKPB
         zEu39MBkr2Dfw+ZrQ+B0GgCOxHruwghyR3+z+AgfmZz1nmZJTwKS9+oLggj8pY6LksG+
         9DPWdLpOu0nUtdj8xFU2B9vK+2Z+adThBkNJ9SPTXq8owFuMucBMa6WZ8rqNRdBfpS9Z
         nBmXF7IF0CZNjfBbAbgLsAiqvwjSpl3AUOIQgwh9MN72Gs6bz2c/2/pDmMqDytV/9CX1
         N3NbnJbcWE/tyCOih8LbPY0iXJyFcldraX89N4k2PrEsIVThTt5CuAPCOM5m4L4KxywR
         GFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwCB4LfcoQLAsD5bNX1H4g+xOMAkIYLxufgsQy62hwBImu5AGcOF/QLFPTD4ll7cnhbLxVd3BV5vo=@vger.kernel.org, AJvYcCWEatJea49OV6aHBOmBHFn2POYDkJz5a1bXBvz/A+KzCi9XltmFeXRvCfvn+KFy2Ow7PU8jV5Kz0+Ppswk=@vger.kernel.org, AJvYcCXmMCY1M9aQnOBuJyR1oHHw8+lT3jsC36Hn/cyfEABRkAdPGRJZ/DmXinfB6x9tj661cTVm1BRa/CKe@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzAilkk1HM0Ca5LiakFzOkH8x3IRR3Wdjlh/jh8K7Q6+EZYOH
	R1yU/2IDa9YOKvdP+06AdpN5YagRYYQNEpArZb6Mq4Ee1lTTOlLm
X-Gm-Gg: ASbGncu+84a3oB3HQCtsBUxcWW7dFNZHWyjOlQEyK6M7mZrVxNBfgdyp2HsXcOVdxOg
	SFUY+hdCA6ZJZCsRcgFThv666gOr3GS9L5XBFtSE2a2e+oKr1GWThpa4ZeZM+hQVgRPaViMenaj
	6L8RekQCcg2r3J5zZBt5Ehrhaqn/B9nKNNIJIxsiyTGUuWCC0AZbWxGiV/VgL6qzcc2VWf/eISz
	fmQ/g6X3K6sD8Pa3Caqkmw8S9+4EYo69KeBIWo962IB8Dh1zBo6UQbESIIXFUs4GT6aM8yeJ89O
	iFu0gd5QshXSVNg=
X-Google-Smtp-Source: AGHT+IEcTQwpsnVXURxRYFuDX1xTBQOSvGJ+8G1/e7z3DcKHqB/DRr0X3DJGiJVousekFSPpJVY1Ww==
X-Received: by 2002:a05:6a00:9294:b0:72a:a7a4:9b21 with SMTP id d2e1a72fcca58-72d21f16046mr30678516b3a.5.1736848430124;
        Tue, 14 Jan 2025 01:53:50 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658d2bsm7274298b3a.107.2025.01.14.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 01:53:49 -0800 (PST)
Date: Tue, 14 Jan 2025 18:53:47 +0900
From: Krzysztof Wilczy??ski <kw@linux.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Niklas Schnelle <niks@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] PCI/portdrv: Disable bwctrl service if port is fixed
 at 2.5 GT/s
Message-ID: <20250114095347.GA953333@rocinante>
References: <20241213-fix_bwctrl_thunderbolt-v2-1-b52fef641dfc@kernel.org>
 <CAMuHMdVtpVTtUEX=hF+r+rt_awk=w8iYWHd5yzZYGUpKoyYcgA@mail.gmail.com>
 <0a053cef86001953b34fd199b551b96100fcca70.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a053cef86001953b34fd199b551b96100fcca70.camel@linux.ibm.com>

Hello,

[...]
> > This is now commit e50e27a613db6f18 ("PCI/portdrv: Disable bwctrl
> > service if port is fixed at 2.5 GT/s") in pci/next, which conflicts
> > with  commit 774c71c52aa48700 ("PCI/bwctrl: Enable only if more than
> > one speed is supported") in v6.13-rc4.
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> 
> Oh, that's not right, good catch. This patch is superseded by
> "PCI/bwctrl: Enable only if more than one speed is supported" and
> should be dropped.

Done.

> Sorry if that wasn't clear from the the limited context of this patch
> discussion. @Bjorn I think this needs to be taken care of by you?

No worries.  I removed it from our next branch and marked accordingly in
Patchwork.

	Krzysztof


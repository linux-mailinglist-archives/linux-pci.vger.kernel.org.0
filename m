Return-Path: <linux-pci+bounces-25127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2815BA78936
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E16C3B13E5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15123372B;
	Wed,  2 Apr 2025 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdWLfVed"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7D2F5A
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580463; cv=none; b=qW9CiodAjLAzPch8WiDKcNZS7L0zlVRawoeTbobNjKiaPKdwk+/TeqOesigF7fLIesp3+1ITYRKMthpgelkm2X0Egq2+XzxDf1mesv3ZGh2L/3z3AVyuSTaQEsXGxObQ59kBdnmS9vPd5c+EaJRgBNSroApuJ9h1xG/EYUYfpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580463; c=relaxed/simple;
	bh=Mb2EC/6/vHC3OJXU3HZj8yJyiLfSXeSJs6GJiHDSlr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc7g1ZenmKRiHlxtFJiK/cM+0sWrLd5bYCysRFl/IijjQgdldspuHfujmKKS2t5ReL++m5HavBWkGlWC8RR9bP8F9D9kPWrvKrQ1v4DKme+EaFa9+OGyj4wc8SRQTqcGrQSV8b1Uc3c9pZALyopRE0VJpSu8Cti5k7Dj7Lvr1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdWLfVed; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2260c915749so90086765ad.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743580462; x=1744185262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WCENuk9PQu4krAXVW7qdLepJ1A4XFH9uwEadY8jcBM4=;
        b=jdWLfVedl8Y4s3y4IsirDjJRsZNiYnG8q0SA3V8xbUArm/DyDzXnrNjxt+d6v8fO9Y
         m6xRiX72blFsrnPvezwqr2EfkNl1EtWXuHGAiCRquKWYatIlipdKFXyThSFz8c8mypBU
         L/xEWBeP2GgaFrMRgSbW9ancnr2Ad1e/3s75AFnkYPpzDpEkEdRMuR3v80ZYCH2klWAL
         i+gQnhX91awZAKkuS2cONMHYeqL4J6TTEvRuDsjI14kbFHfnMUGtjdGnvxlxuIBOc/Yk
         TREJjx3yoTegtX6pR3fkB+ZVCtYXx5PiWNiJAeGbI4p7734zpuHFgIyFhCZgTpmnBDEn
         mzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580462; x=1744185262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCENuk9PQu4krAXVW7qdLepJ1A4XFH9uwEadY8jcBM4=;
        b=rM25HK8eK8id1MEkyObnqvYsAXnKSdAVJDWIuYpFKW6FasaP4BnSYXQ+gNni2rYH2w
         aRmh8BGud6E/IQoJ5U1oGhvQ7Vd25GY0Af18pVndJXtiYWg8mef44KAXIL282eRbszIZ
         U4gux8NWb5QupjMmT1Khax9zKqoxGS/1S7OIJXYQLVb3PCNhqrl4LagO7d92/Npl7q8d
         1S2/3sSrj/y9Lgo2/BKTXDz/sDALyqduAs0aUmereyYUiosSDey5EPyLaokTfqrunayN
         7uiC1ZZY9iMvwgK9c9FDq6IukfRgakf+yDHbhQftKnvtS/UdosWPVXGgu1O85g00EPK7
         wV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCTbr4+bam6w6qt6mh3DIgsUS4RxYvyg8r8B++gPyJoBFJcUswFflS3fOtlFilsd40sBQs3mLwR2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6TUVCr+zskNnuWaP5J0JSggZSezhDstXOOU7seAA0Gnd9m+ro
	WknxFhpjveHzFD7RGDTinU18ovDVoUymZPB7Emf/JLVruhJSFXD08kQxtk1N6Q==
X-Gm-Gg: ASbGnctvpvnxfwMReB8i/UBlLRiuhqbZRcfl+uOGpysaGGLUbiha5pwLWJZNBYHPQOJ
	0sYHRmmtO7ubFtCRvOIw46uYpwEx5zZGUlcMQWD6dAzjlq79eAGsAtMuokLEGMig7kEQOcwcFpM
	BYiF+QM74K9IwHqdGLZs8zlmQ3pIsWkaJrLQHKj+1TgCRzPzO5RsWoIG9/JodQDgtDuI/I/wtQx
	5ED01rHdQg6iYOloXWkTGXXgLnDvcCPGuNvH72+l//OSZ+SvBI39+bYuSmrXRKcgcBe5DIKbQbI
	Yj4r37+jhcLfrl7m9I8B0lrlzYNXz2JuG1hRk7ejpAq3W4wz0dYbJa8W
X-Google-Smtp-Source: AGHT+IGge72TZJH1J2vvYo6DD9BNpDIh2f4O+A+Z8qHrboOP7InJqdVuoFxRjCNjgzZYii4VjHrbsw==
X-Received: by 2002:a17:903:2acc:b0:220:fb23:48df with SMTP id d9443c01a7336-2292f9d682emr277347625ad.36.1743580461725;
        Wed, 02 Apr 2025 00:54:21 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ce127sm101967895ad.108.2025.04.02.00.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:54:21 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:24:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jensen Huang <jensenhuang@friendlyarm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Anand Moon <linux.amoon@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Fix order of rockchip_pci_core_rsts
Message-ID: <lbar6fn3uhqeyg7apvggor7a4lqy22ozkid47quumuvfv7gz36@bny3kfhxvrq2>
References: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>

On Fri, Mar 28, 2025 at 06:58:22PM +0800, Jensen Huang wrote:
> The order of rockchip_pci_core_rsts follows the previous comments suggesting
> to avoid reordering. However, reset_control_bulk_deassert() applies resets in
> reverse, which may lead to the link downgrading to 2.5 GT/s.
> 

Oops! I failed to spot it...

> This patch restores the deassert order and comments for core_rsts, introduced in
> commit 58c6990c5ee7 ("PCI: rockchip: Improve the deassert sequence of four reset pins").
> 
> Tested on NanoPC-T4 with Samsung 970 Pro.
>

Thanks for the fix.

> Fixes: 18715931a5c0 ("PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function")
> Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-6732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179818B4560
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 11:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC95528266F
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704847F69;
	Sat, 27 Apr 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiY1MiDM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04D4654B
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714210430; cv=none; b=JjFq9FeDliHfAKRC98NgbltjppqP/qtEsr1qbPS9lSGyi79bi+1rSFKS/DTdNhnYtDufwcRNIml0E0wyKM+bTbNZP9NHiu2TRAJvBhE2sRjKCC77ObByRxId0eX8JfAZrXPb9S3QRuOm02pIWfXFh6sQkA9lyaPlV23GQtGVHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714210430; c=relaxed/simple;
	bh=Miw7hc5GB+267q55Huzr5s6mRn9tnVsaVR6HdF6ZL2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swC82qxlDHXl6//4Jy2hbwI8MYU02r67uHlMGXO4LvCcqUD6XtNVgH/xqDt5/ec/AwhnO4HSjC2hjg3rUEBBkll06b1S7zfnVRL+T2ICZj9NCiGUaSQyEdMK1FOf6s7WTvajJroDLsn0G1Rw7a9s8/9FajtE8FQQhLwzwUzixdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uiY1MiDM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3e84a302eso23069895ad.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714210428; x=1714815228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xcGWu0Qd+VKYUbfzlOh1vmNPNKKTWpUhtERS9P99/fA=;
        b=uiY1MiDMTVIBtvO59A932NYxcXD9uUSLbFDy8W42UVBUB+WFL78eIApWHFSn21NHm+
         dYb8tZBiE/+2CtgutTxJaE3jV5aAzJICsCqxft76ZGyKJWcs0w3HCyLXqd50iAkbQGY3
         JmhasSBU97Akn2pBbw2KWs0r9WEobCsb0zuCNNHQUQ6EZdhxzFzOfWjxrQl3mDQKKCYS
         81HOz0q0IcCVXw3q9tMYIP4cj7PDPdRWM87O35mZ+BC7/fR+DBbU+N3tY/rnVB7KKG9U
         Vk/d6Iiw+lPNj+UO0m4Hips3+ZK0uXBxW6toEkg0u8WyBX72sZ0Z/naxtzoLiHBhzjFb
         GIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714210428; x=1714815228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcGWu0Qd+VKYUbfzlOh1vmNPNKKTWpUhtERS9P99/fA=;
        b=hW/vROr6GB8khjejiVKLUiF0dicsbdJf/m975OXE2Ts+Zat682EpC7Hakhjow0Ew3M
         dmzi/AuPaMQAx+I2nudOq1LVpvSdqwatj2eJRDyUA4SYN/mZrwO2N5vFXD6csFpFjJpZ
         WJp+nGLlO6rXhVe9LO5iYQGrHdKXCiPtvuaK591gMk89yWTFH+YrgFBEQETFmTRwPXUM
         EyEpDUrKLXjrm+8CB9T7BLJoxBvLM4qfheC5Ux24KmRd47oLePIANhPCXYLvDHoohIuC
         5ZZPo/nmXF2GrKEctN+RpgZXP1zcACxutk8+hVmz29eov/jHjvNHD2Km5BhYyChRtd/L
         34Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWMNz0GZLaYYC4KSjKMx7oqMYI/xEdX+yrRF5RImvZP6+tpMQ6YXvi90Q9AgujfFlT1K23i/383evsC8rbcrSoZSzpiYXog0nw9
X-Gm-Message-State: AOJu0YxpfcXB27JB3e9GiLxjZFIwnY2zd7li77dsyoZKWGuEiqEaiM6r
	GSkGGWII69Tic8p5skqrTkOt3wgwVyqDz1HSIf+O4al5RXEHfgGkAFtZKYlCBg==
X-Google-Smtp-Source: AGHT+IHEgFcFYTWrCb8oOy/T7GvDZXiPS2vYVXc1VHEpHHfPR/Jn0v3TSW+ktgEofQzf5auO4mceIw==
X-Received: by 2002:a17:902:f78d:b0:1eb:527e:a8ad with SMTP id q13-20020a170902f78d00b001eb527ea8admr1948983pln.51.1714210427762;
        Sat, 27 Apr 2024 02:33:47 -0700 (PDT)
Received: from thinkpad ([117.213.97.210])
        by smtp.gmail.com with ESMTPSA id mq8-20020a170902fd4800b001e23fcdebe9sm16790001plb.98.2024.04.27.02.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:33:47 -0700 (PDT)
Date: Sat, 27 Apr 2024 15:03:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 05/11] MAINTAINERS: pci: imx: update imx6* to imx*
 since rename driver file
Message-ID: <20240427093336.GJ1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-5-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-5-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:41AM -0400, Frank Li wrote:
> Add me to imx pcie driver maintainer.
> Add mail list imx@lists.linux.dev.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

The driver name changing part should be dropped. But adding a co-maintainer,
warrants an ACK from previous maintainers.

- Mani

> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a692..59a409dd604d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16736,14 +16736,16 @@ F:	drivers/pci/controller/pci-host-generic.c
>  
>  PCI DRIVER FOR IMX6
>  M:	Richard Zhu <hongxing.zhu@nxp.com>
> +M:	Frank Li <Frank.Li@nxp.com>
>  M:	Lucas Stach <l.stach@pengutronix.de>
>  L:	linux-pci@vger.kernel.org
> +L:	imx@lists.linux.dev
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> -F:	drivers/pci/controller/dwc/*imx6*
> +F:	drivers/pci/controller/dwc/*imx*
>  
>  PCI DRIVER FOR INTEL IXP4XX
>  M:	Linus Walleij <linus.walleij@linaro.org>
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்


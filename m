Return-Path: <linux-pci+bounces-17220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C729D62D0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 18:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EC0B210CD
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFC21DF267;
	Fri, 22 Nov 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nk8/ZEKW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20377080C
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295629; cv=none; b=Quo9iDcZjdB5cVf6vswxNeY5cDoq8nzuHgLAQZ38k2sc8TP9OecAg4tqIsGdhd6uqfHmrzXkPisgz9+z3zlH2p1iZEq7Hr/398HL5630PkMEhn5S+EjWNBdMPpr90NrI96D6O7krBjNyiNv2GgW6idMeL3CPmQtzZfaIt/+Z0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295629; c=relaxed/simple;
	bh=9Utb13MynaifzSiCb+13ADGTdToHf99pkQJS+1gzmyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYSFlk4iz96iRQXBHnni/7x57ETQBGvEZnjaeq1eChr07mTwkvBt9VeXhA/yCnUI4gRHv9P6c4tXs8EGmv/8IPlift4Dq/9fjBE3WyBgb1HsznpRXSgb16exZw6T7Iv1EuhyWLobyPoxMgYjLTRl8t9rsZNJvaydEFULPP6+6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nk8/ZEKW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724ea6a8cfbso570605b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732295626; x=1732900426; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J3Ifp0rGPbm/e/7rhcYVsj05S6iHCWRwu0XzDIJa52Y=;
        b=nk8/ZEKW2PV3KjMJXctgOrzTlgaBZUgzJz3Bex6+Zg4TREgegX7hDHKGr90Y1mSOTq
         eySz0LamewHMbLT9WEoerK6BnyfPr7BbVv+wUIW8kv4WxprTnyf9XPfC98RkQwQJxu5n
         SW08zcnHCoKpUNLqU54xXPAEbi2UyodstPc12E5k6m3wNIbG37ve+Psgk5X2LJS0oLgS
         02YPD8Rswdf8+Q+ncJampQ3ceL0PHCwK7V3FhczW38z9sEP5JGPxjU/mB/p8wIWbvXG6
         yBZVtvd17n0MkUhFghg/MRvrO2A/MtkdyReAym5XpINNNpeVoF+SWq3CQ51BAxQxHQUL
         NarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295626; x=1732900426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Ifp0rGPbm/e/7rhcYVsj05S6iHCWRwu0XzDIJa52Y=;
        b=sdrYtBwAMZBCkWWSs0yAnfzbhGmx8qkj7uijgfAd9QhfjWKgLUg9WKDnjcL+p3aoD2
         NlYg4gYpm50FUFfGKyQLGB4+RutlONObYLPOFORECceDCwb+bVNcSdplSiGjXuSOJ7e0
         B9qLdeWyXsSZgUwudOyzSD0eMvUaY9xQcXzn+rgUaZnqKcjP1vCpaU5ZZl1voDo7nqgU
         +cBh/6PDAV1CcxC8IqloTbP7H+4OpRgP+dV4IvOc/PwJXGBwmYxV+gnk9O/K9ISixfT7
         A2QvQkpsdCUQEm/qXJIOCF75IK12Dc5LN9SpRCdDr7gWtTEmxhmM21vXkU4k08MBzL6x
         qH2A==
X-Forwarded-Encrypted: i=1; AJvYcCURvzodq2Z1Uh7ETFbxWk/X0xaVAm8GhW2+QpwJkAIAxEmdIlvE6BLvoQrgW8fGz5EZi+weMkNoNq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWc/P7Me9oYD8omgls3UrHzNJjs3M9TfJVXlVvp3pKIreCkyKk
	IAf1d1VIoRhw9vGqWKujTYTent/FE6Q8945RKl3LVu/zqYCXUWVQ9ezDthptKw==
X-Gm-Gg: ASbGnctWYhZYl4B/3KbgBaRpR0NUpXpE6unc61pUtjDGFrPqMBep1baInTdhR5+OkhE
	nSUcsP8kMjkaxR/SsZ97QViDgNbI9FBGdR1a/Qkai+KUwDmbn7/RjMKAra5tP0cq2bz3jF/O71t
	3Hr/EwOyB2NgOXPn4BeSZW28VDP81wswR6HqdnhdYvYs44EqYLJb8HDlkkXtd8EJ3nXYJQRzZkB
	xT5dvlA9UTQ40Lx/0b02cgQcFoJnVHnxxJhID2FVz9qvXEwaQmxpK4uyYgN
X-Google-Smtp-Source: AGHT+IFSLoW5PIBSR6LBkAITjbzrM29xeBOvFQPIeej5XJi4ofiDVZntpwn9iotOelT7YjAqhB/X7A==
X-Received: by 2002:a05:6a00:a8f:b0:724:62b3:58da with SMTP id d2e1a72fcca58-724df5de418mr4726297b3a.6.1732295626152;
        Fri, 22 Nov 2024 09:13:46 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e0fca304sm1684411b3a.175.2024.11.22.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:13:45 -0800 (PST)
Date: Fri, 22 Nov 2024 22:43:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe
Message-ID: <20241122171340.4uwlddrwadg3vyz4@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-11-hongxing.zhu@nxp.com>
 <20241115071605.qwy4hfqmrnaknokl@thinkpad>
 <ZzeE0lR8DGG214qq@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzeE0lR8DGG214qq@lizhi-Precision-Tower-5810>

On Fri, Nov 15, 2024 at 12:28:50PM -0500, Frank Li wrote:
> On Fri, Nov 15, 2024 at 12:46:05PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 01, 2024 at 03:06:10PM +0800, Richard Zhu wrote:
> > > Add ref clock for i.MX95 PCIe here, when the internal PLL is used as
> > > PCIe reference clock.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx95.dtsi | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > index 03661e76550f..5cb504b5f851 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > @@ -1473,6 +1473,14 @@ smmu: iommu@490d0000 {
> > >  			};
> > >  		};
> > >
> > > +		hsio_blk_ctl: syscon@4c0100c0 {
> > > +			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
> > > +			reg = <0x0 0x4c0100c0 0x0 0x4>;
> > > +			#clock-cells = <1>;
> > > +			clocks = <&dummy>;
> >
> > What does this 'dummy' clock do? Looks like it doesn't have a frequency at all.
> > Is bootloader updating it? But the name looks wierd.
> 
> dummy clock is not used for this instance, which needn't at all. Leave here
> just keep compatible with the other instance.
> 
> Some instance of "nxp,imx95-hsio-blk-ctl" required input clocks. but this
> one is not, so put dummy here.
> 

DT should describe the hardware and hardware cannot have dummy clock. If the IP
requires a clock, then pass relevant clock (even if it is a fixed-clock).

- Mani

-- 
மணிவண்ணன் சதாசிவம்


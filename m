Return-Path: <linux-pci+bounces-10721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AB93B1AF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 15:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D69B2142B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CCD157461;
	Wed, 24 Jul 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkhkLiFk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C3152511
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828057; cv=none; b=Z6xfpSEICCCOUW5xna2CfXYic8g+mCn+raa7fbaSASDWcIT9jE4Jbm+8B4GM36nWEJn9w+CJI9y5j8+93XlqE2zKnlfyKvwu63ZRsEGfuuZaFjqis6tWU2X0KX2XqcsTDzM45VFO70wHR29psHg5IaBx+X5z8+pf4OCnND2OEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828057; c=relaxed/simple;
	bh=SUUQmRZ2+Ng08hMBvnZsJP3Ew1XLswHadjWxmeWwjWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncpLZNXqE2ZYR56+5yJhVSV92TmsuqYJqbm8BuLZhqqYI75myxdS8kgXvwt4OvN86fvkkBt7C8rnu99Bk6pIyOBWsZL3zOizWgvFFjA6wgb2Plq0MNFEYPqS1UQzJc3MhhecONlwmSc+BaGmaQOLdzNDUplcavEziRcsmcvD1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YkhkLiFk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-664ccd158b0so66376337b3.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721828055; x=1722432855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUUQmRZ2+Ng08hMBvnZsJP3Ew1XLswHadjWxmeWwjWs=;
        b=YkhkLiFkglxrtd8Lmx21PKV/rcP6wKh53VIHtpU0yaxId+fU6WJqUfO67/EMvgo7HG
         Krd0LFY+lJ4AdOjJoWkdqNUjsM0MG7x879w7caufnS6g8rMqv2YDSJmNLDTgkCY5sonW
         AMd/VemA9AFYZ5xUSPr05EwiH89/3dLLX3VpP3o+BhIpiMFsd/YwIV2s+a0MinwAVWf4
         bAtrF4+KXNue2COTUnTIWY9d5+DIHWND6iHQizF41tpwaPP30zkASDkUIkr8SpY3VuLz
         QuInxLMR9tmxdtTT+rrkCfiCAmY3UXbr7vUCAoz2zFRGJCTIpYn4648tT7pFoA6dQJc2
         sXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721828055; x=1722432855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUUQmRZ2+Ng08hMBvnZsJP3Ew1XLswHadjWxmeWwjWs=;
        b=WDYqSk6ZcnN85Kq5B0Nl9SEaUeP5WIBfGY/BdzSK9vdOtXto0F/iTs2/LPuwzgHu/1
         lS15799pUADJZ2CeOxo1qXnryErQn+jiQbzrErOHs35rVBVskTisP0+VGR5MADv5W8fK
         s9ccf7yslUuw5FQZ06LZDFjCsuUfHFqo0UWydFFjk2BO/ymv9+YaSsjn7/Kk1WNqW+BT
         zW6LmFCMDDrqbKOU4XxU3qzXE+GHd25sIv5nbXBcnaru4tmSeQBkjA5XdL078FFm4u4o
         QqdhSf1b5obppeaS5UdiCWzdxwZB/s0vbqH3hzFdpAPc8jA4VI42LhgF+XNyUy/tyoHA
         AbXw==
X-Forwarded-Encrypted: i=1; AJvYcCWJqF4KNAubORW0HJR41M0R/dOdOyipSKt0N0cF+SPX50o5/rHVo6rFGW/2KAbnq2WO1IEt5/FJ6NI7m0FTU+NxwXLLB8by/ULR
X-Gm-Message-State: AOJu0YxxsRkxGd7SfA7zNp2IUKEOaAe3Dc1rEL2UpTcFaJyRFLBWM8La
	A4SBCHgiZiwQ75DEGsjrrNSQ0hdaVf8Or7X1j1wWwPx1v4VBGrPYXksPQAhbObkmgSEg75FOPt4
	Xqt/HCuqPyUssLPbMzeVQuw98scjmDt8/OT9Dgg==
X-Google-Smtp-Source: AGHT+IEmdGS3kWJwFOXkHdsFDbk48NhySqk+PBrvHOVCdWUgLmQZKnzxI3vscqlPqEO9OwfBwd6wWPGHC+h+ULfhzqQ=
X-Received: by 2002:a05:690c:fcb:b0:64a:7379:eb53 with SMTP id
 00721157ae682-6727d7bca25mr25623317b3.43.1721828054790; Wed, 24 Jul 2024
 06:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <rzf5jaxs2g4usnqzgvisiols2zlizcqr3pg4b63kxkoaekkjdf@rleudqbiur5m>
 <a87d4948-a9ce-473b-ae36-9f0c04c3041e@quicinc.com> <CAA8EJpq=rj-=JsYpPmwXiYkL=AALf-ZPQeq9drEoCkCAufLdig@mail.gmail.com>
 <20240724133139.GB3349@thinkpad>
In-Reply-To: <20240724133139.GB3349@thinkpad>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Jul 2024 16:34:03 +0300
Message-ID: <CAA8EJprSTfddwT1DxK7_B-bLbqWO7hTWKRfHnN5kxya6GbcmEA@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe
 host generic ECAM driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, will@kernel.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	cassel@kernel.org, yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com, 
	u.kleine-koenig@pengutronix.de, dlemoal@kernel.org, amishin@t-argos.ru, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, Frank.Li@nxp.com, 
	ilpo.jarvinen@linux.intel.com, vidyas@nvidia.com, 
	marek.vasut+renesas@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, quic_ramkri@quicinc.com, quic_nkela@quicinc.com, 
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com, 
	quic_nitegupt@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jul 2024 at 16:31, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Jul 24, 2024 at 10:12:17AM +0300, Dmitry Baryshkov wrote:
> > On Wed, 24 Jul 2024 at 06:58, Mayank Rana <quic_mrana@quicinc.com> wrot=
e:
> > >
> > >
> > >
> > > On 7/23/2024 7:13 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Jul 15, 2024 at 11:13:28AM GMT, Mayank Rana wrote:
> > > >> Based on previously received feedback, this patch series adds func=
tionalities
> > > >> with existing PCIe host generic ECAM driver (pci-host-generic.c) t=
o get PCIe
> > > >> host root complex functionality on Qualcomm SA8775P auto platform.
> > > >>
> > > >> Previously sent RFC patchset to have separate Qualcomm PCIe ECAM p=
latform driver:
> > > >> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@q=
uicinc.com/T/
> > > >>
> > > >> 1. Interface to allow requesting firmware to manage system resourc=
es and performing
> > > >> PCIe Link up (devicetree binding in terms of power domain and runt=
ime PM APIs is used in driver)
> > > >> 2. Performing D3 cold with system suspend and D0 with system resum=
e (usage of GenPD
> > > >> framework based power domain controls these operations)
> > > >> 3. SA8775P is using Synopsys Designware PCIe controller which supp=
orts MSI controller.
> > > >> This MSI functionality is used with PCIe host generic driver after=
 splitting existing MSI
> > > >> functionality from pcie-designware-host.c file into pcie-designwar=
e-msi.c file.
> > > >
> > > > Please excuse me my ignorance if this is described somewhere. Why a=
re
> > > > you using DWC-specific MSI handling instead of using GIC ITS?
> > > Due to usage of GIC v3 on SA8775p with Gunyah hypervisor, we have
> > > limitation of not supporting GIC ITS
> > > functionality. We considered other approach as usage of free SPIs (no=
t
> > > available, limitation in terms of mismatch between number of SPIs
> > > available with physical GIC vs hypervisor) and extended SPIs (not
> > > supported with GIC hardware). Hence we just left with DWC-specific MS=
I
> > > controller here for MSI functionality.
> >
> > ... or extend Gunyah to support GIC ITS. I'd say it is a significant
> > deficiency if one can not use GIC ITS on Gunyah platforms.
> >
>
> It if were possible, Qcom would've went with that. Unfortunately, it is n=
ot.

Ack.
Mayank, if the patch gets resent for any reason, please add this to
the commit message.

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
With best wishes
Dmitry


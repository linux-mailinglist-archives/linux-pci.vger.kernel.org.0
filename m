Return-Path: <linux-pci+bounces-17217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8C9D62B8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 18:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BB61608B3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9487C1DF972;
	Fri, 22 Nov 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkI1nmkF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B81DF970
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295252; cv=none; b=YRpFr8/1Rj+hOoFXxMiivga86btSabPwBL9bpVO9XvXsruMIRkFCNlpYFcHOcEDm7nEVprHHi1w0NU9ij6g3L0Ls2mYOomaOjJKSrG9mkc/Qkrm61zl2cM3RviELHxfLPj8irZSDaLrRfXZFHsBvr9eFDj3vHJxFn9QDQ9tENSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295252; c=relaxed/simple;
	bh=qHGeW+9YJHnoV8xlYG8Yntca2NxQVMAEhNoIhEt+6xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBdGOsU28UlxU7zvBoEsl2XamH9HTwF8Zbzjo31wtmxYGJdsbkcEd1fS9iNs7skFV9U4tH7HoN53G7O0CR6NmhLo4vW30dUf3GuZTA5Q31yjyJqmc/Cf4d58dXOhMXYphfmIkK26xVzpt/Nxspex+4WcnMtUp+p2g/nAJyq4N84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkI1nmkF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7240d93fffdso1936587b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732295250; x=1732900050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0/2iR2t92OCH9/EybMxXNXRhh30tebsZGZl/G3WtQ4A=;
        b=PkI1nmkFNbg40iAjHfbpK8fx/tPj5m3Sglq2emncXcuVpB+ur+6+vf1TAnWuhzV3tU
         bWsMb99G6w6CIlxZCp8Fu0N1gyziWG2MPKCBVuStdw5dGBMH63tP0MUipwF5appfzShs
         VKCLFlfuR+aTaNguGX/J80uPEXokG7qLwrIGH4K7zTonUi1cWvv6H9aYN8IQcRub+IgR
         gYdGoxjYgKqyST98FvK7E9ebSOQZebSSGDf8Dd8ZXl5hamMqdChiSiumMHzbpsZ1PdTy
         3mE1AQ0OwC1YquluK1kzLBXmmgVB1DnsnrUeXJ5VX1UwAfihzWfs/eGIrvPikv3bSNba
         2AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295250; x=1732900050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/2iR2t92OCH9/EybMxXNXRhh30tebsZGZl/G3WtQ4A=;
        b=nfQSkBp7T/aEgcLdb1vhkykHCuzleKxFU1OH4cEn0MM2kLChE4cNdyOnOpIPUvmTvD
         XpKYpwnKSv0Hpmu0Pa5JoFhi7HcHZwpFur2+7bTvNPipwkJnG3WhfFUdQ0McvCVm4c+d
         lPLu63ri7LAEysUjHlXlW860F6HfUdtRmB03/wJDORlaX+NyA+ws0+JDDVKjJlidVREm
         vuZ9E7/B0n8bkFKgFdkcy8Ak6Vp/ercQXjAmKRhgk1ImjjxsyuL+W8elk8L9WEhuYHZv
         W1cFhbiKvlJPKvrrKI5lOcLcCHeBcTDOs/zpJEQ4u3JeUsRGta4thmRKaPeigI8TBDhd
         CjHw==
X-Forwarded-Encrypted: i=1; AJvYcCXmplINClcLdVSJGdMyiHP6LfcfT+aStsU4eOuh6uI//fJYSj+tWdCZCkWsCdqVcyt/HAfiDxCsZEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7pl/6vTMeOMLS2gc97HvLAR27FVzNjzzY+yZKcqmFXSNxD14V
	yP8tB311ougLFwRg5vQoUl9Yl+tm2Xoc7cdRQnpW2O6qASZE1xHaonBEoUa0wA==
X-Gm-Gg: ASbGnctzbfAKOrL33ngFJAw3osBQ7Kkb/9Qkum7QplO1/jmua0l/e01QzONLpSGhUZY
	KTV39dsqamgBW8eK6paORsug3w08KxRxtOqkQHC230GqZFn0d1u/oHA9/qadQDK99hDk5MZhNeb
	cd5qpKWEu5l8o9OQ3jGd+B0/rYHKtIvKf6Bz3VzQsiPx2T5LxUIXbu9j6rBGKVgo159OD6VgSgI
	h/q3oorjQKLuRXHU2oGZmc+Aq9spxforFwIjLJM7RwczEwZrT/UpFiSMv3J
X-Google-Smtp-Source: AGHT+IGZvDpaoKhSksqbzMsm60Yp0W7DGNYEnn4YmD/coS4PDUIKaXASCZ3cNh00dMOu8rfdsP6n3g==
X-Received: by 2002:a17:902:d4c6:b0:20e:a2f7:8ab9 with SMTP id d9443c01a7336-2129f6ac33amr44650405ad.27.1732295250203;
        Fri, 22 Nov 2024 09:07:30 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba1b40sm18541705ad.87.2024.11.22.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:07:29 -0800 (PST)
Date: Fri, 22 Nov 2024 22:37:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] PCI: imx6: Make core reset assertion
 deassertion symmetric
Message-ID: <20241122170723.s43eokayvnuhas4r@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-6-hongxing.zhu@nxp.com>
 <20241115065221.scfb2chnoetpdzu6@thinkpad>
 <AS8PR04MB8676D25A87FBF45E2B1D26628C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676D25A87FBF45E2B1D26628C272@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Nov 18, 2024 at 02:59:59AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年11月15日 14:52
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; festevam@gmail.com; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 05/10] PCI: imx6: Make core reset assertion
> > deassertion symmetric
> > 
> > On Fri, Nov 01, 2024 at 03:06:05PM +0800, Richard Zhu wrote:
> > > Add apps_reset deassertion in the imx_pcie_deassert_core_reset(). Let
> > > it be symmetric with imx_pcie_assert_core_reset().
> > >
> > > In the commit first introduced apps_reset, apps_reset is asserted in
> > > imx6_pcie_assert_core_reset(), but it is de-asserted in another place,
> > > in
> > 
> > I'd suggest rewording like below to make it easy to understand,
> > 
> > "PCI: imx6: Deassert apps_reset in imx_pcie_assert_core_reset()
> I'm very appreciate for your rewords. Should the imx_pcie_assert_core_reset()
>  be imx_pcie_deassert_core_reset()?
> 

Yeah!

- Mani

-- 
மணிவண்ணன் சதாசிவம்


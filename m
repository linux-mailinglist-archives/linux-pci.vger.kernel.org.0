Return-Path: <linux-pci+bounces-6664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC68B1FFE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 13:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D17B1C218E6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745585261;
	Thu, 25 Apr 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7En29Jx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68384DFE
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043596; cv=none; b=N/HLh1ygKapDq6kCl8kQ2BcDYHUXtn3ctQI+52ldR9rx7BSu8uWja7NPYFmbV0dFCrrPZBqRIUiazc/1j4lj76UzSozBMiCfB7fk1MKN+e4oTPwkL9eK/O23E8b3DPQEKQG3ik2KRSI9mYhcJVx//nUVXXcGI6zMjfPB6ZEhta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043596; c=relaxed/simple;
	bh=9KoaB6+HPDJeQljM4fsDBGLmE1iGfG/0qRUTsarWPHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRAa7qwvcvOa/epSDWOSSq3LKFZq6nsPVe6MSYSU1pijwZVzmqyyEiVK3ImmIyBh3NCAQ8HvN7G239/s43gudORY4L7y8PiNMDXmi9IWVtc59vg0WpD9d39VEP2r0qcvLKO62+om4oSk+avB3XrhlcEfVCQyJvApLHuYNSzMDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7En29Jx; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c74abe247bso523583b6e.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714043594; x=1714648394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QsbB44EeMQGDiOFPnRm6gwdDqQTA+5PLqDVHUcWTTkw=;
        b=W7En29Jx6Z9EtHmbC3mwB/CW+MVtkMDuAgIlrfmDF0mNGAbb+vSfK/4Xbr8SXFsHHA
         9e8iyLlNkxni11DD0zn3bWVOJRnEMVm2EUsBJ1EK8qeAc0IWlEf+eY3ZVVsPeTiMOhmS
         nyy5G33nPu6hJmLNpyQdAa6v1Hd+PVK4edVfJ/rNOOC4KKnp8ee82pqEl+6OizWzzX18
         FS7alwGHkS5K7BjyZvWyv1NIUz49e7HKAdDXfTFn7XsGGXhnbIrbT2Mb5e4FafJw6AtM
         G/ozHhOdt73pVZiZpaIC0Fles+JR2k9uEQU3LNGxV9iu1mcfCi5+RKgDuexcADg5MMdR
         zgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714043594; x=1714648394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsbB44EeMQGDiOFPnRm6gwdDqQTA+5PLqDVHUcWTTkw=;
        b=GMWcCIcThqNVbCXJLTjZfH+XHcR6ZYoj075GLuUo4gDzx5uSQADZxjUtyyPwtFgFY/
         IRggIeEa2hXzPPG/zyhAhbfoiv1qSWm/LyIJiw0cdJ+Oe/6vIgKQN0hvqJ93b6TSVoEu
         lAa16jj8mGrdfxv7z7VhVE0fSBiUc4agq0YrqtrEb8m7NrX2xLHxGkVBmGYGdLY9HU64
         v0ktpYNCnDOCQTl35QRIzn9tFAeSCP4nicZFm2pAJEOV0zqpea2/Uxanc4C0g2dYsHQN
         If2/Zzx5PUzCTj/tEkeFJFaLnP7rZgOht8BVugAM/6Fg6cklyxKYCCYY7wWey4INeo7Q
         rYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAOfHUQpDy0uQBG6R/bFa5Pva7I2xdVsJMKvfGJy8fQKjC7+aGE6ZZGlSd+XmkZLHz21J1bLPyAQ9rzwyGL6ljnyDZxlFiny+G
X-Gm-Message-State: AOJu0YwYPIa2AgEcrXFCv2zKt6hugoQxkXWgIT+jsY8jzvA/4eMziQFN
	DaKcuuX0InpSUK8YadCuZNcVRO+hqWaPeWgGxTCwadKffkKLsv41K4uPyrd12w==
X-Google-Smtp-Source: AGHT+IFHNH/NdwDnqsViBBSK6fogRbB2GKz5I1kvzLPqZs/OJ7Et5KDr4OWgWersvg/dQNYVNr96aA==
X-Received: by 2002:a05:6870:a119:b0:22e:d324:b888 with SMTP id m25-20020a056870a11900b0022ed324b888mr5826865oae.56.1714043593756;
        Thu, 25 Apr 2024 04:13:13 -0700 (PDT)
Received: from thinkpad ([120.60.75.221])
        by smtp.gmail.com with ESMTPSA id fu16-20020a056a00611000b006ecca2f2a32sm12930125pfb.168.2024.04.25.04.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 04:13:13 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:42:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
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
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v3 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <20240425111259.GB3449@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <Zh6GHcARSmlV/QdS@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh6GHcARSmlV/QdS@lizhi-Precision-Tower-5810>

On Tue, Apr 16, 2024 at 10:07:25AM -0400, Frank Li wrote:
> On Tue, Apr 02, 2024 at 10:33:36AM -0400, Frank Li wrote:
> > Fixed 8mp EP mode problem.
> > 
> > imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> > confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> > pci-imx.c to avoid confuse.                                                
> 
> 
> Mani and lorenzo:
> 
> Do you have chance to look these patches?
> 

Sorry for the delay. Since this is a non-dwc driver, it got into my low priority
queue. Will take a look this week.

- Mani

> Frank
> 
> > 
> > Using callback to reduce switch case for core reset and refclk.            
> > 
> > Add imx95 iommux and its stream id information.                            
> > 
> > Base on linux-pci/controller/imx
> > 
> > To: Richard Zhu <hongxing.zhu@nxp.com>
> > To: Lucas Stach <l.stach@pengutronix.de>
> > To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > To: Krzysztof Wilczyński <kw@linux.com>
> > To: Rob Herring <robh@kernel.org>
> > To: Bjorn Helgaas <bhelgaas@google.com>
> > To: Shawn Guo <shawnguo@kernel.org>
> > To: Sascha Hauer <s.hauer@pengutronix.de>
> > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > To: Fabio Estevam <festevam@gmail.com>
> > To: NXP Linux Team <linux-imx@nxp.com>
> > To: Philipp Zabel <p.zabel@pengutronix.de>
> > To: Liam Girdwood <lgirdwood@gmail.com>
> > To: Mark Brown <broonie@kernel.org>
> > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > To: Conor Dooley <conor+dt@kernel.org>
> > Cc: linux-pci@vger.kernel.org
> > Cc: imx@lists.linux.dev
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bpf@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > Changes in v3:
> > - Add an EP fixed patch
> >   PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
> >   PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> > - Add 8qxp rc support
> > dt-bing yaml pass binding check
> > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
> >   LINT    Documentation/devicetree/bindings
> >   DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb
> > 
> > - Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com
> > 
> > Changes in v2:
> > - remove file to 'pcie-imx.c'
> > - keep CONFIG unchange.
> > - Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com
> > 
> > ---
> > Frank Li (7):
> >       PCI: imx6: Rename imx6_* with imx_*
> >       PCI: imx6: Rename pci-imx6.c to pcie-imx.c
> >       MAINTAINERS: pci: imx: update imx6* to imx* since rename driver file
> >       PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
> >       PCI: imx: Simplify switch-case logic by involve core_reset callback
> >       PCI: imx: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
> >       PCI: imx: Consolidate redundant if-checks
> > 
> > Richard Zhu (4):
> >       PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
> >       PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> >       dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
> >       PCI: imx6: Add i.MX8Q PCIe support
> > 
> >  .../bindings/pci/fsl,imx6q-pcie-common.yaml        |    5 +
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   18 +
> >  MAINTAINERS                                        |    4 +-
> >  drivers/pci/controller/dwc/Makefile                |    2 +-
> >  .../pci/controller/dwc/{pci-imx6.c => pcie-imx.c}  | 1173 ++++++++++++--------
> >  5 files changed, 727 insertions(+), 475 deletions(-)
> > ---
> > base-commit: 2e45e73eebd43365cb585c49b3a671dcfae6b5b5
> > change-id: 20240227-pci2_upstream-0cdd19a15163
> > 
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> > 

-- 
மணிவண்ணன் சதாசிவம்


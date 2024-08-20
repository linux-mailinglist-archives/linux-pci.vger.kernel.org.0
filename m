Return-Path: <linux-pci+bounces-11853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5302957EEF
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D90E282E52
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAD016A39E;
	Tue, 20 Aug 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgr86Ido"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2316C86B;
	Tue, 20 Aug 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137516; cv=none; b=tI1jutmf4v1tMf3dgLwsuYo1oF91ShWS1klHnT/HXDJEiap35pNlLzZSkiwe0BoKNeSDAILhV0UDpYxjes8gZMsKRWikfxpEVrDf0HV5BOgiERMMkZp2X2iatkhm4VAyKCHHUz/VpEfkpaaDsJVMyxsVvJpygyUyLgsVTqfsHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137516; c=relaxed/simple;
	bh=GsHRckNHt4lJ18tJSAvBaZnn5/7CpkZCR8qpOQghqmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn/8UuxzdVIV/L1BJO3gIXGWOENkveA1q/p1avwhwitbQD03RkztsN6pRTzcMOCicAIbawZUHInWS90HbQGh93+VUYAVUGIBy9soEhg6MCPfCm7jX/vYcbbyKWnIaVD1dqHhJ/sXbFoDjx/+mPc5YzR+5+2KzKM7qJTu6RigQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgr86Ido; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so595770966b.3;
        Tue, 20 Aug 2024 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724137513; x=1724742313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsF6Nk9oBlSWv0G1oFX6tHfAMXIERFk3AxXMBDi43S4=;
        b=Qgr86Idoue0yKAoNbyl2enbIj8V8VruQ16K65VGI2Hyly/MFr0Zb2prBnFuygIQqn4
         mzwxrMx/GpCPW7ZFRF3e8ameUDB3FQdgerXFqkF6DuzI0W0cpUjXRo//x6lJWv/EIWpF
         C8xDSjZ05hHiJN+om3Wu/oPfM/pyy9lMp6rFYIfFxf909jqxQQYT0DSaajKC7gZhFuzZ
         m0z0DYk+3V9Wuq1W+/J97CCoTBz1SAfA0oPOJn99Hxth+snFEQzNLJRpBUlbe0jPi80B
         ofGcUoCl0MCoDKV5kKcn0OmzO1Bn8tE1MsfY2Qxg7ZIlsCF2Vz8E9t493Bm5mgSEHP/j
         spyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724137513; x=1724742313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsF6Nk9oBlSWv0G1oFX6tHfAMXIERFk3AxXMBDi43S4=;
        b=EhIxVHWDKJXWr2WUYgkB73MvMA4253qWUSLveNozCHgl5E3ylGIVNQa0gB2UqiiIYz
         Fh4Q0gXt5Y7vB5qE1+u25X9QpBd/Rp/0Nx/AqZJUOqvYSrTLqMKoVjJ6+VhUjX5A1ULZ
         NB5svM6keHfDBvuj7TgBuUIwhsaqnZMj3tKFaIXxe4O80BakW+fLkQVHn3ghCPe+5J5I
         O/zfJfRxSudWxF8xK45j5fCsYfc0g8X7x60guA65oX0Om+ki5koskmj7GhPoHtYCoB+3
         oV8lYahbYQ4sa3+KQ2Nh3u3d488sNfa7OP3rQzY2fvlxH34IW/bvTS7pb1EI2jwbbacL
         HiSw==
X-Forwarded-Encrypted: i=1; AJvYcCXEZOS6oGDHKwoNtlwVllqIfGFYVlj403lEIbZ1YMWVWMT/XwqDOIOQtpiMr7eLOWhYBKEzp6fIEzop1n6LxftvWrVMV14BdZjydLIutvVQ5pKhyx2pB+S5776HA7gw7Uphq1Dj/hFX
X-Gm-Message-State: AOJu0YwQB26aKbNkLBPLoEtdCVvZagqogmaKlmz5DefOGTnL1OBUXDCl
	Mezq30L6fbIH8vn3FFqUSBcvZkJFYOVIAgDHWJqNEEhIR95EZBbQ
X-Google-Smtp-Source: AGHT+IGIdq3GdLoqQGTFyWn1TS/t53HJCAInq/O8v+Afgq7IVNwWy6BOOUHntTjFl6AEvA9/pKq7NQ==
X-Received: by 2002:a17:907:e221:b0:a71:ddb8:9394 with SMTP id a640c23a62f3a-a8392957bd8mr965538566b.40.1724137512903;
        Tue, 20 Aug 2024 00:05:12 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c7444sm725745566b.6.2024.08.20.00.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:05:12 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:05:10 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 3/3] PCI: imx6: reset link on resume
Message-ID: <ZsRAJrWTxKCol7-g@eichest-laptop>
References: <20240819090428.17349-1-eichest@gmail.com>
 <20240819090428.17349-4-eichest@gmail.com>
 <ZsNZMdhhpGqXdJ+w@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsNZMdhhpGqXdJ+w@lizhi-Precision-Tower-5810>

On Mon, Aug 19, 2024 at 10:39:45AM -0400, Frank Li wrote:
> On Mon, Aug 19, 2024 at 11:03:19AM +0200, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > According to the https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf errata,
> 
> Can you show errata number here?
> 

I will include it in the next version of the patch. If I understand it
correct it is ERR005723.

> > the i.MX6Q PCIe controller does not support suspend/resume. So suspend
> > and resume was omitted. However, this does not seem to work because it
> > looks like the PCIe link is still expecting a reset. If we do not reset
> > the link, we end up with a frozen system after resume. The last message
> > we see is:
> > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0,
> > device inaccessible
> >
> > Besides resetting the link, we also need to enable msi again, otherwise
> > DMA access will not work and we can still end up with a frozen system.
> > With these changes we can suspend and resume the system properly with a
> > PCIe device attached. This was tested with a Compex WLE900VX miniPCIe
> > Wifi module.
> >
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 45 ++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index f17561791e35a..751243f4c519e 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1213,14 +1213,57 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
> >  	return 0;
> >  }
> >
> > +static int imx6_pcie_reset_link(struct imx6_pcie *imx6_pcie)
> > +{
> > +	int ret;
> > +
> > +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > +			   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> > +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > +			   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> > +
> > +	/* Reset the PCIe device */
> > +	gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 1);
> > +
> > +	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> > +	if (ret) {
> > +		dev_err(imx6_pcie->pci->dev, "unable to enable pcie ref clock\n");
> > +		return ret;
> > +	}
> > +
> > +	imx6_pcie_deassert_reset_gpio(imx6_pcie);
> 
> In my patch https://lore.kernel.org/linux-pci/Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810/T/#mc5f38934b6cef95eca90f1a6a63b3193e45179de
> 
> imx6qp_pcie_core_reset() and imx6q_pcie_core_reset() is not symatic for
> assert/desert() to match origin code. I plan fix it after above patch
> merged.
> 
> Does it work if make above code symatic?
> 

I will give it a try with your patches applied and let you know.

> > +
> > +	/*
> > +	 * Setup the root complex again and enable msi. Without this PCIe will
> > +	 * not work in msi mode and drivers will crash if they try to access
> > +	 * the device memory area
> > +	 */
> > +	dw_pcie_setup_rc(&imx6_pcie->pci->pp);
> > +	if (pci_msi_enabled()) {
> > +		u32 val;
> > +		u8 offset = dw_pcie_find_capability(imx6_pcie->pci, PCI_CAP_ID_MSI);
> > +
> > +		val = dw_pcie_readw_dbi(imx6_pcie->pci, offset + PCI_MSI_FLAGS);
> > +		val |= PCI_MSI_FLAGS_ENABLE;
> > +		dw_pcie_writew_dbi(imx6_pcie->pci, offset + PCI_MSI_FLAGS, val);
> > +	}
> 
> there are already have imx6_pcie_msi_save_restore(imx6_pcie, true); in
> suspend/resume, why need addtional one here?
> 

I took the part from the probe function and added it here. I will see if
I can rework that part.

> > +
> > +	return 0;
> > +}
> > +
> >  static int imx6_pcie_resume_noirq(struct device *dev)
> >  {
> >  	int ret;
> >  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> >  	struct dw_pcie_rp *pp = &imx6_pcie->pci->pp;
> >
> > +	/*
> > +	 * Even though the i.MX6Q does not support suspend/resume, we need to
> > +	 * reset the link after resume or the memory mapped PCIe I/O space will
> > +	 * be inaccessible. This will cause the system to freeze.
> > +	 */
> >  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
> > -		return 0;
> > +		return imx6_pcie_reset_link(imx6_pcie);
> 
> If reset everything, I supposed we can add IMX6_PCIE_FLAG_SUPPORTS_SUSPEND
> at driver data.
> 

This didn't work for the current version. It seems we do too much in the
suspend function and therefore it is still not working. However, maybe
it is really better to just add the flag and try to make suspend/resume
work by using the function pointers you introduced. I will have a look
at it, thanks.

> >
> >  	ret = imx6_pcie_host_init(pp);
> >  	if (ret)
> > --
> > 2.43.0
> >


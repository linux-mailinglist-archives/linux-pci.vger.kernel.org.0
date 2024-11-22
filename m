Return-Path: <linux-pci+bounces-17218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9F9D62C4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 18:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE71B2201A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F701DF250;
	Fri, 22 Nov 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDW3fhV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2471DEFC7
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295420; cv=none; b=MLdfRjPtn6swyWEfw8tnhu10P8do1uJPF2EkZBTV9mkmXk424otN19KnFcRpZ8S7JpE9WsOcefKyQX5KZukJwWNGnY7SV1mbmlRSw6MRkM5UnLDY4GbnlQyjTV9U7TIAGjkpOgQC/CMGO4i6fk615BKjco4BKTIH2zTOggTcUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295420; c=relaxed/simple;
	bh=G9cr1gHE3g36F9Cu85STAfJ/9tRuQumYU8/56wvDlXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrRVtKrtA5Rn1Wiix4igKmtulmEhXNl+a2SXbo9yew0J0TE8AICUkU50x8H7IPeZouEEpOMgGLhs9FG4hH+3A/sYkUYAU0HZqV/oCW23eUzLAJcOeGOLGCJLaoQe32W3FKNxwcOntBqUmCUTHIaw0yhs4bazTjm5gOjOZMA7HFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DDW3fhV/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so655993b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732295418; x=1732900218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/UzD8Qbmoty9y3UdrVjMc3lCWpv9Zoxn+WCwHClf78I=;
        b=DDW3fhV/HabYnNfPG57bMwzAfO2vait3ktXjV0wZeAnIK7hEyjzGCOCFijKlndLBl5
         mT6sS2AtF62A6Qf7qm0p/kNYdURnNZvvMwjNZaWOCIVaZ5weeeysSJzhqq1JRMZ4znDf
         Ke1DTDQYC0uIijbvhGmaHWsNCdbBi+Si1iyfTwrbXcr3QkCDbNZVGrkjILl7RwwxfHsg
         SI5EfwHmhLABjEUYl9dvsFnqQruLCwi2f2OLP1nMcIObe9UYaWpBX+kaWOZp1Zxe1mJi
         5vpb9TGzAXqI/RvNfY/ihN1LtjYVDsa8JlhG0XSJzynowFQP6q/6HPUP2Ks2uQPPMlVz
         uGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295418; x=1732900218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UzD8Qbmoty9y3UdrVjMc3lCWpv9Zoxn+WCwHClf78I=;
        b=VZ524VahBk1a++Ky0+91GMXG24tDEqpB8vICbNFJ/h/lr88xnq6360ossBvRIFd6Eh
         Tv2LePvUD/oOTB0UlFTzEwQ6JPLxVTGsjhc5eKVeE2/lZWnqdUrRfW0gKLKly7JyHK+8
         t1JzKpg8DyDLb7vNvGNiByrRfG6ScGwEKoImrH692fwvRqe2oNvX8m2YkX6tFsDjb6tm
         hUoIcbZcPPgXiH0kVJ9DUtRr+9uFeOtoJOblWpRfYDFHggj9eXQzmFmuFhOH0zDXuy2B
         jGc+rtBNA3U6U/g4diZ4QFhmN7uS30mQ3QS5Plqv8BTMOHHCaEJjemZGnnEHUxmxCFG+
         Qxxg==
X-Forwarded-Encrypted: i=1; AJvYcCUHHelpimUupEH+1Wg9JOaxZqsJZbBDM07//KLyYBgUyP67E35nzvbog70UQcS4Su1gQ6j7bxgtAro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw27UsgeCSX1RyWfCx9003pJuP2VQM3+SRU/2WyYE95UUsOMBD+
	4CA8h44IEJukVT0NG22+2ZfjrnVvte/MMulplh66Ae8GfsJ5Vhz9BumKy2f6+A==
X-Gm-Gg: ASbGncsr+R4letcbbpSeS6t1mw1OvRHC19qg753+3lWRio9OPLDXWQNQ8MDViyPNUNU
	CJV0K4QMT3jl3njqwIIlBsXAdNDxI0HPjekzvUj82CT7vr4JAwNYYGkKEKrmmbyVh8aEB7FyaCf
	7CSGlGcknP+lVoh8+BNWCa3+wYOJm/L9hb7htZo4aEF4IitOlzdVhhmpAH2hH/vOuAEMbMXdu+R
	Fp0lCgcDlTPut6wYBaMY4kbJkxOQp6+bR6MVwOS7iJrEQ7GHA/P3fn+gBtX
X-Google-Smtp-Source: AGHT+IEwjs4uHZtrKVZd87ooqlW4TAiWtY5jzSaWXJxP5mRGV9M6kvrK8gtdD6fzbjrc4NKONPYTYQ==
X-Received: by 2002:a17:902:cec9:b0:212:23e5:6202 with SMTP id d9443c01a7336-2129f67b3f6mr39737875ad.6.1732295417733;
        Fri, 22 Nov 2024 09:10:17 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531b82sm1911272b3a.102.2024.11.22.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:10:17 -0800 (PST)
Date: Fri, 22 Nov 2024 22:40:10 +0530
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
Subject: Re: [PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
 from DT
Message-ID: <20241122171010.ze6iyxmgaq7g7yr6@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-4-hongxing.zhu@nxp.com>
 <20241115064106.iwrorgimt6yenalx@thinkpad>
 <AS8PR04MB86766F6553A36E75A2B1F6C78C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86766F6553A36E75A2B1F6C78C272@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Nov 18, 2024 at 02:59:35AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年11月15日 14:41
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; festevam@gmail.com; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
> > from DT
> > 
> > On Fri, Nov 01, 2024 at 03:06:03PM +0800, Richard Zhu wrote:
> > > Since dbi2 and atu regs are added for i.MX8M PCIes. Fetch the dbi2 and
> > > iATU base addresses from DT directly, and remove the useless codes.
> > >
> > 
> > It'd be useful to mention where the base addresses were extraced. Like by
> > the DWC common driver.
> You're right. How about change them to the below one?
> The dw_pcie_get_resources() function of DWC core codes can fetch the dbi2 and
>  iATU base addresses from DT directly, and remove the useless codes here.

"Since dw_pcie_get_resources() gets the dbi2 and iATU base addresses from DT,
remove the code from imx6 driver that does the same."

- Mani

> 
> > 
> > > Upsteam dts's have not enabled EP function. So no function broken for
> > > old upsteam's dtb.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Reviewed-by: Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > 
> > - Mani
> > 
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 20 --------------------
> > >  1 file changed, 20 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index bc8567677a67..462decd1d589 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -1115,7 +1115,6 @@ static int imx_add_pcie_ep(struct imx_pcie
> > *imx_pcie,
> > >  			   struct platform_device *pdev)
> > >  {
> > >  	int ret;
> > > -	unsigned int pcie_dbi2_offset;
> > >  	struct dw_pcie_ep *ep;
> > >  	struct dw_pcie *pci = imx_pcie->pci;
> > >  	struct dw_pcie_rp *pp = &pci->pp;
> > > @@ -1125,25 +1124,6 @@ static int imx_add_pcie_ep(struct imx_pcie
> > *imx_pcie,
> > >  	ep = &pci->ep;
> > >  	ep->ops = &pcie_ep_ops;
> > >
> > > -	switch (imx_pcie->drvdata->variant) {
> > > -	case IMX8MQ_EP:
> > > -	case IMX8MM_EP:
> > > -	case IMX8MP_EP:
> > > -		pcie_dbi2_offset = SZ_1M;
> > > -		break;
> > > -	default:
> > > -		pcie_dbi2_offset = SZ_4K;
> > > -		break;
> > > -	}
> > > -
> > > -	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> > > -
> > > -	/*
> > > -	 * FIXME: Ideally, dbi2 base address should come from DT. But since only
> > IMX95 is defining
> > > -	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone
> > so that the DWC
> > > -	 * core code can fetch that from DT. But once all platform DTs were fixed,
> > this and the
> > > -	 * above "dbi_base2" setting should be removed.
> > > -	 */
> > >  	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
> > >  		pci->dbi_base2 = NULL;
> 
> The check and the NULL assignment of "pci->dbi_base2" should be removed too
>  refer to FIXME listed above. Would updated in v7 later, Sorry about that.
> 
> Best Regards
> Richard Zhu
> > >
> > > --
> > > 2.37.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்


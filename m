Return-Path: <linux-pci+bounces-14687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A126F9A1165
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 20:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473E11F211F2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9420C493;
	Wed, 16 Oct 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aU87YC5z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5458185939
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102716; cv=none; b=ZZCk0NC7yPnYXXcS4rl+qj7mKTIZO0SVK5348j6bmgK0gYK8Gz6y2g885a/v4dWb2ZCT1kGsxwnno5vY+LI8sjh9suApiuBvC7eqYSTwHRdYIPuMj4CKZtajHFjkkTWbwRmWaSDmwR1H2prjt3MxbcrHSbOvlUqXiCroVJdsRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102716; c=relaxed/simple;
	bh=0RLxWeRy7lIWLtpH6trxl5wUyZXhGtOIOX2LMCj6/wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vehw9nsbLokUdwKYd4UTd6YwnIDb3y7Nk2bAn+uurDgFycONdB3POApbOfmKn9LZjEu/VWJXOKpgzCHBub/6QlpmjiG0vF3Js67Bm46dMn0BvkPtf4kW8dxK51Gk0O/1Q14XWB2E0U1wg6iX72riRaOaqMjeMeKM9iHX4xm5KEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aU87YC5z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-208cf673b8dso1067355ad.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729102714; x=1729707514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KSLOhR9xxYJXQViHS9mwcM/ewvXBBg+Ia/LYbbJpFyw=;
        b=aU87YC5zk93RPwVvSms6thOMXp75EN6SWzE9mgMWodeb+28twSNgf/uSrwVs3eYAvE
         x9x/84HY53+ioIfsgYwvR5CQIjghilaGNBf75vs2gqB6eCFJzPDLTftui3lH9SSGHxza
         75G5i2PT7IfzWqU8NhYklo9DAp5HWxEtsyQ1403JhcNgIBawDxHdA+g6RNbTKN6CGzlI
         l4P5HER4fVbkS3RlvL9I6jHwOMdIVi2gmrfLTgDBP/i1TnLkh1BcK8GQMxs1/jek3zLD
         rxd+9s8CrcsBojEaKJmmw22EaybbzB8e8HhvxxfHBjAXf8PUdPFKoZVldt6oakM3xYt8
         BBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729102714; x=1729707514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSLOhR9xxYJXQViHS9mwcM/ewvXBBg+Ia/LYbbJpFyw=;
        b=UA1nfQ70aZQZmF+B7ykuiykBVe9NPoE68JHOYQHt+T9DONlmdEwNlwuq3yy8O8h+es
         lL2H1PP35iL8cFc5yK/HVgL0/Ohc3r0KGJ/TOnJmWm2a4z20PYt3ji04M8wPt7wTZY2G
         Gf106GJFs9IXIx2mCx70OSGqvbrYa7WZEVR6iWbCKmxvIWvDXUUb1BdiKxlRHWmcG8Uq
         MQ8RKkk9kPMyR6RlUf/YLQP7XrEnIsTnb6/UmFWi5satYvgUzECvjaD4fqrEeXlIgXUG
         tABv+TZLFvhp/J4UJAas46/T+lsj17BIIbTaUW/kotJy4y+weDGCoca5o6O6Xf5Aw1KP
         b08Q==
X-Forwarded-Encrypted: i=1; AJvYcCX57v3oB+FBuZByPzDYPET/TYMNzwXc235TFZPLdJ/eTDmQ9xbXvZdtuWe6PsF+laxokYgmY8MkfPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqZg2ZYuPhGPCD+d1vmv9HQFHF7oe+WA2EMGL+lAcUShd08h6
	9c9h4Ue6fToaM0WUh6UzAHGFy0vrUXkXp46WonebrydJSQCbEwCdk3tPbN0krA==
X-Google-Smtp-Source: AGHT+IGL15xkEGVz/G0WNUShtqNUkX0igr2aU5z36X8kq9Zvhx6EQrdSgDcWVqEV88nIpdgYWyyv2Q==
X-Received: by 2002:a17:902:c951:b0:20c:9983:27ae with SMTP id d9443c01a7336-20d27f275b3mr70371435ad.48.1729102714364;
        Wed, 16 Oct 2024 11:18:34 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c6f3sm31527825ad.300.2024.10.16.11.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:18:33 -0700 (PDT)
Date: Wed, 16 Oct 2024 23:48:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Frank Li <frank.li@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is
 connected on some platforms
Message-ID: <20241016181829.lfgjtw76sm6pzgcz@thinkpad>
References: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
 <1727243317-15729-2-git-send-email-hongxing.zhu@nxp.com>
 <20241003060421.lartgrmpabw2noqg@thinkpad>
 <AS8PR04MB8676495DB585E7F2C9F6659B8C7E2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676495DB585E7F2C9F6659B8C7E2@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Tue, Oct 08, 2024 at 08:25:32AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年10月3日 14:04
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: jingoohan1@gmail.com; kwilczynski@kernel.org; bhelgaas@google.com;
> > lpieralisi@kernel.org; Frank Li <frank.li@nxp.com>; robh@kernel.org;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is connected on
> > some platforms
> > 
> > On Wed, Sep 25, 2024 at 01:48:36PM +0800, Richard Zhu wrote:
> > > The dw_pcie_suspend_noirq() function currently returns success
> > > directly if no endpoint (EP) device is connected. However, on some
> > > platforms, power loss occurs during suspend, causing dw_resume() to do
> > nothing in this case.
> > > This results in a system halt because the DWC controller is not
> > > initialized after power-on during resume.
> > >
> > > Change call to deinit() in suspend and init() at resume regardless of
> > 
> > s/Change call to/Call
> > 
> > > whether there are EP device connections or not. It is not harmful to
> > > perform deinit() and init() again for the no power-off case, and it
> > > keeps the code simple and consistent in logic.
> > >
> > > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume
> > > functionality")
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-host.c | 30
> > > +++++++++----------
> > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index a0822d5371bc..cb8c3c2bcc79 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -933,23 +933,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > >  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
> > PCI_EXP_LNKCTL_ASPM_L1)
> > >  		return 0;
> > >
> > 
> > There is one more condition above. It checks whether the link is in L1ss state or
> > not and if it is, the just returns 0. Going by your case, if the power goes off during
> > suspend, then it will be an issue, right?
> > 
> Hi Manivannan:
> Thanks for your comments.
> Yes, you're right. It's a problem that power is off in suspend when link
>  is in L1ss.
> How about to issue another patch to fix this problem?
> Since this commit is verified to fix the resume failure when no EP is
>  connected. I'm not sure I can combine them together or not.
> 

Fine with me.

- Mani

> Best Regards
> Richard Zhu
> > > -	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> > > -		return 0;
> > > -
> > > -	if (pci->pp.ops->pme_turn_off)
> > > -		pci->pp.ops->pme_turn_off(&pci->pp);
> > > -	else
> > > -		ret = dw_pcie_pme_turn_off(pci);
> > > +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> > > +		/* Only send out PME_TURN_OFF when PCIE link is up */
> > 
> > Move this comment above the 'if' condition.
> > 
> > - Mani
> > 
> > > +		if (pci->pp.ops->pme_turn_off)
> > > +			pci->pp.ops->pme_turn_off(&pci->pp);
> > > +		else
> > > +			ret = dw_pcie_pme_turn_off(pci);
> > >
> > > -	if (ret)
> > > -		return ret;
> > > +		if (ret)
> > > +			return ret;
> > >
> > > -	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val ==
> > DW_PCIE_LTSSM_L2_IDLE,
> > > -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > -	if (ret) {
> > > -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n",
> > val);
> > > -		return ret;
> > > +		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val ==
> > DW_PCIE_LTSSM_L2_IDLE,
> > > +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> > > +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> > > +		if (ret) {
> > > +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n",
> > val);
> > > +			return ret;
> > > +		}
> > >  	}
> > >
> > >  	if (pci->pp.ops->deinit)
> > > --
> > > 2.37.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்


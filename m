Return-Path: <linux-pci+bounces-8959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0190E651
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D70F1C21726
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6537D075;
	Wed, 19 Jun 2024 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbVrKRkz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764722139B1;
	Wed, 19 Jun 2024 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787167; cv=none; b=GnyPZ0T3olWj1Buism8GY2CYA0qtCBP8ucCAiWL90uZV9SRmZPQtBaA/O30SiUsaA8JK9vrl32W+6TxQcGlbXA31z0hD1fvV6BKkhQNuPIfAw2ai+lr1wnYETGgFrX7rRSAer0WHT9TDM7LqkvZhN5pSz/h3e6yNqQCF9Uu/PUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787167; c=relaxed/simple;
	bh=Fkb8YCVrp8GptNyVesDfam2YovE22l6N/C89FMRpyLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVWnoz/xQ79n/7IU0PGDwqLcptM94f3Nf7Z8vfsm21ihGlSBDIOo+SpAoh7JykLAW40qP/INjP1pi6YVSkg2GwLwREiiUhb6ms+FUUHz6pztm4T1alaLf7gkYUr6dHIC/zsS6iiz/+M79CcvNJI8O9isD4geeQr639eY1jNYsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbVrKRkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E09DC2BBFC;
	Wed, 19 Jun 2024 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718787167;
	bh=Fkb8YCVrp8GptNyVesDfam2YovE22l6N/C89FMRpyLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbVrKRkzlQ0Sd8jcanuhXOnuWPsmi15B53bZN9Dhwunr637KyZe5KYCACHb5S1R5U
	 iOOHaPkTkPwqUwFK42VISDNovChpYyZdRoSZmK90RInHlRGV9+bnD6NJUDYQi8gVG+
	 ieYLtadjFQnKgEhUnkV8nFzwKntckuEXMULrQYI981wTH8HQmrGXtyFQUFXtuRgjQ2
	 rkj5Y+nuHEqYZag+q4+p0hec13ATSkidZh19c0DIbsgU/tMj3lqUTV0LcSpo+DgUMn
	 Ux48VBz3VEvgXXCImpTAlxHf7vEc5C4GA2nrce7BTZhIST29NY5fdhjTnm0nb01yYJ
	 SEAimSiQeCCRw==
Date: Wed, 19 Jun 2024 14:22:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <20240619085238.GD3898@thinkpad>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
 <20240618070925.GB5485@thinkpad>
 <TYCPR01MB11040C48B321E9418D274B6D4D8CE2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB11040C48B321E9418D274B6D4D8CE2@TYCPR01MB11040.jpnprd01.prod.outlook.com>

On Tue, Jun 18, 2024 at 08:10:43AM +0000, Yoshihiro Shimoda wrote:
> Hello Manivannan,
> 
> Thank you for your review!
> 
> > From: Manivannan Sadhasivam, Sent: Tuesday, June 18, 2024 4:09 PM
> > 
> > On Tue, Jun 11, 2024 at 09:50:56PM +0900, Yoshihiro Shimoda wrote:
> <snip>
> > > @@ -221,6 +257,10 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > >
> > >  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> > >  {
> > > +	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
> > > +	if (IS_ERR(rcar->phy_base))
> > > +		return PTR_ERR(rcar->phy_base);
> > > +
> > 
> > I failed to spot this in earlier reviews. Since this 'phy' region is only
> > applicable for r8a779g0, wouldn't this fail on other platforms?
> 
> This will not fail on other platforms because the dtsi file of the other platform (r8a779f0.dtsi)
> already has the 'phy' region in the first commit which I added PCIe nodes:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/renesas/r8a779f0.dtsi?h=v6.10-rc4&id=183a709d3719e5c9919a6f12c86c0a3e088b712d
> 

Ah okay. I didn't check the dts/binding. This is fine.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


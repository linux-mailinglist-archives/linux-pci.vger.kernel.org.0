Return-Path: <linux-pci+bounces-24884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB3BA73DD1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 19:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42FB3B92CC
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F78120330;
	Thu, 27 Mar 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFWTkZHB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF31F4F1;
	Thu, 27 Mar 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099328; cv=none; b=X7E6NO1dQKXPO3CUYkfX7KYfzZ51yiaNWJmuW6F+Sqjwkqlx3uHk+VahZx0N1fNmnEHBxFO66bOad+aBTPoDyiIqJESNxXsjJk3On1WHm+KIa3pWK4RRd5HuWhvXm8PqYGXj1r9q4xmPo//shmhzOMW2J2MpZxDacm0e6br8F1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099328; c=relaxed/simple;
	bh=ZEeQ/S/6JeftSF4kJP065O+i5F6+rxtbBgbhnxYIVWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rBvYP2h3xASQuip8zsvNlpUloEYTj/XoHfkqv5KxxI6ifD2z+Rk8ZqtVwCKyxbMlvUztQ41vpiaj7/yksDTaa2/rlLU65LYl3npjnQIwAv1CAVaYBrd0LEHtFwx/+LvXaa9cqKNuvCWmGk90JNdfd7YbhJXccUNWfxtNiGa/w4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFWTkZHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3E8C4CEDD;
	Thu, 27 Mar 2025 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743099327;
	bh=ZEeQ/S/6JeftSF4kJP065O+i5F6+rxtbBgbhnxYIVWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JFWTkZHB7/ndBiO06/3QxNGLnicTD4KEgTecERc8mrFHQiA9Erkq9fYO0XkmBagc0
	 A6UsyyPTh2Bbea2UBvZ4XCjELyUEY+HxSpBDtB9/eKl/IQWUaHJsyzIP756MW55LkX
	 BEbqyaI/iU+j9rIHE1QRX7hx963LBiN6bAAlExoJQqtG/OfU8kmyMrK2L6hNCuCZ42
	 6UhIY4bnmt32kHIf7mSGF9bTn0JbqODFiYX1BWxluoI4L4hcB+1pphuq1mv9RAi85u
	 ZNkaLNZ7IFQDPuKV2e0k3nRow+SSPf3Rxb+DTWboRVh6hOmBREzyvQLva3uxI/YsZl
	 GVyAKOEpYH1Rg==
Date: Thu, 27 Mar 2025 13:15:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: fix index passed to
 syscon_regmap_lookup_by_phandle_args
Message-ID: <20250327181526.GA1470997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327175557.GA1438048@bhelgaas>

On Thu, Mar 27, 2025 at 12:55:57PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 27, 2025 at 05:19:49PM +0200, Ioana Ciornei wrote:
> > The arg_count variable passed to the
> > syscon_regmap_lookup_by_phandle_args() function represents the number of
> > argument cells following the phandle. In this case, the number of
> > arguments should be 1 instead of 2 since the dt property looks like
> > below.
> > 	fsl,pcie-scfg = <&scfg 0>;
> > 
> > Without this fix, layerscape-pcie fails with the following message on
> > LS1043A:
> > 
> > [    0.157041] OF: /soc/pcie@3500000: phandle scfg@1570000 needs 2, found 1
> > [    0.157050] layerscape-pcie 3500000.pcie: No syscfg phandle specified
> > [    0.157053] layerscape-pcie 3500000.pcie: probe with driver layerscape-pcie failed with error -22
> > 
> > Fixes: 149fc35734e5 ("PCI: layerscape: Use syscon_regmap_lookup_by_phandle_args")
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> Thanks, applied to pci/controller/layerscape for v6.15.  Hopefully the
> last change for this cycle :)
> 
> Thanks for the message sample.  I dropped the timestamps because
> they're not really relevant here.

I guess this should have a stable tag since 149fc35734e5 appeared in
v6.14.  I added one.

> > ---
> >  drivers/pci/controller/dwc/pci-layerscape.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > index 239a05b36e8e..a44b5c256d6e 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > @@ -356,7 +356,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
> >  	if (pcie->drvdata->scfg_support) {
> >  		pcie->scfg =
> >  			syscon_regmap_lookup_by_phandle_args(dev->of_node,
> > -							     "fsl,pcie-scfg", 2,
> > +							     "fsl,pcie-scfg", 1,
> >  							     index);
> >  		if (IS_ERR(pcie->scfg)) {
> >  			dev_err(dev, "No syscfg phandle specified\n");
> > -- 
> > 2.34.1
> > 


Return-Path: <linux-pci+bounces-43866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F00BCEA475
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 18:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FCB03003F66
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C482221542;
	Tue, 30 Dec 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8AktDuH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E526E7081E;
	Tue, 30 Dec 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114888; cv=none; b=R4hssjinSW/cM5nYHlfDX13QgB+xcDLF5eUUO8bwvpdDh9p3c/VDKcgmZyQsrLF+7btgtvvYjhkNWTqqGtAaBnzNjKxZ3y0c1412TiXIj1A0Fnq6KRfDg9HJOOKQYhGbjWtIdCHfyT5RU1butXAY7kQPPQHN3lrF1BwekjMhkIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114888; c=relaxed/simple;
	bh=UYidEn3/oKiTBcld3QrP9WYPFP74eP/Tbugi/h5YoME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QZcrm7wgdyTjRdacbXlOnLFHVXsbuX0G4g+hhgge1RHFd067nADrEWEN/X5JV+NRwnDun6yMi1amfxXBM5iZkANYBFsX9W6YBGyT2CBmbAmoV2q7U1v2bmox6h0dcRYpGRfbVDG+K5pgCg8JB8YLQOiLs93xrDo2UD2brBcPfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8AktDuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6742DC4CEFB;
	Tue, 30 Dec 2025 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114887;
	bh=UYidEn3/oKiTBcld3QrP9WYPFP74eP/Tbugi/h5YoME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Y8AktDuHeZGah352PUjIy76Za/Qza3wSDSHuFD9cEvMDH9OQwt7RDhtMDQXDHgIeA
	 ZvGapiI6BuR+hFIUkVsjSypn5zbJpR5Mm0YBeXHqbEl9FhsCqu4za+nlosuAGg/60f
	 sSdgcZz0PFLo1M6TgDREg2+aWUaD1AtCUpFKUG0AvfuuhrUzNPm3MZnKaJRdH53rlr
	 QiQ9Q9eLgicZcY9Sp4K98YydaoR5KkYHObX8wUqvNm3XIoATeji7aQuqPF00A2pnRw
	 7xouwJWfOiHLNp1fVFxfadMr00KSfL728abiGsoUG5JqtndgZJ6dwkL9GMmUn3/sdT
	 9wzVXSDLC+/kg==
Date: Tue, 30 Dec 2025 11:14:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Val Packett <val@packett.cool>
Subject: Re: [PATCH] PCI: qcom: Clear ASPM L0s CAP for MSM8996 SoC
Message-ID: <20251230171446.GA116207@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <scgyvnbmovko24h3sesnmt3mlnujvxohgpeusadusn3fkhsqv3@4hsnd7oacepy>

On Sat, Dec 27, 2025 at 09:58:28AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 26, 2025 at 05:39:55PM -0600, Bjorn Helgaas wrote:
> > [+cc Val]
> > 
> > On Wed, Nov 26, 2025 at 01:47:18PM +0530, Manivannan Sadhasivam wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > Though I couldn't confirm the ASPM L0s support with the Qcom hardware team,
> > > bug report from Dmitry suggests that L0s is broken on this legacy SoC.
> > > Hence, clear the L0s CAP for the Root Ports in this SoC.
> ...

> > This looks like possible v6.19 material since it's a regression
> > and Dmitry reported random resets that are impossible to debug?
> 
> Yes. I was about to ping you offline the list of v6.19 materials
> once you got back from vacation.

Thanks, I moved this to for-linus for v6.19 and updated
pci/controller/dwc-qcom accordingly.

> > For now I moved this to the beginning of pci/controller/dwc-qcom since
> > it sounds like the PERST# series will be updated.
> > 
> > > Since qcom_pcie_clear_aspm_l0s() is now used by more than one SoC config,
> > > call it from qcom_pcie_host_init() instead.
> > > 
> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > Closes: https://lore.kernel.org/linux-pci/4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 805edbbfe7eb..25399d47fc40 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1088,7 +1088,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> > >  		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
> > >  				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
> > >  
> > > -	qcom_pcie_clear_aspm_l0s(pcie->pci);
> > >  	qcom_pcie_clear_hpc(pcie->pci);
> > >  
> > >  	return 0;
> > > @@ -1350,6 +1349,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > >  			goto err_disable_phy;
> > >  	}
> > >  
> > > +	qcom_pcie_clear_aspm_l0s(pcie->pci);
> > > +
> > >  	qcom_ep_reset_deassert(pcie);
> > >  
> > >  	if (pcie->cfg->ops->config_sid) {
> > > @@ -1486,6 +1487,7 @@ static const struct qcom_pcie_cfg cfg_2_1_0 = {
> > >  
> > >  static const struct qcom_pcie_cfg cfg_2_3_2 = {
> > >  	.ops = &ops_2_3_2,
> > > +	.no_l0s = true,
> > >  };
> > >  
> > >  static const struct qcom_pcie_cfg cfg_2_3_3 = {
> > > -- 
> > > 2.48.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்


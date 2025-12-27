Return-Path: <linux-pci+bounces-43753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C9CDF431
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 05:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1FD3007957
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 04:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81218135A53;
	Sat, 27 Dec 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa1qEHg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E47288AD;
	Sat, 27 Dec 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766809716; cv=none; b=gzDFYIqu9HQf0V9Enyad84hAzyzfvmFkb4hXKwPHAc/1Wf9GZ6Bz5i+Oqy1yyePfEqheeUP98IJ25rh6V5T3Xyu/SFHjNmunjK0fGUFwlJ5LaYMVD9Xlm/OaIKeZNhg7QxBGzUZQLsd8lwf5a0zQ07nEuNSRV/nqHQFYY15/uVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766809716; c=relaxed/simple;
	bh=LiAa30J2lKwiSWZfO8YyRXn4CjBMM3IKHPINE8Ajomc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJOKK+zhmrKejNBPZ7HYkii1602UAzuh+uPls4fO6Ib8NXV/E3jHzs2RHHzjFYOyV8LbglnCqYoRpYWofUQivms7f5evLqG/+XcKQeljo3q8HDGjlk4icGG/FeQMa89dPBAbXJHs9QaW6jL/e/v74zCOi1LXB7aNkH958y8LQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa1qEHg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57165C4CEF1;
	Sat, 27 Dec 2025 04:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766809715;
	bh=LiAa30J2lKwiSWZfO8YyRXn4CjBMM3IKHPINE8Ajomc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oa1qEHg+yPIMIeeWxDKazlDn1CVwp+kD10XuABQMNZgD9+xhREX4tVojna/NdnNPH
	 BC2XgGUg/DwR1uZ1lu0x9pr5YwTLymu6wHHQr1nghwPkg9N2lIOS3/f2vwv8cNwXwk
	 97GvopqAe0r8Dbf4Igh246YH7CO0ZvsN/mjYvtgDpHXHmRAATC2paB7zV+JirJvyVI
	 UXxuOA0nPsdPsqiFnxLcS9VuuFTWk8Q2PbYC8Q9CIZ2DEbq1O1z84pfymO+VcNTZv0
	 zlj8LRB+eWUa6h1jte5JMUl6w9bahbXW0jcrAf3RVqfJjZaFCyuCbX11JvKJycFJpY
	 kIkUXmBGqbzJQ==
Date: Sat, 27 Dec 2025 09:58:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Val Packett <val@packett.cool>
Subject: Re: [PATCH] PCI: qcom: Clear ASPM L0s CAP for MSM8996 SoC
Message-ID: <scgyvnbmovko24h3sesnmt3mlnujvxohgpeusadusn3fkhsqv3@4hsnd7oacepy>
References: <20251126081718.8239-1-mani@kernel.org>
 <20251226233955.GA4148273@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251226233955.GA4148273@bhelgaas>

On Fri, Dec 26, 2025 at 05:39:55PM -0600, Bjorn Helgaas wrote:
> [+cc Val]
> 
> On Wed, Nov 26, 2025 at 01:47:18PM +0530, Manivannan Sadhasivam wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Though I couldn't confirm the ASPM L0s support with the Qcom hardware team,
> > bug report from Dmitry suggests that L0s is broken on this legacy SoC.
> > Hence, clear the L0s CAP for the Root Ports in this SoC.
> 
> I'm squinting a little bit about a Qcom engineer not being able to
> confirm whether L0s is known to work on a Qcom part :)
> 

Unfortunately, all the folks who worked on this part no longer work at Qcom. And
there is no credible documentation that affirms me that L0s is supported on this
SoC.

> This looks like possible v6.19 material since it's a regression and
> Dmitry reported random resets that are impossible to debug?
> 

Yes. I was about to ping you offline the list of v6.19 materials once you got
back from vacation.

- Mani

> For now I moved this to the beginning of pci/controller/dwc-qcom since
> it sounds like the PERST# series will be updated.
> 
> > Since qcom_pcie_clear_aspm_l0s() is now used by more than one SoC config,
> > call it from qcom_pcie_host_init() instead.
> > 
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Closes: https://lore.kernel.org/linux-pci/4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 805edbbfe7eb..25399d47fc40 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1088,7 +1088,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> >  		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
> >  				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
> >  
> > -	qcom_pcie_clear_aspm_l0s(pcie->pci);
> >  	qcom_pcie_clear_hpc(pcie->pci);
> >  
> >  	return 0;
> > @@ -1350,6 +1349,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >  			goto err_disable_phy;
> >  	}
> >  
> > +	qcom_pcie_clear_aspm_l0s(pcie->pci);
> > +
> >  	qcom_ep_reset_deassert(pcie);
> >  
> >  	if (pcie->cfg->ops->config_sid) {
> > @@ -1486,6 +1487,7 @@ static const struct qcom_pcie_cfg cfg_2_1_0 = {
> >  
> >  static const struct qcom_pcie_cfg cfg_2_3_2 = {
> >  	.ops = &ops_2_3_2,
> > +	.no_l0s = true,
> >  };
> >  
> >  static const struct qcom_pcie_cfg cfg_2_3_3 = {
> > -- 
> > 2.48.1
> > 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-13701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AC398C777
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 23:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10D31C24074
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F36A1CCEDA;
	Tue,  1 Oct 2024 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slgR241p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324F19C56F;
	Tue,  1 Oct 2024 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817599; cv=none; b=EyVgw1N9KcFZMNt1aMHcrYChDjbDm39QXUDIdR5jfbbTZBFO81ai/et1PZvQXnIjr0x3zKbBQ+9k8GDOOqvHmr2Py0G2PaTnD5/OKfuHth+VAT10mDp+YICyaKLo3yvi1Jzl/wkR1ZhuPdHUMCnHDpy0gNoj2UP1PpiYIXo2rac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817599; c=relaxed/simple;
	bh=UvFS9AEFBRiLrqnwziEbTU80f5qSBbjblSE7Jg3jCZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AGrRPtzGSo76OvqOHrbEKQ2Nlr/Qv/PX1it8gXh2lyhNAJhoUwif847Q0/cueOchDVvk9/K9TBLV4WmSvmGE6ypsyfHJaLu2NYATiFngTGhsfCTam8M9lK0W4Exx/5zbPfu1cAKIaHW5LqvPCFlP6v58Yw9TR87hYH7gBnO/Gtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slgR241p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FF2C4CECD;
	Tue,  1 Oct 2024 21:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727817599;
	bh=UvFS9AEFBRiLrqnwziEbTU80f5qSBbjblSE7Jg3jCZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=slgR241pNj7FVdUseXdhRjPnFtvdPDvVYakmHU40zolreBSBusNC/HaoLzxqOSKIV
	 PvCtfyMmRhgz1HWENNdYkxST1qGEtXRoNXnE4WAEyJOyOgMRsd7CQudXXdmJOSioY8
	 BfSl1PLS0/GWZivLfwLY/eBo+RZim1Qrbc18e+D18kIs4GrWsHFlRaAtbCkw+7L48U
	 WhEuydAZFplrmjXiY3gF1TVG/OKg050H9G+sFrT8+vrfrTQY395NS/2qFGjyjNk/bP
	 I/3lW+jyGU/9liEUFaQFSiwB0UeNiHaEL4W4x9CPLWEdthk4cv48swhVeDl5gr6teS
	 M36lgmDBQzHwQ==
Date: Tue, 1 Oct 2024 16:19:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_qianyu@quicinc.com, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH] PCI: qcom: Enable MSI interrupts together with Link up
 if global IRQ is supported
Message-ID: <20241001211957.GA227250@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001042055.ivf4zspq4fqmaxth@thinkpad>

On Tue, Oct 01, 2024 at 09:50:55AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 30, 2024 at 12:11:01PM -0500, Bjorn Helgaas wrote:
> > On Mon, Sep 30, 2024 at 07:14:09PM +0530, Manivannan Sadhasivam wrote:
> > > Currently, if global IRQ is supported by the platform, only the Link up
> > > interrupt is enabled in the PARF_INT_ALL_MASK register. But on some Qcom
> > > platforms like SM8250, and X1E80100, MSIs are getting masked due to this.
> > > They require enabling the MSI interrupt bits in the register to unmask
> > > (enable) the MSIs.
> > 
> > "global IRQ" is a very generic name.  If that's the official name, it
> > should at least be capitalized, e.g., "Global IRQ", to show that it is
> > a proper noun that refers to a specific IRQ.
> 
> Sure.
> 
> > > Even though the MSI interrupt enable bits in PARF_INT_ALL_MASK are
> > > described as 'diagnostic' interrupts in the internal documentation,
> > > disabling them masks MSI on these platforms. Due to this,
> > 
> > > MSIs were not
> > > reported to be received these platforms while supporting global IRQ.
> > 
> > I'm trying to parse "while supporting global IRQ."  We basically
> > support global IRQ by installing qcom_pcie_global_irq_thread(), but of
> > course the device doesn't see that, so I assume it would be more
> > informative to say that MSIs are masked by some register setting.
> 
> Hmm, this is what I mentioned in the above paragraph referencing
> PARF_INT_ALL_MASK register. Is that not clear enough?

It requires the knowledge that the MSI enable bits are set by
hardware, cleared by 4581403f6792, and set again here.  This will be
more accessible to non-qcom experts if that information is included
here.

> > The patch suggests that MSIs are masked internally unless
> > PARF_INT_MSI_DEV_0_7 is set in PARF_INT_ALL_MASK.
> > 
> > Are you saying that prior to 4581403f6792, MSIs did work?  Does that
> > mean PARF_INT_MSI_DEV_0_7 was set by a bootloader or something, so
> > MSIs worked?  And then 4581403f6792 came along and implicitly cleared
> > PARF_INT_MSI_DEV_0_7, so MSIs were then masked?
> 
> Yeah. Those bits were enabled by default in hardware, but since they were
> mentioned as 'diagnostic interrupts' in documentation, commit 4581403f6792
> intentionally disabled them. But that results in MSIs getting masked in
> *some* platforms.

Apparently the "*some* platforms" part is more qcom-expert knowledge?
There are other qcom platforms where MSIs are not disabled by
4581403f6792?  Information about which platforms are which also sounds
useful for future maintenance.

> > > So enable the MSI interrupts along with the Link up interrupt in the
> > > PARF_INT_ALL_MASK register if global IRQ is supported. This ensures that
> > > the MSIs continue to work and also the driver is able to catch the Link
> > > up interrupt for enumerating endpoint devices.
> > > 
> > > Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
> > > Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> > > Closes: https://lore.kernel.org/linux-pci/9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org/
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index ef44a82be058..2b33d03ed054 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -133,6 +133,7 @@
> > >  
> > >  /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> > >  #define PARF_INT_ALL_LINK_UP			BIT(13)
> > > +#define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
> > >  
> > >  /* PARF_NO_SNOOP_OVERIDE register fields */
> > >  #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
> > > @@ -1716,7 +1717,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >  			goto err_host_deinit;
> > >  		}
> > >  
> > > -		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
> > > +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
> > > +			       pcie->parf + PARF_INT_ALL_MASK);
> > >  	}
> > >  
> > >  	qcom_pcie_icc_opp_update(pcie);
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்


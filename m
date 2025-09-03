Return-Path: <linux-pci+bounces-35402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD303B4292B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 20:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA6A1A85F68
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B622322C78;
	Wed,  3 Sep 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8Ppfyv+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D251547C9;
	Wed,  3 Sep 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925789; cv=none; b=BFRwMftgj1qoBGG8DNXelQWs8rQhn72B4R4e6E5EPdLLResHIaptKfKQRBKzkcrzkCDOolBV3X9sVIVTyi39QZYej2UFIAPJR6H8bY5Ty+xv9ERbfN/Swl9wFIod9sPda5I3wuPceZDWlD2hYDobj8pUT0fj0BceJiaftiWOAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925789; c=relaxed/simple;
	bh=Di/kTCAveoUUjQoVNNWL0t0vFQa2mlSFvm1V0OlnA+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qkyc2lYEOJy6ETAL42CzsyccZD8xnVCGp4/MzwtNUHOulREeGDAC2oC6QVYRVMLByGDp/7MgvGKjKoarBTONq/xVdyux7u6+qy0IsH3FDUzbdSGgWrrnVAvKR1tvyr9sUxi/JUhQOBF+q6Owit57L2+iDzDjR2d6JuBwDPiDoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8Ppfyv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264F4C4CEF4;
	Wed,  3 Sep 2025 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756925787;
	bh=Di/kTCAveoUUjQoVNNWL0t0vFQa2mlSFvm1V0OlnA+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T8Ppfyv+fQ4oge60ckzlsCSvW0CS+/8F/KblhmfNBNBDzbKqjG7GHTSmPj8+pbYSs
	 mJZyGaAF+FSfRZJYUrRoY1RxsOJYKLbo7FUWl5LlNY9jkGZTtNi/QSLtW73ZanbFbf
	 JPggwbng1Y4ppaHYCO3f8mvPWg94FyZZK/2fGBwBcfFUT2FeKfmJBtIfyKwsngOk/3
	 S564EK9e3uTxJ8CeP6MfogFN2CJIBe1ksKCl8OAIJuMzW5ZbSWH0+xhQBwpzPW6Gs5
	 ShvvfeiN2Ce2wFeeWi3NEq2gII1Sn07PzDp5WzIeNdJZE0KylQfjniN6JbvWBzRvoe
	 BZvD5XS18d8Xw==
Date: Wed, 3 Sep 2025 13:56:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v8 2/5] PCI: dwc: Add support for ELBI resource mapping
Message-ID: <20250903185625.GA1213441@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rijfzrfngdtfc2ckxarzrcyt3xx23mldmijdlx7efbkputhkxz@i4cvdsmtavge>

On Mon, Sep 01, 2025 at 07:18:17PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 28, 2025 at 01:04:23PM GMT, Krishna Chaitanya Chundru wrote:
> > External Local Bus Interface(ELBI) registers are optional registers in
> > DWC IPs having vendor specific registers.
> > 
> > Since ELBI register space is applicable for all DWC based controllers,
> > move the resource get code to DWC core and make it optional.
> 
> As discussed offline, this changes also warrants switching the glue
> drivers to use 'dw_pci::elbi' base instead of their own. So I've
> ammended this commit to include those changes also while applying
> (which was straightforward).

I'm glad if we can do this in the DWC core instead of individual
drivers, but in the case of qcom, this changes the mapping from using
devm_pci_remap_cfgspace() to using devm_ioremap_resource():

  qcom_pcie_ep_get_io_resources
    platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi")
    devm_pci_remap_cfg_resource
      devm_pci_remap_cfgspace
        pci_remap_cfgspace
          ioremap_np                  # (except on arch/arm)

  dw_pcie_get_resources
    platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi")
    devm_ioremap_resource
      __devm_ioremap_resource(..., DEVM_IOREMAP)
        __devm_ioremap
          switch (type)
          case DEVM_IOREMAP: ioremap

I assume this change from ioremap_np() to ioremap() is fine, but
please verify and update the commit log to mention this change and
explain why it's ok.

(I don't think the qcom changes were posted to the mailing list; you
can see them here:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-ecam&id=d39e0103e38f9889271a77a837b6179b42d6730d)

> > Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h | 1 +
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 89aad5a08928cc29870ab258d33bee9ff8f83143..4684c671a81bee468f686a83cc992433b38af59d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -167,6 +167,15 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> >  		}
> >  	}
> >  
> > +	if (!pci->elbi_base) {
> > +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> > +		if (res) {
> > +			pci->elbi_base = devm_ioremap_resource(pci->dev, res);
> > +			if (IS_ERR(pci->elbi_base))
> > +				return PTR_ERR(pci->elbi_base);
> > +		}
> > +	}
> > +
> >  	/* LLDD is supposed to manually switch the clocks and resets state */
> >  	if (dw_pcie_cap_is(pci, REQ_RES)) {
> >  		ret = dw_pcie_get_clocks(pci);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 00f52d472dcdd794013a865ad6c4c7cc251edb48..ceb022506c3191cd8fe580411526e20cc3758fed 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -492,6 +492,7 @@ struct dw_pcie {
> >  	resource_size_t		dbi_phys_addr;
> >  	void __iomem		*dbi_base2;
> >  	void __iomem		*atu_base;
> > +	void __iomem		*elbi_base;
> >  	resource_size_t		atu_phys_addr;
> >  	size_t			atu_size;
> >  	resource_size_t		parent_bus_offset;
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்


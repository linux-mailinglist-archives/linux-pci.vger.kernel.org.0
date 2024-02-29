Return-Path: <linux-pci+bounces-4280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC786D424
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08301C210ED
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43FD13F444;
	Thu, 29 Feb 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKiByizL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076813F454
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238259; cv=none; b=dGW9al4JslNd4TN6mTwS0UDzs1eQPwXf9pG1i+Gm8g5ziDbd/U8PnzMOA40Bds8QYRD0VpoIIS78MUispLhEKUaQfS/nCd72XjRd6zwon0PL/LFOjtSq7R7+EJwFGL4vdtwb89njdlRbSb7tUur8NgsmF9S+Fh4DLllZFA14T6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238259; c=relaxed/simple;
	bh=rhO491b82xDzmPf6mBQ0SaG6Ub7MH27gULCh02eSMsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eNtGQErGha0SJ+a/xsr35nQGb1swU8NHmwo/I7Gm0vw49tg6LnDYxomiBXfPHZzsOR/vfLMofxNO9BN9/rSf+sIwVsaGNUEZN7+EowcIzsvPzmnkRNhhK0acJ8zd+8MC0TiCnnxARzuz1TsVJi23qr8FCDOzWRfpfH5/iFixj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKiByizL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF206C433C7;
	Thu, 29 Feb 2024 20:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709238259;
	bh=rhO491b82xDzmPf6mBQ0SaG6Ub7MH27gULCh02eSMsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UKiByizLdUUl0ULmJSbSGIF2HcpZ/oUI7OdYC/IW+Ifdu8T4vRBWj20hyoKOJqq9c
	 4CMJpTLvkP3ngZlcJbYi6gsHdle9CKoek8/DyWkLO3uZOWKi+eVKGWwBMc18kEUGbJ
	 IrzZBUk57wdGQ0yMIQdtiL0Jc6Yq+TNKzIgfR4ftamNZwNC1seXVZTu/cfU6q/GJfi
	 d3O4AQh2oQetOrYHymiR7EfRZbfFZa5jSL9asmOF1D3GU2XDzWKWs6+aeVljK+4w9m
	 RVkHQ2J6mMuSWFwEA/QKNYlFwnf032Xzx3OSoEl6tPioLKOMxPXv94cPbsOZvkiMvK
	 0W2zuuhlUt6bA==
Date: Thu, 29 Feb 2024 14:24:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: endpoint: Fix advertized resizable BAR size
Message-ID: <20240229202417.GA361171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229131313.1199101-1-cassel@kernel.org>

On Thu, Feb 29, 2024 at 02:13:13PM +0100, Niklas Cassel wrote:
> The commit message in commit fc9a77040b04 ("PCI: designware-ep: Configure
> Resizable BAR cap to advertise the smallest size") claims that it modifies
> the Resizable BAR capability to only advertize support for 1 MB size BARs.
> 
> However, the commit writes all zeroes to PCI_REBAR_CAP (the register which
> contains the possible BAR sizes that a BAR be resized to).
> 
> According to the spec, it is illegal to not have a bit set in
> PCI_REBAR_CAP, and 1 MB is the smallest size allowed.
> 
> Set bit 4 in PCI_REBAR_CAP, so that we actually advertize support for a
> 1 MB BAR size.

s/advertize/advertise/ in subject, commit log, comment

I assume this probably fixes some user-visible problem?  If so, would
be nice to include sample symptom, e.g., dmesg log, bug report, error
message, etc.

> Fixes: fc9a77040b04 ("PCI: designware-ep: Configure Resizable BAR cap to advertise the smallest size")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> I'm working on a series that adds proper Resizable BAR support, but it is
> taking longer than expected, so I'm sending this fix first.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b..bb759a7b5fc7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -627,8 +627,13 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
>  			PCI_REBAR_CTRL_NBAR_SHIFT;
>  
> +		/*
> +		 * The PCI Express Base Specification require us to support at
> +		 * least one size in the range from 1 MB to 512 GB. Advertize
> +		 * support for 1 MB BAR size only.

Please include the spec revision and section.  I think "PCIe r6.0, sec
7.8.6.2" would be sufficient.

> +		 */
>  		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
>  	}
>  
>  	/*
> -- 
> 2.44.0
> 


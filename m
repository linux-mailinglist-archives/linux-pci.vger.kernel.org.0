Return-Path: <linux-pci+bounces-10741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8D93B6E6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8697C1C23B92
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6215FA7B;
	Wed, 24 Jul 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlBUYZSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032E1C693;
	Wed, 24 Jul 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846360; cv=none; b=f287MopLwhcB49suDplf3faEHgJInRsNuDwrywLtNbOq7ND/YQ0XWrJdhWc1/6ZwXzwK1FDjWEK6dNUdS33jMcqQov2DBRls5obvOOskoKAtaJAsoYMSqLRAM8Lyv5P2YrMsvUm222PIltHt37IOqRrmfiO/8N/T210dfbKa06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846360; c=relaxed/simple;
	bh=nPltv4qDZzZySxN7PwRobymjhC9n6VfeeKm/ItRhASA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ovPYfE+AijnTLk030SUmmYPWWJy5qZXh3PDRkZmW7zS10N/FrP+60KGi7Mx6zBRk8aWeiCmYMnAemt6xUxsQzU92cpbMjA5qB7kwFaeiHFHqyGJuQzplVVy3yufbkv4ZjuB60YKgMFafFw1RVBghajelScKNVpidCEqelA5eRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlBUYZSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBAFC32781;
	Wed, 24 Jul 2024 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721846360;
	bh=nPltv4qDZzZySxN7PwRobymjhC9n6VfeeKm/ItRhASA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HlBUYZSMkuyIUvF63W6OKsfttDyzKpoAcj6NdDJXVyA1Ic7ML+U7lyCrVp+xCCTHE
	 52beEQD7UpB1avufGcKdt2j8sEqZwGigPHe/eaxe2R30CBuaqHcXrxFyYTXvHHz4zm
	 nuB07598aE4BAvAPhph7vB21sJaMARaLRDwHwS5u4DV0IgWihFXkzI+BdJkSTbYe3W
	 bEKxoIao602qUBYaxkbxM2ufM4vl1RXAQZv44s11EnpKBjaI59y2l0phgq2E8n//N7
	 TFp4BniSVP0IixkQj0Xhn0MKKbgUlNkIreIXWwxY8DZtNrUVOG/x+ANdVINIoMOpN6
	 xHpnDHa0p9NdA==
Date: Wed, 24 Jul 2024 13:39:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
Message-ID: <20240724183918.GA806896@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>

On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
> driver to program the location of DBI and ATU blocks in Qualcomm
> PCIe Controller specific PARF hardware block.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 1b5aba1f0c92..bc3a5d6b0177 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
>  		if (IS_ERR(pci->dbi_base))
>  			return PTR_ERR(pci->dbi_base);
> +		pci->dbi_phys_addr = res->start;
>  	}
>  
>  	/* DBI2 is mainly useful for the endpoint controller */
> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
>  			if (IS_ERR(pci->atu_base))
>  				return PTR_ERR(pci->atu_base);
> +			pci->atu_phys_addr = res->start;
>  		} else {
>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>  		}
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 53c4c8f399c8..efc72989330c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
>  struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
> +	phys_addr_t		dbi_phys_addr;
>  	void __iomem		*dbi_base2;
>  	void __iomem		*atu_base;
> +	phys_addr_t		atu_phys_addr;
>  	size_t			atu_size;
>  	u32			num_ib_windows;
>  	u32			num_ob_windows;

This patch is pretty trivial and it doesn't show anything to justify
the need to keep these addresses.  I think this should be squashed
with the next patch that actually *uses* them.


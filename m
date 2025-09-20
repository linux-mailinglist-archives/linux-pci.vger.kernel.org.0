Return-Path: <linux-pci+bounces-36570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA5B8C179
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 09:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D783A80C09
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 07:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B13323C4E3;
	Sat, 20 Sep 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcWCpoId"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAB34BA52;
	Sat, 20 Sep 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758353944; cv=none; b=KMzYu1J17WngM8kS8Q7AkNAmQoZDRRZRU9uoXFdELDHQbR0LWUHF30f+XVIz3/VU1rdiAf0dRodu6QG2RxAucAavvx2xpL/tOZV49NklCHQkvT9BIkoRoCUvT+M4jqkKcwIKSGd9aaorsnOoNsog2w/oTNc5SN6+J0rQoT7G8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758353944; c=relaxed/simple;
	bh=sj+tflV0kHMCbQri64zoVlUok5g2vfYMLDu5l5fnDk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYbw8e95n2zs2gT2oIuYG+QASz8Ip9pORZTY6ukqCZ7kuIw7F8rg/HjN5eq4cMoBRin6Qq6pa9vpGMCgKebRz8YmbvYN7YFBeAYBNaWu0W+1wJ3zAp5RU7A6c8Id6aAbRRdYsw7tzzJZT3lrEsuZNgJ3NJvsIk3qsCIcqMKHq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcWCpoId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BC5C4CEEB;
	Sat, 20 Sep 2025 07:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758353944;
	bh=sj+tflV0kHMCbQri64zoVlUok5g2vfYMLDu5l5fnDk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcWCpoIdBnJQP1EH8pDFEfVUpO/FjhF+HkJ6O5IJjnMvPZpbw/6ALA7oZgM2IgqlA
	 7V/8MT0+ouzOobywMaXGXSdNC+YrDHREXR8uJ2AjMboT16AlMbHqATmNoA2azJLhJW
	 3eXdKBNACPQmZoRA9gYoo5bZ5L8uUTZMyZJG4ftt6TOPFpklyIDUZlZo4Xt17KsRlJ
	 TiSu11AysiAlG0uzUUik760u6vwF/olDV8647+ev2povbq70vDIPzSBku2dlQArjXz
	 LFaAjMDPWWVilbt/imqXyFgy3rFT2A+m+RDHLUrK+XFaXOyQoKNID5n0wKRCaGAoAj
	 oyd84F0gPK7ZQ==
Date: Sat, 20 Sep 2025 13:08:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] PCI: imx6: Add external reference clock mode
 support
Message-ID: <o3pajmedldkgpmqrnnnoz5nrbx6dz7vnodlpuc6tivbxvln6lf@nxuvdtqoixdx>
References: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918032555.3987157-1-hongxing.zhu@nxp.com>

On Thu, Sep 18, 2025 at 11:25:52AM +0800, Richard Zhu wrote:
> i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
> other from off chip crystal oscillator. The "extref" clock refers to a
> reference clock from an external crystal oscillator.
> 
> Add external reference clock input mode support for i.MX95 PCIes.
> 

Driver change looks good to me (except a nitpick that I reported, but I could
fix it while applying), but the binding patches need to be reviewed by the DT
binding maintainers.

- Mani

> Main change in v7:
> - Refine the subjects and commit message refer to Bjorn's comments.
> 
> Main change in v6:
> - Refer to Krzysztof's comments, let i.MX95 PCIes has the "ref" clock
>   since it is wired actually, and add one more optional "extref" clock
>   for i.MX95 PCIes.
> https://lore.kernel.org/imx/20250917045238.1048484-1-hongxing.zhu@nxp.com/
> 
> Main change in v5:
> - Update the commit message of first patch refer to Bejorn's comments.
> - Correct the typo error and update the description of property in the
>   first patch.
> https://lore.kernel.org/imx/20250915035348.3252353-1-hongxing.zhu@nxp.com/
> 
> Main change in v4:
> - Add one more reference clock "extref" to be onhalf the reference clock
>   that comes from external crystal oscillator.
> https://lore.kernel.org/imx/20250626073804.3113757-1-hongxing.zhu@nxp.com/
> 
> Main change in v3:
> - Update the logic check external reference clock mode is enabled or
>   not in the driver codes.
> https://lore.kernel.org/imx/20250620031350.674442-1-hongxing.zhu@nxp.com/
> 
> Main change in v2:
> - Fix yamllint warning.
> - Refine the driver codes.
> https://lore.kernel.org/imx/20250619091004.338419-1-hongxing.zhu@nxp.com/
> 
> [PATCH v7 1/3] dt-bindings: PCI: dwc: Add external reference clock
> [PATCH v7 2/3] dt-bindings: PCI: pci-imx6: Add external reference
> [PATCH v7 3/3] PCI: imx6: Add external reference clock input mode
> 
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml      |  3 +++
> Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml |  6 ++++++
> drivers/pci/controller/dwc/pci-imx6.c                          | 20 +++++++++++++-------
> 3 files changed, 22 insertions(+), 7 deletions(-)
> 

-- 
மணிவண்ணன் சதாசிவம்


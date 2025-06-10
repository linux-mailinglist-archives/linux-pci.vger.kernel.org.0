Return-Path: <linux-pci+bounces-29364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACC7AD4377
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 22:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231AF189D292
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E726561E;
	Tue, 10 Jun 2025 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX23vM6J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA2265611;
	Tue, 10 Jun 2025 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586066; cv=none; b=n+lwYv5XcwFNQI2Qcn/PqoW2Au5Cbb6cxVsQdrwCKRrll/uB7xjAjq8M8XC9ytd3qOSskeTYJwAmh5pvjdNAruTmewx1cGi9iTe6vf0hGfBq2RvoCWsWWkDi9tLZAv8owrztQ1D6z8aXcgJ4NiKJTIFwQu1hW8ISBJjgJAoUHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586066; c=relaxed/simple;
	bh=lbQngPJAmS13ljvDR/pW0TUmUN4LkzEaZLuRBDXzcOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wz+2Rfuao/It889dMHnj4+xSizGORgUoznTWklUxrHzIdikLoVsuZ/1DdpMfZpBwv4S3bv+muUjy4Kp/B08IMAhDC2lDJee4vzOx44p5YCLbhE23Lywps3/sQlVcp+uK6/QpyP16BwoWBEC1CQCvSWLpEPwcML5x//1f1wm01l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX23vM6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A72C4CEF2;
	Tue, 10 Jun 2025 20:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749586065;
	bh=lbQngPJAmS13ljvDR/pW0TUmUN4LkzEaZLuRBDXzcOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UX23vM6JvgwxNd+hm0flKLu2Gy/D5qE1UszYiy05r2Sijxti8K1ynp3VaVnhsCZA6
	 JYZe5h5y+BbJGaLMAxH5JKZU+SiYRDdwTmmnbvIKpn+t2Od+NM3zIYZqKdMO5MQUBs
	 e1fYFuo8olSap0530IHf+HcZhXaRniOgAQrXqo7aEEuSbYOBndyF85vB13sHqDmIYL
	 p11s1hOoKcQGHfIZsNIcRR7GZZVJde8N3shq69QJ5k2iDt+mWKBylX4NH1m6CN13dL
	 d/gCPIi/SfHvWJ/76MxPCnHIcNKLWyFjzEuBrwLuNw2utGdEk46pL7BGLr89T2adKR
	 cqjULovPTEttw==
Date: Tue, 10 Jun 2025 15:07:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] PCI: pcie-rockchip: add bits for Target Link
 Speed in LCS_2
Message-ID: <20250610200744.GA820589@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEQb5kEOCJNQJMin@geday>

On Sat, Jun 07, 2025 at 08:00:54AM -0300, Geraldo Nascimento wrote:
> Link Control and Status Register 2 is not present in current
> pcie-rockchip.h definitions. Add it in preparation for
> setting it before Gen2 retraining.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 14954f43e5e9..7a84899d3812 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -166,6 +166,9 @@
>  #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
>  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
>  #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
> +#define PCIE_RC_CONFIG_LCS_2		(PCIE_RC_CONFIG_BASE + 0xf0)
> +#define   PCIE_RC_CONFIG_LCS_2_TLS_25	BIT(0)
> +#define   PCIE_RC_CONFIG_LCS_2_TLS_50	BIT(1)

This stuff:

  #define PCIE_RC_CONFIG_DCR              (PCIE_RC_CONFIG_BASE + 0xc4)
  #define PCIE_RC_CONFIG_DCSR             (PCIE_RC_CONFIG_BASE + 0xc8)
  #define PCIE_RC_CONFIG_LINK_CAP         (PCIE_RC_CONFIG_BASE + 0xcc)
  #define PCIE_RC_CONFIG_LCS              (PCIE_RC_CONFIG_BASE + 0xd0)
  #define PCIE_RC_CONFIG_LCS_2            (PCIE_RC_CONFIG_BASE + 0xf0)

*Looks* like it might be duplicates of:

  #define PCI_EXP_DEVCAP          0x04    /* Device capabilities */
  #define PCI_EXP_DEVCTL          0x08    /* Device Control */
  #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */
  #define PCI_EXP_LNKCTL          0x10    /* Link Control */
  #define PCI_EXP_LNKCTL2         0x30    /* Link Control 2 */

where the PCIe Capability is at (PCIE_RC_CONFIG_BASE + 0xc0).

If so, can you please rework these to use the existing PCI_EXP_*
definitions, including the fields inside?

>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>  #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
> -- 
> 2.49.0
> 


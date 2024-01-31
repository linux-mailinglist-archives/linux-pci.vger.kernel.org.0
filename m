Return-Path: <linux-pci+bounces-2887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20835844334
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 16:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C719B1F25B38
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36B86AC5;
	Wed, 31 Jan 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRxtWjsQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B06EB6E;
	Wed, 31 Jan 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715471; cv=none; b=NwrX/Jy4M6QcHJUFF0eZBTjTrAlsxGoW0HedOn4/PztX9m/jax40HhZxVhP+3j7CjhkxnqPiyCvWq4or4tFjsJ+GWc04XAC2ZW29rwpAPyWFBFYC+u3JBXdR+OCS4A7np6mBEpM29K3zSR1c/MaNZpBNsTGX3dwmCdBdQTfMTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715471; c=relaxed/simple;
	bh=NLu5RhQDHjuoWdQ7ATBAXWr7+B9giVQ1tClFHkObJS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LnehuG5u2ODZPEcbN5Cjf0R8qCaeM8qD8C0vHlaQCMnWOqvICwo4zLmLppH0uj5x1oa+T5lj/ON97Ks4gxLZK7cFTRTZREYok9ij+BGkcG0Xi5wMimunOdBlL9VTiNZnZ1kjAVFHcSjiyH9x5G06ly9MSe1T5T+3Ym+YuZOLbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRxtWjsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C4CC43390;
	Wed, 31 Jan 2024 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715470;
	bh=NLu5RhQDHjuoWdQ7ATBAXWr7+B9giVQ1tClFHkObJS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QRxtWjsQrKxV8wn5tiT+hyR8fxLyWD56t7JdxX0F25qs+QkwbsbymnPS2kODrM8K5
	 WSbdltD1Uif8EYPgP30Jjni+6Q2o2NqrGKVusaatjPdUKkP7xTp8OoEjWNclp3yrHZ
	 d3gCwHPJ2YLqrdqnoSpF7xj+jG/jhTbxW+HHsUP+f/rwBFXHIUnAoU9Y+Pd7o/ili/
	 JFGJ6aquyLJqn0G+hKtF5puvFv3G+yxsGedrslEyMpmUiC4DJA870gZZ9X5zLJP5ce
	 jEu894erBsFm4lpoQCci0m0O7CXt1DVx+qkDuyGHiF4L/QCEaB925IhgLkgDKAHUuN
	 ikQZD5arf86cw==
Date: Wed, 31 Jan 2024 09:37:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 1/6] PCI: Add INTx Mechanism Messages macros
Message-ID: <20240131153748.GA586693@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-pme_msg-v1-1-d52b0add5c7c@nxp.com>

On Tue, Jan 30, 2024 at 07:45:26PM -0500, Frank Li wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Add "Message Routing" and "INTx Mechanism Messages" macros to enable
> a PCIe driver to send messages for INTx Interrupt Signaling.
> 
> The "Message Routing" is from Table 2-17, and the "INTx Mechanism
> Messages" is from Table 2-18 on the PCI Express Base Specification,
> Rev. 4.0 Version 1.0.

Please cite a newer spec revision, e.g., PCIe r6.0 or r6.1.

Also, please cite section numbers instead of table numbers because the
table numbers are hard to find (you can't navigate to them from
"Contents") and they change a lot between spec revisions.  "INTx
Mechanism Messages" is Table 2-21 in r6.0, but it's in sec 2.2.8.1 in
both r4.0 and r6.0.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

With these updates:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2336a8d1edab2..fe42f5d10b010 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -22,6 +22,24 @@
>   */
>  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>  
> +/* Message Routing (r[2:0]) */

Add citation to the comment: "PCIe r6.0, sec 2.2.8"

> +#define PCI_MSG_TYPE_R_RC	0

I think I would prefix all these with "PCIE" instead of "PCI", since
they are specific to PCIe and we already use "PCIE" for some of the
PCIe-specific timeouts.

> +#define PCI_MSG_TYPE_R_ADDR	1
> +#define PCI_MSG_TYPE_R_ID	2
> +#define PCI_MSG_TYPE_R_BC	3
> +#define PCI_MSG_TYPE_R_LOCAL	4
> +#define PCI_MSG_TYPE_R_GATHER	5
> +
> +/* INTx Mechanism Messages */

Add "PCIe r6.0, sec 2.2.8.1"

> +#define PCI_MSG_CODE_ASSERT_INTA	0x20
> +#define PCI_MSG_CODE_ASSERT_INTB	0x21
> +#define PCI_MSG_CODE_ASSERT_INTC	0x22
> +#define PCI_MSG_CODE_ASSERT_INTD	0x23
> +#define PCI_MSG_CODE_DEASSERT_INTA	0x24
> +#define PCI_MSG_CODE_DEASSERT_INTB	0x25
> +#define PCI_MSG_CODE_DEASSERT_INTC	0x26
> +#define PCI_MSG_CODE_DEASSERT_INTD	0x27
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> 
> -- 
> 2.34.1
> 


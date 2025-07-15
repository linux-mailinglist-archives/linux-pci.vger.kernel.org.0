Return-Path: <linux-pci+bounces-32175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 971FDB06342
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD9B1AA422B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DFB246BA1;
	Tue, 15 Jul 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em5tJsih"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B1221F34;
	Tue, 15 Jul 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594107; cv=none; b=TfEbG8VSLg0udzFWzcsLJk4BYwxRV216UjyJSa6CvrIlUAiNzetcArRX56WzF7DmQJoKTdHMctJkJie2TxFrxW9l05hKcA/avVuKDXUMEvEgEHDnRluegt8F1QdxUjwbDpoVz1fUTpFrwFi+xXjjSSXCTfHUJL1KW4c6TRRO4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594107; c=relaxed/simple;
	bh=5b56qrNXj/OfNJ271j1G/qJdm0poMtreLVVNIaR5qWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gM48KaU2cpQqu8LmJ14BauhpXTcts9I5TMEFxIKA+U5lQtD9J7ow+gkWcc9xAnso9VlL+xTUeSHJlHPxJLOj998Ib9YsLx26RdSX8D8+GCSxfLTYR1491553tkaHDJJXPd2D6ajFbwpuwgSsy2tKJWWLju/skZ/Sc2f4GNJ2PlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em5tJsih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9445C4CEE3;
	Tue, 15 Jul 2025 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752594107;
	bh=5b56qrNXj/OfNJ271j1G/qJdm0poMtreLVVNIaR5qWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=em5tJsihWZBOan5zIsQ+cSPCgN/Rzp4PaCrte3ake8mi3AWxsjrrCK82IG5RHPyd3
	 QNuI2jxfMyfWMgyviwYRD5CjVdfWzVtyF9fUoMjIPN4q8876pn6mtbVehydcJoUA4B
	 WUwoUbvxn6ip1JsTZTzJce5dAE+IYh9+ZgOBl3XzUfOlprqkrzlFDRLdGyINL/cJX1
	 KmGccngAWOPzR+MRfSAvKVgFTFM2L8FUVYtxkYAEds6vLp3H7gliyxIIQIfpYv8WY5
	 J/mLGzM5se86kFo2Q8RqS4AxPDLGe37gOLscWUJNDFq1gzFiNI0OhvEEEohYvd6R73
	 CSVVVH/eWhvNQ==
Date: Tue, 15 Jul 2025 10:41:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 08/10] PCI: Add FMT and TYPE definition for TLP header
Message-ID: <20250715154145.GA2461632@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715034320.2553837-9-jacky_chou@aspeedtech.com>

On Tue, Jul 15, 2025 at 11:43:18AM +0800, Jacky Chou wrote:
> According to PCIe specification, add FMT and TYPE definition
> for TLP header. And also add macro to combine FMT and TYPE to
> 1 byte.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  include/uapi/linux/pci_regs.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

I don't think these definitions are relevant to uapi users, so they
could go in drivers/pci/pci.h, similar to the existing PCIE_MSG_*
definitions.

Please follow the style of PCIE_MSG_*, including the brief spec
citations and /* */ comments.

Not sure we need *all* of these; it looks like you only use:

  PCI_TLP_TYPE_CFG0_RD
  PCI_TLP_TYPE_CFG0_WR
  PCI_TLP_TYPE_CFG1_RD
  PCI_TLP_TYPE_CFG1_WR
  PCI_TLP_FMT_3DW_NO_DATA
  PCI_TLP_FMT_3DW_DATA

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a3a3e942dedf..700b915e00f5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1230,4 +1230,36 @@
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>  
> +/* Fmt[2:0] encoding for TLP Header */
> +#define PCI_TLP_FMT_3DW_NO_DATA		0x0  // 3DW header, no data
> +#define PCI_TLP_FMT_4DW_NO_DATA		0x1  // 4DW header, no data
> +#define PCI_TLP_FMT_3DW_DATA		0x2  // 3DW header, with data
> +#define PCI_TLP_FMT_4DW_DATA		0x3  // 4DW header, with data
> +#define PCI_TLP_FMT_PREFIX		0x4  // Prefix header
> +
> +/* Type[4:0] encoding for TLP Header */
> +#define PCI_TLP_TYPE_MEM_RD		0x00 // Memory Read Request
> +#define PCI_TLP_TYPE_MEM_RDLK		0x01 // Memory Read Lock Request
> +#define PCI_TLP_TYPE_MEM_WR		0x00 // Memory Write Request (Fmt must be with data)
> +#define PCI_TLP_TYPE_IO_RD		0x02 // IO Read Request
> +#define PCI_TLP_TYPE_IO_WR		0x02 // IO Write Request (Fmt must be with data)
> +#define PCI_TLP_TYPE_CFG0_RD		0x04 // Config Type 0 Read Request
> +#define PCI_TLP_TYPE_CFG0_WR		0x04 // Config Type 0 Write Request (Fmt must be with data)
> +#define PCI_TLP_TYPE_CFG1_RD		0x05 // Config Type 1 Read Request
> +#define PCI_TLP_TYPE_CFG1_WR		0x05 // Config Type 1 Write Request (Fmt must be with data)
> +#define PCI_TLP_TYPE_MSG		0x10 // Message Request (see routing field)
> +#define PCI_TLP_TYPE_MSGD		0x11 // Message Request with Data (see routing field)
> +#define PCI_TLP_TYPE_CPL		0x0A // Completion without Data
> +#define PCI_TLP_TYPE_CPLD		0x0A // Completion with Data (Fmt must be with data)
> +#define PCI_TLP_TYPE_CPLLCK		0x0B // Completion Locked
> +#define PCI_TLP_TYPE_CPLDLCK		0x0B // Completion with Data Locked (Fmt must be with data)
> +#define PCI_TLP_TYPE_FETCH_ADD		0x0C // Fetch and Add AtomicOp Request
> +#define PCI_TLP_TYPE_SWAP		0x0D // Unconditional Swap AtomicOp Request
> +#define PCI_TLP_TYPE_CMP_SWAP		0x0E // Compare and Swap AtomicOp Request
> +#define PCI_TLP_TYPE_LOCAL_PREFIX	0x00 // Local TLP Prefix (Fmt = 0x4)
> +#define PCI_TLP_TYPE_E2E_PREFIX		0x10 // End-to-End TLP Prefix (Fmt = 0x4)
> +
> +/* Macro to combine Fmt and Type into the 8-bit field */
> +#define PCIE_TLP_FMT_TYPE(fmt, type)   (((fmt) << 5) | ((type) & 0x1F))

This looks like it might be controller-specific and could go in
pcie-aspeed.c.


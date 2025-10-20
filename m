Return-Path: <linux-pci+bounces-38730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B8BF0C68
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362DD18A073C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336382F83DF;
	Mon, 20 Oct 2025 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlZryOFe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE825229C;
	Mon, 20 Oct 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958880; cv=none; b=QLfHxL29bvcDOlJUlzTXyoZb+5HL8D5oSjjoZzGxcCKHJZBiTpE1e0IweTD+IXvs4ppxnhS/n/dm8ZCrLOQ3qyHg2eyPGKrGiwc9UcE2MqsPG7cBYvNctGJcVknPs7RfaCqdKDInTWettjllxNhcviBke0y/bqjvTYoGmPThcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958880; c=relaxed/simple;
	bh=V62uDvINV9pfoVeOC2Ljq6Nrt7DgmFMZhMqR7vMAx0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgNVq1VNIPHnXpedA3ESQWs1+rRU/Qu9fr9NZQfzd1mtQ8J20bYQqa0jD2pnsF0WTygI6GlqpAjmsqJq2Ft1iNxiaDnZA0ejVvNLMHcfE5xwSf4FAZWgMdmj2FxQJfkmWLD1s+Sy+q17wUnCJ4v+DckoRlvyekmDy1valZyX8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlZryOFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AD3C4CEF9;
	Mon, 20 Oct 2025 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760958879;
	bh=V62uDvINV9pfoVeOC2Ljq6Nrt7DgmFMZhMqR7vMAx0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlZryOFeHJf9xG35np+I8SQEsCotqwkDYwGHMmcPhmkWb/+OUt7FEPDQEtoM9Cicq
	 PtOoFgtyHTf4CkrHhwYQFmRYyDNm/0LyyKw5uMAyA8Hc+fRyzuJqefn7VgeOjk8aWs
	 l32RAGqkrBvI2scqZqfWAC9h0lW6NFP64HicXaUJKbFG2SYArjryLEhDW+vT9dpwxK
	 Cm3n5XLDwQYeg54lUlm1e5e1FP5DCHkhNsiQiXD9PJj9p8QLQg+sShRcpTtSSCZ7Dv
	 y9tJGge0cSSG/Xb+iR31uvMLKrDZ3yLS1KwgYCE3w1d2o5o4Wu/tQdqp5VYeC9W8Xg
	 fi3j/06XLJAwg==
Date: Mon, 20 Oct 2025 13:14:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Vitor Soares <vitor.soares@toradex.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add optional
 regulator supplies
Message-ID: <20251020-kickass-fervent-capybara-9c48a0@kuoka>
References: <20251014112553.398845-1-ivitro@gmail.com>
 <20251014112553.398845-2-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251014112553.398845-2-ivitro@gmail.com>

On Tue, Oct 14, 2025 at 12:25:48PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Add optional regulator supply properties for PCIe endpoints on TI SoCs.
> Some boards provide dedicated regulators for PCIe devices, such as
> 1.5V (miniPCIe), 3.3V (common for M.2 or miniPCIe), or 12V
> (for high-power devices). These supplies are now described as optional
> properties to allow the driver to control endpoint power where supported.

Last sentence is completely redundant. Please do not describe DT, we
all can read the patch. Driver is irrelevant here.

How you described here and in descriptions, suggests these are rather
port properties, not the controller.

> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index c704099f134b..a20b03406448 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -110,6 +110,18 @@ properties:
>        interrupts:
>          maxItems: 1
>  
> +  vpcie1v5-supply:

How is it called in this device datasheet (not the board schematics)?

> +    description: 1.5V regulator used to power PCIe interfaces,
> +                 typically present on miniPCIe slots.

Best regards,
Krzysztof



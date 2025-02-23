Return-Path: <linux-pci+bounces-22128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC2A40DC0
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A951894E9B
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2901FECCB;
	Sun, 23 Feb 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSUUKBfa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07C198E7B;
	Sun, 23 Feb 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303810; cv=none; b=eJYxlaB5fCU8D+XYiIwKG6w1CC+wBT1q9sOtPiv08CQg+gvIc/9MTDwliQlJ8yEc4I69oTibwDmPtWXxfbcDk50vUBGGP9UW13yL+BDq4U9Byl518UllYZVlp3xov7YIoU1Lk6Dm7oOumWKHoqqCsbczXcQ+5cePGrmeJuk5o30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303810; c=relaxed/simple;
	bh=n3VmuDkahaRSXSSONIGxA6K3sJl+bXqC/Tuu5fPag6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=butuhgMxUht1mxO8H/JgjZAc6k8ap49bJQIiD6EbRlqAZvgCDKddAYrfcw+NOQIE6ZyhOnXfUeBYVAIa5fg51wg9S7iHA6R6t1zP4xrexr9RdQjqd+pUcD4reu2pU3w8XsHYvZUuz1c88Q4WcFI7k0Xur0VgUwjaOTBJME/29ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSUUKBfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C96CC4CEDD;
	Sun, 23 Feb 2025 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740303809;
	bh=n3VmuDkahaRSXSSONIGxA6K3sJl+bXqC/Tuu5fPag6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSUUKBfaBVt20BCaE2r4RGaUbqvbpZAtRTPBl99e3OjmAUd3O/MxP/xt7JwAZVX5K
	 ASSWS6hMqB4DFthWyh/373e6K4DDXdhdUF4WUjEMUb/q8LIe2+FRc1EBfNNJTCTqga
	 kau5tCytLK1rOe3QMF3k+LR2E4Z7YuWg0e4BIyV3N+TDFVEjikyzeFCvfoPo6shAZ4
	 Z7eJuiS0WrYL5I8mtAYgh6DXqjWc2uGRS8pYTsUCO+Nkk+v6A8+PgMvzvR0pRVWXop
	 VoBn1u6JZksCjMtB4006IMgP3NJfFNikGliU4Grk3Btu3eoYIyVNG0YuvT7K91ibiQ
	 sqOKU8UXP5XDw==
Date: Sun, 23 Feb 2025 10:43:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add
 mediatek,pbus-csr phandle array property
Message-ID: <20250223-hulking-goldfish-of-symmetry-cbfed4@krzk-bin>
References: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
 <20250222-en7581-pcie-pbus-csr-v3-1-e0cca1f4d394@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222-en7581-pcie-pbus-csr-v3-1-e0cca1f4d394@kernel.org>

On Sat, Feb 22, 2025 at 11:43:44AM +0100, Lorenzo Bianconi wrote:
> Introduce the mediatek,pbus-csr property for the pbus-csr syscon node
> available on EN7581 SoC. The airoha pbus-csr block provides a configuration
> interface for the PBUS controller used to detect if a given address is
> accessible on PCIe controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

You got review tag, so if you decided to skip it, this should be
mentioned why.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



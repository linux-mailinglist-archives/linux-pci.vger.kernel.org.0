Return-Path: <linux-pci+bounces-20688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61626A26D10
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 09:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E563A714C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF32063FE;
	Tue,  4 Feb 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4QJJz6c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264D204C1D;
	Tue,  4 Feb 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738656854; cv=none; b=Vg9zF+eOuatpJLCmJ/FzQtv3DyG2Mt7wgqCUg78Vz0d3Y7GKiU8/60uiSU8gmoGzhLVdBNY3OHp1t5zeyUFCly3WmlyyMwIDXJ5SbUIARHbssffza/yKQcWLTgpNkFk9BZag5kX4Db6o2HZb01x5q6nhu7WtW2bxY67tdc9VyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738656854; c=relaxed/simple;
	bh=NABi+abZbTj0AxkLzpEHm04MmqQQL8FK5laY+2FfNwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM+A1wDPE5Ne1BFe7PSBvjycFKMsXf/iDgQecBGEXHaYHBfZg2CZug//IpSFSshIw9mWsaEWUqx9kRBaFOg2FgOMv9IuPfVOzNduRjQQYcnxUhNNxPjj3lE3PLbXvqWcWf8qRrb/7zdd2nBgqsDekyJ2swbzZewCJO0ekxe2byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4QJJz6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D47C4CEDF;
	Tue,  4 Feb 2025 08:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738656853;
	bh=NABi+abZbTj0AxkLzpEHm04MmqQQL8FK5laY+2FfNwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4QJJz6ctD223xa9a+xa05n4ENBX/8rHr5yspO2YdRb6DRclEGBcgo2w882H8sw6t
	 KT4FYsSr8f/eTWV2Iaw3sNeBIREzv4ychkMfAu3ehcE9Cgs36b5YlXPDoXluDhEKjz
	 V1ovvCOaxdhJwtM94ANrgNvXtH9II1C1fLQMs8m6xY4UqQeelG11Ab85oqbe9yRsu2
	 bIqMRQ5Aa/QUre750ifxr9g8UjJUZ+dN7jZPFlQ8W95rJ2HsM+xkT1czQLiGGikheU
	 p9PMNksdnSCfytde1FrPatbWT104sKvGNieLJ6BvrkmIzo0DbIBIep9gHK4M477EvZ
	 loOWQ3P7KlrmQ==
Date: Tue, 4 Feb 2025 09:14:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: Add
 mediatek,pbus-csr phandle property
Message-ID: <20250204-fiery-wisteria-marmoset-97af90@krzk-bin>
References: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
 <20250202-en7581-pcie-pbus-csr-v2-1-65dcb201c9a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250202-en7581-pcie-pbus-csr-v2-1-65dcb201c9a9@kernel.org>

On Sun, Feb 02, 2025 at 08:34:23PM +0100, Lorenzo Bianconi wrote:
> Introduce the mediatek,pbus-csr property for the pbus-csr syscon node
> available on EN7581 SoC. The airoha pbus-csr block provides a configuration
> interface for the PBUS controller used to detect if a given address is on
> PCIE0, PCIE1 or PCIE2.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



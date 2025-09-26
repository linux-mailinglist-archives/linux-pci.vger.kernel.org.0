Return-Path: <linux-pci+bounces-37138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B705ABA52ED
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A567AAA8C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2595286424;
	Fri, 26 Sep 2025 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE4nCsRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244E34BA4D;
	Fri, 26 Sep 2025 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921296; cv=none; b=XmicZe2DXHoYOacuy/q6XyDQRtKczJ8HiJZjFhPwLgOtE7JMejCfemCkMvjK6cpm1nDNLPF9QbjI2JkDAx/VKB0IH0coKrZyxzEWGb8f9jgTWykYLItDKcZFxl/0N4Z+TPXeYLj60ORX2JJtRTwNqinNSjGT/YXEgzx8EGvV8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921296; c=relaxed/simple;
	bh=WEqmaCU0BUDs5OjoAtWYAf0UL/AzG1dPeDjq72rC0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXNe1pez/XPZXUi1E1xCPaPNTZ7iFgpd5zjfEIvgPprXSidbjMPDTB0MKsZfd13Lt6YIPQ4OVXKY/lZEiP9VB/D0H2n7VTuCmewrB+pcnR3KEXVRQ7nrtZewrabb0jnT6Xm43FjItcEzBDvnFk7o9/KIlrGtDdgQEW0/HEo02vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE4nCsRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A175C4CEF4;
	Fri, 26 Sep 2025 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758921296;
	bh=WEqmaCU0BUDs5OjoAtWYAf0UL/AzG1dPeDjq72rC0sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XE4nCsRfeX1KRU9BbescvWUhEXzKjBfCTlQiq6RXU4SjCmO+CQ6EG7NOgkP2TF+fw
	 jsFFtzi37veH+wot+rXL5XNBcur565rL2r2nuiOEZXPduUvMNBslnqnrg0jC2sK9y1
	 auFrD1H9xCn/yrjBF5+c8a1lD8q6Kdozz+bu7kTuEZzg0lyoG7lmCWM+xkjh43xfkv
	 dvT2YloG43TShqbBJ22bTVF9QQRZkvYgx3l/gK3C74JvpJ8MmpulthRWQw7C69m3Es
	 j6EdGhc1d0p5ViH3czbtK09JFZN86sCYAupvTSlyYHoKGNdUQubXwgDO7voiOqqvtl
	 cfXXFL6YjDb7A==
Date: Fri, 26 Sep 2025 16:14:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, upstream@airoha.com,
	Ryder Lee <ryder.lee@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 Airoha AN7583
Message-ID: <175892129219.1571962.13823264512166648033.robh@kernel.org>
References: <20250925155330.6779-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925155330.6779-1-ansuelsmth@gmail.com>


On Thu, 25 Sep 2025 17:53:08 +0200, Christian Marangi wrote:
> Introduce Airoha AN7583 SoC compatible in mediatek-gen3 PCIe controller
> binding.
> 
> This differ from the Airoha EN7581 SoC by the fact that only one Gen3
> PCIe controller is present on the SoC.
> 
> The compatible have -gen3 tag as the Airoha AN7583 SoC have both GEN2
> and GEN3 PCIe controller and it's required to differentiate them as
> different schema are required for the 2 PCIe Controller variant.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> Changes v3:
> - Add review tag
> - Add comments for compatible inconsistency
> Changes v2:
> - Fix alphabetical order
> 
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



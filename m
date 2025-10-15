Return-Path: <linux-pci+bounces-38224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC9BDEE10
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF554039C6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730C02405E8;
	Wed, 15 Oct 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9i78eep"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446AB23BD1D;
	Wed, 15 Oct 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536780; cv=none; b=JgHHmDjDEfcgBZV0YIGBudjY3R3jqrDFy8+ifB4IeifRl9WwdsdRCv1YkP8dSB7SVZ+k+hN2EUli1WiO1M/ybXvdO19mY8emUN7xQQUWf208expl/cXGIq9yXnfKeXHL7N8i/Ew8DsQZk20k0oopP3qzRpG+lnRl4J2A8Ydqz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536780; c=relaxed/simple;
	bh=DwUHoZqWcYMyz1nussrz3FQ3Rsn+co8/zERGpsHFIEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhBEdfdLdeqoW8gG+zKRh94NgqajiucLvktK8cjmQjJ8Sz18YIs7Oi4rlqMiOmRTsf8T8GIhalVKiGNG9e+SdUrvUOKNqJt6l5rM7CaTjMcwVUDzteQrTZnw4w/Iken2+atkem56Ud7Vlt36uZjyjOkKDkpSsqlaWpmRBW+H7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9i78eep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F20AC4CEF8;
	Wed, 15 Oct 2025 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760536779;
	bh=DwUHoZqWcYMyz1nussrz3FQ3Rsn+co8/zERGpsHFIEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9i78eep6JNFh+dgLuDlH5N5/XKr7p8sX9bdlHGb5p84TEWW/KHf6y4gPJ/+pSDAG
	 jX//HgZzYp7+gI4qlRNXZZHMTsK44rlSr6m4/q5mq6s1H86Ifo7126uS/LyyO8apTw
	 sV5uRoUjUJtIrz/1FdXmRQgBeOZ6w/mvj+ij6SRXuTKfait1Dz0CgjpIYJR033Yy79
	 B2CfEoZ2ilfxIDuJ5mHK7kW29ZvLTVTWhIJYAm7QvnXpSsr7GVoRXWGidQT2bPOc6X
	 0d5zfxS3obmsutrDBfpq6hEAsWba+gs+4IorVyAMbFH0XyW+pFGzPsHCx6KIpNNO98
	 +CQ6h501WN8SA==
Date: Wed, 15 Oct 2025 08:59:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Ryder Lee <ryder.lee@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, upstream@airoha.com,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/5] dt-bindings: PCI: mediatek: Convert to YAML schema
Message-ID: <176053677610.3299416.10324456171470635844.robh@kernel.org>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
 <20251012205900.5948-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012205900.5948-3-ansuelsmth@gmail.com>


On Sun, 12 Oct 2025 22:56:56 +0200, Christian Marangi wrote:
> Convert the PCI mediatek Documentation to YAML schema to enable
> validation of the supported GEN1/2 Mediatek PCIe controller.
> 
> While converting, lots of cleanup were done from the .txt with better
> specifying what is supported by the various PCIe controller variant and
> drop of redundant info that are part of the standard PCIe Host Bridge
> schema.
> 
> To reduce schema complexity the .txt is split in 2 YAML, one for
> mt7623/mt2701 and the other for every other compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/pci/mediatek-pcie-mt7623.yaml    | 164 +++++++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ----------------
>  .../bindings/pci/mediatek-pcie.yaml           | 318 ++++++++++++++++++
>  3 files changed, 482 insertions(+), 289 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



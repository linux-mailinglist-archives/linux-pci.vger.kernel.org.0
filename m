Return-Path: <linux-pci+bounces-38225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 909D3BDEE1A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 910594FD05F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844A124A06D;
	Wed, 15 Oct 2025 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxRVPNxT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627715B0EC;
	Wed, 15 Oct 2025 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536816; cv=none; b=VaruXYebljN8W1ksrerUYzJpu7r6Mab6vnobNSi8f6m27nswHR1nYoGh5iugirkW7DCJBg5YuRwnUZ9cYA7f+PWvZSJPqltSUzNdlvkM2nQqk6qJIRTzcyiRmaywDG+3V4LVSIlYYvFH0KGqqx5TYGvtzh5LoiD4DgvcjWga+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536816; c=relaxed/simple;
	bh=CFCf1jlvWWOR/a6zkgwqZYSPmfb3AShgDFzbIXQWQOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puKfAU0K801NdgXBpxKke1Oy0kyZ6FAd3MqYymWvhpuvfoYgKqpkQQaQtkxk+BTJ8/mBsP2r/2Gm2WYl/81mHINEl9aIKwwKRnKgZHL8IO8DwbHoXtyiA/BRzVLSk0kFo1dUK002Vh9FZ+23iXuC6yiGQS2o+pQZN5Tr+PKVjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxRVPNxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8C2C4CEF8;
	Wed, 15 Oct 2025 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760536815;
	bh=CFCf1jlvWWOR/a6zkgwqZYSPmfb3AShgDFzbIXQWQOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxRVPNxTJEZrwlxkuY1eKTFhrZhKXnwRscbJ7VUzY9GgzJ+PQebmlbNSTi15ZBt9U
	 xoDvIxMLiw6q1SUpss4Ae4UReY0SCbP3RUaDRJe4XhBemugb8m2gcy1+XWOpZW9zay
	 Ii2jX7rVmR1IV/0HIM+QPn3kmfdUdtAWHrr2a3jOwoTmp5rGalA8ADoLmYFd3I1INe
	 oTOS/zZBinBbqRbrOY3yrUE5Zj8KthPA7pGenTEKmJkRlmijzicanovCH69HkImXSh
	 0feFCF2t43Of1zEgQ3lFk8H2Q+Zh0KGLSH5v3m08GXkHyMKQQZzpODL6enQq/4jsGw
	 ST8ahiKMsFP3A==
Date: Wed, 15 Oct 2025 09:00:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, upstream@airoha.com,
	Ryder Lee <ryder.lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/5] dt-bindings: PCI: mediatek: Add support for
 Airoha AN7583
Message-ID: <176053681339.3300147.17032986972081820170.robh@kernel.org>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
 <20251012205900.5948-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012205900.5948-4-ansuelsmth@gmail.com>


On Sun, 12 Oct 2025 22:56:57 +0200, Christian Marangi wrote:
> Introduce Airoha AN7583 SoC compatible in mediatek PCIe controller
> binding.
> 
> Similar to GEN3, the Airoha AN7583 GEN2 PCIe controller require the
> PBUS csr property to permit the correct functionality of the PCIe
> controller.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/pci/mediatek-pcie.yaml           | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



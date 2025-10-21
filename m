Return-Path: <linux-pci+bounces-38838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A311BBF456F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F54467AF7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 02:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AC51DF26E;
	Tue, 21 Oct 2025 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLy1mWPv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71339635;
	Tue, 21 Oct 2025 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012137; cv=none; b=hYD0x3UzBiIGm0GgIvUeCufXFrmKVsNxOX/YxmxAALWz/P6o3hZ6srbK0B3O8WidMR34vmDkg0BhGsJpaBqNz3HCpzpnhXZuHZAXHE7mHq9AdQSZrriebjWCh8I4iHL7GY2MFmvkYewd9A8SOCkI3YzFjWbabDax6peexq2JzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012137; c=relaxed/simple;
	bh=TRQYyxs7TnyIhaiMb8D95ZijpF7uVPE/ggwWxM/U7eM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PxNP5V5a0ShKnXZJlZFH+r4F8+H/tncjJUDCHRXYNX31uAlFzbriqhfjQxwWimGRPUJkv9A9nGrqX1HAP4cdkykMjA3D7eqnNVa5bWOExJduvSyk31Rb4+unM39YNUNfytXzSY4vizHOcLBzUncqSZ9uqDap4mlZn8MaQk30EmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLy1mWPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C187C4CEFB;
	Tue, 21 Oct 2025 02:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761012137;
	bh=TRQYyxs7TnyIhaiMb8D95ZijpF7uVPE/ggwWxM/U7eM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YLy1mWPvG5DR6ktlfj0FdnbLK0ptkdNbUqQsBCBH4a2s9UT/2khvcyGjKdvlql9v6
	 uf1TPwdjz7XTejtsN1CXKvFMOBJ4X77+LGf12zEjrqVRrrs7vRV4udw4MF0qSKeBJ8
	 P6kOFqlN3iijLhGcoxp34zgZjWo+c3eWzP43UpA2fuUMA4vHvcgQBfLcoxNFnpfOqH
	 LTW8eQ7ywb3N7nB6PU1ctPgw+GQYGaruvcrkxXpl9Xch5ioQJ09TPM9SMmUXRDY4O5
	 sgW5vY+YHZZBu8H9RPCnyRsg0XG7WFEvpas1SZHuc8RrOalGz+TgT9Iz9YFurgFORU
	 T6FkVfZQXl0ww==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20251020111121.31779-1-ansuelsmth@gmail.com>
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: mediatek: add support AN7583 + YAML rework
Message-Id: <176101212970.8564.11599336217062076445.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 07:32:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 20 Oct 2025 13:11:04 +0200, Christian Marangi wrote:
> This little series convert the PCIe GEN2 Documentation to YAML schema
> and adds support for Airoha AN7583 GEN2 PCIe Controller.
> 
> Changes v6:
> - Flags -> quirks
> - Align commit title to previous titles
> - Drop redundant comment for PCIE_T_PVPERL_MS
> - Drop DT merged patch
> - Add Review tag from Rob
> Changes v5:
> - Drop redudant entry from AN7583 patch
> - Fix YAML error for AN7583 patch (sorry)
> Changes v4:
> - Additional fix/improvement for YAML conversion
> - Add review tag
> - Fix wording on hifsys patch
> - Rework PCI driver to flags and improve PBus logic
> Changes v3:
> - Rework patch 1 to drop syscon compatible
> Changes v2:
> - Add cover letter
> - Describe skip_pcie_rstb variable
> - Fix hifsys schema (missing syscon)
> - Address comments on the YAML schema for PCIe GEN2
> - Keep alphabetical order for AN7583
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: PCI: mediatek: Convert to YAML schema
      commit: 99f988953f07484a2c4801c1d3493282f60effd8
[2/5] dt-bindings: PCI: mediatek: Add support for Airoha AN7583
      commit: 6d55d5a7f34b04b3a55dd90a6c3cea5a686e089f
[3/5] PCI: mediatek: Convert bool to single quirks entry and bitmap
      commit: 04305367fab7ec9c98eeba315ad09c8b20abce93
[4/5] PCI: mediatek: Use generic MACRO for TPVPERL delay
      commit: 2d58bc777728bfc37aa35dce7b90e72296cceb9f
[5/5] PCI: mediatek: Add support for Airoha AN7583 SoC
      commit: 09150ab1a7d204e8d03edb286f906c8d55168644

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



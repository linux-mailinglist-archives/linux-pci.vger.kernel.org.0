Return-Path: <linux-pci+bounces-22292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE7A436E8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F877189C5A4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDB42153E6;
	Tue, 25 Feb 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0L7W7NN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D16175D5D;
	Tue, 25 Feb 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470650; cv=none; b=EufdBOZ6crsRVqDfDjTBpGMT/hdE0aNCVWKtzN4ZLiUNH+LkyI+oT+zQJz+8edaYrMDun8FPiEq0H7hAoY5rQUYQTRO8FhWVRbiUWqCrLJXZ3S69Wq3uD2uZhmVQnZN5uHRL8/AtsCM19n0h5tSjwotnPG8Jn/NyWdP721+fdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470650; c=relaxed/simple;
	bh=Q/hlg5DJCs52keNQavSLTdyq9yKobf8eiX9XyuPCwnU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iLLy3tizHdEruYfxQjK1JSGZxkExSs1RXKSvqtw/vPzTh7I7LRykInD3aavb45RSOnkCEmlk9Kg4Lk2Z5BTEoHSpm/xDBeUP1r2YxoSpYr3vXCOqxEx7HdKONlkIjrsFaOGDvUaZSoK0Zdy4uqTZN72sae3QjajqE7YzdcQSjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0L7W7NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476AAC4CEDD;
	Tue, 25 Feb 2025 08:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740470649;
	bh=Q/hlg5DJCs52keNQavSLTdyq9yKobf8eiX9XyuPCwnU=;
	h=From:Subject:Date:To:Cc:From;
	b=u0L7W7NN+Gcdq5skWKb/rmQjvQQxRAgXuBHzglJePGY9PCA5LDnb41LfRExJaoVx8
	 dDGqHtKBy3V5+Av0GAgJneNKWAJCtcfk3toOtx0aizsgzGLostLVRoFf3BP3i8UpGp
	 8UupDTXWBiu/Mol0DvAYsrbs6QtrZPjf/vVWeo0qIKwezteMQIbGhi2al8ajpAYRIx
	 tDv8m1F5qMT9MNvTqRMVqbmS39GUEcHajfL+5jqmqN946b72qpxwYICwAS47IzExpZ
	 z7zwhjh7bi4SLTLnGhU3PPEmyfgfLvHJRZgj/jeRU7c9oqHKhocl1uNiSTpUkzqSLp
	 sxSH5NKJAPl9w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v4 0/2] PCI: mediatek-gen3: Set PBUS_CSR regs for Airoha
 EN7581 SoC.
Date: Tue, 25 Feb 2025 09:04:05 +0100
Message-Id: <20250225-en7581-pcie-pbus-csr-v4-0-24324382424a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZ5vWcC/3XNTQrCMBCG4auUrB1J86ONK+8hLtrppA1KWhINS
 undTQuCgi7fgXm+iUUKjiI7FBMLlFx0g8+hNgXDvvYdgWtzM8GF5oKXQH6vqxJGdARjc4+AMYA
 1qGxVIelGsvw6BrLusbKnc+7exdsQnutKEsv1DYrfYBLAYadbbPImmtocLxQ8XbdD6NgiJvmhi
 H+KzApxxLq0qpVGfSnzPL8AyRLbgP8AAAA=
X-Change-ID: 20250201-en7581-pcie-pbus-csr-f9c4f88ce5b3
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Configure PBus base address and base address mask to allow the hw
to detect if a given address is accessible on the PCIe controller.
Introduce mediatek,pbus-csr phandle array property.

Changes in v4:
- Remove check on resource size
- Remove checks on regmap_write()
- Link to v3: https://lore.kernel.org/r/20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org

Changes in v3:
- Get base address and base address mask from range property
- Define mediatek,pbus-csr as phandle array
- Link to v2: https://lore.kernel.org/r/20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org

Changes in v2:
- Introduce mediatek,pbus-csr phandle property
- Drop patch 1/2 in v1
- Do not hard-code compatible sting in the driver and use phandle
  instead

---
Lorenzo Bianconi (2):
      dt-bindings: PCI: mediatek-gen3: Add mediatek,pbus-csr phandle array property
      PCI: mediatek-gen3: Configure PBUS_CSR registers for EN7581 SoC

 .../bindings/pci/mediatek-pcie-gen3.yaml           | 17 +++++++++++++
 drivers/pci/controller/pcie-mediatek-gen3.c        | 28 +++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
---
base-commit: b6d7bb0d3bd74b491e2e6fd59c4d5110d06fd63b
change-id: 20250201-en7581-pcie-pbus-csr-f9c4f88ce5b3

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



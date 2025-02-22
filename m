Return-Path: <linux-pci+bounces-22083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA74A4078A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1849B3BD642
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27E207E1B;
	Sat, 22 Feb 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tut8NhPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C61FBE9B;
	Sat, 22 Feb 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221055; cv=none; b=twniN7BPzKA2pFPcrtFWRRfhRn6S89A/Z52LRthPX/Tw+Mycv8Nz1fBaddgihFaHl3QilKxGZEnlmCVfvgI0RjWjmIGSM4N/PWLFuCOi3CZe5AxsOCRfdiK8d8PIff3TXOw/nC/iyq69eqTzTcdC//cw3NO93qCrUwCzOGm54IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221055; c=relaxed/simple;
	bh=1EgGu4K6OScm1oy60Hd1e93/YxaKGFVdoWrvXutqVW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jMgCgZC/XGN7LIAW7SpIbxgZh0NAXmd9TI3/11h8t8dB7XnfB6SjGsY+jLbvilTjQUBmej+T8El9ZTJaPecOG7M8J64+GlW4OpCSVQ/1/BiQ1G0f8idZ+E9wAkjgsla60t28R9hKy2wPB1xFzPdhR1XjG2oEcbKSWU4bSBLWRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tut8NhPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6982FC4CED1;
	Sat, 22 Feb 2025 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740221054;
	bh=1EgGu4K6OScm1oy60Hd1e93/YxaKGFVdoWrvXutqVW0=;
	h=From:Subject:Date:To:Cc:From;
	b=Tut8NhPHV5YQ2j2Cev3+E18p21LBX32h8+hopks7Bc4vtsyFbNqRH4xkbQMBMCJDO
	 OYeTrgmvjXNISssHiWIxn3wS9rVvd/CTcKgMmiFzDcygh3lltunhat8ucN4l3FD2F/
	 NDPFknDY/44+wpxk86KxMULtCFu4nGgDYCP361CpWpGTrtSyW4wBbP04fDM+VNqDk8
	 he1Xu61wRtYpWDS07ojJIXiMYhqHa83hBRDwRG8cSO+9/jnODJGOsM0jIsu5zQFILG
	 AQmAuEuyA8ULMNzAEWBZkPsZwtd9+g9kT3E9GF8PuvYzH7arvfN+dXYlvqZAlUjYJH
	 zHCia7a6oIm4A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v3 0/2] PCI: mediatek-gen3: Set PBUS_CSR regs for Airoha
 EN7581 SoC.
Date: Sat, 22 Feb 2025 11:43:43 +0100
Message-Id: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+quWcC/22NQQ6CMBBFr0Jm7ZhSrIIr72FYwDDARNOSqRIN4
 e5WEncu30/+ewtEVuEI52wB5VmiBJ+g2GVAY+MHRukSgzXWGWtyZH9yZY4TCePUPiNSVOwrOvR
 lSezaAtJ1Uu7ltWmvdeJR4iPoe6vM9rv+hPa/cLZo8Og6alOTqqa63Fg93/dBB6jXdf0A6iDIO
 LkAAAA=
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: b4 0.14.2

Configure PBus base address and base address mask to allow the hw
to detect if a given address is accessible on the PCIe controller.
Introduce mediatek,pbus-csr phandle array property.

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

 .../bindings/pci/mediatek-pcie-gen3.yaml           | 17 +++++++++++
 drivers/pci/controller/pcie-mediatek-gen3.c        | 34 +++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)
---
base-commit: b6d7bb0d3bd74b491e2e6fd59c4d5110d06fd63b
change-id: 20250201-en7581-pcie-pbus-csr-f9c4f88ce5b3

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



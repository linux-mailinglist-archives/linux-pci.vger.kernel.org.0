Return-Path: <linux-pci+bounces-20639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4ECA24FCF
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 20:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6863A39F8
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E241C64;
	Sun,  2 Feb 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDaxBCD9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5888F6C;
	Sun,  2 Feb 2025 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738524889; cv=none; b=RS73jQb5+87GMoE/KUyYN4aY4Gr2TcbliQCU2YdTt9qnDSxdExd8sU+7/swSHMk631DDzbIgc3bMjvKbce8TN5id1Ufh5jA1cljSXcHB8KWBCp5cAoStvpcgRG0HVlB4BfosSichCc5dEOd7JLNyKdeMELWwlrXkI5vneq/RkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738524889; c=relaxed/simple;
	bh=VU3MpY2cs9ONxFsQvcQxPlZZBeM5MNvxJnjXLfM6uPI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aOYU05VWETvVzvF1L3/z2bCscSan2XtB6cXQWWfSMFasglIPhuctSS7Nsa1LinkehwtF1O9zMRPQVtRgZduqghSAst21I8l9a5Tw1HWboaeLoe+uoxCCOkqk/RvDxhjfFM7fH9NdmFzp3Hn8tTUqZdWb82Vr9KuyctcjuhcGue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDaxBCD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CEAC4CED1;
	Sun,  2 Feb 2025 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738524888;
	bh=VU3MpY2cs9ONxFsQvcQxPlZZBeM5MNvxJnjXLfM6uPI=;
	h=From:Subject:Date:To:Cc:From;
	b=QDaxBCD9ZM7SbL8t17Uud1wE8t6v3PCBm/LJg6J/wt/BmHTTlpMtvcM2s3+LNa+K9
	 U9BueRbmaHwuUGI5FD35yt9eJePOYE+X8QKHsAsOonoteYuWF/7R8xnAdVBXk/1OtW
	 Ry61jiG+irUCGmc0b+Iv67M3KmAS85zCSRr253z/ed7WzvMUrGpShfTHbwbG19Ae6B
	 RYC6FUDM+D1NRQQgQcvmzAAdCFQNowgDOCfE1SaHxW/Z2Sm+tiUCvHd5aJMDYJkS8a
	 Xvv/B7l+fVKZGILX1lKVmNkYAhb5YtVXa0240y1Zh2ec6jSffZqwGAuT89IqsBV7C4
	 xlWawkG2B4HOA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 0/2] PCI: mediatek-gen3: Set PBUS_CSR regs for Airoha
 EN7581 SoC.
Date: Sun, 02 Feb 2025 20:34:22 +0100
Message-Id: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7In2cC/x3MQQoCMQxA0auUrCfQRovVqwyzmMZUs6mlQRGG3
 t3i8i3+P8Ckqxjc3AFdPmr6qhO0OODnXh+Cep8G8hQ9+YBSLzEFbKyCLb8N2TqWK59LSiwxn2C
 mrUvR73+7bmP8AFZFZr9mAAAA
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Configure PBus base address and address mask to allow the hw to detect
if a given address is on PCIE0, PCIE1 or PCIE2.
Introduce mediatek,pbus-csr phandle property.

Changes in v2:
- Introduce mediatek,pbus-csr phandle property
- Drop patch 1/2 in v1
- Do not hard-code compatible sting in the driver and use phandle
  instead

---
Lorenzo Bianconi (2):
      dt-bindings: PCI: mediatek-gen3: Add mediatek,pbus-csr phandle property
      PCI: mediatek-gen3: Configure PBUS_CSR registers for EN7581 SoC

 .../bindings/pci/mediatek-pcie-gen3.yaml           | 12 +++++++++
 drivers/pci/controller/pcie-mediatek-gen3.c        | 30 +++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)
---
base-commit: 647d69605c70368d54fc012fce8a43e8e5955b04
change-id: 20250201-en7581-pcie-pbus-csr-f9c4f88ce5b3

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



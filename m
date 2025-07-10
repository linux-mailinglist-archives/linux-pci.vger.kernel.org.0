Return-Path: <linux-pci+bounces-31871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392FB00B12
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 20:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C723B8611
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801C52FCFDA;
	Thu, 10 Jul 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+sWyJeV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562932FCFD2;
	Thu, 10 Jul 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170926; cv=none; b=ROWlV2+GtvI5RSt4CO8wbOlgHhCYBV14p0wVOVR4EvjCiuvK1QFhOWVekoXYf+j4SYa8uw1769MJeV9z3zs5063i6j0Ru1LnTN+20zTF+7TAWBYSF1+q8+cMYp1KGCS8YgiICUlj/JCeRW4w0ymsKka5BMfPy9vbxJNlKN7XWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170926; c=relaxed/simple;
	bh=z5MOk3teoc8lNLs6Z8f7WVOw99mPUlh3R4x5QRcNJq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7HuM3+xUl6zOpgYpk5f8YGvh7J2n49z6XEaeHnCYMY3R5aJXzuJXnT5eDklF//QJxwcQF/8TxhgER5/dOJy5xIVnzHhnTNgBS47TGuP5PWSQzI5x3ufJ1LeIGPayTdR8N3kSZ0yyp30db3D86octrWK0K+uOeTQ3GsqAi9y7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+sWyJeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14347C4CEE3;
	Thu, 10 Jul 2025 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170926;
	bh=z5MOk3teoc8lNLs6Z8f7WVOw99mPUlh3R4x5QRcNJq8=;
	h=From:To:Cc:Subject:Date:From;
	b=s+sWyJeVMeLFP/o0Wk0Q+tGrzcGjVpCPMlhfnuThskFD9FrwKdL2wGgDtMyGlRJa3
	 YyZBnrwXqG7VJgYUiJts6hLKioBTzSXx6lTPxdQIV4iom8X0um4z9KvVLg5RdDAkhe
	 +0Xe4CJuegmAZ4UpI3rmtTbbx9RhbdYF9s09OuFkaGcsYzDQIrD9hL7Y3dOS0TnLCW
	 NnyFMfNz7p+FrzzhIm6QNtPRLKdOx5LBhu3oXRcecxDeQv1u+bI7a19C/rC0KEZPEp
	 Oe2pWPjKjLbwIHtS/kldzaSFBsHEdTdG59cONwChEll72BveMmsURcqW1JXwhXA9L+
	 8qMWRrmKtbVPg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Remove 83xx-512x-pci.txt
Date: Thu, 10 Jul 2025 13:08:42 -0500
Message-ID: <20250710180843.2971667-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This binding is already covered by fsl,mpc8xxx-pci.yaml schema. While
the MPC512x is mentioned here, its compatible strings aren't actually
documented and remain that way.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pci/83xx-512x-pci.txt | 39 -------------------
 1 file changed, 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/83xx-512x-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt b/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
deleted file mode 100644
index 3abeecf4983f..000000000000
--- a/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-* Freescale 83xx and 512x PCI bridges
-
-Freescale 83xx and 512x SOCs include the same PCI bridge core.
-
-83xx/512x specific notes:
-- reg: should contain two address length tuples
-    The first is for the internal PCI bridge registers
-    The second is for the PCI config space access registers
-
-Example (MPC8313ERDB)
-	pci0: pci@e0008500 {
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-				/* IDSEL 0x0E -mini PCI */
-				 0x7000 0x0 0x0 0x1 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x2 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x3 &ipic 18 0x8
-				 0x7000 0x0 0x0 0x4 &ipic 18 0x8
-
-				/* IDSEL 0x0F - PCI slot */
-				 0x7800 0x0 0x0 0x1 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x2 &ipic 18 0x8
-				 0x7800 0x0 0x0 0x3 &ipic 17 0x8
-				 0x7800 0x0 0x0 0x4 &ipic 18 0x8>;
-		interrupt-parent = <&ipic>;
-		interrupts = <66 0x8>;
-		bus-range = <0x0 0x0>;
-		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
-			  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe0008500 0x100		/* internal registers */
-		       0xe0008300 0x8>;		/* config space access registers */
-		compatible = "fsl,mpc8349-pci";
-		device_type = "pci";
-	};
-- 
2.47.2



Return-Path: <linux-pci+bounces-5256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12988E33D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6C91F2DED3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1C180A62;
	Wed, 27 Mar 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHLddTCl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E713EFE1;
	Wed, 27 Mar 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542306; cv=none; b=G5LstJAughHiascoijtT448F7Ko46z6srs3D3lEtlRvELGqoQwOgT3zmbEm6ORFjNsnlTmc6sXUU9YvL42YYgCyBjr2u63nHO9XvDB+wPrcBevjozFE2Arxg5pcmTSDzkOhCXfRO9EFI+Uma4aIBP1vkxMKx0eXcBICTRU5Fa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542306; c=relaxed/simple;
	bh=X6Q17iok1lsELRt2E1A4QpgQ+0x+/0qVC3vmN5bsp/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBr5r/J9WP+RUE4zqz6CkSmp3qWdVr18Nqgz7ffd9ryy/T9q4Gz+2yHi5rawGTB+ZD3xTJilzOAVbXv/5J0AyypyGIXHpQyfP6CYgyyqqTWXYYSDkF/5a2wxpCKOJDrMxhJCdmiUo+i+dyfUgOQoTSKIuc85gOODjcYy+VsVnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHLddTCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AE4C433F1;
	Wed, 27 Mar 2024 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542306;
	bh=X6Q17iok1lsELRt2E1A4QpgQ+0x+/0qVC3vmN5bsp/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHLddTCldCQc+zy2KauTb0OEL19C/ZeAtYJN6nFb+A8mdqD6YkBN+M8Bxh/AdNikO
	 buRI0qewxr/ZaIWGFYdzCTl6Gv+RsoBnAlcfBmr9KGMxBuXI3pJYbMh+P8L1zLyhx2
	 iLtM94jJ11V1gz7lLelQfy94vpn6TRB1kTWBvyVzm0aNi5tVHT8vPmz8oEGt3l6fvE
	 QdGQtL8OjrgA1mCZf6OFDsqL3HwWRyd4+/E8wGZNsqkG7tjxf05SR/bswKgUpn9tFQ
	 cxX8P48S5ffTReyax34KkflEXjTW48yOhRDn4aAzKNgI7xxcpWj0iR93pGTAkac01F
	 GSF764hUTtFPg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v1 1/5] dt-bindings: riscv: microchip: document beaglev-fire
Date: Wed, 27 Mar 2024 12:24:36 +0000
Message-ID: <20240327-camper-brownnose-6392076d8699@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327-parkway-dodgy-f0fe1fa20892@spud>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=IXE+G6TXDdUlSmW7mF73cGLzEXQoXwEvNEi4hyJZUcA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGksAqyWxyxDf27KOX45Wc6gK/FjWPo5fVG+mL6XUyzOG oavaJ3XUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgInUljAytJzJPjW94muSCof5 xEw/ruBlqzbOO3DwwKtM0Svf5VZUHmBkOHtBweWu0Nv2tfc3HlrA9/9UdZEFM8duP4nZh9WX7jv Zxg0A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The BeagleV Fire is a BeagleBone Black form-factor board with a
PolarFire SoC.

Link: https://www.beagleboard.org/boards/beaglev-fire
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 4a29c890619a..78ce76ae1b6d 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -29,6 +29,7 @@ properties:
           - enum:
               - aldec,tysom-m-mpfs250t-rev2
               - aries,m100pfsevp
+              - beagle,beaglev-fire
               - microchip,mpfs-sev-kit
               - sundance,polarberry
           - const: microchip,mpfs
-- 
2.43.0



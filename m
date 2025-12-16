Return-Path: <linux-pci+bounces-43087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E987CC08A3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 02:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91033062E75
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECBB28B415;
	Tue, 16 Dec 2025 01:50:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BED296BBF;
	Tue, 16 Dec 2025 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849827; cv=none; b=Qd9/aTdZiDLQzCR0zo9ow1nTxToarIdG3JceEwUbzKWzXIhHveGWifNmlTBjaSMGCm8k/hX03vf2/LNL8re3RO6aBUi4hkj9AyIKCrKMZimlRT9FItq8RdystI2SiUxbk/v6vY9NDOEzOC1BjIU+UasCjuVKr7Ykvi2JImmRvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849827; c=relaxed/simple;
	bh=r0BgtIbXNsHedoFkI9b0LevHO8akl3hnwnFy2Ogu+vM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c+57EL1n5dBwkEGBrg9O35Vz6r3hIjmq3tyVgKx7Tk5rsA7at+ZCHDsplDWpPPQbhMEuMrlNnOIu1YGjt99rqytD4d9oU4UvWbyDo1W/Xn8d3NYDwoNw9x8t+/TyktuRMPXPKZSBxgszpZSh5t/0iXYiJ4g8fKgLjpVmIuBkxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 16 Dec
 2025 09:50:01 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 16 Dec 2025 09:50:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 16 Dec 2025 09:50:06 +0800
Subject: [PATCH v7 7/7] MAINTAINERS: Add ASPEED PCIe RC driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251216-upstream_pcie_rc-v7-7-4aeb0f53c4ce@aspeedtech.com>
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
In-Reply-To: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Jeffery <andrew@aj.id.au>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765849800; l=1055;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=r0BgtIbXNsHedoFkI9b0LevHO8akl3hnwnFy2Ogu+vM=;
 b=yKMzRhd9HSP2M5gJwufO22Da3hHoj7aHBs7q/17VluqfHqxKR+FgCxIVV2wr0ZUGrlORlBriP
 u8wFcI7/wZKCnVH8+P5PCvLWUht/yvwSjzHWTfVmq7f7kaxujr9+v3e
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add maintainer for ASPEED PCIe RC driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aff3e162180d..c327ea375746 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3900,6 +3900,18 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
 F:	drivers/media/platform/aspeed/
 
+ASPEED PCIE CONTROLLER DRIVER
+M:	Jacky Chou <jacky_chou@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-pci@vger.kernel.org
+L:	linux-phy@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
+F:	Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
+F:	drivers/pci/controller/pcie-aspeed.c
+F:	drivers/phy/aspeed/Kconfig
+F:	drivers/phy/aspeed/pcie-phy-aspeed.c
+
 ASUS EC HARDWARE MONITOR DRIVER
 M:	Eugene Shalygin <eugene.shalygin@gmail.com>
 L:	linux-hwmon@vger.kernel.org

-- 
2.34.1



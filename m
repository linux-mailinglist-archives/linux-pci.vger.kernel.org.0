Return-Path: <linux-pci+bounces-25247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7477A7ADE8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 22:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16AC1777E6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72D262ED4;
	Thu,  3 Apr 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBuH+QjA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45313262ED0;
	Thu,  3 Apr 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707678; cv=none; b=tusQK1ZTvlEjnr+CBiHGznnsMUTe/bSRaH6XHC+9wkcx4RvgHBaCbZtFzjRxN4YUoJ98TsMfDUnZTIrT8PdFwbHEIPfoq42N9iSkeKiTb6fL42TJfiJaRFNwTvbf0f5Ypnp4Q+hKtZ+VgZJzRBavO2hA892zdNUqb1fOphJm5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707678; c=relaxed/simple;
	bh=71wBi/cNBET7g7tuz2d1oBbbk5rq2cJkkfj8t+08GTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4zDtRGQKmebmrTBRhwsVhIx0xKGm4wqIIj0B0bF8uKqA37XoU0fp+Plv5/igPIcfA5Rd55xsgzuIih8kp5NX4vFtrLvMA+wppkvJc41yR2lUF/fE/v0RmMHH4S9t/oNM+/Er074OJ+aMNVgK0Sez6wWUss7RpsbfU97ixJaicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBuH+QjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97257C4CEE3;
	Thu,  3 Apr 2025 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707678;
	bh=71wBi/cNBET7g7tuz2d1oBbbk5rq2cJkkfj8t+08GTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBuH+QjAvTrLe3JdD6N32A7iweSTs54Ez/o4QXpclFpUKcDAs/nJNBvIUeyxixi2r
	 grEE2CGDYyHm5r5JAt3xDGVFqewhlATYyfdbM/YmuLZHEPsU+xoQnjjRuWXLu/Ouan
	 GYCgPGHAUIKi0gYSCMOP17+r11OtrJ5d3MydbnzX3TUfKoFJEvCXMV5p+alTQlRjZi
	 mFPJ4+gaLUVLYk2+6HyZj3E382c8THPUXsJikvb34WaO9NHMroJWXmM5p03yM6BLXn
	 d6dJTXChd1GumN5dCJ3MxQ2+z2YyaIx4Lw1sCMh8/EF6CCgQ/nT4c0c3IWpi/8VXCf
	 bGaU7LgBsqr5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	manivannan.sadhasivam@linaro.org,
	kw@linux.com,
	gregkh@linuxfoundation.org,
	lpieralisi@kernel.org,
	heiko@sntech.de,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 30/44] PCI: Add Rockchip Vendor ID
Date: Thu,  3 Apr 2025 15:12:59 -0400
Message-Id: <20250403191313.2679091-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 20bbb083bbc9d3f8db390f2e35e168f1b23dae8a ]

Move PCI_VENDOR_ID_ROCKCHIP from pci_endpoint_test.c to pci_ids.h and
reuse it in pcie-rockchip-host.c.

Link: https://lore.kernel.org/r/20250218092120.2322784-2-cassel@kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c            | 1 -
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 drivers/pci/controller/pcie-rockchip.h      | 1 -
 include/linux/pci_ids.h                     | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a493865..b002740acf8d5 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -88,7 +88,6 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
-#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
 static DEFINE_IDA(pci_endpoint_test_ida);
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 5adac6adc046f..6a46be17aa91b 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -367,7 +367,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
-	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
+	rockchip_pcie_write(rockchip, PCI_VENDOR_ID_ROCKCHIP,
 			    PCIE_CORE_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
 			    PCI_CLASS_BRIDGE_PCI_NORMAL << 8,
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 11def598534b2..14954f43e5e9a 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -200,7 +200,6 @@
 #define AXI_WRAPPER_NOR_MSG			0xc
 
 #define PCIE_RC_SEND_PME_OFF			0x11960
-#define ROCKCHIP_VENDOR_ID			0x1d87
 #define PCIE_LINK_IS_L2(x) \
 	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
 #define PCIE_LINK_TRAINING_DONE(x) \
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1a2594a38199f..2a9ca3dbaa0e9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2609,6 +2609,8 @@
 
 #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
 
+#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
+
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
 #define PCI_VENDOR_ID_META		0x1d9b
-- 
2.39.5



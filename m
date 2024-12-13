Return-Path: <linux-pci+bounces-18369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34D79F0AA2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 12:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DF3281406
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001111DAC95;
	Fri, 13 Dec 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KZgeTGxk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m12796.qiye.163.com (mail-m12796.qiye.163.com [115.236.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6451D88D0
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088486; cv=none; b=S9hIAekgMWarCAGdbZ4TUiSCcx5Vkxv2/5lXkaRgzwdPc8gUxGVIGkPXnxgEgzARLZf5r9KZyjdjY5gPpo1ut8tTjSrjv5Nx6pENmBs7RH4QzVrzWagGx27BREW+m1I7ijPq6+apXgJdfOE/96Z206R7kXu6x0qxY1z4JefJ6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088486; c=relaxed/simple;
	bh=7FkDXT6Ps3HcwwsjQJ/olClzyRrmIocbisQLgLKrf1M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=I3m0B8hZuIGquFmHGaYpu8JtFIZ25DuotCuJeBFJZ4W4EhtXo5HQVHkY/hpV/VFsxctQ/SaPuhRS6Hn3o0hy4V+ezOpHh0yEusIudiEZ+MGJKptf6ouSgTdMyGjtOLxUqFJvxVVz9pApVTSo+3HYKtMCOYmRgV+Fe7EfBOcUGYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KZgeTGxk; arc=none smtp.client-ip=115.236.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 59d5a5d5;
	Fri, 13 Dec 2024 12:25:01 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v3 1/2] PCI: Add Rockchip vendor ID
Date: Fri, 13 Dec 2024 12:24:02 +0800
Message-Id: <1734063843-188144-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01KTFZJGBpJSBpPHxlKGUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93be434a9009cckunm59d5a5d5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6Lio5FzIUFCgRKksBQwhI
	MBwaCStVSlVKTEhPS01IQktJT0hCVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlOTU83Bg++
DKIM-Signature:a=rsa-sha256;
	b=KZgeTGxkmxD1GgSCMuO9gHLsTtQEJLEKyu+56C2zNvGuSaHLL2dTCfQmuELuPhTeVaFfZzYn6kez9KJzca8231KYyI+cpYjaln7ImQ8LRHchwzxf7/+qt2vFCsHphWJSZP5/YwYpBHI9liIfAD5RsAwxZIgh8V0Gm8jreGtSOys=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=IDXftlRgx9+YslsF9zqhm6+zImztC1u2xkzKxCCg7QI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This patch moves PCI_VENDOR_ID_ROCKCHIP from pci_endpoint_test.c to
pci_ids.h. And reuse it in pcie-rockchip-host.c.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Wilczynski <kw@linux.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- add commit log and reuse this ID for more places

Changes in v2: None

 drivers/misc/pci_endpoint_test.c            | 1 -
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 drivers/pci/controller/pcie-rockchip.h      | 1 -
 include/linux/pci_ids.h                     | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47..b5c8422 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -85,7 +85,6 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
-#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
 static DEFINE_IDA(pci_endpoint_test_ida);
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 5adac6a..6a46be1 100644
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
index a51b087..f9eaac9 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -198,7 +198,6 @@
 #define AXI_WRAPPER_NOR_MSG			0xc
 
 #define PCIE_RC_SEND_PME_OFF			0x11960
-#define ROCKCHIP_VENDOR_ID			0x1d87
 #define PCIE_LINK_IS_L2(x) \
 	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
 #define PCIE_LINK_TRAINING_DONE(x) \
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d2402bf..6f68267 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2604,6 +2604,8 @@
 
 #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
 
+#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
+
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
 #define PCI_VENDOR_ID_META		0x1d9b
-- 
2.7.4



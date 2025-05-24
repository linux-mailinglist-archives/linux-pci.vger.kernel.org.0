Return-Path: <linux-pci+bounces-28370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB58AC3101
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 20:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681CA17E9AC
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508441F1517;
	Sat, 24 May 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLyDJWaw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3851F1513
	for <linux-pci@vger.kernel.org>; Sat, 24 May 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748112805; cv=none; b=Q0B851P6GdKpGJ0zkK3ow1ln3Po/ROtzD6M4TdD6aolq6iQYTJDIxxQSwFwoYkN9hCDeB2w9MfUxjbVRm1ie5rw/0RAZVmOU+tsXGwC8L/zXw5afVrc/a7+f5IpDrv83/b8IPe6XAVKJeaU2ay+UGUzs+xKi6r1FY1lDLLkRlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748112805; c=relaxed/simple;
	bh=zCMczU4v06ghUQ9pw1P+u0746zqUXj2cY86m3N4kgoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX0NYIB3Bcc2XvNS9sX2t3JqdHJIBe1spw7ClmuWjI8sH22HB6jooG9kSmYWIg5ywrnovAqKXZcl7vQo2oZ09kPOF1FIh2qmh2lKKZiTbdyu2/8rGrlit3mC2acIG46eMuQRWkUNj1mF5sRkX5WyP2Ky+8KI/gUZs8JLhK9qGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WLyDJWaw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso1133520b3a.3
        for <linux-pci@vger.kernel.org>; Sat, 24 May 2025 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748112802; x=1748717602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDL6QRovWt7sBQP7alBAWgPBh+2vhpbIyHwbqahrS2s=;
        b=WLyDJWawRD1FNVUO53IcDqiIk+1S8tTG07NErfEEomLbdnKYT+NDprIEJk4GbdabR7
         t0zLzHXhgHuDQep/TSjSf8jngJySlhSK+9JXOpTI+RBJ+yUQACwke93CsyQIvc4kHkkh
         qVYvdRTkJNwXKy0P826BxgCk7Yx8Y0vsh1IrhkPyczACJlItM9aYmZVUtoikSj+s2lJ9
         acOWchrLvxZ8aWAm0gkB/9UV+Y9tXtWxN3852prXeypOhl+YV0yFiIz57d3mopz5R1/j
         xO3CFaIiLnKrQn3YUpltvTaW/bRHwSLO2j0IAoUt+6yVJYrY3rp0NXfDJmSLz8deqRp2
         tm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748112802; x=1748717602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDL6QRovWt7sBQP7alBAWgPBh+2vhpbIyHwbqahrS2s=;
        b=Ht80pzlbel4qdZGcGMEs56Fn2pWI4OZMchDkxf5Q9iImPrVDXQ9vasSr4Nkz6qU0mV
         t6n899T6FCregT3nmLf1C8/G0S7gj512tsP+d2r437bZbG42AjBH0M3mD4ueF/nPhv1J
         TXiWVELiRpYjtaYNmFXhmYKGcOgA3D8WSaJD2oX9QAw988pZkhEAaqD3VTeUjVbrid3m
         hVIef2lfAUcCz/qnp/NhTT4mnrCDfwrnGZ96zkTfxzrnFj0zeRCOnZoDp6IG5RYGsCIb
         CNoN8hdbpVnlmGSOKEhQvw6OfyCdcrG1RKThCGHgY+e+LBDE8ZoZyjQTcPZOVMIpt0tf
         nMTg==
X-Gm-Message-State: AOJu0Yx5gWTjPKT3zylPOjU21de9BkwQQTuNyGOYMq33uAkwNbNTzt/t
	ioKfKlo4YHSeYJYKTccKZHZ5GfF1TGiXRXDocnplttJ9neK83GJZ2mH6BALTB5kIaQ==
X-Gm-Gg: ASbGnctBYoHu47TOS8f896ebdk2wPQJTOs1AGXR6llqfpxiPZuggSsz4YgjUvh4Yltp
	jaaOWR3ZoL12thfllJbV/GrOLY2NKxKW+KbbPOet0bXn4oUN/lMVZwTaqIWvEJvALEp7TpImoRr
	TROlNvPvwCluXOsopQfBapNDuKOpZFxQYvABWYJDHVih1m1SH2Pp2BeiQ+rBYK68pYjWf0vwFBk
	NeA2sBAV7tBVtx1F5C0bjW4XbKmzgULiYg8wm7BQBAx3suqBuVoIu3TP3ilXV0yNhy0hnPUHYSf
	cBQnEcT+D0XjOlqt7/nyGoR/IcMWbLFSUbx/tbYg6Nc9FHVZ5ehJ/XK9GJm06lES
X-Google-Smtp-Source: AGHT+IH+7qg3wNDv5nyRf+S4VLDCGgKjl9E0QRjKmpL5PiZmmYwJKZ+o/DGKeM99GhkflOY9BkiCbg==
X-Received: by 2002:a05:6a20:a11c:b0:215:e60b:3bd3 with SMTP id adf61e73a8af0-2188c353194mr6571996637.29.1748112802033;
        Sat, 24 May 2025 11:53:22 -0700 (PDT)
Received: from thinkpad.. ([120.56.192.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a906bsm14532931a12.71.2025.05.24.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 11:53:21 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cassel@kernel.org,
	wilfred.mallawa@wdc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/2] PCI: Rename host_bridge::reset_slot() to host_bridge::reset_root_port()
Date: Sun, 25 May 2025 00:23:04 +0530
Message-ID: <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callback is supposed to reset the root port, hence it should be named
as 'reset_root_port'. This also warrants renaming the rest of the instances
of 'reset slot' as 'reset root port' in the drivers.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  8 ++++----
 drivers/pci/controller/dwc/pcie-qcom.c        |  8 ++++----
 drivers/pci/controller/pci-host-common.c      | 20 +++++++++----------
 drivers/pci/pci.c                             |  6 +++---
 include/linux/pci.h                           |  2 +-
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 193e97adf228..0cc7186758ce 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -85,7 +85,7 @@ struct rockchip_pcie_of_data {
 	const struct pci_epc_features *epc_features;
 };
 
-static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
+static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 				       struct pci_dev *pdev);
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
@@ -261,7 +261,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 					 rockchip);
 
 	rockchip_pcie_enable_l0s(pci);
-	pp->bridge->reset_slot = rockchip_pcie_rc_reset_slot;
+	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_slot;
 
 	return 0;
 }
@@ -700,7 +700,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
+static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 				       struct pci_dev *pdev)
 {
 	struct pci_bus *bus = bridge->bus;
@@ -759,7 +759,7 @@ static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
 
 	/* Ignore errors, the link may come up later. */
 	dw_pcie_wait_for_link(pci);
-	dev_dbg(dev, "slot reset completed\n");
+	dev_dbg(dev, "Root port reset completed\n");
 	return ret;
 
 deinit_clk:
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0c59030a2d55..840263c1efe0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -291,7 +291,7 @@ struct qcom_pcie {
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
-static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
+static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
 				  struct pci_dev *pdev);
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
@@ -1277,7 +1277,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_assert_reset;
 	}
 
-	pp->bridge->reset_slot = qcom_pcie_reset_slot;
+	pp->bridge->reset_root_port = qcom_pcie_reset_root_port;
 
 	return 0;
 
@@ -1533,7 +1533,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 	}
 }
 
-static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
+static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
 				  struct pci_dev *pdev)
 {
 	struct pci_bus *bus = bridge->bus;
@@ -1589,7 +1589,7 @@ static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
 
 	qcom_pcie_start_link(pci);
 
-	dev_dbg(dev, "Slot reset completed\n");
+	dev_dbg(dev, "Root port reset completed\n");
 
 	return 0;
 
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index afa7b140a04a..24e357e85adb 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -99,22 +99,22 @@ void pci_host_common_remove(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
 #if IS_ENABLED(CONFIG_PCIEAER)
-static pci_ers_result_t pci_host_reset_slot(struct pci_dev *dev)
+static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
 {
 	int ret;
 
 	ret = pci_bus_error_reset(dev);
 	if (ret) {
-		pci_err(dev, "Failed to reset slot: %d\n", ret);
+		pci_err(dev, "Failed to reset root port: %d\n", ret);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	pci_info(dev, "Slot has been reset\n");
+	pci_info(dev, "Root port has been reset\n");
 
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static void pci_host_recover_slots(struct pci_host_bridge *host)
+static void pci_host_reset_root_ports(struct pci_host_bridge *host)
 {
 	struct pci_bus *bus = host->bus;
 	struct pci_dev *dev;
@@ -124,11 +124,11 @@ static void pci_host_recover_slots(struct pci_host_bridge *host)
 			continue;
 
 		pcie_do_recovery(dev, pci_channel_io_frozen,
-				 pci_host_reset_slot);
+				 pci_host_reset_root_port);
 	}
 }
 #else
-static void pci_host_recover_slots(struct pci_host_bridge *host)
+static void pci_host_reset_root_ports(struct pci_host_bridge *host)
 {
 	struct pci_bus *bus = host->bus;
 	struct pci_dev *dev;
@@ -140,17 +140,17 @@ static void pci_host_recover_slots(struct pci_host_bridge *host)
 
 		ret = pci_bus_error_reset(dev);
 		if (ret)
-			pci_err(dev, "Failed to reset slot: %d\n", ret);
+			pci_err(dev, "Failed to reset root port: %d\n", ret);
 		else
-			pci_info(dev, "Slot has been reset\n");
+			pci_info(dev, "Root port has been reset\n");
 	}
 }
 #endif
 
 void pci_host_handle_link_down(struct pci_host_bridge *bridge)
 {
-	dev_info(&bridge->dev, "Recovering slots due to Link Down\n");
-	pci_host_recover_slots(bridge);
+	dev_info(&bridge->dev, "Recovering root ports due to Link Down\n");
+	pci_host_reset_root_ports(bridge);
 }
 EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d6e9ce2bbcc..154d33e1af84 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4985,16 +4985,16 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int ret;
 
-	if (pci_is_root_bus(dev->bus) && host->reset_slot) {
+	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {
 		/*
 		 * Save the config space of the root port before doing the
 		 * reset, since the state could be lost. The device state
 		 * should've been saved by the caller.
 		 */
 		pci_save_state(dev);
-		ret = host->reset_slot(host, dev);
+		ret = host->reset_root_port(host, dev);
 		if (ret)
-			pci_err(dev, "failed to reset slot: %d\n", ret);
+			pci_err(dev, "failed to reset root port: %d\n", ret);
 		else
 			/* Now restore it on success */
 			pci_restore_state(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8d7d2a49b76c..ab4f4a668f6d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -599,7 +599,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
-	int (*reset_slot)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	int (*reset_root_port)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
-- 
2.43.0



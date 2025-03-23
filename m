Return-Path: <linux-pci+bounces-24468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A6DA6D016
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275F27A6860
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160F157A5C;
	Sun, 23 Mar 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ETnu4bMQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C411519BE;
	Sun, 23 Mar 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742748625; cv=none; b=O7wN1ii393Z6uI1xN2gOYWDlfhcaHs1MqnDKEGv/BmI7s0xitzZ+fU4L+VLmK5EdMfbFJv0V2D3i7aERyQgT8Vob95idjGTc0YZejnKJE9R1dyA2iFPJObJeeyL4e2cUaLnQnTegMsA461EWHJ/R+1cmvMKQIKtby1P0dA+zUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742748625; c=relaxed/simple;
	bh=sMpGyV6p8pOURoqAQl1m8+lvi69TfLNxdVcEY8ooH+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kU50JORLw4QiHAV31gJynerwUjqTnlhbmxaafuhCKw2LvNzHo7DxJXC3BpJbjx3arroQb5qGDBqVf3NNVNMt1CXssRG5XONruYphokmArmb/FX6pfkGcFfbhbQDeAlDmPj3asQxmcGYANdXO7MxwdtiKUC8GRyuf+C3SzsCQapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ETnu4bMQ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dUGDJ
	3urt8mGfCJw+W7HKnz6HHY6AiqfM5tW1FMklvE=; b=ETnu4bMQHWPb/9zjdcsqv
	zi9y87m+wRZhWNNtpbqbmsenygz8CSyZ8IB9XqvE6ojF/0XOo5ryiskueGZqpwyo
	/uIy7KKv1F7FLWNAw+IwwiIrR+taQKWsZdZbNgKOrneN1hx7tcc5XvcIRQmMoqBr
	gqzdWV/QAcW6/rJzNL9Nco=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXX3qlO+Bnk_g8AA--.12082S5;
	Mon, 24 Mar 2025 00:49:44 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
Date: Mon, 24 Mar 2025 00:48:50 +0800
Message-Id: <20250323164852.430546-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250323164852.430546-1-18255117159@163.com>
References: <20250323164852.430546-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXX3qlO+Bnk_g8AA--.12082S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1xKF4kur1UWr43CF17Jrb_yoW5XFyUpF
	yUGFyfCF1rJFW3uan3Za4UXF15J3Zay347t392k34fZF17CryUGFnFgFyftFZxKrsrWr17
	XryDtas7Kr1rtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvtC-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxkZo2fgMcLw5QABsY

Since the PCI core is now exposing generic APIs for the host bridges to
search for the PCIe capabilities, make use of them in the CDNS driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v5:
https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159@163.com

- Kconfig add "select PCI_HOST_HELPERS"
---
 drivers/pci/controller/cadence/Kconfig        |  1 +
 drivers/pci/controller/cadence/pcie-cadence.c | 25 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 8a0044bb3989..0a4f245bbeb0 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -5,6 +5,7 @@ menu "Cadence-based PCIe controllers"
 
 config PCIE_CADENCE
 	bool
+	select PCI_HOST_HELPERS
 
 config PCIE_CADENCE_HOST
 	bool
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..329dab4ff813 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -8,6 +8,31 @@
 
 #include "pcie-cadence.h"
 
+static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
+{
+	struct cdns_pcie *pcie = priv;
+	u32 val;
+
+	if (size == 4)
+		val = readl(pcie->reg_base + where);
+	else if (size == 2)
+		val = readw(pcie->reg_base + where);
+	else if (size == 1)
+		val = readb(pcie->reg_base + where);
+
+	return val;
+}
+
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
+}
+
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
+}
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay = 0x3;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..6f4981fccb94 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -557,6 +557,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 }
 #endif
 
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
-- 
2.25.1



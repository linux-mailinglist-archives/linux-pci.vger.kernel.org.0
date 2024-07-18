Return-Path: <linux-pci+bounces-10484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBFB934810
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 08:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20021C21A45
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683A57CB4;
	Thu, 18 Jul 2024 06:24:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED777605BA
	for <linux-pci@vger.kernel.org>; Thu, 18 Jul 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283866; cv=none; b=D1l4QYpCjFnDgYAGJ97O+zhWC6c+H0E+D88HRvpi6zEYMQTutCvurlyaiyv+azpuuQa0bI+Z2GLnmRrxrDubVEbg2aH4fq8ZLXFzNLJ0yJdiTgNrJW/WprIh5GzT4Z/ss8A/A6NzaRBK30LrSP8wKHxpf1dyIh12RLj9SeFUlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283866; c=relaxed/simple;
	bh=MOLtsCdEYmFWYJf/WDR3CpjTzHaMsnGa+p1Ce7Ah/j0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEZ3VZR+W5eIeWClwwiiTpTXjWXr4g8Cyu4ISPHOJRnfgfD5byJoYnyzcVMZo2VTdUjT+oc+cxvjT/ZW1CYXGogJloGggDXwBoGXitF1E/7jyhVxsnN3a6Dr9ccC+Rk1nIvOK+Qry8LZ3kysK000j4WsBSuoIR0hMRWX2on0lvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1721283854-086e2311051c8fb0001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id 7t3wzscZeRPh1psd (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 18 Jul 2024 14:24:14 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 14:24:13 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 14:24:11 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <TonyWWang-oc@zhaoxin.com>,
	<leoliu-oc@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v3 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Date: Thu, 18 Jul 2024 14:24:05 +0800
X-ASG-Orig-Subj: [PATCH v3 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20240718062405.30571-4-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718062405.30571-1-LeoLiu-oc@zhaoxin.com>
References: <b99685d9-9f3a-4c21-8d33-2eaa5de8be54@zhaoxin.com>
 <20240718062405.30571-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1721283854
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5203
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.127785
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Call the func pci_acpi_program_hest_aer_params() for every PCIe device,
the purpose of this function is to extract register value from HEST PCIe
AER structures and program them into AER Capabilities. This function
applies to all hardware platforms that has a PCI Express AER structure
in HEST.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/pci/pci-acpi.c | 101 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |   9 ++++
 drivers/pci/probe.c    |   1 +
 3 files changed, 111 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..b522e8b226b8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
+#include <acpi/apei.h>
 #include "pci.h"
 
 /*
@@ -783,6 +784,106 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 	return -ENODEV;
 }
 
+#ifdef CONFIG_ACPI_APEI
+/*
+ * program_hest_aer_common() - configure AER common registers for Root Ports,
+ * Endpoints and PCIe to PCI/PCI-X bridges
+ */
+static void program_hest_aer_common(struct acpi_hest_aer_common aer_common, struct pci_dev *dev,
+				    int pos)
+{
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_mask;
+	u32 adv_cap;
+
+	uncor_mask = aer_common.uncorrectable_mask;
+	uncor_severity = aer_common.uncorrectable_severity;
+	cor_mask = aer_common.correctable_mask;
+	adv_cap = aer_common.advanced_capabilities;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_severity);
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);
+}
+
+static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root, struct pci_dev *dev, int pos)
+{
+	u32 root_err_cmd;
+
+	root_err_cmd = aer_root->root_error_command;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_cmd);
+}
+
+static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_aer_bridge,
+				    struct pci_dev *dev, int pos)
+{
+	u32 uncor_mask2;
+	u32 uncor_severity2;
+	u32 adv_cap2;
+
+	uncor_mask2 = hest_aer_bridge->uncorrectable_mask2;
+	uncor_severity2 = hest_aer_bridge->uncorrectable_severity2;
+	adv_cap2 = hest_aer_bridge->advanced_capabilities2;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncor_mask2);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncor_severity2);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP2, adv_cap2);
+}
+
+static void program_hest_aer_params(struct hest_parse_aer_info info)
+{
+	struct pci_dev *dev;
+	int port_type;
+	int pos;
+	struct acpi_hest_aer_root *hest_aer_root;
+	struct acpi_hest_aer *hest_aer_endpoint;
+	struct acpi_hest_aer_bridge *hest_aer_bridge;
+
+	dev = info.pci_dev;
+	port_type = pci_pcie_type(dev);
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	switch (port_type) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+		hest_aer_root = info.hest_aer_root_port;
+		program_hest_aer_common(hest_aer_root->aer, dev, pos);
+		program_hest_aer_root(hest_aer_root, dev, pos);
+		break;
+	case PCI_EXP_TYPE_ENDPOINT:
+		hest_aer_endpoint = info.hest_aer_endpoint;
+		program_hest_aer_common(hest_aer_endpoint->aer, dev, pos);
+		break;
+	case PCI_EXP_TYPE_PCI_BRIDGE:
+		hest_aer_bridge = info.hest_aer_bridge;
+		program_hest_aer_common(hest_aer_bridge->aer, dev, pos);
+		program_hest_aer_bridge(hest_aer_bridge, dev, pos);
+		break;
+	default:
+		break;
+	}
+}
+
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	struct hest_parse_aer_info info = {
+		.pci_dev = dev
+	};
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	if (apei_hest_parse(hest_parse_pcie_aer, &info) == 1)
+		program_hest_aer_params(info);
+
+	return 0;
+}
+#endif
+
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
  * @bridge: Hotplug port to check
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c4756..03b5339f399f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -731,6 +731,15 @@ static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_ACPI_APEI
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
+#else
+static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4c367f13acdc..f7d80b2a9d1d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2267,6 +2267,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_serr(dev);
 
 	pci_acpi_program_hp_params(dev);
+	pci_acpi_program_hest_aer_params(dev);
 }
 
 static void pci_release_capabilities(struct pci_dev *dev)
-- 
2.34.1



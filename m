Return-Path: <linux-pci+bounces-22481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E0A47081
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33056188A96A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD0270042;
	Thu, 27 Feb 2025 00:48:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28076034
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617314; cv=none; b=FiOAgbn6GOT4ZxswjD07UUXPePSJDHWSsedksrnvYoChnKZUTXSFk4zFjkC0s0WEa5WY4VvGZIb/ZYguaXeKhknGUI0uQn5IXb8bdLUxHade4kt5eTwhffh/2NV+omSHum9J/90B/QdP3RfbHZ54pCpIGx/YLh7MUkci+neCD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617314; c=relaxed/simple;
	bh=TW2S73cCRvglYfDwmQGd9RWd8/DD6yZTh696UemLXhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0TaQ4ovgmgJGADpKJTySmiQs4qkAUlyBLoXL2uvjtIrdGSf56NmnLZjgu82295ThOz2PYvAJF5Q+KivM/E4vAa38Jlb112TSH6dGo3P9akVML+vW6GwCs76XlrrdSoZkeoQsYH6yYySIIrNxXLfvtksgl0t1mVd/uXPkIJNcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1740616660-1eb14e7a0031330001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id UYHoqvL7SyDRaaIW (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Feb 2025 08:37:40 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 27 Feb
 2025 08:37:40 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298]) by
 ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298%4]) with mapi id
 15.01.2507.044; Thu, 27 Feb 2025 08:37:40 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 20:19:04 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v5 4/4] PCI: ACPI: Add new pci_acpi_program_hest_aer_params()
Date: Wed, 26 Feb 2025 20:18:38 +0800
X-ASG-Orig-Subj: [PATCH v5 4/4] PCI: ACPI: Add new pci_acpi_program_hest_aer_params()
Message-ID: <20250226121838.364533-5-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
References: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 2/27/2025 8:37:39 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1740616660
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5086
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.137756
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
 drivers/pci/pci-acpi.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |  6 +++
 drivers/pci/probe.c    |  1 +
 3 files changed, 97 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..2e9a50fc7433 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -19,6 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
+#include <acpi/apei.h>
 #include "pci.h"
=20
 /*
@@ -806,6 +807,95 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 	return -ENODEV;
 }
=20
+#ifdef CONFIG_ACPI_APEI
+/*
+ * program_hest_aer_common() - configure AER common registers for Root Por=
ts,
+ * Endpoints and PCIe to PCI/PCI-X bridges
+ */
+static void program_hest_aer_common(struct acpi_hest_aer_common aer_common=
, struct pci_dev *dev,
+				    int pos)
+{
+	u32 uncor_mask =3D aer_common.uncorrectable_mask;
+	u32 uncor_severity =3D aer_common.uncorrectable_severity;
+	u32 cor_mask =3D aer_common.correctable_mask;
+	u32 adv_cap =3D aer_common.advanced_capabilities;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_severity);
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);
+}
+
+static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root, str=
uct pci_dev *dev, int pos)
+{
+	u32 root_err_cmd =3D aer_root->root_error_command;
+
+	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_cmd);
+}
+
+static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_aer_=
bridge,
+				    struct pci_dev *dev, int pos)
+{
+	u32 uncor_mask2 =3D hest_aer_bridge->uncorrectable_mask2;
+	u32 uncor_severity2 =3D hest_aer_bridge->uncorrectable_severity2;
+	u32 adv_cap2 =3D hest_aer_bridge->advanced_capabilities2;
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
+	dev =3D info.pci_dev;
+	port_type =3D pci_pcie_type(dev);
+	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	switch (port_type) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+		hest_aer_root =3D (struct acpi_hest_aer_root *)info.data;
+		program_hest_aer_common(hest_aer_root->aer, dev, pos);
+		program_hest_aer_root(hest_aer_root, dev, pos);
+		break;
+	case PCI_EXP_TYPE_ENDPOINT:
+		hest_aer_endpoint =3D (struct acpi_hest_aer *)info.data;
+		program_hest_aer_common(hest_aer_endpoint->aer, dev, pos);
+		break;
+	case PCI_EXP_TYPE_PCI_BRIDGE:
+		hest_aer_bridge =3D (struct acpi_hest_aer_bridge *)info.data;
+		program_hest_aer_common(hest_aer_bridge->aer, dev, pos);
+		program_hest_aer_bridge(hest_aer_bridge, dev, pos);
+		break;
+	default:
+		break;
+	}
+}
+
+void pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	struct hest_parse_aer_info info =3D {
+		.pci_dev =3D dev
+	};
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	if (apei_hest_parse(hest_parse_pcie_aer, &info) > 0)
+		program_hest_aer_params(info);
+
+	return;
+}
+#endif
+
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
  * @bridge: Hotplug port to check
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..6ce44a2a3a69 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -902,6 +902,12 @@ static inline void pci_save_aer_state(struct pci_dev *=
dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
=20
+#ifdef CONFIG_ACPI_APEI
+void pci_acpi_program_hest_aer_params(struct pci_dev *dev);
+#else
+static inline void pci_acpi_program_hest_aer_params(struct pci_dev *dev){ =
}
+#endif
+
 #ifdef CONFIG_ACPI
 bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
 int pci_acpi_program_hp_params(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 246744d8d268..40ef918c049c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2352,6 +2352,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_serr(dev);
=20
 	pci_acpi_program_hp_params(dev);
+	pci_acpi_program_hest_aer_params(dev);
 }
=20
 static void pci_release_capabilities(struct pci_dev *dev)
--=20
2.34.1



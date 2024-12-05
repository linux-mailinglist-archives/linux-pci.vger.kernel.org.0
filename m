Return-Path: <linux-pci+bounces-17820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2505D9E62E2
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 02:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70997161008
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614C12E7E;
	Fri,  6 Dec 2024 01:01:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8020322
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446874; cv=none; b=M5BgVd64Ci4gp/vn7yYo0dk0wdjHn1IVjD0nUrv/cFizA6zxj0stgUrSDDrJddOfcmW2fS5qjkZkQMQBLwlMUXsnAIDn5IAR+KzNurG7AOgxuhYTbfkmOMQ9otP950MYrmXnjpJ/hPY2axxdztheECkIL4QQoIqMO8dKtbFmZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446874; c=relaxed/simple;
	bh=BZDWQsHtRy44rkEInZidbrfQIqeEZfyRGi0P6saJo4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scRYy29bUnQttnVPKrDsmLZ+1crhL04gk9q/vapuJqy4BY8tT06iVpN/wP1tTbcmDTQlq7Y0s/U+Y4AMxrbQObKJcmztrawZq/dTQJAshN9SHzcYoDPPmu1mL1JS7tFTafoeMccZQvjEu3Qi6Yad1JqpVaU5eDT2b9SZ3oSr07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1733446120-086e2312d8235b0001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id jxbgTCABAZk6K1vs (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 06 Dec 2024 08:48:40 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 6 Dec
 2024 08:48:39 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Fri, 6 Dec 2024 08:48:39 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 19:40:50 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <avadhut.naik@amd.com>, <yazen.ghannam@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v4 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
Date: Thu, 5 Dec 2024 19:40:46 +0800
X-ASG-Orig-Subj: [PATCH v4 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
Message-ID: <20241205114048.60291-2-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
References: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
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
X-Moderation-Data: 12/6/2024 8:48:38 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1733446120
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4332
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.134151
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

The purpose of the function apei_hest_parse_aer() is used to parse and
extract register value from HEST PCIe AER structures. This applies to
all hardware platforms that has a PCI Express AER structure in HEST.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/acpi/apei/hest.c | 77 ++++++++++++++++++++++++++++++++++++++--
 include/acpi/apei.h      | 17 +++++++++
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 20d757687e3d..13075f5aea25 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -22,6 +22,7 @@
 #include <linux/kdebug.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
@@ -132,9 +133,81 @@ static bool is_ghes_assist_struct(struct acpi_hest_hea=
der *hest_hdr)
 	return false;
 }
=20
-typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *d=
ata);
+#ifdef CONFIG_ACPI_APEI
+static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
+				 struct pci_dev *dev)
+{
+	return ACPI_HEST_SEGMENT(p->bus) =3D=3D pci_domain_nr(dev->bus) &&
+	       ACPI_HEST_BUS(p->bus) =3D=3D dev->bus->number &&
+	       p->device =3D=3D PCI_SLOT(dev->devfn) &&
+	       p->function =3D=3D PCI_FUNC(dev->devfn);
+}
+
+static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr,
+				    struct pci_dev *dev)
+{
+	u16 hest_type =3D hest_hdr->type;
+	u8 pcie_type =3D pci_pcie_type(dev);
+	struct acpi_hest_aer_common *common;
+
+	common =3D (struct acpi_hest_aer_common *)(hest_hdr + 1);
+
+	switch (hest_type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+		if (pcie_type !=3D PCI_EXP_TYPE_ROOT_PORT)
+			return false;
+	break;
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+		if (pcie_type !=3D PCI_EXP_TYPE_ENDPOINT)
+			return false;
+	break;
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		if (pcie_type !=3D PCI_EXP_TYPE_PCI_BRIDGE &&
+		    pcie_type !=3D PCI_EXP_TYPE_PCIE_BRIDGE)
+			return false;
+	break;
+	default:
+		return false;
+	break;
+	}
+
+	if (common->flags & ACPI_HEST_GLOBAL)
+		return true;
+
+	if (hest_match_pci_devfn(common, dev))
+		return true;
+
+	return false;
+}
+
+int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data)
+{
+	struct hest_parse_aer_info *info =3D data;
+
+	if (!hest_source_is_pcie_aer(hest_hdr, info->pci_dev))
+		return 0;
+
+	switch (hest_hdr->type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+		info->hest_aer_root_port =3D (struct acpi_hest_aer_root *)hest_hdr;
+		return 1;
+	break;
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+		info->hest_aer_endpoint =3D (struct acpi_hest_aer *)hest_hdr;
+		return 1;
+	break;
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		info->hest_aer_bridge =3D (struct acpi_hest_aer_bridge *)hest_hdr;
+		return 1;
+	break;
+	default:
+		return 0;
+	break;
+	}
+}
+#endif
=20
-static int apei_hest_parse(apei_hest_func_t func, void *data)
+int apei_hest_parse(apei_hest_func_t func, void *data)
 {
 	struct acpi_hest_header *hest_hdr;
 	int i, rc, len;
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524..82d3cdf53e22 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -23,6 +23,15 @@ enum hest_status {
 	HEST_NOT_FOUND,
 };
=20
+#ifdef CONFIG_ACPI_APEI
+struct hest_parse_aer_info {
+	struct pci_dev *pci_dev;
+	struct acpi_hest_aer *hest_aer_endpoint;
+	struct acpi_hest_aer_root *hest_aer_root_port;
+	struct acpi_hest_aer_bridge *hest_aer_bridge;
+};
+#endif
+
 extern int hest_disable;
 extern int erst_disable;
 #ifdef CONFIG_ACPI_APEI_GHES
@@ -33,10 +42,18 @@ void __init acpi_ghes_init(void);
 static inline void acpi_ghes_init(void) { }
 #endif
=20
+typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *d=
ata);
+int apei_hest_parse(apei_hest_func_t func, void *data);
+
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
+int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data);
 #else
 static inline void acpi_hest_init(void) { }
+static inline int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, v=
oid *data)
+{
+	return 0;
+}
 #endif
=20
 int erst_write(const struct cper_record_header *record);
--=20
2.34.1



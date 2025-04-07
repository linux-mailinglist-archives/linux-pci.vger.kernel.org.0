Return-Path: <linux-pci+bounces-25356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7ADA7D1F1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 04:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A1C7A3AFA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 02:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ED52139A6;
	Mon,  7 Apr 2025 02:07:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D10213254
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991649; cv=none; b=nah4cHQxL/TjmoY+7fk2eBMazlU2PvQAD0+CWnGGqaIscfZFo2aw++nFRHGQFHzVikMsTPQJFf78+4qVaoxHt2qFp/qdGHWOwAZbhFjA/BuGpNmrKqXeuEQeOrghaNVG9TPnExyWDVygdm6pnLHFINENGFHZYzdNOo56aR9RH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991649; c=relaxed/simple;
	bh=v+XmZ2KqPRp5EmGTIn9tSyg8cYsDYB9TmrdHK15WHHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1ZT4V/CkgggyfSUeLfAT8PppgxD8Y0RdpNqENfaUyVnJFcYkLCt1fd308kSlANn7t8HJjhKRgl+5+mD2gjmlrxyLeY4VgLFYY4Er3wPOvKaS4MwWBBX3vz1lgXBdzv4f+aSCdiMH+SV1SDLBdfKIo8cTWYNA8gBFXkdAv4b4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1743991636-086e2365b73eef0001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id Avv6ZhqOzy6NHmEd (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 07 Apr 2025 10:07:16 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 7 Apr
 2025 10:07:16 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Mon, 7 Apr 2025 10:07:16 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 7 Apr
 2025 10:06:01 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v6 2/4] ACPI: APEI: Add new hest_parse_pcie_aer()
Date: Mon, 7 Apr 2025 10:05:55 +0800
X-ASG-Orig-Subj: [PATCH v6 2/4] ACPI: APEI: Add new hest_parse_pcie_aer()
Message-ID: <20250407020557.1225166-3-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407020557.1225166-1-LeoLiu-oc@zhaoxin.com>
References: <20250407020557.1225166-1-LeoLiu-oc@zhaoxin.com>
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
X-Moderation-Data: 4/7/2025 10:07:15 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1743991636
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3372
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139599
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

The purpose of the function apei_hest_parse_aer() is used to parse and
extract register value from HEST PCIe AER structures. This applies to
all hardware platforms that has a PCI Express AER structure in HEST.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/acpi/apei/hest.c | 52 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/apei.h      | 10 ++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 05ab4388cd4b..e7a15d60ecc1 100644
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
@@ -132,6 +133,57 @@ static bool is_ghes_assist_struct(struct acpi_hest_hea=
der *hest_hdr)
 	return false;
 }
=20
+static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p, struct pc=
i_dev *dev)
+{
+	return ACPI_HEST_SEGMENT(p->bus) =3D=3D pci_domain_nr(dev->bus) &&
+	       ACPI_HEST_BUS(p->bus)     =3D=3D dev->bus->number &&
+	       p->device                 =3D=3D PCI_SLOT(dev->devfn) &&
+	       p->function               =3D=3D PCI_FUNC(dev->devfn);
+}
+
+static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr, str=
uct pci_dev *dev)
+{
+	u16 hest_type =3D hest_hdr->type;
+	u8 pcie_type =3D pci_pcie_type(dev);
+	struct acpi_hest_aer_common *common =3D (struct acpi_hest_aer_common *)(h=
est_hdr + 1);
+
+	switch (hest_type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+		if (pcie_type !=3D PCI_EXP_TYPE_ROOT_PORT)
+			return false;
+		break;
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+		if (pcie_type !=3D PCI_EXP_TYPE_ENDPOINT)
+			return false;
+		break;
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		if (pcie_type !=3D PCI_EXP_TYPE_PCI_BRIDGE && pcie_type !=3D PCI_EXP_TYP=
E_PCIE_BRIDGE)
+			return false;
+		break;
+	default:
+		return false;
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
+	info->data =3D (void *)hest_hdr;
+	if (!hest_source_is_pcie_aer(hest_hdr, info->pci_dev))
+		return 0;
+	else
+		return 1;
+}
+
 int apei_hest_parse(apei_hest_func_t func, void *data)
 {
 	struct acpi_hest_header *hest_hdr;
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index da8fe0d9758a..137d99760e23 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -23,6 +23,11 @@ enum hest_status {
 	HEST_NOT_FOUND,
 };
=20
+struct hest_parse_aer_info {
+	struct pci_dev *pci_dev;
+	void *data;
+};
+
 extern int hest_disable;
 extern int erst_disable;
 #ifdef CONFIG_ACPI_APEI_GHES
@@ -35,8 +40,13 @@ static inline void acpi_ghes_init(void) { }
=20
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
 typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *d=
ata);
--=20
2.34.1



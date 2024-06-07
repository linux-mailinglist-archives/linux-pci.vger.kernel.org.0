Return-Path: <linux-pci+bounces-8431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D828FFD89
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3BA1C228A3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E3715ADAA;
	Fri,  7 Jun 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p//Eo88w"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2D15AD9A;
	Fri,  7 Jun 2024 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746698; cv=fail; b=on15vpYk6TnYtoKEJDK80lbwVo2AnU0MHqWmuolI5L468Dq8/uZeuoR88Twa9rsSxTWgrGGybi4zhyTr8Dp6kvTBfAk+Vw60tTvV8StkQobAkVV+J5Aee0LDOlSMlfwdGaXvpWh76U48ON5otYiKk0ePazYuHU0O6HfzsS9nh08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746698; c=relaxed/simple;
	bh=IoWgcFDnmoaB4/Zw6HinZQWtfCv+sV4hOs48gmjcEks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdbWFiFJI3lHlY4fYaTag6csIeo7OAgHNC1VnwijoZQadV1KD22tGKZaQs8MWf2SDuhh4tvKYRQ2A2uyj4tPH7w3/leSsZdsHOH0BV4Un9NvJuk/rZh5HsjbQZFN4Epz4NmwxGUlLzzGJbIP9vEGAka4MIVI3ljRyxFDEkczEY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p//Eo88w; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcJz2Dog3W2VKtI3+JLMf0WVGO2P5FoqVMd7r70ar/oPM0RoNovRgOPT8aPUCPtSllYlPM6N4AdRvdQFykR+HttX4BVXX9o/jr5Fhv3t7iCxcrG/lGclbxJZW3UADdwRtzRgoxalISSuU/GqMjqdBMNs4Ccnj4/6jbs1Zj4Q1ASREibWGRYI6qPKGsHR5JnbuwUR3NB+ZPEGjLBv1TYqSYNyX6eqtGJzNuFb7tpiydjM79s9GSh61HOnd8bMOPYPmMFjAbCdDWMe1bOEdPWt/JQm9ak7iL6uqzWa1uVu8F6gkC8uwep6ejARnjGcVtX28woQ7DdqNyxo/BUkJov10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En8bxbSZDHQoAf0vgERQjVcF+6/gOfNjPiz97+LyFn0=;
 b=QMZRgzSJRzV0O8Nctm5F8C5REZLM3CMdcvN/lS9oEcyS3Xjsqxt8gwr+SDZPSJJ0h3+g9H/s4yZcWywpXvnR+RG10pdRy5TkqE9iUeusHGrMN91z4C556w1Oh6ymsIRMQtAod21VW8UQb/IhIn7tIRTDFBvWrAFNcsc/e6OvXgdlhhcKS90WjtADDc0Ya17kHldZtHcDwirgizvGCvVJd6XVTBGbGuogSs5L2iVot7wERTCKAANR/T2VzqnpE4Ugf2eTFlBRdGDWrjDEC4gfAQZEJ6eLgONkgC6Z3B/3yUJiUM249jNGZ48pUXC53n22bxCv8kzQTLz/5hTvqdigZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En8bxbSZDHQoAf0vgERQjVcF+6/gOfNjPiz97+LyFn0=;
 b=p//Eo88w5UJ2aGK82DXEc1uLu1F5hYVa8roDeHWDb9QsEgEFA0aXMwVZeLZ5qg07V1k97LkAVuamlHdapm+8cRLyjgkHE08br0AZnpamtF/6P3v/KH62j45/QYGGrzWifmvgh4U+ekHU+i96MPEPWo0C5dcFREBEHoh1Low+/Kc=
Received: from SN7PR04CA0238.namprd04.prod.outlook.com (2603:10b6:806:127::33)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:51:33 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::17) by SN7PR04CA0238.outlook.office365.com
 (2603:10b6:806:127::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 07:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 07:51:33 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 02:51:29 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Huang Rui
	<Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui
	<ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v8 2/3] xen/pvh: Setup gsi for passthrough device
Date: Fri, 7 Jun 2024 15:51:08 +0800
Message-ID: <20240607075109.126277-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607075109.126277-1-Jiqian.Chen@amd.com>
References: <20240607075109.126277-1-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 72998cb6-13e8-46cc-407d-08dc86c6a66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04lJ6K7HjkkORc1ZkIo7kjNT5naMCWjWNN1iCyffm3en1aEMaEdKB9GxQlMt?=
 =?us-ascii?Q?46fVljwKopwSnLvepyA22xQuV3FTnD9UUlEf3MW22XUkGvWVtdvBbVJwPIsf?=
 =?us-ascii?Q?UyMegBXs1BjgXVbKHtE+Di6H8pcruwFZYLhh1XMsPaSmLIZ5URt7guxxzVxd?=
 =?us-ascii?Q?NgWxK84GsLRtGFoAE87MhtUdmMuqoHTVbDVzUc/v+tAc/oIRDq++XjuBP5nv?=
 =?us-ascii?Q?nVtjFw01Xux1Cf7DA9tykItI8qG/XGTI2wOY4JgIObKinMZPjkyxYtJYY8w2?=
 =?us-ascii?Q?eXD8aKOxpH5ev1y64fOro7c1HWBUJJ057yvuVPCq9O35qDpEE8/r4wM/6Esb?=
 =?us-ascii?Q?GWnQX173sUH2ctH3WNdgNJ7fSXWslO8PQcpLkoxwC3GvZVMBLbUJ8IYvHnmV?=
 =?us-ascii?Q?RBtEZ4YeWw+lVZkKFBGZHBwdRezaJkAqDwxSbDRlK/WzDBLeMECGT6pt2amB?=
 =?us-ascii?Q?qCK7hgAZnBLN8e1+4v8lBhqmFsvumNlZmAmvGoeeFIG/rxiSS5kRjra38Nut?=
 =?us-ascii?Q?OAKeZhl55yj9OJp7us2tJqoD3cnwEt5B8tY0/SPOhn/wsmLUeCMaxXZk5it9?=
 =?us-ascii?Q?WDGxq5nGiYcgRzIVjaAGXw1fFuEeVU69Q9+X+nTTJXaO19YmEN/qBRIkzvSU?=
 =?us-ascii?Q?CGvP6ke1apZvH5jotCVcyG5hSIpFRKY8jSa60lzvR9+DwAZ0jGNFRW8p8jSq?=
 =?us-ascii?Q?YoSQ+HIA763rhKbc8k1HptztgQ/t9t5KMhBJj4RJDQ0fAwu9/BXWCijSAISL?=
 =?us-ascii?Q?z92OfedmH7EKV28rdnY0QJev9PYj85QZgDhp3qbv8d/AE7G0pLR53IabEqJp?=
 =?us-ascii?Q?7jDNhwd2aObru2Zsf9I76iAbWABWGG4+zi0httZrpXYmaTliVdWS6HQvthjQ?=
 =?us-ascii?Q?o3qyZy+wiRpunWfe1/XGm5nruLGQEoHSdr/SgejdHrwBQmo+J7pL+gEpro9L?=
 =?us-ascii?Q?A2yKsoxc9GEroEbhwvw79zs3EMw/QuPEsG3J0y/N7PZKfPVNNyT1JWpAk+s9?=
 =?us-ascii?Q?N8OuXuQrTS9IWNzpbZa4eDc9NKOUniCvd8y8WWaWJ1O7nD+x71ZNpWs7obiK?=
 =?us-ascii?Q?AKZr5WA7izx7Sj1ajYiOLy2JQwxnFKA+U+HcdXk+y2Zy6mEGBlsZatvgnqCw?=
 =?us-ascii?Q?9/nCjSpy2W8OYpLorLJByrPTJON3LgviYEyF73maWq63qNUQPLXiW0lm8MY9?=
 =?us-ascii?Q?UAw6viP593yYexNtJcf2uHn19GGyR1wMFfCze56LXGRmfwgFVwr5etjy3j+1?=
 =?us-ascii?Q?oNUMNYNaCCNO1WqmSjXN5mSwsSV4fLyjZN/NBru5InCRtwMiICMYN1SupG/I?=
 =?us-ascii?Q?qmXWvUjQUjqzy5oK+N2gbnW4vRvcshN8G9JFaRZwNoRzjsN2BeeWqhr+r9zG?=
 =?us-ascii?Q?BiBEDHae2S3w5zQ96cHdbt/VWt5knELPM8a+/PwJC1xDGYqlHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:51:33.2876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72998cb6-13e8-46cc-407d-08dc86c6a66e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071

In PVH dom0, the gsis don't get registered, but the gsi of
a passthrough device must be configured for it to be able to be
mapped into a domU.

When assign a device to passthrough, proactively setup the gsi
of the device during that process.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
RFC: it need to wait for the corresponding third patch on xen side to be merged.
---
 arch/x86/xen/enlighten_pvh.c       | 23 ++++++++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/acpi.c                 | 50 ++++++++++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 21 +++++++++++++
 include/linux/acpi.h               |  1 +
 include/xen/acpi.h                 | 10 ++++++
 6 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 27a2a02ef8fb..6caadf9c00ab 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -4,6 +4,7 @@
 #include <linux/mm.h>
 
 #include <xen/hvc-console.h>
+#include <xen/acpi.h>
 
 #include <asm/bootparam.h>
 #include <asm/io_apic.h>
@@ -27,6 +28,28 @@
 bool __ro_after_init xen_pvh;
 EXPORT_SYMBOL_GPL(xen_pvh);
 
+#ifdef CONFIG_XEN_DOM0
+int xen_pvh_setup_gsi(int gsi, int trigger, int polarity)
+{
+	int ret;
+	struct physdev_setup_gsi setup_gsi;
+
+	setup_gsi.gsi = gsi;
+	setup_gsi.triggering = (trigger == ACPI_EDGE_SENSITIVE ? 0 : 1);
+	setup_gsi.polarity = (polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
+
+	ret = HYPERVISOR_physdev_op(PHYSDEVOP_setup_gsi, &setup_gsi);
+	if (ret == -EEXIST) {
+		xen_raw_printk("Already setup the GSI :%d\n", gsi);
+		ret = 0;
+	} else if (ret)
+		xen_raw_printk("Fail to setup GSI (%d)!\n", gsi);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xen_pvh_setup_gsi);
+#endif
+
 void __init xen_pvh_init(struct boot_params *boot_params)
 {
 	u32 msr;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ff30ceca2203..630fe0a34bc6 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -288,7 +288,7 @@ static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
 }
 #endif /* CONFIG_X86_IO_APIC */
 
-static struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry = NULL;
 	struct pci_dev *bridge;
diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
index 6893c79fd2a1..9e2096524fbc 100644
--- a/drivers/xen/acpi.c
+++ b/drivers/xen/acpi.c
@@ -30,6 +30,7 @@
  * IN THE SOFTWARE.
  */
 
+#include <linux/pci.h>
 #include <xen/acpi.h>
 #include <xen/interface/platform.h>
 #include <asm/xen/hypercall.h>
@@ -75,3 +76,52 @@ int xen_acpi_notify_hypervisor_extended_sleep(u8 sleep_state,
 	return xen_acpi_notify_hypervisor_state(sleep_state, val_a,
 						val_b, true);
 }
+
+struct acpi_prt_entry {
+	struct acpi_pci_id      id;
+	u8                      pin;
+	acpi_handle             link;
+	u32                     index;
+};
+
+int xen_acpi_get_gsi_info(struct pci_dev *dev,
+						  int *gsi_out,
+						  int *trigger_out,
+						  int *polarity_out)
+{
+	int gsi;
+	u8 pin;
+	struct acpi_prt_entry *entry;
+	int trigger = ACPI_LEVEL_SENSITIVE;
+	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
+				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
+
+	if (!dev || !gsi_out || !trigger_out || !polarity_out)
+		return -EINVAL;
+
+	pin = dev->pin;
+	if (!pin)
+		return -EINVAL;
+
+	entry = acpi_pci_irq_lookup(dev, pin);
+	if (entry) {
+		if (entry->link)
+			gsi = acpi_pci_link_allocate_irq(entry->link,
+							 entry->index,
+							 &trigger, &polarity,
+							 NULL);
+		else
+			gsi = entry->index;
+	} else
+		gsi = -1;
+
+	if (gsi < 0)
+		return -EINVAL;
+
+	*gsi_out = gsi;
+	*trigger_out = trigger;
+	*polarity_out = polarity;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xen_acpi_get_gsi_info);
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 73062e531c34..6b22e45188f5 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -21,6 +21,9 @@
 #include <xen/events.h>
 #include <xen/pci.h>
 #include <xen/xen.h>
+#ifdef CONFIG_XEN_ACPI
+#include <xen/acpi.h>
+#endif
 #include <asm/xen/hypervisor.h>
 #include <xen/interface/physdev.h>
 #include "pciback.h"
@@ -367,6 +370,9 @@ static int pcistub_match(struct pci_dev *dev)
 static int pcistub_init_device(struct pci_dev *dev)
 {
 	struct xen_pcibk_dev_data *dev_data;
+#ifdef CONFIG_XEN_ACPI
+	int gsi, trigger, polarity;
+#endif
 	int err = 0;
 
 	dev_dbg(&dev->dev, "initializing...\n");
@@ -435,6 +441,21 @@ static int pcistub_init_device(struct pci_dev *dev)
 			goto config_release;
 		pci_restore_state(dev);
 	}
+
+#ifdef CONFIG_XEN_ACPI
+	err = xen_acpi_get_gsi_info(dev, &gsi, &trigger, &polarity);
+	if (err) {
+		dev_err(&dev->dev, "Fail to get gsi info!\n");
+		goto config_release;
+	}
+
+	if (xen_initial_domain() && xen_pvh_domain()) {
+		err = xen_pvh_setup_gsi(gsi, trigger, polarity);
+		if (err)
+			goto config_release;
+	}
+#endif
+
 	/* Now disable the device (this also ensures some private device
 	 * data is setup before we export)
 	 */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c517a..f8690b02bba4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -361,6 +361,7 @@ void acpi_unregister_gsi (u32 gsi);
 
 struct pci_dev;
 
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin);
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index b1e11863144d..9b50027113f3 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -67,10 +67,20 @@ static inline void xen_acpi_sleep_register(void)
 		acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
 	}
 }
+int xen_pvh_setup_gsi(int gsi, int trigger, int polarity);
 #else
 static inline void xen_acpi_sleep_register(void)
 {
 }
+
+static inline int xen_pvh_setup_gsi(int gsi, int trigger, int polarity)
+{
+	return -1;
+}
 #endif
 
+int xen_acpi_get_gsi_info(struct pci_dev *dev,
+						  int *gsi_out,
+						  int *trigger_out,
+						  int *polarity_out);
 #endif	/* _XEN_ACPI_H */
-- 
2.34.1



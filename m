Return-Path: <linux-pci+bounces-7256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462178C036D
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 19:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F381C208F5
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6768C12A142;
	Wed,  8 May 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fC+795Wz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA282C6B;
	Wed,  8 May 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190152; cv=fail; b=R1BFWQ7lkBbOhVwGP+nbks9nHV7hiykHmo/ul9nViJlrL4RpqXfD1rgvl8uVN03+7EJU7CpUBysOFksoZy8yshr8FwaBYAPQRpxB2+khAn+VAr2qbo/CsEi2ApBeQ1BV9P0Oc2CriA+3OjT2P9VNi6fqsQdSog7OcwV2zYHS8J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190152; c=relaxed/simple;
	bh=+l6adHMaDkBXHWW0w6MlfZkSJjHwHA6tERK1lfqVACk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeaQ6MB6QPQW4qU11qbr82FNBJUDaQpotY6dFO/Kq3A2xk+Y61VR4P169Y+6m+jDQ60sMnKqwwZ/P/L8HjqyMvWXhV6KS87MhGiq15bBWAdW2Kd/yihNb56kM2JG+riyitsWopuO291Kxrwd73st0Ie64KDkldZEC/2IzsuFwto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fC+795Wz; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cbq8PFHl33YpfiYnIiH4rpwcgkqmScyxMLYPiIyOw7UjdYu0C6/exmMyzzhh7Nc3VLR0RQz5Kw9921SOJpUbZRwwj+gmw/2yfVKJcqtTqLeeuuY4BolsO3UKeZsvpyvjtQSMlBgu+OQ8VzflPY+SigIgOM8SIXuL2zwZoltBe7S0rzH1LDtamby3fu12rgqMyzJCsPzG2aoomR3vKCzSUN6Wlr2elSzRrzJfd2d+4OOO9fR+FYshMpcwZgjXO8vfx5h9mcoZs3Vfdv5S2ftn/etCQsTksaXOeAhi6V5SlobyCcxVHJj1QtJmw4aDdgKbR+tfRXrphEXZpqtzSi6Lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0qaI7bWkocJbbMim1MkePA4fSS4RjMNRqTY7lgoiXY=;
 b=EoR0PogaLaVD02xB0dd2RH8D79gCK0PRksTzmYG5JaEStT3vYnNPDxwbvkg9A5mBric0C/M0cKw3rAke4aEARMVaXepljel1uWt8CpWXi6VspBkdhvTHof2wermNIZPz6swO/gzd2T9JsYXmOahOjFlIITf42127Cn+d4se4JuqZBdwEihJ+tJR3/j5KfcV+IZ6OsXCze1B13SbezbGufM4KuNpAoUkfumkEQ1Zeq7jtuzeXUC9dSuGyR0wCd445lk9FJB8i0Th9XYT3D6k5ksU1LHGtKwm3SQBkju7wyAYEAfIHzqr8e5EqQmdAc3yDtegpt9VTX/ef/BNhydq6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0qaI7bWkocJbbMim1MkePA4fSS4RjMNRqTY7lgoiXY=;
 b=fC+795WzflbTYDcETUyUUYj1OXAn4QU8M3pgPMREVRwK4a312NwCrPSoHPw7F2PhS0wjXbfpcVq66w/xuHB6fcVuZ8tXjmCF+QKwyAumwJLjvmLhv4w9fsuFGbA3m3OTu5KFAovnAbjgWudBsTCF80g47dsoMQnNhyUF9V10MT5x3/t3y+7PKrs2NvgWwNJuJ1EYVYQtNSp8BBhG+0ZCtVKr+Ug12zJmyeAPfXk20naLooD99QOLGDO9DqYo0Da1cJgrtLMHGOjAQ1hPZvk19cONWD7krIjrvgBW1tuD08EPog13aF0JrxneIzI1Rep2cnm7ONSX50wlPeAR73CVEQ==
Received: from DM5PR07CA0067.namprd07.prod.outlook.com (2603:10b6:4:ad::32) by
 PH8PR12MB6866.namprd12.prod.outlook.com (2603:10b6:510:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:42:21 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::2d) by DM5PR07CA0067.outlook.office365.com
 (2603:10b6:4:ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 17:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:42:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:42:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 10:42:02 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 10:41:57 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <frowand.list@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V7 2/4] PCI: of: Add of_pci_preserve_config() for per-host bridge support
Date: Wed, 8 May 2024 23:11:36 +0530
Message-ID: <20240508174138.3630283-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508174138.3630283-1-vidyas@nvidia.com>
References: <20240508174138.3630283-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH8PR12MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f46134-1f9d-4ce1-aa6e-08dc6f86350e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|36860700004|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+cTjFgFuvi9x0L/L+B79AhyD1K7VSOGrtrDpLpU3oHc5FAVuZBFYDitjUitH?=
 =?us-ascii?Q?dqjJarq6FmZJ666/EdPTq/sgJ4Rl+IhzN9Q1BOWfhNWFt0PHFEPgFQzScIki?=
 =?us-ascii?Q?7C20ZJu9W+xydIaamnK6C/GZE15tZgJa5X/iSi9RgxLYLcCgnRmQpmkd5e9G?=
 =?us-ascii?Q?VyDh5foBFnyRyx7fJXH2Ad75R9vGVmEw4jergdO0SHkDr3CdxHpGDKyAPQXU?=
 =?us-ascii?Q?nSKZ1e+FGMueg04mFppB6N/s36SnZb52zDxwyFZvqiCfJ1Uxq1NWI1AagLLu?=
 =?us-ascii?Q?bG6GWR/uYPQ7bG3MEGr/WUkge3EmWQPDHouCiP6Gz9Nm9I3LjPegCZtOAf+o?=
 =?us-ascii?Q?ljqkXNnzUlOpH/Y6IDTBE1y6T98S39a9//g3pIP63R23NaxgcsDxQVak/BNq?=
 =?us-ascii?Q?iMiTxFYwLRcH8CVAmlYGM8/TRzkTNagkROla3ipxO88+UHy8IBT107nwJv+A?=
 =?us-ascii?Q?xxuN13XNUrYnTJHx/5WoUiTLxvdpBvIBJl8ROqvpdtbB+JKIN+F2M2Q3rAHa?=
 =?us-ascii?Q?Am4DUToEPYJjhgsOeiwmbmK6rOGffEcU6zgou2nbVj1glLzCmU10BtWLYJQa?=
 =?us-ascii?Q?kHPZc4hyMlcrLEvdrF3K1Y623wowruKjLjjdFWT2iPD93Rm6eB4VdqQx+kvZ?=
 =?us-ascii?Q?9ZkdzfviezS3aqON+jb2Xqgnb3vPVSmOUXwCoaaPPMhfaVxr8aGxhGFGHPpk?=
 =?us-ascii?Q?vmNtfRNXWXABKcz2Bacpdg1FWcuYrB2ew26jwYy2Ii3a+Lhq56ApOwUDMzLl?=
 =?us-ascii?Q?w3jtxIroYCaU/RZ83kGYdXPQh9RRrvXyILJ0Cl1vnr/hCDSfl37VU8Yiks+f?=
 =?us-ascii?Q?dzpnpw72MtfiPux7Hm9olEA6UhDs5plyiFfLxkdoJca620STfzSWSUVRqXUK?=
 =?us-ascii?Q?e5b2MavEHqcSnpUnUyfjFY5gX1lzggHRHzsawJuBxsqDakzEtQWwPYJ9XaCk?=
 =?us-ascii?Q?qX5EQz722aHBMpeeCpifETfCizCt+X5AAbk2lB1h0pg6ckern0vsY9lQnVI/?=
 =?us-ascii?Q?aiFu+Lbb0S6Yu19Mw9vReT4W7F4nUNdK+ee4rUD+nv278Iv6fsMOohwhtP7M?=
 =?us-ascii?Q?LnBceqX+HSTN+e8zFk6ZWzwY+BbCsfc9ZqqPM/Rfbzm2deJhJMYIeX5VSTtm?=
 =?us-ascii?Q?CGwiwsChREuoDVkScqRrjGIQODU02C8gLXPHtHgUkDxauvvCk9PbfxZXG7J2?=
 =?us-ascii?Q?kYaHazPQzgqYJWoEmpvhuXcPwzxIn8sJHkyfMfRLKBJz7aooHNfMT+rntecw?=
 =?us-ascii?Q?haTMLWHUHFpG3ceo1jarmlbnjhUiFNzg42XvpPXFuzU2As15+9eUEBkTrbvm?=
 =?us-ascii?Q?OkQgl9z8nIxkGmujhqaiXFFkBVIGCfe7nodQ4mP9EyU8DpQTFcgjuVekwge8?=
 =?us-ascii?Q?glpQQ+hBQOf31U1ghhopbL60zSS2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:42:18.4659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f46134-1f9d-4ce1-aa6e-08dc6f86350e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6866

Add of_pci_preserve_config() to look for the "linux,pci-probe-only"
property under a specified node.  If it's not found there, look under
"of_chosen" in addition.

If the caller didn't specify a node, look under "of_chosen".

With a future patch, this will support "linux,pci-probe-only" on a per host
bridge basis based on the presence of the property in the respective PCI
host bridge DT node.

Implement of_pci_check_probe_only() using of_pci_preserve_config().

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/of.c  | 54 ++++++++++++++++++++++++++++++++++++++---------
 drivers/pci/pci.h |  7 ++++++
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..d21c0bed36f3 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -234,27 +234,61 @@ int of_get_pci_domain_nr(struct device_node *node)
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
 /**
- * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
- *                           is present and valid
+ * of_pci_preserve_config - Return true if the boot configuration needs to
+ *                          be preserved
+ * @node: Device tree node.
+ *
+ * This function looks for "linux,pci-probe-only" property for a given
+ * PCI controller's node and returns true if found. It will also look in the
+ * chosen node if the property is not found in the given controller's node.
+ * Having this property ensures that the kernel doesn't reconfigure the
+ * BARs and bridge windows that are already done by the platform firmware.
+ *
+ * Return: true if the property exists false otherwise.
  */
-void of_pci_check_probe_only(void)
+bool of_pci_preserve_config(struct device_node *node)
 {
-	u32 val;
+	u32 val = 0;
 	int ret;
 
-	ret = of_property_read_u32(of_chosen, "linux,pci-probe-only", &val);
+	if (!node) {
+		pr_warn("device node is NULL, trying with of_chosen\n");
+		node = of_chosen;
+	}
+
+retry:
+	ret = of_property_read_u32(node, "linux,pci-probe-only", &val);
 	if (ret) {
-		if (ret == -ENODATA || ret == -EOVERFLOW)
-			pr_warn("linux,pci-probe-only without valid value, ignoring\n");
-		return;
+		if (ret == -ENODATA || ret == -EOVERFLOW) {
+			pr_warn("Incorrect value for linux,pci-probe-only in %pOF, ignoring\n",
+				node);
+			return false;
+		}
+		if (ret == -EINVAL) {
+			if (node == of_chosen)
+				return false;
+
+			node = of_chosen;
+			goto retry;
+		}
 	}
 
 	if (val)
+		return true;
+	else
+		return false;
+}
+
+/**
+ * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
+ *                           is present and valid
+ */
+void of_pci_check_probe_only(void)
+{
+	if (of_pci_preserve_config(of_chosen))
 		pci_add_flags(PCI_PROBE_ONLY);
 	else
 		pci_clear_flags(PCI_PROBE_ONLY);
-
-	pr_info("PROBE_ONLY %s\n", val ? "enabled" : "disabled");
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 180d3907b543..feedbedd65df 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -650,6 +650,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
 u32 of_pci_get_slot_power_limit(struct device_node *node,
 				u8 *slot_power_limit_value,
 				u8 *slot_power_limit_scale);
+bool of_pci_preserve_config(struct device_node *node);
 int pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
@@ -688,6 +689,12 @@ of_pci_get_slot_power_limit(struct device_node *node,
 	return 0;
 }
 
+static inline bool
+of_pci_preserve_config(struct device_node *node)
+{
+	return false;
+}
+
 static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
-- 
2.25.1



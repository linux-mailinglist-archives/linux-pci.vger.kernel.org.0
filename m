Return-Path: <linux-pci+bounces-39616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 619BBC18F0E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDD11C86730
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F9731A571;
	Wed, 29 Oct 2025 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pm2stAdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazhn15012044.outbound.protection.outlook.com [52.102.140.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6D31A562;
	Wed, 29 Oct 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.140.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725172; cv=fail; b=gCIAp0S5yxc9jnLy1zxgfkoZnlSJbFEGg0ceUBZQJ35NWnEnJ4HmBMc+dduPL6k9335XiW10ADn2aZwHOZmWJBkj81cpq+7xNOhPCBLIugsFC2LZ9RCeCLI1lZMYd2IChO0ysnZGThRBQgnCVK1ZqjP+YL+bXgFz6i/S9fvPXmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725172; c=relaxed/simple;
	bh=xmM/Zg5w8puH7zPYWXZs5NEnytFWJAkU5Fuup9SOmSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk2DVmqKNldd2y8Ql+9xnZ/PujZ7b59gIIQ47OSFX570PmtKXaF9jOmGM/6OjkCTjsyT5gfws1LSvirrwbnJuOcoL6Bkua5qhqNCRJ2C5rXW1nDYEjDojYneZFJN0+G1owzl3s2tEsj4sJWOYqF5CaN0eXVjSJ5yx0SGF/P0OhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pm2stAdR; arc=fail smtp.client-ip=52.102.140.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+3cLxhwSL5Lun2JLQN7srQ1r+4nbBt720cGbdJs/E4PcJdmcra0dKLhZRNLNVjIt6MPss4cqZS/CmPEz6OpN4SzOid0ZcNeW26H0z/fGvMyxNUaJXa0vZbTBOJmA767o+9nzNkp/pNk16dJwvV9vajXaO6qwo+kn2uqki1NQQhORKI+Fu+xMfrN16soeMFR4PoZVVoCb9RLqc82hzWJqhDsbnWN09AqYaAEazxhyDkVvJhYSYqJIZ9VR+vCa/uU+WkB9DEz86uyjFFUqG++URMrVsBGkoLZ1CVYlukGEG8ECVFhdfHn6+D4B3lFgvDeHzTRfBIDaOjy+H8yL6hDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FySFmbwoC4NvRz8AKlKQCcwcSNZbL+Kmkb0n90DF7Ds=;
 b=ixvJE8nSAihpXvP5rUJ5/FGG09Fx8BTHX021pLgU0exo3iz+SNsfCBF6DSJXl9p9vOmhh0v8KNH4FayZDlA1Gnx0I5G1bh1v0IfMJGVlyv2WJFdJbCEP6NArbXLXlkzzvBIrIGT2XaOoN5/zSphHrDyuRCQvzRFiBNW0kGp6zkpA//WBGCLyKBJ8AJjldn4kzMH+suT9xBUruN1evpfR5Vo96KzdHzxqLxzN40xlXnOOh4RBgdYdztRT9PYax44ctrJxWd2ryUdtLBwUV/bBoTRdeaMVHaie2diAX/Q/g6PzDPfeZx8YFHDhvbN7jQmDlIBhb/1YYq5ktW573bRTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FySFmbwoC4NvRz8AKlKQCcwcSNZbL+Kmkb0n90DF7Ds=;
 b=pm2stAdRMzdnt7fAiqRnQvmkzucxDR2njaUFnhpkq2y2Ds1bc9tXMPQMxaL4/UTBJRosM0za5sA7GActXpnrbKXykuZ/T+uCk5Z9VmSws/CPJJGeIQWMxvjM0bMBVP4BZnOphdYdgaPL2z026yvMhf/xHzeeN/dNx9uqCGNht04=
Received: from SJ0PR13CA0088.namprd13.prod.outlook.com (2603:10b6:a03:2c4::33)
 by PH0PR10MB4710.namprd10.prod.outlook.com (2603:10b6:510:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Wed, 29 Oct
 2025 08:06:04 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::17) by SJ0PR13CA0088.outlook.office365.com
 (2603:10b6:a03:2c4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 08:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:06:02 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:05:55 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:05:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:05:54 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T85aXg3704660;
	Wed, 29 Oct 2025 03:05:49 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<christian.bruel@foss.st.com>, <krishna.chundru@oss.qualcomm.com>,
	<qiang.yu@oss.qualcomm.com>, <shradha.t@samsung.com>,
	<thippeswamy.havalige@amd.com>, <inochiama@gmail.com>, <fan.ni@samsung.com>,
	<cassel@kernel.org>, <kishon@kernel.org>, <18255117159@163.com>,
	<rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
Date: Wed, 29 Oct 2025 13:34:50 +0530
Message-ID: <20251029080547.1253757-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029080547.1253757-1-s-vadapalli@ti.com>
References: <20251029080547.1253757-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH0PR10MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afb029d-036f-41fa-22b0-08de16c200e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|34020700016|1800799024|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rulv/Pv6/1aRHYO7Bu4Yl6D8IxgZW+39VXRSWyzImPM0mLV98qkjuSKSQ4l6?=
 =?us-ascii?Q?TF1LFfx1KXZeoVA4UMCUomPEmniqqiwnnFcKz8CQNsQbzo3ccMJuKrH0CjnW?=
 =?us-ascii?Q?wgprdFRE0VAVSJ22z8JlSJ/dIo5pVQc6lEQVHd00CnpU+uVli1JNtqL9KWJi?=
 =?us-ascii?Q?X55+olTk92MVDbVAaxM4sdSbiCG9tjJt3eAvCued8hgy/gAcGVhK21xEz4dv?=
 =?us-ascii?Q?b7rt5x0hjEk/t5sfanNpeHbORzxeWkEHPnIy5HSkjF23OGgvYcu48hfjvRCf?=
 =?us-ascii?Q?yAOtT2VM+QGw1zD3JJLW3RuQJl1sc39IqlXiB1l9AJFxg2lFyXGAzNU9jfWg?=
 =?us-ascii?Q?v52OldiCFvxCmxgbX031upwBr7QmfNzsMkIHVDGAVAbssh9ryQtROlnkPCKp?=
 =?us-ascii?Q?OcqMnfwYxOOmLmw9K3ZqS6Ij9N9hhIlajUyIhXVyzsw3iKqli7aRl0GpdKJi?=
 =?us-ascii?Q?UyCcrLr9o2pYHhalcKwTKC40tkWUL1WbIOy+38kB6FuC6vxPo8iCb1U6kee9?=
 =?us-ascii?Q?qYgAKopN78k3CYkjM4d0kuh/WRuOrli5Bdiai6hM06mP74HcUamIAlG232wO?=
 =?us-ascii?Q?4xRBS93PcJT1VWZ/xFxlo4bGOj5UIGFSqL7DQA/c7lZ9YmDwcDf/9owYDgRW?=
 =?us-ascii?Q?rtjJVWBQBReDqXvZmaXzEHdElPnzwZL0HvisfqCB4ZP+7Fu+56hUEHtPGUP8?=
 =?us-ascii?Q?pSKXtFI284R4qHiP1FbJzcYYli9fUGQBVyu3r6ZGNk2Tka7w8u5P6Yf0O3AN?=
 =?us-ascii?Q?6bp+XECd6dl/uNyGAruxLXBBMP9NGxhbluAANn01f+Cy5Eynq0lVMFXEJ2SS?=
 =?us-ascii?Q?/pwaxVDM1mFObzMjZUy1L1hnhXtShEGjhiINi/zuTqsuEj5vgdRaNe64BptK?=
 =?us-ascii?Q?fVsW7/Ze8YbS+hzolgEmVkA5pqfu7ymtHrt5mf/FESy0emZIv/Muaz+Ao/HW?=
 =?us-ascii?Q?EkDpRC0ZeKTnPJHtkai56f1wSoOZYpAIpYcnwr2Es9PmHopnFlc8N+qm+BkC?=
 =?us-ascii?Q?fySN3EfTguroeZq0F1I6ZuTcUKnp4uh/+2BOdcFD95o0hDpj2H5GEM2brmCq?=
 =?us-ascii?Q?ggUR6BWTBKt2M/TcEwYrMMckFZ5I0F1P0PD3rNJQ+C9UNDBfcKhnMbS7q5Co?=
 =?us-ascii?Q?EBBbenBVuA3br/QYETr/m68xh6bwVr4j4r3+KSIN57MCDK8sg50QEaXNuOdo?=
 =?us-ascii?Q?naZH4bxR+621VZ985Jqw5Uq/sNJoMVeWdzsFe3enW6Qdi7UNThiTOZAVDBZn?=
 =?us-ascii?Q?qdZwCnl7n97pntrDxJuNp86Ai/pEYun+ftpslEVWWWJrEkE/7/ggWimnA8Mm?=
 =?us-ascii?Q?XEygMwep97pqxT+2sQg8Sww5KkVOJW0w1rr1cK2E7DCG0pUjk41jhmZVh37U?=
 =?us-ascii?Q?WJ5ss1lUpb7bTgd0358H8nGvwgsep084UAjErMYgHI542tceInVvskptYDmN?=
 =?us-ascii?Q?i2FIf+cALc5SZ4ijStijtwseKUeDPSSkjumJBP//819RAieGUADE2rNkIXip?=
 =?us-ascii?Q?W+VV3s5daOd/BhRnc2gWjp66sQ8pxNQSfCE8?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(34020700016)(1800799024)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:02.6518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afb029d-036f-41fa-22b0-08de16c200e3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4710

The pci-keystone.c driver uses the functions 'dw_pcie_allocate_domains()'
and 'dw_pcie_ep_raise_msix_irq()'. In preparation for enabling the
pci-keystone.c driver to be built as a loadable module, export them.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v4:
https://lore.kernel.org/r/20251022095724.997218-3-s-vadapalli@ti.com/
No Changes since v4.

Regards,
Siddharth.

 drivers/pci/controller/dwc/pcie-designware-ep.c   | 1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7f2112c2fb21..19571ac2b961 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -797,6 +797,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msix_irq);
 
 /**
  * dw_pcie_ep_cleanup - Cleanup DWC EP resources after fundamental reset
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda5..39fda91db27b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -233,6 +233,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
 
 void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 {
-- 
2.51.0



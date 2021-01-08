Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D512EEFA2
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbhAHJ2v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:28:51 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:2579
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbhAHJ2u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:28:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z03ka9aMnt6MEuilGsYGVSarxT/AwB+tIS1hlCLMkIGPrNpFyWL1Y+juawmBvC1ywAzOdqHRRVK0yFLdusKKzIg8k3K2hz6espHV/YBi6O1VBcBEfdQarV1SchRTYmmTZiaT3yxz2hGXhk+zJmQZ0dmDcHkyWW0bckTjwKK8T2phtfdN4Dp0EZuNKOm+HUY2zkSUtW9N8qeZN/wnPdBuwWAHYjAUHncRBOizSWxXHVRHvC3Jjvr4KAcxyCinuRVUwDXm002f3FsbZxh1j7I2x2QF+pHtvNqvY45TBPstMP5mQjGmin6h43Qb5b0EyiL70dBquMSRyfrpFylmknUy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkZKiJX8rSbc9Gl4Ms4Dko37q+XscFwYScgcYSaLS8Q=;
 b=ms82M7gyQqARA7yDRJISKmCRr5/7qN7/LVLv5NE4KUq37kTkANAgTcCN5HQVroVnoSHF2UBm3a9VPmSlu35MDTtuFO+XfhAGh6EXDZKuo3sLHZLBWhTCLaQf2WzydG6bxjuoStzDlc+znCxhW+3vjOdJfdgwgI0UJWjvaJ2qFTlyE2CXXoynaMOXQNRC3kO39pFhj/t4bbGimHrV2fWUmrPTeIy9nrFoS/icePysCfCF85uKYYVIb8aP2hmoDJBZQ++xsIpBIZsLGd6oBJaG/J5+XRhnU4ums1Cqs05GnS5B7gNYCkzBAXP0YZ72P9Ro9uWTBRalF+o0BLGxjjkcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkZKiJX8rSbc9Gl4Ms4Dko37q+XscFwYScgcYSaLS8Q=;
 b=JV+BkBuVLcor1KbJW1tQsIYW27Ip6LbB5BJl23YXHa1iBdezTxdlA/I3jposSlfO3IyBw9gUBWeBmw9yHdbPaxj0AN4vDVib0cFgSsYjAf7eRGUWLbxCEMMgKHzHGpjAOBveE4sSJ5criXInqJh9B6gLEmTO2LRT5CPjT/Fc07k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 09:27:27 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 09:27:27 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Date:   Fri,  8 Jan 2021 17:36:04 +0800
Message-Id: <20210108093610.28595-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
References: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 09:27:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2759dbaa-bcd9-4c04-fc7e-08d8b3b79da8
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2652BB6EB0767EDB0024BFB484AE0@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuIvL+k+N0J1OcRiRGo8mnz23E8UCo9J680XwroS7KgU7zsyNhIrt54laZvqz04HzVUzSsoJVPnDpukO8nU/gmfB2JNCne9YyTES9SmbMILPf2H+kzHgHTqJZSZmIA2jcdbHUeEMKhVeuuREpT5Y6bibMpsmsln27R4fna2sMq/Pzr77K0VbvWd5/9bDS23q/0IomxR/+H/U7Z06z3p6eQN6bvmRr36QQjkqTzL6pJdUpnTFwvVPfZmLFKuQZJ1yezd2xOhdf9+PE5sYLl6YkfERcpmM7DBMhfg15Z0xyc0Zpjav+LoROV3acnkG2pGmuwzm0yxBH/32hEHSDkjYGjer8s/qMBMj0Nrwqlw+t/20iMg6GVexnxCZnUYFmnnIUY75fg58fIS1xxgaKbdVZUmUYPQF6W7xmhrz04VD3cwfVzCrPVPpjuR2Vcf++8AOsplz9WpFL/bP7Ffifu6AcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(316002)(478600001)(6506007)(6486002)(4326008)(52116002)(2616005)(36756003)(69590400011)(8936002)(66556008)(956004)(921005)(6512007)(1076003)(66476007)(5660300002)(66946007)(26005)(2906002)(6666004)(16526019)(8676002)(83380400001)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8YWEf6WYidm2wFCmuYhYEBvK8kLKltQqUUI9qiNY0a6ebsNV8TpRp8nt8GIN?=
 =?us-ascii?Q?vBFE0UZDlxUrKu3z4zKf3mdAiHJ9oa7jR2eQNik70Dq5PapGNRMwkC1Fz7KM?=
 =?us-ascii?Q?is+CGtT1ViGO+HELal92Zt5CLP6iOFjh0JZobFLwzni3aTIe2xyOodIHKQjk?=
 =?us-ascii?Q?ZcCzH69/A8TMSj0eyBuhPkMHKruebsm5VEPUGn5HhnMS1HctkXGVvMIH4qWh?=
 =?us-ascii?Q?jdlX8fRZEgKsdEXNV8S4ddfgVEte+6J6Mvr6lt8cyI4/n+qYh7DCAt6Vbhx3?=
 =?us-ascii?Q?+n73xPGHM+0+pO49d2Jtv0HnQn+Ltn2L5fyZnkIgsRqH+3x+r8E0331m9Het?=
 =?us-ascii?Q?sQZzNHLhl+7TMpdC/v/9DR5F08OS17oQGDdJqtAi5qJ8lkuEPHuuq9gvnscF?=
 =?us-ascii?Q?CVdWCZlYHZCS7kCjkKEaFkJZHFJCd37JVPxeKsmQVYFi2BiBX8eO8nKW6ALe?=
 =?us-ascii?Q?wMCeJM99geIX7C8XsKFB21eXRDzG+8EcwtMkPY1tF0cnUf4svoUb/ot5sAKe?=
 =?us-ascii?Q?hkacRMo2kh2OFOoe7u37ntqUofamAlVHqw/aOE1z1IfEELcVbhZIU6aAS4fv?=
 =?us-ascii?Q?X+OY0zPYeu4ImaZgEuC1DeKYshgThRiUwOuvQ6ArXuhc/rHtYJMu34H3pT/m?=
 =?us-ascii?Q?35edBitTDGi16TDoHNN8UWKCKxiFzNodfXof5rh2gUbLu8dbMnqjG28fJ5Mf?=
 =?us-ascii?Q?3wMaK2adIYd0srPy53/Iif8qVe0nzvjO2Fi73HglobQGcEs0OmWJXKoiFzHl?=
 =?us-ascii?Q?dto8/ULiGZNqNLjz76D13yaUBUojBy7SoXjLJySIr6AG6++3kE2aoM4rgIdv?=
 =?us-ascii?Q?kxvX9Qa3KtzncSgca7zvbl+e1PsYF1nIf1pUmytDXdFwrwiOjM6p6dz1OrTR?=
 =?us-ascii?Q?EvDr25TwNhla9MTMryLx9Eh8NP+ZkbJdD2GdfL9UqTERsxU9Ubp+wptvBGaa?=
 =?us-ascii?Q?dWi87k+/qED8tG668YSyX4ZQqT8mUlI1jADNlCqShhk/IW40mTa2/I1JJvNe?=
 =?us-ascii?Q?tyAV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 09:27:27.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 2759dbaa-bcd9-4c04-fc7e-08d8b3b79da8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDhdsTlTnMU94R149aK6VvrKibZdYRhdRtt/UB1sFwvBp9itiOqhwFdoWUy4ix1DuOVK/AzDY9dFJB4aq0lJzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The dw_pci->ops may be a NULL, and fix it by adding one more check.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
V3:
 - Rebased against the latest code base

 drivers/pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 516b151e0ef3..0413284fdd93 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -429,7 +429,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 	dw_pcie_msi_init(pp);
 
-	if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
+	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
 		if (ret)
 			goto err_free_msi;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 645fa1892375..cf895c12f71f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -141,7 +141,7 @@ u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
 
 	ret = dw_pcie_read(pci->dbi_base + reg, size, &val);
@@ -156,7 +156,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
 		return;
 	}
@@ -171,7 +171,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi2) {
+	if (pci->ops && pci->ops->write_dbi2) {
 		pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
 		return;
 	}
@@ -186,7 +186,7 @@ static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
 
 	ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
@@ -200,7 +200,7 @@ static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
 		return;
 	}
@@ -273,7 +273,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 {
 	u32 retries, val;
 
-	if (pci->ops->cpu_addr_fixup)
+	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
@@ -481,7 +481,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->ops->link_up)
+	if (pci->ops && pci->ops->link_up)
 		return pci->ops->link_up(pci);
 
 	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
-- 
2.17.1


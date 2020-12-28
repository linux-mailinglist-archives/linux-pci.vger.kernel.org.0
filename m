Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA382E41DB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 16:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441084AbgL1PNp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Dec 2020 10:13:45 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:12532 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438238AbgL1OGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Dec 2020 09:06:52 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSDw5YA005243;
        Mon, 28 Dec 2020 06:05:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=z1GryEBqElrFTcJ32x+asL3miwc0Qe7PF6X9kDiz/KE=;
 b=SJGi0MZnbRPcZU0JO4oXLr1PALmaZNfh651IekYZIF1+mvVKapsKhRHy1F/8IjRZtYJd
 zFAwzJNbRJYTs4PVyJ7z7eoLsDb+8LJ/YZN4jmPRnVkBQzDulAaf7byA2KChDm/HrvRP
 5S+4AyJVUHbgQqV5aimmq9lfzpTwiIIKC9JE/VPU8GsoOl0urdtFC1suzUni2b+84Zs0
 Yds3mzTdt7vsFbh1IJ9koOVmSkYmvZmGnVtmJHGplDBmJcX3eg7LoegIUyWr/ACUVAyK
 V6Tkwq1cwPumjsYmxyBh4/mqe0Rasxt2zNMXrdD4N6zPVATlw+dtgD+iyb+2OMIzZTTD ig== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35p2m1be5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 06:05:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=addzTBiTw23KBUBh5G6JB9fePQkpjhCIk9Nhq5zy0aX46c3q5/ZSxgfDRuDLlYbMVY7vBcwlxZpB8mnFiqNn0x7xo6DQ9L5ZqRCe8Nf/3nvzi7ozoS1EzotEMZkc8Ul22gE6+wLM1otNBcf1hlNoXuPGmCeWPg/bq6L1DNooaotyByVRRUzsEwF0CAn+YYnJJvLgi4RIiKGTyJB6tZakMnTAd6BmvP5Kn67JR/coHqa/RT52orX4TF3BUGDcWOZj3ujtFL5R6D7InytlDzHaYu77E4LKm6F40oxvoFlOSshbWbStq96oiFq6aniKqKcnwFyvujXW/VVAbYSFsl+jHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1GryEBqElrFTcJ32x+asL3miwc0Qe7PF6X9kDiz/KE=;
 b=ky9bohYmU9ddQ/K3+uTyKhh2gCtJVphlmQnXYf9Lfy7+XrJnHb/Vj6W2698DkjR6IaJWFaViivxf+YnshkY2xGTk66T5Ps3NWtP2rKuwSZDNeXgBUbchBNFLxBDFFb2W7qvZ47rI2nNi777VvQ/Dylt+l+J+BU9mmgul/hvh59Hl82R8LSoWwzInpj2FJnA/sNaMWVdE4PaTHqhiLbIPtSG9nC/B5iHHoxPzrrtNaxHmzT+bgpnQGL1gzChWCu0eXRgqA04/mevd+p/2ba06hwEm0udjg1VAwdxWsiaTjjEgCdnkCs/WL15TS7iMo2ClLPoymKJIetFj6YWg2Wt7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1GryEBqElrFTcJ32x+asL3miwc0Qe7PF6X9kDiz/KE=;
 b=wxD/IFOvxP3ABPm6wjcoZGNEOkIb8r1Iyfo3IqpZw10xZ6DNziPYroo+Otl/FOc6OlUgwZlOW1t7FcXb3FR80LBrryT6s2DXr42FLHflQ73Tuwg3Ho6zEJX8rxT5nLJ2oqZQ14m+Gh5PAmEypX2ihtHHjlr+nkjoDz807j9WjPk=
Received: from MWHPR04CA0037.namprd04.prod.outlook.com (2603:10b6:300:ee::23)
 by BYAPR07MB4598.namprd07.prod.outlook.com (2603:10b6:a02:f2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.30; Mon, 28 Dec
 2020 14:05:41 +0000
Received: from MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::ef) by MWHPR04CA0037.outlook.office365.com
 (2603:10b6:300:ee::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Mon, 28 Dec 2020 14:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT040.mail.protection.outlook.com (10.13.180.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.20 via Frontend Transport; Mon, 28 Dec 2020 14:05:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0BSE5biS023739
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Dec 2020 06:05:39 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Dec 2020 15:05:37 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Dec 2020 15:05:37 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BSE5aDW014710;
        Mon, 28 Dec 2020 15:05:36 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BSE5adl014709;
        Mon, 28 Dec 2020 15:05:36 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v6 2/2] PCI: cadence: Retrain Link to work around Gen2 training defect.
Date:   Mon, 28 Dec 2020 15:05:10 +0100
Message-ID: <20201228140510.14641-3-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20201228140510.14641-1-nadeem@cadence.com>
References: <20201228140510.14641-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed00e75e-0987-4606-b12a-08d8ab39a88f
X-MS-TrafficTypeDiagnostic: BYAPR07MB4598:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4598B7E6D4CCAE47BC1BFC00D8D90@BYAPR07MB4598.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQ+Y/UyW8HBgEzVMhD81J3vj9vFPjkq+Ps9Vhp4yGrCVSe/PKkEyLJA5LGc6QR5cVWtQcL1QCPIj5w3cfd3cQNvuaRjD0SiAo1omxoCFZ+YNmYwD2uYJ/v2eD2kElsqodYZmZRStaClmn95p+U7HqOSxFsIU00Dcc83I1dXfOfcOWeJal8wzvdZcotNvy0eFGe9B/Pn/jsSqylWItNZdP+vclw8McSvl0q+w6hbVbs0E+UZhV7EdCGm53Fneih5EX9rxtA94vlWel7uLu+dPZGPAJfbWjrpcdnjHw173k4Ff0Xyz+Vx5vLFFyGCnnb8NHTne8ENvZm7Nhv+A0Fg0IxupD6V+sVBzKtxdJwAW9oMcVQJZpVojXKuSdKUhef8FFTRgcfIWOmZZjp10ixjkwHJvSlufDzKjHwPcfG6423/iqoFM54OSvDU213TD7+/gX7pzDigFq5dhNGxvvFWzIjD4zhyWgkMET1G1+SQGoLgmtSPkzl09F/pnrLzO7n+XNzdnRV/KxTXG9CvIBv1MjQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36092001)(46966006)(7636003)(83380400001)(36756003)(6666004)(1076003)(356005)(36906005)(107886003)(186003)(478600001)(4326008)(82310400003)(70586007)(426003)(336012)(2906002)(8936002)(316002)(110136005)(8676002)(47076005)(54906003)(5660300002)(70206006)(86362001)(42186006)(2616005)(26005)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 14:05:40.1850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed00e75e-0987-4606-b12a-08d8ab39a88f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4598
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_11:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012280088
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped
as Gen2. The Retrain Link bit is set as quirk to enable this speed change.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pci-j721e.c         |  3 ++
 drivers/pci/controller/cadence/pcie-cadence-host.c | 32 ++++++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 11 +++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index dac1ac8a7615..23a30be207a5 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -64,6 +64,7 @@ enum j721e_pcie_mode {
 
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
+	bool	quirk_retrain_flag;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -280,6 +281,7 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
 
 static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
+	.quirk_retrain_flag = true,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
@@ -388,6 +390,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		bridge->ops = &cdns_ti_pcie_host_ops;
 		rc = pci_host_bridge_priv(bridge);
+		rc->quirk_retrain_flag = data->quirk_retrain_flag;
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 9f7aa718c8d4..9d730c10083b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -94,6 +94,34 @@ static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static void cdns_pcie_retrain(struct cdns_pcie *pcie)
+{
+	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u16 lnk_stat, lnk_ctl;
+
+	/*
+	 * Set retrain bit if current speed is 2.5 GB/s,
+	 * but the PCIe root port support is > 2.5 GB/s.
+	 */
+
+	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
+					     PCI_EXP_LNKCAP));
+	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
+		return;
+
+	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
+		lnk_ctl = cdns_pcie_rp_readw(pcie,
+					     pcie_cap_off + PCI_EXP_LNKCTL);
+		lnk_ctl |= PCI_EXP_LNKCTL_RL;
+		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
+				    lnk_ctl);
+
+		if (cdns_pcie_host_wait_for_link(pcie))
+			return;
+	}
+}
+
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -459,6 +487,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	ret = cdns_pcie_host_wait_for_link(pcie);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
+	else {
+		if (rc->quirk_retrain_flag)
+			cdns_pcie_retrain(pcie);
+	}
 
 	for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
 		rc->avail_ib_bar[bar] = true;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 30eba6cafe2c..0f29128a5d0a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -119,7 +119,7 @@
  * Root Port Registers (PCI configuration space for the root port function)
  */
 #define CDNS_PCIE_RP_BASE	0x00200000
-
+#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
 
 /*
  * Address Translation Registers
@@ -291,6 +291,7 @@ struct cdns_pcie {
  * @device_id: PCI device ID
  * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
  *                available
+ * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -299,6 +300,7 @@ struct cdns_pcie_rc {
 	u32			vendor_id;
 	u32			device_id;
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
+	bool			quirk_retrain_flag;
 };
 
 /**
@@ -414,6 +416,13 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 	cdns_pcie_write_sz(addr, 0x2, value);
 }
 
+static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	return cdns_pcie_read_sz(addr, 0x2);
+}
+
 /* Endpoint Function register access */
 static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u8 value)
-- 
2.15.0


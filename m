Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006982D7820
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 15:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405930AbgLKOpD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 09:45:03 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44940 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405148AbgLKOok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 09:44:40 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BBEbghu027434;
        Fri, 11 Dec 2020 06:43:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=sizgDNex5AbqWRf90FsmwsYDsSjXNGrRzQBon/StLPo=;
 b=QYURCqk6VRYVvw/dKH87+vC4jzdcf8VDI5gG2/ewE/AiOhnF6RdjyzLjclYDZ+E4fDT1
 pie/352cnydeMKZt7sJvG6t0FSa3uBJFfLnc6hSrTH4GBsZ0YS5CJla+OlMdGEMjYQOJ
 A/z/fVqbeerb0PSKTX2lLIqG5VUr/YbnKwfQY48vdO1wHgISZz3O5066HeKbhhuXwOWx
 lqa/KbSbfg/5NTng/Ej/b0wKYGx5aLsiTW8b0X11kBtibuWUOL29yOb5ZctDzJW40vdX
 wKX0+YyoIAFLs/OEIH+BlZyfZn6drtWD9LTCyh0ATPFWwKR6hthOrW94Gdtm6gYPdKjf lA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3587n35mhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 06:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUtXAUwfWrOM+nVihg1beKMCUVA4AfG6GkqZsVUH4bd+doaavG6KeMndhic6xzLr5/WGIEUT1iOHO9A5lrT/wy7Mg1yVfi7CkfNjnBHg2cYiqEuE3IxV+F7JA4XFOoP6II1QsMVqZojaU/+8aqLWVTZjEgo9dhNG94zLkehKv1TnfgTz8AIQzjNFWgY4hKoJvkq/z89XrjQxjsdRSxqPpI+sXesunACqCdxQp39vsQoSIUDrDtzdNHMRkOh53JG58cmada4p7EFkpeKXzuMHojvd/n4A1qI8vZDUjzV2LeFa0aVgWywLFo2Br5YG3YK+ucAwvn2Qic0kjQav4oyPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sizgDNex5AbqWRf90FsmwsYDsSjXNGrRzQBon/StLPo=;
 b=kVgEkNIn5Mrf17wZGgK3b7dD2ctO9Nm77OtBTM7JdSoShCrtUoWomi4duL62OZLkw0oHJY37A1CUUZbQvHLWeRi9ZuKVWb4dkj+ISJuyQ5+Uti1uzSr76sFfhpkC1bqPpvuXWhZzeKsk3w6bA/zQ4P4JCFDAac/7ddBzNyj8juEJyxIfm/rODLEeEBN2/hFUgSG88nfWsXQ+n/sRv6vbWEe6h5WVe3LSEe1XP4k+8+akKYiTarSDjS2c9j7/ot/iXQ8OChJUYLxXadoPZWFdfXeg+OHMvRzXrasW7zO2I9W61EuGtZKdbr11dXGv6xd0jaVO4Nvie9waXGKR3IVrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sizgDNex5AbqWRf90FsmwsYDsSjXNGrRzQBon/StLPo=;
 b=Vpu/xp9b5ALgZIYh9XY4Pm3ieNEmSfdHc2oaYfOt8SBVa6YTaMBMIIUt/m2Fg7xpGiffRxM9qov70F0jSTp8d4b8HF6ZbpcCts9p6K5hvkWyw7AIB2Zw47yNbER8sSsym52pJ7UmIVP4KkfNo7Er3oYuggC1fcDtxLoRSfAAX7M=
Received: from MWHPR04CA0052.namprd04.prod.outlook.com (2603:10b6:300:6c::14)
 by BN7PR07MB4673.namprd07.prod.outlook.com (2603:10b6:406:fa::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 14:42:53 +0000
Received: from MW2NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::c) by MWHPR04CA0052.outlook.office365.com
 (2603:10b6:300:6c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 11 Dec 2020 14:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT013.mail.protection.outlook.com (10.13.180.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.10 via Frontend Transport; Fri, 11 Dec 2020 14:42:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0BBEgnkR014660
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 11 Dec 2020 09:42:51 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Dec 2020 15:42:49 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Dec 2020 15:42:49 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BBEgnTP003924;
        Fri, 11 Dec 2020 15:42:49 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BBEgnor003923;
        Fri, 11 Dec 2020 15:42:49 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <devicetree@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v4 2/2] PCI: cadence: Retrain Link to work around Gen2 training defect.
Date:   Fri, 11 Dec 2020 15:42:36 +0100
Message-ID: <20201211144236.3825-3-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20201211144236.3825-1-nadeem@cadence.com>
References: <20201211144236.3825-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74c05c64-df95-40f7-f251-08d89de30a1b
X-MS-TrafficTypeDiagnostic: BN7PR07MB4673:
X-Microsoft-Antispam-PRVS: <BN7PR07MB467360CF8DDB6136485120A1D8CA0@BN7PR07MB4673.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhSHF/k8ikyUWnieyhneLNatGoNFkBhxomj8gz3/U5SZ+WQztdICuxZqIkKAS1YGVsvm3rq2VBssXeZfzHgEJzfy1oNLnkepwQAWXvVag8PID84PI7jbMDypmE61liFni20s5Tn2S0taYuHekQQg3zE6APt5PJBOoqZal5PqlgSbVqNOlRlgKQVBsjdtruANAhprSAU9Gv7JIdXLs0RCU7q7DLNeNf3Fon2NzOt120stsppFoDvS4VyHlkm4eqD/KdiBA762mwkT29oRge+8D7rWH9RF8WoousSSPof94HpHPa2Cr2mAcMsG1T8QrYnNX/P4DomLo7haqh/5Wks2jzMh1qoL9yKSUA8XJtBdUZtwvMDLoJvS1E9E9aZxD2l5UNZwPjMyQA1pk5hmtBtDuO99KLrxHsKrzrDQVqlKCw8iOVpcqWb3YtvZRnprOBq5XnD/EPnQIqXoxrt3bPNc9g==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(36092001)(46966005)(336012)(26005)(508600001)(54906003)(5660300002)(36756003)(8936002)(426003)(70586007)(8676002)(47076004)(4326008)(86362001)(70206006)(83380400001)(2906002)(34020700004)(82310400003)(1076003)(2616005)(186003)(107886003)(42186006)(6666004)(110136005)(356005)(81166007)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 14:42:52.4206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c05c64-df95-40f7-f251-08d89de30a1b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT013.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4673
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_03:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012110096
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped as
Gen2. The Retrain Link bit is set as quirk to enable this speed change.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 67 ++++++++++++++++------
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 13 +++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 11 +++-
 3 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 811c1cb2e8de..36dccf7241fe 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -77,6 +77,53 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
+static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_link_up(pcie)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void cdns_pcie_retrain(struct cdns_pcie *pcie)
+{
+	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u16 lnk_stat, lnk_ctl;
+
+	if (cdns_pcie_host_wait_for_link(pcie))
+		return;
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
 
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
@@ -115,6 +162,9 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
 	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
+	if (rc->quirk_retrain_flag)
+		cdns_pcie_retrain(pcie);
+
 	return 0;
 }
 
@@ -398,23 +448,6 @@ static int cdns_pcie_host_init(struct device *dev,
 	return cdns_pcie_host_init_address_translation(rc);
 }
 
-static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	int retries;
-
-	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (cdns_pcie_link_up(pcie)) {
-			dev_info(dev, "Link up\n");
-			return 0;
-		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
-	}
-
-	return -ETIMEDOUT;
-}
-
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 5fee0f89ab59..97b4b4f98fa4 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -28,6 +28,7 @@ struct cdns_plat_pcie {
 
 struct cdns_plat_pcie_of_data {
 	bool is_rc;
+	bool quirk_retrain_flag;
 };
 
 static const struct of_device_id cdns_plat_pcie_of_match[];
@@ -78,6 +79,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
+		rc->quirk_retrain_flag = data->quirk_retrain_flag;
 		cdns_plat_pcie->pcie = &rc->pcie;
 		cdns_plat_pcie->is_rc = is_rc;
 
@@ -156,6 +158,13 @@ static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
 
 static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data = {
 	.is_rc = true,
+	.quirk_retrain_flag = false,
+};
+
+static const struct cdns_plat_pcie_of_data
+		    cdns_plat_pcie_host_quirk_retrain_of_data = {
+	.is_rc = true,
+	.quirk_retrain_flag = true,
 };
 
 static const struct cdns_plat_pcie_of_data cdns_plat_pcie_ep_of_data = {
@@ -167,6 +176,10 @@ static const struct of_device_id cdns_plat_pcie_of_match[] = {
 		.compatible = "cdns,cdns-pcie-host",
 		.data = &cdns_plat_pcie_host_of_data,
 	},
+	{
+		.compatible = "cdns,cdns-pcie-host-quirk-retrain",
+		.data = &cdns_plat_pcie_host_quirk_retrain_of_data,
+	},
 	{
 		.compatible = "cdns,cdns-pcie-ep",
 		.data = &cdns_plat_pcie_ep_of_data,
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC39727F13A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgI3SVj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 14:21:39 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:11578 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI3SVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 14:21:39 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UIIQZN006792;
        Wed, 30 Sep 2020 11:21:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=vd2q2xluFh9affuMd+pKD+WLjzShLnM4RGdvxATJaIY=;
 b=RmqGRy6p+NpP3VsA3NghP1HVdMiWt3wOl05hh41sHTQWfJ5ploXm+p2ACpU2dS+fG0bV
 nNIVqkF6RftwYp68QZ6ybHp5+0LOgYHahHnyTm33rL+SWlCYEUg/lozbcg73Yi2gKgxX
 5suuVdXOQbwIwK5kxPO6PfFukbIFu+8+ej4cvtaVBPkRI08cLV7l2yreYBXqyVU/GkGb
 BtCnJYF/ggpGniAwbV4c1MzZap0n7CmVNv6A9KBOblXU+9TYZxnb6K7f8hgNWQ3/mwtD
 aaheiq7eRmXBpFeGqHmdsj1NTRka6+xFZBRu6mEZvF7sADg6PuHzR5TTPr+fveJFyYC4 cQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33t26xqeuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 11:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyDa62CHBp6T6F8D9Uuov0qGD/lKrpIvcUqCNucoKRCKSlPXzBm1gBEXiSQts598Zqxrq4NQyAGk0B/qh+knhFdCZcZMfIC+4Spajf5N2mlPO2ih5+h+6QoC8GgyuCBHtwYAEiP4iNe6EG5qofgjKHrGEl3y95G2tQBfxFPn9q33ZHsQ6BwKgsYX6C+Jwtabsa/ec9dxr7dw5CG41P3CefEmQKeQcajw7G4of5jdg4X0PMnpDJenVWTikdhn3NC7h2DKVz9Xc6QQ0C9LBfYEZzmrsAcDwfBmkgshxgDEl0gFJvZ9Kx7s18idDBGdJU23AsY7sRiRT1rVJK6nNICerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd2q2xluFh9affuMd+pKD+WLjzShLnM4RGdvxATJaIY=;
 b=XKa2VEYYw44SS9dUfZnTFqtbi2YVA3gIKR0OJNOyeRZWo+6nJScJSrYp453dLpO1fZ5/IW94eia5yD9VMPcbLblairAREm2J0KqxUcjhKRTluwJlt0U51EMRhaHXxIYdOh5w4kQlRzkrttpM9EkmKRm1SCzCjGyoOmCtjHryyvn5cJzGU3BzZ101+azPfmaVeiR3y6SLtl6owYsZJQ+JgLxuPYDTYhPkrFDIMni2OTRF2ao5aLy6YDoAapsGuXmb/SjPQYZwaM6SqG1CStvfQrufJQpnBWjTVOsoguIXlGFP6qRMjjYCBGiEOe7r1FlG8nc+l78k3haoc8KsEimh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd2q2xluFh9affuMd+pKD+WLjzShLnM4RGdvxATJaIY=;
 b=kU1CUa1a4wFF5qK+cg8xVRyPDaJE6vhkM49cbqSSSqmxt4pDvtIaxc2vR31pw1ZrVEgj6o/npEc397Uo5evMK6Ij+VjJ5TCAClXQSI4XVTRytdER660c70jzR3CEmKDAaosRSq+bmOpW6afIaIdNU8cLVRM7BFz1Y6e44nfHsO0=
Received: from DM6PR12CA0021.namprd12.prod.outlook.com (2603:10b6:5:1c0::34)
 by MWHPR07MB3581.namprd07.prod.outlook.com (2603:10b6:301:67::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Wed, 30 Sep
 2020 18:21:14 +0000
Received: from DM6NAM12FT052.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::65) by DM6PR12CA0021.outlook.office365.com
 (2603:10b6:5:1c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Wed, 30 Sep 2020 18:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT052.mail.protection.outlook.com (10.13.178.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Wed, 30 Sep 2020 18:21:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08UIL90c032088
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Sep 2020 14:21:10 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Sep 2020 20:21:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Sep 2020 20:21:08 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08UIL8q4009881;
        Wed, 30 Sep 2020 20:21:08 +0200
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08UIL7NJ009880;
        Wed, 30 Sep 2020 20:21:07 +0200
From:   Nadeem Athani <nadeem@cadence.com>
To:     <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <tjoseph@cadence.com>
CC:     <nadeem@cadence.com>, <sjakhade@cadence.com>, <mparab@cadence.com>
Subject: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2 training defect.
Date:   Wed, 30 Sep 2020 20:21:05 +0200
Message-ID: <20200930182105.9752-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c017722-0edf-4d57-483c-08d8656d9cab
X-MS-TrafficTypeDiagnostic: MWHPR07MB3581:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3581962035776CD71ABF215DD8330@MWHPR07MB3581.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBGPfcWRlqPltegnFweTLSWmv5eQl+F662dH7taIEiaD4vS19v8TFrM5/eMtSHlZXcQKYsfMbJw+/oqsdD1PHeoKg33NHDsdCWRH+JloiEbdQ470C+js/Cl2pm5mxVLShFPlDCEj6aKsR5W3R92k0utMqefNjgn4KA+f3yu7Xg0x0D5WVXwvMjECGDH9uQTp2Z7xdfs6PnOmJJ9NLbfsgTPf9af264hmo5deTWXjtIKs+2REAYMTejlNwMdCTNB5bFG1pByRN0JbBboEU/KFE6UgyItCFaCtauiSQEo4KPxjqjbQh8TpSy8hGYK/WPQU2Z6g7/JA+Wh9Gb2t7yhzwUnMgp1a2lI3wpW+vxGkODrK1ZK2cUVdwL+5IoC1Z2VjoYg0853k5Ihfj4fAXj3VEO80eSPeYZ6K6wEqkcRZw815HKP8HTSQ8NVUXSOgGd7tAMKrVLG13b1DjGHLaLrdHC5rideq16yoO9eE4IRsAts=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36092001)(46966005)(8936002)(2906002)(6636002)(336012)(107886003)(47076004)(82740400003)(81166007)(356005)(478600001)(1076003)(186003)(26005)(2616005)(83380400001)(426003)(82310400003)(36756003)(5660300002)(86362001)(4326008)(316002)(42186006)(8676002)(70206006)(54906003)(110136005)(70586007)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 18:21:12.5007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c017722-0edf-4d57-483c-08d8656d9cab
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT052.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3581
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_09:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300146
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped
as Gen2. The Retrain Link bit is set as quirk to enable this speed change.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
Changes in v3:
- To set retrain link bit,checking device capability & link status.
- 32bit read in place of 8bit.
- Minor correction in patch comment.
- Change in variable & macro name.
Changes in v2:
- 16bit read in place of 8bit.
 drivers/pci/controller/cadence/pcie-cadence-host.c | 31 ++++++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      |  9 ++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 4550e0d469ca..2b2ae4e18032 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -77,6 +77,36 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
+static void cdns_pcie_retrain(struct cdns_pcie *pcie)
+{
+	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u16 lnk_stat, lnk_ctl;
+
+	if (!cdns_pcie_link_up(pcie))
+		return;
+
+	/*
+	 * Set retrain bit if current speed is 2.5 GB/s,
+	 * but the PCIe root port support is > 2.5 GB/s.
+	 */
+
+	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
+				      PCI_EXP_LNKCAP));
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
+		if (!cdns_pcie_link_up(pcie))
+			return;
+	}
+}
 
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
@@ -115,6 +145,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
 	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
+	cdns_pcie_retrain(pcie);
 	return 0;
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index feed1e3038f4..5f1cf032ae15 100644
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
@@ -413,6 +413,13 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
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


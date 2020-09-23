Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886EE275FF5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWSeu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 14:34:50 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62218 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgIWSet (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 14:34:49 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NIRiff004514;
        Wed, 23 Sep 2020 11:34:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=/QW/Sh1TRC/mkIcGwSu8hzK+QPMIqCrNW1FvZQhUh6c=;
 b=R4qQRV1ZhBtb7KlL5Blhlq1+OCmX7aO46ck/6dDSvE4LPO4JQXwa6pENF7ikVeXSfwmU
 AImqMGXeYMmRU76CifEmzlGGau3KNljIZJzc35kmeEDY62Cfu7MBMfgQ8ftI1YXJ6xPe
 Xtw9mGDN5isJFvUDRPj+Vt1BQKAGPBLofbJ2hu8RGAzzAdgkXWF3bLSnmDB5gd+bUDJA
 3s0MlFYP9YANnF87Pdz1qEb2XoYyNYddU7Mb4TRgXnHF3dvMuOlT77vV35zK0A4/1rPS
 7uuAsojvyE2gQcV4L5esGGyefk2bOBPLw4W37JfApQDn7eQ2D+J2/cvG+xPYuoflIUx2 Sw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33nehxy6mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 11:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxwsDJhIa7FjwoLYxJKVLyAJOG1lZw/ZmieRBZu2LUPlit2QQnPqf3ocb+1PGrVoD4qj9Z+CuzfUwCicMd+86diJIDQsWoynL6ri7IyGNZEasehV2GQuFRpXaUJLxdmojnSoNk0gHg8hsW6XClf50qIjAooU6FvufZbZIewXN9uazlPN2c8Ck5xafh6RnCq1Ua96dNmUhHxzu7B5pbXvLgKqMHy2R4pveKqZz6wqSx2L6T3/YJLMs+1nMX8BrUNf47Laxh/g9pD8UThkbIcCEJyXjDYreNH+4boM0h+DyTADNm8+LSDXfXDpC6SFo6r61JEcDpW20v2WBTJwnqbUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QW/Sh1TRC/mkIcGwSu8hzK+QPMIqCrNW1FvZQhUh6c=;
 b=jd8vfkH7EczO4wpWYXf5EkXxi+xU5HNojbBsoo8WsQUl/0RyqiN2RTysePAvU9NF3kedghRage2gWjPmGPFdCjT1JQHJ4ZF/78s0Ap3QQmJ2I7KM9Rn9txIMvI1QbMb1C/sCiQnV+9OfPx6EkIZPMLtw+hW87b4vfGzIgGDFySB5Bmu49e08PJFs1k4Ek6/xanOaV5Y06SGglwlKasnTqSjmclJYeSBeleA9s0zNg6TlYcyktZVi37+jMM43kqdM4wNACzZfqXcgh5PGXD0nkd5YMEbhM2A6CTRazilBTaAWsUp52KmzaJVA6s2Kk4XOa4FZJcySL08vulvEaERdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QW/Sh1TRC/mkIcGwSu8hzK+QPMIqCrNW1FvZQhUh6c=;
 b=RnALXp6+uTIu/LHeSlX0EdaWg5/j5Q64vsa6UotLOa5p53dVosFUnp5Y1vGD3FtW3vSV19oRt+hwCzmdhTIkdQvFV2smnJNNGtdBmMPGgZKWWj7+avL5RY/wQdFxHUbarYVX6XiyoqOjZiCU7thlVPyNPMkNZ1GoHp1LvEfvo8U=
Received: from DM6PR11CA0031.namprd11.prod.outlook.com (2603:10b6:5:190::44)
 by DM6PR07MB6233.namprd07.prod.outlook.com (2603:10b6:5:178::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 18:34:35 +0000
Received: from DM6NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:190::4) by DM6PR11CA0031.outlook.office365.com
 (2603:10b6:5:190::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Wed, 23 Sep 2020 18:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT030.mail.protection.outlook.com (10.13.178.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Wed, 23 Sep 2020 18:34:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08NIYXN5013431
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 23 Sep 2020 14:34:34 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 23 Sep 2020 20:34:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 23 Sep 2020 20:34:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08NIYWZt009302;
        Wed, 23 Sep 2020 20:34:32 +0200
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08NIYWkN009301;
        Wed, 23 Sep 2020 20:34:32 +0200
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>
Subject: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do autonomous speed change.
Date:   Wed, 23 Sep 2020 20:34:27 +0200
Message-ID: <20200923183427.9258-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c891d3-2eac-4b92-6a50-08d85fef522a
X-MS-TrafficTypeDiagnostic: DM6PR07MB6233:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6233431D841F8E153769D55FD8380@DM6PR07MB6233.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqbbvMx0/8R19szloqOzmE5fkKWLoTg/KXHLNLNKiZmCy7Bm8jHtnVWTLnjLlR665DteB8UMMedncfqDGNLxJV5zAowmoThaqsEEEbYOgy6iqv4gASp9WbgeoPIMKbYPtUJHjYfgmY+fGgVCnTplVdb61Ts7qQDAcp5QndtOy6UlnEQODJbmTH3wUdt8X8D+gfD8Z/Uh2i2CG8AoNL93JSM7+Vmg2Vo51RGtDgkzB3CZdG3kPL4VqfpHcPvHVbF2q/DVAQiGW8eSqxnjTC1RWaRAs/zXjhSGaLeaPw0nCu2EYfL7CF6dx20QnbpJsjQ0vQzmkU6h4UnM64snhwZlnPBDkIJLxvKJiziKSp2QTBzWWYzBaHLSCMasoB4jvWmgzs784SprAr72JRcBbuMqXHjU8de9LDJEmVACKoPpVwV8t2cIPxQa65c8YqqUqwrd35wjSrYOeLgIaf+IkBfmViSbGBBwgBJSIkvVzsHgGAk=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36092001)(46966005)(70586007)(42186006)(82310400003)(110136005)(4326008)(107886003)(54906003)(316002)(1076003)(2906002)(36756003)(478600001)(8936002)(6666004)(2616005)(70206006)(36906005)(26005)(186003)(5660300002)(426003)(86362001)(336012)(47076004)(82740400003)(81166007)(356005)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 18:34:35.2539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c891d3-2eac-4b92-6a50-08d85fef522a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6233
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_13:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230139
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if
strapped as Gen2. The Retrain bit is set as a quirk to trigger
this speed change.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 14 ++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 15 +++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 4550e0d469ca..a2317614268d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -83,6 +83,9 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	struct cdns_pcie *pcie = &rc->pcie;
 	u32 value, ctrl;
 	u32 id;
+	u32 link_cap = CDNS_PCIE_LINK_CAP_OFFSET;
+	u8 sls;
+	u16 lnk_ctl;
 
 	/*
 	 * Set the root complex BAR configuration register:
@@ -111,6 +114,17 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	if (rc->device_id != 0xffff)
 		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
 
+	/* Quirk to enable autonomous speed change for GEN2 controller */
+	/* Reading Supported Link Speed value */
+	sls = PCI_EXP_LNKCAP_SLS &
+		cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP);
+	if (sls == PCI_EXP_LNKCAP_SLS_5_0GB) {
+		/* Since this a Gen2 controller, set Retrain Link(RL) bit */
+		lnk_ctl = cdns_pcie_rp_readw(pcie, link_cap + PCI_EXP_LNKCTL);
+		lnk_ctl |= PCI_EXP_LNKCTL_RL;
+		cdns_pcie_rp_writew(pcie, link_cap + PCI_EXP_LNKCTL, lnk_ctl);
+	}
+
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
 	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index feed1e3038f4..fe560480c573 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -120,6 +120,7 @@
  */
 #define CDNS_PCIE_RP_BASE	0x00200000
 
+#define CDNS_PCIE_LINK_CAP_OFFSET 0xC0
 
 /*
  * Address Translation Registers
@@ -413,6 +414,20 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 	cdns_pcie_write_sz(addr, 0x2, value);
 }
 
+static inline u8 cdns_pcie_rp_readb(struct cdns_pcie *pcie, u32 reg)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	return cdns_pcie_read_sz(addr, 0x1);
+}
+
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


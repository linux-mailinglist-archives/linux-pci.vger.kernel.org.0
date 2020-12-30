Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF72E7866
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 13:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgL3MGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 07:06:53 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:14366 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbgL3MGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 07:06:52 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BUBw83G000585;
        Wed, 30 Dec 2020 04:05:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ywU09bRZKyWaKv9lTOYPs5jMfceAhnbKDW3OoLrgyoM=;
 b=FHHQS+bxJc4AXISsHq1QLp0S8PB1JyFYw/Alnsf4Y2xpYui51zuTps343PWDGb+F14/A
 5hUz5lxe92BbmfZTQh+2SlZnuvKadrb7K10WTib0NXXHrolWxABq1LWlmdshztqW2933
 zpNQ1CX/RnUK+RcTl7ryCYNyitm7M7G44q4dcoK2lZ2+opf+SumdR9vattmxbEb3Va2N
 8O93M3eXHPSFMnOqAJb4T1zQxsGwPCnnna0UKu8sDVxr2TigBn0oSDuzdsS2rG63rAvv
 2Nq44M2wmARI+zVSXgiG8LFdl8JUPOOGfsYmdQ4OMT7iNT/q53Pj/cRJcIG7ud6fEbG+ 2Q== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35p2m1fh2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Dec 2020 04:05:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg6mf3ArZYhmbVmWjGDSp7vSAdRuQTXJWP+0tfrMhtRNxRM5mma6H4BYy6D3/hUs7QQQG50CWDnEnNwv5H98KgySdDPJ6D4u9sewY3Mw8zQyMsltVICIZArjEHeJ9QsLnNChUM9sNp2ZeEIE4VqPd+DF2+smhxbkLewNxypX3mpO66L/qi2LrxeM2c79ernd0rRVCXynvMPm5h1oe+/vNRcJenb4RYjpEs78urbNfR+lYf1zjZrKFyOPLbvx+u6RrSYrnXuoVhajNzn9JjhWOE5XvDYEFypAz0M3/eO1oDQ5e49yRXxINnfIRGyOm5fBgjtQSJcdq5CASyrTjmrFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywU09bRZKyWaKv9lTOYPs5jMfceAhnbKDW3OoLrgyoM=;
 b=Z1c4pzPHlD2NJdGYJnbZ/d7QOLPAzhJgDGNNo9Ygb+Y/4Um5aX0pS8y6kGbyd2aPsuBUvNFYWxHC5YxCp0elrqE2voSxGnEdNTnL8HX41xuYFGg8JXh87lxhx4wrEXidpWmG/SMf1NaKzJYFR5Ol0nAlkgRRBrENKMjX/dpdwe6n+nwxy2AlVUNWjYyMF2b5EHB0AXH/VcOT9Ylt/plWHFTqdRuoImgAFiWFoBFZUecYPtoGXcQD84+rKDdj93cZ0xZuqDWs3DtmN9ZYsEztnbwYZH8VA8sgQ+3AS16rd+3iHJqgO8bzJGPmGdJ47rE7HNE5J/pDYoU20sXv+p2zow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywU09bRZKyWaKv9lTOYPs5jMfceAhnbKDW3OoLrgyoM=;
 b=mZzdtdKiaRwRludYhcKM5MGdazoBfiS1ua63jA1eNbj+ypXkRcDAMZ0RWPkMafUeWkeCooLh7FPnFDvMu0SgbUeut44TDQ4TlF1HtXBBYtCgM3EtkJUcaq2PbQ03uUrIogTweM6CKFrUSnu1NjRw2K+OSSv88lFHraKsAxLA25I=
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by BN8PR07MB6097.namprd07.prod.outlook.com (2603:10b6:408:99::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.29; Wed, 30 Dec
 2020 12:05:32 +0000
Received: from MW2NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::32) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Wed, 30 Dec 2020 12:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT017.mail.protection.outlook.com (10.13.180.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Wed, 30 Dec 2020 12:05:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0BUC5R50024483
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Dec 2020 04:05:29 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Dec 2020 13:05:27 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Dec 2020 13:05:27 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BUC5Q9H002408;
        Wed, 30 Dec 2020 13:05:26 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BUC5Qto002407;
        Wed, 30 Dec 2020 13:05:26 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v7 2/2] PCI: cadence: Retrain Link to work around Gen2 training defect.
Date:   Wed, 30 Dec 2020 13:05:15 +0100
Message-ID: <20201230120515.2348-3-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20201230120515.2348-1-nadeem@cadence.com>
References: <20201230120515.2348-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43980375-d9c4-46f2-7a88-08d8acbb349f
X-MS-TrafficTypeDiagnostic: BN8PR07MB6097:
X-Microsoft-Antispam-PRVS: <BN8PR07MB60977FD8DF9ADF18F25A7A7BD8D70@BN8PR07MB6097.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwVdJPiKYvPW4DteZ0P4BMk5/gGNg1IK/dyA+hQsvuteqFmHgDOBfULrCosQiRU6akA+OljGbTBfWp4RBB4PnE6VibJ8aSQUVU/W2RgMyKbL5yYERcjtU1iUYQwfdqFxmkoHHB6VM7xk5FAKBSP8EMrCHFPbmZn8CYAwVUlWBbUeDt+irB0xiTwFpBElbqKziMEgx3beH+o5MfC/fjyJNJytaaCyUjpozo4Reu+0SK8Mk9OOgS36998lxarEdZbYkySWzKluvfK41rdkMOBSocWavsCc8Kr/R9KiclTAan7APzDC8CE6Xm4X76qGaD4CWmDbpQEzCBcEzVT/EWiVJpSbuLLz1jXeVib716sIenxYXTO9U4TBAEfMq2nmzGxzLsWLsEWf8l60qjma8U0QZH5VKBTA4xSKyPQno3WIUcbV2uebsg0x9HnHqR45+e4n10urzSJ/xd5LZD8f2oYJELR77aKpLSdiHeKiJN44TNV7o+/pS+EwOrwbX0ulbr+j
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39850400004)(36092001)(46966006)(82740400003)(356005)(42186006)(8936002)(47076005)(6666004)(4326008)(82310400003)(107886003)(70586007)(8676002)(7636003)(110136005)(478600001)(36906005)(54906003)(186003)(1076003)(5660300002)(70206006)(2906002)(26005)(86362001)(316002)(336012)(36756003)(83380400001)(426003)(2616005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 12:05:31.4064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43980375-d9c4-46f2-7a88-08d8acbb349f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6097
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-30_07:2020-12-30,2020-12-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012300075
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped
as Gen2. The Retrain Link bit is set as quirk to enable this speed change.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pci-j721e.c         |  3 ++
 drivers/pci/controller/cadence/pcie-cadence-host.c | 37 +++++++++++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h      | 11 ++++++-
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index dac1ac8a7615..849f1e416ea5 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -64,6 +64,7 @@ enum j721e_pcie_mode {
 
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
+	bool quirk_retrain_flag;
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
index 9f7aa718c8d4..f3496588862d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -94,6 +94,35 @@ static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static int cdns_pcie_retrain(struct cdns_pcie *pcie)
+{
+	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	u16 lnk_stat, lnk_ctl;
+	int ret = 0;
+
+	/*
+	 * Set retrain bit if current speed is 2.5 GB/s,
+	 * but the PCIe root port support is > 2.5 GB/s.
+	 */
+
+	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
+					     PCI_EXP_LNKCAP));
+	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
+		return ret;
+
+	lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
+		lnk_ctl = cdns_pcie_rp_readw(pcie,
+					     pcie_cap_off + PCI_EXP_LNKCTL);
+		lnk_ctl |= PCI_EXP_LNKCTL_RL;
+		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
+				    lnk_ctl);
+
+		ret = cdns_pcie_host_wait_for_link(pcie);
+	}
+	return ret;
+}
+
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -457,8 +486,14 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	}
 
 	ret = cdns_pcie_host_wait_for_link(pcie);
-	if (ret)
+	if (ret) {
 		dev_dbg(dev, "PCIe link never came up\n");
+	} else {
+		if (rc->quirk_retrain_flag) {
+			if (cdns_pcie_retrain(pcie))
+				dev_dbg(dev, "PCIe link never came up\n");
+		}
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


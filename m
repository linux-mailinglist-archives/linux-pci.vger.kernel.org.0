Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1151452BC3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 08:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhKPHmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 02:42:49 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:16874 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230403AbhKPHmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 02:42:38 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG4RJlf021318;
        Mon, 15 Nov 2021 23:39:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=K1PYtbv/VaaQ1kphs3Y5cL44ARkzArrdsRK925kZZ2w=;
 b=P2SVf+aqRXjhNXHw5CScZ/lIRnhzM1Z9QyTt+0jPUnr63MHjTVNixiJ1IQs6lDmTGdJm
 /H/SVRrh+nmv8yY5FgFRLJCOrWnNW6+W4vEGmo8WEkp5l4kvhtnyq8ptKFSQSPeblWhq
 2dJRTL7pfMvgwlTzmTRKnAKu96bxiEa/Aye1HRj1lFXaLDoG8CucKlAot5plNktbYJBk
 QZtFgGGyBdcD2XLf/yn8FpFrwBQaHrrOJc3sWyGK4wUFObiUzFdXSno/79YMEaSGKXDZ
 GRiqE7fGiZtOflHMx/+MO6xYG2xnS8r/iK6z3VOQRbd1Eni5yhkCjBTFgMOE6uDGS2Ad 0w== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3cbkj1441w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 23:39:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgSJ81Fr+d+cqKa9NNrwLDe15HDj5dyMOj7FcQ7d3r1hitEle1kIgjKl7d5lCiCJPlfbc9/sKA0ohxP75gstV6k3pMO5hJxK3XE7rxwTcddEpqkLLoSiYxni44NsNThK6YsOhuwCJ8DRaB4vpoxG/pIJ/TnnmPGA4NDrKCfjIhH/gr5uq/JpqmTpE0uXbasRjT7srOsB5RBUgXHkLnUNTr5fgSUwziarNBww70NbFJKTSCQoP4FudZE/Lh+aTB0ZIIWV6AIDUmnuivsnzsls6uGTohOR7JZ2UjwPya6T/jYt5TzveMhJjqjqJtiG/zSXrks9rnj7wwKlcgwIAfQzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1PYtbv/VaaQ1kphs3Y5cL44ARkzArrdsRK925kZZ2w=;
 b=LNkQyL1FXdpxRzQm5hELjpTSQu6n6D75AFrZ/rO8s666WV+NeDXVgOXdt7oNPEC1is9nyISkzJbrM6OkC1IvXX2K8hDT0qqM5fckKXw9E8YFIGS2LTGKLE50QskspR7t0EU4Tyt0EWLlX2UWKgiAkeq8hy4N9i8JaDN4q3KyQ9tpPd9yAviwcC0XAzDa/qbkiZTCOqzIR2gLJ0p9FFqGQ+sCarQPNOOXt+FYTqRCX6uX2/wk0ktX7gwyVq/2PvBKQ1UCd+5aHCVMbEeNnGBOo95hYoc3Nl0GYrzkqkPmWK544ZSZ/jinDCfvocuWE3SCII6IuORANwNm43mIW8sq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1PYtbv/VaaQ1kphs3Y5cL44ARkzArrdsRK925kZZ2w=;
 b=uis+RgemU3YdbuSDzEVl5eVm50gQvvDTdG8Vge2OzFR1ArgesgO5iTrFEFMSdw/zYWBWxicvBnQR5up/Dv5Pl9oy9JT11N1afx4hy0iFtI3C6vAyAp3IZiZrljtgidBbORBzOM+eVJbtFGMiR3i26OFBZuTwD5J3s3lUBwZUd7c=
Received: from BN8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:408:c0::20)
 by BY5PR07MB8150.namprd07.prod.outlook.com (2603:10b6:a03:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 07:39:19 +0000
Received: from BN8NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::ef) by BN8PR15CA0007.outlook.office365.com
 (2603:10b6:408:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 16 Nov 2021 07:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT060.mail.protection.outlook.com (10.13.183.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.9 via Frontend Transport; Tue, 16 Nov 2021 07:39:19 +0000
Received: from mailsj9.global.cadence.com (mailsj9.cadence.com [10.202.56.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1AG7dJIR009107
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Nov 2021 23:39:19 -0800
Received: from mailsj9.global.cadence.com (10.202.56.202) by
 mailsj9.global.cadence.com (10.202.56.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Nov 2021 23:39:19 -0800
Received: from ipgpd01.cadence.com (158.140.83.21) by
 mailsj9.global.cadence.com (10.202.56.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 15 Nov 2021 23:39:19 -0800
Received: from ipgpd01.cadence.com (localhost.localdomain [127.0.0.1])
        by ipgpd01.cadence.com (8.14.4/8.14.4) with ESMTP id 1AG7dJe4073706;
        Mon, 15 Nov 2021 23:39:19 -0800
Received: (from pthombar@localhost)
        by ipgpd01.cadence.com (8.14.4/8.14.4/Submit) id 1AG7dINL073702;
        Mon, 15 Nov 2021 23:39:18 -0800
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     <bhelgaas@google.com>, <kishon@ti.com>, <tjoseph@cadence.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v2] PCI: cadence: Clear FLR in device capabilities register
Date:   Mon, 15 Nov 2021 23:39:16 -0800
Message-ID: <1637048356-73662-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: mailsj9.global.cadence.com
X-OrganizationHeadersPreserved: mailsj9.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0010f333-b8fa-409e-93e8-08d9a8d4331f
X-MS-TrafficTypeDiagnostic: BY5PR07MB8150:
X-Microsoft-Antispam-PRVS: <BY5PR07MB81504A2ED43EC480E763080CC1999@BY5PR07MB8150.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTuTL+3mlLkonP43JGWgvm9BUn3BGa/Hfgzqp+jgwNkfTGSMZfbAS0ZsvOFiK2EllnOHrTQlCLEnm0uF0bcnAcaveoz+WUeiBCJAEdGj2soMCvP0uGvEZWgUZrTD1qh1y8qZa8TbcBas1hePZ9Gq+areRBgK4HjbifnkABHGsEbM5paynnOzOLmqmPBnZTweb3Qtuvqno4TV3FPh07qhGrZe3DmGLXD6nwir92SYutkqrpE68zVeyUN88m0gSP4xjz37ntrbd7NO1aXukXCxGQYuazdgmvrsAVxweLEgH96yi/3VMPgunPPjWpzWV+HXnjFCJHgQi7hSAhJwKyEmrB/0mQjOKEvgNDX0qhtj3Cgaj8FWtQoc75vCtCjsn/SU8TJ4HumdmlWK6M/K3/7jJyjtm++tkOltkWz6JBuVlPSpRurOiJwc9u78+UbxZp2kGdlHLvnqXAqjc/qfe9nmwB0c9giIjxrtZOMixaPLD3Gxc12RSCZTpEQ9BBqJwkYxlOaZrfl8LEhee6+bg037zHJ+zcVmBZYW8GsuFHBSBIJRH4pGqEhiIs69j28P5exyMjskKkEiDDdIqpUTNrjWIEL8r11mwou1nRC6t4mQPnuGG7MAf/deduug6tAg4TpG8Nz/lWFULo4SjKNY/pAsoG+ReT/HnSZl1RsZT3TSUtogVG7DbPhVKfTSW4h01uO9+FXYRj43IiCRBo5n70hrcVW5ifrGgoLmpL2R/qvaqDA=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(54906003)(36860700001)(110136005)(47076005)(8936002)(4326008)(5660300002)(26005)(86362001)(186003)(8676002)(83380400001)(107886003)(70586007)(2616005)(7636003)(336012)(36756003)(356005)(42186006)(316002)(70206006)(82310400003)(508600001)(426003)(2906002)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 07:39:19.2367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0010f333-b8fa-409e-93e8-08d9a8d4331f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT060.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB8150
X-Proofpoint-ORIG-GUID: 6DL6XtQ5wSkRCB9S4CwVZdjwiLekI6sS
X-Proofpoint-GUID: 6DL6XtQ5wSkRCB9S4CwVZdjwiLekI6sS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_16,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160038
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Parshuram Thombare <pthombar@cadence.com>

Clear FLR (Function Level Reset) from device capabilities
registers for all physical functions.

During FLR, the Margining Lane Status and Margining Lane Control
registers should not be reset, as per PCIe specification.
However, the controller incorrectly resets these registers upon FLR.
This causes PCISIG compliance FLR test to fail. Hence preventing
all functions from advertising FLR support if flag quirk_disable_flr
is set.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
Changes since v1:
Changes suggested by Bjorn in the description.

---
 drivers/pci/controller/cadence/pci-j721e.c       |  3 +++
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 18 +++++++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h    |  3 +++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ffb176d..635e36c 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -70,6 +70,7 @@ struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
 	unsigned int		quirk_retrain_flag:1;
 	unsigned int		quirk_detect_quiet_flag:1;
+	unsigned int		quirk_disable_flr:1;
 	u32			linkdown_irq_regfield;
 	unsigned int		byte_access_allowed:1;
 };
@@ -308,6 +309,7 @@ static int cdns_ti_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.quirk_detect_quiet_flag = true,
+	.quirk_disable_flr = true,
 };
 
 static const struct j721e_pcie_data am64_pcie_rc_data = {
@@ -510,6 +512,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
+		ep->quirk_disable_flr = data->quirk_disable_flr;
 
 		cdns_pcie = &ep->pcie;
 		cdns_pcie->dev = dev;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 88e05b9..4b1c4bc 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -565,7 +565,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct device *dev = pcie->dev;
-	int ret;
+	int max_epfs = sizeof(epc->function_num_map) * 8;
+	int ret, value, epf;
 
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
@@ -573,6 +574,21 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 */
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
 
+	if (ep->quirk_disable_flr) {
+		for (epf = 0; epf < max_epfs; epf++) {
+			if (!(epc->function_num_map & BIT(epf)))
+				continue;
+
+			value = cdns_pcie_ep_fn_readl(pcie, epf,
+					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
+					PCI_EXP_DEVCAP);
+			value &= ~PCI_EXP_DEVCAP_FLR;
+			cdns_pcie_ep_fn_writel(pcie, epf,
+					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
+					PCI_EXP_DEVCAP, value);
+		}
+	}
+
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 262421e..e978e7c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -123,6 +123,7 @@
 
 #define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
 #define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
+#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
 #define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
 
 /*
@@ -357,6 +358,7 @@ struct cdns_pcie_epf {
  *        minimize time between read and write
  * @epf: Structure to hold info about endpoint function
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
+ * @quirk_disable_flr: Disable FLR (Function Level Reset) quirk flag
  */
 struct cdns_pcie_ep {
 	struct cdns_pcie	pcie;
@@ -372,6 +374,7 @@ struct cdns_pcie_ep {
 	spinlock_t		lock;
 	struct cdns_pcie_epf	*epf;
 	unsigned int		quirk_detect_quiet_flag:1;
+	unsigned int		quirk_disable_flr:1;
 };
 
 
-- 
1.9.1


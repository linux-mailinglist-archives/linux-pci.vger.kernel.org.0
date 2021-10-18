Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B68432608
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhJRSKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 14:10:02 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54762 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231548AbhJRSKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 14:10:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IFpIr9015865;
        Mon, 18 Oct 2021 11:07:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=i41GYAvsVXWfvC/aoyDZxHGHghwLHP94O3sVu7cX1Ws=;
 b=qDi3Kk+flhvrjBHb6ZnNvSiLjgdRXjP1zCmBz5awbB0UKA9fwczz1B+gARV8RbIkhUgJ
 XFbtR2jWX3GmoRcIYBmNjH3bSKyKvw381LjZ9i2MBdZGT+6TTEFBmTAQC0zPhEvD50gL
 QyjN/n9PtDwnDI7f9iRwAe6rydk7C0YdWr2XYuElaUU9Iu7i9MekWm11/ZJHr+eFQbdy
 P0IH7rFTTchAOPe2woE3ARvUjKOnHnyi63UQmWsJsLYVi7qc8b9LwaPXXEl2Dh+Xl5Jj
 0fsbrChiBXjQLPS6NCD17mFBH3YJ1nX/jBJxQgs8Xd8uR/iorK3SLPyQaX6yDSzN/i0O bw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3bs8p698e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 11:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO7YF7twHOt4Ugn92hjQF1RaJ3CZPFOtlz64nJcUvGc11y7b8Cy7vKsdcA2Bb3RBgUZx5cIgzLfVFyIKFjlQCQegJgYA0BTe80gBgAR1u3ZeqoC6jphlUdxUxnB9IRneST65kqH5GGqZCJC09taKQLRtXbny6AumBm42WaEXpZfQHkIXsmHL0EhvMtACH/dMesFvGnct3nPBTc1O6LYMzzDLtKlNN8MsmKBzZN+8X8pKobHSakNYEj4dc2vr5t/Z9E9DmaYVaokPlvp64qYvnT++loDmyoKI6byKwzhl8m7bV1buTwjYtUiIcx+Hd0qBXY+OMKRabHIBp+kwGIsw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i41GYAvsVXWfvC/aoyDZxHGHghwLHP94O3sVu7cX1Ws=;
 b=LKVcr4rNk85zehL6o8ezlxbzehwkew7GvENkWYVVA20gn6TDnv9a8CNsrhUHpfYCebvmiUQDQPIyEgG0NOojoGDqt37QDDKtdSHNIxLqVcaZEqvmim21TW3fOTBCKop6XLpdmr597JvU1EVfJuNZCxd4PVjqo97oGG82RKa6Td4Qp/9Tp/AAXIi7Ppp6Y3dcgJayc6SQNT5tFPocsGZpd/hatzNP9bbRqqnIzpXGA/oHiG/5Tn4MthgECnhyt26A7xTCUUYb7WHcSI0zgi8sKqKaijJ6SAtC3r/UTZ2tBYSOf/SjKMCWOtWx0CFw2THuJj4eSGrjsaXcnb7BNaxKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i41GYAvsVXWfvC/aoyDZxHGHghwLHP94O3sVu7cX1Ws=;
 b=eBX3y2q4zexli+i9IWOR1GcZh+1ITPk47J8yUsH1IQGxwXt7J4hyGEaymdWH1LQGbuCbSUZ34Ob77uSfpOmTfPtVX4YI25FtvxhpospuFHW8tc5uTRItGEeAXIEQgMAs6Lod9XMwEA0skGS4BvmfSAZnbO0uAQNAnQFx/ocCOt8=
Received: from MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22)
 by DM5PR0701MB3752.namprd07.prod.outlook.com (2603:10b6:4:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 18:07:31 +0000
Received: from MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::d1) by MW4PR03CA0167.outlook.office365.com
 (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Mon, 18 Oct 2021 18:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT045.mail.protection.outlook.com (10.13.181.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.8 via Frontend Transport; Mon, 18 Oct 2021 18:07:30 +0000
Received: from mailsj9.global.cadence.com (mailsj9.cadence.com [10.202.56.202])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19II7STa001586
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Oct 2021 14:07:28 -0400
Received: from mailsj8.global.cadence.com (10.202.56.201) by
 mailsj9.global.cadence.com (10.202.56.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 18 Oct 2021 11:07:27 -0700
Received: from ipgpd01.cadence.com (158.140.83.21) by
 mailsj8.global.cadence.com (10.202.56.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 18 Oct 2021 11:07:27 -0700
Received: from ipgpd01.cadence.com (localhost.localdomain [127.0.0.1])
        by ipgpd01.cadence.com (8.14.4/8.14.4) with ESMTP id 19II7RlN089813;
        Mon, 18 Oct 2021 11:07:27 -0700
Received: (from pthombar@localhost)
        by ipgpd01.cadence.com (8.14.4/8.14.4/Submit) id 19II7Rfe089810;
        Mon, 18 Oct 2021 11:07:27 -0700
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     <kishon@ti.com>, <tjoseph@cadence.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH] PCI: cadence: Disable Function Level Reset support
Date:   Mon, 18 Oct 2021 11:07:25 -0700
Message-ID: <1634580445-89772-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: mailsj9.global.cadence.com
X-OrganizationHeadersPreserved: mailsj9.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c31d9df4-6c2c-4024-cfde-08d992622701
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3752:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3752EAD2371C0A7F254E427DC1BC9@DM5PR0701MB3752.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joogyMjV/eO4Tw7YU5MYHZuoSoAxjBNQL7bO7uDDPd8JC7YpserkAy4xdbYIas1KSaSb5xGA4d560kjeW8qUYXGex7pEtpfbgDrfxEtI72PH/Wrqokk7ILy9K3WI1Whqc/gyhl7SIWkWeFqmPXTDbGif4p2+xxm2VedTixi4yiOcGHStxEq1CtBEkMEHfTFNb7LyRu5VErooR9RMDnVGyrjeisikMA8IuKq8+3WVwYLdcr9jS99mclKklIZK1vF+v9mUoYRCRVbRXkiWaPwT3YnFmA9yaFSIHPrEijVQ8Q/CmoDus7pj1bFqcgTHabIkzBO4cW9Le7d+zSEoOh99zbsfuiEmjOmFH4iNGoF7DZlvUmM/lmUSnrO9RdrYnNvxZ27vtYhSBAP3TdbBI+ZWQFZpPYoXAMejUD1FV6meGt5ZzjYZE+XCEHHRiemXSusCkKBZ3fLLjPOM09rYXOKYkIrmXyRthGD85la7s8AewRWwKaTK4+0Rvl84P8earr6+5gbTSISxnkieRcflA8RkU/JCpb2WrDN/6oNuielQGkp3K1a2/8oxEmS3SkMWGmd/XzVHRj5gHhEYXsboG/Pk57EKjF/4Fo9kIFQhkFLiq/Yo2ogyt3uDySTK6qI9cZpHFt5va9KkJuDG+sP7LKS0l1Eox/fCpW/5wTyYnzq3UID3V95/dOb7475iNcgp6Ej7FgOq9++Od0IXhX8dctsektTkXgCM9UYFkpaNv7PApJrMOVUDuFp68so9ofczu+saUd4iOleiv8uXWSr8vjTorA==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(36860700001)(81166007)(508600001)(8936002)(356005)(2616005)(36906005)(83380400001)(426003)(336012)(82310400003)(8676002)(316002)(70586007)(70206006)(42186006)(107886003)(47076005)(110136005)(54906003)(26005)(36756003)(4326008)(2906002)(86362001)(5660300002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 18:07:30.6957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31d9df4-6c2c-4024-cfde-08d992622701
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3752
X-Proofpoint-ORIG-GUID: dzFvyqvcybN90gYauaPmLNk4fsA_a16p
X-Proofpoint-GUID: dzFvyqvcybN90gYauaPmLNk4fsA_a16p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_07,2021-10-18_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=977
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110180102
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Parshuram Thombare <pthombar@cadence.com>

This patch disables FLR (Function Level Reset) support on all physical
functions.
During FLR, the Margining Lane Status and Margining Lane Control
registers should not be reset, as per PCIe specification.
However, the Controller incorrectly resets these registers upon FLR.
This causes PCISIG compliance FLR test to fail. Hence disabling
FLR on all functions using quirk flag.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
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


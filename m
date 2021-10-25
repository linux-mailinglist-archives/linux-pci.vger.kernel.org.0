Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9421643965C
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhJYMd6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 08:33:58 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47452 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232582AbhJYMd6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 08:33:58 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P7i5eK021540;
        Mon, 25 Oct 2021 05:31:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=K1PYtbv/VaaQ1kphs3Y5cL44ARkzArrdsRK925kZZ2w=;
 b=svTayc4rR2ki71Y+ioC0OTEcf4LkVRRUG/qJYcU+I98ueO8hiXWe8plxNvijGI1hJVCD
 Y2FRML7rfThbI5BlkePSXxD2KMHtcRLjZr6ti6cOGNhYn8MT8lKt4/yzpSrl4bv/qp9C
 ALJ06GyART7LCBV/KHwW5qYG9Gah6lTRFbJF3zb1rfNotaTkhpsuSlDuUS6oEdmf5xW2
 JzCsAWg5MHjNNWJPJQiZKaiXVjeW/nc7kbvqcsseVLhKnJD/hYKTjc8hGs1bKmGYATgd
 qnKvlpH5W0i1tKJ7mzPvVnJ9DK20XWrZIMzUbjdxVvq0/x1qRffonlRBc7hIRbnXJPVb kg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3bwrew8vhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 05:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1ysAjcPIWx8JooVr1DMI1H2/wDW4UGKQKdXVbXYrWi6QyMeOEwcqhDHXDOSloda4nC4+cP9+XXc8SsuI98w8hUvUa/KpmIlqYWNnF45GgKsXm2dWGmANA9KLT/U8ZepfJQZ8I8LdcXq++Z0s3nzPGj3BLiTWFJsz+9C5U19ojWuGutshicjMvcmQvIXbBx4ETTATZxJ0rBR67NxiS6Ke0RYxBwQyZlDo8RLhaF4L8G1Osq5of4OLgJgSdywGPtjN4Dz7aMQjIxwKacMNx85U01zOngCBxqHcahfe3SGK/tGfHrFY0wiS7uh8n0xom9QEe83ppoDJecJzSaDAPXVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1PYtbv/VaaQ1kphs3Y5cL44ARkzArrdsRK925kZZ2w=;
 b=Rr7Fs1Fij+M3N14CKRZj4+EAEWo/uTDL0l9AunnD/H5wmqegy83xM2rRsWjc4jQDaRInxAPXarfBbKnSjDi+oGl8pCNk6QX12/Qzwfc9kkXU1TQWHK4tWuKnFj9fgAqF8+5ggAQXJo2jUpHt6XyodC09reRy47dQl8pLXFy7AVxUagxjJ/dWCtmhahe2+CTYpsZb3o1UJq7mOeHKnxpGSG4Ll6XZO7a+WVlo/0c1qRYeM1z1CR/U1V+oX+wZv6NRjk8uLmel/G16rz6IVhoQbyAiQX992UtWKUe72Yp9sg6vQEw2YgcTp6M/pdKh3Q/ojfTPtbj++tqUgASRV2lYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1PYtbv/VaaQ1kphs3Y5cL44ARkzArrdsRK925kZZ2w=;
 b=599knwWOFuSi0Kf1JnkmrzSNNQguUD2gAV5kg30INTT/+FqOs8fOxomgeLu381VVrU+407dReRwmDOkKOUe7m/55zl9Ym6qSdNmOkbf8HwSEb8v6CeoYyBAYQ4J6RIr9TuqSr2nFzDUXu4RDqx+e4kW/l1S/mcIg4/0/osBj1Po=
Received: from BN6PR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:404:b4::20) by BYAPR07MB5670.namprd07.prod.outlook.com
 (2603:10b6:a03:9f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 12:31:18 +0000
Received: from BN8NAM12FT043.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::da) by BN6PR2001CA0010.outlook.office365.com
 (2603:10b6:404:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 12:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT043.mail.protection.outlook.com (10.13.183.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Mon, 25 Oct 2021 12:31:18 +0000
Received: from mailsj9.global.cadence.com (mailsj9.cadence.com [10.202.56.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19PCVHnM019618
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Oct 2021 05:31:17 -0700
Received: from mailsj8.global.cadence.com (10.202.56.201) by
 mailsj9.global.cadence.com (10.202.56.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 25 Oct 2021 05:31:17 -0700
Received: from ipgpd01.cadence.com (158.140.83.21) by
 mailsj8.global.cadence.com (10.202.56.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 25 Oct 2021 05:31:17 -0700
Received: from ipgpd01.cadence.com (localhost.localdomain [127.0.0.1])
        by ipgpd01.cadence.com (8.14.4/8.14.4) with ESMTP id 19PCVHrs089906;
        Mon, 25 Oct 2021 05:31:17 -0700
Received: (from pthombar@localhost)
        by ipgpd01.cadence.com (8.14.4/8.14.4/Submit) id 19PCVGeh089905;
        Mon, 25 Oct 2021 05:31:16 -0700
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     <bhelgaas@google.com>, <kishon@ti.com>, <tjoseph@cadence.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v2] PCI: cadence: Clear FLR in device capabilities register
Date:   Mon, 25 Oct 2021 05:31:15 -0700
Message-ID: <1635165075-89864-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: mailsj9.global.cadence.com
X-OrganizationHeadersPreserved: mailsj9.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9324026e-6d4e-4b77-60a9-08d997b3581f
X-MS-TrafficTypeDiagnostic: BYAPR07MB5670:
X-Microsoft-Antispam-PRVS: <BYAPR07MB56701C2292BFC8D9EBA3A3ABC1839@BYAPR07MB5670.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5mq+y+60ru8WH88zbADxsQIXpSBXWcpB5xnrUdfPpUujXobRlJV5u6+hb7Jkr9xhheU1jt/rJ4cqPx9HctuEDwik+j99qbL6ELL8FlB4XE7hWO5diredb3iL/VP4EHcCpHGqv+FaYL0uTZaWaFEawAG74es0KS3sNED/9LqeyAdgHX3CBD2Izc21JwVGBqDucKJeEdMsx+alLKWVU1BUSMm3AmiLanNX1TZSXYA3+404HPwUv3DNYLzVIlEoGlZQLxgO9inGnVSmQlf3SPD7hg+FUzxv12uLzM9UBO4ff4wIVZ0JnZGskQqkkAD2RnkUBAgWGp+ZOODkgo+tZjiMP6HeYYEZ7JUPoRETvNwbgzUCeVGsRIo5DOQ1svJjhYzsYcLapdzN4vcj823Kz7knEfU9IVMzXw+n01d2q0tg+WsFGXVafrBp7PLkTV99V7kOY5+AIBAONBH6vw3uuIrkwPlwchk6Hjz//fTHIlfIhwe0jsrKxD0aMPS15WKyNCMdT13oXGSR8tZVPJQoZD3bXrSwDrXICm5AmIQ4IgimKhZzVElKufu3RTIU7BDU3IamTicgHIh2DmF7b1YPq7HYCTjU9tqx1A8f22kJyWgzMLAbw6ffivcIiMNvFQQG/gPkyjF5cwR+epIjzBbUVVae3Mtp+3ptQp+rxe86ja0FnJFd74+jDmhLaa/Nf76ueKuw/iXLmXZTVk1HPLIsIPGVyGolBX+ViABJs0neN//Kq0=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(36756003)(356005)(110136005)(54906003)(8676002)(42186006)(70206006)(83380400001)(26005)(70586007)(36860700001)(4326008)(36906005)(7636003)(186003)(5660300002)(2906002)(508600001)(316002)(8936002)(82310400003)(47076005)(336012)(426003)(2616005)(107886003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:31:18.1548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9324026e-6d4e-4b77-60a9-08d997b3581f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT043.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5670
X-Proofpoint-ORIG-GUID: JOFIqNEuppPupMNN8V-WQIpzeopdHl-f
X-Proofpoint-GUID: JOFIqNEuppPupMNN8V-WQIpzeopdHl-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_04,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250076
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


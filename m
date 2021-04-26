Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CA36ABC5
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhDZFPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 01:15:34 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42398 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229469AbhDZFPe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 01:15:34 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13Q5ECsG022319;
        Sun, 25 Apr 2021 22:14:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=AeCRZ/O42CvMAmFTXSnpUYiNOZVSfCw2PT4o1usYC60=;
 b=IS96U5T4h3mLsEOA1+QaC0ewCCYQX68ZNRVTn3kzEL1jPVGLFHKCrtZNaFawOqXkLJnB
 3O8KV2ijaVZlm7XuulXBJMPpOL67OeZ3YlqMuU62srSHkpKYBGxyuiajl/PXD79ry3KX
 wBHstH5zX7gzkXrzAe8oq9n0m5L1PoNPeAlIPUuYFm27QRLk5KDtqljtQFOLfcubYPgm
 /jUIoIg14Vpgozj/bTk3bPq5M0oeUAmbUs8y4hA4fs2cw+AnBxRbV1ZeItaUMkZOcgZq
 wyi/k4EQpuTB5kVhA29hRGv196OKt27GJVLY8LwmBN0cAKHUWdldkOmyO5N5KZR39Wfe RQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0b-0014ca01.pphosted.com with ESMTP id 384ex14ms8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Apr 2021 22:14:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXKgRF0EVA+HWUOTefksM4PAP7bhn7NgIYvY/aBzkRMNIIdkJCRFloAqEGoSEPwYHaooHlnzbZTb4rDZGklto+zhrtFeIzcinOIQ29mHV0ae7o7s9xl/Y4IrjpaUT22yHRrKXNezUCiaHniBJgbfJsDOQcAFJvHnL5kObEqsc1pIYYzgmdZcpoUmjIfJYrmuahYFjrFlI1lHtep2ks3TDquXeiGh78/81qXVwwp/gozZZNSuV/2HubIQov+DZAk2NF6n76l4o/1Ud6c9Tg04XdAHWqqm1WPrH49YJRq9E2LPWLGC/QOWc5vYED/ljsUlipPy3nFbOqK9B+HFED5iGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeCRZ/O42CvMAmFTXSnpUYiNOZVSfCw2PT4o1usYC60=;
 b=IPx8Dfcp36FILjQxCQbb9J932DCjX8FEoaYcnXj70S3Ko6SPEREjRbLZDwUVFU/3cDAp0FEccEPyU7RYQdRqp+2FMQqHnmuqXHBtWdqNDv2IdrsBGHqCDvYEclox9GfFAEG+U64awo0ctkZuX+9hlbPQrwSemQY3S52JzOrU2PUSozPJgmMwlvPWihCMjg+BiYh+cnPPCl6GpOGJl30DzGMexyESt07KVN37deG7V5iENKgkSFfrQJ2BhRKdzlpzdB0m12Gq+oPbKVyESZuP17nb1D/GgB1PSQ3j5FNoJczwMwbuiaDcKRT16jGDL8N4SVvKfWbNefmXYjRxpyIUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeCRZ/O42CvMAmFTXSnpUYiNOZVSfCw2PT4o1usYC60=;
 b=GHRlLjl4uemQUorUMHwN4P9cU2zFa21Tz7q6tN29HciDpJ9IQ34E4EIzjFIrZavlJZwKCdmhR9buYa0ctILzC6za2gQdSFimV1aJy6SDya8BrIK+OPnD7MQkah2ooAJJZK73pODPFp2znHBwYOe5pcIcH70LQRBORxvbUnRmRKE=
Received: from MWHPR03CA0007.namprd03.prod.outlook.com (2603:10b6:300:117::17)
 by BN8PR07MB6849.namprd07.prod.outlook.com (2603:10b6:408:b1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 05:14:35 +0000
Received: from MW2NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::3c) by MWHPR03CA0007.outlook.office365.com
 (2603:10b6:300:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Mon, 26 Apr 2021 05:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT026.mail.protection.outlook.com (10.13.180.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.16 via Frontend Transport; Mon, 26 Apr 2021 05:14:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 13Q5EV6U093777
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sun, 25 Apr 2021 22:14:33 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Apr 2021 07:14:31 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 26 Apr 2021 07:14:31 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 13Q5EVmP016011;
        Mon, 26 Apr 2021 07:14:31 +0200
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 13Q5ETKP016005;
        Mon, 26 Apr 2021 07:14:29 +0200
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH] PCI: cadence: Set LTSSM Detect Quiet state minimum delay as workaround for training defect.
Date:   Mon, 26 Apr 2021 07:14:27 +0200
Message-ID: <20210426051427.15945-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d355131-60c2-42e8-5e71-08d908722e0c
X-MS-TrafficTypeDiagnostic: BN8PR07MB6849:
X-Microsoft-Antispam-PRVS: <BN8PR07MB6849095E59AC2815973F0599D8429@BN8PR07MB6849.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cdG+9jxrnIJ/NP+pSx38z6bNG4qiK4eYXhQr9I0MGVKV/TP9hIAl1n56zjncKgTPwBvtIxYtQgr37c7NgVlfsyWlpH7QczV8ZQEvMon7VbhuicSIQetHRnwLAO7lb8qk1tOMm4i8gfwVXu++qR2/NDtKIV6Ge6q5Hlw2dfY4h+397KFiA3isNxPx6XrfVYvrAa4DVxVGnr7jg7qYWiURXIPV6X79pwJtO/d7olcVARwPT8iXfz0ClY9CQLa8n2Ekx/LXmziZwESK2FqkgG7qal/dxYhijvQqWr+3THAXPaU/3h1xPapdxK6ZkNsNPWm2WoKs9VNFpMPtEXUWWeRutPUhqrtima0JwC7kdLhBDa6lLZVsoTWaMVcAb961eGLi6/r80Lru3Y9f4iH70UwIxJkNwL84TC+H3AaxYGHWLNuCcTsQcavZ2VU1HdBMPdwE+ZVyCbdN+KqULkAEG5nCCkcwKA1uPg7UqiF42FEi97hjua31l/ef9PZjbM08HTAFJqP7/yR6PzIH+HkLHUVs0zLAgxVbSwHQDqIdpxxIcF6AfkX0MUXNANd7kAJNrElKtaYXDXvWFFxv+B4CPsyNN3h5/bg+qyPViqxKed9p9SAuJkACMahhoNkcSQEMXF7WRRmUzeWiwff+xZHeBIQ+nijTZdXC0XRVAy/+xF9ARxBCT5mGjWqjLFGc77JhmuiaUsWfsAuQP1NEAva8HDbwr1Bpc3l62M8RkCPzGIToro=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36092001)(46966006)(36840700001)(316002)(36906005)(110136005)(82740400003)(478600001)(2616005)(1076003)(4326008)(42186006)(82310400003)(54906003)(70206006)(186003)(36860700001)(47076005)(8676002)(8936002)(81166007)(356005)(26005)(70586007)(107886003)(83380400001)(86362001)(336012)(426003)(36756003)(5660300002)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 05:14:34.0962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d355131-60c2-42e8-5e71-08d908722e0c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6849
X-Proofpoint-GUID: zlp12qiVoFAHJvr1zroaJN_WGJizRz4B
X-Proofpoint-ORIG-GUID: zlp12qiVoFAHJvr1zroaJN_WGJizRz4B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_11:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260037
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding a quirk flag "quirk_detect_quiet_flag" to program the minimum
time that LTSSM waits on entering Detect.Quiet state.
Setting this to 2ms for specific TI j7200 SOC as a workaround to resolve
a link training issue in IP.
In future revisions this setting will not be required.

As per PCIe specification, all Receivers must meet the Z-RX-DC
specification for 2.5 GT/s within 1ms of entering Detect.Quiet LTSSM
substate. The LTSSM must stay in this substate until the ZRXDC
specification for 2.5 GT/s is met.

00 : 0 minimum wait time in Detect.Quiet state.
01 : 100us minimum wait time in Detect.Quiet state.
10 : 1ms minimum wait time in Detect.Quiet state.
11 : 2ms minimum wait time in Detect.Quiet state.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 21 +++++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence-host.c | 21 +++++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 12 ++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 897cdde02bd8..245771f03c21 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -552,6 +552,23 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.get_features	= cdns_pcie_ep_get_features,
 };
 
+static void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie_ep *ep)
+{
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 delay = 0x3;
+	u32 ltssm_control_cap;
+
+	/*
+	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
+	 */
+
+	ltssm_control_cap = cdns_pcie_readl(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP);
+	ltssm_control_cap = ((ltssm_control_cap &
+			    ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
+}
 
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
@@ -623,6 +640,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
 	/* Reserve region 0 for IRQs */
 	set_bit(0, &ep->ob_region_map);
+
+	if (ep->quirk_detect_quiet_flag)
+		cdns_pcie_detect_quiet_min_delay_set(ep);
+
 	spin_lock_init(&ep->lock);
 
 	return 0;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index ae1c55503513..ffc2dbeb1240 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -462,6 +462,24 @@ static int cdns_pcie_host_init(struct device *dev,
 	return cdns_pcie_host_init_address_translation(rc);
 }
 
+static void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 delay = 0x3;
+	u32 ltssm_control_cap;
+
+	/*
+	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
+	 */
+
+	ltssm_control_cap = cdns_pcie_readl(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP);
+	ltssm_control_cap = ((ltssm_control_cap &
+			    ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
+}
+
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
@@ -498,6 +516,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		return PTR_ERR(rc->cfg_base);
 	rc->cfg_res = res;
 
+	if (rc->quirk_detect_quiet_flag)
+		cdns_pcie_detect_quiet_min_delay_set(rc);
+
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 254d2570f8c9..d074475fe887 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -189,6 +189,14 @@
 /* AXI link down register */
 #define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
 
+/* LTSSM Capabilities register */
+#define CDNS_PCIE_LTSSM_CONTROL_CAP             (CDNS_PCIE_LM_BASE + 0x0054)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(2, 1)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
+	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
+	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
 	RP_BAR0,
@@ -292,6 +300,7 @@ struct cdns_pcie {
  * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
+ * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -301,6 +310,7 @@ struct cdns_pcie_rc {
 	u32			device_id;
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	bool                    quirk_retrain_flag;
+	bool			quirk_detect_quiet_flag;
 };
 
 /**
@@ -331,6 +341,7 @@ struct cdns_pcie_epf {
  *        registers fields (RMW) accessible by both remote RC and EP to
  *        minimize time between read and write
  * @epf: Structure to hold info about endpoint function
+ * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  */
 struct cdns_pcie_ep {
 	struct cdns_pcie	pcie;
@@ -345,6 +356,7 @@ struct cdns_pcie_ep {
 	/* protect writing to PCI_STATUS while raising legacy interrupts */
 	spinlock_t		lock;
 	struct cdns_pcie_epf	*epf;
+	bool                    quirk_detect_quiet_flag;
 };
 
 
-- 
2.15.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832953945A8
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhE1QI3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 12:08:29 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:7028 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234961AbhE1QI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 12:08:28 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SG2j2o005736;
        Fri, 28 May 2021 09:06:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=gHZ9Iu3ccEMmn30HuEQAEKVkFL74/b4lMa4yUG+YYpk=;
 b=KZSnyRVr9srjCi89eXUKB8z7ZEsc7+s9d9gaZ8sxsRdt9xyxSN7fe2f29JbzxE7m1boh
 wVi5/2vWIoGwLctjnaf5eJZ/PECAkd/SZRmAhjwSMUksiwJ1wkn4IhCVlxSr9W8OFZI3
 IwNpPLzIjYu4gUiUB3kXMJm76qWm141m4Je2wOrh7eZky7z+9ci5k5Fwzm1WB+HcwlJs
 q9PE6PVLim1JnQle3NkZKd37dnqnEjJsMRaugkIrEgyq27nAjJ360/0MMhCM/JXySSSu
 qSAvc/PTuDcbkm+VaijNmQ97g93cdZwYG9e1FR1GE7SbwYcC5N5lgU6pSv9ZwxDGDESf yA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 38tvr5s9r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 09:06:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijmibxsY5QiMMrIBq8dQL99WTrW3i6j+kKXZydva3J9Gbm5+JRlY1azAx/4Tj43Zz/BYoztb/5VoGmaT8EyCs7neI8Afhv6OE4zArNC2bvujxak2xlF4VrgTHupFAL0mIHl5f+4AnO9KCE6sfz5iFdXsLbdFsnlc7hFCOZ8BeN2KYR+A5Y+9Cif9SEOIemMHqMWMfciqp+UOZdug3MhRcouXfKfuEhmwVe4+4Egw8DLi94PDb7B2EqrUNk8psJlsyuxmz8gNvJRfHNEcCKg+aiCqSKKFbVlrpAI/GYp9tS+bd+8vGwszStfvqIfyAejw+jwLzKCqVD27iqaef08wOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHZ9Iu3ccEMmn30HuEQAEKVkFL74/b4lMa4yUG+YYpk=;
 b=BREs9fzLFE2cjMQevwNmCIveOXuSQ/uobAMo+nI/wxJ/3h43Ygcm27OsVaIKhBsRP/YgtEjbHpPW475GWcpQKK2nu71VWZhPJWmvM+Wyl0mTbL4nSIXEOzNJx15QwzivpEpvZ+ujK64N7Wbt6a769vOea5mVaca1So5Hy2P12yR6cJuE3EwtDZCGvTPcqbDjf7GyhQ0ak40jwLX3EuTNPeHIV/mc+ta4IQ3kF2oBWs6c91sZU0QvjNQEJaZMTdg//WOuhDZJTEBOEMc+9JkbvGu6NjWszrWU4f6Y6TkLVBUCzDpfRy0LJuKy8PC4tD5LvjM5oZk+Jip8BBgJr+76yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHZ9Iu3ccEMmn30HuEQAEKVkFL74/b4lMa4yUG+YYpk=;
 b=2evannYjRz9PGGJy/TPKd2sytfjk1iDDGvvcJsDgS43fDRfUWdxeh41KLa+SF6CrNyRLIqS6kILiDtA+FQ9+r4LOFuhMskjeOcHbuukenugUNnS9SXXBdjjUEHH77lR5TTo8ckOQcyh5sE4ke+XX/CKVX//gwoNLOpMihsO924E=
Received: from DM6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:5:80::33) by
 BY5PR07MB7201.namprd07.prod.outlook.com (2603:10b6:a03:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 16:06:38 +0000
Received: from DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::b2) by DM6PR08CA0020.outlook.office365.com
 (2603:10b6:5:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 16:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT004.mail.protection.outlook.com (10.13.178.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.10 via Frontend Transport; Fri, 28 May 2021 16:06:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 14SG6ZtH024608
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 12:06:36 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 17:56:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 28 May 2021 17:56:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 14SFuXhK021841;
        Fri, 28 May 2021 17:56:33 +0200
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 14SFuXV3021840;
        Fri, 28 May 2021 17:56:33 +0200
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, <kishon@ti.com>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH] [v2] PCI: cadence: Set LTSSM Detect Quiet state minimum delay as workaround for training defect.
Date:   Fri, 28 May 2021 17:56:26 +0200
Message-ID: <20210528155626.21793-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe31b47-4e81-463f-8239-08d921f29301
X-MS-TrafficTypeDiagnostic: BY5PR07MB7201:
X-Microsoft-Antispam-PRVS: <BY5PR07MB72010AD6B8045356409F8497D8229@BY5PR07MB7201.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7Qxd6fbQfk8Anlk4VO8FiTRi1rn+jq4dFs6xNpl9RmANth1O+y9ZsbYRbSh23c40+Cu4b5XlvAc+9Sw6baH233LluZZsr6UoQd58BiWUxpoaxPsKmHDk9w1dm1BdzKeXu2uZPKlvZ4LWVrPTrt0KfIt3am+5SPeC18h6rUnJApMoRm/hshHPmSiPNieJj/g8dEBhf4MrDFNGpo/1vLOLvtIifIXNxuo3fGQ4SEeu9Kt39I5c0eBtj+1NkY4HkyIdrnnGPYismTtvRAddF8MKWpZaPyLg3wkttbrQlL4g3RhX4KHiaLdrQxXLGIQRIwo5I3Kr3RtA53DmHaQVW9ue0u4gPLh5BuHhiKM675MdgvT/vrjhPOhuDjzZ5t4d9R1hYAFqC9CyMJA/xw4TdCBTG0mtCLESLHvw/r8jzmgnhEUURxa8alhrB7Zs/lVPLvH3vVSbNau71tHc/1/JViktSNkt24jaQtLFM2cR/3WCCY2EloWmVt5KZ58NrLmJWwl/v6wvWAOF7V3vYgYqb9QVcfGg/MzFeGZ0QkkH+S2sHPMhwkMONdZ8ddeN8I//66Nk4Pm/DLKTn9v/ImCoJ9ziFHr/DWnzfXDhPfU35HZp1NqHDIlyS4+aeA0F+AhWt50Bl2bhm3YD3q/hg6j083XARHyA6ZluIomPaeZcWT3c7S0lcSrh48sLOdje/Bt5S1ii1Uk9WVV9SwV3e3WsPsKkLFCGnkS/5LXZ9GdgUfIPPk=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36092001)(36840700001)(46966006)(54906003)(36860700001)(86362001)(81166007)(110136005)(82310400003)(83380400001)(42186006)(107886003)(8936002)(36906005)(478600001)(6666004)(8676002)(316002)(4326008)(82740400003)(2616005)(336012)(186003)(26005)(47076005)(426003)(2906002)(70206006)(356005)(36756003)(1076003)(5660300002)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:06:38.0978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe31b47-4e81-463f-8239-08d921f29301
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7201
X-Proofpoint-ORIG-GUID: e2VP9pdL97n3F1KRf40RjjZApdOlerMD
X-Proofpoint-GUID: e2VP9pdL97n3F1KRf40RjjZApdOlerMD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_05:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280108
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe fails to link up if SERDES lanes not used by PCIe are assigned to
another protocol. For example, link training fails if lanes 2 and 3 are
assigned to another protocol while lanes 0 and 1 are used for PCIe to
form a two lane link. This failure is due to an incorrect tie-off on an
internal status signal indicating electrical idle.

Status signals going from SERDES to PCIe Controller are tied-off when a
lane is not assigned to PCIe. Signal indicating electrical idle is
incorrectly tied-off to a state that indicates non-idle. As a result,
PCIe sees unused lanes to be out of electrical idle and this causes
LTSSM to exit Detect.Quiet state without waiting for 12ms timeout to
occur. If a receiver is not detected on the first receiver detection
attempt in Detect.Active state, LTSSM goes back to Detect.Quiet and
again moves forward to Detect.Active state without waiting for 12ms as
required by PCIe base specification. Since wait time in Detect.Quiet is
skipped, multiple receiver detect operations are performed back-to-back
without allowing time for capacitance on the transmit lines to
discharge. This causes subsequent receiver detection to always fail even
if a receiver gets connected eventually.

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

Changes in v2:
1. Adding the function cdns_pcie_detect_quiet_min_delay_set in
pcie-cadence.c and invoking it from host and endpoint driver file.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  4 ++++
 drivers/pci/controller/cadence/pcie-cadence-host.c |  3 +++
 drivers/pci/controller/cadence/pcie-cadence.c      | 17 +++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 15 +++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 897cdde02bd8..dd7df1ac7fda 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -623,6 +623,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
 	/* Reserve region 0 for IRQs */
 	set_bit(0, &ep->ob_region_map);
+
+	if (ep->quirk_detect_quiet_flag)
+		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
+
 	spin_lock_init(&ep->lock);
 
 	return 0;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index ae1c55503513..fb96d37a135c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -498,6 +498,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		return PTR_ERR(rc->cfg_base);
 	rc->cfg_res = res;
 
+	if (rc->quirk_detect_quiet_flag)
+		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
+
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 3c3646502d05..65b6c8bed0d4 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -7,6 +7,23 @@
 
 #include "pcie-cadence.h"
 
+void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
+{
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
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 254d2570f8c9..ccdf9cee9dde 100644
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
+	bool                    quirk_detect_quiet_flag;
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
 
 
@@ -505,6 +517,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	return 0;
 }
 #endif
+
+void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size);
-- 
2.15.0


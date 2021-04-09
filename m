Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01173594C3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 07:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhDIFj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 01:39:26 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:1978 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233282AbhDIFjV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 01:39:21 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395Zcne013343;
        Thu, 8 Apr 2021 22:38:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=L0KvZBRLxFRLslZaffXIa15K98XhvoreYRzt3SkpK58=;
 b=MEgmmE94lTQFqX7Eoy+0adW95SgF+w4OemyFrcfHUgn0Bdq7KxNTItr9UCq3TJXSaX59
 gwgfvOruoKLpfG5XwOEIpniNp/5BUTHh6/Fsmq+Bp0FWzJHxju9ab0OSX5L7VoVQCUTm
 PUopFmzY9qh6jENqCXlo7/XlU5RL98K+oJ2NzZsQ9XoIQI3kAYsOnY7KDFlvHlxm2Tla
 NlEdnBUoQJOTJoFlZblIad1ZGpUkwTWQJpZDkuHeRMxKil2oA/8lmWPWB2O33Jd4QMGn
 VQ535a5z6gB/eV0YAS8HeLE+aQIizjQZCvdXZGKZAMjbvKQtIdf4TvPPblnd+H+UYSZq Jw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37rvb4ttvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX/gps9xPdmeQ7aeNKC1XfVqZcagJyuHlkDkeJTzFyIoDFIepbe9a50i8CyTVhanEoiEi/Lg/UJQM1lRVzAdNt8vJUaVyVcuxtzkkKJIZGSvx+8CtNx/7mx2R9wFyCmcx/J3MN93y2Dy/piF+AiMrO95clkM9ITEHnhOu8+tmYjVf/iqGo/Qn1D0LCn3WudtuAIxn43VHE+w7kifqmozFmH61Rbco6KQ54U8SqXlP4YK151EaZ3Gcit+lwBiWWsP3ZrUBEf72QGfLKatpR1lu+sbQ6j6g6txqzyD5kyxj44lULmz+v1S4aLWJSJncd/i3jjj38zjsMOtzHB/spsqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0KvZBRLxFRLslZaffXIa15K98XhvoreYRzt3SkpK58=;
 b=LtSHsj+zdb5IpGr2+uTRYUL2wcXq0vBBzqWEB7y8LsOgMNYgu4FboHGEg1wcRyGLiTeoNkDNe04uimYAIaNlJSgCKiiQDfkO0afvhJ/F1jWA7deeBuwR7ltlWRt3ZBXu7L+GMyiok7McanQVrxmMZGUBh3eIL7sDqe54akp02WiFYiwIYLmxSE0+cdrlE0cmDugUh2dF1MGX0q19QFHIpvElw/X2NTTqijqK+hfPEznK7cOZfssOTXrq6J2hnZBMWW+qaTC51wYnqPtIzZaQZDrqs+aCe0cyhGZfWZpxhntU+12RtksC7ySsTzF3W7jklYRQk+00a8cKz90KPwEIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0KvZBRLxFRLslZaffXIa15K98XhvoreYRzt3SkpK58=;
 b=kcuV0tYhvtCy/7llJRQZlTxHshn8uUp44WQoH5+gqUruAIxmN4VoYIXqteZzFPh0dJI3cRZR4Jgt/v/24zPq6UPmd289k0HD/Su4IPEntrxyeTlZGUiiktWwwfclU4clhOchuyH3cJmdN2Q+55UfYZMUaUT/+G6Us2uQNGRIO04=
Received: from BN0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:408:e5::18)
 by DM5PR0701MB3637.namprd07.prod.outlook.com (2603:10b6:4:7d::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Fri, 9 Apr
 2021 05:38:36 +0000
Received: from BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::b9) by BN0PR02CA0043.outlook.office365.com
 (2603:10b6:408:e5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Fri, 9 Apr 2021 05:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT068.mail.protection.outlook.com (10.13.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:38:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395cYkF030194
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 01:38:35 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:38:34 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:38:34 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395cYGU029570;
        Fri, 9 Apr 2021 07:38:34 +0200
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395cYnB029569;
        Fri, 9 Apr 2021 07:38:34 +0200
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH] PCI: cadence: LTSSM Detect Quiet state minimum delay setting.
Date:   Fri, 9 Apr 2021 07:38:32 +0200
Message-ID: <20210409053832.29512-1-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb969d9-4af8-44fd-09f3-08d8fb19b8e5
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3637:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3637C0ACEC3BA151B8295E3AD8739@DM5PR0701MB3637.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwl6Fdi5JnPRwRcx/L+0oau9G9DV31yruYvXzDJQqnyO1P2jEUzp1nAa3WEJ193czWpgHYMblr1lFtr8IxZSh7PCnnHzBnHBNbDg+wHonmcf6XiH3LTG5WBhzQnE6gL+8WQ7vqu9jwGs8tWg5Q/6Pl3jkeYAhCn2+uIjk9UiPmMUeadzwlbJHTxd3UOIiSQpiG4C0QnT3Ux+x4kx6hXuAZz37l2MRsMp5XYzGxBaHaSys1cT93A3bphaeE8QzM32sWwulILvG+Mo1D8XjtqxMjxTWQk00PuEiJz8IIP68IPoandw6g2dLv/Z6s7sdZ0BO1fQkbx+U4nJYR245n4kQ8o3HAacx+7Hbw03WeXsnHznKkwMI5XVi2i6dRpfWYKFuqibf7meHaMWXsk5hRBoSuUfNcJ7z1pjL+9/990sKbmt/sL+wkzoB+74thhni66wnBoR4pC8JY3LRB/ERsbhWKRJp4C4/6gd1b9HQG83H0v8LF+cmp4vebMn4R/8ncFJpoyZNz38dLR1PJHlSZCdawCHvmaATipHBKck1zl1FGNFCGwXedvYkNjJs6B9jgg3tI8YTFaG/T1AFvm6CDDAjZ8K6ahguQu8F82xVigeCNEoayDHdvIEDCFVgHo9UpM8qUV0+UcixN8QK7qeoBKIKnugZ3g3Sv3bz9pZyJasXRVrYACstOEJV9wyxtC4GVo6Qs29DNNH3XsmcQla111gcnxdHAYzDuZoUN2ynyHQe7g=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(36840700001)(46966006)(82310400003)(356005)(82740400003)(110136005)(70586007)(478600001)(2906002)(316002)(2616005)(86362001)(36860700001)(81166007)(54906003)(26005)(4326008)(8676002)(36906005)(42186006)(107886003)(336012)(8936002)(186003)(5660300002)(83380400001)(36756003)(47076005)(426003)(70206006)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:38:36.7437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb969d9-4af8-44fd-09f3-08d8fb19b8e5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3637
X-Proofpoint-ORIG-GUID: zM8DN_eXVmqD1N9ngvK5bMTycTjear3X
X-Proofpoint-GUID: zM8DN_eXVmqD1N9ngvK5bMTycTjear3X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104090041
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding a quirk flag "quirk_detect_quiet_flag" to program the minimum time
that LTSSM waits on entering Detect.Quiet state.
Setting this to 2ms for TI j721e SOC as a workaround to resolve a bug in
IP.
In future revisions this setting will not be required.

As per PCIe specification, all Receivers must meet the Z-RX-DC
specification for 2.5 GT/s within 1ms of entering Detect.Quiet LTSSM
substate. The LTSSM must stay in this substate until the ZRXDC
specification for 2.5 GT/s is met.

00 : 0us minimum wait time in Detect.Quiet state.
01 : 100us minimum wait time in Detect.Quiet state.
10 : 1ms minimum wait time in Detect.Quiet state.
11 : 2ms minimum wait time in Detect.Quiet state.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pci-j721e.c         |  6 ++++++
 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 21 +++++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence-host.c | 21 +++++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 12 ++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 35e61048e133..40ebe698e179 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -67,6 +67,7 @@ enum j721e_pcie_mode {
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
 	bool quirk_retrain_flag;
+	bool quirk_detect_quiet_flag;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -284,10 +285,12 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
 static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.quirk_retrain_flag = true,
+	.quirk_detect_quiet_flag = true,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
+	.quirk_detect_quiet_flag = true,
 };
 
 static const struct of_device_id of_j721e_pcie_match[] = {
@@ -394,6 +397,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		bridge->ops = &cdns_ti_pcie_host_ops;
 		rc = pci_host_bridge_priv(bridge);
 		rc->quirk_retrain_flag = data->quirk_retrain_flag;
+		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
@@ -460,6 +464,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
+		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
+
 		cdns_pcie = &ep->pcie;
 		cdns_pcie->dev = dev;
 		cdns_pcie->ops = &j721e_pcie_ops;
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
index 73dcf8cf98fb..0ed2bfac4855 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -461,6 +461,24 @@ static int cdns_pcie_host_init(struct device *dev,
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
@@ -497,6 +515,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
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


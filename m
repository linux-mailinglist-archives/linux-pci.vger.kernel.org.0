Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943E5331FE0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCIHcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 02:32:20 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44938 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230401AbhCIHcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 02:32:01 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1297UBpl014277;
        Mon, 8 Mar 2021 23:31:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=t8jj5Dj4GUh8iuzyleftFT1N9JH8R3nUBXBaiG6dlYc=;
 b=NM98ZazsOBKLFPGXKDekxtT+IGT8LvzlMqJd6aaOV2IaiNH13ucOUzf769LsibTKjVu6
 aaA31TKhCGsIHxcU/B9718fwiaYRFE/XHY+AU+vXby7FB79qeSGX4gYx77SLKfxl3VE4
 j28AybNN7kX/G++3M0Wxs58iMgiFBgygdREqblNtQp9zP/QJxTIcvQ1WzJjn0DCLNI6A
 DaqS6No2UKrU7oqFffM6hq+HEVRGv8K7iBFWqjX7mUNnjhFZEAmZBatsODaZkrSQ2PTx
 cNAf8PnwK4qNhoiq1cwlbhkWIxiMgPzlIzuuZLWew26/O3/sKbGlS5zUK3ki6GAwOZbD CA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0b-0014ca01.pphosted.com with ESMTP id 374674yyfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 23:31:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRJtLDFMixiW5fT9aRPGXMo4t7b16osGm5NQPx+HKk+XogBiW+r92BZOC7aeSiy55tG/Zx6fD8BIkfVcb4k4h+fLBuy+pXrEQFUM+MxxOB352fpaliZujfHJ48udVcsZD0z+THyBXqs6u1oqHS3qIdV9FGq4wSJdebVZKSwLd+GUKGO1WVKpVfSHgyARJdlKdwNrG5nodSU5azx52ZC5oF3arLI9XDlAwxxQbsgWgJSklPtSp2cc/9gBHVJrOlKYlglRx3+Omf669i0Fv35SX3OwTP2cVMOd/O2PLbPx0trrgb8CpS4cxEhTUbX9jqSNj8DWGrJXZWaRbG0bPoNZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8jj5Dj4GUh8iuzyleftFT1N9JH8R3nUBXBaiG6dlYc=;
 b=eN5+VSyRH7ZqHU0jPRZNKHJE0Rc6W7g937ukMkQw0iBAsMgt+ueWv0782SNl3mNhxSL5POZRtEWQczbCRyj66Gc6fjdw64GDBo96FjjiNr1jP3aHdmBR1wXBB5HwkjcVItIheyhseVELS59k28gyqJ1vwZl3lODRoTA6ftbzn8hmYxIMFYLG2iWlMuBMfvThkQ98Ico9yJD78mapL/rrqkLXURgVQvA5iC3M/2TH9VMO8v7pKqS9C6aAZFJN+xIPCJvqc8cSm7ubNv0QacpBjN1eiYgne87jMolxn3uEUOgqb4LE2sPsTmrCN0RRoHCcuV/27G2LPP0xvxv4skIcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8jj5Dj4GUh8iuzyleftFT1N9JH8R3nUBXBaiG6dlYc=;
 b=R7WJWrw72pYX/7mBf7UIwmDBHjPYGoGUoQ2hEgNDSuswcYUXwe99jxjX/5MLcXpXjPRD+7jjsStnk+xBarY+ykpq9b3Ghy3ODVg6Yh9CLe0SF8ghTpzSv8sz6jbAiyWQIjiIO3UDCpM7G73a89NNWGivq67JH1mEu0QvLrpfR7c=
Received: from DM5PR07CA0033.namprd07.prod.outlook.com (2603:10b6:3:16::19) by
 MWHPR07MB3534.namprd07.prod.outlook.com (2603:10b6:301:61::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Tue, 9 Mar 2021 07:31:48 +0000
Received: from DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::10) by DM5PR07CA0033.outlook.office365.com
 (2603:10b6:3:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 07:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT012.mail.protection.outlook.com (10.13.179.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Tue, 9 Mar 2021 07:31:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1297Vi7t003118
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 02:31:47 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 08:31:47 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 9 Mar 2021 08:31:46 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1297Vkbx013299;
        Tue, 9 Mar 2021 08:31:46 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1297VknL013298;
        Tue, 9 Mar 2021 08:31:46 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kishon@ti.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <nadeem@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH 2/2] PCI: cadence: Set LTSSM Detect.Quiet state delay.
Date:   Tue, 9 Mar 2021 08:31:42 +0100
Message-ID: <20210309073142.13219-3-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210309073142.13219-1-nadeem@cadence.com>
References: <20210309073142.13219-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e7bb356-4787-42d4-0605-08d8e2cd6610
X-MS-TrafficTypeDiagnostic: MWHPR07MB3534:
X-Microsoft-Antispam-PRVS: <MWHPR07MB35348ED624FDE785F0131AB3D8929@MWHPR07MB3534.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7V25yECxpKwh5+RTb9YMiJIJHvCNYCq1rsegJXHH7ImhptstPPABjhbcjXnYrJhK4msR9ZY/CNNmXMsKPp8g/pLzcBtGaiUK+/gt6uY1oip9+8ithAxKAYFhEFOEfPi9LKyQn/AK1DJdmLSkiZSraTTwwE1xLxHxlC5Q7JXkHeQn4aDSLBdufjXUwca987QytxZ5mahiiKs6jvjhpDbYlPY1HAsxSZQhDOB/OO19b0KChMDr8PSL9OGALY3RLlhdOMsBnBCOykZMwNEw1S5qNOmE0aRSbmYGNX+8ZFW/FYWWtOq+Wfa3WTAqNeGD62yLAbMRUIBHrZrwEoNi+fFU3550ReYprxCRAowKzWSVnTQeky03CaK/wVbU04cVN1vc9pEECkL+b4qA8cY/ayNt0dE3HhMwgEi3lddFy0cXsj0kKWAy9YNkG+vBIuSiBMWYCGEY8N10SdJZYzhydP9eseOvdI9JSyYnizrzPi1LcJxPhxr4DB2PQyHGklq1MAYGcNX7bTxydwBKpgXi2U1fPTwT+YvP1wLPd55/2FqE3RLUvjbr6yt9U29AOngJ64saO70b1Bb2vqjRk2bFCnc3JnoUJbkH7Fh8RfF6Mrwio1kZIRG/S+iDgQXRq4IIjpxGOr7EuWodzZqjxQ3lELSb3XFbfIxYQaWAJYSzJ/K+QpaVcDnHUyWO1P8BxAJOfv0j9nj/vTTaCofTkKAMExAd26r0dOGmEE4NIZd3VTTo2M=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36092001)(36840700001)(46966006)(186003)(70206006)(70586007)(47076005)(478600001)(82740400003)(26005)(110136005)(2616005)(336012)(81166007)(107886003)(4326008)(54906003)(83380400001)(426003)(42186006)(6666004)(36906005)(316002)(86362001)(8936002)(82310400003)(36756003)(36860700001)(8676002)(1076003)(2906002)(5660300002)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 07:31:48.0704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7bb356-4787-42d4-0605-08d8e2cd6610
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3534
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_06:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090036
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The parameter detect_quiet_min_delay can be used to program the minimum
time that LTSSM waits on entering Detect.Quiet state.
00 : 0us minimum wait time in Detect.Quiet state.
01 : 100us minimum wait time in Detect.Quiet state.
10 : 1000us minimum wait time in Detect.Quiet state.
11 : 2000us minimum wait time in Detect.Quiet state.

As per PCIe specification, all Receivers must meet the Z-RX-DC
specification for 2.5 GT/s within 1000us of entering Detect.Quiet LTSSM
substate. The LTSSM must stay in this substate until the ZRXDC
specification for 2.5 GT/s is met.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 22 ++++++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 73dcf8cf98fb..056161b3fe65 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -461,6 +461,20 @@ static int cdns_pcie_host_init(struct device *dev,
 	return cdns_pcie_host_init_address_translation(rc);
 }
 
+static void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	u32 delay = rc->detect_quiet_min_delay;
+	u32 ltssm_control_cap;
+
+	ltssm_control_cap = cdns_pcie_readl(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP);
+	ltssm_control_cap = ((ltssm_control_cap &
+			     ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
+}
+
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
@@ -485,6 +499,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	rc->device_id = 0xffff;
 	of_property_read_u32(np, "device-id", &rc->device_id);
 
+	rc->detect_quiet_min_delay = 0;
+	of_property_read_u32(np, "detect-quiet-min-delay",
+			     &rc->detect_quiet_min_delay);
+
 	pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
 	if (IS_ERR(pcie->reg_base)) {
 		dev_err(dev, "missing \"reg\"\n");
@@ -497,6 +515,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		return PTR_ERR(rc->cfg_base);
 	rc->cfg_res = res;
 
+	/* Default Detect.Quiet state delay is 0 */
+	if (rc->detect_quiet_min_delay)
+		cdns_pcie_detect_quiet_min_delay_set(rc);
+
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 254d2570f8c9..f2d3cca2c707 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -189,6 +189,14 @@
 /* AXI link down register */
 #define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
 
+/* LTSSM Capabilities register */
+#define CDNS_PCIE_LTSSM_CONTROL_CAP		 (CDNS_PCIE_LM_BASE + 0x0054)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK	 GENMASK(2, 1)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
+	  (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
+	  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
 	RP_BAR0,
@@ -289,6 +297,7 @@ struct cdns_pcie {
  *            single function at a time
  * @vendor_id: PCI vendor ID
  * @device_id: PCI device ID
+ * @detect_quiet_min_delay: LTSSM Detect Quite state min. delay
  * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
@@ -299,6 +308,7 @@ struct cdns_pcie_rc {
 	void __iomem		*cfg_base;
 	u32			vendor_id;
 	u32			device_id;
+	u32			detect_quiet_min_delay;
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
 	bool                    quirk_retrain_flag;
 };
-- 
2.15.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34393151F9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 15:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhBIOr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 09:47:56 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37370 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232250AbhBIOro (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 09:47:44 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119Ebot5014140;
        Tue, 9 Feb 2021 06:46:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zWrVEGuowaumsucHSvd+LQ+8x8BQqc6fHTRt9z1+hu4=;
 b=gSpuapw6gAq4fgph68/K6tR9LlulcP5HkyWat451qSBfm8L6zgITLyPUMSeom47h/zU1
 +CBgWqWow0Md3J6soN2RoyzhnSdm7usTW6d07A2zdq+mmmm0otrsTooZDL6Qo8F2V2Tc
 TV1YQ9FlIFHAm1DV4hffwlO5dYEoVzTN+xY0233f24Pt6ZMlCXzH0RjVSyZ2AjzYS3Bo
 +51wWmAmq/YGfCqm/SYQmuWXNjomMyYStoij9WqAsutsCL8us3BJ5Jmw4m7KknQvyCN3
 zDa9wZ/ehdlL29IOI85J6kM4ne3wqds+0XK1/n3kYwpCVLRjp+x07/xA2e4qxcLtOiyV og== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36hrku0ng8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 06:46:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuDdmWCCg/qZ9jO0fwMdpTtM+TZYqKdVdEW6Eb98S/A3hfXb+ImHRowyD8J+Y/PB0JUQD4+k87/4n2t/59CXCNuhv2x5RjEoo6r2/jL0LYHHREFbBxtqXY38nC+TrtDnNgQNBqGjZjxEVswrmGOHTC46gx1B1fC1+RPv1E5l/wEIFUxVbWbFo+Sq+j+AMO7rJAucC+mUfKSe32cBksK/d3grwqtgBrNWWIJhBtKHrKqwtKtWPEbYTmQd26xvyEJZ1wOSnPyV1YWKWejU5XLXgPboG7jleWJ0mLfERvjnDJlYSM+MoT0HrwJSiydMskAfWXtZe7iM6lGM48Iw+d0/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWrVEGuowaumsucHSvd+LQ+8x8BQqc6fHTRt9z1+hu4=;
 b=H63/uxl9FCHRyb2+AwZMSgFOTf3vad75mULOhH1x6JkVjyhTsmcaa8EYGTfz97bCqcR0R2Q3VFXwOHkyCtG5StFPuIlCLciAD9INFTBa6z1Yg6Jn3ysXpO0kUfjg3zbeR7zhOs98TTMudmiJbcLkMZIATewnqFltoFDKNU11Nx4jCP36M/CmmeRQNEDgCYisPgkLMlhO8kzlo7Lu20/mEsOPpa2QfOldtmNYN/IiAcnEBdaURpEoEHdK9GZF1d1XPV00LbcHD5MilwUjJoFptelPpEca0LzcSwwBQ2Ce/EYV+Xx7EcsTX8+Ji+6FzRlOxUMc2GmgS/n0aYDUqzGwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWrVEGuowaumsucHSvd+LQ+8x8BQqc6fHTRt9z1+hu4=;
 b=iYFw/VzAH71IT7liel9T8KFm/uGylGRehl7y4WzJKawQpGk8Q/iqa7S1z57BRsN7PQzAJQ+IUCsSILNSwCWI+hIvWEtqL1qebuevl+4DygDb8oN01iovvwQj7F/AfBJtk8X3HLrt8i2+qitADZqSwXqtoVvDALIaAm4DZvxlXD4=
Received: from BN6PR16CA0025.namprd16.prod.outlook.com (2603:10b6:405:14::11)
 by SN6PR07MB7936.namprd07.prod.outlook.com (2603:10b6:805:ec::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 14:46:34 +0000
Received: from BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::21) by BN6PR16CA0025.outlook.office365.com
 (2603:10b6:405:14::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26 via Frontend
 Transport; Tue, 9 Feb 2021 14:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT004.mail.protection.outlook.com (10.13.183.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 14:46:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 119EkRwH001420
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 06:46:31 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 9 Feb 2021 15:46:28 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 9 Feb 2021 15:46:28 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 119EkSd9026767;
        Tue, 9 Feb 2021 15:46:28 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 119EkSAg026766;
        Tue, 9 Feb 2021 15:46:28 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v8 2/2] PCI: cadence: Retrain Link to work around Gen2 training defect.
Date:   Tue, 9 Feb 2021 15:46:22 +0100
Message-ID: <20210209144622.26683-3-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210209144622.26683-1-nadeem@cadence.com>
References: <20210209144622.26683-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 618b385a-d044-4a92-a1fd-08d8cd097e38
X-MS-TrafficTypeDiagnostic: SN6PR07MB7936:
X-Microsoft-Antispam-PRVS: <SN6PR07MB7936BD97F8280957C4396FDAD88E9@SN6PR07MB7936.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWk+gpNNt0oHC+SDqTnULp9endJzsH9Z7/dQYXkgz8sFiZReMbFJkC2+oFhSRBrxxFmx1w/ST6RrQ4xe5sMcLKpRqsr7x3YxSkLwiDzCZztZ2dcH8SkirWe6F0b8V1bzK3yzG7kyRn8cK+mPx+Y+1/+966Taz6EiyzqykeNaHRqP4WDyJMXmPvvyF6HP+jjhSRWResFrzBhMkBMvJ2IzmuT2rNCb6hoOlEuqxzvxaAWxIZIrjApFBkP7IvNcOXfeNtLWdPVKbFtmeDEAeKgPTqdBPfaRKj5C58l2XuRuF5DvCfW+HOiiZZreIAVDHDEZBHrQ4hYpoVfzModnRtx5PhPIW2rAKRhgJ54bkkA3TmCfgn4XzG6umQ7jz1o7g7+Gxp3TgKg2yQXcBRMi0WpvMRYB4ZO0AMsE6E7IEHT17JK126nyrMASBCh7c8txGEG7e/2UrBiFpcFh/OD+Tfdia1WLQq0CaFienG4cW35snrbTXciYjDV54L7PqgevpXCNeI9hZceDM7Lm9ka4yPcmB/q6Sk7TtpLll2nvbtazY5AijRD4l8QvibEvo6jzzHEBqCO/vVVidoCK+1VjMsetO9kHSeVGBpkakTk97/85SLUaEqMZobpCC+zcbSw6SmGDMx9vwSuVt8dW/8iyf5GfyofyqglR6Gg3hUFNdNUdtKb5pr0LZ8tM6iwXxEm1pKpnaiwUOp349uZ25gP2yR5qm22pruS2KdXAIEfSE2Xnq316nd+VgPm5XWlWKwzXjAS+
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36092001)(36840700001)(46966006)(83380400001)(26005)(42186006)(107886003)(6666004)(82310400003)(2906002)(336012)(186003)(1076003)(81166007)(82740400003)(426003)(478600001)(2616005)(4326008)(34020700004)(8676002)(54906003)(36906005)(70586007)(86362001)(356005)(47076005)(36756003)(36860700001)(316002)(8936002)(5660300002)(110136005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 14:46:32.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 618b385a-d044-4a92-a1fd-08d8cd097e38
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB7936
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102090076
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped
as Gen2. The Retrain Link bit is set as quirk to enable this speed change.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pci-j721e.c         |  3 ++
 drivers/pci/controller/cadence/pcie-cadence-host.c | 48 +++++++++++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h      | 11 ++++-
 3 files changed, 60 insertions(+), 2 deletions(-)

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
index 9f7aa718c8d4..6f591d382578 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -94,6 +94,52 @@ static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
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
+static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	int ret;
+
+	ret = cdns_pcie_host_wait_for_link(pcie);
+
+	/*
+	 * Retrain link for Gen2 training defect
+	 * if quirk flag is set.
+	 */
+	if (!ret && rc->quirk_retrain_flag)
+		ret = cdns_pcie_retrain(pcie);
+
+	return ret;
+}
+
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -456,7 +502,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 		return ret;
 	}
 
-	ret = cdns_pcie_host_wait_for_link(pcie);
+	ret = cdns_pcie_host_start_link(rc);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 30eba6cafe2c..254d2570f8c9 100644
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
+	bool                    quirk_retrain_flag;
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


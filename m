Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C22E7863
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 13:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgL3MGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 07:06:51 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57346 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbgL3MGu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 07:06:50 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BUBvo8h000440;
        Wed, 30 Dec 2020 04:05:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zgZarCOIM1K6Igur7Gd75slQJax4EHskq/GWThyLZzQ=;
 b=Ch077n3ODvnJTIzc4SRjHrGOhScIcPgIlAkNzB+l4xW49PJJbcAuF3eL8WTOXO/0lpJI
 TPFTAvRgammebtJzgxoRSzw2nvSUR+MlvelcMUiXzF6m9J4gbpTJJ+LE8qSZM/WCTVoT
 Zqh5RMzQqBM/Z1H62keGZEXRkIRBZskuysbBC+g3kKJlQ6MZUqnzTwnND2cBMubvcrOV
 H0J9c6lXm4QO0eEF0J17IBpHwPmpkDaQ7reB36muAXmr4H71ax7wqypgr+2ySegoovi8
 GPRqpQSlufOUGnFyCjeZ47pOyz1OVTz/ogctPTQIQ14sZC5fmASrRQd5bp1PnnqcWSLK SQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35p2m1fh2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Dec 2020 04:05:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1VFaFZXHVpzcRr8l/YfaLACBhvoc1A7QObMknweHbH5wo1bLle/vT/twPVfJ+59IjmB1FLzfUWzS9LmKSJXik+jdDLe5hE8E5Ko+P+7okzb1J1A2P6PYoKyun5C4KDZar+1IhwoHC8Neh1BJTwYhZhohtL6fUnhQAw3Rp7D9DMj/dK7WZ03lGK5gkIfD2Rcx/CsWHy7ASIp5qCTuQnVYAmkPcL6JmFJIovFZDpYpq5NeIBq1wV+65syoV/0oXTR/ZfzCdpU1eITlqsPWekdEqoQUq1FNMSon6+4XF/OWeYaAaqtVTwzmZ+VO7nBnWtMCYvknXVYWZUcKCFkRt1lpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgZarCOIM1K6Igur7Gd75slQJax4EHskq/GWThyLZzQ=;
 b=k7dyq2EUJFhWAWj5Y1rkuYaKRw1fpso6czTRDvVyPRuxDVy6f2kVxvfKbWG+LU+zxOlSjJPSrJ2rtyLEqACAy0NyvImp+nAEVC2sApeI47kN8RjT3/EnEvpcmblWFDgM1jLxA9ns0b5zavLUv65z5aMMdZBo1gNG2MfTojB99iF4UKFnGuFd1YO6PdVyjZq/aEH2CyleB+0P9qOVWona6y7n6aj0TL9gtZqJ074vZpauyO8lfhPXUfdbtMzjc6jZXuIl6+18d56eR8MHU8/bmn4MlY9edyqXkJzJIKPLagedOS1KJZm8yAlki8zDMb2MbPUdqRWVKfK/51p3ZYITbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgZarCOIM1K6Igur7Gd75slQJax4EHskq/GWThyLZzQ=;
 b=NasyxSSKMA5lUCZG1D4SKB/Vu9l0+rvqPpqtsacV2nDFfSZ5wYmbjTsCOR+2abFNzJ6xqHhNf7Tws3/INVKYC6FplhIn7H5iYqiccOyeZaSflgouEwNqagBOLDs79tp8B3SKDo1HvemeENvrxx2zEi6LF4RV1HNvPh0CbpjAmM4=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by SN6PR07MB4896.namprd07.prod.outlook.com (2603:10b6:805:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.29; Wed, 30 Dec
 2020 12:05:27 +0000
Received: from MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::c5) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.2 via Frontend
 Transport; Wed, 30 Dec 2020 12:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT044.mail.protection.outlook.com (10.13.180.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Wed, 30 Dec 2020 12:05:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0BUC5MCf030682
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Dec 2020 04:05:25 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Dec 2020 13:05:24 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Dec 2020 13:05:24 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BUC5OtD002403;
        Wed, 30 Dec 2020 13:05:24 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BUC5Ohb002402;
        Wed, 30 Dec 2020 13:05:24 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v7 1/2] PCI: cadence: Shifting of a function to support new code.
Date:   Wed, 30 Dec 2020 13:05:14 +0100
Message-ID: <20201230120515.2348-2-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20201230120515.2348-1-nadeem@cadence.com>
References: <20201230120515.2348-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17cc3373-2b60-4c32-ce59-08d8acbb31e1
X-MS-TrafficTypeDiagnostic: SN6PR07MB4896:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4896674634FBAC44B7479546D8D70@SN6PR07MB4896.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZmeJijOSfUjpv5KSHjDtx3X2d4Nwdycr6u0hPDuN2w70oGYbVFnGsW+X8N2gvQ8hCjO/pVqNcz0J580ZcyAXe/x8NzSTb22GWiZFvt1WcvBrYp7QnaYTcWIi3OOBITjh60Bg4gRTXa8a4+kcUX8hIfz29YLVOBN6yJNUriBE5B7+jjFRW/qyIOHZhZZOYQLCvFHUKamew8+MPGTVoTcVh1c9zH1IBRrbo2sp9xFxMc1IYSgPoRX/WGwf0or5VUYb8C2ZeD97vkKi1WenejoNqGkojFLPPTWvgc4jAVW8FHtf5LYNBc6dabo5yJIyjHOWV+Bar/zCypymHmK+Z3gVNxC0kEi7/yFUz5HRx1GQcKLkEg+qBt4M3F+OtoqanM023dTtwmdHXTdY0YcU+DvHJY0jtB0H970KGNYSXmrXJKDYHQwhF1KV+0DBCxsnnLObA56DS7uSlQPd4iNf3H6gFBpCmhB+Rlh6AH79pjLRWZA+WVFxY9ytqOrpPwb5tlsgA4+P1dDg71w95znbl5PXg==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(36092001)(46966006)(42186006)(110136005)(478600001)(316002)(36906005)(7636003)(83380400001)(47076005)(186003)(54906003)(336012)(8936002)(356005)(2616005)(70206006)(70586007)(86362001)(26005)(8676002)(426003)(1076003)(5660300002)(4326008)(82740400003)(107886003)(82310400003)(36756003)(6666004)(2906002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 12:05:26.8069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cc3373-2b60-4c32-ce59-08d8acbb31e1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4896
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

Move the function cdns_pcie_host_wait_for_link() further up in the file,
as it's going to be used by upcoming additional code in the driver.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 33 +++++++++++-----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 811c1cb2e8de..9f7aa718c8d4 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -77,6 +77,22 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
+static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (cdns_pcie_link_up(pcie)) {
+			dev_info(dev, "Link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	return -ETIMEDOUT;
+}
 
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
@@ -398,23 +414,6 @@ static int cdns_pcie_host_init(struct device *dev,
 	return cdns_pcie_host_init_address_translation(rc);
 }
 
-static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	int retries;
-
-	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (cdns_pcie_link_up(pcie)) {
-			dev_info(dev, "Link up\n");
-			return 0;
-		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
-	}
-
-	return -ETIMEDOUT;
-}
-
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
-- 
2.15.0


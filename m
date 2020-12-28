Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB02E41D9
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438286AbgL1PNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Dec 2020 10:13:44 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:10826 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438251AbgL1OGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Dec 2020 09:06:52 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSDvc4i004305;
        Mon, 28 Dec 2020 06:05:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=pCs8ZIWLbAqar7nQCRBh7v2ZcsGi82HUlYAsqpWpDFI=;
 b=jufdAzaVoE44SxIDnckSoI+qTM6uSuWoHnJr90OXPvQI8kZ5ADuVJwm5wSq+SKaa5h4/
 ofeLj9S+doE4azOkPIPGEUeiBk6VUYsmbITfXnJ9vc8ZsjZgd6lFvEZlAMYGu3SUyoq3
 jQIB5H0LObOQcUsOQ+W4+pJQY0RYArR9Cki6RuqolPEFo8c5HwecChfOOCwI0Ftoqahr
 UpANO2RsNy6IgUvSzQ6wH/r/ef3ZyZ4zOVEoBLm4Iu6WsBVAPL7Bt2iqisCHsqJ+XErb
 xnVjt/Aef91gethQ8cx+ikTZ0FwN00Y+uxWndmpOVbWogsYo9itpfhouSSvRgoabytMc Eg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35p2m1be5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Dec 2020 06:05:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3KMYQQLk1vvatrSqpjva9LFG1dMat13nttLdis2gs3qDwnJP9PMtc7Ma2C0aGoT2TTgNsh2alSKx0xXORdfyIxdunDT7YRVN/ANkR9p8UhVZbJgDAPLxT6qqJd0UtEDbkRnm2bdXZeR4QV0aTxWUCyaJVAwTJ+o7xaUbcrwFzGuqPJsU75swAgR/e+Wn1JBcH3npSTSYbzytKTx/VVqw9DokGuP9RcAmVhXuOCNZgFrz5qQeobk9ZzeXdy0fxaB2rTPcAZMwarxzutfNiBjtOu5AK+8Q0gyKzvaxdv/QBZPCGfHpbUNY1/Mpqj4GaboMT3GI+6Rn0HDNcjDBzCG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCs8ZIWLbAqar7nQCRBh7v2ZcsGi82HUlYAsqpWpDFI=;
 b=mw2K2gSKxhUQM+vmkLlq3WopaYK/uhiyhbpKsOptoyEW307tBioGa7yQqXA89MIhBYWrdqQXjLpFtCprKo9OYzMbEqiqgWS/2s86bHeYwUVpbWwyTpY9KpR5zPVqDKvbB80/gBHUZ9srwkuDk0m2b0DDTyGOuu0x4fLjLlAo1C84BcWMA7G0P3W7PgOhcsH0q/thAnfhZMAEXKRTvs740las99qwvPjv1FWA3ylWNiff58RvL+uXERALLgXDZ//jsz9GQAHCLM8r4+JrMOdhueR6k3Y4hw2L7JqNeKvhQ+2Vd3rNDPts2NYaKRw9cUdjPdbx1zRecIB2EmLnzohkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCs8ZIWLbAqar7nQCRBh7v2ZcsGi82HUlYAsqpWpDFI=;
 b=NuzZSO/NcRdpBuT9otPj4Clt4uba1s+z1Ja7WRl42aW1SAQpBdmqWNCaJviLmg+7UPHDcwrzzJ4t1uTG+R7ZGZhqLR8KbwQpHaYkv8fLk5C7AdQpq5hzeWO+0/zwrrSELT974f2vyf/jATO8jKotRL2ZR+4CFHee14YCllo4jhg=
Received: from DM6PR06CA0052.namprd06.prod.outlook.com (2603:10b6:5:54::29) by
 CY4PR0701MB3620.namprd07.prod.outlook.com (2603:10b6:910:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Mon, 28 Dec
 2020 14:05:37 +0000
Received: from DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::e5) by DM6PR06CA0052.outlook.office365.com
 (2603:10b6:5:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Mon, 28 Dec 2020 14:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT062.mail.protection.outlook.com (10.13.178.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.20 via Frontend Transport; Mon, 28 Dec 2020 14:05:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0BSE5XBO030293
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Dec 2020 09:05:34 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Dec 2020 15:05:32 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Dec 2020 15:05:32 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BSE5Wg9014705;
        Mon, 28 Dec 2020 15:05:32 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BSE5W1Q014704;
        Mon, 28 Dec 2020 15:05:32 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v6 1/2] PCI: cadence: Retrain Link to work around Gen2 training defect.
Date:   Mon, 28 Dec 2020 15:05:09 +0100
Message-ID: <20201228140510.14641-2-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20201228140510.14641-1-nadeem@cadence.com>
References: <20201228140510.14641-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 641dfbfa-2c7a-4148-1d25-08d8ab39a6aa
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3620:
X-Microsoft-Antispam-PRVS: <CY4PR0701MB362067EC2AFD68D6320B06D9D8D90@CY4PR0701MB3620.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlxBixrAS0rWOitHZI2GwSRal9BuCPZgCwYcdDWu93xAufONczQgqX1k4NqS5ogdMXrBHQPnYVOP8RbahktTgdV94MbRmF4fggFlJ2CIO/dYub4b3wb/Y1/DmliTHw8pi7Glw7/aAhPjMZ6CNFrXMXLkOA3Ka7GlREjm5M4TTJXSVS7lggHC+4KiNR3TeofD1OGimrvUUt0e0g5QslXJ3rsD3ldyWXbmD0yTSfP1uLTqakFGqTp7vzzd6eHNc60Y9PbKzqfLM+44bHUWgqe+OrarYb1Pz+zzwb1ymYHK4LhyCIaoQAKFJDLOHL0JZ7XDJnt4uF6w6mfAa/MTznyLXENBCQshvdpBq/5sbdgvmIgV6lXPTAi5JbNCM4nPX9RtnYvMX69fiirHYTDUKb31p26zUusvQpaekPerhZB7lao4zpImZS1oQlff5DgUpt40UfJ4HPEAm1sbnOhfNFEdSsn3HouZuGrTBrQhltBhDUCDZzTA/5DGynaoVYRyY46AZil3iO6CXDaMXc0WJW9JBA==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36092001)(46966006)(2906002)(42186006)(86362001)(70586007)(4326008)(47076005)(36756003)(107886003)(2616005)(70206006)(54906003)(110136005)(82740400003)(83380400001)(81166007)(426003)(26005)(336012)(8936002)(1076003)(5660300002)(478600001)(316002)(6666004)(8676002)(186003)(356005)(82310400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 14:05:36.9837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641dfbfa-2c7a-4148-1d25-08d8ab39a6aa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3620
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_11:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012280088
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moving the function above to remove compilation error.
No changes in function.

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


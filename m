Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC0315202
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 15:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhBIOsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 09:48:50 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33584 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232274AbhBIOst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 09:48:49 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119EibSH020875;
        Tue, 9 Feb 2021 06:46:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=dXYSEl0G00OdyADOwSkjnpNiSLWKVIbFkN7qbFkMRB0=;
 b=T3nJhvI5vZMA8kH12kD1rsbaT8xaHJl+458itQxsuwpselGsbaqiQgtcItsy4TcNz0v5
 W+L+YUTgofhZ4tG0mLzVMA21PBcW/+KbzHQvN/2623oTTzwmfGcMz9qO2CYnd60/QXkg
 7Dr1cVn602dd0FB4HhKjx30mIbxD22mdHU8bp4OK9sJjiV7g15nb5KllIT2SA97ayQXY
 rhgjbY82dCpyYlKQ9O6SQ3xji0kmmHeiv5Gqd0HnQYq5VIY1D9R60hoOIgH6HCwVCKKz
 BgMnlIs3aSQZ68bhURnz6wDJE348ISxsNAEB9ZBmiqhFk/TpLcGVzN+c7ITizk5nZFcW YA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36hrcw8sh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 06:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpbXW85zIYl/47bL4b6ieq7vQLMieJ5joeDW2sXiozyb8XKIaMiee/PbVmFkIwzJqaBgCW3I1x4wUlqeXqyZJN25spFOa96L+Dujo6orBhs6y0XgmJmEUfy8NX+HKBX3eHmC4pT6H2J1dq82pRrWA3bFpIUCpv3dKxiJz7l7jPzqJj0/lRWBZJ9HYKm1MXiyso2eMpqu5IlBCuxCmwwhWnASz0vRPe42O7YPVvr5loWw1fAy/K9gV9YoMMFHQyvRUyYTolixiNd5nJVnYnKnSeUQY80p+/JrJ9q/6wU0KblB7879uqwdqTEppz1tCWv1/w7/yihTT277oyQ1V2FibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXYSEl0G00OdyADOwSkjnpNiSLWKVIbFkN7qbFkMRB0=;
 b=B74g83PFjyZOj3OQsdVB0iBR5fNz9ECd+z8IuEaiCT9y6hzlsBuSM+hGS6XFYvauBvDYQBh2H/garg+z5WUMVZEuql2iks4thAeLSOZBiSKaFsFj/SSmmkqfVjT3DPJfqhilPUUxi8WYWp+SZ/K+/YL90BEK42KZzovNDhwWDDm2eo7bTpeWuI3e9cQMyPzlgqnwQ0JjWiV4a1etQBJaDnJuscyog4/6BXTgJN4BrKE4da7hGCHudl5jm9EUiDFw4SRXnE97y7eV4k4BUzYg8Akcq5vyDkUyrOTbVzGQxh/u7ghQ2g8y1Epb9AW9KMPkFWCPKgTBhDiLoqrvZjtfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXYSEl0G00OdyADOwSkjnpNiSLWKVIbFkN7qbFkMRB0=;
 b=Z2P0/KTPo0fIxg1c2OjxnxuqGqsC/Tzto6ied3XlZFmOjpYctiWB8nCOm4ayV0ay+SxoJkVSWENFbEf2Sh4aaaYe0OsrLS4J7boYhQXCdmDK3c9WqAQT0DLyHIR/tY3UTU0EEIAcOA4Sh9DRjztaufKnPKA4HQZeosZtAX2mB5U=
Received: from BN9PR03CA0834.namprd03.prod.outlook.com (2603:10b6:408:13e::29)
 by BN6PR07MB2753.namprd07.prod.outlook.com (2603:10b6:404:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 14:46:34 +0000
Received: from BN8NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::8e) by BN9PR03CA0834.outlook.office365.com
 (2603:10b6:408:13e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Tue, 9 Feb 2021 14:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT046.mail.protection.outlook.com (10.13.183.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 14:46:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 119EkRwG001420
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 06:46:31 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 9 Feb 2021 15:46:27 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 9 Feb 2021 15:46:27 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 119EkR5x026758;
        Tue, 9 Feb 2021 15:46:27 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 119EkR0c026757;
        Tue, 9 Feb 2021 15:46:27 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v8 1/2] PCI: cadence: Shifting of a function to support new code.
Date:   Tue, 9 Feb 2021 15:46:21 +0100
Message-ID: <20210209144622.26683-2-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210209144622.26683-1-nadeem@cadence.com>
References: <20210209144622.26683-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd15bdb-9449-4edf-7d22-08d8cd097ddd
X-MS-TrafficTypeDiagnostic: BN6PR07MB2753:
X-Microsoft-Antispam-PRVS: <BN6PR07MB2753117692E6AA37A74BA9FFD88E9@BN6PR07MB2753.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7X5ziLKl5I/djQox6Zcw7NWAFXTsZ+ruB3oWK8qPbnM08ctCCnymAVgAJUUqj62oRK6c9oalHOiV2/9tTzbpaexXFYt44JsNxLG6UD42rQx3lQiW7QJeVeCuMnlmLocQrABYjlaQkvRwJyEcT71PnEedbbTtUEs9ExUgNTEzYFfKh/Xsyumsl9ljqgPNAqyvB1Ac8110h+jKqFW8qr5rIKtj8F0PIdpFIqWtU0W/bNK1R1i+5nL4Clu/oOGUa8H+Q7C1wCM4mjIgxY2QIqcoHMjbqIBuwa7T5Pyn+p0/FwexqMYXQ3S/KrM8pHgPsuMr32oxd3e0CSjHHrKLRt3ak6EaYidD3gd+5aoQxdGQO2QvjneIkHar1CvTOkvamRA0x9LOQIFG8dSWoNfkPHRbf6MoIvXO9ZjyL4P9tgCzM1bX+d9mUhDtlqAx0CwxNDXk8rXSFhLpY1goJan7fpeqaPNoJzY0x9pn/PFskUvETh0oEhGPtMQdzHrncfvyU/Iatv4ffhGMYocyyt+rSAPqNNDJixstmntiZwTfRLZir5bY8gb2QBzJmYYN0+4iR9AoQMc/Pso51MK1+E807T2FaE9SZEArXbPEO0sdhEqHhl4Fssgo+AULuG59bQ86BVkRbXmNAdRe+SocHgRsPu/kgdx+Bxizn7oLrJGAqTajlFaAl9IEL07HIIji4kQh+d0aWUo9Q5g3zlMNAuR93jCZlLC8YQOroB5qnh2g7OYvODBTMhnvH+XIGXCOP+DQekB
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(36092001)(46966006)(36840700001)(4326008)(70206006)(70586007)(8936002)(107886003)(54906003)(86362001)(2906002)(316002)(42186006)(34020700004)(36906005)(356005)(426003)(82310400003)(2616005)(47076005)(82740400003)(110136005)(8676002)(336012)(186003)(81166007)(6666004)(1076003)(36860700001)(5660300002)(478600001)(26005)(36756003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 14:46:32.1533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd15bdb-9449-4edf-7d22-08d8cd097ddd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2753
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090077
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moving the function cdns_pcie_host_wait_for_link() further up in the file,
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


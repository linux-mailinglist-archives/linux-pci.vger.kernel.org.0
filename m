Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C362D781C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 15:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406306AbgLKOo5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 09:44:57 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:64936 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405930AbgLKOoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 09:44:21 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BBEZgAB023417;
        Fri, 11 Dec 2020 06:42:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=y6pxn9ZqVWB8jThlKYYIwmeFoDho1rGNf8UTr/dKw50=;
 b=av8KXVr1ilICqGmVbayb841Kjphn+Pt5HAAGXal+iD0tAeJVSveJzf5zvy8ZDcRo+x7y
 74QRYSnhwk2nmo4JsyVqZ0k41x829dRABF84xZDrDXEibrTsN1JMRvwugoHrzmoRUr4v
 qM8/WZ+nnmLp7MBRbpyvvcAnVow/KND0od9U6tJDy8jsGVGKrdEbc1mjJcyUVXjUtFeZ
 FiK5O9qZi5uZMqYWr/QNDjRVdS8YxaEiDXcmcW9lvgOuUnkTb9I2gummsmCL4a2YidPH
 uu1PWNNkZHnXbpOcVh2LHBA6zoCLCe+XvTJasz+BdKbAzw0rx9UO0ZDLtC9EFUcP51b9 Qw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3586p4e1a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 06:42:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqJHsuf3Ck/l08kjec8SHXKLS8jnwIJ/gk54oCXqGybOZG7ooi5Z1G8mKJJeIySC2zp7fJMyjkqHDt9o501KwW2zwB402KxZHWXOE9yGABEOmHWZUXt9WfLf8G4MM8XZSQD/vi927itzj2u4tl1W38QMG0/v0RgqRc765yBrMuxEnqhLGppT2tO+7wuQOxRIDl4hZt3S3wyj8x5VEIzIodMyMfysQdfrS4pq88WUMZMVAWITBW2yDapvnpTrgwAm5gfeMHbC7Qmjo+AAInzauuLvB9clbmv9wdiluIkZf77Wha/SdVSDa5vJkBHJa/UlHJdHRn2lmkhG2Gs2omdSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6pxn9ZqVWB8jThlKYYIwmeFoDho1rGNf8UTr/dKw50=;
 b=dm9ik6bKx0ClZcl/AaYx5E2YFPAqXO3aJOv/BsaAQi6BguxQpYKteLZuczAt6YTk8zYj+QS9zQiTT+8o5aOkN5Ybiz63mj0iQXrZHRTriIwd+lZb4QS18cDYfVhGNYlgetIY+PfxitP5iZJtmoAhKXGId+jOMow9u3+ECJjM54UaYoHb0PI2W/FONRhxxdCiCz+TzmB2EyzZmXCx0RWY00Eyo/3+dhf8UoMKV02133Oqa+A6u6O7tYMeMrS1qL9IdOViT1piTDqTRneKKMB5udG0svL99jofJdmVTOF98qnY+T4XCGIj+BRzRYYCiuRM1MzKO5WhbKJpS2MgK9ribw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=google.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6pxn9ZqVWB8jThlKYYIwmeFoDho1rGNf8UTr/dKw50=;
 b=DcV9TSfnUhmzkFO2aBTeKl9lC+HruNRoJG4xKOzsOdmObrT9vkPzVYe9n8PJ0wo1CIGBfVgFNHQMWQ+0O3KpKZNvJWh60rvWpvuID/zOIA4wCDThv+ULn94GiP/yXjjCXkcWC7nJ5mMrgisy7jiGJmpBysb5hVUMjSbcPk2wMdc=
Received: from MW4PR03CA0341.namprd03.prod.outlook.com (2603:10b6:303:dc::16)
 by BN3PR07MB2658.namprd07.prod.outlook.com (2a01:111:e400:c5f0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 11 Dec
 2020 14:42:50 +0000
Received: from MW2NAM12FT029.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::13) by MW4PR03CA0341.outlook.office365.com
 (2603:10b6:303:dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 11 Dec 2020 14:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT029.mail.protection.outlook.com (10.13.181.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.10 via Frontend Transport; Fri, 11 Dec 2020 14:42:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0BBEgkIO187640
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 06:42:47 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Dec 2020 15:42:46 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Dec 2020 15:42:46 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BBEgjaa003907;
        Fri, 11 Dec 2020 15:42:45 +0100
Received: (from nadeem@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BBEgj9G003906;
        Fri, 11 Dec 2020 15:42:45 +0100
From:   Nadeem Athani <nadeem@cadence.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <devicetree@vger.kernel.org>
CC:     <nadeem@cadence.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH v4 1/2] dt-bindings: pci: Retrain Link to work around Gen2 training defect.
Date:   Fri, 11 Dec 2020 15:42:35 +0100
Message-ID: <20201211144236.3825-2-nadeem@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20201211144236.3825-1-nadeem@cadence.com>
References: <20201211144236.3825-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a361534-9e4a-4c09-5887-08d89de307dd
X-MS-TrafficTypeDiagnostic: BN3PR07MB2658:
X-Microsoft-Antispam-PRVS: <BN3PR07MB26588C66B9A211C4EE8DA6C1D8CA0@BN3PR07MB2658.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xz0co3wKjqCyTlakdwXIiSObN5i2MyBvvHiyUCiEDC2t1t2V/jteVJClluzmxIoPcdnw8b1dTu8Xx2hZyKxRWGE1RVI9YpTglavczaZcKRFS2fJ3djIiQFIQYKeex8J1O0g3AkaHx1EypvkNeSs8Idh0ZBrss3rkcoBIIBLqZjuRobkHPyK/DqWIDxjXHvxJO+x0CA1vj/HMTgIOW4h+umq/q6UojWe4YOnS9kaKJCGp1Zk9Mb5lwTznThki9oDcFDRIZcWqozETGcmsJCHhVwAMHEWnn52MU7J8ttwTwUH7dQ/Es31CgZcc+kU1U/mWiAgyy4tdy6HysqRWRCGAXxPZhzgILAg3zi47zSyJvS5oGRzkDpFcerw+giIKh4ObFayO7B0DmqV4Nvv1xFi0sWJooLCp7lUPE0PeP+ewsTVRCq2MRqQg5GdCpHChSKbQuzSIMHsnIX0AXyCbI75phQ==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(36092001)(46966005)(356005)(42186006)(47076004)(34020700004)(2616005)(508600001)(82310400003)(186003)(1076003)(8936002)(36906005)(2906002)(107886003)(70586007)(4744005)(26005)(86362001)(70206006)(6666004)(83380400001)(8676002)(54906003)(426003)(4326008)(5660300002)(110136005)(336012)(81166007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 14:42:48.7459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a361534-9e4a-4c09-5887-08d89de307dd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT029.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2658
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_02:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=925 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012110095
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence controller will not initiate autonomous speed change if strapped as
Gen2. The Retrain Link bit is set as quirk to enable this speed change.
Adding a quirk flag based on a new compatible string.

Signed-off-by: Nadeem Athani <nadeem@cadence.com>
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index 293b8ec318bc..204d78f9efe3 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -15,7 +15,9 @@ allOf:
 
 properties:
   compatible:
-    const: cdns,cdns-pcie-host
+    enum:
+        - cdns,cdns-pcie-host
+        - cdns,cdns-pcie-host-quirk-retrain
 
   reg:
     maxItems: 2
-- 
2.15.0


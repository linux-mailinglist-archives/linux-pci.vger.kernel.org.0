Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC69742EB21
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhJOILq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 04:11:46 -0400
Received: from mail-eopbgr1320114.outbound.protection.outlook.com ([40.107.132.114]:62659
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232450AbhJOILq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 04:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2t/JLAelJD3nhX9ejVz+zZpDDcujQ1+GRIy7nxCbDioIm3PlB9mEERY/cymtL49I6m1g98Z5FqAjTI2Wan/c9NmcDcDG2nS5Jz+F465VKNNv6zgHKIfULQcFAgq3bNCJu0W8Zr4L8sm9WD5v+cp6+dP0uWRIJCm3GO0XeS1byuGH9QQmr3/kEYDd2QtsWGeO3ic7SMDKEFtAnkzua9Cx2uWSZ+31JKRopmuo+GX5uQRA2V6GXzWLh0a9dZ2IFyVbdpN+bHLHgzHt9cxmO9vbu/UmsyAACucOsdSzU+GB683ZT3jbE3VzKZNjxj39/Bqdt+IY4/E9BBPLYZZLsxiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfeSzEqO7O+IwepqK1d4ON+HNsLvPFYOw6/wuy5mK+Y=;
 b=UMnlEmarpk68tYG/TqU8MtezdILY3zf77JeEkfDO4qiQdrFxSs1olCApuNuHLkXamaEDmeKsgluqXs/TEH1luQ2kXQJRb6O8AXkWLh6rE2jt6DNy1l6EwDIoPjAkWFKvz2WZnk1PSiIqZtK3yag6K+PKEpGMKrdO6Ul3umnsjLSCQ+ocdHoLFXOCHlEZZq1GrNHghUAhe0kSeAfeqwGOtJ4BGPd57N7gwu16RUrNrPiT6SfZmPZZ1f2b5yt29+wL/yOkXGspuESm6X9Bch8/E5Z2XnmFR/k8y8EIaQAUk3cMKfsEibqa/mygptZ64GIeMdtTCbFy4QixGyhkcPAIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfeSzEqO7O+IwepqK1d4ON+HNsLvPFYOw6/wuy5mK+Y=;
 b=Lu5+ys66t/5xTeirMqVe+DI/9W+PkrDZM6y6u6pt4Lm3HWuDRBcNHF2NUeTHJ0JrTjuyvjScditcuho6pK3s9NezkmzZMRahaxVKVPw38YlJbeXtZKQgnyB91nl7gzgvp38TjbGUmhb43ADlnwuZFCzpZnKIgRWXGg6S5zDKnps=
Authentication-Results: rosenzweig.io; dkim=none (message not signed)
 header.d=none;rosenzweig.io; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2778.apcprd06.prod.outlook.com (2603:1096:4:23::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 15 Oct 2021 08:09:34 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 08:09:34 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] PCI: apple: Add of_node_put() before return
Date:   Fri, 15 Oct 2021 04:09:20 -0400
Message-Id: <20211015080920.17619-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2PR02CA0217.apcprd02.prod.outlook.com (2603:1096:201:20::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 08:09:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e11c770-b149-42dd-767e-08d98fb31f9b
X-MS-TrafficTypeDiagnostic: SG2PR06MB2778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB2778CCF66EF41B1CC0C149EBABB99@SG2PR06MB2778.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4g90r+0dPtO3RxOqAnog9KD1NQP+HhalLNVfOc4ZTrdMTN3sSGJJXaNKTyr83awmg1UmLwubkswZKDoRacbbANnnQKK/claECuKaaRSTcTCiYtMOAvwQ1E39yQNNZcm7KcEdRcjJpHb6/iSlY6kRLmEEqujVdslNYQNJC6yza2N2jqNU1L+B1jXehtGhNH6E11BQBsv2y4pPrRI7SICdmj37VyLdXZcOsAkB24XG+UAVvKMAK03vaoDU3sKfoCpKIdTmJWQg3gdwOmNqzgQksmPOntzyZFGyfcgCZqOBQFJf02kkrfFXynqYYg8ldQ349JxazwwMCNHUeI+gLCiTN5Db8NDF0RfBmgRWiFZPadUk+dYHk3MLvmcOtiIfYM05/2bLpTjYPNuDy8cGNEHVMERr9igp6/EHpa6dXEC/96VFWU1EgbNbTLvpaI80O9eqU1Fp7Jweox/JCg5KfrzqqFYz4045ozPDx2PwCymyFwI4teUJqC9OrLaZ5haWjtUVFgcXabTqW89QR+xcds6B5onVhg102IOT2fYLJZ+9h/VD5b69pZjiTmVA0TxOxvMzbhPvlpa+NUEEDY80P35YPq9Qon/uhGxGL+2mmMJg6L6sgEUDsgvtHhPYwRwqzY0kVmpYOTDAbM5oPJoJ0Y1xWRux6RzMquW3rTt55oPgAOY+2UBthCoZ/DFyDrlxRrQw8kUGadsBenvoA1zgzJf+IwWQ46Lixcf7qon8FLIW7DNX9z8nIvptHqaMK6C+Vs5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47660400002)(956004)(316002)(4744005)(8676002)(508600001)(107886003)(2616005)(4326008)(83380400001)(6506007)(110136005)(36756003)(38350700002)(6512007)(186003)(52116002)(66946007)(66556008)(66476007)(8936002)(6486002)(86362001)(2906002)(5660300002)(6666004)(38100700002)(1076003)(26005)(46800400005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ug7MapRZP3D8FKG9zcL9QxBmuhCI2CkmqCUoqsRoE+mVt2n3sQDKRP3DQRru?=
 =?us-ascii?Q?DloI7AZREWWKjeG2DVuoW4UbKYQN2O5G1wBBrAG0CIcmx7yoKAb0O2qMVWH3?=
 =?us-ascii?Q?Fe9RYizz5JBk85hrsJs2nz9ZpVs0NMLWM6HaQmUehmSyuByOhiN17l4SeJvS?=
 =?us-ascii?Q?wjvJgIJ1syRbYBoz3mKo972Exhrq/6u6pBMJ+3adtvKWQY9DbxN+JZxkiUyK?=
 =?us-ascii?Q?rnKeAnfZJ5OWv85cTLEl+QgBQWntsc9n0IOIAvMwExfENmWJdq/gtPyxRzpC?=
 =?us-ascii?Q?g+dyxfrwritJa8EjwRhD8dyl4/DRl0WVNMReKA81kQddS5SaXA3nbjAiwWB8?=
 =?us-ascii?Q?ZXATrjhi3w1fSqJoeNOl12Vh1Qvo40QsxrZMz3lAQfd04pDvSMrIkZ0O43FU?=
 =?us-ascii?Q?/NwoDL7XOqvdHj7M7S4EuYW3a6dP5pJURCk38hGZ9y8X/UdiFLDfSiBnRjvU?=
 =?us-ascii?Q?1x00qB3QFWm9pdcON8B1Ftdrc9uAD9FxOlWJ9/OnTAwShxkVSu+PyrqkQiFF?=
 =?us-ascii?Q?ISiHYOisQDL5RUrFqvWlcBcHNOCm0AJNeTMa2UPa4BbLJgqyH0D2xqy00vhl?=
 =?us-ascii?Q?BxuqfuMRt1zNMceqk+5SWrX2cihEPqtzulh/X9zYocp6FszHvDa72XkfzIcS?=
 =?us-ascii?Q?erw7Msnm5PsFXZH1XldFp5z8KF9JFaeDtvUlcgukx88bqO5tsbwIwszfnauy?=
 =?us-ascii?Q?FMIgWJvVg4MeJnfVl9+shOzz0mA3jWuBbtg587kwiyUsdmjdzit6ntjGQuuH?=
 =?us-ascii?Q?uV6whgs97LxVylNGgi4fYDElFrttS1vQl17GRSOuSKSi4jFcZPFzyWwzFin8?=
 =?us-ascii?Q?y8Rfo9ziu5Lz5x5bLyG1d49bIWc9kSwk9v2LmeJLXHDJI5bZ7CR4ztdsKdkm?=
 =?us-ascii?Q?kHBMMlpVFFN1bTB5La3QtGMjVvWB5v55b+q5qs05BEPk+J2FUlUrxI7w2X20?=
 =?us-ascii?Q?h+f44ZRLnyptcBSDd8ytqKTuk1pMEWPisAIijKp9rv4Zg54pmGTq0wAPtPtA?=
 =?us-ascii?Q?MbC4wMJG96onEBN9U92uyUvJVglq4y6ZVYq40xvbyGEuE2HU0bgCzoT/f7EB?=
 =?us-ascii?Q?gxxn2zN4/YS5hUlAKok9bEyPPMZCx67MXlT/JM50XaTmLmlDhnoJ0pt9mZZD?=
 =?us-ascii?Q?Tiaj0JLgA2UmrfE48g4RJwOzdZ7wWYM9ZWTCkbUe5ejoQWPdjZY6lcZQBIfX?=
 =?us-ascii?Q?2BJiqQGV/B7EKfdWSTIBbHM8otTx4BKqsOkDi7s7YkaXcKLxsDx2NvBy5Txm?=
 =?us-ascii?Q?0lNAPslzfaSo8VGuHd18i5MqNJjGn7t5yXvOzOv6jx1DczUbCQ27dxZ9hahL?=
 =?us-ascii?Q?rfpWpolhiYWDLy/fEng6BkX0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e11c770-b149-42dd-767e-08d98fb31f9b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 08:09:34.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeKDtPwXikgajuAxsEk0gKaUbVkdMMVff1S247lSpkb/YSEoK0fkRW+YekffCrP8HXFtL0aWwCWhrPtjvmJHNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2778
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix following coccicheck warning:
./drivers/pci/controller/pcie-apple.c:771:1-23: WARNING: Function
for_each_child_of_node should have of_node_put() before return

Early exits from for_each_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/pci/controller/pcie-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index b4db7a065553..13101389e988 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -772,6 +772,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
+			of_node_put(of_port);
 			return ret;
 		}
 	}
-- 
2.20.1


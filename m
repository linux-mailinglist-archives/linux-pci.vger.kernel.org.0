Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6A64B0EB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 09:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiLMIQh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 03:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiLMIQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 03:16:35 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A228B10FD;
        Tue, 13 Dec 2022 00:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1+7DP3C4S/kH7LOUThbhHhfz/ACgtGVjQoPPpgCiichW+cm0U8gvWaY5bnwxmwAjeLKxPQVOd1JtPwCJReLzwZZ3PIoHbIzC7bZSsN73ln33F5vFMBtjnHDNCdIU29+5NUZtX2g6tAi3aV7fEQLqFfbds56g56yyKHbPMRJdsbthp+1MWHN2Mql+b4kZyUmh9CKJGvE+PJ5pirWiObPA7jgeNKwdAYHUxyQsNdCHmvx2uIg6l9XRp4PwGYH9SN477xemTQmd3zfeepPAc46Rc+iw0//jlQXADYZya6lbwDAlB7e3nOUC0FMqKpmGMADnd7gzsNRNIVVqfSXyam3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvnll6baCNgnpbQyIOzWlyou763gc/zM2tkkb0Juf1g=;
 b=B3V96CSpeiAtOKEwsCh7PF+v7tmjOYFBNRWdzwg8LmmNEXrq80N3dEphEFVYQ+V7m/IfHvn3XHhfvOqyA2b9joG+E29BvxtUiI9+dctqP8QRZY4UAkRYdVni3GMX4r7KuYNEAcBrUBGhX3e4UFJ7EQn3/nRPokoobm+mLbUViF1xOR+hpRhmqbL0L9Jw7Yyfg5oQ6R1qFh9sj6dA0aKWXV6/ZDeqjzH73HrsEDtHju0XHHMvblvBQba15BMXU3S6CmTciD9kg1h8ydtHHJ+TF30ZaerB3ZAycyuHNjSQ5BkTKejulKWZKJ0HGPbOw+3lCP5Zr+7OmASehQcXjzJYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvnll6baCNgnpbQyIOzWlyou763gc/zM2tkkb0Juf1g=;
 b=NE2w34u1v9HJrztIom+mS9VhhE2PLutpjN6Ndnmwzvf4Vp4qwCFQbUa3K6y6KqMZDYxJQQBMsvViukjpJKLmAqCXGQoTmgAwx88uBoruWxYIpxJqwRTkXRiUnhifMt83Dwu+3OxHctcEL/mY9xmAJX5i8dMLtOilhD1vDWWLq2/c4sV80aFCfacYY2PCaJjTJG8DT9mipOpPPa7jn/NirUOYf8SkdBIQsYCtjHwy86m5QoiTBYRFNp9WYlNE/hu7NlUu+SabpmbQdCIlW+NF/441TKGFpw4p/FT4yjLwl00Kr76f5BBSDUIpXZ8wAiGlRwpQqugCytTGQOspDBda2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by TYZPR06MB4046.apcprd06.prod.outlook.com (2603:1096:400:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 08:16:29 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::dbda:208a:7bdb:4edf]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::dbda:208a:7bdb:4edf%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 08:16:29 +0000
From:   Liming Wu <liming.wu@jaguarmicro.com>
To:     bhelgaas@google.com
Cc:     Liming Wu <liming.wu@jaguarmicro.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        398776277@qq.com
Subject: [PATCH] PCI/IOV: Expose error return to dmesg
Date:   Tue, 13 Dec 2022 16:16:07 +0800
Message-Id: <20221213081607.1641-1-liming.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.34.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PSAPR06MB3942.apcprd06.prod.outlook.com
 (2603:1096:301:2b::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB3942:EE_|TYZPR06MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da1d0c4-df96-46a8-7b1d-08dadce25605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3zGge+BbmvaI09XITlpyzf+LE8++lDfKeoH3Nwd613D3PnspZuC78QWUjb3a2VjpPx04NidYBZcREUaRPaWY3WXRJuzx1niXGg6h01ddlaW76WOeEALOCm99bLr7wvNKkHgQOPbECEg4BwJ6S8bdhgi8BzC0qL34/2X/BSrWenGWBf3tXzsijAT2JN4yiTdl3nEZ9qdpP1EbfApTIocTIXJpERib+xJfBMRWElVl2gIdBWGyYqOQjtIsEMNGzxXEiRCOOuStw31DylV6RBl2mpjVUPK5E1jDi2lr2J0HRkxA4UUwbHpo/Lh34xCJTNUSKJTESCpxKE3hizV4O/3iQy6GDsGfau0QIDoCaey2qYpSglYdcql7K0JP4seH9d0krVmfQOj7JWpJMpMMFK66onWHrgb4SJYyt1DNTj3Ep6OL8+LHf91C0FIIGeiBAIuqfimzYEVCEEQJY0EKXMMULxlvHp+uixmnPWwwwkjPrK2izEtkh/gRIVrQd2XTaImZi/yPzGsPMoan1H7tmhzfXye0gF/U6xnrDP3pP6b+98ztSBCd8v87j6RiCcOz4p0dVijm0JvCWMtcOOSPjPSvl22BVOIID1y/Op/hIIqKmyFpdwAru/4aT/UD8IdQ+d3ATe2QHbcm/PD7Y/aF6IMrynwkcJx/SUdPFMWs8wvoRV8nGAuH2yFBDgJJJ5NNRxtoNHvzOWb1RiQnaicMlRP3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(136003)(376002)(396003)(366004)(346002)(451199015)(38100700002)(38350700002)(83380400001)(2906002)(86362001)(66946007)(66476007)(8676002)(4326008)(66556008)(41300700001)(316002)(6916009)(8936002)(5660300002)(2616005)(186003)(478600001)(44832011)(52116002)(6486002)(6666004)(6506007)(6512007)(1076003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+a58TJXw5VLq6MsvVomo4WPx4o6udLBE29jcX0xWC91lotwDb5gyUrxybXe?=
 =?us-ascii?Q?mSYYb8/P3TmERMmqT4uiisj974CneCz9lEG3xFo281qs6cZ4u/3/23FUuFfv?=
 =?us-ascii?Q?D/8pPfrdU6MOrhBBSsmdGgLLHwjIPEyaYRJtIxSmjbPqM+z8NQuHUxuU6IIz?=
 =?us-ascii?Q?9C07HfXyOCDPsOu1CNT2c/4A1VxRzBh418IsR4uUVGMVWSlZyfGto9MRPr5n?=
 =?us-ascii?Q?wq8YTDzDo3tHaZ+uk5rioau9Dnkj8Nekq3BrdYXcygL1tZvvLB0l9geYphg+?=
 =?us-ascii?Q?XNep295cKv1GWD/DuzJUJqzKcMd/rWg1Hm40itFjFoYg8kkYeJpenfHUtCLQ?=
 =?us-ascii?Q?QrzGxtxKpfGRnhUdUryWFBXRPfg4R7EShdtoRcbakRaA0tIVnfu6aeB8R27N?=
 =?us-ascii?Q?iQXMBL1hlwpRruORFOBh4YNuNU5KpC+T7NUb8P7G19UvHLxS/UNngkuqUdKG?=
 =?us-ascii?Q?zSuEsipTaK5qDpmH+LU23hbDiQuewvniU+ENUlk6J9l9C4Lkauzk0zZD4keb?=
 =?us-ascii?Q?XgOM5EnFGnXYbLhUsKTDg+AUOVM2pfqCCVIoI9P4YTIrcwGyA+MubL+HR5OZ?=
 =?us-ascii?Q?A4D45GqTR+eybnKfxQWtRn0thWzHXJh/RWWbKByeeZQQN9sGQC0pXz1kLtd+?=
 =?us-ascii?Q?cSKfc1if1PE7gwx24Ge1/f5MW4EMGtDppShjhY/f1StYdIATKhf1YkHuX/By?=
 =?us-ascii?Q?SdeGsm0Tgb6O9FXmEUDMK/HEWOGHrQ5Cd1/v/mqPBljVPeWLWjBprtJxC+GN?=
 =?us-ascii?Q?7bdwB6xLu5JY1ZoF8FwBvjD3ybVQdybyooABbAP8i9G89cAJjaQUFx2Jk5nm?=
 =?us-ascii?Q?FCofntfNENgFf1Zt4FV0tU7zL5D9kF4BpW69UabbZuZyIcgs0FcWp5V/yRxL?=
 =?us-ascii?Q?E9JhtcldKVtqD1jz3UvNGUgpqvZYd4/FBkVvjfQGeB9q+Q2qvXEHkEwQk70N?=
 =?us-ascii?Q?qqMKum6+PWSXmiOeZBJuSfdb83a+wYIxuyq3On7SIIRGuagtC+oH5YyCe8u2?=
 =?us-ascii?Q?WorF7j576RiCtLd+LhIjTJYMSB2TevUk45QmiH1bT97xYbQGBaL73IESsmA2?=
 =?us-ascii?Q?Z0LwNdE3Z95HdGuz9Y2QNjHZLxPV9pwNFN4MVh/2rcxXOGq/ox0J7BreV3/V?=
 =?us-ascii?Q?VOCiLFlri4kTWia+Xg3OZSShI6hJmtwynuNukEW1VTFzKNs0DJ9PSf0JC5tP?=
 =?us-ascii?Q?P4IEa1Z1OCWQYc1hLfrx+qMCf1zxUUVhXRE6fsD6HjQmiOtH+0+LSYZ/bzAW?=
 =?us-ascii?Q?grCQ0FOeSdgrum9Niq+562CJi6OXmenCQiZfSKJrT8zyzuiizZqi7Rmk6HFt?=
 =?us-ascii?Q?xCmGzIda+iKjTMdgIkku9wL8BKJIIm4tydG4tTyvIYxR2jPl6pleKVXFp6nC?=
 =?us-ascii?Q?GdAsDbirurrGe0+nxM6lwrHUkrO7ZPjXDEaHoDmee9cmAsBOpPULQo+/OE0T?=
 =?us-ascii?Q?Ob7rbpk08tqls6edsOrns5oWcbrUp+2MpwleCZhBM+XPGvbb8z2oxUKdxko1?=
 =?us-ascii?Q?MWgPyiGiJU047tKrBeYDgBdFzxD4IcKtRW3j4sk5jCYS4ZmQ6dwI14lb/qxb?=
 =?us-ascii?Q?jHbn8OeDJ8sIKMbt7qtVUWUeNeOnyVCodCHvjihG9p6Xdq2rUvsryAk89Hnx?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da1d0c4-df96-46a8-7b1d-08dadce25605
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 08:16:29.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kFmYmxGV/nyJ9NdBY0ZU5GNyvLlJuyIKmXmB8l98UyPax1xvYYuvlKwqGqhg3aNNMRzpFjy3AH3NvGtmhGVWPq3IxUgF5RpFiBTcVUmocc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are many errors returned during the initialization of sriov,
such as -EIO/-ENOMEM, but they are not exposed to dmesg.
Let's expose the real errors to the user.

In addition, -ENODEV doesn't make much sense and is not returned
just like any other capabilities.

Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
---
 drivers/pci/iov.c   | 9 ++++++---
 drivers/pci/pci.h   | 2 --
 drivers/pci/probe.c | 6 +++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..519aa2b48236 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -767,8 +767,11 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
 
 	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
-	if (!total)
+	if (!total) {
+		pci_info(dev, "SR-IOV capability is enabled but has %d VFs)\n",
+			total);
 		return 0;
+	}
 
 	pci_read_config_dword(dev, pos + PCI_SRIOV_SUP_PGSIZE, &pgsz);
 	i = PAGE_SHIFT > 12 ? PAGE_SHIFT - 12 : 0;
@@ -899,13 +902,13 @@ int pci_iov_init(struct pci_dev *dev)
 	int pos;
 
 	if (!pci_is_pcie(dev))
-		return -ENODEV;
+		return;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
 	if (pos)
 		return sriov_init(dev, pos);
 
-	return -ENODEV;
+	return;
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b1ebb7ab8805..c4836104f697 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -485,10 +485,8 @@ extern const struct attribute_group sriov_vf_dev_attr_group;
 #else
 static inline int pci_iov_init(struct pci_dev *dev)
 {
-	return -ENODEV;
 }
 static inline void pci_iov_release(struct pci_dev *dev)
-
 {
 }
 static inline void pci_iov_remove(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b66fa42c4b1f..c951e0a50388 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2449,6 +2449,7 @@ void pcie_report_downtraining(struct pci_dev *dev)
 
 static void pci_init_capabilities(struct pci_dev *dev)
 {
+	int ret;
 	pci_ea_init(dev);		/* Enhanced Allocation */
 	pci_msi_init(dev);		/* Disable MSI */
 	pci_msix_init(dev);		/* Disable MSI-X */
@@ -2459,7 +2460,10 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_pm_init(dev);		/* Power Management */
 	pci_vpd_init(dev);		/* Vital Product Data */
 	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
-	pci_iov_init(dev);		/* Single Root I/O Virtualization */
+	ret = pci_iov_init(dev);		/* Single Root I/O Virtualization */
+	if (ret)
+		pci_err(dev, "SR-IOV: init failed (%d)\n", ret);
+
 	pci_ats_init(dev);		/* Address Translation Services */
 	pci_pri_init(dev);		/* Page Request Interface */
 	pci_pasid_init(dev);		/* Process Address Space ID */
-- 
2.25.1


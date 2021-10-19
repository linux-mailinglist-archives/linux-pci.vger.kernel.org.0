Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3FF43348D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 13:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhJSLUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 07:20:41 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:13486
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230281AbhJSLUl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 07:20:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIIrmyj9njtSUIg04hS/POb43Mv6rZqgPByFJPDTUT1MeXfmDsDoca0W0l2oi2Itq70+6fHTlUXiGUo4q9t8YoHRlaN3ujtIVHXbtxMnx04lbRbjjc24F0Ad2+ThiBgPDIdHPnjWaqCVnDm8WgmIBmaCW5xPp68wKJRs286y01RxasUfJFyve3g7FOZPTnRgJ+e86aGkoTAXAIuWiI1DGcGEJ0Lr+smAd7i6quEElyGm6i7dOriTWf6Y+DnCVj3jcbHtEXell4VCvovdN1P0sL0AWgUWBWG58TRvD7Nz2/PCK7qYFpS88WaihTZ+oy3a8YqQzWZzOOLZqFnOXcHX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhz/RTY6qi6bswaJ1MtebXz7FanCNaNo8Bapvc/5BcY=;
 b=KU9JYRdlDMtfmHKN3aLsUq7IyBSTnpLpvPuK7t9CNO7WsJuUUAIL7ruahJ3YivSHYBaMNtEc0YRQBqQbZn/p4dKW6rXn/CJx0Jt1apmNxY4vPKH3zq6GN6ZnBrh2Bx71U7lEJfD7ZRV4lGiaXlxnhkHTdTR6SrmCJBuaWKYkHSytu8MP7UaZ1XiFC/Ur2IL7wnq/L0DgWyS+N8WLRgrjpaNQiEBDQVqV2VcJRu8YMQ0nqos1KeivHnSYLqGF/j3k6p+xMR0gGASl6HGe0xuEUMhUhYNji1KRj9LBIKGLlmpRpKC4DRdSPtjqVJrxkrQEyRfBul801xtjPvB3wtJq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhz/RTY6qi6bswaJ1MtebXz7FanCNaNo8Bapvc/5BcY=;
 b=H8r/1c82gGxMC/I/hrpXJJlCzA5Ly2y9N85S/WuV5Wu6Pw6n2RQTU6vYrQrUg8P4Kh1euVluBRHEduexAXn/klS+k+K3FHGID2pG5iSawrJP8lswOY4ZrqSD7oEhBm6RXuJsJCgMYB3N/BvwwL99orrbyDD5LsukZOl3iVbUCqQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com (2603:10a6:802:a::24)
 by VI1PR0402MB2879.eurprd04.prod.outlook.com (2603:10a6:800:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 11:18:26 +0000
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::793c:ef8d:72fc:df15]) by VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::793c:ef8d:72fc:df15%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 11:18:26 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        kishon@ti.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 2/2] misc: pci_endpoint_test: Add Device ID for NXP LS1012A
Date:   Tue, 19 Oct 2021 19:17:50 +0800
Message-Id: <20211019111750.28631-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019111750.28631-1-Zhiqiang.Hou@nxp.com>
References: <20211019111750.28631-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To VI1PR04MB2974.eurprd04.prod.outlook.com
 (2603:10a6:802:a::24)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by SI2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:4:194::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 11:18:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d2b1f1-bd2c-498d-7004-08d992f22bbc
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2879CD1085D2E038809D1F2084BD9@VI1PR0402MB2879.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAg7ngQ9MhYQb4wqcib2UqdWUwVHCUfmUhazjyrM9/x/5szWsoavzRSRTHMa0nBVq1b6XSv1u+jpATOQJMn8+R9rMQ6NSeW+LoHqccyqOVQhwFHveQWapUbh+0/8Zl7uhy8YNzTiCG+zS4ins/I8sOZj5X2vAik9pE90ajgXK7kySnkNPtFcMZBRZCdO36bdmOlrwgwEr62yQP5lh0sN9Z+PHLmb//WD7aTBfgZlJMMWo3hPL3Pf00l6+DsNuXS6XoVBKVnrFJr0CVfO8YbKY7GDbqyzp35YSuUl0CXnASjRMe5ajuMFDJZ7yoXSoGOGc/9RYEPkRsrX0hiI/oJK9nZBVJVVhOkTWqobY0ZIn22cZzYz+SVCmZYUT44En7gvwtZMt+2NM1gQ2EmlSgY57gk2QgGDLO8Ky783ZvTyJqosVXtvdoVJRzm4vZbqyNmpNQZVFTmb+VP5SyrsIdkqg7sQP2nvrCZTX6Rvl6m1WgCrGDeY1jfoQ6Ksor88s1Ex6x/70rv4GngV+TZCE4OPIHi+x244v6EMezV5ZSZX/5h7b5jxe20bhn/wq7iW4rnhsMxMEXR3SNzPgS8MpJzGedBlBD8rZnZLxIXTjt0oav+F9P6VERF8IAmenP69Wno9R53s1RPLkXYQ+RFs6gPb9IHYObaUE/XY+oWlBJ2G31/hr/lNglcVzuAguWpFZtBZKNaBUavumOdZA9jPrhfyMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB2974.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(52116002)(1076003)(86362001)(2906002)(66476007)(66556008)(316002)(6666004)(6512007)(38100700002)(38350700002)(6486002)(8936002)(66946007)(4326008)(26005)(186003)(36756003)(2616005)(6506007)(956004)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJJjdizTqctLBLFF0/KbG/vk9eUGEtTp5oc0g4t7vCurWn9L6qnCqYUmNLfo?=
 =?us-ascii?Q?9Fn9rOBrm5R4P5hxo9Qtbjt15ycivfJP/kRx6O8Pk3inT4yNeGdVD/PjEgiG?=
 =?us-ascii?Q?JWUvvNwc4DRSR4u7+3HJt3ZswI+lDPlAbR1gI3gLSrBt++xPUJdtO1hpfERs?=
 =?us-ascii?Q?nggbv7APkgmm3fCTpnVMvCKsTttXCI4HD9LW+GvHKwXuUlti78R+LdbyKl7y?=
 =?us-ascii?Q?q6lbVQPvM++ViXIv4sA2lbs3IzrMefYkAgGsmwamurLBab2bqlXqAapvlU7e?=
 =?us-ascii?Q?PRoTw2eM1JklbeJeFBsF2hFGmpuTfpdMbF0hB363izftWxtqRThWovPSoPRR?=
 =?us-ascii?Q?43TZp3Mgm8UPOvuMozXSlbKCtOnejfiwvPCbz1GLQFPcHE9MvdneZ6r6Qe21?=
 =?us-ascii?Q?y72zOpFzYRqQdwda2c3tK6RvS4sHDlwJ24cL5ht8g9XWaMKyXM+j/IFGLlDF?=
 =?us-ascii?Q?MPnDgfSOKKokv/GmfqOSoiswPhzlRIa2mfSaxOJmAYz4MmaxRcG284WdaM7I?=
 =?us-ascii?Q?AIs0NOOS+KP1BN+ooO6kE73gLY/2wGlFi4eZ5sfaOsmY+0tfs2lKriRiE6K4?=
 =?us-ascii?Q?ue49xx9pa6UlZuKKaX5q/BrOiUGhm1mVzVtLUbIrY+r4HYxjG8cfVUg95gJ6?=
 =?us-ascii?Q?niheh5gRbMK/dMNt4mg3obriJzOhxaCJKfslQFv3FuNpDIRGkucuBL6jXIW2?=
 =?us-ascii?Q?6X/jzefEUclAAKd63zyoenfBMW9C/k7hocBFT6r7/iQUMVbzPfIKRjVV6Gy/?=
 =?us-ascii?Q?VXvVssEOt3EHC5lGrSyPdcgGHbmjKwHLUC8x6bTZtomSVr5Tua5H0pt64hN7?=
 =?us-ascii?Q?Jp15APTPRiO6rkq8EikKYcWLgepSPWsbKmA6xvROvzJfUhisqtwP+vbFRUSI?=
 =?us-ascii?Q?EHeWMPjsiVl+nrBqXVOft4OcYCUP3rlcxcEZldDHrzU3jcJmfhSaJq6EdQVO?=
 =?us-ascii?Q?uSKaJ/zs9PFvm/0rLWCHFOWrUIE3QW8eqZNLU32DP588gPn5cbcOSRJPmodU?=
 =?us-ascii?Q?GnPq3QKv9YQNwsyxeMbL9BQavKzBp9zD0JjbX2JwD8XQOct4P+ohiFAujD5i?=
 =?us-ascii?Q?FI+bht9vPnRx8UdSXwraGWKn0qw1MRCoqzq2CUxYfditZR0f2Nvx43LjwJ6M?=
 =?us-ascii?Q?+QfAAfhR6C9BPwYANDr1GsbxtwX1JymdleMj3XurvjP84TzLPDWYjzGNAgqU?=
 =?us-ascii?Q?YC2nLAN08MJlOEPqxsL+4S7QYH6Jo4VnIhrvODKb3SNYDGTr+oerrHxowd0A?=
 =?us-ascii?Q?4AS2Y81xHw8EU1qgOOSyc/rja8Nnyso/ttutIDMrAq3ZmwgPfXHmkEqy4jXh?=
 =?us-ascii?Q?AnBIRwoNLTKoVfDV4uYZIzmN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d2b1f1-bd2c-498d-7004-08d992f22bbc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB2974.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 11:18:26.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDKU2gZLcbgQt2lPbmwn5OhCkFazo8dJXQk3XmPUi/xRTnU0z8330RJek2ovJOyPZTjAkempYe4yvxc8vv2EKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2879
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the Device ID for LS1012A so that the pci-epf-test driver
can be used for the tests on LS1012A.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2ed7e3aaff3a..b84d5b15aec8 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -71,6 +71,7 @@
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
+#define PCI_DEVICE_ID_LS1012A			0x8100
 #define PCI_DEVICE_ID_LS1088A			0x80c0
 
 #define is_am654_pci_dev(pdev)		\
@@ -955,6 +956,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1012A),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
-- 
2.17.1


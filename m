Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBC4B62F9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 06:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiBOFj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 00:39:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiBOFjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 00:39:25 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10085.outbound.protection.outlook.com [40.107.1.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E7201BB
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 21:39:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqc/40ZubxcUCZjaW8XTiU5pDa/OI2TIRjQ8sEdUkXyxyuZ/WnqGhZb5tpmA6fUNARajXLjke7Yc4ex1bU2DIIkvss6v1denRIrHJA3XUZrLmaC8pJ29bbUYx5SGjV5oxYH9mOt6YPd3FnCnMPtFN9r4blC3idabURYcqETVih+Wr3A+ptMPdOoR+9NRpmaSl2+O7S+6JhshuPHeezeFjV4t9H3XchtwikEFJXRV0DhZi2O/NcDJKn36echquC9PFbBiAz3wvOXK3W0pezfz82YG11xjDGuyQW2KsoSctF4y4tpX8iHRivye73HsbVEK/vhKPXDO0/JYtn1970Mlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wMaFPhFTzVv2szbrY/tq80kfRy3S+WTmskEOA8k0ls=;
 b=aoApvANPWzsvTyMK4uQ5AofN6U3rO+EQOjRTZ2RfxVmvDdT2pGp97Np+/+lyf7Fzegqkz30zquUVeACxldGBWjqpBShh41GYd6f+KMGZzCjrKght1x9kcARKWFGD763psRMiV908jJN0flGSqQsUD/ezF5dagsumvK5hdgiz3Wc4I9rs2wuyx8BAvffjaEDOoxbfis2AXMLZN4Opn2xImndHptnXyKjyPSfPd2lHhXJtf3/ElQ+8MeiqN9VTzdfOzEAe8iXXhvHx/AD4STqhNxCnkkb7gF4EGKCuYHG97PhW7bSWLrOy99uPgZZhawIMXIhRRoBfWWSIPsSmkN6MaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wMaFPhFTzVv2szbrY/tq80kfRy3S+WTmskEOA8k0ls=;
 b=tENLn7FQwNoDETAF8TOgEwzriCu1v6/D+31S1k0FSnvpKtEOHtXsc8MRZCnhBLkXRM+UbozII5v5d003jCNuTzZniPLoR7XxQRFQvooyRaX4ZvtQ3sFM1lsKcdc659uy1yOL6vpdqc7epAo8CgnM1Ez4I+YHXluWf4QlbZ2dPu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB2976.eurprd04.prod.outlook.com (2603:10a6:802:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 05:39:10 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e%6]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 05:39:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     linux-pci@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lznuaa@gmail.com,
        hongxing.zhu@nxp.com
Subject: [RFC PATCH 3/4] NTB: EPF: support NTB transfer between PCI RC and EP connection
Date:   Mon, 14 Feb 2022 23:38:43 -0600
Message-Id: <20220215053844.7119-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220215053844.7119-1-Frank.Li@nxp.com>
References: <20220215053844.7119-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778449d6-ac98-432b-ba59-08d9f0457dd2
X-MS-TrafficTypeDiagnostic: VI1PR04MB2976:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB297669CAC3989B144349093088349@VI1PR04MB2976.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nh45aYy0tAkEcMQwxqbkJlFOf62KScvpmDPB19G0evNvDOch5jxS7F3u1rXmkNLzJcwyNqvCm1punMxAfADYT7GZ28BcV2wWWpmgcycbmYwfgm0N39F/0sqQmZlESg0Fj9dclw81lQiLYRXoSzOGin2uwfFAqYrYRtYW2R11z1KuP3kUmxh7T1rUFZ3DeeDJnwFl6zTn1SqxIrUgg6MbS1s9P7qOUt+kHsnbIHj4NmBYqt8kC4AW+Q+TMcp66rq8s47GURGyx9ZMWXBEiMy8IAW98PcRS1l+IkjMUENbGmqpooEbwki6uzdzlFth6kDZYgSoN0FRvfbBEEZuEcgs7oWwQKi/v3jQev48ANKcTMlEyx+O52fMt9SOfsXuiQ+Nfl+nLhcai18JZ+eBjy/OVaeep1JC/Nu7W4pSwQ7y893awbOBcNcvvi13a5xVTFDN9qinNOy7jggrYAKyt+EesYP7N07uFayYAF1e8Tezrx5jHRco2v6RSG0VfPS2iVULNa061h03GJT4UBJurZ1fOTjSH1zfhYEhW5mfVEMpD4/hE6sMntxVJbaD9onltvtmeTidRCTgZPtkzI/NNqKQwEs+A5vuvJQxLPUgBoPQmvzLe0s/jw5dNs6ylpKTqS+xkSddoQs7LfvfKKIELpnK24H/2ze9Ip+hyPR+fhJu2aVNyg9nVLw9oNNh0CpFLtPxb+BFldlVVirQJtKeDhHtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(5660300002)(26005)(52116002)(38350700002)(186003)(6512007)(83380400001)(38100700002)(86362001)(36756003)(30864003)(2906002)(8936002)(8676002)(508600001)(66476007)(316002)(2616005)(66556008)(66946007)(6666004)(1076003)(6486002)(6636002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a040cFFXUTFEcWlnVkJiZGhUQXAyWHJRb3c3WnRYai9za3VZSUwrOFV2NnpC?=
 =?utf-8?B?MXJCSmcva3k4N09qbTl4Qzd0Q2V5WDdhLzFXa0F3eTluRFNaS0FwaG9XUTl0?=
 =?utf-8?B?RmgyaW0xYkpSdW10QUlSVE00YmE3QzVnNlM2U2NwT1lTaGwwTkJWL2k2RmdU?=
 =?utf-8?B?SEZpR2xiYWxJWU9tQWZEVy9jYmdodjJUSjNObGkvMXM4ZkNUVzU1K2EzVEFO?=
 =?utf-8?B?SkRrTXdMNzFYTlpRN3U3SFJiVDQxUG9Wajl4M3RLTGEzektkdTBaVzlqRmh0?=
 =?utf-8?B?ZmpnL0toSWtwTWY3RmgwT3gyaGFUeXNGaU9YWk9OQzE0cXFEbVJjV09jWlBX?=
 =?utf-8?B?UC9QcFR0SkpYdEZmUU81WmlpV25va2tQZkxxR0FSUldwenBmS3JTemZOVHNI?=
 =?utf-8?B?NEdrTG54djc5Y3hVcC9xc3lLTFJHc2crYTN2aEZHc3VlR2dRa0RpSzVCWmVR?=
 =?utf-8?B?Q3lHSnRJWUxOR0FQeGtLVDBKYk1YL0dPcDB5U3VaQTc1MVhvRU1Qb0FmMTds?=
 =?utf-8?B?Y3huMlNRbi9qb1pFbE5GMlBhVEZYU1p1MHBlOXZWcVNwTzJSSE5kU28xU3Mx?=
 =?utf-8?B?Nng3WmREYWhoTlBMWDZTQXZuUDBxUGk1VWhVUERmQXBoSktIbjdOM3BlTTFa?=
 =?utf-8?B?a3V1eFprLzFRTjlCa0J2WkZMSHQ3TVhUdGxpcFZCdGFhK3JKbFhRcjNHcFZa?=
 =?utf-8?B?VURUOWl6V0l0c1c5TlE3ck1vT0pvdVZRYVI3Z1NnT3BvUTJZblFVZzBKMkNn?=
 =?utf-8?B?YlVVOHJjeTFWaXhvdHVOaXdjaFB3ODJGcVRKTFJFaVlwcXNnWE95eUlPYzJU?=
 =?utf-8?B?TmJtTEVBSVZHK09NTUJHclU1SHhScCtUKzlUZjI2MVB2UmRTRGhxa21JeXpa?=
 =?utf-8?B?ck94bThaWDVPQ2tablM1QkNGSXNMUDgxWk9tYzBUbEFLTWhqZ0E2amRUa1RY?=
 =?utf-8?B?cUQzUElkWWxKcEFwNTJ4S3BTdHR5NDJCYVZ5bytaNUd3N1ltWmptS2x1RktF?=
 =?utf-8?B?MFBGc1lBM3RJeEpONm8rODJMNFU0OWN0SDgzZUtEZEsyRWdOZlcwSkUrV3JP?=
 =?utf-8?B?R0VFK21nUkI0aURIbCtYSjFrN01wcXhWaGJUZVVXMnhYemxybFBTODU2ZS9j?=
 =?utf-8?B?ZCtFVmNKSUtYTmRPaG95M2VsZEZMcFdtVVEwaDVudlpLTkl1eWhZZmV3dGF2?=
 =?utf-8?B?bWpqdDZqbTB3NjM5WEpSS2loRm5ybjRuWkUvZFdmbGE5NmZVVjBuREFBZVRX?=
 =?utf-8?B?NkJuRmVUcTNDTXh2VjdmaG42Nnd1MUk3b1puWG1BcGFJczRHTjZrUHRRbHNm?=
 =?utf-8?B?cS9ZbEhPQWFkckdLRW1yOTQ1YjkySVN0ZWx6bGhxNE11TFFQbFAyQ2cxaEVS?=
 =?utf-8?B?cmNocU1LYWk1TXI4Tml2aldEdllkQ0E2a2lQNUNMSDZETitaUjhVWlp1dVR4?=
 =?utf-8?B?cTJUOUErYzdCc1RSZ2hyTzdIQWl5YisrT2k0VmFlQjdRUWtyMlJuWWJlQlZz?=
 =?utf-8?B?d2NJQURwYlBGam5oQk4xT0VBY1dFdWZSb2RHSkVoNmJrc2VBTUNZTEV0alJv?=
 =?utf-8?B?WWhIdEFwVk40UnpTMDloZVhlV2tNM0lJaVVOV3VYeXplT2xoNzdtUmlvdmRF?=
 =?utf-8?B?c0dVMUQ2c0VOTHJ1WFdPZXc1bTRlZ3p2TkpLZnZIQ3NkdGRJT0RUSFp3NHBU?=
 =?utf-8?B?NDJJeFlyME5vMm11QXpDcjR6Uk52K3VsYitSZkZySUpUK2hMUGFacUkzdTJx?=
 =?utf-8?B?SmtkM1hCRVdybUs3RndabmRVcUxoaEI5MHYvb0YvVjNIWExma3E4NzRkOS9M?=
 =?utf-8?B?bll2ZnNSaCtCUGV4aU8zTCt4T2V2cU81bFQwNWpaODBSY0czVXhGbFBFMXBX?=
 =?utf-8?B?NmVMSHlsOCt0UzBzNjE3b1d3TFkwUjg2WmJPcHc0ZlVTaHJKNE5iOG0rWWlB?=
 =?utf-8?B?VFIvNWNJbDlJYUdmMjB6S2U4SkxzUUJLWFlqc2RzZTdSZVZ5K1F2WHpDSzVh?=
 =?utf-8?B?Wm9JUzcraHFkOEw2cktPTGFxdnBaZTBNcUdUeGNSSW5CdXJMT0xBUjlmbVZq?=
 =?utf-8?B?NHJzQVpqNGpaMkYvN2pIeS80M1N2V3h0WE9PVUovc1ptbHhhWmVmU2tiWVdK?=
 =?utf-8?B?VnBQSFlZNnhBOHo1cjkrYTg4dk5PYmpQRHhFczBUeVBuY2FKdld6MVZDSE9y?=
 =?utf-8?Q?tsz6rDlpQsTqRP0hxwF+IZI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778449d6-ac98-432b-ba59-08d9f0457dd2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 05:39:10.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BwvLmGoZtBKSVp9JJIVMdsMkkngrP+VWa7K+FYY9CQS0vKjtkr55ozWlqdDCAuCOb4b5tmhUkj4Lh3YY9MDqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add NTB function driver and virtual PCI BUS and Virtual NTB driver
to implement communication between PCIe RC and PCIe EP devices

┌────────────┐         ┌─────────────────────────────────────┐
│            │         │                                     │
├────────────┤         │                      ┌──────────────┤
│ NTB        │         │                      │ NTB          │
│ NetDev     │         │                      │ NetDev       │
├────────────┤         │                      ├──────────────┤
│ NTB        │         │                      │ NTB          │
│ Transfer   │         │                      │ Transfer     │
├────────────┤         │                      ├──────────────┤
│            │         │                      │              │
│  PCI NTB   │         │                      │              │
│    EPF     │         │                      │              │
│   Driver   │         │                      │ PCI Virtual  │
│            │         ├───────────────┐      │ NTB Driver   │
│            │         │ PCI EP NTB    │◄────►│              │
│            │         │  FN Driver    │      │              │
├────────────┤         ├───────────────┤      ├──────────────┤
│            │         │               │      │              │
│  PCI BUS   │ ◄─────► │  PCI EP BUS   │      │  Virtual PCI │
│            │  PCI    │               │      │     BUS      │
└────────────┘         └───────────────┴──────┴──────────────┘
    PCI RC                        PCI EP

This driver include 3 part:
 1 PCI EP NTB function driver
 2 Virtual PCI bus
 3 PCI virutal NTB driver, which is loaded only by above virtual pci bus

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/Kconfig        |   11 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1425 +++++++++++++++++
 3 files changed, 1437 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 5f1242ca2f4e4..362555b024e8f 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -25,3 +25,14 @@ config PCI_EPF_NTB
 	  device tree.
 
 	  If in doubt, say "N" to disable Endpoint NTB driver.
+
+config PCI_EPF_VNTB
+        tristate "PCI Endpoint NTB driver"
+        depends on PCI_ENDPOINT
+        select CONFIGFS_FS
+        help
+          Select this configuration option to enable the Non-Transparent
+          Bridge (NTB) driver for PCI Endpoint. NTB driver implements NTB
+          between PCI host and PCIe Endpoint.
+
+          If in doubt, say "N" to disable Endpoint NTB driver.
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 96ab932a537a2..5c13001deaba1 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
+obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
new file mode 100644
index 0000000000000..ebf7e243eefa4
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -0,0 +1,1425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Endpoint Function Driver to implement Non-Transparent Bridge functionality
+ * Between PCI RC and EP
+ *
+ * Copyright (C) 2020 Texas Instruments
+ * Copyright (C) 2022 NXP
+ *
+ * Based on pci-epf-ntb.c
+ * Author: Frank Li <Frank.Li@nxp.com>
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+/**
+ * +------------+         +---------------------------------------+
+ * |            |         |                                       |
+ * +------------+         |                        +--------------+
+ * | NTB        |         |                        | NTB          |
+ * | NetDev     |         |                        | NetDev       |
+ * +------------+         |                        +--------------+
+ * | NTB        |         |                        | NTB          |
+ * | Transfer   |         |                        | Transfer     |
+ * +------------+         |                        +--------------+
+ * |            |         |                        |              |
+ * |  PCI NTB   |         |                        |              |
+ * |    EPF     |         |                        |              |
+ * |   Driver   |         |                        | PCI Virtual  |
+ * |            |         +---------------+        | NTB Driver   |
+ * |            |         | PCI EP NTB    |<------>|              |
+ * |            |         |  FN Driver    |        |              |
+ * +------------+         +---------------+        +--------------+
+ * |            |         |               |        |              |
+ * |  PCI BUS   | <-----> |  PCI EP BUS   |        |  Virtual PCI |
+ * |            |  PCI    |               |        |     BUS      |
+ * +------------+         +---------------+--------+--------------+
+ *     PCI RC                        PCI EP
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/ntb.h>
+
+static struct workqueue_struct *kpcintb_workqueue;
+
+#define COMMAND_CONFIGURE_DOORBELL	1
+#define COMMAND_TEARDOWN_DOORBELL	2
+#define COMMAND_CONFIGURE_MW		3
+#define COMMAND_TEARDOWN_MW		4
+#define COMMAND_LINK_UP			5
+#define COMMAND_LINK_DOWN		6
+
+#define COMMAND_STATUS_OK		1
+#define COMMAND_STATUS_ERROR		2
+
+#define LINK_STATUS_UP			BIT(0)
+
+#define SPAD_COUNT			64
+#define DB_COUNT			4
+#define NTB_MW_OFFSET			2
+#define DB_COUNT_MASK			GENMASK(15, 0)
+#define MSIX_ENABLE			BIT(16)
+#define MAX_DB_COUNT			32
+#define MAX_MW				4
+
+#define VNTB_VID			0x1957
+#define VNTB_PID			0x080A
+
+enum epf_ntb_bar {
+	BAR_CONFIG,
+	BAR_DB,
+	BAR_MW0,
+	BAR_MW1,
+	BAR_MW2,
+};
+
+/*
+ * +--------------------------------------------------+ Base
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * |          Common Control Register                 |
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * +-----------------------+--------------------------+ Base+span_offset
+ * |                       |                          |
+ * |    Peer Span Space    |    Span Space            |
+ * |                       |                          |
+ * |                       |                          |
+ * +-----------------------+--------------------------+ Base+span_offset
+ * |                       |                          |     +span_count * 4
+ * |                       |                          |
+ * |     Span Space        |   Peer Span Space        |
+ * |                       |                          |
+ * +-----------------------+--------------------------+
+ *       Virtual PCI             Pcie Endpoint
+ *       NTB Driver               NTB Driver
+ */
+struct epf_ntb_ctrl {
+	u32     command;
+	u32     argument;
+	u16     command_status;
+	u16     link_status;
+	u32     topology;
+	u64     addr;
+	u64     size;
+	u32     num_mws;
+	u32	reserved;
+	u32     spad_offset;
+	u32     spad_count;
+	u32	db_entry_size;
+	u32     db_data[MAX_DB_COUNT];
+	u32     db_offset[MAX_DB_COUNT];
+} __packed;
+
+struct epf_ntb {
+	struct ntb_dev ntb;
+	struct pci_epf *epf;
+	struct config_group group;
+
+	u32 num_mws;
+	u32 db_count;
+	u32 spad_count;
+	u64 mws_size[MAX_MW];
+	u64 db;
+	u32 vbus_number;
+
+	bool linkup;
+	u32 spad_size;
+
+	enum pci_barno epf_ntb_bar[6];
+
+	struct epf_ntb_ctrl *reg;
+
+	phys_addr_t epf_db_phy;
+	void __iomem *epf_db;
+
+	phys_addr_t vpci_mw_phy[MAX_MW];
+	void __iomem *vpci_mw_addr[MAX_MW];
+
+	struct delayed_work cmd_handler;
+};
+
+#define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
+#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
+
+static struct pci_epf_header epf_ntb_header = {
+	.vendorid	= PCI_ANY_ID,
+	.deviceid	= PCI_ANY_ID,
+	.baseclass_code	= PCI_BASE_CLASS_MEMORY,
+	.interrupt_pin	= PCI_INTERRUPT_INTA,
+};
+
+/**
+ * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @link_up: true or false indicating Link is UP or Down
+ *
+ * Once NTB function in HOST invoke ntb_link_enable(),
+ * this NTB function driver will trigger a link event to vhost.
+ */
+static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
+{
+	if (link_up)
+		ntb->reg->link_status |= LINK_STATUS_UP;
+	else
+		ntb->reg->link_status &= ~LINK_STATUS_UP;
+
+	ntb_link_event(&ntb->ntb);
+	return 0;
+}
+
+/**
+ * epf_ntb_configure_mw() - Configure the Outbound Address Space for vhost
+ *   to access the memory window of host
+ * @ntb: NTB device that facilitates communication between host and vhost
+ * @mw: Index of the memory window (either 0, 1, 2 or 3)
+ *
+ *                          EP Outbound Window
+ * +--------+              +-----------+
+ * |        |              |           |
+ * |        |              |           |
+ * |        |              |           |
+ * |        |              |           |
+ * |        |              +-----------+
+ * | Virtual|              | Memory Win|
+ * | NTB    | -----------> |           |
+ * | Driver |              |           |
+ * |        |              +-----------+
+ * |        |              |           |
+ * |        |              |           |
+ * +--------+              +-----------+
+ *  VHost                   PCI EP
+ */
+static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
+{
+	phys_addr_t phys_addr;
+	u8 func_no, vfunc_no;
+	u64 addr, size;
+	int ret = 0;
+
+	phys_addr = ntb->vpci_mw_phy[mw];
+	addr = ntb->reg->addr;
+	size = ntb->reg->size;
+
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+
+	ret = pci_epc_map_addr(ntb->epf->epc, func_no, vfunc_no, phys_addr, addr, size);
+	if (ret)
+		dev_err(&ntb->epf->epc->dev,
+			"intf: Failed to map memory window %d address\n", mw);
+	return ret;
+}
+
+/**
+ * epf_ntb_teardown_mw() - Teardown the configured OB ATU
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ * @mw: Index of the memory window (either 0, 1, 2 or 3)
+ *
+ * Teardown the configured OB ATU configured in epf_ntb_configure_mw() using
+ * pci_epc_unmap_addr()
+ */
+static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
+{
+	pci_epc_unmap_addr(ntb->epf->epc,
+			   ntb->epf->func_no,
+			   ntb->epf->vfunc_no,
+			   ntb->vpci_mw_phy[mw]);
+}
+
+/**
+ * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
+ * @work: work_struct for the epf_ntb_epc
+ *
+ * Workqueue function that gets invoked for the two epf_ntb_epc
+ * periodically (once every 5ms) to see if it has received any commands
+ * from NTB host. The host can send commands to configure doorbell or
+ * configure memory window or to update link status.
+ */
+static void epf_ntb_cmd_handler(struct work_struct *work)
+{
+	struct epf_ntb_ctrl *ctrl;
+	u32 command, argument;
+	struct epf_ntb *ntb;
+	struct device *dev;
+	int ret;
+	int i;
+
+	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
+
+	for (i = 1; i < ntb->db_count; i++) {
+		if (readl(ntb->epf_db + i * 4)) {
+			if (readl(ntb->epf_db + i * 4))
+				ntb->db |= 1 << (i - 1);
+
+			ntb_db_event(&ntb->ntb, i);
+			writel(0, ntb->epf_db + i * 4);
+		}
+	}
+
+	ctrl = ntb->reg;
+	command = ctrl->command;
+	if (!command)
+		goto reset_handler;
+	argument = ctrl->argument;
+
+	ctrl->command = 0;
+	ctrl->argument = 0;
+
+	ctrl = ntb->reg;
+	dev = &ntb->epf->dev;
+
+	switch (command) {
+	case COMMAND_CONFIGURE_DOORBELL:
+		ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	case COMMAND_TEARDOWN_DOORBELL:
+		ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	case COMMAND_CONFIGURE_MW:
+		ret = epf_ntb_configure_mw(ntb, argument);
+		if (ret < 0)
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+		else
+			ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	case COMMAND_TEARDOWN_MW:
+		epf_ntb_teardown_mw(ntb, argument);
+		ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	case COMMAND_LINK_UP:
+		ntb->linkup = true;
+		ret = epf_ntb_link_up(ntb, true);
+		if (ret < 0)
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+		else
+			ctrl->command_status = COMMAND_STATUS_OK;
+		goto reset_handler;
+	case COMMAND_LINK_DOWN:
+		ntb->linkup = false;
+		ret = epf_ntb_link_up(ntb, false);
+		if (ret < 0)
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+		else
+			ctrl->command_status = COMMAND_STATUS_OK;
+		break;
+	default:
+		dev_err(dev, "intf UNKNOWN command: %d\n", command);
+		break;
+	}
+
+reset_handler:
+	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
+			   msecs_to_jiffies(5));
+}
+
+/**
+ * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
+ * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
+ *	     address.
+ *
+ * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
+ * self scratchpad region (removes inbound ATU configuration). While BAR0 is
+ * the default self scratchpad BAR, an NTB could have other BARs for self
+ * scratchpad (because of reserved BARs). This function can get the exact BAR
+ * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
+ *
+ * Please note the self scratchpad region and config region is combined to
+ * a single region and mapped using the same BAR. Also note HOST2's peer
+ * scratchpad is HOST1's self scratchpad.
+ */
+static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
+{
+	struct pci_epf_bar *epf_bar;
+	enum pci_barno barno;
+
+	barno = ntb->epf_ntb_bar[BAR_CONFIG];
+	epf_bar = &ntb->epf->bar[barno];
+
+	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+}
+
+/**
+ * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
+ * self scratchpad region.
+ *
+ * Please note the self scratchpad region and config region is combined to
+ * a single region and mapped using the same BAR.
+ */
+static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
+{
+	struct pci_epf_bar *epf_bar;
+	enum pci_barno barno;
+	u8 func_no, vfunc_no;
+	struct device *dev;
+	int ret;
+
+	dev = &ntb->epf->dev;
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+	barno = ntb->epf_ntb_bar[BAR_CONFIG];
+	epf_bar = &ntb->epf->bar[barno];
+
+	ret = pci_epc_set_bar(ntb->epf->epc, func_no, vfunc_no, epf_bar);
+	if (ret) {
+		dev_err(dev, "inft: Config/Status/SPAD BAR set failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+/**
+ * epf_ntb_config_spad_bar_free() - Free the physical memory associated with
+ *   config + scratchpad region
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ */
+static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
+{
+	enum pci_barno barno;
+
+	barno = ntb->epf_ntb_bar[BAR_CONFIG];
+	pci_epf_free_space(ntb->epf, ntb->reg, barno, 0);
+}
+
+/**
+ * epf_ntb_config_spad_bar_alloc() - Allocate memory for config + scratchpad
+ *   region
+ * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ *
+ * Allocate the Local Memory mentioned in the above diagram. The size of
+ * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
+ * is obtained from "spad-count" configfs entry.
+ */
+static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
+{
+	size_t align;
+	enum pci_barno barno;
+	struct epf_ntb_ctrl *ctrl;
+	u32 spad_size, ctrl_size;
+	u64 size;
+	struct pci_epf *epf = ntb->epf;
+	struct device *dev = &epf->dev;
+	u32 spad_count;
+	void *base;
+	int i;
+	const struct pci_epc_features *epc_features = pci_epc_get_features(epf->epc,
+								epf->func_no,
+								epf->vfunc_no);
+	barno = ntb->epf_ntb_bar[BAR_CONFIG];
+	size = epc_features->bar_fixed_size[barno];
+	align = epc_features->align;
+
+	if ((!IS_ALIGNED(size, align)))
+		return -EINVAL;
+
+	spad_count = ntb->spad_count;
+
+	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	spad_size = 2 * spad_count * 4;
+
+	if (!align) {
+		ctrl_size = roundup_pow_of_two(ctrl_size);
+		spad_size = roundup_pow_of_two(spad_size);
+	} else {
+		ctrl_size = ALIGN(ctrl_size, align);
+		spad_size = ALIGN(spad_size, align);
+	}
+
+	if (!size)
+		size = ctrl_size + spad_size;
+	else if (size < ctrl_size + spad_size)
+		return -EINVAL;
+
+	base = pci_epf_alloc_space(epf, size, barno, align, 0);
+	if (!base) {
+		dev_err(dev, "intf: Config/Status/SPAD alloc region fail\n");
+		return -ENOMEM;
+	}
+
+	ntb->reg = base;
+
+	ctrl = ntb->reg;
+	ctrl->spad_offset = ctrl_size;
+
+	ctrl->spad_count = spad_count;
+	ctrl->num_mws = ntb->num_mws;
+	ntb->spad_size = spad_size;
+
+	ctrl->db_entry_size = 4;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		ntb->reg->db_data[i] = 1 + i;
+		ntb->reg->db_offset[i] = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ * Configure MSI/MSI-X capability for each interface with number of
+ * interrupts equal to "db_count" configfs entry.
+ */
+static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	bool msix_capable, msi_capable;
+	u8 func_no, vfunc_no;
+	struct device *dev;
+	u32 db_count;
+	int ret;
+
+	dev = &ntb->epf->dev;
+
+	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+	msix_capable = epc_features->msix_capable;
+	msi_capable = epc_features->msi_capable;
+
+	if (!(msix_capable || msi_capable)) {
+		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
+		return -EINVAL;
+	}
+
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+
+	db_count = ntb->db_count;
+	if (db_count > MAX_DB_COUNT) {
+		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
+		return -EINVAL;
+	}
+
+	ntb->db_count = db_count;
+
+	if (msi_capable) {
+		ret = pci_epc_set_msi(ntb->epf->epc, func_no, vfunc_no, 16);
+		if (ret) {
+			dev_err(dev, "intf: MSI configuration failed\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * epf_ntb_db_bar_init() - Configure Doorbell window BARs
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ */
+static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	u32 align;
+	struct device *dev = &ntb->epf->dev;
+	int ret;
+	struct pci_epf_bar *epf_bar;
+	void __iomem *mw_addr;
+	enum pci_barno barno;
+	size_t size = 4 * ntb->db_count;
+
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+	align = epc_features->align;
+
+	if (size < 128)
+		size = 128;
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
+
+	barno = ntb->epf_ntb_bar[BAR_DB];
+
+	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+	if (!mw_addr) {
+		dev_err(dev, "intf: Failed to allocate OB address\n");
+		return -ENOMEM;
+	}
+
+	ntb->epf_db = mw_addr;
+
+	epf_bar = &ntb->epf->bar[barno];
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+	if (ret) {
+		dev_err(dev, "intf: DoorBell BAR set failed\n");
+			goto err_alloc_peer_mem;
+	}
+	return ret;
+
+err_alloc_peer_mem:
+	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
+	return -1;
+}
+
+/**
+ * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
+ *   allocated in peers outbound address space
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ */
+static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
+{
+	enum pci_barno barno;
+
+	barno = ntb->epf_ntb_bar[BAR_DB];
+	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
+	pci_epc_clear_bar(ntb->epf->epc,
+			  ntb->epf->func_no,
+			  ntb->epf->vfunc_no,
+			  &ntb->epf->bar[barno]);
+}
+
+/**
+ * epf_ntb_mw_bar_init() - Configure Memory window BARs
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ */
+static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
+{
+	int ret = 0;
+	int i;
+	u64 size;
+	enum pci_barno barno;
+	struct device *dev = &ntb->epf->dev;
+
+	for (i = 0; i < ntb->num_mws; i++) {
+
+		size = ntb->mws_size[i];
+
+		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+
+		ntb->epf->bar[barno].barno = barno;
+		ntb->epf->bar[barno].size = size;
+		ntb->epf->bar[barno].addr = 0;
+		ntb->epf->bar[barno].phys_addr = 0;
+		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
+				PCI_BASE_ADDRESS_MEM_TYPE_64 :
+				PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+		ret = pci_epc_set_bar(ntb->epf->epc,
+				      ntb->epf->func_no,
+				      ntb->epf->vfunc_no,
+				      &ntb->epf->bar[barno]);
+		if (ret) {
+			dev_err(dev, "intf: MW set failed\n");
+			goto err_alloc_mem;
+		}
+
+		/* allocate epc outbound memory windows to vpci vntb device */
+		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
+							      &ntb->vpci_mw_phy[i],
+							      size);
+		if (!ntb->vpci_mw_addr[i]) {
+			dev_err(dev, "Failed to allocate source address\n");
+			goto err_alloc_mem;
+		}
+	}
+
+	return ret;
+err_alloc_mem:
+	return ret;
+}
+
+/**
+ * epf_ntb_mw_bar_clear() - Clear Memory window BARs
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ */
+static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
+{
+	enum pci_barno barno;
+	int i;
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+		pci_epc_clear_bar(ntb->epf->epc,
+				  ntb->epf->func_no,
+				  ntb->epf->vfunc_no,
+				  &ntb->epf->bar[barno]);
+
+		pci_epc_mem_free_addr(ntb->epf->epc,
+				      ntb->vpci_mw_phy[i],
+				      ntb->vpci_mw_addr[i],
+				      ntb->mws_size[i]);
+	}
+}
+
+/**
+ * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
+ */
+static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
+{
+	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
+	pci_epc_put(ntb->epf->epc);
+}
+
+/**
+ * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
+ * constructs (scratchpad region, doorbell, memorywindow)
+ * @ntb: NTB device that facilitates communication between HOST and vHOST
+ *
+ */
+static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *epc_features;
+	enum pci_barno barno;
+	enum epf_ntb_bar bar;
+	struct device *dev;
+	u32 num_mws;
+	int i;
+
+	barno = BAR_0;
+	num_mws = ntb->num_mws;
+	dev = &ntb->epf->dev;
+	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+
+	/* These are required BARs which are mandatory for NTB functionality */
+	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
+		barno = pci_epc_get_next_free_bar(epc_features, barno);
+		if (barno < 0) {
+			dev_err(dev, "intf: Fail to get NTB function BAR\n");
+			return barno;
+		}
+		ntb->epf_ntb_bar[bar] = barno;
+	}
+
+	/* These are optional BARs which don't impact NTB functionality */
+	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, barno++, i++) {
+		barno = pci_epc_get_next_free_bar(epc_features, barno);
+		if (barno < 0) {
+			ntb->num_mws = i;
+			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
+		}
+		ntb->epf_ntb_bar[bar] = barno;
+	}
+
+	return 0;
+}
+
+/**
+ * epf_ntb_epc_init() - Initialize NTB interface
+ * @ntb: NTB device that facilitates communication between HOST and vHOST2
+ *
+ * Wrapper to initialize a particular EPC interface and start the workqueue
+ * to check for commands from host. This function will write to the
+ * EP controller HW for configuring it.
+ */
+static int epf_ntb_epc_init(struct epf_ntb *ntb)
+{
+	u8 func_no, vfunc_no;
+	struct pci_epc *epc;
+	struct pci_epf *epf;
+	struct device *dev;
+	int ret;
+
+	epf = ntb->epf;
+	dev = &epf->dev;
+	epc = epf->epc;
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+
+	ret = epf_ntb_config_sspad_bar_set(ntb);
+	if (ret) {
+		dev_err(dev, "intf: Config/self SPAD BAR init failed");
+		return ret;
+	}
+
+	ret = epf_ntb_configure_interrupt(ntb);
+	if (ret) {
+		dev_err(dev, "intf: Interrupt configuration failed\n");
+		goto err_config_interrupt;
+	}
+
+	ret = epf_ntb_db_bar_init(ntb);
+	if (ret) {
+		dev_err(dev, "intf: DB BAR init failed\n");
+		goto err_db_bar_init;
+	}
+
+	ret = epf_ntb_mw_bar_init(ntb);
+	if (ret) {
+		dev_err(dev, "intf: MW BAR init failed\n");
+		goto err_mw_bar_init;
+	}
+
+	if (vfunc_no <= 1) {
+		ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
+		if (ret) {
+			dev_err(dev, "intf: Configuration header write failed\n");
+			goto err_write_header;
+		}
+	}
+
+	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
+	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
+
+	return 0;
+
+err_write_header:
+	epf_ntb_mw_bar_clear(ntb);
+err_mw_bar_init:
+	epf_ntb_db_bar_clear(ntb);
+err_db_bar_init:
+err_config_interrupt:
+	epf_ntb_config_sspad_bar_clear(ntb);
+
+	return ret;
+}
+
+
+/**
+ * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
+ * @ntb: NTB device that facilitates communication between HOST1 and HOST2
+ *
+ * Wrapper to cleanup all NTB interfaces.
+ */
+static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
+{
+	epf_ntb_db_bar_clear(ntb);
+	epf_ntb_mw_bar_clear(ntb);
+}
+
+#define EPF_NTB_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+									\
+	return sprintf(page, "%d\n", ntb->_name);			\
+}
+
+#define EPF_NTB_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	u32 val;							\
+	int ret;							\
+									\
+	ret = kstrtou32(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	ntb->_name = val;						\
+									\
+	return len;							\
+}
+
+#define EPF_NTB_MW_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	int win_no;							\
+									\
+	sscanf(#_name, "mw%d", &win_no);				\
+									\
+	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
+}
+
+#define EPF_NTB_MW_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no;							\
+	u64 val;							\
+	int ret;							\
+									\
+	ret = kstrtou64(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
+		return -EINVAL;						\
+									\
+	if (ntb->num_mws < win_no) {					\
+		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+		return -EINVAL;						\
+	}								\
+									\
+	ntb->mws_size[win_no - 1] = val;				\
+									\
+	return len;							\
+}
+
+static ssize_t epf_ntb_num_mws_store(struct config_item *item,
+				     const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct epf_ntb *ntb = to_epf_ntb(group);
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(page, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > MAX_MW)
+		return -EINVAL;
+
+	ntb->num_mws = val;
+
+	return len;
+}
+
+EPF_NTB_R(spad_count)
+EPF_NTB_W(spad_count)
+EPF_NTB_R(db_count)
+EPF_NTB_W(db_count)
+EPF_NTB_R(num_mws)
+EPF_NTB_R(vbus_number)
+EPF_NTB_W(vbus_number)
+EPF_NTB_MW_R(mw1)
+EPF_NTB_MW_W(mw1)
+EPF_NTB_MW_R(mw2)
+EPF_NTB_MW_W(mw2)
+EPF_NTB_MW_R(mw3)
+EPF_NTB_MW_W(mw3)
+EPF_NTB_MW_R(mw4)
+EPF_NTB_MW_W(mw4)
+
+CONFIGFS_ATTR(epf_ntb_, spad_count);
+CONFIGFS_ATTR(epf_ntb_, db_count);
+CONFIGFS_ATTR(epf_ntb_, num_mws);
+CONFIGFS_ATTR(epf_ntb_, mw1);
+CONFIGFS_ATTR(epf_ntb_, mw2);
+CONFIGFS_ATTR(epf_ntb_, mw3);
+CONFIGFS_ATTR(epf_ntb_, mw4);
+CONFIGFS_ATTR(epf_ntb_, vbus_number);
+
+static struct configfs_attribute *epf_ntb_attrs[] = {
+	&epf_ntb_attr_spad_count,
+	&epf_ntb_attr_db_count,
+	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_mw1,
+	&epf_ntb_attr_mw2,
+	&epf_ntb_attr_mw3,
+	&epf_ntb_attr_mw4,
+	&epf_ntb_attr_vbus_number,
+	NULL,
+};
+
+static const struct config_item_type ntb_group_type = {
+	.ct_attrs	= epf_ntb_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+/**
+ * epf_ntb_add_cfs() - Add configfs directory specific to NTB
+ * @epf: NTB endpoint function device
+ * @group: A pointer to the config_group structure referencing a group of
+ *	   config_items of a specific type that belong to a specific sub-system.
+ *
+ * Add configfs directory specific to NTB. This directory will hold
+ * NTB specific properties like db_count, spad_count, num_mws etc.,
+ */
+static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
+					    struct config_group *group)
+{
+	struct epf_ntb *ntb = epf_get_drvdata(epf);
+	struct config_group *ntb_group = &ntb->group;
+	struct device *dev = &epf->dev;
+
+	config_group_init_type_name(ntb_group, dev_name(dev), &ntb_group_type);
+
+	return ntb_group;
+}
+
+/*==== virtual PCI bus driver, which only load virutal ntb pci driver ====*/
+
+#define VPCI_BUS_NUM 0x10
+
+uint32_t pci_space[] = {
+	(VNTB_VID | (VNTB_PID << 16)),	//DeviceID, Vendor ID
+	0,		// status, Command
+	0xffffffff,	// Class code, subclass, prog if, revision id
+	0x40,		//bist, header type, latency Timer, cache line size
+	0,		//bar 0
+	0,		//bar 1
+	0,		//bar 2
+	0,		//bar 3
+	0,		//bar 4
+	0,		//bar 5
+	0,		//cardbus cis point
+	0,		//Subsystem ID Subystem vendor id
+	0,		//ROM Base Address
+	0,		//Reserved, Cap. Point
+	0,		//Reserved,
+	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
+};
+
+int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
+{
+	if (devfn == 0) {
+		memcpy(val, ((uint8_t *)pci_space) + where, size);
+		return 0;
+	}
+	return -1;
+}
+
+int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
+{
+	return 0;
+}
+
+struct pci_ops vpci_ops = {
+	.read = pci_read,
+	.write = pci_write,
+};
+
+static int vpci_bus(void *sysdata)
+{
+	struct pci_bus *vpci_bus;
+
+	vpci_bus = pci_scan_bus(VPCI_BUS_NUM, &vpci_ops, sysdata);
+	if (vpci_bus)
+		pr_err("create pci bus\n");
+
+	pci_bus_add_devices(vpci_bus);
+
+	return 0;
+}
+
+/*==================== Virtual PCIe NTB driver ==========================*/
+
+static int vntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	return ndev->num_mws;
+}
+
+static int vntb_epf_spad_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->spad_count;
+}
+
+static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->num_mws;
+}
+
+static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
+{
+	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
+}
+
+static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	return 0;
+}
+
+static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
+		dma_addr_t addr, resource_size_t size)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct pci_epf_bar *epf_bar;
+	enum pci_barno barno;
+	int ret;
+	struct device *dev;
+
+	dev = &ntb->ntb.dev;
+	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
+	epf_bar = &ntb->epf->bar[barno];
+	epf_bar->phys_addr = addr;
+	epf_bar->barno = barno;
+	epf_bar->size = size;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
+	if (ret) {
+		dev_err(dev, "failure set mw trans\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
+{
+	return 0;
+}
+
+static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
+				phys_addr_t *base, resource_size_t *size)
+{
+
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	if (base)
+		*base = ntb->vpci_mw_phy[idx];
+
+	if (size)
+		*size = ntb->mws_size[idx];
+
+	return 0;
+}
+
+static int vntb_epf_link_enable(struct ntb_dev *ntb,
+			enum ntb_speed max_speed,
+			enum ntb_width max_width)
+{
+	return 0;
+}
+
+static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * 4;
+	u32 val;
+	void __iomem *base = ntb->reg;
+
+	val = readl(base + off + ct + idx * 4);
+	return val;
+}
+
+static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct epf_ntb_ctrl *ctrl = ntb->reg;
+	int off = ctrl->spad_offset, ct = ctrl->spad_count * 4;
+	void __iomem *base = ntb->reg;
+
+	writel(val, base + off + ct + idx * 4);
+	return 0;
+}
+
+static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct epf_ntb_ctrl *ctrl = ntb->reg;
+	int off = ctrl->spad_offset;
+	void __iomem *base = ntb->reg;
+	u32 val;
+
+	val = readl(base + off + idx * 4);
+	return val;
+}
+
+static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32 val)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct epf_ntb_ctrl *ctrl = ntb->reg;
+	int off = ctrl->spad_offset;
+	void __iomem *base = ntb->reg;
+
+	writel(val, base + off + idx * 4);
+	return 0;
+}
+
+static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
+{
+	u32 interrupt_num = ffs(db_bits) + 1;
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	u8 func_no, vfunc_no;
+	int ret;
+
+	func_no = ntb->epf->func_no;
+	vfunc_no = ntb->epf->vfunc_no;
+
+	ret = pci_epc_raise_irq(ntb->epf->epc,
+				func_no,
+				vfunc_no,
+				PCI_EPC_IRQ_MSI,
+				interrupt_num + 1);
+	if (ret) {
+		dev_err(&ntb->ntb.dev, "intf: Failed to raise IRQ\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static u64 vntb_epf_db_read(struct ntb_dev *ndev)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	return ntb->db;
+}
+
+static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
+			resource_size_t *addr_align,
+			resource_size_t *size_align,
+			resource_size_t *size_max)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	if (addr_align)
+		*addr_align = SZ_4K;
+
+	if (size_align)
+		*size_align = 1;
+
+	if (size_max)
+		*size_max = ntb->mws_size[idx];
+
+	return 0;
+}
+
+static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
+			enum ntb_speed *speed,
+			enum ntb_width *width)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	return ntb->reg->link_status;
+}
+
+static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
+{
+	return 0;
+}
+
+static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+
+	ntb->db &= ~db_bits;
+	return 0;
+}
+
+static int vntb_epf_link_disable(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static const struct ntb_dev_ops vntb_epf_ops = {
+	.mw_count		= vntb_epf_mw_count,
+	.spad_count		= vntb_epf_spad_count,
+	.peer_mw_count		= vntb_epf_peer_mw_count,
+	.db_valid_mask		= vntb_epf_db_valid_mask,
+	.db_set_mask		= vntb_epf_db_set_mask,
+	.mw_set_trans		= vntb_epf_mw_set_trans,
+	.mw_clear_trans		= vntb_epf_mw_clear_trans,
+	.peer_mw_get_addr	= vntb_epf_peer_mw_get_addr,
+	.link_enable		= vntb_epf_link_enable,
+	.spad_read		= vntb_epf_spad_read,
+	.spad_write		= vntb_epf_spad_write,
+	.peer_spad_read		= vntb_epf_peer_spad_read,
+	.peer_spad_write	= vntb_epf_peer_spad_write,
+	.peer_db_set		= vntb_epf_peer_db_set,
+	.db_read		= vntb_epf_db_read,
+	.mw_get_align		= vntb_epf_mw_get_align,
+	.link_is_up		= vntb_epf_link_is_up,
+	.db_clear_mask		= vntb_epf_db_clear_mask,
+	.db_clear		= vntb_epf_db_clear,
+	.link_disable		= vntb_epf_link_disable,
+};
+
+static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret;
+	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
+	struct device *dev = &pdev->dev;
+
+	ndev->ntb.pdev = pdev;
+	ndev->ntb.topo = NTB_TOPO_NONE;
+	ndev->ntb.ops =  &vntb_epf_ops;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(dev, "Cannot set DMA mask\n");
+		return -1;
+	}
+
+	ret = ntb_register_device(&ndev->ntb);
+	if (ret) {
+		dev_err(dev, "Failed to register NTB device\n");
+		goto err_register_dev;
+	}
+
+	dev_info(dev, "PCI Virtual NTB driver loaded\n");
+	return 0;
+
+err_register_dev:
+	return -1;
+}
+
+static const struct pci_device_id pci_vntb_table[] = {
+	{
+		PCI_DEVICE(VNTB_VID, VNTB_PID),
+	},
+	{},
+};
+
+static struct pci_driver vntb_pci_driver = {
+	.name           = "pci-vntb",
+	.id_table       = pci_vntb_table,
+	.probe          = pci_vntb_probe,
+};
+
+/* ============ PCIe EPF Driver Bind ====================*/
+
+/**
+ * epf_ntb_bind() - Initialize endpoint controller to provide NTB functionality
+ * @epf: NTB endpoint function device
+ *
+ * Initialize both the endpoint controllers associated with NTB function device.
+ * Invoked when a primary interface or secondary interface is bound to EPC
+ * device. This function will succeed only when EPC is bound to both the
+ * interfaces.
+ */
+static int epf_ntb_bind(struct pci_epf *epf)
+{
+	struct epf_ntb *ntb = epf_get_drvdata(epf);
+	struct device *dev = &epf->dev;
+	int ret;
+
+	if (!epf->epc) {
+		dev_dbg(dev, "PRIMARY EPC interface not yet bound\n");
+		return 0;
+	}
+
+	ret = epf_ntb_init_epc_bar(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to create NTB EPC\n");
+		goto err_bar_init;
+	}
+
+	ret = epf_ntb_config_spad_bar_alloc(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to allocate BAR memory\n");
+		goto err_bar_alloc;
+	}
+
+	ret = epf_ntb_epc_init(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to initialize EPC\n");
+		goto err_bar_alloc;
+	}
+
+	epf_set_drvdata(epf, ntb);
+
+	if (pci_register_driver(&vntb_pci_driver)) {
+		dev_err(dev, "failure register vntb pci driver\n");
+		goto err_bar_alloc;
+	}
+
+	vpci_bus(ntb);
+
+	return 0;
+
+err_bar_alloc:
+	epf_ntb_config_spad_bar_free(ntb);
+
+err_bar_init:
+	epf_ntb_epc_destroy(ntb);
+
+	return ret;
+}
+
+/**
+ * epf_ntb_unbind() - Cleanup the initialization from epf_ntb_bind()
+ * @epf: NTB endpoint function device
+ *
+ * Cleanup the initialization from epf_ntb_bind()
+ */
+static void epf_ntb_unbind(struct pci_epf *epf)
+{
+	struct epf_ntb *ntb = epf_get_drvdata(epf);
+
+	epf_ntb_epc_cleanup(ntb);
+	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_epc_destroy(ntb);
+
+	pci_unregister_driver(&vntb_pci_driver);
+}
+
+// EPF driver probe
+static struct pci_epf_ops epf_ntb_ops = {
+	.bind   = epf_ntb_bind,
+	.unbind = epf_ntb_unbind,
+	.add_cfs = epf_ntb_add_cfs,
+};
+
+/**
+ * epf_ntb_probe() - Probe NTB function driver
+ * @epf: NTB endpoint function device
+ *
+ * Probe NTB function driver when endpoint function bus detects a NTB
+ * endpoint function.
+ */
+static int epf_ntb_probe(struct pci_epf *epf)
+{
+	struct epf_ntb *ntb;
+	struct device *dev;
+
+	dev = &epf->dev;
+
+	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
+	if (!ntb)
+		return -ENOMEM;
+
+	epf->header = &epf_ntb_header;
+	ntb->epf = epf;
+	epf_set_drvdata(epf, ntb);
+
+	dev_info(dev, "pci-ep epf driver loaded\n");
+	return 0;
+}
+
+static const struct pci_epf_device_id epf_ntb_ids[] = {
+	{
+		.name = "pci_epf_vntb",
+	},
+	{},
+};
+
+static struct pci_epf_driver epf_ntb_driver = {
+	.driver.name    = "pci_epf_vntb",
+	.probe          = epf_ntb_probe,
+	.id_table       = epf_ntb_ids,
+	.ops            = &epf_ntb_ops,
+	.owner          = THIS_MODULE,
+};
+
+
+static int __init epf_ntb_init(void)
+{
+	int ret;
+
+	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
+					    WQ_HIGHPRI, 0);
+	ret = pci_epf_register_driver(&epf_ntb_driver);
+	if (ret) {
+		destroy_workqueue(kpcintb_workqueue);
+		pr_err("Failed to register pci epf ntb driver --> %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(epf_ntb_init);
+
+static void __exit epf_ntb_exit(void)
+{
+	pci_epf_unregister_driver(&epf_ntb_driver);
+	destroy_workqueue(kpcintb_workqueue);
+}
+module_exit(epf_ntb_exit);
+
+MODULE_DESCRIPTION("PCI EPF NTB DRIVER");
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.0.rc1


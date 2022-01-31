Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36714A3E5C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 08:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiAaHwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 02:52:44 -0500
Received: from mail-gv0che01on2116.outbound.protection.outlook.com ([40.107.23.116]:24929
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237927AbiAaHwo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 02:52:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8Mqip1x1N3ubbpUmFa3nmZ/KVElT/2lbgYcwnPrpqvsrOchMjZX4D0F5Pi5N4iEtZ3h+vmDq99/4KJ5BsiS18BneakewsExR1lgF0IrmCN6lT9utmykDYizCotwJ6yI4OMGJUajZTYT0fQvaRH2aiI4JLWVvwGl3EJ+XkRC/0TDVMiORfhIPFldxFaVl7ce8A5Cfcajyofupf4ElgO45nDwzmCvOVPEQAgTQqW/msim7NZLqmUsBxHOYzuYReDO1FPv+SrYTeWlGNAbiVSOPwQ1zG8AQ0eWU+VrVnvEziMD7iE5GPJ2qdjMVCi0buCeBmkeF2jJoBcBxWQlAAdZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDwr7HV6KU5Vv6PWjmcMfB64UaBmg7KXWt6gaVkEIL0=;
 b=CxMvUYGIPLkK3O1O7OMDN33A/GGDgh3p9nJGaKPZ+5cMG8KALwZiHe2SezbGsFNkya0ts6O+enoexeAyTeUn/JPaFSp7QfCR7hATvYShEvbzwROErgnVRfK0W2LyNwIFtEU2VVU7nJMpgO2wxloV8DNyBCfK9lrWhDkx1nCWoY+RdsHr32qm18xm91WqggAsBr8l5QqGdqD6wfWzX0rVsx40YoOV0ysMm/U10u3x6PLcv8niHHz0WHlgeNvXJXgRcWjr5OuHhAwTWcypJFK45onSz6jZWY9e9AQOhi6OCLhN+2nZXlqcB1+jU9wMZNh4e1Zm0tRUF/+aLoy1rNE8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDwr7HV6KU5Vv6PWjmcMfB64UaBmg7KXWt6gaVkEIL0=;
 b=cuhCzas4uCdt3Ei4/SpBbqVgwhlrtvQvg6GZ/t1U9U01GdoqK9lEwDiU8S/wBp4HYlmMdbxKgFqqmGXwCjPOYRNFrjdVkwtWHuWXGcQ4bMGlkBICcVl4ljIz/OGjs1CFEQZEVNRsbHgVeE7X/W9TNoi8V10bwfqRYh2I5mXzijA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GV0P278MB0436.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 07:52:42 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fc21:519b:ba18:7676]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fc21:519b:ba18:7676%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 07:52:42 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] PCI: imx6: Handle the abort from user-space
Date:   Mon, 31 Jan 2022 08:52:35 +0100
Message-Id: <20220131075235.787432-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::15) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b91400-514d-4bf5-52c5-08d9e48ea8da
X-MS-TrafficTypeDiagnostic: GV0P278MB0436:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB04361AB9036E6BD7ED43A8D7E2259@GV0P278MB0436.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+eV9lj3ihEB3F38S4Hq41vLchyReyvEZchn69vUXHWwgGB397jzBrg1HRYlVEWDa8lIVW4XiWnI6w/4dvkiFfRvWqF+NiYyE66xcnVTFjIEcbsZvPkiPiTXIOPNFAFKauEL/CX3eImwlJHiqgnns1b8PNyk6ZMrfXP22CaIEEuysP2ePlfcohTnTUGyK0q8wgzOND0ePG1xRsw7JMiORUZEa5E67r4xyLeIvEleCdEIJFj+umRLavPzZrtwaJfMSvYiBVC+ml77w1u1808GobczAw9dRawXT2x60ZODuUGiHuqbdw+AiJT72V745yW0moZNXAKQF3JvPVapERovrVbSmvBO6fEZeFrdKuEj39TfiwoxgBhlQw8G4J5qBEg66Dj8SU1nmW5YipIyxhqmInz/adwhYR+KgKZ7qvmfLbCj2p+lXJe0ad/p/me9B7RbayDM/BWjqHt216eTSOtKFZNlDl7CxjXw4Ur5y5a9sprBeuNNgPHDAbMA9RJKWNrlu+9E5pFKHNRhkSuQNz0kSth+deF7TJdcA082OFO1U5Q/Av3fSOMKtjKDchYQ6j7GyaetvfejOVb5jJ4F9zu5WWCuzZRZHM+3QHcr+SpV6u1HpC5rIqGZ9aMJBJ5p0Yc0PeQW9dw7SkpOIGL0ioPEXsZPCjgd10VABei4jkGiDhIBcZz7yVsa5F1paAKi279Zr+gDZBU1WRMSBkhbkLgRNAEebYMNA6C3KzUYaXGrf+5LtYNU5UeCnqcwisznNwPwSd6peDNqZmXpLwhrQfdBU/Mip9xHTtKMUO4IXBSHynQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(39840400004)(396003)(136003)(366004)(110136005)(966005)(83380400001)(6486002)(38350700002)(8936002)(36756003)(52116002)(508600001)(66556008)(66476007)(316002)(4326008)(54906003)(66946007)(8676002)(6512007)(921005)(38100700002)(86362001)(44832011)(107886003)(6666004)(26005)(186003)(1076003)(6506007)(7416002)(2616005)(2906002)(5660300002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5xudGt88kvPOnDKUjAU4Uv7ImGpJfI47K0HqsFa3mMf8C7V4YrW9SNFGIDh?=
 =?us-ascii?Q?kCgkr9/oWFZDfLmrIj9Qp6DMqjFiGQcRJiQWBl1uWFn6SmdTFuRFGVgp5pfi?=
 =?us-ascii?Q?IbcVJveZ1GzPw49vK8aXStDSkQlokRFImLWcFCEwhM+zPgfU6g5vJoHIxyUE?=
 =?us-ascii?Q?I8b6Gtn1Hw0gpQi2+F5tDMVJBcHRE8prX/pG8hgbq1sc5AK/omzaQtR6IYx8?=
 =?us-ascii?Q?blrWIFJHGMdR/ZrRH5zbwp+28cSdHolMRX/h8HeqEijBLYws/l+wv1G1mkHC?=
 =?us-ascii?Q?CbB1ySUSOkKieV3r1I97bwYfZ8ZY1y1WQkpSbU5eHb5PIu0wT5Rwz+TMevnz?=
 =?us-ascii?Q?I45FLd1ZYeKj3E5WOkOglOOyG2pP7Xi+2NXpvs352gSLAh7ew13qksVJYnRs?=
 =?us-ascii?Q?tRA2k7KeT5EXl7bgBBfCWPdcu+LoFygmo8oO2onqpL1bnr5HCp6N6J4/M0DP?=
 =?us-ascii?Q?mT18Kj5ms+yWm3tsSt2RLbJc607btsdmiZui/e7Smc1tn7/VHwdsfuPAF+aN?=
 =?us-ascii?Q?CoN6xSmj6yfaF9hTkUNWAy2QOzWSCfNGlTk+TA8Wfm/A7QzWCNburCA1GoI+?=
 =?us-ascii?Q?Y6azQcmAIS+xNqBVLkr1KexNvWNeb2ZMp5HQ7wAGvgqqTqsD5475BiBxs7/C?=
 =?us-ascii?Q?D/Ecue/nfUm4ol0+GOrx17+BRit2wjWCN9JFqfTWMOOEIJWHSboH9rQ6nbTb?=
 =?us-ascii?Q?yn/vkoYSXM5leva0ndQOzYpRfOK1QFOxN6Muog6CmJjzw89K6PWTyGxqr6DS?=
 =?us-ascii?Q?7IunzEXfYL5YamoLHhcvEcq4aBc/mSY9jtQ+tuOWKYoZERZbZcJmCO6t+EyU?=
 =?us-ascii?Q?2GkwrU1JAiHDigT53R6xLWG1Wbw2a2jD0gDUgJxfMTY1ggV8oYe0+CwOptQj?=
 =?us-ascii?Q?dNgj2lLvBx0f9PCjpbUzCZzzTHS9Gbg+m/7ZshBjm9x/f+hoACIwEDDYPXZw?=
 =?us-ascii?Q?FlPV72WESyHHii2zzxk0YD3VnYDpAtKNnwhJOoCuUZCgYHhiol1jN++TGLdC?=
 =?us-ascii?Q?XWQ4BE2ZnxDTMedQj14+HgUNCZkwRRPklVeVbS6RWKV6tbqC7iBBObg8/8Aq?=
 =?us-ascii?Q?+3ZGYnsw7CLPHbgKh5TXI4rbF/cBDOZIx1gPT4H25pB+iFE/UHXbeXWchsP/?=
 =?us-ascii?Q?KrnfGyvR8Vc9iwqkxZWjrVkEKSEGIqLoaGEjwnajcthiRmoZQK35cR/6RXvJ?=
 =?us-ascii?Q?4nOYwrSxrO6Es77/fa8OMJz66QSyBDnBE0qa4x4KwuJTXZ3iAfGp0KkUJDab?=
 =?us-ascii?Q?em+rAPB85zuU/g57KiEFl7hWDRzywCkKUz1D0y04XiIj9tYulbEwDEyjiqDl?=
 =?us-ascii?Q?XAJPTXgsbo70ZfJm7QevincTYB8yH5Pb/XNMH/bsQlSGIgICqAMYk6kl3b+f?=
 =?us-ascii?Q?mEc/MgIg+uq7EydZiU0ioo6pStULzxKqlmMqcyOvRvlakre5y5ti5lGj2ic6?=
 =?us-ascii?Q?a7fLVoyHvdorZUDtrvSWTpDjOoBWW0Zq99w3ag15XwaU09guQ5EHSCiBh6aK?=
 =?us-ascii?Q?cnn3uiVBMo7VfZhrv+yxYw4X4/VyTn2ITaN2fpnQrZ2khdqga1asTFVSj38h?=
 =?us-ascii?Q?QmlQBO7n8UFpgFOMZ5GDL2yO+VE2WayDa/Dsg0V/uka64Uq5HIt7lbKL/Y7R?=
 =?us-ascii?Q?3Geze4wenBcDELO2erGy19OzfwlRCOhw3aKveD6enAFthz8Khh2Blaknb6rd?=
 =?us-ascii?Q?TxFqGA=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b91400-514d-4bf5-52c5-08d9e48ea8da
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 07:52:41.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0kjJUElJKCLduNDKJ/L4nWlxOJjv8p9D6r+pDlTHOALjukD2ixXkTXnG9HIuMVWSJIgGWqCx3qJzDYbD6OEMkoMnD51HwQBqqYt0LZgV9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0436
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jason Liu <jason.hui.liu@nxp.com>

The driver install one hook to handle the external abort, but issue
is that if the abort introduced from user space code, the following
code unsigned long instr = *(unsigned long *)pc; which will created
another data-abort(page domain fault) if CONFIG_CPU_SW_DOMAIN_PAN.

The patch does not intent to use copy_from_user and then do the hack
due to the security consideration. In fact, we can just return and
report the external abort to user-space.

Link: https://lore.kernel.org/all/20220128082920.591115-1-francesco.dolcini@toradex.com
Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
---
rfc -> v1:
 * added Acked-by Lucas Stach
 * include correct header for user_mode()
---
 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6974bd5aa116..c47a05332a94 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/ptrace.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/resource.h>
@@ -297,8 +298,15 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
-	unsigned long instr = *(unsigned long *)pc;
-	int reg = (instr >> 12) & 15;
+	unsigned long instr;
+	int reg;
+
+	/* if the abort from user-space, just return and report it */
+	if (user_mode(regs))
+		return 1;
+
+	instr = *(unsigned long *)pc;
+	reg = (instr >> 12) & 15;
 
 	/*
 	 * If the instruction being executed was a read,
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9B49F518
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 09:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiA1I3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 03:29:25 -0500
Received: from mail-gv0che01on2112.outbound.protection.outlook.com ([40.107.23.112]:30551
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234154AbiA1I3Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 03:29:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KegLF66KZXj3PCJsjjZyEnDYYJt+U4/Yje+HFm9oOinl+uFrKTOyHKotrV8TSw1AL7eBdxFN3mQA3AbsTrfAjAXvwivRegI7unLrNmPRXZ/1cV02DeOoBcTptXOdjq9OqgrsLZ7Uu1yo0n6KtGLEx5B/NvIlD/kegA19pOogGt4rElLHeMh/N1I8v3jCKYITl9hEysJJozOQRb18rEtU0Y2OZ2NmJr28noIYpAGD8eMsqabExj1PQxaMLHFEtOh/j7s+cJ+Y7EHohwqSyLIuLpgYgG3SMjbM/6xHb6nDX0ODd/2oC2v8+w0pizy1QFGFS8h7nisY7Y2zbF+BIP7yvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0rOm2bvPg6yIuIcr6eA/oRZSaHpnC7lSgCeq/+2FmI=;
 b=fbHAf2Fg2QopjYS4xhHadvifMypzbCPWNLwxHlM0bm0LuFA2YRrcDw29g/ATLFShDHyf/RCO3VXtRLqYi4P88g4JoQ8gVaS/1AdoaIjch2OObbLW2EV6C9QhCHqqwWKBfF4k4zNMCV1zAgdYH0WQ18dk/srujSrSs9I8pQu2+d6AfXKo6dGDsxJYeRuyTVjJYsbFLSmBIXma3sf/mFYi4Vvt2+UZse3nXCBFpVItuXk8gz+MKyM7qxFZwzjjcZoQeLrltX59T85tb06pb1kXx7Yrlg62pEs6w7377v/ZDbp2QNqRQgvr40Y1hRnb/wGOOEGaSid1NQO/GRWTl1LR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0rOm2bvPg6yIuIcr6eA/oRZSaHpnC7lSgCeq/+2FmI=;
 b=R2zusSdcH6/77/i6wZEl6O3bKxtnytPvZQ3nbO54pP3M8i+UnLBevJURNV9yHQUQBJNwRzJMY7jtC5CTvX/ZUd7ZkeGTCtTyCKPEOhpBY85lFSOK0Z5GYT1HrBrPKRxfY3qIVtYW1ZBNd4lCrV3+BL3u+9LRT8S612rtbKttQNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GV0P278MB0386.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 08:29:22 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fc21:519b:ba18:7676]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fc21:519b:ba18:7676%3]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 08:29:22 +0000
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
Subject: [RFC PATCH] PCI: imx6: Handle the abort from user-space
Date:   Fri, 28 Jan 2022 09:29:20 +0100
Message-Id: <20220128082920.591115-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::27) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45f1e6af-b28e-4f3d-06f8-08d9e238492d
X-MS-TrafficTypeDiagnostic: GV0P278MB0386:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB03862211A799352A451253EFE2229@GV0P278MB0386.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeUBdSf2JmXHJSOhkFP8UD2F9Nm6xRl2qogf7MBMBytz9nWbCukBnrG8fLhO7p0loTfnM+AHQ5iZcv1ZQFkd3P/5Fn7JAfJ1Kr7XoUsHwv3HYTpXsmidKS4W4MXziC5wjhcvdGxbut1ATpPXt81O8LS9ryQnGiSsCKAhQy3IigQMC8mjQRaClLQvXDpdNB0vx87xUqnKVgHdeekBUDytu/97f/iNHlWJeM0i66rOAGoEEJI1FZ6bEOChu+SDp0ePPzdFpgsI4pYEuVVNQjZOyhaDg6DNhJqUqtcweMJOrdcGH+KzTXBDk3MKgSae5YXsilUOwiINmhFnqna0ty9heqV0kFlexow/Psekv3/z0shyjCKTdRsRHM8kRsEQ9WKVbTRwzUcJ+pgGeB93jlfKGAdTcPkDkniHKwFg8K3mL6Q3G+IMRlwpOalvBuwBEpvP8qV5/7Sk0VfyYY/tT6YBd8ox7yjjfDhTbaOeYKu1BSLq9wqiERwKEvZpYb6dZ3bO3I268ujRmuyKKrEsQq9Z+sAT4wJTgdzyMjDdD45bkj8BKPhqXSr+H2V0Mnu8wP/0o8AziWnpiEfwYdJN0r4jGmPnFdOlAiMZ+qnojrvlsQx5rPdfq6wn4gCFL9cnOEWOOh20dLKnZtNTubvcXlxTfwcTFPCrWiUv1Y7pJPobtaavYmp4S7/96AkmzwT3auRFvLlwMlkUOc6B5864E8azI4REMjtuLTPK/yChzQohzqWuOrzfe2PvRuE6+hg8Y3ToPFzH6IN4QVKY4OQ8cw8w1/m8j14TeCNHgfnUlY+JbOwjfqyawNqysNDtVrKT+Jg+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(366004)(39850400004)(136003)(376002)(921005)(4326008)(38100700002)(38350700002)(86362001)(508600001)(6486002)(966005)(52116002)(6512007)(110136005)(6506007)(54906003)(316002)(66946007)(66556008)(8936002)(8676002)(7416002)(44832011)(66476007)(107886003)(2616005)(26005)(1076003)(186003)(5660300002)(83380400001)(36756003)(2906002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wk6T2yZRtN5gTH1QGt8DDNAzVAEYsic2l0P5iuy3mXpEwD8ReYN/lpIvyG5z?=
 =?us-ascii?Q?rAo4CyshYb8ilKWnbSkz6LCZzcK40MXFPGeBkrXjBjB6ZAufTJZAvYv9IY9Q?=
 =?us-ascii?Q?vj2pFLgzEu30/Feodh8N0Yo7rBloDPsLXfllBZPU2OppY23ZzNxP4XOr2g8Z?=
 =?us-ascii?Q?HESGlqDCmO78foiekrD83ZhvV06FZiKd8eHX3QGQujhhb4/caSyouhZn9Mlg?=
 =?us-ascii?Q?E8YWpDZhXZmoaMjdyEjmh5Pz2rTUx91gFCRTgUSuxNMEXEhvkSYcz4Zap7XI?=
 =?us-ascii?Q?u+IwRLFytzGVPyxBU0YzuHuMNe+KfmXepzTsikZvdWkcbiJ30w88TsyFH9/V?=
 =?us-ascii?Q?Y6HIWQGm7bF+DCQ1my4lVOTLttTexWRnnWI08ZbLbda5Xj2zV/IbDFtpArs6?=
 =?us-ascii?Q?deAQQ2vzGPzyL3gwjrR6rVtOxFl7pa4G7MGMzIxAAGOm/5KzPKHglde+yn2p?=
 =?us-ascii?Q?lCd1hd2YRYAtYZJDUgQ0T7srJlLiC+ZtssKhL7+L5weqvHLIsog7Q/JxBbMX?=
 =?us-ascii?Q?3kSzjrlWix9BvXJA7/ZuzC3TvyapvOgeYafu5/oKZ62Kjjw5me1BIXhnx+DA?=
 =?us-ascii?Q?XkhLcDg1rtQy36QuKegsLoxoL2F9TD6whndl+Z/CHDB1QTVF9G6KrODd7sVX?=
 =?us-ascii?Q?uhmjBXu2cqgZFcX4J9r+atOqaZzUGXStCNN3AfPPcBD9UqwzTu6borOg/LGp?=
 =?us-ascii?Q?cSo8FMXDXwTPnrD8WH31EPK5OH/qrZHGbdyunUp6UJMDDyD/ARF/k4nCW+L5?=
 =?us-ascii?Q?Q+bXDGJFrIrCX5gkTARCT17I8D6/KjUO3Wtkmg578Wh60+tSGaQg/kyXh/fJ?=
 =?us-ascii?Q?i8qUlzt0r3CQxobfiMrR7GMURlTagH6Da3q/NMaCJTuXGU1AX2Cgxp7SLJY+?=
 =?us-ascii?Q?zgSl32WjENO0a2UOSQs+gVSIO6hmhf/A3Qrp1RIpIDskKGIPLMCizGgO11od?=
 =?us-ascii?Q?q4dZCUn0/a9y2wsiypCZaOQNs8yoomsUjYGqn2Dpa1UUpWEfGqBcXVCK+Nua?=
 =?us-ascii?Q?BzQzQGyUpfddiELzTGXD6fQ7qr8TUz0AAAZ3KBHbVqNrbrBuWWE+vDzr9ceH?=
 =?us-ascii?Q?+fgsJuBrrhGsY13hY/fneebIpxTSwerEvzvDHZy5NIyBfk7K4GDQyhnwksQq?=
 =?us-ascii?Q?0xPyso75ROT2OApOkRVqo785mz0ICEZCNG5d8alKy61Nily93IzWq/yn0U+f?=
 =?us-ascii?Q?9SfpVl3GPJlJ+AjgrAi5PTBBOMXQr0Qi2qScW5eaA2im9IBs8CGgFhAZvKEl?=
 =?us-ascii?Q?69K4TsQwkDh/U+FvbHfXoIHrMrF1VztEYlSI165oMxBPS8ivW/ZnqR84nCE3?=
 =?us-ascii?Q?SVZ1m/HBQ9eFjEHNGO3wgHtjzRRkTzO2frywBiE8zAiQdo2Rm0nkHVFMVwhg?=
 =?us-ascii?Q?J8bvkXTR/pxJOgyWZ1hVzuiB2Tg/qa3pSF1TQDHQZtxuxI0KUq1Rqo1ZTGAz?=
 =?us-ascii?Q?jWIaam7F5kZfMktVspcwzoNwh7OXrJTFdRb/sxNxh0DEdAShBJz/fqCip3Dr?=
 =?us-ascii?Q?+dASIu9X7MzxDIJ7hWPXdTSWiBOiAb/zR2bT6jvHxB3MaxCGLQX0wZao4Rl5?=
 =?us-ascii?Q?0GSozh5jIeZvBCYmK/jK/c/0FufGmAKk4v08IHP/RrNsXqKaJ9oylUh9M6Ke?=
 =?us-ascii?Q?q8yRL3Rl0+Os5wv9XwVfP6CVAGWSGkwgJNXoQaZrzAt91f4DgsDYm6TIgInU?=
 =?us-ascii?Q?oLcaKw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f1e6af-b28e-4f3d-06f8-08d9e238492d
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 08:29:22.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6P4cA31WnDBJIcc/svrn9+46miXuq8BvFiIU/I5MTb+tKyF+Q5CLWH1+7G+vk2MglrD2Mf4KbT53xkVXwm0CIr4L91XQQ87f2wQWPzqcFN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0386
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

Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
We have this patch from NXP downstream kernel [1] in our kernel branch [2]
since a long time, to me it would make sense to upstream it. Any concern?

[1] https://source.codeaurora.org/external/imxsupport/linux-imx/commit/?id=62dfb2fb953463dd1b6710567c9e174672a98f24
[2] https://git.toradex.com/cgit/linux-toradex.git/commit/?id=2b42547cf659f979be2defdff6a99f921b33d0f1
---
 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6974bd5aa116..6b178a29e253 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -27,6 +27,7 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
+#include <linux/uaccess.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
 #include <linux/phy/phy.h>
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


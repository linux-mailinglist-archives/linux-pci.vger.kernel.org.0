Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9072ECC40
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAGJEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 04:04:16 -0500
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:29669
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbhAGJEP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 04:04:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2E2yTjx+eX9nev9F1wdOC/EsVLuTXoSrwvX2dr3MMW6Re8WRb3Vty5iKlrooANU7TO26tJqq3hFIJnra7L8ltoAs+wZmjUFcepNG7nc29QUSec3ivLnYpVflJ76NlKYX69MCrTk07faFQFF+wPY0IED4QcwO82Ldbx0CkmwYeiLuxPQHaKpxTKuijffJLZxIdwwqBRG/CkBM6f7ARWOUO/IG6GoWCYLmvMvhSOR8VWaGqHkS1wSGlx0MBwbWs+UUMsNIAM3gAphACOFaSruuwi0Kqc0fxl0Q3gv7CTaNQiACcra/Dpv3gnw0DngPWaHjIzPtd3br6UtzeFyGW6fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlvHZfJZIwzcSkOnZnqPa3+7Mf5EUr5UIPNkC9HD+Yw=;
 b=VtjLZTYeE1L7XZ9mHaRGA/sasu2VZIQVrSsO/wQXemdi/qGzCNjP0bjw0xUt6Q3LY0v/DGZjmMqMNXsbP+MIfUCz6PNZWxqyLgC3c08wHMFcQe/y3Dzcqq/yVvoSzTLT/SHWpdrmtVpjFH9h0ZZyEECm7yJJDSnmdQeDsuuBYJgkuWJdwBZgvKGpJdO+E3yiPjyT57g4zmbsRCSnzErvaVHsoJjdR7emPsDvTsEdnCkZ2lyZ1sxvScH9HIXBgHNVRbVYkov2bY/7TRSUc/kqB/YzlFixbor5BRSwQL09PIrFRRnZEXTXIck3knZVaLpqR8vt82J0/d8dJMk2bxUqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlvHZfJZIwzcSkOnZnqPa3+7Mf5EUr5UIPNkC9HD+Yw=;
 b=Z9MHZ/szCDVOOIMlVKVfMfTYkTYB2drLrK9dtx07r8yp9vJ8uJv0Cz8OCB/lTTufD0Red76sm/JE+HTQea16vSYjgWZTtlvZPMuWE7Zdi7hA+0Ish2kIMueyvuBc0xI8Bp0FzE2Cd9utjYzvAUS5yfBwDMME4L/mhTiJh6iddb4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 09:02:53 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 09:02:53 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@axis.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com
Cc:     kishon@ti.com, minghuan.Lian@nxp.com, jesper.nilsson@axis.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hayashi.kunihiko@socionext.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 3/4] PCI: dwc: Rename callback function func_conf_select and its instance
Date:   Thu,  7 Jan 2021 17:11:22 +0800
Message-Id: <20210107091123.8616-4-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
References: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR06CA0085.apcprd06.prod.outlook.com
 (2603:1096:3:14::11) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0085.apcprd06.prod.outlook.com (2603:1096:3:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 09:02:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 033fc5b0-3f56-4867-355d-08d8b2eb0491
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2731C240FF8F3BADB7F2493E84AF0@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmzCs2hLhybv6TZX7IGklhFTw9AJvvHJ+d7xkcvvzFWHb7lxDKRWr+18nTB3bzZowwOhBYNn0OOjbGjNAMtGawSrxmO3BMmR+IiuW4nzK/X4tXuFoffRcPhboLu+lavu5Y1Xz6CndC/WE52EbbcpoEvHQqJaBy1Zu8xbOiMcx+VuYMH9XUJCz1Y01QU2G4XgUPhjvH2Om7l7kyT8Ulp1gu56ufxT4JIPo1ZIZCHC0EyXZQFy0nyoJhaKTFH7+LSmU2RKgMQbnNBtwJRZeP//v8aszQSNcP2XFcjjRomol6Zsc2g74mi6ywaQ5bf7PlSIPyVqzZjcNqg8v7EVtmQnAzeK6cdVB1Y+QTkf1LkhKy+Nvg1/mEmtI/Qd4FvPXxRAeF32ejAi+ds4Rgpf5sCrsU0ICXRGx1xfCP/I406CDZJwhM8I5YbwDrAQfHVDl0YKT/rXBlp3ljTdWQZA3VDrxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(2616005)(66946007)(16526019)(66476007)(66556008)(186003)(52116002)(86362001)(69590400011)(478600001)(956004)(7416002)(2906002)(26005)(8676002)(316002)(6486002)(8936002)(4326008)(6506007)(6666004)(1076003)(83380400001)(5660300002)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7toAhuEU6OWYCbPOGksaIIBr0nNKNgFdD5g1N4+hQg5lZji0mZUV34KSfvqE?=
 =?us-ascii?Q?9G2b3uIJqvvtTGFsjGccKYRSLy8BMnbVTnHKBrebmKNF/oXclTB1r6vO/eak?=
 =?us-ascii?Q?LFobVV1cF0G9XdyT2gKWVCFFR1jAWpXOw2QW/mygmajS9HMUvz22yRliisnN?=
 =?us-ascii?Q?09C4lxtcNHnvmOsc/L/awk/5uhmgAb8hS+y1Qqt319lRIk6UrGrnnx8/2cUo?=
 =?us-ascii?Q?kGDbZ5e7bEnQAjAh9dxGShVJnao0pNwlvTyP8psitrWjTiWKtiN6A3t7q5fj?=
 =?us-ascii?Q?jyAkw71j43ganXO7zAGPY5Q2kt0ffhKM965ZKAAPyj/qTaQDjeWCJQd1FaMo?=
 =?us-ascii?Q?kjNjwjauZWD6Ps1MGPgRQZBaGk2K4fQy4RtT2PBv7QNkRlNCtYCGXHGoviOY?=
 =?us-ascii?Q?Iarqp/hBNfd2t7pOjPVa3ElxNFMGfOOcjAn46+ifIB7VQ3HXn64lOcJrecdC?=
 =?us-ascii?Q?Qrhf0YIRvrDJUrLfknLUp6kiCRvZtkfBipyPOy+1U4pQ+kUh2sjEIWIpxsEj?=
 =?us-ascii?Q?NnxPdzcZamaqwJuvPc4T8SDbV0rkplUCtalhUzyX+EWyzbgLxiFMVpmXMrIo?=
 =?us-ascii?Q?sPDnn5DsI8SKSTL9CfsxKgiAEWVQQNUVUC2ASjY+WvwwrCofhgyFkkny7QOL?=
 =?us-ascii?Q?l1gyGHr+mCN0A5fmxfLO+4rbGqkhNqxhKY1Vg1qe0jjqdAfmiSnI7lrZ+KEN?=
 =?us-ascii?Q?CNhp3WWVfKOcZVgBL+ZlNtLu4MePuVIzGzXyMJ7G6HpoLcISinFGv+h1MllP?=
 =?us-ascii?Q?dRYCtR6Zh4aAPRAMqHNf26ujTZQi+zs2LO7dDh6bB2If7EyyN8y1MLXlpkB1?=
 =?us-ascii?Q?8C9YzyXHEEWSoYhIjsMMnhRI22XmyLtW3OGQkXd+DIUmVitPQwTyUav0yhSW?=
 =?us-ascii?Q?UjzMuvocvLa2dvhAaNXpduz534VLLXjFUZLWYOrJL/syJHSMwzF75Qsv4zmC?=
 =?us-ascii?Q?wYIzGukKvnm3y0bHvJ+zU4LJRbFtmjDJa2nsnuY6mlgBaqGMw/ekEOfrUEOK?=
 =?us-ascii?Q?z7DN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 09:02:53.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 033fc5b0-3f56-4867-355d-08d8b2eb0491
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTjQGytZK04Q/riacG0M93mb6YJA0cX96aPBhCFMWVGWMrqxjUXge2fY3jFgk0W2qXi0EKqd5dCI/r0nP2b2Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Rename the callback func_conf_select() and its instance and wrapper
to *get_func_cfg_addr(), such that the code becomes more readable.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c  | 6 +++---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 9 +++++----
 drivers/pci/controller/dwc/pcie-designware.h    | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 4d12efdacd2f..0f5e4104c06c 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -87,8 +87,8 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 }
 
-static unsigned int ls_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
-						u8 func_no)
+static unsigned int ls_pcie_ep_get_func_cfg_addr(struct dw_pcie_ep *ep,
+						 u8 func_no)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
@@ -101,7 +101,7 @@ static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
 	.ep_init = ls_pcie_ep_init,
 	.raise_irq = ls_pcie_ep_raise_irq,
 	.get_features = ls_pcie_ep_get_features,
-	.func_conf_select = ls_pcie_ep_func_conf_select,
+	.get_func_cfg_addr = ls_pcie_ep_get_func_cfg_addr,
 };
 
 static const struct ls_pcie_ep_drvdata ls1_ep_drvdata = {
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bc6ad1f96a48..d8eb9a984547 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -40,10 +40,11 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 	return NULL;
 }
 
-static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
+static unsigned int dw_pcie_ep_get_func_cfg_addr(struct dw_pcie_ep *ep,
+						 u8 func_no)
 {
-	if (ep->ops->func_conf_select)
-		return ep->ops->func_conf_select(ep, func_no);
+	if (ep->ops->get_func_cfg_addr)
+		return ep->ops->get_func_cfg_addr(ep, func_no);
 
 	return 0;
 }
@@ -730,7 +731,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	for (i = 0; i < epc->max_functions; i++) {
 		funcs[i].func_no = i;
-		funcs[i].cfg_off = dw_pcie_ep_func_select(ep, i);
+		funcs[i].cfg_off = dw_pcie_ep_get_func_cfg_addr(ep, i);
 		funcs[i].msi_cap = dw_pcie_ep_find_capability(ep, i,
 							      PCI_CAP_ID_MSI);
 		funcs[i].msix_cap = dw_pcie_ep_find_capability(ep, i,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8ee67d4b8109..b8cbe266e01c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -217,7 +217,7 @@ struct dw_pcie_ep_ops {
 	 * return a 0, and implement code in callback function of platform
 	 * driver.
 	 */
-	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
+	unsigned int (*get_func_cfg_addr)(struct dw_pcie_ep *ep, u8 func_no);
 };
 
 struct dw_pcie_ep_func {
-- 
2.17.1


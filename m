Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34681302144
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 05:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbhAYEkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jan 2021 23:40:37 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:54916
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727035AbhAYEka (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Jan 2021 23:40:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKqJIqRXyxyMGWl8VFXiujkC9KDTGTMZUbQAr8dRrhtXiIv8TYgnV8d3YWyRXNLuE7sgcWITDeF1HRxY41bngzCTVHZ3Vsldvy8kLjYCT0AuL9CxG4ZlGNsXTgoL7plsV5QHLQRu86T/RPePvPX0f4UafFlG3/SCbomY1I43VX06b+cA77Hg3lGt3DpmjDVOGmM2T0FQfN9lTMrjikX9NSSLUWvhP4XhjGsCkogXuyTENBXbbGJdpZ99HEIYs++9vX/Yghjfx/i9gqCINpcj7xSXUJjarCbKZcGqDoCDQoeKGZVlD375Z5l6Tz/USHsgsoSI/8c6rgr2NEc4SaRZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCTM7uvMHFkTsWftTg/ryxNdMzuH4WhUMKz1HlZAuYQ=;
 b=br6T1RM52GBSuBa9eUkyORG8ntWmrjRl9f1+iIp2fOqcxjtBk+Z91W9bbD2cMeHWhzHXoKgAPJYnPShZBRxTFHNfVV6a7GQWgHdqRm8BfFrt+MoCrXmrlNqRIiV37dIYu1S3jO+CFMhnu8kEiyMWywjLBKKDz9dOJJLTO7XLHX8kQh8HXgpTmLwxDpbPjYxk/l/FEypgcKOsdvfMXzUA41Qt3T/Sxwms3Ni8SXvwsl1iypCMmYateFUMObnboez0nFZreFb1+eH01oJz5Bf+0CcHXAzNIbQCj0OwN/RMAMXk/Cbic0wHltTzZT3VbRE5fhzzKKfqqAew5Z3goZpmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCTM7uvMHFkTsWftTg/ryxNdMzuH4WhUMKz1HlZAuYQ=;
 b=S1rjIjSNnw3r4B/z0he5AOtBf1w+R5/47h3XUJ/sRMLtzKlInIVnZnrSfGWn5XivTtV+HQPtg8SskOKsIJbQQuBlJZPSq8wshDZs07ALXSZAsOeZGUcMKwF2HhBbpiKmF0IbGFBYCkArcab2uBHRwVfesilCJ1WMBcB9oODDtm8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2555.eurprd04.prod.outlook.com (2603:10a6:3:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 04:39:40 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::d1b3:d2fd:113f:ce47]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::d1b3:d2fd:113f:ce47%4]) with mapi id 15.20.3784.014; Mon, 25 Jan 2021
 04:39:40 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: dwc: Move forward the iATU detection process
Date:   Mon, 25 Jan 2021 12:48:03 +0800
Message-Id: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 04:39:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd358f37-2783-468e-62d2-08d8c0eb39f2
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB25557BD2A3F417667DADB58784BD0@HE1PR0401MB2555.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jm5kwVD0y2Z5ir5CP7Y2OU8ievuABBS1UV0mc+jODQqqMsbGzMnTrFmdB5NWTAlAFWf/cw1+KnKVgQb2zzEP0sBp5X+9N+0l6gy2wgniIR9smehFFDmHb8m6C6JdUsDq98U1lvmMLF7Zn7VS8Qoe6lIykzWW6SNZy72cFI38aJ8yZbLdqhgGLnp/i8+a6FoKjbY5pvcULklUug5OwNV1zHI7qWuMrt4X6f2nLryVrmXsauj8/IjAbuQDjS/e5B2UlmqVY/HFbIL2UQkivukuWbKJnGgKNQS3xveo7bH1O9L+h8F3JoWRZ8Kw0HTYemeacLghkrHlWE20YOfFaBiNObUbmWZYObSIZ6kjw0qyzELtSQeAgm20t9xV9MidkYt14j+1xPF3w51rEHaUV2TQMzgmlzOKTfxuheKK5Y4+2vJkFfaxRVoPXR4a1YLE3ouQgf5ckPtiVY1DG1iIHV6QJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(8936002)(66476007)(6666004)(6506007)(316002)(66556008)(5660300002)(6512007)(66946007)(8676002)(6486002)(83380400001)(956004)(4326008)(1076003)(26005)(478600001)(36756003)(2616005)(16526019)(52116002)(69590400011)(186003)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6JTRCsEtwILlioT1Lynqf+EnkHkV+hsu47KvepZpRV8Mq2AYErK06NhlvPpf?=
 =?us-ascii?Q?fmrudw5y6DE4FwW7PeU3RW16OURNdSBeolvYGEAWaP3cgqePuahfJEBu6jCg?=
 =?us-ascii?Q?jcGZGVRqlv9I8KwC5FGaSRlYDRUz6zkgNoE/GVgQ21fnjcHYr2pEOWETSlhr?=
 =?us-ascii?Q?u6CfASUIz24qB+9xhgOUCcOQFLbbOi6/D8HF81ucAtsOt+9yN4vHEZTmQCEf?=
 =?us-ascii?Q?laESlwtIz/9hoVlRI6V7ILSZpWp3I4jnZiJIe3tjy1Z8sTc60cjffydclIqX?=
 =?us-ascii?Q?rCRSHI3yerPMOQ2FR3p9HjLL4mdC+u66FYd3rMsGKsTJNqPGmrbY9SqNK5Co?=
 =?us-ascii?Q?QwjT+eNcAKGroDqM9gSP9tb0f0jCzb99Uy5b9uKOmvM5KL1KItkz4p+9yKko?=
 =?us-ascii?Q?Q5i191Fm6ZxUD6l1CN046iTIUG+6OEzaNNbN0UCTwwc24M0c1poVCTZwdIJK?=
 =?us-ascii?Q?T2z3+gbSCJl4T0CRd+gvBGUxaDDkRQxUFsNSzxI9f6LJ70MTvn/qbjgTYydA?=
 =?us-ascii?Q?RnAG4vnTbAzJl6ScJ9GaRMsjMQqKQVb6ZKybhfYm6KSl1xouGdgwTfGgWXzm?=
 =?us-ascii?Q?j8q+ChtQs5x0bbx8yTzsdW8Fq62hiPeGJPzAEgcGCn1uqJmaTeZgLDLT9V+6?=
 =?us-ascii?Q?CTTTNRtUuxVvfigWHZ5EFfOApGjnLgou78l8/FUmFW5gSEGkRXNLuSYmlwIg?=
 =?us-ascii?Q?P14lVRagDwbzy4U/hP74ZDDD2X9VCgtRGBoFmSGxWVXnwX4eTHTM10zc8i/x?=
 =?us-ascii?Q?bLBnHB/haMVZ8v5u3kY+I+t9+xCTieQSYjh5/IEN/G4BT7OBv1Ukn+Y2dFnp?=
 =?us-ascii?Q?xXp0cPgP7dneGhT2oH22sB/gak/dALurv+95MDeHPGLTY3iTisQ18rQvXoGL?=
 =?us-ascii?Q?RwhAKZv1YgYVvbet6snXc39VBqN46+jQLaWE8wXinCkBBg1o1kCfJbnM3D68?=
 =?us-ascii?Q?udak9fMBHrXu9nwepmvrIkQUdUChPu/urVdz2PW2Isfzo1rBEgVty8s5PAW3?=
 =?us-ascii?Q?trdmQBimBqIYXpImZkvYMc953zsX9YUqslgUo/YYTkXM6aX1Gf9eTQbaihbx?=
 =?us-ascii?Q?bBkUKQjT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd358f37-2783-468e-62d2-08d8c0eb39f2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 04:39:39.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stEzwiW08WtI6+0kw0fkpEICe5YyEaqoZFCs5UN6vVyJrlzq0Qm3HZzqoYoPkrhuro7Bxxwjb0hNwtVA8LZfBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2555
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

In the dw_pcie_ep_init(), it depends on the detected iATU region
numbers to allocate the in/outbound window management bit map.
It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
of iATU windows").

So this patch move the iATU region detection into a new function,
move forward the detection to the very beginning of functions
dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
from the dw_pcie_setup(), since it's more like a software
perspective initialization step than hardware setup.

Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 ++
 drivers/pci/controller/dwc/pcie-designware-host.c |  2 ++
 drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++---
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bcd1cd9ba8c8..fcf935bf6f5e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -707,6 +707,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		}
 	}
 
+	dw_pcie_iatu_detect(pci);
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
 		return -EINVAL;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 8a84c005f32b..8eae817c138d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -316,6 +316,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			return PTR_ERR(pci->dbi_base);
 	}
 
+	dw_pcie_iatu_detect(pci);
+
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5b72a5448d2e..5b9bf02d918b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -654,11 +654,9 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 	pci->num_ob_windows = ob;
 }
 
-void dw_pcie_setup(struct dw_pcie *pci)
+void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
-	u32 val;
 	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 
 	if (pci->version >= 0x480A || (!pci->version &&
@@ -687,6 +685,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
 
 	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound",
 		 pci->num_ob_windows, pci->num_ib_windows);
+}
+
+void dw_pcie_setup(struct dw_pcie *pci)
+{
+	u32 val;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 
 	if (pci->link_gen > 0)
 		dw_pcie_link_set_max_speed(pci, pci->link_gen);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5d979953800d..867369d4c4f7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -305,6 +305,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 			 enum dw_pcie_region_type type);
 void dw_pcie_setup(struct dw_pcie *pci);
+void dw_pcie_iatu_detect(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-- 
2.17.1


Return-Path: <linux-pci+bounces-253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D06A7FE237
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 22:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E71C20B65
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBDB61688;
	Wed, 29 Nov 2023 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G+fPSZ5G"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829BA8;
	Wed, 29 Nov 2023 13:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3aHqkTkwEcB41AUeFTg75xYDwkQwv1XTUCk4UmEH71MTt3RGbpcUO64jiQ9oYzOzMsTnQ4BgHtXE6sph+fS80mSRek2m3TgT0wHlCsmrsIHWIv3kCaFTkgiR6SyaeBxDxpFQxoQj2dxWHFsSvmJ1QrdFHHuc+X/rt6Gr6zHcSph0TWwHJNRNt4IKzTpil4zEo/BgPkXcdRlGoH7lP/ZWqusMYms1srV6K8PmcgkizG4BJBGPlzGvy04AgRKuiYNKzN5mzGPlfYGEzYnMLtfzObACBFXUqfgB8sJj7KnMJVLYhfqdxxip1ZCAM5Gwc41FWXlvYWGNDSf3BnqdOpvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBCMCWGGXGr2hf98ucqONPAAgP+J1XSzR2QklVebEHo=;
 b=iSeENtggTs+7IbFJMwdIMZfzAjovgjztqmUPOq4tqFN2/LRfBA+CQligcEnCHr3KY/dKEDqxHhT6Du04EMsfCs+drJFeSMOiFd2K8gaUfNEaZOplybK/8ggmLSovwIuZ12ejxIiIXNJgzxrmDmmkFIP+0qtjAUnlTsqBb6Wf64I93lKo/J0rNeqC2qaR/C5zm8cYLAhysEt7iowbOaR1rVn7sNCHfi6h5lJbKxt3dV7wP5Rmq9lu+4Wm6/vuLMUBrIhcKuDHfTZEUCIx+olRDoHlUVOvG72785LRkuogdoC9l+kbMrE5BHgxnJD2a/NtsRpoXg2Dl3JEihOEziB4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBCMCWGGXGr2hf98ucqONPAAgP+J1XSzR2QklVebEHo=;
 b=G+fPSZ5Gheya2hVFV2JynlCLyo2+8be+JHIxL48RLbn3yzBCkL7pcownXyFoKHuw/IeKgiXkrHLduUTdz0+GG1MaoPL1mb2ZhAVIJnoJceqpSfFZBDXhiRPUzqTKRJxgPXMk6wOuvlFuRiZP4hWrceob84XkgL//Me+AgbtWHb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7416.eurprd04.prod.outlook.com (2603:10a6:10:1b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.11; Wed, 29 Nov
 2023 21:44:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 21:44:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	imx@lists.linux.dev,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lpieralisi@kernel.org,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	robh@kernel.org,
	roy.zang@nxp.com
Subject: [PATCH v4 1/4] PCI: layerscape: Add function pointer for exit_from_l2()
Date: Wed, 29 Nov 2023 16:44:09 -0500
Message-Id: <20231129214412.327633-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129214412.327633-1-Frank.Li@nxp.com>
References: <20231129214412.327633-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f38b58-d0fc-4b2d-c1f9-08dbf1245fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Vl6YtIdwyefDxCJq/BzJh2xNtAxaQ0m+MvnjkJoj7FYKlPsRgIQPjP6ppxxYoZeAg93ke80kBH026ZcCAISXpTAcs+zWShn8nGAH2zwPdLozeCTVv2UmAYhEGSc8mdJ2GR+Q8JaJDw06FOgwTAZQdQB9w6BFLDJGwxXmB8sUn7+jibs/uNMcqIpTv4tGkYiq+LnAXcYhFokKG62ivYfmfODTbobUtL6+08t3ILIK8icP5p7cgtwDdQMLQqIpgiHhcEWH7wQG8THlAkqe/PZl+5NhQ8o4oc1mD7vEm18quGTrLegsylXZxpipbGROCO4mcXEegd/8lCjSwX9HuFckU9iVh14rlLW8SgFqgmVRExNuEfSPHAqkTrDsjX/lD5QF5oCpqkNoZnzf9KZ/MQTtXcCHNxOXlo+UtYd19Yuu1IttWuzqEolE//lRe62DyuAcU+9G51de1kXAtz8By4K3o0JTu5lRblLUagn0MHzWlHWCQO1WDx8ljfx+WBremmbNmpjv6SKugQFtMZsHi2dZNCWTWC5vGUPpJm2sY2IBYmLI+D02pXi0VtC5Gt5PIY/zwtM0WFJVXO7Rcj+uhRmu3BMrCLiKgIV9WBVVxoKxqYImTN1Y1ADDSdH6uP5kjDdHFO5HlmUC4NR50B7z0O+Iljut9D9VvVVCwJhTHX7CFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(26005)(41300700001)(8936002)(8676002)(36756003)(478600001)(6486002)(316002)(86362001)(4326008)(6666004)(38350700005)(38100700002)(202311291699003)(1076003)(2616005)(6512007)(52116002)(66476007)(6916009)(66556008)(66946007)(2906002)(5660300002)(7416002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dywSFHG9nYnye8+ZLNH5uHFG20x0To6gW3UUoWUZoLy6Sq8i/8WWbNKIK/SL?=
 =?us-ascii?Q?C3gQRjCxRoTFOQUvlCeTsRb/her6DuuSdCCbK3O856e81m8BWjCko2Hcw1C7?=
 =?us-ascii?Q?7USa2ujJ8DeCc4wtSvmaV/Im3EWU9eiRradQctY/Hc/dPEtjraoJwiosQw0Z?=
 =?us-ascii?Q?s56B4osEnsuFAVGZliw1t3VXKSxp9R0w0NIf2Lth/Ut0ayCvLGcZ96Lt+n/k?=
 =?us-ascii?Q?Tn5hXRazp7SPQiUfMiSBdo7YoOhjbCI2VwIPkw8CUdsf6d+pCSNAESv51OSh?=
 =?us-ascii?Q?lKElu7GKAHStweULM12A1VCW73eqt/oD6jchMfPBdyVQgRJ1loXnocCHP1sO?=
 =?us-ascii?Q?Jnt+fs+dMvP16GTjQeHO4rqo2Cz36YYZ0QaZFDxHnl8gLfeBVxf54ji2GxD2?=
 =?us-ascii?Q?rIoXg/rUqU6aaA683UYaJ3Q/KcYIyCRPtJnD3+G4UeugDRxvTwwLHtdS9kyn?=
 =?us-ascii?Q?E207w/man7dSzxaf1IPgSE3O0Iy1RMkyaRkj8SdFvuE35qqPV84GKmsfMEdP?=
 =?us-ascii?Q?Awa4+Xl47GH2wvK7j/eNlkWiBzVGG+l+Rd66y/Gv9fuELGSvgxP/3LASw0YT?=
 =?us-ascii?Q?J+nZHg1XLhtWqk1YrBrrRl3M5Yk6W/LXe/P+Lsumlappfzu+14pDMDFHpvg6?=
 =?us-ascii?Q?aL4Nktf3DLL4DG/O4dh6RSisEvx4pncbTNmpfdTVIU41zrLIrgTNU+0IDL3u?=
 =?us-ascii?Q?qejcHIjaZRtKVC2lE62LZHFeedv+/24EhlxrnQqwOogc143r6jS16gH6xJkM?=
 =?us-ascii?Q?zZk3db10vPvn9vN7lMz4bEvC3S17MGbzfcX31/iHe/1zoQ7Cz61lggUh1+dh?=
 =?us-ascii?Q?YZRmTP1Yzz4ffuV8e+//xt+3vrHQlOATYoyNvpcSra32CRMlRahdmh0Kewn/?=
 =?us-ascii?Q?4af7VqrNnPGwzdwAibQWqTPacPPC8Be97KbzSr55IaB9iZnd69osmb+8wErk?=
 =?us-ascii?Q?v7oxVvJzePvOquYA5jfylZPzQ/BuLGhe096FPXeJWyoJcTsT7nDSQGAbq8/y?=
 =?us-ascii?Q?4G8aiXMfvXWa120kvDCyfX7znTJIdfDTuptPXcI3UDK7UDKIV7Qxn9FPXB7L?=
 =?us-ascii?Q?gzVE2GkwcleRBKffQX50WOdxmzALuajz5YJJvmHfCfKKoh93Pofj1jo6Xyvn?=
 =?us-ascii?Q?a9iCvrdFqrmZ2tX7AbhKCuixmKe7QrLCE3heiFm9q4vElZE0PM7++/x517YC?=
 =?us-ascii?Q?hINAAyeapKZiMYhH1zQphgQacKSFb5ho3vNp6Qxmb0C2ZKs8s58HRLZ58mRC?=
 =?us-ascii?Q?CMg0ao9cFag6gdcJ0r4o9UvYE8cGeMAQIEMbHgelS5dOBhFUkfobrvQvCu1i?=
 =?us-ascii?Q?4ieuTbcnnk24gU9sd1xEHmKkwtkxA9tleyLP2FDXL4za/A+QjnBFEZwgK0cf?=
 =?us-ascii?Q?xKGnsA1cRh8i71xE/c+MVZpu7kyJr2IiCg4qD7z7qMSwArTt+uiRLsiBnLLi?=
 =?us-ascii?Q?W1S4QUY7Zh9T+UXAT5uxRagctttcg+PpuO7fydJ2timJtOzVYHLzfsFxhxfI?=
 =?us-ascii?Q?JBFvmo6bvPDPuv8GVKTyL2ZLyK9e14uzq4JWuNDfxcQlkDwvZzrFIzOItkk2?=
 =?us-ascii?Q?5Pg3oSc97dIAD1BvD7o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f38b58-d0fc-4b2d-c1f9-08dbf1245fa1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 21:44:33.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovnIhvgycGnHm5mQ7WBhp5iI8DiK9PGm9QlwiE9wf39eNiYWUZOnguSV0dqhndkJl/nqNCg2Ure/zvkn3snxdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7416

Since difference SoCs require different sequence for exiting L2, let's add
a separate "exit_from_l2()" callback. This callback can be used to execute
SoC specific sequence.

Change ls_pcie_exit_from_l2() return value from void to int. Return error
if exit_from_l2() failure at exit resume flow.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - update commit message
      Add mani's review by tag
    Change from v2 to v3
    - fixed according to mani's feedback
      1. update commit message
      2. move dw_pcie_host_ops to next patch
      3. check return value from exit_from_l2()
    Change from v1 to v2
    - change subject 'a' to 'A'
    
    Change from v1 to v2
    - change subject 'a' to 'A'

 drivers/pci/controller/dwc/pci-layerscape.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 37956e09c65bd..aea89926bcc4f 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -39,6 +39,7 @@
 
 struct ls_pcie_drvdata {
 	const u32 pf_off;
+	int (*exit_from_l2)(struct dw_pcie_rp *pp);
 	bool pm_support;
 };
 
@@ -125,7 +126,7 @@ static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
 		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
 }
 
-static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
+static int ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
@@ -150,6 +151,8 @@ static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
 				 10000);
 	if (ret)
 		dev_err(pcie->pci->dev, "L2 exit timeout\n");
+
+	return ret;
 }
 
 static int ls_pcie_host_init(struct dw_pcie_rp *pp)
@@ -180,6 +183,7 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
 static const struct ls_pcie_drvdata layerscape_drvdata = {
 	.pf_off = 0xc0000,
 	.pm_support = true,
+	.exit_from_l2 = ls_pcie_exit_from_l2,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
@@ -247,11 +251,14 @@ static int ls_pcie_suspend_noirq(struct device *dev)
 static int ls_pcie_resume_noirq(struct device *dev)
 {
 	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
 
 	if (!pcie->drvdata->pm_support)
 		return 0;
 
-	ls_pcie_exit_from_l2(&pcie->pci->pp);
+	ret = pcie->drvdata->exit_from_l2(&pcie->pci->pp);
+	if (ret)
+		return ret;
 
 	return dw_pcie_resume_noirq(pcie->pci);
 }
-- 
2.34.1



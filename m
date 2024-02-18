Return-Path: <linux-pci+bounces-3683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E60185966D
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACB1282253
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821FD4EB30;
	Sun, 18 Feb 2024 10:52:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933804EB21;
	Sun, 18 Feb 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253547; cv=fail; b=TrdUK28bsCYT6CTMGZqjSMp4Vfv7eiHDdekGLMKJSO34KIdKXTHsuu3GQbvfSlpNousepzX9IC1b7pmtW48WFrsvDwL3yUQ98kwvablhQowliv3w5jz0XiXYjeheMmS76BC759IMhSeqe8T0C9PcVJNxXivOdfDpPFcEumhtzWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253547; c=relaxed/simple;
	bh=6IWs/9L5/U7olRhCkLt+mH+c3E5Xoo0SyzW6LQLbL8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCyVTT+MdlcmiavGcyjeUlhnxwkWTyifc9fsS1O81CD5sGlgOYaH6BH7NReXMg69Bk6JHjtc2AaiX7nMPkvCPtBEdjBGL0WXymBy/729iJ7jOsEIzsEv+d4ceAQqAgU6XGPBNTzEvNsXC/1gGY938ARYBru/o1Q+OGbQjB8372E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lef6Y5A8qhzuIDEy5oD0azuDI7yoHDt4ZTtdKaW7ORp4BWkKLAAJZHXglII2ZuGctLTRU1rLeQxZPA0HVjQG5YWi17naJUm4BSBKewz+6CIizE3N4Zb7lHAraWv7bvy5Y+eJfaIOaWCkBBcIZNlDItXWNwsUb29J3D0mZYUhMQ3glycdpSozybPKVCOl/qSERLkuV+nNKJlP0T05bSBKVoYVG6SUIPjRF94J5WN6orBKNh7kY2szCK9UWOp6/ygXCfK2M+6y1MhZ1nH7+k8obamux4yUpbW5O0r+YExwbv2Bpf+Ai3yxgJ2fOQ05WR/HrTUoq5+uIjLTk64tgzFeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1L2zCinMaKZ61leC9g0xpthGdFxAFSQ7l+a9Zn1/VQ=;
 b=b74mEowkO76tc8nCPTObdhx23tQyPOKPS15iaGEMKchDFYeLERUOELgcERgl0Ygyv8L50SqeW8iusn6iPZt9hAUaxRAxJKwDTT4DLTT8kEoEoLPIj+rOFoB78Pt9xvBbkJBHBDmh7OpkH58efFLarK1kWKOsHPQQKOBQjUZlGwcJzp7WPZjmBa7tXLokHn/4kk+QFnhMwjunSGrzy2E3DvewCO4oM2InalqKQTscGUUMXXD+lk6pPIpRPLWBsfaIn9Jay0Xn0s5nFJaiwsf8w8mud6wPJWrLKseBGosnV6ifwtVSc4lHct4Vh0zbDZ5CIhgQFFxPLq4zb2vbzEYbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:43 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:43 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v15 08/23] PCI: microchip: Change the argument of plda_pcie_setup_iomems()
Date: Sun, 18 Feb 2024 18:17:27 +0800
Message-Id: <20240218101732.113397-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101732.113397-1-minda.chen@starfivetech.com>
References: <20240218101732.113397-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::31) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 769b00fe-aecc-4c22-8946-08dc306ad88a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	83w/HIPo14ADlXVI+osf47iYMxotXMzk260C7IqG1EwQ2cx7hKx4Bg+OpzGfHOzywmqFSSSpOR0tcIMNrZpMl4Jukfgqgb8iYh2UXrjhvynTC9JDb9Jv29MvjFQcpQW8XI/+SQfcnY4Lu+yOzTfeH/hKxrqTxzfvw8lf33eqN/x+GpThyIRIA0T4tC10iIvMk2TWXo4Z1YVzFYUoRIa+Xw6STNhPQMnnG7HHSEaXsIcitkvbRwq2NaO++4bMEzXnyz+mQp8I732i1+n4ZtciOtl+KOIck+jKq6ppoWFhYpOvnquNMhOBsDFbfSd6WpR0xaGC443dCgGuEdQQyh4dFT/vvu80uQtmw+X5rXt+Po5k0tL2GQS7l1G/AtaeT2u/STbYacNCcCBTAanejkXQZYxspcoOb5uR6rTR5NOF1WLl/fSrDxBf9/Qks+lZ2g79370h5m/mC5UHcDMIdVtIW8VBRW9+D2taqapd70IAtw9FzaN1I8D26142k3nJbJ54S9rtVL/6qkfIlg86XdzFcSZO1Z3HXasJRgC6SRIG8r2fBoEM5xouxkfZJFHs7Q6y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZ5QsstCIdvt3KqpF/4aK67XvwI/xDQTVggNQieJDza42rm2ONjP6e3KCU+W?=
 =?us-ascii?Q?ehYAUAfrZ7mMPim4wMuYrLHN7f1jxlKUm4H3fZXzOU09GyZzBy6jRY6FP3sC?=
 =?us-ascii?Q?8C7NxhU6YoGAHQMr2ifU2MQhQba+q3o4EECm2A1m+Ibe4Mc58cwhZffJfyCp?=
 =?us-ascii?Q?5UqvZDOnSLvGSl1UuSkAZ09NpqvuICOHhHomyJWRekKKT7i6ic+r51tNe1/c?=
 =?us-ascii?Q?2UY5Vjh3yCuf/wgnxbbV8/yRswkPWJXg6o9qgfJ8mplkIJY/3yYJNUmW7f23?=
 =?us-ascii?Q?pFeIVgZaD8p4nYBN3eYRc8OL1xCmpwin4YEbuyuAPPqvedjYMs17i7MYSz7w?=
 =?us-ascii?Q?IwLPkj2kM1LEU+Z3UP0WMVGpnkjLrcPh7oraj5Hf7/QoH8ni0fBYK/fzGNNr?=
 =?us-ascii?Q?rgibANqA4ocoKp/O45LxxMrt/FUgkSJ6a8ehfEq1Gi4X/ayJEJhB16K5utcR?=
 =?us-ascii?Q?2zcffWciEAxbhXPewARqmGQcEPdqTWPhz74HpNTiejjiU7Ymvo7oawzGvcFC?=
 =?us-ascii?Q?irzbc1rstsxcqa2YmNr/44z4mVV1b1DDDMrctgw0rluGEtqROpb6gBhEG5Ef?=
 =?us-ascii?Q?UpFXiVkam8klXAi2ywZy/BXh/t7hJ+WpAWP7EbcrKPedEEUugRPG0z8BBgIe?=
 =?us-ascii?Q?o5xNDuRUkdcNIvPAuch03rxPMsOLW7rCiicIScC0MQ+52vPPGsXggZILZu/t?=
 =?us-ascii?Q?QiMZ+Vwmil7UfRuod855jOe52LNlEnOejUVIc783dpZUjH9yyWXUed0ER/+u?=
 =?us-ascii?Q?lFWfpSKpQPwgaBQyD6DJvPj7mRIBXuVB94/6o4rQHKIWzaFVpEydclbSjcOh?=
 =?us-ascii?Q?YzyCJu1FAmpupXxJYeRYTd8lIJGuWCcgry1ss/mL7/54O9vnpR13vTHui/Xt?=
 =?us-ascii?Q?j/bp8ODh++eHXxy1gsmLyyXZSncRrG7kXx+pEy95R4TWWnQNd4XVuKtrxtxf?=
 =?us-ascii?Q?pNmgYytBi+1uQ5h7fivqpRguAk9Sssk+0gv6Gyvly/36EHo/F0Fe+MgThKZQ?=
 =?us-ascii?Q?HggxU6YRG+Dq/b+vfxpf/FbYJHSR1dYpJ9RgjU27RHo/e+VO2JRgdc08CD/I?=
 =?us-ascii?Q?lHqCKhc8uFncs6G8vBy2ZeSuUlTq/HWF15SRsy8Vn1OyCFlXRexYuupczsUO?=
 =?us-ascii?Q?epCKK1iRZKnpQOnsU0YdaRtQwnZEH7Q1BrLBsD9MsWVIYpNBixIQqxMjCKt2?=
 =?us-ascii?Q?SrWyC6m+sHK0a1KjENrA9s8d9Z4lMifb5d89mAo4v5SpOaNzQSsj/cg0Qdbu?=
 =?us-ascii?Q?PJ6jNOqx3RKHE3HEnyRx9RUM2wFr7k7dV7LitrFXevmm3Fk32tnAYAIfkW9n?=
 =?us-ascii?Q?EctSl1XramOF9KzoWu6VhLPtugdkJGkXsXr1ZdXe/TDvaz1xinBwa3SqOzzj?=
 =?us-ascii?Q?rzeC0df4JuhMuKZhdVCEUpjXkjTYfkcjwE1ttORwsVey4lqq7lfD8S6T/ZyH?=
 =?us-ascii?Q?aJZY+KLyULt2vGIG4e+pmt3zshNYQBpiOy5ypHZ9xAPgKR3T5GyswGnJtyEt?=
 =?us-ascii?Q?cppsmoNxQXK99u1DaR8nLaog6bDr5uenOJu99OwtGgfeyMMUkczN4BjbrtQM?=
 =?us-ascii?Q?vE1JHRhYyPuhMCtxP6KrTQNvuGdSjy2HHuGdUBFFMwATE8eVVqLoH7HRmDMu?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769b00fe-aecc-4c22-8946-08dc306ad88a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:43.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eocS6y9iW/cmXfIQGZBZHjNMxUw7o7Mn5UqeKw+uAtfFpoMVzTjatoF0p84VR+vQr9lo5YIJAkZK9vgxCsRYXPuGwEKU5AJJXIj2Kj/enFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

If other vendor do not select PCI_HOST_COMMON, the driver data is not
struct pci_host_bridge.

Move calling platform_get_drvdata() to mc_platform_init().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 9b367927cd32..805870aed61d 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -876,11 +876,10 @@ static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
-static int plda_pcie_setup_iomems(struct platform_device *pdev,
+static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 				  struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
-	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
 	u64 pci_addr;
 	u32 index = 1;
@@ -1018,6 +1017,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	int ret;
@@ -1031,7 +1031,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = plda_pcie_setup_iomems(pdev, &port->plda);
+	ret = plda_pcie_setup_iomems(bridge, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1



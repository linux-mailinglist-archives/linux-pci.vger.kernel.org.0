Return-Path: <linux-pci+bounces-1152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03D8180B1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 05:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4187B286171
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 04:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3253B4;
	Tue, 19 Dec 2023 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QASCaja3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870B5C97;
	Tue, 19 Dec 2023 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcNfi4U8K9jbbzLdhsb+j/3CTmZStZGVahSxq0LC9o9swxZNWVqqbTfLj9IASnBIfy/SmKgo+q18E5BwEpO4H2TDIlFqwqTtRA0cp7mzBmXtpU0zzQtjqGird2151+hK2+nuPsSRSjIRgo3syXODZ0aXvrnWBpEEkI+yzB6OTMuT9alKtefFSLNjWCXg0ZVDGFgbEfnK/kFpnAwQMSErj9TV7g6gChUrxAgbOBk+GS5nJdje6g/ighcm0hTMkgH51iHz4AGNoIazYJ1WdLIzgKFSWyacfO0Gx6O+vM3yR0zRzuOb/n09Ik7Ey0YPTAyzAqnef3139cetM+K+xVNzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6oNC4ObsvNqUDhQQwIKLvKoUztjDywjQKt68rBtEgk=;
 b=FkM0oD2358Ev5mTKESu5ZzIbCexdqB1Re1kLEzPK2Af72u6cHSfAvDcN6TmtpCowrH27AAYRIkUVZjgxaj0Isq9hSOvZKjujeSvz68ywIHw/nBdPfOv8qhSlYNryMGU6eft7KKN8pJhC0GDn8CXc88Nh7IKVvDy/hAUnz9eU5pOTgK9GVicQa7Kl7LX2UvFZB/Vjp6k73fs1RSTHv9bp4465BfEMhzICQk5tmNRuulSGgbKd6XImw1rgjW0GjWS8ll9/4YDFRYVtDJCls4y4k0iEh5h2qjNKc85XgXEG6YWvlgS6Pq2wTPYcxkeOlXSk4xz/GdQ7VUGwN2Ll2+YVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6oNC4ObsvNqUDhQQwIKLvKoUztjDywjQKt68rBtEgk=;
 b=QASCaja341WnKOdWfggfKuD+OrMcHDUi98QXJgKsMLGidRqVjDRj4uUxI0zdv4ZJq9WJh7OQHqu6VXyCWRBikkQLsXVs5Nui39ZACzS2vt/6F/qdF0ADg/Y7Y+RLx9tTh28ZHV8GDf+Ioy9+RIWGSWS8wQo5iPadQiAjBwm0cSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 04:49:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 04:49:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: niklas.cassel@wdc.com,
	imx@lists.linux.dev,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root complex reinit endpoint
Date: Mon, 18 Dec 2023 23:48:44 -0500
Message-Id: <20231219044844.1195294-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219044844.1195294-1-Frank.Li@nxp.com>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6bb3e2-f60f-4c1a-b90f-08dc004dd471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e6bUTziTald0x+95m5C2qRxZFyazj1VkBFihlKP21Od7207K88EivDqishrRj4AERdgJxT3ShFkw8mnpRkDCNNySwt6FREmeG9qOJuI+uIKMKrN2ot1AA6NdaWrOBurrxwP0MsyfL4o3XnQPoklc8ZvLRbK2XCfC0dUZHaNuzI7hNoIk10Pa8G9bLqHZWFJL7/gelrLu9zlnh9H3Eq8RtQ5kWoz4VJQO8x56ay8IznQu/fi7rKwhEHf+fhoebwITIvuqTE76rUgrOAovQ3o1/A1EpdXgFO22tFmb83xUHwM56jMQZ/DHQYJPbPhcMgGMhBwe+cbIWl+7MujtsEAgST9/clp0NwmRu30MIuSk6gUSzHWbDkgkIyOP9a4kz2S/jcKNeBkOPlDbLVzjLvcAvKjXBrXljCfadWch8ftJ05yUXerHIXyua07UIn0O+bNois7w/rc1v88Qv0+GQCf47bJ7oqfQuTawCmLvqtZ8wxliVtGCtyebzSdkPN4i6mbo+TE81qdQGY4bpRRiu7RfqQ3WA45ozX96RT8Vczk6LmqAgo6eZdzbLIDLuYkcZukGkV44pAi22QRLtbF4Fa1jMoOd/qXf/vNE6EB+if0VzM6SjIVtLVN9q/3D4oDpvtKc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(921008)(38350700005)(316002)(66556008)(66476007)(66946007)(8936002)(8676002)(478600001)(6486002)(36756003)(110136005)(966005)(41300700001)(7416002)(2906002)(86362001)(5660300002)(38100700002)(6666004)(6512007)(6506007)(26005)(83380400001)(2616005)(1076003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SShQMRBZAmu3hM4u1x18RiKR7exdvbpdyk/M5bNv3/CBoczb20fBWNHt1FiW?=
 =?us-ascii?Q?uBfIgV8K+P+ah05oLNVSEROVAcaQk7nmaLT4flgkNtofD/ExvNLZpR3tt7bB?=
 =?us-ascii?Q?49uwtZ19EMAoGSRmSVGNJP7y4DAzQM5/lvDjaW+JhaC+H+Q4W2/ILwN7NJtB?=
 =?us-ascii?Q?Y5ga/4rQwe00w4QuFx6ik+hje0t1Tatw6sBqHLRzgeIKTf5oMNexM19I5QTJ?=
 =?us-ascii?Q?SqRyalLOE8WsMT1OS80soebFUael4pF34bRLPKyUYBJualTN5awflcyPvUPL?=
 =?us-ascii?Q?wKcL7OubdCuuR1BpWInG1HibfnFodRrO5Nlqo7J41x0Ong1biFHUkFMv4A/q?=
 =?us-ascii?Q?ZUgFLhNRjIqdI25lD1mulvCcYThWXZWqbT0TwdM/XK5H3fHGRyOJx5ieq0Lc?=
 =?us-ascii?Q?n9OaDgqVpAjEm7WX1HZEQPo20ic6WoYVIyLrfBsz37i6mQztZemfAiYFzCCv?=
 =?us-ascii?Q?Qh6UFESqMpWV8cUwdBbaOr9LwM8L3nrkQIjZZENZX1P/iW/g1fLM5yrZDbKx?=
 =?us-ascii?Q?y38vRVCXQM3B1Tucc25kFJeHH04cu47H52kjjlKxd94/RDjHDNqWqpG0rje8?=
 =?us-ascii?Q?rNloVIZek1qBDeKuEeWwerOQEcniEzO2B/F0kcp2PNIla8syooacvFiWtSM4?=
 =?us-ascii?Q?FTu90wEcML6TtiW7ZU4Lh8iNM0vtoQgBeRhkOeNl2TeQOTwpfjGx9ABSfBI2?=
 =?us-ascii?Q?xsJ2M3WHYLncegQexVneS1JfpDGOh8/lhegcNNvSNVkzQp+tY0ZO8nrNZDJp?=
 =?us-ascii?Q?sKwzP5op8/Yzjjnyc6IrUZTvolcvzWDc5LW4VhUQ8YyKAhWg4DWqS36BT/7o?=
 =?us-ascii?Q?39SxAOzlJXv44YjzwuYkSylkll1HjOvXp2N1gY3MAT2qRe56OHsEICKRXJmN?=
 =?us-ascii?Q?OeZ/249xuCbATQd5ZqYN7wvMEminVkVV5Q+f0SR+1M8W+KNAQaSWvMEXenoD?=
 =?us-ascii?Q?6Jov7P4QmIwHL9BD83ig8liNouU3qly/knfiFD0bXOQ+7hJVsHyKMWqrik/9?=
 =?us-ascii?Q?l8dNA/SU2+lPhllXrLqXntepfsEjI6tBzgo4ZXhse6eSsrGdaFgGkuIs87oK?=
 =?us-ascii?Q?UizY1ZqfJLATm2JGGIx6fVqLCEiKBkLWaPSF8ywiAusqmiF4pmII2JpC8bzn?=
 =?us-ascii?Q?UcGF2obHti9SNcsJujwf90IJiC2OQtdj5s1F5bFonuyOpKEnFcGp/N9bUydO?=
 =?us-ascii?Q?uPPZ5El1R14cJPMkNJRFJ4qDApA/1OVfrbeT5D50mjp2dBo3v3iVpltgjXcm?=
 =?us-ascii?Q?UzWGSfZSQgAv0mEEXdw3MrBhbFY56X5Yz0EH2ivZUy+j932UCHTbZCGLvmJs?=
 =?us-ascii?Q?A466fqOnw/+FpciADuI03iph78e68j4ro1lM9nC8yjC5MTGq9pqAHR3pKkSQ?=
 =?us-ascii?Q?E4ThwcQFaaReQACz/+A0d0/n7kbkJ2+PqbpNPsBb/6V2tjTDgHkTCFQvqUj/?=
 =?us-ascii?Q?Q+khswUGIQYBQNATGHBqsfyIO3KYpKLI1yHl441oUNiI+Fnn7jK6DdMp/6om?=
 =?us-ascii?Q?7i2hbiRsIhcQ8ESa4ii4ryDtN8yQizfK0WGXt9UpwJwwfN2m1/s/aXyFt7KV?=
 =?us-ascii?Q?hafA8DuFmFOUiT3/5E8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6bb3e2-f60f-4c1a-b90f-08dc004dd471
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 04:49:05.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIqCzaxu9tUWXCUe9r/K6xacidw03zE2NeG621m2rKn01ODGJHRE+BPmSoruCJjxVPCze3cxyLn525XB8ggZwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203

dw_pcie_ep_inbound_atu()
{
	...
	if (!ep->bar_to_atu[bar])
		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
	else
		free_win = ep->bar_to_atu[bar];
	...
}

The atu index 0 is valid case for atu number. The find_first_zero_bit()
will return 6 when second time call into this function if atu is 0. Suppose
it should use branch 'free_win = ep->bar_to_atu[bar]'.

Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
not allocate atu to the bar.

Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    @Niklas:
    	I have not test your case. I should be equal to previous's fix in
    mail list.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 11 ++++++++---
 drivers/pci/controller/dwc/pcie-designware.h    |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f6207989fc6ad..0ff5cd64f49b0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -174,7 +174,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!ep->bar_to_atu[bar])
+	if (ep->bar_to_atu[bar] < 0)
 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
 	else
 		free_win = ep->bar_to_atu[bar];
@@ -228,14 +228,17 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar];
+	s8 atu_index = ep->bar_to_atu[bar];
+
+	if (atu_index < 0)
+		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
 	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 	clear_bit(atu_index, ep->ib_window_map);
 	ep->epf_bar[bar] = NULL;
-	ep->bar_to_atu[bar] = 0;
+	ep->bar_to_atu[bar] = -1;
 }
 
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
@@ -767,6 +770,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	ep->outbound_addr = addr;
 
+	memset(ep->bar_to_atu, -1, sizeof(ep->bar_to_atu));
+
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d3846..5879907c5cf25 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -362,7 +362,7 @@ struct dw_pcie_ep {
 	phys_addr_t		phys_base;
 	size_t			addr_size;
 	size_t			page_size;
-	u8			bar_to_atu[PCI_STD_NUM_BARS];
+	s8			bar_to_atu[PCI_STD_NUM_BARS];
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
-- 
2.34.1



Return-Path: <linux-pci+bounces-3030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26D8472CB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC3A2905A9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455D1482FC;
	Fri,  2 Feb 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WZnRXwub"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303DC1482E2;
	Fri,  2 Feb 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886727; cv=fail; b=Y/u/GHhqHDw+8U5GxPCg9Ww84lcqe2shprVFIUSMl0cjMJKJ3s3wYaKkRdYqp0FerxWOX90OVZqz1PHLJz+3uwfCRk8gMXqm27HATFN0IgpprpwelDpSX0uXk3AGkz6pc3qKU5ZxsfLM8K8wzyxTld60DkgcJHx4ewocYVx8aiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886727; c=relaxed/simple;
	bh=tryKGtAme2JMTWxLIzvuOW6099a92TAhQhYi6fqGgNc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p4nqkNg+/xNVnwrWm4vQTXdUfjpjwru8oPe9Gr9TSQ87W0OsHkINsQoEtGnUPCdhPfRFxTxMVv2RmzxhfEWlDY6SoDFpd4qfmnmZ+vtnCly/mREXk87fK9Ehhla28XuVelJwPJQhQt7R0o/WaVD/nzFsju/pht4gpIWF3UnLEis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WZnRXwub; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsCZmVe4lQDiwbjPQlsQiZcdOeUJtdR0Rlo08ROqKFiS0wSATOiAE+WuLzIopYhJIDBzhAHthNvkO3LPN9o5zJglh6NOm4AVplvZ/fL+Oa/RjTaWwEwiFP1i6wr1BHD9dqwkLAfj1Kq7n7IJMyAMbnc98cRyyGclrl6jqocDoZhAr5qQ91iS7pHp94yrMHtDWSbQRGZmEqaee9p7K7MY+s+L7axk0tHQvAsFWwkNPuHxbJkb4CQtLYNQPMxVUDsdZF6Wnz78lsiG2PTkGV8LWQtralr2Ae+iZpuCmK1n/K6IWq8lXd/FPitctJCxm4jWyteX+DVPSa6huje/MUy0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4XwyfS8QmxQrETSuuG7tEPexqIg6wIBIaRCqhpBC28=;
 b=F1Og0/yowk8oS96r1AcRg/SdQp8TPgH4txDg0aROGmRm41MoVvHHzrsX265O+1OT16Y2SqB0gS69kkZpq44auDNBV8F0JosA6vpu8X0S7aJYzybfGT4zheWYuwd39RcRkSR56sSzA78+LTgBPpbwTkBZyGKO3lLqYBCwRR1FML1rAIp0rD97JwOQgvYCL1KthnEZzpy8Tr1zrrLiA5gdjiHDfS2Eqge6Hp5CWBMsWj+j7c+g+ibKGdd3SNJqY4zJMkO5kKHjX9fEszT/Pj7J6IhmJHE29L/8TR+kxupvJtN/csqC/jdxEmCPo4jA6s8KhZqLyq7sjyeTSEZsyOIULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4XwyfS8QmxQrETSuuG7tEPexqIg6wIBIaRCqhpBC28=;
 b=WZnRXwubRT/XGj7n6iuldL6pgh9xxson6YLVS7yE+bLbZ84H3jFOopWGZB5PGpvD8A7bVmINuaM6F+rnNBlJPxGf+xUf96UlJw/zMZKvwj4H1+hc9hdH8ZGE9iCYsuihEtmrtjq8TmD6cyZ1fADWzWCIQ1JBO7xcqy0UNBN7r+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:12:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:12:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 02 Feb 2024 10:11:28 -0500
Subject: [PATCH v3 6/6] PCI: dwc: Add common send PME_Turn_Off message
 method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-pme_msg-v3-6-ff2af57a02ad@nxp.com>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
In-Reply-To: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886696; l=4262;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tryKGtAme2JMTWxLIzvuOW6099a92TAhQhYi6fqGgNc=;
 b=2aXwg2uU8PPq1+f2HOHqikb4HKmjPalxtblfBz4LEyNrBAuMPT9np0TtA4CKWarJvJO1iwy+0
 p65yRXoSwMaDNRRYh7uJfF61OFuMi7WkTLv6Z5Emk/mvvQPYNJ+CwAe
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 804cd913-c5a9-42dc-e3f8-08dc24014f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w789IxF5Y+QAVzEdIceeUCIiqCp/ifZvr7v+7JLi1XbxfHTNEI44ZQyKCcGQUjqEVr65bogYVOvd248GlF+nrsj5VbjC/RvdSpph/zluZQI4N4NZ2ISmUspnX0lhSHTctdRPJoiyVkEh2jFyqQlrEA9DTYbYaZKOC1EJKfBzBtEqD2GRBFhcpSEXQbjO4MQhktYyVvw/ack+/x7sTne66fFsKt2mpYGc9ak47oJjt7RXbIo/BWhjIG8+v7EL3jX7ZiicYh1YIi4DaHQAqCiYgHVHPRrDHMkhLCahydEc4JWLHcaUNqQp87IKheXVgvuDT1svHps8FKfO781B8b2/bNACNjoy2qMSVk8AI6vk7lus7ARrZyzyy4TSBeiUyLGDrUjt64m4apSfw/+mNFLRHfnQf3Wf6Zj7eV300LLpLvDdUhSOCBMFXVQrWPsmEnePiKK/OIF4CVv8dR21rogLS4aZr5M9WTMrf2XFqlTtRSxH3ya7lmDJOSG44gpkcut129S4q58qlMKFQNKWfo5VTOzHflUjE88KAWunE/U8BTKduUZwH/hvyXrrfnoZQ07Z8xK11aYVIFT/2agUyHhddr7OgV9pLk3hM4V1E7GlMH0lfhmybDribRPXQFEayECNUDcsiF95qKL3ouxRczNqnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(478600001)(7416002)(5660300002)(15650500001)(83380400001)(921011)(38350700005)(4326008)(36756003)(66946007)(8936002)(8676002)(316002)(66476007)(86362001)(6506007)(6486002)(52116002)(6512007)(6666004)(41300700001)(26005)(2616005)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3B1RWVGVnhVa0tyREcyYi9YaDJmZG9VMml5Zk5xci9pd3RSb2RGYTVHb29F?=
 =?utf-8?B?VlhweDVDei9sQkVLQ0hWT3VpanN1dnNabXpwbEs2aXVnejFndlM2UVc0Q2VE?=
 =?utf-8?B?dHlMdm91Um95cEx6WitEejl1ZFlzSitDakFSd3pmd3lwczhKenhwWnNjMCtn?=
 =?utf-8?B?a2xpeS9wcFhERkF2a1ZoZGIvV3BpVXhydFpzVDlpcHFXR1ZnTWFpSmNoU3RH?=
 =?utf-8?B?blJ2QktwTmFZeHhaUE1zOVR1OVl6RlVyNHVoZmpuTkVoUVo0bklsVHVzaGlp?=
 =?utf-8?B?MFE4cW1pdGtkbHNIWSs4bDVqQTF4U0NMOUhrYzhEN3ZZMGtCbzBYNDJKcXEr?=
 =?utf-8?B?TzJSL0hCUHVHL0ZRSUFMMjYyZWtxSFN5emxjcGk5MG81cFlOWXNFYklZRkU0?=
 =?utf-8?B?aFVjNzRBZ2JtMWkrdlFHcVc1MStUWWVKMFdvQjQzbjZVTzhka1pwYzZMNTVR?=
 =?utf-8?B?dk9VSHQrcy9OYjIzay9jUXlyWit2TUlPcXFwWFRpdm9wU2VZenU4ZDkvQzh4?=
 =?utf-8?B?MzJXY1FGVU5RLzdrampHVlRubEVEejBFS3ZPUGN5eU5DL3d5OU5pbDZMODB3?=
 =?utf-8?B?blFKb084NkNvOVBiNXpVTkNaWDNEbCt0Y25XV2gwVEN6YXJoejVtME1QNUJo?=
 =?utf-8?B?N0V6MzVKalBubFp0RkdpbXVUaTRSdjc5NGxBN3VkMmJ3RHEzVFJTZW95T3o0?=
 =?utf-8?B?c3B0SjFMYVU1SkM3OUVCbGJQNFVBZmd6N2ZlMjRuQWg0SEFzRExIOWxNNUN5?=
 =?utf-8?B?QkcvQ0IxNFUrdHM2cXgwSUJDeEVNMytQRXJvYVgwMHI1eUxtRUpCb0QyUGww?=
 =?utf-8?B?a1BzekNGS3hvd3Y3VVQ1bDZZQVY0VDVhS242ajlPS01UK3d2M0FRMDYwVS9P?=
 =?utf-8?B?L2RYSk1QblBpVTRrS0lpUU1qcG9kL2FDdzg1OWFkTEpMdnpTaXVCbnQybDBL?=
 =?utf-8?B?bFk1OSttVHB3akZiTjFITzlQR1FCVHVPbXk5ZGtkWnBiRzVYNEdGdGZ2Uk1U?=
 =?utf-8?B?eG43bW9aemw4d1lRVllNOVhEY0VYSjJ5aEkrY2M4TE5taGYwUm53cGpTeTU1?=
 =?utf-8?B?MkNBcS9IMmtEV1NlZnAxVldvWitTRUtRVlR5Z1oxZnUrMDkxdnlmRVBvM0dL?=
 =?utf-8?B?RHJITFo1THJRS21TTU43bHBQSmlIMFZPU0hoUHZmQzFzU2sxL3ZuSU02aG5B?=
 =?utf-8?B?ZTBibVlFNFo2ZTFyTFFNbEtkallyKzFkenhraG1XS241SlVudlR0TnZPQitQ?=
 =?utf-8?B?MjZWc1FNK3czc2MzenVaUEhtZ0pyZDk4TTdrV0pQVEhsQ2VOWmIySlQ1NGt3?=
 =?utf-8?B?Z3Jrc0tNaTUyOXFWY0RqbEtweGpoL295dU00eG9qcWtBZ0o2TFVKN0hEYm1I?=
 =?utf-8?B?bEZicFIrVXhTNXpJQUJTZEdESjhLU1Q3MGRkRnF1SWRuNVg5SklrdlhHay9j?=
 =?utf-8?B?MHJ4TUdWOFdianBtNXkrWWdJZ1dLbUswUkFQckY2YUhwSUR1bklSRUMyRFho?=
 =?utf-8?B?Tm1JUjYvTWxVTkY0NE1hSElwS3dzc2duZTgzUzgxQUVvcUUvV2poY2tCczla?=
 =?utf-8?B?Zm5FcTlxWGxsaUdjKzg0aEw0S05pUkFoY1JJcENRNUFZcHNkcGViZHNOV2tR?=
 =?utf-8?B?TEZ1dFhtTzV1VnIyNWp4Vmk4Z0lzaEZRMVdFV1J4VXo2Skx2MHhmN2xHME5H?=
 =?utf-8?B?NU9GRmxLL0pCY1kwUDVqeG1wazk1WTI4K0tuZ0hwMWZuWWNPZmdWK29XQjNr?=
 =?utf-8?B?eTViSFVEdWN4UmpXSzFCTVVJcnJiU3FqVk1UNnZ4djEzRENlOVFiVmJ1aDFm?=
 =?utf-8?B?OXh0NnIvY2ZpaXY5SjJ2RVF6UVk3S1NkandTUk9oK3BtVDhNVEwzK3Q0eWt4?=
 =?utf-8?B?S0JFZnhZa2crbGRNOXpmbXh6TDRKVFg2YzZaTWt2bXQwYVlON2p1OGJmMTlK?=
 =?utf-8?B?UzJZajVyUUJTdG1JMXE4SzZXTVEyUE5iUTVOeHNjUXZHUVhMNDl4RDVoQ1ZJ?=
 =?utf-8?B?a0ZsNzBPc0NWdTI2Q1RNN0hWaEJqQ0ozd0g4bFdIOUZRSnVjbGt4UTR4RjJt?=
 =?utf-8?B?YnlzOGEzVFcwaDBGZ2dsSzNQbllXYTdESGs3Y2pDMFc2OUZHWnZoYmszMTFQ?=
 =?utf-8?Q?fpDKjtaGS7huqUDuX6eNuPg7m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804cd913-c5a9-42dc-e3f8-08dc24014f4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:12:02.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oilQct4DrKkMOrjH6qS+W58ipshh2PJQmETUqdEfXgwOdVhmLOwvNms8LCK3UWwxwRGbWe7rK871vF12t2a0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

Set outbound ATU map memory write to send PCI message. So one MMIO write
can trigger a PCI message, such as PME_Turn_Off.

Add common dwc_pme_turn_off() function.

Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
exist.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  8 ++++
 drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 267687ab33cbc..c177f1076ecea 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -728,6 +728,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	pci->msg_atu_index = i;
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -833,11 +835,50 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
 
+/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
+static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
+{
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+	void __iomem *m;
+	int ret = 0;
+
+	if (pci->num_ob_windows <= pci->msg_atu_index)
+		return -EINVAL;
+
+	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
+	atu.routing = PCIE_MSG_TYPE_R_BC;
+	atu.type = PCIE_ATU_TYPE_MSG;
+	atu.size = pci->msg_io_size;
+
+	if (!atu.size) {
+		dev_dbg(pci->dev,
+			"atu memory map windows is zero, please check 'msg' reg in dts\n");
+		return -ENOMEM;
+	}
+
+	atu.cpu_addr = pci->msg_io_base;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	m = ioremap(atu.cpu_addr, PAGE_SIZE);
+	if (!m)
+		return -ENOMEM;
+
+	/* A dummy write is converted to a Msg TLP */
+	writel(0, m);
+
+	iounmap(m);
+
+	return ret;
+}
+
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -849,10 +890,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
 		return 0;
 
-	if (!pci->pp.ops->pme_turn_off)
-		return 0;
+	if (pci->pp.ops->pme_turn_off)
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	else
+		ret = dw_pcie_pme_turn_off(pci);
 
-	pci->pp.ops->pme_turn_off(&pci->pp);
+	if (ret)
+		return ret;
 
 	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
 				PCIE_PME_TO_L2_TIMEOUT_US/10,
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ba909fade9db1..eb24362009bb6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -155,6 +155,14 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 		}
 	}
 
+	if (!pci->msg_io_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
+		if (res) {
+			pci->msg_io_base = res->start;
+			pci->msg_io_size = res->end - res->start + 1;
+		}
+	}
+
 	/* LLDD is supposed to manually switch the clocks and resets state */
 	if (dw_pcie_cap_is(pci, REQ_RES)) {
 		ret = dw_pcie_get_clocks(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 703b50bc5e0f1..866ab44df9fd1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -424,6 +424,9 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	int			msg_atu_index;
+	phys_addr_t		msg_io_base;
+	size_t			msg_io_size;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1



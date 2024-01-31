Return-Path: <linux-pci+bounces-2851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1084323D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 01:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D40B225E8
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 00:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA215C8;
	Wed, 31 Jan 2024 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQufqIj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3884DF63;
	Wed, 31 Jan 2024 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661982; cv=fail; b=fkdaeFkS0hFaHFI6ge3+/8EnFnZ7Kxg5mNg5DnIDL0fLkpgHzoIlEykZXJRj7LPklhzhLo7InBLqoUAPzpBTTpUMFeEM2CohyB8BMqQM28P32nVa7F0mFVi9QH6AJ9zAEpIYIUdpb7oHJq8UyH0pIXj+LP9nMFWCVpUfeWaT5Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661982; c=relaxed/simple;
	bh=w5ej/3IyEY+WZO1JvfC0AqolZMkMcYnAfQL4D+f2MCA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dST3smhvJXD1EsE2KVY5r6Zud/2wUUuGWkPq/S7dicmBywfkLsG+yOArXP2nvsM5mUmrW9ceGBdYvVs2v6/pkY9V2df9lTFlQra67tcHLaxnvFH4sPB2m5GAYvAoITdmVPABnxZnJcKCBS0HoUE8ogRokxkRQuc4+vtIHNE3zT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fQufqIj6; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxcX9lcWCe3uW/D9Oo5kgr20TlonZf6fZJrZZYTlZPYmHyEE9fNFqxdWqtNzIJ9I6FTN2GPEapTATrP653Gc/e7QZwMNhVyog7quJ2AxSK85Rnf2eKTgCUnZz/Yjg4SuILjfTMpODffJgu7W3hPzcO0yE80lHk2HZSR9SF4cL4Tjj1IxtXPLZI8A/ZfQZwct8uJaJ+1ysjK1ms8ehG9dJm9EC1gd/mg1FskfSrU9EkPQVlKMAxsYA1eiy6xv0gQukV/PUfyHMn+sXR2xybhJ1sxESGXYypvbe7jFnz2+T8JHudR4olkmpdXhRUcxyuHumH/hvz0UNKVXGGJKqSIE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEbzfKH1xUS89dtwi8tCWKu2ZeVTsxGddGeKiXwLfVQ=;
 b=SMQUNrOl/Ti6yl4sRx5jG0lJaBEmBoRj2fDHrc7+Yj6zF03xY922aKnQttF++5yBcX0G48biooQnWJtQo6FB/rKi6kk0GlQ6tKa2NZJsrrW5wKepI7XItRntY8V/b3Btv/cfFtgPQuKZveh8wxHrd3CFhZn+egBsRJQgkyZarLcLYfDHr8gwcRf6xLdFPt91a6DGaDg8sYwoox6gDaY69IYZ805MspqPp+O0pswqsk5adoJrsOOe9XHi/l7apuNCrIzwiln3RLPSfLZYYe2/AmjKSRZB0q5NaJ5vYgEWIk0mT8piPKKc1Z7/vyYC3Iv1l4epYahWFc3fn7fYiclwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEbzfKH1xUS89dtwi8tCWKu2ZeVTsxGddGeKiXwLfVQ=;
 b=fQufqIj6sAwGvAWiSI4kfn03Rvqf6pdofp1+Lgd86c8oV88bp3PFdsrh6JeKGG8FPOAZUH2LKKZZJ/mFz73J4xi9q4C8YaV3L2ITMk30NcasAeHXrjDRxnjZSQollpDkPk4uLlr5CDJVZ34o/ePRmQtStKNrXM2k8eZwuWuJMug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 00:46:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 00:46:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Jan 2024 19:45:31 -0500
Subject: [PATCH 6/6] PCI: dwc: Add common send pme_turn_off message method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-pme_msg-v1-6-d52b0add5c7c@nxp.com>
References: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
In-Reply-To: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
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
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706661950; l=4224;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=w5ej/3IyEY+WZO1JvfC0AqolZMkMcYnAfQL4D+f2MCA=;
 b=G9CDMmzzSg7ushqUxI6CN1B3eanQca1agkuFSlgt7Z96N/+IWj1Dz1TT11jgLoP40rVCKd8IZ
 5JBpVI4l/0RC9IEcmAhFTTupT5H7tIkIpOhubhJediz/2++36LbkZzZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 663c77f4-7ead-435e-fb9c-08dc21f607ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fGI8HVw6CITlVT19yLJ50uYeVZ2MvmQqhch15yZl1dLmBwpC44QPgfoibMlDDkB3YdKI2nM/lA7uXUWze4+WExiUw4HsS98F3QU/Fgjy+IHoWzZHaHdNSN7lRRcBcyXRdg6rnPYDqMM5VtG7GDKrKdzPBD06PcaPBwvzJKqdwJh828agxWF5yxcZTvTq9rrrjG6KhccI8RNhyjymXR30YfX5x2mf6hysRMaaeSUo4dBR40jKM37a1sDuuBcm+llRLfQVVX2BglsPk33PpLy6qBzLm5CtLjkhJ3K2hk139aZmfuvoPYHvREtl5k6ruNht7/6YiaPsxdEyqUd2luscXbOvq6nE5nl5vKsT3q0eH/yEs+J4E/Kj4jqjNDO3+1brk42LymxtOzEniFHq+CsMJAJ5XRjbxN+DEKUKppbqT45SoCGDMQS9jpjzFLFWqC2hHOGIiNyv+zdpVPjuu3VAIA084dtCZSoeiqiLyYtAdLyojniYfg4OV8+a0YSanu3w2z1nuCu8epmkB0wn2QnKhE3/Ghyvacp5YfSzLxzpCkKOXA+F4m/pnn/ysINRb4Jq9BaOIBOx5264+LJpDEUsYGZXvlxf3xBg5L2GrEBBWwxK2up4GvDoH5t5VBAuSAGkVFQJdDDRlPqEnLEfuKbvSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(921011)(26005)(36756003)(316002)(66476007)(38350700005)(6512007)(52116002)(478600001)(83380400001)(2616005)(6666004)(6486002)(6506007)(38100700002)(86362001)(5660300002)(7416002)(2906002)(66556008)(66946007)(15650500001)(8676002)(8936002)(4326008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3J4L2V6cEZUZ1A2VlZ3M05laUkwWVBSZDhJUDhpWUh1MUhESGM5QmhKTDlu?=
 =?utf-8?B?cm1SQjI1S2NOVVRZMGwwdkptdkxDUWh1T2YxRWlZUTMzeUNIY3hDU0l1NlRJ?=
 =?utf-8?B?c3VnUmxNMHZsMW9mdzRINE1GeFRuYWhzTHhVSFJ4WWpDRC9KOGtBT0ZkSDJo?=
 =?utf-8?B?UGdubUpQRWN0QVRmRk5FM01qQ2d0MlRkQjZGV012SytVdG5uVE5OWHVrcDNh?=
 =?utf-8?B?dVhGa01TVVczQWZHdTVteDhEa2Z1NHB6OForbHZKRTEwbCtrbnJCMXR1UHhS?=
 =?utf-8?B?YkQxOXRLSnNWTFdjVklzQXBFUDJ3SGRxNWIwVjh6M1h2V2NuMlhaUEtNNjZm?=
 =?utf-8?B?am9FK1p5VUpqS0d1Z0h3QTV3RmRhSGlXWnFQVkdtQjVlbVhxdjhWcndUR2pT?=
 =?utf-8?B?cEZSTS9QdzdxNnA0Z2NHVG0rTEFQQmFsUndFMjF0N0YvMm5nSlFzS0JlWGhp?=
 =?utf-8?B?VVRSSVM3NUJRc281M2ptV2FTUUJJQWFiZUgwd0E0SnAxeXBOM2U2Z1QyaVdS?=
 =?utf-8?B?WkVCelVZYklSYzBSR0gxWVFRZFBFbjNpTWx4OTB2WmRSamsrVTFPQ0MvS0dq?=
 =?utf-8?B?L3p3VnkyK2UzS0xTdm02UE9BYXp2QmlLV2VtaGtyTHozZHBZL0FFd3p2aWtO?=
 =?utf-8?B?YmtxQjU4K2JoVm1KaHNRNndlMkFtdHpqakxheHVlZ09sV2RobjFVNEIzRW54?=
 =?utf-8?B?R1h5SjFueGdKZG5sWTFPdStLMGo4amdEMDdSMERqVFA3M1hFOVFjR29wS3NI?=
 =?utf-8?B?aFoyM0V2N3ZPS0hsWitlWXVPQ0dsaUVDazNoaE1UTVc5NnQ5NVU0aW4vWmhz?=
 =?utf-8?B?cHcxZ2xnTVRHVmRiclQxVWJaRUxKVTd6T09hc3pNNHJRUFA0MmtPS01CNWlh?=
 =?utf-8?B?Y2dpNllxZWJxY2hPNCtRaklJektBSjdpK3gwOWFuYXJ5QWY5U1FYTmpCM3oy?=
 =?utf-8?B?RkJZWHNaNEVGb1JLVjN2eHZON0hJVENEMlBNTU53cGJsY1dFTFhLUzA4ZmRU?=
 =?utf-8?B?eTc0Q0NicGFXUk1KK1czNlYyUFlBL0J5dVZxY094UG8rZm9jazZlcWZuc0Uz?=
 =?utf-8?B?Z3VHM3R1ejUyUXROcXpvWkRNc0hRa0FGN0ZoRHRsZXltN1IyN254aXFpM0RJ?=
 =?utf-8?B?NVRQdlNFVGlEMGg3MWcwYkVaTHV4S0lvSnJTbXZ4Y1cvZnhwSmp3RWpSTFd2?=
 =?utf-8?B?Q0lBZm1lRTJRKzVwa2tYZ2QyNkNJZGkyL2tUa3pyc1kzTjBVd1p2eWtJSjF3?=
 =?utf-8?B?SUhUMzJLTTcya2luTW5kZzFqQmZHWDg0ajQ3TFpabFMvTXIxbkthSHY5cTdL?=
 =?utf-8?B?OGhjMTR0RWpzZWZYM2gxbHNvdm5NeDZKWkl3dmd0Nkx3a1JpQ3RrTUNDcGtZ?=
 =?utf-8?B?RnViOVIrZkxQWHgwV3VjRlFiVFNrMkg5c0gvRWhFUFVPcVhNU25HbEhhKzlR?=
 =?utf-8?B?Y29sNUExTFdJTXVwQSttMzdiQXh1Ri9HZ2IxK3J0eUtmVDBBaThuZHVQMnp6?=
 =?utf-8?B?VDB2c2J5WURWYUxmQjd3OHhXUHBnQzA5R3VEajZQNTZNQXFNWkd5eUFYekhi?=
 =?utf-8?B?ZjJrUUxkZDkydGc4bUd4L3Q2azhTOU15L3Z1SDZraEg2MnFVK2ppRW1KMC91?=
 =?utf-8?B?ZTdySExEN3FmWUxZTDh6aDBmRWVibEV3TTNMaWJSQkFncTduV3BnRm1rUFRt?=
 =?utf-8?B?R1pvTkZHMUpFVFEwK1ZIRk83OU5lcXAzZmw3T28zN3I3anZXM3o5MEZYVTBX?=
 =?utf-8?B?MmV0ZW5qTEdiUE9FanJHWVZkVlNEYzR0WVYzRFNkcUFBYzFhSUNtemcvOWdU?=
 =?utf-8?B?MUhraitYWFhLNVN0RElTeTVFaGc0V3FEUUFnSm0rWVNsREtoK2tiNHJ4d0Ns?=
 =?utf-8?B?RHJSTlpjVVQ3U0Zodk9BenVOVVRZdDZYaWNHNTRsbVFKV2xpYmFibUszY3Ur?=
 =?utf-8?B?MU5MbzNuWFVPZG9HL0tXeGo1RWM2aEp5U3Erc0lEaDFabmpnYVRoUE5ITGVF?=
 =?utf-8?B?YnZuNGRGelJ1UTZVQVpnWEtXUnlIN1QvZ2Ewb2VLT0VSTmJTQ2JhcExreFBl?=
 =?utf-8?B?eXIvek5DSW52a2JZaFBWVHR4NWt6SVptN1lpMUh2KyttMFV6Z0dPVzJIVVMv?=
 =?utf-8?Q?+0UmepxrY7aaqQdlxrbn91uqo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663c77f4-7ead-435e-fb9c-08dc21f607ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:46:15.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4atgBjHqpHz2pa+JAZCOMI8oXcJE/IBAqkHJJXGncIO8r5AC+NQciJKDJdEad4bh+NMa78FdTCrljUd/iFcV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877

Set outbound ATU map memory write to send PCI message. So one MMIO write
can trigger a PCI message, such as pme_turn_off.

Add common dw_pcie_send_pme_turn_off_by_atu() function.

Call dw_pcie_send_pme_turn_off_by_atu() to send out pme_turn_off message in
general dw_pcie_suspend_noirq() if there are not platform callback
pme_turn_off() exist.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 51 +++++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  8 ++++
 drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 267687ab33cbc..2a281060f3aad 100644
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
@@ -833,11 +835,49 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
 
+static int dw_pcie_send_pme_turn_off_by_atu(struct dw_pcie *pci)
+{
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+	void __iomem *m;
+	int ret = 0;
+
+	if (pci->num_ob_windows <= pci->msg_atu_index)
+		return -EINVAL;
+
+	atu.code = PCI_MSG_CODE_PME_TURN_OFF;
+	atu.routing = PCI_MSG_TYPE_R_BC;
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
@@ -849,10 +889,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
 		return 0;
 
-	if (!pci->pp.ops->pme_turn_off)
-		return 0;
+	if (pci->pp.ops->pme_turn_off)
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	else
+		ret = dw_pcie_send_pme_turn_off_by_atu(pci);
 
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



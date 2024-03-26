Return-Path: <linux-pci+bounces-5200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333BB88CD50
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 20:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C581F2A47C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259D013D246;
	Tue, 26 Mar 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lBNU4Q9e"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2133.outbound.protection.outlook.com [40.107.104.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0A13CC41;
	Tue, 26 Mar 2024 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481765; cv=fail; b=nYu7phN7Q4UW+tiwYZ0mf/Op03oCyDZeNFPM2eTB2o6vSuX/uD08tmDllRd9VseB/LFEfVAfQa/kFMl1Wvqof/Y/u2M5MSS7V7w7jKPCv0A7n0EEi6NT23dDWqE9878A0ad1UZPyaDP4kmHmbw1i2FAJfZBTzUOVNPWs+HVP+yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481765; c=relaxed/simple;
	bh=BROr7rk8vwzQgK2p19UHuNXsTNsZJmL1eAxB2wnXv4c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FnL/jrbABSEYLnZGW75t+HaxsxphdXYKhppoWqahGRpBQISVdpEuqewW1sxjClHsgDryBkF6oyixHlcMUYrNsDmPik+tsXYOQQ3UGb4utOLuMCiqFXddUZg1Lr9/PvCrWEN3dKQgOTo1vEhYnHi4a/qLq3A1audr2NZmsvvsT8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lBNU4Q9e; arc=fail smtp.client-ip=40.107.104.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f08mJUr6FHf2WwD6zEoU33JZx7OvbRWSc+k33ICkDnKwoHkitMgP9/b9qoK3G3HNHMeCzZv+ZJZZDpZr2STDLue+OWSd+1beOrVbWGgi/rbLI4rfCW3qsYga1KCZgSwjNDjWbkn1VuCZvTgH3YXBij1jdqOCTJ4YNwjJo9xmpzGt1vCWgl7lO9MUlvBy9LC9O5egQDmndFZghnOChFFKWVW1WpzsWj3CSTuDvi9MPjEIlXkGDgWEY8Sx484CHChCvSGLuk1TMKB8FSO0TCnqUdoAfYC9KjaGP+XbgT2xick9cvvQs5vdNtu9kbYId5s17/6c5fgJXBTKI7Iw1kSNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlYsfya/NREepbPNsosV8dL8dlZoKSz3Is+4nwBBg/I=;
 b=i0RATdOYXGKAK0EuO8s90OSYLJ1UPccd4aaso1g4hqswzD9ibzEKpc7Gksp7aqfgqGTw2RgcvpUiYIv3tr/EPt8SRVjTSK/5Brb07bqdw4t8vQ0qJNOn6TPjIUSHzRE/ES7Qoo043Q9c8p2Kk217VSKxwlZ8NS60+ysjOIVFKC60e2zzQUlyC7P5cWS7Gc56hCmih8HjSZCa2fWW3pTDjPCIFombC7DGgj4RfDlteiVcveGtrhwGOudBfqYL71/qPKLnUgGKUWs/LhlRScdcwlJQgUM+n36lKzEnACvElmPfLGaNHrBMlscaYopGCTLdJP0JTCQSsUEixGutTHTY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlYsfya/NREepbPNsosV8dL8dlZoKSz3Is+4nwBBg/I=;
 b=lBNU4Q9eAprmcQQR0+vM1Jdt9b+NFPmtZhecpbBf9flTiUExxfLSYqUG78ctiEF/PZ5ju689lk0qM/kk8TJacpRcpbyMvUEWlM1dsmXn8XDiRrqwcXuG4B13jJ2RUtvZlylBlF7cCQV0o7DzBtFGN2Lxf9RPA9/W79KgTNswQAc=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7438.eurprd04.prod.outlook.com (2603:10a6:800:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 19:35:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 19:35:58 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
	gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev,
	jdmason@kudzu.us,
	jingoohan1@gmail.com,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	niklas.cassel@wdc.com,
	robh@kernel.org
Subject: [PATCH v3 1/1] PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot
Date: Tue, 26 Mar 2024 15:35:40 -0400
Message-Id: <20240326193540.3610570-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sW+WBh/djFWX5pdFauMNCxyZnZP9/c20XpVeTK6WRIYgy7kE33pCTTcR1Yev9Yf8GzMLm17JXwoaYswf1hFnoa6E5Utj5jgN/jScDO3YnmKCNl1TDZ8VdvZPMJehO4GfrB66r0HOHVYkpiAmgEn5kkPzFWR693H4Cq1GO0158ZY2pEWNu4JYtK/ELJHTZugW6rtXKU4dUjugiHzxqwdT4AUC1CZ/J2dOK4CT9+zuD6guZ9YlxgdQSYL0l+j/kXw57mT58rbPTKtItP1KwC4CdLJ4IFJqGKCxZGs9jqwGzdwi5idmg4fMCYA9Ndp4fWiJNn9e9jgVglsJzCeep/PmwXKKPIJmW3/hGyD9VrkdfNbl2bMFG6xjS3FWL5JN2z932RpFDUc8gVXlNVCPJNVczhodEL4UnaVsWcewuUDiNay+4KSzUyxNPfr8eTkmiO9M0dg48IrQzvpZR6EXOPeyxRgX/UhNJlfEBVtWEKE1HK5Do8dMbxlXUXph6eWwXx39U3d19LxiYfcA2+N+ndQCIVh9SqkOWXVJrCJ4vj58CjCOAT53G8xr8Nmdxrx8Up0aXELKfMMoNy+zqaEPwOkICapf+HA6ziuHDkwT3YCULweYrjmsBJ1velwzG922vLP+8pxnvo1l+IoD5YWiYcXKbfJX6QM52RI1lHyxVsM3GX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SPzjWGER6qD9g7KQKmcr/QUkH36S8cEpDGmtaoCxqyNYTUHr1ZLVuRz12/ya?=
 =?us-ascii?Q?uyyrYWRx/yPajyxlEqa+wVMwa6V5VzGJ7CphoeacafoNYcCUvRyNZx36vldk?=
 =?us-ascii?Q?Vid8aQiFF5eVW0qNbXUhz7EWeVHV5X+AhYSvLDQNXCneWr1yJjpV9OrI8eng?=
 =?us-ascii?Q?Mp0Nf6Ww0fI/Oy7GZ+x4GYBEctHOhqxl2MNS58S8IFbYXQlAvhlEnsQ4/2LT?=
 =?us-ascii?Q?OLV+1qoDwalJi66ORVtbGvCCpzsUAa9BeLQWdP/OKdJj6dwAKAjqpSq1lO6b?=
 =?us-ascii?Q?oEvNbeWsy1OKDKU8EVZNlIXDqJp9ltoL/DErXM1fbrXTUWiIABwN3r/Vy/Qk?=
 =?us-ascii?Q?0c7Oc1TO+Af9bQFp612ek45LkH3otK71DD3Mn80FbxSokG7kgqH4gbUeipr1?=
 =?us-ascii?Q?KygTuUvefuPrXha5Bnti0wVmoofJ5o8bfSgLTM0uOTQ/7cTamgU6+U6kc++6?=
 =?us-ascii?Q?qRqj/o68nSFQlfyaYMUJWTa9vMOw74vlXr5DasjTHRUBF9gPOTNDBAae6NzS?=
 =?us-ascii?Q?wsgrpkU4Dj8gh7+hsnEoAYh9wLNk6fPglSrMBAEAJl+eh83VKQ8nqPCIfj6h?=
 =?us-ascii?Q?h1sz25q+/xOCzZ+keiLX0nsIYgwgGgfWSwMPLsz8dLby6agYaduRhvn+Vbne?=
 =?us-ascii?Q?btaukWF+pL2OLhzwvi9ilFxzx3dZs6D4yJ5kMoy9UQ3suMwMAMWRwLhZDeFa?=
 =?us-ascii?Q?V3RaABM+64e05kDcyUQXuvIeVAGjQBm//XoT0IZxS0oUifyVi4ffrHqCXl0M?=
 =?us-ascii?Q?wWS3xQVOFaZ0bBmaIzZkLyfcilPRib9XarBIKPiMc52GMPqAnzkfJLzwtEFu?=
 =?us-ascii?Q?DixRz8FCAa6f8Z50F96BPTOaP33aKJgtOEmXK4wfEXjgbaz1Jed32F7brLp6?=
 =?us-ascii?Q?VsAreJwCWZDM0R7g7qn2J2O0ryXaczf5Cag3lP2zd+whFKx49CaYAK6rF/7Y?=
 =?us-ascii?Q?Z/u+dpJvzQAKdG9zktg1ibKSBBzWaiWtkIQO8vy984QzB/2eEN1wxaao7Xp0?=
 =?us-ascii?Q?THL1CFlhM9mpn0/Co12Xz/jqy0lBoy6EPq6Mr+BXt8w6OZWIpuQcer9XALHu?=
 =?us-ascii?Q?hdqreU/q4iLnU+lzz4Q5uzzaJxa5NmpeuWdaTFD8Gnfq2EbJ8tfuMWsfx+tT?=
 =?us-ascii?Q?LblFqmALWQ5C5Gmu3HsINAarM5uWxwSFo1X0BbTjXOVSVW9MJlA4HvhWBMFt?=
 =?us-ascii?Q?88Ltr+pcaFnrXkniuVdjOilZ5VGaux+0MQoOuPGoBYbbCSJPtUckLeI86vvc?=
 =?us-ascii?Q?crVrQlGZWEZX4Us/u2Cw752P/q1L2wa2M184smsq82IXpktKsGJbYbZTyuMv?=
 =?us-ascii?Q?RRZuBgacAXjlt3ox6Y3F8J+9JHDaxDCOX/yTuPDeVVPS74hZXP4DdoluHLIi?=
 =?us-ascii?Q?tWkLL9WvAMnRv3nIT8dHFFWUzHAjrL9H5CWAfufcQFkjsno4212qdtNO/Qwq?=
 =?us-ascii?Q?xZFEI03CHvHHpvXdFbTvqJdt6v9kyJUvGYfjhe8iIS1VS6DO1zjfK4l4xPaf?=
 =?us-ascii?Q?+xRZJjagBzvd1CfKjjgJFJxaU8YgwqfUkEo95ZXO3wODuxG8SF6c2MUhyLnB?=
 =?us-ascii?Q?XqI+FwwgXfYcmnHfxpFxpHLRejhvBj6BvXRalTUO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e424983-8838-4ed9-b0ee-08dc4dcbf603
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 19:35:58.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INyqbBJ8PnJDPH5LkyJKxHPKkQBtbExkLBVkTnw0M5awCv93F0QeOWQGhMcKH1i50z8lzTkGts+HJqusD/6TBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7438

When PERST# assert and deassert happens on the PERST# supported platforms,
the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
to the area that was previously allocated (iATU0) for BAR0, instead of the
new area (iATU6) for BAR0.

The mapping between PCI BAR and iATU inbound window are maintained in the
dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
of the existing mapping in the array and if it is not found (i.e., value in
the array indexed by the BAR is found to be 0), then it will allocate a new
map value using find_first_zero_bit().

The issue here is, the existing logic failed to consider the fact that the
map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
will return '0' as the map value for BAR0 (note that it returns the first
zero bit position).

Due to this, when PERST# assert + deassert happens on the PERST# supported
platforms, the inbound window allocation restarts from BAR0 and the
existing logic to find the BAR mapping will return '6' for BAR0 instead of
'0' due to the fact that it considers '0' as an invalid map value.

So fix this issue by always incrementing the map value before assigning to
bar_to_atu[] array and then decrementing it while fetching. This will make
sure that the map value '0' always represents the invalid mapping."

Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Closes: https://lore.kernel.org/linux-pci/ZXsRp+Lzg3x%2Fnhk3@x1-carbon/
Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - Add impact in commit message
    - Add mani's detail description
    - Fix Closes link
    
    Change from v1 to v2
    - update subject
    - use free_win + 1 solution
    - still leave MAX_IATU_IN as 256. I am not sure if there are platfrom have
    256 ATU. Suppose it only use max 6 in current EP framework.
    - @Niklas, can you help test it. My platform become unstable today.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b7..ba932bafdb230 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -139,7 +139,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	if (!ep->bar_to_atu[bar])
 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
 	else
-		free_win = ep->bar_to_atu[bar];
+		free_win = ep->bar_to_atu[bar] - 1;
 
 	if (free_win >= pci->num_ib_windows) {
 		dev_err(pci->dev, "No free inbound window\n");
@@ -153,7 +153,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 		return ret;
 	}
 
-	ep->bar_to_atu[bar] = free_win;
+	/*
+	 * Always increment free_win before assignment, since value 0 is used to identify
+	 * unallocated mapping.
+	 */
+	ep->bar_to_atu[bar] = free_win + 1;
 	set_bit(free_win, ep->ib_window_map);
 
 	return 0;
@@ -190,7 +194,10 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar];
+	u32 atu_index = ep->bar_to_atu[bar] - 1;
+
+	if (!ep->bar_to_atu[bar])
+		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-- 
2.34.1



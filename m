Return-Path: <linux-pci+bounces-4485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A280871048
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 23:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982F61F23E1C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403D47BAE3;
	Mon,  4 Mar 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWvYVtcO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9321C6AB;
	Mon,  4 Mar 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592396; cv=fail; b=C6VvstiUHBJLtQ840UXrnX6vjSsTPl3QXyauHZ/l3cLQ3PxmxwVkvLh0/elbjeNa7j/cM8D6EIbzsS5owoEJJXTRcnandMZVRbe+377fyZJ9M2mZh5yu7XtoshIxopN8SWK9Hz9bQ3Ll03fCNvnUuDhKAeYyvRINMs7w7piyxUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592396; c=relaxed/simple;
	bh=sMTD7H3pkXtumX02kxfIYE6xXXR25O5SYFmfqYo/NmY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PuGS77jjRlt7butospBRvvcAPgV3cBgYSNmP+52ogpl92wnLrAHEwkVXEOEJ4qOyFUL50SEsmxpLe2uPg0IrurJOqjIRBP6fsGrWmD08eo0q/hKeLeN53KpsOFXPaXdoxtCXhqdUmPwhjT4hgqtLtccsCiIAXTboDZ2lfT9HypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RWvYVtcO; arc=fail smtp.client-ip=40.107.6.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyXPdjfx3urm0zKDcayPtrnaip0wOIpygZ2gpRkxTRY1U9IXqJ+06MqYTaEQn9mV28mIgYAkbyAd5qCymDo6vF/H3nwnvBWZXtns9PLzOrkRCxqrHXNr+PHw3BWErAFaeFu81Ym8ja//hQ4+f7HB2WwuULT/uLWxclF9uYG/jwWuz2tvT/hniOIMUYf4e07MCPSGQe8fVv+rzJmrLT5Fq5ijTmC/7Wa+gnD8m3M2LMXlF+0+O6/hhz/8dx08TGHFrxODEzISIPVPjLQIwt6r9myDELy9fVuMyI2aynT6zr1DPxUe+JVH1bHMg4MxrJxPXD1PadGcc+DZiI/8nw1XLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUIkqXdRRiKSu4KArfKZ1xd5qDd8TVc+USYhMLrh0wA=;
 b=X4QiL+SsAZ2d/nwrKD2xHqPMd056v/YvCwQlJgFXRwH1FMQuM1wg5xmS9F+9OHHx5OePGwtgoJAwOyO+mOmiSFCKZEFTSHYiKNwIsPoqQqlX7qnI0yqonrAg7JAqy136rnqu4wQk1u4rl6PrXp3yFE1xqE1Pfl18sEDGWhDH+K/GsxhKbempCZWam+Bx9ualUiaZuuvYA7YuhkQ/tu/nmKJKSCZFzgPJAUJ+R+hEIg4caDHGX2UGGv/3EEQaWzO0YI4SUl4kGEtoGPTRdAFZau18iO45wSCcloVqxU2Ug0c2HVZSKuQFgRdV24p/5sox9I/s668vAoKWTSDwjP8PXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUIkqXdRRiKSu4KArfKZ1xd5qDd8TVc+USYhMLrh0wA=;
 b=RWvYVtcOUHM/gh3pQ1VFiQAWbNLJ/deDqvJ7tInhlAbBxjiHoxEwM2wAhfdmEqT89UH15arqPh/eYh4N8ZnGuvAVyIh5NMgs9IN3Fn3G4JM99Q83qmXWtLgxjTtvPVge+togNjHau/LTtH7S3buGOqK7g9qiAEm/zcL9sflKD3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Mon, 4 Mar
 2024 22:46:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 22:46:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: niklas.cassel@wdc.com
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev,
	jdmason@kudzu.us,
	jingoohan1@gmail.com,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org
Subject: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot
Date: Mon,  4 Mar 2024 17:46:16 -0500
Message-Id: <20240304224616.1238966-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 41340640-29fb-43e6-c7d3-08dc3c9ceeed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hzRBCUPQ2Vt9P0ObmrVOEWzY6sUV43X4tJYsmR7ALnEh8swpNMaAqHff0lNwgFGgxtNbQBeikHe4loMXlYFb+ct+R3aRpihP/5mIj+aBg9TWXb65qmS18SyCy3sx4yu8YQ2aVIYDjmxU/+nlTQNeid/tpLfLuYrKjLIyjWwXanFISra1VlbUgtA71IPcBH9vTtP4yBxz8ym2OXdDubD0zVFSVjGaYyzgmNtFxl91GGWWn31Eswilhlk1S+zU2bzpKcJYTDgz9rgjSB5Xs+xUI++cvoFlE08VndMMVyhFlA5ictJ8JlIdgkWs4LhSquVHmnZ76OUNQuNWEMzZ09KwgPJ2t7UFYmz7BTk6yAks9Nz/fBJ/LXw5X78Dhn+mdPLR+l90baI32XCfDxm99rpu8YDf+JUwH8IbNnaqVefeUHhu/EAsjeN3m024dgC3Tf01Zh8cX5xuw7XlfpF5JKlT5br3HExLFC17RCvOtPSk5HYGPN8VZ8Gtt2IHEr0wk7W9zMGQy2sJnSQ6pYIFzo2GKemxHDsCpV2t4Ti+ASQWOREkYqGtD9zlpk+NKU40Sirj/pnxTtclanaC1u5IYmkGMa37g7MBNy9YapxsvlRqyLwFPV4KA0y2C5VFqwxD/lTjplNFomZZycVd9Ff87pXkhllp7hGT68j2xN3o0hDqL4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zq6k4FSgenee1i1qh/34jFUy0MrT7+r1Lw+6eubCVhHFgE9RajkPJN6mfuia?=
 =?us-ascii?Q?3r4tDBC6ZcPHO/g1lbullfOldN61XTyYeUHBTbZV0IBe538rsOq0zKECggmw?=
 =?us-ascii?Q?7SfOv1/5i4f0kOW7ds5uuLP/B7enHLKDzshbU1lLXMof8xbJiI0XVt25WNBG?=
 =?us-ascii?Q?ydSImtMGL3gjud/r202aZTN0UVpsmxrKFQKRzJiWPPHoodDKksGh6GNJ/1T8?=
 =?us-ascii?Q?KMIQJzHzSjME6D/g81eidc15f0YSh/Fr2yj6Bw0ZpMtxRFBDdb2WpZuY/BAC?=
 =?us-ascii?Q?A8iyxrZhxKD23tV7Y5Y5K31fYQ8d6eA35ez4e8bwTPlVVDCVZBQd9ivKga50?=
 =?us-ascii?Q?mBJjaP3JjRFhBZ75Ygft+tEUhyxha5rmsxOPoFC20U1CswucNIkDGX7RS8No?=
 =?us-ascii?Q?e+MoSgKpLevfHNUsNdBixaHxK9Laqs6CWzIBc/fjVcEY5sOIgSMIgXiPPSsj?=
 =?us-ascii?Q?Lqi2JV1WAjTmnGDB7KHh2+vzsfjOOBcDvoS1btZUSbMwor4uvMXQZCOaITvN?=
 =?us-ascii?Q?7yQBMXAD6SLw35Oxmh14HMEdKYMAgUS+jPpyYQrwFH1xS//MFFaS+E8caZH7?=
 =?us-ascii?Q?vpefyvZAyd290OFg8HxhfakFSioCcODpRKOuCWd2sbUHJ0T2ofKuBpoXDCXV?=
 =?us-ascii?Q?7zOOpfw3bYJ1OMxdULpSD8ImdIJ/IB8Yv4fI+XHf2udV9HA56cXk0qngVrdO?=
 =?us-ascii?Q?LmVV/f+pXM8bnn43Cc4Ihzlsxp6yPUJcLDHGHxrcIDz5s5ybWEIOBkSaNoUi?=
 =?us-ascii?Q?piwKMHOlho5lHDjmpoYMLBIOhJABuwzQ91lIk9zCFsUSrZcxyz0np1fjDRAx?=
 =?us-ascii?Q?Am31FDgtqhG7mIEdQtV8TBDlb/6ZGNFMLoWK3GW+kCrXmhBhzDms3yvPHI4w?=
 =?us-ascii?Q?Kjh+acM0CPZw6dASHxXxJakNmyDTsm7+/g8svaVkzZ+CH1RD6c8ScMhnGi0U?=
 =?us-ascii?Q?yZJAuYcfcFLVZfvUQ4HsmFK4kphizM+pR6O7GbBVNAxNcLLBs+BMwn0yZnJ2?=
 =?us-ascii?Q?jCai3vUcONihsdillcRkNj2FCG0kSRGzehGlABVpeI1ZpYDUzdb9Kpcgnhhw?=
 =?us-ascii?Q?I3OJB4ltSQJ7JsAic6b7uIn/4FTaSoZY9jg2yX2AJrJVF6F+jNGWuCRceZ5z?=
 =?us-ascii?Q?6KPxcYW6A2sFkMf76H4J5q69aS1S/DX9oUNckuIg+URGVxmEC1B9/fGOmsvI?=
 =?us-ascii?Q?Oapu9O01TC4+1X9WgWNgcOZDMH6RlHQ217vza1IMU3nXhC50++XhZOkGG+ce?=
 =?us-ascii?Q?3iOf+6Bra0cGBY15SG3kSvcmdDmUozeRebDC9BCHG6YlM0Q489oi9j05mFJT?=
 =?us-ascii?Q?A84dgwY6FSygQO22E5zz51RuS/iBdyMCKP22leTmGkf/FWi8YmVxqsbuFBpE?=
 =?us-ascii?Q?cQDocRgGTbAQeAtgxAovaihlHvtGkTqAu3yrDO/Z3d5IBGn0pkcqztnR3p2v?=
 =?us-ascii?Q?f1YBLWXzsM1sHndMhNVlwry0SvZ+YY5glkg4EO/LxHyfF4dKJPeDMMUWdStD?=
 =?us-ascii?Q?poaBtxdbqVcLgUPDbtAhn8X5GbIfK7bU7fkcsikzQd8jJjU1ft0da4Fxzt6t?=
 =?us-ascii?Q?82F9y7/n5abe+YjwZPg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41340640-29fb-43e6-c7d3-08dc3c9ceeed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 22:46:30.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHk72aOwwLTQPjz9FwKpUEMDLWsILYAhzpjYW1UkajZtKuWfIfd1gowWCQSwaHkO47tUD3xm897xyVz+yhKmNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314

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

Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
it have not allocate atu to the bar.

Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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



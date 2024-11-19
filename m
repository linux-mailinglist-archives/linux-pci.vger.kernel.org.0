Return-Path: <linux-pci+bounces-17061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21EE9D2029
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 07:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C0AB210C1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 06:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1534914D70F;
	Tue, 19 Nov 2024 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzJwFoAw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFC1482E7;
	Tue, 19 Nov 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731997364; cv=fail; b=jfsNuYaHvxDXgxFe1Fq+VKjs4MSU3U97MIH95uFF1qREmWJXw839F5jjDst2HFCeI2ddsmWNYcZEJQ3AEIipYIZpJ23w6OvQC77gRMKbNrM+6H1zpgEizZeWr/ZFhBOW9dFccRys9t6pNaiTqHsbO81lAK1GTKv3l2+0R0axaVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731997364; c=relaxed/simple;
	bh=iyaReOFvWURz/CKD8k3Hyp1sLUcEDvaqs2MCTJoowo0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MFEF6KD5OMLmNNm5wWfg0Fn6jPrFdeYO/YRSKuXqJTfuTzQz3ivfBHAX1E/QMuxF5tpLHgXYtzTwnEEkG4N4hxoU1vftYi0j+Sl+TA2k8e4Js0CPyRq1siDUN3QP6OAdIYKJm9ak1+cRQmPsh+4vNC84ZFzjlcg1FmpSSQhsuQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jzJwFoAw; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMppoYetg5UxUN/GLxzPPn+B4rkXiOYm3g56BRNiOLatWNrUw201XZ/5dhzDRGALik081syxLQ4X144kKhadqvKskO6gP5We6dehspzYXKrvTpXc733wTtroWJBaBpV1Dsx8Pi5aBtiZx0U2FJP1ZqUqTfuMCBtebqAUAz44tRTDafaPiKgtbdH04fAHYOHG7liV3ABbbH9eu0Skd0T8MIPeAITujobrqzB3x7vEPWpr971Uos8J+s3l4G7zZIsO9Zjj/W7QVRoKglfAuUPfJUskfBcb5nn/Jo5hLy9uyCnOuhJebvEkSwSj2iPRafDUDISZe7UoYqjW+P0Kwvz06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAjvFpgbJBuv52VTYiDV/mxwXI7ZgeJn2QvxYJ1lA/U=;
 b=dlZSE2uqXBvzrAySWaHoaXUctwSZPtKH9nalTkPi/6GUYMtIle5u/OlEVCBcu1o1Fv6l3GTGwSV9J2NjjFxua1qK4n0TGAlRiRY7FUD/TCIuBI5hkLscPnAEgFzM6QKfVGAdtmhGgKzKct8JA0o5BqO6zEdWoB6BYwTj+ylf7oanv98KFnvGVoIvuCnP1yo5JDlsFMj2Ya6RTPXiTSj5HCQiDEB2i6jEnqG7ENfrNyNNU4FjjwM5xJy/kQ5UK3B8mc10cIJbZqG/8Td4lYeaYjWo1sBktk5e1/uPAgo7ArC19M6WpqD1PYClsDZssjvGfr/zw4lmW9TINVjvn/3j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAjvFpgbJBuv52VTYiDV/mxwXI7ZgeJn2QvxYJ1lA/U=;
 b=jzJwFoAwmrpRdxBQkoa2yZKjDCQDkvo/PrGN2b0gCX4SX/u5Scb4K7d427tME/QD9GZg3FrrGtkdtEMV0odcMUjfaaZbHmYdJnLhcMbqvTUeUOM3J6InrO1ocejX6OpdeIX/tJF1M70PLZ8uDnEnFfUSrlWuVyLLz9xadginEzT7C7SNCqt5d8cLjxC0oaL1d1f9iIsPI4L7ioymQsBM9+ohxfOjPascRSuhO4stP978cAAluB1l/0emvrjBldrcDEmOOfj6LibASJa7qKBEujT0JDLZ7/I+AvcatG4aCciUNyYsVPVfNbc8fiBWQXOm5+KWezlQnxqH+TUQhg7+xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA1PR04MB10746.eurprd04.prod.outlook.com (2603:10a6:102:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:22:39 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 06:22:39 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com,
	quic_krichai@quicinc.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4] PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()
Date: Tue, 19 Nov 2024 14:21:21 +0800
Message-Id: <20241119062121.620913-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA1PR04MB10746:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d396fab-a103-4230-189d-08dd086290f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jgZeuxcOFb4vvDEYouloUpfl5ouwGnxYFoE2lOm7evF8i6ztJAQrOhrSOu2i?=
 =?us-ascii?Q?5r/Q0Z5qGqZSl2H0gsqDCHCMtG4/5yBaA2E61vEyNVuJ7lZBu4mJhVjPa16+?=
 =?us-ascii?Q?j1Ipg2R1Z26Uh5iIiXKO+psyF+C+7lVp7IyiXMB6I2iv6ZQvJAd2JMd6V+jt?=
 =?us-ascii?Q?8TQ6Y0WNQ8N22MJG3sR3S7j3dyTPT9LTVnLaN0SYcI+t/4a394ZCXwITt/wf?=
 =?us-ascii?Q?tHEBowD6K6QzOg9h16WiK91bua0jG9MPRozHDx2IFfrKDzgQla96pH2O/N+X?=
 =?us-ascii?Q?MC18+p7/RGV00D/Dqj/Ba5Qz9WCiwhQzv3lAO6J2fFor5rZ5D5ujyTbw+rtJ?=
 =?us-ascii?Q?dZR9dnTj2zLLKMNWI/F4Jkpzv27CXHmxxUtczsyzWfg3XxdGh3XlVEUJc/ML?=
 =?us-ascii?Q?0YpW/gSVaXo+w96Ho9NIhY39IHiGIcpUP75QoqtFSsfsswRE1/MnhBkuAbDI?=
 =?us-ascii?Q?u56NYfDxozhX9I83rmcfmv98xVtStyKeigWqIb/+XAlPE1/m2ScLERVK9yAp?=
 =?us-ascii?Q?1SiFszyRreGDOVs9u/JeLr1R8WhlwhWPN8PcKk/Vcos62o3WaK3qsYaKnH/X?=
 =?us-ascii?Q?jTAPkSl50OY2DzgYJFbRRSJQidpTtpNS5R5BrDg4LuwnU4dERZgX69hxbmkA?=
 =?us-ascii?Q?Zs+qf+Iszdz8EhWDCUtqEPKlYxbzcuiBxv4eu59+wW53Ou6jzPhsiEOkBTuC?=
 =?us-ascii?Q?tTx32ShE4nJkWjgoCAjq0vXcImYPC6mIfIDkfXqsqZ44m9D/fK8msp/lsaut?=
 =?us-ascii?Q?nWf5Cn/Mj738PoC9KKMfm1C3+bbTwB/5Gfq6A45z/O7Y30Ui+8Qt8WA9sNwC?=
 =?us-ascii?Q?cZq0zoqxHDTfzLUUbTV9SuwsYT9YFedsH4SMgiyw0Xi6k77W9AG5QrQz4ORU?=
 =?us-ascii?Q?SsqDN9JlBWvH2IGzmdXWf5m/OxU1LeaM02MRgAXAn5nDook6GXpjbBDguia7?=
 =?us-ascii?Q?Ztbg2U63VlU62ghFOC4TN6Asb7ceiwKul8fLPZuOPuKtgmdv2VYpe1MhKdKA?=
 =?us-ascii?Q?L5PC3HlEVht7U08L9jD/tfUL2LSCdaSlhXLEGFipkwaeSPJTKc0N/HsnjjLE?=
 =?us-ascii?Q?JnmYlispRAxx7TEG4u5QtqxKX5PjWhwwRiLoOirmzR6y1L+bCngOIyKrUHN8?=
 =?us-ascii?Q?p+gJv09+BMarS3vkPI+7TogUnpXXTDMFMGFa9l1ECIgGtBk6OfHLt0OibRgG?=
 =?us-ascii?Q?x8OViOYfCD5tk6AYdMrTvoBAoADxS8yHp9ZCpfNcIiwLsQgSQYeDcCiKnws/?=
 =?us-ascii?Q?20NspMnnbIpOK+DdL0iVVWV6iVW66unFs52/BahGloxHo07x+xxUbZuik3cG?=
 =?us-ascii?Q?/84/uCFJgNVBiNdv2uCMpfrGuN0JASLR0GxVKdhVUFKmaL28/cMO+Q+QF94/?=
 =?us-ascii?Q?mc8RpDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SGjLovBVQTdZdjEW7JiYarlREXjEN/7Att5xwn2bcV7k8YOMcOi2WkhhElws?=
 =?us-ascii?Q?48ugnrDTPHWF8yrpSj82SXbwLaXpj9qXBbSoeGoPGNVdtSKogz6bowoFWeBP?=
 =?us-ascii?Q?UvjegI4P0pCwOyGubUrB8+Mb9UYRsQXEH908QMz26RowlHDmh7CLKuQN3z3u?=
 =?us-ascii?Q?Y3PxVygex/1GOrpt6khLdu3tXNXx9+Pct7KPi7givEP7b+PwVfhLWKjk2gJE?=
 =?us-ascii?Q?Nu9ofYjWDX6jflbJDAfAMYLpJVxDY0qYppbl+ZhM9AKhJCTMakgqdXiGLLy6?=
 =?us-ascii?Q?9PcuHaTWbSQTE3MJgCwXy1267XkqjWlVidsTj7EjTthV7gejGZl6lpK+nqNK?=
 =?us-ascii?Q?NcXzU0R4/60Y2JOBken2KEW3HYY6UY/oab+Y8+CGnXxrPJDARv/ZbduJRJ7t?=
 =?us-ascii?Q?+qk/vHyzSIQg6Iai0Jjz6q3JQ6vI2enjC7UKz19Kf4bVPBo7a0dymRSsv5zu?=
 =?us-ascii?Q?PLZjqLQzKz7Jtv1M969ho7CTSqByy1oB4R1juReS+yUe2MNhKdp82eCTtJAK?=
 =?us-ascii?Q?gEpkKwybw1MvY9ZoFfSFCMo1TZu+JsKB7o9pxNuoOzNbrXQKdDFVj4hBAcf+?=
 =?us-ascii?Q?yefS8yIZwbK+OC6qE3yhh9Pujhm2EFCK9fTQXHuYumwiY6b/leT9bMIrRPO9?=
 =?us-ascii?Q?F7rGChDsh4CQv5FRdfq/D+GofLD+nBZinZkwaLOLS2F+XtPN5hHqSQ19s2nk?=
 =?us-ascii?Q?/TAPAHKLBXovrDgK/GbGHvDnMDj3VwL49z9l2wDjPIJWvV7Xciw+Mg/BBq1O?=
 =?us-ascii?Q?aSUwD6nLwG2Hbr6CrI7APoCs+l5it3wJzbMB1BCm/2Or0wM9KsIE5gF3WKzr?=
 =?us-ascii?Q?+neUcVXhQHIcr868upvjPhCpV9U+XfZOvG2jJEblyxvem0PANmj5hO8lDMgS?=
 =?us-ascii?Q?MfpZJp7696kYk+cJLWSw1MBmWE8hU/P3UgsBpTa2iEMkyKfxmEHJXkOHlZbq?=
 =?us-ascii?Q?KzG3ugNvdIGyFLmOT75NMxqb4QdFnU5AmzkMc3UCtpRe/Sg14ZFre607R2K9?=
 =?us-ascii?Q?Yni4ZRuUE1ocPqpqLwylnLIEYOZ2OEf5fAbZxcyxkQmffGOb2CrcgFMPrnG1?=
 =?us-ascii?Q?HUJ3kfhmQeheeDGuM163Nf8KkLHsBkUTvkW2NeR3nnR9TOPQBmPatwMEmdWp?=
 =?us-ascii?Q?rwHaC+t/bPSlLCVSc0A0mOUfDgGnHKOnMYjR3kDkdVdN9GimKemsqoe8cJ7k?=
 =?us-ascii?Q?S8yVoD120IG28kyQsENAltAi2Hv6WSoFFgt/MtRHU1xbQ2jFoPfV8hT66kFy?=
 =?us-ascii?Q?OlVGXXvmbFskf400OMd95UVnQiSsZg+JgC+asDqHL5Y6gAk9pldcKqYrjqxZ?=
 =?us-ascii?Q?F33STJ4M1pXAi/k+pkuKGA1SUkgkEe3h92ilpZSBjbhIKj3f23+P3i+OU7ke?=
 =?us-ascii?Q?VSSEzEcEkt+JbSjBwA+IabbPfd8CQpqc3V5IyWES1Ih1jKNjQyrsYXf15vIH?=
 =?us-ascii?Q?uXBCxQ2AxJtvtbIfcHi7V06ux/oTQQiApT2PGhS6tT3354fUmDwqqpoNKYqF?=
 =?us-ascii?Q?2Zq5BlU1uQ1cv2PSIvUjN9FAp05+MVf7dxlMwfq8e3W5wZYjtt7Mk26IDxWo?=
 =?us-ascii?Q?7kfOXZLktj+vdDrzzg1YW8FFdhTYsHWcBBLcRUCg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d396fab-a103-4230-189d-08dd086290f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:22:39.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPfqtvXadNB1gmh5oNPKSPxHahiVkWWjvQdJthMskTsa+bdjhQcEHVm9nZxr3+dvkkwCHlONJ5+/hO27TqxoJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10746

Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
to send PME_TURN_OFF message regardless of whether the link is up or
down. So, there would be no need to test the LTSSM state before sending
PME_TURN_OFF message.

Only print the message when ltssm_stat is not in DETECT and POLL.
In the other words, there isn't an error message when no endpoint is
connected at all.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
v4 changes:
- Keep error return when L2 entry is failed and the endpoint is
  connected refer to Krishna' comments. Thanks.
v3 changes:
- Refine the commit message refer to Manivannan's comments.
- Regarding Frank's comments, avoid 10ms wait when no link up.
v2 changes:
- Don't remove L2 poll check.
- Add one 1us delay after L2 entry.
- No error return when L2 entry is timeout
- Don't print message when no link up.
---
 .../pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 24e89b66b772..d36e01539ce7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -927,25 +927,31 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	/* Only send out PME_TURN_OFF when PCIE link is up */
-	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
-		if (pci->pp.ops->pme_turn_off)
-			pci->pp.ops->pme_turn_off(&pci->pp);
-		else
-			ret = dw_pcie_pme_turn_off(pci);
-
-		if (ret)
-			return ret;
+	if (pci->pp.ops->pme_turn_off)
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	else
+		ret = dw_pcie_pme_turn_off(pci);
+	if (ret)
+		return ret;
 
-		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
-					PCIE_PME_TO_L2_TIMEOUT_US/10,
-					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-		if (ret) {
-			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-			return ret;
-		}
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+				val == DW_PCIE_LTSSM_L2_IDLE ||
+				val <= DW_PCIE_LTSSM_DETECT_WAIT,
+				PCIE_PME_TO_L2_TIMEOUT_US/10,
+				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+	if (ret && (val > DW_PCIE_LTSSM_DETECT_WAIT)) {
+		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
+		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+		return ret;
 	}
 
+	/*
+	 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
+	 * 100ns after L2/L3 Ready before turning off refclock and
+	 * main power. It's harmless too when no endpoint connected.
+	 */
+	udelay(1);
+
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..bf036e66717e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
 	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
 	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
 	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
 	DW_PCIE_LTSSM_L0 = 0x11,
 	DW_PCIE_LTSSM_L2_IDLE = 0x15,
 
-- 
2.37.1



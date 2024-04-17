Return-Path: <linux-pci+bounces-6371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6E48A8999
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899591F228B1
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF117279D;
	Wed, 17 Apr 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VIPJn7ml"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0E171647;
	Wed, 17 Apr 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373229; cv=fail; b=FQwUu4hwr76M30iiQV0dVQCC1rGMEDt0bHHOM/qgsySccJGhnp3hJJitBtd/UPENMvwPgCKtneXTsYvU0hVxgXrIWfutlim0z4N3MYqmHlZBALSN+AoUPyzyq9o6kO6u381L7M5z3znrhxCWkX/KeCisFfPDOpCsIZzLZcyv1lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373229; c=relaxed/simple;
	bh=WYnwvMsizIBjI0dsvib/vHgErqffgHMQFqLXx05KeyI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CduqD8dc5M9LlsoZLx2c4mT1xtxdNsjco3DyE44xmoLlcTl8DCdM0hwUk0ziGLkJtzQUYHrx3pc7DCSyF48Hn+BWw1J7WyGANu4lbduXz24ZomZeZ+G0+mDfqRL43o3LbepP77hYI/xph/XlPWydXidasGLdlI6Wj2FA6xQs9z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VIPJn7ml; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jqqf/wKpih4G2yv4Rdz3ffY/kt1hTD7h9BSaOe0YgjETVPSm9mh7k0HhMp0QsnHZMolYk19pSRPbtisRzRrjfIFuvDga9CRiSlaoEqp4Ohgy+wXF7ikKyuOvL1gX4/KVUqE7s0+UdSVpFWbzjsCgycfCP+JF0DpkmTjg/rlOL0eUWPdGdXQzoRl64cxOvW9kGwRJ/tjSixguzUmAfMCAkLYFfKEok2o7iAVwPLy74gsbMiIiGJhJgWNmdjOHBkdwk32akQ3vl9X12RoAf5BcRSDTiuui/TRyD/BWJJsNHHlstihlzI9yzqDxJQ9Qwl3fgjadLR2GGf4miWTn6tGBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eGDa6Oi5FpOqvaJybgmzVETHo6HCdbgKB/yOCCnyqY=;
 b=GGDFTA/pWG8UPFrTbXxYTovODMcax9gf6SL9EXDlbdzm35s89Bcq0SZY0mLAylGMpbwSPuWlcLowIqF0bQmbKUw9DcH1iCMV7S5LmmsyslLDrDxU6YMINoY8gcOLwA+hBwStOcywuCkdg49MGwL1fFkPtZj/nGQ53VTtxhweUjWtkimJaMSCGiRGH+ylft0aTR+OWuY/MtjyTsVN0P/wwIoXRWXmsPaH+fVwt2EK57/47qAbiBCQO5h+h9QS1NIY/vrz2PQe/Ftecp+u4rm+y1o19HBijSR2cx40tGiKYeIf9Z9+gPHHZzvu1Oc1bT+3wO/5xgEPaffWYd4/yYfXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eGDa6Oi5FpOqvaJybgmzVETHo6HCdbgKB/yOCCnyqY=;
 b=VIPJn7mlO9f+iwPEs2Jjr7jXdH6Bp49V8J5pn4HfQLAOYT7wfIdg/6CD8n3VVmSa3L0tgc0wS1ZfLPD+PHhMc8uQ6EPKABpXsGd5Rb1yHJ5c8uRQGr+4ppjyJt22NIDtxHjnJFP+EqKIQRObQ/35nI534dNS6m2VpbP03b8MG7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8080.eurprd04.prod.outlook.com (2603:10a6:102:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Wed, 17 Apr
 2024 17:00:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:00:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 17 Apr 2024 12:59:43 -0400
Subject: [PATCH v7 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-pme_msg-v7-5-9c6208cda90f@nxp.com>
References: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
In-Reply-To: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713373200; l=6369;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WYnwvMsizIBjI0dsvib/vHgErqffgHMQFqLXx05KeyI=;
 b=iw75DLzDPH8t4Y5PLnGGaj8MTEJfzsqPoMH2wtnRfVk3JOXDlb+FySLw+bi6nlSz0A+N1yUa/
 5xUCzF5/EJABF4ZSeOE1c6oJe7/Y776lVy7r5SXRiQV2FHKDkeyp9i6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ec8319-b82f-4c92-8d55-08dc5effdf72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jJnPLp5TDBST08NRXyaGHn4HM5C651Owobc79+SeWQ6Gy5iLzQc4X6rritiNCPdsqmGDajgKKaGbxoNt2NcTiNZbf+TVN/wkHOyZ4j2ZFBIqtq+4C+iLvc//NcSIJcUhPgOcNlGgmZ/HPBy7wrsEzVoPd90hc8RFHUcVWMlrY3c4Z4HfH0qJw7rS3cYVlFuer8+1kO0swRYbsk3qFmfC+vkXyRemDQJp2IImTTct+uoWwU/BBDtfjMiQNegacnZNdNKxHAkMhYmx3t7dJ/oU8amxXUXLJTzQDu1VQg0ZXn4UXSM3tbPNLO3j5J5cQsyPhJ+pfu0lgfu64X2THZLquq7jS7pXxrSCOgRdRIta9POsywcM5L21jLH1DzQRb7bwUVJB1BSdnr0RFdBhC2EkrxpB3W2jpViKb+O/LgTDQX+kPvMhAzgxL3vxB1ZC8qDMIbb77Jqvf/CFHRWhB7oqYUk5huQwXpc5oP6sGWewxpj7OnlzKZo9L7mimeNufAtxvJ51PqqZ0qQlTi41nQbBMwSvQxocbyaK225uAECG3TpfAUkPl0/n3ELS5bk4BpDDjgirL+qeNnM/Fzc+mARG9w3Yd/JLUs7sAgzS0dCnZDPs/T3LphSkIZ8YBqPQgZ7hljldsZW2XbFsWyo32txNkeqVBDh/ruq4nhIHi40AzXSeFIOAw4RyLWDNT9VKimGiLl5H+n7hF2MPOeg38WtC4oolOb21Q44b+Xb67W3zCU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkkrdHAyNDd6QUdJaWRUa0NMTFYwQ3drNVY2My9KSUs4dVE2aDhJRXBKRUJI?=
 =?utf-8?B?aFVPZDVPcWkzdDdDTXcvekhxTGlsZ0ROWkViL3AvbXRsTXFPOUMxQW52WWNk?=
 =?utf-8?B?bENhcEszUTN1RUFFVzhkclNZWDBuejZzODlJU3BnODMyN29rVHBZUFZwZVR3?=
 =?utf-8?B?TGNZZno1OW1RcWE0MzkyZjdQQ2dVVDVTbWlhMEVWMjZ4RFAvL29QNm1IVWJM?=
 =?utf-8?B?bExobU90dVo3dGs1Y3dXNE5zTytxSnd6clkzSitLaFBJMWVrTVNnbkRtT2tj?=
 =?utf-8?B?aVpnNCt5MWlMMjdONW5LMGU4TysyWlptMld5NzFTYmpna1E4Vkppc2NFV2dR?=
 =?utf-8?B?M0NVSVVYWFNIV0lMb2pnT0NlU21LLyt3bFJ2bityWlpmaCtlaEZRN2JzcENP?=
 =?utf-8?B?WG1sM1g1M1dGTUp4RnFBekw2MnJMN3NHSFEwbmdMbGNQdXY5T1JxekVFY05q?=
 =?utf-8?B?ZEd5NjIvTktDaDlXK3lDcm91SlRvaVZtcGJEakNtSDJHNUlHdGxOUFJaUTN0?=
 =?utf-8?B?K3BXNkc3UFY4aTBEYzFQTjg2bTNBRkxOWmttakVMNlp0UlBoU3F0TUZubUJB?=
 =?utf-8?B?amdQSjZtblRhdkpsK0FGdTZNY3J6WU01bnk2QlFPMjE4MGh2djhHUDJONW5s?=
 =?utf-8?B?Ukl6R1hJK09FcURXMFdDYUZldXI3TmZZcTc1dVFqbG0wVnJQTy9wcUh0WGdl?=
 =?utf-8?B?QTZOZnJFZkI0Wnp0T3ZBM1hobll3VHNhMEJadkpMVExlYlNOUkFSKytDRll1?=
 =?utf-8?B?NlpnRHRETmdVa0R0N0djV3JVUkkvLzZySFg5akoybk4rZzRMS01lR3RwVENh?=
 =?utf-8?B?b2RYMmlkZktZdVR2K3hPSEhUdi90SENRaU9MWGVucGZFOUllZjltODc5bUk4?=
 =?utf-8?B?cnhHQVpMUVM5YkN0RVFmUk96d29zUnFHV1piRGtIRUE1TFdJTytzVEg4VnhQ?=
 =?utf-8?B?bk82L0RQRDh0eUhhK0FTbmNBQ211ZVhPTkhJNjFBS3lRK0prbFBETEhqRkg3?=
 =?utf-8?B?TTYwTEJFQW5pR0luNG1vRHRkaEZ2TGFualpEYVkxamlZREdEMFl5dUhRU0xu?=
 =?utf-8?B?SkZvR0FBaVNkN3l1SkNsK3RBQjBveU1WZDhPS0NtWTVvMmNYN1ZkTUNXNWFs?=
 =?utf-8?B?K1dmb1d2R1dkZjBwbllwNnNSUEl6Y2RZaSs2VnlrMmlGOGNJTXNVQWQ4dEtm?=
 =?utf-8?B?bGsxSUk5QlpUQnd6WjY0K0kwcVo3S2VrbnhLWEtOZGNYdHo5YlN0UjQ4b2dj?=
 =?utf-8?B?bWZ2am5oZHdIMjhTS3lxVmt0NXFlWTQyRVB5UkhUSXZYdld4NmpuWEFCMjRr?=
 =?utf-8?B?eWtWM0h2NXBUaE56bkVrL2lMS04zZWpBM3ZqNUtuMlZmdmxOL3FiSWo4bzFO?=
 =?utf-8?B?Mi9pM1MxdzlxbFdaYlkzcmt4Wm41TnhqbWphV1dTdm9ucndsNzk0MFczdzRi?=
 =?utf-8?B?M1ZXYy96by9IV2RLRXJ3V01HSFRDaUcrNjZYUFJTMGJwTTJlejJST05TMUN1?=
 =?utf-8?B?NHlQN3JuRm1uSkJXZFNnRyt1KzFiUlFiSlE5VUgzOUZnb0VxYlYzQ3BobkRM?=
 =?utf-8?B?S3FtTHJYR1RCVzE1SEtzeEdDTmRoUjFJZ3hsVnN3dmQ1WHNEQUlVejdXMTdo?=
 =?utf-8?B?RndGQU5xOWloZVU2Q3gvcmZucVUyUU9Cd0xXOS9ScDM0bnhTWG5qaHRaYkRY?=
 =?utf-8?B?REswK1M2eG5MV0QxalIveWNad1h6VFp2UmhHenFLaFNYVjhPRFRTSXk1cGlF?=
 =?utf-8?B?UktTVkk3dUVtUmhWREVraW9RZ2N1NmRzMGY2UnBkS0FkT1hnYTNUNkRLWFh5?=
 =?utf-8?B?eGQxclNVbHBCTjRhREt0Sk55ZHgvNDdPN0huSG1jVW91S0pQam9JT0dQNXNW?=
 =?utf-8?B?TU4rK0IyaWxoUVdVcmlSMmJRL2NyQUxiNUU1eFlFREpyMXVxV2dmaTZvL1dH?=
 =?utf-8?B?N1NXUExaY1k3VGt3UGxFZit4SGJGVWdBTDN5d0dzUG54ampydHdMTWtBbUlG?=
 =?utf-8?B?MzBmUExHSnRObXlzY0ZUK0tXNDVOM1JDWFN2aFM4RHI1eEhSTk1JT1JueHNE?=
 =?utf-8?B?Q2ZLaXU3cXlhZGFBQ0psOXFxbXRybFpnZW9sMjhQVEJxUmFyRW9xUGEweU1U?=
 =?utf-8?Q?PFnLrbJafFeoAxiTzCAsegy4F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ec8319-b82f-4c92-8d55-08dc5effdf72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:00:23.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19hHVRk8W3H+IGuYldYxRgveWbV6I+D+C7TPHmeQ/JKT/37M5kB/ijDW+5CBMOSPS9ac3QMNwkyl1yPC0jD1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8080

Instead of relying on the vendor specific implementations to send the
PME_Turn_Off message, let's introduce a generic way of sending the message
using the MSG TLP.

This is achieved by reserving a region for MSG TLP of size
'pci->region_align', at the end of the first IORESOURCE_MEM window of the
host bridge. And then sending the PME_Turn_Off message during system
suspend with the help of iATU.

The reason for reserving the MSG TLP region at the end of the
IORESOURCE_MEM is to avoid generating holes in between. Because, when the
region is allocated using allocate_resource(), memory will be allocated
from the start of the window. Later, if memory gets allocated for an
endpoint of size bigger than 'region_align', there will be a hole between
MSG TLP region and endpoint memory.

It should be noted that this generic implementation is optional for the
glue drivers and can be overridden by a custom 'pme_turn_off' callback.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 102 ++++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |   3 +
 2 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3a9cb4be22ab2..f57805b21ef53 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -398,6 +398,34 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct resource_entry *win;
+	struct resource *res;
+
+	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	if (win) {
+		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return;
+
+		/*
+		 * Allocate MSG TLP region of size 'region_align' at the end of
+		 * the host bridge window.
+		 */
+		res->start = win->res->end - pci->region_align + 1;
+		res->end = win->res->end;
+		res->name = "msg";
+		res->flags = win->res->flags | IORESOURCE_BUSY;
+
+		if (!request_resource(win->res, res))
+			pp->msg_res = res;
+		else
+			devm_kfree(pci->dev, res);
+	}
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -484,6 +512,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	/*
+	 * Allocate the resource for MSG TLP before programming the iATU
+	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
+	 * on the value of 'region_align', this has to be done after
+	 * dw_pcie_iatu_detect().
+	 *
+	 * Glue drivers need to set 'use_atu_msg' before dw_pcie_host_init() to
+	 * make use of the generic MSG TLP implementation.
+	 */
+	if (pp->use_atu_msg)
+		dw_pcie_host_request_msg_tlp_res(pp);
+
 	ret = dw_pcie_edma_detect(pci);
 	if (ret)
 		goto err_free_msi;
@@ -541,6 +581,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dw_pcie_edma_remove(pci);
 
+	if (pp->msg_res) {
+		release_resource(pp->msg_res);
+		devm_kfree(pci->dev, pp->msg_res);
+	}
+
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 
@@ -700,7 +745,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.type = PCIE_ATU_TYPE_MEM;
 		atu.cpu_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
-		atu.size = resource_size(entry->res);
+
+		/* Adjust iATU size if MSG TLP region was allocated before */
+		if (pp->msg_res && pp->msg_res->parent == entry->res)
+			atu.size = resource_size(entry->res) -
+					resource_size(pp->msg_res);
+		else
+			atu.size = resource_size(entry->res);
 
 		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
@@ -733,6 +784,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	pp->msg_atu_index = i;
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -838,11 +891,47 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
 
+static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
+{
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+	void __iomem *mem;
+	int ret;
+
+	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
+		return -ENOSPC;
+
+	if (!pci->pp.msg_res)
+		return -ENOSPC;
+
+	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
+	atu.routing = PCIE_MSG_TYPE_R_BC;
+	atu.type = PCIE_ATU_TYPE_MSG;
+	atu.size = resource_size(pci->pp.msg_res);
+	atu.index = pci->pp.msg_atu_index;
+
+	atu.cpu_addr = pci->pp.msg_res->start;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	mem = ioremap(atu.cpu_addr, pci->region_align);
+	if (!mem)
+		return -ENOMEM;
+
+	/* A dummy write is converted to a Msg TLP */
+	writel(0, mem);
+
+	iounmap(mem);
+
+	return 0;
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
@@ -854,10 +943,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 703b50bc5e0f1..dca5de4c6e877 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -341,6 +341,9 @@ struct dw_pcie_rp {
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+	bool			use_atu_msg;
+	int			msg_atu_index;
+	struct resource		*msg_res;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1



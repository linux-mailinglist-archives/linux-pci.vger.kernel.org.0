Return-Path: <linux-pci+bounces-6368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8320A8A898B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126F41F25048
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332D171081;
	Wed, 17 Apr 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7K500MA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD717166E;
	Wed, 17 Apr 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373216; cv=fail; b=c6Ozm/uiizjG4MkarAqnT6rMYi1lR17tGq+dnOdk3e4pdejGdR0c4m8gNpcue/vsQvVm7UXbzHLjgImq9Ii3pqG2qVF2OZCNGupRcB9Vx7inv43use3/8WtHVH5XJx0CrlyMtHNMjT7X7NI0OnRSqKbiLrb1QbRPBgvLG1jYSRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373216; c=relaxed/simple;
	bh=Z1R7qi1P8tpG+wqfBqFnd3RzZIQbkAXoWFjXpkLP86U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RQPd/+yz7xHO00IrjHy0t9vzjM8W/O7qEH86KVDAyJdmrxcPIRzSM2TvZXtw9U0tnupW4mb+5Aw6UZkwR4jLIPL0Sf+9h+Xp5mqwdx571hvXvd1wqeJycxTGLxZAZFgCrfPddqvyXQtyZZ9ruKeU+ITyol5cRFoSQGcomTrND40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g7K500MA; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeTZK8OprDyl3sGWs/RJI+Qu3PEx+SceTwcc25ihRNmxmht8TTsiyhF9AWoeB/hGf/rI0WVo5LlXFQotaLowlJYQNYO98acUJ0lKREJ1gkqzYKwkiAo1RGI2ldshs+zhERp0sg/tmdy0DexQQmrBHiEZKXcanXfqfyeG9Vxq0s272F9RaFkQU9K8PEDF8oqA8r6DGYIRSnWceTUyetOjXVEDrmz58ayV9zhzcCWSK0+zNRuFWaY3L3mxJBBHm+tmESX2TLnVPC8cMLiC+tpBQfOvvfgELFRJG+uNUtEqCkE8MeB82sIBnokWMW1+eNf2FYkEcWCEdeQYXt4DZuKsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpPzzDR2t0W4uJFD/pHJufCGdd3ZJ8oAc5V/JrUqpWM=;
 b=ZFiWcGwo8DZ5W2lnvOWMSSiwGmOSKCnTn6I+uFkGmqVCUK4kSfqd1OWSIDrCHNzkbhs+KsCrhaDLZ/T48mKkfOhkOvCo7r9tyjn1EIwg+qNwugbpG6QSFs9ZZP8T45i1QD8k69VlvhRjNBT1KM0XudNES8r37PQdWLmi7qk1j80xqmpq7b/vStczLFxD3N8ctma5wmnVV2o8eU8U2yYGZXtnJFMlyKba9JMFxOzYpoB8s1RMGGVYiwwhFWMPWni4wfk8RTKHI9SL7H/UhyYsi01TpMJBHfEx/H28Oe5+WglnRpvHIEJUVBHm8GuYkXvf10aXHqb8y9Tte/2OXFUTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpPzzDR2t0W4uJFD/pHJufCGdd3ZJ8oAc5V/JrUqpWM=;
 b=g7K500MA8k3R2QTsOK4LZyPiMMXMj6HGV79XO2Fvb9gHN6O9YZWqtzYRbF7WW0Y6NokiLyZygl9mGBcM6sPsc99Ezla/AYGLnDrzRc6McJaz0wC7Y0rFmGDA6TYOLO9WnlalQ7Frno/Bl8GXhygqnhS0FOHsMm9QnmenuYj3jl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8080.eurprd04.prod.outlook.com (2603:10a6:102:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Wed, 17 Apr
 2024 17:00:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:00:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 17 Apr 2024 12:59:40 -0400
Subject: [PATCH v7 2/5] PCI: dwc: Consolidate args of
 dw_pcie_prog_outbound_atu() into a structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-pme_msg-v7-2-9c6208cda90f@nxp.com>
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
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713373200; l=12761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ub0sCY9OqWzN3Pm6SPBEwtB2z80F4sah7lj6v7E5fbk=;
 b=ehwcx5a5f6xGhAwVrknFQWZYDsezt9SKt9DnsPu4dBafU+1M8hPVXN50eKXMBUGF1JdrQMJbW
 8tpNwbWDTV9AspLk651qtJWxMhkk2AT5N0qC0jUku6Do4gpTWhK/LWG
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
X-MS-Office365-Filtering-Correlation-Id: 218c189e-927c-4d11-2edf-08dc5effd854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yOZEHVtFgbXBCiQpJ8FiL0gT23U7/7NmWBryOm25+M4Ny6R2viu8+0uMZNKzJMkpfstKnxELz6+bdBK4Nu+50GPEwhr1kgqKCMfQnEjgkRKz6p47NpeInF/enuSpSN77qjtNJ5zlpnucD6INK3Y3PzvhU157KgHDxWKcUh1X0EYUmodVn9noiJE+G7lipcykVa2txFLiCkT5HbhtSqEszWAM16ClryiVbI8mOkSAdl48+svl4gKSLcBbypIuRzf6yOrSbnDw5AvQNHIzC2KJusfF3aFtsoADJAR4KKYiLlLxs8R1/gSTysbpmSOuf5IMSSJ3oGh/VCc07qMbFr3xw5N4G98SuvcGVqC/7nehbRaWuADoNTzFyzkqMefSLLNNYURrkQDs56e30rC6ArgRzLsXXsfwMZXTjy3BTvsu8qZp5EcZNz5hCy8ddu5L/4KAd+Pmq7960iSIpuuQHcpJ38IHf+LZQPf7tob5VjB5yJ17XjxznLoUwMa4SiQuo0oSuDG4Z5Q3fht9FiIz5cLbyqlbLYWJZxSVpeE8IUEgk8Z7/qrRxtzD2X3FA6KuEjKT7WR9zJZbW91IbyTRUrVrzJyKFUT2F5Gm8PJZM/vzSxbAcavsNJRUCWEFrVxXwp+9EcTkxYulxEafwrs8Wn9UmVXT0K/CCnket+0YxUSZ2UBkkWP8MD77y4BDeJ8ot/y5HpGyaRAQsisZogwad7AIeB58hxa55z8NKcG2KmNt37M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDVPK3ZUOEdOQ1dRNVVnZDFZSkpXNTQ1aGN0aUZIenpOMUc3NTQ0aWJRNC9u?=
 =?utf-8?B?OVJ3NGhmNDBoZklRNCtYbW1TQnZ1YnBvb0dnNkt3eUpoN0swbFNQcmdTeGtm?=
 =?utf-8?B?Szk1K2VxT2Zwa25GZ01TOWpTSDNVZVRHeW94bzlaeWp6bllvZGt5TGZqZnB2?=
 =?utf-8?B?MXpKK1RLNDNoTmg2aSt2VzRiTmw2ZlVpRGlhTTF3Y1pOZXU2blVoa3B1dW4v?=
 =?utf-8?B?WS9mdTNnQ0JJSER1TTA1K1FzVEMzQW1oMlViZUZOR0IxUVQvMSt6YUg4enV3?=
 =?utf-8?B?WE43MGRKeUlvYU90ck04RG1IRGN1QnpTRVk5TmhqUXNiUWZmTmNZbzVSWVVh?=
 =?utf-8?B?Z0ZRMERPbUNucVd6MEVwdVo5aXVvdmQ3clZKS0swTjJkQjg3cXY1aG1jUkpZ?=
 =?utf-8?B?MnM4a2VZNno0V0RUMk5VNk1kbW5zTkRGUVQrZmVrY1BUOVdCL0NWd05CVzRP?=
 =?utf-8?B?cEZFU2N6MkUyZ3hqaFQ5cXdZakxVLzVhYzk3N3VLZ1BKTlV0UTBVTGxJU0Vp?=
 =?utf-8?B?ckVVS1hTWW1HOGJUNzVBM3B0Mm5wa0NBN09BclJielZNbVN3cmlHR3lIYjVU?=
 =?utf-8?B?S1ZLRzB4NmNTQUVmOWpTN2wrS0RUUUtYQU9tWk41Q0FmMDI0dFMrcjNQdHZq?=
 =?utf-8?B?RDRHYm9HZjEwaHVzclIvYjdwMExnOFJPUU1VRjVRSnBEQjIydi9xVlByUUhm?=
 =?utf-8?B?b203dWtvZDU3NjErZitGVk1JZ01IRi80clVPSnh1OTRXY0dyV3dLRFVVRXIw?=
 =?utf-8?B?YmUrSG1sNXZyaDdBdVhiM1RKSUlxZWxrenBQRStWd1FkUU1JdDdUM3BMV2Iw?=
 =?utf-8?B?RmtnM1JjMHA0ZDAxZ0srV3Y0SWVEbmVLQkVwUHlHcHhSQmFyT3ZuQ0FIS1Zh?=
 =?utf-8?B?SU1RK3VjQnIzUHVuTGY0aVVON0x5M1pxSUZxRUhKcFo0Z1JNOUI4MkpwWmNk?=
 =?utf-8?B?b2RzbmxELy9lbDRPUWtvcklBQXBhaTU0cXBZdGkveFlteDRseUhqT0pSNDNW?=
 =?utf-8?B?U1hYSUEvNDgyWEJjQytDSWlTUDlnZnlKNjZCSjl4SGp1TEtxa2xvcUhSVUwr?=
 =?utf-8?B?UmZpb2xoWHgydjNzajdQU1ZZM3p0b0pFR1B3MWRjR25GUTRjYkRTSE9aWHhS?=
 =?utf-8?B?Z3ArcDZDMnptNzdhVjFtSTQ0Z2EvbHp6Zk4yMjgyNit3V2RKWE42QlRJWGpK?=
 =?utf-8?B?NTFBNU5Kd0x2ZXE0V0dzUHhrS2hLUzNNNVlrNE93QUwwSUVKR213bW1nNERn?=
 =?utf-8?B?aFh0b01WeHNZczJSeGpIR1RmVkl4MjFpY0QyTmRETnh1eDRGdEowTXBKQWdq?=
 =?utf-8?B?cHNyMGdYYTdENlRNTUJjNU41ZEc2RHBZT2FncU8vWDQ3NjIyM0dkV0VrZ21w?=
 =?utf-8?B?V1FRQ2M2S3laQXpyRjZaTGJXVWhhbXptMmFDT1lSNDdhV2pZalYwaTBhRkMw?=
 =?utf-8?B?aGhMOFIvKzhxcVQ4S1lMMUFuNVpqckFkSTBkSnVRaHNDTlp6MHZTMmoydjd6?=
 =?utf-8?B?djdCV3ZKYnYwNDdwL0RvQXZCS1VoMzJVZHJxb2hPaklqcytnWENYa0puKy9Z?=
 =?utf-8?B?ZUk3OS9lazVSaXBsMVRYWUs5bldDdGRBblFYZ0RVNkh2WDgyZ0svTUdsYzdl?=
 =?utf-8?B?Nlp6ak5lbW8rT1E3UkU5N3ZRN3Nwc1BiMWRsTnFURVMxelZaMGVMNDRNVk1I?=
 =?utf-8?B?UHlKakhOVU9Fa2czdzZmSm9wd3hrald5b3FsR3pSMHlEdEkyMmRDNDlLNDBw?=
 =?utf-8?B?OGEyUXZUNjZ2dndGSDMrZFdVVTlYTStrRUhRR0xabjdsUWtLNktPQlgzZktm?=
 =?utf-8?B?cXRodHdhU2JFK1VWR3hkTktORlU2MzdRM3c5SkJCUDMyb3dpWUNralJ3RGcv?=
 =?utf-8?B?Y0lZWENMWU5oajBubFFFODBkMTliZWlLaElUa1NZd0hHUkpGYTVvKzlVRDJZ?=
 =?utf-8?B?Z3huUjN6b2JkYUZPQWx0bHNpQjJqaFhXci9rZGF5MVdVZjZoN3ovcFZxa01H?=
 =?utf-8?B?anN1RzgwMUlpVFNTSGxFUzFFc2x0V0djRzJ2ZFRwcGIwTE1KaEVSWTlhVkJE?=
 =?utf-8?B?enBvSWhVd1VndUswVVY5ZmN0Yk5HaHBXUm9SOXZDazEvbzlieFgrMW5QTkl2?=
 =?utf-8?Q?HD7QDbntbXYNiMIppHy8IfHAn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218c189e-927c-4d11-2edf-08dc5effd854
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:00:11.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCMSWlm4zmUGJtTOw21QBTr0IzMYJK6qHlDc8l0loa8x7lkhpJN8MzhJ6I4/9N+40ZpMnoaUvgIfAm5J8PipMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8080

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This is a preparation before adding the Msg-type outbound iATU
mapping. The respective update will require two more arguments added
to __dw_pcie_prog_outbound_atu(). That will make the already
complicated function prototype even more hard to comprehend accepting
_eight_ arguments. In order to prevent that and keep the code
more-or-less readable all the outbound iATU-related arguments are
moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
is supposed to be locally defined and populated with the outbound iATU
settings implied by the caller context.

As a result of the denoted change there is no longer need in having
the two distinctive methods for the Host and End-point outbound iATU
setups since the corresponding code can directly call the
dw_pcie_prog_outbound_atu() method with the config-structure
populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 21 +++++----
 drivers/pci/controller/dwc/pcie-designware-host.c | 52 ++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c      | 49 ++++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h      | 15 +++++--
 4 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 746a11dcb67f1..9dd6a2edc7ae5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -160,9 +160,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
-static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
-				   phys_addr_t phys_addr,
-				   u64 pci_addr, size_t size)
+static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
+				   struct dw_pcie_ob_atu_cfg *atu)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 free_win;
@@ -174,13 +173,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
-					   phys_addr, pci_addr, size);
+	atu->index = free_win;
+	ret = dw_pcie_prog_outbound_atu(pci, atu);
 	if (ret)
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = phys_addr;
+	ep->outbound_addr[free_win] = atu->cpu_addr;
 
 	return 0;
 }
@@ -280,8 +279,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-
-	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+
+	atu.func_no = func_no;
+	atu.type = PCIE_ATU_TYPE_MEM;
+	atu.cpu_addr = addr;
+	atu.pci_addr = pci_addr;
+	atu.size = size;
+	ret = dw_pcie_ep_outbound_atu(ep, &atu);
 	if (ret) {
 		dev_err(pci->dev, "Failed to enable address\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d15a5c2d5b480..3a9cb4be22ab2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -554,6 +554,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int type, ret;
 	u32 busdev;
 
@@ -576,8 +577,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 	else
 		type = PCIE_ATU_TYPE_CFG1;
 
-	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
-					pp->cfg0_size);
+	atu.type = type;
+	atu.cpu_addr = pp->cfg0_base;
+	atu.pci_addr = busdev;
+	atu.size = pp->cfg0_size;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
 		return NULL;
 
@@ -589,6 +594,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
@@ -596,9 +602,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -611,6 +620,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
@@ -618,9 +628,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -655,6 +668,7 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
 	int i, ret;
 
@@ -682,10 +696,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows <= ++i)
 			break;
 
-		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
-						entry->res->start,
-						entry->res->start - entry->offset,
-						resource_size(entry->res));
+		atu.index = i;
+		atu.type = PCIE_ATU_TYPE_MEM;
+		atu.cpu_addr = entry->res->start;
+		atu.pci_addr = entry->res->start - entry->offset;
+		atu.size = resource_size(entry->res);
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
 				entry->res);
@@ -695,10 +712,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	if (pp->io_size) {
 		if (pci->num_ob_windows > ++i) {
-			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
-							pp->io_base,
-							pp->io_bus_addr,
-							pp->io_size);
+			atu.index = i;
+			atu.type = PCIE_ATU_TYPE_IO;
+			atu.cpu_addr = pp->io_base;
+			atu.pci_addr = pp->io_bus_addr;
+			atu.size = pp->io_size;
+
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set IO range %pr\n",
 					entry->res);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b858..df2575ec5f44c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -465,56 +465,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
-				       int index, int type, u64 cpu_addr,
-				       u64 pci_addr, u64 size)
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu)
 {
+	u64 cpu_addr = atu->cpu_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
-	limit_addr = cpu_addr + size - 1;
+	limit_addr = cpu_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
 			      lower_32_bits(cpu_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
 			      upper_32_bits(cpu_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
 	if (dw_pcie_ver_is_ge(pci, 460A))
-		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
+		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
 				      upper_32_bits(limit_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(pci_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(atu->pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(atu->pci_addr));
 
-	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
+		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
@@ -526,21 +526,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	return -ETIMEDOUT;
 }
 
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr,
-				 u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
 static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae48374627..d21db82e586d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -299,6 +299,15 @@ enum dw_pcie_ltssm {
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
 
+struct dw_pcie_ob_atu_cfg {
+	int index;
+	int type;
+	u8 func_no;
+	u64 cpu_addr;
+	u64 pci_addr;
+	u64 size;
+};
+
 struct dw_pcie_host_ops {
 	int (*init)(struct dw_pcie_rp *pp);
 	void (*deinit)(struct dw_pcie_rp *pp);
@@ -434,10 +443,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,

-- 
2.34.1



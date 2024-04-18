Return-Path: <linux-pci+bounces-6442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FE8A9F79
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A54B25445
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FEC16F849;
	Thu, 18 Apr 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kB4V+yGt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDC16F29F;
	Thu, 18 Apr 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456287; cv=fail; b=sf0bYfYTe1+cyBRuhqsr2Qya5RZKD/Y9WEf1KLftrA5sMDPs24VpPFBlEOvm6gF/q3iQknmMzpgpcz4/RSTHG+WL0HnSVJbDRer+z/L5AkZ/KJNgbBmLXJ69ycYzps8V6lAkXB6LElYQb6ki2hp3a0CVdhfdqDl/8il7WXZYdmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456287; c=relaxed/simple;
	bh=oa20jAtgf6BGI1t6XMDTMopuu8tQXdPY7/wRkpr1Qyk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=C1cTCe4/g9Y0rmvavjpIWoQO71I0tDqtANDXMH+Bmgm+qpUjIht02KbqdxkBxUXXDHBZo6yKTVacmPDO8GaWBoSSVbz1drjx9qUMDR5Gim5yi6/U96JrWJGkOLDr9br6AT1FC3PX4fK5dL0TJBVHue4iL/Mvu20mmgfWukHhKcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kB4V+yGt; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWPkg/GRjDKDIbqb1biprlB2dH6TNLPjG5Lj/fzFthmxXCt6XJNgubnPFbsFtkP6PsUnY3haFvt307w8A57xG7vMqSukOfe090HuZc1pPb4uiz7lluEc+6Fwr9IzTm4kGU8jdWH8obzHUAv6ow2zPzT96E2rEcKI6gBty1ZqJoQeMGHea4Zsy+wnHiJ+glDSONjnFTN1ETWxN8DRGA8qx6oPexXaZib5+Qas1PDB6+ay5W733n5dHHMgJhoKH2PyOyhgLkcKGiDVL7UqaBjveyDmNPSlxvjc2HloOQdVITXE27h2HFrB9XaZDjhYoJa1EYzWcZeqWztTQjUbh4VOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpZltRIn18fpINxFNd1o0NL5JiPfprG4paj2+fqnaWw=;
 b=CRiSyDDRiyU3euXxThrFeFN2pSFBjl6+aDPsUGT2xSv1mvGM5FT+dr32eRqUiSTPKNr5vAZhI7I+0jzVHPPs16rs2+DayBrVv6ffnkceIZLuSd2e8A6R65DFZ7uKb9+DfnJ3tCKRgL1cUTUsK3iR31axr8ypp1tRQpfE7xguEoZjKM6YRerAwSTVCayfSSpxN2ouSLdsHUNDyTbcO9Dqs5LuL6tXBlmjQg/zyp2tG4Cwd+AcYiipNVmWADajlH5UKunUp7TP5keXoyqXVeufHj3zW+Da2j3RgjeAzOWJ4HbcMwIwxlPWLy1jG4GOG6DcyyPc9edYtJCdlzLU81tW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpZltRIn18fpINxFNd1o0NL5JiPfprG4paj2+fqnaWw=;
 b=kB4V+yGtjcpZO2D3QMRWtxTYOnpbGRzH5+CpvnN5kO7Zssiw+M7FhR+ddecdmYj+zWBteCp9qbaooGxgEGkSwvLtVt5ODdnd/or0NccYbuJgEvM304r3TqrkkZAnXgJTbC8t7CS+4ZfqAOKLlgJg/iJas+R9rb0n22ND5IKDDWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8057.eurprd04.prod.outlook.com (2603:10a6:10:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:04:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:04:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 0/5] PCI: dwc: Add common pme_turn_off message by using
 outbound iATU
Date: Thu, 18 Apr 2024 12:04:23 -0400
Message-Id: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdEIWYC/2XMy07DMBCF4VepvCbIHt+74j0QQoNn3HqRixIUF
 VV5d9xunMDyjOb772LhufAizqe7mHktSxmHOsLLSaQrDhfuCtUtQIKRSstu6vmzXy4dEVBQzDE
 EJ+r3NHMut2fp/aPua1m+x/nnGV7V4/q/sapOdmThSyKRTT69DbfpNY29eBRWaAqkagqqct55a
 SGzQ3NUeq+gKV1VzoDZepSAdFRmp5RuylTFgIkMeYQIR2Wb0io2ZavCHHNm67PRf5RryijblKv
 KOkKKLiBpPCq/V74pX1VMDmRIhFHmprZt+wX3xGu24AEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713456277; l=6625;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oa20jAtgf6BGI1t6XMDTMopuu8tQXdPY7/wRkpr1Qyk=;
 b=1V3vdOMBncGsPSV+ADr2AI8UFQugrxPac6MHJisxTCaj7/V3EKAXbiQD2uUvsuLnqTS+jrwMJ
 RTBx911sIxJBHTl/KQk3o65LGzo5cMrJ34e+hu8XfpUt87hzoYWwBwd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6a5022-da70-41a3-09db-08dc5fc14184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xj72f0Mo3xPRIBMtVQDha0e0DeqV8qoj0NhQAAENoOUaIzO3n46/ky33N2DQDuc0c0gvdYmlZgarOdhjijSj0/p1VPoodbGeBIXItAvvKpupgDSOrt58MFMl89mBi5xyigUX2pXGcV1UXhoUNlxpoJvrWdG2mzfGPFfCS44qm8W9xJ8xb+SxSm+VJjYTYAr+0GG9LGeQpULZZZtD4FSP6ETF62IyhtzDfTlhXOPNPijtJJXHFOkEclvkRZRDRCL2w5slBvjYyrLFjH5I1BLfhr81WD2o5ZnN5e5j1OMJKr8PADuhsglag1bBmwBmEs7rIfkr43rvVXBIuImiz2z0qMdiIGJBj2G2nkycRoVj+lddPLFtvWQrMYRjqIr6aYAY2m6scp5hD/toygdKS2F5G2tJ6F1CVg7R/gTX2TK6Bw9N6ax/Ww2qo6UIhRVgO2nH5zvf8RRJD4SBH1ThODVc4MpGC8fGlNJOWU9A3kIaz3p3V/EWqvvlnvFMQHTRDFRuA5nm1cser+gz8ZT8/m303Mv+bh5dk4dpupn8STqLLz9OYXqlLEIsUME27FXuXHp3P6zAR75kTBlIHvz87rBWNG3Zl69/ujzeSmJFZRYx1K2gx68hgf2Zaw/8PjpUxclJzWpMR1+8yBfMFeZT4INTyjjlg4PIB2vXXtc1M+ZFGlcun0ziON4Znw29JsDq7ioJ3Y8hrdICH45RB5HfjRFhYcgbhCGkV36vaBDxL1cWkJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bitKcStXUEZiUEM1UEJLYVd5YUdaZGZEa0RXdE9udlh2UHhRV25neXZpblZV?=
 =?utf-8?B?MHZuQzRCSXp6LzVMYWZsdGpFeEpVWDhMVitHWkRMUHY3NkVZeDNtajV0Um1T?=
 =?utf-8?B?bVBoVm8zVUhjNHlQM0VSUzZwRCtTdXEwRkQ1UjFmdklxTHJ5T1p6WjBGd1Ew?=
 =?utf-8?B?NEMvcFhMUmh6Q2pMZWZqenFkWVIzSTBRMjJMY1RiWEhGRWk5LzNMWk1WaTJY?=
 =?utf-8?B?eEZXTGRJMDE3RWNTSm9uRGNZWE90YWVHaVpONWt0TlRvV3VPWWlUSzZDSmVk?=
 =?utf-8?B?aFdsNmE0aWZ1VFhxNFZYNEhROWMxb0FQOHYyTmtTMENEc2FUS1lvM1dVVHRq?=
 =?utf-8?B?ZFJQeXc5dTF3WnBFSkJVRnBOY3UvN3BTekhyRUZ1LzVaK3dFYXFwTHI0V1p3?=
 =?utf-8?B?d1d0VStla1BMdXJQbmhsK2Jnb2dUc3l2anhSNlpjVHIzbnJ4MTJldHVqSEN5?=
 =?utf-8?B?aDBRVVhOZlhITXRvVWFqUVhVa1BLM0lvUkpGaC9aUzVZUkREK25jWWtYN2FP?=
 =?utf-8?B?TDNIa3VCYkJPZWJ6QkdDK2x3YUVXK1oxbXlZUHhqT1NIUEEwNkZYWWMybGZF?=
 =?utf-8?B?MHVnM1luUFRUU2VpSHhHUkFrWlE4NHBYdGlkUGxkbjBYWGY0cXVneDJ1YzZy?=
 =?utf-8?B?RkkzMXNoRTV2dDNZOWw3NXJpKzBvdjZDTnNNaDdFWGQ1ODZ5eVZaL0kyRnZ4?=
 =?utf-8?B?UTQxRGpaOEF5aVhzN1F5NU5ZV0JnVUtTOTZLN1ljWnYyc3FweGRlNHNUbDRV?=
 =?utf-8?B?SUJ4SDJhMjFGU2g0NFk0ZGYxN1JhZGR2RFhPeTNzcFBvYVIwdjB6SVF6U2Fx?=
 =?utf-8?B?ZzBDL3BOS2xhSk5WOEVDbmJUYUJRMWNrelRSL2NpeU5JMVRMbkw5bStZbTI0?=
 =?utf-8?B?bXdtMFZtUHdYTGtJVlRtN0JhZ1BqYkJ1VWNXck9xN212TnIxYStsZ3RMdHpo?=
 =?utf-8?B?SGdGQ1N2TndId0ZvSktscHFmUXVKMDJDRUxSVXZIQmI3MEhaSTdPMUNNZ2tW?=
 =?utf-8?B?dWg2cEpLelFwZUhZc202WCs0ZzlobStmdExPT1E5TGFUb2dnNnRGU2hkWXk2?=
 =?utf-8?B?L0lkSmNCb1lPZUdydzdHV3FWY3FYOTd2c282bUI4aVIwamJiUm1wdjlZaXpn?=
 =?utf-8?B?N3RVNU1nYzVoQUVyRVlyWDk3d0w0ZU1hTHdtc3EzTmY4eUtiMittT3d3VWlY?=
 =?utf-8?B?enhhQklNWDIrMCtWR3FnK3k5UEhQbGV3c1EvQm05blRwMjNMUGZHL0FqV1hO?=
 =?utf-8?B?d2VoMWtmOUNqYSs0NlF6elE1R1BpZFBrZHQ5RGhwMTNGeG1wbDNXdGloU2c0?=
 =?utf-8?B?L0s3b2RaYmVvR1B3UUp6TjJYU3N0RE1GQVRic09RWEV0ZUJyS041a3ROU1dL?=
 =?utf-8?B?RWFjUEtqY1A2aDNCV0lLc2VNTDZSNFRVZjVRbno5MWtTSnVHclhtWDFEWFpH?=
 =?utf-8?B?ZGRhaHkvUmVmMUI5MzFpbHUzdFpLaXNvVzNDemIyYXlsV0xqeCtSUjkrbzB2?=
 =?utf-8?B?RkpQcDYxR2o1SDNZajNKNzdmcVBDL2FCOUl3THN2TENMRHJDWEJOd2Y4MXZD?=
 =?utf-8?B?dURvSXhKSDJRd1VqaTVJeU16UnVidUN1bSt6WU5aM2MxTXFHU2FuYjFabHhN?=
 =?utf-8?B?NTlFMGJVNjZuRDh6WHZrTGVaeFQxZ3FDcjFoMmxUbkFZUkVZTmdrNC8ybURC?=
 =?utf-8?B?OU1BcXlEbG5TRTlTYmhRZXJKTXJUSFIrY2RFZGkyRnFnWkNSN1ZJUnJwMW93?=
 =?utf-8?B?aGtITXZmRDU1NHdMUkFzb2YvN2NPNGtITTZkMndpRzhpeXBiMjMzdEN4ek1F?=
 =?utf-8?B?bDFCQllBUW1LZGloRVFIUEhiV3RveG5DWmd6TnlpV1NRc3VSV3RoajVGQlhv?=
 =?utf-8?B?alI2ZWtlRXNnU2Nmc1o2TFp1bTFpMUs5bE5KR2tjV1lUbHB0VnFvNXE3dnZG?=
 =?utf-8?B?M3g1L2Qxd0xwdHh3U05CMzkyekxLTFB1ZmN4YXEzY2hRTHdGWXluc1hnVndN?=
 =?utf-8?B?YnQvcGJZTXRhK1BHdytkNktpRCtNSTVCODJBZ285TkVlSDV4N0w1cDVab1FY?=
 =?utf-8?B?U004Rm0yN1BYdUhySER4NHhVendNZVBBZkdDZ0U1U2JXK3pNMEJyTGJlRm04?=
 =?utf-8?Q?/NXGCWBipl23/WJu3IBauJ7RM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6a5022-da70-41a3-09db-08dc5fc14184
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:04:41.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOXTMB5Ude+rIJgCTYjXCJr86/n/PiT1gn0HtiCQ2tXzWAArlvQT1Sx/Fe8cd9GtKWPU7C0CrHNOjwyKTbsuNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8057

Involve an new and common mathod to send pme_turn_off() message. Previously
pme_turn_off() implement by platform related special register to trigge    
it.                                                                        
                                                                           
But Yoshihiro give good idea by using iATU to send out message. Previously 
Yoshihiro provide patches to raise INTx message by dummy write to outbound 
iATU.                                                                      
                                                                           
Use similar mathod to send out pme_turn_off message.                       
                                                                           
Previous two patches is picked from Yoshihiro' big patch serialise.        
 PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
 PCI: Add INTx Mechanism Messages macros                                   
                                                                           
PCI: Add PME_TURN_OFF message macro                                        
dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
to map PCI msg.                                                            
                                                                           
PCI: dwc: Add common pme_turn_off message method                           
Using common pme_turn_off() message if platform have not define their.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v8:
- Total use devm_ manage msg_res. after read devres.c code to better
understand release sequence. It use reverse order to release resource. So
it is safe for msg_res.
- Add Reviewed tag of Manivannan Sadhasivam in patch 4/5
- Link to v7: https://lore.kernel.org/r/20240417-pme_msg-v7-0-9c6208cda90f@nxp.com

Changes in v7:
  patch 4/5 add
  /* Power Management Messages; PCIe r6.0, sec 2.2.8.2 */
  patch 1/5 change comment to
  /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
  /* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */

  order according to value.
  Add Acked-by: Bjorn Helgaas <bhelgaas@google.com> in patch 4/5

  patch 5/5
  Apply all mani's comments.

- Link to v6: https://lore.kernel.org/r/20240415-pme_msg-v6-0-56dad968ad3a@nxp.com

Changes in v6:
- Move PCIE_MSG_CODE_PME_TURN_OFF ahead before INTx to keep the codes
sorted.
- Added reason why not alloc_resesource in commit messag.
- Change title PCI: dwc: Add generic MSG TLP support for sending
PME_Turn_Off when system suspend.
- Rework commit message
  "Instead of relying on the vendor specific implementations to send the
PME_Turn_Off message, let's introduce a generic way of sending the message using
the MSG TLP.

This is achieved by reserving a region for MSG TLP of size 'pci->region_align',
at the end of the first IORESOURCE_MEM window of the host bridge. And then
sending the PME_Turn_Off message during system suspend with the help of iATU.

It should be noted that this generic implementation is optional for the glue
drivers and can be overridden by a custom 'pme_turn_off' callback.

- using devm_request_resource()
- using mani's suggest comments

	/*
	 * Allocate the resource for MSG TLP before programming the iATU
	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
	 * on the value of 'region_align', this has to be done after
	 * dw_pcie_iatu_detect().
	 */

- Add comments, about use_atu_msg, need glue driver set it.

- m -> mem in dw_pcie_pme_turn_off()

- remove redundant check() if (!atu.size) in dw_pcie_pme_turn_off().

- The reason can't adjust windows->end
This windows already reported to pci system before this function. It is
not good to modify window-res-end. It just add child resource like below.

windows is root resource, which will create may child when call
request_resource.
          bridge -> windows
		child1 -> msg
		child2 -> pci ep1
		child3 -> pci_ep2.
		...

Although you see whole bridge window, 'msg' already used and put under root
resource,  new pci devices will never use 'msg' resource. 

If change windows->res->end here, I worry about it may broken resource
tree.

Detail below thread:

- Link to v5: https://lore.kernel.org/r/20240319-pme_msg-v5-0-af9ffe57f432@nxp.com

Changes in v5:
- Default disable allocate TLP message memory windows. If driver need use
this feature, need set use_atu_msg = true before call dw_host_init().

- Link to v4: https://lore.kernel.org/r/20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com

Changes in v4:
- Remove dt-binding patch. Needn't change any dts file and binding doc.
  Reserve a region at end of first IORESOURCE_MEM window by call
  request_resource(). So PCIe stack will not use this reserve region to any
PCIe devices.
  I tested it by reserve at begin of IORESOURCE_MEM window. PCIe stack
will skip it as expection.

  Fixed a issue, forget set iATU index when sent PME_turn_off.

- Link to v3: https://lore.kernel.org/r/20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com

Changes in v3:
- fix 'MSG"
- Add pcie spec ref in head file
- using function name dw_pci_pme_turn_off()
- Using PCIE_ prefix macro
- Link to v2: https://lore.kernel.org/r/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com

Changes in v2:
  - Add my sign off at PCI: dwc: Add outbound MSG TLPs support
  - Add Bjorn review tag at  Add INTx Mechanism Messages macros
  - using PME_Turn_Off match PCIe spec
  - ref to pcie spec v6.1
  - using section number.

- Link to v1: https://lore.kernel.org/r/20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com

---
Frank Li (2):
      PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
      PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend

Yoshihiro Shimoda (3):
      PCI: Add INTx Mechanism Messages macros
      PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
      PCI: dwc: Add outbound MSG TLPs support

 drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 ++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
 drivers/pci/controller/dwc/pcie-designware.h      |  22 +++-
 drivers/pci/pci.h                                 |  21 ++++
 5 files changed, 199 insertions(+), 64 deletions(-)
---
base-commit: ef6a734484e939cf67bc41c45bc936a78ea210f0
change-id: 20240130-pme_msg-dd2d81ee9886

Best regards,
---
Frank Li <Frank.Li@nxp.com>



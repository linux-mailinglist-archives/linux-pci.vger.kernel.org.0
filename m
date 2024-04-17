Return-Path: <linux-pci+bounces-6366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC478A8985
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E48B1C236E9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946F917106D;
	Wed, 17 Apr 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="okLbzM/u"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61216FF4E;
	Wed, 17 Apr 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373209; cv=fail; b=QvfapelKqha6XwvWl9upIQeUITLt0GRsGgwbDW9SYdUV7iLRMF7kHX3WHnUetHTLMmgzMulHRnNIYzQIQzcec4CQ8a99S2Kk/W4gWj27Sw66KgiHN0T3fmMx/uK9ptIdezUA4wskn45Nfz8sH249/WZQK7ptcnEI43zKjPGJBQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373209; c=relaxed/simple;
	bh=6A4YdKGW+qmEv9LurH0bq4iO422bipXEb829MgPYYbo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OQaWtF1jakbclkIdTwc51Sslrmgwj0cIfCVHpA1gW+YdDBgQo41YpyvpnGcBvEcTrS4pVrIsrjPwp2MT8V1fVu7KhBNK+Nty/k8Z99bnqztZW8t40dX6RTJ07E1ROX2TJnaKt6giu20fl6nDZRd7X798iREK8dpv13aCvDFSuNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=okLbzM/u; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlcdZCPFBGhU/jttIfL0triF3XVHTW7KYjwcptGi29880hh9SPjJ+oGdVhIzgrs6iqavRDFQ8b9DAhQTr+6rMx4HN6wZ2SlP/H4x4CUUq/R69uj9jMLr5EFcrrVwCdun5onGIVRvLIEg3SzTsK9zj5ZLw3Gi/EMNd+aRHKl1I4CdYY2OTWS2HOj/XH5Goo3WN4Z0CRI8SUb77l/fT4p3osIx3VFt2+3CuKiTWt43m6mZWr6b+bacyVBp8dVT+IXu7ZPJWG86080hrakRndTDcmKuwdwIp0Cc/g+uORMPW8y/WBIVlKlVnzVF1EuISA0qC1QCVZNjKHsrOSnTgbyfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9Pvok6cqsoWzvIxsZ7LIXKfUQQEgGplayr0uCCntxY=;
 b=WX0VOWJCRhyZowep4Jy8OIAzuNZw13C3UNkgRJ8o3aB7CxJTfndieDMiK0llOTBONVmhWOcjg2wZdb1EBzGHmCVNzASJP2+sQYnjPjZd3ODSh10WkMFKN0PlYyVU6gJTPhHNDBwrVVz0orRU9vEgoicV26WrAYu5SKLwJYARDeUQQPB8ZAv4cSR5ziXZFnAUulrcG2z4fwcV6/rAVs++J/x0KKqpb9+YOIUqrh7YewkYu3rFodkVslaIxj1yfTn032nya79LKh6LiG6aTGE5P/Ziwrv7JYeHGFn4DMwOV76yvQN9uqGAr0ew82wrjdYaxJwUNgGdU/E1m6s2tbnc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9Pvok6cqsoWzvIxsZ7LIXKfUQQEgGplayr0uCCntxY=;
 b=okLbzM/uPSKmZ9QyQ0Q5sAAoK8xOhEZoJkEWsuF6NwW/sc4CnfJ/fIQsL1JnT1QX3KYwD+L76BrISXBixThg/L6FoEnrdeOXzo2pUd1p1CpKKgKt57lNcPtgea7JcU/03Gdz56BQm/uqrgpeymf0tdnfVhkGAULW7Uhblwn2CYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8080.eurprd04.prod.outlook.com (2603:10a6:102:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Wed, 17 Apr
 2024 17:00:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:00:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 0/5] PCI: dwc: Add common pme_turn_off message by using
 outbound iATU
Date: Wed, 17 Apr 2024 12:59:38 -0400
Message-Id: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPv/H2YC/2XMS27DMAxF0a0EGleFRP3sjLqPoChYkUo08AdWY
 SQIvPcqmShuh4/guXdReMlcxPFwFwuvueRprCO8HUS84HhmmaluAQqs0kbJeeCvoZwlEVCnmfu
 u86J+zwunfH2WTp91X3L5mZbbM7zqx/V/Y9VSSXLwrZDIxRA/xuv8HqdBPAorNAVKNwVV+eCDc
 pDYo90r86qgKVNVSoDJBVSAtFf2RWnTlK2KASNZCgg97JVryui+KVcVpj4ldiFZ80f5pqx2Tfm
 qnCek3ndIBpvatu0X1u4F5qoBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713373200; l=6293;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6A4YdKGW+qmEv9LurH0bq4iO422bipXEb829MgPYYbo=;
 b=EdlhBXE1W6PJ1E+KxsXIKh8S0lw3llrkDoTfzKljfmfc29Yp1RVN8ifEoZ6EgLNRcs2j6VZqX
 jxIAj5wKOCQBCSPUUdX16iyygddOBqbpYLu03YTeZR5agAFHCJe68jh
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
X-MS-Office365-Filtering-Correlation-Id: 12cecf93-f268-498d-d81c-08dc5effd399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zgh/uslssq9X8IgLTOS1LOhtZujOBbiB5O6pLNkIYKs5kikIzw+U5HiiGGB48WiX5auWAOQQDWeuTK77u8bU3FdIQHGSp/93ZytrxVc+BbBFMHZho29beLBsn2CrifpiXGd3xO4Ic1ru0SYDpfd2u3wYFIe+6BaJUHNIbe0wgIiLhBD1WpBOoFbmKXjexDv2Y8A7IYlG0rCHp2Aq/NvnADnRdEI3KhqnlYBjlWvGCaR6UZ23bdUlMiBgj058MoIAHvGHExs3G7ssnzfY3JXq0ageTlUxqqy2JhsQZqoSIGpaSdz/RYTU2eHBjTnmUR+DgOeOAJeVpmE4iIfBZosjvf0V1cUAoR4kioV1CUVK5wUG6IC2QHS66s7H9xfW8K+2w3z1NsVAiVhsliGHVKWEHTxouLmG1YspgwTMAGU0PVInvxt1uWf1m7Uysc+zQtmZqrFVJgPiS6pDuorzD7ci+Lu4fzqdYWAAYFnnEa9Xs6QuzWaL8Y+N7Ua4r4ThRKFaamDPaKxXlSewdZ8JPW+3LQdl3OdF9HGRzX1B/axl/qLdtbpUkX/vx5ONgfg/2heCln+ceXzSFs2JrrR5HhJCus3GhuNkfkGVSUGr5g2NzSFC7HdGBSOFT6zU0iKoZcSlsnEm1dHYUYAkLYhMxU/0ZhNJbmwEUAW8IAcJnAs6h7zW5c3f6FpDcM6Ce7Y/mfas/txv8bZDQbglmgwrwEvtn079ROKdU0lwPbi/GniiE/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjRibEpzczVoRUFQa016ejB5NW1OQkw0R1o2SEEybG5OaTNnd003WlMxTHNB?=
 =?utf-8?B?Nzd2RlV4NnhYYTlyL2JjSEw4OE9uVnYvTXdtcm5EYXZPOStUSmQrc1pUNVZR?=
 =?utf-8?B?SnFSZzlQaDRhejJDLzI3eUVEVG1hVkpTZXAzVWJPVDlwZUZDejl4YkpzUzht?=
 =?utf-8?B?dHBTSEFWSWMyZzVoeFpjWGdOMnZQZG9tSzBvY0E3V0MvdW1LYjR4VEF0ZFFq?=
 =?utf-8?B?NFBxMnhDQno2YmxhdlRuZ1Z0SnR1K2RRZzc3TWFoYk5Qam91K3B2c2xUQUFm?=
 =?utf-8?B?T2tydzBRN3VrOGtLUFQ4MDFrc3VqOTUvdVY3aUNsVUFVYlFGS1hMS1hpYnNm?=
 =?utf-8?B?Nmo4dStpeW5kRU1Ta2h5UzlhMU1Ndkx5VWdqWmpHRGlLeFcvS1hqSGJ1Slo0?=
 =?utf-8?B?QjNmTkxxRlN0OVc0Tms3dGlNdXJuYXRYNEczV3lYb05qZW9BdTY0WmNkVnJL?=
 =?utf-8?B?Nmw4dkpGSFV0MzlmU0hWdFV1dDBXa2FycnIwUHM5QVBLaGc2RFhJejBEbXV3?=
 =?utf-8?B?Q1lMeFYzYkpuUXVxVXFqQ25EaTNPVjgvcm00VlBjU0h5MmgxSXY4WWk3cEd1?=
 =?utf-8?B?OC9YQjFDcEJSZkNKQ2doVjg1NDVJc05wNVVZckwyMGVlL2FwRHpCMWZ3TUhM?=
 =?utf-8?B?TWlUdkpER3JFVmF0OTYyT2d0T1pROVdkbDE4am5INkw1TWRaYzdUM09VNzF1?=
 =?utf-8?B?dmNXNjdUc1Ryc3IyNHdTcU9uNFZCWFpHY3ZFelhkeHRYSnkwUFl3aTZldnF6?=
 =?utf-8?B?cnB4YkFTeVBnL3FFdjZhdllFS0JHV3lvTVoyYlY0eXNpMWt3MHJzNG8zcDI5?=
 =?utf-8?B?ZHlSRDVPS3BIOVdMNDM5QkRTUGJ1Tk9VRVBPWk42RW5Ybk96MThhNlJzNXdV?=
 =?utf-8?B?ei8rQUZ2U1ZlaFVNSTNwWmxUdy9IZ085dU9nMVROM3ZZaVdrckE5WmM2Z015?=
 =?utf-8?B?b2RINE1OM0lUbmh2a2NmUHEwWmplVFpuSFg4Uk4wWm1EYVVrTzZsbVd4QnB1?=
 =?utf-8?B?ME55VU9EUXR1RzdsV29PQmlHV2tpZFUxd0wvMVB2Sit4bUV1M3ZVRVNYdXBW?=
 =?utf-8?B?RnBUc05KYVEzczdHY1ZiUkk1MTVCVUxCNWlrenRKbFV6TnZEOEFxVXlZVGxo?=
 =?utf-8?B?Z3kreTMxeXA1c09XbVU5L2FKNDNvdmFCZnBOYkpHOFdmRXlPSFg0KzVZUFJS?=
 =?utf-8?B?eGJsWDdCbzdJTnRRTjNzSnlVMlJRZ0xuNkVpbnc2VmNFK2hKaThQeVhHVG5R?=
 =?utf-8?B?WG5jSzRmeDVNYTVkY1hYak4yMFpVbHhyeU1LWjg3cHI3TmlQUTJ4MFRETktr?=
 =?utf-8?B?WmlXWDVsSWRyckZXTkJDNkhabmFTWklKaWdSR0hubDNpRzZhQmxxaW55VzhR?=
 =?utf-8?B?MnU2RHJJdmlVRjUxcldHQ3gySGxXdGd2WHVCOURXZ0ZwMVBkY2RjZWNQbDRB?=
 =?utf-8?B?U0NoUzZwSXE2Qm1nMDZhdDlCckY1RDI3eGFadEY0QUdUczFYa3NFWjBSNWJE?=
 =?utf-8?B?L0VDTWVOR203U0VMVnc1UWNGZGUyV3draG03a1V4ZWZZbFpPMVRTQXl2OTI3?=
 =?utf-8?B?ejBpU0pXZnhFbUpUQmgxaXVLNTNabFFNblErLy9nNzMwcTY4c1RkSFA0RTFi?=
 =?utf-8?B?Y1lYN2tYZG8xMEhxWXhRZU93NXR5RTQ2Y1RNL3gxVHY4bjd3QWYxUFBuN09o?=
 =?utf-8?B?V3l1SDZjV3p3TFBBUWR5VmxhdS9TeVFWdm9jaEdta0pvOHIzVVVRb0diTWkw?=
 =?utf-8?B?RFZUS1o0WTA4NXRPZVlJZnZXY05rcGFTY1hZRDQxSDl2TGtpMzg5UHE2Q0VQ?=
 =?utf-8?B?SGU1SEkrTXZIankwY0E2azlPaHA5ekdUSkpmaTV4YkpraXIwWjlIb3ZKZTAy?=
 =?utf-8?B?THh6QzBnZThYN0FLdjdFOUxrMTQwN2p4MURUTzMxNXRvL2xFOWRxQkhtRjJV?=
 =?utf-8?B?bkg5VGVOaTEzQ3Arc1Z3bUdJd0YzT2pBbHcvdmVGODdOZDd1Z2dkOXRocktD?=
 =?utf-8?B?c09VVmFtQ08yVEt4MTk3Umc4dTVtUWdNUmpmenFUV3NSNXpmSERRUy9McDh0?=
 =?utf-8?B?aFBJcEM4VTJlWXVFeHFQM0ZKbFNxQVBNaHRqMG05VDRJYkdFaG9HQ05xeDgw?=
 =?utf-8?Q?yZvrA3B6AI+UxkrqjhnLkc1Cq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cecf93-f268-498d-d81c-08dc5effd399
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:00:04.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6bPtyYmUriLZYQEAhXkM0R1yhtns8oQFQ6ijB+BUVX+zG8rWogThjGfpt0Hx7SloW9ZTDxFTccJYWFhOgf1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8080

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

 drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 +--
 drivers/pci/controller/dwc/pcie-designware-host.c | 152 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
 drivers/pci/controller/dwc/pcie-designware.h      |  22 +++-
 drivers/pci/pci.h                                 |  21 +++
 5 files changed, 206 insertions(+), 64 deletions(-)
---
base-commit: ef6a734484e939cf67bc41c45bc936a78ea210f0
change-id: 20240130-pme_msg-dd2d81ee9886

Best regards,
---
Frank Li <Frank.Li@nxp.com>



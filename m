Return-Path: <linux-pci+bounces-3024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1478472B8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1E1C20751
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED32145B30;
	Fri,  2 Feb 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oWwXrMMj"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0A145B05;
	Fri,  2 Feb 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886707; cv=fail; b=uP3JUU6IaPLxAghXuxUVPG49yoNYrVb5iKDVjVqfECvW+AJYICuwYd1AAI5Ye0JOIA90qbuyvwyS63LTsUqlRDP/o1nfMpoSY/Icz1jUnUpSS/zTIf05vpWaT0pCpz1imyx52mwx5TDN7RXkWLUSyYlU0my5amm4yYN9wS6a7xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886707; c=relaxed/simple;
	bh=PhkaShGQv0tjX1Hrp4irVjeSaK7DIs/gW/2xe61cDNg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=M4/EhdIGyOMYLVJRqcBwj5GYUq5vEdETEyU+PJLMzkMPtEdqG+dp3TuqLCAgyNSuumb1bYgbq+SJVRhdvwgQgOPjrrLQFfTq3CLzVBpyq0ryxGB0oHFHkoOhv7oAGlknBlTikXOZpU79UeS6BNYVZsll3eN7lMHFoaSi23+7FSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oWwXrMMj; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db1uDqnPAx0MphV30rLS/g/FPHj/sP53zQ2ECQrtjD/OV4Xmx54D7Ve6c1iB2fzlBm+BbRgolyGcNYmsRs5MiTgdJSCTYHF1lwTcnoz6IGwiyUk5PvEwAtLvos2bljcU2Lbspp5Y6o89CvXp+x5OApc+wvjWtvA+UJ+3Pfg3Al7lzod/qHgqaIythlonbVTFf34ASsmdxodVoMgVb6Q+TnyK/IJHYQw3VPE2uDj2+xXN2xe6Tpsx7LvU53CdGpI5SvtV9CtKxLbpd2NcDtuDL6Ku2VMomRCZr4I/aSHYs3uVOxpZsqRmmzEkQkBo7zoarofXKHEfiR+wtk7ysHVVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcMJqhqrvgs/or1vlLoiBdD1wpfiify/EKnhvVMAQyk=;
 b=RuQyobkT1dRqTR/MUifanhdNVcTK9dA1eD4svDaBlIAcPPhHe6YXcPNXPnulxeN9NvNGA2MYvqoiqSsYFLBX70KZE8XWP78hEDT0wzasw85/c6WpUKYOHF7xrlosWrkuyJz/XApA9pGKTYerF00QctiDTEExRUiHiS7Sg8RzCew/+AWPKOUSGE6JK5bN8KeTCnr1USN2isdYYDRubFoEa1TOvQxAY2yzRfaGth6oZvGxJ4CbFcDuQDWJE987BNnKJknSDgIV2VlxpGFzU+4Qm8lp9jH9jjUc63fE07fmFQ2FLEGofaDEFRSqditcxHkxG9oFVxwoMMCMWWV7P9zSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcMJqhqrvgs/or1vlLoiBdD1wpfiify/EKnhvVMAQyk=;
 b=oWwXrMMjoPB0lRBGtsAutqyLWoDrJ/GJT9JQ3QD3mrIu60ifhxmOzX/OZGP5KaUFZW/M9DMYl/NofWw7JB0pPt1D6d6gWgkAT5+0pBX+7WSfUNoqZ2420LKmSW3DTP8oUKD51uzpaJXj7dvWA+xJzASWHHQG95oL2p6lE/+8FNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:11:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:11:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/6] PCI: dwc: Add common pme_turn_off message by using
 outbound iATU
Date: Fri, 02 Feb 2024 10:11:22 -0500
Message-Id: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoGvWUC/2WMyw6CMBBFf8XM2prpAAVd+R/GGOwM0AWPtKbBE
 P7dwoaFy3Nzz1kgiHcS4HZawEt0wY1Dgux8AtvVQyvKcWIgpBx1hmrq5dWHVjETV1rkWlUG0nv
 y0rh5Lz2eiTsXPqP/7uGot/W/EbVCxQW9sWYubGnvwzxd7NjDVoh0WIT6sChZpjQlFtSIqfPDW
 tf1B4sSiOTSAAAA
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
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886696; l=3148;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PhkaShGQv0tjX1Hrp4irVjeSaK7DIs/gW/2xe61cDNg=;
 b=jvA30hK/8MizNuX5NMoRbQKMpts80gbE5t/LrXKIN+TwsTcykxXgGTc7xEXr0h3EFJrnpumky
 VNZ1HsvBd2RC7gtT10+LrrYkGASNfWPPWcsHDnE2zthEeoUrZsK0kzu
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
X-MS-Office365-Filtering-Correlation-Id: b551f54e-bc9c-4bb4-db65-08dc24014239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FWO2cCnEa79hQG3/F0CC9a93TmRPt2bDoqHx5+fAVW14jmMIbt9fwBYNc4m0Djzx6mLFAoGhUI9bIMPhStw47pEibzouBE/sp86fJo960j0stw9f098i1Ad9xpnTpS0nbKOvimqUrW3/upfVU9yiqdmRMR5IKoKndYh5iODCy1gjt2a6EhOTexLivlOU+HxKqpSObMQuNUx/DJ5W2Fq7xvDk9Lo7U+Zz4/iAsFH0jU1urL9Xpc42Q9URkX/zWlb1/kcn+Ze7yXYW+Ktwo2qojbdf9c5hPe4XphBh/bDw+WEm9Y5iehbg5M3hEOyCLa9vXosQbBPMzJtA6G3UO34OS+Ua6reLueWFBs5QYHuxF4PgRdawrZnZGxS9IxLxhJsFPc4u9Ues1Ur2oJNjec0ZUtIyzD45KvPbXQb6cvPsiVVGJRmKahWlb3VuiQ3liYVj+u2+Z1flYbyUkanFKR7FTY03Nv5rXVrxqjcppfcrps6C0kdLskm2QkGUEVyEN8BPBglYcGHE7Zjwi3qLuCDCCGoC9Zmih8/CNS9+NYVrhkNjQ0Hh5gwMOzx/+va/OBz41qCV4yzLAbK17CL6fgejLv1k4wlIKhF1fdPY6zV/ckWj7N6UoKLg0ihfo3KABY/X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(478600001)(7416002)(5660300002)(15650500001)(83380400001)(921011)(38350700005)(4326008)(36756003)(66946007)(8936002)(8676002)(54906003)(316002)(66476007)(966005)(86362001)(6506007)(6486002)(52116002)(6512007)(6666004)(41300700001)(26005)(2616005)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG81U2Naa2F6UC9Xd1hvZ01GMHpWUDEvcG5SZnl0MDlDVG85Tld1OTNUUHBx?=
 =?utf-8?B?WFpHVjMrYkdqRlhGb3pQRzUzTzcvRjFhbzhKZVZ5dy9NaDVkaE0xbkFaN3lR?=
 =?utf-8?B?TlVNNzdQRkRNWCtqaGZHaXlhNXVTcGU2dXAyS2tacWtWRTRDcHBJY3Q3Z0sw?=
 =?utf-8?B?Rk9JaGtTdUtXd1dtL0IwR1FPYTVyanNCQm5YNkZVbGlWOTNUWU1NV3VmcmF2?=
 =?utf-8?B?cndOUmx6MGZUMjZOR1c1RWx3aFA2SnVnOE1kZ0hHN2xBeVplclcyelNEakNG?=
 =?utf-8?B?TXFLYVhFNFpSZmNyRTM4MisxRm5tblZpbkF2MmI1MzF6cys0UDlMOWNtN1NF?=
 =?utf-8?B?c24ydDBBV25WR3dmdlE5ZHpvdWRCT1dqZXlKM0V6ZFNwRHVDMWxnT1ZtVTNZ?=
 =?utf-8?B?ZkJWRy9pb0loNDY0cnh4b0hqaWVNOWhiSmwwWC9lZ3JPTC8wOWdBajRMNEVs?=
 =?utf-8?B?VHYvMFFnL0lCUzZpUGgrQkM1QlJQRmZKaEhYWUVBYW1vZnNZNjJhbFhybDJk?=
 =?utf-8?B?bzk5cFVpRVdFYTc5UHNrZHRNaWtJMjlQUmY0Rkt4UHRKV1IyQXRmUmZ0RlNM?=
 =?utf-8?B?bnVSZDhFalNkZmFkcldwYTZpR3IxRmFoYmptNUI3Skd6cHA2NjVmZFFHWmZF?=
 =?utf-8?B?WnEzUUVEYUpCcWxRZ1d5NXVjcWsrTXo5eFR5dUdlOFVvNG9kMUpuYzJTdDlx?=
 =?utf-8?B?S085VVFjT0lZVVdtSjVXcFNnWFRKRlpwZDdqSGFJdDkrWCtvYnl2TUpmVUI0?=
 =?utf-8?B?djlab2YxU2ZlWTh6MkkrL2dkZ3paSnIybmN2UXVVZXgxemw2Z1FMRjFnNVRo?=
 =?utf-8?B?U2tENmxsNGIrK000bWd0b21mSzdPNDlXa3Vha0JxSDhEbDYxNldBeWtsSGRD?=
 =?utf-8?B?ajBnZDNyMEZDenRCZ3drb0R6WlU2SEd0L3NaWU9GVU9mWmgvb2xpK1dyYWha?=
 =?utf-8?B?Z3Y3SDRGaU5UN3BwVXZmbUVkTGdNeDU4NkVZbmhIWk5vVjRkb2JuNFY1TUdM?=
 =?utf-8?B?S2lKUnFKUG4yRnY3R3pZNHkvZUJPd1h2aG04Wjc3aitOM0VjUXhUWGJOZ2RS?=
 =?utf-8?B?UVZlQ0lDUU5NSCthSEE2MU90aU01MkUzYWsvUnVhY2ROcHJRVlVqZ3NuRW15?=
 =?utf-8?B?Yis2c25BVm5zTUZpYjZQMDFWZlkvN0RxUTh3cHFpR3ArSzF3cTM1dTNLUlRP?=
 =?utf-8?B?TG9UdHEwVWN5ZWdsblRVTUpZWWhJWXFmT2lMWnk5a0VwT0VQeGt2K2tvNk1l?=
 =?utf-8?B?bmZ1a2YyOWJpTzF6TVhYN29ESHorYVRhd0Z6NHpDNmNRYXNvVG0ycHdqL2Jw?=
 =?utf-8?B?aENyOTFmSzNaTHJ1Q01seldaL3JsTlZFNXU0SGhQdnJHQ2ZML2hNdXFXVUJ0?=
 =?utf-8?B?WmJVZitrMVMzN3I0MTQ1cGQwbFVDYUFQbnpGL0VpcjdCYkZPZ3d3MnI1OHRn?=
 =?utf-8?B?RjBxWXdmU1pmWW9wTDA1RHV5OG5uaUVVaFJ0ZG9sZTZwM2RYTEZ6K0dCSUY2?=
 =?utf-8?B?T1U1UHJuOWFhUW02WmZHcmdjaitrT1pUaEJLbUtZSHBHNjdhNHo3aHpOYXVT?=
 =?utf-8?B?cGxkVWEvZmVVQ0FaKzJTb2pnbzhSMFZyTXFKR0JUbDZQQzA0MWF1SFJPVFNy?=
 =?utf-8?B?MG1zeTQyWWNQYVVldWp6WjQ1Um9HOGNmS1I0c3FqQ2dtUENDelBRbzBER0lC?=
 =?utf-8?B?bUVwYTZSVmpSczVETmNhQkprNTc2d3Z6Z25JLzBPMjg4U05uK2dVcWRLSWI4?=
 =?utf-8?B?bEJiQjJybEY2dzJldEJkckFJR0l6YjgxdGZYL3A0MUlrMjB0cHRVZ1piSGpn?=
 =?utf-8?B?RkYwbmF0cFZkTGJoT3RsMGZKcm9acWRneTg2S1NQZk1BVlluSzF3M01ZRUlx?=
 =?utf-8?B?UVBaSHJqMERkNUQ3MFRFaDdTUjRwUGdXZXU2ZFc1N0pPVWRiMWY1VDhNYVgz?=
 =?utf-8?B?QVFqSFN6aHNaclFsdlVkYWZRSDdKWUtZMXZXUEVOcFU2L3lOSkhwS0ZYUU5X?=
 =?utf-8?B?Snd2Wi9OK2IzRGJuQWsrY1BIbmpHVS9DMEN3NFJRZktwQWJhd1lsNldiTnh0?=
 =?utf-8?B?MWI0Y3hCbFVjRzdLSGFEdU9VL0N3Q1dscU0yU290ckw4N2dPNWlWaGlqNXZG?=
 =?utf-8?Q?5PkDgEg4IZPvCxkmVIohO+gn2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b551f54e-bc9c-4bb4-db65-08dc24014239
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:11:40.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC8SPo/bFlUFui73CpGFiqkpVBYdB5HCge/ONf2/f3S6KEWgRCDtMbiM0kTVIomNlYWHYkRzd1ImSZ0n8UYREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

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
Frank Li (3):
      PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
      dt-bindings: PCI: dwc: Add 'msg' register region
      PCI: dwc: Add common send PME_Turn_Off message method

Yoshihiro Shimoda (3):
      PCI: Add INTx Mechanism Messages macros
      PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
      PCI: dwc: Add outbound MSG TLPs support

 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   4 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  21 +++--
 drivers/pci/controller/dwc/pcie-designware-host.c  | 104 +++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c       |  62 ++++++------
 drivers/pci/controller/dwc/pcie-designware.h       |  22 ++++-
 drivers/pci/pci.h                                  |  20 ++++
 6 files changed, 169 insertions(+), 64 deletions(-)
---
base-commit: e08fc59eee9991afa467d406d684d46d543299a9
change-id: 20240130-pme_msg-dd2d81ee9886

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>



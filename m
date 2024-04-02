Return-Path: <linux-pci+bounces-5562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51AF895973
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94C61C21F62
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9514AD2C;
	Tue,  2 Apr 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jUeLaosL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2107.outbound.protection.outlook.com [40.107.6.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33047A724;
	Tue,  2 Apr 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074569; cv=fail; b=c/lSdj+SmhEeHX47xwBM+NK1I3UERJkeUe31Ha/TrtXGFcVv1Fqcs1TAiN4wcqhAPUwQvJ36OBeHivRrsSnkyL6z9JaDOD75ufvj+oloEdLgY9JQMZVNrNNmA2g0reAnmWlhKhdrtxnZ0q8bx/oiQ8TAlCa5pV1PsrS+aC3rg24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074569; c=relaxed/simple;
	bh=3pGR/ddW9dEh8gc9hakUC/itow/9ISfzO+zUdzmjzeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fVzNMEl2pHhOm2+jT6kdI+cncXmwPwhuf3vGgRJmUHI9/jWAqD4vkC43QSS49KUXMUgCZeZ2fqy7a0jqgEz252P0dPAJZaP349iPgUyxfh5AzrgaxOtwsoAGtVXjrqB08dvpS7KTtxxMWCo5LMu4Yz04FSKmx1upxjw/9RDXXfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jUeLaosL; arc=fail smtp.client-ip=40.107.6.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEBMc1CRn6pOnESFPYeJap54mC75yQXfM770+D26lX+qb6q7/Lnx1EtCHRRivRmRdDL9/e9wGB+cqrwc9yu3vm+AnBvhcQ4xO8AqQEuemx1/XMByGmPQUF2NPEJS8t3kznjzfD2RBEgC4R2zALNTxQdTI6b9fpjnPgh2vAAknLPJthLsxPRGKShwkvNDChpwwq4BkHp6o2XMmdvSpNlZ0ENWPuJMQaVu6+jxfSRnK3HKXILMlek8xSuxolq6y1DB9R1sQmgziiR8SEeG6TAeHlIrAXUrg+E6WeUmkYIgx/oK8eduaY5WXqEMLByQNa05jtuGPxYzzy1JVIZ18pMcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62qibg0CLg8Od4rQwvqlnEBbDzREBhUJH2r8VaQGCNI=;
 b=hU+HvwTqd7SkYpQliQIdImn4bG1MIBDXEfkOxeMVC43jZz/Bf3h6/z2r+O2tuHc7Qma+CFTdwTGHzrHkrm/2cPvESAqcL3AAKxZH8oEJ5V4Av3IAYVdNPD+7MwtPUy8qTG9nnsqwA/6khyjBEaexxmc6sNSndUT+TTY6SW8/w+GWQWMX/tB4d0Zj+/eP9oQYuw2Xn8qpVGa1/cvIVQmkuxoNuMHMqDskgZdCTUn+fPrw7/f9MFQfkCIn6VjXuqY6cvh0JNSSm8txWmtm3KHouhZU0pzXhLLekuX8AnL3n47xYZPiz9aogQfbeMOZqx90TZdftE2MeOEy+7E4OWyCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62qibg0CLg8Od4rQwvqlnEBbDzREBhUJH2r8VaQGCNI=;
 b=jUeLaosLhTLHTSMlvs6Md8KNlQ8Ob16N6B3tx2uY8SnQZz7X9d/t19T3JFKnfDhUypE7qNRYmNyra/yfjz826MIurYI9agcq0ahQ226J4/R5UIcf7FwXPtUatEpp69bDH7tFhzUZVBETqcgd9UOiJXLuVs8zbL4M2qVuQCXBtaI=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7731.eurprd04.prod.outlook.com (2603:10a6:20b:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Tue, 2 Apr
 2024 16:16:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:16:04 +0000
Date: Tue, 2 Apr 2024 12:15:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v5 0/5] PCI: dwc: Add common pme_turn_off message by
 using outbound iATU
Message-ID: <ZgwvPB/LbPRshVCy@lizhi-Precision-Tower-5810>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7731:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	974Ocef1OVSJPzdjqqvRRDP2MenXpb6XSP6gpKaHUhX9VWGsvfJ/3EoORJuXBNx2EP2XZc6awbKHQEHNdu2tNxwy21e5V/7HKtx8dTuLdYhSepYBnfSYgea88iyje8VR1UShJ+c2tGkYjcgp71ErAZITlPgPtWuI41KBf8lLcKCKMXLuajeZF9MYc9sCo6QL1VQiWxpLvreq77fDm3zgoRfhLBwKfIfoFNJerwbIleXtFpzc8auk6sKb7OfOACwM4OIWL+Zd1pnJs5bRSTl42Oedd4CcUazhBy9MGSjtylx3KH4oLGOlm0huAfctRsm4uaV6ewpltOhvZAtdXUVSD+8mE3DPeZZzYp7vLy84C7tp5ieXOfr8NknQZdItNHtdgLyQMlwwrI3Sjj12/3D9g0Hsdw70zfbcROBQ4kdeenzZMilIoDa+maU3Ea00zlPGXMx91zOX4JUALsHl8Pe3Oi7GS/10+cVfH4lFlAFGhGMYzEZHwQHTo6MqD90l9Cp8HzIzhTvGqg1xh1s7yGS3ihmrpz/IQEfoln0dzHQYbXdqDpMnD2SwAqkZnaN93oWWq4+k03YsS+pvK/XygqC2xUkJc9rwo9kThpxrfWlUbT1KN5BVf7/Hk3o6S9DI+dB4HHdFQS2iPLUerIDXJ0IbP7sr0Ph11JhPyBSG2Plg9ZSXXsz2cofoEUFZefPfYL6a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tLpR1Y50JzXDqDOlbiZgdQHBuq19xZlQlXstkoCPhdjZH72B2kAok3cY1qCG?=
 =?us-ascii?Q?qHOMggCmd93sp/zHRw/VYFd48OiX/QCm2e4arU3BK2KICmMILfCi2UsNc5te?=
 =?us-ascii?Q?Wf/Ig1XX581cPdAb/N23aTgoQ/sP+TPmKvdXZHhLYtXtGkw/6M+2HF60VTRc?=
 =?us-ascii?Q?4C3hdkcV9sgLWTHi+iODiGkMU2aAVhfu2QXallCF6vOYFLOh5BxFD0EIc1Uw?=
 =?us-ascii?Q?fSNPRuqV1HefqEHOIek7OP6wCIbRm/8Mo0wUwco7ymX9DhhLZFJ82t5yclYi?=
 =?us-ascii?Q?J0p4887UwMBuMNofx+M+HuneDf2lgnFEvwbkaFC/iS3I8rNzYXyPRDr56S29?=
 =?us-ascii?Q?xO0BtdVXHQ4ZJJDn7YFEUCuayQX9OwXZII3C47Pu+FD+ouTy8XfQAfmlPQX+?=
 =?us-ascii?Q?I8Dfx4IH3p7Bj/B4HRmeUm9kco2aZk+fbzwSOxMdqpXspxLdP0yoAu9v4DhF?=
 =?us-ascii?Q?emodIzekECVi0H8LVuEKAxUToLzdhsrTkdQArjGDmoKTWmx/9pUYcXsUeJ5f?=
 =?us-ascii?Q?s/x4doA+3KmcKOtt+o2G+VWYZ6lm1wT55U02D2/JaBhYvyL3kNwsNGWw/GsG?=
 =?us-ascii?Q?Ivmm68foRjvtbZVcjZzlsGMVq1jxa1BdMzHrvO5J1f5BtxR0PcHA2qkMYYcg?=
 =?us-ascii?Q?Dywv4yCaIG1o2bdKgWYxq7qJvmtqVSFfhc+qbqXrldHbH5rZ5Xmkqvd2A78h?=
 =?us-ascii?Q?dP1ilvoSNKDOxkH34n6CAdANdkGCaM7da0jz/DG3hm8tEgQZBAi25CJDdUL2?=
 =?us-ascii?Q?HEYLHtcijhQfQfXHS0jX3iLZZDKmbOKVEzmYHiQoZ44HiEDGXNbK69YkwLbe?=
 =?us-ascii?Q?ZIXONHE/oKDaMYv5AeoWTca1aACDtNFJILyHIOsU0Q+e1ExPx5jKoUPaPdOp?=
 =?us-ascii?Q?kqPBXNhU1XSyApItj4Ud4qCXBHbqQKKFnmYY60x1f4M2y0zJU2MoGgual7Xp?=
 =?us-ascii?Q?ebJcGXwuClO4a6KBAIe1AWXabzf3jwe/rNQdUcSNW2U+u0qzsva286nUCpkD?=
 =?us-ascii?Q?LzyoAK+PcUnCPBSn+jbrhCa3d6TYTOvh7iOWBowUBd642k9J5Ax53PJaWjev?=
 =?us-ascii?Q?U6Q+01r6FQIMS8mKBOGWlyvQpuRgErEthZVMEZbhD2Mp+OyKzkcgk6LttEO2?=
 =?us-ascii?Q?RzshkYcrpvW9sS9EvhIa71ogL6G4GruHbphQoZVHRuN6EzHdiXzhd1mLQuWa?=
 =?us-ascii?Q?Ao+T0JGB0pw88I/P3O7b5gZeb0DJGjBJ4e412BpbwwShM8gebippw5z2NwYe?=
 =?us-ascii?Q?rxrLSnwv7drKGtopck0L/dZsTf3N4MOVTxUJAhBQ7HfJ3S/0laAnmpgRlbvE?=
 =?us-ascii?Q?cYsJBPWqK5cZj3ZP9xAJ6vkyuO08sGolsKeSs2sapxEpu4GNAfc8HnLji3up?=
 =?us-ascii?Q?J6CCo1LqSVwBGfVzn+mKJMwTZmanz1WQDtlDFDOCETpBGM1xYewFUvJV3Hf5?=
 =?us-ascii?Q?o1GbAvVgCq9UFBJ4XsrDeOWI5I2XLYE+juhsGpx0pa0ZH+0i58KvbYRKBvfp?=
 =?us-ascii?Q?c7ahhJpR7JA4f0yi5TCYTvr3PDdN4Lsf1xcIZfTZTExoyxZyTXZvco81E3tu?=
 =?us-ascii?Q?Dowq7ajaRU23iUeIE6/W890zvgH8W5ggExNcnRa6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8d4fee-e2d3-45a5-4b9c-08dc53303203
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:16:04.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu9Q0E4Hlp1S/z/aD2I8MIBPscFfbQqTL4Ierhiy0j86pr8Bqvx93q5ChsDTlwBXgNNrObkrpBcvzq4gasKLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7731

On Tue, Mar 19, 2024 at 12:07:10PM -0400, Frank Li wrote:
> Involve an new and common mathod to send pme_turn_off() message. Previously
> pme_turn_off() implement by platform related special register to trigge    
> it.                                                                        
>                                                                            
> But Yoshihiro give good idea by using iATU to send out message. Previously 
> Yoshihiro provide patches to raise INTx message by dummy write to outbound 
> iATU.                                                                      
>                                                                            
> Use similar mathod to send out pme_turn_off message.                       
>                                                                            
> Previous two patches is picked from Yoshihiro' big patch serialise.        
>  PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
>  PCI: Add INTx Mechanism Messages macros                                   
>                                                                            
> PCI: Add PME_TURN_OFF message macro                                        
> dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
> to map PCI msg.                                                            
>                                                                            
> PCI: dwc: Add common pme_turn_off message method                           
> Using common pme_turn_off() message if platform have not define their.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v5:
> - Default disable allocate TLP message memory windows. If driver need use
> this feature, need set use_atu_msg = true before call dw_host_init().


Mani, lorenzo and bjorn

Any comments about these patches? I already set this feature default as
false. It is common for all dwc platform. 

After this merge, imx6 and layerscape many customer PME code can be
removed.

Frank

> 
> - Link to v4: https://lore.kernel.org/r/20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com
> 
> Changes in v4:
> - Remove dt-binding patch. Needn't change any dts file and binding doc.
>   Reserve a region at end of first IORESOURCE_MEM window by call
>   request_resource(). So PCIe stack will not use this reserve region to any
> PCIe devices.
>   I tested it by reserve at begin of IORESOURCE_MEM window. PCIe stack
> will skip it as expection.
> 
>   Fixed a issue, forget set iATU index when sent PME_turn_off.
> 
> - Link to v3: https://lore.kernel.org/r/20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com
> 
> Changes in v3:
> - fix 'MSG"
> - Add pcie spec ref in head file
> - using function name dw_pci_pme_turn_off()
> - Using PCIE_ prefix macro
> - Link to v2: https://lore.kernel.org/r/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com
> 
> Changes in v2:
>   - Add my sign off at PCI: dwc: Add outbound MSG TLPs support
>   - Add Bjorn review tag at  Add INTx Mechanism Messages macros
>   - using PME_Turn_Off match PCIe spec
>   - ref to pcie spec v6.1
>   - using section number.
> 
> - Link to v1: https://lore.kernel.org/r/20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com
> 
> ---
> Frank Li (2):
>       PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
>       PCI: dwc: Add common send PME_Turn_Off message method
> 
> Yoshihiro Shimoda (3):
>       PCI: Add INTx Mechanism Messages macros
>       PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
>       PCI: dwc: Add outbound MSG TLPs support
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 ++--
>  drivers/pci/controller/dwc/pcie-designware-host.c | 146 +++++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h      |  22 +++-
>  drivers/pci/pci.h                                 |  20 +++
>  5 files changed, 199 insertions(+), 64 deletions(-)
> ---
> base-commit: e08fc59eee9991afa467d406d684d46d543299a9
> change-id: 20240130-pme_msg-dd2d81ee9886
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 


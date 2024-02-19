Return-Path: <linux-pci+bounces-3732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D9485A72F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 16:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701391F222DA
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AFB38384;
	Mon, 19 Feb 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AL2KhPLH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012611E89E;
	Mon, 19 Feb 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355795; cv=fail; b=BspyGbMU3Iq+0zEZUFiDWThVel/xX31V8LwcvS7lfMWPNaSrBBL0PZAOLpCJNsGm8sBCV+ZqPN2dZOCEuw8lZxNf/cChpDLDrbH7KcuPhxDKZ9f1SHnxFr0yFhN4or1WIi13oWuvVbeEOd5UKIQkHkmtOSkmNow3fyaSZqAGAXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355795; c=relaxed/simple;
	bh=FoNq+w/bSBF5so49v17G8PMWO9nHEppU5N80DOehsnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OjDMSX3WZZPtOy6hrT7cHbuY7eSFCF5pU9KhW2TRGIhA8jOQOkciueRXGK3KsrS8zVErvKsCRaOeKXb0XX+RAjFIy0Xyv4HZeaRl29W6E3dF9eg/SO56LDKov4GpzuwUqg48vvqTBtdToyjHOd8yzTmeo+91uiqfYTM7CHA2PfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AL2KhPLH; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN8xjWz6LXhZneKDID2qTkynwdpOuAZnO3IKTxuGGmUAGBxoNB1NefW5bFa2+m3b5WKYlenLIoTVCm6vEPSOc2lin9pCSSGPD8FxpBJyp2V/n/AJwgxWIw/ifeY8xjlHoM90DTnrLLs+YeYsw/lt+psSXIq0l/0Mn7USM9XsROxEHDZ9vIB7O4VIYhGNdVi9S6b7Ogfgg8IV9pxR54HUXk/V06v8YISxE8TLh+be3vmK00sPPG4tnjyrQ24aCekuapGTREipMytLXurHBt6SHsmXCqMKIsbnw7PvT3u2w3kX7EZCEFEjB/xAW4pjbBoaW0lDeQRz6NFCGTQk9czNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prg3wI315pErdbKe6vdem/KHQMAZYeATJ6KHnusqEio=;
 b=PuEOpeOJMSWjUvQK9u5VGTH89eXI30AvQfZQ+2SuGhou2M6PwmsNOBaToSdWed70aV9YEFUtIq79zqD6XFNBA0Ty0omNmPGlZezT3oyAsTUxHl8ZlVkNSWIE10KDi5yvvAFj1VMFnPY4SzdVB5Gl/K0OhaAaGxHDWUsclgTsKbP6KpRsmyM9/TTioFvaC930Tj3Qk2IQLJTGPYbHrTnTfcZzWmSDPUQkphullbk8L/ckaryEmTbJdwgFuh5c/VDYmAiCruXs7DHi7MSoKojz913m1zWGazscOfqMVjqV0hlF3WVmh/aZv8y6MrClL3ayhDzsjYMgVTTMCVkSfkdalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prg3wI315pErdbKe6vdem/KHQMAZYeATJ6KHnusqEio=;
 b=AL2KhPLHhYLr+h3SzZ5qqja91CXuqYtC1w7O0XGchODQ5MqhdxCH2JpRwtAhhKxOW1kdrdlbvYl3RmuG+lFfgi749iiiYOqjcmgpMlKpG1UZjQttbI06JRT5NxBPFLkAimvqKetUiYd3MeqYt6/4mPQSa0VeAoylmDt345rDxPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 15:16:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:16:31 +0000
Date: Mon, 19 Feb 2024 10:16:20 -0500
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
Subject: Re: [PATCH v4 0/5] PCI: dwc: Add common pme_turn_off message by
 using outbound iATU
Message-ID: <ZdNwxAi2KH/P07bi@lizhi-Precision-Tower-5810>
References: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
X-ClientProxiedBy: BY5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 222d998c-759d-4c2b-6124-08dc315dc049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F93cRtPXhdOZEEfkTQWCtp7FtYCgRegUlSH98qgi2NqpL0c7b9aX36VpHm5WULU0dm+A4LBRAfbfF7c1CcblCsjGTy37y5v6j6izLU84xUcVcux8V6wfrf65YIp5ZhC+rFvYAI6f/0WOfmpEfhIF5x9Tu05mIEUzDfY4OyJvnqqjYL453ydm3Pch9mtc2MjimiNhbWVzUUj/76QyGM4CKpr/+n26vP6tXn6XMGyohZVECpHqK3f5zBrNJUW4bSqTfGh1RiIZU0Ng6kaIe8wG9O9lSznjPMchSJSi+kz4oEsr/g0vbkXzxWtqletdXfMGC0/6sVsmIfR3CQuNLj7FQnArFu8f529XdjWYUigFBCxLgU0uurLtTMb/ogeSxuDy80FmQNvtFW8tSnFmi6wZvcudZ74rl3HF18mZCP3KkaSWAkMQnVWY2wE1UsyslTGf5p3iQ9FTuI14w4kLsgfnpI1bswnT3rFBYj1UKyFDFHVzg3e9FPjo2B79MUFfKvChgp/mlBQbyG1QWNgKY/a2KzNGy/6y5TH/C3o31gLSa6iNDG3oe2dAP9940VcOPHLCRSRd5ZUy09ewZ8p3OK3sKDEPKy3x3C7P0TKxAp43orDGYLwSSZnK1soGAIONN5Dp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eVyojjQZ6EUtfkOfmXQogNGMb2Zkzi8czfqsNZ0P1d4L7NLzQF2lPTVxqjBk?=
 =?us-ascii?Q?4BxFwjL6edeV1cgDm9XJd8WIfChiXsnU7wfpZBF4QOuFd8f1vt99uxh+5c7P?=
 =?us-ascii?Q?z8ouzJ38/5lnpD8vZ0xhWXCjTIeUf4AGULy1QZRJFYXDrL2M8denJIyKOjPU?=
 =?us-ascii?Q?MBN4G1+d/ORx8KrCJbq+Dpc+uqARjOZcDldTdVRwjVHjyCJb8dIHjiCLRHp0?=
 =?us-ascii?Q?VpRpWKDkHaJN6czf5zEb2ouAdpAc6kvrpPmzcCFo25q1xtO2TUoKqXOycIAE?=
 =?us-ascii?Q?DoMxkq0zs9RK7Z2NBioxwajQEDz3MkT5tmiO46bMCSY9Q/u9vfjwDtqA8ekx?=
 =?us-ascii?Q?+JzBmLtqB5ETS7bGcCrF7qqk5WHY5yApPYW5mxIVXlS9TXc7KasFQBWRa6fU?=
 =?us-ascii?Q?k0wnPzWedGvMcLvkINp5427vgHDoXZ7vL0pw3QkI8nYcHe1xDPI260xph8AM?=
 =?us-ascii?Q?+5WU4W4XENkvMyXYJ+1rdO7Xkrm+NFGpHXICBb6fV+LlY3AGxr1NJr9/EofT?=
 =?us-ascii?Q?j05N/InL3d87Zon5ABbFZ3vgJoLkApOa00ljS4Cl7zIYUW1W+rMdxxge10l7?=
 =?us-ascii?Q?7oMAVRsu4r69IF4fp7zHHZ1noVkagH5CfWawmRcCzqW8D7+WWw8nn7C6Upiw?=
 =?us-ascii?Q?JjtUzqJC2mrskCbMu6pV4MdjvMNXRkz6JxNBsUacZ4UBJ5NmYkgnyxuf4Zyc?=
 =?us-ascii?Q?kTHWmjKEaOQ7LGZSmBj5Ka+YqLzey3af/2d4YWt7FDAfMB7TKsa1R1Oc7Fju?=
 =?us-ascii?Q?SBod5A58bxDaF3DXHZ+eD02ohtKdtoVVTvQNDQHK61Xv5PRTpgy1H+cAlEVR?=
 =?us-ascii?Q?1CYHeLBfufnG/VB9TzF5GmOJ/IVLUDhVJNQVnx6tcJLB2bzbjCbiQIE/9+nt?=
 =?us-ascii?Q?swMjOauVcxm09FrsAZL8lQ9ILcBtglqm9mw4F1RE0prWPuVijTxAWLDJCeIb?=
 =?us-ascii?Q?lzPlJrac4AOeUQILDlOdNDo7ulYizx8glBhdnQ4pM8ilUrM3MUfOZRZYf4+l?=
 =?us-ascii?Q?GxKYV5T5JdH50/Krwmu8C9zpFpfwU0nhEdHrnHnqDwOU0Ao2V+6wn/gdtxza?=
 =?us-ascii?Q?/Kk9toVysWJayuHj6mQxdxdq1UeTFP+Wmv1M/fiZZ+Z6YewloPeOUhP5hqNq?=
 =?us-ascii?Q?VF90B4j5RR1eSMpY1FmvclFcNhGWv4lF15dZULrocfsy70MM09kjWwt02NYQ?=
 =?us-ascii?Q?WNplV89jzHK8XYu2Plpo2MWU31x9z2nZqqJWwd2MyxGuvuOqYonJNQsk5cZH?=
 =?us-ascii?Q?tsMPMK3R8dt3Bpb9a1aSwtsSdwsj6UPQH9SzZpkx9Es1aAysUYYTgSG07BCY?=
 =?us-ascii?Q?0PieKEvi+bXPtAML4lQ1jwrdjdzdSvVu5dixp1U3U/ry9I9E7q7fa6S8x/Zt?=
 =?us-ascii?Q?BYXrTb9BgrEEFUfDEBPuNapE5q9/kMf5O9yQl6osuXGSxtfR8hUyZp+YZa1W?=
 =?us-ascii?Q?u+CLkTVlK39cS3rRI/AhLZLrHgGUtmMLPtja+F8BVUDx2hEDwVbzGRBpT+KY?=
 =?us-ascii?Q?186r6fxPzaLfU6Zd+Eve8pc5xLQlZdeUpnI+p64u+Wrau2Ue04noT6FyYZfU?=
 =?us-ascii?Q?ysSYrPz3HBy1uXsa8vw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222d998c-759d-4c2b-6124-08dc315dc049
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:16:31.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGYP7PcibtQR/zIsuObz2znlk/dWfbIGDyJBvBi9H+KJdGHVp7UCzY0SPlSv+6o82XvxxvvA+jNIHZ/9KH2vFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142

On Tue, Feb 13, 2024 at 04:50:21PM -0500, Frank Li wrote:
> Involve an new and common mathod to send pme_turn_off() message. Previously
> pme_turn_off() implement by platform related special register to trigge    
> it.                                                                        

@mani:

	Do you have chance look this patches. Actually other patches
already reviewed. Only missed

	PCI: dwc: Add common send PME_Turn_Off message method
	PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro

	This patch will reduce customer's PME_Turn_off method. Many code
can be cleaned after this.

Frank Li

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
>  drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h      |  21 +++-
>  drivers/pci/pci.h                                 |  20 +++
>  5 files changed, 197 insertions(+), 64 deletions(-)
> ---
> base-commit: e08fc59eee9991afa467d406d684d46d543299a9
> change-id: 20240130-pme_msg-dd2d81ee9886
> 
> Best regards,
> -- 
> Frank Li <Frank.Li@nxp.com>
> 


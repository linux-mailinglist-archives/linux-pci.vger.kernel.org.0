Return-Path: <linux-pci+bounces-40132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C033BC2D7BE
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 18:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1E234E27B0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C588E27F4C7;
	Mon,  3 Nov 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WNG0xlXP"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A23191D2
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191237; cv=fail; b=XRALAxzs125VATomUfTD33C2bd/HscckmwoPkp7cqQP9IJBAOilLwUlBoYKI7iEDx6hHEu4mL00lq+EgALMaRmOFqVhPO5EdAKqqM3vtzdNWACMq3wQzn3fsDTK2hZPsfVAaWOWrSij0tdy9n9t69DjpIjkz2BzmYOocug4AVyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191237; c=relaxed/simple;
	bh=QwDABjUNL8tEqe7qk5ZDlZVKWcCa51z7Fsa5E2MQMDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VU9o4jLgbdf2AEIEysJd5D3dimFusMObpoynJVVais6d+PZFSwYFOIFuD/zimMsyTDYLHslekoHzWJbXkFAfpHNK3smxChKwc/7+Gx1DOUX9vfhb49j3YR+UNXIEVxGGDGLg/pvWZJRw3mIS+63YvPdMVx/Sj5IM/i+iYXq3ujY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WNG0xlXP; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shSdQwWmLtqo0/TLCkfX9Ano/ElNEv5HrbWt/Mb9VaPet/U5qp5YlIWdB54OqvBR2oeVXmLbXLkKmlaeTOBAhm4Lgw6luMVSvlpnUSy2VC3zQ6/aajD6CR/urH/20fMPT8LVn6nV/vu5rh4/FHcdDVW7vN0q4loGZxMaEGEq1dk7yzKFRKFLpDQXjXIQHzRt22gVHwUfYGp+WYD7XMIAUjHWe6NKY5eO4+GcgVdNg15gYkwHH0rmfXOppbvaAIF7vUmT9tMNnnOvJty9Q51/AhvOpggHR7k6G6rWbGEYUcan1hbjepuiLtsg/ZzP/SkRHuqP/WIfACoxeN+fHv0aRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiLyn71vX91z75xOsrvs2rcPLAAfjYsg6OFuOxOUw1Y=;
 b=k/YrFeb8fYVLDAPTowSofDsHJsDPBPC7wVAZKv2S6L/sHHBikRT+1jUFXxwHQ2Xd+TPdypGRgfpej3lz+TAdyqqs+x3EwHJDoUW8vPgJ5PYE7orVpsP+bKV+fOCMLLA/b80Dr3hIMi3Ssx/gwSdtw4cOG89Jrx9tUC4QC9v3jTHF/Q79y8tsEaKHBnvp7hsKYNaSBIEJTEuuUDQqNajVId2TJuQZ2CpMBSLu/BxEQ1ykgTuJDefJbQd5UZ0PzmiYrT4+pLhtswuGLu12ngJZ3KcFPJVMeToDlX0jqh8NHKUF0ZDWO7cAu0t36L6Ka/sy6bzV0AtIGPAY7qyiV7arWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiLyn71vX91z75xOsrvs2rcPLAAfjYsg6OFuOxOUw1Y=;
 b=WNG0xlXPin9aLSJht6P9Us9MdZuSzmsptOOsDXhH+T+iBO5rpE1eW+ZDgGt0E/86ZNCqz/cOzo9US/U3cjZb7I+VXlgCjrFES/kmwLH+LUxWIubABvXuYL3drqtTrU96J+658Q47ITK1kdR21nnGj14NGPGg4vz517fvydNPBmycMHqfS0N8AwrCFc335FQbwyVBXUmhr3EQk87WJ0O1MjM24GUeNOEl+3lZa02XmOwJ8O2OX0aKnz5u92rVtIXjo0P7jWJ6fyal7Mz3pJNUUFX17wVNxjVu8dI0NEjTwj8JvK0P2V/5URKYG4rMYYMi2K//awuFDv2Sq9mo62z4Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8424.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 17:33:52 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 17:33:52 +0000
Date: Mon, 3 Nov 2025 12:33:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: PCI: endpoint: fix section cross
 reference name
Message-ID: <aQjneC5p0Ny7O5FW@lizhi-Precision-Tower-5810>
References: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
 <f53830741db9d0351d1290fdf8f250bc685620c1.1762154911.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53830741db9d0351d1290fdf8f250bc685620c1.1762154911.git.baruch@tkos.co.il>
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 490f118a-bfe7-431e-9af2-08de1aff2826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0uP0Ljl5cpQ98Ym21ToCbuo+f8GwwfF98/S0ks3OrCisaavsGAWx5YdrMaPB?=
 =?us-ascii?Q?nYH6DxJmtYMkI1/vHm6oMXbzkoPfie6dA8ozDYNx9tCBNOjvfYV3QEd3h1YD?=
 =?us-ascii?Q?UKh9rQbqCYfHExkCmEJwE6+kxUHEtONwtH681Jo969qSfbAal5p2ZCvcTMU1?=
 =?us-ascii?Q?nLHB9Pu6jvxnIvDdWFZdyrCXtmTNwgDFlNuteo4ag0bQFPbBVB8qYI8LNQKr?=
 =?us-ascii?Q?OnPbeRr6jlHnGrTBr1n4yZEOTtgdby7aCxYHL+/HaJPz10YUlVC4fw24+6Kj?=
 =?us-ascii?Q?GSB67Qbmw4fdlXOgxtisvkStxnvgK5OISRWEaBfQJOUykXmCsAaaNIMUpe1O?=
 =?us-ascii?Q?MCTxfM4W7iS3SH/418G7OGfLVlYMwU3VzFCAvRYXOINENTaTGGD6cPWtJCjv?=
 =?us-ascii?Q?yF1vXCXln4yocAXaIJ3vjx8sebFaTTzQOIj68sSHfNIncrUa+vJPR3j7+x2w?=
 =?us-ascii?Q?FJ+L4jY2sK59geDgPHC7pXjMtFQZBVzGX56R6CYaOLd+z7QcEJkDOSEGzzaB?=
 =?us-ascii?Q?PEFkeGGcMqqxGf+jegqHi2yLHerl2gkNpH0nfbc0gK3Ur+RYBYDuPdB2YWVs?=
 =?us-ascii?Q?6WIJ7r/hFwhL97CRuxBpPtnwjgc8KfVf4JLhvk9+tEhQ1GnL0y9vmwxd/daQ?=
 =?us-ascii?Q?6TsG5s5Py7lc5k39oLteLwPVTBpXhmhxwMgc6rKcMeesdIspGq23jp/tYF+X?=
 =?us-ascii?Q?7F54MUqb+EFKKPkDoVFxGJQll2twWgmPaqBmL2HkiYuMvPczKLBWguMTptz6?=
 =?us-ascii?Q?zAkI4TWMd8T2Gu0+UxrsPiSX5V00OUMNPOL8y2/NI8O8VRy+DD9YGDA0fbGh?=
 =?us-ascii?Q?lxHOVExHM/B9qmCVSByFiu24jenAZRiTVxZqO7gwmdufDTA0E5aWPUxiyFDM?=
 =?us-ascii?Q?Qpqqw27vPiHLEJj/N1e3hOGtTLF114WvtFulGvidH3zZn68p4e+dFo4pWkUk?=
 =?us-ascii?Q?QcaJjOWrnSOgR3XxlD5TCCuYIdSvf6va5EJ4umUyu0hlPppmcZRIqOhN+nXi?=
 =?us-ascii?Q?/cMwUVtcuuX6t/m185gT+REbNyY2a0pae9d+8tT4XZTvCw8tsnepKycbK4Im?=
 =?us-ascii?Q?IlpLclgmu0fQLhVSTwHLXQi4+kqgIQbzrUgfPngBqsAH4UBKLkyaofK14N17?=
 =?us-ascii?Q?DqJM4gwZx1FfoqFWM/J1obXcMq45kml1EZHeGF73jDz3UK9cTHm+c/3FwSix?=
 =?us-ascii?Q?qwbKmPlg+H6SGYfE3t5hx/fIr5Fp/rcKdO6GzQG3V6KnHJ482tzUZO32Rdjy?=
 =?us-ascii?Q?9t5GV0bSt8H+wJmy6SqIS8beFvwFtG9/GQb+aX7BPuV7V1DTM+yo0CfgdLHq?=
 =?us-ascii?Q?lSPCxXJ7wWHTEQQfdowjJt62ibHoiJ3vZVzuVc+NOgHUDYmUdv1p2b48Ulxm?=
 =?us-ascii?Q?PyR9wT2KCax/1crzVKXQ3a6U76z3pSmIBftmDwp5giEajYLs4WJJN7znXVmw?=
 =?us-ascii?Q?KPiT8wlIKdtbNgizT+jRysIzYHIfcwPK5hcoFyf1UfoC21xmeDEQCHqvm74t?=
 =?us-ascii?Q?dpF0kRLHlP52b+J6WHlENknekeKQ/t2FO8+Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AlFyES0/fsg2RWYlHJ2+V1neOIY+zAw5vwy2SnkzuXpey3jpaJVc1peGhP6W?=
 =?us-ascii?Q?Anc/ZyxHkjQj/uu7imSoPzpJcrM/tdVmoEFyRrkswIjSJNz7eD0ez/1wQcFE?=
 =?us-ascii?Q?PQ9vdWyCISMqLG+NJHFgCU8QRqXj+vYvGx7UgnWNTOFjMlO2PqF/8X3E85ZD?=
 =?us-ascii?Q?2HSnBXLnHYcpSgWcOWBtDp/b0Gsa1Ydg3yxIs4LNvKCuilnUibM5YNWYYWrR?=
 =?us-ascii?Q?S1JtBYd+Xw61c6F052TSDKuL9kzZ8dhQ2lKGF2CBeD99m5IK6+VK1k5V3DV8?=
 =?us-ascii?Q?4ZS4laFDbWWAWBAVgSB/ENWsOH3vWOwAkGoD8ZAjRbMDDQd0wE4WCx3Ttplm?=
 =?us-ascii?Q?Ypiz9fk2HLKJSjRfi8QAZtVrg9UJ24Sr05g/FULRQh8kZTGiKquiCRWYE4vQ?=
 =?us-ascii?Q?lja5e0NBtzNqfeXT1E5PdbKdl0DVxfeSbt92Wzm8KyGtrVJjFBB/K/JRfMxR?=
 =?us-ascii?Q?y90rs/ToU+M6WaEtJN8l8Q89smOeWWVB4/RYImkROk8O9Rp0uWbSaLT1cjx8?=
 =?us-ascii?Q?kDqf4G2Fc9i1m85T1tT/+x9O3bJJ2QW3PsRFjKsgDaKKaFRiopLUDKu8bDZc?=
 =?us-ascii?Q?NRUGgffF5UJygCl0yrnUpfMKrD1OCEyuuOLDGp1zKEwndo15UQFqCY85xLji?=
 =?us-ascii?Q?PciVGaprK5KBJYKq4GIrjWusA83xUMrj6l3rKkuMPyc1SWtRfvLtHv08n8hj?=
 =?us-ascii?Q?IoUubMF2S6ZG0GiPwm/vIJQDFG7zyaZAWXkDxYZGNTpGlJE6mVhl4MHT+xpL?=
 =?us-ascii?Q?uR2EYxsqvLx9b/Jh+CfVS2+krr1CZ7Rqh+AuRCDQO55q1wfhiH/jyF6gvi6m?=
 =?us-ascii?Q?BGWUAuGdHzvbkIxDPzNvjjVDbHoDInSYS167s6QkLy7U2SBvJY3lxVe6lO7o?=
 =?us-ascii?Q?UWx+ww9F+wABeGCnjqL6A3OGg5Uvmar3byP/Vv1fBN7J3Im4dmlI3oLyTeIn?=
 =?us-ascii?Q?6IwDJmxTPGW2JI2suWTInr4acWn8LxgSdDxul056heL7ohutDZXJmEAG6SZp?=
 =?us-ascii?Q?zxZLU51UYIkoSVAFl8fzZXeEMQ3TCa57WH6h3aqDEticllOFPcnUJU6a120N?=
 =?us-ascii?Q?I6RJOqKZR5N636IlOv6/k83qfTyQOzrw0USYLkPlt5Ibaf+kG6bIrAM4XYEt?=
 =?us-ascii?Q?27Bbf/PoHrm/grbe/nVLSpAt6G7zmjTFXJfw5bdMLXdlFYnH1SRwS4LRWyU0?=
 =?us-ascii?Q?nu+953LRjKtQfvMgRPfSQC2eBOk6+ar7PzDAQYDqOmp5y+idAeA8xSpaCeKV?=
 =?us-ascii?Q?ilnOPYVNx1e+Km/XlHu9vg+GKGyEWoVra0AFv/9yfcA7DGX4pEanbC+axkLn?=
 =?us-ascii?Q?rXlv7rcKXJS1NDCisNm8jepXdC5/anNkbDr4qCmERlmJ6dHHyCHGRqK3/lyc?=
 =?us-ascii?Q?Sx6k2y/WROowpV3MwdhKB2EVkAEbdxMeFoQauPqBoz68UrZLbsgBSdE6h2Vl?=
 =?us-ascii?Q?GMm7nYTT/ilTP4Sa/L3+3Xy3V5E92WTlDjNEt5rZQnY8JDxRqxEib5t8bjMS?=
 =?us-ascii?Q?UpmKnMAnqIzH297Kf/K3Tk+A/hE1+bpdwWv7RQdkfsGoAz6xiz+N3LgFHtR2?=
 =?us-ascii?Q?I9a5S2KzVFUqMkAPDco=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490f118a-bfe7-431e-9af2-08de1aff2826
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:33:52.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eTuw/wr+G21WJOo72g4s+YO9ciz5eAACve1yQ/XwUGYNPqf6+oXv8fSdYXbz2UMhGkmKK+6qY18NR6tPiDmUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8424

On Mon, Nov 03, 2025 at 09:28:31AM +0200, Baruch Siach wrote:
> Refer to the correct name on section in this document.
>
> Fixes: 4ac8c8e52cd9 ("Documentation: PCI: Add specification for the PCI vNTB function device")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/PCI/endpoint/pci-vntb-howto.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> index 72b7a71b2e64..18146155c350 100644
> --- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> @@ -139,7 +139,7 @@ lspci Output at Host side
>  -------------------------
>
>  Note that the devices listed here correspond to the values populated in
> -"Creating pci-epf-ntb Device" section above::
> +"Creating pci-epf-vntb Device" section above::
>
>  	# lspci
>          00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0000 (rev 01)
> @@ -152,7 +152,7 @@ lspci Output at EP Side / Virtual PCI bus
>  -----------------------------------------
>
>  Note that the devices listed here correspond to the values populated in
> -"Creating pci-epf-ntb Device" section above::
> +"Creating pci-epf-vntb Device" section above::
>
>          # lspci
>          10:00.0 Unassigned class [ffff]: Dawicontrol Computersysteme GmbH Device 1234 (rev ff)
> --
> 2.51.0
>


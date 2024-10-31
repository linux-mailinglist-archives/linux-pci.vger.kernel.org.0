Return-Path: <linux-pci+bounces-15707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF359B7AFC
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B692865F2
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F9619D89E;
	Thu, 31 Oct 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AAgO/mQE"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAC199FC5;
	Thu, 31 Oct 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378709; cv=fail; b=VKFJPPz/XIAbLM828LKiz+2jzB+8IKQ11wVTBtIWX4QmsIBLdMGQ/nIV/J5nG3aCHLFSZddfmLokbkq0R8Uim9JloQP1SlD5xJCwyaf+N+74rnMB2+dX2Yn4rDn+ifZr7z3T5codaeiOfMwphpJiYeJOE37u09JXdClcw4WR0P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378709; c=relaxed/simple;
	bh=K7oik0YsfSJ9klQJLIiUU4OrY/n5P8HzvXDjb0uglLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uDeSMjoJ5thfiTWTj5L3Ah3FZVac/AVpXm8dtu7v8Xq2zhZGci3xyjtazze0D1lU5e8vGZVFkCaWQzuwTEZHkWp7b2s8Hq0XEOR1RHY1Y4HF0zRddfGs4mG1V6KrgsOAO5OSUDrn0RVphbV+7Xwx2qXPUq0kvux9IsFxHe0AyyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AAgO/mQE; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrajQpIAK7fr1Bhd+Q5ydcObQfMpWjbZdP/A31TU8ZkI8eNfm7CuQ/Xr2kTcCbFc9s+qz4t8cDPOhjTTU1J1Y6eTlumJLrMo5/VxW/HjBp5dg6TBGb7n9YKBWlme9AhNNkg2nbge2NXKbLrJ78pBgELJLdPzoQ3e8UPdQwSibUPtAr2H6iHCO8CytvDNJYcoBNkozAzCiHSxF78JM0TcrJ0pm40gQeFN6vNohPQxfJXza2wYtlpXKWqRWURWW1QtT17udHaB6eVh98aSDvttWIhcDEXkPo5zBvRi4yXO1n2WX6zSw3ZzKMMv/gSP0+9EVaYolR6BhXP83LNGkoycXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=065PR1VasPLU2MaE1XvyNtR2xf7JMD8s2jFgnFgAHCY=;
 b=Zndc30VGq6VDPk7RfmikMsna6bbE8gH4bRDjG3IsrwQCuwllyERvsAfDonZtPozsezCMCrYt35Hp7FJZCpgD4tF/oPJKKkfqdwwTj88yfZkYpfaN9lkYVKicAf4QsuYQsRVpVWRMG7dd+xQWXExPvWO0UcWXBO8s3VNy8SnP+mKQEviH+XujOfCW/P43ptwCiCB7LxSfQDJhUS52d8OGTDyH0xC2dVzEhP2vPsbq0dhUFLNpOKY9NJKsFK9cSoIkPlHJsVml0tYtUMT+E+UYWRhUqPZvmm5fpxXkYYLfs7FBvmlU5K9e61dxbYxLKuquGp8D6iS4Nf2gwsyh6XmNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=065PR1VasPLU2MaE1XvyNtR2xf7JMD8s2jFgnFgAHCY=;
 b=AAgO/mQEkwKeeAj27vJ81gD3Sc1rub9q7cvVn4Gc7xjudAPf8B4SlaE+OGlo9DAuNEcyL3pztsyKjOdeaIUXC2oSJLCCJyiL0Tw7fyaRuf5b9kospp1TpAZi8xOZg0VE6Fm1xZjfxMKJvg1onFQdWV9HVlEcZ7I6dHu/27l2YcrLikgktKIBeIu67IvhuEK9dBiAozmWmKzV/mGbRGmr81i7W7se+qH0XalAQbSNwdvv04sZZZRBPJHYW6+NexSIhoTwibOwAoZ0wGQpW09SuaXCVbVj3c7OiOADgaGynxlAc1F6pMeItwghIy/eZ/XbF10fzmJoJYzQV+2pS0dKqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS5PR04MB9998.eurprd04.prod.outlook.com (2603:10a6:20b:67e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 12:45:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 12:45:03 +0000
Date: Thu, 31 Oct 2024 14:45:00 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <20241031124500.vxj7ppuhygh6lkpm@skbuf>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241024143214.qhsxghepykrxbiyk@skbuf>
 <PAXPR04MB8510BE30C31D55831BB276B2884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241025130611.4em37ery2iwirsbf@skbuf>
 <PAXPR04MB8510B731B4F27B1A45C1792588482@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510B731B4F27B1A45C1792588482@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR0102CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS5PR04MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0f74c2-375c-4844-0aeb-08dcf9a9d72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivWaP04Wz4ApvdgCpKO54krupnx5WyzwaJAyH7IFL4CgoCfGgJn7LbUmSXy9?=
 =?us-ascii?Q?DNiaWLBfG1l8I6MV/Bvd0InzN+CwgBJV6gR+wqTq8qNP6ZcCRaKC2RtsP5wU?=
 =?us-ascii?Q?vas8jVQ4y5wUBtSgeviurHCOQlJl6tuXIhL0FEeJ4AQieqTUaD34ngzoUh9v?=
 =?us-ascii?Q?xfFUUvSMycEUGP0jYeX8M/ZBgI0pKMwSkcJ2KnWg4FkBYa3FkqSVLddPUrCh?=
 =?us-ascii?Q?1tAoP1d11kF2wkKpqkmhMvW4R6O89KmLAgDdXyZI6+da4B0QhkN3KMqsVlQf?=
 =?us-ascii?Q?M6ap9WEOpHwwjj8OO7pP2TGR4G+1V/kkmXYp4dRWcfTO/+jTHKghP5nmO5BI?=
 =?us-ascii?Q?IK+u7M55aHfyzgdIM89Gp88K8cquRx6pNVzd2V9pVcZrx2v7IY6yi5hp5L7f?=
 =?us-ascii?Q?YDTh8ZnSJIb+BsrRCml9UvX9LpUaGCNjn/YReE1QSzzPkQzR5LwQ7M/qUPPe?=
 =?us-ascii?Q?9odF+OuD0cCYwR1oImAzhOE5pxgBRc1lNzcSxop7HuOpt0rY+4fOS6/NXIy6?=
 =?us-ascii?Q?5DzV21Wy8sMc+RvNeLPTHLmUYQywq3PBdRz18cSclz7dKLDH+SFW2LAbis3O?=
 =?us-ascii?Q?GhleXRSSwM7Ew9+UWMG1Dqx+l9oi18m6IU0/gPZBdO+HJnKgeJdsqfc2lCLb?=
 =?us-ascii?Q?jaQWaStLNpEu3e3Q81x2uuVc2lUtxy28BASHf5piDDbsmMLjpcu4QQKOA8lX?=
 =?us-ascii?Q?u6Qg0Pp/4rS+ASIH8smz6LTK0cFz0RFFXJaXik59iX7SBWNXiVA2giXuSTRD?=
 =?us-ascii?Q?Q+wQ8qQyBOWBgc36LZQ+0yzDDaCUxL4hNsLXJ0a98LUk1lpTJzspJrV7A59U?=
 =?us-ascii?Q?txjs76cbsSReBmRyu73dLr+VjAJxG+Gd1EFm4ozSPfPUma+rZoV1wzQvbas6?=
 =?us-ascii?Q?5jzV9cQeQ3HQUxuIFztgGnvY0DGsjyIuoBR/hy0B8RmujfNnCqlkmUdjbQmG?=
 =?us-ascii?Q?J4/iiXf01DR3vSkSufWmPrlBJVu9cuvXO9I8CUekMoL106E49kNenV8oYcnF?=
 =?us-ascii?Q?IKSi1wBkthNfnPHwv5QzYSNABqwzRjXcu0kaLnEhO0H7045rvjHp4bJDxY2k?=
 =?us-ascii?Q?qMfkGnbZhgswviT0olBRuw2KFsEiTg7S3tlfB6wQi05jtQEyAJnDhixY3+Zx?=
 =?us-ascii?Q?glWEFiMkTGaD6GqlJuAADx481nq7yCk2gosaj/zeCg3nHa9A8ZAUNZlq/Hoz?=
 =?us-ascii?Q?J51Er3QvU6KYcsHVr7QiWpCzLyvwIQIj4sE/H+I4T7WpoDaDuYxN/r65tPJz?=
 =?us-ascii?Q?5WFHNN86Icj7KXXVjZa1+YAO5Y1f+/gL1jSwPH1pqPwI4Jv0WN8fXTnU3ADP?=
 =?us-ascii?Q?USSTYLNR0Iu0zyiBtuhQnUgl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIj6vip2LQmez/HS4cacrUivghyb96m1hBHvAeRVvydp8BuPZDO+RcLIzQqw?=
 =?us-ascii?Q?NcklhfDhgPog5O1Il2Lbo3eQeMvH+4eaVr/jJu3i+Cj+qHMtphomyaaFcD9+?=
 =?us-ascii?Q?Tz4232NfJOdUGBD9oX1/gfseczxin1keMA4Wi+49E8Vck65rCEEaq0mOOYsq?=
 =?us-ascii?Q?eka92AQZaPCt7ALSvyKKTLWf9qrOjGdf0RpkIj0jKlgI7ztvfvabl3gmiDmV?=
 =?us-ascii?Q?ndMMGjiPqwFnDLo5iAuR4ZOCcbDzMPMVtgWWNIE05zVS94AHKn5lmwaV/7S9?=
 =?us-ascii?Q?Y/f3O2bKsUDZdlvXwuXlP/5GxYINhxqM87lBeCCElrs7APx2t355YQygm3Rl?=
 =?us-ascii?Q?lavVfvuUNyhXPtN9o9PN4rukdWKhiOFI5PDYB7Twotoe3fIq6CjcQfq2qKOP?=
 =?us-ascii?Q?jG0b/hGX7GK5D4P054iHyQTtd059/6Tq3tiUf1kc8IC2MaxAGEYtfqZ3yJsN?=
 =?us-ascii?Q?JKn4ec9157+ccu12ubhpgCr+4kKG6riDigOXFpz5/GMwd6O3X7qVMiqACaaE?=
 =?us-ascii?Q?XVhdxUuWTymdg+k1YS45JDegRdO+20UTN397TNMclI0VTIer5UWuNNsWBSxA?=
 =?us-ascii?Q?u5WXZXtL6i5r4RSrmmQW01BD6QhJ3QY+fXfRuOCC3v3XDjQFzWhMI4whRMvO?=
 =?us-ascii?Q?ymyXQAPHUVtO/oT1cdgNdsTB60QhGXMAruMxJFEVImIVC4casgWNSZyZheeg?=
 =?us-ascii?Q?ftAmM2B1ewW5AcqzXvzy1FEa50pMhQHAof8P363qUW+TtXaaJD11Jge7Zedc?=
 =?us-ascii?Q?Bn6IQNUB14MI/W/j/QS3bETpKMSxwPY507jNgxqM2HjpYx4psOm1io/DyDUn?=
 =?us-ascii?Q?jPjuZQXIDlcBP2CBUufpq82REcLGCKG1w2noNf0xHwVZjEQ89MWUyvS3foZB?=
 =?us-ascii?Q?7E99cX6ghfhpoZ6CAhXs/RWeqDjbOv+8YwcaEz8dZ66LaT1fC9HAe2hnXODh?=
 =?us-ascii?Q?DrlHOSWIs6IETynebOSScPqhnVe0ORzu88+T2BEbrs2eV6/n+/tsKhNG/YTB?=
 =?us-ascii?Q?9e80tHxTJMETUCOzvte5cuzHaINVOJFObmbfrO2mXmMRJJ/kLzFhGfzWTg5g?=
 =?us-ascii?Q?473DOclYKLN5EpPcSx+ReEAd3kbrySjiDf+ibsQkVx9pCtL0/X3FfB6+p4sI?=
 =?us-ascii?Q?wW+ikI6XtPcnO/b8xQfjBDx/557OqV4ibdp88hde1KZGN44nJaDbFKZCZbrA?=
 =?us-ascii?Q?ObMisrgsnBVKSPX50K43vTFylNRwriR8JMv9W4MHLM2ciXu/8j34njBsqmUv?=
 =?us-ascii?Q?pqciVtHM5zk1mSSyapQsOEVQ1ezUi1Iktj8isUCCsN9kqgj3UF7pzLsNG/Ts?=
 =?us-ascii?Q?PrVHGSAg0rFc0WqRw45Ax7xY6ZUSa0KVRC3btGjT3kfU7K7PziCF29HfbBQT?=
 =?us-ascii?Q?sOneJlY/0I9cdE7nbSacGYjQh9H6yAsntAc4T43EJW4u04x/2fg9/ESB7AGp?=
 =?us-ascii?Q?oMAIAXYBTqoA10pqqxNMB/C+kYkodm4PRoOfTPxDUvQhshJ8vKaonxD+2Ia9?=
 =?us-ascii?Q?t21jzlgoiXlQ5FSvnrR8o4q0PBSRMaJM8p61u0Awl9oGITdsRnPC5DVqsTXI?=
 =?us-ascii?Q?L1msajXL2LL2AbVc5LRCl59zgQM414mDfeAXK6aSJpQ1EfPvYNakTi9cDCJT?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0f74c2-375c-4844-0aeb-08dcf9a9d72a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 12:45:03.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC4yv6smVtKpbSWQSQWuHhrjpnnl529LnlzNhGbRXQ33gqT9QXbePuH/sVuTO8t/jN67jgkzcyO8a6pu4ImLWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9998

On Sat, Oct 26, 2024 at 06:01:37AM +0300, Wei Fang wrote:
> system-controller not only configure the endpoints of the NETC, but also
> can configure the ECAM space, such as the vendor ID, device ID, the RID
> of endpoint, VF stride and so on. For this perspective, I don't think the
> ECAM space should placed at the same hierarchical level with system-controller.
> 
> If they are placed at the same level, then before pci_host_common_probe() is
> called, we need to ensure that IERB completes probe(), which means we need
> to modify the PCI host common driver, component API or add a callback function
> or something else, which I don't think is a good idea.

Ok, that does sound important. If the NETCMIX block were to actually
modify the ECAM space, what would be the primary source of information
for how the ECAM device descriptions should look like?

I remember a use case being discussed internally a while ago was that
where the Cortex-A cores are only guests which only have ownership of
some Ethernet ports discovered through the ECAM, but not of the entire
NETCMIX block and not of physical Ethernet ports. How would that be
described in the device tree? The ECAM node would no longer be placed
under system-controller?

At what point does it simply just make more sense to have a different
PCIe ECAM driver than pcie-host-ecam-generic, which just handles
internally the entire NETCMIX?


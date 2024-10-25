Return-Path: <linux-pci+bounces-15303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB929B035C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C516285389
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84D1632D5;
	Fri, 25 Oct 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fwdbVuZk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A170803;
	Fri, 25 Oct 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861582; cv=fail; b=HNzLfLQCyu3Dy5KugLKTH5bpMgbFQacmkjKsS+uKbMAvEroepz7tDxxr8yoP94/esApqbzNbYQo+2w+lpBlfx7s2nfQta+Ot8NEQdf2Jo1m0HvASd8kzP0MFlzEA9MRZ5A7D1aqW16LoHjsqJbvtcCLh4xJ9mqaNZoQ36bqlMj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861582; c=relaxed/simple;
	bh=oMwASnbOGMF+RFqZxGw7e1ykbIc/lKdaofSMh9DsCfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u9ub6zmDbp4DvFluUcgxr5MTHYaanOtN0j+Z7umLSPab+tBbrQd8hnjeAHPI5Tgtu6GzG627ZREvpH2eUWIyOWU8lg5aql113231XSk0BWXGVx6jYExn98aO6sJPF3hdG1YvUSh34AG1BwhdtUibiYp7+33wWaw9itmFXC1wJDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fwdbVuZk; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vld53SPSkbSm2SzsReXxGX1Rbbt+m1dglNIKFEa1dK2j0XezjB1kbiejWA/R/+cJ26c2wz04JrJGCSgGqt4bUaXUiOUdkYHBBX04rYnMnFtsJVmnsgyVlUn2BEzvXnsyEVDB++w6yp6AHO156W2eGMXMwWwq3+ObodiibXr3THVhWXJ1hTeBzR3+nRprPPFPEpBZxhwmwWEKzAKK+sIMfTKFOTa2SpiaC/8xRxyQ7EFbtKQ+WfraMz/5IqVCORY2xHV6uhYL6hrVauHFq28j5jYz+wSph8CrQdFZpsEboVmYOlu/c38W/mXRn+n4YIItwmywPWTyvgYJVcuFJ1HguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ex4PHqJ7cOHU77VwyScCZP5fSLsM/CDN7fwzf4caD8=;
 b=htgnVilR8sAyxkjfmqalQ7BqMI75aK0sda4h6nCZtXlV8Euld/OA2YYOEmEshpQW8OvOPEm2bRHwKiYELG3Y/GhfJL7jzhXb4b9gwRXu29RaDHTlNaXQDocPYiz7XKO1KC3vmXC0qj05tYebVF9A0YkNtUQGDi8gkTxM3XGUnQgdKSJnuVA3lv3yAJ8LtX6ae3wuouU5YNxSr/0Jp6n0Qh2TlmYCAifSasoKYHx5UxO6zThN8rw/oqUVJiMHTEg/Fz6ob9gpW0U5CdHsTJ4Om2nCd7sXq/dAgQ/7fkZHgAhG8MRu4LLVPZsZQ5d64INCoHaYC5jmFCArh7Uv+OM9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ex4PHqJ7cOHU77VwyScCZP5fSLsM/CDN7fwzf4caD8=;
 b=fwdbVuZkIfs4bNhpipksDWk4yfn4jy7wu2bWHKEQLqdgxu64+YKkOh1VQcY2YyUva/Q+46KxFdWc9pZPvgmwZBMLtkvky40O6hTEtmljDLZ3CHjp6mAqcEm5pQ1c0LkVyZFmS+Qij1BOPe2r1TrTXENqNpuvwqX3aow/S7m1idjZ2YgB0ZpkGKtFwXDbrN1+kjatEQ/FprkQgQ5rekTdhBU6dZfksGk7GSaitAJ6xPbC7wEDjHJLYz3LQpXr+IJPBOJ8FINKqbHgqOz0WDAUz4NQmgV86s/R6WLcsp5IP2zEZu/Ru6Ab8Ujhsn7lt3NwFZNafoSCGZ6CbuGe5sqnsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9844.eurprd04.prod.outlook.com (2603:10a6:10:4c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 13:06:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:06:15 +0000
Date: Fri, 25 Oct 2024 16:06:11 +0300
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
Message-ID: <20241025130611.4em37ery2iwirsbf@skbuf>
References: <20241024143214.qhsxghepykrxbiyk@skbuf>
 <PAXPR04MB8510BE30C31D55831BB276B2884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241024143214.qhsxghepykrxbiyk@skbuf>
 <PAXPR04MB8510BE30C31D55831BB276B2884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9844:EE_
X-MS-Office365-Filtering-Correlation-Id: a752f0ac-ec1a-40c7-f54c-08dcf4f5ce8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/s1DEhC8G7vTLb1wSLwHiDCZC8Z2dXbYl333Q00lBCPuQFtLScXk1IAnxG6a?=
 =?us-ascii?Q?Y9dkHSuhMamc2e/AGg4dCzab6k/m4k/B/H5HoIYhjHwM8c32FB571wtbK92G?=
 =?us-ascii?Q?zmbWyWs3vdqT3NygAfzp0v6yvHI6ra5jKAp/OAlBy2y2ZcRLxtO29asbJBbs?=
 =?us-ascii?Q?lCLQ6kZiOWI8+1ocI6fnOLLxjawQu0UmU04lFyp+MdG9CZzVng5rVG55HiT0?=
 =?us-ascii?Q?hXE7TDEtFGHuxLxuyWqCPZz7tH1HSSSyfAYYZjmxznLpjdluK3AwLuo17PoI?=
 =?us-ascii?Q?aS50EvWvtVH9OXQOr5vawAN1w1ZNYr20QXMSEmou4Zs43PM6NvWu48Vo5460?=
 =?us-ascii?Q?0Wps5x83EuvvAMv1SePDrTjbzzBigVA3FGCqgSHord0eQjOd3vxqj6C7PX3b?=
 =?us-ascii?Q?Z/7CSh8svm1Th+7ptra90VpXOOexG20u/Ab8MJkFR6w+e4ubAFP2rAmMXhwP?=
 =?us-ascii?Q?rN5msknIkVGwGByV+gmAWEC7++LQT6UDg24h7Vayg5K5UbU8p2Vqi9fvM/Jf?=
 =?us-ascii?Q?DP4Mz1Weh5riVfujDawhGOCIZA0Hj5OMt7gTLyopyZx7Gi07fsjZyeV+pLab?=
 =?us-ascii?Q?WmjMFdhi+j30n6+IUdTdXizShxtL/JhH9gXd5fZHfhtXN74JT3z89gWFtdiS?=
 =?us-ascii?Q?VY5jbCuO5WCyP5gplfnRzAWVgFd0efL6GXBSrLMfzhkUyP9Vd3aPOA4SSWb9?=
 =?us-ascii?Q?3yCHmVJpwa6E26CH5GTXj1VDSOguyCSdGqar3e6x3OV/QOlTqa2ootm04QjH?=
 =?us-ascii?Q?qZ22tTTduo2w8Y9hEcZ5WM39XKbqQMuEy1UDm9fZGrBPh0Jvwb+Rch9Aepse?=
 =?us-ascii?Q?ZgGs5bORPT5zD1u23+I+g8mT6nqtCW1Aunt699Nic1S2u2DcT1ZjmS9N+HM4?=
 =?us-ascii?Q?vU8ntweWVy7kavtBf/ukZgV9gyVqNnp9Tf2WzPA/rzHcjGU819xLHcc/2BSu?=
 =?us-ascii?Q?MYWZEwQ6bjDOlF3Sv9+wtRIKlyMkSjwhxOfoGnuqmgDXDreBAbJfjHZMzvVe?=
 =?us-ascii?Q?J1I82dfon7wxdG+1GR3DBydZBqKtQHE7ktXUD/rBMCJ6IXoERGplt51q5dV5?=
 =?us-ascii?Q?O5AaVbSkPgX6rqyEjB5BhrZp3p9W3GsKalDD/MzFpfXGnnTqRX6x8YYeXKJk?=
 =?us-ascii?Q?ERPLeephtWtZFFaF1rbB5VJCjDUzxK2KhWkNZCQO3YKMD5G7AKzQC5Fm1rYj?=
 =?us-ascii?Q?JO5e1UFG6MwRuJHASfg2/4enGk9lmEY1SM8OYVcquWMVYAHDZTLyUNO/BRDe?=
 =?us-ascii?Q?9T3BHaF4g6jADHHeHPNtwEgdP5SLoikFa987BLQPBLthBmM2TI1H+ftJrZNx?=
 =?us-ascii?Q?V7cpvzxFt4eePmFsOiftd0G3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0X/NnNq74ZyATBmnjHldxmofR6n7x0PHxVI/2pwJ/CcFrlgpkrdVVCjnXAUk?=
 =?us-ascii?Q?c7ouTREmTM6E/HJKdwvFL8ArdDZq0MriOXzDqLBnuH/I6ePx8Dh7F3oK0Gxu?=
 =?us-ascii?Q?szxi/f2yeXzq5T2o4JZbFIlhbaP3K9aa07OTlSDVAcqOuyd1WwI61p/B4gN9?=
 =?us-ascii?Q?gve/JuSoZxeRd5nR5Fn3C7ZFVEUJQpLRahyjykUf0J/6co4P5x90bzrBYlmz?=
 =?us-ascii?Q?NADRYzxo6hZO/NwSgMyIZuqnqvJyQYiO3XIPsFxQrvYcRwD2cToyKzOPDW6V?=
 =?us-ascii?Q?w/e7tRDRVictpwd8WuAuTPpDG1k/tywDifffwQ71IZKk2+g79+4/DplE+RPV?=
 =?us-ascii?Q?6mbXImK2j/1hlhyHlZT25bAGYAbAO+yH/sI9DVZMoNBD7yutXy6KjSwlYFUz?=
 =?us-ascii?Q?NM9WobizQLLF1I0feavLvISD2h+2DwhKcG4enTHOZw7TD02trHTS9AIM8v55?=
 =?us-ascii?Q?+wpPy8NJ+SW/l5lCenohlB6F63BNSkdJK8wqxDfZK3ZrGXij2TdfEU9eGnB3?=
 =?us-ascii?Q?Zrk8wKB9qnsZaMBOlNF0aXq+CA9rklJUL9U9bNTWGcXYctE6si8mg2XDyGnX?=
 =?us-ascii?Q?M7CTYbUQwrT8VDN60ioaaBJF6gwTKTgsfH6vz3FU16Jr9WRBJfgjO0vawMt2?=
 =?us-ascii?Q?Pt+2oDpxQFDK81ycHXn8BnZMKrLNdERvSlkSxTa/81cxh45rmLcGx0dnZqLr?=
 =?us-ascii?Q?rs+twLtUnG8pXmAaxUHF8eR8cVVnaVg/4XgYmRMAFg3VYUggmByoVkiN+MBr?=
 =?us-ascii?Q?Vm7buMQQrXB4jpHqCwvqzHj9o8yVAIJjDid1oxKgdloWlW8OM/p63ojfnV5F?=
 =?us-ascii?Q?0lKM87o3Fm71ol7f91s32OX60z8vHO5yGe8tO6z19Qctc9GTi0wxfmRnPFJg?=
 =?us-ascii?Q?SGjWUiyVAB6muAWGc4HNeHhbaTH+K9kgrpguex0wMB96Oq5UAzUo4ivw+fCR?=
 =?us-ascii?Q?h9dRxZpPaT1UPDzyhPuYuH1+5Hc2LZtLDYoQUtrTUnPhCHJeUnJ/eYnw79QC?=
 =?us-ascii?Q?mWo9Y0BJCSM6xc/P2nUdN+7Jloq4BhHfi+3rdqMk3qpTlWbVe7YMN6EA5d9X?=
 =?us-ascii?Q?gI5HZC41JOtOg6R+VXh2GI98xBJob93r4ZbB38oDs9UZdlPWfeUvtHXiUTMi?=
 =?us-ascii?Q?zl505SrCfFbhYs3hgcCprBSFMBpocurlzZTSuQzcPcYgnrVaZU3caYQnfVMF?=
 =?us-ascii?Q?4kKLD8zJ/1/7Yf0pFYYJ7v0ee5BnluE0qRx+JFLPtJsfCR29LvLyewk+tOAK?=
 =?us-ascii?Q?eYGnykODPRM3M6iRaokRpOTss6pyzVvK+8GaNSBmI8Df8f4RztDdeNJhwPiu?=
 =?us-ascii?Q?s6KeOR24MHA5L6o2nk4WRWYGo8dFQ+r0LGHjQ+t03YWDkwoSzRO71kB9d0kz?=
 =?us-ascii?Q?jf/+OFkGXkP1CPoxwlnSToXUwYJgdd5BuQJf0w3tpzl1TFY7wAVNFL+Y+QCq?=
 =?us-ascii?Q?zbnYUXWfub1eq96zYrh0JOC10pJDNKwz+1fgQ3VY/eCno8i2lpiAmK1ygWEB?=
 =?us-ascii?Q?HE42OU4JriSSpSQAhoCh1VSCv9S1RTW6nk7rc9y6LhH3vAkPM4a5Ni9vL+ih?=
 =?us-ascii?Q?DMlKf3WpPAcdX9VhJY7HM5QdWx07jDLq4wYhZIarhimeWhKd6XEajC50xiob?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a752f0ac-ec1a-40c7-f54c-08dcf4f5ce8d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:06:15.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NPDFrUUirxAsQo/YCXEMh3IQsteumOUpyCxzmjqeG0zSn9i1NvpAyzjEFqzBMilqnAJX7I65o3OSWvgt0pZNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9844

On Fri, Oct 25, 2024 at 11:48:18AM +0300, Wei Fang wrote:
> > > On Wed, Oct 23, 2024 at 11:18:43AM +0300, Wei Fang wrote:
> > > > > > +maintainers:
> > > > > > +  - Wei Fang <wei.fang@nxp.com>
> > > > > > +  - Clark Wang <xiaoning.wang@nxp.com>
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    enum:
> > > > > > +      - nxp,imx95-netc-blk-ctrl
> > > > > > +
> > > > > > +  reg:
> > > > > > +    minItems: 2
> > > > > > +    maxItems: 3
> > > > >
> > > > > You have one device, why this is flexible? Device either has
> > > > > exactly 2 or exactly 3 IO spaces, not both depending on the context.
> > > > >
> > > >
> > > > There are three register blocks, IERB and PRB are inside NETC IP,
> > > > but NETCMIX is outside NETC. There are dependencies between these
> > > > three blocks, so it is better to configure them in one driver. But
> > > > for other platforms like S32, it does
> > > > not have NETCMIX, so NETCMIX is optional.
> > >
> > > Looking at this patch (in v5), I was confused as to why you've made
> > > pcie@4cb00000
> > > a child of system-controller@4cde0000, when there's no obvious
> > > parent/child relationship between them (the ECAM node is not even
> > > within the same address space as the "system-controller@4cde0000"
> > > address space, and it's not even clear what the
> > > "system-controller@4cde0000" node _represents_:
> > >
> > > examples:
> > >   - |
> > >     bus {
> > >         #address-cells = <2>;
> > >         #size-cells = <2>;
> > >
> > >         system-controller@4cde0000 {
> > >             compatible = "nxp,imx95-netc-blk-ctrl";
> > >             reg = <0x0 0x4cde0000 0x0 0x10000>,
> > >                   <0x0 0x4cdf0000 0x0 0x10000>,
> > >                   <0x0 0x4c81000c 0x0 0x18>;
> > >             reg-names = "ierb", "prb", "netcmix";
> > >             #address-cells = <2>;
> > >             #size-cells = <2>;
> > >             ranges;
> > >             clocks = <&scmi_clk 98>;
> > >             clock-names = "ipg";
> > >             power-domains = <&scmi_devpd 18>;
> > >
> > >             pcie@4cb00000 {
> > >                 compatible = "pci-host-ecam-generic";
> > >                 reg = <0x0 0x4cb00000 0x0 0x100000>;
> > >                 #address-cells = <3>;
> > >                 #size-cells = <2>;
> > >                 device_type = "pci";
> > >                 bus-range = <0x1 0x1>;
> > >                 ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000 0x0 0x20000
> > >                           0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
> > >
> > > But then I saw your response, and I think your response answers my confusion.
> > > The "system-controller@4cde0000" node doesn't represent anything in
> > > and of itself, it is just a container to make the implementation easier.
> > >
> > > The Linux driver treatment should not have a definitive say in the
> > > device tree bindings.
> > > To solve the dependencies problem, you have options such as the
> > > component API at your disposal to have a "component master" driver
> > > which waits until all its components have probed.
> > >
> > > But if the IERB, PRB and NETCMIX are separate register blocks, they
> > > should have separate OF nodes under their respective buses, and the
> > > ECAM should be on the same level. You should describe the hierarchy
> > > from the perspective of the SoC address space, and not abuse the
> > > "ranges" property here.
> > 
> > I don't know much about component API. Today I spent some time to learn
> > about the component API framework. In my opinion, the framework is also
> > implemented based on DTS. For example, the master device specifies the slave
> > devices through a port child node or a property of phandle-array type.
> > 
> > For i.MX95 NETC, according to your suggestion, the probe sequence is as
> > follows:
> > 
> > --> netxmix_probe() # NETCMIX
> > 		--> netc_prb_ierb_probe() # IERB and PRB
> > 				--> enetc4_probe() # ENETC 0/1/2
> > 				--> netc_timer_probe() #PTP Timer
> > 				--> enetc_pci_mdio_probe() # NETC EMDIO
> > 
> > From this sequence, there are two levels. The first level is IERB&PRB is the
> > master device, NETCMIX is the slave device. The second level is IERB&PRB is the
> > slave device, and ENETC, TIMER and EMDIO are the master devices. First of all, I
> > am not sure whether the component API supports mapping a slave device to
> > multiple master devices, I only know that multiple slave devices can be mapped
> > to one master device.

I meant that the component master would be an aggregate driver for the
IERB and PRB, not the NETC, PTP, MDIO (PCIe function) drivers as you
seem to have understood. The component master driver could be an
abstract entity which is not necessarily represented in OF. It can
simply be a platform driver instantiated with platform_device_add().
Only its components (IERB etc) can be represented in OF.

The PCIe function drivers would be outside of the component API scheme.
They would all get a reference to the aggregate driver through some
other mechanism - such as a function call to netcmix_get() from their
probe function. If a platform device for the aggregate driver doesn't
exist, it is created using platform_device_add(). If it does exist
already, just get_device() on it.

Anyway, I wasn't suggesting you _have_ to use the component API, and I
don't have enough knowledge about this SoC to make a concrete design
suggestion. Just suggesting to not model the dt-bindings after the
driver implementation.

> > Secondly, the two levels will make the driver more complicated, which is a
> > greater challenge for us to support suspend/resume in the future. As far as
> > I know, the component helper also doesn't solve runtime dependencies, e.g.
> > for system suspend and resume operations.

Indeed it doesn't. Device links should take care of that (saying in
general, not necessarily applied to this context).

> > I don't think there is anything wrong with the current approach. First, as you
> > said, it makes implementation easier. Second, establishing this parent-child
> > relationship in DTS can solve the suspend/resume operation order problem,
> > which we have verified locally. Why do we need each register block to has a
> > separated node? These are obviously different register blocks in the NETC
> > system.

Let's concentrate on getting the device tree representation of the hardware
accurate first, then figure out driver implementation issues later.

I'm concerned that there is no parent/child relationship from an address
space perspective between system-controller@4cde0000 and pcie@4cb00000.
I don't see a strong reason to not place these 2 nodes on the same
hierarchical level. If the dt-binding maintainers do not share this
concern, I will drop it.

> Another reason as you know, many customers require Ethernet to work as soon
> as possible after Linux boots up. If the component API is used, this may delay the
> ENETC probe time, which may be unacceptable to customers.

I mean, if I were to look at the big picture here, the huge problem is
the SoC suspend/resume flow, where the NETC requires Linux to reconfigure
the NETCMIX in the first place, before it becomes operational.
The use (or not) of the component API to achieve that (avoidable
in principle) purpose seems like splitting hairs at this point.


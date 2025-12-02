Return-Path: <linux-pci+bounces-42452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A8AC9A650
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79E734E0739
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247422A7F9;
	Tue,  2 Dec 2025 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gFpDYBVf"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010059.outbound.protection.outlook.com [52.101.229.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B17211A09;
	Tue,  2 Dec 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764659521; cv=fail; b=c/qN8Rqr2pLrggw4F/6EUmhNSInRpDtU56z2bbxYq2G9W2FO3Iu3lDrufL1INRl8xdc/FTp4yT+E2Tv9fxiOAanmpqVR4sN60lDLjSg70xTQoNqVdT2AopB559ecun8tmkRBkcoCbboZJ+vajNhSNFjPm3x29Y3PV+t8iSJoqvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764659521; c=relaxed/simple;
	bh=JrsZ/oqlwOw2G44rHHypuapCZWsnpxVXf4/oACE56AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EKWv+2kGcopg3pJ3c5z1z0C6VwC50SoHhM3KnCXFFFfJ8k6dF92TnTsEFcsLBQmFKDK3qCITIPawkp/Kfxb6dpMi7hpI7YRPI2RFSmSpdu5O2jt0bHaR/WIJav83o33pEi78zEmeQqrhlpUONeK41vTogK+YvLPThTx17OY02Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gFpDYBVf; arc=fail smtp.client-ip=52.101.229.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkTEWOqSAH5tyepfn5CnRZVI/PPj9IM5Ox+L2KElSEoGpedU1B8i05FRxkYv8oipFRA31ixVWptKIbcCLOyMrmPS5gxM4tW90LDvQoH9debf1FaJwU/3DvEZJ25+YrWdJtbZyq8xjCwaO4UKyRyVHWFWMPWCB4LWBg331TUXkUMP68kQkwFgVrZYLWUA8sONxUtF8/IjbeE7k4J6rNRkaIIhsz55y/wHhipkbW1Z54YTMq8IFvCe3WBqzVyFT1YgDF6T9kKNH5TXmEjYm+vSO0WMc9cQzfbtsQ2MmMN5xZ0YCH6YqRODabA+vG2H+rVH6yXjTRs0761iyQNPmbcOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxeif++4v333BXay8REEPWPy7t8KL2Sr+hu+QTzNkSM=;
 b=TRrwEWxoMx/lsLznchAl2bMT0wL2OjQADJoA1CzBmg+ibSn3/RUI/W+BHkk2l7hK/qgdD47AqG7aaMpZ5VdTO/kMwaa3ZoQwoi0k+BSOzYY2rkwtfVuLmddudh4pHm1wsymQhSr18NLDP5wdZrIGB0Z6X5lFrxUsSYlx3KZ5DqkaZoIRpeQX1g8s9XSszqMZQMHECoIiw4bYaPkXeoNli7qFVCHjYahGqOSwSu5Ds9YvaE6du1pE6GBvFw0dXPI8PqHwWuuRW5AzRv4hUerEDQS3EjZPQxOpqJ5aAKv/4V12r8Cag8uhMLqiuPPQMILGbjEM+f9TqJHOXI0wvIL5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxeif++4v333BXay8REEPWPy7t8KL2Sr+hu+QTzNkSM=;
 b=gFpDYBVf1IyHSZVQEWVweEjbZ9y6EixXgcmobaseJ6KrLLhRmt+VfjKjV4ALJAuCPnX0bFYUz4wyO3TG4TztsOiMpkz0u9pAl5tzpJuMO5YAuOkFzyfUbPALXMfc4OwJS44dELC26SwLic0hTgyIxmXyn6D5SKqTAnrIgHR2DXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYRP286MB4295.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:133::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:11:56 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:11:56 +0000
Date: Tue, 2 Dec 2025 16:11:55 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de, stable@vger.kernel.org
Subject: Re: [PATCH v3 6/7] PCI: endpoint: pci-epf-vntb: Switch
 vpci_scan_bus() to use pci_scan_root_bus()
Message-ID: <kmaxwuo6diytlbtarf7pigl7v5zgslhmgnxhvujfds7kecmxbj@co4oo6lytb3o>
References: <20251130151100.2591822-1-den@valinux.co.jp>
 <20251130151100.2591822-7-den@valinux.co.jp>
 <aS3jxR1YvjWZKYYO@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3jxR1YvjWZKYYO@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::6) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYRP286MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: ab59ca82-521c-4507-30f3-08de31721418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+pIIyQ0M9x6u7WG1VvQymot+/M5Mhn3YUN22fsbHcJH2ljMbE19+rExItV6?=
 =?us-ascii?Q?eXaC8eyWp9Ey9MiY9roVrWaWFFiWUHGkOt3j39R323sCfPjex0doTaXB1cJb?=
 =?us-ascii?Q?sJJgHnxQM2KIxsw1sdttZKdGDdHWRzzkKvh5Dh0J9QbrFubvUXlNMCKt6imm?=
 =?us-ascii?Q?PYUpkgBIZSQOQuvTYveNTjUSJLhUixrAffGRTRnrN17gM7ghLWaCEjDJJTJm?=
 =?us-ascii?Q?KjhCs0yUKcRVAQl3STXP0s6OFamBktaQFgL9lyZnP487hUB5IGwSTHPM279Z?=
 =?us-ascii?Q?LQOjecpIQAxTwiBCWbJuiwzNtukPVlZHDpAAHcZsJIysrNk2fXTRKUhzp7M0?=
 =?us-ascii?Q?o6vToCpQ3tsqu0tcjQryIHb636EYsqRoWOxkXlor87Q7KrVmcdIg8cCgjsT8?=
 =?us-ascii?Q?ccqwqPy2CH9AIc+7sAnG4IPTomQP5UCYAhT7vTMMKWWjNig5mWJfOeYpgYHL?=
 =?us-ascii?Q?MX4i821O/AXYgtJR9mkqhYr2ABg0d/g+orcoe/ieWIh5YZSzT/cSEeCzcaYz?=
 =?us-ascii?Q?z4bEDsw0HRj/d/VG4spd4lYEtFRoYyY/npxPR22U/i3fpPdC3lbnuEZKKEuz?=
 =?us-ascii?Q?mk93paysYmusgGfl1CedQDZxysZwHQjuIuYe1kFBcDHXCvc19Jl9rYiEosBV?=
 =?us-ascii?Q?U4cAmiuj+O9U1J40ibXmmeqa1MgqVX+FdyggZqtVrdJaTIjjEAfOXB362byJ?=
 =?us-ascii?Q?eXqLnRm/ERESwfFK7aACwFlDDcA2Tf/3Z1gx680n6mjui2LzUMeCvFRzx+yg?=
 =?us-ascii?Q?domfqZF3hrXNmhSHzLtOXDbBMNSJW+R6zJP+b5hZkQonBzE3O/BtVA5hRDQ0?=
 =?us-ascii?Q?DPPJ4glwf6GH4IiD26hQJbf3MsMGxE0vzSqN8Fm4Xr16iLZmyELj87w3Vl3t?=
 =?us-ascii?Q?vABvgrz68AWSfmmwM2XTfbK4rXe8EeLTPRSx8bjRQStWsEYt2FlY/5foVUVx?=
 =?us-ascii?Q?McIpYwpFMUEXooGE+E80CdVy2TUOCED0deSmoJzuO9XcT7gcszFmp8RG/1Jm?=
 =?us-ascii?Q?p8+Bqio+kzfOUoLQQSbeBdfbvqEpWPSEdlHhb6HMer4O11kx4gz9zDW34ZLr?=
 =?us-ascii?Q?TfHGYhOnvf3yOEhLGlrDJBWmhnV6kMWyIrdu+w4tM8aGwBfcouDAFpEq4qt3?=
 =?us-ascii?Q?btyTO1TEn4ln12OIgZX+MywT/q2mImrpbgqohI8yBw4GysP/hHBUfMqWHQs7?=
 =?us-ascii?Q?UXC5LyluUw2hzVoL8C1fm0pwbKUkIPALmS/INj0b+1YKs0bp5uFcnO9aZ1KD?=
 =?us-ascii?Q?+rA0JaLG5OhYi76wt0EZzmFCsJGanizj4CTJCcyLQgsiJKt+FQmOAXZxqSQe?=
 =?us-ascii?Q?XuirLM8ZLLbT7TMk+sROVbIHaqVEeASJ4L5eEguhh7i+pDUdYBl3NTI8uTfc?=
 =?us-ascii?Q?9EVBRe8oTw1w5nYIXF8WLm0d2aIJN/XjcJssGd2v60jHdfj2WACvTZfiW9LA?=
 =?us-ascii?Q?KtudMK3zk3ehqdWea9tazainIQZIjJA6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7wlokqLllFxU3hgnMx1ctamtFpGmpGfbSj2/FRNq3EgO+x+v3SRJY/rrPq0?=
 =?us-ascii?Q?egk/iHIibBc8RURQomLoc7U8hR/o1R1AO6K+UD58Z9Ev0xmWy+vatC9M8h9T?=
 =?us-ascii?Q?/wdPeJcD3AuC94DXGhj29f9CmJ2DoKuVBBpSeK0OhogwXHcngttpt4ADvIs5?=
 =?us-ascii?Q?vJr516bokSf5HdN9+s3E1svAcQhHfv7h57mtqIwiH0R+DIzaG4/famrcwGQb?=
 =?us-ascii?Q?wRZUK6NFt0FEfSJO6BA1na6tcYSuq6aQ4ZVRb8P4eLfBEZOGFrGpru52RLHE?=
 =?us-ascii?Q?X3ux2UuocDivoNbuqOqrrDCIwp93EXmdm+2ZJaVh/NWVbs9WVYWgymBuE0uD?=
 =?us-ascii?Q?9b6xW+X1jUSg7mI4bHiFI6GEWkG/gBy/L+F3B+iQmbVOXY/3tO9Oxwq7oP6G?=
 =?us-ascii?Q?8iBEV1bVDMI/TNf7sHuY2x0QigRt5NyDpcOMeQjGzEsaBswWCfsrgDtlyD31?=
 =?us-ascii?Q?er9ssWxE00FSy7BJomXhM/Ko92HRmatem8+qwcNPgk7Oc7JQ+GOMUNcnfDbn?=
 =?us-ascii?Q?O5mfDUumQ+2gz81Sw7IGuUjkP6cJVqJh4c0I8eECSJaNOmM9kMQgxLcQnUHw?=
 =?us-ascii?Q?s1s5mgj+2EYxUl85Z4xMiubiy9QwxRf2dn1CJZjZ7g0PV8Ds1xnXciANbtDv?=
 =?us-ascii?Q?45A8hLPpJ7xvsm4TwHQ3pedC4Rhl9Cx+jOg+mL9irfLpg9Y8YHS7RiqZtdqR?=
 =?us-ascii?Q?47GfeX+yjb+kxIa7WJ0QQB9kXFTYu1M7/KEG302be/JoO926dYWas4vGZwDR?=
 =?us-ascii?Q?sadxBKECLyM0qZUjXmjKS/4cU49AQy/cFgHOJTILnqmrE3cY5LO1ngczOWUN?=
 =?us-ascii?Q?U8ramTUzc148KqUbI3IZ/cqH+K8O3upo0Am3kQZd036YaEflqpEVbfBJ05ju?=
 =?us-ascii?Q?DOC37dXaGYbkLn8yiL5WCmhtF7Ayee669Lg8zj7iVAl+2/olTKS+5OOi0ja9?=
 =?us-ascii?Q?GQBO/KAEw6ykDp60PuxeRcooUmKJChQQm/Sk4JtdkomzYSJTjYCs8dfKZfSO?=
 =?us-ascii?Q?HQzjSVTSjQlnpC8uLtVn7JgG3g4u3PP/BXzV250SARra3g/cwaXLAAU7HSmw?=
 =?us-ascii?Q?u+iznM0KKjAtKYX10YHLL25j/23mGI0XBLkhNuQKfdPvj6Wf2tHFGA/QpnmS?=
 =?us-ascii?Q?r3ssuSw+VIHeXiNKo7m2bsOtbIlI9d34fYwfLHYCQ5qBg4caNYT7AgHocetS?=
 =?us-ascii?Q?bEFolO2RgMsWsPPZOVe3IJqPW4gDHiUEENhhswRfJN2mDAVkQEksEvgJGSlD?=
 =?us-ascii?Q?WU3UVJKETohZNBq3rNXllhFvsqvWFfDaG9y/M2ONUWDjP2Z/RAWFhcP24S0h?=
 =?us-ascii?Q?pGVsXQDQPQYNsK+qDg34Tb9mrNG2EVNgEj3nrKmgKXKwFmH6xno5AG9rt6j7?=
 =?us-ascii?Q?g+BHQ/g8j9XArpOymIvN4hLdFA+ieQ7YB85W0Nzr4Iy7tWzzW9Cj/ULuOzYg?=
 =?us-ascii?Q?bYtEjoXK46EFofYxYIyFdKIiHJhpIyh5Mzb9cymRD+VW3CRDJ65fsPMcy6Yq?=
 =?us-ascii?Q?o4SSxaYNbJA+FAkRRG7bJGCrTi7eRhq6tmCaTPeNpOIFnR09TiFADbmzy2Ax?=
 =?us-ascii?Q?8yRL8DVDhwULjpByZawmmuyaV2F/xOwNH1ArSOohvygVwst8l7Hy7vnRrVFR?=
 =?us-ascii?Q?U3WOl4N8WxcV0TuS9d896ls=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ab59ca82-521c-4507-30f3-08de31721418
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:11:56.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qiXR/WsUVBgSis7GWYztrQFWspUOT2kL3ol9fmBs28A+bNjPG2HD+qLQVDtfPQqhQA5TnI+liq4T+lfVvL+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4295

On Mon, Dec 01, 2025 at 01:51:49PM -0500, Frank Li wrote:
> On Mon, Dec 01, 2025 at 12:10:59AM +0900, Koichiro Den wrote:
> > vpci_scan_bus() currently uses pci_scan_bus(), which creates a root bus
> > without a parent struct device. In a subsequent change we want to tear
> > down the virtual PCI root bus using pci_remove_root_bus(). For that to
> > work correctly, the root bus must be associated with a parent device,
> > similar to what the removed pci_scan_bus_parented() helper used to do.
> >
> > Switch vpci_scan_bus() to use pci_scan_root_bus() and pass
> > &ndev->epf->epc->dev as the parent. Build the resource list in the same
> > way as pci_scan_bus(), so the behavior is unchanged except that the
> > virtual root bus now has a proper parent device. This avoids crashes in
> > the pci_epf_unbind() -> epf_ntb_unbind() -> pci_remove_root_bus() ->
> > pci_bus_release_domain_nr() path once we start removing the root bus in
> > a follow-up patch.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 750a246f79c9..af0651c03b20 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1098,7 +1098,19 @@ static int vpci_scan_bus(void *sysdata)
> >  	struct pci_bus *vpci_bus;
> >  	struct epf_ntb *ndev = sysdata;
> >
> 
> next patch's remove empty line should be in this patch.

Sorry for the noise. Please let me send v4.
Thank you for the careful review.

-Koichiro

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> Frank
> > -	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> > +	LIST_HEAD(resources);
> > +	static struct resource busn_res = {
> > +		.start = 0,
> > +		.end = 255,
> > +		.flags = IORESOURCE_BUS,
> > +	};
> > +
> > +	pci_add_resource(&resources, &ioport_resource);
> > +	pci_add_resource(&resources, &iomem_resource);
> > +	pci_add_resource(&resources, &busn_res);
> > +
> > +	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
> > +				     &vpci_ops, sysdata, &resources);
> >  	if (!vpci_bus) {
> >  		pr_err("create pci bus failed\n");
> >  		return -EINVAL;
> > --
> > 2.48.1
> >


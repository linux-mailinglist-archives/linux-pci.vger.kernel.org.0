Return-Path: <linux-pci+bounces-20162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAECEA170F2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7A27A353C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663031E9B1D;
	Mon, 20 Jan 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="igppPBED"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5141494CC
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737392527; cv=fail; b=fbA+TErN6OgtshqzB/+7Wxh4GO37l2cVvFvjJmzIlJNKq/HXHjP58LEiVoHN7uLyoUiztALOjznqVb36/FEU9++CSDq+lpla0RBjnbPvWO7c+b34TpswuA8DExdwTN1s/lbTqN+XXoPrc5NsnUSRPac2gYfBvcyQugCky7JPivU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737392527; c=relaxed/simple;
	bh=mxEqknYDJp8vE1cHHSEDWbyTgrqdMaLx435lDLbi5P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JrjLlt+Y+1XgVZbN3C0dLDvoS0YJ9w2MRlbfSBiF3uLxpZnapexJSPTdK4jzrFvVx2FahllZ6qbZ4EAFLztRKe0P+Hy3qP2S0ZgvNk6a0O0yMl+LwiAWC9NuyzKDhw++uUSHIRGKX1sJaucB80ZIH1VGTF8aCL3vSB+7LITZjr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=igppPBED; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sza/7+krqLCbGpoy9znIZndyi73GeL7E3n73ViNivCMaBx50a+GKzlAN/yyH+aC8z+raHNLRH/wHT/I9OI2mixMyRO+fQaDIbZc7azUc2tgu32j9KLZ5oZTApmsB/LELWQMHGOnill/eGnLQFAGeUNxFd7+mm/3uKsP/pyUWmUwWiGqWWDThE3+vvPxvNvj2vTV7p904rVGaqmojjqWUkLIkFohpog7HKSG321LLr4asLPbIWfyQK8CuQ9Fcxrrk4QzAwFo94JYDL8Dip/9SdomWrYujs2sm9Jxei4X6AYHbpvIyZhRlFI1W5FSW9tikkl8A3wvwVurKkU9zKLQfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9znjdx3P1PwMP4Gixea48d3LPCkhd610BENAZn2Pbjk=;
 b=oayYqg5m5NB0H17m5dsNY/Btv9iUbtIgnBP2ZpNiU5tka/W68ARoIvEsRDXpOCngiHOwIpkz9M1O2oVFpPgCLulPCxyjW1ccgTYhqwC6OgPhr8XsxrbBuulEkfqSjUly+f9LWjrUcdI1NibbHOngBc8dDSCDaQV8fq9q7yoLziCODeWF3hZfmPP1zNPqo3Y3dQ9wOyiAooMXYMmgIfUnkF/C+YF9BRaVw0h+5/Nq1pf829X0YKKFwByG7VOo+w6l8iWbsKbOppPxiJgQcgg2Vdy60/hDPjsy8zlrRaxbmcRBhqI3ZBJNRxm6XAjWhmf11JVIbP2rgv1Ffb76po/Clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9znjdx3P1PwMP4Gixea48d3LPCkhd610BENAZn2Pbjk=;
 b=igppPBED8U0dOb10h7MoB6EB2toRE9ix1AZtv7+4ILXygkGHpm+Hcrw1Ly+ZH6EigHptvKIa0yzcdb7K7k00ArFx17v0GEEorFxlIrUA4gBNuayZ9rbfHZ96+TBvADPQssGj3CSD2X+dwYzvDmAq9RvC14mm/miIgGcfPKs8irKt5DXDcPWHdnuIyD8lMxgnpJq4yaSJ1ZIxmRnVcptiYG3LN8ncWnKvE78pF7q8P7mD7JsrvEV4aO7EDs6fqIgJh50nnXjvpFgJ67z13pVDoUo4/XQX4Orj7IcArl53337Aey/HGMyqvfOiqa89d6GISSN/IOThrzkGSZLeQ+3taQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7111.eurprd04.prod.outlook.com (2603:10a6:20b:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:02:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 17:02:01 +0000
Date: Mon, 20 Jan 2025 12:01:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Handle endianness properly
Message-ID: <Z46Bgt9i3TQZcoTA@lizhi-Precision-Tower-5810>
References: <20250120115009.2748899-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120115009.2748899-2-cassel@kernel.org>
X-ClientProxiedBy: SA0PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:d3::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbfefd7-dd7e-4b5a-65f3-08dd39742860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zmDNndDQhYYiyx2OS7fHQhpM6ys9vUALT0M/7uNCJ7mwx3+B8Ktqg44W5T4Q?=
 =?us-ascii?Q?UHMQnL0HBIhoKb1qVXNKwJ1NBMCXohN6btXGcMbCqVorrgmpTA9lEhCe3tBs?=
 =?us-ascii?Q?ESe1vuUPw5DNlVfmeVdrvXXYx6if2k5PtKs4Hmv+XcIBAb7TlWyUosJvVOHB?=
 =?us-ascii?Q?f4fWZKQiBx5qG2K8jNlpB5odOkD4Sq8v5ilEryh+vRbbGe/7tHxtybDdtppQ?=
 =?us-ascii?Q?W6zl8P2qSPQy2YPAe6dvv7+49/ThC0h5tWOipVv0t4PSmaZUgJn2PhvWPe+J?=
 =?us-ascii?Q?l+5X4evpfFV9QEBXQhI2AEAf0bt1ytbTSUoEptwtgFKnCYZUPpiZn+RC8JmG?=
 =?us-ascii?Q?VjGm2fkLkn4EyWnP6zvI3zOItiS0RZp4WR6nRL2YsprTUH9u2fLJjLKSpwfb?=
 =?us-ascii?Q?cbUbb3NqO1FzXxy7KPn/XTF0asIyXkjn76vEYXWfqSYVTosBHE3eyTvBObTu?=
 =?us-ascii?Q?EiLut+eqmGK0jLSk4BT9IMPjOIg0eXanoCwklWvKw6sLk5sSGssKgCV3YWyg?=
 =?us-ascii?Q?Js81xvkkVmMUSTQO8yZMuAspc5tlC70ND0kzFWkT0j2rSf2q3rarSVCPpeny?=
 =?us-ascii?Q?qJ1NSAKWJTZGv5lxbuScFAy8irfDbCE/GFh+I2kfjtkh/MzBIYdQPz/nJQ12?=
 =?us-ascii?Q?UIDyWi4Q6qr1lBUi89oldQyhRfrCnipkhUBxqcSe3n/7AsaEPb3E3nFQ6IuX?=
 =?us-ascii?Q?VvIFaqhuCC8CjSTLNdj0igGyRz6wSgBQ4RiFkj7cAV6ExPaR8n3CqlYBEfCx?=
 =?us-ascii?Q?VP2OQsFUQKV5cZ8tYIQWrqxI1/UA1GIwjvoOWbr30kDCwErt3G17wXpZeYAH?=
 =?us-ascii?Q?zdizOOJ4leeHTSjxmkydGZarLI5gkMkqj+FO9TtzRkEFo9XzlySuc99BUMlk?=
 =?us-ascii?Q?n1Bdbs2gSZruGyxM4Re0fuGh9e4yhPxChkjX66jYryTgtnMIOjuV+oV/hUCQ?=
 =?us-ascii?Q?laY7Vf3OCP6B+cL49jxF1m26O/rcZJMWg74VxILIAKVelzEnQCW0OssG9EaD?=
 =?us-ascii?Q?iPwX0ZPKag2XTgXThmuYkHx55l1WEeMueucbp6viSuqni0jok1eI6uMGEo/U?=
 =?us-ascii?Q?LbJNVlY5SsQqo2bjPcEDxuS1p3K86TjcyBKiw2LTiEpi5k2VAfpC+w1zXt1l?=
 =?us-ascii?Q?udAX8P5EUlI8w7GYNM0beT65d84lGWSkY+kaN/t67vy7vkU4IbxG5PqAbH7m?=
 =?us-ascii?Q?PtVNcs+qoVHZBi77mka+00BFqUumagApSQqbilCw1isAz/vRab5bDeqWMkb+?=
 =?us-ascii?Q?oWgQ/SZidPsiaeV17WFxJ6KgHj/8gzRtnORyv38o4QCGokF8tgAktZUN4E8b?=
 =?us-ascii?Q?ezUHutndWnks6J54PHZhlkbpzcI5eVpHA/1C2MErOmSqhZ7yTd7XeNw5Pf0T?=
 =?us-ascii?Q?gNCc32AoVs5J+wi1retGwov2qVUKp6M/yvgqy0psjyGgbj23HKs/az2ptqmz?=
 =?us-ascii?Q?LyGDIeWo/KzSK01HlNNbGNFp65LRh3gG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JhdoLewp8QxhT5dMo1YJj1jKG2ccmdDvgnrTaZuW/Z9bcykSDF/gFZBLPXay?=
 =?us-ascii?Q?fSkriVpQ2Kqtf0OyL57jx4eBq8UEjCs6mazwKHqbRJ1+khc3y7A67WGuq/z6?=
 =?us-ascii?Q?xLsPBQFFp86UCoLxpR0u+kefp7+8CM6RGelrD1sbIREAccFvTCZPHpZJxR1t?=
 =?us-ascii?Q?gKIFxjeHsOsFtSbIOEggCNLK2xT4pXzYPfjMre5R6mtuN2ce6helkMVKrZi9?=
 =?us-ascii?Q?iO+kUatTcAoGb7HvZjnGfWYfXnkRs/NTmUUekCMqlyn9vftCfnhG3ea+xy78?=
 =?us-ascii?Q?i5GFU4gQbqowKAAmKR5+OnkNANf9pnDjYhDsAE4SRTyuRGNEwJw9nZINz1dc?=
 =?us-ascii?Q?2IggHeQmYBWToPZxKtj1vp0MPBtxoYDTNC+ZKuGHOa/zOdrhgOY9vIVmSKxC?=
 =?us-ascii?Q?5++jG6eDsJHKYRMNy9PdybYNv2Fe1wkKwVSQp96xwCaGoyq3pNORBs/wKdn3?=
 =?us-ascii?Q?Zu+Xef7NVoMPzpPlJHag59aLi2qcPrlkuPv8UE/C3cF71jEoZXodFH45x40/?=
 =?us-ascii?Q?AhqtP/dg5ktqj1Q3y/RAPC5NwyXcqXvk4kzHVlNzMp3Cpo5xAFn1rxQ7+vxx?=
 =?us-ascii?Q?JCx5dQFu6NzTc0gA7iG9cwXtJKNvPQDlqfCi6VcMgOQgmwKkfpjVWE+cC3Ju?=
 =?us-ascii?Q?ullP+QdtvxgEIDLxdhXIH10owTC82P4iCtXo3KG/NyuyhkoTU/TBpqodxqO4?=
 =?us-ascii?Q?4rJYukYv7aEp5t/Ynto04T38wQoytFOym6zIIATN6wW4AhGDYq1yWsFxWnjW?=
 =?us-ascii?Q?5fOvcDdi2veHkOPGdUU+vEA+YgBHRFINdKGee8aog3BoJgZhZplxY5aM8pR+?=
 =?us-ascii?Q?v+bmi41gnuxTrltGH97vXnCP5t2PYE8KXdU4Tx0+UbOpY1Ok5d8YNx0AbR5x?=
 =?us-ascii?Q?uC2rIWV3HJ9qFdbTgENBROScbl3cltd0fFFSGJwOnojnmwRyJPTHOJGn06Tz?=
 =?us-ascii?Q?JIWNdcT3nFH8pfTFtOiwb0T5U/VoR6wQDrMgLvKuORVy42o7UwlT5jKsvYpe?=
 =?us-ascii?Q?uKxNOL/SGIVsIOiA3/D/IPLf5KDsHFYez6vw+p6VYJeDEwM9GF4oBoj/ObgO?=
 =?us-ascii?Q?Vu6gfUJO6v5FSep0nICOORVle5weEaqFTWWtxSWLBXBH88aRd+jBE1fouZSe?=
 =?us-ascii?Q?XfnEFXsRwltFbnTq4WEXPFioZsMxyEPcIa9l5LwvzcMYndO3BffTYX0DzxsE?=
 =?us-ascii?Q?Vri4oTjYglx7jSDjdKM1yuJBZ65tjG4zeEyKWtt+cbkGsk5fIuDca52rES2u?=
 =?us-ascii?Q?5TZn3wBfXAVipjEh5eCjZC6+/b6Uy1BHYXF66jEK6rPxtmYOIHkwwrTA7692?=
 =?us-ascii?Q?xhZEp6/cQXDAJimGWNEpeGFhUk5PKV/XSZYlx9KYVVtCn70pS4PcRA7Mvc4X?=
 =?us-ascii?Q?C0+6DH9OrKkc4qO+fSqxUlj/UcqfasXGvbWop8ui4O4A5vFSYT7oabexbuuI?=
 =?us-ascii?Q?3MwKB1BDyaxxMik2h1w9F/psxhcMfbMLf26sAOQCMUQyGL31CQewJu3YZvP0?=
 =?us-ascii?Q?MieUWrY6TlXS0T5TafgMzarjam1uYQEHtOa0B+EN6nsW/wgrBxA1xstnoqLv?=
 =?us-ascii?Q?JdI158YXIddD+7ZLJp4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbfefd7-dd7e-4b5a-65f3-08dd39742860
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 17:02:01.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtK9c1z2T1W83SENakzHoWWmj6w5nkW5tbZmkRqvu8tOxNpLzU+c+nE4INbvOAxrEkNPLGvn1r1aPQ1OXMxkIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7111

On Mon, Jan 20, 2025 at 12:50:10PM +0100, Niklas Cassel wrote:
> The struct pci_epf_test_reg is the actual data in pci-epf-test's test_reg
> BAR (usually BAR0), which the host uses to send commands (etc.), and which
> pci-epf-test uses to send back status codes.
>
> pci-epf-test currently reads and writes this data without any endianness
> conversion functions, which means that pci-epf-test is completely broken
> on big-endian systems.
>
> PCI devices are inherently little-endian, and the data stored in the PCI
> BARs should be in little-endian.
>
> Use endianness conversion functions when reading and writing data to
> struct pci_epf_test_reg so that pci-epf-test will behave correctly on
> big-endian systems.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 126 ++++++++++--------
>  1 file changed, 73 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ffb534a8e50a..c1359f3662ae 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -66,17 +66,17 @@ struct pci_epf_test {
>  };
>
>  struct pci_epf_test_reg {
> -	u32	magic;
> -	u32	command;
> -	u32	status;
> -	u64	src_addr;
> -	u64	dst_addr;
> -	u32	size;
> -	u32	checksum;
> -	u32	irq_type;
> -	u32	irq_number;
> -	u32	flags;
> -	u32	caps;
> +	__le32 magic;
> +	__le32 command;
> +	__le32 status;
> +	__le64 src_addr;
> +	__le64 dst_addr;
> +	__le32 size;
> +	__le32 checksum;
> +	__le32 irq_type;
> +	__le32 irq_number;
> +	__le32 flags;
> +	__le32 caps;
>  } __packed;
>
>  static struct pci_epf_header test_header = {
> @@ -324,13 +324,17 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc_map src_map, dst_map;
> -	u64 src_addr = reg->src_addr;
> -	u64 dst_addr = reg->dst_addr;
> -	size_t copy_size = reg->size;
> +	u64 src_addr = le64_to_cpu(reg->src_addr);
> +	u64 dst_addr = le64_to_cpu(reg->dst_addr);
> +	size_t orig_size, copy_size;
>  	ssize_t map_size = 0;
> +	u32 flags = le32_to_cpu(reg->flags);
> +	u32 status = 0;
>  	void *copy_buf = NULL, *buf;
>
> -	if (reg->flags & FLAG_USE_DMA) {
> +	orig_size = copy_size = le32_to_cpu(reg->size);
> +
> +	if (flags & FLAG_USE_DMA) {
>  		if (epf_test->dma_private) {
>  			dev_err(dev, "Cannot transfer data using DMA\n");
>  			ret = -EINVAL;
> @@ -350,7 +354,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  				      src_addr, copy_size, &src_map);
>  		if (ret) {
>  			dev_err(dev, "Failed to map source address\n");
> -			reg->status = STATUS_SRC_ADDR_INVALID;
> +			status = STATUS_SRC_ADDR_INVALID;
>  			goto free_buf;
>  		}
>
> @@ -358,7 +362,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  					   dst_addr, copy_size, &dst_map);
>  		if (ret) {
>  			dev_err(dev, "Failed to map destination address\n");
> -			reg->status = STATUS_DST_ADDR_INVALID;
> +			status = STATUS_DST_ADDR_INVALID;
>  			pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no,
>  					  &src_map);
>  			goto free_buf;
> @@ -367,7 +371,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  		map_size = min_t(size_t, dst_map.pci_size, src_map.pci_size);
>
>  		ktime_get_ts64(&start);
> -		if (reg->flags & FLAG_USE_DMA) {
> +		if (flags & FLAG_USE_DMA) {
>  			ret = pci_epf_test_data_transfer(epf_test,
>  					dst_map.phys_addr, src_map.phys_addr,
>  					map_size, 0, DMA_MEM_TO_MEM);
> @@ -391,8 +395,8 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  		map_size = 0;
>  	}
>
> -	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start,
> -				&end, reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "COPY", orig_size, &start, &end,
> +				flags & FLAG_USE_DMA);
>
>  unmap:
>  	if (map_size) {
> @@ -405,9 +409,10 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>
>  set_status:
>  	if (!ret)
> -		reg->status |= STATUS_COPY_SUCCESS;
> +		status |= STATUS_COPY_SUCCESS;
>  	else
> -		reg->status |= STATUS_COPY_FAIL;
> +		status |= STATUS_COPY_FAIL;
> +	reg->status = cpu_to_le32(status);
>  }
>
>  static void pci_epf_test_read(struct pci_epf_test *epf_test,
> @@ -423,9 +428,14 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	struct device *dma_dev = epf->epc->dev.parent;
> -	u64 src_addr = reg->src_addr;
> -	size_t src_size = reg->size;
> +	u64 src_addr = le64_to_cpu(reg->src_addr);
> +	size_t orig_size, src_size;
>  	ssize_t map_size = 0;
> +	u32 flags = le32_to_cpu(reg->flags);
> +	u32 checksum = le32_to_cpu(reg->checksum);
> +	u32 status = 0;
> +
> +	orig_size = src_size = le32_to_cpu(reg->size);
>
>  	src_buf = kzalloc(src_size, GFP_KERNEL);
>  	if (!src_buf) {
> @@ -439,12 +449,12 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  					   src_addr, src_size, &map);
>  		if (ret) {
>  			dev_err(dev, "Failed to map address\n");
> -			reg->status = STATUS_SRC_ADDR_INVALID;
> +			status = STATUS_SRC_ADDR_INVALID;
>  			goto free_buf;
>  		}
>
>  		map_size = map.pci_size;
> -		if (reg->flags & FLAG_USE_DMA) {
> +		if (flags & FLAG_USE_DMA) {
>  			dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
>  						       DMA_FROM_DEVICE);
>  			if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> @@ -481,11 +491,11 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  		map_size = 0;
>  	}
>
> -	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start,
> -				&end, reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "READ", orig_size, &start, &end,
> +				flags & FLAG_USE_DMA);
>
> -	crc32 = crc32_le(~0, src_buf, reg->size);
> -	if (crc32 != reg->checksum)
> +	crc32 = crc32_le(~0, src_buf, orig_size);
> +	if (crc32 != checksum)
>  		ret = -EIO;
>
>  unmap:
> @@ -497,9 +507,10 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>
>  set_status:
>  	if (!ret)
> -		reg->status |= STATUS_READ_SUCCESS;
> +		status |= STATUS_READ_SUCCESS;
>  	else
> -		reg->status |= STATUS_READ_FAIL;
> +		status |= STATUS_READ_FAIL;
> +	reg->status = cpu_to_le32(status);
>  }
>
>  static void pci_epf_test_write(struct pci_epf_test *epf_test,
> @@ -514,9 +525,13 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	struct device *dma_dev = epf->epc->dev.parent;
> -	u64 dst_addr = reg->dst_addr;
> -	size_t dst_size = reg->size;
> +	u64 dst_addr = le64_to_cpu(reg->dst_addr);
> +	size_t orig_size, dst_size;
>  	ssize_t map_size = 0;
> +	u32 flags = le32_to_cpu(reg->flags);
> +	u32 status = 0;
> +
> +	orig_size = dst_size = le32_to_cpu(reg->size);
>
>  	dst_buf = kzalloc(dst_size, GFP_KERNEL);
>  	if (!dst_buf) {
> @@ -524,7 +539,7 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  		goto set_status;
>  	}
>  	get_random_bytes(dst_buf, dst_size);
> -	reg->checksum = crc32_le(~0, dst_buf, dst_size);
> +	reg->checksum = cpu_to_le32(crc32_le(~0, dst_buf, dst_size));
>  	buf = dst_buf;
>
>  	while (dst_size) {
> @@ -532,12 +547,12 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  					   dst_addr, dst_size, &map);
>  		if (ret) {
>  			dev_err(dev, "Failed to map address\n");
> -			reg->status = STATUS_DST_ADDR_INVALID;
> +			status = STATUS_DST_ADDR_INVALID;
>  			goto free_buf;
>  		}
>
>  		map_size = map.pci_size;
> -		if (reg->flags & FLAG_USE_DMA) {
> +		if (flags & FLAG_USE_DMA) {
>  			src_phys_addr = dma_map_single(dma_dev, buf, map_size,
>  						       DMA_TO_DEVICE);
>  			if (dma_mapping_error(dma_dev, src_phys_addr)) {
> @@ -576,8 +591,8 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  		map_size = 0;
>  	}
>
> -	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start,
> -				&end, reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "WRITE", orig_size, &start, &end,
> +				flags & FLAG_USE_DMA);
>
>  	/*
>  	 * wait 1ms inorder for the write to complete. Without this delay L3
> @@ -594,9 +609,10 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>
>  set_status:
>  	if (!ret)
> -		reg->status |= STATUS_WRITE_SUCCESS;
> +		status |= STATUS_WRITE_SUCCESS;
>  	else
> -		reg->status |= STATUS_WRITE_FAIL;
> +		status |= STATUS_WRITE_FAIL;
> +	reg->status = cpu_to_le32(status);
>  }
>
>  static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> @@ -605,39 +621,42 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> -	u32 status = reg->status | STATUS_IRQ_RAISED;
> +	u32 status = le32_to_cpu(reg->status);
> +	u32 irq_number = le32_to_cpu(reg->irq_number);
> +	u32 irq_type = le32_to_cpu(reg->irq_type);
>  	int count;
>
>  	/*
>  	 * Set the status before raising the IRQ to ensure that the host sees
>  	 * the updated value when it gets the IRQ.
>  	 */
> -	WRITE_ONCE(reg->status, status);
> +	status |= STATUS_IRQ_RAISED;
> +	WRITE_ONCE(reg->status, cpu_to_le32(status));
>
> -	switch (reg->irq_type) {
> +	switch (irq_type) {
>  	case IRQ_TYPE_INTX:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
>  				  PCI_IRQ_INTX, 0);
>  		break;
>  	case IRQ_TYPE_MSI:
>  		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> -		if (reg->irq_number > count || count <= 0) {
> +		if (irq_number > count || count <= 0) {
>  			dev_err(dev, "Invalid MSI IRQ number %d / %d\n",
> -				reg->irq_number, count);
> +				irq_number, count);
>  			return;
>  		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_IRQ_MSI, reg->irq_number);
> +				  PCI_IRQ_MSI, irq_number);
>  		break;
>  	case IRQ_TYPE_MSIX:
>  		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
> -		if (reg->irq_number > count || count <= 0) {
> +		if (irq_number > count || count <= 0) {
>  			dev_err(dev, "Invalid MSIX IRQ number %d / %d\n",
> -				reg->irq_number, count);
> +				irq_number, count);
>  			return;
>  		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_IRQ_MSIX, reg->irq_number);
> +				  PCI_IRQ_MSIX, irq_number);
>  		break;
>  	default:
>  		dev_err(dev, "Failed to raise IRQ, unknown type\n");
> @@ -654,21 +673,22 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	struct device *dev = &epf->dev;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	u32 irq_type = le32_to_cpu(reg->irq_type);
>
> -	command = READ_ONCE(reg->command);
> +	command = le32_to_cpu(READ_ONCE(reg->command));
>  	if (!command)
>  		goto reset_handler;
>
>  	WRITE_ONCE(reg->command, 0);
>  	WRITE_ONCE(reg->status, 0);
>
> -	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> +	if ((le32_to_cpu(READ_ONCE(reg->flags)) & FLAG_USE_DMA) &&
>  	    !epf_test->dma_supported) {
>  		dev_err(dev, "Cannot transfer data using DMA\n");
>  		goto reset_handler;
>  	}
>
> -	if (reg->irq_type > IRQ_TYPE_MSIX) {
> +	if (irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Failed to detect IRQ type\n");
>  		goto reset_handler;
>  	}
> --
> 2.48.1
>


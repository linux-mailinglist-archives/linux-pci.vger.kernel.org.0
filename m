Return-Path: <linux-pci+bounces-35692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ECCB49BF1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F701BC6C4C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F592DCF58;
	Mon,  8 Sep 2025 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cUwEY77h"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B52DF703
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366938; cv=fail; b=iydp8cl7uAqwNZwvtz9CzRQ1AySot4jhxeeVvEeMQu0L+7RcfmCqAFUdHtTDfwTpjxwOvyJjPFjBOKxu8ZEHyYYYWkvt3Ech7p28CacxjDVyF2j1tN3vxNDdIE6O5TP1X0/UZ8bmpFL5sVYfkK01OwSeAgg32sIRnJFI3DtCtuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366938; c=relaxed/simple;
	bh=dXHJtJYVEwTtqIkBOEIQSF6HERoaT81DJ79Px838FP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rGbVbeatUlQZNVgNySFRQw8YexaQgcdTdzOgsuPc+efyA8SPb7s6QxkfltBM0raHTtX86EYpuZoOI3xBuEh+ovAhX1wBNm9I0HAgFIS72LE4jRGgfyZTrDigDHzwXjs10byby0/+12APhwNQHE/txT7HQkU66uTcKhTtCCJ8rc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cUwEY77h; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQbQmJm4Now3f6xXKw719JX8HGwHeSI89etXYXKeHthzAL4Y9rhoKVE7XATfXRsKM8kDXS2CSvOgpFYt4Y/8iKIYGI+egx5cXIE8mAIDuC7CvLhQpOVVSdeWVBJVhsfyb+88LD5yR/nmdI1h0y0aVFdNJ7ipuds9eZtObtqB+aZaS4KPFgcsSq8+inEcxtPxi2ENqheQdZPTw3iFus3DldL2x5T9LUSXWDC3mqu7Uuy4c02vTX1jnrW/M6lij42A/Lt0lwWj7kn6F5ifeYInR70VfUBsjvmP2K/VF7TolbKnSjJjbevJ6++rekDLN3VSwYNEH48cvTcYEdjIzL/bLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZkhfQfkKzbYxtCPTGtNPPHVtrxufgor8l7/otNibpg=;
 b=PrUPyatXbCgQJH80wSqiOOZWGd4j/MhoGH0u4VEsH3Uo+kseq0jq9pHjoCqU/d4+8yv2RBWYDZKCVkTEwUFfEr3yrtSnJInJJcDarydh6b92lMLJxwAMX9VdrV/GuUG0p6dGiefTYGP6i+P+FsbtWi5lAke6wCz3uwtAULz0Uwo0y695fuJcgXvvB+HEQxPDT8f4v8MWMblzUaMq3pA5aEw2MeW2CT39ycpRljwiiolZRp6/9sIt+d0LcY5U1aALgvETK/BLybqWZzBqPBuh4yydHjT8yiDjZuUobefZ1nptlze3zVHFGrQOVNZ9FqPAm9sEkB9XIo+5+LNs6iySjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZkhfQfkKzbYxtCPTGtNPPHVtrxufgor8l7/otNibpg=;
 b=cUwEY77hXbzNAXmOHhKKfGMYcCs8e0eglUjDlXf5S4odJpP4M2vJJ6oSEEitJKYpQxQprzrdZINlU7QTjCT9VLGBDHnNHdP1NXvRPULWSX95NNYJ7/EgpeED0mlcGDkq8yMzO3y8cE6q+Ufwt2rtUT4Nfn++Ovi4ZEfmp4P0f8b0bc46NivRjWYTXCIWCgW5lc2q0bGVDHOURy+S8ykyQAIeYwO+3NVosKC+9JAjyYkc7u2HPBK83AQnhqki+yN3spw4Wg/VvoSUF7oUxf7QMaDwz/n6grPtLILsbLjXYKf39meqBW2ILxAIFwIwUb/xtmeMpn5RxX9s83pN67BXgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM7PR04MB7016.eurprd04.prod.outlook.com (2603:10a6:20b:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 21:28:54 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 21:28:54 +0000
Date: Mon, 8 Sep 2025 17:28:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Fix doorbell test support
Message-ID: <aL9Kjx/3fUs0bL2Q@lizhi-Precision-Tower-5810>
References: <20250908161942.534799-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908161942.534799-2-cassel@kernel.org>
X-ClientProxiedBy: BYAPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::37) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM7PR04MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dede479-538c-4bb7-da63-08ddef1eb617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1So6ipiwJUykWJU1QGyAnqxGWIv/mqBMJQN52UDjjPEjnUEMjBL7dubbpn1?=
 =?us-ascii?Q?+IuqePzuvD9o2RnivmafF6SONBj4qEa7i/vqfsvYv+ER/kT8jaUBuMewrU5l?=
 =?us-ascii?Q?ErTdEQz2Wfkdx9g7mlG5QeiN09+rtY1ZfuTWjEwmpODxvRy6u9PRvkucdFSD?=
 =?us-ascii?Q?55LTt/60n4pObxYwYNXeRwj1o2w+zqGBhI+rSzr4X7FaKqgLAsoJ/OGqXfHx?=
 =?us-ascii?Q?SUgxNfEzp7G7Jw8i7T/nj/DezLVQzvA4ybHhysJ0lqvNpYudnMEonA6qUmAV?=
 =?us-ascii?Q?wMLLin858Qftjr3exBqkCfw9Mpeirct42relXHaOq071e/uwrv5P6wS5Brzf?=
 =?us-ascii?Q?klZtsLwjvME0ohwXBgwhPAUjK7MCNGBMTGrVqHBQnaLXblY0rEQ0U3oAvPHg?=
 =?us-ascii?Q?0XaJSQ97b0MYWDaN9nSSO+49taS/a56Eb/4wGGddjtm2IqMifDK7SvmVREm8?=
 =?us-ascii?Q?TXhoFEZao9zk5JF3oapFHK7jcyjs5+IUUzvsykR07McA27FpsMQCxT5ECuxU?=
 =?us-ascii?Q?Aqcvu5PNvrKfpHqFU2na87xSnNCt8qnInbQBrB8nFFEHRpPnAw6rMwxZxB7+?=
 =?us-ascii?Q?hu4y27K8UytZm0VeTtNC+2ygDkK4k648kd0Sa7hzoYxMndC2OQxEgaH6SgGw?=
 =?us-ascii?Q?+mGUNsL8uDXQUzVUAvX0VSiAeXPjRKuC6dcaKKZrPiCivsuwAbqwF3ZosCO2?=
 =?us-ascii?Q?V9kw9FhZBVzQpHLju2ANqHEYgTmMIKHLCpUjSArbzG2ZhsD39E953IwcehbC?=
 =?us-ascii?Q?2l6A112qCxc8bFrCVHcdJz5RR91owv/4kfX+JbvUtPhfsWSx7WFPw4DZ5+Yf?=
 =?us-ascii?Q?cuIppOirbXYqXVhy/onOsD45h8AtWthyGPeYsXwR+GffNORRVwy1PbSrpelt?=
 =?us-ascii?Q?L7VMAiJi8qARCFEPTa8mSxWwecsP9auRGjIJTkittAX4rvQoXo2RDfbP/5zE?=
 =?us-ascii?Q?BK4CfEJcAzOdRYgS+n5zJSUkbmNW20f1XxqXfarYwMsTgrVXZUPubdCABLjS?=
 =?us-ascii?Q?2bASkb4wucJGjf9b0EIWWreuffOCBZwTg2Ox10bsp0uU4X7WJSCG8YEmkwy7?=
 =?us-ascii?Q?YJbHREXSbFv4lqWgJ1dJML9NHwvvqSzByemhPA5/YHWTLFwpqCNGmdvztsap?=
 =?us-ascii?Q?MuIFsNW5BFl2duu86ejX9J8YfbjOvxWGPZETWElVDXaLzOuUNCw8LdqprrFX?=
 =?us-ascii?Q?9q2uVWmm+37E6k86IPpT6o/pPFUEgH0hKxq5vIHBysQ6VRkIdhpjIdUbgJNu?=
 =?us-ascii?Q?3raitkiFNNXPitRGClJfKS6K9SZe0K4X4nrYlewtpJxm+6g6qTi/eVMVISEz?=
 =?us-ascii?Q?8U2r7FY1ED7kt/WZtbkomF0KehnqJNU/6e//0FvPUmKLZhoFwOew4CApWhNz?=
 =?us-ascii?Q?7S3qTNPez4qqB8lHMp1N5tvCt2G+fUiX1ubG2/h0Ox1jnhMfP3iX7KAPakGu?=
 =?us-ascii?Q?W8KqTcerH9hKgu3S9hPxkQ1jKK3iqHxAgk3oIpUjCl3iQghnVFvV8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ukieyMl09fGFmhu8omqZcLye4Ij2a9J107k+DQj9XjcHfwQLWDgproZvLey4?=
 =?us-ascii?Q?M2gM/pkzf9z3Os9gVaBzq12JTxKulpeZ0nBjce3DqkAulWNwhjLXlWmzlbt6?=
 =?us-ascii?Q?PiOiSRrMvIP5FHblCWjVp7sY5NGu7BvTzzxpL8i1Tz36x/E+vf+SeOgPRbvy?=
 =?us-ascii?Q?q/VFX9LI/jTo5Eb+2dtGGeQyDd947Gh0/um8krUEQ8NTwhZ94L3Gmj/jW7hO?=
 =?us-ascii?Q?n0DG+zrXryB5VUr8lVlt5NSG7osDjyCoc1lu2oNxitFcUVTkD2K7rx3QBh2g?=
 =?us-ascii?Q?m+NjvsBLZn4Wl4k8JcZOSlCfy4dOOQvzkNNhZLgCaGSQ4yPJFxuEweOpC0Ck?=
 =?us-ascii?Q?jO4nU7HeDfpOyZhw+TW+fniO1Z6t+hblAowi+ITUucQysh2wYpxq8LE3/XUn?=
 =?us-ascii?Q?81r3m7rOQgh9tBP6yZZtdHZCC2EH4mL3itRQsvQI2bASUfr51X/83UKYkZ/e?=
 =?us-ascii?Q?Bczxt5PaLlEpWn0NvMI61LQ5JNFDJmVJtjrwwAOZ7wg/bZ3jQ06GWamZk/Qo?=
 =?us-ascii?Q?mzR5ydpP5W0v4K4oENN5bUWCouVTuqKRE56DmUxABLnnavdzxNEbeFe+Ab8Y?=
 =?us-ascii?Q?NO+Z853z6ozU+yZdSXVcTC8wGKcagECLAKcG85dAvPoIgtYfQi6efFPG33yL?=
 =?us-ascii?Q?FZV8Fy205Av6dSuZiBNQGgTrYHXkzUfAZ2/Nz1ZPfXdy3UH5j1JqbN48Duvw?=
 =?us-ascii?Q?6uJg6kwqaZwq3bRlVqRBHzSMnt0hGPby5grxLsMRy+7jqw8VJeSJyfvb76fD?=
 =?us-ascii?Q?jjC2o2r797ZGQTwUShfIpfMWl+uD5ftg9UK3eUqgn5lSY7VWFVdQVLWSrDRa?=
 =?us-ascii?Q?7n5Em614YdqfXy9vyorlHMYEQFD9FwNVRIFxNOuDdUZUzgH5577EwEsYhpyl?=
 =?us-ascii?Q?JEREyuHnu+EQwGhyoxcLWbwZaXKDRE+CB+CheRPN3QhstfL6Q6rp11Lc9sm5?=
 =?us-ascii?Q?PY2VvBOdXTnQ+ti/WxgK5jPlxp9lVtH/vJq00hMenJLe+sD82mXmGbIP35FK?=
 =?us-ascii?Q?jBGjC0gXfH87hlxiU3Jm0YH/LxWubipB/bSRgyjbL+ykwO8GgaKhscCfdXHK?=
 =?us-ascii?Q?HjuD/hWsTMBxqpulW10fMICEX4xa4gFgo1vlhnblakA6A1Or0w9tx7F4lNXZ?=
 =?us-ascii?Q?Br9Ze+1JSg1FTLo3kAFuXjj+9Biran+ynRzAklyr5ZXce48ECkzgse98pvSj?=
 =?us-ascii?Q?CvU8Rx9N2LcLOv/hqSGU1Q5ALakEh8eBVYEunCS7DIy6ghNym5LZ5Qchig3f?=
 =?us-ascii?Q?oGumAKH5aIRgHjkqmHk80yus3ewhvAQC5uWZa5LA/JNFOw3kfQRGyk+CBt85?=
 =?us-ascii?Q?KHd081zKv6YE7ZLdDaYAELyXdc2mWSTADgCBkIQh9Q866Gua66UrSE0Y62Y7?=
 =?us-ascii?Q?ochaj60LUvRLnHSSjmZXncR13Sol/PcIzT8aRQT7/QVwHXmLQWDI4+ugDd5d?=
 =?us-ascii?Q?daTgjRtGq464n+/wVUhSkgGEy0GM5V0U9qAJjP3aLZTbrEuuTySckud0KjvZ?=
 =?us-ascii?Q?YtTJ0My3qjVKywhYbMS7Q083oJZ6VUzsWHMsrqjibFbSqssjggSbv8uLo7HT?=
 =?us-ascii?Q?TwvOgvIrwN9vMImQWV1b6WghcJlZW5x65RJgkuqp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dede479-538c-4bb7-da63-08ddef1eb617
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 21:28:54.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5fMVFXUa8lemntnJWJMfqDIc6f6Ee3DMt7YvYbLXhwAW1qvREa7D8xjCId6TrvH1jAEstkMaOS2zdMYvJ/h/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7016

On Mon, Sep 08, 2025 at 06:19:42PM +0200, Niklas Cassel wrote:
> The doorbell feature temporarily overrides the inbound translation to
> point to the address stored in epf_test->db_bar.phys_addr.
> (I.e. it calls set_bar() twice, without ever calling clear_bar(), as
> calling clear_bar() would clear the BAR's PCI address assigned by the
> host).
>
> Thus, when disabling the doorbell, restore the inbound translation to
> point to the memory allocated for the BAR.
>
> Without this, running the pci endpoint kselftest doorbell test case more
> than once would fail.
>
> Cc: Frank Li <Frank.Li@nxp.com>
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Note: this is actually how the code looked like when it was submitted by
> Frank, see pci_epf_test_disable_doorbell() in:
> https://lore.kernel.org/linux-pci/20250710-ep-msi-v21-6-57683fc7fb25@nxp.com/
> However, the code was modified, without notifying the list of this
> non-trivial logical change, before being applied.
>
>  drivers/pci/endpoint/functions/pci-epf-test.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e091193bd8a8a..b6ca1766a4ca9 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -772,12 +772,24 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
>  	u32 status = le32_to_cpu(reg->status);
>  	struct pci_epf *epf = epf_test->epf;
>  	struct pci_epc *epc = epf->epc;
> +	int ret;
>
>  	if (bar < BAR_0)
>  		goto set_status_err;
>
>  	pci_epf_test_doorbell_cleanup(epf_test);
> -	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> +
> +	/*
> +	 * The doorbell feature temporarily overrides the inbound translation to
> +	 * point to the address stored in epf_test->db_bar.phys_addr.
> +	 * (I.e. it calls set_bar() twice, without ever calling clear_bar(), as
> +	 * calling clear_bar() would clear the BAR's PCI address assigned by the
> +	 * host). Thus, when disabling the doorbell, restore the inbound
> +	 * translation to point to the memory allocated for the BAR.
> +	 */
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> +	if (ret)
> +		goto set_status_err;
>
>  	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
>  	reg->status = cpu_to_le32(status);
> --
> 2.51.0
>


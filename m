Return-Path: <linux-pci+bounces-28037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94362ABCAE0
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9279D189A84B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794921CA14;
	Mon, 19 May 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wpunyn6+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B45219A8C;
	Mon, 19 May 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693785; cv=fail; b=j/BY/u6o53GDSFyDAFYhd5uAZz5X1faI90Gs7gszMZ7ccfIWLb0yE7zIauuwBAqSmKJcBX5rGwitIoZMWBtYwGJxhZmQIOcnRA63comtr6LNrJtMBk8jcawHUOXQe/lH9NHrRmes2LCwYlIsZ647i3zfA/pmFJJoffsOZJ1/448=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693785; c=relaxed/simple;
	bh=5WVX7zEriZlyJWWdC+0nEQ8sno76nhOkALMX1MQDPw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FAR/7pWig2hZ/G9a4wVxiFFhOyDoTW42oCXGsRPezZguuUJhZKH/ZcBIgDj9W/oeKN2NpK/xrjqMsnYbUFL9jwmfYAIdNBk2bef7iC09aoDQbOYuBR/klphhYPQM7UI07oBimyM0HreLdO/sznhavICuX1lsO0L4FbE4FQo8F5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wpunyn6+; arc=fail smtp.client-ip=40.107.247.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOq/HOS7zgaalY8Ltnx4Ta0Giep843KWzIhXISvBLfTEvkB9QLSNZq6VuP/dPYbdm1ydNe3kQ7uCfkJyH/082yawmd238yHr4/5xpkM1QQIz7gQ3tKt4+Q17dOzj7dmvAGrPLKbXu74AR0+46r36TgWBf8Hx8xB90uQhPSAagu61jWJKVLPPybt6Yi/hQ7csQX3yOnlwYNmAQgpkvwDToTXu72PV0l+tNhf6R8ru6JmKNgBq7w0rG451Z96kArLInlLLCLuPQyOvVQGHMv1TA/VBNN9hixje6Aghe83/ELB5Ct9QDjESk1dmF1C7wWffTmkXRtXuyc/9mh4O7TDHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqm9yXeb/kt7L3thER2lh+8QIOBUNbmp5/o5A0SEjnI=;
 b=S8nIB2dIIlBM9LcHFaRSXB6TI6M3bA178awXRAuBIGgrabZXPFqXpgXYRPr+AoMDeopynEzG4P71HKGdBuGTBf/nlVSjhPyIdniaiCrA3DYh1sSfYgiMJ7cfbSVxN/+FSQ3wJYYL/cnvmlkSBSIyE3dzM3lDS4t3lipnkZLdWA0Fcg5VlbXbkn6gpcmHdmD+/eu3Ar0b+PR5l89RGBqxX6HLIe9ojptAwZS8USVpAcCrkYZyhvzJyyz6so5bGp/JVCkftY2HklhfSqFSmvDHyKId30+NqSTogiIU12grWFXXc/ttTeXlDENIrFzGxkK0n8FlEJYvp+tMbqQdsqJxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqm9yXeb/kt7L3thER2lh+8QIOBUNbmp5/o5A0SEjnI=;
 b=Wpunyn6+h9geV7uDwCawNROo7DERoGI20Du0cadIyDqmrZbvhJgSxVwtl1ZlJY8m98hYowb33zKSzplQgwNNVygqIZGtFLTN1rX1LcOv21TUWyZRboKi+jHJB+pj2ji3baok960z+I3ZEl9Vwce+o4UXNCbbbKklzPIWNNbvqWJJguObmrGSZYmH40RkRnqWpXYvl8pjXteNywG720KH6lnjKRavfFtNOoCCeFgmk16my+2+ynTGX3EUIVru74ctjBBlIR4yIkR655IjoMZdRxOWWSe7yfB+opY3kOVCY4eZ1KEtenDMvYdyqBA7ePCu7hl8/JSIep0KvVGr+HFrSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9582.eurprd04.prod.outlook.com (2603:10a6:20b:471::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 22:29:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 22:29:39 +0000
Date: Mon, 19 May 2025 18:29:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI: endpoint: pci-epf-vntb: allow arbitrary BAR
 configuration
Message-ID: <aCuwy5ZjkhAiCPoZ@lizhi-Precision-Tower-5810>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
 <20250505-pci-vntb-bar-mapping-v1-3-0e0d12b2fa71@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-3-0e0d12b2fa71@baylibre.com>
X-ClientProxiedBy: BYAPR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c1f810-0a56-4847-9c41-08dd9724a4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p2eovZfbgh8WvEWI8aIHRGiXIqemsLRUPtAWcHVfDwPtSgWBLEjYaYy1e8mF?=
 =?us-ascii?Q?7ym3dKr33iOOuExzBcD8CSOXBQLX3djEldErx3SMqQzDI+7uFzGrzlyDwDBi?=
 =?us-ascii?Q?n2jdf/Veb2FTzBlGqtQQXWxusLw2hgVjMPQgvH2ygbpkQCUwj8OJdcxWyIMf?=
 =?us-ascii?Q?4XX4ct8AXDTeR7OmntHfF2bWmU9tE3npteKhlISWKXVUQtLdnnOFvJQDwm7k?=
 =?us-ascii?Q?WsyRO7dfE80yZDpPiax8d835GsrbsncVz80dQLXVUi5l+LS1VcvYYInSsEEP?=
 =?us-ascii?Q?7nEGAiVO8oVPuugkTNSQBRmM98lG4S7zVnssq7jkCwHK/l98ElT6GnGnfcnV?=
 =?us-ascii?Q?or1Ey950rM/xHemwhrWHAx2K4pr9SKnHODo5zROIEA9vpapc0KkhQF1EhM3+?=
 =?us-ascii?Q?Kr/FWZIxmkz5Y7T1FyBe2X4asLFHAgYR8xs+gqTOtkUFFhivbjLGn7ha3YBo?=
 =?us-ascii?Q?KFVxtl1UW0SXbz0G31rQs3MIJ5azSIqJ4YXrAcAC02BcnLJLQC9g9kvgr75J?=
 =?us-ascii?Q?I6/bkGKePfc7ANVd4VDk+rcS1AK6El5UU1WBeW14ysNNzl0+SCqkilBfkVBZ?=
 =?us-ascii?Q?AKrKMjinMUaOKeEDGBqWzpSTDhVtZUUuihIukb4QIe0Zlj/FOazCHrbfuQQB?=
 =?us-ascii?Q?aLn5zmb8CQmmL3MIKDrVUeh7H1V9VCJaiPt8/BzapxDwAsDqCQUdAMWSbB1b?=
 =?us-ascii?Q?YwfOkJG/7SqRw0N5OXNm/AZ325OOG/bir/GGtH/0U1bW++1COuIZ4YzbWPlF?=
 =?us-ascii?Q?Kv/3qKSNugB6JHeRuq8FFYZ6XY4RVO37HRe7RPDOrnfrNBvAzk29m8zJ3noH?=
 =?us-ascii?Q?QNnh4LjySKQreAYyMmCI/tgLVYb204bwf6VLJRznEj2A7A9hKeDx9dfJ2t+k?=
 =?us-ascii?Q?3h4ly0Ax9pgPbbqwMIDs5wxtQmPqHf1bKU2zRSPMlDkW8wtsohCSN8ohO6RO?=
 =?us-ascii?Q?B3EbI0rB9e187r27z0uAe2WP4z6MQ0cXLWKRwBkIVAhPUr5s+bYsrxgcQ71H?=
 =?us-ascii?Q?cja2OnXjO4FLfrcnfaw9G4ws6ypl4H9MsisC7rFqM9CmCqXiZnXt9yahR80d?=
 =?us-ascii?Q?UrtQ1pw6+G3xAx17wcuNvEyHwrLDAjhqZT5B02kCrOp8cKsZFenDzlWRtvu0?=
 =?us-ascii?Q?NqV2gHqufycw/GAgQAtVqPKnMhQQdTLa+uf8sTXRIy0o/SOc2/v3uPwP4JsJ?=
 =?us-ascii?Q?enQQqyXwCWtq+UAIOAYGkCS65tC4b8yPx3ZLtRcz6sXhzbh5IX+nng4ryAB1?=
 =?us-ascii?Q?LKRdh5QqJHoiO6aRFaxg2aTkOtJ4ZaWnUcNVUWm9KOqbSHlZE0LGbtU3abWR?=
 =?us-ascii?Q?cv5edGHhsg+Es2VLZKkxfl56AsIQY1FE6QqmRQTg6MVv8mVXyuXFxEjRakpU?=
 =?us-ascii?Q?4Zi7B4Pnm1Hw1lU8F3t2i3EZn/aCP5PKalt5ZFDSDknY86tY9aFGW34CtL67?=
 =?us-ascii?Q?4xUOeeEiHv0J8CevVNCCMrCfguZuY/n9NllN7gsis4ZVS1synQASTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFbZPExf32GZbG+VX0uXXEB4VW6ggGG/E7OaklUux/hZJDag4RoN8FBja3mb?=
 =?us-ascii?Q?/ccQFDXIaQJSxQQkgWD8zUy6gf3HRPXv/vP7mWfTiaql4w/f2ZrM3S04z253?=
 =?us-ascii?Q?R8KKivX2/+B78SY0XRYaFhRNUQKhKcRz/mft7ly50suLqQ92OerumVgnnd03?=
 =?us-ascii?Q?Vmfq7bhT7GvTyALhCtQyB1cpua3EB0TSxheZGACv8p2WzilTsG4bnFU1bfDt?=
 =?us-ascii?Q?XQdbAwhI+tlkyezpUWkLQUQkgacZ9b1RowKeTcNIb1Nvj1F7PHQW/dtazKw/?=
 =?us-ascii?Q?AD/ByBD5POz966YUoMssVIL5rAt2cfsO94E0dx2O5ikWcFdf/n2Y8t26ewpZ?=
 =?us-ascii?Q?kPJMkT/E2y9KSmcYTjQRGSxmZq/ceBC+Uoa1/arL+Ml1vibp1VGrXF5BpkPP?=
 =?us-ascii?Q?2d1M1jKe1ta+f44/T57RJqdpnWboR+B1pUCk0aNvYdxoH60EDnF4PgUkNDwx?=
 =?us-ascii?Q?Nx5B6VJAhdAk3RO0wnOGb1Ggf8l3lLmaIxI178eTDvTWsBwm6F0LoYLI+NBO?=
 =?us-ascii?Q?HfLzrlYB301DvGRXIOtrwsoqtKF09Z1af8BCLhExgdOjIlxFkr7egeerLbL2?=
 =?us-ascii?Q?g4nw/lbqdZqg1OpS94eLt+54Q4d9mILefLjdaNmhFI88AkXwqM5Bz7ml1PBY?=
 =?us-ascii?Q?cw0jbNNr53M2+pUXt9OvBJCvSGrTh/ZhdBZ9nkryF9+7kM/QBFfgYJkvKLFM?=
 =?us-ascii?Q?K8KuTw/dHMTOw/iwqg9pMquUkoB10lwH6kDCLeFipKF/iUsLF5jAikmNpwkE?=
 =?us-ascii?Q?RAgDWwRY94ucb38MSjVpcXGTYlDqfm7HE3CEEznxQ2lg35H/u668P+4dh5tB?=
 =?us-ascii?Q?XYUCKpmmOUo+dbr/0SLpd9zZzt54kAcwkibYhzQJVP2fNdJTmYPrha0SXrni?=
 =?us-ascii?Q?cuCYy6aOmBBwvmT6/ABGBAmU2E40B8pi4VkNGywG20+54yVBMCg5HZlAuJUC?=
 =?us-ascii?Q?dYJveDVBtJbXzTYKxJBzMe2iGMIzrtWr9Q50wn3UxdIixTC7rGi5bq84qQO4?=
 =?us-ascii?Q?iyndEnDSwCCSOR3v+KOFYQ2QupVW/SQ5rVERRRLmo7CV/V/skcl5Z1smsJW5?=
 =?us-ascii?Q?Y2UskIo+cRDimx21h6g7AsPSXb3ZVETmoD1QKUk/JntlfXJcA3nkRvFLB+hy?=
 =?us-ascii?Q?ssQ4AlvJJGBn1NMzJ+dFBu0NJTTfyQwq4KVoBlMWr02lpUVvWemux+vDGjHi?=
 =?us-ascii?Q?lg4dyNlV2zvcUGLXlhjwaYuU4VCqzgmTwqUonJPRrn9k3RbOxgLlzbNcavX5?=
 =?us-ascii?Q?0VdKlJ8sl3J+GDdZrraBz+epaCvsFe8P0CeFEr9DSf2SgEn1Ms23CV61OM41?=
 =?us-ascii?Q?78s8nRcyCOK3i72v/UEZug8cnHz2TGIYhTpUMz6CeeA97w2d1bX7dD4eIz4h?=
 =?us-ascii?Q?bktSqQz4/LzDl6zRssDEsif4EObTDWbM/YCyuDNu/xbIfH27vnmJvV9FmAFc?=
 =?us-ascii?Q?dXgfbAgpsw8wulIIgjx8gfcXR8jio+HlDyYGHkZOr3w/nR7lnYBfyrss+ZC0?=
 =?us-ascii?Q?otieoxiw3PZsCf/3bBnPR74FRCpNfw34LJiuihRgqAyTS4sl2hGbyM/n2L5t?=
 =?us-ascii?Q?JTWeTnC9zXwUnhmgyBE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c1f810-0a56-4847-9c41-08dd9724a4ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 22:29:39.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNHc4Nr/ecKGtFpVMn2pfC/D8A1jiJKQ+Dy6jDEv+yghfh4j3/1DEG0fSGgLNjYZolLmT9koTl6FHGZ6dqjCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9582

On Mon, May 05, 2025 at 07:41:49PM +0200, Jerome Brunet wrote:
> The BAR configuration used by the PCI vNTB endpoint function is rather
> fixed and does not allow to account for platform quirks. It simply
> allocate BAR in order.
>
> This is a problem on the Renesas platforms which have a 256B fixed BAR_4
> which end-up being the MW1 BAR. While this BAR is not ideal for a MW, it
> is adequate for the doorbells.
>
> Add more configfs attributes to allow arbitrary BAR configuration to be
> provided through the driver configfs. If not configuration is provided,
> the driver should retain the old behaviour and allocate BARs in order.
> This should keep existing userspace scripts working.
>
> In the Renesas case mentioned above, the change allows to use BAR_2 as for
> the MW1 region and BAR_4 for the doorbells.

Suggest commit message.

PCI: endpoint: pci-epf-vntb: Allow configurable BAR assignment via configfs

The current BAR configuration for the PCI vNTB endpoint function allocates
BARs in order, which lacks flexibility and does not account for
platform-specific quirks. This is problematic on Renesas platforms, where
BAR_4 is a fixed 256B region that ends up being used for MW1, despite being
better suited for doorbells.

Add new configfs attributes to allow users to specify arbitrary BAR
assignments. If no configuration is provided, the driver retains its
original behavior of sequential BAR allocation, preserving compatibility
with existing userspace setups.

This enables use cases such as assigning BAR_2 for MW1 and using the
limited BAR_4 for doorbells on Renesas platforms.

>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 127 ++++++++++++++++++++++++--
>  1 file changed, 120 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index f9f4a8bb65f364962dbf1e9011ab0e4479c61034..3cdccfe870e0cf738c93ca7c525fa2daa7c87fcb 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -74,6 +74,7 @@ enum epf_ntb_bar {
>  	BAR_MW2,
>  	BAR_MW3,
>  	BAR_MW4,
> +	VNTB_BAR_NUM,
>  };
>
>  /*
> @@ -133,7 +134,7 @@ struct epf_ntb {
>  	bool linkup;
>  	u32 spad_size;
>
> -	enum pci_barno epf_ntb_bar[6];
> +	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];

It should be PCI_STD_NUM_BARS

>
>  	struct epf_ntb_ctrl *reg;
>
> @@ -655,6 +656,59 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
>  	pci_epc_put(ntb->epf->epc);
>  }
>
> +
> +/**
> + * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration

epf_ntb_is_bar_pre_reverved()?

> + * @ntb: NTB device that facilitates communication between HOST and VHOST

missed @barno

> + *
> + * Returns: 0 if unused, 1 if used.
> + */
> +static int epf_ntb_is_bar_used(struct epf_ntb *ntb,
> +			   enum pci_barno barno)

return value bool is better

> +{
> +	int i;
> +
> +	for (i = 0; i < VNTB_BAR_NUM; i++) {

PCI_STD_NUM_BARS

> +		if (ntb->epf_ntb_bar[i] == barno)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * epf_ntb_set_bar() - Assign BAR number when no configuration is provided

Look like it is find a free bar number, which have not reserved by configfs.
so
epf_ntb_find_bar() or epf_ntb_alloc_bar()?

> + * @ntb: NTB device that facilitates communication between HOST and VHOST

missed bar and barno

> + *
> + * When the BAR configuration was not provided through the userspace
> + * configuration, automatically assign BAR as it has been historically
> + * done by this endpoint function.
> + *
> + * Returns: the BAR number found, if any. -1 otherwise
> + */
> +static int epf_ntb_set_bar(struct epf_ntb *ntb,
> +			   const struct pci_epc_features *epc_features,
> +			   enum epf_ntb_bar bar,
> +			   enum pci_barno barno)
> +{
> +	while (ntb->epf_ntb_bar[bar] < 0) {
> +		barno = pci_epc_get_next_free_bar(epc_features, barno);
> +		if (barno < 0)
> +			break; /* No more BAR available */
> +
> +		/*
> +		 * Verify if the BAR found is not already assigned
> +		 * through the provided configuration
> +		 */
> +		if (!epf_ntb_is_bar_used(ntb, barno))
> +			ntb->epf_ntb_bar[bar] = barno;

missed "break" ? you find one free bar.

> +
> +		barno += 1;
> +	}
> +
> +	return barno;


return ntb->epf_ntb_bar[bar] ?

if pre reserved, while loop will be skipped.  reversed bar number should be
return, instead of input barno.

> +}
> +
>  /**
>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
>   * constructs (scratchpad region, doorbell, memorywindow)
> @@ -677,23 +731,21 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
>
>  	/* These are required BARs which are mandatory for NTB functionality */
> -	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
> +		barno = epf_ntb_set_bar(ntb, epc_features, bar, barno);
>  		if (barno < 0) {
>  			dev_err(dev, "Fail to get NTB function BAR\n");
>  			return -EINVAL;
>  		}
> -		ntb->epf_ntb_bar[bar] = barno;
>  	}
>
>  	/* These are optional BARs which don't impact NTB functionality */
> -	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, barno++, i++) {
> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
> +	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, i++) {
> +		barno = epf_ntb_set_bar(ntb, epc_features, bar, barno);
>  		if (barno < 0) {
>  			ntb->num_mws = i;
>  			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
>  		}
> -		ntb->epf_ntb_bar[bar] = barno;
>  	}
>
>  	return 0;
> @@ -861,6 +913,37 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	return len;							\
>  }
>
> +#define EPF_NTB_BAR_R(_name, _id)					\
> +	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
> +					      char *page)		\
> +	{								\
> +		struct config_group *group = to_config_group(item);	\
> +		struct epf_ntb *ntb = to_epf_ntb(group);		\
> +									\
> +		return sprintf(page, "%d\n", ntb->epf_ntb_bar[_id]);	\
> +	}
> +
> +#define EPF_NTB_BAR_W(_name, _id)					\
> +	static ssize_t epf_ntb_##_name##_store(struct config_item *item, \
> +					       const char *page, size_t len) \
> +	{								\
> +	struct config_group *group = to_config_group(item);		\
> +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> +	int val;							\
> +	int ret;							\
> +									\
> +	ret = kstrtoint(page, 0, &val);					\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	if (val < NO_BAR || val > BAR_5)				\
> +		return -EINVAL;						\
> +									\
> +	ntb->epf_ntb_bar[_id] = val;					\

do you need check the same val to assign two difference ntb bar?

Frank

> +									\
> +	return len;							\
> +	}
> +
>  static ssize_t epf_ntb_num_mws_store(struct config_item *item,
>  				     const char *page, size_t len)
>  {
> @@ -900,6 +983,18 @@ EPF_NTB_MW_R(mw3)
>  EPF_NTB_MW_W(mw3)
>  EPF_NTB_MW_R(mw4)
>  EPF_NTB_MW_W(mw4)
> +EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
> +EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
> +EPF_NTB_BAR_R(db_bar, BAR_DB)
> +EPF_NTB_BAR_W(db_bar, BAR_DB)
> +EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
> +EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
> +EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
> +EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
> +EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
> +EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
> +EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
> +EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
>
>  CONFIGFS_ATTR(epf_ntb_, spad_count);
>  CONFIGFS_ATTR(epf_ntb_, db_count);
> @@ -911,6 +1006,12 @@ CONFIGFS_ATTR(epf_ntb_, mw4);
>  CONFIGFS_ATTR(epf_ntb_, vbus_number);
>  CONFIGFS_ATTR(epf_ntb_, vntb_pid);
>  CONFIGFS_ATTR(epf_ntb_, vntb_vid);
> +CONFIGFS_ATTR(epf_ntb_, ctrl_bar);
> +CONFIGFS_ATTR(epf_ntb_, db_bar);
> +CONFIGFS_ATTR(epf_ntb_, mw1_bar);
> +CONFIGFS_ATTR(epf_ntb_, mw2_bar);
> +CONFIGFS_ATTR(epf_ntb_, mw3_bar);
> +CONFIGFS_ATTR(epf_ntb_, mw4_bar);
>
>  static struct configfs_attribute *epf_ntb_attrs[] = {
>  	&epf_ntb_attr_spad_count,
> @@ -923,6 +1024,12 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
>  	&epf_ntb_attr_vbus_number,
>  	&epf_ntb_attr_vntb_pid,
>  	&epf_ntb_attr_vntb_vid,
> +	&epf_ntb_attr_ctrl_bar,
> +	&epf_ntb_attr_db_bar,
> +	&epf_ntb_attr_mw1_bar,
> +	&epf_ntb_attr_mw2_bar,
> +	&epf_ntb_attr_mw3_bar,
> +	&epf_ntb_attr_mw4_bar,
>  	NULL,
>  };
>
> @@ -1380,6 +1487,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  {
>  	struct epf_ntb *ntb;
>  	struct device *dev;
> +	int i;
>
>  	dev = &epf->dev;
>
> @@ -1390,6 +1498,11 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  	epf->header = &epf_ntb_header;
>  	ntb->epf = epf;
>  	ntb->vbus_number = 0xff;
> +
> +	/* Initially, no bar is assigned */
> +	for (i = 0; i < VNTB_BAR_NUM; i++)
> +		ntb->epf_ntb_bar[i] = NO_BAR;
> +
>  	epf_set_drvdata(epf, ntb);
>
>  	dev_info(dev, "pci-ep epf driver loaded\n");
>
> --
> 2.47.2
>


Return-Path: <linux-pci+bounces-25012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9126AA7691C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66846188CD9B
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8458218EA8;
	Mon, 31 Mar 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9xOfZKw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CC21421B;
	Mon, 31 Mar 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432550; cv=fail; b=QR4lA2ac6SpHECcW2i3DQ7BOHVlnq+jO6fSP4LqjsXE2AbX+GyWkvlqcO4ibUzYqGQmjuvU4CalMoDn8OD2ZXwE8ye0F78TCGl3aqAT3/RoWMoRpGiqmf0Z++3wlL8I7YrEOmjU5O9Br2/qix2tNTeloVcI4bWevfOQSeoGezLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432550; c=relaxed/simple;
	bh=JuXK0yIweEoPmJiXZ7kXOPHSi81Q+x/WZx27R6+7ba0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tjGel/vviwadmL2WGGpJQQu8rMqoRxvsnGiinqZZBVHAfgtLdtiBaAh5R0DsXFu6jMkc13w1qKxmnyIpF9VOLHuILX3rEhFMG06+AXJXyvWmaXwp6eTzpOXssMnSUjMV0asGIzMQuqigCJvjuwtQvMWftnmWPpx6/UruDVapsOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j9xOfZKw; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI+NyCu3BFeZEgMn660/po/K0qSI/zCKsaHRrfdr4FCoz1FaSAFNPZEyNFLOaR6c8Qhi6jocn+MACL44caNOoIzvF2JSI1nIHNeu+yUYq0YrP3jc34yOi3unQ7Nj39Tov/2b9ZhQEO2TFlhPZxP8cUbCzlVwAUDr2C7TzHIVYwkL6TqpedNzTNUWTH5pzS/u3pwSJnq5beYotwD9Ri1Kjnz+3P/GPL2ss+5NOtuq8dLvDLciDc4qnsSY9i4YE6hx1+py+0bc+nMKURB+ZcNSp/FViDVI3WQGMym40eQM/JgRPAp3gtDKzv3INgqcZEOnwy8DT/5d6++I0Pkfq1Ej/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnPdTrBeDZnVRE7yDZiV6+PX14LsHJFJYXEv6q21bMs=;
 b=vSDX8vUwAAg+I1BBJkrC30eaVCph2TUZ4K9wHail46ZVu6W4R1vuV3fykO9zOrwSNhtHtSdMP/9l8EXm0PUD9HcJHOL++XLQGpmPtjQ8u/XX6evjAI7hPfr0bf2snuPC6d+c51oJr0QzvTqm5CEvuIeKZLvYy/zo8DtIali2i2I+sgpk/Nxr/WPA6l7/Fd/U2RoYCWglsE/7Z1/Q2sq9cYDT0vUxkxPGTtg2iM6/pvFAvIDHh5ETymVT/24CIaX3Lf5MjLPp1Ih7mdK1CG8hbYul5XATitR8C28IJeJ6f7g9djelAKFcV9A91tDDSCicxBB73QOea3l6CPf1o9bAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnPdTrBeDZnVRE7yDZiV6+PX14LsHJFJYXEv6q21bMs=;
 b=j9xOfZKwhqRoDEXmJ5NCwwELvT/VQTR8cx8DkXELF2Fqp5eSBMGzOnnBk8HNifvikVKrAXM9O1kW8YnrDbgc2F1WTNJPqEJzBJfWeE5mgYlWiU5MDfq0K8RkcCXas7WfTR3reBw8z2/8BQvX7Z08WyO0gxanQES4xqMvysfzinNHvlD/rZfT13z5l/90pDBztXXS7eUfF/NDNdmplPEkmBwuPvkBYRZsMad9vVJeGqZZb/abvEQViPJZG6HiYqQ9Lou3dSSzbPgfKv7t8xW7tR1g9JM6DsBXav/H8CuoQvcgevSR0kZuS9O53dw0JXHj5qwDi7pTRrjPINVb1rMU/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10373.eurprd04.prod.outlook.com (2603:10a6:102:416::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Mon, 31 Mar
 2025 14:49:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 14:49:05 +0000
Date: Mon, 31 Mar 2025 10:48:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
Message-ID: <Z+qrWleCthbAfDxf@lizhi-Precision-Tower-5810>
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
 <20250328-pci-ep-size-alignment-v1-2-ee5b78b15a9a@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328-pci-ep-size-alignment-v1-2-ee5b78b15a9a@baylibre.com>
X-ClientProxiedBy: PH8PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10373:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0b5d59-a91b-49d7-3264-08dd70632f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jnU9W1vbEOn8DtD1dXc8WJNPaMUlBbeKHizxF9tidAKb8Kz7WY08m+uVNWdr?=
 =?us-ascii?Q?EqhX/jG7q6GDzRHHEcxMMb7HbV4F1eZ4eUWOLs4xZw6XNziBhPRbqbcbaQrM?=
 =?us-ascii?Q?J201L/nbMDa/vogLNuEDOrHGjgBxC9qCqWOd16OzGGvaAk1RAkcLqqoq1y9Z?=
 =?us-ascii?Q?iPDtNrJa4sjoca0LrFxwW0ipIlBqwzM+gAcS7U8lupuc6+aznLcHO3v8zWeT?=
 =?us-ascii?Q?DedJEIIm46FtLBQ0UYXEaOd9UtAlW+S+FOOGHhbEYVTpkvJEs7yztqm5wYzz?=
 =?us-ascii?Q?ZVv4MXYxAKfY42WBBYOV87vRTYyJQyn3mSOJiUwFk/TFVnD5oeCPPwi+M3gP?=
 =?us-ascii?Q?K1XZ9+qIZKYH+aLZhcJHLC2UPva9fDPTw9TyDjVfHY50jQuZBRPStvrFMw+R?=
 =?us-ascii?Q?DEGFN/1D0YZPyg4IO7rqEoNbCgenrWy/xR2jFn0Wac48dT+W8LDshlZqBV2S?=
 =?us-ascii?Q?8wtYeTXitKYf22N19oTInuzH4OVBH31G9xqqVCfyx1LQyHtRdQd1Wg1X03OS?=
 =?us-ascii?Q?zziNwjxOGWBo8oZAlPAjmz9mHUugaj4ehTzMdkU8t+lY42uN6bTOrUAlzoXP?=
 =?us-ascii?Q?c5GYQ+zVwDIB6+LZoMi3w5omGfoCemwxvzdMBZLg2YSiLEA1aNnYpyLK2RpQ?=
 =?us-ascii?Q?Qa0UDndJduWqZvZJq0k9n98f8wXtm23k9HyrAxe3Okh0nJG37J99Fnl3FUHC?=
 =?us-ascii?Q?4CyMis3neB6dFmrC3PfwkZy8kSeULSuHV7IbWEnBH5pJMoYhvlngCKzDqCPy?=
 =?us-ascii?Q?yEUZ0jMiNYsdMuLDu2Ml4YW9k6Z+nhPmC+1lVHUVdYlCQRFsfKFMNBwb46JD?=
 =?us-ascii?Q?u7P7oJDeIR0apisCc4at9yDhNfVJNL4YUh54mxxffeagY0x8JrjfjD0f1RIF?=
 =?us-ascii?Q?dL1+BzWjDkE0P+XixKIegGeXUCfsNZ9pxseky6RwIkLzKKqDumEybgEJEULV?=
 =?us-ascii?Q?w5KDgfQW0YSKKTXffBwtw1cB9itRY0rfo8L76quXfy4uCG6sEzW3pWNQu0fI?=
 =?us-ascii?Q?827g533U/K0HcH+q0EIgb//fnfPqZ9+MLuBxkA4P37lm74TgQYAh7B07j8VU?=
 =?us-ascii?Q?NAJ0pQsiEhke/zzqeWrV9znUddFMJCsH64aP5UD3mAPPxTeId4lC4OE7dC07?=
 =?us-ascii?Q?Ght4mi/DvSXVGghjf1NImJtmkSUQjiUUp9bzRTfa7Dyty534yoqYwjFnZmXw?=
 =?us-ascii?Q?TAyEyI6+55D7nFgkI6+qjk/cvxQVR//+qWgFNZhx6kGvHHl9RzcK0kQWonwv?=
 =?us-ascii?Q?e/RDbMNlazGzDVziQYrvTjLkMN7SDV+Z5ui813EKmc0j9abQxvGBh069N8Ae?=
 =?us-ascii?Q?Sm0E7YEGhJj3HWyEy+k0dR2GQg4QKKerxcD6qnHf1sk0wX9IWjZYtmp0bHnR?=
 =?us-ascii?Q?ExEwYfoT/cn1/tVngUsimSdHlhfwjk/0/LZKjbFjkG5LbgUpQdcm56quoTNj?=
 =?us-ascii?Q?X8nXpZNhZc3WOX9AzlVWDxg3WgF2sXSh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N7Pj6Q527u6TkFrR3jVxu2YBBI5uqq6gzu6a5ldp0vp88vXjIW6TyXznO0bO?=
 =?us-ascii?Q?2i8dqRYGNCt0d9u4I+Hpy2XsAcJnMcsW2wo+55jKfIb2RJPHthYcObN0qLHP?=
 =?us-ascii?Q?NRau/M/sBtY4vToD3CxuwDkwyB2tIk1pejCTY5bpgP83EISzgAv6l33Mbthu?=
 =?us-ascii?Q?pbfDjIqsSohHSbJpK6Hg7qtxB3YUm3R5Gh47yJkvuDUSEp73Fac7VWv9eSkv?=
 =?us-ascii?Q?CrDwFfr/UqgNqf9nW7okMRZvygc6M+UlHBAkKuqDIzGkVHlM/zm+/IpNOXTX?=
 =?us-ascii?Q?C8GTHmhBeEpIvTq1B1oYI0TQIDn3HEcevN4lI4ss0DLNbEzFmT+oTNZlPnoQ?=
 =?us-ascii?Q?eUYb74U+osJRpm94S1Tq+0GWtuQo9hVqDedCm2p7qADGa3pzWCXQofD0vOIm?=
 =?us-ascii?Q?IO6bTAR9WKDCRSsi9Sb3yAQ7nS0NnerWMGgN4nOh3hZqVg1TKxk7g/J05QYB?=
 =?us-ascii?Q?gFKEPYm5fuK0OIvHaP8b7lEVokZCJernS7QmfW6KAO7e/4o0Imvc6TxTvzFE?=
 =?us-ascii?Q?xjw/LCmlYnr77HumN+TB4jPQXQblk0HZq7DeUzFSKregLMJhb2DqshEIHalb?=
 =?us-ascii?Q?0Q19BBp0dDm/XIR4TG+oPZdasU1mjKKAPKyDiC3CsmdLIgW57JKDKJj/oDBs?=
 =?us-ascii?Q?bRdHdTXMs+lioqFrHrDFH1OSK8ThtMnrfHietv8oSKS2rhMCaDUJmMCifzi2?=
 =?us-ascii?Q?tTE+x5gOz9c6xOuqBoJlDkQB8wSDu3Dd7l1ROHk40GoVC9Hc0r9QIdfqeSDy?=
 =?us-ascii?Q?MEGzJdH6ZYqJJZ0fLtw+IJyG2i//Z316q/5OrHszN28AKZjpX0ISQJ2Ed1V4?=
 =?us-ascii?Q?rh35gu0Ad6V0836JkWPrGfBqb9QBWW9RCjF96butR57DUnFghQwEJzqrGz96?=
 =?us-ascii?Q?ceiywMfyHogzJcwLNARk4oXAJWBaxAbVKsV5nPtZ59CjYqspkekIHTl66Ooa?=
 =?us-ascii?Q?slThIde6iYbmS5kBGJ+jPMJGHXyCJFHa55p1nBocrCGdI7CW6k1V+QGRh8Qt?=
 =?us-ascii?Q?epMKX7ph8+osK9RCXX/HOVhasKX+0nJU3BfTNr/d+uKzhz8/kDkj7CSKckSV?=
 =?us-ascii?Q?QB/2ko8ifUZjTzbCIli51ThxQpVCyx25zf8uGKL3p7dkKn69pTCfff93nrP/?=
 =?us-ascii?Q?mQYxL+DU5dYUmSr60fT7R/BP7kAem3NC4QgdZU6L9dNU6AVQ/F+giNagwr81?=
 =?us-ascii?Q?SVkc0mhCmQY50WHGc4r2zl73fnbNttnYIKl9XEZvSFS5+wk2nmH6hYF9VJ36?=
 =?us-ascii?Q?j3fnAg53axfbvQw5dkg2cGuJEhFdJLxVvvXXI494fDScWDgvfc6yUiu6sUiE?=
 =?us-ascii?Q?9lvmAXQqNBftyINeJH86vLRzQhdVveorXHRrxwKS3WRLRORVZjNGqxhsZ2jx?=
 =?us-ascii?Q?2gtVIVOpGafFjzqxd5ZX71S38bWFICg5ltP/q3rXWHLagUPjgKsc9YroHwLZ?=
 =?us-ascii?Q?WiwffN+/tRZYMC5JgI2uqLPyyqlzz20Wb4qy/8LUackEgjxK7Peo4GPdO66q?=
 =?us-ascii?Q?QfJlyzBQgBSdkTDKMYLhI+91hAwCJsNGFcLdgf5Jk0m/PskIE2hFCZp8KG91?=
 =?us-ascii?Q?yTc0ezv+A1L7NQA+l58=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0b5d59-a91b-49d7-3264-08dd70632f60
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:49:05.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbjDQanVOW5DDv4s01OSjrIlzJP4HSdZmPCSLJ1tgxo5/leso7tWhb7nrP965n2Y53yLXfbIYe9qGWKm3qyDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10373

On Fri, Mar 28, 2025 at 03:53:43PM +0100, Jerome Brunet wrote:
> When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
> should not try to handle the size quirks for the underlying BAR, whether it
> is fixed size or alignment. This is already handled by
> pci_epf_alloc_space().
>
> Also, when handling the alignment, this allocate more space than necessary.
> For example, with a spad size of 1024B and a ctrl size of 308B, the space
> necessary is 1332B. If the alignment is 1MB,
> epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
> been more than enough.
>
> Just drop all the handling of the BAR size quirks and let
> pci_epf_alloc_space() handle that.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..c20a60fcb99e6e16716dd78ab59ebf7cf074b2a6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>   */
>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  {
> -	size_t align;
>  	enum pci_barno barno;
>  	struct epf_ntb_ctrl *ctrl;
>  	u32 spad_size, ctrl_size;
> -	u64 size;
>  	struct pci_epf *epf = ntb->epf;
>  	struct device *dev = &epf->dev;
>  	u32 spad_count;
> @@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  								epf->func_no,
>  								epf->vfunc_no);
>  	barno = ntb->epf_ntb_bar[BAR_CONFIG];
> -	size = epc_features->bar[barno].fixed_size;
> -	align = epc_features->align;
> -
> -	if ((!IS_ALIGNED(size, align)))
> -		return -EINVAL;
> -
>  	spad_count = ntb->spad_count;
>
>  	ctrl_size = sizeof(struct epf_ntb_ctrl);

I think keep ctrl_size at least align to 4 bytes. keep align 2^n is more
safe to keep spad area start at align possition.

	ctrl_size = roundup_pow_of_two(sizeof(struct epf_ntb_ctrl));

Frank

>  	spad_size = 2 * spad_count * sizeof(u32);
>
> -	if (!align) {
> -		ctrl_size = roundup_pow_of_two(ctrl_size);
> -		spad_size = roundup_pow_of_two(spad_size);
> -	} else {
> -		ctrl_size = ALIGN(ctrl_size, align);
> -		spad_size = ALIGN(spad_size, align);
> -	}
> -
> -	if (!size)
> -		size = ctrl_size + spad_size;
> -	else if (size < ctrl_size + spad_size)
> -		return -EINVAL;
> -
> -	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
> +	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
> +				   barno, epc_features, 0);
>  	if (!base) {
>  		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
>  		return -ENOMEM;
>
> --
> 2.47.2
>


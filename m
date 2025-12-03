Return-Path: <linux-pci+bounces-42589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C32ACA1943
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 21:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FC6A3001E0E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3A2BEFF1;
	Wed,  3 Dec 2025 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kyarLYQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540592AD2C;
	Wed,  3 Dec 2025 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794468; cv=fail; b=ljm91qBJdeSOK+Bkj+oyeYeWSxgW7Txeqpj9vBdduroINitvEQcjhgJ4irpEMwFsBKpJ9dHvKz5IzaIX8RT3ys841RS06+T/tMuRPHz0pL/oFB5g8E3Yd1tJrlZbujTIzqm0vKktwpalpQzgeTCST3gmLSuIjaMt+1yx+0nYhkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794468; c=relaxed/simple;
	bh=lBiCRyD7NNEIwbH6rVrHuDE4QMLjz1ho9bq1qJUUlWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JfrErqlB6+4Q2s91YycKS8UJPMoS2Yn0j68PlW56k+/UoS6x0oVX3YKiAYNwHX4tdbQIckTmc3nFJblgDH8ceQr5lsZqjssdifEp3YkrhS4YS+zsnyD3AK/QcSKIPcDaO8jRfjG/o/TpnxNt50E0B0SOj5Lz5tIDq4iXNhA2fGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kyarLYQh; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAlF05vQLCubyppPbFpFvYhP8XBb9PPbt3FQc2l37t4Zbi0OdO/KC1hbgYJym5g7Y8JvEljMioeemFdHxHfdZq0ggzxlodyMTYEZntW0Gc6twJKeiK4FfUZug2Au4DrdakmokklTIxpJKVnuXFmIszaC1IGDuZ+g7J9OqqFNf1UWUG0vghXxCy0doEktX/B1pXxlvccjH0d74Cp0g9fno+2TlEx6kNYYuyXNGFCQBxBxdJ1761i2co2uK1UzR2/YCIiyt+WXMEhXe4v2pwLhlB4XpqDorTvrZaY3TjeLHBdNktBMA7gx2rmabHYf6Gz/9kvWOHnUQJ3sTnr6Eu2h3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT9DrGPJIeWCpJ4+G/HiBVqmeDgsASWSbEQOf6wyXD0=;
 b=n7zP5vfIqE4QAw2hXGXK4tM/wfolYOtsUri+DYQwJfFnLciXgv0O71TbKwKMQ43A2mdfIUSAgV9JVmUQTanwtYCAwL1zkTK2xCsGAh46/aCg7GLikp97lreXV7CoR5N8NPdGRmbY7jKs1Dwl+STyMU4UYbv3va2tMzJ6Tzh9+z/8pf3VgRYUl24KwE7yaOFCGU2Sg73emDB2Fl6e+SugNSFi4iVNq5kEu7TEtdTadYses+HeHksDHyBSb/9kU6SchCmUS9TRgXGEeqgRoW2I7Itc6May4Fr3nUkOsaiK7K77d4PaCRAVufzIeICTEIPO3894MUxuhR7Lr4TKn2GYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT9DrGPJIeWCpJ4+G/HiBVqmeDgsASWSbEQOf6wyXD0=;
 b=kyarLYQh27kVkZlmZ6x7XZmNIThWH/4eoWjITj58jemXXdIb1tgv1wouv3G8gYnsKT+uSmGPV1kW5bvDRDEpgXKuw+poz/oGDM65/aj6CRh+apq68GMD7yANW4vfi5xL9rhlFwd63tApcU/1ZDrz8Ux3Q+Hf0GR6mrVQnroKiGwjZ6G8eWao8K75bGXwDiW/y2AvaIbp9lA0TnoIHBFNTNT5w6gV8ENyXtMgUPtLyvXxjPzt2YsUvMTaaz9oKzgFaDZm3tUL7EBVXcH5yXdJfUMeRepMSJ1rABPi4yZVemb7Tgkqe2Peutw43RXZD9xBgn6VamLNlsMgXDLFGivTGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU2PR04MB8949.eurprd04.prod.outlook.com (2603:10a6:10:2e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 20:41:00 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 20:41:00 +0000
Date: Wed, 3 Dec 2025 15:40:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	macro@orcam.me.uk, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Correct iATU index increment for MSG TLP
 region
Message-ID: <aTCgVd3xzIQlW27Q@lizhi-Precision-Tower-5810>
References: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
 <20251203-ecam_io_fix-v1-1-5cc3d3769c18@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-ecam_io_fix-v1-1-5cc3d3769c18@oss.qualcomm.com>
X-ClientProxiedBy: BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35)
 To DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU2PR04MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: b80943d0-90b4-4403-fcd5-08de32ac4509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vJCRNW4V0Rng81H/KQBUiRuUs8qKJ0zYJRnYn0opjcnyXlUSbFbqdmpW+wtm?=
 =?us-ascii?Q?6GInKFbQVp+uBWzfat4LellpjNYTJrJJxBc4Zf74wcEy3DzaEc+x2JYVP5x5?=
 =?us-ascii?Q?jHeLnPOlFiyzzARH0dGRdvJWiy2Qxdvg/8TzjBn39qJv72auPg5wX2MZ9U8a?=
 =?us-ascii?Q?uILnowqJInOv5f69fAVoAE9sH5pBtR2Ez9sn/+J5e2PG8kmGHKDYEInhxvJH?=
 =?us-ascii?Q?IKM22Ya4PAIGN69pC7ooTpwqiDleMLAKUBDEEybxYgXyq0woIvhGOFpwDxz0?=
 =?us-ascii?Q?0S6DIY6iot3FAzVofpSjLxADBjW9GbSrTSl/9IMTv8xt5e+FeZF9sr6F/APl?=
 =?us-ascii?Q?9YbHo2BarwZvzRWSHFl9QvjWiY1wxY7E2FXddAFtuSL0DT01kjdmHkoaujZ8?=
 =?us-ascii?Q?AeTmal/nEdlrq6+qg/RaE/pow8kJn1GmOsXbRwaNah2JsaNxhFrqY6ULp3qF?=
 =?us-ascii?Q?mDcwdZfH0zrw7h0K+F2uGS14zUg72BON5FTUK4hl0mwc9GD3FQJWSY+hS3dB?=
 =?us-ascii?Q?nPCMuNVfOGCEXDIBRApk0abUC/oEIQF8BGOvA54t6kRZM/KVLXHTyq4fMzBj?=
 =?us-ascii?Q?u8MJbs+jKAtJscfAE6Ehd96TzpmBybanvH7gHPbVObUUOfbbAcbP3EwxbC/s?=
 =?us-ascii?Q?vlW7bsvgMkn91Nn5SlIr4NevKTSlwFgCWtTPGm1jEuUhxqUKhQHlGonnnOcT?=
 =?us-ascii?Q?t75nt64wj0W9rLsrK2THI20G61CuAYZtmf6bi9sWcxRcJVAD+8mT9jAd0SgZ?=
 =?us-ascii?Q?6Ltlj1fS3czKdtNGdlluNNCpQ2ttjFVhb+LrK2x5fTwFPhtg1Qg4Ij05eyBD?=
 =?us-ascii?Q?sERNzqU3THR5gWc4RkCHqfdlSjM1+Zp172sUwEGJH0dDHTZr9of3aU3CrA9H?=
 =?us-ascii?Q?WJKfLBzhSQkLEZDnVyg2Df6Jila9DEZWwRXcQfRQ/d1Ofvb6uQUfmPJGIs59?=
 =?us-ascii?Q?+3wFQI5cvtY89rzFYbmQ3jPP/5yItn1EFKSAxqNRYWrxdZPw75NtDKzFJE2Y?=
 =?us-ascii?Q?AbXlbzOBRHnSgbg50tLR+osAqAqwdwDTdbJlcDMHYgHsGHKhO0GTprDylTSa?=
 =?us-ascii?Q?LB6RVvxz98qwa8UGXmobTdthN5GwMZHqvLWGu/fCxALpuvIzwknVifjK1TTg?=
 =?us-ascii?Q?pFVRKC1cTHx1TX8G68PUp9bBL2VBfErVPwTVSAVBrRXbsVuRyzDv1Pb+5+kZ?=
 =?us-ascii?Q?IGwk5zYEedDOm+Q8DJAcQkxlw8w6JkaV1MUcUOPyngBlv/XxGzOCuyVi/+LZ?=
 =?us-ascii?Q?IIPg236R5jSraUSXF8mQOAxcquIk1DiCd3a4vkDEA3E7qsI+L5dbODWKYkqs?=
 =?us-ascii?Q?eTQSK13a0MrK37tpQ9UpqkwO63NEzCK57E0aa6VCFHQnvuh+1nzpDAMg5V7f?=
 =?us-ascii?Q?aKmoRvp5UCqpc00OlgKiTmCD2AJBrNTxyU887GwdZPmCZIETSKJ6S7t7eRFM?=
 =?us-ascii?Q?MNMdUV6VdIzkVjRyO25xE5u/akLI9pBRnxEgR+jUVYyVH8mGH6UfZkQoOkxD?=
 =?us-ascii?Q?2DCAWXDCYRuFa6Fhk1w9q+SYW6ihATfL+Pxl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BSpBpYoGvfRRWPtbKzuaQOqdANQ1SSM+TY0TSG0a5FvwW1A5eymOsxU/YdPq?=
 =?us-ascii?Q?mf6kWcij2H+f1qoQd3uQhoQW2obKiYdf3U9M8C81kx1lx2L9ry7oLcGrKDGH?=
 =?us-ascii?Q?pWfnF6hyXb0ixJsA2hetYOZC52+cB5U6/DgAAyjdJUkLY4iYghPissHbCRAq?=
 =?us-ascii?Q?Xs/Tmp5mJGAN5li1kyR6Z2Fr0h19OyiGV3CRXk7HdstDNUP7pI+EF9akSQPt?=
 =?us-ascii?Q?gpISPdDz149o3M0+wi4uvGF/nDnlUb2qXl9haqHhR9JiwOHiAbUw2w5T078b?=
 =?us-ascii?Q?24haDqshAKKe2rz+BWeB/4NO0D+MKlV6GCpjQ96rOyChlIS9Z7IcwllmKncP?=
 =?us-ascii?Q?yEETzQuBSbdBbqO7GkGcmw9ZnmNAqFCNgOKrdFc4+Z4QQWxeV534TYMcNZP9?=
 =?us-ascii?Q?juegRqdp8s2YA1W9YDVtcRGVhRpjvPQFYuMumYvWCa3rkPh+UgX5uk0sBQVv?=
 =?us-ascii?Q?PYtxtNAxi7VXuL+WhF2hwfQXZVO4/YjuBeO5ANxZJAU7oYETvJaWi9BMwIAy?=
 =?us-ascii?Q?C2jnsmrqFBW6tKxHLPdu/kLMlaa15MkiNVy/VXfTrfyH/KyQe1ZKJ+Vd88R/?=
 =?us-ascii?Q?HEIRcRvEnw8Wa/r0h/cuRtE8XmZeId7kgviKv7m4bdTtJ6HQbkDW3/9v9FmN?=
 =?us-ascii?Q?2PITXscEubE7PmdmMuuatF/qYNLp7xMenkiKUPrAJ7VS23pNnXbz2Zil4pug?=
 =?us-ascii?Q?q5O+iGy56X6iq3GIpvnifo+6icwEuXNT9K3lrT4+SQrpHb3wr5Xts+NLVHW/?=
 =?us-ascii?Q?b21ODwWsm/M1de7rQPIkvqW1CxZ96f0w38JHbw/ocjrXa1PMnygX6zhjEIhL?=
 =?us-ascii?Q?hrdCXMqvHwfZ3yXSAW00a5PXdsm/kVm5bHOB2lUjqDimPGw3ZCxRe8Z2tX4m?=
 =?us-ascii?Q?VCKc9+GKCA3TIZebmBHMo/o0gLnJDlA1YRSUYlE/qSpTqJPHeCjsEKjQXLCS?=
 =?us-ascii?Q?39b2Utl/Yem5b+y4Yp9qiyHvNxWLZMim7KiFTtaiz5xsQSsTbwXzgKbRvfKu?=
 =?us-ascii?Q?QxwrELLSwMpgiYiPBb0dES4bi/G0MvAt6LRfJgCOozPKflcaJZkFnfVwVqY9?=
 =?us-ascii?Q?if60XjC4XuAsmXTcwdI0bwX5QTPCckoCiaPvNCwiRpKcuJsWZUZ/sWQEQj7x?=
 =?us-ascii?Q?dmjwu+logH5N1sVQros7S98vKI/q+yl96x3jT9K5ZSvm0S7hXrb9br7+01WH?=
 =?us-ascii?Q?AodFxvuJI9DI55CxktVDr3TKgRtKCxtfbm1QbGzj2YCEiUOAYOT3WkYyq0nA?=
 =?us-ascii?Q?kG4hcRkRhpF46dr6xi9caHuP8t79m8EB38saqgvvPJiDkW+bqLfoBK01oC7n?=
 =?us-ascii?Q?UYdfMObxE21jfYYB/f2piwzGNEz5T36Iiu7OL54Ud6DorhI5db4k/hNkTXu9?=
 =?us-ascii?Q?snlLNm7jP9VQjHcmrFRqeDvk2hnxBzmnFlpsMkcBYXPwwIQCRlryZGGKjDYi?=
 =?us-ascii?Q?V8eG3yYVCVixFYbLaWL7BHxV1LiPTxZQmrefNnRYbkiVnzB+foF2YdULnYRo?=
 =?us-ascii?Q?m735BAMAOscNESWpFvUB4d4Rv3cBwdUUR/MkU56rILdG8D37ET2PElDFBQsa?=
 =?us-ascii?Q?uk6zFF/aExtxUuYrIh4O7y2VGLLlTbOmG/RKUUqa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80943d0-90b4-4403-fcd5-08de32ac4509
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 20:41:00.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a2aVCsjoSztBrGKIlpUIxqZPoGCLFmttyop2wPJv92Ug/A7v4dYQX2HzNr4pMA08jHZCdkvCikElJnEwibynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8949

On Wed, Dec 03, 2025 at 11:50:14AM +0530, Krishna Chaitanya Chundru wrote:
> Commit e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending
> PME_Turn_Off when system suspend") introduced a mechanism to reserve an
> iATU window for MSG TLP transactions. However, the code incorrectly
> assigned pp->msg_atu_index = i without incrementing i first, causing
> the MSG TLP region to reuse the last configured outbound window instead
> of the next available one. This can cause issue with IO transfers as
> this can over write iATU configured for IO memory.
>
> Fix this by incrementing i before assigning it to msg_atu_index so
> that the MSG TLP region uses a dedicated iATU entry.
>
> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Thank you fix it.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda51bde3a7157033ddbd73afa370d78..4fb6331fbc2b322c1a1b6a8e4fe08f92e170da19 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -942,7 +942,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>
> -	pp->msg_atu_index = i;
> +	pp->msg_atu_index = ++i;
>
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
>
> --
> 2.34.1
>


Return-Path: <linux-pci+bounces-28013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD616ABC8E2
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4997ACB11
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66152192F5;
	Mon, 19 May 2025 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a3QreWxV"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C01288AD;
	Mon, 19 May 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689150; cv=fail; b=a+mafEfyY66p/y3p8BRvlP51BYEiSvNAZ+IQrVu0jnRIjCm5UaZPanTX1b4R+8MEhnneVatAAqvKUnY4fhvrk+WMas4tXe7afibMkCk7pscB1d7SWUgx209K9AIpY+Je4806WGJ0fURGhXubqax2mJw6hx4S1pse1kiZcu+/FTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689150; c=relaxed/simple;
	bh=JQ8lmoOU4zDoqxj5IAcdsgkd/v/Jn68erq/H6dwQxAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qzrXpbkZSayHmSNIQyKM01Pff1NG9KTktdt+gfj33J6nTLsNmA3SJIeQvnGXCO5U9hTe71J7e+6wy62x7oX+LvHxjr8bwqmGimLawdNoh4OB3l4oSm2jrDIIK8T6phcU4ml3lz4FIpOdSJuMetlb44UbHf3AVe7pgTFZLixSx1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a3QreWxV; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut1FWh/eAVG1/znje23+74IDlNLqK00mwWCYrLJYvDT/jhIISHcDZUcjqsJE/UfCs5+Flemxp1QUPdt1VRWGECr5A168pSucHoFu+zHlDzKq5MxiPK+arwDBq+XGOd03hje0Bny3A3AWEz0OUUNiWvwcfoDV450c6LmT1tnlTDxcQ8EHVlyMOHcUk7z1ay8okCqIReIPUEQC48fQ1byyK895bFMXnC6E4B9JErIDOv+vm48kbrSref4BykApsby1LIjDBtumsCmCvDIRJNNVUhOOeL+9+qrC02oLBiNsleR+Z9vGzWwjLDsg7DROk0pnkwtNRCKgpjVRl226m/hc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am9Sg3DXFAfUhcnXnupGy62LUJj9J0fOwBvd/uJy33Q=;
 b=mBYv4odasxZLmp2bDEipM+ze1YpCnLfUvNT/hbhQBfqBpIT8EWMnVtzFGAZWoVsBPgbIHaXxBTJY8LLMgxx2jgxA59wr6d3xlZlwxeKIsgelh+naoR85PXxypAxshtZLk2tX4AfV9ioVllfa/5ERlfDvOCCRJbAMsBua1NlmG3bDu5BGPXWk2xVVgwTHnQJqY8BWULqcewFOXi5g78ZpTMMXxNzYH2EB8eXPHzWKZ17xjn3imhVZZO3xauyvplHlPZ5BFXMdxmyrWnmTBfHdP1mE5r8mFnxe2OAiXOj5Ts06ifRGypY7xIuFaQsW9dY/UpQHdQX86cpUEmvsoKWkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am9Sg3DXFAfUhcnXnupGy62LUJj9J0fOwBvd/uJy33Q=;
 b=a3QreWxVJYxl7CfGiEkwXbhni9Qh3L9Xk/w8rrSC3TCMmmzhi6VoduuYiP2QXOvGcTPPAmjUIIK8irjspRIrg+dfetvB2l/D9ZPrNBC2dwSRAGlLthR/h4ApXVXWiVEGz6+El4GhvlIrLYw39j3z4u7wXxJ+4GPJgYbTvWZEjnnOY1+tdCwxh2D7sElGafT7Sx2CssmphMLozkYiLpAsGwkSFurn61GVK6CO8N0CqUQkM7UpzkHU5mdVlZFJNCCG/iFRTlwU+B7+XYVKqTBP74lL0b5SjBeJuK/wVML5WcaQc1Hkou/6m3z88yjZQ7VYsLs3VwpSrc8OztX41zbsDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7401.eurprd04.prod.outlook.com (2603:10a6:102:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 21:12:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 21:12:26 +0000
Date: Mon, 19 May 2025 17:12:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: endpoint: pci-epf-vntb: return an error code on
 bar init
Message-ID: <aCues6UrqlV0pDfw@lizhi-Precision-Tower-5810>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
 <20250505-pci-vntb-bar-mapping-v1-1-0e0d12b2fa71@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-1-0e0d12b2fa71@baylibre.com>
X-ClientProxiedBy: PH7PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:510:339::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec195c8-48db-4f92-ef40-08dd9719dafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4IqRLzHitmynDJ0pEk7ZZ9McfScQzicwht9Z1u6lxaVn0625UeenfATICcZ6?=
 =?us-ascii?Q?0Wt3kgxSg4ldojcrVb0wWgYHtACSWZcsU1+c6xlE62FVN+i3MReRy0z8cFG/?=
 =?us-ascii?Q?xIhYzA8+6JTfLbdvnxzhFbP9ruZNvmoGlW/z4eKl+RYtfrmIJXLCatOQE+nm?=
 =?us-ascii?Q?VGTDyrgJMmO9u8r0ET1EUCqeSaCcfvi7WLhQMtq8fAYmM2P3nW9aK55NlGNa?=
 =?us-ascii?Q?BIJ+Kpziz/b9sNxk53vcUzLal1Ck9KsRsKAo2Oqw55jjsZhfF8AW6PpbjH5h?=
 =?us-ascii?Q?yTeuoI+rYVb8shxYVivpT7ASsAWVJbl5MxLJkOYsIAvt3IiPfalW4s3106RK?=
 =?us-ascii?Q?XFyk9hnoaDNESGQ794p2fLKPogCaeq0dqVEEmxXdd1+nesWUJpjNQX7DOazn?=
 =?us-ascii?Q?sFHpKGH7zYA5X46UWXbzel3YXjWQJaLfu/4/vOZwZ+apgv8n9z6/YptkKf+u?=
 =?us-ascii?Q?HMlHEMPKf5xXSblRGmZFsgNNWaARjpg7I+vfjFfFAc4jmQH1PCCf7aLS9uN4?=
 =?us-ascii?Q?oDrRszuGWfuwpgov2ZD3Lw5KWYYW6cYgWANp2GfrZvBBlTdgnG2U5ZxMteU8?=
 =?us-ascii?Q?HoXEQdOAKx5hF788j26FM93/yfyOiuUrDTDAWXR5IW4wvsc56mJC1h2KRWN6?=
 =?us-ascii?Q?JNIA6dC2t18OffTu+Dua1EfOBRkfWj7STRMC83UKlpeOeg7Xrd8mfAyM875g?=
 =?us-ascii?Q?s6yLB6u4MLvMGjP3aGSM9HxdOsKYmzXGUFxC6IiWaLhGRYY7NK2qIYPaIqNv?=
 =?us-ascii?Q?P4HVW2gW7wR30ifOf9xnGi2FvB+lGmHbwYhog3BZO2D401upZAyQF3y5zoMX?=
 =?us-ascii?Q?1S7+L/pnyJil+lPVeZcAgkqLcA56x7VTQIrev6PFQVixAxo8MzaCeRrEjUTh?=
 =?us-ascii?Q?FSy+lfn/qBscAiUQa+Ppy3T53tNI6FM6gN0KM2OMtcelckrzUlyC5Sq1ScFG?=
 =?us-ascii?Q?8ocXMwRP9e168vjHPIU/qll7NYi2n5cfwYyPu7FzCW1bAhuR50dGXP460NRN?=
 =?us-ascii?Q?tT6jIpkiP2Mk2qjIjmcxiEa64jFspGl2fsr1MAuLq2+lHqXS6hwdMIz8FNhB?=
 =?us-ascii?Q?FmnvhkhHpjPgG7IEtN4Kt6/RP2ljMg2oNn7mJNtFz1+hKjXrSc6xCMs5GzHX?=
 =?us-ascii?Q?WHWaMrBZw5faDa8lA7O1QYjtgb0bkRJs8mXgPgDzOIJXsjsj+XNIjPVLlB74?=
 =?us-ascii?Q?7y80elLUV2D0INR69YWq4Cs5MkEgNnG5H3Khtb96xaMmlx0ESDyRB5K72SOE?=
 =?us-ascii?Q?OVfZ8lywbNWsRGirrwirD365pGuvNJ+iqNiKJsDQyGgSb1ukrgxtJsGx1xz7?=
 =?us-ascii?Q?4C5WbcwCa58nJ8APUkIRioA1f4PDHPy1Krc2nSgBWFfBudz8f4PVxrTkgz99?=
 =?us-ascii?Q?kbm9UR7q9IQbuLI7I/gv3r5AWyeDKia1JaatWbCi270kkR89/rw9uPE6teGZ?=
 =?us-ascii?Q?hc3JEQIIZk9lWkvwYLaIlQ25/djfqFMhUuZ9GKxmdL24Yplq7rUbzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmyMKPS281VkLyC2vMUtqgkVMWl+L4vA9TBOtMCKV4r8TKO6gub7X8dSLoBp?=
 =?us-ascii?Q?FTLe+2rEPdYOZoTFRywBsHhMsGS/+XFzMPfR8MKSwK+qDbhCx0yrJnwjdzCS?=
 =?us-ascii?Q?sbBOFOobeRMe5F0Pl4ou1+1/6L7RUwxY1kc/ghTnw1NJElhqrbZFTTN5l/0I?=
 =?us-ascii?Q?VPaYqigw5FAl2o/XNdO6cCxxbcdeshBnzkA6wOcMYL35dPICMY0p29oyCWJK?=
 =?us-ascii?Q?3tLdpmWTuGeIe/8tCpKguFoDY/IhRgcH09empYbx8I3OjnQnc5+qfMr3lFo1?=
 =?us-ascii?Q?tm8n4BcseVRAf1VZPJwG22bwpLj1YyEETxOpP3AOQP+cCedykQD4KI4SA5oh?=
 =?us-ascii?Q?RtCjhZT/DjxMwKCJ5kPMcucG9Uj0/6RDeGtpjCBdIRuwO6UVlD+jtGBU3Pc+?=
 =?us-ascii?Q?MWAdpBxNE4lfJdEK42uw3TPYBfnJEdpS2i5vJYeyiX6rBkA2uixd5VKv9Pfp?=
 =?us-ascii?Q?Rxt+hfa17s7I6cTj6t33Fact0E118+v1icVPAujIUNNDqAa71Xppn3WbufpV?=
 =?us-ascii?Q?D+GKOWyxisSwvIXsSy6f+YOnyV0EH+rXdMDNTpEbpfrx+dVq4wur2zPbo/Zr?=
 =?us-ascii?Q?gaAsJnV7cm9c1WE3OGGPRDHQCntiDQsluxUt539Ta5mfOFDwXeM/1TjLuoWJ?=
 =?us-ascii?Q?97SFCNLWVIKsnBdlLRGlnmU6VsgYHYkFF89erpIPLjhquK7tz1CkjZ52guR3?=
 =?us-ascii?Q?p9x0h5C1W2PXXA4GLaXl/j9UdaI6sCcf2SIgmsKskv/TghsX/H/nbUDKa+TR?=
 =?us-ascii?Q?BIWDH2pEvIY3gwugGgZh5CBAx8rNNzRBe/8F05OG0vBW2WWbC5mTCHUl54XH?=
 =?us-ascii?Q?DijZBRVukD6n4YKWBXNSacx9THDAHAHe5TmWRUc11VU2Fkrsr88DwoEXEHxH?=
 =?us-ascii?Q?YPrQtGessl5VLNbuNvuo3R1wME1rdFKxqgdkIdz3K4BeavptNCZ8SmkmR32Y?=
 =?us-ascii?Q?fedj/TyraEFLkic7FubFpFV/C2h0Wc0rpd4DlRWNwqXZQGv2VNmX3Z6zo+xJ?=
 =?us-ascii?Q?ibm24kgFndbds3bXkkKQzB1w6rIDoC9orZ0ya3EKBUguCwQM1tJZF1uh9l66?=
 =?us-ascii?Q?J9G7uXjtZX1oEZPs5TQtgINo8eUgOcxf4QX+FJvvzgfeMtGRqrOLo9ML4Bjv?=
 =?us-ascii?Q?urfT3DuQVjozP/T/CgyDpwVLo20pMy/UsFiDmC+ZoA6zLXW3XAV6f/AU6WL4?=
 =?us-ascii?Q?jX2wM0yD/fdlke+ctKB+SHrjgWPxsITkB3tTFA02I3QjBcAirib/JwoPc4zC?=
 =?us-ascii?Q?cdJxsIUyzxGFaG6pTPILNGh+4uFNVYdxJ/wA6/80OAKacy/em7czjHhqf93b?=
 =?us-ascii?Q?mxEFlvlNmeLyiqm7NBccq8CGiztPTxlA7lLHsU0dDtf8z5hK2eNuX0sNf31b?=
 =?us-ascii?Q?ps6+2qXPBW4RgWfGK3L6SWOOFSYkoBQU0oyCb0nzft1MpTO7jnjs3QnnEg7G?=
 =?us-ascii?Q?H1AKUOwN8mujtz8RVZLDWHKZm36zrdD2m7VV4GwDtPE2XolWpcai+TlcN0yf?=
 =?us-ascii?Q?cp/RTSRgLLbLdsY8Pi7fzu4vzpKa1bbcvS3X9Cmm4NWJsMyG34Ns2GNz1231?=
 =?us-ascii?Q?kJdXvjnwb6EywllEXMAlmwicCkVMe5SEKxdAnQgC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec195c8-48db-4f92-ef40-08dd9719dafb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 21:12:26.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfsD9pNGhy/vv+Q6eHfHuuWy3I9uunwtIItLV3kyG8zLdVlXFZAquoZ9J2sI6k3Uemk6WYqtEfaL/Ak2V9iT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7401

On Mon, May 05, 2025 at 07:41:47PM +0200, Jerome Brunet wrote:

subject: s/return/Return

> According the function documentation of epf_ntb_init_epc_bar(),
> the function should return an error code on error. However, it
> returns -1 when no BAR is available.
>
> Return -EINVAL instead.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

After fix above small issue about subject.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index e4da3fdb000723e3adad01f0ddf230ecc0e572a7..35fa0a21fc91100a5539bff775e7ebc25e1fb9c1 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -680,7 +680,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  		barno = pci_epc_get_next_free_bar(epc_features, barno);
>  		if (barno < 0) {
>  			dev_err(dev, "Fail to get NTB function BAR\n");
> -			return barno;
> +			return -EINVAL;
>  		}
>  		ntb->epf_ntb_bar[bar] = barno;
>  	}
>
> --
> 2.47.2
>


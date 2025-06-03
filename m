Return-Path: <linux-pci+bounces-28909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE9DACCDD0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D2B3A3D5D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5A19DF62;
	Tue,  3 Jun 2025 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ExSCtpxN"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EE26AD9;
	Tue,  3 Jun 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748979975; cv=fail; b=cFdovYoP+DG3kMzVBf+IF7v/IWHiznMlAZpMC9IV0S3iP1pFbR/FyoHeK+fUPUoqz42koc7J9WyaEp8NI0DkkCbI8IIzjmbqb76KXqwNsbthLMe/jO9oPexrVf/P9h47/uQMXzu7u9lVYtMQOOjCgBYMABA5OkNzPuWCHcSnamQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748979975; c=relaxed/simple;
	bh=rxOPA+O4icH8OVM5S2AOTYaNvaAV5gotfc//H+Q8HMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G5EsFLfQqY4rp1ei/4/0+Q2kM4B43FYryws88JR2wESGWenIfekjL+jJxJMMcwEhxvbAhfltxZuUvxXmWTCrxYD1Vn2n9Pk5J87aDg24vOv84GHB51vPr8rGhg3CZFWVNDRMW4Ln6e23ug44JnYZdgWPITRdRlAWtIWBKLiuF2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ExSCtpxN; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVzOX6AkyoLkWekBcPz6T3tmrr3/8Jz9+SpaIj4WDkHzfbuiCvEmgxTS5meADv4AKiLi5nwO9O3za/ZPSJabiASm59YOACN2rd+B2a3aNvgW/gJJHB+0NpsztKR7GOqiCK5h/bdeIWKlMXWrdEA9dumdPV62SupD5leb0aigiuAHGPW2rK3e3ICS5puwQvIIuH3VZ1CKNW56x8WHwgCkVKcF09YHJ8j/ly0uTIhZKRBTOe7VkFKvXDf2V6wmO6tHCcNg4VbutWEHlYJl6g2jYFeOuaAMkeQGx8T9hkPJyfCR54wnB3BytmEoPZF5M0EIsmd9Co+zZXXjgHe69tsWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKV+plGTJn/B3ECFEiQhG7lHMQN2BYNxXw8Q6rG/gtk=;
 b=IP3h5NyVu1zm7XM4MQfXbSei3RvGi+Rmh3SPzVgmfmfRyBY8/w2mreYs/7l6iptJbLHj1HCzSd1189TnTz9EItyq2W5RTQWnaLIm5xWIKX3bO70PIrMg4zkySQriVmlGGf/enXWuUVYvEE2cYZveZi3A3t0zcoUdXqg+pQMwCTKsG+GyflJFy/eeiQtb84Izt64LfPMSuAKdQ29UFvY289QojoVIs8N3TXne8mH/VRgtPw78Oq56GyafUVD4sKEL+EGniByP56+EMgmXewnjI9nthzKleHed0k+hP8de2/RgN0Nl3mGdcdX5w8Zf+SR4WmtlLrrpagRsjhXbLae87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKV+plGTJn/B3ECFEiQhG7lHMQN2BYNxXw8Q6rG/gtk=;
 b=ExSCtpxNtYYQ4Z0J1YM5zsvQ79ibneFG+G9DQYDAbn1VKDejqO974vtJuZ8X0GCGCmakWyTpjqeLFrmhZde48ajeCQz6nReQKlyGmIIWqQVRDtgDKrbKb+PDaXkiTIXFxUqe4eG4tU2J1ErDC/PT7ffsxYmvdbjGsyWDqlBJNse+5yeq5U9/pLSiSSr9D5JadKl/WvcuTT+mnyBIW3Mp6K3lSf/BFgcXzokwUdYDJAfxuyyxFcNxgYhrBIMfARHKiebQKOM6aXAyF79fFkHXMmW1KBHO4qJt9+7zrL1Z01sYNhoo2tN6FTmGrf8iJ9XvRRDN7rKU+y5mm021c+GnnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV4PR04MB11330.eurprd04.prod.outlook.com (2603:10a6:150:29d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 19:46:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 19:46:09 +0000
Date: Tue, 3 Jun 2025 15:46:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Allow BAR assignment
 via configfs
Message-ID: <aD9Q+sWtRL7Mj2uU@lizhi-Precision-Tower-5810>
References: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
 <20250603-pci-vntb-bar-mapping-v2-3-fc685a22ad28@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603-pci-vntb-bar-mapping-v2-3-fc685a22ad28@baylibre.com>
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV4PR04MB11330:EE_
X-MS-Office365-Filtering-Correlation-Id: be23c894-28b9-42c5-e3b7-08dda2d7497b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFgVSBG5c/s/wnCo3XzDvT/v1ZHyADHsDjB/bG2BlRs1pWlcMnWyJUOiEAM1?=
 =?us-ascii?Q?HnLD2apXACnWVeCa5dusHycS7SqVb/zrVnvZ6XNqzQ1LmgtbLK2zFUuYS06B?=
 =?us-ascii?Q?GwOJkOV22lIwSpWqh0v9wgU/0JHpjB0aVSZKu2B3r7g1EFCUzuCCoUdX8/sY?=
 =?us-ascii?Q?gJC4f1YP2BajrOkZJnlfBGJONQg/qkAnsV3o35pbGJKgV4tYXY5UoiwDHtQX?=
 =?us-ascii?Q?yawC1CInNy7WAWiPFf4L5NbCC4nqQaG7H3MfDa66C3rgTnWJKN7yRJiJcYXB?=
 =?us-ascii?Q?Va/+C5Iory9hB55hk9W0M/ov0GzSY5QGqEtCkaujOiak38cpfBF4G/5UhIP3?=
 =?us-ascii?Q?quFgLyI32danZIQVIOq9Bu2zVQOIvbHDGY2/fjwCyOyxd+7KGziDKMoRm+va?=
 =?us-ascii?Q?PGhe2ZEjemMH2KaqpTuc9ctaX5LqCFEKeA8pW8MKnG+DIBIbFxRoDVr7usho?=
 =?us-ascii?Q?+DuF8DtraD0nMVfV0HgIyvsolwcMlnbmYN10/l41si4oLSQ+7LNAKfOkhZ+I?=
 =?us-ascii?Q?saQJj5/++YdMkLCFFDpsPvQ4rDsbpZkkeGUN8hhVD6g8OFx9nQCXnJqz6PMd?=
 =?us-ascii?Q?nwvc8dIqxm9WgrnUB3YURlDOSbg5U5oE4XV3UoYqmpdxhQT1Pk2ieqYV1cn1?=
 =?us-ascii?Q?i2cxDjl2yXRxSXpfZXb2a0ejqkxJV2Cl5eUNaw3/x/bSxfTpg9zdVGlzM3Kj?=
 =?us-ascii?Q?CYW6Xzz15FprDl6jL/A/1hhNcjO+nLpHiXD7ZB2FK8NSP8/q7bX21m4NKL+v?=
 =?us-ascii?Q?KndwOB9sNgo5aIMdzTcblwjbPosHfz82gbeRNBPRalTrqLM1vHJaSEJujLt2?=
 =?us-ascii?Q?XpZHniVOkDqqCPw+6Nx+pXrTNct37KkkESRxNH/zajSL1oOEzt8JL2c7p8Eo?=
 =?us-ascii?Q?8yCo5YtVqIcDNN0wmx8y3f5mq09Jb27aj9CGYa9ze014om4saNKwPMjCqTGe?=
 =?us-ascii?Q?wNmBam3KvFRA3PbuoJaf/aGLhJNL2C4SrKEA4C6x7sOlsYJuUckBKA/qOddZ?=
 =?us-ascii?Q?ZIIvg1uO1RTAs6Ya0TlGD5opmJBuw2sjkHE7/Mbpvw82HKfduTmhRTKOLx4H?=
 =?us-ascii?Q?sNfG29lYJ6YL5fnmqxk8Zk5mthmDu0dx7TB0occXIw2Dn5TVYM1Aq9OwF7/H?=
 =?us-ascii?Q?qyUXCTQyuzcrMDLQYE6XrGHBgE3naYm/NHVP7UAy0gnEjzHfAWIsy6ayl1N3?=
 =?us-ascii?Q?bLw2UgjsGm80/lp4Ruefe7jWxGdRtOa1t8Nykjg7Wq8pU/LGcdgu8boS/PFs?=
 =?us-ascii?Q?hE3BJGZVZFzgHUJTige6runTfmNORhHtiyJb4y+udeIYjNzYtTq+AInBxf4L?=
 =?us-ascii?Q?CInbFJTYlgzCGFpwiZLRWzsl80DPPQQNfK71lkFNWSGFB9p2vlFeq9v309i8?=
 =?us-ascii?Q?oc/tNwRlPixSm3AnRc13SOlUB3xcOfVoNOoQyb3VlMywMEvRm+MgPjpTxkhd?=
 =?us-ascii?Q?YKOoMv8cxinQB5dGbbGpjwb4bBRCkvR3gTb1ddRESIxwur3CX8BozPSknM+f?=
 =?us-ascii?Q?hh6bJYLDzNCAD80=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQOs8R4zOrKo1F9YMp4p6Doh41zAKymlXyMEq/oUarMumpPvxnSJAZ8ThQ+e?=
 =?us-ascii?Q?FQeAVl46SdTXnx8B/uCiy3UCtbPeOMevcLQ/JbgWI6EEH/UzkTCy6uV12yrk?=
 =?us-ascii?Q?5IOa2LFLDcbZfrD3FzgUytIq/oZgRZSVcZkQTSW+p5AUX4yyete5KFQvzLcc?=
 =?us-ascii?Q?RBr/soSNgniV3r+uPrp+P3AAPsPUzY8kB/qEg0m9WjS58oMBsI51Q2rNvmKJ?=
 =?us-ascii?Q?9ZrBcerzZkCHGK+F53dCDVqic1XeLrXmPRpBSVqJ9STdDGJqpiYOD0K+xLC4?=
 =?us-ascii?Q?fWJNTrW3gwGsBKU8l0Gnu15YRZ86EQegVJtV/5Cg3Vj9E+jvlxFGRjhyW820?=
 =?us-ascii?Q?uw+D75inFMZDZWRH66QJDmy+6T8X1ohbuTAA9ux3jSO5FRHoVLE0BlmsCT1D?=
 =?us-ascii?Q?W75kwxJEbtycpVrrbniMpFRIshEMa5Hg52xXDDQjj3lKDqkHrqvogVQZfKWR?=
 =?us-ascii?Q?f6C27jBTZVxa3n4d09Sq2kkIuPgkNPl9l7jksMYU5XdcUO8sxbi9wDEG8Xeq?=
 =?us-ascii?Q?kOm6pHp9YIE4K0zBBl/cFpCpWNtvohiQFMKcyA8ufdqoi8qkM5RE/BfHbVsp?=
 =?us-ascii?Q?qnDqUiRVvm95gxZv8tSc3W5mfcDGHO95+GZklLO9SEDGVj/AYzdqfIn1Yre6?=
 =?us-ascii?Q?AdFe6hwUGK+ctBKN7cTP4syOUE62XWnLlSFOyCRMX+teWpssInNTvkClRbuj?=
 =?us-ascii?Q?2rgeNwxMTgbrWqABK5pr1BjIdD/4K8XsTFNR+RnhyH8cEZhxZTEV5sj23gXb?=
 =?us-ascii?Q?uvOBFIuK8QgFalq7ruOWjXjU3Aty4nJZGT5hRXuci0hEAVRaN6HrD2yF7phH?=
 =?us-ascii?Q?B5dDQXblOTAmYuzg6EdrnD81CgB9g+Tp8Ywk+qaeNzgWlg3ubyD0ANc0poxk?=
 =?us-ascii?Q?W1XTWmzxEBID5FnON1BxTZypGKyV+z4xbmo8k+VfeCwWrTkMTx194Vo10PzG?=
 =?us-ascii?Q?vU0axAQfBVNQS6Dp997ixaeUHtHGEN/HrP8LfFurYqn1jPruWGU8XayntrH+?=
 =?us-ascii?Q?MDNIoiHQ0DvJMdMv/U9islAWILVvFWr7ItDCElWjCdCrGP6dNc7fgrOhOoB5?=
 =?us-ascii?Q?KXk9JGyOWaGKiL0AnNMDxCZAlfkROGZ458pFADK/QwG54InAAOfESQKRIBdR?=
 =?us-ascii?Q?2A5HqtMXw0CvV1EuBPrgQAeoz1R5Zxmm9r578Nomij/0kAGZpARdsapPq4cu?=
 =?us-ascii?Q?sKxkBjvm+eC8qvh6g3ZprvyT88GF6FZuTvdjEt+KY+GlH/gWc1CMnOlG6E3x?=
 =?us-ascii?Q?GploXnVtvyKMp5F2f1KLV0XFxfDfGA5rf3oXROXfrahSYsTePWY6nu2oiFWK?=
 =?us-ascii?Q?91jovlIIinFPS7fRheZrtTzM6X4ncEFjU5dnYkvNDzefebJrTaMTyOvaUDkQ?=
 =?us-ascii?Q?MyjjiOkXypJDRvLRytidaUwnXA7E5hmWxD80PJDTBJVW14Bavgw/P2DJjj4c?=
 =?us-ascii?Q?EN3iG43uY1j8URiVyMvg6CiXrYi+mJXdJmDQ67tdIYRtVT7k98daOaH5gToa?=
 =?us-ascii?Q?PTzjthqepYzsBmIbr7KQhiT2cL3N/q/utKhl+4l1ozXOBxUgHIsTVfZgPojC?=
 =?us-ascii?Q?BIBHNSA1FhfLir6K4WDideRglcI1Fznj4Ne4K342?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be23c894-28b9-42c5-e3b7-08dda2d7497b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:46:09.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8c2JkGDxCW4NI7refvZovZ7x8r0eU/od3u3cSuAsp8uQRxdaWHPeccD4OWQ3OfJEUhXbVFCT3/GMyVNOj3t3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11330

On Tue, Jun 03, 2025 at 07:03:40PM +0200, Jerome Brunet wrote:
> The current BAR configuration for the PCI vNTB endpoint function allocates
> BARs in order, which lacks flexibility and does not account for
> platform-specific quirks. This is problematic on Renesas platforms, where
> BAR_4 is a fixed 256B region that ends up being used for MW1, despite being
> better suited for doorbells.
>
> Add new configfs attributes to allow users to specify arbitrary BAR
> assignments. If no configuration is provided, the driver retains its
> original behavior of sequential BAR allocation, preserving compatibility
> with existing userspace setups.
>
> This enables use cases such as assigning BAR_2 for MW1 and using the
> limited BAR_4 for doorbells on Renesas platforms.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 131 ++++++++++++++++++++++++--
>  1 file changed, 124 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 2198282a80a40774047502a37f0288ca396bdb0e..7475d87659b1c70aa41b0999eabfa661f4ceed39 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -73,6 +73,8 @@ enum epf_ntb_bar {
>  	BAR_MW1,
>  	BAR_MW2,
>  	BAR_MW3,
> +	BAR_MW4,
> +	VNTB_BAR_NUM,
>  };
>
>  /*
> @@ -132,7 +134,7 @@ struct epf_ntb {
>  	bool linkup;
>  	u32 spad_size;
>
> -	enum pci_barno epf_ntb_bar[6];
> +	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>
>  	struct epf_ntb_ctrl *reg;
>
> @@ -654,6 +656,62 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
>  	pci_epc_put(ntb->epf->epc);
>  }
>
> +
> +/**
> + * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> + * @barno: Checked bar number
> + *
> + * Returns: true if used, false if free.
> + */
> +static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
> +				enum pci_barno barno)
> +{
> +	int i;
> +
> +	for (i = 0; i < VNTB_BAR_NUM; i++) {
> +		if (ntb->epf_ntb_bar[i] == barno)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
> + * @epc_features: The features provided by the EPC specific to this EPF
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> + * @barno: Bar start index
> + *
> + * When the BAR configuration was not provided through the userspace
> + * configuration, automatically assign BAR as it has been historically
> + * done by this endpoint function.
> + *
> + * Returns: the BAR number found, if any. -1 otherwise
> + */
> +static int epf_ntb_find_bar(struct epf_ntb *ntb,
> +			    const struct pci_epc_features *epc_features,
> +			    enum epf_ntb_bar bar,
> +			    enum pci_barno barno)
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
> +
> +		barno += 1;
> +	}
> +
> +	return barno;
> +}
> +
>  /**
>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
>   * constructs (scratchpad region, doorbell, memorywindow)
> @@ -676,23 +734,21 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
>
>  	/* These are required BARs which are mandatory for NTB functionality */
> -	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
> +		barno = epf_ntb_find_bar(ntb, epc_features, bar, barno);
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
> +		barno = epf_ntb_find_bar(ntb, epc_features, bar, barno);
>  		if (barno < 0) {
>  			ntb->num_mws = i;
>  			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
>  		}
> -		ntb->epf_ntb_bar[bar] = barno;
>  	}
>
>  	return 0;
> @@ -860,6 +916,37 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
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
> +									\
> +	return len;							\
> +	}
> +
>  static ssize_t epf_ntb_num_mws_store(struct config_item *item,
>  				     const char *page, size_t len)
>  {
> @@ -899,6 +986,18 @@ EPF_NTB_MW_R(mw3)
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
> @@ -910,6 +1009,12 @@ CONFIGFS_ATTR(epf_ntb_, mw4);
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
> @@ -922,6 +1027,12 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
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
> @@ -1379,6 +1490,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  {
>  	struct epf_ntb *ntb;
>  	struct device *dev;
> +	int i;
>
>  	dev = &epf->dev;
>
> @@ -1389,6 +1501,11 @@ static int epf_ntb_probe(struct pci_epf *epf,
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


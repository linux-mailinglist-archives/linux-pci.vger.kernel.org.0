Return-Path: <linux-pci+bounces-12380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56568963003
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 20:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C341C220BD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01470156C40;
	Wed, 28 Aug 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OvdxtzW1"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086B1C69C;
	Wed, 28 Aug 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869890; cv=fail; b=Mr9I60d/gzRWsPk9hNA3HPqCUiO9I3FVp6Zvthyweo8Z6QRY0xBUOEYBGEFWBKqPOyBj1b2ATN/XshxQ834uBoFcPye5la3zHewKLNa4AOBT6WGIF53e2TEc24ntM1ai+0YnXLOUCagKIZNztmCWepBixnTNqaxDP4nBVha700Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869890; c=relaxed/simple;
	bh=DAdn7UuxjqDMrXHi4WKb8HqYHN2zXpsxMYurallnF+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eLix8KbrCBkg6JhbA1LwykEG/+ZTqZSj0DdqJWHJeWUsYsAyQ0C7IJ601uOBCFwbs1HNRCRSbxKac4E/iwf4P4OacCH9ZqPa09VY2f1UOCxlvPgxjaiz6yrFbOFj2dFAbRxfvuCLOQLqQFz+16jvVLi5/JekNGBCUGALRKuEyqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OvdxtzW1; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMM/Ksd59nxou5wUj5ECLq1lpUQyH969Ifrkmo1xaxAd/NmxZwq9T12Hj0w1M0lmFTqaS9DcmT3nae2fHqorzqEJZBvSJBIdfTrx4jrM8Z7aP2Rm13BbLEI/tdjj0Qlm5UyijwG6lyXmx25XBrvnF62DcMgKaG5Gw5VI9AJkF23SoMHffbrRxu7OqTtBcAGTOzkT09HovDrgDiKiqRaf9kssjb4IZvHgTR6Xmwe7kTcwZZRLmXqepbQ/0kO1oGXcnFnO1TZ5pr+i0y4b0BS3SK23aDbeoKBUUfD2VBcY0RWir4HS6z/cBnjrkzCDDn655Gwr3HJmJ3LXWhEGDDfP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp7Dt90MBSx/taUC84rBQbgl1JBNb7Ezk/QZoSCFZ0k=;
 b=Qe/R+J/3XOdPVsAnKtsybS3/W2Gpa1hlrCKYm1KVIC+bHikDmlPBP/gBce45or5I5vDLSdMurlK9DmxpCb5bh58eNBRMuCTIuqK9dZ6UVUIAxfapHofTJGebb9/6cACvSvKdwXmI1oa346SzseGcrpKA1cGxCXZvz28YltOZRrcBRZPb3S6EMczb1gzuFdBuTbCMHNrfBxahWxpURfvgfSh0yLl994sP7KgURgTrNnByZg0chNEEvFD9vPhv1ZyR2NS/g4nMaKbpS5hFlmexgwtjK4N3kir9mil30CmxqxGmlMftmKwOmMhU6ckxUDfJMi2dAFCtapptNkVIlH2Quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp7Dt90MBSx/taUC84rBQbgl1JBNb7Ezk/QZoSCFZ0k=;
 b=OvdxtzW1U95u6G2DsqOJJyhY3/AcnEZqU+M64+ZpxQ/92Zfv5Y2TIGAUSuhp52l/J/cU4KwNRMlYkBPQDxtRuJK+y+GDRSDQx7y1FYTYOWRqQgjkZSdl8x7cVO5R/1LhdkLGVuVV/EbHO5hbUETDVyQnarpOs+IVaRucThyfPN68KkQ1poEJMVfHWH5EAXYBU0vgYxPYFAxPLnRfGJf3fX4K9YCBzkCnhhz8jeRTkFf9W7M3qpB2W1V997xQbdOvwouwKgPlfuy3Dm+RSgjFZvP6qyJwJkcK5X50IoXu06xuKda9kwlBdkPzGEfayCdOJVFMsKqOnlCgX8YHlIIapw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 18:31:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 18:31:26 +0000
Date: Wed, 28 Aug 2024 14:31:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/12] dt-bindings: PCI: pci-ep: Update Maintainers
Message-ID: <Zs9s9qJynqxRRICq@lizhi-Precision-Tower-5810>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
 <20240828-pci-qcom-hotplug-v4-3-263a385fbbcb@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-pci-qcom-hotplug-v4-3-263a385fbbcb@linaro.org>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b194c2-af92-4060-72dd-08dcc78fa057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkD28foTNEJrBRgNjUkGmrhLVyWzX6ZtsHSOldn9oOxVpHOVgBp3BJ00jgBt?=
 =?us-ascii?Q?t6sCRY0PN4HQuUhhazxf43dzbvMJg74DVH3h4ln4WIpZ6v15r3aY4YN+tfO4?=
 =?us-ascii?Q?sm5C7lmU63zYeWUpl3bwGNa7Z5Epcc65kGWMGeEloyhw9FZhKfxmepYzJphU?=
 =?us-ascii?Q?IBsz63PPANBhWXtYUTkmQ/evx5FpLyzzb8pA4++957HRcBXSqUCCh/JAzq9c?=
 =?us-ascii?Q?5Ahqo7+8IraZlwS/k96+xz4MuDFYbYrzBWE+CH8MP+Sa1tKaIt4yTAzygxn2?=
 =?us-ascii?Q?0Pa4pkLqpR2I/FJl0s1kD7qU9NRxGMmb3A4Z+TD02sL09iTLUJMkGOT+ZVyV?=
 =?us-ascii?Q?fWRFs5MHkmH//lu1Yf1y10m6q+G8UHzBlAYzznMgKsErrTh9GOpcvqtjLHZU?=
 =?us-ascii?Q?Ol/mzeO4HosAsOR4k9nDjdsovqWA8Eag2wnBIrX8LkgqIVOpytaKpdADEhIO?=
 =?us-ascii?Q?En6scEyNn35aHJfTGcoThQ2w5ZyzL4AFyn4/7i293qonyUxbgk8QbQj1VgOs?=
 =?us-ascii?Q?PVCXMtZp/hEtcWStYj/Z3kLIv0QQCI3W3ahzcUeJw5a4T9RfjRUtExVTwVSd?=
 =?us-ascii?Q?8NC2iRvuz2sYUvKxf5EAMPompGVX6atIj2DFeBAIrqpFnzKDcD+0ZKHxKva3?=
 =?us-ascii?Q?g4KOPfwm66vT2pRRlNthz9UzUEeBHvBgstQh0mf3DY74lZIdMrzTTp7iIwNy?=
 =?us-ascii?Q?xdXCvgKbCFu100YeuS041rpN1wan7vBL8NXDLNyeb8VlJwy2z4toL3ZBMB2E?=
 =?us-ascii?Q?kB5omvk2VlIQ25FtDlpgwQ1SJNJqUyIaHmPJNOd/jgH46KlFI+3kEqqZ10wp?=
 =?us-ascii?Q?4nM77zr1JWCVMa8rH1weOh92g0RZ95bgexmQ+yL2FH1GKiiebFZ69F31tIVN?=
 =?us-ascii?Q?LhH1jL0k/J0xmTCb7FFot3SHQ8iEOdzfIu8PohfdMdU11UvTaFlRGzyZ9+wg?=
 =?us-ascii?Q?M6zNTYDW+BEjZJyllfEwilUNNHY5UbG1PpgqHYBn8+tXJHzsxBRv9h75TsYf?=
 =?us-ascii?Q?+akQgpTRmwih97HV5vrT/m6+TpEcE/3RLn1PpvFcnfZM1q52+iAOLCLA6dM6?=
 =?us-ascii?Q?oNeYqA/hQXCv0OuMoOZf0Z3pTRb34GlZZVOMXE5FNYs000i1eRPoeKVuNGEk?=
 =?us-ascii?Q?qjqaQqBMpODnnqinb1use+XSHYAl/W5GQlLOG8R85PjkEez/d+XYWo7BTxfD?=
 =?us-ascii?Q?qK8o62heqOf9BxUg2i6a4xsy4ZAb/UQIMD4hxRcZdsaFo6KqVsS6HFJKWEen?=
 =?us-ascii?Q?acZgGhrfDkU3dBowqxlIMf5s15mhp6zDFzsBlPO5jR289yvtOE6+hS0VR9Q8?=
 =?us-ascii?Q?t/Jd0ItfdMTMhTCaKLRvfRym+Oprez3pxqUw6Bp+jKstOlmrFRQNFWNz6xTP?=
 =?us-ascii?Q?COI5zpBA5xcrK/6+dEI4XrMOGzDppYVJ3CD1nW9GOHsK2TpziA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bja8fjdhD/lj3UA22X8fuWLvALycyPSefKXX3UVQa5/I0MzghRx8Y1hwscYf?=
 =?us-ascii?Q?Z8qAbuvfu3lFSqOE430I3h4cfEJdo/ReffABXVGZsoPW4iu42n1DLKg24uOr?=
 =?us-ascii?Q?F4+EMXp0Ivtn2QXyn4K7mNSTHgaipPwl1HWEh2wZuU3lvw7l/LxpI6JsEn5j?=
 =?us-ascii?Q?EaUAJ9+G+DuhiModUwGHh5eL+RE2XBcFw4nDk6KuibMjhaCt0YcPnhwSYbLg?=
 =?us-ascii?Q?fHcBhrOJZnKl6cCYg9ZtgO2qY5em3kJBLQhT/8RASe8FEdDBF6flntI66aVz?=
 =?us-ascii?Q?yaJnq6C4mC2j89KFezKmnTsJzyElDt1M4o+Zsyq6ogWCQfxGc7LJXOTGz/T/?=
 =?us-ascii?Q?6bKLqtUiFTOfKGvVNQqpAKY6CU5R1fpQmrfZqJ6Tz+ZqZGMuLE1a3qZZq9P5?=
 =?us-ascii?Q?Mo5z+fnaezQaHOuurFASFAnO8I7UGSN9zbSswRsXpgH7OxaxLnZmvSsECwwz?=
 =?us-ascii?Q?wxHT1r462gF0RkPfdsG+OQ2nb2FW/BnG7V3wtdISw6OwPF7Hrj35jhv5xwKV?=
 =?us-ascii?Q?qKKzDkHYVRhkdbyDfF+jdfRZ/2TRxexl79pWiMSHmyCbbuBh167d5K2Us7XI?=
 =?us-ascii?Q?mjlR9ZgD8K2lpp9idJN57YTU9bSVomOeT5Z4Znyb1WbZK27fkID9LkkGBAM1?=
 =?us-ascii?Q?fsSsf0GXvkitd15AOSyHE6vq9cqTQoVrLs9VGJTwVD+1FJTwiPA5AXaMjAId?=
 =?us-ascii?Q?DaqnGoDzAkZb0qYo/eIWhpcIEuW8ouo7xl6bi+xnqAHM9HCtDilhS0Pwz1Ho?=
 =?us-ascii?Q?htWaYdkR1874UPzDFSPBdZKZQOxrtamzePuVFXQC1wQQPSw55Dqaiv9+bAyB?=
 =?us-ascii?Q?kH5oxACBsfAef8IIGvz5waDB+lxsu2rk0HUqyYeaVKru6zi7wWDb7/SJ+wRv?=
 =?us-ascii?Q?v7q1e0tvv5AE8L4rKjURzZlcrb11rh2ziCa+luSZiyWFkPbS5tjhSbHyh5iQ?=
 =?us-ascii?Q?yYRgjt2KdnHBNL2+O+nloCbmG1fc5xMSJRgNS3Iih3pfmjwbOzHP6zMBYu5v?=
 =?us-ascii?Q?fHQmHnl8Dwsf8G2ROzRwrGMeWIYkV/syIDGOMpy0qJQ4oUqaITlmjmu9Vdna?=
 =?us-ascii?Q?9BGB6saIT3Xh4qWCCvP9zlQupswa9Ja0wyF4MnNkQt+WTk0XQiodB2GjzYbD?=
 =?us-ascii?Q?5o9feMBdo8bX9r0+zn3nSvtlnYz9iIwLSZdCg4PnoWeuSdZSvhzFy9GOOU0s?=
 =?us-ascii?Q?vlyEG7uyDFlctfV86NJ1TfHnX3VswMmN2u59VjWsEZye9jam54tIDHlwvzp4?=
 =?us-ascii?Q?ypRkuLAMHJvsmUlF7aqgGaxX5wTzr1LQJBzT53ujGuRyAw4yXBzFIo0BXxHv?=
 =?us-ascii?Q?TcI9pfhY8Bp/p/ba05tlUIfzVKcV8UohUW03zAZDWYUAvtJWzw/l9zjtMtUF?=
 =?us-ascii?Q?i1ET5OgOTDDLYtJNKvzBUq1HhDx4GZ7KyRL9pgMAYnj6V97q4FAnBpcQCOBe?=
 =?us-ascii?Q?rXE7KaR5dDb9lE/QqkLuGh3A9+jrMZc9hXIdnzN7zo4fjqNdJtmIB7a6y9ub?=
 =?us-ascii?Q?38E2UIPuJbx7DGx7NbsrSh1lrBvwVxLPOmGVaNmbKl2YxGMvnsBMlpvB5ME9?=
 =?us-ascii?Q?4MN8xbKyAINk/OC8wmA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b194c2-af92-4060-72dd-08dcc78fa057
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 18:31:26.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3reKJFQfWJ+5PrGX6y2Q7DHvqVu/yxL8Rlp4S1VA/7GcXa6vXep3jKSjXpPer565zsCsGDwNuDBCjjjY1zoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

On Wed, Aug 28, 2024 at 09:16:13PM +0530, Manivannan Sadhasivam wrote:
> Kishon's TI email ID is not active anymore, so use his korg ID. Also, since
> I've been maintaining the PCI endpoint framework, I'm willing to maintain
> the DT binding as well. So add myself as the Co-maintainer.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> index d1eef4825207..0b5456ee21eb 100644
> --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> @@ -10,7 +10,8 @@ description: |
>    Common properties for PCI Endpoint Controller Nodes.
>
>  maintainers:
> -  - Kishon Vijay Abraham I <kishon@ti.com>
> +  - Kishon Vijay Abraham I <kishon@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
>  properties:
>    $nodename:
>
> --
> 2.25.1
>


Return-Path: <linux-pci+bounces-25381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2AA7E2C0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973154421A9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA61EE7A7;
	Mon,  7 Apr 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBAWRw0F"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602C1C68BE;
	Mon,  7 Apr 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036633; cv=fail; b=WWo+u59UaYZgQWnsuwEluZtSr8I/2O9WGcgTA31KprSNMPGKOOjk0sxb1uWlT9xnDjQ5ZmmmIsG0yUudYmSYMNEeWJaJvjJIvP5iuRQDR3dvEGbCmmS10oeSFWe+OrdlmWFFFOliwaWfnZBsZr8+GBOF+FqG6vD+6gvOL6GXBLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036633; c=relaxed/simple;
	bh=314y1HEl0NX0J/GJC0bYRnFYODszkk48/BYR72LMZHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W5yyF/4Q+EO6GPNq562rFqIyp7IqnasD7SovSQEDT+olSLz5/OglFB9GJyXvbHWZ/vaBaimDy4B3oJ+/aTiF+wIGk6TGi0ORDivhttEjIdfEVsU1q6nIowMexAWxQ+/+PgQB+VDY5dM/6WbcfzXNXwgY7gGOQyaa1ndKXH8T1Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kBAWRw0F; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVVO2FIVVT9QXxolSTulm4fml6eXtpIjRg0AATWTL7lj6Zv/rH18Aqs4kVwTAVN8qz8FUEsNbVFyo7usge1aGCf9WuWnXjDd0ORt0nvSpuCIHwiY9U9nfJZBH4DFdwZZJQ2OnxTmp6VhOGNygloKxbXY5kypzqqfT1VfM69pPvTEAAHJkCMOtT9ZqhAKelGsBQeQXaRyzGnBGX8jjQzP3VHS6mYprennxh1RJVUKJ35b68+nEZf/RCadlVw1Om85ja6IQrkrsVnS0lPtGucfSBfGjotGfdN0xRh8xHNek2r3NyfFr2Z5l4lX1vKHwmghUiPWoJSQQg6siFqthhTpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcxUjLE+nq7g1Zg40DUVFoVmkvLylAwozNPS7qm/EdE=;
 b=O521SzolozFnptFOB/IjrBmrgKZBDg2nAJiOMNvGwV0kBSrt/xzo0ogzd6WqMxSeZof6Ng/s97iQzjwp2w3HJk2bKXZF1BLbMTnWWzWLGujZ9aLqFQi0CJ8INvCMa7j9vAVsuZlFATFO/4ASyaXrkxNVxEWB3vrTy+KHrwW/qUqjfQI7QaGKO8w1rO2ZrzSyXlfB2XVs+Pc71Tgud77kXdjIHhhoUztMf8Az72w05V9bC2sXTu48uuqfZaKBLDIT4wMiDzGAWUyWBibY/jhgh1d/fPj++FPgSimAagJ79BTDKIwxLF+jANWwm8Rcc0IG8GerOfzZDgXNP0rJ6vuNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcxUjLE+nq7g1Zg40DUVFoVmkvLylAwozNPS7qm/EdE=;
 b=kBAWRw0FrbsobgnxonNRsZz0/N8gPc27gkTpU9EH3oTBNyFJAuBApf184loCJ2UDxgF1NPozefGIa+BoOyNRSfR941d/o7Up3qhdT2X5+qQSchK7u5JU+0tjWL2NWn4B8egZjqPIwYPwPfcLJBKIgl7yNxf7v2xyJb+73HpzsqsWyBpMhLs5I5Q5MY0TsWRffCxh+GeeHeNjH0QIHqB8ue3ZQDFo5bLVq+e7a2vXo2N6ydEg9ERotKDBk9y8IDL1AU40+w4lQ/wS3PdaaMV0G6Koo98B0OyLKzaorOA7P+B+XlptPBM3tHzY7Mp+ujVxK/7P57Ab07dgyzvdWyliWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS1PR04MB9357.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 14:37:03 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 14:37:01 +0000
Date: Mon, 7 Apr 2025 10:36:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs
Message-ID: <Z/PjBZVA4kgEOWm0@lizhi-Precision-Tower-5810>
References: <20250404221559.552201-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404221559.552201-1-robh@kernel.org>
X-ClientProxiedBy: PH7P220CA0143.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::25) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS1PR04MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 589f3352-7d78-47b2-5e4e-08dd75e1a8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BUgkOn0tZnKx9bu4k6M/wdiJh/tltilXwQ0q4k7tuAi+p/FOIX+ZCNpPGzdh?=
 =?us-ascii?Q?uD0aMnPv8GnC4sZW8J56eLOJV9HR2XvVXCnqHQnM47ofGNbl/xf7wM0i4YkU?=
 =?us-ascii?Q?9eWhvzGStZNNwW+7/K+FO+bLNbL7CIr6p8ihv16vqmomD5Os3Pzgao9MkC2Y?=
 =?us-ascii?Q?tjvv5JAZYpkpu5EpN9drGpMyeOVayPjn7fSnIx1MhmfffrzcRvNCuNkBkOPM?=
 =?us-ascii?Q?R+cUduVMPxsrXFDdxbu6VV93iCo5qedKRubU/7zxCeVX86icevQ0gy/MQ3NH?=
 =?us-ascii?Q?S9uQMqM4xdEEbJrvUgjYuBS1SBd/7QTkhK5iRaTs93GQi6h8AjZ3k3l2kfhF?=
 =?us-ascii?Q?c2gnf66oBnKrc/9exaQxhpPET1MI8h9vBG+N9o/OE+2g7kGNKV4w9avNthpl?=
 =?us-ascii?Q?w3gX+QRhoeDwxTYmadkfDzgEYhmsaV0YFTYjAm6Qh0ZiY8Bh2vQqRJwlFeV+?=
 =?us-ascii?Q?Jyc/zjhoGPtYvAmzrbB0+kwpT8tp1E2nmhNtSCqoldmmF8aRcq3/fIapWapd?=
 =?us-ascii?Q?K6hbL9USMiESQXupAPaYSKiseABJCKgx7ap+7DOo9z9YH87cSMHW+V+ogZE6?=
 =?us-ascii?Q?Wgh0lD7sNl4V1V/rLXy6v6uaosPfzwbkgCJcQlOlViEEgtE+zhLFsTFlatRD?=
 =?us-ascii?Q?4rNcJfu4VjWnznXUTIoLrXi+laVMzVmOrIxY3hXVl+pRvsWcFQSuS5gd2xMc?=
 =?us-ascii?Q?k7NbLiP/4Hs1z4k8K/Tv5k8dWl6IrjXsalmfhOlGusvE0ZK++OxRmlhHSWOh?=
 =?us-ascii?Q?DCBDuxv3P+aDikwq7sBLPbZXq4m0834ZGK8qTJUZIwOhnW9JeFX6GW/4RPTf?=
 =?us-ascii?Q?eAFwS0w1VbpYa1LpfbYiVVwhlbx26/FXnSUoyiNo4mvCSOSD9ViecfDUAWgn?=
 =?us-ascii?Q?B3d+8ureByeQtG/tuC4SB4WZxuNBErornEOMshNBZvud10LQG0wE9YX0KphO?=
 =?us-ascii?Q?UF2y9GSiyaMiml0lSXY9zn9xfdVh2daxV1P+XpiTNHz822yegIjHOn8IEl2x?=
 =?us-ascii?Q?t9UNClahg0oG3O1Q/3EFzaoV50vFGcnWMo2TdxkyDo6Jherk0Iwd7uTnWEdG?=
 =?us-ascii?Q?Vh1JIJKl39ZZdWeMLBJpiIYNQkzFVZ+vnn/sLmyUFRKsKCd3NT3B0I6jIVhK?=
 =?us-ascii?Q?Q3K6GSCM1TxkHoegbqyCG1tLcPRJGYcu+cnpam7rtWK5pRw1oB6qQH6Gs55v?=
 =?us-ascii?Q?HR7bWWR7xfFW+d5Mv8wiVCMa9REjvjHbRWd0+UzG787y8J/h8y1mjSa05Ebi?=
 =?us-ascii?Q?zz2sZcBFOoMJXApKnJLkjO2+VGGpZ+ivwg+j5qFhgRs296WCAxsx6N8tyArl?=
 =?us-ascii?Q?f8IZvbe04XTx3KZjU/EtZQgW50lNJvq4q44XtE89YZVp+tnOBmNg5k+1dCrT?=
 =?us-ascii?Q?J/LMp0cFHTybQYZKpJCOkhhNJT0VO0I2jkxyiLI2BZu+IS+HRpAUtKI3O0Ka?=
 =?us-ascii?Q?AFLvk+PMBmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ynn3CDK1YSCHsgPT+hlCa57E+PrWUZbeZrQ4Bun+zX+KrV5OEKaImUgrahAs?=
 =?us-ascii?Q?2jR9JQYyP2JuiQbMKQyvDNguu18+coOCcQJac0Kro1Xd9512hToHuAepx4p6?=
 =?us-ascii?Q?hK/n5QN/ihqleViRbq6uowN0tGBJrdRcMeqaUUflwxG25AyMN+6YM0I4zLKe?=
 =?us-ascii?Q?wGHBCI7J/9QZSK6Ce4WZU8oUR51inEWFyDOKZN9wETpopN3dAjunYZNLYGs/?=
 =?us-ascii?Q?neHHs9Aupgd5Vf9Xf+a5ceNAdAbD45PxODxqBz/KI3hsv/GurreqpYHHeiKf?=
 =?us-ascii?Q?YAwb7z8+OOvmL7NTFNyC3DbJky3IAc+5vCywN4KHfndvyMXvnvrBRkqNPQuE?=
 =?us-ascii?Q?9fShMGJa0bk5WjWTV2GXFPX/Nzu7ylDuFZitBVcAmJphX0tEWnSGXn+OYMX9?=
 =?us-ascii?Q?QHYJW5QBqhhwNyeAHQofGFNexVQtbq8ZDo+K06C7c58Aqmb3MWSt9gkj4fHG?=
 =?us-ascii?Q?5lCXIz5xp7S/T1Q6qxN1CJwxKB6ADyBrcLolKocvkF3IW3Bsh9128uDXPzDJ?=
 =?us-ascii?Q?L7F67yq3pqwVtxKxb6RR1WDdqQqFTJI8ipPHxOnC7ht0WRw+ZxPOa0msedhs?=
 =?us-ascii?Q?vVFzfdHQoynASFBNQ3cFI3EA5LFVg54XSpmIunNZ2Bdw5WeuqM19dK3QB1nX?=
 =?us-ascii?Q?8GZc/Dre/bJKnkTgjwf+dyb8lrYlcylxett29ejXd58dLquxNv21l0V3OMWu?=
 =?us-ascii?Q?EiSEXSLWmje2CL56t35JZI0Xf2/OVzlP74le2PeoBlc6gNolQFcY4EAoIw67?=
 =?us-ascii?Q?XhpQpUWNTWuhLcNWRQMDfZNBnFQlXGltQoaWU0f7DJD+xUJUZVR3CdiFhE14?=
 =?us-ascii?Q?vaxAX2mWgSVFuA4aRYcfNTmvRRKu53KltMzTlFPdCjqVJ8sV7pvtrctdiaSt?=
 =?us-ascii?Q?EjfSChHf8wQs1sOWeHCwxUd9WAcbXngh/azS81QZmEKElYHVZRYwtpro7miQ?=
 =?us-ascii?Q?nGsltFjxQareQ5JutbZD/fML+ybBRktUITa8QEJm+3csR1UwDOWgKz2te95t?=
 =?us-ascii?Q?JT/0HvGV/KeS8oN4MqNx3w5GVOsmXhfRlnCall2JHeAO8DRKiTfYcmUiSdqB?=
 =?us-ascii?Q?wuUAlkermxQRFkIZYzdK1URyizcqN48L4cUUQyr4vSGqVFzvu+BddEV4aqRz?=
 =?us-ascii?Q?VLV/Sg2+fMp/1GtFoKnU+yEJZJPWnSnAidz49D62G+6EjBbjUWpkuXMLe6RL?=
 =?us-ascii?Q?i7aSIPiOcjQlkX3NdwCpqBGWw43/GFfd1XJ+xHVgk8K8pGS8lDgrV6lf8cbH?=
 =?us-ascii?Q?dg0wWmVEWxOr6plK7uU1JHz0jZkrDmKdPtCZpQ5BzyQ21ezRAT4Dy0o4YAVr?=
 =?us-ascii?Q?gleO2y6Yy6LoCxCa/RZ/jucYUPlleUjU5IQmdxaxTW8zFYJg3j95Q+WzvBv0?=
 =?us-ascii?Q?ICZuencPm5+0VDYkqE0UUjp8zns25twTbsJt8cxjC1N4CQVBjSW6UtF8RZ/D?=
 =?us-ascii?Q?9mZFV9k198XV7ITxCTXKi6dcE04d9oJlT3YrYyvD4QPzKkjWw6Tif5g57Myu?=
 =?us-ascii?Q?K1Ip/pl+SY+yplwdDKNSa5Y53pk1OS4pnAKIQMiLNRQnCxUxIBfciESNc4XL?=
 =?us-ascii?Q?0Ou3JDuUAeZ3Z+WnVbs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589f3352-7d78-47b2-5e4e-08dd75e1a8b6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:37:01.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiRF65ZzAyBHV16xPz7NCcWxHWeDwcUWQgQ/jPh9j3dW7cF3hcw5Ii6zmrSxMP/eTGPbb6owc+6SKHnRW0N1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9357

On Fri, Apr 04, 2025 at 05:15:57PM -0500, Rob Herring (Arm) wrote:
> The content in these files has been moved to the schemas in dtschema.
> pci.txt is covered by pci-bus-common.yaml and pci-host-bridge.yaml.
> pci-iommu.txt is covered by pci-iommu.yaml. pci-msi.txt is covered in
> msi-map property in pci-host-bridge.yaml.
>
> Cc: Frank Li <Frank.li@nxp.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |   2 +-
>  .../devicetree/bindings/pci/pci-iommu.txt     | 171 --------------
>  .../devicetree/bindings/pci/pci-msi.txt       | 220 ------------------
>  Documentation/devicetree/bindings/pci/pci.txt |  84 -------
>  4 files changed, 1 insertion(+), 476 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> index a24fb8307d29..6d6052a2748f 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> @@ -74,7 +74,7 @@ properties:
>
>    reset-gpios:
>      description: Must contain a phandle to a GPIO controller followed by GPIO
> -      that is being used as PERST input signal. Please refer to pci.txt.
> +      that is being used as PERST input signal.
>
>    phys:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> deleted file mode 100644
> index 0def586fdcdf..000000000000
> --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> +++ /dev/null
> @@ -1,171 +0,0 @@
> -This document describes the generic device tree binding for describing the
> -relationship between PCI(e) devices and IOMMU(s).
> -
> -Each PCI(e) device under a root complex is uniquely identified by its Requester
> -ID (AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
> -Function number.
> -
> -For the purpose of this document, when treated as a numeric value, a RID is
> -formatted such that:
> -
> -* Bits [15:8] are the Bus number.
> -* Bits [7:3] are the Device number.
> -* Bits [2:0] are the Function number.
> -* Any other bits required for padding must be zero.
> -
> -IOMMUs may distinguish PCI devices through sideband data derived from the
> -Requester ID. While a given PCI device can only master through one IOMMU, a
> -root complex may split masters across a set of IOMMUs (e.g. with one IOMMU per
> -bus).
> -
> -The generic 'iommus' property is insufficient to describe this relationship,
> -and a mechanism is required to map from a PCI device to its IOMMU and sideband
> -data.
> -
> -For generic IOMMU bindings, see
> -Documentation/devicetree/bindings/iommu/iommu.txt.
> -
> -
> -PCI root complex
> -================
> -
> -Optional properties
> --------------------
> -
> -- iommu-map: Maps a Requester ID to an IOMMU and associated IOMMU specifier
> -  data.
> -
> -  The property is an arbitrary number of tuples of
> -  (rid-base,iommu,iommu-base,length).
> -
> -  Any RID r in the interval [rid-base, rid-base + length) is associated with
> -  the listed IOMMU, with the IOMMU specifier (r - rid-base + iommu-base).
> -
> -- iommu-map-mask: A mask to be applied to each Requester ID prior to being
> -  mapped to an IOMMU specifier per the iommu-map property.
> -
> -
> -Example (1)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	iommu: iommu@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the IOMMU is the RID,
> -		 * identity-mapped.
> -		 */
> -		iommu-map = <0x0 &iommu 0x0 0x10000>;
> -	};
> -};
> -
> -
> -Example (2)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	iommu: iommu@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the IOMMU is the RID with the
> -		 * function bits masked out.
> -		 */
> -		iommu-map = <0x0 &iommu 0x0 0x10000>;
> -		iommu-map-mask = <0xfff8>;
> -	};
> -};
> -
> -
> -Example (3)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	iommu: iommu@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the IOMMU is the RID,
> -		 * but the high bits of the bus number are flipped.
> -		 */
> -		iommu-map = <0x0000 &iommu 0x8000 0x8000>,
> -			    <0x8000 &iommu 0x0000 0x8000>;
> -	};
> -};
> -
> -
> -Example (4)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	iommu_a: iommu@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	iommu_b: iommu@b {
> -		reg = <0xb 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	iommu_c: iommu@c {
> -		reg = <0xc 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * Devices with bus number 0-127 are mastered via IOMMU
> -		 * a, with sideband data being RID[14:0].
> -		 * Devices with bus number 128-255 are mastered via
> -		 * IOMMU b, with sideband data being RID[14:0].
> -		 * No devices master via IOMMU c.
> -		 */
> -		iommu-map = <0x0000 &iommu_a 0x0000 0x8000>,
> -			    <0x8000 &iommu_b 0x0000 0x8000>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
> deleted file mode 100644
> index b73d839657b6..000000000000
> --- a/Documentation/devicetree/bindings/pci/pci-msi.txt
> +++ /dev/null
> @@ -1,220 +0,0 @@
> -This document describes the generic device tree binding for describing the
> -relationship between PCI devices and MSI controllers.
> -
> -Each PCI device under a root complex is uniquely identified by its Requester ID
> -(AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
> -Function number.
> -
> -For the purpose of this document, when treated as a numeric value, a RID is
> -formatted such that:
> -
> -* Bits [15:8] are the Bus number.
> -* Bits [7:3] are the Device number.
> -* Bits [2:0] are the Function number.
> -* Any other bits required for padding must be zero.
> -
> -MSIs may be distinguished in part through the use of sideband data accompanying
> -writes. In the case of PCI devices, this sideband data may be derived from the
> -Requester ID. A mechanism is required to associate a device with both the MSI
> -controllers it can address, and the sideband data that will be associated with
> -its writes to those controllers.
> -
> -For generic MSI bindings, see
> -Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> -
> -
> -PCI root complex
> -================
> -
> -Optional properties
> --------------------
> -
> -- msi-map: Maps a Requester ID to an MSI controller and associated
> -  msi-specifier data. The property is an arbitrary number of tuples of
> -  (rid-base,msi-controller,msi-base,length), where:
> -
> -  * rid-base is a single cell describing the first RID matched by the entry.
> -
> -  * msi-controller is a single phandle to an MSI controller
> -
> -  * msi-base is an msi-specifier describing the msi-specifier produced for the
> -    first RID matched by the entry.
> -
> -  * length is a single cell describing how many consecutive RIDs are matched
> -    following the rid-base.
> -
> -  Any RID r in the interval [rid-base, rid-base + length) is associated with
> -  the listed msi-controller, with the msi-specifier (r - rid-base + msi-base).
> -
> -- msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
> -  to an msi-specifier per the msi-map property.
> -
> -- msi-parent: Describes the MSI parent of the root complex itself. Where
> -  the root complex and MSI controller do not pass sideband data with MSI
> -  writes, this property may be used to describe the MSI controller(s)
> -  used by PCI devices under the root complex, if defined as such in the
> -  binding for the root complex.
> -
> -
> -Example (1)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the MSI controller is
> -		 * the RID, identity-mapped.
> -		 */
> -		msi-map = <0x0 &msi_a 0x0 0x10000>,
> -	};
> -};
> -
> -
> -Example (2)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the MSI controller is
> -		 * the RID, masked to only the device and function bits.
> -		 */
> -		msi-map = <0x0 &msi_a 0x0 0x100>,
> -		msi-map-mask = <0xff>
> -	};
> -};
> -
> -
> -Example (3)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the MSI controller is
> -		 * the RID, but the high bit of the bus number is
> -		 * ignored.
> -		 */
> -		msi-map = <0x0000 &msi 0x0000 0x8000>,
> -			  <0x8000 &msi 0x0000 0x8000>;
> -	};
> -};
> -
> -
> -Example (4)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the MSI controller is
> -		 * the RID, but the high bit of the bus number is
> -		 * negated.
> -		 */
> -		msi-map = <0x0000 &msi 0x8000 0x8000>,
> -			  <0x8000 &msi 0x0000 0x8000>;
> -	};
> -};
> -
> -
> -Example (5)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi_a: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	msi_b: msi-controller@b {
> -		reg = <0xb 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	msi_c: msi-controller@c {
> -		reg = <0xc 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to MSI controller a is the
> -		 * RID, but the high bit of the bus number is negated.
> -		 * The sideband data provided to MSI controller b is the
> -		 * RID, identity-mapped.
> -		 * MSI controller c is not addressable.
> -		 */
> -		msi-map = <0x0000 &msi_a 0x8000 0x08000>,
> -			  <0x8000 &msi_a 0x0000 0x08000>,
> -			  <0x0000 &msi_b 0x0000 0x10000>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> deleted file mode 100644
> index 6a8f2874a24d..000000000000
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -PCI bus bridges have standardized Device Tree bindings:
> -
> -PCI Bus Binding to: IEEE Std 1275-1994
> -https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> -
> -And for the interrupt mapping part:
> -
> -Open Firmware Recommended Practice: Interrupt Mapping
> -https://www.devicetree.org/open-firmware/practice/imap/imap0_9d.pdf
> -
> -Additionally to the properties specified in the above standards a host bridge
> -driver implementation may support the following properties:
> -
> -- linux,pci-domain:
> -   If present this property assigns a fixed PCI domain number to a host bridge,
> -   otherwise an unstable (across boots) unique number will be assigned.
> -   It is required to either not set this property at all or set it for all
> -   host bridges in the system, otherwise potentially conflicting domain numbers
> -   may be assigned to root buses behind different host bridges.  The domain
> -   number for each host bridge in the system must be unique.
> -- max-link-speed:
> -   If present this property specifies PCI gen for link capability.  Host
> -   drivers could add this as a strategy to avoid unnecessary operation for
> -   unsupported link speed, for instance, trying to do training for
> -   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> -   for gen2, and '1' for gen1. Any other values are invalid.
> -- reset-gpios:
> -   If present this property specifies PERST# GPIO. Host drivers can parse the
> -   GPIO and apply fundamental reset to endpoints.
> -- supports-clkreq:
> -   If present this property specifies that CLKREQ signal routing exists from
> -   root port to downstream device and host bridge drivers can do programming
> -   which depends on CLKREQ signal existence. For example, programming root port
> -   not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> -
> -PCI-PCI Bridge properties
> --------------------------
> -
> -PCIe root ports and switch ports may be described explicitly in the device
> -tree, as children of the host bridge node. Even though those devices are
> -discoverable by probing, it might be necessary to describe properties that
> -aren't provided by standard PCIe capabilities.
> -
> -Required properties:
> -
> -- reg:
> -   Identifies the PCI-PCI bridge. As defined in the IEEE Std 1275-1994
> -   document, it is a five-cell address encoded as (phys.hi phys.mid
> -   phys.lo size.hi size.lo). phys.hi should contain the device's BDF as
> -   0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
> -
> -   The bus number is defined by firmware, through the standard bridge
> -   configuration mechanism. If this port is a switch port, then firmware
> -   allocates the bus number and writes it into the Secondary Bus Number
> -   register of the bridge directly above this port. Otherwise, the bus
> -   number of a root port is the first number in the bus-range property,
> -   defaulting to zero.
> -
> -   If firmware leaves the ARI Forwarding Enable bit set in the bridge
> -   above this port, then phys.hi contains the 8-bit function number as
> -   0b00000000 bbbbbbbb ffffffff 00000000. Note that the PCIe specification
> -   recommends that firmware only leaves ARI enabled when it knows that the
> -   OS is ARI-aware.
> -
> -Optional properties:
> -
> -- external-facing:
> -   When present, the port is external-facing. All bridges and endpoints
> -   downstream of this port are external to the machine. The OS can, for
> -   example, use this information to identify devices that cannot be
> -   trusted with relaxed DMA protection, as users could easily attach
> -   malicious devices to this port.
> -
> -Example:
> -
> -pcie@10000000 {
> -	compatible = "pci-host-ecam-generic";
> -	...
> -	pcie@0008 {
> -		/* Root port 00:01.0 is external-facing */
> -		reg = <0x00000800 0 0 0 0>;
> -		external-facing;
> -	};
> -};
> --
> 2.47.2
>


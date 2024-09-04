Return-Path: <linux-pci+bounces-12754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3589896BF71
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71822897C4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39A1D79B6;
	Wed,  4 Sep 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B7XAAZ6g"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C121DB949;
	Wed,  4 Sep 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458367; cv=fail; b=couOTKG4pvbp/Bea1rlcBKvRvtlP8JD7sE5E2Cg4VRHKdwoWSiOOfVMh4thVBtCC0FcwzJ/1LFLURM6tnN2p24UyZX/Icsh7V5oj7Db9kBNtPj5Gq3qYMq30m8oofdJvVTZ1u4NhOf7wKIXqyWjYEMCrYPxFEWUPtabUhopQfQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458367; c=relaxed/simple;
	bh=OoJU0qwvw1DjCj9mFY2aFVT7jMMnfsv/fRROvXo8AA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AYt4a0i+CDxryFqkEKbHIWJ8lP8ytu5S7mtMmTQ7uBQVI2b6OcmoOV4QSYRgRWgJ7pq8WqHBwpoBybXPar7VGiSgX2eMmN/IpjUuQ36IzWIkD8bPVa1cluEQHeGkWZM0nag7SBcPSE0MrpeipXfeZmIZ2B8+wjiA4/GlPue2jbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B7XAAZ6g; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wyqo8FGLFM8ZHaYvtgYj4hk1xEG7gKCXn0GtOjeH8TGDklR9wpov5jFV9qMBgG8csirSzmCZOMWjajgRK9s+ZpGuGLgA98FV8U/tFBSwb7ceb4KZDnj45A9SCTbsSUg7m0Kg5TaoueQw6klQgj6UOQqTZUIZFWFPvse96dv7wSLtMPdaDDWwFw5ORT2k6NYM+z2+r46NgfUBeT0gK5HNYB/D9wYHzVM84zkzNC5ntTEKPh3cGXetuYXLtT+Y697Z2PxTjwE6H1FKY0ofzYKAPLh6LNw87M8Ie9oxX/qpAZWUy7Phw5NNFYhI8QfHUJlMautwQNfWKHvT2rgo5RmKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doxiX0QeM2tlYWuZ2JOzWTuZi0vTJxXceTFcfowjma4=;
 b=bB5O51kNtoAvLHX4+CzsZZb6hO44SdfHI6afvz4Gd/ffNa4B1LsdfPUEgRIjb8RXGWGhptVBd0/7Ov3XK6fGGIdKralKrNIyfhH/mCSPCWWzbuFqi0C6V8j8w1VDWgzEZEwdeewgH6G8T/uOBJgTU+XLkNl/s6Htc93kSejRM7EkD9RoVFWtYNDfqjQ2ftoY7kCkO76OoLsrUrqlGTUSo3KZnLUbbZ5IhvBy2vqXi3UvgVICIcDSIx1Cr3elkr0ePlTwCCZP0qOtpa+VeBO/iD4lVRu+jnNG1SabFvcEgwtS9czafKw/AqKuFRZESOApoYfSO7yzg/p3dpOZ5hBFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doxiX0QeM2tlYWuZ2JOzWTuZi0vTJxXceTFcfowjma4=;
 b=B7XAAZ6gMLvAFEPtSCQLIx03Yb5PdMTdd8VKSeauF/UztyG2cxXRCnXw0WwmCGbifYXlr8pBhSgFNkjr6qrVYyO243+NNCMSONATDkRwZ9Noqgf5dladLCqKi5lxsBJP1/GPBOUgv2agS/6028zvh8UjPimxPJOqCjGUN3GR1IFTCVFlXolDdq4sHkysU/ECcQMZScD5wawxiPEpdzBD/BgBRfZGQJfYBJ3msLO9suwM1IrcuEWDyqq5tDr2eECK/aVgt9tJog1nWSvpIExvupQhuQZk/VsFx4r+RizhGAMDxIkOhA1AIj5i5nFQuKiuV7pHak9Gw5211ll3lFhC1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10778.eurprd04.prod.outlook.com (2603:10a6:150:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 13:59:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:59:21 +0000
Date: Wed, 4 Sep 2024 09:59:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Bjorn Helgaas  =?utf-8?Q?=3Cbhelgaas=40google=2Ecom=3E=3BKrzysztof_Wil?=
	=?utf-8?Q?czy=C5=84ski?= <kw@linux.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	imx@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/1] dt-bindings: PCI: layerscape-pci: Add deprecated
 property 'num-viewport'
Message-ID: <ZthnsofkAI7YbI4u@lizhi-Precision-Tower-5810>
References: <20240823185855.776904-1-Frank.Li@nxp.com>
 <172468109227.92699.12972235014145037669.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172468109227.92699.12972235014145037669.robh@kernel.org>
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10778:EE_
X-MS-Office365-Filtering-Correlation-Id: 511d4830-cba2-4337-77d9-08dccce9c6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CuZ50+ws9P1DhviJ3MlCCNKXwQRMq3RCZZh+M5iINQSddlQnpIL0yB8Pk4X0?=
 =?us-ascii?Q?LFE4drAkwtoWqbIEgHEqdBT/GmIUP9grdzyTpEeA66gtk9P5wfgTfveBq+/e?=
 =?us-ascii?Q?1DUgH7+9M2YGlOhFjRm4V/gt9nyARype5mYHFAygMM/7BnwOFAqOa5Qq12CU?=
 =?us-ascii?Q?BRex4YtI1gcAPt3UdBp1eo0YSBS8Mib6eeC4Xlxe83sFed+sH0pBsciQsJBm?=
 =?us-ascii?Q?QMKPFlh3CemfSbjHxX2jNxqjex3YscUuGtvvBB/opvo9eYWGcdC+uyux2Ngs?=
 =?us-ascii?Q?izW0GxX3v13j3E8LWHxke0BbhO3bdVYcE+1tbPpNgnt4aNKMsi9swpY3iw1j?=
 =?us-ascii?Q?kcd5qIJZoXNMTHftfwqltQuBNKJDIgVLq9VGg6lgfRM+qHeMyrOO4EdxMSo2?=
 =?us-ascii?Q?wZz/of/aRP0iEHj50UQ33axZFQTW5FaesWGEa+730CTfkPk6IkJ+QBTM9Bar?=
 =?us-ascii?Q?Wor51cDETK8h50BWAVw+BFkVQGQZx1ygO0VvamAMk/bi52Z6zQ6tqoTbaQUd?=
 =?us-ascii?Q?bBCvLKaZMfn9gKJmsT0YNExTN7Z+QlxQUjDstVsdNjXMXhQIPCI4p572SXVB?=
 =?us-ascii?Q?6RaZJz6VdFMNd4Oy/pXs/Zj3zy0Tg8eI+J5z5pxxNMmRF2AJ04uoRrvmv7Sl?=
 =?us-ascii?Q?c9QCtU72rc+ar/W7oMvpK41svmWbH3alFjZpSV6xGbFoWZQd1bhoGNpZl0CD?=
 =?us-ascii?Q?ZseslussUaRxITIJNO3bISEgw33ZDj/+CQT8WdhQZWFyde7HIy0hCUMIKqpL?=
 =?us-ascii?Q?i3BMNt6qCwPCxYz1Rw/idndBWZWKAW0XZo8YyxHLmmUSxJO23Kh04dDK77E7?=
 =?us-ascii?Q?xTSuyvdw+/1mfwnwMS4pAFntw2XRvWBdifk8BngNPrJbHs1vIfp0WYtqtUOe?=
 =?us-ascii?Q?Zsro9aIIul6F60Hyz2W1roIeugeTFcdeZOcNo6aRccAnVDyZQqk5Eqq9PN6q?=
 =?us-ascii?Q?pTIOKWfD0HiT4kOz/yYKwiyXdvlCjx0dQY2W/iNOOMm3MimtJXqtmC62Asvo?=
 =?us-ascii?Q?/WoN8H06a1639yL90TQfG4CuWSdEFp26AT272d0uWYOosP3pRR3/HO3x8E2h?=
 =?us-ascii?Q?4nAXiCAcR/EzTjlqdz2WJrXbqfzOodjz7wFmiwCdRU+FZrLrFOY73b2GGk/Z?=
 =?us-ascii?Q?KfbcVuDP73SFLOpGrW83yuEf/QQwMo/x+D9YDWlT9UC5dMvFOWP/RzTpsU4X?=
 =?us-ascii?Q?sCpP6qGajQ1wvWMgV6TKniN+N6vGCaUHNqngn5/w0h2LUUrG8/ebb6IzCyeY?=
 =?us-ascii?Q?qUIGHpY9nI0XXpGr9cgpMcModnejMqM7o/rcpBLniH4RXF6Tv+BGB2nEgI9w?=
 =?us-ascii?Q?RdR2xPWjm8mtSlQEmKkuDHVB2/zaYDd852kVW29r6dUe5lcAbxjd9faUDaYE?=
 =?us-ascii?Q?bkTYwLTAOpF8wLhMphreMluBEqofMgAHxlr3UgbW9ugH7sgbTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0DcoVLrKBWfqAkqghJwvHGRxrwLXIJTwpfvhDRcuvMi3UK7C4dOyAb+FfwLT?=
 =?us-ascii?Q?ArysmtJWY2y5FbfsKpk1HUNrOh3ySXq7LZIdYnOSE2LKybocCnOv98BXiW1E?=
 =?us-ascii?Q?kHD/q5AVLm5CJbf4QRcgg6PDXUvu6hNuQjdAXvmX4Yz/O/4DF1Siq66Ha/RP?=
 =?us-ascii?Q?xL+d8pZFFTbZ3tUfn0+bW0tXoIpT8vQ8sjpO6GostZVVmu3G0/q4Ii8kKPHO?=
 =?us-ascii?Q?iG3jvMkG0Ivrjk4fHuVWORe46XtPNpXkyD8fwPbuO/bvr2eYugt8Bsd1lLSR?=
 =?us-ascii?Q?0wpYSOx9cp3a7PL1kTXZTrpz+p0axN/gJveNKFSX8TuMhB7WW/FgQLHwlu2A?=
 =?us-ascii?Q?DYkMnNRYIG/nmRFIWYJ8vFhgGXTP36T/d2hFqDHybw08Gq3ojKuFzEuTwl/5?=
 =?us-ascii?Q?UwT0D8YTFWPXj9dXg51Lcx9UyzDrGrYDJ+0M37NKBf4Dr89njFzo2SrZk0qq?=
 =?us-ascii?Q?4z8KASUksaWMmgXfXjQSXPfObEF+DUgnNkBd21kK4hF5FhP9DKhraQ9nRugN?=
 =?us-ascii?Q?HowTe801V1oyvGcWzy7mGAXulpfIpIk9DqYEpAMxofVxi9X2sJZhWdalSPSN?=
 =?us-ascii?Q?JJbfm7AVAKzEJxGshLA2HdAh25FKuYbB4LM89EaUzQ+FR+D1YYySrTIXuJrh?=
 =?us-ascii?Q?CPqf1cX8bVvvJy3/5iB7SFyqXWkQCW4aWViwVx1oxvfiYU0O8X3VD/uMrho9?=
 =?us-ascii?Q?cL4tXQSHd1/uNK7kQWqio1rW3xGcBYwY9QA7sRjimnW1GeEbA2gNAay4TYh0?=
 =?us-ascii?Q?drp/Y42DO4NjPXIrYmAD2TkHlwlda5lXC4LUl1i1N2/Po88gp93k9zFP2Sb/?=
 =?us-ascii?Q?U0MaIzMY0VA9S7hWrH9vBj8NxZEySNMqheBTWwpLlRudlj5c46W8qD9Haud2?=
 =?us-ascii?Q?+KX7myZpNexVrh5nxRWbceZoGuHFSvFICozqXV8NkWlZDKmH+DToIzlyYxrK?=
 =?us-ascii?Q?sKNRz9/miIm4px7KfVsVF9vWCl0Mt3AMLREoU6v3tnZzrf6cb1qMfYvQL3QV?=
 =?us-ascii?Q?Ai7SVhbEaiok7KbCfd96C1cfPX0lzWj1vXCjHP49EHilHvb/8ZU62f3fJn+0?=
 =?us-ascii?Q?FqsqAcH8xCiQ4YYuevoQbJF4Z+dxKQ0Ti4fdkK4xIPfNOF4MvekY5BMlrvBj?=
 =?us-ascii?Q?1O+Fk4Vi2LOfs0zcxe/savdXTm+hVTqkbdkNiGGIlipAjab/vQsEUHdK0pQb?=
 =?us-ascii?Q?M6cMx3KuoEoxqTwNteIylts5jXzggH32VvJ+B3WGYYS7M9uifqMUiDcPbrxI?=
 =?us-ascii?Q?AXok9eD+eJ0K2STBDhHSEUghGnWpGeBrVoDmGIijq+74tByXKxYOArro0+39?=
 =?us-ascii?Q?9KoGpMVm88sPu2QY1VbBl1jKirIQcVY+P1K4dxqCVxTkG96ouDATRTJgPVlk?=
 =?us-ascii?Q?3Z7OYvnhQbuPIT9q6TgsRB1HD9C9+Na2xQXdndPsbgf2ZxTse6pWlwUDmU02?=
 =?us-ascii?Q?YSNIQoUlh9C0KCfjwe2BJXdGvVJj6q9oiI6Jf6w/mctqbd6EWzx9dYdJ1gjI?=
 =?us-ascii?Q?/9+QB+GVUcA82o9b4OXSKORM1VmmKvt3n8bmdf5LXGhp9bnnE61U2ArHgDi6?=
 =?us-ascii?Q?Z/9SXOahgNMA3+85QU/fDE72NhqzXV/qnl1TgSVG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511d4830-cba2-4337-77d9-08dccce9c6ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:59:21.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkLmnQkDqqvW/3Kmv9kZ1G7A9sqUFexvJvvDZVYe27Kq8v7hltm0iNtgVMfsx5KC0AtE705X+UxgelkBc20pZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10778

On Mon, Aug 26, 2024 at 09:04:53AM -0500, Rob Herring (Arm) wrote:
>
> On Fri, 23 Aug 2024 14:58:54 -0400, Frank Li wrote:
> > Copy the 'num-viewport' property from snps,dw-pcie-common.yaml to
> > fsl,layerscape-pcie.yaml to address the below warning. This is necessary
> > due to historical reasons where fsl,layerscape-pcie.yaml does not
> > directly reference snps,dw-pcie-common.yaml.
> >
> > /arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: pcie@3400000: Unevaluated properties are not allowed ('num-viewport' was unexpected)
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml      | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Bjorn and krzysztof wilczynaski

	Could you pick this trivial binding doc change patch, which acked
by Rob, I don't want to miss this merge windows. It help reduce
CHECK_DTBS warnings.

Frank

>


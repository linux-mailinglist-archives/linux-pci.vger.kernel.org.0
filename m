Return-Path: <linux-pci+bounces-22353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0249A4458B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7E916669E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D68218C34B;
	Tue, 25 Feb 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b4agQAS0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714C188724;
	Tue, 25 Feb 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499914; cv=fail; b=ZS+SwT6jYNlKp6Vku4p17Z+qG8HXl3mYPs7fKoH2m/0VsG2KGOAz3/BpCWj27eDjy4HXRL85xZWyv3ivIA+soPMLzXy0WW/agqcyHT21Zr0+Czah7LOt6tAUgO4ts0+qSIMlXM+lLP2s2Yk1EpWhEczg8veTvvEcvJD3R6QEJzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499914; c=relaxed/simple;
	bh=0jrWnLnC/ZgjbPqMptP4XMtXs4/Y+n6gOe1MoyXuNnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YXXfwJrT/C/BZzuc6HqJBxfVnrXSUbIaYzSxhN0f4wKQecVBvEjqu3ckRcQWiRHaCyufZvFDZrQ3FhFsEnz3/hrmD8DnBFwRezk2jJsAJ42VWHbQ9mqMKxutTad0fHnP9pQrs5BlpqTu/ttAg8O5xcN6bAVcEWH+f2tz0iV8H2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b4agQAS0; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxuFeoKzqf9XJ04Sb7P+a29GkoSeaTAqazBqGt39wiAO1E6/7wF0xKjF4zSg6muI4Iqai9rcmWMvAQgpMMMDqNbrStzSiTRhB05bvkapxVSeL1PH6tulaHjs4CpCgtWyZ7vFlFFfJ66sly7K5p+Kex3P3iPDsZ301qj0UwTOhhFj0Da2Wd1DthDHUwxeBijakRp9w1vegnJt4MfWzoTH37ekVhsVlTikTFaNs+aRoKkN57SCLzy9l272QYDak1C6T+rq6Y4bHK+c/eGV0trM6Kkcpdqgfb7g23LxLy5+zJiuCIK0SR9nyeu49domIE4QE4vS/aIZzTLmCKsmY0RotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFOYsk9+FSlMiNBwFU0Gvn39nnBzEUBOLaIqkLEK3S8=;
 b=euQOxFY5WvVPI95UWwVAFYmqT50R9JI5q5vpcV/81JMcIMFLvw/1VzC3RN9qieDZyQGQTYsykW/6FKm83IVbZyqXx74+C6erUub/Dawqc3xBgtkFkgVGdD6x7mM72r3dQtEcyDOZl7puMnm6TOXTzBr3fVnw5Us6vG2L1QXZL7rxWMEY4fJEszAWacAvJ7GnCsBt2eljLicPJjrW3TYTsEDKCl8kSl3sF8r9+r6sYhUI1jPDCNRW2oxt26QWF/eY1EDI7SKhJ0HcKDJDsxMnKdYhaP8u0/faL7VP/ScTirfayN0qqAUhvdDhYZBY6gfn6ESkuTYcti+RFGIZyFllIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFOYsk9+FSlMiNBwFU0Gvn39nnBzEUBOLaIqkLEK3S8=;
 b=b4agQAS0vD//nXxJlGwfPxU143tweHrZhK+my7iF4ljdEbmG3qvN0i46A70p4LftsL8WRDl+74/strK3jsQHBEG5AHXoCzyRfU82/naGIx5gweY6vX2PpwyYfBvDUKn6ICkyBAXbNLGA0vnExHoW7peRu9BrF0XSwHpdKpQp6FswFnCb3wQ086qVTJlMHbnrodrqZa1rRdjXQt6x4bL4sI/CGWUgHYi72jVw4xTJw/BR41CT82EwlBI9I06Qxx9B7SIpy6qEJG37WzHynB7fRHvwqKNYeJt7onqrKHeOYVHCFLGomSFwZP62LSqif8o309c22ouiEFDJ748fywTBsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 25 Feb
 2025 16:11:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:11:49 +0000
Date: Tue, 25 Feb 2025 11:11:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH 1/3] dt-bindings: PCI: fsl,imx6q-pcie: Add optional DMA
 interrupt
Message-ID: <Z73ruVQy9vtrr45O@lizhi-Precision-Tower-5810>
References: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
 <20250225102726.654070-2-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225102726.654070-2-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 339bd8c4-065f-40ff-e1af-08dd55b71ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EU9NjGqDygFKJ1Ru3hpRBMDuVuybGbcVpuIe/zP7iaiMhMljcDiQzz0FNphu?=
 =?us-ascii?Q?VqoRXh4At7lsWyRGRn3/+Wm5rOZeHu+eWGkQzbPaCFKH3ZLHt0n9JXB3+ifU?=
 =?us-ascii?Q?pKE9lfdtMRj4eoB/yMMz7voW/mX32+zGK2zxdVhsgA7rNy7dyiHBA2/HTEUz?=
 =?us-ascii?Q?BQbdG3X2qINTYaE4JZw1UpJIcAuGdgOUGpeuXp1b/O66m/NXrf3WmqaffAw0?=
 =?us-ascii?Q?5Guo2nS63FrC5w/CPfNnbGgjzMjd5/ZjAXl4PJpG8qqbYTsIq7WEkOadISr4?=
 =?us-ascii?Q?KonAIUi/u7cC4s2O53ADvL9KQotLYBLX/XXjNF1eRyGu/C6RcGnRmPJfjbhD?=
 =?us-ascii?Q?UN3KdsUgdcmVvWoc1eP3NbGYpG7E7reiOOS95KO8zfR6cvqUCAgOqCUR/6is?=
 =?us-ascii?Q?0T+xNtLv63VK7m1ICXughtlHXiVvPvw/OCAJbMrJX891MKOT7kXLPZys+LV7?=
 =?us-ascii?Q?KWiuDS/aFtWM0QGlBSA8KHVhvhDiy4XnHVzweogRso2Glx3uQM3PjtobBBt7?=
 =?us-ascii?Q?5iWZ8gC85AxNrTe23jF7Q1u8xCw7GTKVW1AnJOyiYixaGrA6OY3haW1qb+fA?=
 =?us-ascii?Q?iWVsy/lNgeq1DTCw1UgsZZ+wI15g4MXmCTMQr7fgeA370gSOzMjT9kzIYfi7?=
 =?us-ascii?Q?pfulnZN1t0CAD9+ucrL683RNIT84M8M2Vnt/qxwCjYaH2l9shWqTLna5Yzw1?=
 =?us-ascii?Q?em5WxfkDx3q2BiOHS4pLULq4hFIKe9i8LYCdxWh5Nw1b5pRQtBHdGzD1ZaKx?=
 =?us-ascii?Q?Kbo9JLkgFc/LpNKBW/a9I1HXI2MsMQ83L+coLTUNKXvz57j1oan+htoPlRzJ?=
 =?us-ascii?Q?fNtlQhCZDoPyinl75VHAgKeE4YXyU70dXhB9LlNwBw3nnmDV2DJDXzVUVoGk?=
 =?us-ascii?Q?58dMNbUtfsleecg1yihVgsP9o2e43sa5z6qRFAqlvzvV+rGV/255YcQayJvv?=
 =?us-ascii?Q?QjhvvFlasi5X9MshjX9sypJ7qwfeL7jVh6FtrxrxiwwF7NFo6RWX7snNY7OV?=
 =?us-ascii?Q?maTIzVuvJ/Lt2Ds0ropQ+UNp60ENPDOPyKHvhSsXkTq9OnV0Ew5HjpeKrg35?=
 =?us-ascii?Q?eAbzYSF+mzmPkPIBDitU9DbwYZLVulA/evmqX8CTd7COc3BTPkHdXFCnW3EZ?=
 =?us-ascii?Q?sZccbcwsyCSIRGcIPJIF4t4WyPGP8BIsDxaGghRNIj1B6MoztDJsJioiKkqd?=
 =?us-ascii?Q?AQdpCejEV5f186c3y5/3qrHisn4Yt/s+Mq3XqSAhrYKM6xkUT/M+YTt54ldX?=
 =?us-ascii?Q?WhpGCTyoO5Lz9jaG77a2q7dxuWg/zFSA/QQOjn4x8gLPVHZQTKpxqpcfZQUy?=
 =?us-ascii?Q?8212ptgvyrpkpI9038qGHlhl4bHI0nlnCMa1LEIYKsrhE0tQ/w7Rh34AJo5T?=
 =?us-ascii?Q?+2G0rwST+QX+//wle/gcYCguPBSh5B0zKD/oUWmHVnj4mPaeIiuRDhOhaIxr?=
 =?us-ascii?Q?wgQ9gaWPsmtwb6s7mXzt9rSeNoc/Ko9d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GxtA+2O68CJfnZ1W07HHUylGoKOb5OY8xF/ELJgn1y32kL4wEHaRDh0jt5no?=
 =?us-ascii?Q?XwV6e/VEa9JwIveyhGIPuFg9KIztP3brNrkrf8Lub+IxiXYXd3mOGsHk+MDN?=
 =?us-ascii?Q?MnSlAo2r/EbVsQioFYkIAAtD3y8+qUn58A6HcyU6p1H/lueQL5Efy10j4X+j?=
 =?us-ascii?Q?4SPnBlznsW1upCr7aup/fAPcI6WUbLByH/EyG9tDV/h83ItBoam6etfc9Dl0?=
 =?us-ascii?Q?WCbvyapmz/OZ3bPTeIbUYiy4nbn1ny8jyHfMRbTS+nQ3tNakC3xuZUrORyy8?=
 =?us-ascii?Q?uKBbxWMCwHKC8qd6pK83daXICWcV9ITTJnP44keMTVYduoJoAosUBLBoNvuN?=
 =?us-ascii?Q?9eAyXE2GwC4bG8R597jclSJ85I9z38/rZzE7cU5Q5pcD05u24bxooJjDCXgt?=
 =?us-ascii?Q?vNcdvqmBzeji8DFBkcry8UaFsYpleoObRS1AcMByc0dTKywBnnQNjCVYW4QS?=
 =?us-ascii?Q?PV1tM4FTMNfLfjBxzq7EP7StXlEFLcmWmW8vv3tRwrBqAWzdTkq0mllv0cGE?=
 =?us-ascii?Q?0XvqB4KN07TaeXYKO79c4Wpdgpaklvzy47bCCMfuYJsd1LvGLNwuoGnHfx1T?=
 =?us-ascii?Q?o59rLUKk2nbL8zkG/ZzWrUcf/Be+at++G8gzOUJWHwjfO0Y4i624ESrTkU6x?=
 =?us-ascii?Q?cyOFPJtXmd+RzFn7J3qqffOvvR25wDZo+Vr1XD3oWocLKDX72S6YigxHIU+1?=
 =?us-ascii?Q?xrUqXw1eUIdwZPEueCypcMBjfp9fw4GYjFNV3xYWOhONjy2YA2YVtrbir9Uh?=
 =?us-ascii?Q?2WUJPSRpvHwHPPzV42r2nRFFa2GbZGd8NZv71Z7/QzPe6gT3e4qe9lJvBvFp?=
 =?us-ascii?Q?vXKCa1CDa4IJzi+K9BtS1jZwzXbBOgU39y7NhvI+2RuOl9OyC9IFCQ7XxK26?=
 =?us-ascii?Q?nXVcVeKf9C0WB6ooEmCja5VSLYQ1t+w0bN9+Bn7saNZyE+4gczUcPQWTFjFE?=
 =?us-ascii?Q?XQwNfppyQCWtxkggATU2NlH9dH1x6NkRln/7Z0ALD8e27sjJKuhoiAnTVLG0?=
 =?us-ascii?Q?b5eGGp9u49shbN+tGWWn5anuoaI4j6mrfwXhGK6fbPu24OpwA2Hf+e022lbb?=
 =?us-ascii?Q?dUWjuLp+ATw64LoNElJQdLJ9Vb4B2lJFk2iskfAWJ6Yuou4JOpyj0oKzihgD?=
 =?us-ascii?Q?xX/bTmMqopjHtzr3Mpdfnq8zKuwGpV0JKBKew2ejY+aEx7HUV8WVXODcZ2Ke?=
 =?us-ascii?Q?sgG6HcPP8+yWhjXvcEvT6nIdY8VUKZpIREB4YsN5p0dg4sw5NSmBfHOJbZgC?=
 =?us-ascii?Q?AyN4hxu50bhRUMoShwAYfQ96dHEnH0JNWZJMyxLyA8uXR4cx5eHSopyKcP1s?=
 =?us-ascii?Q?M0J5W9g8n+VC5IKaHNhXCHDDMT0q4ai2VQR4pvudyE7h5Zu7TWyMi3iT0mhI?=
 =?us-ascii?Q?PkZXR8RelDct4kllE3GRtt1B+LKcyErnzG4h5Gdys2PdB6RJhBnmCTbTSAEh?=
 =?us-ascii?Q?djLjxcC9epbTsmm1VUjM7Z+2C0fDcTI5nDYYdA+bDMybfp7frtIN27yx7MUU?=
 =?us-ascii?Q?bvZDuc6v9ucR5oFBoozCqC+kUNQ0VGa1atYDwmhZtTkp5V9peKTnNPvsG5F3?=
 =?us-ascii?Q?eSjjVgpo5Llpo5GCW7CGe1t5OG3Wq0ao/26/eOmL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339bd8c4-065f-40ff-e1af-08dd55b71ba5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:11:48.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xY4bqFr+zGBOvOrMhGW8Wj8mCUa2G+4R22bSQSoqs2Mh9/g4wHIsGmoMewXxdrELzAR1oI6CfRiEUj31Fxnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

On Tue, Feb 25, 2025 at 11:27:21AM +0100, Alexander Stein wrote:
> i.MX8QM and i.MX8QXP/DXP have an additional interrupt for DMA.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 4c76cd3f98a9c..ca5f2970f217c 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -47,12 +47,16 @@ properties:
>      maxItems: 5
>
>    interrupts:
> +    minItems: 1
>      items:
>        - description: builtin MSI controller.
> +      - description: builtin DMA controller.
>
>    interrupt-names:
> +    minItems: 1
>      items:
>        - const: msi
> +      - const: dma
>
>    reset-gpio:
>      description: Should specify the GPIO for controlling the PCI bus device
> --
> 2.43.0
>


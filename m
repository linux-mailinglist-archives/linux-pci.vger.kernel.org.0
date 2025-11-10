Return-Path: <linux-pci+bounces-40729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB83C4873E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 19:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292A918915FF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F43161A5;
	Mon, 10 Nov 2025 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MzZ6tTEX"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9C30E0F1;
	Mon, 10 Nov 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797544; cv=fail; b=D1GupvhUld/PB70NQrsek1/WyUwOzH/pxQYpemAoBysAorZQ31agZxYPc9F52soQDK17VudGzGywQnyJwmXFv2FlRK/+BOkNP0bblUnq2oQ5Wj5zLovvEEWj7tK62nH9MI/c2Y1+xODScug+OpINMibUBgVQiRnD4n3VuJO3hQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797544; c=relaxed/simple;
	bh=vQ1n3SkwjJWuJxRXS5pOOxsQstWnPGNeXtXssW+kwAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rRQ8nTX+ouK4Nfz46zfxqd+0dn+rysY/wHbNl8OPEaHidJzibpe9F/aEaQWw8+GJVKnureEWP/kd50S7KmHbQNjKWDjz++5MVdulWgs05dr/cZFp+kg289RAs6U4nGjFngoMmetK1yNPlDKU0shu3aZo6GqSiL0Addj4NZGRm88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MzZ6tTEX; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNEje8UsqEcnUFdwTW/yIuOod89LnpUWUEGA2HAXqUVZz3Uzw4Zr/ntBatEsMsKxDBWo9j3vXx6JVwhvHHpVccXetd0OlAZNPPhNSfQtaXZ77jShjoIfH3+V5fQ1Nd4rDyIUy1u9Nd/uSIG8SqIA8cTEPuU9KRP4FycI/hNg9Pcl6VsZm6l+Nrq69MAQFkoMVtUiUWDL3mVGhzlSNClGMRDxNLg48PRH3g8Dfg+TVFWaNd2r+6vDRoKG4Uaa+JdGT3F3+2c1bfH/fKJbzXKvV1qcG3tY19nW+FDfA+cvC5ju1aivS67ouS7caH+69TAAOBkvTs/8ZhprppS0esH86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZybhZVXTtPKolIzLW4P6Q7EFrq7yKGOtlg3gmHO23k=;
 b=mEgwetM//V4PqPfTb7v3JyVeNcXfJR1hkzg4WTV2pPCkjHHCt2OQjd18I4IoEPNASqQlRXoxAK1XE9+5c7z8RXp0sizNx2QxDLreaYikvhCEK4zmGqrh/zCBDC3/oO2p+wsaVzwl8T9ueDmpQ/XfM/5iUcZqPTncq+FteHDvn/1L6h/vBxmtCRg0lFJ/k3yr0k5PH74ltf4TU78vAfR3uz1gKRoTXAx0VmwF9Zx1gRaSLuEXiI7GPE53WYaN0STrwqneNWjW9Nl7Qq8I9FS2fLe9RFLaKYkWKyQ5dNFkqRdUXT1f6iCfaf91U6aDp9FJueqgkO6lKDEhUGzrLN5NMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZybhZVXTtPKolIzLW4P6Q7EFrq7yKGOtlg3gmHO23k=;
 b=MzZ6tTEXDrYH6hHOKH9vbdRFPSvTR0hxLqkP+VSSyRpVngkRt3OdzwSueDPYSm28/VLzIUoq3uzYboCqO9odghsU6v0QRZEE76G07xh0Aa8p8AugmkRqu+0w7BcClUioJhC61mIry0n90OU4hbUPUXrC2x3sYaWQ1H03kNK1nVQZFN0VjlUyNzDYeKypRV6zfzmGcUjwp4HlUXui/q6OMnmy+55bZKZ6fu+xg+hWbUfGf0h5KtMwOA5P31hxVkfk/sg8QB+jvG9MiIl5HuuPAkAMSKas31aQvoEtcXLpv0NaTthw5RvQdcjlc8DxYd2zKQ7fDreka5bplZgDwPCsiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM0PR04MB7169.eurprd04.prod.outlook.com (2603:10a6:208:19a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:58:55 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:58:55 +0000
Date: Mon, 10 Nov 2025 12:58:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 1/4 v4] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <aRIn1COnQG6Mz27j@lizhi-Precision-Tower-5810>
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
 <20251110173334.234303-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110173334.234303-2-vincent.guittot@linaro.org>
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM0PR04MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: fc261139-f8ee-4d32-972e-08de2082d04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fSbr5rG/Okl5XhUw4kFMce0jObWTNNWe/6xPUsVWwzr0aq8ND5WwRI09naYL?=
 =?us-ascii?Q?rWJHrXZIoLEQ1kvQHRJiwGgst2kUYv3pN5pVHkfL27AL0+DByOjlOwnmUis1?=
 =?us-ascii?Q?JvuAJ0DdxTCvm2m4RMLD1LzpU7mFSilxEFjUH/L+s1CMWlHY7y3dlMjaBKpO?=
 =?us-ascii?Q?T6sc37rZ/ytLg1dCyKv1lYLwvhovqDmUC4z2njCVrKE3O2JUGJncGIosIQ6o?=
 =?us-ascii?Q?kDEvbQQeE8IPpYzqiNCPrlk0Tu4wSMXQgosCNLOLBDOqn9/NI62FiaOQAF2y?=
 =?us-ascii?Q?XYUgQjpMbKwlsDGV47okqQ97GRY4zilEF8fabCtOQinIITJg2NdPHIJhj9I1?=
 =?us-ascii?Q?he4s0PSizG5cfP1a+k3brwC1HdLpoWqxfnPhg0yjwT4LgWEO0qPkNI3ULY4F?=
 =?us-ascii?Q?ksM0Cvp2zbtZw+qhUEcFuaBPnbOpHzTxMZ/7QR+JxF83PwXk+2ovFj8bwEAV?=
 =?us-ascii?Q?szlWTDndoXFLPZJV6q9rp/Pc+rAvL3fSlW/hvo0qoQ0Hlblpo312YfCyPGIZ?=
 =?us-ascii?Q?frF5MX6pbdWx4tZbjjG+sl10br9MxvLsQXaX4oVmQeSKm3ChRKRj1O6TJLwQ?=
 =?us-ascii?Q?/9MpaQ/3RgpCKtbPm0CsKwnS+UQMMsS8lcBhV9b/Fh2m/ISHXeDUiKIQ5dhB?=
 =?us-ascii?Q?SlKyE7K2kVW70ThF8KcpLhkuYbCXjxbcKQtGA4/jJ3wmOP5Bap1SernID0Mi?=
 =?us-ascii?Q?0SEQqShaZj5ZJCr3Y1q4IsO3y9rboYvnLa9j6c4NQ+uNl5191dHyaFl+uUZC?=
 =?us-ascii?Q?35k6qjxKMUUW0hV86fWnuz/vBuW+VGelIXh/DMqGaRbW6Li0vv8N1+JqpuEz?=
 =?us-ascii?Q?8euDJfdMNQIzDuoZN5ykjbh8hkpf/JgsfFWETQUkmxaoAL8gBR0b+4ToSnJH?=
 =?us-ascii?Q?i+r6SC5pptSm8hZfCfilbZjONP8DH/UwqqTBZFLUxvMFWP29SudF/9iE/mhb?=
 =?us-ascii?Q?57ltouPVIar2p4gQD/TyRp1FXDUuTKkCw/nl72Rx8fvhTANMjm2srw13wKJw?=
 =?us-ascii?Q?Jj3D2UCJTpvOfqb8FwteEQU+IeDyJAWv553jNB+heK2efLG8goi8JEZrs26S?=
 =?us-ascii?Q?H08Wqr1fKYPLjE0LUk2Q3PpH5jsSwySTuCZ1YsuHvsfwlBaDx0BtIgg/iCxB?=
 =?us-ascii?Q?vvGrco8W5QjXvIaHngD2hfuOzcYlAvnIkvZVTCkCJjJs3oM25GZl4tlJTajI?=
 =?us-ascii?Q?iUiIZkQGmX/tagwSGA0Qr5SNdpva/1wS4CpH95gpluYGp43vrtLVrVii7fCO?=
 =?us-ascii?Q?qUaaxBcMleAUHKmGNy0uBCPTgym9FAiafyuwXogDwDFGe39O/WADkyoX193S?=
 =?us-ascii?Q?e91C7PxklE4NTvY2WyewTeOE/mqGkbv33lXgviNOLnlD2HDVyNrcUroXWwU1?=
 =?us-ascii?Q?KEVObn5e4M8iZpdRZrFR2KG0RUdt+A5jyAVe5z1GedlvCPUJLdut4I76oqQx?=
 =?us-ascii?Q?yVOrv+WV4wINkixa1U7ZtE2XY4go31cXQ17T8oFFY5uICopWLCZsKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqw3C+iAAacL7soEE27mulEL4ZhjsMLLOKUSxmOv0GvUkruK8V8umIZ0+hhu?=
 =?us-ascii?Q?3OmmwTOOXoY8MHZCK/UAWAG8FwmYzBg1raYy5pJpAJ1Sui+I0G78Ybd6iFTW?=
 =?us-ascii?Q?M7VnbFnIPfUmG0n+iYfFx9V2u7ow6hs00d/1dGVnl40FMPnsFeYLYkLdSpEo?=
 =?us-ascii?Q?2sAQTBxMg8wLK2T2kX2qVPt0L8HlRBl1AJVCe+IRc2TOBg9xFqwoT6DQ9K19?=
 =?us-ascii?Q?387GITmXmXA+aMhtOpK15QJ9ZoHvcaQzzw4+7JRBB9nrknvfEg9aa6ugJKch?=
 =?us-ascii?Q?+Ziu9oXUFVytwMqOsik0nAxZqy+CBwFyoWem3zZsiY+n1f2UJZie8nheyRPp?=
 =?us-ascii?Q?YA+B7oyT2PdXeXitbWJJgraKIYr1aTTksQYEuViQkuLroVw5vJk+Jt3BJ5No?=
 =?us-ascii?Q?AnmIGLXC4c3gY+VEMXG3PY/404+R9rQNeCmxBiHYZu9hc2XqbK5q5/PTBr7Q?=
 =?us-ascii?Q?KbUOw/MglTbWiX165Hn9vKCaoaFdTdPf9Nfv5ecnUX7QyjhC2UUY7qjN+Ga3?=
 =?us-ascii?Q?XyJMJWIyKAWZQE9RPxdnykgXld75k6XNNLpSdhZTi9J8Vr1UDzf2/pvtyTtR?=
 =?us-ascii?Q?a0scOi3G9u23yzGwYtfSjF9cACK08YIaoOfYf0op8e9XLbe+mqYniQqDuq+w?=
 =?us-ascii?Q?WGJNX+PP44c1UyqGYZLukV/5HLP3iGfQOy375Sc98LWVJmgJm2Wy4Gy5Ctg4?=
 =?us-ascii?Q?CI3eOs29tPpJoz3DVHNEK2+/xv8gQDnj6y3qBK+MXTLuL/9lvD9g2lBWFcAO?=
 =?us-ascii?Q?sk9RTEJDOu1oa8Zk5w7tTX2uCJXOLaZWbpIOKsQBYChKdXqZ/1oAP5rfdgyw?=
 =?us-ascii?Q?U0u9YCydi7Hf2v3mZfsfbtd06Cyuqp1HGUWdDRlir7oavv43OovHLajySX9G?=
 =?us-ascii?Q?D3VPdvcEmNTrIqI73K65jtRLwDcaxSi0Mra1b3q+fiael1mIadcOjfWQB0Eq?=
 =?us-ascii?Q?TTgj49Vql1mrwZmIvnywiWh8KhW2yIW757am1gRn4yvznRUSWm89Boz2vlqz?=
 =?us-ascii?Q?gpArn/RAarOSrHqCT6FNssUz+1ZrXOIUaVMMxCSVHaqMK1Y5qe6//7IuKaRz?=
 =?us-ascii?Q?O6UUDgrUXex2Cqe+f5n2EY6qTe+ugZbcdeV9ccWpBJWBRSKw57ekq957nj/v?=
 =?us-ascii?Q?Vz4p5bc/l72YrpC+CdnOhFUwq+Iwo8DcCjAaum+3VPUThgjqsssbopJ7Zqig?=
 =?us-ascii?Q?gFEp/AD1oYmuxeWF+qZ/INPvZxPAHdk3WPoVRlbtF/rbo+2MC6Ip3DyIaoZ2?=
 =?us-ascii?Q?4yjsHAY4EMtsACWVes/81rByM4rIg0+c/11/NWaxJDGG2Nhqvz9PlAC2Stgg?=
 =?us-ascii?Q?u4NuQrqn0jmO/uwCVc+VRDn8eZ8RSEhbjGXBSdJDgCdkjhSOt47lZM2mEYgB?=
 =?us-ascii?Q?XZ5wM8Y3v/mbkXMRJsveJN/1BJgN9qzdXtwkUF+qb3mnFnr8qgm5IYUxtL8C?=
 =?us-ascii?Q?7Ico4D96DwhlCfLFBQTLq+IMNAcgAI6BDOpOJarqXgsH1Ct2WdimH1rJc5kv?=
 =?us-ascii?Q?1dzX5508E19ejefLFKc732eS/1FkDuNCNNc1jyBAsAcHKBW+yCJ1aQbPPAml?=
 =?us-ascii?Q?/N9XSV6OQCzkAYzuCKfFPaqy0gsfDAnr3BtH2XpI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc261139-f8ee-4d32-972e-08de2082d04d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:58:54.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yot3zH08S5Js8hTDKAFW2LJrIhQcTxOkJKQpypgsJoxa0zk8ThHZ6X35zt0Qo5NzwTbAE0fwbTOwB8Ss4psTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169

On Mon, Nov 10, 2025 at 06:33:31PM +0100, Vincent Guittot wrote:
> Describe the PCIe host controller available on the S32G platforms.
>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> new file mode 100644
> index 000000000000..6077c251c2cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nxp,s32g-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xxx/S32G3xxx PCIe Root Complex controller
> +
> +maintainers:
> +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> +
> +description:
> +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> +  The S32G SoC family has two PCIe controllers, which can be configured as
> +  either Root Complex or Endpoint.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#

Suggest move allOf after required, in case add if-else branch later.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-pcie
> +      - items:
> +          - const: nxp,s32g3-pcie
> +          - const: nxp,s32g2-pcie
> +
> +  reg:
> +    maxItems: 6
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: ctrl
> +      - const: config
> +
> +  interrupts:
> +    maxItems: 2

Need match interrupt-names's restriction

      minItems: 1
      maxItems: 2

> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: dma
> +    minItems: 1
> +
...
> +
> +        pcie@40400000 {
> +            compatible = "nxp,s32g3-pcie",
> +                         "nxp,s32g2-pcie";

put to one line to save LOC.

Frank
> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  <0x5f 0xffffe000 0x0 0x00002000>;   /* config space */
...
> +            };
> +        };
> +    };
> --
> 2.43.0
>


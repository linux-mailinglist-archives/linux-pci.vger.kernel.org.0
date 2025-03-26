Return-Path: <linux-pci+bounces-24732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F623A711D4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316923BA8BA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6618CC1C;
	Wed, 26 Mar 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FmhNLIrp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8517F4F6;
	Wed, 26 Mar 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976035; cv=fail; b=Fc/fZZrO4OCMJOlK4YsRridFqF7XnV9ddjqDHLWDW3QU6R/6doD7/5NVR3Qd/WON84ujK33ZfjdddoCKZIU5SRPncpfUuFKpRclgrK08qcVMTe8hUL73IhSwAeqU4utpgf3DN75MNIfx9L5ZqlRY4ts+TOIV9ML/SeWZseJSZ2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976035; c=relaxed/simple;
	bh=MkqWkzGs8k1vwo/xvA6KkTeLZkUJL8nYoAWkwVU63G4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Yf2aac0eHW17IdPB1wXH0laIjmdq/Se++QFbu0sQaHo9d53frU2BpdG0nLow/Ik6Glw1Tie85cbvTVfzljFy6SEifh2D5goO8ZSpfIETRZWaP5wMU7Z5a/Kk2vSvmH/NVlfYlPQ0zUCwJD1pq9VH0L63W+e6BSTUBeKxtJ/BBmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FmhNLIrp; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjF22PPG6IXYwzCg5U9eOgFCS3uW3/r3b9E85DaUOTyAGg31FecJJBnQOQoGiLo3X9b2ujJ8BNM0SbcMIrRSI6HtX8Df/mf6J9QV5iZWeYpjkd3bdPPskh0pNdN494u/xPXH7RJ+oLUM6ilB55ZHEF4Js6qUHMjzQVFV5Y+V50bri9aPvFkXATKFinT/6k+BZmzN5aMZrVLuOwm0bgLCWoGaHTIcifYhg8C6Gex8SG56Uk++3lHNvxWEekV7beBVQcaSanhCLnxHJlrDT7oksM1kKU9SX5wu0AZF9Ls1JXV2P6D3opnb+HhNewxLeYOafKKJJnu79uJBIVBCokm5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkqWkzGs8k1vwo/xvA6KkTeLZkUJL8nYoAWkwVU63G4=;
 b=DUobDZUZz9woJNuD13gJkxMQ+diCfhvRcLBfDRWUiqZmY9MovNAElLa16sLMt4WMxj2WRnv8v4bcK+hoR6/YvIQjE8AoQ1kC4dR7ZPfvz0pzpPX23JtliY30TEx4J+0iD8yiUkV1DjdzQpJFrzFSEBv3mGe8IlJBAb7fJ+fQaSVkYfyVSg2SgT3EITQi3Zp9BPLrvJVVFby1U9AoKuUjoaUhACz8jOkbGVy3LdgaeVuSskLHxsPpkXluGSeYW9p4Kx1iCaYBHrKgR+9dFGk7wVnZpHuE+TMxQ+pO/gkCEDmHMU4W0k7hrxRHEQTXfD//nul/zyiphT1V0ciBdbHr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkqWkzGs8k1vwo/xvA6KkTeLZkUJL8nYoAWkwVU63G4=;
 b=FmhNLIrpJhpjcWSUyw1PD6emcZddwu9t4SoNENjs/yZNF2f+7kSvsrG2ksL/Go/9U69Hx35/4qlrhBQkS3IkPo6thwE3Rr+m3z4/OgeQzSgvzvl/xt3Ij+SZlb65xinK8x3FYs4VV7930xdnQOHhwyLdq/9j0Wq9Gjxzroebw62D4NGYw1n2OFlluA5Kxx26FcbQN0DmOOOGJzRPs6x5My3qS2fw8vzDekQAaZyyutHsJ8oCxigOihtANQruJ0ntNOfF10gdXqccmo//S/Axy51jMEX8DrgF+bBsv808tuuwzHdMnWyUnTuw/54mSlWsdGocbPSO1JCKp8zFp8NaUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 08:00:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 08:00:30 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add some enhancements for i.MX95 PCIe
Date: Wed, 26 Mar 2025 15:59:09 +0800
Message-Id: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cccbf6-0742-4960-bfd7-08dd6c3c470e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1E39AmHcM2CVkPexAWHUKF8nE+V8vy6COGz/6NoU+Yv3OmQBY+gxrSV7q2s3?=
 =?us-ascii?Q?wApHV0ZroKdVQDFmyIbTyjVtL/1Y7fdd60yfOL9ddGAUKnEAK7RHGPP7kEHC?=
 =?us-ascii?Q?EXRN+vdzJb15SRVLBLBPZIsISplACjTVdipadMFBXZjC98RBn4GHyAoE0wqc?=
 =?us-ascii?Q?zf2YvX3mI51xb3wp1WGRbF4H43/vHJEA6q1COKZznFCIeIC48VXiEPpTRsMV?=
 =?us-ascii?Q?XYqm8YUfkW5j3Myu/VX/kKb3DBeGJefYMBOwq0u1RWpXFzpdzb+U0owRkA9+?=
 =?us-ascii?Q?pvj3qJ4hU0y7O6y8NhtklTcX+cwQbrgnSWrrKTYW5jEW3Cl0U3vuLCVXoICw?=
 =?us-ascii?Q?JNa180tS7ZvIZWI+DxKym5ZGFtZmvsPSPMl3KN7NU+u0hZJbC0og9fxsurg2?=
 =?us-ascii?Q?DtIIWWz5TBhlH/pfF+kjk/KmPxgXJU2KkXzAnnCi0QTuJXVx1mX2/JqXuCme?=
 =?us-ascii?Q?fJVCHq/TC4qQOD079IHqGZeb2TcG0A8hB/IGhcuOmwHFV63F9w/4pfdqf11s?=
 =?us-ascii?Q?HYkzXblJDzPjI2WoC3FEZdavcx9k6tkfb3kOkXsD1s2r2aeBDHI22pCA/cws?=
 =?us-ascii?Q?eHWW6Sr14Ewes3cBW9iaLOD3pkRMfmlqrGqkzcQL9PZwqII1j5dW9QxVGQc8?=
 =?us-ascii?Q?msRac0OHiIAYW5qd8aO8fM4QI5kovaoGdl3g91P0alEUdJsBNBDk4aMKx2+o?=
 =?us-ascii?Q?JjQgtpd66SKOg+VSn3FugHYw6XnPfiL2wAtJn0Wz9y+sEoqbgob/ETiPVRh2?=
 =?us-ascii?Q?oHpzEM2dZiW0mhv+a7ScBeg3Xmw20TT//wEVwuw2PqIisPVbMOHM0AS1tzp+?=
 =?us-ascii?Q?6fz5/TGRKGzUJUKsPcmzB4h/91JNA5oc6juTmf5EDBMEKEinFn7DYyk1lMKb?=
 =?us-ascii?Q?bQh2mDgGoWvwZlgJ4odcvN2z2YKE+ST//NraQCEkrnakXYuv91Z4TYq8PblI?=
 =?us-ascii?Q?J7tRE5d7H8ASiYvQSPOD5ezR/vLyvgL0GgqpwaHLFQYBKoZ8rwJzfMQGG7Tm?=
 =?us-ascii?Q?aEoP6TBSsCAiD208OOKNLgCh3bNXxeHHevit0vxqUdUP5LThwWh/k5UZbzvP?=
 =?us-ascii?Q?Ez7NU16YDlutCpGsUDNclduls3qgyLtTWa1IFCJkVOVYnTiEqTYnnaFSKdxe?=
 =?us-ascii?Q?6HSVvvWuad5njJneNUU9z41pnpP05tV3MmMzK0E3sgeuq0Szn2gAOTMzZO7x?=
 =?us-ascii?Q?A1sfOHceJ7JkrUwi1hI0suN3AFsAW6hNOuuFmmw6rxdUaVuJTtb4wM3w00k/?=
 =?us-ascii?Q?H3H8dIqxITQMS5iHGji60nQ2zxTnFy9rueezKtiWl7DHoLIcCsB0rPrR6rS0?=
 =?us-ascii?Q?yFERNGzc2Me6mYrTZ5rgag74v26545OR+AvUjG5AnwkUMYNTAbxgbIG5CjGc?=
 =?us-ascii?Q?S4vkVyTv0CCgD+ZYKNBK273Yfn6YEpzEhXPV8wl/Qxe5mca/bt+5XHAx6SCp?=
 =?us-ascii?Q?GZ+ZYZQ/oX/PY/Azg/Lgi5JfJQSYJZJFCzREDqI5iOG17xQFNKGXkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZcL6LEyTp7VatRIpAwMhdo8pTKsszdkzy0djpuHMKk9LBmjhZTknXx6yRQiM?=
 =?us-ascii?Q?yDxLQ64Pw0958zgY1W134c6w0iAVEfy4lLBPXH6CJNXnLdQZEVPvvDdhX+9X?=
 =?us-ascii?Q?a9KDzWZ+iyNmafQsGE+VI+/Tq9BLgzyiRV+xnjrHQMH7rAJrkTo+88wUeUgQ?=
 =?us-ascii?Q?4DhrCTghfHeomCfaan3wsZy5GvJ8S5siYh7J6HwITv/NUX5EedKer+kUmuVD?=
 =?us-ascii?Q?UXNeK8msNBSapc5b5xck/XOkBPeCMKJI28tn6SCeYq2EMda4JDjHQIGldgfC?=
 =?us-ascii?Q?TIeH+/b0CGLiglEht8MdUkFEtp92Zlz7e0Zzfg1R+/1k3cIC/VK+msfUJ2Ue?=
 =?us-ascii?Q?uy8EuVztwjAxif8kmQrf1kuc7RDZY4mr6RDXh7zRL2kaBJbG773Ki7I18bXO?=
 =?us-ascii?Q?cZJVzQ2QCI+prqlljmbSKjhtBk4fYuLUn9i3Hgj2oxYN4qmw9RalRpQznZyF?=
 =?us-ascii?Q?QvJD4tyJJ9yi4GqK/BJLtqrRi6+Y+cEprXmSUGBKh3qgiw90QjUGx4ne/q79?=
 =?us-ascii?Q?qZXT+/9KJes91vPZTj8yWXTDRoGfFtjm+YFfNoSMfsJu2dVIpOSime3gLb+i?=
 =?us-ascii?Q?6BiUpI/GvBYOg1gHBZu01kAr1ShXpFOKJWuDG935MURaiizIw55z7RJoqoOs?=
 =?us-ascii?Q?h1bAfCU87Y3WyDX0fTz3Esah/7i3J0MdnnQavnV7J01pQmDg4JdcgJxTnI7O?=
 =?us-ascii?Q?3sN7f7v59F3k/+gA1uz3vRGw/DXZz9EAaP2BYzzxFOCNQtY7gfORjCjjX0HI?=
 =?us-ascii?Q?pAdiVXiVj6yOzwv4htFKB5LtFJtDuS4/Nj/1KgHSWHQjGvZBWGfuhwL7Xsi1?=
 =?us-ascii?Q?CKzeGDNj7LUcjZVYnzvPbhCx4IOmzd3U/wDQ+lUedeiq34BGdS31vLq4ASRI?=
 =?us-ascii?Q?MAgPyemS9atEy6uUeXVgYdc3GwZyi5CiMcmKq53tWrHTPMLg1QBG62JcNX4t?=
 =?us-ascii?Q?BGIrVxCNS79ctVNy2HIrxZHl9FydkWjafJFmXLcbpuEeVjk+UyvFh2SQ7T94?=
 =?us-ascii?Q?3NF5w4nPc5vILaA05MXb8IVk3/sJj2TAffScWC2bHxz2HVnYygqpPmodSDZq?=
 =?us-ascii?Q?B4qQZpzob2HWnR7WwWVxcMLNMO+wgBBcAfVFsx2MT+O+MP1ZCdI0v6yIoIhE?=
 =?us-ascii?Q?aGwloOuBThNRBwe5ijTdUxJKeuJDzJZK+CNKRgU9Ga9S+QkKjbXzLIAScbWc?=
 =?us-ascii?Q?uEXYvGqDDZ8OaoxcJo9NhYbT/brWXYc/VJE8oWMoKYlLcG60QE7taZkHUYMJ?=
 =?us-ascii?Q?monqPcJ4W7bOMozx4V6IiLk/RcUZinXmjpctzlJJcPs1HGHa8BJiY8flVmyb?=
 =?us-ascii?Q?VMZv5BbVgwKtbEF2Ljm4PMzfpB7+Q/rroaxUYoT0ikuC/JL+pXJRs4olTuGN?=
 =?us-ascii?Q?EiAbByEytiUy6Trp8TunNE0x6zW7mn0WHL57Y4Tq/yB00sLNRAjXvq2Q6XpC?=
 =?us-ascii?Q?f/KlXAvFdoy06M6IEmsV15J54Q1zYID5IQY06hzlRD/o9hcnzJf790RHFTMC?=
 =?us-ascii?Q?3TZCsU8dtp+58WcKOXWVU4ZnkuhWdXDyT5IteXhv5HwtCNu01SZqY0LkVyAU?=
 =?us-ascii?Q?Oa0yR/NNhwb7ApyRWgGGdvnxj/ucJabH4GtDSzUG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cccbf6-0742-4960-bfd7-08dd6c3c470e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:00:30.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFrJ9JCrKlGqCepBmBBGQXFPJvFRoPjVW6kBt5k7jYwKJFNDGu31YMFihCaOT5Dhi4cLXpidxPj/T6neH282Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8948

v2 changes:
- Correct typo error, and update commit message.
- Replace regmap_update_bits() by regmap_set_bits/regmap_clear_bits.
- Use post_init callback of dw_pcie_host_ops.
- Add one more PLL lock check patch.
- Reformat LUT save and restore functions.

[PATCH v2 1/6] PCI: imx6: Start link directly when workaround is not
[PATCH v2 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
[PATCH v2 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
[PATCH v2 4/6] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
[PATCH v2 5/6] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
[PATCH v2 6/6] PCI: imx6: Save and restore the LUT setting for i.MX95

drivers/pci/controller/dwc/pci-imx6.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
1 file changed, 175 insertions(+), 22 deletions(-)



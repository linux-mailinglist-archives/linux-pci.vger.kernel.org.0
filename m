Return-Path: <linux-pci+bounces-13044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B09756E4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 17:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EAF1C23006
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31A81A303D;
	Wed, 11 Sep 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J1lAfLJZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ACF1A3052;
	Wed, 11 Sep 2024 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068117; cv=fail; b=QztkTjjjw3OA+JZB5zf2quE5f708s7NuePBpNZtT4yI1bTq37r0yIpVFfs0x9l0rb3OCJU1dEL/9dsZHmob95/5MsCm77Wh3hupuZrOdAc8ijD6Y3AZnIcq5y15/SZ/F2OQhqq3O2PgdNsKRhYMXCrL50JtSKAXQK0fzhA7PeAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068117; c=relaxed/simple;
	bh=GUAmsP4+4yMGrmXacX8ccG2r9H1Syn9P0fXtMAR/WD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YBvPSyN8dshVETXqTup8chC/Ei0/uL9VTh92C6RSyePYOevk0czS9LM9KJHX1xPQR/dwrvj4ZD5bMj0D1Bdae+YIII4sWRjHq4jTjsyst23hTX5k8G4COpXBtqSRSzLbs3fql1jwx3rXt45H1djUkrNTHzCaF5yIAW34o2YbFnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J1lAfLJZ; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgqBotqk1wfcvEQVGijHMY5kjgk+M0U69sYE2JOC6+0IfssDBrlPjuClNY6WnF8GsqraAyHmWC2Ecu8b4ONisY6PxVHOUVx82BvTTDqbELkkUWNTe2khTJ1Xa2yTz2i9q3gODYi/tTOlJVaetHPXc7pvG7qewe3YQMlYFccoO4bFdGtBpVc42EMa2zTSvJVScGrpJ9DwLJFRlHM8MSfVaAhy/rr8sXSe8FQ/YyY3/s1bgHMSktgsVqwANsNKiXzwP/pCVgY9CbgFp/uHosps0A+J7v58yCua2e5D25coJRxlHyKTFvSnAY7o0A6qZZcP3XbI3RS/+/h+jGDhCPGcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhVW1w/uJGpi35S0gJPo3ndGluyyAvvsJswmyfeJjRM=;
 b=tGb0Ib4Pm4WMIpuPjdY0xjIV9iYBWd4mMZIVq19SWO+XM9uGkzPxK7NglkKSms73ivIyClZZhmOyKNQWeGxX11R87W4j3q3eOZWx4pG56yEXO7E0LRYAAfEwhkOTqcarbeFAJlC+AzDp7/57BYpdk9Z9OeGa7eAoJj/ar7/WstfNq9YYnV2E5JvI0if8e74sSIY7bvYHEQsYUX3soWqcHe+BMB+k5lqkanAQHYi4ywLaqBnx6IWkUBGd+8ZJU2Ms3NrvvTaGPmTMvtmoSR/aATJ+YDl6Ij7jbVcOoGRetHfBBxW/y0ZSgi6SxEDyCicXATVeOFTZI2cLGCPwwXV6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhVW1w/uJGpi35S0gJPo3ndGluyyAvvsJswmyfeJjRM=;
 b=J1lAfLJZEaac9dnbxKBMZG5JzmhK4qlonN2RlqBPbd2CZp9l7ixT+9CnU04hSX+NmH5xic2X7JSmkaOHYVIccEgZfWscjYVZlv0fs4qAUTGSpZXg0XjnbhaUKBKxSJzzAPG9tshmo3CGoLshBQ+9kC3G2voDGKZ04QsX5qXCAuWlOCtOIZryP92eEoCBSeaOFWZdorsbBvkFbrbEpCzCwKhWQ1I6BGgNwo4CdDUoJ3xjiDmIhAI2prNt95EuPaIfv4uRtazqm6ou+ig89+CMByVlG3ZluS3dmZ/IfP/cZLPhiW1UUznbuJ+CMX48icZu8KIXdPzZay9NkZ0qXzxHvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10798.eurprd04.prod.outlook.com (2603:10a6:150:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Wed, 11 Sep
 2024 15:21:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 15:21:51 +0000
Date: Wed, 11 Sep 2024 11:21:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Qianqiang Liu <qianqiang.liu@163.com>, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Fix a "Null pointer dereference" issue
Message-ID: <ZuG1h664NeJ/X0ZS@lizhi-Precision-Tower-5810>
References: <20240911125055.58555-1-qianqiang.liu@163.com>
 <20240911141658.GA632894@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911141658.GA632894@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10798:EE_
X-MS-Office365-Filtering-Correlation-Id: fc28d30e-6211-4364-400d-08dcd27575e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5J4hxfgERgTLgoRYz8tPKqonSogfZ1lgQJ1gue2n2FYcsum+HbsYMenXdAKy?=
 =?us-ascii?Q?V2M351azkiaK41no9Q5AmmoVkopZO+3Ub9WyrtILExcMiXXRr8qjqIrbvdxd?=
 =?us-ascii?Q?RQGZAahaevHmggHYuBCE8wo3jGT8S5TZQTB7YaXaokIazfyH1Q4UJdvXm9Vv?=
 =?us-ascii?Q?KPTbvCiFY98SGX8qUdc1lQQ+ShqV1uQS+LHYsfM+jaZnEvXVMVUWa74H508a?=
 =?us-ascii?Q?YHQMFtNrVYiQpmywv+5n+NiXr4A+nwomn3P3Cg1Z0EaPTGqDavQ1cPNdmc4m?=
 =?us-ascii?Q?9PRUMQ3ueXu4UmJXmKiKMAunnocA7H/kmSilqkdf49L6PYfDy9ou6jkP+mTc?=
 =?us-ascii?Q?fcrARzG0+7cAdNGscPuBPkzbbjGladR9No569oL6Viq+GYDzz1VN1B471L+g?=
 =?us-ascii?Q?yJH0RxGTxrCDmjFHu2II7Z0+U9Qh+hgiAxA0f7vW23vuo6hM3I2LXMjWI3Qg?=
 =?us-ascii?Q?s7q8SKNMc1MQJvyB3bybZZTXQ/x/K75A742tspnthDdOargFGh2Kww8j7JYk?=
 =?us-ascii?Q?S4S7yxOtER84f/eZgi/GYie5lnjk7s5UIyD8c59rbYFkRAPfCR1NQVoMp2Qw?=
 =?us-ascii?Q?RHgyaiEEauNHxN1yOCKNekn5gFQKdMT2SrgUeAAU0SRy0USLTtGi9DumGB5I?=
 =?us-ascii?Q?ncMRRfYnAyUbeO2828V8oePeXzAiJjqs4VbS55eRot4w8noCR8aW/skvJiiz?=
 =?us-ascii?Q?DYiiidvOmZZ2dJ2AHSdfRh7XZZ8bGoyqKLu4r2ACbZWy+qGej3FxM0bQC2Am?=
 =?us-ascii?Q?wOe9uPgo4Y0NTZJpSXsVf1mTOoPZvGLMNzmV5QARX5kHyQEyPZ3vWLogekym?=
 =?us-ascii?Q?nbzLjehgcCGXn1f6wjC9jB7AZg++B4OctuwpFwk/2X42XlMR9s3xujyTycEy?=
 =?us-ascii?Q?FNY/bgjtWy6OwN45nKgrH44gv2OSt8358zqb2rkkBqvp/TWM/2w/1DJPh6HA?=
 =?us-ascii?Q?RfRWcH766SBuG27i1RA3iQkmtn1jaEGU3cir0DUN0prUB0Uvzk7fbZHPY/sr?=
 =?us-ascii?Q?vwPqKcSsMwz+VSIUjsq62eMiW6WsjD4XmGHHZ7lgufaXt/EDBamMd8MWAsXN?=
 =?us-ascii?Q?wVCeXUoCZuMX+fvmBjRogRQxWzrmRjyoHZlZOApBZDUHXxCvMKLl/CVezyZI?=
 =?us-ascii?Q?YXyvcQnt9kYIGfpVBbyI5rhYqRhaO2DwVfkk3HgRigmTAWH5wF5macBJR2FP?=
 =?us-ascii?Q?SObC4zTWMBuTwsPjNbO9AlpRg2IdbHFwJ5q/i/cwZhv8bjmXF54o4OCemW1C?=
 =?us-ascii?Q?j4PhP2XmewYUjV/PBr3Dmc4Hv3xhltYdSyPSEc15M8zH5Z7ptTF91fQKWnJy?=
 =?us-ascii?Q?3MoEZFAX5sXPNBL7P7OZYGGZWVVTdN+hlmCBLVNB+YrEg8u7wxlyvXxYvy0c?=
 =?us-ascii?Q?pZ0ZUc//2MVDa5cW5InufXUQFynM+oTdc6r1HXSq7gjTmqrZvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVhMCH6SdQ4qQy/46rmHkHWxdSWRvAkloDAvEj+vqbMysoE0ZrLVeh1ndQFL?=
 =?us-ascii?Q?Ftyke/UByYVMpPhkh3Y5foG7ODXqjYwgExP9uXoMk91V5OfOJui/lhaLVwsw?=
 =?us-ascii?Q?6Me1NptgYtftyJGE9z80s/QVAnmpeXvKgqZlgrHShcaNuABWOj+3/hQRkQyp?=
 =?us-ascii?Q?fDvD77/ekGnH9Rp2IpzVIkeqjUblWEsg1bAQ0An40pRVAxRqCFEAXI+wqDzT?=
 =?us-ascii?Q?wKxqHnk5CAtmxgdGB9SkAk9lOUm89+bl06d+jcgc5e137H/JXkV5oc/NtMij?=
 =?us-ascii?Q?WhvV6yIZEEZyXJuVYh8uikO2TkjhCTKLlikMfhtQRSoGnVGxmZhbYLi90IBc?=
 =?us-ascii?Q?e3K3v2tGCvtb92bGOnqcoo1ZmhLsvkC0CtuRg5E9VZ2ziXYJt4dtv08BMbqs?=
 =?us-ascii?Q?0IhSogszj6PiPPrVee87uZrkXctci3SUBwZbLu5WgoEcJj4Y7z5KF4JIF1rT?=
 =?us-ascii?Q?CAjWbRDeRR8BU553VG7gDq7l72vRJKqxe8Wu2UZCeqbbjHikdj6o95saHnit?=
 =?us-ascii?Q?mbmuIYlu3f4fKzITZgA59Umqy+X+QsrmIDPWiXduLvadWrjpur4hpGcagDGb?=
 =?us-ascii?Q?u6vIYgNP1CpTaIwOiNsHsP0vqpDCyYRaY0N1NQHyH8+Mv3icEAZQbc3c7125?=
 =?us-ascii?Q?Z8wgeX4i202C3vGlDBgmML+iZ8Y4zFvUtUdXCo1nrXteTk+VBTnE1IxOE9wk?=
 =?us-ascii?Q?m2yPOaHWNCIxVviUFy+aacHulEwrxT6aat0fmBhSIfDWxmG4p5xTaSzA2qkR?=
 =?us-ascii?Q?tfTvodLzEzLWP0g0Z9qCvMmju+41hKUTjkblvkX32HLDSyUe8MJO2c3T5fK5?=
 =?us-ascii?Q?im3rdun2jaY9RMRfrTHcplZ9hpEBUn95KUN3p0b3mJd9rJ0HuGw671HGZSXT?=
 =?us-ascii?Q?IAnvX3be18QCPSdcqNIW2fh9HvmNitEwO6skO29VxQbONt+tjOuHboWDXiNf?=
 =?us-ascii?Q?7rEeY+ISsV2BezuMSHOmeTlE/oWHK15eyXzfiY3LVURQoyPwXSFzfCIZNJC/?=
 =?us-ascii?Q?Na5bOfkBnIb8i0wlwk7KJZ+UjPvVYqW/GOD7vhpb1v2nCoDVnvsEHg7yMpyX?=
 =?us-ascii?Q?bpBEdnuWG7ga36qNdwrN8s4Gg/M0STV0318JjPK1TjDqmGzU/fud+gjt/veZ?=
 =?us-ascii?Q?kFxhNBIzgMn0ymlyaypHkF9YQaf9A3B4jCgo4JUS7XiBGz59vqbiG7lMsAQ3?=
 =?us-ascii?Q?AhHbG8qwL02F0CbF765hdU51zbPEJsrrx31Fom9TGFj5oBXKiq8PJ9crDy7A?=
 =?us-ascii?Q?zQPFHh1fHVf5FyMa8CgmfUnl5ZV0BNVCvyl4K/MO38UCJspvYThMQkfYygjX?=
 =?us-ascii?Q?LD838IL4h7px2Khj5orZgBHlRM176+soGQiz/34ZPp+O46IZKJ7WEUOrU+Rk?=
 =?us-ascii?Q?mG43T//mOqmoEpM3vSf6Ma7YzWdWUcs5HjD0Ql0CWQ6MwTPgZ9pBqQE4euEy?=
 =?us-ascii?Q?omuI/pyhhTAI7Ud+v7qvpaOtKLxeN6nygkgZj1LFRzOMm1xGC0QN+nI1BZU8?=
 =?us-ascii?Q?l560MZV/dFfnrpECfBh4OY60qo2TvdcbnDYrDwhXqPQol5hLxF4oMHepPtas?=
 =?us-ascii?Q?I4SgaWSqclHLkk1JpLSMdquQ9WGD3AqeYuSwdXH1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28d30e-6211-4364-400d-08dcd27575e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:21:51.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWvf4HPnwJwgBjjEfvhb7IlkobKHtOgkhDymyQUTQC9Z0wjB/yluK92mNUgKSEF8QhU1lI+V6H9t5J/GG04kfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10798

On Wed, Sep 11, 2024 at 09:16:58AM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 11, 2024 at 08:50:57PM +0800, Qianqiang Liu wrote:
> > The "resource_list_first_type" function may return NULL, which
> > will make "entry->offset" dereferences a NULL pointer.
> >
> > Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 0dbc333adcff..04e90ba4e7d6 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1017,13 +1017,14 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> >  	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> >  	struct dw_pcie_rp *pp = &pcie->pp;
> >  	struct resource_entry *entry;
> > -	unsigned int offset;
> > +	unsigned int offset = 0;
> >
> >  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> >  		return cpu_addr;
> >
> >  	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > -	offset = entry->offset;
> > +	if (entry)
> > +		offset = entry->offset;
> >
> >  	return (cpu_addr - offset);
> >  }
>
> I made the edit I proposed here:
> https://lore.kernel.org/r/20240911140721.GA630378@bhelgaas
>
> Please double-check it at:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=c2699778e6be

It is good.
Frank



Return-Path: <linux-pci+bounces-42085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB148C86FA0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 21:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F29134D3FA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686A325482;
	Tue, 25 Nov 2025 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LDO+XHuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E61A5B84;
	Tue, 25 Nov 2025 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101824; cv=fail; b=bJ1FcR2R3D620pnCm1DppPPiunuktRIDeZYnJr7t0DyORq4A3+SR2WYD1hYTLNzog9wUU5zNbXBuF4ItYXcOkA1n4zmdO26O8nbo7zvMhs487L4CzoDLSyfW5RoLbfXlm0DQ0VpiI8dfHCbwEKNDLIEkbqhJkV2zxJgU46C6bNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101824; c=relaxed/simple;
	bh=jwqie6kjGqb58MNg1qBelIGuKGD0QyxBFSs3lX/czMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=POBLpNCZcqDwSLud2adt6NGQXDjXQC1Vsos/KIASVQt4/FIWKpf26co+ZcmMC7olnAJp4Q5Ek4dxug8uDpAft6iakUtV07XeZ2rp5saisCCPzaIZqDZB/KLrM7017NjyiZeD/ZQQWABdLSraq4pM0yNiRJQOJCWB0JknHOsKAP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LDO+XHuE; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cz7os6CN5186gE51YEhNqD3I7sRBhW9lotzhLkhKReAsAABAfMNp15MXKIHNV++rdap4qeXd8QzvMbH3sWx3q2Ab4Vdtwj8qEGefopvthZfYVdLtATMLe+wZiYSoA7e8cpzAr7X0tRgRouvOf/EDAN3KMR9DQxg/whyG9icOG9insxeu37Szu74bDJv45d03NFptGAny3VByVQVgW5D/uJplrWtOveamC+ukx4nutAxQVSLvPQx/3aVZh5QgLkVyqVhmD22383u0sXqoWnnQ8dsFTNnPAmpHwYnTmIdKy6Zdy8gl7kdXJzTzNsK49UYgHr82OHBSSPBsdQHEzy3buA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If0Y8eO0hPXlrsE/336t012YVEgXJWKDaeug2Ft5YEM=;
 b=XCP0V/sVfdrdeIKOUs4F9WBj2XUpl1ZWR0FjHsiRM3eLWOinCZ2mfO3UEb2j1BuTIM8FieSqV2JZJTRwr97BocwDolxltqjkDrQ08eT470QAxs4p4u1wDEJLP6y/cL05YR5RLqI3OjUSEsJ8oOPokHLx9e2aivnQlWP6hl1b+51F+jU0xDJxp4vj323SE+Ktz10BzJAq/DjdocJzF5o1PZqLaVzR/Zg+xlhT+S0kNFwbPpT0DPCCHCp2617YugYdrpPgr7R1LSa7sQQVmheDnuHlQtR2cck7lbMWTaJT1+5q9PNskWeXBNubbB0BxJ7e3RJoP2Eyc/Guk1GXDt7Rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If0Y8eO0hPXlrsE/336t012YVEgXJWKDaeug2Ft5YEM=;
 b=LDO+XHuEOSOddgniVuLvu2aS0uyIItCweULeKEStTQygjqNsjxTEzFBBAYEQIZCqsZkwQdYHrOH1IlM+XFRwMOoVoIy4KUZsGjnKblamhxQB4+CIptCMlzeRW0S7upIXyHzN4zwgB0byPqsLbArgJbCdgAHrKo5/tAmKnVob1lR7uEbGJ+l4MGPlA0UjKzoeKPULLSM9PaN35PZYkBkP9WcTEoSVBQ5KpNEZyXDZMN4U9LnfL73hLli+ix+NrZpfL/gQvLfsqTLShUoTkTyAQK2xLk6Jhew23JSAR9g4O0zo2fJTG30HQgxlacmhttSB7ON8BtTShTGRtEO0meB/mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA2PR04MB10124.eurprd04.prod.outlook.com (2603:10a6:102:407::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 20:16:58 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 20:16:58 +0000
Date: Tue, 25 Nov 2025 15:16:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 4/4 v6] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe
 driver
Message-ID: <aSYOsL82DApW+v+I@lizhi-Precision-Tower-5810>
References: <20251121164920.2008569-5-vincent.guittot@linaro.org>
 <20251125192119.GA2760316@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125192119.GA2760316@bhelgaas>
X-ClientProxiedBy: BY5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::37) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA2PR04MB10124:EE_
X-MS-Office365-Filtering-Correlation-Id: 033f181e-b5d8-4ba0-7f53-08de2c5f95e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ahjLOThYAGm+ow3cXORf4t14HVKP7Uqy9IurS53RkMqJnajT9aBwUo/H/xk+?=
 =?us-ascii?Q?bJjgeTz3hkeGLUVUG4GVw6KUSrUHQMChIcZwz5b1Z35jjR2ZaTap+6CGT2uW?=
 =?us-ascii?Q?LGntRlA6Q8Z170T/A8CZYR+5g9VpgZ5cNkzsUhBMwp5iuR6rZQXc1fvT6Wgy?=
 =?us-ascii?Q?EjdRWV46eEe1m/g8CFnZQGcllzOqzdp1sLsWq3tUVhyD5Rb48LS6DpdGDbLn?=
 =?us-ascii?Q?BtCYvd/vUts6R9STuk6rPuKUJlOJw4XCsOjr82NQIK5ZGVloY0vHaRHEVwai?=
 =?us-ascii?Q?EuZeFAwUejUfrvaq709uHfaKrrN/lrcFmCOHtfyUJhSBqlJBIOjREPTRVsoI?=
 =?us-ascii?Q?lRbWyiLDeZyXykMnsOLAyUTF1RPzLYSoxA3iG8WvF1txOlD6ntI3tqVQ8SSm?=
 =?us-ascii?Q?Xm+ndrYE5WK1YM3igibBoRmLlrDazuElTIKuBA1u1D1lHgX4P0rmSDh2qY/D?=
 =?us-ascii?Q?T7MEvq84Uga96DoRO5H2WPdxI838LAKRFRlt1cEoOa7orZeNWgUk8zCvVYv8?=
 =?us-ascii?Q?rPXKdVHA+jV1bWQAr2H884kER86M8Pjt8DbxxZiOnqXCBNuvT4umvqs6IZKK?=
 =?us-ascii?Q?C3HMdJCNFEfI5CUMptTFyi6ydHYTn4IunJkQ2Bbf5vDzMLTI1Vs+Isjt9qEM?=
 =?us-ascii?Q?feQVfNWOd5ht+8ARTA+EC6w6PSfbYaA2FS7qyjAp2+xOqEfO1rYMC9fcyuOC?=
 =?us-ascii?Q?ShunCgcH07knGGoa6xufnOCNPxOigv1rnaj2OvrUSIhOybEa4H+KdWT02rOT?=
 =?us-ascii?Q?l0Bu8Bj0BdwEcFL4Dfp/ORqpsn/zWSa1k5waaSTFJz/u/RhhWquAOPlEFCpp?=
 =?us-ascii?Q?NFL26Rl7f1baRXf98NPRtrjxHoh54jMbYUJSyNznTMLzvhk7C7JfhuIDWswj?=
 =?us-ascii?Q?4MMhhROlP2Vgk1MqR/lDYR8+Zb5lAF1JCviCIYA8RB5r1XtZP7rkbgN/yx7w?=
 =?us-ascii?Q?wno091FZIIJxHfR24ftQd7ss9y1eK+r+ziGUF4XYbm8+ZXJQwLNpJfK429vj?=
 =?us-ascii?Q?f5d9O8s0G74TzzA4y7YfpB8o8wXgs0qMDAIAopWzd+Anl7T/yYfIhiuH8K2v?=
 =?us-ascii?Q?25RszJ6vU629tD8BcBxCmpglYf4QJDI4QM/qPauvBf0l3E9BvG/jpDmNCcj6?=
 =?us-ascii?Q?GHRUepDYG20nSEdzKepFcbZ5L30+rp+WVpEzs5RC2/lOTSGAyKuNWBHohQzA?=
 =?us-ascii?Q?e1M3yRwSHzvnHF+In00r158mcYFEoMnuN56TdzKIOlR9rFLd12PJOJ51l2c0?=
 =?us-ascii?Q?ouaZ55rHtDvhGEtxj0s1lh71Qkw/ZJeU/X4EaSfmY9Xg/oVgSMsoxCJqvpd5?=
 =?us-ascii?Q?uwMFgUGaGtY/jYamRoGutWQyVHjAah6H80xwcwscd1ZfUQpu0BSAdRp5gwaG?=
 =?us-ascii?Q?3/IzcV271GcbkqLUMMSfpaqAZmjZhEPpm/PXd4k/rMcFKnZoHXH5ElnhgJFy?=
 =?us-ascii?Q?2aeDfRcE+wsP4pBaH6Ms80kc/Fyf4wiBWbGFS/P8V2PZXET6UnG/TOFMpOoZ?=
 =?us-ascii?Q?/XQeygughn2/1diw9GLsQjnoTUbWB1rXJhL5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1bJkO2wSTU2pHeiwOVfYanzlwtb1rlkwLwfjasDYWbae/0W5ZsOpMFNHXei?=
 =?us-ascii?Q?NNecIXWpmprCzs7+aN1B2i6zQhsC8a4eB/wvd+HcBx8ufaEPAHSXebkAVnkS?=
 =?us-ascii?Q?D6CjMqC4PCQ6yKEliA1ALU1+NrmOe7GwxwIv6zfmZOhYW2RVOqK53NQvJrpt?=
 =?us-ascii?Q?eDI/W0aNJC5O8TvHfoXBCDSD61KyVesHBkTfhNC0bsnXlutPt2RRaoHW4U+8?=
 =?us-ascii?Q?bdZYnzkC1U6zGXu+BApwOL6i3sWbZWQkLxX+3AwjY+13O5lK6XLUkaQxgn7E?=
 =?us-ascii?Q?YTe+4BOXPbbtw6IK//OIhsutXGuyzxGxeGebOk33wY4zCHNDaxS2jAPpPcNh?=
 =?us-ascii?Q?tOgOmLIUn8+Jr/yQj8smSz2DDb03xnMkwOPcxHg2hh5pu77DGfAbIhKYjcnu?=
 =?us-ascii?Q?TE+UYUs+z4HmfKoo6BbTUbp6Z7Jqpy+Ze6eYJsw8wrvdAl29TkNP5kSe4CfI?=
 =?us-ascii?Q?6q7jkOmrTOgIcXYQ5P1CTFUlhRWjEVVjUaDX8GaeR9rHt4/np/JUNx/KT6dX?=
 =?us-ascii?Q?3HBi3CEJkIfGdTohpXw+nYxvFNxG/IgrCbiSOFPojagZmtx7aydr2IIGvgq3?=
 =?us-ascii?Q?Prz96Y73JmGHze+b35tYOX41Pw1t8imQ9ndMLWSxNOPjKdD7DVe4J9Pjiqen?=
 =?us-ascii?Q?8sAZjAdLVXe40esyNdwDjIRP7gR+R5lLrYR98RT5JIxd7Ipzp4rWYqllG+EK?=
 =?us-ascii?Q?GBi5BdGH3RPg5ckdYZy9HYSxltPGLdO6LXKyIzimiD/uiAzedH1KFYzKPWpW?=
 =?us-ascii?Q?oOvF7G9tpeGK//tpmmqPcRCyOIGpufy/OmUL76Nz262WqvnE4LUQnCdksD6L?=
 =?us-ascii?Q?yVKmYinA0GSs9s4xgQ+ZObHQR8WBcCWcBNkamqyAPlbhvI8eMDsGfk2Ru6W8?=
 =?us-ascii?Q?cRMxnGGC94+gHRA03tvuEBCU7yKNlhbJpSS03lbi+YV+Cy/aEI3isP2ff60W?=
 =?us-ascii?Q?ZpskOUZ4DyJrro8gHSP4e4oQlRtyTMmp5VIMzohhJImcosMHz+4wFNGOIc5+?=
 =?us-ascii?Q?tY7vrKThx8lI8u663UakWo8XxF+LmG1+u20B6Fu8kSHhzbrkRwlF1uK/0IIe?=
 =?us-ascii?Q?vnPhtFQQTZJjh4wm0xFpRL22+Sn3rSyqObtBpeGIeawyJe8u4S1ksKKXDaUx?=
 =?us-ascii?Q?kOcpkEfRjCMYgjJU76O2oXvO46RSoS09bNA8+fMotWMt978e60eqToWZDRHA?=
 =?us-ascii?Q?hejjZ1Lf6vOpiAICYeTgLQed8UIZqQXbBlmgr5EwJqvVJ6mc1hu/lUmwn7CX?=
 =?us-ascii?Q?DynTsYRepI+czYgk+SNSzKLqyHR8s+U2nh0MQEQW0+lwyU8ZylGsdN/NGJwa?=
 =?us-ascii?Q?uBWpNQUEvi/FDd/oEdTybAEIALetrSZJo3dWb/peE04Ejx0tpDpUJ+J7ThSB?=
 =?us-ascii?Q?7GK0gvV36M6gR6w9irCYopUZcPn3mC7Kb17f1MrjOWlEw0C6iJEFDmt5nPa1?=
 =?us-ascii?Q?hO0Zax1kjifSh5M1mDdw1Zargv6woJY16489h/lb4jWPKMXbahAEFyX9rCZT?=
 =?us-ascii?Q?0OpZAhpGVmenPSINYBLmYwa1QJmtr0o9Ql5vivIJNF+iZU5OKrNNlTW6uzs0?=
 =?us-ascii?Q?3E50xO/gSQd78XEpbzc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033f181e-b5d8-4ba0-7f53-08de2c5f95e6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:16:58.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIPVZQYpiYmkyplk1syFrY32ACH+mEL8ozEcYbpH5Ph8jyGhPvJn/9iXXckehWVvH56M6vAUkmuaI4ohU7sipg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10124

On Tue, Nov 25, 2025 at 01:21:19PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 21, 2025 at 05:49:20PM +0100, Vincent Guittot wrote:
> > Add a new entry for S32G PCIe driver.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e64b94e6b5a9..bec5d5792a5f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
> >  F:	drivers/pinctrl/nxp/
> >  F:	drivers/rtc/rtc-s32g.c
> >
> > +ARM/NXP S32G PCIE CONTROLLER DRIVER
> > +M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>
> Would be good to have Ghennadi's ack here.  Don't want to sign people
> up for work they're not expecting.

If need one from NXP and Ghennadi Procopciuc have not response, you can put
my name here.

Frank

>
> > +R:	NXP S32 Linux Team <s32@nxp.com>
> > +L:	imx@lists.linux.dev
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> > +F:	drivers/pci/controller/dwc/pcie-nxp-s32g*
> > +
> >  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
> >  M:	Jan Petrous <jan.petrous@oss.nxp.com>
> >  R:	s32@nxp.com
> > --
> > 2.43.0
> >


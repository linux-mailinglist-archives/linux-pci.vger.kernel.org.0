Return-Path: <linux-pci+bounces-28229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA63ABFB39
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0CF188D3FE
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05422A80C;
	Wed, 21 May 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FFv06QnN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86439221719;
	Wed, 21 May 2025 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844937; cv=fail; b=X4j7AUY2U95Z8ROfkauzmgIkaG94PC+iq09kSydhm7Ewbhor5T/+6JJn3geJ22K/wm+PcSTs3SM/YuMf4rx9oGhZnAsVD2gj5npdk+HYC6YJ0W/r+yy2mPQ7fl3WnaMWOkAi8hO2o0p2W0B2qxNogR320hkdT0C+z0KT/o43pMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844937; c=relaxed/simple;
	bh=3CmSwCjsIDxt4YuBWAfwkmlAFUwHbceowDhXggOtBA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BlrIcmVGM2ZKetrWnoyckvg3uuGW78CjVKk4e6D8wfXmmNOFutq6yJsUN00ZE4a4p40eyD9eE3Cpj1rVPHbZ4hlk8nqMN2hQPRtK4cmloi5c1XFgb60UdAfPvsLs3VKXeLsgoodVOYF2j3sFunWaM1PpKYeK2Fp4YwZ/ymZDix8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FFv06QnN; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1e5+44nbAC4eXnucJvrdISVa6NFKn/sjOGD+w8+WYsWNSLzkVLiFe8bMh1+q7GqlY8Oe+vTrPXtzmliVMfCvt/FD/MK4HPl2l8/SJzyCiyDuQ6hlAtGOe/1+4MqEQSvYo5bfGQ93/ejEC4x1ihWrvj0I4cgpfdTlxYlM68ogKl5i+63hxYvL0ma6R29MR26089U6CzuuRyWgBkSOTkLZp0hkG4R0lI8KdXwXf0Kl3Ee/2RQBJLAoemcU/zux3Z9455vqpMFT53Y265OCG73SHW5ju3wa+jwRunP05N8GJrmpga0CtgTNJEzg/KPG9kp+ViPFwwTWUluuJDBtq5BCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3a4qWRPRuKFFG+v8h738mmLBSqZkmsRZFXQ3jF74To=;
 b=tgaVLK+PrRJa2eUrzhkXTiVmyAlQ/5rOV7MXeo9KJh8PX1zhosNAUBIfh+6qHTF2qihali9jNk9HRqPL0iO3w+rn24mFtcofm6HcOy1A43NI5zPkSKyvpupR36puKtyRlCTsGrYDT3U7lV3B+76zScfUY0JTkIKyxjC39NlUB7a5uqbzkb/EAHw/ys5ZRi7N0fwGLjCf/e+16BnJGuS7Y6qk4mCXSZo+nY71cnCvtYVMdwd0KocnL363j3FJ4JjrzYvUvoRELFWUb6b7T5vM+p1eFJ3oyFJXw7ZbQzZgXE1YaeypkNCBuoD86VcEfJGhuzEnsPMHF2UQ9ZUiNBubmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3a4qWRPRuKFFG+v8h738mmLBSqZkmsRZFXQ3jF74To=;
 b=FFv06QnNt0ksGQ6v4kzQMiNqbJEgovZfnLAzP/l1/WWzg7LQlRjZhjWt+WmowTFTHxCAF41DnwLmzPZhzh4BaV6Uck25qEsMA9Vk1WhwdvugozWdcDH5r9SI3MtN+H9lqgcZHUc/HvUaZ+Z7/4bQ7EFed6EH/iF8rCZOPoWYhEuN9/dWU7yGXqZZCQno49ax4HdnyqlUca1qzDBV3DAYkFw7rLvuOfcR8bRXthLgJp/uXO2UWOnisU5nOXYsSicp5QED2NsAwMB9Rb455GoZ9DvUjY9+6wYrgvg7e4GOj1XajmaSWi88/O/OrH6KMAmi7vnoTplM8j9C031+ptN8Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7446.eurprd04.prod.outlook.com (2603:10a6:10:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 16:28:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 16:28:51 +0000
Date: Wed, 21 May 2025 12:28:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: endpoint: pci-epf-vntb: align mw naming with
 config names
Message-ID: <aC3/PL3jdGMVHX3n@lizhi-Precision-Tower-5810>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
 <20250505-pci-vntb-bar-mapping-v1-2-0e0d12b2fa71@baylibre.com>
 <aCugvDoKTflV9+P0@lizhi-Precision-Tower-5810>
 <1jecwjn2pp.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jecwjn2pp.fsf@starbuckisacylon.baylibre.com>
X-ClientProxiedBy: PH8PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:510:23c::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: f86b13ae-a999-4912-8ae9-08dd98849269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RqmjWMr8Vbkz0p5TXE4WOUpKWq2UELBo08G1iHrviLDlGqf47xxB8mjBcBeE?=
 =?us-ascii?Q?VWLOFYLOGBynXRym4oPa+nWZR7aW9Bu4UNmW1x5+WqoDG9EVY5fndQss6PIW?=
 =?us-ascii?Q?JhV9BGpLTAe6JnBGQ4VOAxkNLbvxxMI+GXbReDQ5bvV01mCEe+1vMd/du/ET?=
 =?us-ascii?Q?B0i5uNEweplfXWE4KubdhvnwdEpNNasU/QyqmIbjnpmC3iWLbBW5rcp9ZWhP?=
 =?us-ascii?Q?s3KeWh2TsQ9krW6mqxMQKUfogecw7nBfifO1H7yTMuYxR9C0Wi5jhsOAE7IH?=
 =?us-ascii?Q?2k2a3mrKdq7eRl5j5EJZ+VDYNkvSESM63zGxyfQpB9rjzGiiEg06Q21uj6gX?=
 =?us-ascii?Q?DJ0cv3OUplmBMl2V6zQeAorrbRiLgqyTHel7vyfpJcHrgqjYS/8l9FXYC1i4?=
 =?us-ascii?Q?UvAl4uyOoPfF2hOQvBko561wJERlviZfIN8Msdj3d3yJi/cELYizO9vATdKp?=
 =?us-ascii?Q?wupUPdiaaIcXm0iIdk9eJkrg14/XnXqnPLVM+7TO0EHC+tRJBwKOnVDyyBIK?=
 =?us-ascii?Q?DOFGmcLW13GkeaYYn82yY4UQRToFcmhlNMc1rCQ1V/eT3M6k4kxDyRp709xT?=
 =?us-ascii?Q?iwiHSCUUVnfKo1qSc8lbal+Ga3HxUX505CtX57Vej+iizEAVR5uV6ZTcs78l?=
 =?us-ascii?Q?8GERO59vnZqiNgyT2B8ctdYxayKg0Aj3H63ucXhQxi8s8MFOf6QChlqhI/Ug?=
 =?us-ascii?Q?J1VMNnUMNVBHFl/uhY5urBFblw0kLEcF6nJSRor06bL4Bx1HOU1JhSnaH8c+?=
 =?us-ascii?Q?hCvXNVdwQyFrK9sjZ6JttXuCprdgFO1MEVQDhd5UmyMkTjzJKy8p8ra3Yk3T?=
 =?us-ascii?Q?MM9eujVdoT9LzcaIgqxMwnSJzeWC3U9TiheZoXAu1vcLu09KeNahiOde50nf?=
 =?us-ascii?Q?h4zjCTineOqj3Adi1I5pf0RhhxoiCp8+A+g8EDK1WY6wr4MuAJpYIgGkXADg?=
 =?us-ascii?Q?+XrJ82IUnaO+BYeb8Z6zexnyUPCZk+Uada4mD0q1DxGwvHBvgRqF18SoYPh4?=
 =?us-ascii?Q?u+B3RyuzeXxCxbmzFQ0fWcaz1U6V67OSgK4ztVSR4t5y1UyfVUjzWprgz5mJ?=
 =?us-ascii?Q?xwV2pCATTJ30YkRRhzcRbA7FIU0762CWZBOATg5YiI/KUXtmvj0uOUhC2DWH?=
 =?us-ascii?Q?ACOgN+VUZwjJlrdLBgolBsV6JdK+oiL+4gIbAD+26yGZf5t7dOZPU8hfmBzO?=
 =?us-ascii?Q?TyBrVtza5vT26gVlYCF6pPYM+moHd+Q9Lu5Rf81ViekY2MlFyEl4jwxkR8eR?=
 =?us-ascii?Q?iwK7luRRbkJRvAz6uaxIMDbdrtXRn0Bgk1nulgKV/sXEf2hUdNhCrh/f8j9n?=
 =?us-ascii?Q?fXM4GWTkn1604E2LyWGb4W34hzVfARzxmbz2d+VZJdS+330essNpVQGaYA+N?=
 =?us-ascii?Q?oFlGGRgjGU2I9oOUKZW8h30RdveOVRPtYfVzm/ZKL/BDXj7maUFDVTxgp0xI?=
 =?us-ascii?Q?0HEDfjvBUF4ya9qSp8G10a0NjB3KhJJqo1cI5v3Rs2oWMC6cXVgRQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PMKsVz4jMzHnzJM1a91eaoa2umBAxzYAEL6BJjOv3ZvevWxszWFdYS/Blayd?=
 =?us-ascii?Q?gJRTM3UoHfS7FDr2fn/AEahPbe1SkTTTkydQI6Pba5vnbp+wU+5TIw574t1o?=
 =?us-ascii?Q?i05vo2eH0V3GNuB6EIFEJxaXD7xhD20jphzIMz6h9P0BsAO79ZOsBlQl4/ip?=
 =?us-ascii?Q?KXqlICei3Gzdi1fl6vA+JJhDp4Z98zA3L19OhUQFs49Y1jiQ6AaUXkMUuYHM?=
 =?us-ascii?Q?LgyDPEWepJy18LYnz+Xyw/ayBeKvwGLvZx7khd8o7dj5hmnna75SL1TaaH3q?=
 =?us-ascii?Q?oycRW02hqbwo4B2UetkWzW+cz+55yIVXbaSqLme/qw5qRE+hlQpFMhs7Eko7?=
 =?us-ascii?Q?q6GCcQg00GR6lHA09+xaQZa8Sagkymzc3Sm/OSTLFae2p+IaYckJo7Bx6C9k?=
 =?us-ascii?Q?c3FUcX5tIjAxwKbG8bLkwSpFgRU5pt2rX3jaVLJALfryF4rvk6UO3sU4JJg8?=
 =?us-ascii?Q?bowsbN9/PnEzra638MbBrM9YyFLrsjeQPbb5hJtVsT1ZETAmhaLZo0XYzlxX?=
 =?us-ascii?Q?dd9GSsjzHvNGPOCjICIOyGbSg/xW4RnUFIyBBZUnVfIlQCX7Jq9P1VhOXEEw?=
 =?us-ascii?Q?7z5OY7f2EQmmo/OrbZKhphdpQKcm13zXyti6qQCyJH5rSdvv7NBOQiWUVGN/?=
 =?us-ascii?Q?xlkatvViUWicvdr4MOd2rR/JI8r2KyhFb1qP1ENKG7R/dutsB4Qw3cX8j+Yb?=
 =?us-ascii?Q?jhaxB9WMRt/dxcLJ68eBq40UGhqlUwFMpXi2Xcj+CdT/O5gV822ARARZsJCf?=
 =?us-ascii?Q?RE+wIJCmst0tG+XVyXwazg6noNQaAls2tfTncrFtvKjBWF0/6wzujuCg5w/G?=
 =?us-ascii?Q?s56xpSwD4Xio4O0l5brvNnAgz4S8RmIXrTWoPJCKsbACeku/UPJsRFkoOR4e?=
 =?us-ascii?Q?8UW+wdTsNJvThduXxmCjL35JEEKfzES0KFooAB+kJU6Il7a8mkP1wRPbKJ6J?=
 =?us-ascii?Q?KmPBaIPOKii54V9YEQIOY7GE3gQJumtCVUNemj1KiLc7sLuuBURDQj1PdLSC?=
 =?us-ascii?Q?DZ+/S6gDga30yXRab0X7spZJDOUMY5v3zeM83hEti3fn0Pa8767C4Bm97vg2?=
 =?us-ascii?Q?hrTduz+HjW08NCiL0RSOh5ud9DNSNuCh+QBTjXAP4ebHpxfTKRm5TeLldjlj?=
 =?us-ascii?Q?csGxFmmUVg07E1/7wDgWIEy6gg+wR/PHS+QzXn91WRW5PAaxMwsfL2j2jj+/?=
 =?us-ascii?Q?iolvkJlUQeke6aVB4X7lOMt1EhDNXwLJPMswzois3/l+a894o7bEr6kM7Can?=
 =?us-ascii?Q?ud4AHOClx08Z1ee9VEWj9s/fB64btCsLF3Hc99/iHyPQEbDPQM1BhgiyE9Sb?=
 =?us-ascii?Q?XrId0sX2DsBTFpYI1LlopLEVo5wf+WrowvciyYwmjcslxFgKVb5N3wC21qQY?=
 =?us-ascii?Q?y12uVv/Wzd/HEDCwRGsogNc8442KEG1GowhrWNFRd0C2QNFPv+a07qSkKrVg?=
 =?us-ascii?Q?IpYEh+LiavJ8tiE+T8qcnGJUyLR6FeNiD8lbyFz8tR+gDhza/6NLqCDGSz4w?=
 =?us-ascii?Q?ETxszZf6PyBsjxHZpKpW+3Sz2vLA1kxb5n7M/VeRQzm5TbMIFtl7Ie1PdIKr?=
 =?us-ascii?Q?XtQK303ZtxK+xZnO30o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86b13ae-a999-4912-8ae9-08dd98849269
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 16:28:51.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LEKT0QAvRJVtxEQM+5Ska84fMMPgFUmohdeFF1h1iAnXL6OLbhH2uS7DIGjEY0fhU/RHRoI1afaEF3Tz12k5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7446

On Tue, May 20, 2025 at 09:47:14AM +0200, Jerome Brunet wrote:
> On Mon 19 May 2025 at 17:21, Frank Li <Frank.li@nxp.com> wrote:
>
> > On Mon, May 05, 2025 at 07:41:48PM +0200, Jerome Brunet wrote:
> >
> > PCI tree require keep consistent at subject
> > git log --oneline drivers/pci/endpoint/functions/pci-epf-vntb.c
> >
> > require first char is UP case.
>
> Noted
>
> >
> > Align memory window naming with configfs names.
> >
> >> The config file related to the memory windows start the numbering of
> >
> >                                  memory windows (MW)
> >  then you can use MW later.
>
> Sure
>
> >
> >> the MW from 1. The other NTB function does the same, yet the enumeration
> >> defining the BARs of the vNTB function starts numbering the MW from 0.
> >>
> >> Both numbering are fine I suppose but mixing the two is a bit confusing.
> >> The configfs file being the interface with userspace, lets keep that stable
> >> and consistently start the numbering of the MW from 1.
> >>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
> >>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> index 35fa0a21fc91100a5539bff775e7ebc25e1fb9c1..f9f4a8bb65f364962dbf1e9011ab0e4479c61034 100644
> >> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> >> @@ -70,9 +70,10 @@ static struct workqueue_struct *kpcintb_workqueue;
> >>  enum epf_ntb_bar {
> >>  	BAR_CONFIG,
> >>  	BAR_DB,
> >> -	BAR_MW0,
> >>  	BAR_MW1,
> >>  	BAR_MW2,
> >> +	BAR_MW3,
> >> +	BAR_MW4,
> >
> > where use BAR_MW3 and BAR_MW4?
>
> This is aligned with the file available in configfs and what is possible
> in theory with the function, same as the NTB function and NTB host driver.
>
> Stopping at MW1 because it is only one used in the driver would be weird
> and the number later introduced would be wrong.

Yes, but BAR_MW3 and BAR_MW4 should be added only when both was used in code
actaully.

Frank
>
>
> >
> > Frank
> >>  };
> >>
> >>  /*
> >> @@ -576,7 +577,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >>
> >>  	for (i = 0; i < ntb->num_mws; i++) {
> >>  		size = ntb->mws_size[i];
> >> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
> >> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> >>
> >>  		ntb->epf->bar[barno].barno = barno;
> >>  		ntb->epf->bar[barno].size = size;
> >> @@ -629,7 +630,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
> >>  	int i;
> >>
> >>  	for (i = 0; i < num_mws; i++) {
> >> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
> >> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> >>  		pci_epc_clear_bar(ntb->epf->epc,
> >>  				  ntb->epf->func_no,
> >>  				  ntb->epf->vfunc_no,
> >> @@ -676,7 +677,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
> >>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
> >>
> >>  	/* These are required BARs which are mandatory for NTB functionality */
> >> -	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
> >> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
> >>  		barno = pci_epc_get_next_free_bar(epc_features, barno);
> >>  		if (barno < 0) {
> >>  			dev_err(dev, "Fail to get NTB function BAR\n");
> >> @@ -1048,7 +1049,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >>  	struct device *dev;
> >>
> >>  	dev = &ntb->ntb.dev;
> >> -	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
> >> +	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >>  	epf_bar = &ntb->epf->bar[barno];
> >>  	epf_bar->phys_addr = addr;
> >>  	epf_bar->barno = barno;
> >>
> >> --
> >> 2.47.2
> >>
>
> --
> Jerome


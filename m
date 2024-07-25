Return-Path: <linux-pci+bounces-10797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890293C772
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238151F234AC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CDB19D087;
	Thu, 25 Jul 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GHEXqKfO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86618786F;
	Thu, 25 Jul 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926486; cv=fail; b=VycYb7Q/78jaLjq0uNsUK7P05lHqutQa15s8XaHCnQ9SRT8gXldBwdulgkLvDyt5fb8Qok5/a6v6rV7t7zy3LFUqKw1bXRUENdL0YbLDF7nXSRbbVvN1Q7fuIqJsR5jRili0Tn0IT1RAMQzXN39f0JuXutTkdTHQcZjLIxl3XnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926486; c=relaxed/simple;
	bh=HgVs6oO+D5MFzwvx3PdZv0Lq+XopIcd/r5mWZxSuXQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdTLe//+hrFYUOAfqLb+5Bd0Cq+UZ5nRpVN+EqvISGGIrFGeWCLdzqwH0Y4NfyjOIAhYFAR1KGYb8xABat1vPuAkfCGl3yKlbdH2z6VI0Ozp8hoKVfb2TNOeazd49Viy7RuQQVlcjdXw2aE6Oa9AvH21Jbc+vvWN0UzB2RIV2nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GHEXqKfO; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySI+lWB7p9mEr7o3FebnyaP8Xgiub7sAvZ/OQ2cs2oKdmJ05JH6HCZkPdKCIywJ3xfJbzErQr9EAwaT3SDZGEUvVCFw/R/zdOHaCcK2NPWFg2vXZt5EgGUvZeZ7dhk9/hMIXC1EyegiD9D3umVwr9ybqnm5zHfbMwUqZcqBhOzqk1tGBP2KCX4lxfZSXKkwkY3kMrRVncGvOgOAPDYE5RLPq3ruvTzFTGAUEJ5uzC3LoIZDnCGymoJVlkSIBh6ZCN2jBNJViJzi/exrSid56fquvF8SvL7S/IxW8mNtdvAq1+KwZ2e2Jb+/D8d4qAs+XhhKaxqJRhNOGvFZkP30TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjzrjhAxOEodv/GKWJ4H9S1uCW/M2xWBOrxkYMpPMwY=;
 b=oxOxSiUWkclsO5kffzfYSWgOc0HQJZguwcG5rWK04+1JqfsE5IAAXGcOtlzGosfoodG8EF+mHW8t0Ga+9G1Mddxdx/OmuYCjJRXiYWB8Rzji9ky6Cm2c1zJRG7ZXkcFZ9P7su+mBOoTZbJBHUyUvgpQTROXWAMiirjOVzuGiUuh0kVo1JQD4GkZ40btm0IkbU4UP1BWOHEg4DeN5xuAWlQYG5mpmo97JBChNQzwSveayWRkUh/KkKSVXUbzEh5+kXkIVCQyolREjr9dx3Z2vKX18OTKEPiqVoOX0bRonJkj8xqy9F5wwEfR4kb5wkxfEWjwcGwVxTLzu/HlAkbssLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjzrjhAxOEodv/GKWJ4H9S1uCW/M2xWBOrxkYMpPMwY=;
 b=GHEXqKfOD8vNcxqxFwcOnwSqpdr4Vksm9lJpQItY2GmJ6cOTyKxUFhxPbbQlgVXbqRau8qr0EMRrZjZIV/MRA8A+W4JaVZ0VCSnwigyHnXg+FAtnjz/kwfzsD2txDRnlhasU16S5AKJaHB9y0uiShoEiH8H80FM/ZyhGMVuZSs4xDO5Bu+Qn5txX3e5RrjkBdTVlaJ8aD0cMj/Ro0RBX2thzM8WreDSGGNur4F5DUXUrl+Yy9+LFXtnSBtGbvUiA63TirwBfgOHbeWfP+liKP06q5rwYxzSHJt6JPccxZiO/zgQGTrNcDLfvdSGpGbkbjytfUbVRB3LYXvGaJhUNgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 16:54:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 16:54:41 +0000
Date: Thu, 25 Jul 2024 12:54:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v3 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Message-ID: <ZqKDR6ZuLFxb7Irl@lizhi-Precision-Tower-5810>
References: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:a03:100::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c2d41d-87ff-4bf7-7cba-08dcacca7a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ekxjmm9Ed0Q9Ijp3lT/tgcWJf21LAkYwxJ6MyVLEoC/kuRly43HZq5zu3NC8?=
 =?us-ascii?Q?QAKM026WwNxgAWQf1fuurUPKlnzq7a9qAaQC2+NptUVCSXnEYfl2dd2w6xGt?=
 =?us-ascii?Q?ZC/d/IVksIoO2E6gZrTpiu2c63JLkhIE9pJe9H2Qp71gdX3ishq0UnDf4jTL?=
 =?us-ascii?Q?eoHnzursAWOpgrGloHUwOJUwxEEsYXmjpqoG49U0OcvXxc8nqJKo72+9i3ee?=
 =?us-ascii?Q?xqdvn2QydjyDEo7cfnUjNZ4lnn9cSgr7yEOEMSIfLuMqEvS/prtxOapS31Dd?=
 =?us-ascii?Q?RWGiJIE5T/Yh09HATm0ja6Y/IcmbXctx84q3QDrey1ZONvk/OXe+aZT3t7xA?=
 =?us-ascii?Q?jsUleQA5IxX+GgbLdbB/rw5S+wXO/0Wte6+7E7Qq/EnrkMR4xuVfyOinupG0?=
 =?us-ascii?Q?4eRNC50k8wJVb2jKi5pEbCJMI0EHlo9+6J4f7bTBHkbDia6xrbOg7qf+zIp7?=
 =?us-ascii?Q?Gms2GYqOpmmp2jUvfa0ZJNObE8s3bENpq7FUylmHcHt2qPHvvdI/FGRcl5wi?=
 =?us-ascii?Q?3KbSfDhXr8/vJFIvw273N1UL8qVLPVstnPgY6bFXk+f2c47y0+v8MdQ2vSwm?=
 =?us-ascii?Q?yuW2FNqk/OV5l1U62SFfvXxoIkStrSURfjT2rC2tJqTwG/jlFk/ACtIcTx73?=
 =?us-ascii?Q?qGqfB5tFuESUQCmtaUVDEmVa5sUh3wVKa97uJa4q5MEMfjGnND+QyChRYv5u?=
 =?us-ascii?Q?M84MrkObgXo0rvT2YlWfKDQZc99pUZ0xD0Eg2E5Ptr4j14SnNj2fS2idUB95?=
 =?us-ascii?Q?T+EmgwKFw8XcKNlBW19GM6J/VqgKh9N4mZnfk8gr0OyP58z8yp7cfr49P/JF?=
 =?us-ascii?Q?Gks5qdO3j+R7v7yAzbzKERaEFHwoGvSBX/R5tS1wrfvtMd/i6R6FCpLYzDI6?=
 =?us-ascii?Q?HBVei8IcErYJ9uXCgoCeh/uAkVJ8T5QHvOSi4pCF9EsSVQxITq7VMuvLHLhj?=
 =?us-ascii?Q?b954wRwyj/MJe7OSXjj8nYpxaUBfyArLyKWEoMRkyAQGCBSUmHCABxAMr3eC?=
 =?us-ascii?Q?Yek0e+HDiR+iMn4c6VyQhrBllsuIlARGCNFsqyUnKEFEWUlFvkbzeD9fs2fo?=
 =?us-ascii?Q?neRu5oeWgcbSpTjEi7etkDJmrHLzhj4X82tDYIjeUfBNipioGCPTu+CsXYjQ?=
 =?us-ascii?Q?EBTGm+e8Xalb4BuAduBfk8K58WnWSbS/jagLFq1ktjgixMKpNcn4PRGz6Sul?=
 =?us-ascii?Q?AHyQtq+9hhhMVTH92QBefMR0oO1Bwlg2iRU2LKR7D2OuZUnZorKfHVQBOWWm?=
 =?us-ascii?Q?qFrsjTBlo1emEvgylS3QifB7aiqeYERDdJzgi++/chAKeZ0Ao5/HGlgpNPqP?=
 =?us-ascii?Q?fuGqsvxADNvbKUbXLgX8ek94y4b94Rwnf72uS344Z7XAFpTXf33LeUHkTSUT?=
 =?us-ascii?Q?KNkIhRceHiaSPOAFNxUJ4zCnobgEj2o+qDrpH4DbQhsIW6oPEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tp11tfN/4U4f2RTwXrz55ShJrSjfv6w032AjK9wSaQ0gd/fdTE7f9PFFb32E?=
 =?us-ascii?Q?nmqNJLOhDG4f0kYTFXo9fXMEjR2B5HZYGLCdQkVd2zsv/9nVf/0UqfQVrAzc?=
 =?us-ascii?Q?KrIYHH7QqQlNaKECt894myte07pt+rGILrch5a/3J3O+/TNRv5lnvPS0j7SV?=
 =?us-ascii?Q?8X/kKmEMcrh87vzeRLX8BLN0Ok8aA7mxDZGFt8UvP8QmSGT87+Il4LXXJ4UT?=
 =?us-ascii?Q?SrZIRtFjqdZWshE0yA8yxuFaHfGp7s5uSSMJPBr15Dvp+GVzqGI768OccBdw?=
 =?us-ascii?Q?d95/AVaBMKJ3w2vPHY5ejJ8Iq1qoOiTeyBGrxL4xRNc/gLPSg6A+0q+/wdtg?=
 =?us-ascii?Q?HzbmlFgSSVvQ0p5bbt70rGj87M8tKmN40aHCn5TmggvNF5UDKzbKUTe/0MS9?=
 =?us-ascii?Q?755LxC+EknEz/YnXCsW2l3NT4zNN9b7nY8jHKs+bGHzpkMuKARq+Eh81imIo?=
 =?us-ascii?Q?nti9Thyka4btait1e/qvi7S572Ytd0Or1jtf6ekHg6wKgXZKW2waCrw3I61o?=
 =?us-ascii?Q?oozaYnKW30qdCN0QIqzKTrxR5gL7m2snwACtkJSuNSOGfjlrdFLTGWRK6xAP?=
 =?us-ascii?Q?qmHLtzkUlD26Qi3D9DVDvoFweRcNdUYoCfMNeyszfrNMnnTXd8OVTgEsT9WV?=
 =?us-ascii?Q?Q7jJZaZVNJCMHp5g6CaoBbOG+9BbRmOvqLvDlMFzcQaNoVLPhfZ4VUP9eSep?=
 =?us-ascii?Q?3u+DuYv23ypQE3rGc+g3+THrF/Fpbz+WVx8w6BMXUKtYT8rJT9VnNyYtqdNh?=
 =?us-ascii?Q?dZLGOyPmvHKnqt9fcTYhnd2pCObuBPSkgxMomr1AUpggDPq3AdJdYpaE1hLT?=
 =?us-ascii?Q?3BCdfbX2qAe/MXz4ADNJvFhr/HJ9Phws9Iyb+Q0rEhyVlRS0djGRXrK8KSJ1?=
 =?us-ascii?Q?jbZGBzxdI6OhOyJ2FjL06Lzj86CUALt8p4OI3OQo7DMlcRgJ8yRSArJiyp0i?=
 =?us-ascii?Q?2TVSzd4nHJT6vlewisAJsx0ES0hgddHx9dKNCJIeIlRr+mM+I88/a0i5lWNO?=
 =?us-ascii?Q?URexsUrIlWrm11l3o01TCKHL08K6UOtGK/lcwrkEocOhZCDbDvwgSzsmd205?=
 =?us-ascii?Q?6P4vcHsJtMHoyrIE3fr7OR2BPlwRlaMgqYreAFwxmxqlB2l9iXnFNn2WtoUe?=
 =?us-ascii?Q?fu90bXn1b28xOXrNmEHOal/1jzrV6NkxmP3zX5/9PbKGzwvLuog6PEc9mBUO?=
 =?us-ascii?Q?UeVPyQsQdCW7a3eX42yWWvx5aj3j6gfsqL4QREVpKxLO2jZiTxUY2TlMZGqt?=
 =?us-ascii?Q?aNObCVDmIRGccH615RhQGgxdlwzr6jxndZFNyelBXSfzUikoi5sZ8IceAzQ/?=
 =?us-ascii?Q?VbQbP4viFgz07trRhhrApHdXeZRqY3nuabtqBBA/UDwISk259FGKLD1ip0pC?=
 =?us-ascii?Q?aEjedQrc0pC+nfb3+qctJ9zFPbn4dqgmwOae/0Z1+Nj/cFgm5Y5nK8aJjPkb?=
 =?us-ascii?Q?BOmFP4m54stjtiUbanlzQPwE2oOf7we7e5UxOVj1Z/5H/bMmdEfHeKK86nGE?=
 =?us-ascii?Q?mAAGqV4KpmDMEuhI9Lht3EOkXrBdQLbzYTYB9BxkPkh4GK2yeZ/ezf0DS7U5?=
 =?us-ascii?Q?E+3g3xy14eADOQlk/gc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c2d41d-87ff-4bf7-7cba-08dcacca7a20
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 16:54:41.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJasriVMKxi4UJG4ocKORf1mZqeOfohsbBLIa7AbGTOT0/TuYd3Ih6nB37XfzBp4F52Dk3K0ta/1xwlhTxq0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379

On Thu, Jul 25, 2024 at 03:35:12PM +0800, Richard Zhu wrote:
> v3 changes:
> - Refine the commit descriptions.
> 
> v2 changes:
> Thanks for Conor's comments.
> - Place the new added properties at the end.
> 
> Ideally, dbi2 and atu base addresses should be fetched from DT.
> Add dbi2 and atu base addresses for i.MX8M PCIe EP here.
> 
> [PATCH v3 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu"
> [PATCH v3 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for i.MX8MQ
> [PATCH v3 3/4] dts: arm64: imx8mp: Add dbi2 and atu reg for i.MX8MP
> [PATCH v3 4/4] dts: arm64: imx8mm: Add dbi2 and atu reg for i.MX8MM

for all patches:

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 13 +++++++++----
> arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  8 +++++---
> arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  7 +++++--
> arch/arm64/boot/dts/freescale/imx8mq.dtsi                    |  8 +++++---
> 4 files changed, 24 insertions(+), 12 deletions(-)


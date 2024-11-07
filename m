Return-Path: <linux-pci+bounces-16293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6179C11F1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 23:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690CE1C22420
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580621766E;
	Thu,  7 Nov 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AUDT83gX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2073.outbound.protection.outlook.com [40.107.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58D218929;
	Thu,  7 Nov 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019479; cv=fail; b=BMCbHANJE8QXDR2tM1hBJdHgLVbYlWTiXuU+ptU7uX4zhjWgmueP7NeyoeYB1p01n0zoxNxxEJweCh7V5S2e1GoZmZdTSyatuby0p1pdMMKoU97c8p7dFVJD5zXbYQ1RI8yD7UhghinSVo89KUrjVQjhetK5AEOtQAXj9CpQ2I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019479; c=relaxed/simple;
	bh=fumhcU8Fz/+D16bGVITRglLVuBNXhM8SofMlo/CTh6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DA0SHJRmVDcf4allJVIW/kvx8s/UWGS9IqpsRT0UtE0jOGvxyRGaFPcJAkLvFEHX6PGEPC/CMhK3hTsvZcyNjYHr6Q5YmpzYWTSjfp/6fUnetOSKPlMUeKSESnYh4v2vofdqsbEgSU1yAk5P3qUfur4FOVS59dhzbUsGp8OeI7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AUDT83gX; arc=fail smtp.client-ip=40.107.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKsCDh8wTJTooyrsP6EqeUpm4I1Xlom7CjsW270WbAc4D+VSyoMUU1cjX8yxtuS1R63xXUvcgvENU5AROLl+HoSsT+dbvnz54YZvXgZhCDJfwLyT60GkTmdfsvnQE+Kb8LvHf1NYyF7OsRgxUadDGigF3DyXRw+EXk1SaVZB+NzRSnhXErka1srS3040lwqOZV48Oa4kqXovwWNtA9yekqINrJ3BspD/EGP/vIj2v6jrJQIhoVry+rncPIUpngEnbW2Pdp+cPvels9AFDRr6fBNq1CwgdzuwsaEEM8++GENz/iXv37TYHPN9Q5wkB7HMsukvfWSjmTzGU7n2I82beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogQE+qqKOp89z1iQujXIVRcn2gzAEcF1r3bFmZ3WeZo=;
 b=oGUUUtEhR/Z+x+jBqK2Lf9Ejp5e+sjyAk6qjwpeo6RVUXX9B1TEkC4GRdHS8EypwA2M/g+oWkM+dF7uI7X0CKUzPIORSVf93cTAIQhcJHwqF8ZTgPahq9czf6Da8KSDNvSdgn2WSM/gy9CniXVPrhRSpOkxb1mo6oedNCdzJkHJZ+JOAalCs1w/fe4zKEDvozXOpMTfwu5/GBkz0KGsmVa9LnhrUGTeUyBAAcYjBKr/xHsO2qu9ETCRvzR45QoFuYGCEZl9ZS/qi1i7p6Jufu7eHcSNPeNcQxCBueAY4rx49maybdIOryre4P7nRqn/xUo1miXAtK9cRbgB1aDKnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogQE+qqKOp89z1iQujXIVRcn2gzAEcF1r3bFmZ3WeZo=;
 b=AUDT83gXbz59oeCPslPH13QiMw5XuYQ/HEusZtb0j3WMZowPaBOKvJAscBOiPcCSRGWccC6/CKNREFor/w9egrG0HxZ4anXnhkpXVXn8V0XUsgZdxXtSP/ohTrKVgz8TxC8IDoptbq1lkMeCUUCcLQdDjybhZQ6Kp5/5H2724hPTgusGa1/Y7y3Z6OMfH5exP+ia4qeQZ4i/TOFnR+/t0LZj2KDy6I3KrM3fb6FWnO2HD/sKqWpDD4tPIIn7n03XbrV8IHjFn+U0m8JI0FE16k/oDAOPT5zaSuyiuD3D7TDMbZ2FuQ6uISXyW87yqX6zYVQUgJ5nlA4/Ny+e3EGbyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 22:44:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 22:44:30 +0000
Date: Thu, 7 Nov 2024 17:44:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v4 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <Zy1CxtKSgRuEPX5A@lizhi-Precision-Tower-5810>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <20241031-ep-msi-v4-3-717da2d99b28@nxp.com>
 <Zy02mPTvaPAFFxGi@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy02mPTvaPAFFxGi@ryzen>
X-ClientProxiedBy: BYAPR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:a03:60::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b6c424-8e78-4d84-264e-08dcff7dbe07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/G7Ap8Glir5kW4FNEMhjXp2lZyg33oK8YLvstggsmZF/Wq2Oonjh3wI8msn?=
 =?us-ascii?Q?F0kNfVkM6JIbmL1CMcN/tUPn6JHjncuQZBRyoNaIMw5nAifVV9QfMp47VjDh?=
 =?us-ascii?Q?Om3XBh0sUrryUSkFYXnZ4GDVlh7CiTRi22jk5RDSq3RCRtNYHmZb0ChxDaoa?=
 =?us-ascii?Q?/fiU6Kw/cm0N1vqXIF5vHoAlcYBXGsBDKmbnjOQgB4Cl77jV3SdwlyqchUQL?=
 =?us-ascii?Q?xacAwtvzrZljABZfun/XgzVJTSx135+blix2Q9eySiZqdsmRAiJkpNsTXY8n?=
 =?us-ascii?Q?yH3tauUIjuyNjEx+53hKOULXHDPi+Oj2r437NNGYdi/Yt8N9AjH2Qm/YMoz1?=
 =?us-ascii?Q?pgAaA5iX7iZyAghEZqUh9difj+2GlaKnymqnRzRPub1NjOdobprVuCDmdRqZ?=
 =?us-ascii?Q?Cfj7324Fkl1lUB271PeliDTEh9ATwxudKrj7NTnbZBXx+tgdHqQ0cP9boRrB?=
 =?us-ascii?Q?mwiIJOF4euEFJ39zeh+Np2EK8sy2R/BfyL2OVQhhhQ11fPmzaK9y3dmbXAae?=
 =?us-ascii?Q?6dmfCxB/fnAxnWFVB0tT/WD0qzoUUYRMhtunBq8Bh3wexu939Lw+st0XzF/y?=
 =?us-ascii?Q?qOSNCKAnB7WWTBK0ui35aw2BFg5FSn1rMiTa+m5ENywp4eV3c9cMo/iZi8Jg?=
 =?us-ascii?Q?Ns/NP/4Zi60MP0+eP9QTD4gKV6ANkzd759q7Z7i97/XtXIu/+A6SBEaPKQOQ?=
 =?us-ascii?Q?wJcs1symVbI8WT53IaE/QGHTZET7oEJnr4+v31AnTK/hzAi4s3JtTiwr+GIy?=
 =?us-ascii?Q?tmaWafMklBvabxPpptydCMp/wSWhT0SRTi6ZUmZXfb9pGJpVH0t14rBn9HAR?=
 =?us-ascii?Q?dwl33MYQxiN2MdT625QODZyUMdXQRu5GaamkyXGODldnTslNidJV4d4uMJlY?=
 =?us-ascii?Q?42gXC//lgvn+7ABF68drJZ78FZiQ+AMBMsMLaP0ZhqOlxdmM9DKrNeBpI9m/?=
 =?us-ascii?Q?XeBN3xkRC68KqILXiLnL/AE0D3OM5YV0kQIxyEPwWUNmWplFm3xY70LJZr+K?=
 =?us-ascii?Q?EVBdGIC6ekPye0oeGu7ErzZsUNWw+BNUPS+Bf2gDIakRXbaVSNMLTbRizki1?=
 =?us-ascii?Q?ZXonAVNmyHLe+ofgPOLvyIgapDINYJeFTqaO2fFgVcLij81kXQHlMahAGBxO?=
 =?us-ascii?Q?38GG8TeWdbib7b/0cN3nzChMF//vP8Pf9PUvk8v4isAkKSexo9nIGTRaS8lk?=
 =?us-ascii?Q?lgEP8s/VQxS7ImA/x9oazs5Ec0IIsV65Z5kT4RU5flEJmyoNHQHs5Pj7RpSy?=
 =?us-ascii?Q?YsVg5Enebl0azIvn+4AzMMtKlc47vWieHVtH2QacgX9kd90Jj9ZFsyvQ7one?=
 =?us-ascii?Q?ZzOr7HNYgF0Oay0pLwdRiRQwlom5plhAbfevBUhs8vmzTAgJMUqcUfi8auzy?=
 =?us-ascii?Q?lXUjVCg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9hQXxUh1CkdI2Kr4g1f052NVlNUGPl3vv6BgZw9QlCpmJhHoUt1TuInHZwL?=
 =?us-ascii?Q?iJ01i9tMRJ3DoZIBXNkgxBqli+lVB/DC0+wZDTnKbv22g5rjwkdJ1OvhBiC/?=
 =?us-ascii?Q?85tOKmHb4nNDrMwr58wW2dizSefjszdSS24WjAXDkrXGyaC8yKApMl1MzeH3?=
 =?us-ascii?Q?wQsJJxByzpqkzFtzohlGy9NEW1nFUbcLzJcyWKRdE+jbNMurCmxcxhtwf+H1?=
 =?us-ascii?Q?IP95KGvDt4KMj6tDOOzBBC74DFApIQUHYABUGq0TCakQ8lOBWHMIbNmF1OuK?=
 =?us-ascii?Q?MynVvPZDz4Pn9pyXwlotU/ZX0V5u+cWTCyuMahzkP4ztR8zJei7lza7ERNP6?=
 =?us-ascii?Q?y1IHUktc+l+PbnSdQgGuxPbL5vBs6+1MMRJNZ7+w/qZOGWbbqkGBcBqQc+sE?=
 =?us-ascii?Q?YzsUXG/266PBLs7zkiudhNrpk2c6fWctUvH5LSo8ruIlaSDcsN4sEgrQdfu8?=
 =?us-ascii?Q?lj/tezCCDIpEofpUKeHammDipWzDCCQ4Odqjq4/klWJ+i+Z5GE9rlcVOxAqm?=
 =?us-ascii?Q?URLN+C6pk6knfwAujsHxPpMaCzNcg8OktsMeth+NUZQSv3pPmdbq2C39+/xj?=
 =?us-ascii?Q?CLTVSe3cl0WjHSj+QFMf918uGj0VfQ9R9kKF/gVKjFjGZtAzn+yXCqV8832W?=
 =?us-ascii?Q?MNbU8aqWOSvnVU1GYMAJEJHeyeZzHpwl74cuE4wKfAJOVngS37GRupJv5XIG?=
 =?us-ascii?Q?6FTYiD4iJMmcK+VXiXrSggK9R8HtTLRqu8C98kinuzwcXihRX6jbEBOpe01G?=
 =?us-ascii?Q?J5MXpIbroT3EfYhi3MAOaa/kPM2KP1DpLoaJ3y39X8ahrLXGx5a0GI8JtEr7?=
 =?us-ascii?Q?LE5EQydhheJZeL01E5g9dBowPKWdZxcaczuObN8Ksg1tLTMY8zMb8LVAygEv?=
 =?us-ascii?Q?fsKDcy5OTFFyUeyOZ5JLg9c4ZBO49EZNRzc5UKyyT8BJWfr7tIp7hQSNWTUn?=
 =?us-ascii?Q?PsPA5W2jWGuwn4WA+T6+C9lFb4BFVGcu+iyF/eMWOyzIdzYfW28WQKRL4wGJ?=
 =?us-ascii?Q?yL9utxURoJ1FT8HYt5XL+VRn3JakoU6ptnrYArm0URwzHWQjBaAwRl+D8t2d?=
 =?us-ascii?Q?3BfqE3DKxLGb/XuI4Ds2jaZvn9xb3jyxHumIxbK5aAtvu7Ed3ydr8S58sMWR?=
 =?us-ascii?Q?baKLWMuPVOK+gFDdc97AMV0CxqTPMrtFTgQIwEyZpBhCaXHdjiPguBE3qVHa?=
 =?us-ascii?Q?vYzrsjsPmtc5U2KXypgsc4hhFi6xrKLCvkQb+3GRaKU8eii8qlAHX+oK7Tpr?=
 =?us-ascii?Q?DPg4rhAO0zTz8a3rgoPdgal2WYuLHkTtrToN3w+PP1tHSMgqyIQ4qXnSo0v7?=
 =?us-ascii?Q?OTEdM9zhoH+AzzeN8G0QYjQaIRXZY/iHQlHUTq4RBIu4P094w6gKHCdMZ4EK?=
 =?us-ascii?Q?ESBOx2sjySTV6WSRua7/awzzi+ZNTRiMg7UakYBKS1U98oIjIK667kys+sB0?=
 =?us-ascii?Q?FAyfPtpNPC7mbxyslARWNthZJw+TiI+s6s90M8fX8RAx7lSHkvIXiNToSlt5?=
 =?us-ascii?Q?Z6TLpe9xXK5MuFxbEsCcCVK/GBie2q0RfJeN+Npkl2hymWFMFoTdK5wwa7jE?=
 =?us-ascii?Q?DD2MloNonFbmNfHbORwurzkCaNWvlEBrscv2ZYW0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b6c424-8e78-4d84-264e-08dcff7dbe07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:44:30.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0Zyq2ZQOP7HNJaH4NpCMSZnkOrVvFpIVDrK6pKLjnjL/eMU63MqYY/sQphSlJ6//gqKSCc7KpsUes4jHG/R/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240

On Thu, Nov 07, 2024 at 10:52:24PM +0100, Niklas Cassel wrote:
> On Thu, Oct 31, 2024 at 12:27:02PM -0400, Frank Li wrote:
> > Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> > along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
> > doorbell address space.
> >
> > Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> > callback handler by writing doorbell_data to the mapped doorbell_bar's
> > address space.
> >
> > Set doorbell_done in the doorbell callback to indicate completion.
> >
> > To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
> > and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> > to map one bar's inbound address to MSI space. the command
> > COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> >
> > 	 	Host side new driver	Host side old driver
> >
> > EP: new driver      S				F
> > EP: old driver      F				F
> >
> > S: If EP side support MSI, 'pcitest -B' return success.
> >    If EP side doesn't support MSI, the same to 'F'.
> >
> > F: 'pcitest -B' return failure, other case as usual.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v3 to v4
> > - remove revid requirement
> > - Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> > - call pci_epc_set_bar() to map inbound address to MSI space only at
> > COMMAND_ENABLE_DOORBELL.
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 104 ++++++++++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 7c2ed6eae53ad..dcb69921497fd 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -11,12 +11,14 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/msi.h>
> >  #include <linux/slab.h>
> >  #include <linux/pci_ids.h>
> >  #include <linux/random.h>
> >
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> > +#include <linux/pci-ep-msi.h>
> >  #include <linux/pci_regs.h>
> >
> >  #define IRQ_TYPE_INTX			0
> > @@ -29,6 +31,8 @@
> >  #define COMMAND_READ			BIT(3)
> >  #define COMMAND_WRITE			BIT(4)
> >  #define COMMAND_COPY			BIT(5)
> > +#define COMMAND_ENABLE_DOORBELL		BIT(6)
> > +#define COMMAND_DISABLE_DOORBELL	BIT(7)
> >
> >  #define STATUS_READ_SUCCESS		BIT(0)
> >  #define STATUS_READ_FAIL		BIT(1)
> > @@ -39,6 +43,11 @@
> >  #define STATUS_IRQ_RAISED		BIT(6)
> >  #define STATUS_SRC_ADDR_INVALID		BIT(7)
> >  #define STATUS_DST_ADDR_INVALID		BIT(8)
> > +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> > +#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
> > +#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
> > +#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
> > +#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
> >
> >  #define FLAG_USE_DMA			BIT(0)
> >
> > @@ -74,6 +83,9 @@ struct pci_epf_test_reg {
> >  	u32	irq_type;
> >  	u32	irq_number;
> >  	u32	flags;
> > +	u32	doorbell_bar;
> > +	u32	doorbell_addr;
> > +	u32	doorbell_data;
> >  } __packed;
> >
> >  static struct pci_epf_header test_header = {
> > @@ -630,6 +642,60 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> >  	}
> >  }
> >
> > +static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> > +{
> > +	enum pci_barno bar = reg->doorbell_bar;
> > +	struct pci_epf *epf = epf_test->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct pci_epf_bar db_bar;
> > +	struct msi_msg *msg;
> > +	u64 doorbell_addr;
> > +	u32 align;
> > +	int ret;
> > +
> > +	align = epf_test->epc_features->align;
> > +	align = align ? align : 128;
> > +
> > +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
> > +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> > +		return;
> > +	}
> > +
> > +	msg = &epf->db_msg[0].msg;
> > +	doorbell_addr = msg->address_hi;
> > +	doorbell_addr <<= 32;
> > +	doorbell_addr |= msg->address_lo;
> > +
> > +	db_bar.phys_addr = round_down(doorbell_addr, align);
> > +	db_bar.barno = bar;
> > +	db_bar.size = epf->bar[bar].size;
> > +	db_bar.flags = epf->bar[bar].flags;
> > +	db_bar.addr = NULL;
> > +
> > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
> > +	if (!ret)
> > +		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> > +}
> > +
> > +static void pci_epf_disable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> > +{
> > +	enum pci_barno bar = reg->doorbell_bar;
> > +	struct pci_epf *epf = epf_test->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +	int ret;
> > +
> > +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
> > +		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
> > +		return;
> > +	}
> > +
> > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> > +	if (ret)
> > +		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
> > +	else
> > +		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
> > +}
> > +
> >  static void pci_epf_test_cmd_handler(struct work_struct *work)
> >  {
> >  	u32 command;
> > @@ -676,6 +742,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
> >  		pci_epf_test_copy(epf_test, reg);
> >  		pci_epf_test_raise_irq(epf_test, reg);
> >  		break;
> > +	case COMMAND_ENABLE_DOORBELL:
> > +		pci_epf_enable_doorbell(epf_test, reg);
> > +		pci_epf_test_raise_irq(epf_test, reg);
> > +		break;
> > +	case COMMAND_DISABLE_DOORBELL:
> > +		pci_epf_disable_doorbell(epf_test, reg);
> > +		pci_epf_test_raise_irq(epf_test, reg);
> > +		break;
> >  	default:
> >  		dev_err(dev, "Invalid command 0x%x\n", command);
> >  		break;
> > @@ -810,11 +884,24 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
> >  	return 0;
> >  }
> >
> > +static int pci_epf_test_doorbell(struct pci_epf *epf, int index)
> > +{
> > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > +
> > +	reg->status |= STATUS_DOORBELL_SUCCESS;
> > +	pci_epf_test_raise_irq(epf_test, reg);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> >  	.epc_init = pci_epf_test_epc_init,
> >  	.epc_deinit = pci_epf_test_epc_deinit,
> >  	.link_up = pci_epf_test_link_up,
> >  	.link_down = pci_epf_test_link_down,
> > +	.doorbell = pci_epf_test_doorbell,
> >  };
> >
> >  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> > @@ -909,6 +996,23 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> >  	if (ret)
> >  		return ret;
> >
> > +	ret = pci_epf_alloc_doorbell(epf, 1);
>
> Calling pci_epf_alloc_doorbell() unconditionally from bind will lead to the
> following print for all platforms that have not configured a msi-parent:
> [   64.543388] a40000000.pcie-ep: Failed to allocate MSI
>
> In ealier discussions, I thought that you wanted to call
> pci_epf_alloc_doorbell() in pci_epf_enable_doorbell(), and then let
> pci_epf_enable_doorbell() return STATUS_DOORBELL_ENABLE_FAIL
> if pci_epf_enable_doorbell() failed.
>
>
> Perhaps you could modify pci_epf_enable_doorbell() to also check if
> dev->msi.domain is NULL, before calling pci_epc_alloc_doorbell(),
> and if dev->msi.domain is NULL, perhaps print a clearer error,
> e.g. "no msi domain found, is 'msi-parent' device tree property missing?"
> Or put the text in a comment next to the error check, if you think that a
> print seems too silly.

I think resource should be allocated in bind. it may be too frequent to
allocate and free msi resources when call pci_epf_enable_doorbell()/
pci_epf_disable_doorbell().

If you think "a40000000.pcie-ep: Failed to allocate MSI" a noise, I think
we can add a msi_domain check in pci_epc_alloc_doorbell() and print a nice
message at pci_epc_alloc_doorbell().

It should be similar as eDMA detect. It'd better show captiblity
information at beginning instead of defer to when use it.

Frank
>
>
> > +	if (!ret) {
> > +		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > +		struct msi_msg *msg = &epf->db_msg[0].msg;
> > +		u32 align = epc_features->align;
> > +		u64 doorbell_addr;
> > +
> > +		align = align ? align : 128;
> > +		doorbell_addr = msg->address_hi;
> > +		doorbell_addr <<= 32;
> > +		doorbell_addr |= msg->address_lo;
> > +
> > +		reg->doorbell_addr = doorbell_addr & (align - 1);
> > +		reg->doorbell_data = msg->data;
> > +		reg->doorbell_bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
> > +	}
> > +
> >  	return 0;
> >  }
> >
> >
> > --
> > 2.34.1
> >


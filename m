Return-Path: <linux-pci+bounces-37105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE91BA44F3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD257A73B6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99413957E;
	Fri, 26 Sep 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MCBCPI+h"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6D38DE1;
	Fri, 26 Sep 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898619; cv=fail; b=UX0OaD+/hAXWjd3jVUMC7PTKr0qG71MzKSuqkDMPoxv0qlmaaX4lQ2GuRbNnVsGTatn6e7F5Kcly+aTl7cfruZI6QvPmOubTzTxeD/PMHN3CIMniKaozrkhRlnHGKdAHCq6Ib8hMIAUjMZ0lhDsz/BcybxyiwpOnulGbeIn3in8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898619; c=relaxed/simple;
	bh=lceJalqRof0i8C5cQ2qkgclYJMYDlBGcRZ9QUjwJUwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iHfwuEKcncMQi4EjxVNfxHTkdV8AxhV9PNNerdgCus3jvZoJIzRDkgRQ72yeBXKYPVOKfOIiIZrj3hQejWuBm1SrCRoDed/H0AJGh7gFwdC8cIb8HyLbsWbbCYGzyB4nNXgKUTnzqt4C5F/EQ8OiCk+RGdKVGIW+CNeTQAeuYAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MCBCPI+h; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up/bTEqzFo8OMzkp79Mn/L6qmCXHc+KKzZa1AVZVrkm42Cq8wxHh8FOaqUbc8mU8REY4LJQx6Ntwx7xDHUhN4LvzKIlgJ4CGUIqOwM4pVPjK0pBKcCWvYpd0Z0hhQsTFpv5U0uiIuehTwvRQ0McVcT3qn2s3b2JHfS6I2TxQM8b2bdzUFB0hxZYElv39Hmo49jExDpqDxVpfnOjo2bBh3ZAW9jZ3Wk+0PfqvkZ35rFG+xuVhPfkobCT25Pb4VQRAMzXF/F5cJQGAufOL/xuujSO03z8lsBk/Vv9O8u2dmVq3pbbgtaSGP8Swvq0qvTRL5eQtZpZFd6B4XtK+1cJekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LjNKdbgKuhtOxFcfdNV8Fi938QNTSKywuL+iis5Ncs=;
 b=OqonAMp/QgApa2tjQizWgir0XE2FhrjOsrnFF8fetC2KyRVFiZ2I30cPbdc50F0e4H2ahaXJQlCsm0d8xNiLyOtTL+0nAdZmzSRcYhH3NUyi0TCEpmSJwLXoNmmbG6a1dmpz2hJMsil0d8sTVpwVzyvIyv0zCjLkEOX1Lot7+jc8JehkegQjaBGbsMtZmCMJX5Cin1CD89TfrbrRPJy5EQFKK0vW3Uhj73FjvHTb0h5GJCdKVEog+UI2maG7nZwPYTe1gm5d12XNkWNUL9iEw8mA/MpkUAbJmho1zNW7TIH3zNX0PfcYLSRSP6nrPZVjYROagsNYuYz0GO7aMxmM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LjNKdbgKuhtOxFcfdNV8Fi938QNTSKywuL+iis5Ncs=;
 b=MCBCPI+hK94EVjY8sc3TklmgQM8m+S7JXLpQxlXV9fuxVrY8MJ5KfUYAClfjeGntaYNpKiZCrDEcMOcKe7HWQXhAQhIBd1hlEPJRHwqtkw5q/yMiz2taaf+efbRH2ppeBRfJlQyfYeNxmOAdxe1a5g5+kvI0eM0s1KeXAovu/oG9GymdHTzxDW7JJ9c7naLKfzd20fcg6ByGE60UJ/gaGhb4lB4+wbyQi3nB2HV9PeaMgcw/2hldb5htFUlJBgtDXxlw2B67SYKLb8fWFyxN6JcGHWZrRviKKxDUsmDS8xWDUz3QsTmCaUyPu0CigRQAK7EcyvW885LoJ6g9r6vwHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS4PR04MB9624.eurprd04.prod.outlook.com (2603:10a6:20b:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 14:56:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 14:56:54 +0000
Date: Fri, 26 Sep 2025 10:56:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Message-ID: <aNaprpfaeXIcqeGD@lizhi-Precision-Tower-5810>
References: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
 <20250925-vntb_msi_doorbell-v3-1-ae0b0c93caae@nxp.com>
 <aNaHrj0rwLTtSRS3@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNaHrj0rwLTtSRS3@ryzen>
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS4PR04MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2484eb-a220-4385-13ec-08ddfd0cee81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BpCBx3D8HLEICdjFAGi/m/H22JxmcJZjUi+MN1M2w/woCHRWz6JpUYv/Q7kj?=
 =?us-ascii?Q?oWdNZP14QFtSGH+3WWB6EDYP5y2AY1wvxQ8iGuihA4amqi3z6lWkxoCx8W6y?=
 =?us-ascii?Q?qXCAmeKIkG+YHmwVBsV4491V52q5m/55tr3Mj1xi3f06GMLlqBXtGUEsYsBO?=
 =?us-ascii?Q?u9nG6p3023wHQlyQfNB33QPO1V5Xa+2MaesTHBLZ1cQZEX1lMrIqJ7N7ZOVe?=
 =?us-ascii?Q?LOhlEIVoAxPUV+k5CNSMbNuo3AhYJ0h59B63CH8enElJNAOQvDiBcafZgOOT?=
 =?us-ascii?Q?jKPAWAZ0nt55Q4DvABnrdu2DCLEZOa2HFfAQfk2aGFuXmwlmjMKRJSHRAQNv?=
 =?us-ascii?Q?FSeRVv3wy+5ajuAZVDjHKuBPJxIo9zN23ebxucu+8oHejwPw9WaGuHh9Muz7?=
 =?us-ascii?Q?tvmiX+iBk1iPANrtUjFZjjfvdSPgTc9cX9g/ytwHCpIYl6gMTbF/EuXWjDfe?=
 =?us-ascii?Q?cuP57i/CBCRG90+Yqbs09sI9RVIivw8X02xZBgOTCW1tMwoVdF1vo29WiSwk?=
 =?us-ascii?Q?V9lDKGABf9pqmyxcHVMghpcBircoUbT0vLONwrtxU/5KnOAMo3cTMGzelf/6?=
 =?us-ascii?Q?J3kHN2yz9O5AZyQaWtgu6W7m1htvtWpluN5mmkaiYddoMwhtCn5epOG7WFQY?=
 =?us-ascii?Q?Ro9UOoIq4CFmBC1PLbVV0SOWpqWv+rT+p7bb3+EvmhMshVfyo1lK+vNb58eK?=
 =?us-ascii?Q?W+6gavpadACEHuDv+bEcEnAahx0oWQ3p5AKlIe2T7ffiiiXBsv82j8IcsNYb?=
 =?us-ascii?Q?qyj0WzViR+DlnsZKzyOLCQzxt74GZOn+RYmYezdmfXr1VdkHD0fuJ7UCjlXW?=
 =?us-ascii?Q?Z9IlTaOOYhzdUZPAukLx1u4jBIj29PUxSff8RgxlQQ9Ft5rziKiAiz5vl8l1?=
 =?us-ascii?Q?OFZ155rjUcoyC+IIlu3lAmdp8u0OupIz67q78u0cbWsSZYn7irSV5y3gXfli?=
 =?us-ascii?Q?XTy5fsAn9RMHtcbjbgcVYtkV7KdueXis4R91mSW+SketmFjjfUk+UmzeCSpo?=
 =?us-ascii?Q?NYqeIa9cQjyX+DU6Zx//Ro0F/tOCrWbXsd0c6lQqDBGrJhyiSdGBSKGpMcx9?=
 =?us-ascii?Q?0752PGqhGEz9UPv6vhP/O1ItMGbTeJtf0K1cNsjlTc0q+O8KHw9uJoE5iC1N?=
 =?us-ascii?Q?AeINuIvS4z9Do5hh2W8oyiopD75NyXSz10AsKMtsgXvTWR54prchnmRuDpWr?=
 =?us-ascii?Q?y5P/2exXc7SBFbq3wUN8hYCtthOrn4qaHFa+J/mxBcj2BPp0HIWYU5WnUnqZ?=
 =?us-ascii?Q?2Ocqv+u2DUss7N7jUAzkiMg72apxvGQqT/f8XcQERWHh8JrNemp2NTRyOiOZ?=
 =?us-ascii?Q?JoPsmTJM7kHY5UUBkETLys1Q4EnWgbOjG5F1fs0I8uYqLux9HUB/C8WiiB0W?=
 =?us-ascii?Q?IOGipNUsgiX7D7N3I+FH7tanQ8SjlRewp/2/p9PGlsUhfUFg8BqXd8VcGr34?=
 =?us-ascii?Q?d4PCCw/mCqcQEg0gfU1sGYaVQNOfVgQZmfRUoW2a/15JYu5v9CcgPrY11IWu?=
 =?us-ascii?Q?3Qx9sDbH18R5wDP7YGT7gGaGD+R7GmmId9+K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTwMb6ypR2jzfQB86M3Y7FUYgwqjuM/qOI+ASspOMJneAu5QdEe7GkA98Q1W?=
 =?us-ascii?Q?0yiPTN97o+23si3jAG9HigKrHrEyRTvTVDlK/E9LjfxWwMVvh07Q1V3cDCQM?=
 =?us-ascii?Q?bbCFeVsRzHoiVKBKySrtDrMmynpqJ/CCfENo0c6RfGK1HYMAxwuzieaYzX8T?=
 =?us-ascii?Q?2RhRGy1b18WbQpnONb6ADLgZpixXZZrOCHwi71ECzv6IoF2SXR/PZ4XdGxMU?=
 =?us-ascii?Q?OaJ38maiA7872qaLa/W9cqTheLXwm4NLd9F3LX8qoztGC96ArQcMfeEdjfSq?=
 =?us-ascii?Q?6ngD1IRLIndtC6hewzpU6qpEPaKN+I6mMwxCHMD8MywfscSc0W6qW+1urm0J?=
 =?us-ascii?Q?IgkD2IDA5Ki2mVfyGWAJ2eYaj2MlNSt0GJQczAHghONO1kvkac9i+XlLlGeg?=
 =?us-ascii?Q?Bwwl0b34DNqlZugJehxkfNDIld4pfLp1oghZVqI8em3xrwZFg8jLfBNHoNE6?=
 =?us-ascii?Q?uVUtegbJ/j5vCBb7skYusI1E0yaVf9WqYQaM8WrCoknAZ1X8N0BTRnpMAUVN?=
 =?us-ascii?Q?nc+jfSyCtZaUH2QT2lHACBGSlPsl0FRh9aMr1uo/ZsOQr/oy/fgRQiTFQ4vv?=
 =?us-ascii?Q?4Zb4k+1XkvRqAnmzKtLxh7MVzhIgxqPlmLMSQIkq5UHZwqJAqttjQp95D+Vy?=
 =?us-ascii?Q?0uWpbAgvFl0KUkBQImVdk8cL+EQsxz46CpOErD2VcZJXX1Ksri72c++39Mnc?=
 =?us-ascii?Q?tVQNa6K4JFtvHoCbY075hnYfVNKmdQDhEmRgZqwZfgIhHnlbqQ8eDVzwiQ7u?=
 =?us-ascii?Q?sjwd5nD+R3e7Fr8uwwGFSYl5X7Q/lmnJjbCFGJf9TtaBK2XqYAhdP4BAuYzX?=
 =?us-ascii?Q?zdLi82RfF1beGwd0QXklBvXVttrCmYunzjs79zMCf6K3Rc4rAbeFtkT4aXk4?=
 =?us-ascii?Q?iX7VWfJtcTcUG8d9shYX72CGFfdSDi1nEAabr9IwQD+U2MMNXDSOtngCKyl/?=
 =?us-ascii?Q?+3n+9H/m3Ll06DP9fxyMtlAjIG+ZlC259ETaTL9cc4NZS7YyLb4gwy5/NRXw?=
 =?us-ascii?Q?Jq3aEhAKWMwgESF79/Nfyik5YU3/eMx+YwwJv8jqez8KqKpxXGGB5TKMGidp?=
 =?us-ascii?Q?vOqyHZNXJ4poYj8q0oTj92oU+Kn3unyO6MT7Ie2LozFNnTI4eLN3YSG9iq6d?=
 =?us-ascii?Q?1QVN74fi98d60o3Q/r05K9htclmMzOZgpTop8eMxUNbMfj2bZgHiIcIXBV0x?=
 =?us-ascii?Q?B7j1kUWeG1dqPpRIEyP4ErRaYa7ZuY9ubI0RxNuuXLCh3Uj3Ef//n0dGm07+?=
 =?us-ascii?Q?Vn599S1QJegkr0sBSoS86qNfmy9pU4tJX5QbHmxCzUwx4nm8d81e0DXUVMGr?=
 =?us-ascii?Q?lNORcrSW6XGcPm0z5Pgko2c3sU5SoB63O1L8T/n7EScfEcQWHRbY7kvJMQDB?=
 =?us-ascii?Q?11gj9gXuMEkjm8nFTb858AZwWPelg0UVaCifygSSkX+pjzJ7US8sU9DqFIjd?=
 =?us-ascii?Q?c0esjxooqrn299y+SLG1cdNR8g0UeyEQV3I6zcH74nwhl/QoZYdr+kcPgeQ1?=
 =?us-ascii?Q?xcAiguOMgeQu4bN+1D0RyOacYq02zZ7AdMgX1FTNt9yxqlTSxiBgZC4yUosT?=
 =?us-ascii?Q?bYmMPkUzAYjw6JhM7lLrnEyrYNzOd+1ZGUhahuqY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2484eb-a220-4385-13ec-08ddfd0cee81
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:56:54.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whqqqIKRuRub0Kiv2ABk0MRYXW/mhkM2+X8huzbUz0ohikP2PBVBPQQX1CmkIaw+Nx/rAJ/4r/sgh8BZTOrn3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9624

On Fri, Sep 26, 2025 at 02:31:42PM +0200, Niklas Cassel wrote:
> On Thu, Sep 25, 2025 at 01:01:47PM -0400, Frank Li wrote:
> > Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
> > size and memory size. Prepare for adding support to set an MMIO address to
> > a specific BAR.
> >
> > Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
> > confuse.
>
> s/confuse/confusion/
>
>
> >
> > No functional changes.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change in v3
> > - change return value to int.
> > - use two pointers return bar size aligned and memory start address aligned
> > - update comments about why need memory align size. Actually iATU require
> > start address match aligned requirement. Since kernel return align to
> > size's address.
> > - use two varible aligned_bar_size and aligned_mem_size to avoid confuse
> > use 'size'.
> >
> > change in v2
> > - new patch
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 84 +++++++++++++++++++++++--------------
> >  1 file changed, 53 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index d54e18872aefc07c655c94c104a347328ff7a432..2cd0257831f9885a4381c087ed8f3326f5960966 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
> >
> > +static int
> > +pci_epf_get_bar_required_size(struct pci_epf *epf, size_t size,
> > +			      size_t *aligned_bar_size,
> > +			      size_t *aligned_mem_size,
> > +			      enum pci_barno bar,
> > +			      const struct pci_epc_features *epc_features,
> > +			      enum pci_epc_interface_type type)
> > +{
> > +	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> > +	size_t align = epc_features->align;
> > +
> > +	if (size < 128)
> > +		size = 128;
> > +
> > +	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
> > +	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
> > +		size = SZ_1M;
> > +
> > +	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
> > +		if (size > bar_fixed_size) {
> > +			dev_err(&epf->dev,
> > +				"requested BAR size is larger than fixed size\n");
> > +			return -ENOMEM;
> > +		}
> > +		size = bar_fixed_size;
> > +	} else {
> > +		/* BAR size must be power of two */
> > +		size = roundup_pow_of_two(size);
> > +	}
> > +
> > +	*aligned_bar_size = size;
>
> I think this name is wrong.
> The BAR size has not been aligned to anything.
> The BAR size has to be a power of two, but that is a requirement of the PCI
> specification, so that in an inherent property of a BAR.
>
> Perhaps just name it size or bar_size?

there already have 'size' for input.  It should match epc required's size.

how about 'epc_bar_size'?

Frank

>
>
> Kind regards,
> Niklas


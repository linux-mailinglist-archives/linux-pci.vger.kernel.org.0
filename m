Return-Path: <linux-pci+bounces-19767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C75A11284
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EA8188A752
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F5232428;
	Tue, 14 Jan 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lezb9whB"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E71FBE83;
	Tue, 14 Jan 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887891; cv=fail; b=M5ju5/taLUqZ3lX/bg8mNMB2EtUpMM56H4B5f10NhWt4P7roQlHZ31jK09/B0kvA9Fp1WCVQ6UtomkV2BS3wA8aN72sjFn5+eoJcvY/cza+no7XVZcH6xcREs65hPC4Y7rqZoFyIhggDa1t/auaDRGqJNtNpmqdbMJ0obwVI8R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887891; c=relaxed/simple;
	bh=zjIV0oLAFwjmFKKLE3SLDMI2+kiQ92OrBLiNZNlhZow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M5CwwKRs1OLP3h/IDz+5OFahftSlo08y9I7kV/F0gsDzXbo7h9SV2QTlI0mqKjJCXVNKCpxDRCVtx2O4SJxD2R00//LEVrip0a54JPQ8/QSjuXk+57Wq6hxpCh31Wctjf/QxHJizdDI8cBkXXfj46zUblhFC0G/mUZYdWVPx1SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lezb9whB; arc=fail smtp.client-ip=40.107.247.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mz2DT1u2UgC7U8VU4puu2SdACc1ysfS20PORMIIse9P72lFgps8O/V4QtTwRnA4fC9Ia+/sRyOLtwPCRKK2Os7uuSoTYOirb1hfvYoawzkWDwQOKQRu/J14cuH8ZbIZt0FwMe3bkJGiAqbbVnXU+Mf+mr3/3LkrCX0L7LVkDDAkdjjDmLkRdbtWiZbl2ZnEK0wG6VyFWY16Znxipj5dVnLSIaJdayKktKoQu6fPRAHbiVsHSeeQbtZEECO19gwLeSc1oUISkRVAJYzWd8ksB+QnTtTK/hmAhsNNcZOiBhKoOvoucxxG5kjY4PcghWaxXBQJBxw4emN6X37TeSmCu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSA+letLx04xgKW6Bf2iopfi+5GqQat1kHDLNoCNrZY=;
 b=nbdYABsROTzddbx15WPiQ+f4y5oReK+VPm65uVrT0gYhgGSN0EOihjnEEqEnk4nGc5uGXAyH5UNltst3A3knUUPzfMq27nLVI0tjOmi6aPNdckRL4UV32ggLLKwC1mjmyCpPK5bP6RTKk70/Z6sbqtuXy3pKpHwTEUhqgBPgYitI24ou+Wu+YA2zE30fdVbsz/33VHCbgRVgtEHj4dcoMM4qOPYzKoYEtPIIEbp5qfkNbb41vrDpBZOXqHXzZYvOcx7IXzN5burNUn2IG6zbZ3mz4RGt0+oJMJ/usClvlL6ue5bNreBIdXYhQ2dB2wwRFKJ6zgIsttimEf24PYzlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSA+letLx04xgKW6Bf2iopfi+5GqQat1kHDLNoCNrZY=;
 b=Lezb9whB9HneJuZYX5D8cd2ObUQv/8+1zqtms2lPF3goCPVSUyiGwHkP+7pMa6TndmJQ7s0KHHmaOPDI69V6PznJtvCZb5hThhYsEhqK6S5kNNzeJ4iIbqxcM7Ue1dIydzEpDVT+pMimHKBTb1ecB7HI/9bGD7izDB3/gMAfHzaegt4hwr6m4GcJiMghhihkZK6B6Bgwn0CkndcIhm2vJJqmofGtIo7jd7YFs7/aLriPxtuEraienEp3jpMYQ89zDWrYXpTpDiaKSu3ChZARGF9YOVTLGjJdsLk2ER9QBzdsHm2yiEGNF9+XgaP13O8dxtbsqBBzqoXRjVw6LU5cQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 20:51:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 20:51:24 +0000
Date: Tue, 14 Jan 2025 15:51:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, dlemoal@kernel.org,
	jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: dwc: Always stop link in the
 dw_pcie_suspend_noirq
Message-ID: <Z4bOREyxM7XWUlpt@lizhi-Precision-Tower-5810>
References: <Z4a71nPa1H01+Ang@lizhi-Precision-Tower-5810>
 <20250114202622.GA483044@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114202622.GA483044@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebe4bd4-dcda-481b-4fcf-08dd34dd3583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z3xs91/O8jiSbJQZH6wBBNCq7JcGt+i9hshGzEOzZ9BWtJ/FSjVzn4iOxdCS?=
 =?us-ascii?Q?WR5qdJC8Scy3nFrR3tacTpXmUafjigdzXGMysqyEQ9DnGWNEZdK0sFdH/Jtb?=
 =?us-ascii?Q?2a71036Yvx4zC9fVHth+3UCSGrzF4e4OoBKqt5mqlrq3lXfA9cCznt89tN45?=
 =?us-ascii?Q?g2eb6tpV5D46hj7i5yF5Tbk04qUbSfZWpYtQQNhKGgNLlr28LgxpvU8c3Jer?=
 =?us-ascii?Q?l1apz7ZqmcVrkoUV13mL0Njlx/pejAeyztJezficBDMRJ9WYWnZ2ctXfoSD8?=
 =?us-ascii?Q?XnkppmletGExGhyH06dhzD8sDiEo3Vr9V2iSCiFFVY6FtyOHHx/B3aBLoNmg?=
 =?us-ascii?Q?Ocqgbzw/53HLyrVSHP4+iLI/qwnS4pVca4xudMqSo1jMZ+wGH3xM6TFGmUii?=
 =?us-ascii?Q?2uTCZX5hDdZkG1ZKvASSH02jnnc9goA6BFa8dY3IU02XRo5tMqhjsak1qm0c?=
 =?us-ascii?Q?RI66iNEgBJhgH+AAO5F98xjXz9gVYgDufvRBtR8CqIQnOmozhc1iR6r6zzWE?=
 =?us-ascii?Q?Ny4Q0rFT2NZN17K1ODLQULq14BY98LekEwzqHzSx0I+SvxzFYSlhP0ePEcJq?=
 =?us-ascii?Q?FxQb0/WyjgPtJO2a29v9zMeyHZoCtr7QLfW3AMxejFIOigMe8mOuyK207S1R?=
 =?us-ascii?Q?y37KKvUB5XlCtaGAHBjbV2QPpnMUztIlqgRs2w4pNIN71wDTzvbB27/ZFPbO?=
 =?us-ascii?Q?Z5XSYHmF1SKstiZRv1LuDYH1b3XGGXocn5e7C6TOB9dKczJD6qFKTRcBDTDw?=
 =?us-ascii?Q?eIqQSkdC0NS5OdyKEyp20CCAUG7lldXi+Y38jlLb1RHOx8hzF7JPV5L6Zei+?=
 =?us-ascii?Q?JwfMHUnrNZnqzw/FJNLAVaHGXUpK9k6Yq0mdje0ASKgffIfn+NK6WvDGVj0I?=
 =?us-ascii?Q?D2Ay4h3o3s14ER4cTUXBKH9+2sHHbFkCVD+xfxavfiOXSKFXyPT9oHkJbmog?=
 =?us-ascii?Q?BldB9LEXU0m34QKX7RYdfiPzd+BM1yqaLLyphJ3GcwwGnSswVtLfNxpL8HV0?=
 =?us-ascii?Q?CIi8VfVkaMCjJQYPhV/GoUT9nGm5Muhu87w7pBCeQLNR0JEETUAIaKIVIgjI?=
 =?us-ascii?Q?44XQA3xDnX6A2wMdQ6d4Yp2pxS2EaQdJ/vGb1X0s/LRvkW92m6Yr355o8dGU?=
 =?us-ascii?Q?I8X1tyvF9vriWRVO9O0FgMpE6asRfZqYhAtjAX72ll+OCrd9Heq31Ayx6d54?=
 =?us-ascii?Q?IW0An2hZoUYm9jNWvbpKRJLTUYll2KJfQ2an0wRSK1sLKV4z/h8zy+9nQ1gZ?=
 =?us-ascii?Q?rPlRRi3ROB9UEPKQ/s785MUQbXhaEJYWDaH914CrwVuynStjh1btc9pF+nZu?=
 =?us-ascii?Q?vOjy/um3d4fDv3nkxkcxaUIt+nbOc3ljEFc+Di9ELrFncytEs8Cyl5rtAGdd?=
 =?us-ascii?Q?L3AhllFGqyoX/kqVTUjUFiXsX5eSaFcMpg6W7SoW8WIdwY/AStQwk9PJfP96?=
 =?us-ascii?Q?0+BaegEHrOGkZLm8EYENftJidOSXNY/UD4aLftVXUaL69GA83vvQ2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2GMqtfsU/2PG5QF+xfoWJ/43hl6WMzuieHmUyzn9n828cDqcOI3eQUkmxaui?=
 =?us-ascii?Q?HHAISYASeTqcCYbQ16rfg9F+1awe7FW2axgAOtACeNGgbyavSeBqRVVXLjSq?=
 =?us-ascii?Q?AGM85OLqld4S9C4jGzzzQlOQaWz9KOqBLdsh0QUx/3ch8LoWZCRaxUduG5D5?=
 =?us-ascii?Q?mAjVXfDBcOeKlFLVGdo/jmUh8Zh7pDjLSoeTQyx/KmtPuzanMFUb0ris8adJ?=
 =?us-ascii?Q?gYFOLJ6/EoF463GH9SA/t1/+V4qMzKs8JPdOkwcftkbtpmSF3YWwVhCADsTP?=
 =?us-ascii?Q?4SQqDxQl5MdkvE7wQwbzn2cf1ydHgH4lJT+klJIrw30MgR2/HbRccv+hAb90?=
 =?us-ascii?Q?hatDSuCoGJxh7q2dXxrBcJsWUShse/SMJmGvSbeMBLJO1r/5b14y5XHg+wFP?=
 =?us-ascii?Q?8zk/ZwQcDSNNYV1shgIQw8ywNRtiCfeBN2OOgf3Gansnv0YZQk6UvcWl2YSP?=
 =?us-ascii?Q?1k1w2JL9TKwz23kQDoVMHtX4LBNPlS3X55FoZES026/oVP3jrqSUvD5RerGB?=
 =?us-ascii?Q?HMPq1adEaq3GHbx7vG3sKCAiu258kpvPyFgNkTxXfFC71/T91s89E5BQIi1n?=
 =?us-ascii?Q?V5/MO8T2NsFBWopEdmO9F62OcgeDE4I+VLFH8yh1FeH0g6NABXN+XK/wrjBq?=
 =?us-ascii?Q?TpjLFnNhbkbUTb42Q3CZaW9mL918EopUgmwuy2/V54l9vAPFVgwsQwLLlAE2?=
 =?us-ascii?Q?pACOOLe0eahMvwZ9Ql44OsZt6qg/ukCuhW4vGgQWbNtlSaAfmwDCNTp9bgcW?=
 =?us-ascii?Q?El6ILXpo7A1ZYFYAqH16zwsShtJQEGXDvqVevWkiChbQIDrb+B7ttzsQHB8j?=
 =?us-ascii?Q?CgzxGGPdC0Jeltvjf5Kd5IP00blKzyV0STcbCNd7QjwjmGESlzx20swgtyXs?=
 =?us-ascii?Q?cNJGB9Ll6aq8bGZwB6cIsCqq8dNPTM5OuDLXnhFOEm8rAS6ic8GX1O6bgC6D?=
 =?us-ascii?Q?hkBpZE4UE7J59v/U4jD4XjaBhY9mVCx6P2TTa/NFw2dtPH46pl0mFpEbK+1z?=
 =?us-ascii?Q?5nTQlEzZTvY4i6QGoML/SJVLab+SLLhNPUiRLzbNsbs+HGHTy7zWPklMtv1z?=
 =?us-ascii?Q?WB+ysltIkenW4xC4s1ZTOH+dBCm/q5NmZ3htfBY2k9AT2B7MXdYtUNSQEZnp?=
 =?us-ascii?Q?OG+nfRnLhnU30ujPka77VL8Mqay6F/R4eXD88SMO983x4MPquTo1zYIypodQ?=
 =?us-ascii?Q?mOf+5266ToHRfO/7oBFkmiWvf2nYEQIsls64gFJCiD0i5zgJRPnp1CCOiCjO?=
 =?us-ascii?Q?BJD0e3rLyYnIFTPnB9B2YYguWjYABFfaRighrsYaMCO2yBCWyZsCoBg1kuT5?=
 =?us-ascii?Q?vKI0dy8VYM0/TXInuT/EQ0lbIEFyVorplPBgEMwsym8b8VNVqlipjeQI7BT+?=
 =?us-ascii?Q?aAeumUvmY7HWhg6LYB63b0WRUsfNIZqIREFPnRKw25ZspzI18/O/wrQIpcQY?=
 =?us-ascii?Q?yoK9jURpE6HlJVfH13ZZ4t4m5mp6SpYhCn08XbR+dzdB4M7k8OjJFzAc/cR1?=
 =?us-ascii?Q?jS/7OqRLUA9JnWxIApm1M/a4Hd3FwHnRn3RrUwDXbCT3JU9D0l7Luau2Whje?=
 =?us-ascii?Q?E2aYojXjJctrk7Mq5BqPNc2WiKD9TNIsTWNughpi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebe4bd4-dcda-481b-4fcf-08dd34dd3583
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 20:51:24.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKiaN/kBPS0/84fcPwmbYEDD1wgkXNfDd+tjp2I9O58wAGSg8RwlvpzsXquFIHoI4GINO0EOu43XppeuJueJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

On Tue, Jan 14, 2025 at 02:26:22PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 14, 2025 at 02:32:38PM -0500, Frank Li wrote:
> > On Tue, Jan 14, 2025 at 12:15:18PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Dec 10, 2024 at 04:15:56PM +0800, Richard Zhu wrote:
> > > > On i.MX8QM, PCIe link can't be re-established again in
> > > > dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
> > > > dw_pcie_suspend_noirq().
> > > >
> > > > Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
> > > > keep symmetric in suspend/resume function since there is
> > > > dw_pcie_start_link() in dw_pcie_resume_noirq().
> > > >
> > > > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index f882b11fd7b94..f56cb7b9e6f99 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -1001,6 +1001,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > > >  		return ret;
> > > >  	}
> > > >
> > > > +	dw_pcie_stop_link(pci);
> > >
> > > We should try to avoid changes to the generic DWC path just to
> > > accommodate one controller.  Since other DWC-based controllers
> > > apparently don't need dw_pcie_stop_link() here, this seems like it
> > > might be the wrong place for this change.
> > >
> > > If doing dw_pcie_stop_link() here is really helpful for all DWC
> > > controllers, this would be fine, but the commit log should then explain
> > > why it helps everybody, not why one particular controller benefits.
> >
> > It should be for all dwc controllers although find such problem at i.MX8QM
> > platfrom. It should keep symmetric between suspend/resume function.
> >
> > So far only layerscape and i.MX platform use these common functions. Other
> > dwc platform still have not switched to this common function yet.
>
> I see that layerscape uses dw_pcie_suspend_noirq():
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-layerscape.c?id=v6.13-rc7#n379
>
> But I don't see where imx6 does:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-imx6.c?id=v6.13-rc7#n1236
>
> We don't currently have anything queued that touches pci-imx6.c; am I
> missing a patch that converts pci-imx6.c to use
> dw_pcie_suspend_noirq()?

Oh! It is here,
https://lore.kernel.org/imx/20241126075702.4099164-9-hongxing.zhu@nxp.com/

I am not sure why still not merged yet. (Nov 26).

Can you help check "elimiated pci_fixup_addr() callback patches". I already
ping serial times. no one reply me. I think it is more important, so other
person can start clean up cpu_fixup_addr().
https://lore.kernel.org/imx/Z1i9uEGvsVACsF2r@lizhi-Precision-Tower-5810/

Frank
>
> This doesn't feel urgent yet since the commit log talks about i.MX8QM,
> but I can't make a connection between i.MX8QM and this patch.
>
> Bjorn


Return-Path: <linux-pci+bounces-41007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98472C53A7D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 18:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20294A3770
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12D343D8E;
	Wed, 12 Nov 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jbtlmFby"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2D34320C;
	Wed, 12 Nov 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966493; cv=fail; b=TeL6hNKuZ5Efg+dU1Nall1AkdS8+p0hHOg7P8vtJtrWrMt2cV07yWdnckUJjYCwJvym51DArQnoAO7qBs5puvEZsdf9+QPs6NfQQyU6pdtprEYOEF1bJaHMRAb99Ss+rHCfNtdRR3wXUBJl0yQdVj6YsYOPKDVBFxlWDHj7l9Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966493; c=relaxed/simple;
	bh=LYzHfN2lgxCg9l9cuz6BtE0tbp1vVr1LkSZGDYQu9P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WdhBWGJdhwoeBfuA3isS+w3loWURIZiQUefL3zoOoDTKl+JPWIKrbuNtu4cYYI5PfpBzpBZPx/X6uEBtCOWBt0CypEdF0XOaAViwjo49RwlknAtlUPdLFynpSAQsypmeV2pdcKOnYgzaUkdCLMAYEnEDtLdMAG2d3BM3HsZ6Fhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jbtlmFby; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVCZXmWWGImLI+fDLCxpOS9ntJaXjFkXRikBO4JUY0iLe1Db4Rh+nAK43IPAvucVUcZmty0gaXaISvGoMAED1w0Z8mqe0FvD0EcqPH9S6CZAH8OPtkyRU38W31Zt0WRNgQV2BD/13P18M2vHMT1XLOcqA8YApVhtNn2SGs86gm73lIXtY2/bWLRjKoZgDu/wnQfi4S6Q1sY5dmrCzk2l/7tJ+lA5+VHZrBG5aKK/yIT5SlulWUX1xeULk1JNondEGJnX9dBeFeE3+sQCohyGI23CkmJXW6FXbR4T64BVQ39rUBKwPfWJ7sZkJZNLXIt/bbpUavfvaXTmWYRWngH8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3td1LOofs20x94Bbq81CsWh6anojcHjZx9YqWR4u80=;
 b=AsfHJHA9aA4glDRRwoI0fub8thjzMDPakyqHYzHgCLaQ0r3CeRgrKLGJDYDd6562WMhvcaI3fopyiqdBdzvnR+ABdkIvz+tSf/VeU/NgB8Y8Z8RfEAI1Vo9c+neCRPtRkvhgM6JX05gEi+kk0OSumxLF1G6YMryYtJWFb7bXo30dl6OtSSt5/QOGJe4DQy6j7FiMkTvxx85/qG2zN0yAdyybBfS6BAzV4S1yU2OIknKeTzBqh3JyP/UT/I174i/p+77RHca/RLcQ9zaafo5aa+BGdva/H+JLu7tSHvyXELnASQuhcUT7WZghnkk8d+KZuIW8dzzLaRqpO/rn1Fpmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3td1LOofs20x94Bbq81CsWh6anojcHjZx9YqWR4u80=;
 b=jbtlmFby72odMmVzRXuCf0vLtcChdKeKx+4HlIUfi01WqUjUWPulebg0nHiOGgauAPkgRkmxaNEAdXK6tsXXZMl5wfC5mkwxx6ngG7zbq2bbCimKOuDLkXFIx+Bt7AOuNvhXiwQ+x3sfINE4k6/zwxQeaUYewn5hVhtd2WrYQhOmbR9PXd9ld9sqYkDhwEw9HZcaoUuhkZ8L93GYN4CDXGDOngLqEBCudHVMxUYdCr7xyLaaHV7pI5zaJbjSc0HdvPzmTuheRamFwZXxdZBz39+8auTcy0Cgoxw8KZt6mwpLnN5Q9BenUPfjJo1msnXP4RcA13K1tXN8XxgaPT82sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 16:54:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:54:45 +0000
Date: Wed, 12 Nov 2025 11:54:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <aRS7zZmo2WoW0DC1@lizhi-Precision-Tower-5810>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
X-ClientProxiedBy: PH0PR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:510:4::9) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: a498f77b-236b-46ee-637f-08de220c2e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llp20EJCh9XNOVo92RYcQsGU/9qUBPXoOW4Fi/eukm/goscZpX6jweaOs9eJ?=
 =?us-ascii?Q?NXq3ACOm5DgeoYDDR+/hq1L6ZPGyh+bvfaAWXE0qZ3UV9o5I6y/aG9EMgpwK?=
 =?us-ascii?Q?5HIN3CaDS1FO+H20/esWH7WkT6cg7uFX6DhtAMrpre80iY/X9z0UkCALGmk6?=
 =?us-ascii?Q?Q8bCvL2aUg3zYrNUbh4NcLXZ+gOw27fLt3gzOTWE7l69+kXQ7ZeaHPMOQ3o+?=
 =?us-ascii?Q?uYtI0mQtROkbwSgqqt8Rq3pA8mErVM72K1HgKA8kvuD6Pyj0jKPTfbwB510a?=
 =?us-ascii?Q?4FfKi6XxkxPcz/hXf3oYzk/4fHRXoyEBy1yPEwTXhcS+KosfliRizXOx4tPn?=
 =?us-ascii?Q?5O3dzh1yvgFpoj8lNqHLgpy9PDzO66yJuepQqJI4Q2q13lpG3lbtrXjdW6zk?=
 =?us-ascii?Q?BKRBP6xIPTyHTfM6iPcLVcS67Yxm7iqJK/7HIHQAG7ldWtVFR4fUc+AF0Jqz?=
 =?us-ascii?Q?MBzNoErF2pT+qshpf/WJEn2lVmiQkSTZIf59DSXlJVJXnSy3w5RA2HgyU5U6?=
 =?us-ascii?Q?euI7pkey2sIIzjZnP5jkK9bVtuj4Mvc51DGGuoMkwWrV7qSYjx8VNEZihzpq?=
 =?us-ascii?Q?26AAbyJRC36Zqyt2ib+IrIzA9yrXQ1GXfQq09DbW+SCabrBqSq34TxVUnysC?=
 =?us-ascii?Q?W3otUHAxdiplRF2/f9D5l+gAkimIMAQ4PY+cEwbJu5Dz4bjuVGHCT4Qt07pH?=
 =?us-ascii?Q?H6oD6vfWrEjn3YllKNNEgbdl2Q03kfooIKpvJm6S8bd2smrJNV/bnnhzvlbe?=
 =?us-ascii?Q?1BsNVPL5VuNTbfO41knCvhjebaf1nPrtGM5wIihLQ4EtIM8QfrvTE83Se0mo?=
 =?us-ascii?Q?3Xm2Kw5ovukrRbJTaQ//cpq6IO8uwAHmJNJ5Xj8NxH1aKPhXVOGKogDrJds4?=
 =?us-ascii?Q?BaAL7eBB6BNA1dIM7H2Dfbj1+2ngVichE6tsLfEAQu1fPhsJxGTbFVaYJ/P4?=
 =?us-ascii?Q?MrYhe72q8NnMAmBd8OovMizxsYVrfxejr/MRA20lV5hmA7aJB3dj/qFVysRy?=
 =?us-ascii?Q?0OieaOn922z2LkSlPU9Xo/KGevfGADbgFsACv74TqRLl4kF8b/N2g4xie634?=
 =?us-ascii?Q?5ozmzgG08bzkWCdGl0f5P9HnpbXxj1f6DmfOmlwZMVA3Ek8peoq7KbPSIB9g?=
 =?us-ascii?Q?leMHvKxkxLCnsSfunLv5Q7ZdF1J0CePs32OkKSM/bHYd5KmD3A1m2WXesII2?=
 =?us-ascii?Q?nfK5WNqUMBA9xpBi6iMYkGHGr1MHYPaBFYyVH4hbHouxcCrJCwzKP+yJQ0vU?=
 =?us-ascii?Q?jmXwHshiVcQBsT0962aVZjyw60W1bo8EHOzqCaO/TaZwRo/qEo9xJwYuGtdC?=
 =?us-ascii?Q?bU9q5aoPITXh/DP3Ct6Ru5OeuOMlxfpO4usrI4/Jl64b3Yn3Rp4cVobmKPS+?=
 =?us-ascii?Q?TPTeUsPKLfMZmvAsVXvxABSK0TmAkYfw6HtilpV8Pg796eDnWHlvk0GrLkGo?=
 =?us-ascii?Q?Ckrx8sxKRc5XK4iooMkkbK9Z3QYzC6drAQGBB+L0DtJ1XngOrXixDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WkOGWx84a/qqHKN1ULZ8W0X4/50mhn/xa2BS5Hv+mRrFt6bLow/a5AFyLfJt?=
 =?us-ascii?Q?q6ygPahd4C+THtotm2dZOUXkMEqJ8sj990aAcTq7nsyiNL64JEPsYlfyuFy6?=
 =?us-ascii?Q?KuZl7ROdTrkIOU3i0L2X9OA1zdUwBW8ms5wbdEg4BHaZXdicNPc+vZR0/pVp?=
 =?us-ascii?Q?1p8C5mDTAa+QBUUOOUXT88X4q2IJAvBrb4UFJQXSjhp96St9gP06NyWVsPC1?=
 =?us-ascii?Q?2grCiQnrso4T7bBfqSHEiAcGJMTv4OrQfpBv0tNORN6u4mDSj70So+UafvPT?=
 =?us-ascii?Q?Zv3qxkTqrqgRhdyfDDJ9bozWF2qi4xssSMrkCe+LqSGumfBnJY9JZOpVdGue?=
 =?us-ascii?Q?XA7oiBxndodiTNSptyNUeBt81LmPxRC3FkLiSVr7z3V8c2RV1djgbSUK377Z?=
 =?us-ascii?Q?mokzQFqUTjgaN4/iaSF+G0HOgDVhPERqgHPLtkY1syTT+6tq7zPQtZGSkwbt?=
 =?us-ascii?Q?atjeocEuEauU+xLmcqWtkmcl8ssWy3SGhjWyE99mBC6KOuFNqDXGsP/moBjn?=
 =?us-ascii?Q?mqrPlrIn+9pSE1FfdEguW5WBWNAy//B4KmhVpsBK7tFs2k1brpICfS8xU3n1?=
 =?us-ascii?Q?Tk4q+/yaxdDCVJHnxApu6upWtVTdYENETsARoLmgH6oTPvPPEKD4I/9Sf0Cf?=
 =?us-ascii?Q?0leNIOpEdbK0f6zN7NuzSHgt3Q44B6MD/o4upkeXlvOBqjDfiW/cyBtG/G2t?=
 =?us-ascii?Q?WATG7/c40QaXNhPyzyXLafHVsqGZXkB1PB05zH09/XL6tPQu1ST416i1Pdbx?=
 =?us-ascii?Q?bkNDmLNna1+EX9hQHs/5uwHSECu7ZuiHHhCHEKS0nPqexTcoC1Wllauovd2C?=
 =?us-ascii?Q?lLq7HzvW4MgvET1kF6t0Ism9xfJy6RqL+8qWZXP+YwQm92AjptAwM6Xj1ETi?=
 =?us-ascii?Q?WT3kjHiLo8k96f12Jl6rJkk5MKpyZPwN5vmTmemvoBIBp9O464WGvOMhL+Cf?=
 =?us-ascii?Q?yfxf0wS+lz9Qi0JEbXjtR2RuMTo736WMsHUYSHWUGv8L6TYZXzjr7/NQ3j1o?=
 =?us-ascii?Q?I5znWK5ueMgFj2VRTF3pvslGpepR/oxCepRF5wj/PhMo2mWkGwwIKZ9rdQaZ?=
 =?us-ascii?Q?KUcYWyViSyAgmY0MONLrmVGwpcpLb4omy4N4fPo+FoDvvUCNbpxUbQT0O97k?=
 =?us-ascii?Q?/x/5xPVqvgesAhrnqCfeS8XN/TsWOsqb/sZ0Dx25DsYT15ob5o1EJgqPLQ3v?=
 =?us-ascii?Q?qeb1GcBMSwnE8zifDh5+b8WZx3P5rUnV374D+ibmpBA2Vf3SmbYJ6/LTU+kd?=
 =?us-ascii?Q?JyaG/WCZW3Cvswn9JtAQ2QN9g71wtN7mXWSFYzqm0tbJa5EKoC10L2p6/8gT?=
 =?us-ascii?Q?VEn7z7wI0YPuGg+8Ienx4GT1b6LrVtZnvUxOFRlFdj2Ezt6fV1A4Z8uG5xt8?=
 =?us-ascii?Q?TmlcYklad0N7/RqGKHXhxCBcjxmp8A2VIZKNbppMmnct31HPLQ1L7En23XnP?=
 =?us-ascii?Q?jOtXkrjsbUAC0tM35iHGrKD0A0RP2CSNdYJiuY2yTrq9fRKqiVqnaRZsZj6l?=
 =?us-ascii?Q?DT6D/kVCHGrGsC4N2rF5wVnVNiatMFrITJ+y/6dL14QPPMrHro9UrSvFZ+cB?=
 =?us-ascii?Q?6lTY6PCW7pLzlxexlCU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a498f77b-236b-46ee-637f-08de220c2e57
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:54:45.0671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Tms73zmctYz4hGETqT1okFvvMuZxe+1ydGdJ5I+pMSQnV0OM4Uefcmzw5Az4tgLBAAiVawRsrMk6H2Hx/bw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369

On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> provides interfaces like PCIe and SATA to attach the Solid State Drives
> (SSDs) to the host machine along with additional interfaces like USB, and
> SMB for debugging and supplementary features. At any point of time, the
> connector can only support either PCIe or SATA as the primary host
> interface.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key M Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> +  host system over PCIe/SATA interfaces. These connectors also offer optional
> +  interfaces like USB, SMB.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-m-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vio1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Since a single connector can have multiple interfaces, every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCIe/SATA interface
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB interface
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: SMB interface
> +
> +    required:
> +      - port@0
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> +      more details.
> +    maxItems: 1
> +
> +  pedet-gpios:
> +    description: GPIO controlled connection to PEDET signal. This signal is used
> +      by the host systems to determine the communication protocol that the M.2
> +      card uses; SATA signaling (low) or PCIe signaling (high). Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.3.4.2 for more details.
> +    maxItems: 1
> +
> +  led1-gpios:
> +    description: GPIO controlled connection to LED_1# signal. This signal is
> +      used by the M.2 card to indicate the card status via the system mounted
> +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> +      details.
> +    maxItems: 1
> +
> +  viocfg-gpios:
> +    description: GPIO controlled connection to IO voltage configuration
> +      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
> +      host system that the card supports an independent IO voltage domain for
> +      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
> +      3.1.15.1 for more details.
> +    maxItems: 1
> +
> +  pwrdis-gpios:
> +    description: GPIO controlled connection to Power Disable (PWRDIS) signal.
> +      This signal is used by the host system to disable power on the M.2 card.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
> +    maxItems: 1
> +
> +  pln-gpios:
> +    description: GPIO controlled connection to Power Loss Notification (PLN#)
> +      signal. This signal is use to notify the M.2 card by the host system that
> +      the power loss event is expected to occur. Refer, PCI Express M.2
> +      Specification r4.0, sec 3.2.17.1 for more details.
> +    maxItems: 1
> +
> +  plas3-gpios:
> +    description: GPIO controlled connection to Power Loss Acknowledge (PLA_S3#)
> +      signal. This signal is used by the M.2 card to notify the host system, the
> +      status of the M.2 card's preparation for power loss.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key M connector for SSDs with PCIe interface
> +  - |
> +    connector {
> +        compatible = "pcie-m2-m-connector";
> +        vpcie3v3-supply = <&vreg_nvme>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                endpoint {
> +                    remote-endpoint = <&pcie6_port0_ep>;
> +                };
> +            };
> +        };
> +    };
>
> --
> 2.48.1
>


Return-Path: <linux-pci+bounces-20344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC9A1B9D8
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 17:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449B41658B4
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC415688C;
	Fri, 24 Jan 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CqQHUrYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C2182D2;
	Fri, 24 Jan 2025 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734499; cv=fail; b=k9gpOtifxtk7n2ZBKYlXfw8NHGjpa2mNFzsPXO/SEYzC6SzfAIF6UxhZaZ60HDJLy7ZibRpX3sWv+u+ZmCOrg2+fpN36VqzyRpq5CvR0NK48H9++wfRvp/dkov/x/rw1rEDDKts/SnZNrQangiwY9pqQiGDCjVyaa6XjLcKkd/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734499; c=relaxed/simple;
	bh=XsMDVsyfoDCbVVfVMYbJZZB80b5B6DVSqB5T8SUGZCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZDME0AdLDQzIRmfwu0cUmde4K0LtxrFRvsAcl7Q+rJeLdObRC8r8ObMzSiA452gokmX+/x8Zvkq1WV29GPujgsuuEsFtiuLDx7axTnM0vkvj5Ry4VMimXxjH1XN5+sKZvXuD33cb4mV8npa5SXAJIFquAb0IiYR1TyhEBHiPuTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CqQHUrYN; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hjr13ajMfKOIcLQxXxUjVLG8rYw3blH1GLHVhh8ep0rDPdp8cpvUffnY0cspH4j939sRI+pK5KkjJcwFKXzqNIob+y9a3Exmp5FDbkQbv4038EVoM0TX5x/9wY9xXNzJkvQiaLAkVxmpG6sOGJ1qQ39dVK+2kOPWDnNbHWXSwMznDDbEqT8KfuYSJ9RsLRghDAJyqbx5MQui6zRiluqoBaRK1VGyNOlDByCBNG/dQoSe6h6zDjpH3D77L3VIrVfESO1MzbQ+a8ysLAsGP+9NeG8soTxcIpuQcno0ecJZVp5u/WRiN7S+Rq5wNRIySRbIJ5O7aF3c4ZqoPGRgQIVmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynv0cAABxcCZIJJNxbGP2obHtqPLVOkEf6nt6fDap9E=;
 b=Ji1qnKRVnvQmdht6a+BU5RAHvuJYee77ezfhWL5742AprUkWSER70cvwExmJly6PcXSE6vP/1s2XgRMnfISs4Gtq7IyMiN55COXhinkURYdlfrKoodCmjSxtslQH6KkurBXm+IBPUUeNmMSGq/vwC0lok2A5sFAhWncK6Pl4pPUtOL5YrF4V3BM0rr5mkdlvflRGcW2JJJP0cZAEq6yYYIEAN25daeij9rdJleNC6NMTpHl1PM9agHz6NwW6pafmF3UA05lHESpzs3qp4u0LEPfzXLo8ygoQ5krpHKcJvljTYQpBgFHGM+T8I6RoBhLaz2BQcB9ciey/Ng/R270kBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynv0cAABxcCZIJJNxbGP2obHtqPLVOkEf6nt6fDap9E=;
 b=CqQHUrYNy/q2R0jlTuqVpF7tAI49zuP9CChdo0K484PHKuPhaeRuhbGSOAz1cvIQ3Oifm1QM+clL1vKjG+4t0/2poz/PWy3qycvxYBxrH8wybJqd/Ivy2hQdwxDPAKdodO89NOnYBUp+lOQWHtzskw88nBNvcK1VImJSVLIndw7ExIn4Ad5Z37DetmE1FF+qlKdZZ636NKazPDzArWbn8T3FpYnF4xbCRJlHPUnrLYcxeBFON8IRji60JCk/XvmAnxP1xxMEyQ0kO3C64W8UMcVr7OaVzqIELFZvDoelCaeHrM4u41mwAnro5+MGVkK4Ghx+DYdFlYI4k+nfYT4yLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8626.eurprd04.prod.outlook.com (2603:10a6:20b:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 16:01:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 16:01:33 +0000
Date: Fri, 24 Jan 2025 11:01:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [PATCH] PCI: dwc: Add the sysfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <Z5O5VsMLYE9R+loz@lizhi-Precision-Tower-5810>
References: <20250123071326.1810751-1-18255117159@163.com>
 <Z5JrXsDDM2IManp+@lizhi-Precision-Tower-5810>
 <54428aa3-2178-45d0-83d3-0b6254347bb5@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54428aa3-2178-45d0-83d3-0b6254347bb5@163.com>
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8626:EE_
X-MS-Office365-Filtering-Correlation-Id: b0277388-145c-4bf9-2e75-08dd3c905fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l75+rxdSj6de66TEjfyhozyAZvfrmhCbE9NIka7sYKSPDUMN4GguKS5Vfs3h?=
 =?us-ascii?Q?ipPex4PtYUWOvGo/arUuCMVUVJ7cuN9vD9FfuL/e0JX3B5JArxj4lkUI0s6m?=
 =?us-ascii?Q?udMQnkNtovdPVJsANa73AH+0kU/ymM1alrHuPDsGi7oSB+YE7b4U177nsMND?=
 =?us-ascii?Q?uc6UeuNO7QaHLr+o5XOn+t632G56Fm24waJZmDb1CawXd5WDMUfrmpGGVp+7?=
 =?us-ascii?Q?UgKpxcs+jS4ZLE/Wu+R22BOhptpPKE5jxxgLO4IJyh+aIi/GaiJL94VgsOcO?=
 =?us-ascii?Q?hKJchbvNyiaMGEchamNVgk87vX5O5VJesz8sawQ9x5a5IfV/s96HPRsGDuDy?=
 =?us-ascii?Q?u2KHdBH8cSGeFj+rXA8eqs0s3DzVqZTt7RzipXUCslhxUy+RXanhGzb9NC9e?=
 =?us-ascii?Q?5w8sOWhJT4jLXKBS44d391q3Z6A/ZCARXQ3ECwPdDem62e75Lhsz2lturW+k?=
 =?us-ascii?Q?Mam2a2wtSBuLB3JwkuCgZRp/uTMFSnjo2WePbDxCfUC+J1NTf8pV/YmDsENc?=
 =?us-ascii?Q?HiLT4wZ4p4jZAYFowe3odnzn7TQEJ9DzuTenU2xLte/FHswnpSV06slsyWWW?=
 =?us-ascii?Q?XqYHTQ+DFvWF4XaDGjocRwOMBGsOTDaSTzO8eLCgRNv5QwRGjBGoYZsDLR56?=
 =?us-ascii?Q?4ki7iprPWoBW1DG/aow/3kZW9Unmw/m8LPa+yGXWZQjY+NB93Os0JwMEIulr?=
 =?us-ascii?Q?SYOLLq6VwfSjursdR2/yWrdCCNrRwwnZUCj1fy0b3jrLowTDl2OAHtcN1CN8?=
 =?us-ascii?Q?FSE7fEQQQ2ndM4tPsUb7uFSwFIUEGgCxh7xpE8bId/JUdKTOV4LbK5C3NSli?=
 =?us-ascii?Q?zdGgp4z8gyTVET2C2W47WrBzbyzcvwoFIhqaqylpSI38hp+m5Tzv4y7CGVzO?=
 =?us-ascii?Q?ALYolEjSPD6qzJroRs6MMm4nntixk+uIph9hEKBO2xAf3YMkhyk9zYfmbxCk?=
 =?us-ascii?Q?z1sWXZ3LFi4XzvyiOpEbBINXZV0vIWtzRXyXTZ6L9c/s5nbA2S2p5SP3XEOx?=
 =?us-ascii?Q?lptfYG78B0RLsw/d7B7PFJy+Hz0MMZ5RGJh7p5ENtKuetDLZZqnR3R4rfUDs?=
 =?us-ascii?Q?Ux3QtZmgOQaqV01y/42/ziDBkQFtG7CL3XrTljwqfumMwNc64ykgVazmUp/C?=
 =?us-ascii?Q?+A7y1iQLmM1+Lfbvn0kDmvV4+1d63d7VAlKJ6wPYBCv5wcF0ij9IYJ597cNW?=
 =?us-ascii?Q?hMltVs0lytcym5V95/yAc2s734DbfXIhL3d1moJ8OydNy8FSWOpOu0Xbr8ms?=
 =?us-ascii?Q?O/Jf7/yvCxgug+lMtMLD4B3NxOffjSSySPELasif6BBR6bIPPAEuffAV3Mdv?=
 =?us-ascii?Q?Uds8KWzaNbwqc5tYFM2RIRMb/NIBaY05BTYH9lltZTcQAMU4Pz3wYFKLXcfn?=
 =?us-ascii?Q?5u9P+vo/M5+IfwjpoD3m/p9l1CVO67dUPyZYwPgQICPOFrVBU4YrDLboCJ30?=
 =?us-ascii?Q?06AOFjpnzkgI2Xm0t7yBMTkR4E16mkaV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4b9SRLmEiXuzuz0sXybhzToNI7OXJHWjrMEidz9hIjYxi99boVxSAyFn6XIg?=
 =?us-ascii?Q?jWpana6m+SB9tsP/X9nG0Ho6CET18KJtje8v1l55OltLUw7qzcSddupRpW7O?=
 =?us-ascii?Q?uU2+0wD4FUX4AySEy0ijT9cejxSHBPyXccgOL1D8rvRbIGGsLro717NH8Ahj?=
 =?us-ascii?Q?mMEdvcYvV2Nh25tx1oJzU3w6Vr52SF/YsdZUnZSW9Hib4wDz7nglGjnDFQXm?=
 =?us-ascii?Q?uLDZcjZAel/brLIGR0Gq4sgioXrB191FbaoyX6UPRMHMhyEbKBhvg135zsCR?=
 =?us-ascii?Q?mAzcZqDcbvaMR7/WS/blVySFswjJuO2AVvFFgL4gTshCFqU8DDH/W1D/C8qQ?=
 =?us-ascii?Q?f5CnDuyJaX84dmGvu8OfaF/dQJobWmiCq4dBHPDwa159PBCTdkZgtHohQs43?=
 =?us-ascii?Q?gucjBZoii4YyTwQJnm22g+6A3Jww1+rYKJHysQqcgnbiBmKZLZ9DBo2hc6f2?=
 =?us-ascii?Q?QH+GMQVmmI1sxZKWnI0j4azVT3Zd9DstmrwFxhrf32l0PWojnZnsY0hutX/L?=
 =?us-ascii?Q?Pj7wIhkwdBsvNgKYKMtuYSGzCn0Pb/C2CtE/uNTVzhxUbs8XGRods+60iuPY?=
 =?us-ascii?Q?XL7grukOBQk5pp4Np2ECO8dJ1obx5MVybvPSvzW6Dxf96hq1mw5mMXuof+Cp?=
 =?us-ascii?Q?SQPZN8zZNFDXdOa6ifgeXDGwo1iztkOwIh8QuBkfp/Twhv+2J1e0G/sC6n+E?=
 =?us-ascii?Q?qHEfrTvsxbs1X18vAhjsoJDuHuewXxdiB71TxHSFZKAn345GXCSHf8mGW+cw?=
 =?us-ascii?Q?f9wfct3IhjoUgcuFwTx9qFfmlxQqRgq0AV3nRW+dluvF9g2fayu9do8vMnYy?=
 =?us-ascii?Q?z8Ler9Geif/j+n+EnxMnhLeHTyxSvfNQKvBCiJR/EBt2L5MSGspsD/KZHdxq?=
 =?us-ascii?Q?Vbk4gIkbwUVjSPlAkzlLLSIyUVIkQcjY1SD6DbG/Ora+Tb9psrTyQNgI8bBp?=
 =?us-ascii?Q?Nc7FJNYcQbmIYCsyENx5ox2SRfWj7GBsTmUeJhv06xVAWvh/qGcSldP0clcE?=
 =?us-ascii?Q?tqPgJ2ab6FkG+MtuZylbVYUwXPULUz9/ZM7ujb6cirMFpCcvXGfMlbYzV86e?=
 =?us-ascii?Q?yLABRz6tsx7JDzcQZNFzWiB3xX0+sQ3Hd14H2hPS/EfGWOrxSPzPztB64MfT?=
 =?us-ascii?Q?+irlx1EhwTtErAor9qoD558FFan+c6yZh4/yydAGKxhEc/ixKV8Nnq8IjpIT?=
 =?us-ascii?Q?CwOnk7u8LlGjEeb+qoeI9vc9wISMPnLITnWIEvXuhxOYZqgw4mOHjPRURD4Y?=
 =?us-ascii?Q?INZx6DTLu7jN2UNUGXC5FLU6eQT1IpVmKRhcYeH3nPGNxq28Lo6I7agv17i6?=
 =?us-ascii?Q?lZENIU0X5S3+pj8xm0sIuQtBxAXUUqdp9g3Y7F6j1K7te6juafV5iK4wscsq?=
 =?us-ascii?Q?X8w3JzG7IgLDDNuVm+N0CzTEwapAFCArw5h25eyHJePqiVvtnpK2fB0EVxH/?=
 =?us-ascii?Q?p6HC+uXz8W0FMLDkaJfZHu0cxQe2OBvp9rEQW0XirgAxV5yvm02C6uGSepiW?=
 =?us-ascii?Q?Qljiv1n9A7wv8Xn8+Gfa6YOhMAMG2omstuHyYmobY8MrZYfWimJjGmon8wdd?=
 =?us-ascii?Q?6bavZgvt+mJU+KK5ZhI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0277388-145c-4bf9-2e75-08dd3c905fd7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 16:01:33.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc/05J+YMedkjHKmunadVJMPr9P54kPmSh2Ah9cUZPx9eV8z2pqcXF/PgK0u4g8P4TbS16go+ShyeHyIDiJspg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8626

On Fri, Jan 24, 2025 at 09:12:49PM +0800, Hans Zhang wrote:
>
>
> On 2025/1/24 00:16, Frank Li wrote:
> > > +static char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)
> > > +{
> > > +	char *str;
> > > +
> > > +	switch (ltssm) {
> > > +#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
> > > +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
> > > +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
> > > +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
> > > +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
> > > +	...
> > > +	default:
> > > +		str = "DW_PCIE_LTSSM_UNKNOWN";
> > > +		break;
> >
> > I prefer
> > const char * str[] =
> > {
> > 	"detect_quitet",
> > 	"detect_act",
> > 	...
> > }
> >
> > 	return str[ltssm];
> >
> > Or
> > 	#define DW_PCIE_LTSSM_NAME(n) case n: return #n;
> > 	...
> > 	default:
> > 		return "DW_PCIE_LTSSM_UNKNOWN";
> Hi Frank,
>
> I considered the two methods you mentioned before I submitted this patch.
>
> The first, I think, will increase the memory overhead.
>
> +static const char * const dw_pcie_ltssm_str[] = {
> +	[DW_PCIE_LTSSM_DETECT_QUIET] = "DETECT_QUIET",
> +	[DW_PCIE_LTSSM_DETECT_ACT] = "DETECT_ACT",
> +	[DW_PCIE_LTSSM_POLL_ACTIVE] = "POLL_ACTIVE",
> +	[DW_PCIE_LTSSM_POLL_COMPLIANCE] = "POLL_COMPLIANCE",
> 	...
>
>
> The second, ./scripts/checkpatch.pl checks will have a warning
>
> WARNING: Macros with flow control statements should be avoided
> #121: FILE: drivers/pci/controller/dwc/pcie-designware.h:329:
> +#define DW_PCIE_LTSSM_NAME(n) case n: return #n
>

Okay, it is not big deal
can you return
	str + strlen("DW_PCIE_LTSSM_");

Or trim useless "DW_PCIE_LTSSM_" information.

Frank

>
> > > +static ssize_t ltssm_status_show(struct device *dev,
> > > +				 struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> > > +	struct dw_pcie_rp *pp = bridge->sysdata;
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +
> > > +	return sysfs_emit(buf, "%s\n",
> > > +			  dw_ltssm_sts_string(dw_pcie_get_ltssm(pci)));
> >
> > Suggest dump raw value also
> >
> > val = dw_pcie_get_ltssm(pci);
> > return sysfs_emit(buf, "%s (0x%02x)\n",
> > 		  dw_ltssm_sts_string(val), val);
>
> Thanks, i think it's a good idea.
>
> Best regards
> Hans
>


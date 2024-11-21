Return-Path: <linux-pci+bounces-17179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3997E9D5374
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 20:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EE01F2322E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3714C5BD;
	Thu, 21 Nov 2024 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nc8RyoYo"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9743ACB
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732217953; cv=fail; b=CUlUhcBb2ipYXxe2jBt4MA1dQayw0EaEo7hfgzXzyM8N9uiWldohsykUSFQ8+CLcH8TwnWPFeQtZ030XYkJZTNRPqu5xM3w98SXlSnyyRPoweik1jZGgP05lSVtbKtUMIhWwI5FLEEYoKMFsaoIyEGkVDw9A18rOeUmT7vHEggU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732217953; c=relaxed/simple;
	bh=5bmu5PisW8lIHe94AVNaaKDAqBYIgkpRIkS/wwzG048=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h9kgTwzks7C+5sLCRAu6hWd1P45QX9E+Malg93uvRbnFmT9Y01crB435Uqyr73Eo/TbYMhUyRBqzfFLMNLHtVZMq5D0WLkkq93gfajvIgNfLwViTmKnv89nnDsMWgKyd8QvuU85RZoKetQ1DuWjmjALJ45vH84U4NeLGhHrHEhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nc8RyoYo; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6DSDxQFU/D/2LcKkUcd4ujFSjb4ike1/RKHo5lrssSZC15AXhoi4fRoMiYUwK/+ddu9iFVl7awT64CVJouap2bVfFzqWjQkoP14YeloM0KyCZz/GEKU+GlXDTUcLhU1CHp/2vRdz06WEhag18caa1wawzkcvZaix80AMSACRRso9WxAs9ElN4etDy7QXDhCeK2Bz2LlTXce2IX1GM7HKm9vwsPHBO7YBA5yC/hOwjDOFkHN/iH1qcGBL95VfJKSQD4PDhR/QBk4/f9BOFe41HoCnZXRW4YRODyYOxvCGtgmd8EWCZBQfYtd1T/Lejo8b3akGi41wASz9GaOmH35Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvxCAAwA1ics8gQAWEUUeext3khSBYLJVt9Nt81ixDg=;
 b=UanuNpJmYDxO2IaEY1TXknMGN9kPKMnZB4V3is01PUBq8jxQoAZsSdfJlNzQjPAEyoO6rqqfgpev5w4IygLqfVZdK+v7Bo1+NygYcfjHqFk8NXpCwBlDGC7QQj/7CVZVQnlGCgSqJp5bjQEObN4MZT+CVimIqeb2wtjlIuc6ghh5amm7omomPGJM+ofuWZNVl9PTneGAuyU9EeeXEp/wPUCtfWilK2QXliVxAQxaKiFhzph8Tcj44Rqsb5k9j8/rDvp8nBcSD+C6e8PObMG4kRtU2MjhCjWipPulIo3Z95fQjq9xYpMR3yeJheK6rYXwzns4P1DqrVAvQCcrrdYZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvxCAAwA1ics8gQAWEUUeext3khSBYLJVt9Nt81ixDg=;
 b=nc8RyoYopONTqockJbq3wjSTjRwSGtRKnTa5qZEauIjJdCEj7KBUX4zNtgDLksMiYgW7uHIBsisBD+F2OaXI3qGLWjfATkOqzmd/MTXpcTBkNlK2M9RRkllO8MZvqEKroWXibhtnJ/qevK9YRelNGv7f5Wr4ZwNOp6z+yeIuJC4JKbSsLfIUpfMtZrftOvsv9CWKUUJ6Ww3tjMLyOGDH0X8Y4Ya2tf506iy63JdqRfergJnWTrMM/S0UNCGU0iBjSiYdU4ER9FoFs1CG1oPS3dsuT1WHQxtCShizVx6LkOi+laxGJsPxs3jmeCirGB0KnmLhVt5ZTiyIvEMGbUPt3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 19:39:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Thu, 21 Nov 2024
 19:39:06 +0000
Date: Thu, 21 Nov 2024 14:38:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <Zz+MUSqb+GfutIIm@lizhi-Precision-Tower-5810>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-5-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121152318.2888179-5-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dec297-7ce4-4c66-b90b-08dd0a6428f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uYI+flJ43tIpg6fZQYD551qVECIQgNbTyeT4lW6tPPROO3iAWLXy50yHSvHW?=
 =?us-ascii?Q?BU4prw+aMCPaFKkRM0AuQ22xndqIhqnfdNvcoSpzCuJ5uYVmvmLiQEMpcyjO?=
 =?us-ascii?Q?2Yu+Heq3rExu4yJ6fXjvcIf3MVOt858IMPgqTFD2NrdEr6bsK+ZAaZyJ1ICG?=
 =?us-ascii?Q?rtAqUD35lPlJbiK4OnAbqjIaCLVr3v9vvrsMe2craF2fEDlWRdNtxII3dQyU?=
 =?us-ascii?Q?U4leIL1Kbk/5VsV9hyqT3OVooEhaIomhceZzfTbh4Rp62UDwuIjWKevE96os?=
 =?us-ascii?Q?L7TVfkIObq2eT+8pwCOY5s4MQ/U9I3zpcBGDYnjnl9W7Ny+A8a5RMXn1rKlc?=
 =?us-ascii?Q?AYJUWWcdIDSk/7Jsrv5JOvguIACGPQGqE8QCpMz3j42JyxqPtcl2+YB/7Ucn?=
 =?us-ascii?Q?Y2e+cP4Au+cOlZQlBgUT1UWLhBAXdMte9Z+eOggzA8UbbgOg1tMLsavZG23z?=
 =?us-ascii?Q?Mpp1Tge5IOtabNQ1Ym8qJnt7Ii1kLEwt/ibfKC82F3zSsjTKGPboeBoS8+g1?=
 =?us-ascii?Q?DY+lo5/QcsFond/npj0V10IEWE6aeERLL69evSsWcYNRHmKA8xsz+I1wFSUw?=
 =?us-ascii?Q?8iyj5CeOYcu/lwcx89r6Sde4gYu++l4Noy/xrGH72IQeKYYIOSWCYdO/E9/8?=
 =?us-ascii?Q?lz8T1xO5HHUwdaGpqzj++dwRVdzfaNsFERhfnRPgG16ZmEalSXz+5VwBJKaf?=
 =?us-ascii?Q?iHcWX9iFWOfVNQeYUASBSTGULlA6ZGiRa9FVqlOZVVLHlcfOgWbyAFziVXWH?=
 =?us-ascii?Q?gVf83uU9s+JTlx0IUOTVJMFzDFcHxAGEG4nF2BJMlKtOJfasJQxD3V4eZLmc?=
 =?us-ascii?Q?ygwiYLX/9zP3uwtGcOlZGGr4V9i2sf6fILFWH+DINLJNkXTjAkOLqALhsYmM?=
 =?us-ascii?Q?y+HKR1rNFfxR/8E4nQyxrLut8GVNo75sL+rcxGZwSwViNRbiwdNSuV6JH25l?=
 =?us-ascii?Q?roddvlBKLnWx/sBpvpwXYJm3AlL1VLVwTUo3nVcglcVv3v2C/yle5I7+GS1i?=
 =?us-ascii?Q?ShkuJMfqNiQYdVHygoSuIN3WdLyeZdgnilrp6FPwHR7ooJaWz3oFNQhQ01UR?=
 =?us-ascii?Q?EPf9e4BZa+SJtbF2RG7rl3zRaEbpxoUyqu/0GVNuIVc1nSiuS7Ws1jvmnzuI?=
 =?us-ascii?Q?GfvsRkwZeUwH1Qi9x8gFWNyrthjoVlOSgEBk304PdyiVQjzuJlpTEZJ4qLDw?=
 =?us-ascii?Q?KWG4olJ0/ZfXZtw5DY4c5/wp4nCrbB59YtnzQ25zi+Dd8gATLi9YKLeqhFYn?=
 =?us-ascii?Q?fBba4PhxrCyI9yPWI2MA/flB08xw2X3ayqScTuFQG+2R2qzprnhVj9F075qG?=
 =?us-ascii?Q?f8L3djnw61KN7T/oQ4IS6Cs0s9toXiizugXjZhrkT7oRiEzPfc1BWYAe8Wji?=
 =?us-ascii?Q?FDBMOr8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p7awUnC7I9zpCgMKDS9XPYycrNi3ujHqM6SXy4fLhX/70GjKyI3fKlruPC8l?=
 =?us-ascii?Q?9F1Y+B3IA9lmoOmKQwv2iwqXmurXXzoBdT1biVOC6Lk0qe7EqhEUszGvXqss?=
 =?us-ascii?Q?XOaMkxUK+y6jFETHOEwL+XOrYmCSU13Fxa2kXE+WVQh55H1ff7d7LVjIq4Yu?=
 =?us-ascii?Q?MOmjJsdVqf6YGpWlcr7XF7N5CEgPHzPIfhHK5y1nsRdHHwQj4pbu0QhFfv8n?=
 =?us-ascii?Q?Mrn4iafdic7l5QgF1Q4/mgf81fPSo9QrBs1Kg+Xs8gPnAsbod/oQE95otmjD?=
 =?us-ascii?Q?utFJmk8lsodnlqrz0F+pwV1++BIuaZFMEP77MEd7NNV1cny11lJr6UeMDcDl?=
 =?us-ascii?Q?3qiGJYfjYURpWQqUXlm7vORvsJUXEAvKKn77OReYVugv34vyNUa49pHVrLm+?=
 =?us-ascii?Q?H6k6mTJLQbkzsyFkfK6byYnl/aYw5jAosterUayxDwpvpCsk0BPGbDtM05Hk?=
 =?us-ascii?Q?WOWYf/AZk856Y49RHNPweFy/lR88Dbq8NrnPZ2EMjpIqPpGMT9SvFLTa8ENb?=
 =?us-ascii?Q?x4gwAz0rvpxgi2Fo4dUZAdoU+jTTAxUyQLXTIdDfaOToUABuYlZFVMQqNdQw?=
 =?us-ascii?Q?lJWlIGMXsXWcYRFhe3rgdPog9oeQTsMX14vVSzMrfI7H9UrR90rl8iaFvj7M?=
 =?us-ascii?Q?H2kPhODyIZABSYfF12Bvx8SSCkvFNR/0Xfb88YINhdkQT3k6pvQeuLtfWexV?=
 =?us-ascii?Q?b2QSjhQP3vJLt2+LKdDZjSndzr6fepAqv6a4MKDnB/5kTZon4cVnx3dw3nQ8?=
 =?us-ascii?Q?NBc6wMplfiwq7vcYeDVpm2W2XLNUkPTYsrDmJS6vItisR+3pC3t/JpZtFb3W?=
 =?us-ascii?Q?2z4QM5vHBVhHVqomyOYsfj0EvFkkaPx56VlTQzwJKj/nG9IfSw5Wi67RIcvy?=
 =?us-ascii?Q?MuG/p7iRAH9iacMi0H9mp99iiZcWti8RK6L7CdWOvIzmQw0EN8NzMTmmfsue?=
 =?us-ascii?Q?BWsgO7ZeDHwTVRqqT1jX09gpYEC5iQ1WoWHdubmpxO8+ThIaNeSknFYW0IBg?=
 =?us-ascii?Q?fNiDbS3xq59sv58D6rUrFNwZJNTvQ2/AASRWKbZSGUb3M1q1Oz0azuXUCopz?=
 =?us-ascii?Q?YGvwCqi4fdcvg5rMf+XyAxaFJA7INsh+4jgDDQkI72SJ6gn/gSTdAESpxaFS?=
 =?us-ascii?Q?mWVgHwUzS67ElyPX/rPw6Sax8T/604/M3Uv4fRPpetnOJgoXR6CH43ZHcpnz?=
 =?us-ascii?Q?AdF8xPdU1lnN+sYTq00PVwWpQJQCsYB0UxwdbCKC7kGcVN+KWJNK9b4FHbS3?=
 =?us-ascii?Q?BODWo8NH4+hvHxxmP9ZilqYTJCb1xpshgaQDx5unyKWv9VsHvGla7hd5CnTM?=
 =?us-ascii?Q?c345eyOHH2noces3WzaXYIlSZgZuKkDzViyGv0ixv1WzS07Fs6fq/rGrLqfF?=
 =?us-ascii?Q?t8FKqV7RhO4LAhp1oM5CHQ9LLrl0IOjPYOZm1c4iXhWDlzYQH+XXTfkNwQtU?=
 =?us-ascii?Q?+Aph+CwFOnlN+YgwhmrsDEz7rywSPO+19vhPfsZyhgX+KkCPIsThPF29mLBF?=
 =?us-ascii?Q?mtPLLIMG9sLJRHSLRgE5kYVgKGdAiHseFv0E2XDfMW3mOKoPHDontpz0xcfV?=
 =?us-ascii?Q?4M0AwpdA62XUCU+W44ZcDIdx/X9V4+EG5kBIYlG8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dec297-7ce4-4c66-b90b-08dd0a6428f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 19:39:05.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMrpHZCXhOqq2qQV1Aalai83jkxl7eBkfMVQVeqLxJ07+5OhEnGASlJcXLscvBfSkF9KT40pI/4FfrDPSY2A4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

On Thu, Nov 21, 2024 at 04:23:20PM +0100, Niklas Cassel wrote:
> The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> which allocates the backing memory using dma_alloc_coherent(), which will
> return zeroed memory regardless of __GFP_ZERO was set or not.
>
> This means that running a new version of pci-endpoint-test.c (host side)
> with an old version of pci-epf-test.c (EP side) will not see any
> capabilities being set (as intended), so this is backwards compatible.
>
> Additionally, the EP side always allocates at least 128 bytes for the test
> BAR (excluding the MSI-X table), this means that adding another register at
> offset 0x30 is still within the 128 available bytes.
>
> For now, we only add the CAP_UNALIGNED_ACCESS capability.
>
> Set CAP_UNALIGNED_ACCESS if the EPC driver can handle any address (because
> it implements the .align_addr callback).
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ef6677f34116..7351289ecddd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -44,6 +44,8 @@
>
>  #define TIMER_RESOLUTION		1
>
> +#define CAP_UNALIGNED_ACCESS		BIT(0)
> +
>  static struct workqueue_struct *kpcitest_workqueue;
>
>  struct pci_epf_test {
> @@ -74,6 +76,7 @@ struct pci_epf_test_reg {
>  	u32	irq_type;
>  	u32	irq_number;
>  	u32	flags;
> +	u32	caps;
>  } __packed;
>
>  static struct pci_epf_header test_header = {
> @@ -739,6 +742,20 @@ static void pci_epf_test_clear_bar(struct pci_epf *epf)
>  	}
>  }
>
> +static void pci_epf_test_set_capabilities(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	struct pci_epc *epc = epf->epc;
> +	u32 caps = 0;
> +
> +	if (epc->ops->align_addr)
> +		caps |= CAP_UNALIGNED_ACCESS;
> +
> +	reg->caps = cpu_to_le32(caps);
> +}
> +
>  static int pci_epf_test_epc_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -763,6 +780,8 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
>  		}
>  	}
>
> +	pci_epf_test_set_capabilities(epf);
> +
>  	ret = pci_epf_test_set_bar(epf);
>  	if (ret)
>  		return ret;
> --
> 2.47.0
>


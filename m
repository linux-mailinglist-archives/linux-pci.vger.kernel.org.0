Return-Path: <linux-pci+bounces-4031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A78867C20
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47E81C2B01B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F82312AAEF;
	Mon, 26 Feb 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLEYOHqq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8053E3B;
	Mon, 26 Feb 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965281; cv=fail; b=udKaIsvAb8qp+YbSInY0PU0YMlT96MFJwoHHxObLbyOD+XcvfB3xd6D/TLO3022ZkbbIjcj1oDC9abZ7zPotuq8cSjV4VjdOUjtD+ioUd0lgigNrzqiHjxF4hTrL2m5ZUHGGwpJC5ZH/vrl71MXmmNnVukHGigUu9IoZFyndDtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965281; c=relaxed/simple;
	bh=Mt/z2kGY2rER2RcPx6sDOzfiYFXZZUQjh1i6TwLPU7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BUti/x4gASMumTUcdrfT53GFeTGl7WmYNzzEZAc+tQNeRhMleMn9vA/0pkgUJYznGkOFCD0cW6WvScCDlgBeeDEZcBH964f7Zugm3teQgEqaD9dPohDU7RnWWYEYVDamIybrlNPwsC2CWAkbv3CkgNlhz3YWO8+TBODFSpZ8xCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aLEYOHqq; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcyC+6AF2wMtDqKndMrmtZNUUxXcHAbG40ILvCRObG8+pkmI1UqyFEV87Ka6GNNphUTt7+5O4fwYJxEUhhicf/eJA7Wetg/CjBb39X8FbpwCLZDufgYFM1avUdkUrsNPKZiYfe0F6CEdgDWChqr/YPy1HfsF8dCqPEwkn7DnJRdMjmKd7iHMsUEpr8czflyl+fpz3T6v7YWovFSyjoTtlSgmzQUBV6dc6fWxJQPoSM8l0QNAA3SaWYjGFA+wW55OZzjBytVn1bGjTteczygNYbKSta+DYS3lNmKQIk/g6htbKUa+MewC3roWVWzpPtCpntkTP9l9lq1grbvGxgcIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOYR+o9gFKOThN1kJ46Q7/hhRKL7Mo/dUbJaLEZgTJY=;
 b=LVhbvVY8weEP3ymVjXID1e71H3BxP01k6LdG4Z75kDJIr2Quqzo+M4r8j0CR9FM4WvpzPM5fbNTS7LWeabrf9pfXBbSR5wQBQbYH59jCQGkb6Ps9/yiAWvvNxV5fWE6rd48NvONTAisL3wnHKE6z0eegifj4ESAPew6DYqMiSgwXtsE3s8EPnAhqNdjh82+Ul//FOBDA5PYdaIOvmb2jrgX9N2rH/6vhFu5R+4K4CtPJf6MQiMqDBmhkoENkm5fgTtV2Wi3zADEyCHXC4jgEP1gNDQhotorWiaMAOj3XeA11ZJgliK7n6bUXPnMsSEViCh/UicOLXPbJtQwZoDoP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOYR+o9gFKOThN1kJ46Q7/hhRKL7Mo/dUbJaLEZgTJY=;
 b=aLEYOHqqf5qbXHTsWRnnbIIenU2uuIwYdM2C3HTT/DLuQ27VYQb5AEdGhe5tgD1gF/Qm3efAcYprvohZOMX6wUjCayCC34HKGpfiwsXNrLsfDyOXcn5glnS4wMl9fn+KTCB3zP2FGP0t41MJS3liqsuzEhzZ/PxvtXTREdyPxWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9470.eurprd04.prod.outlook.com (2603:10a6:102:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Mon, 26 Feb
 2024 16:34:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 16:34:35 +0000
Date: Mon, 26 Feb 2024 11:34:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 5/5] PCI: epf-mhi: Enable HDMA for SA8775P SoC
Message-ID: <Zdy9kqRDWeaazjle@lizhi-Precision-Tower-5810>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-5-cfcb8171fc24@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-dw-hdma-v3-5-cfcb8171fc24@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: c7031202-4457-4b73-cb3f-08dc36e8d15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nHnHEbw1A8N5NNS7XjK8eAoFq3OD3cyE8UOKqm+X/QiV/lFU+q6w8XCZgs3Xt794Ew4Exaa6XCZJ4vMFbpCH5aeSJWuS5xKNBXG3lXLnrUjNmz1Emgz29SdqN4hzNWYpvgsHk6OK+963n62oh8JTkib3aaHQOQ3y3R5auQ5o/BfBRr7xECu761Oyo8e8wUYoUj6CRKtd6ckGUpXg9S/3SkkghWU2nQ6A4/ZSPtFGOKxae5MULxrrSXVsl+ysfedubSmmzDtXI89X/s2s/K7f+TtbuSmefDdRYPWzs0ZrBBlAN1W+TdvfUNegQX5aLCIiRXax2IORzYTdFnh+qeavBaLxQGwU6nsqqOPfBcgWkk1NlKgvGfv/EnIWSOm09IdZpsh0oV1CXmZcvgiTlE6v6B9fGJwBtBA4wnm40RvOh9TgOi1TwwzRSwHL3HRBxIPzptIzSF4TM3S9WV6Gzl1xsjL6wh5+dsPvIw6yoqGAfg0txoifdtbPCevjhiy7VASzgeHsf6BXF8SdGKnZqKJv/g/eP4e+PXPwnD67SxH5kq1RQnDXg7Tx5u2/51LayNA82kL7DiK0rVG2Jn0kqTyPQxnASmmcAJ9zNghjFcl8whGggDicY+CWOSgJvGLLJAsZ5sN90Dz8QAdjQRQJWobc2FI+5xY4EkqUHZ6l2qkqGnJ8GoDfVh+bkxmIHOjk7cZwDa8tq/QnLh6tBO1qxYI5bAYG3wji8Q9tHY8wwPlXdVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jeNrt7oRnw9BWFjIrjWlOP04ZsOALg+UHmDjtZiS6nWAoRuhYCZYnbzHVpg?=
 =?us-ascii?Q?CSGqZxXi57rOhTLNBWY716fhEfuYsYV3bLsKMtgYKNA6K6zqpb0RC6aBZjHS?=
 =?us-ascii?Q?M7BzEdOYPxVHNQGWBv4vgZhB9b4zbd6XIU2tRPf95UnVXXZj3sVGAbv4vPGO?=
 =?us-ascii?Q?Q1JIxTzT6UilWgJQDJjfNctVubJJFNBTm5kikB25ziaaVrjciX77teL6IMBx?=
 =?us-ascii?Q?5xSuQ8vHFKXUlhJTBQA0FBYFzFRJCC4eTR0tV/R5erLWPaIfeCl3dPYhHAyv?=
 =?us-ascii?Q?6+hjf0fUHIqgJcQNjdX8zieObK/YfIZfKmWn+VEUqo/WLNzP9lx0r9GWATtI?=
 =?us-ascii?Q?D9nqEN+NiFW5Zsl3HQr1Q5G0N2JdLORgLbiDaUkNmPHRhebPqR4guT6JHZFn?=
 =?us-ascii?Q?MWKi2wejeYBVlHVIQeE3kqPy1eNLjjpc7tXDoUR5g9hlBk37FzguGnqrK2KR?=
 =?us-ascii?Q?EL8g0WcKBRTwLefP4ag1mTvkC8DpcASgC8jDCNLLO/RujIhPptXrgwj0NFsG?=
 =?us-ascii?Q?pgqDhS/SS+HirFU9Y3aACu2/kzqJ22eBTxZIBi4kUrkwfRGokqWh1mWidmr4?=
 =?us-ascii?Q?C71i4M1EtQz5LZ+Kkwu8eXgR5ARdU6WBl0t0tswiymEMjlHX/FMYI7P9pyd+?=
 =?us-ascii?Q?+ZdjQx6VtzcJC7SMISvjGKs/nsRUmRuXx92nWpMkbg0QuIwVtzu2cimzKgO2?=
 =?us-ascii?Q?X0Lr5PKlMhJP0y/9Zo0M8ZfsPlHDY5/6cZt2Apoc9HWEPP7TckvAWQwjo+fl?=
 =?us-ascii?Q?ftrPR96fhthZTCOGMaXYfBvIcr1i2BMGTQpF7r64WNosXJgleTN3FR69Tl16?=
 =?us-ascii?Q?NHV4vUipNAB9AP4xiAIfBTlj1gc9UtZ0IrlgQuz06zBAQMgCQ+fC/ZYZOxob?=
 =?us-ascii?Q?jkDbm/1+ZCuxXCwa3Arqnca1UvBwRR5NG0jWLKXKObexAD5WRD/UJnAii7vq?=
 =?us-ascii?Q?KbMNWA+IwtHoPb+4F5sq2JPHs7szzSAUujvh7cah3HD56YwTF6IPDHHGfIBU?=
 =?us-ascii?Q?wXwg+uyCIccIeirEaMml7YJutmQdnU9sAUdpKDv+0zyYXdF9lUzFVkxVDPvu?=
 =?us-ascii?Q?597Nsb3QzJEmiWKbdfXB7cumzTCfYmaDzYuaQOV0yXO6T8f8+PEZnM323SZP?=
 =?us-ascii?Q?MCkcxDIPNz6tGbYYTkG2vdHBDmupzqhuFcmwmNyoPWIm+GwTsFA1AeMr5M6/?=
 =?us-ascii?Q?ez0Y0pjqgf3ukRsxmbapgbwgGGSJYDdbKpbMwHB1Foq7tUBDgItaprtEuLEk?=
 =?us-ascii?Q?kkJYhznFR55SbbzKUFVwCu2KEmBXI/rGtK19YqwRRSwaVxaBVHJ8RmfOgH0Z?=
 =?us-ascii?Q?XIDFLuqeeBdyrgNgsgWHuN3DmdyCaRz23M7hdacpjXMMDGQ0oIC7YmNbklTX?=
 =?us-ascii?Q?+rsgs7w/u8f6OTrWWOzMQWbdf0ggnsrORVbBOAeVxXmCjlJSExSPsH5r6GXV?=
 =?us-ascii?Q?uBmiJJ8VgQt8cA7WDs0Nsaqh5tnyHSd7Y7jl+70Fz6uhJ799j8BqVQL2k8cp?=
 =?us-ascii?Q?5J2/nGvDyGX1fkwaxy9zPmWhywU1IC3haibeHtFW9a5zzj7Rye3P8C2gZRxD?=
 =?us-ascii?Q?+jxidEdiwhPJCTyXOHs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7031202-4457-4b73-cb3f-08dc36e8d15c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:34:35.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6S5TUqQ/jVoQXoObG1Trv90Vs7gi3t3+hnmay+UJw0xAF8xFdYXocoOduHsNcZNSQxmJ633hs4YvSJZDjIo4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9470

On Mon, Feb 26, 2024 at 05:07:30PM +0530, Manivannan Sadhasivam wrote:
> From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> 
> SA8775P SoC supports Hyper DMA (HDMA) DMA Engine present in the DWC IP. So,
> let's enable it in the EPF driver so that the DMA Engine APIs can be used
> for data transfer.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> [mani: reworded commit message]
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 2c54d80107cf..570c1d1fb12e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -137,6 +137,7 @@ static const struct pci_epf_mhi_ep_info sa8775p_info = {
>  	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
>  	.msi_count = 32,
>  	.mru = 0x8000,
> +	.flags = MHI_EPF_USE_DMA,
>  };
>  
>  struct pci_epf_mhi {
> 
> -- 
> 2.25.1
> 


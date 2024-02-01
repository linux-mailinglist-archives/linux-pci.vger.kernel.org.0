Return-Path: <linux-pci+bounces-2961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC09846120
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 20:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DDEB2A6BA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1FC8527E;
	Thu,  1 Feb 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NR3Ng6AT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB72B9B3;
	Thu,  1 Feb 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816433; cv=fail; b=Y1PZUei5X4V/CffAiI/eyyhmsKqLMZIiwGZ9HCxxe+LbqXMYHZUBPQCf9EALjLcrpGwBo2BCOKSDg5b1sauj1So0JM5LcJANxeabPGl8RZN4M5kQ03lRE6KhcByRQEcxYft4NsrnuXmECBdL8v/XAKDXH6MmTUXE7eOYV9/BssI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816433; c=relaxed/simple;
	bh=cZtK3vE3ZNZYdQsrOiJ9DGBDz4Q2GfIHwW8zITv+az4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBMDMzXFjgilLnYeYg59prS8S+wSKoHA8Q/Yn8IT1Za6XfQptFBYpe7ImwVUdy1JzkY75nmLZcAf0q0pfjghiJ3pb4Jr/Sqe1PktlJz6PunidhqP6FtpUiYAZJZQmJ81Fp/V4QF/oOb7ERS8Qnan2fGTXA8IY1bvHjOsG5Q6J6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NR3Ng6AT; arc=fail smtp.client-ip=40.107.6.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6UWhqzNJh2G4QQFrZjoa41mh8hcFqdgDfoAzi9Zv7xdzXZOMT84SEmzO78gJmTHB/Mw9t66d2ZGI4AP9PnrgJeJcJk4maceaYSJB1pfNvUZgKcMp3MuUMtqJ6HzyRYXbtTgYVR/GB7wgJt5bX7DbLD9J5QEFRhmzNhLMX7FWngCc/4CtUCaTIem3MihTOShbmDafPF5YvqD0K1C/sWkfbA0JBxTN/PApd0h3pef/KLd+EC78ej1Qx8RIm3pdOnAw9UPIuHNCgWYkfIR9qp0vXNxjNWJofFgG2oLxoPfG+wgA3w0UFBzXqPur50xUAgA/E3IAyzWPh58pEEG7VZ5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKjo77WWgFgeAsMJ0om0/49l36LCmtLIgkSv2CYnSVI=;
 b=XLmiNlfeFRMVxs/0p9fr9wXDQZsc60TLSa8b5r2rvje/BfutzK4EQAtnOZVPTmcfB29yW8bUOKeGgwWXnW19+iekNakD5xAFPZX6TcoJzisHrK3Zw92g6KZNhXjgTvNtR4CALGi3ApruoBonvcfY6CCTIKoM0WpMQUK8erMwSWp3ZFk4ZmZoR8fTgtcNkIfUQn1LutwQm0nq1oQmRepxopMAWE9ay/2BF+6DCfTimVUu2C8Gpa/WC/w7lI93I1knFfHgthhsJP7BcdS+do9sAImJc0Ft5q0p9W8mdvT/G4r6Hh3JpcGnyrVzNkdLlNVlfrnyHFwz39uoV2m6nYzoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKjo77WWgFgeAsMJ0om0/49l36LCmtLIgkSv2CYnSVI=;
 b=NR3Ng6ATyWX8HwbpDqOLDZigV5eIzh9OOBms4nZeZYGD8OjgJtsUWNorsm387+7y/GWl3eALr47JlU8zqYpJgq/w2IdZwV5hVWZHWyUEP3m6s/PGd4xN7kDZengP8NCDKMsP9Ln7yG2LfJaJSO9p17gCaZxny6XVHFh2ZbgqSgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6903.eurprd04.prod.outlook.com (2603:10a6:20b:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 19:40:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 19:40:27 +0000
Date: Thu, 1 Feb 2024 14:40:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/6] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <ZbvzoklqE/V66a3P@lizhi-Precision-Tower-5810>
References: <20240201-pme_msg-v2-6-6767052fe6a4@nxp.com>
 <20240201180349.GA640827@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201180349.GA640827@bhelgaas>
X-ClientProxiedBy: BYAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: eccfd38d-f836-4cf8-1cb4-08dc235da3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rPs/yDSBXZuf2C8ywoD5zhtk2ZFjTSMBdZnXVByI7C1IVt+/O925YmlugJystk/c/XB6cjfoaUozc+UB23ypmzJzp5drTYqhTlS59A3Gm6tieHGMsZA38qjXvCOuiO5VjunbW6hehIU6ra436B479pbPeOZtPOTZd9A+MrCzf/QcqUrI8eN2WJmeAos4zUq0fipEbP++rKDLf2tXHZ7B+E9yhx52YFanMh88HeDMjNSaAr9SoeTv5agKDcnCVyuoHRkjvLiAb8KNn6/iIb7/9M6aApGG90ayRYuneu8bJNsFB2TZ59JxvZ8oxYM3k3Lyvz1P8RRqllc3ghk9uG5Uc8JAomGU8XOwgp77KupKCZDALzKt834PFg0qTW7sjQgvaH6Cpr7AYUNTzymMiJpYbqdvVgIFez18FI4S37acBdGif+U2cswUE6Wpnrzji1FB33wVAhA1JkS0byK4Ah7LRNmmMoFveL842OHyN69armo+05wP+/p05HsSRrHVAEWygNWq5mBpEUkgjKIoL71zEdtzSp8lYw7QAtKZHXHeH4/DVhqDqglalBgcXFe8UqACz5KESHhidsVLPfHFK+L+nM7t0jlld6+OEt7UYqrH6MmndtPdi3vYnAZ8Aa6RWJfz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(66946007)(8676002)(4326008)(8936002)(5660300002)(7416002)(86362001)(15650500001)(2906002)(6486002)(316002)(6916009)(478600001)(66476007)(66556008)(38350700005)(54906003)(6512007)(6666004)(52116002)(38100700002)(83380400001)(6506007)(9686003)(26005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ITzILL2RClSW6ra1BlPfq36UL9Va5jrOgEVJMjHm3UlnG9JxlrjQu0UPMfYu?=
 =?us-ascii?Q?SsPW8gzuz1/Mx3qBasDcFRBQIW765GxbRiknQFhfYoTexx43uPTEzxQcNQ9Z?=
 =?us-ascii?Q?rs/Fz5Na6lT1F0b15oc0ohiM6pSTUVjz1EbkpP2vm0+V9iqdmf3Hda/l7EgS?=
 =?us-ascii?Q?VkO1xV8eg3YSB8J0WWGwfMydiYKbHgjkmR9dPOi0KgERiRGRSqp4h9CVRZSm?=
 =?us-ascii?Q?zzTQ3uz7I5a4aeaQZRFoUwZrxldSUVS58d4dV28wCfLCB90b2t5THzAlDJ+o?=
 =?us-ascii?Q?DILy2RPqlt5TtZSVOLqc3MT/NJkt+laETOMNoI02c/KAVe1wPnEYCsrazTDd?=
 =?us-ascii?Q?kXQ5w7R3KTb+Zoq3S8wWFTvUiPSMXkF6hRoexf5LL2FzFQM1/FTxUws1KlYu?=
 =?us-ascii?Q?dkA+E9ixh96PnsJbMXxfC/HVkSLZP6NSPDJip+1LQwZ/d8eWi0ORWX4MJZzK?=
 =?us-ascii?Q?IpHFfO/cFJmqbtMU1g58UOo3ddswKCG69HfrvUXgw6UhlQGieCNgUo5fRYDH?=
 =?us-ascii?Q?nye+hVCx3tGT6Tex8vrT0Rd1511+b1+81Lkv6TeIHvGOMhxNbP9pp7giJu5s?=
 =?us-ascii?Q?Fbg7yvL93deZmAWSU2Esyg5gNU+LpREqtaPAFeG7KknOrv7PTW7fWKq1yBY9?=
 =?us-ascii?Q?IMI/RuWVlzDRzMs+V6NYhZWgAv2vCz7Ga1eZlp2GMqL3NkT7x1ybhFH43W/0?=
 =?us-ascii?Q?hmzgTbrwE/8BAVKApyJtGhNyqlT4TUYUe93fDw0b9IQaccKwsl+Yf4MzytRI?=
 =?us-ascii?Q?e5VJVjLW9fgcvHz2uuzDUdyXZ1jnMJIoGui2+Qvi56NjZ4dj3jf0UKs+Mqhv?=
 =?us-ascii?Q?pDKA+Ta7CdaDJBwrVTpbt/aIldUW1q9U3SS/Ox91vTN4GsQ2FxjCi8/yntTH?=
 =?us-ascii?Q?vRn5GOX3Q85C43+Ncthqzf1057oV4+pbRHXLu/xMLWcWnOuA3e0fFFRPsnGZ?=
 =?us-ascii?Q?X7RR0FQz0VPQ2i3DNp5mRZlIDbwePmP9qyM8hN09IM7lfPKDyr2q8YtxFpj9?=
 =?us-ascii?Q?uJjgbbBszXW+BMtnCfVrib+Gko2mpjlxC+i4GKuuURafzC1UMG5ucrPPOk7x?=
 =?us-ascii?Q?N93dGyBykuta4+6nQTmGJSLPvGsIaPXTfEwMWF00rfE19brZzrwjXi5IBs68?=
 =?us-ascii?Q?UF18uVpyHL/+V0tzYXR4a7yMTaMHbCxoAZv/wI4OFm0V46BkfEHilvpP8lS1?=
 =?us-ascii?Q?2bK/xZA3CQUY/eV3rMimgJMYVwSRgb8YoZlL3VKXkiryGZ9mJiV7aJYa4o2g?=
 =?us-ascii?Q?7qjTHI4JSgOmUNB0Xz2H8OArngZVnEjGbD54nbGawQ2aLKC/bZwYkPJ13ulO?=
 =?us-ascii?Q?qUlEKwUH4vVqFQuzZZrWoCj/bFol0NWYJIjVHvmkrB6fj+P5EIS8pDsHrdfu?=
 =?us-ascii?Q?MCMZG4pr3BEbpnpmsOdbnrv58gxqE5Z82R/NUeKdZ82ZinTYfeg7DNen6PLg?=
 =?us-ascii?Q?bq69oQ+OacTX1axPkl+gi1avBOQ9GRCTLsbH+3OLzePZsq7ocspqMGv+GSIu?=
 =?us-ascii?Q?P7imjYZh0dMZTjzD6y9BXNOspH4rUZRwF/IkWUGWKyTkDMdE3anH8pF8DyLG?=
 =?us-ascii?Q?+vjLjdJ6T7tUlxxbA/bf12IO+uzLb75++4BXimAf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccfd38d-f836-4cf8-1cb4-08dc235da3a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 19:40:26.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSU1P9VnmSPrZarTD8u2siQmtYTdqZZdKUmN0uJ9wEjpoGK398YCHI46ImA3j7t+3n3PkTie5M8tIv9PUjsrWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6903

On Thu, Feb 01, 2024 at 12:03:49PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 01, 2024 at 11:13:30AM -0500, Frank Li wrote:
> > Set outbound ATU map memory write to send PCI message. So one MMIO write
> > can trigger a PCI message, such as PME_Turn_Off.
> > 
> > Add common dw_pcie_send_pme_turn_off_by_atu() function.
> > ...
> 
> > -	if (!pci->pp.ops->pme_turn_off)
> > -		return 0;
> > +	if (pci->pp.ops->pme_turn_off)
> > +		pci->pp.ops->pme_turn_off(&pci->pp);
> > +	else
> > +		ret = dw_pcie_send_pme_turn_off_by_atu(pci);
> 
> I think it's nice if function names match the function pointer names.
> 
> E.g., we currently already have:
> 
>   .pme_turn_off = ls_pcie_send_turnoff_msg,
>   .pme_turn_off = ls1021a_pcie_send_turnoff_msg,
>   .pme_turn_off = ls1043a_pcie_send_turnoff_msg,
> 
> which is slightly annoying because it's always useful to compare
> implementations, but "git grep pme_turn_off" doesn't find the actual
> functions, so I wish these were named "ls_pcie_pme_turn_off()", etc.
> 
> You don't have to fix those existing layerscape ones now, but I think
> the same applies to dw_pcie_send_pme_turn_off_by_atu(): it would be
> nice if it were named something like "dw_pcie_pme_turn_off()" so
> grep/cscope would find it easily.

Okay, these funcition can be removed because this patch. But It takes some
time to test it at these platform. Add need dts update also. There are
still long road.

Frank

> 
> Bjorn


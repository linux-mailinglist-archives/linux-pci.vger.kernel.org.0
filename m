Return-Path: <linux-pci+bounces-2529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6783AF48
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 18:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5441F228E5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2387A738;
	Wed, 24 Jan 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BmWmrSq4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425007C087;
	Wed, 24 Jan 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116216; cv=fail; b=XPAisIIrWlfXTjlAiCiQc1C+Ndse1VbBwXwKeDNHmgUhtsWPCbpPLCG/j9dd3oBPfgT1ImD448llI8tjrEkT248RKJSCttnF5fUI2Orx2iqAHBQIWNREyWrNb6eSE7uLpvSQ6TKxswYwWFZUFYeJDy6jexwngfi+oiAekRoE/fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116216; c=relaxed/simple;
	bh=rPKWNF+1BWb2OGAB86SIOLpmDziq+ER6c02Pw2sB78Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfF4MD3MgWPUAS60ILzEAnMK3qYokI61ZdMfO9d/RO5sKrZv2iAs95QDp5BPcG2v6anmWYvW74gyLyUHu+7d1fA6CEPi2sa+0aNTQFlkbAECPfCAP9IwGIePoaa48ONT+DvB+duzZAOSImZPTsO8zrXVnCLWH2pgAzU9UKVYek8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BmWmrSq4; arc=fail smtp.client-ip=40.107.13.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbieraNWdqMfXSMZwotkCnLwvdtPSVD2CkfPYfJpkZeoLksOkAcPbLDn1wVGYeM7GtfWHVQvuruPfnQyeqVpDwhx8Rg8f6jN6y30acGJXkqeKUFJqEBBvIh5uSE0H45XiewZq7onx5MrXmHH7+nv9Qtl4kS4NPBY+rK3qyPUt5VEj9ojEXuSczGin2mvq39UOke7Q0XNovel53CQxnyaC3ijka8WfDP/TurDUERYVzhfmxvl5WfOMdjthUh6pk8t8t+ndwwiTXDcvudy0YNikybfujBzNR6rkex1vGVGZdMfgdDf4pbSANpRTbNyAJbLDCbSdSAyhQP9Y/WUfgto1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsE4CQ5kR0aFxV9whG0c5qhjLZfaFGbW3waw65kyMQw=;
 b=X6+VO3bKpV76BsZKXLWWTTp60wsklhd99LzaUHHNWDxGTBCodKL0z7HWEr6iiWia5Uk5Z/rXs15nEhs/+qZsahEOHMk0wtKewEy996ye4cETVXe32xo2Yc9Gj+XYBx3ZuWkBoj1Wr/vAIARuXWUY0bE+oWpnw5oGkV0x8vESdtJ/wPhWTOmtYw9OzjI96KlPMbyS8enhQr1m3EvEOk+nggqV7vgGaoxV2oR8yYvIu0xKQOCbGHp9XLzTPqR14dniYpJS7kLm4XUEDMfhekEH79+yrtxNHrWdOWsseWX4dne7y3rwPAGijv7xLDy6Ziad0NDgR1wNL1G+RzEsOzb7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsE4CQ5kR0aFxV9whG0c5qhjLZfaFGbW3waw65kyMQw=;
 b=BmWmrSq45WE+ghff3+4t/52YU8cuEYgl7ljL8yokUB/17eZ5ait4UL50C4Hb0jldShRUVrVpuT2Ua+f/bDk0oUKuvEw0P09QsvX+Tq/VXS8Iap0BYEsnW/f8ouiDssoKkzcelk0VNF1RnCM56bRNhbSvJg6r5MSXEDqxiX0kzyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7963.eurprd04.prod.outlook.com (2603:10a6:10:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:10:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 17:10:10 +0000
Date: Wed, 24 Jan 2024 12:10:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	"open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Message-ID: <ZbFEafUmqmE0nrPx@lizhi-Precision-Tower-5810>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <ZZ1Pj3MvhQNMnP8M@x1-carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ1Pj3MvhQNMnP8M@x1-carbon>
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f5ead5-230d-47b3-78a8-08dc1cff5265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+gmvM++Jj7p6+q8rV6KorRTFbc7HMcE4TPL0NWoKvVA/vl+Bmv4OMJHwVWjfd8fD46KNQ2+/w62xK7K0wGkR/N9NH1xXRe608QmsvEXAIrZkg0/Z5noNSvOISWKzOPDcTuC7wac8K6mI0hBm5AvL8diRhucPO1Qr5QKfEo5KpDSz8XLzIpdqK9j3OujdnFyEsyg1qBdMtZ5YcyKCIgS/sD+uKwut0Jk1cU1bXscOWSdCoe1cyLa4ipeR3ZxuBjlQtLWS54i9IHd8+SsbuP4RM5KljYs/IGj7RlucJB5OcL+rxlCWwLmwc3XackIx0yv2Jjcj028YF0gKO4GKwZl1noYo+rLq48/Ox0FTxkn5HTO5eEK6XU2MpWpVGUTa4oom4fm4S9sN+suskX6MXMcdsA7b5bocLgGH+fAM+6+p6TYhv3B29/xaev2POkNaPtx3eIp9qZSrHGh1r+kJVqse9xdzm3rwNgjGtTzX2CuHKDMCuEjkvWRN7iN7NaDk31VvGwhSTl0+xe43rVnNWMPspZhTypR6ATP+ZDbPJfUjlp+yLigVj7JQ/ru4DSmc08pWu8W0zRP+/vRqZ8KZmd5CHN0NwZ15tOhIuSOByGk8iMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(33716001)(38100700002)(66476007)(54906003)(66946007)(41300700001)(7416002)(8676002)(6916009)(5660300002)(316002)(2906002)(8936002)(66556008)(9686003)(6506007)(4326008)(6512007)(6666004)(478600001)(6486002)(966005)(38350700005)(86362001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+91QVmSUMxPXi1wYkwET9c35QpBSqME6iNw9yAg8oG8XAGmPpfXSP22UkSQ4?=
 =?us-ascii?Q?V6qoAs1oLlwBZFseBKJ9DHjAE3fGTkNQkNS/IOncHSxPD6w+xRlaK2nJ6c6B?=
 =?us-ascii?Q?Mkg3sdpDIS9ularjx+R1pKLKwdkMdypgck2vOpP2Pw+Rz1UXFSbhkSJvVkig?=
 =?us-ascii?Q?Cc3OzzyiJ5J/MEZqHkQpl8K+HJCQ9vh6KwJbyQQK+/vQq2hlRrpKgA5aY8uh?=
 =?us-ascii?Q?KsKh75dDSHM8KhNe7I7E8i+1Ehgv5jaR7kEZXQykBzEVbknO6B+jAYtCXz7h?=
 =?us-ascii?Q?bOE57Dfm/40zqPqdmizbKqykVJDp120oxntgTqh6tBCw4HFNCLk4Qk0pyOTP?=
 =?us-ascii?Q?Y5OGFu1RL00kDMonI/gu3rgnA706lHwgAIZVGS35CE3POqQU4rp9WmTNtIAz?=
 =?us-ascii?Q?kJPng81eLPg98m7PylIfuPCSk/jDmS3J0xFrmGiqGl/ZGgS5XXVjqYtiJoSM?=
 =?us-ascii?Q?uGP2polITlvp0WefxoID3RrmaBII1Jfcd7BKQSRWJ8vjhkOD7q4+sseKSq7W?=
 =?us-ascii?Q?Er4LdDhKBAeYtnq6RPH/9LVW42bEF2+9/r4fEGHLq53fvr7hXVx6XIo7rK6f?=
 =?us-ascii?Q?azLl1efggLuuKCDRVnv1yYxizwyYckHYICnZVUW7ZF2cG4T2lyR2RyVY+Ov0?=
 =?us-ascii?Q?28ISwIuSs3jmidatk6GBziCYJqagnLG3YnTKIcNZS2vCqeiefVtLiKWoM7iZ?=
 =?us-ascii?Q?nxCJzDYR84pLxmOfdAfVN1EVs3eEmJ3YSv9NQWCw5C+Rf7ApeB4e+TacsCkm?=
 =?us-ascii?Q?pj/dCjlAXmjQ2XdpeBhqI5LS+jLFM+sv/Lb/TMQV4lkpWC8J19Kk7Cle9Oft?=
 =?us-ascii?Q?ysOCWsktM3Qyp1tSkZ/808ulIaPu5dRvZBRzMy/Ed/8QRP0dM1PjpZatstCy?=
 =?us-ascii?Q?r+2qSeXW+hGOr6ErpIP/kisfcR0v9liMYmMX3yNxETyVAEU7HO0eALyu9FVy?=
 =?us-ascii?Q?QAHNJG6ZqAW8VrueYPIaRZdFhlfAx/dVVRjE6PAwVp7o2Z6zScon6oj5fwRA?=
 =?us-ascii?Q?v5gAQ2HZtXL3IwBatWW11on/vdc3MwGMStM/V6yeq9EJwDgIm+gB9nW6NR/X?=
 =?us-ascii?Q?7cAITZiaBo4R4X33iUP3WUuUDeGTxQ9u3YkmWhpnWsqvZVdSmHkchfr4zxU9?=
 =?us-ascii?Q?9suFFLzLt+3j3xrOEJn5mLTTA2H4NnuLHUPpL4Mkd8mk/iu2Nj2RtBR1Ucgm?=
 =?us-ascii?Q?GA0+2oM8auofg4PWVOa+fxNrnTBUKLHx7L6Hz94m45Cu2tSmZPZTxDQPYVdD?=
 =?us-ascii?Q?G8RLMkYdPHKiGUAa2zd3+K75RGM8TcsjYov5irfU6iUNvAQ55OEjqK5nRl6a?=
 =?us-ascii?Q?GTOQ9nPJxsjFDo/8LG0/0iEyGISDoIMqdKM1lsMO8qbbBUMgvZxnXacRBC8i?=
 =?us-ascii?Q?Dc6sQ8zuPju0JqPxC9wLdFEKzHFdqxV9HAtS3YATYDpFmEPkHibCbTnj0s2l?=
 =?us-ascii?Q?cdqSeiin4C9B9ivgPP7jVxUsWdWnrEygr1T23TvL9xzA/XTsyiPN98CzpuoH?=
 =?us-ascii?Q?AZZTxOVbKxqDtACrvWC49BjPApIhlDqwxMP5M7R8WU73MHfHWiQjjdse6nfo?=
 =?us-ascii?Q?fYnGtBX2kZ3FcS+WVgXVZ7hLta4+fIWzf1z9Wr45?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f5ead5-230d-47b3-78a8-08dc1cff5265
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:10:10.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caRfqR3NChS66Nq0Ph0PW5Z/EyEGny58QDDGjnvU+xVLELAgufk6DN/uldU1Kh/uJksLeJd1wwSSFbIYSu0GUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7963

On Tue, Jan 09, 2024 at 01:52:15PM +0000, Niklas Cassel wrote:
> Hello Frank,
> 
> On Tue, Dec 19, 2023 at 03:38:33PM +0100, Niklas Cassel wrote:
> > On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> > > On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > > > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > > > dw_pcie_ep_inbound_atu()
> > > > > {
> > > > > 	...
> > > > > 	if (!ep->bar_to_atu[bar])
> > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > 	else
> > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > 	...
> > > > > }
> > > > > 
> > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > 
> > > > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
> > > > > not allocate atu to the bar.
> > > > > 
> > > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > 
> > > > > Notes:
> > > > >     @Niklas:
> > > > >     	I have not test your case. I should be equal to previous's fix in
> > > > >     mail list.
> > > > 
> > > > Hello Frank,
> > > > 
> > > > Thank you for sending a proper fix for this!
> > > > 
> > > > Personally, I slightly prefer your fix that saves the iatu index + 1, and
> > > > keeps 0 to mean unused. That way, you don't need the memset, and you don't
> > > > need to change the type to signed, but either way is fine by me, so:
> > > 
> > > index + 1 don't match hardware iATU index. It will be confused because
> > > other parts is 0 based.
> > > 
> > > So I choose "-1" as free iATU.
> > 
> > A s8 can hold a max value of 127.
> > CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.
> > 
> > Since the DWC code can be synthesized with 256 iATUs,
> > your code will not work on systems with 128 or more iATUs.
> > 
> > If we continue to use a u8, and offset the saved value by one,
> > we will at least be able to support 255-1 == 254 iATUs.
> 
> Do you plan to send out a v2?

@mani:
	Do you have any comments about this fixes except u8's problem?

Frank

> 
> 
> Kind regards,
> Niklas


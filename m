Return-Path: <linux-pci+bounces-32390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C49B08D40
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B9B3B795A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6497E9;
	Thu, 17 Jul 2025 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B2kqbZr6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38162C17A3
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756220; cv=fail; b=eS6ObYl/ROMzGQGHfOyZ3J+sIQAOb/PpgxfCaspjYih0jQE4JjE3kom0JEzkolYwSsS5IX262lRieM8hqCr8iw5DTxlbnt1+DjfdKsb/7NxGv6nIxwxS8qKBMUa4rjYswtNRfoetzbVDR23wJTTWytjlhmSq17Ux3FOWwOPOIEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756220; c=relaxed/simple;
	bh=fxc7XpyfDcEV62lCqiLcFRUXWdY6Ed+9PuASIzRyFjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lBSG6Uw6tooleI5rG4jcb9109MeG0Mzl1P6siv7jQ13v4jk4Y2FeaU3EI3cdUJQajWEbcq13JVzjw8DYPopYYJXAipbOIzb1fZIrcBnh87llah7A4SpYiOcKY8nxOtgW85+zMH44jlmukLfmb3G48US5yL3FeOcZys4aTp3GOfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B2kqbZr6; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgEs8rp6soeLG02BupjsODd81mVM9Yk8wzKXLznECJpXxkVxp1m75OHKzqh3Nzb61A48CHTknTgesK0VrIu6wF8FLQpnaq5n0Pzk7wepAwwKdi0agNPFuP4DJAF6AKABGa2g+qMG2IqUbfBtbCfRPDd94xihyx85DmToEy/poPWV0UDZtwQMV73LAuaTuGXV9K9gPyApITCLpzbFosVU9DRu07mtwe+5uqBauS4O7vJPS7Y69nJWA3PBrt9/UGbYO/zGb6gv90LxJxwZbQlBlPst4vJYuQi4XgAM+L+j+E+2TSAh9t86nmkFxLQ9+G1X70KztsT7RtQFj+RvCeNEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAujl0L9R4FB5DJn5d5zsyQl6x3kLp7QJPggDrgtJRY=;
 b=w2VF+AMMkps0BDJCBo4XuxPB5J+a6QK7MICX9GaqeDvervQj2bZgAAppEIZ4sZAFFYcaEojeDFt69E24VuQIlmSUHeQx0vV0R1oZKHYDjQ4OtoYzcuZPa/vi6YboSVN44nt00/cIWODzCZaeu8lHHRBx6TYSYwd9lSnXAczP8amRAO0pMoC3Pgjd7wQw498JkjrznAl0+/S57pIAqEzKb0S09BzlitrJbEW8medQElHbl/Ed5j0lJWA+eCQmBXc/U9Ad3R7NxC/PHwd3ywNYVB9G9CTd2R8NNhCiVS5UAmkpTfP9v0YxK8SmxCSbV4nqo3/2V6zceeLg/CMtwwFpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAujl0L9R4FB5DJn5d5zsyQl6x3kLp7QJPggDrgtJRY=;
 b=B2kqbZr6LmI+OyDUINeUgyUW4OQq72ZU2HncLNlvpXedxfB8dsi6KQeKXbUsp8JDZINPNr0Bnl8lGo4qWV38o5JVyYls/enyvkmFfJ9PnJM1/l2HXpRJ6d0JNN18X98/SdM2XH65C1UEkf3AaQFxaGLsfh8CX51Ikb4wm4GqIiPjiKRo5kvYXl6Hj4LVpl6K0rqC+CTWSYeitNv7AYQskXFe02961bVgs5MXpzBDqMR5UtcWKUV81sMLCS5Lmc30L7cZUDtzVEE7BV3fguWq1psejIEaj1jR0feSfJUjHZO8gwDmUijFJrgmGhYNaghd9vD+PgfUdxq3wcG0EC2jOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 12:43:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 12:43:34 +0000
Date: Thu, 17 Jul 2025 09:43:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250717124333.GF2177622@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
 <20250715130949.GM2067380@nvidia.com>
 <aHfIGJzqv+4XiO7f@yilunxu-OptiPlex-7050>
 <20250716163134.GA2177622@nvidia.com>
 <aHi0HxV1Y1TsauxF@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHi0HxV1Y1TsauxF@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MN2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:236::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 02582768-0acf-44c7-a62b-08ddc52f8b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MebU446mT8RPP9pg1+Y9rbgcjnEKjxCFg/InrN8/lvqJPxgSgmf4piuZBVRe?=
 =?us-ascii?Q?MvM9rbzYMqps7gIfQTIefd9SC+rOGtuUKSDHKMBDotgegqiiRUaGQSgZwXAY?=
 =?us-ascii?Q?zfjnK7VTie8m1+csLJXhkWyKmkhD31v0VFchLKH1kfFWvznoMSujxcHEZmcu?=
 =?us-ascii?Q?0cgU5qoUPMVpi2jBPXKvdWg9p+sCiRC0uc9SrbY164x/g4bYqLkQvcQAraoJ?=
 =?us-ascii?Q?aRkgOmhnD7jeHttBCq18IP4byWl8sKwe09dcNhTSWxLN1rWNL5XBz6gsKnFU?=
 =?us-ascii?Q?NZ4iSCRPqWKdbrzBqSLzS4OVez5iRlyeJxhiSMNk/+Nxt5iyZ+5/h2HAvmvu?=
 =?us-ascii?Q?LDMPBco/5tyiRF/EGtherS+XmNGYpjv1olj7Bsi2tbTUnIxg3qnuVoCl/2df?=
 =?us-ascii?Q?kz+AXTqWJ8DIgnpCmqxlYCtufxq8rwMcJVm2s3vFPvTJJqYVdbQqYCj2jxG0?=
 =?us-ascii?Q?oSgpnCoJwMDFOJK+2eiRpPtg6feF8RbXHMdLJDtXHZ2mn/+pTBgAqP1NYBaw?=
 =?us-ascii?Q?L0BS4/vNkDgs8xIYN+hoWvqKy3yrjK4U9iv1fA67psKG15BGyIRJf3yJxA0G?=
 =?us-ascii?Q?OOdpGhNwQTCsWIurVn0anb6Oa1wgrI+dRnygX2AC52hfCC+JCa6ER8APyiYf?=
 =?us-ascii?Q?IegFO5ZNxmK2/n9NHCx+SlAConrliZE/5ZIURk0UmmhZTcq+iomcLOZL4yvz?=
 =?us-ascii?Q?+7C/31qm3qF+PaTatiVu9GofVrVOCpkJXEmHWJYLz8Cct7x4tJdsIRPsHBGB?=
 =?us-ascii?Q?Du5xO44qrNJ+azdol0VlZoy7jCYg/FOU9DYnN4DBwcNMHUYvcerm08FN6Oi2?=
 =?us-ascii?Q?0JGjOqplCb47hjsu4tVLHAruOKR+rzExa1nX2OREtGy+NBMotBadMRsGAzK7?=
 =?us-ascii?Q?+ZaBIAWwYozvBMesyxsIdPB9//ezk+ZCpSKUOC6K+avcFYFtAR2kU9kifBHK?=
 =?us-ascii?Q?yUof1XKPQuaqaz7jEwAeM8UW/V9EW9JRS2M/7qkJX6say5HzSyCvibgH6T95?=
 =?us-ascii?Q?em94AM4lMMnTm9tijfX8xmH4/q8ZrjdOomOMbOsM4SHqThKZYk94LlNTwiS4?=
 =?us-ascii?Q?uZ+JkcOx/XxKpY3OmJXPMLjLlbipmLcdgkXBgGJEIkYOOJlenBN2a9xCWNlt?=
 =?us-ascii?Q?9cpqqN77PXFpb1InPxcsJcR1t5ZA3K5mWoFTx+RG1/z+9TtdcvZ1TFaEpDh6?=
 =?us-ascii?Q?0Q/2up6uZIOf1LDE4r3jkWvfMnwrXXazSf2V1fAxR4LcvYG2xUWya1HhiQsc?=
 =?us-ascii?Q?5NmO7QxTBKTE4qF8EBAg6lwTkn6+9yyxG8y5RRpJBlMY0LjZ3aq4hw5HtGuz?=
 =?us-ascii?Q?pgXy7TDGy1TRqDoAALav4pynFcAFgNdu3WN6H/1omhXgd80ZJVIIwvZpHxL4?=
 =?us-ascii?Q?NaRgAstpacO7ZrRrwjzQsMWNt1q1pUmPkusKj7+J5Z9r8pIILCAaCSuP8XPF?=
 =?us-ascii?Q?CE/2KyHUECI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ffyFGhZWqtHH1FAcgloOWhfJ3HfwxyP9/KSwc//BEnsk2tZCb/syTXmvyXz5?=
 =?us-ascii?Q?Cw1MrWEBXLH6hhK+bc363XQo239C6+X0hSau2NCGPnC/tqDFb/CzUkdw8QkH?=
 =?us-ascii?Q?3ebRNim65fJKlSumGiqViAPXBN845iCOX10cHHAtoVUhVH8ELl9WN2m4s5Jm?=
 =?us-ascii?Q?i4WLVuv4C2aSu5nCQ5gMxr4ecLUXc3fKOH6gIooPqInGGZNRpiXLOl7YnQHv?=
 =?us-ascii?Q?PznSEyTtwsFFymrfCw+tJJOPzFRSYWuiYOfMBX68lmWd7druQzZCyZg3JuCd?=
 =?us-ascii?Q?cTydb3n2L5bKosk7viVkEGLHI+mwI4i4SP/Qk8k2y/6TeGS0AQGC9tNHCFW/?=
 =?us-ascii?Q?XmzfLPHsJ5tA4YKqPo/vAV1qewuZdhyhjx5xlzGfmpJUX3jQxAQaxFoe0CLR?=
 =?us-ascii?Q?GlxTn1Vvcbjl7wHJpkuoQ7jg77EJuYODw2CLO8Vz0x/UOTtd8JptmPcXJDKe?=
 =?us-ascii?Q?M1z+VhsDxbIycMe7DdvIg4/Cqqwdj0MEQdHsRR+rj1t6+E9eoAnd/p4k75xW?=
 =?us-ascii?Q?wisodwV60rBxACtUhzXJtT13DmASWDfCYep1s8sepffIIwae6T7VOkWVJkFW?=
 =?us-ascii?Q?xR+PtwRKlvdSMeFp08N1Bir+nPlW1n9mMs/VArTDfq9JrlrWcunTNexg3+6i?=
 =?us-ascii?Q?kwHSc3VktJ8BlE1N/b7S4QA62BvVtRB/warWhELN291xDu/RisqkYhPf4w0P?=
 =?us-ascii?Q?f6v+suJl4CHVvP14TmF2U0IuKfBbuyFijKL4xDiQufTP5X7UXax5AJDjtwKN?=
 =?us-ascii?Q?C20VFer71+I2O6YGGXVBa7fYHuqOza+9gAxQzxs833eRxgC8lhNQUXl246Dv?=
 =?us-ascii?Q?jVc1iHMNEJ6P7gKTnMRJdUhRintoy1XrcTNBsy//+ck0p6dMdJ1EisOJHdl/?=
 =?us-ascii?Q?Bmw2B11xBW8cOhOBB/C03wGcUOsdJzVfI4Hkd0h3hT8D/WX3qscAF7nS2kmH?=
 =?us-ascii?Q?NYyvj032326MBJ3Y5mSQtP8VWPVhcfpgAZBdjOmdsbFbfhgQoKNaxNeWHfrV?=
 =?us-ascii?Q?eWAju74Eyl1hzOMqpe5prdZYtA/nyIoeT/XIRtno1lIRWiIV/HUZp5OPvQjH?=
 =?us-ascii?Q?2UaqfUqNsjBKn28ojtsdkVK5EtoDKbXPgd4PBB4rkdR8apsz4v6IhzbZIrWX?=
 =?us-ascii?Q?g2VqC+/EE2CizqD/ySp38D0YbIubIyDnDO5io3/Z/G2RwrSfokj0kzDdLDPA?=
 =?us-ascii?Q?A9+O/vXXxXics7XwW1K80xx+1F9AlP9TlTNjLd3enu9MqvXx2x+D4nOBIka5?=
 =?us-ascii?Q?ph2puXlpcu1Tv9KHC2I5oDrK80RrczCjx53R0/4ziQNXsc1g49R5qO4ua4yT?=
 =?us-ascii?Q?1QxSRca7rdNC2LjjevnbxONXnAUgGPLyvX8FfS5j8qhResNrGAXSQl2jKnW0?=
 =?us-ascii?Q?/bmUbNvRX65MM8T9Ay93V9HtcGdHX8VdgpOngJ5XnZgO+WfDbeyGcTBgQpPn?=
 =?us-ascii?Q?ZrRuZLAy76JdmcNDjIOQHmqa85d7mySp2pvuWtyovciI+ZzV7IvAVJnPUG7N?=
 =?us-ascii?Q?jiZ2wrR0S2PcXa2CCodV9Jjo+lNmroKpAzKGOSQSsnh4pH2KZnbj7GvjPQau?=
 =?us-ascii?Q?c1rSlh0zOn80ugXInbxug8kVmwV/7T+xe+YK+cds?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02582768-0acf-44c7-a62b-08ddc52f8b09
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:43:34.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVHpIQ3oB1iXM0c72rcwEfk/78+SatkMslSfrxpS4uByopBtj5QmURbKVziivQaY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099

On Thu, Jul 17, 2025 at 04:28:15PM +0800, Xu Yilun wrote:
> > Seems to me that two DMABUFs is easier than trying to teach DMABUf
> > about some new attribute..
> > 
> > Userpsace can unmap all the shared DMABUFs, do a TDI BIND, then map
> > private DMABUFs. DMABUFs do not change from private to shared on the
> > fly.
> 
> But the shareability of each MMIO pfn should still be recorded at the
> time of TDI BIND. 

> Shareability is not only about hypervisor can map the
> MMIO or not, it is mainly about Guest should access it in a shared or
> private manner. According to this KVM map the pfn in EPT or S-EPT.

Yes, which is why having two dmabufs might be nice because you can
plug the public one into the EPT and the private one into the S-EPT
and SW can validate the right one is in the right place.

> For MMIO, the shareability layout is the TDI's inherence which can be
> get from TDI report. I.e. some MMIOs must still be accessed as shared by
> guest even if the device is converted to private. So I think a private
> DMABUF without sharebility layout can't support the TDI case.

IMHO this even more strongly says two DMABUFs. After binding you'd get
a new shared DMABUF that was limited to only the actual shared pages
while the private DMABUF would be limited to only the actual private
pages.

It is much simpler considering the current DMABUF APIs than trying to
convey per-pfn shared/private indication.

> The existing shareability layout for all guest memory space is recorded
> in KVM via KVM_SET_MEMORY_ATTRIBUTES, but now Sean's suggestion is
> giving it back to resource owners when in-place conversion makes
> guest_memfd fully aware of the shareability layout.

I would say this discussion is irrelevant to this case since we are
not doing any kind of in-place conversion.

1) At VM start the VMM gets the shared DMABUF and maps it to IOAS and
   EPT
2) Bind request comes in, VMM unmaps shared DMABUF from IOAS and EPT
   then closes it.
3) Bind is done
4) VMM opens a shared and private DMABUF FD and learns the valid
   ranges in both DMABUFs (ie what PFNS are private/shared)
5) VMM maps the shared DMABUF fragments to the EPT and IOAS
6) VMM maps the private DMABUF fragments to the S-EPT
7) Unbind request comes in, VMM unmaps both shared and private DMABUFS

For all error cases the kernel revokes all open DMABUFS and userspace
is expected to close & reopen them to recover.

From a KVM perspective when you tell it to map the DMABUF the VMM will
also tell it the shared/private, which is basically implied by the
GPA. There is no "conversion", userspace will destroy the memslot and
create new ones.

Isn't this pretty simple?

Jason


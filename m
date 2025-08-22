Return-Path: <linux-pci+bounces-34559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C2B31951
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E681D215A6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35812FFDDF;
	Fri, 22 Aug 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SNzuNlO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099502FFDDA;
	Fri, 22 Aug 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868905; cv=fail; b=IXN2SscA+LjtC+Y2JfieDxYU9oadsA8JPe/uybgNLiwR+oENA3mtW/cqIZO3fije9QVXyHWEdQGVxiBrTKMWKNE11rkYvkk3+HwbJl4EQnX6zuQ+sWXzs160znaKqdPjseNLVUqBkz8PEmtcoNhK529omsmmIoJ7gATqgPtEk/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868905; c=relaxed/simple;
	bh=Gusokgt12KzwJfIUiL0NHg29sURn78VJrZICKHVmBzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WaUfbRhVk8ZukMmxNNdPZytXooBCb4C1eN2nUN/iPPXb6bcfAG8CTMuZco3jep3aoeLPVsxJcxlFZmngxQkRHIltoTWos8wx3DbCZIzka9FCgQPdWC/YcaUJJPboO08OxeM0I0X0JuEhxN9c8rf2n5jd1aWn2+yq7EHJ92JHMJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SNzuNlO8; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCbyq4Z/JF3+WoYNuyL2LEq5pCoPTeBPd1Afb/Qdrd34ZK8uypSU8/K5/dMnvhjB0Arp99jSnpcybx/IBsZUIAco/1qe9SU3tj1YZw82kyD2LNoe1b4fFNUSX/AaqMsx1sROHp3dclOY9EAdHEpAT6av0MNQWe7ZKWkz8piYEW2RFDWzApuWquxdF2ayqV7yNqnCxAS2ZB+PweHG7OoP5Mg2n/yLew7/N3Kjqw+2QJKKGx9vMLF6ax4aZvStFKCqEfBIuQyOdLlQHQERDM8wllNzKMfsrlqDLJYX9vh5nNP/zCDM6F6TukkOIsh8kxcy1ab9ctuk/9Im9pYpUPvzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF17v9PsO6nl1JxfujORcyOmP2u2wIInPza2eoQbeIM=;
 b=fdl0PEcpwmKsToWUChhGptULzRJ67CAU0NhnWM7F7gYxnR5pc8/9YtrBiMKhxWrm0QwAnck6PIa2sYTU6KpcAz5Kis8OA899bTOpSI9xaYQYPwveFo3+3GSziHw3IoF1hI62DFVVDwYszoPkjSbGXbvud4Jd4K9etQcLTc4eJ7E5atth8xYClLU5nQvaLtqjk4O2X4Hj/26R3w4nvourIlWDDAjxeGt19Uuh3ijX4Gf1ykUPhNunvLg4HphHa5X3pADX3uXD2+fAJu0Wo1BYkxKq+U3yt/+lyJXQxl+DkvjQPlORWLfNPaJJbgEJVrzUJ8dryP74ATIDRwsntE6NRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF17v9PsO6nl1JxfujORcyOmP2u2wIInPza2eoQbeIM=;
 b=SNzuNlO8JaFgeWDalSiMYkokhSddPACjN2vaTQSWvZCIycvLJ2vkKVg+/s7jQyc5nrf2FXCo277Hw0fMnWV2mtNtquXsyApJX32SOxCDUYhLn8Cgg0PaVUuUbD4j7lmj9N97r8Ebz2uW2TxgIMUpsHorHQerVWNp/Ib5lDoeGCrHvkYcEYCvQQqdXsjAOu2zt5hIxT8JQL1xEnQ/yudCUe8tAr4qjqH8bksvnBDqVRtO4/MzeR2h7OEhjRbG/NjIV8BcSxf7ZLEycAWzDWq42jpXSoJ6Vq6i5sZyBczkjBE/VVMXhJVGD1FqG7x8uwypmFDBl21XuIOVOsryJ3aF2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 13:21:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 13:21:39 +0000
Date: Fri, 22 Aug 2025 10:21:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <20250822132138.GD1311579@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
 <aKNhIr08fK+xIYcg@Asurada-Nvidia>
 <BN9PR11MB5276262E1925E2CD8AE037EF8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250821131426.GN802098@nvidia.com>
 <BN9PR11MB5276A95E69D761271953E9F38C3DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A95E69D761271953E9F38C3DA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b33664-874a-4945-9053-08dde17ed3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBNn1j3DH8f55ZDpoIE307x9GRGWl7FB55YmJip+cVj09+TJck8UVSRETBli?=
 =?us-ascii?Q?4EG8k10Ce32hKQPD9FVz6BVnr/mHYtRO9Irkb6aKABmXKRwQnuaRnATrfcGu?=
 =?us-ascii?Q?hzyHKm+QyACc5KsSc1Tvb1JsjYXExOzviqyNC9jLNTVSjE4E7nbNNnFkxE0u?=
 =?us-ascii?Q?RhmzLvzytxEoez2RDHZxQuXdNoq7XVJUNC334R/ZJt79fppCL5ZOTFxCyv3g?=
 =?us-ascii?Q?2poS366SGNL+SR0en1ntyBWRG2102sAF87FC5e/fCX9u0q/EZhqFFDXt0s8n?=
 =?us-ascii?Q?ASebB5PYYBJB2CBJLl98JYiHyLRpViOwNOvh/eqXzHbOP9k/2a/3ddkS2FXj?=
 =?us-ascii?Q?I7sOghUNyigp8ryCYlGqJU4BN0LJAfKmPCEUTVPwbLGduHYjkHEu09ljbYRe?=
 =?us-ascii?Q?recEXCU6IqrC3ZvcGG/IH3+P/h/9frhNUnCUatuZ5Mgl6/tgPoMW1Q+u2roo?=
 =?us-ascii?Q?B0rtafo0wNOq3/qiMYd5EqxU3qxgrjAkpmzgTKRRzh0EErWcWpUhQyxHROHX?=
 =?us-ascii?Q?Ynr9LbljHtod3wj7Ml15abjiy1axUrOZt7Hpt79Ibsz3AAl19r3po/Vm4EuZ?=
 =?us-ascii?Q?jMxYUuK1GegFopkPIz4IQFWVw6klA0LEDT8a/4K6vfjhZQid80dN8ctqhcw6?=
 =?us-ascii?Q?mN6rmcRPFQ7gBLvCOwNjvrRSliIO64DMeFdnrdkyINCsCwg/DzGx85Yvb/Ca?=
 =?us-ascii?Q?nRk6ObSm5Ai4cTdSmb/6jwvuggCJ4JBA+vx180iDJHCySG101+410K79BXUA?=
 =?us-ascii?Q?B35P8aEbQ/HsuNFWAkp7ukCG+ZFe92VeelEZ/pMQ73IHgXOs1WkdMlwmmNZD?=
 =?us-ascii?Q?Hy4YWPu32ZuzrDtk/65JFevkEiHbBbjMkQyXeU5k+gwcKMyyfwN89YwQfDVT?=
 =?us-ascii?Q?WAs3ZE7Fj9wJwLZphBSRFj8mEddK/FwrbcQRpc2BVQuiG1CPmHgjBQr+W+hD?=
 =?us-ascii?Q?+EYBwy4gbhJARURLtDxMqAgFqtlrdT628fo+8MPGSl4zJykStmEgA8F3ssq1?=
 =?us-ascii?Q?4t+oEW+pld9hWF4rIeqLd8Qtv4ZwJZh9ln+lkFG1cHJOk294xbQUhzQtDyNF?=
 =?us-ascii?Q?g4KsPRKCQ8OYjUHCI47DLI6ItM3xXCVQA2ahVMwpiTLyT5akoDOAwxY4EV6i?=
 =?us-ascii?Q?MH6mE4Ryat3tkw5Nieh4W2WsdVGbOo4O4j4INWwHsFLnSOKyir1ESwyaPIEZ?=
 =?us-ascii?Q?r22FSJh0M0KM0NYuyCPilXaUS3hJU5Ek7hQHTZHbugeF+UXW3ZjDi2c7bwpZ?=
 =?us-ascii?Q?b10GW3pKDVDZJcSV5WrFx7iVNtofSohNNUe8YqlptaQDS3eFfws0VSDN+H3x?=
 =?us-ascii?Q?7DxF3+4itg8otwLa8u7Fmng7Eblm2DNXMGsacIgn3rKV8tMOp+XmDAlkGxat?=
 =?us-ascii?Q?LBcoU6jPMXarJlnTaLHVmUsRo0ahOErblxWs4gsLosOlxIWvGqkjQc9BXC0w?=
 =?us-ascii?Q?FbSSJaRP4TE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GB4H8wFrUml8TAkniby1bicXwu2ln3Sn8iP5kf/t2CZd02u5ZphwiZ+ihR3O?=
 =?us-ascii?Q?X1YAC0FMtNG22y6Ek+WWppnx3LOa5zdw3Y4w/qQ0h23VzuclLiLv8ywhHgGa?=
 =?us-ascii?Q?djGAoUhT5/wuuz2V8JGD7VemJUB8dELv69G8doVkqMLHrjijfA/YzQ5gg5BU?=
 =?us-ascii?Q?j/E8ij+mxedCtrQTrg+uqoLJy9yJp48zva8jFy612S0xUAhJSlfN3oEk6Ulr?=
 =?us-ascii?Q?3v35/C0kko7wdpxDV5ru9m+ybsSnWjUR/z87dV93fb4BLKvKAMuoONmiRcgg?=
 =?us-ascii?Q?iozEzBJHkMrkxJwTV6ydQakiO2wec1SgaA8ADTX29hIKLhdZ6s8QujykkxBS?=
 =?us-ascii?Q?+wYk8NyxIUf3PcaWwYESv+8A5JjKRsp4ZrL4kDJE2vQyrWwEQDZ2nSpkCKof?=
 =?us-ascii?Q?IL6yVUqyi+WClAMF64yyDvrV+BDXNzdK6rdVXVzT6LPmral9t1UOJ/C60RIZ?=
 =?us-ascii?Q?KchrAOZuScYnggqIZy3xnxPmSm0d+QvGhhl73c8cS/hzKtVQZucXQp+o68Mf?=
 =?us-ascii?Q?CGqR6kEUixFuH+u1631WVWJvYTOhZCTZTusN37ODA7ACiHm6etcCoqgUovI4?=
 =?us-ascii?Q?ZAp96kJKQuOs+oJS0jRbVY2fCrPV88kNjjwxDu9NmKunDpvTFe8Nnhmu6UjC?=
 =?us-ascii?Q?FlhPkt09u5RmbxUXabB93Vutrj0lVAYYobfb7Phabau3lG8l+MtLJ3VXF14H?=
 =?us-ascii?Q?0SLsL5sSXw1hOFBZOwrEHozVPKgIJAvzj0Zz8s2XULNe0tyQVOstj2zTV+fM?=
 =?us-ascii?Q?gxjR/WJqvkiiEA+dcjdgny5tNXW7oo8jqiK3bQwZjugR+WkiP/U2GjY0V5xE?=
 =?us-ascii?Q?U7HRlA4ZjBQlppHoD7G4PBTHuCYnizLQxfZJj55QM7Two53ko+gAVjr4bNo/?=
 =?us-ascii?Q?h9pod1VG5iM+n0VkdkLEcSlgiUic8I1Gs0SUcUfU6nzVKDgOLuJj08ay5IYY?=
 =?us-ascii?Q?LYgkdqn8/U0HPv4oSoSBuaFq9DoYe8g/FDLM0AR1IyQRg+n3Hw0+La6P7GtG?=
 =?us-ascii?Q?LMQ/B9vJz5VbWXq+ZS9fmpMDW/J/DiU7KTdDoaeTCnns3kJzyzzSttfFN16K?=
 =?us-ascii?Q?aXkM9rSvoqZfG6XHafIgQStQ9GgRd+dBEs7+Lfpe/39+FSx6psUd1eXqFP6h?=
 =?us-ascii?Q?FrqwrZ+ps61z1M9qMrx0P/uUOBVcjfhwotj0jVThQtF+T/SY4p8FDqoTPmpD?=
 =?us-ascii?Q?3VEbHBt/bpZ7ubw2lPe0W3T3I9/lsIKyzLLHSiutUYyFG25tmHHYi1AYuhWu?=
 =?us-ascii?Q?vjVQhnPm4XKsilb6P7ZnkVqIQdU90SYHcF/P9Xhn+rLWs7yUwjNmNYT7Elq5?=
 =?us-ascii?Q?2Zj/tAON39LvosquHBrIMEJXuKT8475EaH3l5FVDsN0Ry0x71gRkkVSMptoK?=
 =?us-ascii?Q?ijnki9EzA4wxBwsH+9wzZxvAjmSS2d1rls8cBoWRwMC+pxrrmbUkREPU9YEL?=
 =?us-ascii?Q?utbEY9CxdHVpVV8OQS9gcsuH2x05tjgZrjWtTGOb5dee86DQ4rRU2LXBVdwi?=
 =?us-ascii?Q?2cjsHsmlKhr1CNirxpTN4cZc+c6pcDMcwKLtdaTGpEJ5xCZWEH2CZ665MBav?=
 =?us-ascii?Q?GAvuKwXUWVonlfuwWE4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b33664-874a-4945-9053-08dde17ed3f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 13:21:39.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FSJVDdVJlnR2p9pcrp8P8K9Q0/6TOBFsskBcLSzEX0Grbm4BtSiXKnG0bBYZ5MM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

On Fri, Aug 22, 2025 at 09:45:28AM +0000, Tian, Kevin wrote:
> Thanks for the background. btw is it technically impossible or just
> not worth of the extra software complexity for no value? 

Unsupported by HW. It cannot mix S2 and S1 formats on
SSIDs. If SSID is in use then all must be S1.

> e.g. if maintaining two page tables (S1/S2 formats) with exact same
> mappings, does SMMU allow smooth transition between two modes w/o
> breaking in-fly DMAs? 

It could and there is SW support for that..

> but probably keeping two page tables in-sync in transition is
> already a problem w/o proper locking in map/unmap...

Yes, plus the doubling the memory. It is not worthwile there is really
very little advantange to the S2 format.

Jason


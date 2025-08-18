Return-Path: <linux-pci+bounces-34218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95295B2AFFB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 20:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAFE1B256F5
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE732BF34;
	Mon, 18 Aug 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h677yzke"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2232BF20;
	Mon, 18 Aug 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540567; cv=fail; b=qoxcQQu1VtIVNsBIB4VTYfWXGR8/p6vp8aht+O06B6058neng0TRLVCNwgLjciXqkrBub58Spc6Vj8TtXg0k23o2YYPUtHF/8L/DxkhUYrPkzyWlX2FyWM7ICX//i5ZgsTFaH1rkHu5O9H+ag3m5ff+pOfYp8LnJdT6R0dlrc3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540567; c=relaxed/simple;
	bh=TrWI1iIP47e+WBL+U/DeZzs1i49STc/Vyn2ojCDm8BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Txs0olcZhmSIb1FgjNfhucRiZJji9+PRw1kc7np/pINNGDBKXBkW9f8hPcoemreNsWLfJclP34BP0ExgTOGlW9go5dhXugQ/gW6/XkM4fvAx0TF96pXfjKeu0JjOygBIcGwN4slWlVYXGqbU+ydbTYmqzRStEpsWxyt3QWp6xtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h677yzke; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+9eGUCrXocarSB+jhEvZUv4w+CgNfuqH+vJ5Wxxr9gOwsuOi4ynHfJ9BTnYlEFUQkUC1AW8/YArUBx8g+hyjfcwPYDegyjp2spkUYJTQrbonhHlJ8e/mboYz3DYyq5HZufWvFXrd4hEHu3Tb+xoPYGA/nxffDa6LHn0PaszdZTcPBhoKQA2o0Fx/73bBe2iQuWZGmlrpaJvQLtUNrH7dpuCr59/pkbgNOkk9HxmX/VdKIda0HdBbClNberYnTevM2ICEpD1heVfHyNToJlexXHwENt+2pMnCh5oZpZXt92STUJNGWrzu317ZwoVX6oIYCBZIsb7CJ+Iiycn3T6W2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1UnFGEBDcWBBOIouy7wxm9/WUEyyx6tNv81SW9AMvc=;
 b=duuA+yjbk/ZTiin1GSL+ez9AsmD0Eh4y2a/fjfnn4M/R72M3vMfk7B6aqt5dHKA2hPpl3wChHLYaNGPEcyRp+FNVLtBRP9aIzk7V2PjbTz+8/3jETS+Iv8FAjT7O7h4c0DFflTEF8N7SqBi5WRohD0P5YMl0H3JGnUDdooh2taeYMmqoQ/BZfQLlGMSrR+mHR3P4Ty7NmPNtOszRxNRjDHsnEEyAct9JCv+ZjJmENeiRv5JBI+d0jisIhERAGEl69Pa5XvokMtlHG94T0IJdoeUp7ykD+dVCYNkCmctw351jM/7o+E1j2IZoZk6D5/lmWcYbB8ugkcaJ7w+s2qV8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1UnFGEBDcWBBOIouy7wxm9/WUEyyx6tNv81SW9AMvc=;
 b=h677yzkeJ9ruNLVjnoaCuPqZvkFcVaPSwv/jBxEJ/oZ4D08p7R5WH51NSewfG1DzaO7gpvxpZlsAfJapT7R7jh1ku9sFOfaN5TlivcSFWjjVoMsrr8P97wxi+jjuIShv2aoHt1FPKenCUEHjWvsU0pLJdkHQb1XKX9MuuVBxS7D/31NQ5u++K1CU3AyV8f0N0JG7k+BQiA1QgBdl7yyZCzRJfZ4zNgsPC65r7Z4L9/DJ9sh7ntrhc2jRv/w6ckrWcfbrVSyuRWwYY18Fu6pa/q+rMxAB94Nuqcdm3tRwl4wdOmtNfuS98XlwT/tDgieC6zxcbYoiLvjhu6BtwJTFOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:09:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 18:09:22 +0000
Date: Mon, 18 Aug 2025 15:09:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v3 1/5] iommu: Lock group->mutex in iommu_deferred_attach
Message-ID: <20250818180920.GC802098@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <44783ca52e17a9ca0ce7acfe8daae3edc3d7b45b.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F543286807E05FB465F58C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250818141751.GN802098@nvidia.com>
 <aKNmo/O5aXb88GKK@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKNmo/O5aXb88GKK@Asurada-Nvidia>
X-ClientProxiedBy: MN0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 161edef5-ba19-43b0-bf6d-08ddde825b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YJj1WPhY2g+3UObwR5ewVx/DLEibRMRcuxVEnqlFTExjMOQ7fSTz0Z07FQia?=
 =?us-ascii?Q?0HsgoDrWrv86YI1C0MF/q0Ayi7mTHvyUZtxrh1NEd/xbBxjSEaK0wv3mChVb?=
 =?us-ascii?Q?JbXH2bYvgs2gJVPAr841Wv2fenMvty8ZyQriWrBjAmJho+dxmYYPKy6Iii2P?=
 =?us-ascii?Q?J5UJ34sL12chUPM6KtvhvCSqJSa3Dc3zeX+1u3qB38KzH8WElb7ixg99qpol?=
 =?us-ascii?Q?wo3NApVElKuLPd0nmnjA0gyDwb0Y1BxlpgMjcI7KeoGjUE0Fl6gMXM1HLkqG?=
 =?us-ascii?Q?G1jfviz02dQiRic6KggKWmAjZC19c8scKVnaTql5J90JCQHP0oWPXwOobt0r?=
 =?us-ascii?Q?RK3fDKa1eCWw/Dv4gDxv9zmGua9b+IytbAbbvG08efaFgdoGIphahEQsDWW9?=
 =?us-ascii?Q?X/DjEDkSSLesgAINtj6k1CuuFXJlJM7BMauVUjuMKWCB0UTiDerbbiCkX20V?=
 =?us-ascii?Q?LkmCAVELztFp420VqRzHDZ3DF2iTtQ0LxCAVeVvxQcNTQvT6u88u5OFj4M/A?=
 =?us-ascii?Q?IfTtS9pajwFDUO5v1PhBdNWo0zs3zWRbTCxoUhskjsPFLI5U73qJOEUZrcCg?=
 =?us-ascii?Q?OweMG0BHbrPoRrdvDiV5SgLN0BzvYAVAdUhtjIMy+KPAs2x9LpV7QeXGThPO?=
 =?us-ascii?Q?lAaJAcHt791khoskLE3R+GBXN+R0Jl+pRuMPPQvUSEE7R3ZW2lgNGSTnE5pY?=
 =?us-ascii?Q?m5BQ0PrHtR3PV0kPkrd9Ib9HyxhgI0s4xA4kP3c61UFJKCO6FUhNVd9EzZ++?=
 =?us-ascii?Q?NCk51UmEqwwUjzV6vlfUy+GfkQj4hscD+VkXbUhMbkrAtOarqDijpJA25VGs?=
 =?us-ascii?Q?sdXcskkKyhB8Je2kyBK49061SThW32GOQJVAT/eNsFRdhXz51PvyiVWHvw9U?=
 =?us-ascii?Q?JcR5ESv+G7JLaro+bMlxLCID8crIBtRTynFZxynqKkY2ojOyt343Y7Wts7ad?=
 =?us-ascii?Q?yJvYM3yTHXffV2BlPhluwijViTGyTx7M+3shiK0A6kW3Fs7lzVGw3sdOaGby?=
 =?us-ascii?Q?Aq4g11wJge7mZbIqdVLrchVFeH9mBzfL5LWryuPqE7IT8AZ8ONL4ZjH+62ai?=
 =?us-ascii?Q?or7XU96mYM9fGTd/pKOafXeEBCagXjvAtjXM5ultmE4goXE0lxp1P9owrTNW?=
 =?us-ascii?Q?Iqo2jvCzN8fKWMgtzFgApRP8Tr96rDrXtrUNU5+1yAQjneBRvf2dwbtkyRcy?=
 =?us-ascii?Q?gOvN87r8IBEZkJXCUT0gLe+uQjzkbbTy2sHr3zm21AHjWsCLeFv46WxJUefH?=
 =?us-ascii?Q?f6d7ECP01OE7wbARZQHDzmc9Ot6ChIkkavrW19uFnLOoEkvN3edsZCSkZqnV?=
 =?us-ascii?Q?bl1KrTv4WlzcANi51ZpWsEI0y4i4o53zNzOQO8zYSTMeeq8BwGvRPjmCKawr?=
 =?us-ascii?Q?g7uL6MoO4ngm7XWwOWUpqS6HMYl8GHYAeQcGNUS9Iy8Ncaq/dUJtfGPfSOgF?=
 =?us-ascii?Q?V3sHe6CF7YE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wq3VtZii0rFLj6l03Cm38hOF9iWM6XO4u4Hh39QWaRQ88YP/x8sma3/mEueu?=
 =?us-ascii?Q?k2iveSOJSbOIX4LW6+1Iz9YVL/7Vu1rXvkOnC5XeQ4JG28np4v3nABlHhY0C?=
 =?us-ascii?Q?wkwybTD4TmHbFkguexfVOzwkeWw46S34x3s7BoVOrwqsLKM8BYls5uZmmpMS?=
 =?us-ascii?Q?4dJKxkizFAsn0W26jOZHgt2RHWHUj8LD0Iv8gwHmG7MJD9HKenF3gj5iHzJQ?=
 =?us-ascii?Q?LCb7na25bKx9ltOC9YUreyCBTyKi2Xok0ym2KVJKt9IrB/ATVpkKj1Uvps0f?=
 =?us-ascii?Q?9WzBypCAsGDJAiTAcla42V++rAmIQvyie60DLIUTNglmFvdtYTKqYbwCmQIs?=
 =?us-ascii?Q?0iA1AAxx3cWSVIR1LZAkrTPs6incOIa8Jf9tor09uW+kzIMc0cSqvfc9F8Rn?=
 =?us-ascii?Q?Ur9FCAPdMv5aHpjqcJrWJmKaXAeTZvgpVXRyXxWkbBHMfNxbH8NN9Yhap8UJ?=
 =?us-ascii?Q?vvVRB9TsVDdsDL6L07n2IKhYaIgvafeHcwR776B5pFsH1C7q76YcfYtz+e/X?=
 =?us-ascii?Q?c0AEyblDmFIGTyInmTdQNZauEl16W7FzY9AhzxmodhdEGklK511cI4ETV0SH?=
 =?us-ascii?Q?4vbKJ7yF0po0zqn+1cwoKZa/f3oQ2hMMR3gVhCaxKrQDG5X0zLSnSLIB6PT6?=
 =?us-ascii?Q?hX4JAZUICycLBqgJUDbtA9XxbCuNm47nKaIPLCECXtbE2k04LMpijzW3oOIi?=
 =?us-ascii?Q?i6RbLOrJqXD+IFQWsqHqM5ifLk7Tn35X1f6YbAA3FB2hL5PqMkSFJ+rqK23e?=
 =?us-ascii?Q?kVUBFD+Xu0XXNuxLEQ+DYhCQHeWTcPdmVfC9XMsmgLgIfrxevWgx4uFuBOKv?=
 =?us-ascii?Q?JGcrXcti1E8WdT3SO+0VBbWA5CJzY2ehyFuTZfb1UOz2m4kitOVnyBjb3L4P?=
 =?us-ascii?Q?pg7YKkmW728DTQG/NeuNReTLXa2+3H1gLONq7V3oZAuHJmN8cASBXzusSeeL?=
 =?us-ascii?Q?gx8p8P+CMdC5kani6tKpUzrn4U5A12Z5ylSQbLFPaPqf4a6AL7oMCDHmGejL?=
 =?us-ascii?Q?wB7WFwdixANRSmfRZzGMoyN0cC9N49/XrKeIWSvVzlVTTA6DQ/TRpEaG4RUS?=
 =?us-ascii?Q?/+SzBPf++DOezEyoypNrMrMMqdsxJaHIpySTdWwX3eKqulRxpX67Wl6B1N+J?=
 =?us-ascii?Q?OKGCd+fJ3MoHVepabPCs74t5oEpz7mcMs8XbY0IiKH4/qKlC6LDJ7AnPWkEt?=
 =?us-ascii?Q?zemdKVCXvQV9bXBKFtuKkmh2K2qCkV8KbZEoWSnS88E1n9U7w6i/8VRYPx3Q?=
 =?us-ascii?Q?NLkBllIWjGYCrem5nSMx8G/M3X7Yrn3+uBVcwA12JQcVfXoMHnTqBjH5eTXl?=
 =?us-ascii?Q?8vFH2RL6YNqr0Ma9fTt5oK85A1iAs/PXgIRbuHy7ruZG3vkH1ycB2/SkQOAJ?=
 =?us-ascii?Q?vnya/OgMpqEiOrmhk0WYXLgwv+L9mE7LhgFewmVdUHrRfc1/Gk5D1mv3dIKn?=
 =?us-ascii?Q?WJgso/rcu0SjaJ+HC9ySJrwp0SK3V2jDpZbqKP9FhlsHDTwVqIjinMJs72R8?=
 =?us-ascii?Q?WPNmW3pN/333WN2A6fk5a3bVgrqM4eSPiviCvUUFvBWiEGojiEMqAaT+vamV?=
 =?us-ascii?Q?9HxgA9HQHQzuVvDPEZg4Tysqrd16qoOUIIBEaHwe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161edef5-ba19-43b0-bf6d-08ddde825b80
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:09:22.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pwIWh/MpjTjezoeIzb+egeFnV1fvj8+IWBkvERpMifma2GyClnObENYDgxs2hRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572

On Mon, Aug 18, 2025 at 10:45:07AM -0700, Nicolin Chen wrote:
> On Mon, Aug 18, 2025 at 11:17:51AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 15, 2025 at 08:24:57AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Tuesday, August 12, 2025 6:59 AM
> > > > 
> > > > The iommu_deferred_attach() is a runtime asynchronous function called by
> > > > iommu-dma function, which could race against other attach functions if it
> > > > accesses something in the dev->iommu_group.
> > > 
> > > Is there a real racing scenario being observed or more theoretical?
> > 
> > I think the commit message should explain the actual reason this is
> > being done, which AFAICT because the new lockdeps added in following
> > patches will fail on this path otherwise.
> 
> Hmm, I can mention that. But I think that's just a part of the
> reason. It still doesn't seem correct to invoke an attach_dev
> function without the lock since iommu_group_mutex_assert() may
> be used in the path?

Last time this was brought up there was a bit of an argument that it
couldn't happen in parallel with anything anyhow so it doesn't
technically need locking. But I think we should not make such
arguments and be strict about our locking. It is too hard to
understand the system correctness otherwise.

Jason


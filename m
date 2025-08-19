Return-Path: <linux-pci+bounces-34298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848F5B2C43F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA1F188846E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B415335BC4;
	Tue, 19 Aug 2025 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UNuL3mmT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D11DF74F;
	Tue, 19 Aug 2025 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607977; cv=fail; b=cbvM4rqvYmlFr3B7sNq2JQMhcLdjcrT0HNAMMIR4CYCQ34PTKTx4zkeJiAc+zhzi+SWGRM1zRtIGkdELA/P1vj55UXRBsuitG5A2Of5QkjvxQzfCHfogNmwZn5hFOBvOA2eAKBhk9BQL0HqOmVEm12BtmiHSmtFxroBAgHbWNik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607977; c=relaxed/simple;
	bh=46maVMNXvRZJmPfmszn0giMe/9RIsKyKdGmdLwFBhJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J53TSAuZOE4nQXJ4e+sYv0de13xiEHh1ggQ+wReC0Q5noThazfrOy23oZcWPGf8xqUNwJq5WuSHpUhu9iVZfRRsDj+/sXymMz7onV+X0hS9JoYWDqWgmWGnhvlhIEslmf1ek9jZ6SEWqk2GhGoXiK2gNUcni/LNkwA4Eco4aWKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UNuL3mmT; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoEBxnDK+TRilACrrG35cvQuw1k2nS1Vodi38SY3d/UmRR/Wh+NSkghxWVJqaVsVMXpzUS+LpN4QURp78h09ehbL0EvPDGd1JfnoqNG+alnFkIhLenBMyWhpFLXy2YiFQ1KlFV7eFpXZHlRJRmT20zoouSgoisP62mV/hRkJ+ujeqxvAe5xt5ZVb246w01Fe0+ZIntr9S2H7DoWBaEC1xpENeyuCRF+kweMwC1D5QfKl4WZm0XDGk45eP/Xzfr9cTtaj/JNOGHo9yqQlQVtYUu2GDQoZAfwub7DaSHoh9SnNUafrNdO7PKLlvKhPexHTQYiRgJPXR8WO/p47nvuoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0WYBkpfTmAQ0ngXdQSeH11u9Ngezm98mFsxEeWTqnM=;
 b=olGRQpN3z03oyHV69TVNThaOx0eZZKXZJ1cT0xgaUkfKTVyJEba4gEpcjf3wI69dNez9gkjEm8CY4WNS3f/mHCqza29QV9h1D65d3H7/XBKAg6xInQoLS/LEke/O07tpEij7ImR9d4jbd2545JxrZKzHSqDLGTwwInB9fieM/sNu5w6xXOP0M0gPBxSUFScaL6nHa9w1Tc9jD+GXaIsjSpoeNoSVA6/veil0jP2PefvXvuJUAxqv/CWH5U1bl9lqUMuDM4ykic6IFGxLr74WgdmNOzGPtOSL0TTr8rflSuLIsAO9I3Tw9OsjQkbWv/FLabIdsPj2eH9cN8Yac6CNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0WYBkpfTmAQ0ngXdQSeH11u9Ngezm98mFsxEeWTqnM=;
 b=UNuL3mmTL7yBbvocaZ+fU12Eft8djdt1L7zMcKh+iak8APo2M7Sw+DUyXu88QjvS6dQ1yNq6Psa9e+tGn22AahjpLHdy2J947VURyOchWzP9ypq8hZc7wzb6Fb3FRE3lRI5mAexgXIbjN2TKAnEcRidXCxK2VY7jC2HD9hGBKQ5AyA9S2fLYpskOK6qjNlB72Lb15+mFjJBpC0ens6OiSDCxDKVO9PihrHPVhevYfMdwpH6GLyRV2V4z1do0FeJqxjW+Ld5LVDYUQDqbuZrFJKOL1vRXE24dmerbmPkUSo3YO5E9BKYjrLtUZYQEfx6TQc4/g4DYoyXvjap5DqMoYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:52:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 12:52:52 +0000
Date: Tue, 19 Aug 2025 09:52:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	will@kernel.org, robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org, etzhao1900@gmail.com
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <20250819125249.GG802098@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
 <aKNhIr08fK+xIYcg@Asurada-Nvidia>
 <20250818234241.GF802098@nvidia.com>
 <aKQG9/skig6F8LdQ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKQG9/skig6F8LdQ@Asurada-Nvidia>
X-ClientProxiedBy: PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS2PR12MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 50076d52-c356-4847-cda9-08dddf1f4ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9pOSJPylLQBfCOoBjDhtfIVpS56vFOUudv2OanJHLM1ERwS3434jVgafRVow?=
 =?us-ascii?Q?PJnrzWZvjLqNn+C3N0WB/uodI18o7ak+s7jSczDV2q6AK71WC6Ppzd/tZE/9?=
 =?us-ascii?Q?Mr071ytzOOLEoY23TEsSiBkqb6wMYPSh4jDBYWp8BiZ8xFLH9nyAXQIQyEMJ?=
 =?us-ascii?Q?CGeXY52oSEP6+5DGGwpFUgt7n3v+8SK9/AfMaNGgyhZ4g/rCoWxKTjHNGuCU?=
 =?us-ascii?Q?I9TZwrvIdMlEVIxQ/Q2vAhgC6dDWlCKAxwOYEWwAowCaNTitc+/sXv0PwR4E?=
 =?us-ascii?Q?QeE0jF14MuV00Hm87QzNUmVuiubCTVwuWqDsGmNZWCf8GrWySupzP2Nj+VvO?=
 =?us-ascii?Q?Fg7YNv9y7OTPf+WOKtKnEAq+r4iE9rKgI+vlywo3WT5DvkD6QjegZZWxgAHe?=
 =?us-ascii?Q?N8qqY06H8SRWRxVM4xtbM6jYQlihdE/ZlWRZN14KJ3yc0gKysU8BWNqEsx6+?=
 =?us-ascii?Q?gnMCBUwtzumWIgM6D94UGcJKHmXTHgXMO7ZPhDA8CpYLlin/p/a/50gf0Bo3?=
 =?us-ascii?Q?HAedMUPj5UCsIu/9uc80/vtxBOHl407AOPpE7obS9/zuW3IU5sUEmW7nxk9h?=
 =?us-ascii?Q?BjufX0or3Y/jb+vZk0wmNZsDSyGBNUh5PG7dfq0SzHT8xN+O2s5KwKn7kGm2?=
 =?us-ascii?Q?JshyirMGoWTxlqPR06zdiAHY9WLCD96osmNH630bAsbuROT4BWFnbx4sOy24?=
 =?us-ascii?Q?Y5dmXeO0rDbXqsvdtRsXGDwT61XayPwTBW5kMSuhVBHUBqzKoUFFgKYDKaA0?=
 =?us-ascii?Q?LvuK7z7g/MY8iyvrP0kDvUy/9XOFF9gpLRjytRqGgMu0cumrY2Yz77EitweY?=
 =?us-ascii?Q?qu+huJwOWEcPlujzCInmHmaXz+6CFekxEdrmvhfJIHBCdRCJIVIkOiJuwLnd?=
 =?us-ascii?Q?mM5IqEYnjnlnhbylwNrLnbcMJ+dL3gPmJBGwAkcuj1l9uyFsSFHxKpAyedlg?=
 =?us-ascii?Q?/Vem6ehQmBsLxvSvgpKkCpaWW5kaB/7Mj+ieNJ+az2855EliyUxZE4Vr35fG?=
 =?us-ascii?Q?vPMS6Wjc6/k9R01OXPeokIsY2B4IlVOnw5fk8p7L74BkeRjgHY2JFU7ddDq8?=
 =?us-ascii?Q?O40Cz5I8giIuaJWPZ1ndgt4uzVNFgj4IGYKNzm6MzMl8eNau0GMG+3sRvv+r?=
 =?us-ascii?Q?bLjIAR67rUPL5bolACZanfgLoaKKotJj2MeH9SBEGU8ilZgXOuiyK/yjdorr?=
 =?us-ascii?Q?lD0jvzp6VkHBkO2oUnnHXT6oKWTnxH/eqben+s1DJIt9tn5sv7aI5i7fPRKo?=
 =?us-ascii?Q?S4JbJDSeWK8s3To84YbWFXTLIdX95sjGM9b4hTiXfX4ITm/5lKzZM354Xu0q?=
 =?us-ascii?Q?yFSOc5hxAdz6AivMhYXSQ95fjiaVqwAigFBlSXC2a8qvwQeWlU3uzZrZXHGN?=
 =?us-ascii?Q?Rou4RZiPOIjoMQ8IFdixqelv5blO/rJAN4FT0IcFKPpA3AqbuP2dVnqzyKCp?=
 =?us-ascii?Q?uzgzxj82gHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VKG4/eAtNwg1Z7t97i40t8n/smI/1PrARTvORRZXCqs+7/0jlT8GBUKOVXRP?=
 =?us-ascii?Q?tI1mnYc5s+95cCkH4lmSjE5pXKtXyyIUd/ZjLtEyxSP93izDnYGx8PeSLfpe?=
 =?us-ascii?Q?0yxy/5nz63Di7KurRhNFT5quBVHRwJcRUWowzqHZ25c5W+ibTm+H1pqjqlOc?=
 =?us-ascii?Q?RemRCJgrsgGqaRbTLMCZhZs8Vwzms5QFWKVpa790G8F+5Af92uiHxaxwgWp5?=
 =?us-ascii?Q?q0XZKEMnK75NBZ2t8A44YbvwKpbPI732eLNrwI336E3ZNOeWdl9XdlYDpz3D?=
 =?us-ascii?Q?2ZTN+BmwLMetGAhobUpvATYvwlTZ4ET+72Aob/mGY5pkn10WLL3fzmNFuGLu?=
 =?us-ascii?Q?JZD3dgciYSEbbq8wqt6ghrn3Ibe+I8mAJazCgKHRkJ4ueLN23TheOs2E1a/D?=
 =?us-ascii?Q?orkUIghZf+b18O8mn+kfcG8fD4UBZ4n9WmPb5gFkYhjumefISzzdzGNMagbc?=
 =?us-ascii?Q?hxJCOTtGinzeV7Frz4uprbTUV8t8H7/e8gvmjzHo+iGdO63x3ph9pE1iWRt0?=
 =?us-ascii?Q?fVS470NleSoo+urMHnha0lwGVxkgR2wTAXnw+a8vH2FiKJoVCDbcjxwBVgHl?=
 =?us-ascii?Q?Idp4ytvEx7DljMZYz4QsZjNACYsD2ehmH/AsTs3y83aaVaiwAAwqSBzL/90y?=
 =?us-ascii?Q?OFCPZ8C/pM9ajJ7uXNsVQz+JLxpFkrDHPvkDXnQhkm6x69zL9xy/eXf4jVM9?=
 =?us-ascii?Q?i/cEYWcm68L/qIKRZCyxzU5obL0cVmTf6n9PumnmIlTudseG4jgBYI2t6OFD?=
 =?us-ascii?Q?KmxUV/DjyQmUOCVk8lvKateixKtPqPf/oKAB9hzbgJ/b/hSrKVykPOzvsZd2?=
 =?us-ascii?Q?shbfjHPtTBNFRKodrYAxoX1Yd7qRD4Fd/gmZLlq3TVI7TkCchWfAzBj7SE5C?=
 =?us-ascii?Q?Przivws5BLRtQRbyQX4pyt/jkz0cbJKHfNkd1hdDVtZLScdzkGXpcSuYqFHK?=
 =?us-ascii?Q?gA9mHEKlHOksAHTOSCRdCj4zciV1MxYglI/HbmrI1BbcXJoGfYUB7N8vMxho?=
 =?us-ascii?Q?iS03buqxrX8e3bEf9nLJI9FSMvVuhoODjQ6WxuYl6I1xxF68NIyNMI3f8oy4?=
 =?us-ascii?Q?PJ2SKCPA351IwGkWLjOZQyy6XRA2QdxgeXZrCJYw/Laxudw4MIGUR0BKr4iE?=
 =?us-ascii?Q?JWx9A5/DHJmqkh0M6MIbV5C8tX1ri7wfCRzgfIGtDp5ePk5n0JKDbtq6oVgj?=
 =?us-ascii?Q?Edk3aNESiVb3XPiOW5D7j95rvpVabKDANFENj3oHNP56XQCbsi5EpH3V9Iab?=
 =?us-ascii?Q?7P4vlnVu6YLE4MgsLvdGxi/DNCQXmEsutADplvwWppNb6ykxwzMRhdABptMa?=
 =?us-ascii?Q?zXFktKCbL0LkI310Z5FzfRcDB1PTWlKIZJ2J+XcQW//1uQs7F5zUy9t5Spg9?=
 =?us-ascii?Q?tr2sdK3SnHHQUWI/VC/d9IhemSr3ING+5MKJJykAU/anfOM9bOb4E0F4BC+E?=
 =?us-ascii?Q?ORAqp3sHaEqi5hN7rAUryit3tHm9g0pOjwxSJq3wipQhJepHAvd4tVNjX3GQ?=
 =?us-ascii?Q?ihSPTpIImWmaYwfq/rvT4nVc+YCd7bZiCn+37lKB9cBeY0bsOf1NBX0J+9sZ?=
 =?us-ascii?Q?uCSMjVKhi/h5fE401sSKz1C6Z5sPL33r2TrkgH1z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50076d52-c356-4847-cda9-08dddf1f4ef9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:52:52.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRv0RDvpt3B+ij8GgxSQ6V2kiIDVaCmmBqgI2zQZjgWs2ovKjOu6Fsa/rX7xYAy+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614

On Mon, Aug 18, 2025 at 10:09:11PM -0700, Nicolin Chen wrote:
> Yes, I've thought about that. The concern is that some other place
> someday may want to use iommu_get_domain_for_dev() in similar cases
> but would find that it doesn't work. So it would have to duplicate
> the domain pointer in its "master" structure.
> 
> Overall, having a _locked version feels cleaner to me.

We probably need the locked version, but it just shouldn't be called very
much..

> > With sensible internal locking
> 
> Hmm, I feel this iommu_get_translation_mode() is somewhat the same
> as the current iommu_get_domain_for_dev(). It would just return the
> group->domain->type v.s. group->domain, right?
> 
> This doesn't have any UAF concern though.

Yes, no UAF concern is the point

> > So that is another bunch. Not sure what will be left after.
> 
> I recall that some of the drivers manages their own domains, e.g.
>     drivers/gpu/drm/tegra/drm.c
> 
> So, they would want more out of the domain pointer than just type.

This looks like it wants an 'is currently attached' operation

Jason


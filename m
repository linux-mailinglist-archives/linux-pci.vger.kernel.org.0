Return-Path: <linux-pci+bounces-5985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D2389E5F4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C6F1C21EA1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A2158DA8;
	Tue,  9 Apr 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GOp872/J"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2119.outbound.protection.outlook.com [40.107.243.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B008158D6F;
	Tue,  9 Apr 2024 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704324; cv=fail; b=CrTtfml/63c8vFhTvH3kVo7Qy/RmykYsUGJqBZQ5lM8ggE88tzElH7ZggeMCMPEAVOw1io9m2K0EysUZvtGlDxo+oZ/+zAb3G6D+T+20A73IBsFdauFnJtK+1cLuzYyS0fXYgBPLbDZsfiDhwpLkRAY6blqzgI3m//att+B04JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704324; c=relaxed/simple;
	bh=0hyAiDRi++qlIanbOuEqYyiJTKQii4TO5XvyKy/UgUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N9EQpyXdXPTTuvlqRqjEtlt6Zvf5Kzdcv2QFJBvLc6V9kxzdE4R2Hn3YSulJXHD2a85H4bPxHp22m/zJCQNY2NMpcdkS9PLfVokAFoN4Vy2k7rPB7+/CkB1o+CPNh8kXOLO7Uk1PI7tmrJz1+dlaKYbw9DAjKW5KI8LUdq8foQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GOp872/J; arc=fail smtp.client-ip=40.107.243.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKIFnPlbfyppslN55rzjP55xR1YaxSde0qtQirJk7iesmIEa34zEeEJKr6ZSZKXtTU93H0pwW0qayYLyhcaYgval0Gb6jTB92aacTOnEoetn2he9N4UE1TiIFEob5Db2sm/xqa0OOoDKb/gMDPuFarBLkwxFdTTvn4bZ7pDSYoCvK3oN7K3XAqmVv25d8vzcbzMHRmQ3ACHsWqft4t/A+pn6urjzkqwo5B7wz3zZoInfBWtALrYqU/QS8y7VGX7W068VK0KbWxau0eQLk6+749uYaDvYJcXJys1P1ltGVyIflx+aWn9INuc+GplUnh6NIgODVYp7FzyJ/xwzyR19mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hyAiDRi++qlIanbOuEqYyiJTKQii4TO5XvyKy/UgUo=;
 b=IzTkoZCugjlTz7EQRUzhtqWJvPWWquofvSsZlbq//QMdCHJra799MWAGuLEi9dcp2OPTonSwQWoCljxCkOpG3y8Lb85uB5VYy7z2iSmvSZIxmv9O5S0Qtd/lFf33ModVE0KQS8l317OGiphlovTLafpycVXoP3bo/zHhQJPnxchZQudXP9HMUw9P+1SJ2dQZwqbg3Vkf6OXyQw+4QJOkrryeCphDxa6/GvcKfLCPWVvtV44fw28JqxgtOmH2/3HhB3od20sbCH+4T9H/H8fADrTH54CgtfpJ4XJuB8cN3qmAVPgUSp7s8KPH+DXgu44neVs2t2jD2J++E7loCqD9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hyAiDRi++qlIanbOuEqYyiJTKQii4TO5XvyKy/UgUo=;
 b=GOp872/J1inumDqv6ozfGDINhPQuBh0xfn+ISSeJM09YLi7Vfet/+fcCesk8zsAXoro248vUXCUPPWAO/nXQV6YBTLEZFNdVSfvGQ6v41H0WSIgKO3aYZGTPdtPnbiaycVwGMDGpLcRBDV7AGNQWmrbUP5zHl+6iXJjKwmCvvnp9/gxra/KlKnwweRHjTBn6eP1pMHGtvY1VqmbmkJPiYXXm8MmBqYxNs2ojEECiDileNaKyyhm2KILzf2f+jR2hOppPdx9TMEAt3dVpPTWFGUcElb3/3E7oSBZ9Nxzm1MJgxCnrpvytcOhMqBj3s/gSVX/d5+svRlq+5ZOoSF1RTQ==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 23:11:57 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 23:11:57 +0000
Date: Tue, 9 Apr 2024 20:11:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409231155.GA1613204@nvidia.com>
References: <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal>
 <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
 <20240409153932.GY5383@nvidia.com>
 <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
 <20240409171235.GZ5383@nvidia.com>
 <CAKgT0Ufc0Zx6-UwCNbwtEahdbCv=eVqJKoDuoQdz6QMD2tv-ww@mail.gmail.com>
 <20240409185457.GF5383@nvidia.com>
 <CAKgT0UcqJr4s8jMGW0a4BA6gUs+ey9X2JAOpeEP9cBW1qHmizw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcqJr4s8jMGW0a4BA6gUs+ey9X2JAOpeEP9cBW1qHmizw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0407.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB7661:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gMSnD76u4CZEMbZXr1q1CxNKCCVArsY9uiBJRg5T/pHcXHZuluJ4GTcsO1W8h1yOm8V+Am0Xka8mW2ZUsfnLmwnnx33+MzJ6BWiRKeyWaWImUfRaS0mV4FB+rrbsJenVbj4Bm8hi8uFdRZNPb6yVlEMDusyDPOPz3W8tB1+ByZM5AtncfAZQFUOsZ0rg2V5WZB9YX/3MFiAlV8QTqE2TwcpjVEQ5x00ifB5PJkbhwJrBTSQnN4hPv/vQ+G3kqF0SjBZF+b/MARQ3UOGv7f/FqMRR94Z0z8QCQPaiOhIPSp64Mhcuoq54W3jfoVeq29m0GA2HL7tp0DGwx7FS/7gAWV7w6zw1ENjjzzjO0TUSZT7NnLTGSuPz9eZYUpfD2q/q6M9Nbiy7b79NTU5VJjThGIKED9EyS+BokOF/sz/hujUYQjrZHy7hPQegRJSzoBb4KKcVNDCnorfkMEA/+ydF4bArP5FZPa6MQIPBJhjTO2MgJBhiu2OD2eB3P5XaFb+AOau6S7Q04g+zscRZ1q57SE2xG5HBZkPWxL3J9qEzKUZqMZfcZ9Oqfdsy8XiIzsc4HKQEZprvzGFtRwzhlNcQsh+zH56FeXiI8lt3HG2tAQ4SE9IYhlVzaoWMpgb0t+qa14FzRYmlW108gioK6vcfeo6/dumhypZttkc0cXsQx/Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jCN4uDbEnmClcqwJuU0HvNqlFxdpKxFv3gWgQTtQQ40ZoihzGyYauoVA1dHi?=
 =?us-ascii?Q?lui/wuICIzlOuuogOgxXWapNPE26yiXUzyCZR1xpeFGcUmYaBGkmLmyrSecS?=
 =?us-ascii?Q?qhY52LYDG0NGOlt81l1ilVBVDj4bioRyBmhB3KikBZ/MB1cVd4Hr2d27H/6a?=
 =?us-ascii?Q?Ps0nvvi6Cz3hYeDQxVHMwZ0zy9oXsMjeLuSZqt7smpZB9Bbk+4lIFneQbeFf?=
 =?us-ascii?Q?oN+QhimecFj3T1JJ359vXVp+wBpca3n73Fa0Z1iXf/unuLhYLrwa5ivh8J71?=
 =?us-ascii?Q?43ZcGlH5v/XPfVt4WErIdtyEh2oadj1xPkS1tMpvyuG56GMgvCBtH32wARpU?=
 =?us-ascii?Q?UEh40hvchlfHlcXq6nhfN3Jj/h+KI+YIJ5EtFM015SRc8Jtm50eoHcDNV4mz?=
 =?us-ascii?Q?Tdv2PxsFM0w88AnXZZhMwp+dChLxR8pyLljR5/HesA9/mZwPptuOh0tWG8uG?=
 =?us-ascii?Q?z8USHKPjUPc/VkubJFnxNrR+6opezNUyt37qFbYyN8PcTXJ0QkDClCgaOosd?=
 =?us-ascii?Q?woqlAJad8bMHbTpFOFsc1xr9FeBz3OARHdCD+r4Aa27lV+PCUDVt1jYNMZAU?=
 =?us-ascii?Q?DasU6ttYuoL5iJcuIqAEgBgUS2syHo241Jh81bwS7QcC0rWsJO67keS8Fbhl?=
 =?us-ascii?Q?Zy/KgPZBm0HA/dj04cCHtqxydzxF6dK+uGAWjkS4ENQjc7kMgMtKIbOOyCv3?=
 =?us-ascii?Q?jOkxUpFuL/kVLW5ozFF4MPX7cKCXSR0nndhIeshFFDrf6ugPS0kQM7sz/+n4?=
 =?us-ascii?Q?tqw/U0fg+fW9yM3twrioVOov7+reFhLWNgw0cBJ4YbVeIrhKcKshCNv/svds?=
 =?us-ascii?Q?DvT4yqSkUBCKDo8yHXhrByPouYIHwW5fD5fdTw58CTdd8zp/t2rZ6CQ/DZvy?=
 =?us-ascii?Q?Xggwo4eO+XqPfMyvr4Od7H4NK61g7ha6qgLpXa9IWdybWc5+j4MdVXzbWaQV?=
 =?us-ascii?Q?CXi33vQQgwZX2ddtG1Y9dAavIIgWbKi7rk8ieu541l+ewiU5nO5W1IsjUCGa?=
 =?us-ascii?Q?/7twVTSzpBtRcJqWd6SQVYhjbadtWnFiNDCSJlFEr1yhCjhJL7o2ZwGCTd4w?=
 =?us-ascii?Q?XP9qrL/LqdZH24Gjgyhf1pxQUNky8nS+d9A+RjX2q9KlAMnL3zE+web2oRDr?=
 =?us-ascii?Q?SQ85aMKlnVd9qaDVjqn77Fi/zwIzUgV/yv1QqtFIx1ZJLyYT+VR+nvo6AdYI?=
 =?us-ascii?Q?1LWiSEQdD4dcvN6Ne2POyn/lMPzy4vlHZbgoy5Ta0kK5eV1zXdynR+6AokVo?=
 =?us-ascii?Q?FDWwQ/oyU6ldyIxKu6wes8Q0tYj366e4DTtAmFIv841PsXLUE+LdTSWc2qpe?=
 =?us-ascii?Q?rqXIQnNOGz9fsD0Ao/CdvgqSmVnJeE1bTRlU6XSQiVn2q5HvjlXtdfzXFXzr?=
 =?us-ascii?Q?RG9Q8NO20jyzIChG9tplnQ97/S3dVL+h9KJO9MnAl+kHMjc3rfy/u2SdiXqw?=
 =?us-ascii?Q?U+pNm5T7XrwKvmdVNMc4HdbGMm1z8w5gRsDCCNQRcWAxiYGdi8nMKfIdn8zS?=
 =?us-ascii?Q?cnlyesesPqj/+Mm4iRpl6W03WSUuRH8jSbh2dj1AwKVtJlFf5mu+tMTsBxEz?=
 =?us-ascii?Q?f7NBu3mAjSw7UvY+Nn//L6iE2n+APFemMRr0rzfA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0db1fb-f367-4e60-d853-08dc58ea73df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:11:57.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JX+thEsBzJdIRYUeC26xaqTKlDA7Hzdgf2tq4WZ9mhJ6MIfexo6pTq9++la21yfy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

On Tue, Apr 09, 2024 at 01:03:06PM -0700, Alexander Duyck wrote:
> People were asking why others were jumping to my defense, well if we
> are going to judge the team they are mostly judging me. I'm just
> hoping my reputation has spoken for itself considering I was making
> significant contributions to the drivers even after I have gone
> through several changes of employer.

I don't think anything in this thread is about you personally. You
were just given a "bad vendor" task by your employer and you carried
it out. As is usual with these things there is legitimate disagreement
on what it means to be a "bad vendor".

Jason


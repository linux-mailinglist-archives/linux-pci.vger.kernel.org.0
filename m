Return-Path: <linux-pci+bounces-5951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F1F89DF73
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA29288088
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5352B13D623;
	Tue,  9 Apr 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IRrqRfB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2115.outbound.protection.outlook.com [40.107.243.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624113D61B;
	Tue,  9 Apr 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677178; cv=fail; b=jqloarOFw7WiH2iTORJeALduWSWB/p9fCfXJaeSHXXQCH4dAsjl+Kc/BsoewPvf20SEDIvYJ3hcW+hRxZp5uyel9OflRL9VgepU4IGIzjXHm8pY5w2Oq+kaAswOAMg/m+gFnedQWptreA4haD3Tqd9v/c9aQXLb0N9+Hv/PB9BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677178; c=relaxed/simple;
	bh=Fs7bdkMN3D0RlRiudDOpggJ9vMvbrRe1YsNVlqR9zh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bkR/lEd7HWvqCv0n2iFTn5KuiJws5zRPWAFTPvICbck01laSDbudITbLjZ6qNC+2T0kMqh9mu7Rakvsm6laGnGInRV6Lu+5GiMM/j465Fvlri5pPGuszMa6wfFICd0CjBiMaxs/J/qJQ/bhYQ4bmvmNT/05Shd4xba39Q892XaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IRrqRfB7; arc=fail smtp.client-ip=40.107.243.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPrHQHzuPOd3INz5Xo8WMW78Z70O+WqGCT6Cd5ugekMf+4saqURRALLYJwrkhufDe79AJTZBsdx4KfYL58FTG85U4XCyaRil2uHEmJS5H3XfmedmtqGHWc6dX1YI7GdB3NNIFHpXQ7gO0ReFspFnBkKG2XgJ6wH2ZNCBtrMnM8oooMhsMF24bBHTgAAkUyxPlspbRnUINqOBrfTalnTDqJ5/3/Me2NjpjEIhkIPHxVRR8HJzDu0WhnAj3NQv6NQElKrTn6nugzLOHM6FATXzhFQomIqGMdaZZwtNbyoMKuoj0SH7XS+H2xTntU0kT2JMW2F1k715zGLUq1dvIUjjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1yULGYXXIXSML1pfZSD+exul2GMZiHwt7Ge2/Ar6sI=;
 b=F3xxwDZPFDJQB+jXhjOv/rF1+OXltIcrRePmiiVqA6nntmGS8J+3V72Rtqj33VroUrP5Cgcdn0XVxwd5+bOVIk+QiYfgTOnXUOaYTSSciYhrhysQRiprhJUI7We/zLRDjJXlI/eugVJedzDoz5l+SurEhqo5z3faQO+Nk8VM1C8P8RSO/t0RZbYp4kll8AJl9q312kfHDIGN7C++h16RcRwAJF+o6QwQPl13U8O4X6F+w1tk8/GnGXTZcMcwSzYVazLlakyRdjk2zih/JzFfX5XxuVK/5N8fWyRhfhhJt2URf3kxE0amd3Jd20YkJYR9uoT0/ouKs9aCs9H2FOjE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1yULGYXXIXSML1pfZSD+exul2GMZiHwt7Ge2/Ar6sI=;
 b=IRrqRfB7iXIj98dPdR+JarBwcItXvnUkH5FMzqbNw51br3Bu7+zbSCbeQX9qhUwaGlUd9lNpIKU9JudbFryOLet4+MCL2/Dg9O7o5QmRo63H7p4V4nllvTRarWEZQByWaaX71KXBBCnMaBsTLugoQ++K6kKbJSGlGUOPyl2Acq9dCNR22fIOtTB7h2JnPf20gH0EXzTujRQeGscnFk23eOX98N/S0qT5YGk47qZzNrpZv544Rotx3z65lLYXD6EiE9WUxokmRGJmosFN1qTLIuiWOIwXr8YJ7FsyxDtela2YLjDHqz3nelqhc58u21P4HLWjmCknVKiO9fYK+ldRkQ==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 15:39:33 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 15:39:33 +0000
Date: Tue, 9 Apr 2024 12:39:32 -0300
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
Message-ID: <20240409153932.GY5383@nvidia.com>
References: <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org>
 <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal>
 <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal>
 <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
X-ClientProxiedBy: BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB7755:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J7qQ2TSZ2ktIysuzZ5tnPICgKQ6yDBqFVu9TxTCu9gAxA+czFnSUsHBGp+zFcKhC57nGBvrecp38f/cGKMqM3J/T0MY37bTf5A9O1ECqSgitBkQycb6Ll6dRUSfqazAxcbN88UOzPH9LsYmJnTDcxdfO1oQmw+8WM6HSaIq6Rv4iItUUB1XsbF3c8U4+fRE60NTUEvT357bxzAyf9uAj8d1MXOzEW0uW+m62DSJPw3gsbnXr6yQ4Tf4XvvciHkdd7HpMwrzYZ8VZw4ApwCYN8VZtNGdbpM80vE4R4rTQ5+wepmzp73MVOPQPr4ix0fSnLXeJDM7XfG6KzmG70L8K4dWexhhXZ/b6aXMlqRs5s8yFVX7XZGtfRkJUzIZODXLwnfWYZZB2bgKv3NkE/odIllLIL87336MztpoqP/A5aTwHIlaqPGO/aqbRyWxRQ9TIoZ05JcEVPEx/4SW+gU5i1/kkNNyCOxittMOkDAtFkidc/DPcZRuSfQjHthXBClyzyLdjlclOjq8kcLjeWw8ZOTZMOVemD7E4JqSvrZSqHl7NisEZL7rKWA/Co8pkPi0qqVk2upxeELMay5AShwfC6jEP3RPdasVRLbjcY44JGPU7E3d+KYkC/9BlecuttYZ8HlY5E0lTp6I3Z5ovBQkQ2N+un1ORTkUg79msO52yolQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I3WUMgXOJ9u0rVML5pYX4+UiL9+mGUwtMEWNhU4mMCb68/9YsU+9fIiunSl7?=
 =?us-ascii?Q?OiaHZcjnTZIcakLae9Ysvn9QypCeaoh8yuoZEtvoOAsmX451blxkZQ/A9YU5?=
 =?us-ascii?Q?n25ntGkKc8AC3wNdZ9b9Sc2J2xJVuewQH8WhnTd+jbmXOZFlTLIGVPKGWpf2?=
 =?us-ascii?Q?vgq60hJOU/rL3PERRyDh8zDILFBmkCuAnRfAP7JGH3GH0tEgxUwSvc5K4hN2?=
 =?us-ascii?Q?qb2wlQCzM6wOq2DZB2QvmmZ8yWpEzbza/YP6hhvM0Rj10miWuxioTA5IuT+j?=
 =?us-ascii?Q?fGmsO+HgYpgiIk2xytO0cMwkoTNwYUvA0f7XIMFiGegW3PPtQ7JWyxSOCEWP?=
 =?us-ascii?Q?zfFveeNwz9Ql0equZM92e/TE3nNH0B9zkOcFryEYhjoUSPqd7D77bYGM1xw6?=
 =?us-ascii?Q?62+OvitmC4GhoFOA0wYq3fFbw5S4yYZFGeFQ3y1UXALw6XEdUFe8pt2z7mVN?=
 =?us-ascii?Q?zEYiHXWJeoIi8qwe8xFY982zcOuGKw65iY8s9+ZcjzoDY3LNjpcRgMqDvuP7?=
 =?us-ascii?Q?gqMpQMvHckaiX8eGmNBS7aBsqAHrS22JEbejPwJofSIpOZWcErjDBQ8XXKKz?=
 =?us-ascii?Q?TKzwK7LWN5mwV+rpFVslDWkGkkiDVA2w1KOOpfwpK2bcQwv8qtGSGnMua6mP?=
 =?us-ascii?Q?yCd4mYGU+lAHPfBOY1QL53QeILEr6/ooj95/3TzQyzs3Axe9IRqew+rVHUQC?=
 =?us-ascii?Q?M6zOdkIFdnxP1sCBENhVM5aYHQs75K3LQ5Lb9z/mcGnQuaHsqpH19TMLhcdR?=
 =?us-ascii?Q?Y+/ggr/ssLjMy4LhSo/6T0nmc9CWsnzPiitEHUX6JlLa+j/ekdnc/l0FmXI5?=
 =?us-ascii?Q?tYpAnxxRrCJtit1ZxEDjEp+deBmfYSqrIUrNJwUl1L7KjYLoMO9A0MD4e5y3?=
 =?us-ascii?Q?jO8Fe6z81YLxJa2ARuSRZQzC6TTCht4a/5EduPtOFuhwigBULWPNawWHibBM?=
 =?us-ascii?Q?OLPSqmOFpyI5TyUDBKh67A5gJx1XG7jh0u5G4TuK9kbFYdw3qXuW002k8m43?=
 =?us-ascii?Q?OYuanQZRh0tySl5x9vjayKyWPC4UXNvxXZDz5XMwDITj2P2G5mgO2l7yV7sy?=
 =?us-ascii?Q?GY1g7JGxCphkgaeV50rYtcTcXhnsGgzWUIvN0DyYOyJhSAKkHZ3THz3nIPYY?=
 =?us-ascii?Q?rNArRxwuLlVe0s8k33WSBvddrCY1KeUuC0CLZXn4KXMi3n36LV++Pb3yEDzn?=
 =?us-ascii?Q?q/8wibA/tcbxKZuIYn8n+ityTHz+l+h0VoV/qWa7ehkWHRcVSxTwho72axPJ?=
 =?us-ascii?Q?6gHORgNmzaQuzDPksJP6TfFXKHPYoRh1XUCrgCstp6xJnKysehoexuHY9tdH?=
 =?us-ascii?Q?VYgCJ3Ser+NmSDFaVQcbUckMAFDYhuhz0e+I2X1Ps6YaGEgzZ7Wtz+Ne3SWq?=
 =?us-ascii?Q?1z3Jg8ThhCVbQGAKs7vSNBDH+lKdFMTqvsV/G09n5WS5HGcIbvmT+1YR6os8?=
 =?us-ascii?Q?zhbWz691wTJrKm7am/36bdy2+3cDknR5JAf7VQZ6YBXBuYQBuBxrAYUC8yu2?=
 =?us-ascii?Q?t+0aUJ+hFGs3PwnTujuG3d/GBZmPlIcqXJd5ft+ch98wMWHnhK6XarvWB0Nr?=
 =?us-ascii?Q?PurFbA0kPO5cLoifPCxBzkLiFWxJNk4ib6o2S9A8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c1cb51-c78f-44a0-8e45-08dc58ab4101
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:39:33.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZuwH2yqTcl4IMbPXCDi0QQH4ho0otnUqa7UD3TqYUFReNf1biT3j9YuBHPW632Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755

On Tue, Apr 09, 2024 at 07:43:07AM -0700, Alexander Duyck wrote:

> I see. So this is what you were referencing. Arguably I can see both
> sides of the issue. Ideally what should have been presented would have
> been the root cause of why the diff

Uh, that almost never happens in the kernel world. Someone does a
great favour to us all to test rc kernels and finds bugs. The
expectation is generally things like:

 - The bug is fixed immediately because the issue is obvious to the
   author
 - Iteration and rapid progress is seen toward enlightening the author
 - The patch is reverted, often rapidly, try again later with a good
   patch

Unsophisticated reporters should not experience regressions,
period. Unsophisticated reporters shuld not be expected to debug
things on their own (though it sure is nice if they can!). We really
like it and appreciate it if reporters can run experiments!

In this particular instance there was some resistance getting to a fix
quickly. I think a revert for something like this that could not be
immediately fixed is the correct thing, especially when it effects
significant work within the community. It gives the submitter time to
find out how to solve the regression.

That there is now so much ongoing bad blood over such an ordinary
matter is what is really distressing here.

I think Leon's point is broadly that those on the "vendor" side seem
to often be accused of being a "bad vendor". I couldn't help but
notice the language from Meta on this thread seemed to place Meta
outside of being a vendor, despite having always very much been doing
typical vendor activities like downstream forks, proprietary userspace
and now drivers for their own devices.

In my view the vendor/!vendor distinction is really toxic and should
stop.

Jason


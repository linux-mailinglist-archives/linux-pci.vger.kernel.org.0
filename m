Return-Path: <linux-pci+bounces-8774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D8907F8C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 01:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E591C214A7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 23:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2787314C5A7;
	Thu, 13 Jun 2024 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S4be/DiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AF14375B;
	Thu, 13 Jun 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321776; cv=fail; b=UpwJyr4WVIfnf095rUZmuearCXFg4Y6CQzzZhYkZcD6vNc3Bu7+/Ep1ilnxmMylg9CSDJVrc+WLi2qNR39pofZicQ6rjtJ6p8ohBGLyEOkXiXGnEH33+LbO2BMGqCZzhqS9d8LfVnfoiEIdwCWO8aeOT4HyWqVdC6IqFo7Eiy9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321776; c=relaxed/simple;
	bh=vwBQRE6TO/jFDbFbux/Go3FcjmZEdHOJimCPn3c7AcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pV6owWG8R3nyTJ4QyAefi44q3S0nHdxQYip/U/Oz8IVEr110mHJDR+/0pYXo2oTsYKKPdFlzBTPwlB0qpVn2W2BPQhS0q12lyfzxYjxVl3kePVxHXgwx0mlYJ6URgwqe444YC4mRVKSnQDiFNZKqFvbRKHK3XLvbEJWQ1qeUVfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S4be/DiC; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePLCyjucdhBk0kOTOZfEUZ5OeZAfALQR8Y5oCLNc+sgfqHS4fjOD/B9X+KewNTnRH+QtDx6xhfahoXf8m/EE8/koJfUK1IvjvLJUSpkiGwTSaUYcP0KPqggmVtna5Kkux5nnVLXcGltJzPApMhnOvTFiggylTzYQwUuU+y0NEZANAslBY7In6CdiuKFEgBE+Cn1rq0aYXb4vnxhN/eoS5D8BMRPBRq5JqXwpl72lfZherCeJd+/Kt1vo7Mm9ODG4nqekiSoPefPmAu9tvF6Xl9LRZn/Y3/ofr9fMyVSytICOBjC9BJp1EWQ3h8bWhYwuzttdphKmSEfJ9H8BienpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0YeTOdOXsVvNXuzErwCMoT8c62jUQ32TEyZHd46ZuA=;
 b=VhwE5lxBAs+I9yw0NxX5FLKbpPpuDgiAmeHJkdwxELQkqcE8HL9nrpo3hCbaOH9HW7m6s2uhiydtqNlocmeVovzQ2A1X9qU04JNoWgLoS6AD/6sgWGqZk6fYkjz1cnBKT13lPkXHbG0C5KNKf7cQlnpM7xCvggQpL0+9OwoY/jtPCNBBrpW3LgfSBzBaYda2FUKJ6ygfKT0Qnm+WNu5rLg6PSNVYDDe5r1nNId+S6SaZnefxjavXuU+v1eV+oYIzGHyrq5IYypC6cz/ntSOVSVQsYZANxCdfcHjRqUB9WNyH29ymT4oAwxxR53SxCGj7j2RiOmYKikrqNuIR4MvYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0YeTOdOXsVvNXuzErwCMoT8c62jUQ32TEyZHd46ZuA=;
 b=S4be/DiCuMTqh9hZLioDj5pCCgM0LjCJIs/xkEh4pE19g7bTJ59OEym1E/akddvIOhNUBM0s8H0scvPqL6d3b8eUUBvmylF+xCDfmiyklFomGrwO+aca/ZC0RVSbkJEoQVzLYGfWbpx6d94mqzeviA8uYmvta6vFnrcouhanTb9ey3l27qxBzXX+unXcUzp994PCe0H+E99qTdkhnqU2XnzgZbktotN4QWEhhh5oaQRUgzpGLY7vkTd/fGmm+PNzzvAaVieqZfWsTwh7LBj1SdikgXTo12lkIiWTQV7UOciZ5smE+vaaEIXCnM/7yPb4uugM5GcEYtLfGj3LDf32ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 23:36:08 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 23:36:07 +0000
Date: Thu, 13 Jun 2024 20:36:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Gal Shalom <galshalom@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Masoud Moshref Javadi <mmoshrefjava@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Jiandi An <jan@nvidia.com>, Tushar Dave <tdave@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240613233605.GG19897@nvidia.com>
References: <20240612232301.GB19897@nvidia.com>
 <20240613220520.GA1085981@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613220520.GA1085981@bhelgaas>
X-ClientProxiedBy: MN2PR20CA0042.namprd20.prod.outlook.com
 (2603:10b6:208:235::11) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ef3e29-6c6c-436b-224e-08dc8c019936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wmyVB2lWrAxsGJ6VNt/t9Y4rPaTTGhfziii6ovWHHo1c+aQIcV0D1P0ZwKUh?=
 =?us-ascii?Q?2aVCciw49M4Jn0JbpgMbN0Rciw8g7urz43l4MOt5efZb3kDmwHVhsLveYnY7?=
 =?us-ascii?Q?pRlwDHsQ5yYKbqK3F4hRl1v7Y3KT8GoylsD6Q8DPTmWKJiCBkkdI+CWjMtjc?=
 =?us-ascii?Q?bXRL3DvXU1BIBA/TmGCJjSKDqPquNiwqFtNqHMdrwVEYTYjSu0iE5OaUJKAk?=
 =?us-ascii?Q?zCdu8l0a1uSp5nWgzsU+WBzV8aCIsZKAclkOjwDnvs9LSkjQtyVnZHhFLnRi?=
 =?us-ascii?Q?RZjxGW50o9KXce0y42hE71QYj3dND/b4dP+7p1yT4Xdipzm3Enmndm75aMkE?=
 =?us-ascii?Q?cNiYN27ApRWyDxnnxxgAfwyHmfUWMGUXZIkWNEu9s/eUVWG74xodqLzgeTSY?=
 =?us-ascii?Q?tPGcAMPpJ+26Gr/sO4B7gSivzUifba1KRPW7e6d8je7BEdJBwnyXdlXCeKUz?=
 =?us-ascii?Q?mG5M6iAe6NnaVPEEy1iN2Q++W5O45FLq0JKBISDPcCH31VrMCKUFNfKsjb56?=
 =?us-ascii?Q?Vm0ozAzPX2JB7/Vu9BQ2EIK6R4WCyWlzhtoUrnKIYAoAKtlwDi8hnfCqQpWP?=
 =?us-ascii?Q?4FNOHMjuKgIv57QR/SAtyphAmqQ87BcbjzRZljsbCAn9a9IjDKejJLTY8GdH?=
 =?us-ascii?Q?pD/Wh+LTqIBI0lNwtjHzh1GTO1zT+97MSHK54pbXkchnYs1SQ+gz0iO8zu0h?=
 =?us-ascii?Q?o3KEage5tvYgf/ENqdnhnU3J+QsWyKyLP2x4POX7+g+ylqAkpK6m8+f+9uh5?=
 =?us-ascii?Q?Z9sVSo8Gj9DibPiKreeKP5R5tcihpjXcacisktKMgdHEgcdjtbbcwKhfsQ/Z?=
 =?us-ascii?Q?h05LOLBszDKWKUJ5bz3t0zLvlm5GEgrfz7ocpV5tWie0RinmDBnKXqjD2XAo?=
 =?us-ascii?Q?0/+gEU3swQhj27T6mhc+PioRzpxfNlG5gfBQZm7PvfQBaxPFcLJ30q467YFZ?=
 =?us-ascii?Q?VMS8ICO/HwGTDXa/rERssIGDYZJmq+XRgzCp0pvgOHWe85KtohKPGAL9PNip?=
 =?us-ascii?Q?gk2Mjt7w9OOXER9mAv7daQZyoUoMFP/Mb8i7YcnysvMbOxGtV65qeHcGVEez?=
 =?us-ascii?Q?fVtjcV3JL9YIB/Ep7siy0mBnZMdTRdgC/YAkVkPMHIsxAaFNR1n+ejCNvkul?=
 =?us-ascii?Q?wQTS3OuozAtZopK1xfy2UCbPTnxc8u11O9cJrgHYtw3ZsVogsrUiz46s7uam?=
 =?us-ascii?Q?T7wknNytR9Fqm4yNrZVnysyrj5h10OvQxBaXs1iWxD7CrehqaSQ+pE/rp1J5?=
 =?us-ascii?Q?16UJXMcV25m7+aGXyBJ/RNbp2vofhNcimHwaYxdj2W2XB7hgm8opBXUKOCRW?=
 =?us-ascii?Q?k+4Mh6u9RZHeEHugeMTbwwMz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dPeEdq7lu/kTBYkFaqprEjfI5acMmBSyRiBL6sT19SSpQKjArtIwjAtn1Hw?=
 =?us-ascii?Q?VdmzMdpWVy1UvZ6q8R1slsJG7lhnzyR0GbTT1nLQQxYTEJFgYQqAyW1dwyqf?=
 =?us-ascii?Q?54c86R2QPX+cuNm59RwUrhDtpQ2r4qGkYvtOWE93QSSXOqP/IysEuj9n4mRy?=
 =?us-ascii?Q?f8SudeTwnrSHMeMqLOhsLlbcN4l/9opuIrLFYnV4A/6qOpkNxUpsk62v1IOD?=
 =?us-ascii?Q?Yq8GnzrgMsyktjs4CILUYq4YAiUWcCiHHntAqdcvEFKNLZC8zDFLS8yv6RpZ?=
 =?us-ascii?Q?YvwkMaFONo8xAUNlhVpA8de+t5lb/I3mGzeKOCaM9LEzZ+brU0RssIJlBEoF?=
 =?us-ascii?Q?w5QMvXfhXP1kPb+cq/GhC6R0E5vg/RQwOZTiAN39GclMjmvumPcU2L+Lr3i6?=
 =?us-ascii?Q?oOleaU4stYq3N6cvS/bcxtJZqu0uZopkkI/kWZnvvXEOJ60y2O4alIjSUY4A?=
 =?us-ascii?Q?WoiBjtdLpQETadZuMI108QKB5US573mmcb57LfdTLpBxMWDp8mCXKQacGbYM?=
 =?us-ascii?Q?HPqKANGcX3GCRV6gs/eDjGg8+XkyIMtYgCt9tpR1o5Q27kyn7O+P4uTlDOL9?=
 =?us-ascii?Q?Q/FVq2INzC3gOyNyCO8PKRdxdn+FcHU0/s0Q0D1RK4/YbLxfD+zemeqWGj7K?=
 =?us-ascii?Q?jx1I/0rzd888hFKZRK0AjmPN3UUyOdsRoeN2fKX+AOZrHFdxcWMyNg/gIE8i?=
 =?us-ascii?Q?snjI2E4iUDKk/egLMwhRXrbUZomCkkLVf0UhKvjwB52bH3J08YND7zdtKonO?=
 =?us-ascii?Q?PPxlaVOJgt7f6XjQGdsBzjoMq6XW5sqEfiHI1QzujHNLgnl4JA1kZ/h+M67y?=
 =?us-ascii?Q?HgzW8qBwD7rbX/P1vVVFHzWy6Ailx1JxfXit5DM+s9ZzlA/bkEIIEnblj59y?=
 =?us-ascii?Q?YOVnpSnq9rkH/4T6bjktz8DlZWB3aq7QTCN0e+Dl3E43+EUCg+fCLG0jifyX?=
 =?us-ascii?Q?SnSZ809RdS2XBPrz8yh1bNff05e1WW9Yfk6VphcBB7/v4ykvbEszKqQAaC3H?=
 =?us-ascii?Q?VrV4fKjrI9E3uXv/tyu7nPAsJlrMYzN7+N+jAIo6a1xCsuQPkcxP8MlCRjgQ?=
 =?us-ascii?Q?yNgssgAQi1XorMwbKp3R6RBoLhLc9lWsj8ELAkIoyAqQnG7MZvbpz0x7EImF?=
 =?us-ascii?Q?ImC7b24fPCkKeAm23aiqifatwRkMKZhVWATMQ/f5Pye1dG5cAKNcQ12VVuHM?=
 =?us-ascii?Q?+396ePGsQ4GfvMIAxZeYYXVZZddtP/D3cFkMVdwX0WwCM+B9w0XOcZvw1uhM?=
 =?us-ascii?Q?2zD6XmWy2FtrlxuE4ZqSLc+UY+pI4PYmE6d7lqC1c8QHzyvuo9bgB6pTYh6R?=
 =?us-ascii?Q?yRCwZH8u/IDm4MyXAOTZZx+DBvMrkeAmE1l0AmNdtIftaFn6MaAjB7YQx8ev?=
 =?us-ascii?Q?vTRoUbwBiHJVmOGVCDWcubO5Af/j+ver9FuqtNzwFPTV06sn66Im2WKVvsYx?=
 =?us-ascii?Q?KH/C+O3V0pAuRZljPTLcdmNmpwLBrUbqP6pVaNmqpffo1A1JsEDJ2xOZBZce?=
 =?us-ascii?Q?H34R/OBRjquHYZBnCewuLwkM5pEHN47r8oeA0VCCqbNzIYkm7klqXDaehPDn?=
 =?us-ascii?Q?H+Z1wPpxLiglfjSiHSW6keQgU1/lrG4omjO+ktxy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ef3e29-6c6c-436b-224e-08dc8c019936
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:36:07.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZY/cU1Tlsnr2m0nXSJBHqJYYNz0k5IoWCl8n3G8i+lqIawYNm5PjmKXF0ECul0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646

On Thu, Jun 13, 2024 at 05:05:20PM -0500, Bjorn Helgaas wrote:

> It's unfortunate that this requires so much expert knowledge to use,
> but I guess we don't really have a good alternative.  The only way I
> can think of to help would be some kind of white paper or examples in
> Documentation/PCI/.

So far I am seeing the system supplier supply the appropriate
instructions.. It is already this way for set_pci, and yes, it is a
huge PITA.

At one point Steven Bates was talking about some ACPI tables to give
the OS more information but I don't think that went anywhere..

Jason


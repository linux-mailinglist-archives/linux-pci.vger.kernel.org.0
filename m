Return-Path: <linux-pci+bounces-26683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80032A9AD78
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 14:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E7D461F00
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375727A906;
	Thu, 24 Apr 2025 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eskJ/1bU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10A27A901;
	Thu, 24 Apr 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497924; cv=fail; b=JSQSwNmu1IMLciDC0kGgxvNI0m1vT++E269ma+qf3RA3Ks4eHV8SQMSKQL+tBVPyxIHSJ2ZqhaUx+45LUmj7KNwQadDnqLUznY0L4rSIQzETL9yu7ZohF1rBuAO4+KGl2npXZ3rOxk+47LA0KQpzzMJu8H/gn9BBWY6SrdMvPlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497924; c=relaxed/simple;
	bh=Zvxtb3VU4sqkyX3jlhMH0jeBY2Y4y+9SvJn0qA0qG3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a3h8f+NEV8mGFHFfluWXOMoZij+qIsZxr1Snoi3bOWaOIQSctFkp9y4SOYqCuJk2m0Ua0zidulLn5u7JLvvUS8wmTAI4yXw1wTIe+IcoeWyVxumD+WlxIb/uI7uHji9QIZmb8Vbybm4HM/4lkFt7h+DuHLsPhEMgUVBDHKMCBw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eskJ/1bU; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPOdeV+DbvFC7w4xkW8gNbM7Uq8YJzRW+c4D2xfMGcPSKW8JJ9FUyiT972ExDj0Dtcz9rxMxen6Pu31e0LGEjiu7ncLdcAlveJpm8WUCqvyGV2dLlBPATLtd4YK711awWSl3cwCsFCyRzDGGhb7njGUtnK6I8k55l1OknHb8fjnlON38Kh2ZHTAgyWDq6SwxNi0RlTcZpaogW7/mMDD9LycZPJeQ/ldcFLByAtQTnOEqPwlABTMlLu1E0847YzFwAERwL1NtktvTOiqlNwkX8VSPDi7tM+CAVIpQXmgBDaaja/PxCOWdR3LIXLtFUn165zrqMvVtRRh9X1UDDVE65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zvxtb3VU4sqkyX3jlhMH0jeBY2Y4y+9SvJn0qA0qG3c=;
 b=uHauKxZIfH4FrY7oG9srwTZIJHBZGqFEcOUuknDzaVPXGJVzdSQgKG/UWi+VnHjYj2ElzB8zhuZWCL6WR0R5wi6LW72xNTtbVaMQDntL6tB+Rc7XF472G1LJPAYPVKiRXPNtlVNwwrodhhb8UC4NWbKUE4XAWViWAnCfNDTkwq0Og5UvkHtHQlbrlyEk/eYvH1MvD+Uzy9p4on4yuOVfvhuTXuUW4VuBqNm3/yyaEfzkh/KkAkyvd0ylc8LuD4q1Zd4mKYXcDP62VhlAdk/Z84h06xNsPKWpQJtOBgVoLIGBGkWniGwnscOee48kwUaoeOg8Fp9KBHHmCipK4a6x/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zvxtb3VU4sqkyX3jlhMH0jeBY2Y4y+9SvJn0qA0qG3c=;
 b=eskJ/1bUCxThoyrF3q+l88GNai1oGbaJKGumsApNJDii/8hN0Z3Eyz32yNgbKEvzWOWghECLdVwjNBwVLZ6n/fwU9JF7na/I0+LwrUWUAxfFX/GdmxQHd49JMfGDGzSpFfuOAVtnOS/d+QieXYWEmQ5QwkXbkFMM5i1pX5CN2pClFdN/I0Kbu4yTDWEdscafI9J6EKcJC9LrzAifXdsEUhZypX+ENtgcuYnXar4Sb4R4kwM7+TkYuqQVWRfKa23/RIYs86dkk+QsFktVS2JNGIljYvFcmxGjYR/kxTuJxWuSwiSZtkGWRPnzppTjKM8vrJIDrT/WF26rHr2TEDx4Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Thu, 24 Apr
 2025 12:31:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Thu, 24 Apr 2025
 12:31:58 +0000
Date: Thu, 24 Apr 2025 09:31:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Tushar Dave <tdave@nvidia.com>,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH rc] iommu: Skip PASID validation for devices without
 PASID capability
Message-ID: <20250424123156.GO1648741@nvidia.com>
References: <20250424020626.945829-1-tdave@nvidia.com>
 <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
 <8ef5da0e-f857-43a0-8cdf-b69f52b4b93a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef5da0e-f857-43a0-8cdf-b69f52b4b93a@amd.com>
X-ClientProxiedBy: BN9PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:408:fe::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e25b46-a767-451f-d969-08dd832c016e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04h23T89+temlrKU5OnNBblznqxDUJtFKBTlmZqcptZ2Fq+mveTEJX9XAa7p?=
 =?us-ascii?Q?fdWlX2UzkRKqv9waTbj/tc8z8Hax2RuPjlFzWSONZGL5WP8Psw6Mtwm1b90D?=
 =?us-ascii?Q?V/SWAS6XeAAIrWTjMuaSS0b2+QQqmaH0y/Gd24vcNEIT1Wdsnf41MQ6G7OVQ?=
 =?us-ascii?Q?nWWzlRDpWrFmbIIPrlC7MY2jbSrVSck9Yi8H029ykQQWVOfFQYVK66r5WA2n?=
 =?us-ascii?Q?NqWlvy3CUAa9RIXxt6qmPmuoBtks1DVrMIDT3gXnmUKiMBxDQPVcM3mBRAUA?=
 =?us-ascii?Q?OZQm3ieTVUAHnou4z7y0qpcrwDPQzVVC4ENbeSMtP1YM6p0lDLfGyuMkUh3b?=
 =?us-ascii?Q?9S/w3fvv6hgH8DgoxvxUV6sfk1l4A5Vwtk2PGi5jSujbX8lsvY8QNkPoox9B?=
 =?us-ascii?Q?brKbpOpOiHP7aLyljMzbQfYP0tTqIWuHKasB9Xlz/lFPbDs2tOEux7U0H+ji?=
 =?us-ascii?Q?bPf7m2V0baZMbs6S+Da+YHVn7DPx9exFiwx1nnvsakX5Ng0kVcf++ejx6vMJ?=
 =?us-ascii?Q?ukjImvp3MhOmtgYCmiqjwEDJy5WGEMPS6aI8P0KzyiXFdD/1c9p8LlqWqZC5?=
 =?us-ascii?Q?I9BYo4UDUXuU5Ln2BH2OHYH+318qDxUFshoPpe8jA/ZOud1HJsdvQfZEQVFD?=
 =?us-ascii?Q?4cJP1kAHQ3zfzx/Y8ag3U30npxpNG82rdApzIxVCAEGSbKZHHVV+AXITXFkz?=
 =?us-ascii?Q?PYOuYjz83+hWPt9YzCr92ogoSZ+tjwA4j0D17CLsMte0+PGvw6SADJY1N8V/?=
 =?us-ascii?Q?DbevdkXLymz5lj6vlBM5lbow4MRA101tkSx6LhYst7wIujxGIxHHV8Ctl8K3?=
 =?us-ascii?Q?gjFcZVEtqr2f7xEP3hxiBfD4SJvYXMfIeVeLV2r9LJ2mLV985DL0Cdabw9Rb?=
 =?us-ascii?Q?haXUrzDBX8rEGXaZO7R6RVrDR5FR9P4pgEuT6uvj+aARYsFY8Prk/0pMEXyX?=
 =?us-ascii?Q?5iWqeOjncy1O7V1cZC5ZO5+sTAE1kD6rIE7SqXi7YfK6Hly0/6nDUGZwEncC?=
 =?us-ascii?Q?JADz/xtU+493F8TKZqsC/pgbl0yASmCXtCbiPohNQ+ww+q6Lr3AWiPlIt+F/?=
 =?us-ascii?Q?luoO17ONl79S9z6io5t8SlYKU+GfcaBSvhCuQhqoRqWGbRK9uvw1IJSeQkrF?=
 =?us-ascii?Q?xoueLQ0xMy+5x8ImA2oRSb7QXcw8VlQ6tZ061xJBXbO84oKfxo8Lj+71XugV?=
 =?us-ascii?Q?s4jZ468fp84d4BQWF4BlVCWDY+CA+V/yKIcSVhIg/PLp572AO+WRbP/NeMG5?=
 =?us-ascii?Q?e9r/dkVRq++hTYEd04M5+uPPsyIAlVCLWmzBsmEbz6Hb1Pfnou0zPF7P7GKh?=
 =?us-ascii?Q?GRsdKJDg+kSvwEdbbyRx3w4xsRb6i+hpgQc3iLATi6HtFTyNbDp3IVZCk9CC?=
 =?us-ascii?Q?Sk1tKDtzuzj0AAQ81V6ImzGs2iZkWPimDGlpdtd2oYiL9nqLP0ZnPGF7Z+jM?=
 =?us-ascii?Q?C3IRQ8b6RpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y+jKU0Bh5vgUVBPUWVT2PV7oSCL5XHXrc0zYmRljMB71S/x/nXiNzQ7Vgj1a?=
 =?us-ascii?Q?hTtvi/knRF+YSjGvidlDb1Be5EKkBt/d9H4bRi08gplUxK9b9z08aKLcgljD?=
 =?us-ascii?Q?9CgNsnjvgPbbWbwC3h7QLCuh9xpC7jo6h30ZI8LywE0At+iNh9ePQaulJfiO?=
 =?us-ascii?Q?rjcIET31eCoU4TXy6eOeYa/2/7nteP7b9v2O7GWPLvz9TtDZekww4EqAo4HD?=
 =?us-ascii?Q?98VEjBM1zjvVFjToYyQ++uyv2MMKeOQcO8cuLiiW+5Q1ADxmPTm1aT8dGNTW?=
 =?us-ascii?Q?u/yHrfntV45eta4K307JZ9jydBn9xQSK0HuaSGRrCS7gm62cQmnw6FFgCh7E?=
 =?us-ascii?Q?xFLEYKp/r5Ww6PvYDsMR3GuyByx5MpEI9OE7daWIxvmHQGcMGxs9NDcZLbRT?=
 =?us-ascii?Q?hci+izREB4UjGsKBZda8LRDjOLCsLNw6LMDDCljLMQWuqPNU1f8sbvi8DJT4?=
 =?us-ascii?Q?qL9xtJ0JENMYvU/4vIHOWvPeSRLKyM5CVJObVk4JuGtVv9K72jhf+rIPJUZs?=
 =?us-ascii?Q?phumQWfZs/pjclg6tIMAlCRPAY6ZMH54HtHMKz7pSnFyFq2Tf6kvZjLZeCIM?=
 =?us-ascii?Q?ZksrFDQTWc2DfUszLMvWFwopvhzpMF8cup6PTkEmhgfv8CvxTh4ukKyacbbv?=
 =?us-ascii?Q?uKF1KWh54AbmVnprcj1rvpQ1Kg+GkRP68caecGlkxxREKXdZkwXD8o6IjvFx?=
 =?us-ascii?Q?fgYsqSJU3XH2cO9Uzsbtd+CriLSG8DwyCK8xWOaQQpUqS4YOtkJ1zgh9fLWz?=
 =?us-ascii?Q?uttCx1VBeyHPHg6pr99s6GMVGj1si4s3H2eyDXgChuFdeG9/CYSood8IwKQ9?=
 =?us-ascii?Q?kzXKAnLuwv9Stc/ByH1jjiWcTW3A3U2GRkwfqBcbXaCgBJBM+Y43i1N4SSEZ?=
 =?us-ascii?Q?tKAxJvXpGAiLV1XH4SBxUKnFKm4ZRgoxswbHAGr2PKx597QMR38LxED1X3HC?=
 =?us-ascii?Q?oO31OcwRvJDxsdIGw6MKbd+1HPgQTR2ghvSm7QePd3YEZSgrFWwVIiCus9Zy?=
 =?us-ascii?Q?tJ6x1flr6OIcqPl54GyoA8GoIMEQ4yXWoQ+gJxyc/eDZpem+bghuVWTPMuYr?=
 =?us-ascii?Q?krnhi3vNLPLSN9Kn/PXYwAR3KK/tIrw3dMfSj65G+79lcRhU8RkBtvboI4Ot?=
 =?us-ascii?Q?biTtYAL4MLBMaYAXwvQ3nu8X03pYpTrult4VtELlB+9upO3Wipo1XWH53Zml?=
 =?us-ascii?Q?ttQFuppLzf72dmfHUj8UZjU65/ZKBsV4VxmXE8EE3mxTbFcjDdeMZhB5fLBI?=
 =?us-ascii?Q?0R3726IlIQ0LNNTcHQ0K9NKj/0VEH0TV7D9PEdOnk0vxscPUc3kcaVuZals5?=
 =?us-ascii?Q?WpxY3AltuJC6Cjz4R1BROxY3j5sxNoROWLABpgAN5Yc+I9TiaFpLFaAhT8bG?=
 =?us-ascii?Q?ZXvxfMFDIwtRH7J3fM/KUVytAXt0iRsOdxHY2Cl6mgz0zwzgbOzDkLFgKJde?=
 =?us-ascii?Q?wHrzAhNoqPRyMU7XKOD2yfr2OC7JsbczaD5/gsPAo17uoyK3yCpoiD1Tiarg?=
 =?us-ascii?Q?uNbC+vkmIdz0PaCjkg1UKzM4KkxUB9iOWTc3OpkvI2vXwrhv5Cu1rXQAlTqL?=
 =?us-ascii?Q?2pHTB5paAnZP8aFi2bXLlX6WO82wOs16iIv3Q8BF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e25b46-a767-451f-d969-08dd832c016e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:31:58.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4BvvoHUGY27TMUt7k2pq5BiyXwQcvdJugVmpsPkFoZiOvxwf39A4ccQqktdPCAs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095

On Thu, Apr 24, 2025 at 12:08:56PM +0530, Vasant Hegde wrote:

> > What the iommu driver should do when set_dev_pasid is called for a non-
> > PASID device?

That's a good point, maybe the core code should filter that out based
on max_pasids? I think we do run into trouble here because the drivers
are allocating PASID table space based on max_pasids so the non-pasid
device should fail to add the pasid. Tushar, you should have hit this
in your testing???

We also have a problem setting up the default domain - it won't
compute IOMMU_HWPT_ALLOC_PASID properly across the group. If the
no-pasid device probes first then PASID will be broken on the group.

Tushar isn't hitting this because ARM always uses a PASID compatible
domain today, but it will not work on AMD.

That's a huge pain to deal with :\

> Per device max_pasids check should cover that right?

The driver shouldn't be doing this though, if the driver is told to
make a pasid then it should make a pasid.. The driver can fail
attaching a pasid to a device that is over the device's max_pasid.

> FYI. One example of such device is some of the AMD GPUs which has
> both VGA and audio in same group. while VGA supports PASID, audio is
> not. This used to work fine when we had AMD IOMMU PASID specific
> driver. GPUs stopped using PASIDs in upstream kernel. So I didn't
> look into this part in details.

Uhhh.. That sounds like a worse problem, the only way you should end
up with same group is if the ACS flags are missing on the GPU so Linux
assumes the VGA and audio can loopback to each other internally.

That should completely block PASID support on the GPU side due the
wrong routing. We can't have a hole in the PASID address space where
the audio BAR is.

I suppose the HW doesn't actually behave this way but since it doesn't
have the right ACS flags the SW doesn't know? Guessing..

Jason


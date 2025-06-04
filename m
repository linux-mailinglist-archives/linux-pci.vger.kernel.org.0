Return-Path: <linux-pci+bounces-28967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD513ACDDBF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED90178F9A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3021256C79;
	Wed,  4 Jun 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MAUaZx5q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550411DFF8
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039502; cv=fail; b=Laj8v+pWIYtUpoUHcKvBzXbD0CGJ0SR0LGeSMUBOqpAJ5iV1xRKpZtBpyPfkl1HbCy0e+JLyHq3d7khdYlRyBYiwd5jYYBNP/qBpKeJBxZxCzJRRm/ogrFysNExulPcOEcMV6aGnmywGk2+dDV6oQr8IOw6tSbY6tv22kvWNwpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039502; c=relaxed/simple;
	bh=tdfwtBL2kH29AUVjHFrbL7szMKe31dM0dDuWSgyFntM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o4v3uT08tS1WEY5Q2L/k90YLDEdbvEZZWfwqEOwhry8s1iOm0W9/mjtfCwDxhtDmSmbxLLqfeg8k7o4pxEGfi86E4Mlozj7E2eyKOYOyH1Zmc+a/fiMOLhBEaNbQDkXp/S1ooFM4M9JJmunJlDmdbXmgRfTK7AXz0zTnb91V/hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MAUaZx5q; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsy3tJccbD7iyFWANG1m4Qo5CT0U1BQg1oVC0thrm9VslFKvqJXQaoplgGDNkQ8uzpJMG8oWIgLzcolsZotQv44xdEoBEj9/3kLCZ6mAv6xVwPBrXln/Y8bwzBHnjaUoSAbN/DUrFBs1Dezh5E6jCVVl/QQohbBLJ2HhgJVTt9GpoC9wPf2tie5pA0WITbC4bU2tQVGF5HnqJ6I3n0WFxKJU0aYa/abIUAYto0iSpkzzstBXdU7ixf60zyD57yoDTr+CTQInEJiOgx3mnUThgke6Bgs/+Xm5q6IZ8tr88UExpHpZqfy525xjpnyoJcnU5LNIUEO70Qxbs48T0958Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxMmuHycknI3N0ZDW8UuDzLRUmaWFHZPAg6Uv5PuzTQ=;
 b=KnsFXWtvym0r3pnSfCEO4pMK8stf3KhB6z6ZQofxHVqnruwkucFSbnGhL7DtUKvh9ZLlZ5GQUlBpUF/cZlFDQcWdAstKyO/IUVHe9WFNnZl9sC0LbtrLypDKvNJ27WgQu3w6egw37DmFJbofODu61VMDFRENoyGT1FMWcQorQ2jinh+CWBQCRf+f4s6ft05QURxx0mknNBFBXW/m5bZCMfDsGkLdOReOFs2oFYu1DB0lapmlfQSvq/OtbP9hqG/bEsKPlDEQPR6Ux/8V/jOyfFIAfkcMgUdd8DGSH7EhhXkHPA3PAha170tMaZlJWXPgr1j4ZWoNiPFOECjT4KyyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxMmuHycknI3N0ZDW8UuDzLRUmaWFHZPAg6Uv5PuzTQ=;
 b=MAUaZx5qr6NJ4A/9nDQOwyHceLxGI3O00P3J+MhD2FrGVxozW83qVHvhddrWAjcVr41N99kOoU4CF38DeNjW5YBANQ7Ql+vUrvYvMkZQaI21els+AyDYVRuaouod+VKYQIXEBV2pPkquy4Gt3m3rLyqFsNSkCu5JIpI/1JOgVvRu8ocFzM8PbIWJSnFYhWqZfrFJlxY71v9MxsYpVtrcdYVLJ8S3wA+OFXkYI928z7/OsuL/7JsAJgyIHHtp5rsWgtrPRCJ5vqSShKc3GDcQ8uHsh3QETnsByw/4F+6YVG/RkKXEFK6lyHSr3eJrqsqUl4WGxCDJrrrsH0ihnmhpbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Wed, 4 Jun
 2025 12:18:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:18:17 +0000
Date: Wed, 4 Jun 2025 09:18:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250604121816.GD5028@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <20250603121858.GG376789@nvidia.com>
 <683f9c0019be3_1626e100e8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683f9c0019be3_1626e100e8@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: YT1P288CA0031.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af50cba-8e20-457b-8b6c-08dda361e30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cgV3jnGQdM/5BgzxCqCPW/0Q6qgS0r5Q7RUk/MxhO1V693mb4/6HVQIw94G4?=
 =?us-ascii?Q?ubxxK4IAyMiNlZdi7PQTnNZwqfuC/OPDhOEXvPdI7cmsFOQcHbG7N4M1bU8w?=
 =?us-ascii?Q?cSwmJlH7uyT6mfsmDPboIlEPJMuH8xPnj7bN82K/pEP++4MIJWVlontxwX9p?=
 =?us-ascii?Q?oDd7lIWF7ulkSx7rbtdLM/pk05j+PZBGeJtZaLoWCjXI4MrR2Qs+Ms/oTSHy?=
 =?us-ascii?Q?tfANokzky1+katbjmK8cy9H3ECgo62RhZW2yGzAumq4GP34Llt1KtHyUwn0r?=
 =?us-ascii?Q?GFSZ+4GE/7XnGnNmMPGWCh0VYuWDwKgYphoX8A3O5qHBzdcswW5BgFlWKjNW?=
 =?us-ascii?Q?tvZZhgda14E7K9sQuDK182sfxVmJij2/KPFDIcKOmhtSaGLfoGvIRg2FML1v?=
 =?us-ascii?Q?AZKgBykPJMphtzp1fx8rvNvU5Oak7R8rk8pVn51AoljnMtO8UtB1jvEe6/k3?=
 =?us-ascii?Q?prsrqvkXlktr2fgCFcXxkQILQSPX17Xa/NIRM+9C4mfwit28KP0gfWB0JKPe?=
 =?us-ascii?Q?WUkvFt856bzwaQvIt6Vk/EUxGz5pmRrhW42D7r5rqGUkoshMUd25c9JMvDFn?=
 =?us-ascii?Q?oMm/coe/plaBDzzL0lh3KrgVwPzGTOHUCey3Oo+XzIGrm3eDtYfIG31UFROq?=
 =?us-ascii?Q?lkqFwAK8RQJtD6KLG9WyEpiBsUqquVnyPU1/6ncK7OWl10WJcZIVysi9Fs4h?=
 =?us-ascii?Q?kIlMLveexwtjMS8q1zh9NeLzLhYLwcQkagYgO2RHPAbe1/o7Quv+Lvlxph68?=
 =?us-ascii?Q?iuKBYusTUEsGasOCysK95KR+voi6/tXs7ShPkTqdsq69FuGsoC7i6v95XSTk?=
 =?us-ascii?Q?Fd8wM2RBOzBvKYy4fptjBSb/JtlSR47nFZPSIqXMyECwVuX9akhiAKQbY/R0?=
 =?us-ascii?Q?DTiJcZr+GuAuGB5wUxGjxiweSDjAQic0XDWqGNTJ0+2zy3Z3O+sLuo8UDLk1?=
 =?us-ascii?Q?7e3U9cuZnU/tqHZMJHkaiM/X5UWoviWmQLTvXUd3ycV5TpV2KrHUQMTc0uUm?=
 =?us-ascii?Q?+6XYzjblGuG1vas+S9Bg1V1cek1qord71TyMXXjU4fCQ1VNo+Hstfl/yioD8?=
 =?us-ascii?Q?92zHqPKGHe/ZGU7ozj7PaT/22tfXNWLD70+bbHX2SCe2OqdC83h2AsWxtnIm?=
 =?us-ascii?Q?T0QHUVcYUErHU3JrdXyv8MwVWPa3ZLrzCXF7jOOdNsU9yS9WnNUD6Pj9ZqMt?=
 =?us-ascii?Q?f047zCDYy6ktEF4DecxmH0pWtr9HUFhwGFQd/PwpmREXC+McQRy+We6ZN/K3?=
 =?us-ascii?Q?ljlo1A+/CEVDzEDn0Fh7il7UdkL7BP260+C1hSn+7QMrWiTLteHjhQVD/D7y?=
 =?us-ascii?Q?n4OQRaAE7163MlLSAHjBkOqCcXGyInKMx2VwH9GUJWEyXRpKa4wfS+ep6G0P?=
 =?us-ascii?Q?+9VAnm9j4gb2V+K/g4nl1/pCJc3+A/gcPPCzvbUsNs9ORa8JTLUOvmYaTxmB?=
 =?us-ascii?Q?zssWQ2nZtOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HW34iOBagU3AMF6s2x6b5ISiGoRWg76TlXdaQVScNVyA3TPXhwIs2DQg954g?=
 =?us-ascii?Q?O3bG+ujdCAD9g3sBr4Hkf6eiYQomjDqolONW0FxjndABWS9HJD0U6rpCDifb?=
 =?us-ascii?Q?gT9jScDKyq34+SlZKdPzpd32HComc2i7Apiq7SGS3LvzCrwhJd91CwOJvQga?=
 =?us-ascii?Q?VjAv8lBLmdWCIgFkB/++dqj3LU1NxWDIaZcVgNGY5276NhwmKvIenu5yDkOF?=
 =?us-ascii?Q?pz8VnMoQv3Cy+fDTSh7Fxq8NRWCMntv2uNkhvOEMA8mGAPdqkrfi96y22UEM?=
 =?us-ascii?Q?/rJ8y+oRhkprv6WwTigyk9CkkjfTTkte7tdHsf0EMUluSnsUpdVt69XD/MV8?=
 =?us-ascii?Q?4/lm89oYT1hUxNGaucUhF+/gNZqozxs+dLLCBkrlG3xeHv1P1ILlO2xrTGYf?=
 =?us-ascii?Q?zis1OQR2tWO0qGVYX0UBVeRGdLYm7rx3hrfQuomMK6xxxIFmNJYiCTqLc0aO?=
 =?us-ascii?Q?id2HrOtcVFHTtRQScmUgf1+SivGgbA0JGkmTwClSGPQM6DhhKP52ugo0rT/5?=
 =?us-ascii?Q?6B56qAzfVdInbx9VcmzlMJtDqKbaP5C0nzeFcqBNPTAEnWcYLexlOmybXdbf?=
 =?us-ascii?Q?fOu5JL4ZcAMC5uvH8YF39oHrJZ2HuOwUj/eRRxgTgnEaPTS+JAcvyJfzoin2?=
 =?us-ascii?Q?LA3QqytXt3Cf+mug7zLznyWt4/tM1aqIQMd4jhFzD4Ols4204LwlXLd2jSrb?=
 =?us-ascii?Q?JniVT4/jpXBBI6iSpO+Q1KFGTyWoIbh45C//bokRDES9ouMXzWH3uUHBZxrD?=
 =?us-ascii?Q?9K0tCNENXs+X4olTRbrFCkpNtj9NArQ0pIRfkdS3jxjQJpUYd9pu6Mknr68F?=
 =?us-ascii?Q?MkY3OtUneOhQqojsxq/HELz4zvKyWRtTCIqS9/Ixqn5pTFs6vJATRjyIlkvX?=
 =?us-ascii?Q?ltwu+t1nADTcwfxrkkCIq84tEEbVBHyUq+gIWaI8UMF6HVkJZGgY1qE3+IID?=
 =?us-ascii?Q?9gzyVKkWWJ5YX5A95k4qYPUmfsnXO6DhVrxL6LZ8ELFizXtKH/8xlRLJXLaG?=
 =?us-ascii?Q?N4xlDKNvb3n1cCKg7JzbHZY09nFh1a/HuC0Ld9u61P/7v6hIzIPwZMtg6fiU?=
 =?us-ascii?Q?1VaCOM0Obnj6eZKNTX06Q9X+7hRt/v6gwi7SXCkJD3cH5B79dsUJlVm+kADG?=
 =?us-ascii?Q?bwux7nef9HHeERTrdxNTF/COeqUQBjmpi2TK8mQ6W4Ae+zfUFJbde7pnfn3y?=
 =?us-ascii?Q?+PaTUW1RtM9Rvieyk8iPo8PH6hGEvsSaX9mzWvfKrvkcdvhCyAdUOblr7kXm?=
 =?us-ascii?Q?KSeYaWba6eXDBP7KGAKgmeYKPBFn5g61iAP6SzS9dCXEWkZq80jXXBs9TR3I?=
 =?us-ascii?Q?sIhHhJSE6IqkFu7RTNb+u8Ky1fnWJ6B5QDfuLTr2BoYZpZQ9tETXJ0ecqiBT?=
 =?us-ascii?Q?mSeshc5z0XuNrpmGK2xtFAXddB/F8zj6CjT34an0E8nJcc2cu5m8W2HcMeEH?=
 =?us-ascii?Q?FAreXyz7x8rRSWDfYrNl322/VP3AuKqDJfcyKcLIQaNuH/q/GBzb6fYx1zOw?=
 =?us-ascii?Q?jub+omh+/zsEQWxWXGcNERRvzjXA+FoOTrEuya3ODcfI6hO/GUBV0OMfF+6t?=
 =?us-ascii?Q?oGQbU+YqCzWjV6XivGFzwh2NOF8p3b7dI5yvGAZR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af50cba-8e20-457b-8b6c-08dda361e30e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:18:17.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YnBW8+e4YEgC/zzhqEa9x5sUu/0A53afFxVbu1ChxbqsD6I4pHdotXIMKM7a/4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

On Tue, Jun 03, 2025 at 06:06:08PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Tue, Jun 03, 2025 at 10:30:30AM +0530, Aneesh Kumar K.V wrote:
> > 
> > > static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
> > > {
> > > 	if (mutex_lock_interruptible(&vdev->mutex) != 0)
> > > 		return NULL;
> > > 	return &vdev->mutex;
> > > }
> > > DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))
> > 
> > Dn't do things like this.
> > 
> > We already have scoped_cond_guard(mutex_intr) for this pattern and
> > there was a big debate about its design.
> 
> The work in progress proposal to improve upon the ergonomics of
> scoped_cond_guard() is the ACQUIRE() + ACQUIRE_ERR() proposal [1]. I
> need to circle back with Peter about moving that forward:
> 
> https://lore.kernel.org/all/20250512185817.GA1808@noisy.programming.kicks-ass.net/

Yeah, maybe if you can get people to agree..

> > It doesn't make alot of sense to use that here, this is a place where
> > you should not use cleanup.h.
> 
> What are those situations in your mind? We can capture that in
> include/linux/cleanup.h doc.

I wouldn't indent the whole function, for instance :)

And I think I saw some agreement you shouldn't do tricky things to the
holder variable, like nulling it or whatnot.. 

cleanup.h seems to be generally accepted for very simple direct
non-clever things.

Jason


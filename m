Return-Path: <linux-pci+bounces-34229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D8B2B4FB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 01:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F08188E4BA
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 23:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397C27FB21;
	Mon, 18 Aug 2025 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8P+w2gU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26C278E7C;
	Mon, 18 Aug 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560568; cv=fail; b=CooDSkAlnbg/a/kxA8EpEIgIBXjHV/piIiMcIZ6TAYeGeKdRKwry+RvEb/yfLuB+ctc0/YgAd5k2Zi17avyPpxH0jfYyha6DxikXp9k3nl394g0HqY1fwxEkAb+ttwcWlaYuz8nHz3VPvM6ea63kIFr4db1KV8teztS/BfLGhKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560568; c=relaxed/simple;
	bh=C27v+rdtf35BbDOJx8XQ6EeIaNjH+WwCBl7c1GL6CbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qYMegrbtJSpeh+9RgZ8R8iqJrwIbP6tXvZCh82OfgXQZAwXeyRNrtEJ8DdifLiHz+EZXMtUwbc1/GwMXeXXjN3lioWFyjxmZyIHS3fLMHW83DN4rO2D8KxnLsFGCNsIXqPB11ep5fbysbcXfOSIact6KUpiCPLIhiC9UPK/LHT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8P+w2gU; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVvdfSRqFMVOMosKPIDBHUBK8AZw1ovCP1ke23E6qLqniYXYjEpB8UMu6l81qXHW+L+qRM6TBeO4l9vbfxtuu4MTv3dsrkeqSK61fQOGJs8ifSL+9YMvjB8olfAszDsJaLL2m0sCUrnp1bQyiojvni96GPXg5M+Uuehv4W8kq7rBPyICyW0yQ0H4MgJtv8PHRoFejJhOKEJPqwOTYp82+keXKrCYRapiVVQJ/zceqfAge5Oo0kBgn0hb+f8lMFZyjNyPfDWjZAf3ZaSEkegjvlSO4Xrn8yZZ7GYknpKx4KreIuvolO3RJZIYy+TASVuAxmh4ensY1Lg07sEhcqd2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5je7JVJvPAueLhLaeeTVFXe1YUqzaamlGOAHEFv38Nw=;
 b=lIurzqqKUyk4pnhoziJumdb7NPMXqVQyO6BUuIdgJFYPOgSQ+KxtxXSuAzeGmjYUeRB777ZKonbeI4uq4Sxx/VL61qDImLbgS58pgKP0p4bLI6HUuJ0dsZQ5MMfvDY2xtvsqY/W6p75ckvu+K13dV9nBM3X9LUttJRKuM+DPJz7C4tJFfHLXbznPz2vEsZF3XoSOk9SUNXuPMvheJcvm4s8Qw/6gukXwAnHqhDmt/Fm8uBfvnM1jUNVUp4YH5LB0vcu9jqz+VhIQbtcNwFwutDCrkrL8mCUyvFHUXMxxYzhJNhv2LGjNHO6fkOfBtKiBaonqqi+5kFrK6v2cjfmodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5je7JVJvPAueLhLaeeTVFXe1YUqzaamlGOAHEFv38Nw=;
 b=F8P+w2gUF68hU0B6RVPwLqsFQLYpQ8SQUyCORzdZ9fWhi1SxFohM1n2AY1feD6q121aXZl7R/K8UAhmwnKfcBs3sXAQ6fcmehD0VEnUksTXJuR10s1UGx0Gwb/5zi/hs7rzGWqiCbLGrd9QG/qAGX8rjS8IHrbETBmH9SwOT+QUtCA4czoa7NWSlbS1D5cm9o8wpyrgzDH2/ja6aMX8g891aiCOg3G0T6XFfSeSojgvKRcu2rer+PAzLtAHqyRopS4CL2Dm7/v1DSk4BV2xO04ZB0rlaz/Mz2vOFPIiRWGLGnGjcGbxc88UhjgGG8kMi7XuD86LyAfgiH4abKYx4kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 23:42:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 23:42:43 +0000
Date: Mon, 18 Aug 2025 20:42:41 -0300
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
Message-ID: <20250818234241.GF802098@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
 <aKNhIr08fK+xIYcg@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKNhIr08fK+xIYcg@Asurada-Nvidia>
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 7423265a-7a59-4c6f-a6ad-08dddeb0ed71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WBF6ZWstJIcwMt4kZ0k11PVnDHXilKye5y3igKggikGxuIASqHvhwA6nbnWv?=
 =?us-ascii?Q?v0BpW/V+JdqoTWR2wQSUh6VkRVtWTGD/mh6A4ucmk2QclG05L0+trsykciEy?=
 =?us-ascii?Q?rNMAH39VJ8+kHnJ6ac4iwx0765gi221B3BCeZQroWx5Jc8mmjXOQjKT9TvTw?=
 =?us-ascii?Q?+jXdWz4elztwBzFAjSFY2hCbB8PHQoHk/Uz+7i2ws95XUlpjUslqkf6KzZvN?=
 =?us-ascii?Q?L5X3s9vuSPNlrxv5fpiBBbi5+BfAfeZ2v/EvSmBW3B9nyv3CBHaB+7qqiWgY?=
 =?us-ascii?Q?9s8DFEWkFooECXpL5MvEiaWGg20+R2FSQ1eidEO+zTBjov7p3W9sn1JDh1lg?=
 =?us-ascii?Q?Rbd+ER0sm+oeXCv/6E4dsslQUzZVmuNUpcYOi7uXf0DP4U19l/qAJlWPw2XV?=
 =?us-ascii?Q?N8SUuSqQzUdGZxjwkwhB/OiJq8C/7uWYgog5j0SjMJT91jwyWRzMYJf7y2CD?=
 =?us-ascii?Q?U92mXE5nQIzSP5uZkMtYuu5vxr540phoWEdQWRuIYQKZPTFXcCYOEJkIVllc?=
 =?us-ascii?Q?91Q093KkwdExcGvdPgqques7KPbOXrdZaM1H2hHkN/N8CahQ6nzKCdSl1Sx9?=
 =?us-ascii?Q?Hlwo7qzu/dfK27efB+5oJEs6VBX+XoG6LqKkucZ3T4CMwIzJmLgFrcslDZBt?=
 =?us-ascii?Q?BddIXHa5ZNh2e5TqVQO0tlsTNptw83/oSPwS/7kxNJuNHEOZO47goZd4Guy3?=
 =?us-ascii?Q?N7BXYMV4aPgGCc/3h6MB+nqzvkJAsYn7vpUNLuae3ca43LdJlGHfO1kRN+yd?=
 =?us-ascii?Q?fv42H3dtVI97zKXSUyxJ8gc2MtWztM0aT8GE0IbOeAQB1YuGQdb4Tv03FXrc?=
 =?us-ascii?Q?BuwzsAdJGJ14udcdvoN9wWDFDYWYtdymqAZTr0u05oZq4e05rwJ1RcMz1zn1?=
 =?us-ascii?Q?i3lDK/hNO+dCYFsdxqcVd2thMJABmY2amwyy8jxMWRaQ2g9XHpatVMzf6Wnp?=
 =?us-ascii?Q?D0Nyy3or15Tp1nkGmTu6zq9WPBGSufpUKfjc7+6yiefW3RLW4IvuxtpBoFBr?=
 =?us-ascii?Q?e6CiwQ9bjHl4plJHbbQglwKusgzqhTi+ts1sREHr2NfS16qkrLnqxmU7p2Yi?=
 =?us-ascii?Q?lplmaHYTQ7z2zH4e3U+/aOHwkoNXhYgpbU86xpPNXwMHtmPn7uL1ubnrQ18k?=
 =?us-ascii?Q?b5SSWe+m/UdjVDwUG/BDMqINZ76nIpL7MTiuOgP101e1cp+ir951iiLdJ2Uk?=
 =?us-ascii?Q?bFLMekqY6bAhQj6VnYShIz89bHopv5kfxi7Y9rYwL/i8HOWAjGk+Eob4g1/c?=
 =?us-ascii?Q?mOAzny/UmfOIA1tmYZfno6bafZldECgIvcX2h2G65aVELt7UNZpm635bHkx2?=
 =?us-ascii?Q?sfqIlcuu1j7T5yJqSagiRG09j5xZ3UnIDKORm+z9HRyns/wKrPvY0JbICbNx?=
 =?us-ascii?Q?+36/ughmj4Jr0f7JOD6LfF8AupYnS+fPVtCbroNhg1ahswdriTzrWhk917gI?=
 =?us-ascii?Q?8vrPFFpGZTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AezlHu2bkpQnm3PkFYUwCt4EtuzMFL9vd6epv7asPoo9ZnEay1PdnZnR6j1W?=
 =?us-ascii?Q?ii9Md4fSq9W3UC2cUarivZb1xp1rUsADO/rw0i6EGmO8HB+FAeWKyuX7XZQV?=
 =?us-ascii?Q?tVVzkHemqXvYTuZJmCIkN11uVod5/8U6bgPT+rbBAXKYetIsciDbsRFyCCW8?=
 =?us-ascii?Q?amRpdzFqN8Alp6UT1C1xgCrpYYeAp+UaunB2HLGKXgFrVb5qzTJttBHYTUqm?=
 =?us-ascii?Q?EGd5ECBwZeRTFIhItsrRhIHUMs72XBF6FdPlztE9HxSMVEuB500nIE/IE0it?=
 =?us-ascii?Q?iDsccMwKwNebQHi+PaEVAX27gm9zR2Asd1ZoXm40hTRh0kf8Bgf9IogtQz5n?=
 =?us-ascii?Q?bCSiScR6Zg4KyHjYEJXrdOrH/0SpPW+59KS/9y4JN/OK79qdmnyfNtViZYZj?=
 =?us-ascii?Q?TJgBQZk3AXA+HIVAKu+NAjkTDA5CkR3bkgSQb5YMFb8u2ukytcyTLwQdocGy?=
 =?us-ascii?Q?b7UpxySjKjw5JXasymiL/RWTR/+/aEMvDE6tHjB4DzFsV/6RVvgEOGIwsPT7?=
 =?us-ascii?Q?IwH5xEF5aLzl6jOn7PviE2GbUo3Z3CsEpP/XnGHrXzRkGe2jXuBXnI0WkfTb?=
 =?us-ascii?Q?3VdSOyBseAKqL2LdpiaGScHJGoP5CnVudvRqr95DOcLAECdTKZ4zhfDbpDW5?=
 =?us-ascii?Q?/BLHZ6v1TFgSI2j5FKrZA6y4HO8YRDCevdo09149pTXNpdpzfli/ulCQaQbq?=
 =?us-ascii?Q?hLz5K9dUcrWJKmpEGi2vbh7vIj8b3Rd+Wz4RLR2x7lr3sSwsFN4DpyzWUDpt?=
 =?us-ascii?Q?Ys8zsq7YnY0NlUSAqJRfeZvvH9EqLog0tvBahWYhEGzc6ZqLphaH1EAKa4Dx?=
 =?us-ascii?Q?L6fvuK6RWUplaq7X8EvFBHZ4z8apZNQ2YwlVzVskwua4ulF3X5sZ7cs3Fs7i?=
 =?us-ascii?Q?kmYKXqm+p63OAT61m9032b+g4ryEz6Y72erc3Q8rR/0MoxV9AFY0TkW3uCtg?=
 =?us-ascii?Q?9knEoTTNlCIVzaueMgIKCzeOcN6b+xcc52umtGSzpaeUp6UkZ+RtlUF55gyo?=
 =?us-ascii?Q?pPPXdVo0cPietFE1KiNAlYsRgwl+ieVXV6F5bEgZF67wlTSrqLlM/hWu3lRK?=
 =?us-ascii?Q?12+y34TId7sDBzb8zMheqdwpisi0YakpeyxCwgkYqBQRpSrznIRxH8kV/0DW?=
 =?us-ascii?Q?4aO0F4EQ0Vc5kEnmcp4dAN1HMZCGUO4/thsTjvzW0bIzR+jp+RpQ6qwTfkd1?=
 =?us-ascii?Q?a6+6VcXIA48zj/w0KldaarYPrgPzYUUMwAAzTex2JVkRV31uvbK0ML0fwYGq?=
 =?us-ascii?Q?b+bdPV9wCIZV8Nvkb97uh/c5O/AHGfNhPAWRCLc55xKmlZIAeibDiH0w2ZqH?=
 =?us-ascii?Q?6zZmOcq7gn2D6SHZ8spfGw5wKhsrGGyWVlQDblYfrs1/FhoYAZOB9dKKj0HL?=
 =?us-ascii?Q?Ou+0vP2uQNEDC1b/AOpedR8gi/6KHXvM2QnjtqqMju+sYB2hG2ikJttUP5N0?=
 =?us-ascii?Q?rDudXklf7QXcynbQtskuU6u00RP7rqwnqKXgfhfpfbRKICFpKASRknDuM2Vr?=
 =?us-ascii?Q?s+tp590FA7bYI42gdf/HaJwFkKkD4o78mTSlhQcNvVOIi5BskK3txD0/Swia?=
 =?us-ascii?Q?QgyjS+EyNBUNXXKs5bOw7imUCrxfR/RhYAf/gdIB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7423265a-7a59-4c6f-a6ad-08dddeb0ed71
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 23:42:43.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z33DAptqq0QHaCYNyOt+tgd2RqOYXNcprSdmI/hNIGUKuIRNteQtz0pvPiKCun/m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085

On Mon, Aug 18, 2025 at 10:22:52AM -0700, Nicolin Chen wrote:
> > Because this is a very common pattern in drivers.
> > 
> > Once that is done we can see what calls to iommu_get_domain_for_dev()
> > are even left,
> 
> ... I found that in SMMUv3 driver, iommu_get_domain_for_dev() is
> used to get the RID domain for an SVA domain:
>     arm_smmu_set_pasid()
>     arm_smmu_blocking_set_dev_pasid()
> 
> These two are already given an "old" (SVA) domain pointer, FWIW.
> 
> So, we may change to passing in the old domain as you suggested,
> yet we still have to fix the iommu_get_domain_for_dev() in order
> to reflect the RID domain correctly for the driver that calls it
> (or even potentially) in some group->mutex locked context where
> the RID domain might not be naturally passed in.

It could probably be avoided by keeping track of more information in
the master, but also it is not so bad to use a _locked version here.

> > arguably we should be trying to eliminate this badly
> > locked thing...
> 
> Any suggestion?

Bit by bit.. I counted 58 by grep

Changing attach will get rid of alot of them

Then there is stuff like this:

        domain = iommu_get_domain_for_dev(emu->card->dev);
        if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
                return;

Which should be more like 
   if (iommu_get_translation_mode(dev) == IDENTITY)

With sensible internal locking

So that is another bunch. Not sure what will be left after.

Not saying to do all that here, just prefer we move toward that direction.

Jason


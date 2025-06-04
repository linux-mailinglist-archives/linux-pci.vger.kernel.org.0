Return-Path: <linux-pci+bounces-28965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94836ACDD9C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0ED18873AE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D9428D82F;
	Wed,  4 Jun 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dw05mYjl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8C1E3772
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039283; cv=fail; b=odHnJqdRa6Vj7ZV6PIIdvF77fOJY92IK84rh/zbhuHu8PKHTCnSu16+YXn+yJwXPgJai0Qm4o6InWvGViXXWAcE2CSsaVZjLw7X+xMHl55Ln8gb7C0meNobvSTFFLlmhuTHS2T9Zqsc6jWrcDS/xh1MPTbeaExQPMTuoSbf82Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039283; c=relaxed/simple;
	bh=cdjfwNeUAUH/y2ev0upJbwrHoOnnqTTJlTVy2Vftf7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cpBA51i1k8b/zYsYoslqPaMZYQ3upNdEOnUA1qHtuu3omX3k0j1J6KeE+yeGH/HxKJ+afBjiI+8nSo03o6w7GFzeGyzhWEy0lT2+pnS8YbaW+WiMqyY2DHJfHgi5oxfD2URGtCtKlBKFExl1pkrllXYiRrxwslgx1Rwhe4bULqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dw05mYjl; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4bC9U347CUkxZra/NFrysuaPblTYtDYFH9XbijA1TjZxbtc0qvK9AHNbeCUZvwxG0yh1eYq0fA4aIPjZHXrK7CMj2mn9Q0m3AnhRlZwPFhdXcJqN/ddKmJVrkWek1TUMLtPIXIm0Urc4V14o1EBNP7WReb/CbBFkwHlpGE1FGPbM+PScqg5BzA2q0h+13Kx1BnmQXWuQjvIZAUbcf+j6qjkz/3msLrqIur5Yt15sUFPf6L+W/PnDBSnIWkD6jzBYLpIKj4Y+jC2vdw3fvqNk9q5JD+jeTjD9FgEcSMK2FjyXI/Jc4HAG8Wvtx3YL708ge4VOvNBBPeupblZTetd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4mUk3URVKOMFNE5kSKBa6deUBXB9sBzPcDmzKYI+NI=;
 b=c/A5sozcFnnjFnMxQzyhjG56oieVobhrpP+aujzAgJeJRRmijtddmG8mUCIfVqDLYjCPIIEkQQkaBSAkBiJDsdshfvUHngFRcJ5fbSdFODlMmhOx7/zoZMq4+6BCawtNjpo58O4F0bz5JGcfq20Z772if/5j8Y5kOX/LWP9qwRl5GTgSaFIsEqGlnHAJhoE3z8FXiu/IPEe+k8QAqZx85yrUqKtmvwkPWrhxsAafqyKV+HhYCdw4R31qZCZmev7scfxONiddEBVIZxQEFJjftmIYlwyitw6d3NWKa371hVdUVdBbDSqP53O9s5CFjwufPdcFYdwv9WUv1XrivhDFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4mUk3URVKOMFNE5kSKBa6deUBXB9sBzPcDmzKYI+NI=;
 b=dw05mYjlI6cklxCPGCiYGL7XPMEHOxknX+zG4C2NOZzyfKq9riF+C2lQgFO8+gb3JLJZMPDNpgl6OAC9vwnkP3ra/qPIJve+KVSalx0tVaqUD44Y4D9qTWq3JKjJS+ALGCO4E0fN4dFdPl13Sjpk662ORgmCquGOBmjTOZmajLgHGDVwwo4CF/S5kmBu6YaV4kFg2IjIxpp6MhbEjEvI2bEn44p+xiIX7ih1zNgn+5HduRSbRTZIIdIrQcxNDvsVb/D8rIHB8s8szKvazFK0o1gkAv5fCWfY2jRiJDtXiXPsRhMjuDfvg4HjnvlPTiTMposVMa7P4ABjjJPXZ6YQgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Wed, 4 Jun
 2025 12:14:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:14:39 +0000
Date: Wed, 4 Jun 2025 09:14:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, lukas@wunner.de,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com, sameo@rivosinc.com,
	aik@amd.com, zhiw@nvidia.com, Xiaoyao Li <xiaoyao.li@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Yilun Xu <yilun.xu@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>
Subject: Re: [PATCH v3 01/13] coco/tsm: Introduce a core device for TEE
 Security Managers
Message-ID: <20250604121437.GB5028@nvidia.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-2-dan.j.williams@intel.com>
 <20250602131847.GB233377@nvidia.com>
 <683f965d41634_1626e10043@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683f965d41634_1626e10043@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: YT4PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: ab48110b-da4d-4adf-3554-08dda36160fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5b+XMEF4XgCcjOLdxGIQKm1rAdSm5rQ1MXqdJckIAH6eWg4dtlF2+05ZKT5D?=
 =?us-ascii?Q?cTeXU62qXgE+52leRsWSUf/nTunxC7yJKDUw1Zm21V8o08bB2256kfsZbRHA?=
 =?us-ascii?Q?zu1g1JtlA54uzXP55AVtkntWrDq8ZhwlbV6yW/1OQe0cimnvBXam7ONUVtLn?=
 =?us-ascii?Q?qAZUITUzjeStorrLOfRCesqtBmbmHjXgsmB9xs99klNqrZwq6NTjGTc+4ckk?=
 =?us-ascii?Q?H0vR0qYKuh2jdRtVerAvMIJb9EX6aOwUdSqeJwBun4H1FzUZM2MdWYZIZbRM?=
 =?us-ascii?Q?C/SbHf1x3eYvq5JR5OGOAR1LYFUdMnwQgXcEQvXnxoxeHZGjMKfC7gnpCjDu?=
 =?us-ascii?Q?z1plpoJCE21ENq9ITg/MND4Fr2gJtCRGmEHJ6WD8GngeHk6agFiLKuyVC/Xo?=
 =?us-ascii?Q?c9tr2tBW0TiKNJ+Y8X+5Qi3TDuLSWQ6fPHPtKXKSB2fqFsZeAdyAaXSVzsfb?=
 =?us-ascii?Q?mY4t4sBrt8IBm3dlusdhsWdD5FQ8Swa/Qy/zABisVzeF9mzIPb+pN173tnKe?=
 =?us-ascii?Q?YAmYHi6nsdqlpsS8cdapmXnvSb9qP6cijj5g4ev1cOtz7p2x4S5lFZCSQU/A?=
 =?us-ascii?Q?Z20C4mE+X7btZoUQkaoIJ0UJp7kp33k33IJewu59qDwpKkRbw6DWxqyccqFU?=
 =?us-ascii?Q?CRB+2RgpEABE+ESZtjq09ZGCgBjCUa7NW2UKP+waeC/UzCL/sN2l/dkNiVvJ?=
 =?us-ascii?Q?vfS5IlTyADzJj6ihGtcNh0k0ypvwfUGepgcCTSSaW4j4ih9hP65NFD0rzrVp?=
 =?us-ascii?Q?S6l93BSpmTc/eOfttWs7VKIetK+fX9B4/pVHAnwxW0Zs2yy+NEief4QXM/I5?=
 =?us-ascii?Q?TBGMqzr4IOAw0JNN3ufoJI9wLENj/QywvCguOAw+X4bUyfAvLW7zx3mZZ81K?=
 =?us-ascii?Q?ivrHez58DTSCJgUJwFGVrRKFBOxemU/lFmuigQu9kxf7q8kCNhsUF+YxzvWf?=
 =?us-ascii?Q?Wj6SUTXURgzlwFz1KjRasvVUqXi+xPA/ggjGnsJa9j11q40+3ylJspZE7zny?=
 =?us-ascii?Q?MTbFBOlsjq4PZe4cNGdxUl/aGTFmm1AJ66GrPn+03WJfa3GWLu9wyGzm3sn2?=
 =?us-ascii?Q?hUI36F25Cx/91v0DkHMA3ptPBp+Nptvo8Fbks2j8jExYQOmbI+cXmt63Aq3N?=
 =?us-ascii?Q?BY83QodubvKnoDEXsQDPHklq2CFoW7KUaJNWdq7xuHvYZjdANn5/D1VjzU1Y?=
 =?us-ascii?Q?IIGx2VgJDSciDqrv/Ej9sEv3VvUS4RQHDqOVhqwkOcPwpw+EeymqbkLwnRs7?=
 =?us-ascii?Q?T6vIiKYlBYpeq0Er8ZLZzFNPRs/Lb1p3dTd21ElFA83R2Wzx5+TRMpub19E1?=
 =?us-ascii?Q?vUj/dyiHznpNs1VVVxSXHFl5u8m914shlhITMWMIhUxIOAVHFWcyX1PD0gyV?=
 =?us-ascii?Q?BboHTvtu9bjnZqrRrYEHa4xR2eOjcFd0oK2GTo12QM+2rxTJOZgtvi9Tu3Ku?=
 =?us-ascii?Q?EjbUBECfUzg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OaSgwJMrKe1En/q2vmNyhJoVGdzZI2UqWQilikpi2iIjosC1MuwPBMFJle/B?=
 =?us-ascii?Q?9n2RoA/mm3jjhMe+R4uW+ZFW8nxbVsMuCBn8vmrxZBSsnSYZlFfDjga7+XKv?=
 =?us-ascii?Q?nLgGZ4ZonjLyf14Uyz9u1nID9SkA9z2/8eLZP2qABYjKBskYgThHFag4o5JW?=
 =?us-ascii?Q?j92JxCafogK4b/HwC69xKsMqGj1t9rg59ufploKGBMYOUt0zfk1rQTzyOzED?=
 =?us-ascii?Q?4WbjZUmGc/WI/HQd2t9Mc+QAACGZ5XrZkc0bK8pu59gtlxKZMwRF0L0NYmh+?=
 =?us-ascii?Q?DLLrxuWy2GBbk5GVFx5nsdQnh7Y9ZvgY3No9UJ5/f5X7oJauLzAjw3gr8nLR?=
 =?us-ascii?Q?AnQyF/lViMy/10nzhzLnNon/jr1RBhnzQVEml0phelFX0acNsxhLfxJq/B/X?=
 =?us-ascii?Q?iZOddVcnerEAiuAjrKSyZa+ihkaYXG8fNkq+5af+Nu8FOYG5r5/l6d2gwCDk?=
 =?us-ascii?Q?JOPBkiJzzsleTSL51o2CxC/SdD5JOCF60wGYHRQgr+aOv/S7Ngyx5Gm4xpQq?=
 =?us-ascii?Q?vkpbylbF/QVZrmMw0ilzcbBYOcfxSyg14JN/j5VJufDtYPskZQzdEWj/0P+j?=
 =?us-ascii?Q?zEfdPnucfpvmqxjQcrCGIDV0mOlDG3xzVNlb5ccaf687hzpGNFFfWgWMBzC0?=
 =?us-ascii?Q?JpEkUGteErnNm7CZqZYUVfyhgSNpkqUoyqjLa8h0/nl3mlByih2mDB2iAnc+?=
 =?us-ascii?Q?x0BXuBUkJtmohHVne4J5CbHb/0JoRNlxrDp+0lX3axcxu3TdZ5R0Do+DiT1q?=
 =?us-ascii?Q?ztC2rUkm/R4aDkdL1Y4+7oJalrilQ3WI0xpgBaTLDvo+xWvx+2L7f6B12RCA?=
 =?us-ascii?Q?wjemPbJDHQDZBQbElpc/eC/HdQFWJf3YNQm+hiweFZ0Sc6qsLZbzcEYQD3EK?=
 =?us-ascii?Q?RnaDuLQKF5+DytrBQBVyJwgW/mLZt6nQa7cyZDf8x3irIXsXJm1698rO9yqK?=
 =?us-ascii?Q?2rT8vR1lCrt4edpfaW/3NPl0AI1Q/zVMHNAK8Uz/V7ixecXK9kplO3x9c1cJ?=
 =?us-ascii?Q?4SZyTNax/rU1YZv9nSuHh2GlesElQRR2aaPwQwdr7W9OW7fDxx+e+EcnxjA9?=
 =?us-ascii?Q?KhNcXn4TcuneAFNCTBwsuXKdr/05mlfEnh+xlEXExIyySvqPKk6r9u/i6c9G?=
 =?us-ascii?Q?DV5OvpztWUTcCEYAUnkCLxhbbjo61mHk7KUFI6TizxKI7sU6OlaX/Ef4WGOt?=
 =?us-ascii?Q?/2f9p7Z46UObFiBf9SGiKecQzoPWLeL9wHJJx7TaRy19+ZSDZB5j4qFCjsHk?=
 =?us-ascii?Q?S4p0ivaCpHopxWao3dM0/wCqALwNbKmimdumVqZHBMNFz+XYUxkd9Mz5IthW?=
 =?us-ascii?Q?LW9ddCv/AaVgyWb0A5FP0BWp0yY0Jn3T7L6I/nzYibYbElkSrAJZtXrVyirK?=
 =?us-ascii?Q?V9JM2tVqGNHdknOwrCzCPPhsDVhM1ydEdMCVGru+TjYyuaWrtNeWQjtFxfBH?=
 =?us-ascii?Q?SvLDIZnZcEnqGHVKp5MgWlC1h23BlnJu2nrqwjLqjx2d+GBtX+AKSwpQpF4x?=
 =?us-ascii?Q?I3ldDygqlPdeKpIIzP1vlHkCW572bMHML/c962nLGdXWnuZV6XizwQREwuto?=
 =?us-ascii?Q?Yz9kuNgDON8ldxQcQ3oLtbBtGQtBGwPhhhzWYvrX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab48110b-da4d-4adf-3554-08dda36160fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:14:39.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqM0fr8w7Vpdv5h9SxbMnFmmQvY3/6Kq0A2Xhp2Bz1vduEbkl3eOi7qnP3OdnXiW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

On Tue, Jun 03, 2025 at 05:42:05PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Thu, May 15, 2025 at 10:47:20PM -0700, Dan Williams wrote:
> > > +static struct class *tsm_class;
> > > +static struct tsm_core_dev {
> > > +	struct device dev;
> > > +} *tsm_core;
> > 
> > This is gross, do we really need to have a global?
> 
> Let me restate the assumptions that led to this, because if we disagree
> there then that is more interesting and may lead to a better solution.
> 
> * The "TSM" (TEE Security Manager) concept in the PCIe TDISP specification
>   and, by implication, all the CC arch implementations, instantiate this
>   platform object / agent as a singleton. There is one TDX Module in
>   SEAM mode, one SEV-SNP CCP firmware context, one RISC-V COVE module
>   etc...
> 
> * PCIe TDISP is the first of potentially a class of confidential
>   computing platform capabilities that span across platforms.
> 
> * There are generally useful details that platform owners want to know,
>   like number of available / in-use PCIe link encryption stream
>   resources, that are suitable to publish in sysfs.
> 
> * Userspace is better served by a static /sys/class/tsm/tsm... path to those
>   common attributes vs trawling through arch-specific sysfs paths. E.g.
>   SEV-SNP device object for their "TSM" is on the PCI bus, the TDX
>   Module device object lives on the "virtual" bus etc...
> 
> So, create a singleton tsm_core_dev to anchor attributes in that
> "cross-TSM" class.

We will be very sad if we need multiple TSMs or TSM flavours (like
PCI, CHI, whatever) down the road as single TSM was baked permanently
into the uapi.

It is far saner to have paths like /sys/class/tsm0/tsm/.. and remove
the global than take the risk that one and only one is the right
answer forever for everyone.

Jason


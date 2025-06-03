Return-Path: <linux-pci+bounces-28922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380CDACCFE3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 00:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB17B3A40CA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE242253B0;
	Tue,  3 Jun 2025 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/6MPeoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A319CC39
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990014; cv=fail; b=Kz8kaII0GLrw7p+61vvNARBCDCQh03I4p9Q2loOJBU9mt12nQRZMFRMcAvIW7DDnI7h5yG2qQ7DMoC/BnXPCteW2jj0oB9C/kBWgnz9u30eOkdysJyWXaQ6gEZ1OCYx3bdv9ub8GUtfgKnG5ZCvYKtKFsD9o/k2bv+DS3BktvC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990014; c=relaxed/simple;
	bh=8R+fS55bl41T/VqB0bgiRelztBBZv/+Px9pZDcTHeXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phDz7giiAgp81iS0zsDpHhxXTXTRADwxXjb84oaTVqTbb8RqNQgdiPbOW5Sq07rQfv9G61CsJ04GDJHT48CB8nPsvoqRieQvD4ej3/Ylf5YgF9zVd9wqTp6w8wFBn5aoWoln5wERmRIo8jVsNgZEcKO8H71nMTy/S8Ifxdba07Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D/6MPeoQ; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgCa0ID20+xnWqC1BTemlDWMiczDUkK6uLdz30EaD1+koxulUkv346rKh0gjGIfFDzB08M80ka/X99yHD0mjAoPQugC6TUcJyXwjfn98ZZjH/xfrQ7z/U2pU0y9HnEzfgvugiCWnnnuS1azrr6mwrMk1RxMfXq338qTkq/rADxTLIrmf12WoWI1j9lqAwdKwBIrlzla3eJVzamvYqq4ZXuoeKh9CZd6sZZCDTt4P3855NXE3GQqCq0j/ui0FGsFncucXd14G6aV5v1vRQlq9+JSslaituFuFxRhah/Y6eguNXfzD5uMBc61Kc/k8jelGSQcDwg9g1/abru/J+yAziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MziY9EuP1V8bGF14oHh9pQ1SHyBr/asjPnVFLwO2Gbw=;
 b=uHBAXh++1M+0yHX63GB5vIw9uY9pp93BKoTUxEu6EOfiSCfo5+YVi9lir2s1+3vn8bucfqoFn8wwscNT182HIhMG4YwfnSoew0Xf1/RlKfo3ocWwiv9ew/3BkFLhIXfIpILUXndIOCUvDW45DLo0X+bh8miY07IeVI/fHazxi6zGXrh6ihwBim2LYA8UvCLAcqIvcx2J+azAoL1auO82iBivyG7eXbsG52qa6mx/IFYSXU9DsOkRxEZJw4HAqT0VKyWiriYKE3UBr/A4MOjGraWytuHEDj9OYyPIqdE7gDjDZskJlOpGxKHosAFFfCVwHJvlVF/8Qg7jli7k2MaqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MziY9EuP1V8bGF14oHh9pQ1SHyBr/asjPnVFLwO2Gbw=;
 b=D/6MPeoQ/OefY0CzQgT2AzMaiT7CoEUnPvUIhbLDF/yYDAhjAudzCLs8CDVJpOQIFowtsXSWqgFbi2DPXhOfqCVCspz6yXq7HF3a73WZLEwSaqsZuHimJAM6eSx9p42F160CI+TWvbJGJT9gLFZzHUBH235fQqIA3RoIM5/qzSJXIveFRWy+Vm8Va2Bae/UXy2OxSVNa9mBNQYgVYweUEnYy77Ew69cSIReW5CVFL3+qov2qxFx7TUgKjxbNnvt3F+z8VmWoZrs1+knIBJAFXGSJRyvmc9vOEolhQrQNQW0rnwBPl3QNyUgnK2odptp9iQ7b8s44DPEO16iRT+R5kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 22:33:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 22:33:27 +0000
Date: Tue, 3 Jun 2025 19:33:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	sameo@rivosinc.com, zhiw@nvidia.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Message-ID: <20250603223326.GC407344@nvidia.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <363a3220-e43c-4965-b138-b85f09a5907b@amd.com>
 <682ceffd717b4_1626e1006f@dwillia2-xfh.jf.intel.com.notmuch>
 <cc0e125a-a297-4573-a315-89f4f95324c4@amd.com>
 <683f76a7324e3_1626e100df@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683f76a7324e3_1626e100df@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf463db-4e35-4df8-c33e-08dda2eea88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?suFUYATid+ABWnhZImwwR7GlQGqQHpGKOAq33PJh8yi1Vg8bWKpDQ7HHkjNk?=
 =?us-ascii?Q?Lvj8aMmSefLQulDzzR4QMRxoViM3JzGyKJk7zYANdPA1DpeSb6nK7sdbeh9W?=
 =?us-ascii?Q?MmpyYelyEKZvdgMvISnW9t60HXSO3cu/hmHfRFKnh5+LGB0pcOdujKbJtBA1?=
 =?us-ascii?Q?LvZhvS9+tDWXHJ+0HJBYFujzr364Bg0ZA0WzxZque11Ki7TDw+nD8bg3wBZ5?=
 =?us-ascii?Q?OoMiWQ1SpWN2AtIRFHppnzNUoOpFgEkJQj90VOOsjCjR86x/WUUzW+OZiDpQ?=
 =?us-ascii?Q?PMgZVj8ZB6K9YkGIWQpaC1oYlw8Tpnsc4D8sXm7gvPMwe+XIFjcNHPeR5U4u?=
 =?us-ascii?Q?uNlN11zMG19td1AoIKQz4mqWiR5My5xtpLSzz3drn1KN0IecJMPLxDuD/jme?=
 =?us-ascii?Q?zp5CVQX4Ud+Y8IDUtUIy451Y32iYBkUXwhZEkuFA/FUO558Jc06cLlgwDMuT?=
 =?us-ascii?Q?x21F10SF+gSQqKn0/V2WK7Qf6LGlMZ7EDcLWY//+xBsgT/BQTw/ldnWzat67?=
 =?us-ascii?Q?1PWc6+v8+xan7igMIT6T7Qub4BeypYb0wT1U858eP3WteDNNnpsqwK+9k0IZ?=
 =?us-ascii?Q?ibvKi7eF/220ZIz5uOOcKF8xFKn2X4y8kk8FQ0+8ZwrixuLDtLifXXCJXA8t?=
 =?us-ascii?Q?3rrysskp3Xcj0Qacso6Wu22TCAKjWWrqIliC3UKxPsL92ZGs9H/UrqrYwa3n?=
 =?us-ascii?Q?uF3N1cRbPSs7L/Cc6GxdUrF1pqAAlIFyf/agH8qF0ow69zKr/km2jAchSFds?=
 =?us-ascii?Q?5akFP+SLaocQICaEMDG1YYcbKMJpk0etuT+jHZzrf1NYUNuM2rDeDKbd1Wtz?=
 =?us-ascii?Q?AYrWbEe/Pq56zPVXok/0lWQQnnOBCuomNKBHIX8r2mZFp504LjS9EE99P+iR?=
 =?us-ascii?Q?zFk9glqzz9Jmj6ZzD1hdmBRnVV1VbCQpKb/nXw0S13yRCKYogxViPRikAk9a?=
 =?us-ascii?Q?5+R+GmP99xa1jMKBYjjdmLRPUbeTZGmlJb04otv/VFziPYsrFge1OoWG3H7q?=
 =?us-ascii?Q?S6H/v/7VCK4jFecpNsgz93ooE2NrOK7tbcBJILw2F1XHCuBgPMN+h54eJE5K?=
 =?us-ascii?Q?/O7JsGFK3whfQfSQRf7JisUYtCOrH/fHllhUWH9IardFx7aGT9WTGcNC1kvZ?=
 =?us-ascii?Q?w0rkMzdSwOGx4Rjn6Q8C36JM9EOwjWzIvtP50NP7WyqujMEEVuMw42WcdGm9?=
 =?us-ascii?Q?un1W5xXmspyPAayM0yawnHx4df7S+LVDDQjiUf8fC5gI0BOecACDqEeHPDvG?=
 =?us-ascii?Q?7Ug0zAJQrnTdYElH7vn1BXL2eq3JawFYXjqGsmJoEoVtEzcWyRzW/MB+U2W8?=
 =?us-ascii?Q?VxATCg8emLJMmMEgBJNNGdCi3lZD52WOFIwcbFPIu4DnwQXqkhhNMOmG2cJO?=
 =?us-ascii?Q?UK74HnJvIkjxXFq7yyHQLJQhanhAoIYNAI7FhBq1pHV3my0VKq0eAKV4DDW9?=
 =?us-ascii?Q?iCMCuY1X9Ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gfBO+THviZZoHliciEcVdURw1TNBYFwrFV4IB/zlU6bi9QokIP/wbG5y5poc?=
 =?us-ascii?Q?2kqmxKIljwPP/7zcl20HS2UtoIEJtVPB01wuLvBJOX3Bgw/IdBf9plLXwe6L?=
 =?us-ascii?Q?VK1MTJp3svKCo0fU6efb9Vs479ZQLA39dWJ4r75G5Z/J2QMdsNbKFxvqgsCA?=
 =?us-ascii?Q?MsVvrflcZ3VFTQMjmHcSb4EADbhHc6CaRlPLyCAeYoO3Kj/jykqI94u4I5QR?=
 =?us-ascii?Q?8Dh+ZpWVEYDzGYsDBHr2qDl2fx3ddwZdtkGTqg9EtqDe9C0i8ADikjxyEW/7?=
 =?us-ascii?Q?e/T/mbCXgK7Xz0jF09RbuRmz13yRZqZQfMhJyzrX10FX2wV+Pgm1eShvtB7T?=
 =?us-ascii?Q?QA1zuERhLG0HJUGEPVN8DxZESddx9jHVYswkCDMeTJJyvNJjIxDWfpv/DEK9?=
 =?us-ascii?Q?nHVrtfA9lfz0glkx/RQ8t7MnURFGbEFnnR4QI5gLwNkrq4GyVy+8bj4vfrQG?=
 =?us-ascii?Q?8psPA84WaOY+h4EG8j/1kjBZBvkHW9ZIHT1Vr6UHZeabj8JdQZvN9Nog2OLL?=
 =?us-ascii?Q?6D8aIj52shpgMIDDebrc3CqBXibPQXS0W9YdSWubdFiHzx29g55mU6ij/Ebc?=
 =?us-ascii?Q?iWIWr77coKZsbScweZephtfCJveV+x4zQEFLGCNuL3QYMA9x1mRCRSfgyUev?=
 =?us-ascii?Q?IKJEIfTnVbVnv2xeeEGpP5GA0wVD3nTDpnlEVIOsUAM5UKZDQRoJD4PESWAT?=
 =?us-ascii?Q?OybQb6CRoVFsjmLzjRwLAZ09Veb8OrhxJabM9qqvEJjhVP/0azR5cuKftiC8?=
 =?us-ascii?Q?sC++3p4UliTc6fL2YQQJ2pwdwK+e7AUcBiRftJeedG1jn9/5WBa3Ciw/+YWO?=
 =?us-ascii?Q?L5wBGPCMXC4I+YYGii84nRU198jnEsLAjeDF3rEkqO/l6AzikxTaSca+qTAT?=
 =?us-ascii?Q?MQQVdleolqOqklFCKy5mRQY0jwW9d9Fxg9AuzmXwiTrj9FBWeLoPD3Y15N5M?=
 =?us-ascii?Q?nmnHPH3Cu62aRWEc4Mg0LHgUtnhM8ektZIvoAVa+OucRkNqCX4rlCMeFJVsQ?=
 =?us-ascii?Q?eGPSoMoNZnI3Ag5KkK5LT1tfx1dL+LhWhe026+0H+0zbX1W/TpzxJVOtG9Fc?=
 =?us-ascii?Q?s9nM2w54cu4uXuyZYTkK23pukTqKAxWiQn0WoHEqfhAr+rf7lUNkK0LqWg9t?=
 =?us-ascii?Q?QvaHi88FmhONnad30dznfvT3NHNKhIcutzC6g3fkbnjwDCPQj5wukzX5bLIN?=
 =?us-ascii?Q?TpmCkQ6pP5Si0QqmfKT0tbNFdIq/6zfRRWU8vk6rkBtTak2rh4IarAV+ZIPt?=
 =?us-ascii?Q?3ctKkVtdQsGVGCSVemVaDwhmPW58sBakuIimsE5/weQSaxuacBZUeJsAYQdK?=
 =?us-ascii?Q?gNqJrym2QMZ1pDXgJeWvpbECqdhiXThVXpANQZs9tqtiHGbJ9ict6fPv4kUb?=
 =?us-ascii?Q?O1AMzJuqxQ5UrsGwzkWdxqm4klsc06V/rGej8E7nLwZi8mUuEL9xUmT0ytC8?=
 =?us-ascii?Q?eQcNiA6rN974ZXyObe87n3Jq9i61P5yFFIxNimYPINsZjSVvW11XgeVwEdMN?=
 =?us-ascii?Q?jFOOmUWcETr0Ryu74mTRyZLmB1nAcOD/vRt32XAfknFZ0eySDqBRbIqZrcI8?=
 =?us-ascii?Q?9qEfmgfszsrYlExNhUf4jhW9DCSBs/hpPVnyEmUO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf463db-4e35-4df8-c33e-08dda2eea88c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:33:27.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atk6uxfgscl+R/vCd2JQVnQUtJeRs8KkWSGkr/jeRSLHJgYfHuVqRnnwiTJwQufA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906

On Tue, Jun 03, 2025 at 03:26:47PM -0700, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> [..]
> > >>> +static int pci_tsm_accept(struct pci_dev *pdev)
> > >>> +{
> > >>> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> > >>> +	int rc;
> > >>> +
> > >>> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> > >>
> > >> Add an empty line.
> > > 
> > > I think we, as a community, are still figuring out the coding-style
> > > around scope-based cleanup declarations, but I would argue, no empty
> > > line required after mid-function variable declarations. Now, in this
> > > case it is arguably not "mid-function", but all the other occurrences of
> > > tsm_ops_lock() are checking the result on the immediate next line.
> > 
> > Do not really care as much :)
> 
> Hey, what's kernel development without little side-arguments about
> whitespace? Will leave it alone for now.

I don't think places should be open coding "free" functions for
mutexes. We already have support for interruptable mutexes in
cleanup.h. The syntax is unfriendly and that seems to have been a
deliberate decision. Meaning if you can't stomache the syntax then
probably don't use cleanup.h, so don't open code it?

> My heartburn with that is that there is an indefinite amount of time
> whereby a device is MSE + BME active without any driver to deal with the
> consequences. For example, what if the device needs some form of reset /
> re-initialization to quiet an engine or silence an interrupt that
> immediately starts firing upon the LOCKED -> RUN transition. Userspace
> is not in a good position to make judgements about the state of the
> device outside of the Interface Report.

That sounds horrible, I'd expect a device to be largely reset and
quiet after entering T=1, otherwise I'd fear there is some way left
over junk from the non-secure state, programmed by the untrusted
hypervisor, could leak into the secure state.

Jason


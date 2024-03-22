Return-Path: <linux-pci+bounces-5024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79850887498
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 22:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ECB1F21E91
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 21:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749B7FBD9;
	Fri, 22 Mar 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keA8aym/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483178297;
	Fri, 22 Mar 2024 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144271; cv=fail; b=KZFIKqKYTlwQKCGCLDl+Xxz3k7GxDXAL8CMRP1T/Gykyk2x6lL+ecuo2dn0u4qtEn2Bgutw1HVguHxBty6W73IHoTwRC/dLoMLh9Vec2V+LZaFz+YG6tXhu1Rg1Q1ya2xYPLPZAyqItRjixFcSVCdIYGYD/hYNhe+fIO/AY9z9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144271; c=relaxed/simple;
	bh=DfwMIN4+Xaw5iJ1gCuCLAFPww+qPotAtK7gtzzU6hpY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L6xx5UTRSBUOkcoBVnoh6WYB9XeVCU8AbbuxrEu+vpy3Yi0GAp2I3rQTuJzP5UGSPdVdcWZTGYibMZckkxie2bGLkcXWvxjle97G8OXIOCK7vqxZNE903swa8yOdfHwWhqwhORtiMmmoLITZX4cCfYpiVXiyERbS9dHUBb3cu4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keA8aym/; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711144270; x=1742680270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DfwMIN4+Xaw5iJ1gCuCLAFPww+qPotAtK7gtzzU6hpY=;
  b=keA8aym/nGxKj1so8QldWtfUe7EgVk5Ps/oWFHixdq0etUoElRcPzDdd
   UsfOdga3dxfgwHF1bkakFR7y6uCMGEjqfbq0xfCQEOZvdPeq9jmw06l+O
   tjXnT05ziPIZxfbO+WFHS0uzqnViTMho33ynarCn6bvtRnYx/B5CQHjsd
   Y+9/JgRRKBwSx+ziwV//Yi3JEDPZrPmeVCYKmI16L42pZ8XgXRu013xv4
   THyRGE5OIp4BSUnV2YhoKuqm7lS0g72YcOowFKuDMBHaEq2OPFzW7a5d9
   4o03WbvP531hGTH756zKBOUTBamv0rjsO2XWsCCaM6EeM2tQJ72WYsAB5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6043178"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6043178"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 14:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="38166784"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 14:51:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 14:51:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 14:51:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 14:51:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 14:51:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnbv1hbl/CNJx5r53wtU4Qq11FFAdxFvXCKJyiQ+9ymfcE2xfj4zsMLoN/Z09X9tMkRbKEiBzteoroIPd3AAawi8pkqHrJQlGVBkorbPw0Spw3inDnfSxSeYG5M0xjSJPDvQD7Ow9uahfnpmKumcV6r8oIUrCah8+Tx+3usuV4XViDAlvZGZhAXfhFwFeR4m+I8PQPkZ2Im4W1g/f3/lBFaqjNEDpoJjYMR2/1g7mkX2Ln/AgxtVp2RITGxKan1d2QPPhVy2fhTRGDERpzro8rOU0GMTIdWMgBeFPvJSrZkxVQbtn1hjmoWIrofA9omHLlGbz7mhKzqxeUm0A8Ng5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaRHrq1300K8DYG8PnDXyM6nkb57UEwoFyfAEl7nhns=;
 b=dAV+yaBI/M5P3vKpjVa7FE/tGXHr0U66sKvw0ft2VcjtRoygZ/UrxiAopEclIlEp+nhK7P3fdDMLAXHAETR0j3OLynKbWv2j0WADB7rQstlT7BsaPDpkSfny86NsyEnVAU64jZ8JBn7ge6dwZc7dUtb4TWTa53oyTQqrnWUZoQXTXIS1HeXQGZXDsTnUl/sQeLmJuBRUWsCXhVmmDVo/xYtjONXR7CSRzb6oBpPhBDyHVEbI0F3fHd6NfDtR1j5RdI7KEF6kvjKvnAbAt4PVu8i4ElLPUR1EVU5f6FJ4RtBD7v5NHj8Q8DjHE7Mz3VRVQtRJRCBA1urk1BjJoPhYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7319.namprd11.prod.outlook.com (2603:10b6:208:425::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 21:51:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 21:51:05 +0000
Date: Fri, 22 Mar 2024 14:51:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>, Stuart Hayes
	<stuart.w.hayes@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <65fdfd46e6a82_770232945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <65fdf85bba0e0_4a98a294b2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240322214251.GA1377469@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240322214251.GA1377469@bhelgaas>
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: b917ad3f-6bef-4f49-f52e-08dc4aba2c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5B1DbBv69zJ6ZGbq63aUrgM3iMXAA0cWOxYNmrAjsPx6BPfej4Zfzim8jSJIadn/ncoLxLASHFGRzmDnW0LSs5AOP52Dm7u4VF/uA8imYSciIycCmWHw7uTSuYOZgRdeDDQkQSian5Y8Wk2A+A6Veo/2NS+Yrt7USrffVPBHjWTFYaraJfaVt521eu8U4gp/1/R5OJ+8jlrcDfnTZutAZxHlgwGYwiJWJFxYuic45j0lRKiOiRvgNZpzakP1NWazKeJfZALLY8IgKdlTforWGvBx0ElDg+Wwg6R4kXwRlp3gxKFyi7KyssCaKmeObKVVcBg1ZmUmuv4BbW8GgUGz/JKEG5NvW3Ggf8vXxiNnF+Y6JFNuOqAZ372rg1CiiebXcpo3ZGF+slvrYSnT9sMK72i2kKj0eoCZHY44vX1Pm577PODp7rJsF0fjhtYZ7RyJKzBF9KfxcTQ6e4UVKsN6tHDEWJ8/fyh5khRx61CAgu+BF9J4MWwBKnEV6Bz5dYxUE00nx7FTgV3x4vqSHJOQfLo3vnuRgbd/C1u/e6TLQdJH37YZrcUeRaUwzPEW9Ifp0tOiakrx+DYDUh1j3G3iYvJG3QJiQtXrYRU4YissAckBX70InuELDMVeutLoxKPbGHgi4VRAUK6vZ5t7ESUK9Jc/R/xIaHK3M+4BM9ikvgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VH1mWyNzEeq8ayGd0YJWu9uge5f+VD+9dZqp+BnNF9EzwOpE5nYy9jKrhX7w?=
 =?us-ascii?Q?gzY0K3BZ5VUZxuuCvr2JH7Har8A1Y2dyEsg/lTC5ryNW4ufJUVr0gFDH1NKd?=
 =?us-ascii?Q?J+D6kgLQLQc5JWAixpmEVfE+Q5M9F5TXoMSiQ4BCODveS7fo6RlTu3kHvit0?=
 =?us-ascii?Q?XJ58TvdrLgKl88ClBLJhOpFb2cq1SP9wQEyvXlufRmVMgtXiwlvycKcFjpiC?=
 =?us-ascii?Q?lujSutSl8Ba6W0z+Nf3SogpWv87Zncwxxe9VlB/YvFZNzDwX6zd5seRnSp0o?=
 =?us-ascii?Q?2mKnAqcjynFU61ldOS7SUOwqXKI4LX/9si14ywZzXKdD+WqZt2fvgthtiehR?=
 =?us-ascii?Q?sHb5W4++bPVxayQWW23870VMV8Fs55xhSM3RIaynyweIqBILOcs1trw8Gn9f?=
 =?us-ascii?Q?WEQ1r2dV1WzDGVTw/5eOrUtT6DsdonAmWRNMeVTZy6Ino8rLvLFbYUlaJAMZ?=
 =?us-ascii?Q?beu4nBRvmBIS4CGSC7fhd1xQsjf4nI60bM71dzwA1vyd2GH0gHKfxP+r4+Za?=
 =?us-ascii?Q?FoXtp1CXL0qbOkTziBebru70hs9vIxhv9W64K4SmzH0HcLhsjQjV7xWHQ8b2?=
 =?us-ascii?Q?8uJlzHr0si6Qd+3alsmhP/IC2+lIPgu7n/KNWpNkwhjVGJOiW3+ltfMt2fsI?=
 =?us-ascii?Q?Ej41msBi26PxJHkfuhyT6Fut+PaT/7mm/19GMvJXOYs7CfK6oMvnxUfAtGpD?=
 =?us-ascii?Q?WRAxZ1Y8F5SgCEqh+HIEGvuKaeCNyajKCF0bSgpFpm1fToXDYKhB7Rl7Xx7W?=
 =?us-ascii?Q?nGPURJmVyNaKsppMk4vJwJWC/e9uOnA9Gf9C/gCfeZXDLGIOO6u3QYHOOVXY?=
 =?us-ascii?Q?LnGw0hr7qyV0WeviriMgTmZ0x8+Kv4a7h8KAk2Hq3DKxdOXqXO4WPVUAfJWp?=
 =?us-ascii?Q?6/X1BHy4zO4YWZsYUEoy5sQxtTCC7Rfxv7PDma3MhxqqYBDQDLo3pdOu2xwb?=
 =?us-ascii?Q?T13+152swUOyNPeZ2x+AzYHFAGLJ9QHsrCr1yGQZFHXYxl1eGDwi+Xv+hH26?=
 =?us-ascii?Q?cTe+h5pkcg52wJRwvFMfWE2IrDz92G3aMUv49XjqQdcMOqTKYNPczPtx52Ep?=
 =?us-ascii?Q?4qikP+tv8cRh1u6H0t5Rqm5BKOZAu80ziiZ3Yxdi7U840hG4laWHuKvjD/LP?=
 =?us-ascii?Q?lTyilwNn441TIcEX9DPFrhJ9iuI/MtkFXcaF0PkGAm0q+krcHkz+W0kLtOFZ?=
 =?us-ascii?Q?ksE2lrt410oDiDVF6gkYJriI+pg1VMdd2b1eV8F3iQTiceI5UtxXnsDSuSTu?=
 =?us-ascii?Q?gu09d2FpQJiZVa1eC6ccbiknICHRGCG90SN5Loi0b91HaVUodyMacya6EPJ7?=
 =?us-ascii?Q?rUaQEdafqKoR8xNL+NMjDDgQQF5fyl1AdTTY2rFNc9VPnKuzPoXd9P5Ff9PZ?=
 =?us-ascii?Q?fWPD9p7G0Phic3km0VP3841gFgn1eyyFA2ebQbZrAaTplPT2VyzlOAqeRghz?=
 =?us-ascii?Q?M0MCQCAA7LEIe2dLn6J9reeEiDMZJljF1dZmykn9b0nqWzqe2rJMvWrtVxVp?=
 =?us-ascii?Q?qQd9j0M/5IGJYxPAfYBuVgbE9LM4aG/VrDrvHcViHcQe4spQ3tw+MllnFLbG?=
 =?us-ascii?Q?IVyPKMEqT6ooQX3b40R8VGw4zE3A91lhj9FTwJXKtAQcbmgRYbFQ/dEI81qt?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b917ad3f-6bef-4f49-f52e-08dc4aba2c61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 21:51:05.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9KYMVkbFY/0Wg//GvOW4h0fl3g3bAotJzE0reETt2hWJXI8RUZG6SlVm4kGqOexcvmfVdFGcR+7nKmRw6HiejHRPJ8KiElIREJiIhXO+D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7319
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Fri, Mar 22, 2024 at 02:30:03PM -0700, Dan Williams wrote:
> > Bjorn Helgaas wrote:
> > > On Tue, Mar 12, 2024 at 10:08:16AM +0100, Mariusz Tkaczyk wrote:
> > > > On Mon, 11 Mar 2024 17:30:06 -0500
> > > > Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> > > > 
> > > > > > > No, Linux doesn't support _DSM. It was proposed in previous
> > > > > > > iterations by Stuart but I dropped it. We decided that it need to be
> > > > > > > strongly rebuild because "pci/pcie" is not right place for ACPI code
> > > > > > > so we cannot register _DSM driver instead of NPEM as it was proposed
> > > > > > > and I don't have _DSM capable hardware to test it.  
> > > > > 
> > > > > I'm not sure I understand why pci/pcie isn't the right place for ACPI code--
> > > > > there are other _DSMs used in PCI code already, and this _DSM is defined
> > > > > in a PCI ECN.
> > > > 
> > > > I looked into internal review history and I found out that I dropped it after
> > > > discussion with Dan Williams:
> > > > 
> > > > > After review and discussion with Dan _DSM extension is dropped.
> > > > 
> > > > Unfortunately, I don't remember what exactly he suggested, I just remembered
> > > > conclusion that it needs to be reworked and I decided to drop it.
> > > > Maybe, I didn't understand him correctly.
> > > > 
> > > > Dan, could you take a look? Do you remember something?
> > > 
> > > Straw man proposal:
> > > 
> > >   - Update this patch so we use NPEM if the device advertises it.
> > > 
> > >   - If/when Linux support for the _DSM is added, we use the _DSM when
> > >     present.  If a device advertises NPEM but no _DSM applies to it,
> > >     we use native NPEM for it.
> > 
> > The current patch matches my last recollection of the discussion, at a
> > minimum do not use the NPEM interface when the _DSM is present. That was
> > the compromise to meet the spirit of the _DSM definition and leave it to
> > folks that care about the _DSM and have hardware to implement and test
> > that support.
> 
> In the case of an OS that supports native NPEM but not _DSM, I think
> it would be unreasonable for NPEM to stop working just because a new
> firmware release added the _DSM.

That is also a reasonable stance.

> > However, I think the strawman is workable if only because base NPEM
> > already has a problem of ambiguity of which NPEM instance in a topology
> > should be used.
> > 
> > For example an NVME or CXL endpoint could have an NPEM implementation
> > that is superseded by an NPEM instance in its parent downstream port, or
> > another ancestor downstream port / root port.
> > 
> > The fact that the native NPEM may not be the right interface to use in
> > the presence of the _DSM has no specified way to resolve conflicts is at
> > least matched by downstream-port vs endpoint conflict resolution not
> > being specified.
> > 
> > So the spec left a bit of a mess and it is reasonable for Linux to say
> > "just turn on all the NPEMs and hope that userspace knows what it is
> > supposed to do".
> 
> If a device and its parent both advertise NPEM, I dunno how to figure
> out which to use.  Maybe that's a benefit that could come with the
> _DSM.

The _DSM is at least an affirmative indicator of platform-vendor intent
(for that one device), but still leaves open the question of whether
a downstream port _DSM supersedes another downstream port or endpoint.

So, yes, enough ambiguity that I retract my suggestion to skip native
NPEM in the presence the _DSM.


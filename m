Return-Path: <linux-pci+bounces-5021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9C887470
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 22:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BEE28350F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52E97FBA2;
	Fri, 22 Mar 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbFGo61Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CA1E53A;
	Fri, 22 Mar 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143034; cv=fail; b=rqzvIddarOoDMbzqFD+xrltqv/dWHpfQy6Amx/MJInDvmFse2Ooy8+6MC3NsOh1BkAwxZSvJGTcuoEILaKYI1Dm4a7C8rCTbqadiTswOlq8t/OXnpUCy7DAyLbUULk/poTYxu3X/0VXTi5UjpmwkSQvP+aGXRlWFkqQrZTCFZJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143034; c=relaxed/simple;
	bh=BYyhSpFLFH8ly5AGQtPBG7W1ro21f4SoTfFFhBn9ip0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L5N0CAz1eoFa3Lnvb8OP4PGi/pdMrt2Kbj3XNd0pCmYkj36lyim0OyF4m1C4V3C8wbv3Ge3CQaax4TZ7YJGYFXscE/TBjwgDBbL5b20bEHo7mewsXkFCQGkRPkEoySIJ2DMZ70pDG632Ael2ATeSeB6PasmB5OmfC0BZduyLOjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbFGo61Y; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711143033; x=1742679033;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BYyhSpFLFH8ly5AGQtPBG7W1ro21f4SoTfFFhBn9ip0=;
  b=QbFGo61YXvFr0/v8PsJ7DI5DArnGjp8SnWyLV0JQGuIn81WySLfCdcas
   QSVodRgZuvgslvT2h6/tg52aqKh/zRf366CHpyu6rfMMNAxC2oz5ktix/
   y6oVG0gu2wUZiRv7ZxIIdLzd53isjsh5I4IIyGEXi4iHeY5/ixXVHauC2
   wGuVnRJCP7qeApea/SV/trIMGtsxgwKBLOD5LGbEsP5bS2ywhOLFZ+k52
   O69k8zvpGZ24Z6AO9QlyJ3c6AgOXk+HANodZ45NTcTlO4C5X67iO8IrDl
   JFNkIVIW1laqq6Cd7CZ7pV1rQh4MacrzlqcsUSAETEt/8/YxpaE0hzkqG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="28688515"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="28688515"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 14:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="15047007"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 14:30:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 14:30:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 14:30:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 14:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOTYatgSG9C0Zpnjz+D1NB4waw9sQ1pHWhWk1kFctB65oF/wvHx6lBf8OP+PGfPbxrpQoMbkahNGBscoB/WI1cJ51QMf0ncV4FWCfrcDuogM7AMz3f2tPwkjy7rmBTnkOhe53B9bEGMon2FAQ5/qbTFobglmwV0ZWE8T2cpQVdif7he1Ydx3SAPiy9r9vQMYRbqBFZc+N2r+ZD78wKBcLwLeDkg1kKGBnm3UUzF4WPx97ew1IlRclHF/ARczIch9sM32FPhBPbYaDyhiZAxbQnee+XyQ184viCYAhHjwDtRXVq/LgtvrNu+LJs4KazzcN6FP8hvl8S4vb2Neyyo/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piMrqDuGXw9lyiA410MAtrchsLjEiu1Hxvs/U61zyEg=;
 b=kr1GpNCYchs7o1kKZnavDbc4jcVBBOUXkhKuasqPwwBXt9cs5NwMm4h3a8Z2M1uNpl5FssCMzGmoPXdk8OCSi3XJjOeZLgmD7o/QHjcPrUbPrLIqXx3x6rzec1QZbWqSkT0pz1M5m2WUZ/wx4nY/KeOoU6sRMdy94g4LbW8ba7cnAMbto08gMWfRDQ5/d1rKFw8A9BlKWA/BfUh6j9vAVYoNbz9aPkwzl3eW2lo8eV5X+PRVcb/EwYoBjL6CWyNfSV7iJrSECf6z6j0NR1RqqX/H87+S45B1pkYMRIReJ00oJAXCwtZYE6X/jOLSamcZ7sZ9XdBK97v6x1cs+1ci6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7872.namprd11.prod.outlook.com (2603:10b6:208:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 21:30:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 21:30:06 +0000
Date: Fri, 22 Mar 2024 14:30:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Mariusz Tkaczyk
	<mariusz.tkaczyk@linux.intel.com>
CC: Stuart Hayes <stuart.w.hayes@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <65fdf85bba0e0_4a98a294b2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240312100816.000071ec@linux.intel.com>
 <20240322195612.GA1372991@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240322195612.GA1372991@bhelgaas>
X-ClientProxiedBy: MW4PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:303:8e::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a5ab10-c104-4091-bd81-08dc4ab73e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IE3DYnTV8ulhtv5hbxPYe9YIc3oMNkxQHbm4b7E9DJ/WF/lRZg5tfFNfQyCT2mnrIi7Tb/QSndymcwaHlJH+d3fsJN52tByx3/fvRQreUPNlOm3Y51/eZ4mhNSIP8L1KpD5fPM8oJ55qOBPTPIWEpjAVYhQVm8awEOcldERhfcnlrguUbm606DhYQ6R8aPtYie2FJohWFOk/rJjXaCjGmLPhPN3MB04JSutC6WMiVX+bSRnmZgWZ2euQKIUm6i1aWmy3qDPb4ddNPA7d18fndylNGVfXz+RdP2LP2WoFrwmtZ/24cG+69mdNwTHjngC6pyjx1rGXY46T/5ZDWaw6n7fQMpNSfanjJzkd5HbLyFuADd6FEpp0txGAQZJ07tHc5RfmZJ6lX1djT+UUuoT+J03ay7Kxx9hV/xg5RnzyGfPJGjPI3lgzxTlQodXFT8xbJyNA3786mMqa1GONdAln87okqFYOX/LUhQZroFFznB0qPgfv0bMDa4Vs2e6ENsduqrcqMF02G+UIy4JvmEESpl5TZpTk0qZxXxVAWdYvB7E+zN0ZSwW2ajzRtGbIHO54FHfyVus55PC7XzH2gMtw9F1J1FGC04eyafc9ik8Wu/FCyziiu1dLpaje8+oSuVT9hVqEr+oGv/as3cG8Ac0cSTyHfgawOoy33LffXYWTPY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P60de9D8zQntu0sz7hLAo6j0loHbG416A/9q/uZ7ts4QhiHuIWquhsXeJeny?=
 =?us-ascii?Q?fXh6JLtfFr0z2xM9rt/rjotvSHvC5bZPabgmSZIm3CyhBbCyL2wmhJSNHtQU?=
 =?us-ascii?Q?hRwPG+iNTgnM0zAtR9cw6H/zXLTlWhYfPMFlots2Fi8tWnIaNMDZ/4XAiB+q?=
 =?us-ascii?Q?01r678EwowXQE5TAA5UwaYrTj/rpFRC56hJUmvWOfxuTmuUfFS6mgf3LtxOX?=
 =?us-ascii?Q?WGiEEtgK9qtMu8Ca3lbJHJixckqbxAwj3e8YSXssiZ8C0KOFC+RzWmDBxgmr?=
 =?us-ascii?Q?IvjOrga6EhxdivTtoiAk7HWaRNkk2rdEe1gYD4FhzcUzBX4yVZFxVXm05/JV?=
 =?us-ascii?Q?/Yh1q+tWmmTMEJ7UqKlJhbPQqesovViRq3FOrDTejz8lUL/ndSfUtNurZJna?=
 =?us-ascii?Q?u93fNjhsXZf6Zwgg6LWBO/P5lZaEdSlVyDmqhX5OU9mpmYvHQg9rmpALWKhD?=
 =?us-ascii?Q?aA42ZT1ckVJNfyKaUmFTfb9GJKAb1WiYxNaGLdDch1UvAlypiQRFFdJ288r+?=
 =?us-ascii?Q?u07kysmqEgkj7Ox+wyFd7B4Lm9KLASI85iun4iXklMJ89MRlqnVbXGzrAhf2?=
 =?us-ascii?Q?aZR9Tx18G5QFew+eUmUGd2NRm9ehWLn5NPJUpePQXraPV8dXQ5EfuhHnCfgg?=
 =?us-ascii?Q?BJhn52WHqwfssZoki3yBCSpa6/ZXN9cG6D3RG6wL6+UGe5DLBkdeY9D9bJuT?=
 =?us-ascii?Q?aCCmJiE9mxuxP3AO9I5mAKMQAqvGh0TiuOVBv695XKxB8UUmbph0qZoybrGG?=
 =?us-ascii?Q?y1YnaGPao00wiREcxf+5G2Rv8zxSDLgLs+WW6bo/2SVjT1vcFJh3+1tzJZuP?=
 =?us-ascii?Q?+9KXzz9TcONwTQmdagmXT+gsxyJdfZA+tkyquWoPdK/gbw3hpVdVfpTw2Equ?=
 =?us-ascii?Q?oBCBWr0hoNu1suwmYt3gtFWwLqjmlSYBcNeuhlzRd4gy7baw3im181/C4yaK?=
 =?us-ascii?Q?e1Y9ZDVv2a5dX0iPkj8vZQZYaj/4xjSDxThwyO+EkCC+UbJZQEf9mo4PJnCt?=
 =?us-ascii?Q?GCxgxCl1paWWsWWLrKlss/xjGbN0OLvGaD2prSRwKRgXEH/E+lmbCtQw/Y7+?=
 =?us-ascii?Q?KVHNURAt2wr87X4qdxCzEim++OQJF38lb07hwnY2aLuRi5KGOBugSHh/kZcp?=
 =?us-ascii?Q?rtMcv5x84S/toWVW4dO+N12j4/D/f3NOp2vNb7B1iMIqxLek1GAlRwyowVW0?=
 =?us-ascii?Q?rl+obtxpzeDIbNNRwKo9JL6rlH8QRzNEWIjS7hNHNocUooilVf5BpXzbe5oG?=
 =?us-ascii?Q?lAw8BoK4VT5xOWLHa9bsZfOuiPT7eWfzcRwWgE1Ar6UDvVRJ6uAC/gFpCoJE?=
 =?us-ascii?Q?KwHmQiduYPCJ6WNmAeDl3g4UH/7fWKeqgMlOmyc4uKlKEVplPFPX2D5Xew+L?=
 =?us-ascii?Q?6lFIo4GXmtSs7fGx0SD9u62CHm+oHxA4BiIxjfzb7vTFjf0NbSxx2sgaUiio?=
 =?us-ascii?Q?hmRgLHGiZQQIqnCHr6Re70RIkJjrtHinoDkIM39BImIokdSLQMLe/EvFTlLy?=
 =?us-ascii?Q?+VWuwBMMCBE10kFZ7L+LakoNWK9CjupsJuW//Yln3dsgoFztomhtXue1Ot9Z?=
 =?us-ascii?Q?AQ0b66weTIG7cFTyn1TaNvL4n+x+Fuxto7lgxvGt2gxgk9Hox8rA6odSP609?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a5ab10-c104-4091-bd81-08dc4ab73e37
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 21:30:06.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEm5QQc/PzZkZgk8pW5VJl5ywlNa/6zVjaOmaNSCfd3xlfBYrzd6bucJYjLkUt+tDckIbjs08Zq9Q4Dpp0E4QlLwPWcGYbzfEJo3R9wlxHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7872
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Tue, Mar 12, 2024 at 10:08:16AM +0100, Mariusz Tkaczyk wrote:
> > On Mon, 11 Mar 2024 17:30:06 -0500
> > Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> > 
> > > > > No, Linux doesn't support _DSM. It was proposed in previous
> > > > > iterations by Stuart but I dropped it. We decided that it need to be
> > > > > strongly rebuild because "pci/pcie" is not right place for ACPI code
> > > > > so we cannot register _DSM driver instead of NPEM as it was proposed
> > > > > and I don't have _DSM capable hardware to test it.  
> > > 
> > > I'm not sure I understand why pci/pcie isn't the right place for ACPI code--
> > > there are other _DSMs used in PCI code already, and this _DSM is defined
> > > in a PCI ECN.
> > 
> > I looked into internal review history and I found out that I dropped it after
> > discussion with Dan Williams:
> > 
> > > After review and discussion with Dan _DSM extension is dropped.
> > 
> > Unfortunately, I don't remember what exactly he suggested, I just remembered
> > conclusion that it needs to be reworked and I decided to drop it.
> > Maybe, I didn't understand him correctly.
> > 
> > Dan, could you take a look? Do you remember something?
> 
> Straw man proposal:
> 
>   - Update this patch so we use NPEM if the device advertises it.
> 
>   - If/when Linux support for the _DSM is added, we use the _DSM when
>     present.  If a device advertises NPEM but no _DSM applies to it,
>     we use native NPEM for it.

The current patch matches my last recollection of the discussion, at a
minimum do not use the NPEM interface when the _DSM is present. That was
the compromise to meet the spirit of the _DSM definition and leave it to
folks that care about the _DSM and have hardware to implement and test
that support.

However, I think the strawman is workable if only because base NPEM
already has a problem of ambiguity of which NPEM instance in a topology
should be used.

For example an NVME or CXL endpoint could have an NPEM implementation
that is superseded by an NPEM instance in its parent downstream port, or
another ancestor downstream port / root port.

The fact that the native NPEM may not be the right interface to use in
the presence of the _DSM has no specified way to resolve conflicts is at
least matched by downstream-port vs endpoint conflict resolution not
being specified.

So the spec left a bit of a mess and it is reasonable for Linux to say
"just turn on all the NPEMs and hope that userspace knows what it is
supposed to do".


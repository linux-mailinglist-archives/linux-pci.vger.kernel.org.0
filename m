Return-Path: <linux-pci+bounces-4068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BE786861B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 02:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C22C28CDF4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B67F53A7;
	Tue, 27 Feb 2024 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHFvJ2vb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024836E
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997976; cv=fail; b=BJMzQ325Avhvv3L7KK0QnSZsjdg3p2qT9rjPpKwGdbWEfW7J3mhEmfUuZ6XuNtOTU0YoYatbYbrFk02Yeha4ufWmkNBK7ZpjIz/Q6yF1MhHvyILyJNvUz9GX4hXjU66H4FV3TV0kE2lPKsZTpfhgWoFhbZBP/sFRJzfGV5nNqUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997976; c=relaxed/simple;
	bh=mz8hUz14WCqE+NpE0Cegr1PMxJl6zEXB2GaTj6Ee1Xs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bLwEwMu7yxsxI7EEUzLQ30d/X7XeY43UV4hyXQwSqpG0tu7i3UiUk8USkW+X0Kz/pPBpeImPhhyaCZI8+1mzbCZ87PZKfXJkep/eCzLq/ULBXDAnjG80R86TMlE4Uf11u6TetpWGmKL4qfZJRM9l/s9K9juTLsTIfvksxBaIbL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHFvJ2vb; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708997976; x=1740533976;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mz8hUz14WCqE+NpE0Cegr1PMxJl6zEXB2GaTj6Ee1Xs=;
  b=QHFvJ2vbXIEFGjzpl0v6+fdFguxZthzjOEY0Ss0+nC0Q7d5L5mjBE6/w
   aHU9CJBro8KG6IrdLap8AaepqOsErroK4n6txl4++wFmMP8Vr47cF9pwf
   SU4XhLroeHK9dJYAqnrPynNy9W35bFgDNRY0P3yy4xjFIB3MzMrPgB9t+
   WiFvPvLHaiOhKOYl6CY0oVgO4kM4B1jYc5mkgsmNiia4M7rCN9lHuI8fp
   jYs1Zx78MjMaqM77SUxgDrp1HA7KoLkQipA7hqK2htg9jqjr9RCZ3nAVk
   ADVIdsC1EQ3Cx8QOqeK4exzCBz2EZgtaCnOTLu2Xr2VnAgYAJzltAqUdw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3436317"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3436317"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 17:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11442599"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 17:39:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 17:39:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 17:39:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 17:39:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 17:39:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+4/sdqxj/NER3qraGZukSxJXvksRUspObuj2mk+rpCbtPB0H/73RjtavQJFevjCs1fich0zXJRKC/mhbfIdHkLzo4+MY2+MSoTJMFfJeshc6Zn9M26nQZNXQE4ezpGmDDf0gzzKUxZeruS7gc+ggLuT2k6UmpbiCqIUjbzWneh8naJUsiEkSbcGxZdmVyaw0/WT2KnwJskHxOq79HsSsYQy1eycB1B9L5TZ9BPbw6bIe9i9QeDjXJXRpyUJJitGyR4+D9PaA8L4NtBW3v06HJJRVoRQq5xkHaRty0PfCUeJqByGVBi8ddpx2ZlPOaXdYs3aZTmNOfM5AEkzsyub1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUVHfAfIVPBqrwi9dhZAjFrEPsmBvr2/sJg09f2UZao=;
 b=bdjD8GBJ1bpjRKO1QLnN9PWph1PfP7cCJc5wojpxQvoA6Jl52JiJFvHC/Wznhg+FJDfwXkf3LHjrYkhU7rN/NpyYSIgLjANT/O/OQEi/d46zC3FCfeAL7f/YzXYWS7tX7vS4icFCg3HBdmrW5k0WAlnbVecVdib2S6c2tP6LllZvFM4aPUuk5lWOV0sYqDi+DRBI412rSBm7Rfc5Fs2u8QxkuFwCCChHXlAkf0wgwoc587TfDcrmmHSR8R4RXdOuIZ4AObLRm1JZRF0b/oZQ83qSXLrRUQqAyQWJNqgevtAfD6RV+SaPARUsnUSn7NBKVNg5Usuba2ESaiGuIqX4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Tue, 27 Feb
 2024 01:39:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 01:39:30 +0000
Date: Mon, 26 Feb 2024 17:39:28 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 2/5] coco/tsm: Establish a new coco/tsm subdirectory
Message-ID: <65dd3d508ea52_1138c72940@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660663734.224441.8533201007071291342.stgit@dwillia2-xfh.jf.intel.com>
 <8a32b440-54a6-4676-85a0-ba6341c220ab@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a32b440-54a6-4676-85a0-ba6341c220ab@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 262ee89d-f00c-4403-8e98-08dc3734f129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cd4VNnyWBBH3tp4lDQ1fvMsEVDaL7tSzBNegvryPb3MxhJU5RLYs1bYbAHtzUwiOsaUbidIwrO70JBBUbF1m5oZzzae4IkKnNncOx/tNodzJlNpwiSRLOTqiATHgbQpspS+SThkIMYJyslDFheIfqXNs+zYaeT2fDTyvizFSW7sPDSNjzjFv9paSWp3ZZlqrRwuO7qdE5nkVvtFkoUvhbquwaOmMHm9pwCRjGk4Wy8LlVIjT/kgYl208HVlhiffZWshgU0h8R1gUm3oNsVkUqNTbUToYh3LeDKU346NnqzUMYAUwjSGqmcqUnkWxEEnQm2TTRFOmtVad7zhrhuUiPhl+M3SgyKexGOuaG0tTfrDEm2eIyKnASsS75vDKlSZpeVq70vbFIwikuRS98wHhUbV92YEOdmTncFcDFNbk9WgTo81h/VY/K+PqrQGCfzWhk+j4N8sphbe3T7WpR++/9NzY6930OgTjb8RvojVjOMteDrfL2aZ/YSSO2YIstLi1XsAwfN1HW5XZl/ehnRg5YS99ej7pRk3F0HACvf11bUfRfBMrDYS8E1ICDusf1/vix0F2Xkk4nWE8Gmz55v8wCtgQuzxvsEEh/svHCcnHrBPSjWzo8AIFlo67efvy2RIEP45+jXDgGb5uz7iVXEC7/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KhNioL4Ugkh7hgrS5TworRAxtkoJ3iBFtYP0Pe+LUsz060wHO6N0/45CiBnG?=
 =?us-ascii?Q?Lo1pj/32+pwtAg7qHrbOSwLexuCa7cNrlC93aT+LF62/SYxB/YDyLi2dfi38?=
 =?us-ascii?Q?JHcJ8M31IdSgc4wtSmBQhGuIKLabr6qCgw35lmFZtyFN70CTNiWzWFsAcbRm?=
 =?us-ascii?Q?enu94UyUxN9dc1ZeC+CqRLcgeAWIgFlRuhCX5p7jRXZ/S4IeQ+CQSAHZoyi4?=
 =?us-ascii?Q?vDvnrEFgloMcx4OALC+gAkCZuUnqvl/7AXf8Tq3smknXJbDiAuDH9yLlrcnH?=
 =?us-ascii?Q?WrVI7V8GK8w1Lxu4CLT4+VyQ5k1HPNAKpYk2pUyp7ey88zzxFvEDUhRHhNbK?=
 =?us-ascii?Q?4J9R8QuNWF4+fG2oQvqtFRb0S+u5ZJwBj8S7sayc0YvrhjcYg2efRdg7uD2/?=
 =?us-ascii?Q?zFkLuFcbskheXqIqGogxn8toO0NOw6Y8QX0s2oiKvXGznMUYsrwIfDVdZTrA?=
 =?us-ascii?Q?myuc9nSoU3nGOA/klXw6c9Fp9NUgfVQWogv40SuyrSkVFpPjxMKQDHJZ+Xm7?=
 =?us-ascii?Q?B4ZmhlHH58JXas6k7ieG19G4pcOcXy0EGGMzQ9Tk/OjnPWWzmPgokHYezIE/?=
 =?us-ascii?Q?rK3/gN8+3J/Ov4OiSCgKZKpIsHehsxIFXiBV1bxzk0R6g+QriDSBGZ+cApl6?=
 =?us-ascii?Q?oakOvsxttr7wF/FsJOWlNc5oxIjrc3CPjXOjRe15ivReNEEJtpa6TMQPJxnk?=
 =?us-ascii?Q?NdFU4Acnevn2ENIXhDQYKUT4f1OiLOulYtHHXbpBtma4Z0PtVkEIWuthq789?=
 =?us-ascii?Q?/5t/JyimCj0oMmmjSU4TFkk6GkmuF9e9EprcMNwksYI3dEUqywzK6StGueQS?=
 =?us-ascii?Q?gBMZUHxDhVCTl9HcS4m6aiVxnR9N3lD2ONjDSpApg0utCAx+3/H8gWAXiS3W?=
 =?us-ascii?Q?Q/aOtqfMoN8mSAG/uj79KIM4VdPg7uzrZeId3WpXKVsvpGkTjeHdc76y8oia?=
 =?us-ascii?Q?aWgCSVZ7/HnH+9LcrmFT6lAuzTzXGMZd/bzdgVXWeJzQRkbnLPnaYkLC1eFD?=
 =?us-ascii?Q?6pjWn6DA9geEaKsP5EEEYjiQJ/IBA3teuajq9YtlyNhNkmQgvR20kXZUvAtc?=
 =?us-ascii?Q?DOtLi9STixhIQjUDGu06/scZ4y0Ifrpp8QaClGIjyvZc11orMxV/tKJTXm8A?=
 =?us-ascii?Q?QsuVpLq4FK/0maCvwmdgHV9BgE+shB8+qsIam9lkO6HGvEB1lc179XXtxfCX?=
 =?us-ascii?Q?EHqJdTPrLjCFyjzamfQ1vkZlfBY2M+KC7hzBi26lVwXECpY1pa0FpvNC/QbY?=
 =?us-ascii?Q?oHOls1ImPoNhpRg9vcTsiJDaj+lknVahkDaLtlk2/sJ+F2kG7hjjhc151AlA?=
 =?us-ascii?Q?aIggbHa1Kcowht2S2+NX2vauWKSzOKYYz9wX4Ly0caYSDGHP0qNKxWIGFfdg?=
 =?us-ascii?Q?4dsUkRup+whNLGxUC79euzgZLJP5HB0Os1sMd2toWFg/kZBINWsCBql++aRQ?=
 =?us-ascii?Q?c7fdz5XZ18N2LghV0zRbLsNPTOcQrnHOr7ukhXQhvp4fVnNj/7S1eMklkMOl?=
 =?us-ascii?Q?ywYO2tVMwUUUz5fDJJSKBCDIyL3zHIXxdzPz5tCC2fbcfWetVr1JW+L/6950?=
 =?us-ascii?Q?cxxv5ioLjkHJy4m/Ab+11K9Ff4aanwopysnKS2qB1SKyk3AQlQ5CDK4CBliU?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 262ee89d-f00c-4403-8e98-08dc3734f129
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:39:30.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Vz/eXQRMzHeC6yMgEQtWIF/hP8QDL0kYg4ZtgyS0H4Bs8quBdKs0t8j8SOAyZ9BThj+0x2SZrsBlHyJML1vrWXaFVIMd+nSC9KN1GxAbWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6879
X-OriginatorOrg: intel.com

Kuppuswamy Sathyanarayanan wrote:
> 
> On 1/30/24 1:23 AM, Dan Williams wrote:
> > In preparation for new + common TSM infrastructure, establish
> > drivers/virt/coco/tsm/. The tsm.ko module is renamed to tsm_reports.ko,
> > and some of its symbols moved to the "tsm_report_" namespace to separate
> > it from more generic "tsm" objects / symbols. The old tsm.ko module was
> > only ever demand loaded by kernel internal dependencies, so it should
> > not affect existing userspace module install scripts.
> 
> Since host related common code is also going be here, do you
> want push reports.c under tsm/guest dir?

Maybe... we can always cross that bridge later if it turns out to be
confusing that reports.c is only for guests.

For tsm.c it may end being used for both guest and host so it is not
clear that separation buys us anything yet.


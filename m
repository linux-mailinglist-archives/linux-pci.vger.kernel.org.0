Return-Path: <linux-pci+bounces-5121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779788AB19
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D001368644
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095213F42D;
	Mon, 25 Mar 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhs3OJBg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54713BACC;
	Mon, 25 Mar 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382065; cv=fail; b=KZmscdZiX0r+F51SkUFtPHOooksJJQxaXwvtnHGHXucZavFv7f3kiXC6NWgpBb9t8vv7yn9wbL2s7t2svXsGQI4qNdzaua7A182YtVX5/n4MgLDy3M7+jxGXnKQT8Vg8g3q2EN2YNRi63nMLW04awH/fOyT5vqKIc+8P8dP4Ccs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382065; c=relaxed/simple;
	bh=wJNrOF6n5v50elvbyscLgb6i4uPE/7PLSKLt4cxl7xA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A9YHlG3lpxJL4QucgJTPcMQB67dmO5UmGu3mCaq+S/jpCyeO6e5KKtHqTOIfVbVmdCm3l6TGgTKJMA3qo4YG6K709uV9G321+rRYghWBLqnoaDmNF4yhyFwhgngtcAoSdA/zVJ20QJQC1VGA6+Xk9vr7GCBqRrNiZq/3+8hn/is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhs3OJBg; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711382063; x=1742918063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wJNrOF6n5v50elvbyscLgb6i4uPE/7PLSKLt4cxl7xA=;
  b=hhs3OJBgi8Cp0Y2F5Ti6KI8AiPr/4rcN/qSrJhO6RYRifRNehpFnBj4K
   MHATjRfU2tlYlNRirdN+odVQFTGz82QNZFFJQJMr6wuzdMoay/V3L/kys
   M81rH4ezHUCoqfaTiPmvE4YVcea2BNy7MGUjkV6rFkk9JuAJmVaiW2vkB
   j7Y8mfNaX822AzTcme310hUOUL3Vc9C9EvAdXm0QJqqjg7wpSAgsGjL/f
   8un1BjQ020hCGIygRBwS8mG3mZgUiUKP1rcSvaxuRanChixKwTOSXbZ28
   R80HeP+pziGtEk88zcFNi3xIvUVB+LDHGwr/qojizCCsGkCJ0Ruur9ZFc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10170466"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="10170466"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="16087721"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 08:54:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 08:54:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 08:54:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 08:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIexsBoqu/R49VJNkCkhr7uHSUz2m7OQDMxJYEUbIwOxJqr5rIV7hQ5mmE7RcaHVr+ypARTgxDtYcux35uDoZd9LrSsC3N9ddzn46A+/MPDKzn2y7eEMckYfJquSX77L01Dym9pTY1oOWM0sKEHiIH+dAWh8jaj57tRLP0/hwbdh7HDqYyBoVv3w21M4HPndsIZRpow56MKRdr51uQlewnuCNygt+W7fOvtlDERIr0YKgTQBFXebYfUfrUj79Ofw5bDTyz0dsZM7K1NDkMKuKBI3yNW+yabm534HcRmRjLBuDDCWop0zw88vyY7Gr/nKTDHNBgGL785iZW0A3/lrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d/pJgsi7JkTWhbTQTCOu4qVz6zK8Jmh5WOoj+GH714=;
 b=ODuict6Gt8buQclm76PUXGvhWAPKyaNGl/E5w1uVqSgZmHhr+odnc7bs6DU4Ws0vZQdxVzxOauLC+ZRVS+o7VmOBuCnKO5gYFzJymFB5pSxaEk0s1zBk+iIXCzZIyXkSLsf6RyDdjjGj+DqOOk0Hfq7bChAtaHr+95xP0Pfl3zcdvCNRdbiUYifYtMjLj2tGf9tqcDZ1rlcctZD2E/a4N81yCrF9tldzAiUTsIWF4HNdoFyMjxiBPKh23Mn/LYEzR6Ws27oxZf2d1OMHz1F/Lqqu+IAWftXY8PWTJ3pfTf46VPMg95xrzwXdlcECwxu0AL0gRxtPls3mAnOHqc5OAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 15:54:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 15:54:10 +0000
Date: Mon, 25 Mar 2024 08:54:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <bhelgaas@google.com>,
	<linux-mm@kvack.org>
Subject: Re: [RFC PATCH 0/6] Implement initial CXL Timeout & Isolation support
Message-ID: <66019e1ec2153_2690d29440@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
 <65cea1bc6ac0c_5e9bf294ed@dwillia2-xfh.jf.intel.com.notmuch>
 <1287adbe-364f-431c-b33f-9d73e7829b6c@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1287adbe-364f-431c-b33f-9d73e7829b6c@amd.com>
X-ClientProxiedBy: MW4PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:303:b6::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b4eec5-f477-4e92-fe17-08dc4ce3cf2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sS4a1tZ+gW7xqUxwbn0O2Y5AIMascM+eEXT2UuVGnUdTD759S04IcqsBuSGX12u3IPpac8qZHvaJK9AdxGU7IP6YvV74BglMH7gg3VhHZwfJJCMgfh1Lx6gk4jD+K9GW5amap5ou/bSQkGV27udjYXG2ODM98OpDTXCc10JmD/qT1S68TB1kSFTRoPqM5eBiiFimlcJBkoKUPWWs98rxG1mRUI8aoBG3YUGXTL0vAz4rcYse2EXA9n6g3FjzqA7lXnjRedVczEt5aLEj7F+5BnRy24w+d1xJDlE/xNCnmfyyJrn/8L4m7G4j063z8rqYKwHtJZZNiawuwPJhPfw9dXweUteccdgbwsFbYBTbvCv7NFTemXRenyvBuy3oj1WgXjcc7PNSQMmy2V8BlYG9aeIdR+E3xidWxotlrpdapsmAPO3cmbbQCOggzo5cUAvhjSKPJQ0MZlhkxrP5ESV0oly7YB4MLcliqbY+0UYEv2HfdtUc46GoWhvswWmb7Nsco5e+bC9Ii9MxdnAyXFVdRCOsmaibj7sGrOd8HQbz7QMRiiWb4r1oMRRyx6hbVLsYaY8g/hBtVbUawXim4pq5Z/CH0rHJaPtMoPrK9VKB96XtwINW4+GECQO0TkIPA6LiSv7qVupeAAWyl73P6bVkU0B8fDvvpH2wYthFejh7j6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9n+GnqqsGOhtox76C/jyV6p26s1g+nzFBmeylDWi+4bxfhC6NvYwSJSJp277?=
 =?us-ascii?Q?kEhWu75s+UmXOllmMIeaEY2VqY/l5s8lNb+bvkG8WMWmmwzm1e1RNXAu0UV+?=
 =?us-ascii?Q?+jmMVMmyvrySVW5lCTkz2dGmtKqr9MQ5SN0VJJceYHR995k3irqgz+I5WyKi?=
 =?us-ascii?Q?zZcsaVFRh9CVon1I0MPp33MN95VQgNpfm6Vz4xS3WcRnygQZKMrlfx+TMv9k?=
 =?us-ascii?Q?hxML6VQeAi3Y9tUbUGT1TMTyPZ1OckkGszyheBE/mdojhBU2Amg8X0FUtcS7?=
 =?us-ascii?Q?Lbd0TmeS7fT9mC+byuoZbbn5pcQT+BEu4kJWhG5R+ke7mP5kVEwb7OaAd8yM?=
 =?us-ascii?Q?8m621crP9+AAJUvcO1dAfLpiXvUysAshkLNcPrCitysRL0SJHV52M4N3d6Mg?=
 =?us-ascii?Q?XNwL3mJ5I0HMIrbdEIT2dy3u4KMQukW8GYgGELwondb9B6AVGJgNWU5DODMk?=
 =?us-ascii?Q?l35/fakdia9SLEJa6oGO3S7/LkQtSrlkpe/U9SVhJn/s1vOb9eYMN4/xobOO?=
 =?us-ascii?Q?0J1rxhzW9jf5roTwV6rl47nX946k9t5izt8oGaTqnSsz6iriHfjJupZrxI72?=
 =?us-ascii?Q?NyCKzttILUsuaNnImoWNd9EzcZmMJ4zos1Nd/ZmwDhGG9ior//hnRESjuWA0?=
 =?us-ascii?Q?wDGsOpfia2haUd/TJXNo6jOgbr9nwkQbuY7hfIp+TDCTRt6wcEyzekzK/uQ3?=
 =?us-ascii?Q?ey4flLLYFlWWE8F6VYZ+oai6vx5WHCsZ+i4wbToW84ejqmFphHPRB3R2BpCX?=
 =?us-ascii?Q?QxZ+fdclk2MBm2o15wAdKh54jzhPYsY9sptgrOAsgeU91TPRhjF/2LrnFBGc?=
 =?us-ascii?Q?FKAkfS5Y08yqVsYPtuwzK7xinDKv797EgjsmEvr8XliVYkCR/IbTsmiwtZ6P?=
 =?us-ascii?Q?6rO5fPl4pJQOH+/HBUlwmYbX7O70/2Pxqg+Hh8e/HvwuqiRcHM8qzLNx7zZ0?=
 =?us-ascii?Q?nOdjYZxhQexH6QTX7rCM0Jc9Beiw3wOgnaCml6f0ec6DoTQTFE/JTuAOZQI4?=
 =?us-ascii?Q?eN4Lk4YEI1Czb5D28CbkmVAJd7vnc3dLsYR0MpCKBorHet9RIu8ffmhn3IC0?=
 =?us-ascii?Q?1u8ZcR2Pt9+aA1VIYmdZ2launyOEYCDS5zBpjLfJY+GTbHM0H4wQF4bKmmuf?=
 =?us-ascii?Q?oLWWZNMl0C8RQ+Btt7WvDB1HHJG4dD5cT/+9041VtLmI+lsOW/M9m66C6A2A?=
 =?us-ascii?Q?QkyXQ+aCqB9Y5+VLwPF+9T0jedC0LkKkM7JxGbP5VZGXgEqhBtZeR8SfvPbq?=
 =?us-ascii?Q?jn7wqvl1FyF4f385ugKiTjslvWcqvk0oWm1QSgkloxmJZXW8nEeoQfNMPQLL?=
 =?us-ascii?Q?wlBa+ErsLUrHl1pn1JDVNQqG12dfIPJrVMMjdFSq4XAYadUyGJI3lV3XJF7D?=
 =?us-ascii?Q?jiy6KRpMtqiIustZYDqFalbeRYk+0Gm5Czod8lYIqRaB9MPyHTtbDKLrmbMJ?=
 =?us-ascii?Q?b3DkQD6PVJe3yf6chY9KGJbB4uC5NELV7avTthPXlMr65/M+o1Dy0RKDTv14?=
 =?us-ascii?Q?mx4xNZAIH+FJBcV/4vtEKmwg1VW+zrD15CUbQSsl5RAOwO8IS5Xmj3HBc3Gd?=
 =?us-ascii?Q?CZ/P13sTavCkrh5JHZCo5ylYtGbAhjt4kaGY7xNi2IjcrnZ5bMne+S9TesHa?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b4eec5-f477-4e92-fe17-08dc4ce3cf2c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 15:54:09.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7sQTccnw+SRBsSfJp5jpImHWVGVDJJNd4NrOkb97D5yjRW+a+XlAymQU7+awmgNsvc4nzPZJDZooKyUof554w8oQedYSVDdavf1H9GI/dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Hey Dan,
> 
> Sorry that I went radio silent on this, I've been thinking about the approach to take
> from here on out. More below!
> 
> On 2/15/24 5:43 PM, Dan Williams wrote:
> 
> [snip]
> 
> >> The series also introduces a PCIe port bus driver dependency on the CXL
> >> core. I expect to be able to remove that when when my team submits
> >> patches for a future rework of the PCIe port bus driver.
> > 
> > We have time to wait for that work to settle. Do not make the job harder
> > in the near term by adding one more dependency to unwind.
> > 
> 
> For sure, I'll withhold any work I do that touches the port bus driver
> until that's sent upstream. I'll send anything that doesn't touch
> the port driver, i.e. CXL region changes, as RFC as well.
> 
> [snip]
> 
> > So if someone says, "yes I can tolerate losing a root port at a time and
> > I can tolerate deploying my workloads with userspace memory management,
> > and this is preferable to a reboot", then maybe Linux should entertain
> > CXL Error Isolation. Until such an end use case gains clear uptake it
> > seems too early to worry about plumbing the notification mechanism.
> 
> So in my mind the primary use case for this feature is in a
> server/data center environment.  Losing a root port and the attached
> memory is definitely preferable to a reboot in this environment, so I
> think that isolation would still be useful even if it isn't
> plug-and-play.

That is not sufficient. This feature needs an implementation partner to
work through the caveats.

> I agree with your assessment of what has to happen before we can make
> this feature work. From what I understand these are the main
> requirements for making isolation work:

Requirement 1 is "Find customer".

> 	1. The memory region can't be onlined as System RAM
> 	2. The region needs to be mapped as device-dax
> 	3. There need to be safeguards such that someone can't remap the
> 	region to System RAM with error isolation enabled (added by me)

No, this policy does not belong in the kernel.

> Considering these all have to do with mm, I think that's a good place
> to start. What I'm thinking of starting with is adding a module
> parameter (or config option) to enable isolation for CXL dax regions
> by default, as well as a sysfs option for toggling error isolation for
> the CXL region. When the module parameter is specified, the CXL region
> driver would create the region as a device-dax region by default
> instead of onlining the region as system RAM.  The sysfs would allow
> toggling error isolation for CXL regions that are already device-dax.

No, definitely not going to invent module paramter policy for this. The
policy to not online dax regions is already available.

> That would cover requirements 1 & 2, but would still allow someone to
> reconfigure the region as a system RAM region with error isolation
> still enabled using sysfs/daxctl. To make sure the this doesn't
> happen, my plan is to have the CXL region driver automatically disable
> error isolation when the underlying memory region is going offline,
> then check to make sure the memory isn't onlined as System RAM before
> re-enabling isolation.

Why would you ever need to disable isolation? If it is present it at
least nominally allows software to keep running vs hang awaiting a
watchdog-timer reboot.

> So, with that in mind, isolation would most likely go from something
> that is enabled by default when compiled in to a feature for
> correctly-configured CXL regions that has to be enabled by the end
> user. If that is sounds good, here's what my roadmap would be going
> forward:

Again, this needs a customer to weigh the mitigations that the kernel
needs to carry.

> 	1. Enable creating device-dax mapped CXL regions by default

Already exists.

> 	2. Add support for checking a CXL region meets the requirements
> 	for enabling isolation (i.e. all devices in
> 	dax region(s) are device-dax)

Regions should not know or care if isolation is enabled, the
implications are identical to force unbinding the region driver.

> 	3. Add back in the error isolation enablement and notification
> 	mechanisms in this patch series

Not until it is clear that this feature has deployment value.


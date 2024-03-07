Return-Path: <linux-pci+bounces-4613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF487574C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 20:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE01F21426
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D12136666;
	Thu,  7 Mar 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5b9LJjq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914A136650
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840050; cv=fail; b=Jb4oG+7iXEkkq6xHjcPRpPFr/QAZ1hcn4NcjomxN53t8jiqZsbqxLWbGKUNWGN9Sq5lbPGcbVkl1R0BuI6Iah+UY8AXbutnzKk1aV8pse26mmPfVSv/XJttjSrEK4NjYWffBDeuYEN/3sWhJCkpEc92CNl2IT1+SgWYe7693IAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840050; c=relaxed/simple;
	bh=qfUwUzfXLu+dYDt18ecwBUp48e7FjtNnD60IQDBAU4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MPsIwr2SuX9CXs8Sew0yOfjsGfKMAJvzfBpuI2VINyUxsLd843Nd7xPaLI9fXvDdGa4nrZA2lLgHPBu4uxM7kh07LQd0dYTmFVe1RODMoRtAquAMxQXg02BL+m1QYvbPUABfKVntCOeSkHbcxJULaPDAmoj/tMPBvEKE7IhwZ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5b9LJjq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709840047; x=1741376047;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qfUwUzfXLu+dYDt18ecwBUp48e7FjtNnD60IQDBAU4s=;
  b=T5b9LJjqQF5kDUglXRfnlMSqGwbyoFTeE3RrE8AcFcJ/HiqinEPQS2q/
   +bXy4SuBPoSYI6ukOGrcCAltNWj6ksOXaR5BE+ahhE3JRaBxodBzd1jWP
   XbUEPIFU3Kz8tn5/jDTj4oZgm/0XX6jNkyU7gvEk5IUsNkmHLYa9YjYtq
   0jMWEBwbLBrWFLwmljhCFruTrIYgyWxuj4vhr6wkxEBiOm9YAoQsBkvEZ
   r67+jd9+gkpfXsW6cItNxvd2SD7N4TNdxghOSj+yjJcINRFy/Flo5WEGa
   axREmREsoRatVUcM7FFXQOFPtKTi3p9WO2YbidzQAnvwNmJstwsrvKp7H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15102711"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="15102711"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:34:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="14718905"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 11:34:06 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 11:34:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 11:34:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 11:34:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqR3YpZxfBVACudVXLWUWJgJowR6j40XT/d/NJaomDCzH5x/qWSlm65dNfBzUZiPiu2BjA/VVg025BU6Ja+wMHAZDjMzEVfiGSXcqkvrjFizUPd1OCHWiYuNbhPzglvA/13zu29fKtSySZ84LRRVKn+XF8V3KZEtlwHf/77Vpi0k8NL+vAtbrBctXmKnB0TqzTas+RAbOquw7a+fucxqiIuqc8vfyBry+5IPy+aY8AodHg8WDmRhrzzALaYbxfXwDxUX0CWxNLLgu2MMjKxWp821mXC4QE6PJcIxPXxZPHxmj//pKBMItwljBC0W1zIaF6RIdnRUpbgLFv7yl45zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3CtQLPJdGjoZMG9Pz+SoxQJfkAo0WFmBy8MKm9LrpE=;
 b=VsFA5IqRUPiBaYsWE2Yp12w2oBzpfZ5FjJ/Ua2YYktyhnqXdtOin5TvXv8Z3iS+/yrizG46BwNNUqDW+7X1aVt5fI1b6fRotxCTQy8AHQ0M9FCqFRR6/LpWfvfJJZCO/wnJPiJUh2Ikl55y57OzTEpcgTeOzFO8VcNTdVueud+GZGvuxIvEX3BrLNs//v5P2L1abCvL4aABAadqagYeamhK4RNbgQk2LKC9fUBMUiNYspUP7UopC7g+aBcjK0o4wWjxNe95JcqzjXEg2h5N50KlOHDWVB1uwvdHQqmgALEJG1xwvEc/40aqcjfPY6i0PH8GUi+jAy+WxOQr1/DRsrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7664.namprd11.prod.outlook.com (2603:10b6:510:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.18; Thu, 7 Mar
 2024 19:33:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 19:33:59 +0000
Date: Thu, 7 Mar 2024 11:33:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Alexey Kardashevskiy <aik@amd.com>, "Wu
 Hao" <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 3/5] coco/tsm: Introduce a shared class device for
 TSMs
Message-ID: <65ea16a54fd74_1ecd2946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660664287.224441.947018257307932138.stgit@dwillia2-xfh.jf.intel.com>
 <20240307164139.000049aa@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240307164139.000049aa@Huawei.com>
X-ClientProxiedBy: MW2PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:302:1::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ede457b-806a-4b53-e92e-08dc3edd8978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uowqWPz2QS66nWqP9NWGbhUSHw8hlA5ytOyZSma0KiAkdnY1vqKPi6MSbeqzvfn8C0LK8XmzwUvVU8YG5t8M8gST9Kc/2sBNepnztawlg+ThkEy2N+qaXXc3BEOxbrAv10F2hB+3fK/hrNiHwX7EMyqEP1HgwSr+rv8CtUtRm8TmX0jrBaI23QqbKkeee+WDtvg6cDyToqdJRizH5by5zLCZXfuBoBZ4G7yMeKU+LIfA8N/SZveBOKHxWnxrmpVrQRyMHaXIoHxNbfMon+iy00ABU5Oec8/aGrYfjiHuFD/DjpqAP4ERPASe6HvdJgZjuJIi3rbZuF5r1DMWPKRoboGhXmkG9I/gFTxtKeauqnnQLnbjHe/tlFIE0KL+ebIQhU+Hg0a202q79nr/qH+Pt7E/5pEj/oi1jGaBTmQKHN5dxAO/Xz8GjTcoaU4MRA37nXtiEvRKXvk/wNMGISQaYdTCs3qc0kh0T+OTZez11MLMAZIUHoUj4jRueYR5egOzIAmaHUxNO2JEvn1okIeCaNNCPffbilfeCyIG5wA0gsoeAtfeQRvajDNG+fZLZRreMhIc6a9wbQvDKqQQRVEddpVPzHRRqbQ67TAjBoYPfEmH5VHuddWuhFDKLbN8KLq/6P32smhWRUzsHDFXErGQF2yyfKOGQKBbeq2wplSEocU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vuBFWdqEpFGeY0rgDhTE9B6aeezIap4s6KVRdkf9wuqgzuHyeUk9/Jom7as?=
 =?us-ascii?Q?oXcRSwCJVZINHCKofthALZW2jCdC8nDUGpaHJxloaLeiDlHKwrNHcJHROMKZ?=
 =?us-ascii?Q?oX1L2ZIUEXEXD376HzY3rXdb4wF47kaLYvDENuFgXH7jTTHIEIetQCJdsWPl?=
 =?us-ascii?Q?2oQyheNd2KDPur+wCF0aCklc1L4Eexu2OhXZ19aU9pGvExCIA96cSsAT/iRQ?=
 =?us-ascii?Q?QGEU2RKWQh89AOPaYy/T1KBVXWr4nX5bidOrR2iLbip621z06ja+I72Ym/ok?=
 =?us-ascii?Q?L8Ylvdw4YaNqfVsQSARIAhPpDxcaaJSXI2xw7zo8I4duWAXE/9K2YPA7hNy1?=
 =?us-ascii?Q?0ZmT4prnEQUu3SLXCkQQPGQ98AZqm0625fUoR7qG8wrDHaHFUe6OPUiI5CF7?=
 =?us-ascii?Q?AgQfcKKQ9dYaQ/WL4h+N7Ixzve0TVR8Vj+aUaipbqLg7xBhSGGRqOfValD+C?=
 =?us-ascii?Q?z/4X5zvEQylVgoD3W/WwlXuSTA0of0PO1UzzIl+ptMmef+Cg4BYifZ4w5+B9?=
 =?us-ascii?Q?11JizpVVgd/os6iCOEMwEL/n1XibNpMsDi1CwJX0mOoOqlD7RMXVp0HdC6IN?=
 =?us-ascii?Q?htPO7AuQSRdNmiAqTaTdCyAeWEJ0nm9X2MXrs86/KSqbUMmDL5kyBRnoD6tA?=
 =?us-ascii?Q?W1gwCHEGYH7S52snRbLJRQakApta+L+9Dq2IPGIDB5QZeCefpZfcPqBjNXDI?=
 =?us-ascii?Q?UPsM7gqaSrDwp0viBa4myy7oPBWBK1OUpeZSj/az2e7BnUs8GHOMMUrdONmH?=
 =?us-ascii?Q?R80WiL/bltN0lUhiWoVGJBqWtWENeBBs1s0ZGv+Jz1KJ3eAewbfZHgyfLtIv?=
 =?us-ascii?Q?kPq53xcMM/8rLnEVrMjlUBPxmcMYh1/aW17pCrW0pDKB7U0ZuNILtgONu5/r?=
 =?us-ascii?Q?ILvQUcYkuftdfMHFZEjMrdtikScy3hGGZ9LdoxTIaRoy+FsXg6SXj/xjregu?=
 =?us-ascii?Q?BHyVWIpFp0/qckQrwkiZHV2tViwv2nyB5uCuUNjejldVHwl29mQbfXzBcAgs?=
 =?us-ascii?Q?Fj31mJjPqndFlcrMcFRvzQRVRo6344BOJyh6QBFhS07O6moGjSTUBRs8Bf7Z?=
 =?us-ascii?Q?8oC8e7xPoVX7B06N/Xw2mGk+5wZkgN3WwS8bthEd/SoqLHtV6zFWOOOjHMCI?=
 =?us-ascii?Q?4whyduYg2OoAjX38wfRg4WE9R2uYHIEwnn9aUfQMCnQhbOHymJJeePV6/Pqr?=
 =?us-ascii?Q?wy6adpHIbR4uPPjyWd/3R7r/QsLzTN/yMahsZUWCAj0NEhq2vW430cwVYqoz?=
 =?us-ascii?Q?f890CZWCMbvZcdVz1tkUKQJRWlvMUPE9FEyAY0fkk1pmMu00/3Z1jUvooj3m?=
 =?us-ascii?Q?GLyT/JPCnN7Jq0vYPHj33UMK++yGi+jGj2YH8d3it1FiPNlPKTuus57ju1Co?=
 =?us-ascii?Q?g0LherS7B/w2hAHfC5+x5xU3kraB+cs878wtj9jvmkCoDheSkelxQgKMn4b/?=
 =?us-ascii?Q?1CLE1tRJKXHukpDj+gQKm/989v3y7KaZU+9W0tcSE/abhqnEHFLvFG4SDB8Y?=
 =?us-ascii?Q?4P7VQlr8gCl/quyCocBd18qPFRnIRy1B70b/jjRDCrQrBC8kM8JHBdMhMj0H?=
 =?us-ascii?Q?hJWkq0Ub3Wt/75pqBkertU+kyDWAvanBDuySct9AoKUl94gb2ZxpiM0NSL+H?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ede457b-806a-4b53-e92e-08dc3edd8978
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:33:59.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzCBqLVMVYTzso0+ymhBOxFQI5FYYZ4ZAWEdjBWxqbfqynUTdKe6g5mPgfX7fbKVKK11FOG1WHUha6dnWJjHhCwhJ4k8eCpeJsXORVS/1xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7664
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 30 Jan 2024 01:24:02 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > A "tsm" is a platform component that provides an API for securely
> > provisioning resources for a confidential guest (TVM) to consume. "TSM"
> > also happens to be the acronym the PCI specification uses to define the
> > platform agent that carries out device-security operations. That
> > platform capability is commonly called TEE I/O. It is this arrival of
> > TEE I/O platforms that requires the "tsm" concept to grow from a
> > low-level arch-specific detail of TVM instantiation, to a frontend
> > interface to mediate device setup and interact with general purpose
> > kernel subsystems outside of arch/ like the PCI core.
> > 
> > Provide a virtual (as in /sys/devices/virtual) class device interface to
> > front all of the aspects of a TSM and TEE I/O that are
> > cross-architecture common. This includes mechanisms like enumerating
> > available platform TEE I/O capabilities and provisioning connections
> > between the platform TSM and device DSMs.
> > 
> > It is expected to handle hardware TSMs, like AMD SEV-SNP and ARM CCA
> > where there is a physical TEE coprocessor device running firmware, as
> > well as software TSMs like Intel TDX and RISC-V COVE, where there is a
> > privileged software module loaded at runtime.
> > 
> > For now this is just the scaffolding for registering a TSM device and/or
> > TSM-specific attribute groups.
> > 
> > Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> > Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Wu Hao <hao.wu@intel.com>
> > Cc: Yilun Xu <yilun.xu@intel.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: John Allen <john.allen@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A few drive by comments because I was curious.
> 
> 
> > diff --git a/drivers/virt/coco/tsm/class.c b/drivers/virt/coco/tsm/class.c
> > new file mode 100644
> > index 000000000000..a569fa6b09eb
> > --- /dev/null
> > +++ b/drivers/virt/coco/tsm/class.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/tsm.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/cleanup.h>
> > +
> > +static DECLARE_RWSEM(tsm_core_rwsem);
> > +struct class *tsm_class;
> > +struct tsm_subsys {
> > +	struct device dev;
> > +	const struct tsm_info *info;
> > +} *tsm_subsys;
> > +
> > +int tsm_register(const struct tsm_info *info)
> > +{
> > +	struct device *dev __free(put_device) = NULL;
> 
> I think it would be appropriate to move this down to where
> you set dev so it is moderately obvious where it comes from.
> This only becomes valid cleanup after the call to device_register()
> with it's device_initialize - which is ugly. 
> Maybe we should just use split device_initialize() / device_add()
> when combining with __free(put_device);
> 
> The ideal would be something like.
> 
> 	struct device *dev __free(put_device) = device_initialize(&subsys->dev);
> 
> with device_initialize() returning the dev parameter.
> 
> For the really adventurous maybe even the overkill option of the following
> (I know it's currently pointless complexity - given no error paths between
>  the kzalloc and device_initialize())
> 
> 	struct tsm_subsys *subsys __free(kfree) = kzalloc(sizeof(*subsys), GFP_KERNEL);
> 
> //Now safe to exit here.
> 
> 	struct device *dev __free(put_device) = device_initialize(&no_free_ptr(subsys)->dev);
> 
> // Also good to exit here with no double free etc though subsys is now inaccessible breaking
> the one place it's used later ;)
> 
> Maybe I'm over thinking things and I doubt cleanup.h discussions
> was really what you wanted from this RFC :)

Heh, useful review is always welcome, and yeah, I think every instance
of the "... __free(x) = NULL" pattern deserves to be scrutinized. Likely
what I will do is add a helper function which was the main takeaway
I got from the Linus review of cond_no_free_ptr(). Something like:

diff --git a/drivers/virt/coco/tsm/class.c b/drivers/virt/coco/tsm/class.c
index a569fa6b09eb..a60087905c72 100644
--- a/drivers/virt/coco/tsm/class.c
+++ b/drivers/virt/coco/tsm/class.c
@@ -16,10 +16,29 @@ struct tsm_subsys {
 	const struct tsm_info *info;
 } *tsm_subsys;
 
+static struct tsm_subsys *tsm_subsys_alloc(const struct tsm_info *info)
+{
+	struct device *dev;
+
+	struct tsm_subsys *subsys __free(kfree) =
+		kzalloc(sizeof(*subsys), GFP_KERNEL);
+	if (!subsys)
+		return NULL;
+
+	subsys->info = info;
+	dev = &subsys->dev;
+	dev->class = tsm_class;
+	dev->groups = info->groups;
+	if (dev_set_name(dev, "tsm0"))
+		return NULL;
+	device_initialize(dev);
+
+	return no_free_ptr(subsys);
+}
+DEFINE_FREE(tsm_subsys_put, struct tsm_subsys *, if (_T) put_device(&_T->dev))
+
 int tsm_register(const struct tsm_info *info)
 {
-	struct device *dev __free(put_device) = NULL;
-	struct tsm_subsys *subsys;
 	int rc;
 
 	guard(rwsem_write)(&tsm_core_rwsem);
@@ -29,16 +48,11 @@ int tsm_register(const struct tsm_info *info)
 		return -EBUSY;
 	}
 
-	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
+	struct tsm_subsys *subsys __free(tsm_subsys_put) = tsm_subsys_alloc(info);
 	if (!subsys)
 		return -ENOMEM;
 
-	subsys->info = info;
-	dev = &subsys->dev;
-	dev->class = tsm_class;
-	dev->groups = info->groups;
-	dev_set_name(dev, "tsm0");
-	rc = device_register(dev);
+	rc = device_add(&subsys->dev);
 	if (rc)
 		return rc;
 
@@ -48,9 +62,7 @@ int tsm_register(const struct tsm_info *info)
 			return rc;
 	}
 
-	/* don't auto-free @dev */
-	dev = NULL;
-	tsm_subsys = subsys;
+	tsm_subsys = no_free_ptr(subsys);
 
 	return 0;
 }

> 
> 
> > +	struct tsm_subsys *subsys;
> > +	int rc;
> > +
> > +	guard(rwsem_write)(&tsm_core_rwsem);
> > +	if (tsm_subsys) {
> > +		pr_warn("failed to register: \"%s\", \"%s\" already registered\n",
> > +			info->name, tsm_subsys->info->name);
> > +		return -EBUSY;
> > +	}
> > +
> > +	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> > +	if (!subsys)
> > +		return -ENOMEM;
> > +
> > +	subsys->info = info;
> > +	dev = &subsys->dev;
> > +	dev->class = tsm_class;
> > +	dev->groups = info->groups;
> > +	dev_set_name(dev, "tsm0");
> > +	rc = device_register(dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (info->host) {
> > +		rc = sysfs_create_link(&dev->kobj, &info->host->kobj, "host");
> 
> Why not parent it from there?  If it has a logical parent, that would be
> nicer than using a virtual device.

Yeah at the time I was drafting this I was working around the lack of a
ready device parent for Intel TDX which can not lean on a PCI device TSM
like other archs. However, yes, that would be nice and it implies that
Intel TDX just needs to build a virtual device abstraction to hang this
interface.

> 
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	/* don't auto-free @dev */
> > +	dev = NULL;
> > +	tsm_subsys = subsys;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(tsm_register);
> 
> Seems appropriate to namespace these from the start.

Sure.


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63656CC57
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 04:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGJCM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 22:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGJCMp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 22:12:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFDA2654E;
        Sat,  9 Jul 2022 19:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657419156; x=1688955156;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ROYAsAwSaKwVpPRZUaj+A38JQJ7N0dgnRMb9WPRyux0=;
  b=AWt4/C2eBhnDWvDn7zeVQnSw8kX+l76YjQ0/uOkWh5f7Q/GDmaloqNJR
   EOOXLSgK2RMh4ialYPJtfgu/90Jks2yO89KWvBVTDaaaccDwHkJYFUSr2
   QHVBaWQZSJc578e4nHk3yV4Y85BxRfRZKif70ZktdXzRRUz8xiieaXxFI
   MHOpDVz12hewBfCjBh0+n0c71KlSg5OYCJYzWRqGhhex8FNubX80YXeQZ
   L01KvPmWnG9sewTO1Fc/AwxoarL+7oxrriOP8hx/mdZ/XC4su6SX2fIYq
   7nlKI6pRx3eeU5k3YKNYxU2a+kl/OVqm0j8vVISpXjNC9EtFYGMnSEbv1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="285600462"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="285600462"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 19:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="544619314"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2022 19:12:36 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 19:12:35 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 19:12:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 19:12:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 19:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaIksupBJxLIqwHIihLrzciC/lk7Gh8bmuHzr57qQE/sCjrFBv5DaJ7H30sif3WGg26jsOiHdDYZ5GnwD4vdJ+rShoAPNFsbPhaJUPMWhoaYNFI5bciqIiGV/jyzxQ25v6aQIetE9nlxAkMIcBiu6uYOojFSBCyUUCqCJyGGUANdy5d8dZiyQzrxr6wXxepDbWRxK8ynMsK6dZtKJNP+egSxhO7EJgDzu5BdMlQbvpjGQ/NGkzqfnFzBppKypllHW8LFjpXW5POqLGZDQXSyqSWA9a/szVwHNOvcf45+D7AafLuH66/tSmRL6dr86TFydZqSDdvccTUVJ62o0qsJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAVqUjl5Fw2Sxx5l7zxP7Zwei9QkDcad4/qJieSUNIU=;
 b=dG0DU1AAu5e5VDiwB9DLhzViZdAObEUgKyg6F/FJvbmWIyJHrOVdlIZUAQ5LMJpqKBE5H36ivgmVtFG5J6xXDD5Yf9F+MRX02i7VpUifRT28P1jPA7GKFDdvdKieOYTkGrqViKMZqJwR88+NOmFpRkITrucfBVbKAqQ6uOizajxsyWngUU2XTqB5NIFhfi8yMZQQiHAqXKGofJm36zSMEpFOOCSCkZRCiMikd6Gwbc0EvzzgsszmETXonYWKxZHCPgoQFN3EvRyHmK/Y6iCldVIv9EdEx3MtME26GIu7ZDRj9rHn/Ae+9O18fZkxNJwA5SyV7uIN0fIsL7BRTewkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB2049.namprd11.prod.outlook.com
 (2603:10b6:404:46::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 02:12:31 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sun, 10 Jul
 2022 02:12:31 +0000
Date:   Sat, 9 Jul 2022 19:12:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <david@redhat.com>, <gregkh@linuxfoundation.org>, <jgg@nvidia.com>
Subject: Re: [PATCH 09/46] cxl/acpi: Track CXL resources in iomem_resource
Message-ID: <62ca358c461f1_2da5bd294fa@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603876550.551046.11015869763159096807.stgit@dwillia2-xfh>
 <20220628174346.00005dcc@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628174346.00005dcc@Huawei.com>
X-ClientProxiedBy: MWHPR19CA0062.namprd19.prod.outlook.com
 (2603:10b6:300:94::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bab6bda-a8cb-4984-6b2b-08da6219a4e4
X-MS-TrafficTypeDiagnostic: BN6PR11MB2049:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slETHd5gcNiVg/8w52U5B0SkdHTWWwp9mmMc/NK4D8qpYn/h1+WaUVhQp58URKh05Qy+rhcMH/Q+ua48dBDJ4DTF2PkEwDmj1n5wipceg/eT9VzBX6ZTvY4miURGHHsW0bOlIODcHP9ifd8S37VlWtnS2n8y0LXKqCUkt46bZ/KeHtQNO69nCnsGUL1ZQGlom/3ATyj8KMjFMhtV//7gi6etwmD1cgIK+ZiyOPfOO0ODMl08wTp5+65B8zFkrWj9FylxuMyKY3zGnDtG4Macxs3UOjwqhmp149TZZqpZUYrcBi79a7LXTyxDUzxob+TmdLpDdo9ImnkWLAiUP489d3EUb6iUIXK7yUU14tw8MyLK94mlPYbV8zyxwiiIy9ht8p2IyVC+6Fn2x0hJ0j/u2mTLOnypHhgbEpBEUOVFIAwKFpUs5JUi8ROuV0PO1HsS/QLuvwl3NOqa0e/u1uMbLfnoXe89nOxx9voJZWlibkmEGM38YVOSuyVxStnClTcwWn3glkEzurii6tFIQubZ72+DOkQXVkO2f54OwEHGi4ZfAenAsdKOBhd1Z7FrYA2k8ZqR+xAxj+IWePLCNEF6wEBqhU+3NZ0Um1hQY8PQgAs23cxwfbP9qD5wdDJve9MhkmJrfobW2KMFfILVJX62HX5BtoZdu1/nxUt8Sc6dgVlbWLBcCEvkrrGrMB8nrH53ilKEeXyGLTdT+VmOi4OThV/5RVv9Rv4woc4H6YnGah/zpackIxOWVke+pGkkwTyKcMRSaL9E7OTeUUo1U9XhJwPx+S699+5rfCzEzhpMjWGwMHfQjrshglXG53US24TFxZh3OGc+XwXfG2EO4av6oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(346002)(366004)(376002)(110136005)(38100700002)(86362001)(316002)(66476007)(66556008)(66946007)(8676002)(4326008)(9686003)(6512007)(26005)(186003)(478600001)(83380400001)(82960400001)(966005)(6486002)(6506007)(6666004)(41300700001)(8936002)(5660300002)(30864003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t27PiqvKXzrIyx6T+Gtp4lCduVPg/b8HsCAHQb69VTZV84HdaRjwSrkXZyAb?=
 =?us-ascii?Q?QQHiDhNJGLf4KR2KNediqz1cZdEoRaO8ZhGLSmFwsCHAxLdvGJjA16f4GamI?=
 =?us-ascii?Q?IK4I22zv2CYVTbGnQAIBFsDXAjneoQFy3ZWu/OdC8pkXCcXEMrMHQ/Db1tKk?=
 =?us-ascii?Q?IebPEWJeLx23EWbkNJOky+XUIbnxXwhrXuYknMVg207o7/Z5rhXSxpoeAEUn?=
 =?us-ascii?Q?dPgatI2ga3d2huZqKjg5eOZnZSAXU3MgMf3XmsDSSOImYuKOEeFbWWw0oGBn?=
 =?us-ascii?Q?rz92qHGK9J/Ue+RngDNKOKpBhVLbBQbGqdrPkA8VjwA8Pe+N7Kn3bubahLCD?=
 =?us-ascii?Q?nRXauLNMcR2EnKQ41DDGvCQlZ3aDNkViP9/Kw28gK8lWfb1Zj68At/boIFl1?=
 =?us-ascii?Q?jhXkq5DkAV8wHK+Z69SkYCB1bLPS91U6IGE1eNUrayb0Aza9dzn/72nvN/k1?=
 =?us-ascii?Q?Vo5YCYHQLXFistLKc6J72TDBckK1Kk5QAHxmVnU8aMj5yLA74YLabPpXgLM2?=
 =?us-ascii?Q?LwSLdC9va6nPkjZ7HPSyQao7W61+NBHA0GFXolQtDcvaUPdztajrVS1KkEo5?=
 =?us-ascii?Q?LV2vq8spjUxor/z1uinJGTcC7Z18cZsLh8dHAcdBhvy7I9ikns0zCQ8/YXU5?=
 =?us-ascii?Q?BoF4DBHrcD9h4LacDTIf+2+r1Lo6iIciCzaTZHvr4d7nrIO/F5Xn5Qgl7tXz?=
 =?us-ascii?Q?NQWL0vps2O+NF7rq7eg48TR+f5w3vPzIhWWjfXKgKzEjp+HHPyAZziF+bqG8?=
 =?us-ascii?Q?jY96OPzpofd9gwoRgBzoc27fpvAijZGM1c0O77rWBMg95HPBrsb/O3TTijMy?=
 =?us-ascii?Q?D0eusgHV69+FFYnYnHcpjh4gkERfZnFZbah0gQM9URyNLmP/R9h9Ab5BH0oN?=
 =?us-ascii?Q?jdhXCMLCal84x2g/hAd8ZMrkCV7fhP0okqFFmNThNzUIIkrd5KJuB+kcsAGW?=
 =?us-ascii?Q?heqyw8gi/kI/eY+xoy6zObg0zQRrgCVnb/8MUIkMOx5KS0GKII7MxwQ/mFAP?=
 =?us-ascii?Q?xQqHbIwZ+s5gh7h3ycf/SPYeNlid7jU9g6btKLFOpkb4W7TPS9NT6cr+vAwj?=
 =?us-ascii?Q?FknIlePyV2UsPT6m5T2UkO4IZd9QDmz6tfTF2WRiuufiNSSEu1cRQbVpFlSh?=
 =?us-ascii?Q?mKKfYA+E1QDagyYeFx9p8RIAhoAH362JnN8BIfFTh7136yvMGWt9Q8HGhKfD?=
 =?us-ascii?Q?MkCXHPnq8qNLAamFnXvCxz9Ra6/3rsW4CTnN1v2XRL36RF26307GPA41jWme?=
 =?us-ascii?Q?u56M2nPlnC2/iHUefgOgCokQuymbKAFQyEZdHbDTLMredXTArkoSv9q3aIts?=
 =?us-ascii?Q?SfiRqrBF83iZiQIOMKyAKe6iBdXOHHg7JOZm/xlw/1/38pduxcYFegOJFcJ0?=
 =?us-ascii?Q?7kLujmxwjwA4kPQ9f8cfi6BrLbPxJ0nYayONB28Cvn0p0ug19l5YiFHYpjfY?=
 =?us-ascii?Q?jFYR9x/8niPlXC8JCbONq/qF5fDtU9ZnVNNGjH5z/voBZYrdwh4WslEBRHgk?=
 =?us-ascii?Q?t4pWp0k2oGzpESeBOnr5WTH3uS9OM/auSHXvyeSQNBIbxGj+9IzFnfhezLjZ?=
 =?us-ascii?Q?+5ZRr1lidOMSjzDjxSb3z7YZXXiD56TTk+CyV6o0hLM5xu5Q9LC9I5O0C7M5?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bab6bda-a8cb-4984-6b2b-08da6219a4e4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 02:12:30.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiVT21T/mNUgbc3d95vRTjsUlkK1fXUI/GfF0FO8yArd88I1XMD9hHiBqCir4kysmXOWFV4e7k+sRJWjdpwGGuH+p0KlnJunJC70q1YDQzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:46:05 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Recall that CXL capable address ranges, on ACPI platforms, are published
> > in the CEDT.CFMWS (CXL Early Discovery Table - CXL Fixed Memory Window
> > Structures). These windows represent both the actively mapped capacity
> > and the potential address space that can be dynamically assigned to a
> > new CXL decode configuration.
> > 
> > CXL endpoints like DDR DIMMs can be mapped at any physical address
> > including 0 and legacy ranges.
> > 
> > There is an expectation and requirement that the /proc/iomem interface
> > and the iomem_resource in the kernel reflect the full set of platform
> > address ranges. I.e. that every address range that platform firmware and
> > bus drivers enumerate be reflected as an iomem_resource entry. The hard
> > requirement to do this for CXL arises from the fact that capabilities
> > like CONFIG_DEVICE_PRIVATE expect to be able to treat empty
> > iomem_resource ranges as free for software to use as proxy address
> > space. Without CXL publishing its potential address ranges in
> > iomem_resource, the CONFIG_DEVICE_PRIVATE mechanism may inadvertently
> > steal capacity reserved for runtime provisioning of new CXL regions.
> > 
> > The approach taken supports dynamically publishing the CXL window map on
> > demand when a CXL platform driver like cxl_acpi loads. The windows are
> > then forced into the first level of iomem_resource tree via the
> > insert_resource_expand_to_fit() API. This forcing sacrifices some
> > resource boundary accurracy in order to better reflect the decode
> > hierarchy of a CXL window hosting "System RAM" and other resources.
> 
> I don't fully understand this and in particular what assumptions it
> is making.  How do we end up with overlaping resources via just parsing
> the CFMWS for instance...

Consider the case of platform firmware placing CXL memory in the EFI
memory map. In that case the CXL address range will already exist in
iomem_resource as a "System RAM" resource. The goal of this patch is to
reflect the true hierarchy of the resource tree, but late in the boot
cycle when the CXL driver stack loads.

I will add a clarification along these lines to the changelog.


> I would shout a lot louder in this description about using the CXL NS
> for that export.  That's liable to be controversial.

Added some folks to this reply and will cc them on the resend (Greg,
David, Jason), but I will remind anyone following along that proposed
solution here is the one discussed at LSF/MM:

https://lwn.net/Articles/894626/

...and suggested by Jason:

https://lore.kernel.org/all/20220420143406.GY2120790@nvidia.com/

This also builds on David's work to remove "top level resource" special
casing in various kernel paths.

Otherwise, if your concern is the export itself, I think this is a
straightforward example of why namespaces were created in the first
place to limit exports to a specific scope when there is no intent to
make the export available more generally.

> 
> > 
> > Walkers of the iomem_resource tree will also need to have access to the
> > related 'struct cxl_decoder' instances to disambiguate which portions of
> > a CXL memory resource are present vs expanded to enforce the expected
> > resource topology.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  kernel/resource.c  |    7 +++
> >  2 files changed, 114 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index d1b914dfa36c..003fa4fde357 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -73,6 +73,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
> >  struct cxl_cfmws_context {
> >  	struct device *dev;
> >  	struct cxl_port *root_port;
> > +	int id;
> >  };
> >  
> >  static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > @@ -84,8 +85,10 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  	struct cxl_switch_decoder *cxlsd;
> >  	struct device *dev = ctx->dev;
> >  	struct acpi_cedt_cfmws *cfmws;
> > +	struct resource *cxl_res;
> >  	struct cxl_decoder *cxld;
> >  	unsigned int ways, i, ig;
> > +	struct resource *res;
> >  	int rc;
> >  
> >  	cfmws = (struct acpi_cedt_cfmws *) header;
> > @@ -107,6 +110,24 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  	for (i = 0; i < ways; i++)
> >  		target_map[i] = cfmws->interleave_targets[i];
> >  
> > +	res = kzalloc(sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
> > +	if (!res->name)
> > +		goto err_name;
> > +
> > +	res->start = cfmws->base_hpa;
> > +	res->end = cfmws->base_hpa + cfmws->window_size - 1;
> > +	res->flags = IORESOURCE_MEM;
> > +
> > +	/* add to the local resource tracking to establish a sort order */
> > +	cxl_res = dev_get_drvdata(&root_port->dev);
> 
> As mentioned below, why not add cxl_res to the ctx?

Good idea.

> 
> > +	rc = insert_resource(cxl_res, res);
> > +	if (rc)
> > +		goto err_insert;
> > +
> >  	cxlsd = cxl_root_decoder_alloc(root_port, ways);
> >  	if (IS_ERR(cxld))
> >  		return 0;
> > @@ -115,8 +136,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> >  	cxld->target_type = CXL_DECODER_EXPANDER;
> >  	cxld->hpa_range = (struct range) {
> > -		.start = cfmws->base_hpa,
> > -		.end = cfmws->base_hpa + cfmws->window_size - 1,
> > +		.start = res->start,
> > +		.end = res->end,
> >  	};
> >  	cxld->interleave_ways = ways;
> >  	cxld->interleave_granularity = ig;
> > @@ -131,12 +152,19 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  			cxld->hpa_range.start, cxld->hpa_range.end);
> >  		return 0;
> >  	}
> > +
> Another whitespace tweak that shouldn't be in a patch like this...

sure.

> 
> >  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> >  		dev_name(&cxld->dev),
> >  		phys_to_target_node(cxld->hpa_range.start),
> >  		cxld->hpa_range.start, cxld->hpa_range.end);
> >  
> >  	return 0;
> > +
> > +err_insert:
> > +	kfree(res->name);
> > +err_name:
> > +	kfree(res);
> > +	return -ENOMEM;
> >  }
> >  
> >  __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
> > @@ -291,9 +319,66 @@ static void cxl_acpi_lock_reset_class(void *dev)
> >  	device_lock_reset_class(dev);
> >  }
> >  
> > +static void del_cxl_resource(struct resource *res)
> > +{
> > +	kfree(res->name);
> > +	kfree(res);
> > +}
> > +
> > +static void remove_cxl_resources(void *data)
> > +{
> > +	struct resource *res, *next, *cxl = data;
> > +
> > +	for (res = cxl->child; res; res = next) {
> > +		struct resource *victim = (struct resource *) res->desc;
> > +
> > +		next = res->sibling;
> > +		remove_resource(res);
> > +
> > +		if (victim) {
> > +			remove_resource(victim);
> > +			kfree(victim);
> > +		}
> > +
> > +		del_cxl_resource(res);
> > +	}
> > +}
> > +
> > +static int add_cxl_resources(struct resource *cxl)
> 
> I'd like to see some documentation of what this is doing...
> 
> > +{
> > +	struct resource *res, *new, *next;
> > +
> > +	for (res = cxl->child; res; res = next) {
> > +		new = kzalloc(sizeof(*new), GFP_KERNEL);
> > +		if (!new)
> > +			return -ENOMEM;
> > +		new->name = res->name;
> > +		new->start = res->start;
> > +		new->end = res->end;
> > +		new->flags = IORESOURCE_MEM;
> > +		res->desc = (unsigned long) new;
> > +
> > +		insert_resource_expand_to_fit(&iomem_resource, new);
> 
> Given you've called out limitations of this call in the patch description
> it would be good to have some of that info in the code.
> 
> > +
> > +		next = res->sibling;
> > +		while (next && resource_overlaps(new, next)) {
> 
> I'm struggling to grasp why we'd have overlaps, comments would probably help.

Added the following...

/**
 * add_cxl_resources() - reflect CXL fixed memory windows in iomem_resource
 * @cxl_res: A standalone resource tree where each CXL window is a sibling
 *
 * Walk each CXL window in @cxl_res and add it to iomem_resource potentially
 * expanding its boundaries to ensure that any conflicting resources become
 * children. If a window is expanded it may then conflict with a another window
 * entry and require the window to be truncated or trimmed. Consider this
 * situation:
 *
 * |-- "CXL Window 0" --||----- "CXL Window 1" -----|
 * |--------------- "System RAM" -------------|
 *
 * ...where platform firmware has established as System RAM resource across 2
 * windows, but has left some portion of window 1 for dynamic CXL region
 * provisioning. In this case "Window 0" will span the entirety of the "System
 * RAM" span, and "CXL Window 1" is truncated to the remaining tail past the end
 * of that "System RAM" resource.
 */


Also, if you're wondering, the mismatch of iomem_resource entries to the
CXL windows does not matter in practice as dynamic region provisioning
only cares about the portions of the CXL windows that do not intersect
with any other resource. All that matters is that all intersections are
accounted for when it comes time to scan for free address space.

> 
> > +			if (resource_contains(new, next)) {
> > +				struct resource *_next = next->sibling;
> > +
> > +				remove_resource(next);
> > +				del_cxl_resource(next);
> > +				next = _next;
> > +			} else
> > +				next->start = new->end + 1;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> >  static int cxl_acpi_probe(struct platform_device *pdev)
> >  {
> >  	int rc;
> > +	struct resource *cxl_res;
> >  	struct cxl_port *root_port;
> >  	struct device *host = &pdev->dev;
> >  	struct acpi_device *adev = ACPI_COMPANION(host);
> > @@ -305,21 +390,40 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		return rc;
> >  
> > +	cxl_res = devm_kzalloc(host, sizeof(*cxl_res), GFP_KERNEL);
> > +	if (!cxl_res)
> > +		return -ENOMEM;
> > +	cxl_res->name = "CXL mem";
> > +	cxl_res->start = 0;
> > +	cxl_res->end = -1;
> > +	cxl_res->flags = IORESOURCE_MEM;
> > +
> >  	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> >  	if (IS_ERR(root_port))
> >  		return PTR_ERR(root_port);
> >  	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> > +	dev_set_drvdata(&root_port->dev, cxl_res);
> 
> Rather ugly way of sneaking it into the callback. If that is the only
> purpose, perhaps better to just add to the cxl_cfmws_context.

yup.

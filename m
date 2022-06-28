Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AD55D6E7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbiF1DeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 23:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiF1DeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 23:34:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9DF24F0D;
        Mon, 27 Jun 2022 20:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656387258; x=1687923258;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FxYPW5G8stYkPHjeR32E2U1WV+Y9cAHARXctxCW8xLc=;
  b=NhkTrVvSaOllgvuSp+pYJAQ/OEQk1UMpZtFgE00QjwkFbf+a+vvBo8W5
   DIgrEgsWrDVIJi5Y1zt0Q+UvJTcpk0I+6zShP/VPNxDz9vzW4/QH5XFE1
   +1lLmOQBx7XmsQHNDYRF4WtKGXbiNcBe0H1pyKoGOL/OcGyfNkRJSaiSf
   zNOB92iMS58gQp4veVHnN6cif214ZtCO7NRMBao50kOrCsHbQTGNqkJxl
   +lCK3nGTRUnm4YWYeRkgmrTsptALyCkqcFFOA1n4+Ht3J3Kega+Bn3qPi
   KqsGYzJulN+5FRkeCBSlKSXZ4c0vy/stNrOMqtV9fmNJmdmjDK5Z1sPXL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281660317"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281660317"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692907670"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2022 20:34:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 20:34:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 20:34:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 20:34:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtLL8SNk6N6TyFBUOMmqFRb/mpaJ3ZfDnR4WYjGfi6FAjKCj0X3+fIxb7kcAOOVQKsqCSc0NjyKstulo4FHvaQDRh+0pcH6TzkfOafDOFKAEd/r8ecpxbBR95F5uIii0GG+Axw/Sh37YtFOIrtClIw0hmQPygXx4g6CxiU5A2FKpTCc1C+0k9NnizbELt4ESeXsSX2Zh23mSUE6i5UIK52R3wH1HKTG95VyElAZjyGeh2tGDuJ8q5itJVx5WRZAdymRnBH7Tvg5tAPqqb2k+4RKRdB35lLJMIvygVZ3Jd4Kf3M5CyJ4jowzn/8JpkUAMlj/SXyMLFtYW82tsYMIBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/TSGYcq/+zWEOzRsrE4YIEmrS8rMq4ZW0UEj+hO+GM=;
 b=bUd3/GsuJ+rW4is5w7+mEMw6FDgGn9zx4ZBWlpZavYdZNmyGZhhbsfokw1XxQSXQHE+uGQVRg7mpyKJM7t8Or9uZl0a7LA3/XZtlwY3DfXiIUosfWjGQU8n0pWuqiBPsl22yYgP58rCTKJUz0cKN5JD/FsyYlT8Nq5G8lTktCHfQ6jDN0fU/5n9KTm3aRuYlyeAj4JUAWIJv1cX72r7Wi9DrJq4tAkc8xk2xB0K86JWCrQIVWUKsPwFXnR+NlKzDliSmkpj8X5XsGQN5KwANAfAQwlVPhtJ+Ol2rlUeFrsSRsL9WEReZQ25w09MzZsGwd44PbWXusGroIPzloISIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5102.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 03:34:15 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 03:34:14 +0000
Date:   Mon, 27 Jun 2022 20:34:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 00/46] CXL PMEM Region Provisioning
Message-ID: <62ba76b49721b_169b9c2949c@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220628031205.GA1575206@alison-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628031205.GA1575206@alison-desk>
X-ClientProxiedBy: CO2PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:104:6::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6126ea29-5f9f-4644-a1c9-08da58b712c0
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5102:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqt2Km/7auNKiFE0G/6lk+xqSlqbMY1xcwq+WTNGB0ade2tlIs/TGj9SV3iYUnv7tg1mnAjQ5bLU2zcZlud+hs7kPnsIjJ/vdNu5a/8G42SYvSBt6U81XTERM7XU/udzNc4mmGbErpWFKYZ0MzWyvomq11u2iYVWayaBD6NUkx4oY8/uFIngSFFJQLnZfsv5wjOJmtM01Bx0fEa+zFxnnIeVqnbRzPj5rABkSJiXb+RxN9fPAXjmlDxnjNmzGXOZX6PQOxsyCgvpy2WhwgHlv3ZNw0m7DAy8gcPHQsEBk+ugQl/aBcWoCag7d3ggDBDb9mCT0FysjZ+1duoVhgzEOFNc0fQ+uV+FIncdP6pFhHD79PhPsjaz638IV20Ybw7a142c5T0AZCKYbs0Rkk1Q81yiR8lyFLB4hi44qMC+A44gbX4T/dQr2e664KTUpGIWlflFE+GyluWSyfZYnqErvrKWO2s9jrb2dQxY1apVCrmuEmgTah1zwoQl9FrGVRPUBbCV75iF9Tf3WJFwAxI95GKcb8RybdM5W345Bn3g1L2g/r6wUBaxxQDI1Trb7TXjUzPiywau/ERAZddxnnr1cNrfr4qm9Z4XpW1+yLb0GOZlM9n3H7UfRRqNbBGIe+5h5URGHOHXXIM9WK7XPZDPOGSc+GRSSSYgL0IwBovYEiAYEV0W/H5B9nLM6PGTQlVscjDKKEld26Hm5qbMYMyACsmif010MEmuhYbARMQbb2AjAxbezAALVH29NInyaKuv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(396003)(376002)(136003)(6506007)(86362001)(26005)(8676002)(4326008)(83380400001)(66946007)(66556008)(66476007)(6486002)(9686003)(6512007)(478600001)(8936002)(38100700002)(110136005)(41300700001)(5660300002)(316002)(82960400001)(54906003)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SbtfWowIwxOenOXsVDsDag7gb4uswxwFsHJQl4UPayaSUAM4qIQD+qeNFPZY?=
 =?us-ascii?Q?CfJlYpneSH0uIqBoryd9hxLB/LUHRjTsk+FqH9RsPnN+AepawEtl8jNASWte?=
 =?us-ascii?Q?8SZwF6F4ID0bLAq4lTdP1VMMRRwmb7/iSyA9FKOhRE0kXjyaSxYTKSE3kv/F?=
 =?us-ascii?Q?PNHuebX+DVsimLRs3KrrRA752xtTi3YnWfojm4400ar2+p5j9+fu80T61xuJ?=
 =?us-ascii?Q?mjDJSEShW8nvd0/euXzCdrXaL8hkYdmZYvhnCOQo9IZF0yf1An/dv3c4Xcm1?=
 =?us-ascii?Q?EKP3T0Kk5VQzzTJypK02SY6UWZXDOfJar497CTZfplNbURvtbuIFGgTPLQ08?=
 =?us-ascii?Q?H4GmnSka76Bd1E1vC71igJU6MKzdiMnDEcI7q+Gl5jHhOXUde2C49/9RLW3s?=
 =?us-ascii?Q?cA6xUzCil3TDVvNeAtmjGz9ZD45/nEd60y0/5RKdivcoc54DrQyTpWLx2JQj?=
 =?us-ascii?Q?0uYg6MHIJ2Cenwn8hzhpTEabvwfq5EGLeemX+I7SVTJQe/HwXqRHBRapykoN?=
 =?us-ascii?Q?kdKkUB5lDn1cpuTq/aVE8v7h6XI7vrgcv5qO73LAgrTPIl4UU8i1ATlCjeFF?=
 =?us-ascii?Q?Du7+wBTrr8riOzzpTIxq819DFcElnBpPl4G6thFfZNYz6DFO0n0fcl00a+GV?=
 =?us-ascii?Q?cKVR431Z3JJQNLn4IxkaHQYwI65SDKZ6iTJXG/W+yc9PnSRc3PhRN1LcItQ+?=
 =?us-ascii?Q?t1K8jr80UbY2Id3bRyXdU7D3q/R5D4VHH3qrlx3p3pSYNlw9lEtZ8CaHWEgI?=
 =?us-ascii?Q?6hYYSedtRF7pkqavQBd2HXLa68M8XiG1zh77OzhxaPXsnoJEOnjFO2J4bxKP?=
 =?us-ascii?Q?bgWr9q9PZwqUZm4PV57fKmzqFEhF8Iz22DhAAeuGJ3Cskhthu7AYW1Mlqs0a?=
 =?us-ascii?Q?GtpPtNOYSgnU5AKiU/+ik1pGDyVTWUGW1trTjbWL1GI5zAtlp8hEmlxLjJ7B?=
 =?us-ascii?Q?JOIjJgy3rV1PEVz/ZEVqwxTU3Wfope7QWE44ncINjDIBaMU7zZakpZVbwr0B?=
 =?us-ascii?Q?+QykIvfsUGTAstCAtICPtcFZV2jjTd+0UpecfSNNB6zSgxslC49CeazTgNQM?=
 =?us-ascii?Q?PTKjKq0fDC2kH20elI3RUt2UPiGFRms1frnG3QXa6La5Ae+M7P9Ik7UfIv+8?=
 =?us-ascii?Q?AlRYZgKbnN59HQFJMM4KhHIJQREpSgN2xLDEUC5WF0hhTf4cHkpRRUxbJnlm?=
 =?us-ascii?Q?yWQsX+vIRmUTczT0LlRF0jsgdkYyIoLMmkxCX+fcsHBPTJfHW+kte6WWH3du?=
 =?us-ascii?Q?SeSeN7O4sht/HfI8yirOtRTXmt4LGJkU0a4aZgyUYN9bLctL4A79n6WR+x9q?=
 =?us-ascii?Q?jEZJtlTsO+QNaWYROFi5wz7c/kAlfsahkKcflMg3aF2KpO7KCMzdFq5CQEY3?=
 =?us-ascii?Q?FLOw/OoZxRf1Gz0WK5RNJjcYCUtZ2Zlk6pERiTIwXJPO8mW4Ufpnc5MkXHRG?=
 =?us-ascii?Q?PhOIrFul71MerTFpJrE8AtifTzuE1FK4CsVuNfx02BzpBcA8M30KtQmxtJBL?=
 =?us-ascii?Q?g/WqCbWyox0e8IyofFgVWW6JJ5rse4uLEYQ9Vk5zDZ9rKE+QG9f3FrxJ2Yup?=
 =?us-ascii?Q?LXd4fkYC1Z8ErMoP/JOvOo86bsqU/6Zm5YSS7ebYu4vcaansr/85Gx/8LDEU?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6126ea29-5f9f-4644-a1c9-08da58b712c0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 03:34:14.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYwja7XhTvaJ4EKRfZYyQhXVXlaPJ6QE5JfRVhxvcid+flbtSZeauBL9EPTYlyW7TVNA+J0feOa8SR5tciR2CGXhFOionmPHuMQRZYi2fIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5102
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alison Schofield wrote:
> 
> -snipped everything
> 
> These are commit message typos followed by one tidy-up request.
> 
> [PATCH 00/46] CXL PMEM Region Provisioning
> s/usersapce/userspace
> s/mangage/manage
> 
> [PATCH 09/46] cxl/acpi: Track CXL resources in iomem_resource
> s/accurracy/accuracy
> 
> [PATCH 11/46] cxl/core: Define a 'struct cxl_endpoint_decoder' for tracking DPA resources
> s/platfom/platforma
> 
> [PATCH 14/46] cxl/hdm: Enumerate allocated DPA
> s/provisioining/provisioning
> s/comrpised/comprised
> s/volaltile-ram/volatile-ram
> 
> [PATCH 23/46] tools/testing/cxl: Add partition support
> s/mecahinisms/mechanisms
> 
> [PATCH 25/46] cxl/port: Record dport in endpoint references
> s/endoint/endpoint
> 
> [PATCH 30/46] cxl/hdm: Add sysfs attributes for interleave ways + granularity
> s/userpace/userspace
> s/resonsible/responsible
> 
> [PATCH 35/46] cxl/region: Add a 'uuid' attribute
> s/is operation/its operation
> 
> [PATCH 42/46] cxl/hdm: Commit decoder state to hardware
> s/base-addres/base-address
> s/intereleave/interleave

Thanks!

Wonder why my checkpatch run elided those.

> How about shortening the commit messages of Patch 10 & 11? They make my
> git pretty one liner output ugly.

I'll think about it if the whole series ends up needing a resend, but
changing subjects does confuse b4 version tracking.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8F6F70CB
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEDRXO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDRXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 13:23:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98281422C
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683220992; x=1714756992;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TbJYKgi+1F+E28TvFUjzPRKi6z3OJJS3om9ZhsBGu6Q=;
  b=Uzq1dHvBKIYLWr3kSQdzZHoAj5mNRUURK3Ob3k14oieWgkOG7Q1ZQj8x
   FTjoEJi1fN+oi0RC9V64jkhfKIR0LsjM4U/L9qfpU1OQZmhCYFd5yTBJp
   G9yGKu4A3UgSmti75yCW1zPlGNB5mYrhNq/92/g5suE3RwUv5xBj9HmM/
   fTpoA1Pqrg4QlQY2I+E4Na4z9vxOiAEWT3DXmqW8TLRUABm7d6OvUOoX0
   OFWM183hxcdMjipxT7bPwHgyFt/Tkd+8oCGXrVVjOUIZE6qDXIi5yyQyF
   7t6tMkBC+9XpfBAde5OcGOrr7f8qliflfiPx9/3SWYM30dE8LQWQfVoYb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435313123"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="435313123"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 10:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="691232715"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="691232715"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 04 May 2023 10:22:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 10:22:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 10:22:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 10:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK4NouEMvzUSzoWC/sCyLUkaqLDfIqU2Wpk+m9RqoU1ShXqxAA67NNpTv8Yw8ASLTbEl8sQa87/24iUsAnvDOSEFjYfyPxWCC52TjtKyDBvtP+V0WEnz1Omr6JpwlzcKfTrELG37mSuRtFyYRBpLXyUB3TgFSsAdeXuQPfBGXpxujfJYU8I8F0XHUHKCvHS7JE9VYtXBwgC8tcHlDRTpzqVrMHj1dM2xP86b4T7z+1NeAVF6L0baNiJc7emG7Zyg3eSUiuiJh4veQ3+KdrRSiXpt5keSnzdDIzGN7eF/6fZY7iIASxM5DrWK8SXX3fpHeBbe5j4t3qj+sQdrRcMSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS+2NA0nlzGHcIfY4UoyELCCwjrpbuHQ4sNHFTCpnM8=;
 b=ftxkkRzORMGM2tQ5IdqZHF2XFQoE8ZIQe/NYXlhUWQ/Pj86XxVf3xnLBEUDGPXj0uzlDVJ2oAVgnRWufeCNRku6cZvmr2ExXdvxO7hc20P0u10i8B0uDGa9sBFrQp7QMfA0QAlYbKsxT951jUXbB+AoKyyb7vhVO5kf48U37GjTDUtmmvyOmWAHGx1uuezel2ScI35/pc4AGIC0wA7RsNekidPiZkk/qQkgCwgo3g0mM0T8xX+u83YZoydX7FgrfGYaR6rkOFTrdV4woo5d//PKufjyqDczRcN8vtEo/6eAiLniGJyBp3hNyLSpRp2CQujrwl3bvxnFWiUGICfFz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 17:22:57 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b3a5:53f9:3055:e9ff]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b3a5:53f9:3055:e9ff%4]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 17:22:57 +0000
Date:   Thu, 4 May 2023 10:22:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <stuart.w.hayes@gmail.com>,
        <dan.j.williams@intel.com>
Subject: RE: [PATCH 1/3] misc: enclosure: remove get_active() callback
Message-ID: <6453e9ee667dc_2ec5d29462@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
 <20221117163407.28472-2-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221117163407.28472-2-mariusz.tkaczyk@linux.intel.com>
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH8PR11MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c127c9b-ae2c-43db-be46-08db4cc433c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuCHkaCid55HtiCC7wYYxivJqmbnUSlUV82ecDPMO5mK5i+TGHfNd77vDXM3SxF6fpxz6UE4dxfNAHY1kVKocGQLqA6Cra2AFLdnLm+bcKvf5VTPb2YkTMQudi07rbb7ya00LyJWcWiHmIV/qL+KtRFioG3YZxieSSHbdf0TSv9Mioymbs79Kvt8MZaqcoinoEv1g6p5/Bnb+8YtEGW7ql+iSS2ix4qDW7qnuvHMEozi2hOhaXwq6eZKH7Zoc28grNDCrQ0iQTDp1osH7iP027KT4fR7Vcc8MuG4r56MEgld6KPIHrDMB7OjZXEIFbY+KPZxINAvqq2bnL45Rv3exB0dunrIJi1gCPvdnVgLdK8mBtucmNMfHsFwoCbslNWXF0nvqs3NDlx894kdsKOQ4/ugellzRp04TcnyhRRhd8jrsIC/MwnT5GSlz7WZu/LRw64tWsqX+zDPOYfSy5qsTcUgWxiX1w15z8iwZkKppC3BZ7akevYYonwRuROyneil0QcLPZBissl8RES7IB7aBniZLq9WA3gukSkKkzK5UORIDbwZCnBcmhMR3LKflba1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(41300700001)(83380400001)(316002)(8936002)(8676002)(5660300002)(4326008)(66946007)(66556008)(66476007)(38100700002)(2906002)(186003)(9686003)(82960400001)(26005)(6512007)(6506007)(6486002)(6666004)(4744005)(86362001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wfyjHtmQzIZ/q6cXD93YdhVYFtBdacqLwoyAEHnesT5h3v+SSaitsmrrCRkR?=
 =?us-ascii?Q?aUtS1S+0W/YZeeKkwznsh+dPEJQQsWtw77he9QlOXbJTeyor12odSvYFpMvj?=
 =?us-ascii?Q?xXaI8snVg9Bu5t4if40oSnXWv96UFX5rW3z65ySDUodG8Ow0TuqEBhS9mZAB?=
 =?us-ascii?Q?BLX6OeLz3JRuGHqBfOisPBw7sX5z4Fl2u3E6WwK44+Tq74/ybbkKi+ZctnBZ?=
 =?us-ascii?Q?h/96nwQY6i2PBaTo9eaPelkVJldlYOTVCR023e8Yc2As8XWG/78yRkXUOXmE?=
 =?us-ascii?Q?eyctd1QYUG3ESdpCF53EacPn+0C8k4zMtwqddcfRW58e+TZchHUCfrLtV2rR?=
 =?us-ascii?Q?gQvBD740MB508VcfEwauzAYAclVT+/L5Qvppf2sjXKKzn7w3KBIciwrfjjyL?=
 =?us-ascii?Q?5jm+qbffWoqDHjnRt+b/GFyUEFun9k2A2xlQA6i9Sd4TO6AYUkfrS8DUGele?=
 =?us-ascii?Q?wCzBAEGxF/TvOJvGvh5jRiigC4LxcCuYhO9inRadP6RJHAjgPzxVmxX/3C1a?=
 =?us-ascii?Q?9mjEsDy8dWeEsJIu2jK6qNzqoJ7KpFTMbS4b7wad5W53wGDhuA9C/5WVnsM5?=
 =?us-ascii?Q?VU0ZEIX88fAIhppoL9sylFxQVBs5hQkR7Mdxi6epOhQ0BEdeNZSwPs95g+t+?=
 =?us-ascii?Q?7PEVe5bbnhWvvH3emkNRtx8BR2C1Nvk0LI4K4p5mdTeZGxKA6dxIiTE7qftA?=
 =?us-ascii?Q?FkdI+xzRJX80vpS1CibA7YsEjTJHKAbEO5XuVphceB6lkNT8PNgM67nXnEAb?=
 =?us-ascii?Q?bmlrHhN/HkwNgHDcqMHgdPUwuRHcpCMi+dtshBmtd8VHvrLZXQb5FAgmBOpX?=
 =?us-ascii?Q?gtxKKxbyKOtjBv3YIq0dkZZPVURhW5JMONo+vCmzVb4zo2+wRWdGrNaI47oa?=
 =?us-ascii?Q?9584sa/xErRn+lEoKx2YYSqq1b14FXDO+yk8ZYsyH93LbjcnaiddA1FbZGea?=
 =?us-ascii?Q?01QYqY2UtoyQ1/d/lZV0sexebBGEQIyyGqdGZFT5dXV+gKaWkjGmdIcfKk+t?=
 =?us-ascii?Q?eFeAw6HGOoNvesqKSsmwR6RaLFuz/vseBqm1rnv/MVXxi8F5D86v3UL2zc8y?=
 =?us-ascii?Q?WuDHCQ/i89nV5RhzYzM03her5UWXAQrAqd62Aq5+vKWHBll/mGUrW8hJjrD2?=
 =?us-ascii?Q?tfM5tKD3anALTP1YZk5TU3d8IfR2JCvqqRicbCto2OgKQeK4R2/6fFwP+vXd?=
 =?us-ascii?Q?ZDC8PGshogoKuAaUfCpoZ2YQeC6mVI0Z1kl7d6cLjkKlf7Jg6xHQHtKky5u1?=
 =?us-ascii?Q?rDmKwoisfcxhg6jLF66uVjNiS/Vv9quSTxrszRggREA9QzSsl8RdWO4VODBC?=
 =?us-ascii?Q?NdmymOUZWEo5UAA2PibKwCTQtD57a0VXX6jOGmAJVIY9uv/CB4feOWPt4XqC?=
 =?us-ascii?Q?oqhSIO/pECMBQKjvwHY8yO/3MYRLdH3lznOMBBDTIqpRb6OtB2qTEAPyUjRz?=
 =?us-ascii?Q?fF0E59sloQ/hFXYUyFqD0skZX854nR7k8hCQ41L3BjRtryrqEZoCCG1HvNyO?=
 =?us-ascii?Q?Oi19XNZX3Eb0BB/55bWuP4wXtlXj8e6PqUi46mFdS2prBbYIijn0I6itwhBB?=
 =?us-ascii?Q?x9oRISeHLkwNSopcK3d5nqgUmEtM12h5C42cNUtzpcvYNrr2OZVvevXNq+FR?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c127c9b-ae2c-43db-be46-08db4cc433c6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 17:22:57.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98ZRYF32HIWmLZIL1PP+NVVqRIedSFMcZkkNZUr8Ha1tCyr2utHQSJVgbtEnYotVx06suEhVx4E/IkSs8OOPxvOTnrK+ZHU3ZzrE6wXNRfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mariusz Tkaczyk wrote:
> The callback is not used, remove it.

While the callback is not used, userspace might still be dependent upon
on the "active" attribute being readable. So I think the change would be
limited to:

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 4ba966529458..0d7225dc5d45 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -534,11 +534,8 @@ static ssize_t set_component_status(struct device *cdev,
 static ssize_t get_component_active(struct device *cdev,
                                    struct device_attribute *attr, char *buf)
 {
-       struct enclosure_device *edev = to_enclosure_device(cdev->parent);
        struct enclosure_component *ecomp = to_enclosure_component(cdev);
 
-       if (edev->cb->get_active)
-               edev->cb->get_active(edev, ecomp);
        return sysfs_emit(buf, "%d\n", ecomp->active);
 }
 
...unless you can prove that userspace never reads "active", but I
expect it is too late to make a breaking change like that.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43527575680
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbiGNUoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiGNUoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 16:44:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3853F4D16D;
        Thu, 14 Jul 2022 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657831472; x=1689367472;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NJPvRq0jIZ/GFS1toJdP805WZZmnHk8hn5saK1fIZnI=;
  b=Lj7g8vSqZwAYfASz2JWaXAj/E7Fcz196jFZGR9MCQilsuHUvTuROCa6x
   Y/ccFG4kzw9KI0fBylWhCmOTJNOD51BqD7u9gDJpwUmFEhyaYyEQUgSeO
   aWzvidu0Fo8lwgNeMFZYxuOwL25MKBFoCa+wUXtfur2p9sDqILnJJDExO
   GInjg1WCbUarv9zV/HluYRgTYV6ZbPXOONiAwX7iLUEacEXHErz+K4au5
   9If48HhfDrdgdnJZZDMOf9bjoS0jiJRmuJB++3bbUHK7SZk8tm4wJ+jpw
   IA3i4GDlKMNY9uQ7NQeEpurSclO5EChklG/9jQTY/V/SekSMMl8BOD7m1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349592146"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="349592146"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="923224520"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2022 13:44:31 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:44:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 13:44:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 13:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy6IKyhDpXYoxh1Ph54000vXdGgR96s38ApL5IRUSTLtzZkCZar3sHM3Qt6OIQpySE4hA7bDnH8YWu/PE5FBEV/sFFf3VrdN71KhNM5gDuOQQDSrBTpeDdAhJ6STjT8uVF2pmlBboH1pjrYQXWhujCU1Ogj8p3DaYWFJkTJiyYzQwbwVhhma9sWb2B1PROVNqABlEVHylT2FWNOQvoI/fbEM934PBWtg5xTUt6VSqAZWTktE0L4w3AaT9n9XHJM9AJxfRZQtH2LnlxiX73e3wYJxTAzGfnhT+sk7/9/+sJz/btBVt6WzhNoOo4SFbFuyt+47gWQdLeEv0WupApiMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bjjBOaz4Wa885xAW/d7WeALTW1XokgsgYLqsTRiOiw=;
 b=chZujgXEPdxnmvIQrjXQUCF36im+Pu+/zn23pgUToETuuivRl1dK8VystgnnRRht2W1Rf/ZFtikpbunVzhG5kdqB1JX5H1agsD6V8E+k6ryTGLJ+eCwhVBgQe0cPeXY47gG1WpyqUYAYBs+eVIIgXL/oWIfKlL8bqeiOVAjTRiqtxWPVzfsxUFqdUDTqKFrGW8TSx7ax7DnB4DwRpJEQI4YT3xieTEFYyEtOBRWW2+PZ13fMLYdpVX6b+GujvnuaLpCBqqMBHqooUuhjGew/GkXrNKFzHgOsX7Sr8dkSGNWt+WZ8nUeC3MU7MY6P77iWqiogxNhgkfK/KL2w+F6mlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6512.namprd11.prod.outlook.com
 (2603:10b6:930:40::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 20:44:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 20:44:28 +0000
Date:   Thu, 14 Jul 2022 13:44:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <62d08029504b6_1643dc294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-9-ira.weiny@intel.com>
 <62d043d8bd04c_16fb9729422@dwillia2-xfh.jf.intel.com.notmuch>
 <YtB3GySfcm5CfG01@iweiny-desk3>
 <YtB49QRceabLTV/7@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YtB49QRceabLTV/7@iweiny-desk3>
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f09f4355-67f9-4adb-f027-08da65d9a524
X-MS-TrafficTypeDiagnostic: CY5PR11MB6512:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0qw95VVgw0NImdyMKuONx3/AkPWqE9p6hzP1FW8dqaa846tyBAZDP8BwmY9BI1sXrPNRcM/7vSPjBifjdKhZqpYX+98V4XhGUFRzArKmow9B5/DiDHvVr3rTe6boX6tAeBEVjZlFhTnpRKJVAu2+ifKp1913i8itI3ijKnVJXQucxZSzqpbpWj1b9hhHzRAdvoQe6Y/yLF3l4hjSxdFVPIM8Pur6RbhMQkwpe5b4gcOF6plAWSnKNlIJp1hOP3KOkp9c23XrEvyFp8lR7GrvE5MiQLim3UHQYH6V+4RtNuVmopHeIIpcZFBXcERHwqOr//cBwIKaX9k9QHfmMTpFwCiXvbr50qI0LGLBDLg/S530L+QiStvnz8+bi9alirUQMfq+egmCJH0usOyyP5jQpHzI/WijeqQkfvkCWp+R8HpLUtudo0TLAPksxBk5LdsMueZT3HrAAoi5Iq5R/AilYCpxK3m9CRr1wIdmPf34RFaheh38KF/Ov/srefmjJc969635oWPArz9HA7bWtEg53HIpBCMVNtTc65OSeGmnrvPzdKSln0Zg4+ARsLHnPltMbU2Zt6bOpd8A3j+13YoGjhPEfV26SowTnE+X7gxmpOCHXJcrURGbIPs8SCD8fTtvRPBFUl3pxAx6KFamL1R0ao4qkzuTzPgL1qwnKF82zuiDf87LwNzkk5cvuyT35AYTLeYPhEmqtXizWK5QQnCg2zihcNaZ/6x7YEfTOJdwuoxPlsgts2ORn5LChu3gKLHzHBV8AlHOHuHxoT5Sl2CrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(39860400002)(366004)(136003)(54906003)(41300700001)(6506007)(478600001)(9686003)(316002)(186003)(6512007)(110136005)(6486002)(6666004)(38100700002)(8936002)(86362001)(5660300002)(26005)(4326008)(66476007)(2906002)(83380400001)(82960400001)(66556008)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7SOAtdeVMgIvpbS17xl53jvR1oN/pdgc80lwNy5WXqqBju/xHewEaaLrqOLh?=
 =?us-ascii?Q?9G9kbkUSY24az0myoa4+HcA5V7SHZLLGmq+hG3hlh32v/y2gg9P9f8fPYZQY?=
 =?us-ascii?Q?u03v/JyS2uZAQ/mJqrVRp3dGifWRBnVXmgyUVEeOEVUeUjz8Bh0ZZWpaCRAl?=
 =?us-ascii?Q?Bxt+/NWIyWXOkWiNa5ZVOeWcV83PHY6uAjvgT6pI1nIbAgRUrkwFQKSNXtn+?=
 =?us-ascii?Q?VxOye26QzJC2V/DORxtbMxI6Cwux6S6+8CcTjI4BDOaCOVuUoDryHEupBFEY?=
 =?us-ascii?Q?F7EDggiVR47rLP5xsemyC0dwWHdK/BrDReBFhs/0X3MWn4Y7WHLzhikS2NmX?=
 =?us-ascii?Q?5tLgvsfaqmEfDrEw3+Loaq2PQV8SiMoIPFbYezcGI/HxxXWQT/PcWqSSw9KA?=
 =?us-ascii?Q?PFlJ7BIoQ2QZp0gVLRLgKxgSvw6QVyhWHtg1fUeEYR7C6ZFIo7XdUsluf2RZ?=
 =?us-ascii?Q?b0ccbIAZvpRTXBg+Q37o+PGxtvxPPtbnazEHx6KgVXY7m+yRcG2uCgAshau+?=
 =?us-ascii?Q?hxuAPVdAG28jqrdMZLbyYfogE/HkLY6CjxRbHLHrcM3z/A1vL2QEpc7Hl5jC?=
 =?us-ascii?Q?CZQjK5ZTY9VaXhkdaqBH3uOigVl0/x9KCgBHyoqpRhPuhhXFUIKJTcurX2Hw?=
 =?us-ascii?Q?3TrP/Yq7piKYN6IXM/q+zzD8O87XE6SM3WwgqUQyUTosey7WIGlaneAqHkPB?=
 =?us-ascii?Q?7Emqthz6qnwWm44AJ/CXJOM+ZUsPKp8SRg3HQgCFLC/eyfq5si7P58wMiivp?=
 =?us-ascii?Q?SnyMfSm8jfAsy4Y2sGgsT9rDawvaQU2Asn8cVO4ZLZfPn2KMeQ8lH4mcYLoP?=
 =?us-ascii?Q?Yl3kXoyiLcQc3HStAb3Ph2BclcU8DUvN9KogeCVIuMgkcv0JqKNKyPVHvOby?=
 =?us-ascii?Q?CLLDlCLluO35dN8EMhmlRSLhe7GCawc0ljdqkrs/WSk6vjjwMwI+TjhkVuO8?=
 =?us-ascii?Q?Ww5yl+qUI709hoknf/7dGKb1KFy9nc9hD5Yzi9nff1upIrvaOCwzWgmyjCra?=
 =?us-ascii?Q?nr8zlXK1uZpWIJjAZmL9pH5zxCyTmxb43+zqcRCADZp8zChiiFympaCeCZR2?=
 =?us-ascii?Q?X5EvIikNl2lA7cfwjxhqBLHwOjjeidwyz671Ert8BPtLIIsaEEpND44SA+2t?=
 =?us-ascii?Q?JnBNRTEgnx4GQbXG++QUFDyK8I327ZUThCkTMzj2ngrYp6Y8BujY00om9sj/?=
 =?us-ascii?Q?mD6VSjwHcaH+oxkTzVFuEsD6bFAvf8oFEvVQCprBe5nr0LiuTT8pcQ1xyMcf?=
 =?us-ascii?Q?d8gRAt9Ysgl11on5YsLvdLcn+pYM5OlyAKhM9CD+8iImWT8fSj+PwwWKaMjr?=
 =?us-ascii?Q?D5JiolH3bpQEggZ4VpZegdsyypeOmGtXYzrJ6g4SGNOx7vF6+MOil/Npgz2D?=
 =?us-ascii?Q?uAofuZ2r64p6Nm+I1D6ISD3ty5kz7elGwwQb3Q6dVI+14ROXFxcJO6FKNSWD?=
 =?us-ascii?Q?8hjMM1/SvjOjZ6TI+cCE9nHibJQEQMhBH801E9y1+h3kLJI5wByW5CNYOZja?=
 =?us-ascii?Q?urXzCNmGLeEsO7QQhMbddu5SBU9G6Xj+5S0G/FdeefLCjqeP2gxTH4o7p0RT?=
 =?us-ascii?Q?4HQsW1kfEM+pc+m6dFhRnjH39lj6zrBTvuWjR2LTxl31g1R3cPACRbeT263M?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f09f4355-67f9-4adb-f027-08da65d9a524
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:44:28.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f65eSNaUONnBsIdZqZBY7pSwT68Wnh0yPtx3usqtDzZwvJunTbim6Si50gJJYeZhCx/BirZRn9wGKgne7OuvEPLG4YvNh077mxibC3l/azE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
> On Thu, Jul 14, 2022 at 01:05:47PM -0700, Ira wrote:
> > On Thu, Jul 14, 2022 at 09:27:04AM -0700, Dan Williams wrote:
> > > ira.weiny@ wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > The CDAT read may fail for a number of reasons but mainly it is possible
> > > > to get different parts of a valid state.  The checksum in the CDAT table
> > > > protects against this.
> > > 
> > > I don't know what "different parts of a valid state" means.
> > 
> > This text is stale but given what I know about how other entities may be
> > issuing queries without the kernel knowledge I'm not 100% sure that the data
> > read back will always be valid.
> > 
> > Regardless, this has already caught a bug in QEMU.
> > 
> > So I'm inclined to leave this check in because the checksum is there and should
> > can be validated if only to detect broken hardware.
> > 
> > I can update the commit message to clarify this.
> 
> Oh wait I thought this was the 'is valid' patch.
> 
> I can remove the retries if that was all you were concerned about.
> 

I was concerned that this patch was trying to accommodate CDAT changes
while the retrieval is running which should be obviated by not allowing
set-partition while the CDAT retrieval is running. So I want to see
single-shot CDAT retrieval underneath set-partition protection.

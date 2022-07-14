Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E6D575267
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiGNQFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiGNQFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 12:05:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3E5141E;
        Thu, 14 Jul 2022 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657814729; x=1689350729;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k798u0yCzT03GDfDNe3+zfWEEUON0cZmC4p9fS2VU68=;
  b=Ng5yU952pXpz5F/EoK95uZvIy+aGC4hW0u9v945FDAoIkI6PZPlRJipb
   4bgbFS404ovI49/YH0tnn33s7mE0FiWwBWYJV26/xvkzCWSt/nAFKsGPg
   u2CNdmaqjsOkH2RA07XWjM/0ieatR144Eu1cOBTifhgQXm0I14UUQNkU/
   5/CMhCbDXUD287xRbRGUMVtcU2DSkbyMNWHHgSuZ7soarjeDXPd2DA/jx
   1Er45y4QlvM3dSVkbDNYRtOTBpxEtl7HAOV959IEnK2EvMlerXWkJnaH4
   OoS1nSkYGo6Q5vqFJwXtnT9cT0G5kLmKKMrVdIn2sHTGPodUm7oNQf8I+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265344178"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="265344178"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="842191472"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2022 09:05:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 09:05:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 09:05:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 09:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaOht6jVG79jTt8A7mKSGV2CwcaDA/4B/oVsr12IHoun0zjqRnKW37i/ithlDLEtTgAY0l/cxSwifCrAcVUUGdAh7jPwkkSGNwArc+f8P8RvnXDzytpEHuYNJ6v7H8FL/tQFaI7s1n/j+4qS+/kHjt8/Ryp1PtPJITfitw3xkIzRhnEyOlcErC58k567/T9hHuU/faabBt2wK8EcIrMl6hJC7ndJerwJmTVdgL7tmTFQilmKfqEMVtTD1bP7xSDmWOrTaI3CuAUY+KBJkpcsjtkiV+xfbZ8uiWMCAMJlp5/9BoeLliDtscXLtl3O1ohIrpyvpQi0UPelavty9/yQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvLYkx3QpwNkvZWYrdeybObVZZ30cX/BikZ7KEYHvM8=;
 b=EZSyQySeLXRBEZqU/rLJInv2A2CucR72sH4t00ro5bvW/vqU+efdGF0uGgazB28f7x2yg8J3ZN+kDgcpRRqOFmhqgtrXDHBxOl6pJ5GPOAEzMzWOuRUTqWXLcGwmthuFvgivHW/ek8NBm5hinYrTNlY75HKO3309gb9d2QbMv1lnVT01WNPp3/C0+eVCf+3hWZOl2b+9j22eKEN9OQf3CIhRex17cMLYz0qJEtOA7hX89H6tsJpw6K8s389dfMEgTZdRxEpk6c+iIHpUnylP8RyE1XSzrWt6f/3EbMN6CBf40QNqVw/HkTOmkXM1n7Pcf7zwPgSK4K4TsN41HvA2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4777.namprd11.prod.outlook.com
 (2603:10b6:806:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 16:05:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 16:05:22 +0000
Date:   Thu, 14 Jul 2022 09:05:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V13 7/9] cxl/port: Introduce cxl_cdat_valid()
Message-ID: <62d03ec0620dd_16fb9729446@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-8-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220705154932.2141021-8-ira.weiny@intel.com>
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbab540b-10dc-4c57-a1e8-08da65b2a825
X-MS-TrafficTypeDiagnostic: SA2PR11MB4777:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzlbRJFTooCeCjK7TfjylEi/XYzYxsmJmuqPN7/5dVuF5BybqJq8EnYPbAEyGgIGIw7ejEzihGZQjjXGiSk8CQ9Qz5cGMyUCQcOWuIhh5jBTCp8htdazOYwYzubVybUbLNJREgErvZqtasFp+SINp/5mFpA+hv28rQnUQ2ZQT3nH9twkIEOoGpTy0di4gmTPbpFx3NExfbDfZLByVM8U0Zjn7hrJlLCUJ3W15hrggQtKmIR4X7L/8U3vOOEV67un749UPsxK3nWBu4ao+WTrUuEGDjQJwRstdzA5v2QVndHZIO2y9fmZQwMScIeu5PkVdXvZs43LbZw/O1fvmGudHjqtJW/nPr3fz6B0bkuvEConzKUFbRCD1/GxwTATnt1k+9IVrdpigcCTKeSvdLoTNmV4+7zEhx6EAv5j+9AK13KXvV3gy+s7Dhg+Hx2t3bUzSolLwBz8EhK+wjAuYqJ3vHGXrV4LgUwnP3QR43yfAq1TiKGRlSfQcuLWQ+epiWn7YqvnCbdON8FgaiAotleX6ZLSoQAcbQmPPQEmpbbTLu5ZgYJres4vIIRM0XvAIPdtvXNPHc2URVDpaWIwMG7tifYmqujQiTU0qxje+rDVuNaqA6Y9D/GrMe+T8tDqeA16V0kU/QtULzu5F87pZR7meUQO7QFWus56trzPakH8TqXigKXmj0PJh3WRutNGLeqXbRGtPYBIVGNxi0ZhiwLdI4m5jK8ghfFNPWsHXJ2d57/9pWa4A75Z85tlWeVShfQFGOPpeeWQk/1C31uc45B8Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(396003)(376002)(39860400002)(26005)(6486002)(8676002)(6512007)(110136005)(82960400001)(41300700001)(2906002)(86362001)(66476007)(83380400001)(5660300002)(478600001)(186003)(6506007)(54906003)(9686003)(4744005)(316002)(8936002)(38100700002)(66556008)(66946007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ck0qZk0xb6CvTr4bCyGtHcW9s4lP0MnD5YDr0F6jPNm9TnQCuY8+1yRiakRQ?=
 =?us-ascii?Q?KM6YCDUwoFSdopx+qqJ3O6e3CwaLhb65j331kpgwlbR3sEN+4529c2BBUv9L?=
 =?us-ascii?Q?avXUSRRNEt+0eBda9yXFatxYl9/wQgwKXvfT0S0mfX5HJCefPHCjT7j8PE9y?=
 =?us-ascii?Q?PcL09DDg307KdAZ6U4otOAmTVe6/rogYxkzpBnvQpwCU6tnj3l5t67+aGiSw?=
 =?us-ascii?Q?2BSYNG5n3eLOQ4sQ7I5xzv3dJmDpssVQML1BQ7hnZpfGwe7AI2EFnip4o7ep?=
 =?us-ascii?Q?jP/E0c4gROE/TehKVZOR5et4VX4GeRHKjzMQogxxLcZC8J88fRR/+7rRCjAx?=
 =?us-ascii?Q?8W42OP7xeoNi0bAbapCRJp7rmUH6uHkiPw5iC05SFBFrt4lAPiNgwhyCLoHw?=
 =?us-ascii?Q?RmG4cOg/4FBYfAlXHW72UKfWGmseCfxZZzHqMM5ibdQSVzjneoxoyuFpwbWj?=
 =?us-ascii?Q?rVD0Qc2OWHEIO37pfSFSnO9zcsT3FfXbb4CC/odhJ8TpQZCgQfPqsBz81JZK?=
 =?us-ascii?Q?vIbKVdP79HI6Tud9gaaYYu6fXyRKg7nS3DH3sm5aI3/lVXygumJZDUl+J9s2?=
 =?us-ascii?Q?V8PUw/bBMGG390L/RvLS9Vb1OvRDRfMOEsdzFPA5MbQ2ZhYSE8UfNMTgdVos?=
 =?us-ascii?Q?cjVQcohwt9AvY9nXXwxcx2RTZGeFrEGLbCY+jSw+GZqDfHBdcHfAqwFu8vV5?=
 =?us-ascii?Q?0pJVlfOgXSQCcchLJB2sX5NNwW9f2UbXFteF+lovyswblkLzCu3FfWZLd79D?=
 =?us-ascii?Q?yqlthy85cI1Rc7ptCjHyQ6CHNEjq9TQ6O2k9l1EftwF40PNOASav+MZGsGwZ?=
 =?us-ascii?Q?1uJJJ2z4OR99dlSoMBdxTn6lYXoVs8JmI0uCleL6bzTjJY3NOoMpUVh3GL3/?=
 =?us-ascii?Q?Do48vZbE+vUGVfBtC5C01nAcJoFe1/u5rT6vqtJCf1Urx5ys9n/l6nOutYtM?=
 =?us-ascii?Q?pRSJSckDjHLKV2rm8GBg/WvSUDLYlQ0gMgKtto4nmlEJP0dzf4Aizq+9gqxW?=
 =?us-ascii?Q?fwwQ8CeDSrjyESm4Ta+eqEea3I85PajkDvtqfXRWesvRlPZScbgBJ68WlmAa?=
 =?us-ascii?Q?pa1XOVb4IUS8r7xQSdl6d1T1KhEJq6fuTItIU97uQNM4dwnCdE2K32or9T0X?=
 =?us-ascii?Q?FEX5XzJ4ajk6dJUlJGNX7qiboL2ppRBKD19wvKuAZDyvBmc0MiE2NUc9oH8Y?=
 =?us-ascii?Q?mmM/0hxj7MCnxsF5RB04tCkcFDfFmE8mkg4d/XrB8R0pgsLqjUeMOVeqIuXr?=
 =?us-ascii?Q?dS/HPP5a1FHGYn/ecaLXgreZBLn415XeUR64A6uUk3EMO//5rts4DD2W8C7u?=
 =?us-ascii?Q?ytiaHitM3CUQPDUpVAaYNQxOOu+o+AjQOIDi+vrjku48Gd9lS3EJcf/N9kNS?=
 =?us-ascii?Q?5Ft3LIcZDAzXZC97JS1Y7qzIC5Ms2E4UyPzXYHmOV8iry5D9a3ItAhY4D0IP?=
 =?us-ascii?Q?CB4FfV8mTwMg5/RqM4belyoGMRKMh78kn0Fe2GvXKzvXkfW+Vm7XNEsfumBM?=
 =?us-ascii?Q?v0FKzgqTHRm5p/vrosHISj9O+OpLNpO0X3TS5dm2j2mI2XBPM9deqqWrb5Hv?=
 =?us-ascii?Q?LjCiNH279M1IKssdfFzoc2cVpAdG40daCIIzBzZWAo2ajysq5eui/flf62gO?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbab540b-10dc-4c57-a1e8-08da65b2a825
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 16:05:22.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMlBlj+wDIuvUBlxndE02ancgK/PsuAdBmn5TT1qEsIt8dR+yRmo64X1ulG/UgUMTfczSA+bWj5Ecog9yN1+aO7fGWXK6lMI9MY9rqWfD5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT data is protected by a checksum and should be the proper
> length.
> 
> Introduce cxl_cdat_valid() to validate the data.  While at it check and
> store the sequence number.

The acpi table parsing helpers already do this style of validation for
ACPI-table-like data-structures. So this comes for free once those are
used for parsing and I think this patch can be dropped for now.

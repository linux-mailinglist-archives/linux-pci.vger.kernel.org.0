Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86C1576B4D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 04:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiGPC0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 22:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGPC0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 22:26:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ACC62A69;
        Fri, 15 Jul 2022 19:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657938368; x=1689474368;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qNxcWcw+JBZE+DJOAEXQcSJRqLz+F7FdAmbabeyv4RA=;
  b=g4+kcYTsIV7q8otUXs3LF83RcWuCQcVv4GJ8pozRd5ouWBxtqvSwuGUx
   tCgf5Lt+IkgypWdWxpBrCNNcO2hsL1Yj+AecqXk+uwQc/7FGJr8P/8cn9
   7ByFVNQUyFNo16H2nyzzXXSxJDloqEWsajNObKRGGoTCIEqnNZSyzH8OK
   AwagOlfN7/N3WeQ84p9myPKqHanhbMQpvIa6dbS6ilAfTLmR8j/tumiv1
   +ak2VMtYSrXk3aDcJc+009GlcUuMzR5lKAopAK4GQnCiY6ufyJogn0r6V
   YFNNh5vnxhhxOfaprOoJIQcbO/eKBJHcLwsRbCvdhDy+N36BC+0E5iC9k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="287077505"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="287077505"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 19:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="923730564"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2022 19:26:07 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 19:26:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 19:26:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Jul 2022 19:26:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Jul 2022 19:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPhY5jGp7xBz5RoMQkqSeigyqeT9c9b29riF6Fe3k6KKDW3jo7m8LLwgTLCxJ4Dg7HCkGdJZCl/fvForIksUz2TSFvD/bCauL9zwpSbRDAkTzpfMe0aN9qkzPkFNy2CGMUS22qeUgz86M78CDGWH1+RuANF4P8i/2Wvn4scAhCqLOk5BrnNZL3+qRjHDSJLTJPdhhgUJOqtuKPvJQyWWx2BEwP0Mkmlof/x1PgtyRg0DIAajQzWpyJRIhLZvkTU0OmRBoK3rTIQmc5ImOfm6wH9wubLABx4fI/aRJ3PRU7/s+HVxh0hCYcUvysOiPOFAmSLk+daluPxa+H+OoLM2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4By8Hdg/W0f5y9VOvnxIwl2cAQZS369s3lz3DuKkE0=;
 b=flSrzQgwTOspKqbmE9VHmpjJtlFaSiaSC6NNyIQU00kRiFMBIeigbrVDNUIAQiuXdCOB+WMWhv47dz3fbE97y3I/Ig75iQAhLHdz7lKiXddWLOQ09BHwfOegFiFzjcz3k4Klotj5S68XNbcxtag8UzjUnGJdDJno0EQQ3SxHhYINj75T6bg+ygsfNY50WXjOJOhQGKdEUnK4W7/Ir2y/CPsSPe2plIWk8LYoxFqBVJBjLtOX5uxod6ts2aTmfLpNgEOSMNBAjzK0HTmudbj8r0ieVZt1g0VDhU53TbjXg1mPBAeAbVMg0iRAOgXwNu8aN3q95s2iZudsacRZ5SpxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4988.namprd11.prod.outlook.com
 (2603:10b6:806:f8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Sat, 16 Jul
 2022 02:26:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.018; Sat, 16 Jul
 2022 02:26:04 +0000
Date:   Fri, 15 Jul 2022 19:26:01 -0700
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
Subject: RE: [PATCH V14 7/7] cxl/port: Introduce cxl_cdat_valid()
Message-ID: <62d221b999ece_242d29476@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220715030424.462963-1-ira.weiny@intel.com>
 <20220715030424.462963-8-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220715030424.462963-8-ira.weiny@intel.com>
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9104b4ed-66cc-48af-a750-08da66d2881c
X-MS-TrafficTypeDiagnostic: SA2PR11MB4988:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQa8lurMZOdUqlTNkhiZeiWhkMS08OlFN/D9gvxR9hp05QweTqYCukDWHal0MOdm7Qd8cax72HJ1P5CxYotIo7Uw5ZUEyfOZRA+taHpT2ojjI0frwXGaPM4BKx1euKG8Vi5LwiDdlpRo7g4Q1AqnhZA5jW6wnLIkUnciW9AzhDuQbGCesyJoPbZPD6YiXHVSlSowotRNGZee1XQdaOEh+n698x4/WvYXZBj5LJvejGWbbE5kp2qFFIoUCkQcXBT4HLtXu+CPa6vNrNrl9kHXXTmiw8h7RjcCvtfFoupBU1uOSLGYtNQQlYNQVNTDP++hWFB/9/6FzwnYkdzAdcxtLkfABaUwEe2hgu9VJXOPPrOp5XnntMHmgojHIhf1c6gS560EfpTlsT4QurVoUZQMsLe/JoAC9kdTPeIxiASj4w2FWQWwTBJjTtxZJPXIy0Xxp6p4F+w9HPbknaCg80WkvhgnxhugjELq2sr/NJKzKs1ATmIwT3r5EujInLF1MIcg38Jkq//b3GK4lTz1EsijK1LAS2RcC3ubYYSvxICwDFSDHTQZGAH0l4LQ+YfvXZ8Uh+y3IqmlI81lJKewGnY7/9RiDXPuAdPc9+U1lI4EcNsZUpcNCLzBW48JWaoFf4PNHl/K1vq4yam2dGItpYh9U48kzBmS3kSdc/S1jkhATxqYvVpdzGV8uqWMXC0KgcxQFIqDtnN5S+CxQNi6oNHFY7nhyclpsVhwHMZQhedrGwnkInNT+9Cu1jR2CGwLnzBwAi1PZpaXD6g9BnhffW4Qkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(366004)(39860400002)(2906002)(5660300002)(8936002)(66556008)(66476007)(66946007)(316002)(110136005)(4326008)(41300700001)(54906003)(478600001)(8676002)(6486002)(6666004)(186003)(9686003)(83380400001)(86362001)(26005)(6512007)(6506007)(4744005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/LXYHgOCXhN8c6eIQtNdskmkgA29VlSFYIx4EP+eGH7z9HG7qqD20u4DurQ?=
 =?us-ascii?Q?+n0Nbz1KtuwFIlUkxuKtLK86DqPbXC3XASEfGt1cajB9mWtPVz1jonPStFra?=
 =?us-ascii?Q?UVh9zXZX7ed+dWTyAsTGC9sQcJBV0xVysASa5bDHpXl5Sae1kOoAnTj+WJ7A?=
 =?us-ascii?Q?XzVSZFP2qAs0cYxMUAFCnhg/xzjCWQ7pgde2LANZPbo9GDH3sPg9Mo0ztF7X?=
 =?us-ascii?Q?G14xHyP7bIO34cW1gEEjcmSCR1bh3kWEXp7UpbUidjpmUt3+V1+7eC9AYEMV?=
 =?us-ascii?Q?K8Ef4uIS08MyRFCGh3zCVneuCISaopbhjXrkllzZFNt4ttOZbGAce+XtQIoC?=
 =?us-ascii?Q?Y2nbFXM4oAhWZHOlfdGWxdVXZ4dfr2oi4QgtlslM7QMBTP4C4H2glMzjS3cc?=
 =?us-ascii?Q?pWg4Gc435lzkVAgnk5WRDNaA8Dn/1sGPz0Fa9/bz2ChmbUUwujOcCOd2xbYC?=
 =?us-ascii?Q?+OpLd6kYl8monkmc2ni8hL7fnFMDHhMdXr+WgyT+YIZVgUawQOTvoRLSiaJm?=
 =?us-ascii?Q?RMKBq3iPMIw9qwFXkcBNsW6z3aoi0uUUyj3NhpVYEkeSbwpHX1EohrZuO6Qm?=
 =?us-ascii?Q?ik2lExsGs+KhWI+aulMSGMdbfnddn8Ora6lxbYF0cmUHFUs3RgRbVAnKkM/7?=
 =?us-ascii?Q?xT+cR8UueUuMROPJJAzV8cc7II4gOT51a/clDJ6TYd+aLgs5LOPmBvMVK5HW?=
 =?us-ascii?Q?9hHC4B7QSYlHMN7cYYVVGkdv1g2gTj3p+3ns8elTX3FSJdHGRZlVPYhBy8zo?=
 =?us-ascii?Q?KMR/bKRx1csCLuHTc4yGdTEa9FDQasbDuuDC0x+W9FxDBOKWnMgaxyjK49t6?=
 =?us-ascii?Q?yZMvFjHkz0LirkidBtWVc9xHNhBbZCY+B5F4N3ztNH2J9FYEZsj6KqTCjMfx?=
 =?us-ascii?Q?eA0Q6P+dYBuE+7tSMeG35Ja3f2j5r/AP64ivPZxOG6zVJe0/58BCVtg6Unml?=
 =?us-ascii?Q?6t2y2OkO6DP/Jq0WUSS5LvTJ9cdsCAiP/KGbJxBK5LF2Km2UgH8rCqtX2aXz?=
 =?us-ascii?Q?D1pIpLkrQ0guS/V4V3/n5ozh+dboCjUFypGBOpKH8A6hL9hhQUzW29cecLy/?=
 =?us-ascii?Q?PbH+Do4OoE3lBRxJuchISZ7P/WN8PZ1C3u8Ac+N8TueLvcDbKtqmLIHXHc8C?=
 =?us-ascii?Q?iqFomKfb/I0Hk/q3H0DuSl+RjbNi8ndcIQI/9h/WhD2G3NhjwzIeALJiGL7M?=
 =?us-ascii?Q?fiCzU/h+eybGfYstApaineZe/wtFyH4t8G63/paCiwoBrIHtSgVS5fURThsI?=
 =?us-ascii?Q?CesYBfK8Jl06/9qJfpqyXSHl6XDz/TjTl+qWGsmY33TvIIvqYt/Wl4HU1Qmg?=
 =?us-ascii?Q?5lyaOp1mwNTtgn2j9EGMhihzoyfWw1jCdAjMeibOmu+QCM4IhrtYJcdRkdBD?=
 =?us-ascii?Q?N0NSy5sER8MyCnPdDxtBAWhq9NkHFcRusIdRjOBOwU2k7GF/DLRDo7ebWgtM?=
 =?us-ascii?Q?FA6neiKgfXj4jUV9ZxqkKt3g0qVBVgRrFxlZ9DCnXQ5SRiAegzgSmA2l2ys7?=
 =?us-ascii?Q?+4duEeFeg4R6nHkt4NHUjMbv+3/zBC9fVrt6ihk9/NG84F5Y36G+4uHZNK39?=
 =?us-ascii?Q?b5YS3NCRZNBkS9GGTJAw3PwmqWqJVu0TmsRO569++/3HkWcCIbQ3gx2bwwuU?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9104b4ed-66cc-48af-a750-08da66d2881c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 02:26:04.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4Y3BI8UYvN0NdI6DT7Y3I/jKMY5g62URSSww3Z+t305vhtZtu24NB7zS5CT4wwRQilcWpaIIxGPOzH/7Q0yw9B5s9sQyMeFc1YhPnQGIVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

I am going to drop this one. Userspace can determine validity when it
parses it. When the kernel grows a CDAT parser it will rely on the
standard validation of ACPI-table-like structures from a future
__acpi_table_parse_entries() derivative for this purpose.

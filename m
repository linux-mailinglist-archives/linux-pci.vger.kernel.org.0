Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74537737B0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 05:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjHHDZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 23:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjHHDY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 23:24:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B0A8;
        Mon,  7 Aug 2023 20:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691464965; x=1723000965;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QQkpMx9IHz1ow+JZBx7UGg/LEemKsHh2B57j+1Yf76Q=;
  b=g5cCU5gqmH451DfOHu1U9Mz36DJyQb7AMcDRRa1nrVoKZFlBYDCLEjSM
   WDFx8fsa6X185/5INXUXJjzCGeF9pR3zcBH6Zs3TIwRM+i3JR9994w83Q
   jiUP1CkxFfeIdru7Fkd2Ls5bg4uV7I+JmjrlRug5fwr0QGM0ohxBjUKm+
   n02jqL8Xns9B7GWUF7IZFqais66c7wTSbkbPsvLGGHPCldR0ngZ73b0do
   ygtE6SGT+jxDlEWLx59F9vDzDJt5J7GzVCUxvD1uejUxWSnklfD1/446s
   Bmtth5JQpZIkZM20AcZueUmXmBkiZj7IHsE96lS1HFF3dE9w1HbGRhi0q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360797163"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="360797163"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 20:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977700522"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977700522"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2023 20:22:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:22:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:22:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 20:22:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 20:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om2EwwxqWzBptiQ53nAGW2iaecwQhIwRBtZfY57iJq/ZKFvAZCfshRbn2IbiaujATyQvlHDSL4aPqmZjxDaiaWlUQh3RuUyJX4/kbDQGv1Blsc9h3pzPjototesx1eKiozsN4BV92XT0cEut/6gIN6HXiehPgDUWp0L8LuNEZeN8Ugs/9h2cKw11FTHaoTFajnEjPBSVEZ4COyX6DochjhJARZvYb6FDETjNtslJXP0XxQRJKkFzII2IEVmQuTfbY4ukB4x4eWeTDA+5/CRMtYhfx14CkVsumMyHluFYLEtgeUqDDkl3vFlCMLppFfLJdDRFcfJkWeRWLeAn/jomGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FF1PsZTHcfK4La0U2jihdS+stQpJTSISQRwCpiyH7E=;
 b=lmzfm4LO0VOG6Ogf+q9OUjVD5zqj+Q9bcHvZeEVQHwunvr2ayZ4R5m88OsmPMXToPFl0AUDhP7kaBNGf5hcj1uKKuwHz0Q45RV9c6bmbAB2ONs32Hw55ZCBg/Dwk1vOhY2BY+PYWCgynGguo0n1/wG1DYSW4xIuznLLEk4BbRWeOLzb/AVvExVv/x86m/CGzuyUgvhP0FCJN5LTohlYJYgZnFkj6XZHLFrsHC5XxJgbvkcvb+LWL3x9K9+7VxpA1cJDdPwsPV1Bhewt4vFLStgZAF+ySP5cleXIYS9zW3cWapF0LWPPNdHgxxyTsA5KhKKFmQzffCMyr3HVz/Z54fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 03:22:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 03:22:22 +0000
Date:   Mon, 7 Aug 2023 20:22:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v2 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Message-ID: <64d1b4eb4d991_5ea6e29427@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
 <0e4dc46f-a086-8b85-f94f-b3530d958209@linux.intel.com>
 <64da6d98-953f-f813-7184-e69b1c8bb28e@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64da6d98-953f-f813-7184-e69b1c8bb28e@amd.com>
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8a4664-abeb-42ca-9761-08db97beae50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PN9UFpEFuqf1sv/QpP+qnu1r4nKgSppSUUKla+sTHrIuLYIDy609c62xE58n+QgTbEMzhQwRbY7gohNRo0mU+08ZAjO3ynin1g1g9by6YWoezz8ANYBtA3RyZIli921/xSJm4C1vg0UwpCwqMWAUmiwDcDaJbmIm+gMGJkEoHu3JqU99DzMFMCMvKBycteX0wDmBRI5gC9PcKm+B4s0X5Izx99p8hdWdgpP52tgOv9ZRuttpy2I1y9meXFlBvOnfNqfMos1niRXA5cLbdVzRgmIA1Iz5gEDfBX0/4TXeM9pWkCkO8e41UqGJbVf6RPCeMEmASZS0CqkDKaS+CH8G0HjUxH82SV1OB/+WSsO7aPMj5WFrG1OVc5S9p/ZHOeXR359o0kMQIGCLDSapQ5SR0U8Q57BJqwJpn0Ticv0e6MHqFdgakZYBJVIJAT8vR/ulViSXd7rYIt4mLoxJc525eM8DMSe3epMXEwMA0f+kw1VW30i4TDWmFIXAGiCmRl8dkAQVBvxqeiLFNXZigwvDzuOWlNRZQVAZWT9f7Zheou+7TEdt8Y/WWmbSn9MGfUEHvOmA0XSsyJopJBFKhqc1pImMwYPxExWw++GPRKZNLGT6W3FyIQf6RbgS30N/p2e83XCXU/Eb1LRQnC2nMuThNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(90011799007)(186006)(1800799003)(90021799007)(451199021)(41300700001)(26005)(2906002)(5660300002)(83380400001)(7416002)(8676002)(4744005)(8936002)(86362001)(316002)(6506007)(6486002)(110136005)(38100700002)(54906003)(82960400001)(478600001)(66476007)(66556008)(6666004)(66946007)(9686003)(6512007)(966005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8AAW+Wmdx57uvXcVdpkJCp1OHG6IRap9U4cmqucGVMRAWwuwY6oal67d2ei7?=
 =?us-ascii?Q?O6q+wEzPIAK0ERJE+eSHgOv5jr3ANAZjoGYXXQEkG9lRc/cYA31oGPkWv1u7?=
 =?us-ascii?Q?taUZySm06FPFNVuKjyJCYmEXFNeYNiJF/LLP7asu73hxiccA6Lud1ah25mdu?=
 =?us-ascii?Q?6aXK7cFgelfQEhkA48b4vt3zhfLX7EVlo7SqxTglq/nQ0V3FvWeeqT3sLF1B?=
 =?us-ascii?Q?2EnAerBzQ1buP6mbpf47fKDZWRDsaucWCORNhwYPrkwSEcEPq4NSN/GhtrCT?=
 =?us-ascii?Q?e3CAK+OpueOZZ1Hk7nLAqfe1IeGabImbGswpXAfUZtpqyUsjwJEL7DIyoXOf?=
 =?us-ascii?Q?JryWlFxgZ+7enOSjBdyKS/9koEUv/ZKlTJIiU260jYUojAG1Fr+51uG8mKMI?=
 =?us-ascii?Q?E0WmuUubjhpg3/3LsQFG7EToy7WQ/raIt+b+DaZRaZ0EW9klunCum+re2gLU?=
 =?us-ascii?Q?9d2DkPx8YZgt5LGjccO55yiZ3OhEmEoyBQkgb4Z7r1LJJf76isl2w2+MYqzE?=
 =?us-ascii?Q?VgpH/gZDQ2dyl2Xh0zvuGdkXwf1LSXuqCv1eAn1cb1ltDvDmmBFYy8GME8qq?=
 =?us-ascii?Q?gvlTtyVdo+puaRnrgFkK33Jzj83k3S6vwQ1uFTBaAHbD71ECq1iD128Fu+Sj?=
 =?us-ascii?Q?OX2wZr0phAEyrE3LoJZajohdkZ2CqWHWXZoexoubgi8BeQnwt2yPIOKzS+XE?=
 =?us-ascii?Q?+gnoaaUVJUAECP9hZzD85DVUUnAVDQcL8g5662qNB7b+iZ5YTYcdMlZeTejV?=
 =?us-ascii?Q?pZBvdu9FN3dA+yYCqk7H/njUCkPiDJrShg490HUwC3tLLJspRpX9TU6lXgh2?=
 =?us-ascii?Q?MLXMrU4mTZCLijtAGNm+qlrWjbGPRKajXvRzK1TQCik7SY8/6T55zE30/hNk?=
 =?us-ascii?Q?6sbvLjUAHL3jjJ3PRFxG4JH5P2s06YmYEa/qkGmyj3k1NJWmvK5/yhMXEkZU?=
 =?us-ascii?Q?p7sF+xfYn1/vbVBFu5vTXXh4MisD9o3deyFLaOsN43yq8AS+5ipmgZyITJjS?=
 =?us-ascii?Q?meHyc286UM3XjxGJfuXgiQUZLisL8hqxK5a9LZzqwF8PuKQAWl4iIPpoxar8?=
 =?us-ascii?Q?Mv8FPi2LZCP9HqLVGwzMSyq2SmeXEQDJNnxvkDlL3GEqs/8mRVyAcVclGCih?=
 =?us-ascii?Q?3TC7AvRuGqAcAYodeEOCI8y247mmD4jWo8JtCOC8VqnTW5RuxVEfL5f3hzKn?=
 =?us-ascii?Q?KavzDE4fylUzvnhK5avWqZZGJwVAImUfeJIzzUQJ3/4R5zQhihez6rFpVM9W?=
 =?us-ascii?Q?Duoq1ZxhHWuJ+Ho5LcrzPB3BkswhR2PD4uSEbE7iaOsYaENDAhGNEU/rao3/?=
 =?us-ascii?Q?9HjprPE7/lXHp5yRRPIbzywp0SHn44gLy2bbrJWJUm6ZOS5y/+pKGf8xA0Qr?=
 =?us-ascii?Q?5dJaTjISLkKrJEWUqZ69GuOi5tF/8aNZt2aCahI8PLfU6GU34OYHXpBmLfOM?=
 =?us-ascii?Q?w1UyR32LmC7RKJsCuxEhE3S7hnDt8tbHp3L3AUuq9tFgylFA4IyXtvUpYOel?=
 =?us-ascii?Q?80G4lKIBd5/YEvTzTuQYIuy8MPZ66oNyPaY+5TiOLeXAspIFb7q/CJc4K158?=
 =?us-ascii?Q?/3n0J+/cceFpY1lbFQSLA0PwmhG4ojv+qOdzeLD/3grK+2MpjAhQ5fSu22Je?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8a4664-abeb-42ca-9761-08db97beae50
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 03:22:22.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJfUZr+6zHgK/e9X47+JAhvWHfl3HiYIDypPIPKB9NyD7rr+Umt/eANNhB1JuEWOt/ZvfNu7+f/PqtzrFOx+404WTaLnxUoC72O2MvPP6/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Smita Koralahalli wrote:
> 
> >> -	/* BIOS has CXL error control */
> >> -	if (!host_bridge->native_cxl_error)
> >> -		return -ENXIO;
> >> +	/* BIOS has PCIe AER error control */
> >> +	if (!host_bridge->native_aer)
> >> +		return 0;
> > 
> > Why not directly use pcie_aer_is_native() here?
> Yeah, this was in my v1. But changed as per Robert's comments, to be 
> applicable for automated backports..
> 
> https://lore.kernel.org/all/ZLkxiZv3lWfazwVH@rric.localdomain/
> 
> Please advice.

Keep it the way you have it. Minimizing the backport is the right call.

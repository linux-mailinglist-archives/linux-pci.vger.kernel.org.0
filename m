Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51369709B29
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjESPV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjESPV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 11:21:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15677106;
        Fri, 19 May 2023 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684509685; x=1716045685;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LGTVZSIzvpsM3umkfnr6bnPtiqUPYRg0F4cDLgoviHU=;
  b=dxnAhyoo7evpThFKqDfWbDnw3mhTNYmMfGBz8ds2Wnw6NVf9t9hLfuN+
   gK2Vhhmspi1wdzqmuE7uNWZaQzzdmDklsO07Fi5fIPe5bDizoK2H1Hrzi
   4L4qGTp6/Ey90E8K6tMYoD5/NV3mgaSk7EruC3edrQRsR7vZUvm0nT+t/
   5+OSTEJ4eqEKeqOd8kjOoDD720jsYktZOea7S71yWhhffpcT9TWbzHDlb
   SBovYS9mYFp643bYq0vOlmckGqodI07fnM7uPI+dwCPd+QBop0atNRUtx
   Xw2BlmtcaXebx7wGhszy5v4lTgLASrrRlScYYUZU2I43cHu2jfQ99TtGu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="351242727"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="351242727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 08:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="767648943"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="767648943"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 19 May 2023 08:21:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 08:21:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 08:21:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 08:21:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 08:21:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYtHsVlYyUTYHSzKsLgxPA86zfivEHb5h+Xgq/yxOED1Hdo3xmYrhMwEIHJTxaier9EahsOyuGFIfTAjkH5pRh/OX4nOb/FEnky5PxTuEJQcobAfLTP2R+EBWmbSq3QL2L53s9ldm9C1jWVnz32KT6Tz2dRjaEhl4iGq/8dhvJQpKxYd7uYUZTeLaHB0KlnPkBJuKeqfSl1bpL7xBdooRUud4Ag3OFhwzz2tEZjGexyce4q1gPj5c2ziu5U5b63JdVU11qQQpC8MrPs2iE+3br/gQh0v8yCjwYpUizz6jMNGAVnKU8QqeGY8+02N4ekoCjXMLCrwzvqrh7iZEuL8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/NkN8u7J5PkjAbXJKBi07Ov12y+cR8OcMr65JLLwYU=;
 b=l2t5+YbEclO0h4NDmczmSUSOJ6MiR1VUtO3vxVJnFZ+0KxQDWmcc8QbMdB9r7GIzQqJPeW9Qr3OpJs553O2qlcsBHDO6bqOOpzkKQFdp9qJ+fin/d28ySEOCzNQ0J6ZPzqe1OQNmRT8AyhniOdqrWLTKRd+rl2LqzPyr4fkBTCBiDmgg2dhaFCLraOFlpkdbExDWSCdjk4sa+fpiHbxyRcyLTdaRoMxQDQEiZCjDNNPU+kBFDlzjs08Q5B3Tn+11CikZ1XONiiEb0/ib/j6/DengcIJcLC36utW7tim9tXoOCNLbDnb9QV75ecOqI4hAKAZoP4uIZE19/1WmBfFmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 15:20:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 15:20:57 +0000
Date:   Fri, 19 May 2023 08:20:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, LiuLele <liu.lele@qq.com>
CC:     <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <alison.schofield@intel.com>, <bhelgaas@google.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <helgaas@kernel.org>, <ira.weiny@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <rostedt@goodmis.org>, <vishal.l.verma@intel.com>
Subject: Re: CXL memory device not created correctly
Message-ID: <646793cc665bf_1231462943c@iweiny-mobl.notmuch>
References: <cec6a8f5-a284-4f46-1ada-4edd625a9a2e@intel.com>
 <tencent_D9D9D358330CA573E23D490C6EE13E0DC105@qq.com>
 <gbsxrcjtnf67jxpqmbn57nqoslpmjtuk2ycatmau3vfsmpvbrd@c2umpofn2hti>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <gbsxrcjtnf67jxpqmbn57nqoslpmjtuk2ycatmau3vfsmpvbrd@c2umpofn2hti>
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ddf5c8e-077e-440e-08ac-08db587ca52d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fMKDLuWRbCXXjIGETxup+LPEJwzDmUPr/a53m/KnLSOAvcLJdyqUPYlxE61n5xGjuTXn09Ym6GpH5UJ2Js9/dH+fL8UAVHU+yojTMmlAXIRCnOTK4C86YM5eRTKcY+vG2PoVoS3EPVmVzFhozrgJPomR11CBzxqB7MgjBeQZpLtCOSrV9PE5dZlMhQlf5SNXUv0D/+gRcyY1FpzsMIPbL1qb4RDtTCL5JbnC21YZ7W8fpmtaRuu/NUv3ZFhLRxhQTACBetGjP8BP0x/DOHhMK2CuSf0aGQ/8vwpZVgleSWjRCg1WBLqS8BWQkgStzbjYPZgh4fTCG3p2EjZpQKTXZrPzaC2YPDlvlqmxE1ON4+G6p4MAlu8f0jtNuhKeZ8RghDdXF8VO+48dKMoK6gmpNhprAbNCZU46bxWf5dUYXJO7jVokAknr6wOC2StdOF9wgz6znYBCndA5szj+QSp7bSXZQyQEfHtVKWCyX55pANm/E40oSBlmRCnY2L1SmoNR0yJrliW6/ImupCGe3V96V3qOhpONnCfq4z2M8RYQDtmY/knOQisjrwHocHIBn+6h8NVFZGF8TtjkVaXw5Yy1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(86362001)(83380400001)(82960400001)(41300700001)(38100700002)(5660300002)(7416002)(66556008)(316002)(66946007)(8676002)(2906002)(4326008)(66476007)(966005)(186003)(44832011)(9686003)(6512007)(26005)(8936002)(107886003)(110136005)(478600001)(6666004)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mpa5/pWvpUdTBECpu/VyeccsXmPue9tdW9sclhY9WcyMEqL4uUGaoTu9vG6L?=
 =?us-ascii?Q?QS4pivYZKK5xToqPIBXsRSByRrcKjLpzVKXgDWeX2G1zVKeGP+KNpuM/MZ2d?=
 =?us-ascii?Q?xXY9imeRzj/gfv8qT1/CC0lqr/Nevpp4yYxfKLyQoCCVZKN2bzPo20MjDJXm?=
 =?us-ascii?Q?NWmHjU3FMheG1B2pSq8ytV+dcOxqbTa1lprTmRrK2FTjfltF0YpaV9iCIHZf?=
 =?us-ascii?Q?yzYmu9dW5GwTx3xniu6zrl3Q2+wRJEODbz8msZOQ/SpUdB5yddBMmAVW/tYX?=
 =?us-ascii?Q?PAmx4YGAQ7WqgjsiQZGdxkdNq0cdBcI3DWW1Ye2LO7mdsU7K7k23nPCyYPNg?=
 =?us-ascii?Q?bHLOiM87M3ZfA93anTeLBU8iVV72jASJa0HxRBPSWR4a9OINPUxnrrP4Nos3?=
 =?us-ascii?Q?ChKfU1d4hSsK5lONTxxkbfjrOVj4YLU9aLqPXA1ycHv3U96xAd5XXb63QEYF?=
 =?us-ascii?Q?iLsGcZ2oWNkvUK9AOf699aFMxvzBnsKP5NtmzXWNIDaLhbjUtuV1pMiQ3nEk?=
 =?us-ascii?Q?VH9YuGVaIbCANxZo4hyqmuSmgj53EzbDwuKtRKmN+RCt1Afun4J723Pec0Tw?=
 =?us-ascii?Q?cnOusEHE5dlPD2I6Pz6YcY7G3sntorN7qhKF96m94zDmxT/2RaPuPtRR0EhO?=
 =?us-ascii?Q?tWUIVzTdjU0eW0mQjVgTTcJOpFFMTo6JV454PtcCoH3gU2Qi37R2Fyh8kCoV?=
 =?us-ascii?Q?MNer+vEJ1o+VQv/vAVjtUduzMGoGEg8bvoSMhwTtb+4jPqNktpXYCLbcFfYM?=
 =?us-ascii?Q?Ko8x7d/0nb6+sF0PUj0Ha7yDgPFvnD6WcitJu8G0D6Nry/oZf0lj2aQYLsOD?=
 =?us-ascii?Q?o2Ko680Hp+Ojh/2+z17LbFoNB3GBfdOy1+NnOgljeGsLHmO5zCqmtAAJPwE+?=
 =?us-ascii?Q?lFOL8HLknjNyg/fTf/E8lTLtAqgUoCd9zQ6OVsgMoPq26vVMkCUmWwqjumqx?=
 =?us-ascii?Q?fht4YkJPB3WMakCuVexcIyaLeXHnBsDHaK6U8Ke/dhdxgGdsTcCdalYVOX2a?=
 =?us-ascii?Q?L00pn7t6+0AISe+bBqJZn7ExQQW8CZGWeVK8yDRqoiQ8Uz1EDRFHBVCyNk+W?=
 =?us-ascii?Q?xEaTeDZnSjMBVaP3q1Eg4ywNs+CO75Qonmij05MgZmUlOM2Bi0BEvg5MgoUk?=
 =?us-ascii?Q?lSwTGeyHk+8xaPRx4wkvUlGi7bJq4UcwHnOdnOzgeXmdivtN/VF+YNB4pRpr?=
 =?us-ascii?Q?45WP/kkwapnCXMBm9vYG4xhFeg0dYgvMuVGip2UgkcWs53glyZSvbtvq51qg?=
 =?us-ascii?Q?ZxBpIpLBEfAYgvd3XywzSxbWAOyNZ8vMQG2GE6Xvvz0rdJfzYwx+K40aiN2V?=
 =?us-ascii?Q?jmT5FmphIUgLlWnfUxk3KOrbRnSXR/AQi1pu83JvmQ+tEpef/v+CiOahuG2b?=
 =?us-ascii?Q?eqR3SLB1Iyi5B5ilvII+iRnL2J15mkZA87VPrRbNd2CFdNX43SeMSU53mmCA?=
 =?us-ascii?Q?/TFexYVLu/nhVv9br7VMNPGKMh8dPDGR3XotpVE00c7/6WuwpTeynRPk1fXk?=
 =?us-ascii?Q?sOrziVAxKbHHTuJQX5ReU8xQatXPg9Jd3as3TjwhgTGBVKykmTmMHY6JuAWC?=
 =?us-ascii?Q?FiLVgNKi2GgelaxWO5QqphGM12ECdobudEmfu8Vc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddf5c8e-077e-440e-08ac-08db587ca52d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 15:20:57.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ILW+HP7kTFWxAw8sVQo8B0KbGBgmy/WE9gkAOIPs3Pgr+rgmMJi4ahzfI08JzauLL4qttdYCIE0s1GmRZZSLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Davidlohr Bueso wrote:
> On Fri, 19 May 2023, LiuLele wrote:
> 
> >In my testing CXL device /sys/bus/cxl/devices/mem0  not created, and the get error messages :
> >
> >```
> >cxl_pci 0000:0d:00.0: Failed to get interrupt for event Info log
> >```
> >
> >My test environment is a qemu CXL emulator with qemu v8.0.0, Linux kernel v6.3.0.
> >While with kernel 5.9.13,  /sys/bus/cxl/devices/mem0  can be created.
> 
> Yes, this can be annoying and would argue the probe should not error out.

I had to double check.  Events are mandatory on devices.  On checking
again interrupt support is mandatory as well.  So that is why I errored
out here.  With real HW this should not be an issue.

> Regardless, the actual qemu support is in Jonathan's tree:
> 
> https://gitlab.com/jic23/qemu/-/commit/a04e6476df363d1f6bc160577b30dda6564d3f67

That is the commit you need but it is probably best to use one of
Jonathans 'official' branches.  Looks like he just pushed a new one today.

https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-19

I've not run that one yet.  So if you have issues try his previous one it
is working well for me.

https://gitlab.com/jic23/qemu/-/tree/cxl-2023-04-19

Ira

> 
> Thanks,
> Davidlohr



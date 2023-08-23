Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA5C785A34
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjHWOQN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 10:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjHWOQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 10:16:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1D10CB;
        Wed, 23 Aug 2023 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692800164; x=1724336164;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=OiydVkb0icIAH0X+rLIqIkvYODPMhX1t6mFGkX9l9r0=;
  b=oIz5oX4OKsWQClvBYRxf40hjJVzXn0Gwd2Cm6ntB4xYkDQVhJ4GRbTlA
   lyoptnZkLVxF0parjMqUBCpE8Q86+IfKdSf3DpNmUIG9IH7QOTQwUt1Bb
   Juafi5VH4LqDBP+ECBZljKEc3K5YiuXawN+yjkjhWwjk0U+AXpEnesIMM
   r2UDnimvTPjI3BsjNnVo1kFgr/QogoNeL4JVxhxggDf/sL/ihY3+CYP0X
   TkU/PC8BFZNwEDqu7fIJ5Ift4BHRBzHaBVi9l9nn9DW4A7Ee4JwLxsJpS
   AiaaNP7yo8SQnFbzBhsajOTEfsSu3QSxGrqAQB6/Tz6lQxjovbyMh6346
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="440529899"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="440529899"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 07:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="806706373"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="806706373"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2023 07:16:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 07:16:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 07:16:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 07:16:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 07:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z06tXtm0T1O72X6iZ4wpBeZwMWbo8F80RluKA9zL3c96LVTKYZU3iodJHsqrHxftjD9LoTZ/rZi2JC/7DMzbxeRAgE1qEP2kTNlO/OGn1f2TQRavCTyEbEe3jzJsqeBXeAskI2eJKsJ32YmQ2FHXczTTQKRr4CQMnfvN9jSb0RGSgPSZOkW0OYC5wV6gtmMI5JhVeiIx/VHqySTWp8mlA0ZTxsv1pQ/AuWRdlDBV+XIeIWGBJx0qTeN2ar8CM7n5B7P2P74aEi30X/hnm2i4gcKcY2U40gWj0s+ynrM7oM8BPExivllj9UgVS9L2MvyYB51xrUQMqpai3qOs5oOmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdYNYd5PyBvgACL3kypuE13fiVf7EGakiKav83Ytwb8=;
 b=cU9xeHSEqHUwvMFNy6klpG4VH6SvpjPtr0SVABHP6o/uQCgX4qJ/1DNv53Phs/YxLZLQtkjYxiWFA2scWgtzyfz9QhxryNYtc7e77ArXGbszB5Vx1Txu2+ESRnG+FginoGF19F1bhJXB858vLXn4VfqWFKu13t6BH55DEO9PT65aFdNNgH4U4YbUNopWZTPXgOKItmwUEqOgsJiverPAUhCMYxK7Z0YJaewAHLsLu3/RhMCjPnItyR9q4whcdmlm8+/kX6UuNZW64bQvPNr/qHzS+pNq+u3vNFMSfEIvTjTlQ9sJyUSCnUWjhn9wdu0uJCihRJ9cl85ApM9FObuaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 14:15:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:15:59 +0000
Date:   Wed, 23 Aug 2023 22:15:49 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sanath S <Sanath.S@amd.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        Sanath S <Sanath.S@amd.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Message-ID: <202308232106.50c8f492-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816051923.2287912-1-Sanath.S@amd.com>
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 0588aebf-acbb-429f-06dd-08dba3e3797c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmGy8FRU9vZrk3ICV7UJzzxqjvbQUz9VtThT0VdsGcRlNT3/FbL2ZN1TXsE3CwkxiXE+nRkCZBf/omoAovVTF5PuV0jcWa1mmB74PNrETgs39Qe6I0PyZqKuSi4vN6Bz53PaMS6T2rSlqceCRtkVxpzWVRoqisL+Ed87iD7EotxueXk8vSRpNp/XwG3wZPj3nEe/pfaTZ7J11HbiFAbojBzpXV7JECYDSg7WK5WyQhSOBJOgneSrZ8BwmZQbtC7uINMRNP48zVJzVvo25yRR4jze39YRrH9UA0lmdoHbZzhvpKawB+0GkeOl3upEKx0zPHK0cVpMu9B5AqXjSjqzPeH2FrrWMH3MPMbu2azSR5lp27pgxeF946cVhDwakgg0klGjvyWzECXWBW+vXzxt5K5E4QFZ0no0FPrUu0aVj37qROwCfXZYc2gJultBtIGfzDHFgH/n4t6RUX2t5H8jjK2larYB69sfSlvoCL6OH+0I2ljjDCaXcw3gYy7qa5/m8i6fMh1d9HEUVqR4ML32mSQWa+07GVtCvB3jYPHoJCicFZfExCrEyxqxs4pRx1clQ8OGFcXm2R0J1uof0DvcRD8b1EEkRztBwANhXHxK3blczaXmRuZkv6DRInhqciV5OjcxDCBS+DAG/oxxEb25/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(1800799009)(186009)(451199024)(966005)(6666004)(6486002)(478600001)(1076003)(107886003)(6506007)(6512007)(2616005)(2906002)(26005)(5660300002)(8676002)(8936002)(66946007)(54906003)(36756003)(41300700001)(6916009)(86362001)(316002)(4326008)(66556008)(66476007)(82960400001)(38100700002)(83380400001)(131093003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utydqtxa3VuRq3PtTWODHac9Gs0TH0MlFx00rEMOy8qDpItL+IFIHWU4SRMz?=
 =?us-ascii?Q?WIADEDLvOLrm8cYRobr3nFVreRuaw+GP73o0bCbl5a2l2yRGCSQALJpUFB49?=
 =?us-ascii?Q?mOiYt+tbFpo4cBOmBt+01zNgQ/y6ayfQI1De+lkUpk6LFAz1+4kmyyrYy6BG?=
 =?us-ascii?Q?afaZGLRdv2cXGXKh2VLPD5a6cTjW7LStJ57cY4dJ3L4EgoCajuRVIlqb1Cn7?=
 =?us-ascii?Q?MiDqZuxqXd9dN6HXaDYdV4BQT0kNrwvHITxIA7yxmOPqdCC955vgBAl6tAxz?=
 =?us-ascii?Q?7t1p2RUtREr3t3w8LfQoEVgpR23nxHaph2NHqPAA6ZzSRheT9JRvTd0OU8xF?=
 =?us-ascii?Q?lQ/9YiQIvA4JebRCL5COFhIerA4EAt2lgcwrRSQGyGeZaliVnlBWQzNQE1FO?=
 =?us-ascii?Q?CPKufw3BRPO/EjjAiOXYzsBQS7u4I3Uni2LswVVN/+TOnOrWCSgHwtQweUNc?=
 =?us-ascii?Q?xcp/08AGhF/BeLYlM+TrfkEC6ncOHsHSQiySP8wuvwQJ1eLdNb4yFBt58k4m?=
 =?us-ascii?Q?CM+D3x1y+PDV5pSz+S0K4s45PnZQjxpwB6C+v6NPd5ooAuQW3rASjLF0T4qh?=
 =?us-ascii?Q?O36rx6ciLyJuw5BmaHqH5Vl28/9sWGHU6ES8xYDqcCrDyQvVwXC86ck0kcff?=
 =?us-ascii?Q?ceEQ7H4C7zZfHataqHGIKQahYkaRq1SvQGDcyw6dgoKA4JFFJn2jnbZaO6VK?=
 =?us-ascii?Q?TjslozpYrg47QRfrLH53Fw54hz9DRrXV4K71ufvP1jVVxeyd5kKbOSrkbY9g?=
 =?us-ascii?Q?3+RRuM9gejD76pjCZKbxH1OEAMxuL+nuaho8ZnivjVBqG8KeH70WRPh1WMgR?=
 =?us-ascii?Q?KMIxvnjVrf2KWNNrffdWjitlblHlNjpP8PqGB+tzc8yx/Dv5KGtQ3RKGmOql?=
 =?us-ascii?Q?CyYQqw3xhdpYjsWONOB3TJdCP0yu5F157MdN+ii5yo6g6nLCsojQHnh4jq/O?=
 =?us-ascii?Q?gR6aewYbo8HR2cH/M1SUxwLFZPkKsuWDumQFWNC5KKWAFRGk5CrizCtwsK1F?=
 =?us-ascii?Q?myj0Lal4a50q/IXX4jFsZ1HAeQDWN6v33rUq8GvFoLNU/gzLVM/zKul6OtCn?=
 =?us-ascii?Q?RfsY8BGO9j2J5rK9Kg6hzTBkWpFt9oH6r20Lr93vVPgdsBm8uYdIr31BhpDn?=
 =?us-ascii?Q?xBslQVBdZRYWAUn0srKG09YzTUAwXKp2z7HJ9IVIGVh+eVUgZ+Yi6WJ7KsAU?=
 =?us-ascii?Q?8WuY50iJy4ksDkM4L7Lq2vFKeCeTsEjKUFDa6EzSd7ZHu9i8pY7tS+2BomUj?=
 =?us-ascii?Q?jNi55zZw+iGrwc5AMw581WzW2WOgp245JsLFcL04eVpvNdk/YZmsVc/A/9R+?=
 =?us-ascii?Q?PncO+eH29eOjuvMGdruiVAij9wbVaaAvHzoNgY+5b7V5vr6rqLpEuETTQM2a?=
 =?us-ascii?Q?DpSjlmTsfbs8KjvTeZ/KFQxOwlanm1Xrd5F6RH+Ru+3IvOMYKvNiWBpDQVen?=
 =?us-ascii?Q?FqA12184Ta0AM9ZdHtekHKMOg/6nf91WILf+AZ3Img+TcUu99be/A/ZibYuA?=
 =?us-ascii?Q?VMT18KNpjOuSSlmv5iDZK+1lTN7cYWNE33guLPcnt2gZymSz5p74csf0+8Cm?=
 =?us-ascii?Q?oX4A0p/v6xyl4wD0NZHp9VT+1tC7XVYoVmARueWN1cb8WHy+gVvPCgYMfRVc?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0588aebf-acbb-429f-06dd-08dba3e3797c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:15:59.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RESUSwDriW22guPN+ADlORVn6H8tC6yXW4ND2Ovbl6UrlAxsXynoHZQ8TasaSOEuwZfZQ/Fzptbwk7y+gmn0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Hello,

kernel test robot noticed disk issues on:

commit: 4f0dbecaea6160d50d568fcaa4e09346052f7423 ("[PATCH] PCI: Allocate maximum available buses to help extending the daisy chain")
url: https://github.com/intel-lab-lkp/linux/commits/Sanath-S/PCI-Allocate-maximum-available-buses-to-help-extending-the-daisy-chain/20230816-132324
base: https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git next
patch link: https://lore.kernel.org/all/20230816051923.2287912-1-Sanath.S@amd.com/
patch subject: [PATCH] PCI: Allocate maximum available buses to help extending the daisy chain

in testcase: filebench
version: filebench-x86_64-22620e6-1_20221010
with following parameters:

	fs: xfs
	test: filemicro_statfile.f
	cpufreq_governor: performance



compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308232106.50c8f492-oliver.sang@intel.com


[    6.738560][    T1] pci 0000:17:00.0: Bridge has subordinate 0x19 but max busn 0x39, reconfiguring
...
[  238.092454][ T1230] ls: cannot access '/dev/nvme1n1p1': No such file or directory
[  238.092457][ T1230]
[  238.526845][ T1230] disk number 2 mismatch with 1 real disks: /dev/nvme1n1p1 /dev/nvme0n1p1


before this commit, we have below two disks on server:

# ls -l /dev/disk/by-path/
lrwxrwxrwx 1 root root  13 Aug 23 23:00 pci-0000:83:00.0-nvme-1 -> ../../nvme0n1
lrwxrwxrwx 1 root root  15 Aug 23 23:00 pci-0000:83:00.0-nvme-1-part1 -> ../../nvme0n1p1
lrwxrwxrwx 1 root root  13 Aug 23 23:00 pci-0000:84:00.0-nvme-1 -> ../../nvme1n1
lrwxrwxrwx 1 root root  15 Aug 23 23:00 pci-0000:84:00.0-nvme-1-part1 -> ../../nvme1n1p1

but after this commit, there is no nvme1n1p1 detected



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230823/202308232106.50c8f492-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


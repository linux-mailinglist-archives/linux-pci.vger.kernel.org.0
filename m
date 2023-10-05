Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93AC7BA8E3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjJESRc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjJESRK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:17:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5CB90;
        Thu,  5 Oct 2023 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696529829; x=1728065829;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aXHdMf51qsSafFOBrfuA1MazbE+y52QHzVVYgwd+lIk=;
  b=CLODhnQqLUB2UCaZz0T2+ftivsrimmanUhlhKUpWK7x3Q4DCWgUhtDJH
   WLIa35v9T644yoquRn9AZUffulu2asul74+uRJF83nxTN+YkNJVk24P3O
   Y7XQdaEezpVdJWbT5kCuD12N+ANcpMSQH1zTC+DlVyqpiDyJ72b1+1DRo
   6wSfwr7M+vGpSm0TNK/XAXK4L7b+enXV3zK618P0k2zKF3xFFKZgT1ROH
   2xDekDMPEWQUlLnHNeRR7E6Z2Vf6vPPZ1wXjgokkohioAJy2CsY/igyHD
   ctaLo1zfW94MyperVBSyoTQe24NJ3CzNdvEeCKgrOlJnw1kW2IyZXbwXL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382448893"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382448893"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999040943"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999040943"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 11:16:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:16:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:16:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 11:16:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 11:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFqIlgzRM5IdziRE+By6bU3LOxBMFqeLBRtu4bo7ahhoiT1tobdc0R2fBvrhzKUPk84mS5yMfP9M/A8wDR4FD5iO/SUqqPaNbGjDMK/U6ldL485UQWp7v/iXrPt0K7+z9KhJOsqCrKYzSauH+c9CsTVwwvtjgY34886zZEH5LtVyFaKt+heIFtuczF/q+hpkaKHBPO7aKu1iacgq67BhfAqIK5tT6uoikI5eWPSDL0Mc5mmLYh2yRizwbpfdM1T91WOXkuxteinUds2lKTCYnAwoTb7Qmdf7PJhCJz0UCfJ5n5MzE5SnrtfpK0lQxOYAv7clusE2ltJhSRiYKObx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i78En+znvO52iUKVfnbVVLvaqJYTL4UTjJAswom601g=;
 b=kXVvpqACYWLo/o9YzL7c/lHLaO2W5fJSngKpybf0oZnVPpSJ0vitGfJ+fNJBlLV/vNLua74rUIYsR0LnOZt2Lqx0d90kLbVNPDTROw01nNteg/uGC4LQ8v8+Gh5e40d12kmDDEGCESqggrct6SLyuJDq+ms9/kOQc7U+4XU6iJsgI+Uq3n435gkXGrQ9rlKC0LUn6E6i1Ys4xXNkQkuBoCns/PyxuKPzk4T7Bhjm6Qv8w64ktvz2Nx9NowysRioqWTWrvD6MavKPUxoX+PQXLVMyjLfDx0n0VXvIgRP32Mfnio58JV6Wci0N+q/QswjrmiKuygk2O26ZtFVK4832OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7777.namprd11.prod.outlook.com (2603:10b6:930:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Thu, 5 Oct
 2023 18:16:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:16:18 +0000
Date:   Thu, 5 Oct 2023 11:16:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Valentine Sinitsyn <valesini@yandex-team.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v9 2/2] PCI: Implement custom llseek for sysfs resource
 entries
Message-ID: <651efd6b8596_ae7e7294fa@dwillia2-xfh.jf.intel.com.notmuch>
References: <2023092241-obedient-squirt-966c@gregkh>
 <20230925084013.309399-2-valesini@yandex-team.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925084013.309399-2-valesini@yandex-team.ru>
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a37ce08-657a-4bb6-b01e-08dbc5cf2b70
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yysCCtszsv80UQKZZpCCMyZhXPk5jvENpv1Tz1oTbKu8qD4njNKIh15QYlEpzlEiE51zkowXTsNKezoe6+E2qNnuuPkrYoz8EHh6NYkPwFfOIKu0isk883O4mOlm3FF7wHPx3SVPHM/U7uvx5aoBP0rSv1u1PYf99+42+aUcTEYoRLH1uKcGrRmiTRHYFFwz68vvfSJ9qrrUpXirFesKDc5f4N8aeI2q6mndfijUpa70wQy7uKj7aUlacHYoL7EOLj98HoCdU175VKabkbFccm6wUjBQrOPPKQqFEz6I25H6IzU3mArbMj4Y9So1RYU6maZ/sylfbgeP4fG1cpHxVx495TVvKAscUdOmhegs5dTGJWLSF+UGiH4Hikytl8hhTWxpftQoq12+0ilrCw6q15FyzEEmIhWVFJj6oahjk+qBGz0xUJz414Hni/k1fcP9ssmvrZlUKjT92ilc5mb1f94FuJ1dsxdkIBMVf6zZ0TLSbDxUI5AroONfLk/UhIHgYeLnDQw1tJIUBeGBiWOpdcw41HvPzDz14GQBg+sM9Spfk/j9zCH6fJ3uhXKcilyA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4326008)(5660300002)(82960400001)(38100700002)(86362001)(316002)(478600001)(54906003)(66476007)(66556008)(66946007)(8676002)(8936002)(2906002)(26005)(6486002)(6512007)(110136005)(9686003)(41300700001)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNd/BjoiSxtE6y5hHRtAxOaR4qy8fl2s2JWfojo6mmmdiCb7C4yAwr5QwrD3?=
 =?us-ascii?Q?/8/ModGwcYVayBw2Ulf5IA1gnjzE/zkFHoHwTH7CjvLkjUCfm7uK2+CJ/iZA?=
 =?us-ascii?Q?HBqHgz1ebHJWpyEepYrI0rqjE9CS09sx8YZkaNC35S1+BU+7OS+zFCk5V6B/?=
 =?us-ascii?Q?62cSHKozlGV51C6k9TDyiaZYznFEDkeogSZdbfghFMdOgX3itNh2GceXDa7u?=
 =?us-ascii?Q?umGwDcgY81u4EZwHHrwOXWNjM2/hjVeauhXJP417Nl4cLzBSPHjOT/oPjeA1?=
 =?us-ascii?Q?ZVnK+EQEVc5qVafcb7jkgTckt0lWI6ocBKOCr0PvX5yAC3HVliQLsxMo3pvF?=
 =?us-ascii?Q?oSq2YSgQHkalzS0n4OMdaq+SgTxg55mJiHkvti4IR66sZeDTGjniKepNzFG7?=
 =?us-ascii?Q?gm1H4wyK0qgaPEM0dBz6FtdCyRE/S5tgEGkH41VwRaAYEqqKTPrv/OALqZKw?=
 =?us-ascii?Q?yHeCUX6iLXdzWxXwW3j98BPUXgUWi+CZCE68G11MYptwMNaiADy4t5o1Ss/p?=
 =?us-ascii?Q?j1pbAeq7ZXL/UV01YlCD+uidx2B3FSwmcoUoG4WWDkhT/0lr9bolPZ02p8DT?=
 =?us-ascii?Q?Y5U3qY1gu4/SjCP7J0Ruk8lIlK0zoWuw8vfV0r0d7pkEk54xZY7RHscnCKne?=
 =?us-ascii?Q?tijd4Hh1LAtndIr9nfnAd+aB7eQw//DazT7v9JgVdKt3l7q05nz3kwXayVZ7?=
 =?us-ascii?Q?zAsCj6nidDFmcBNpkUBZ1aJFlpJEzwsjjRgAPsQA8SVUBts2AK+e7t2G2BVo?=
 =?us-ascii?Q?1puz0kQDT9tJRMjk+tcNOtlAGZpDwqWrvaA3gcO1uLHesN0d5G7hdqIjkbA2?=
 =?us-ascii?Q?EDZDBPr1DcZLhlW11Xd7cvUB3yQ3QBMIk+22dQGGKIp7NUttrYZ/0lSlcCjy?=
 =?us-ascii?Q?iXDw266JYLPCx+rejEW3EH5Dt0lIk3991w5w+L2oBj8h58QKgVFZWUe+ALwL?=
 =?us-ascii?Q?yVYCeZH7SnXyM+pP1pfT3Wi0Bvxvqu9BAJPkqdRn+qhPNeTTyrwBpvYYQPgj?=
 =?us-ascii?Q?t0Hst19cX2ubChCM7P8Cejt0yBlgombHAZX+MWYbkAWOSY7EhuJxVbHAWnXY?=
 =?us-ascii?Q?Ex030OC9MoWd1tYFTuGSYjQ2nED+cWLgE3aOp3TyJ1LZ7NQrKg3WwW9iXh3D?=
 =?us-ascii?Q?nqgpnW8iohyqPqKkniEzQo0oxBqYxvvCdUmhtESm+b8Gi06ggtiTG2z+vbJu?=
 =?us-ascii?Q?/5rvvLYxpSmkIDwyioubeq2x6PM2Jd2XhP/xTtz0JymchYBv6ZMwnbkf5qgt?=
 =?us-ascii?Q?XG0l/wyjEPattRTQIj9UVI4RUlyvst/MFHl8NgKhXXbkjfDmClYfb8dWz9D0?=
 =?us-ascii?Q?0tzYZpRIBxYOwPcWOvUafm2Oehlh8i8XQD7Lc3ln0VCX0SHpKXylml4qCD5m?=
 =?us-ascii?Q?IHbft8iDFG6l8Oc9fT7XBC6IscE1wPApCTngt2dDWw95tEEHNyhCUyFXw7NS?=
 =?us-ascii?Q?kzQB+A7+pnwPc9/L+0Ik7hxDsNgQFsQRA1bs+y7qYgDh/Qer0aJLZCAxjJX3?=
 =?us-ascii?Q?hr7QZtJbxwVpTnePquzQwt4hbtNbd9F5P3YTo2RPj23ZDV8o/QPG5xOed8Ai?=
 =?us-ascii?Q?/JkrzxLddHsiob5/aiKh3Zdkq0f0A4EWh2rK+2LRBDOSWnTO88l+72m7dZnk?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a37ce08-657a-4bb6-b01e-08dbc5cf2b70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:16:18.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg2W4wk8yXnxrIuTowXmrSrR08jtQXxWql+eESLmuMmDxIcXc4SaQkcT6j9EDD4xoGUt+tt+FVntL/3p+9FgRMuuLL0DV6IpqmplpkKzMHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7777
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Valentine Sinitsyn wrote:
> Since commit 636b21b50152 ("PCI: Revoke mappings like devmem"), mmappable
> sysfs entries have started to receive their f_mapping from the iomem
> pseudo filesystem, so that CONFIG_IO_STRICT_DEVMEM is honored in sysfs
> (and procfs) as well as in /dev/[k]mem.
> 
> This resulted in a userspace-visible regression:
> 
> 1. Open a sysfs PCI resource file (eg. /sys/bus/pci/devices/*/resource0)
> 2. Use lseek(fd, 0, SEEK_END) to determine its size
> 
> Expected result: a PCI region size is returned.
> Actual result: 0 is returned.
> 
> The reason is that PCI resource files residing in sysfs use
> generic_file_llseek(), which relies on f_mapping->host inode to get the
> file size. As f_mapping is now redefined, f_mapping->host points to an
> anonymous zero-sized iomem_inode which has nothing to do with sysfs file
> in question.
> 
> Implement a custom llseek method for sysfs PCI resources, which is
> almost the same as proc_bus_pci_lseek() used for procfs entries.
> 
> This makes sysfs and procfs entries consistent with regards to seeking,
> but also introduces userspace-visible changes to seeking PCI resources
> in sysfs:
> 
> - SEEK_DATA and SEEK_HOLE are no longer supported;
> - Seeking past the end of the file is prohibited while previously
>   offsets up to MAX_NON_LFS were accepted (reading from these offsets
>   was always invalid).
> 
> Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for doing this reorganization and the follow-up, looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

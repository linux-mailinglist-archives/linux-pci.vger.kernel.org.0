Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37C9773797
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 05:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjHHDVW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 23:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjHHDVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 23:21:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13A138;
        Mon,  7 Aug 2023 20:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691464862; x=1723000862;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XtPU2XkngqIqC98/Of0H4rFSzGAEp8hdDvcryNgMd7U=;
  b=j2gnjPSJOXTntETMmlHfFfSaGkS4pIkd2+4DmG4D7Ib9jHRDWfPOt/35
   cuqekA3T+epbZzLJDQdUmil4Pp9t+sqkGathIVQCwljR43mB7ON+9esXk
   gmuistJGp56KD+e/Ue+VKuJ9YD1PXyiB9bUvXJnzvieg71/4fa8ev+l6I
   phNVteneZo0PEOfc2xY2B4aYhIFoE4aLciuXDonLZshbD3Sc2o8te0U2T
   jZdUZu5Mx6ipb3lOPQJ0ZMqfq6SlizpY8t4Zxa9SV10e/Q6ijbND1oag1
   wEMwz0TK45RioUfu5D/Urbo/1Y5aRc8gdF+yUGqB7QsS9kpgddvOIYuSP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437035754"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437035754"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 20:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="874571009"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2023 20:20:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:20:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 20:20:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 20:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oADQraaSBOfSDyrtmy8AAkfRSrM8LI6wqDN8AlmKxWNWTawxSEH+3reu5cGJMxkfE981w3+ckvFKVEOz6WWAgsZhp0ZyNM5Pjgo3HP94QYGo8V+MaOdc85ATRMuNJxgWjeLFnhXt9v5QdPFVdv6uK10UKJSOnL4m8uOBdnesU3L1AAxtvOHQf77Msf460kgTs6aYTc2VGJ2n9fatpxk8fCOyIY/CAwFBGDzwJ/K6x1dBxRkMoLtpqLVPmq8fruowGvTvsdkbBtuF98JIVp+/80gQOOOlHQGeGah7njNWk8DhjCyjvPE/DacDyNSJ2MFpGzaxYJnviWRUVTNDNS/Kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNdR/p2zdzN3pm+PJqv8pvfDkzIDgqsimvcwJm4uAQg=;
 b=KcjPYkQ5g1LEaceSp1t6CnteF+BL6GrjcvuOgxBtPAS3WrUtccNJZpv3b7UhMrBYEijlLDZK57FfT0ZmNikqMSeS5NQU1QYnYk1OUxi1I8tjJSVOsGiRkzmtHi9Gdaq6eIzYYcsEvTYMKSHZwh9vnydecH4wFKb3N5y5UmthfDlgWyILeLM6h0guo87n7y6SmiH8nD3tBUmQAzYrICWBost3DiFnKYtHHbRPzmFIMsq5BqnXsIjhRGSgOd8Ike+35LM9tr0k4g6O4xKl8/ftvjIaZf5Gk6Cun3QhBSxjqsjt0Ij2UklOaHmBfyMycKcxieMxpAozXNOBbBxyHDiWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 8 Aug
 2023 03:20:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 03:20:30 +0000
Date:   Mon, 7 Aug 2023 20:20:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 2/3] PCI/AER: Export pcie_aer_is_native()
Message-ID: <64d1b47b7bd8_5ea6e2948c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230721214740.256602-3-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:303:8f::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 014b1076-c327-46f2-2864-08db97be6b70
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luPc4f3SgbraYrokStZgAwsJFczEkxYjqkMZjUUjQSceCnFJIxJeACUDFLfmZbF+IFK0KUAyGIrSfQcxjwYcRGls0tGfPZ2kKAhGidnRNWNCtuhsIqH6SAof50PtAGhVX45AQQS3g2IkxmELc4JfbFkbk5LqH33/6ItHzoa/peea6J4ly4MLpinVeR9T1MA1LfCW0+R4biwU52Z0a3PL/jv6PpxYfC/NEmpclWpzy5CdWvusJtJBSv7uF4WrGNhDFEYuKTCJrpcfDg5gnXbN48/KInt///mAhkCk/SiW/RjG9eCKzcixi7NdTDCPk2Sr5/9fMl1CZbthK/hc1tx2hrlSenf2uS0yCmx52dSZcfCGlOeUVK5p6EEmdEHJSYvYlK3aPmn9oE9y0KYt5mppP0MuHhXfuY5vXWzG24oRmVcH93vWnw3Va25mzZU2mDgKy55S2dBiNgxvf7BAUDJvp831YGkLg8+yTe76zDWg5YMXaKmtnxcwWec1rjnJIBn+aZZxU/hQ/WIwuYFzXd1U1b3fjHxEWAH+u1caKClMPod9ZwyeUgHp6v1s6ktovrtvpKoDXQV8/ylgLzXTlNK2xHsKjI412OKz6VvkCB6bioS/8D5dLCrLfyNeFPPp7i2aVBlnmQc3oBuJELmg8x6O/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(1800799003)(90011799007)(451199021)(90021799007)(186006)(66476007)(5660300002)(86362001)(316002)(8676002)(4326008)(38100700002)(8936002)(54906003)(66946007)(7416002)(66556008)(41300700001)(82960400001)(478600001)(2906002)(6666004)(6512007)(9686003)(6486002)(26005)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/g7mIoz93m0ZxX0xXfKTiJT/4hjseOnLj+pad/9awvIxQsihLzGdoFyjfG9?=
 =?us-ascii?Q?es1UbMeYlzxmxQOWJtEuTijzmAIX0pmH99/3j2itkQv+eQzCfqTjY2G5uqfR?=
 =?us-ascii?Q?LxJRXi0ulCKRZJfXXf3BGNwP1DdyaEB1E8hEI2OGeVXD1EI4XTQ2YpH8s3Hy?=
 =?us-ascii?Q?PSzRyCxPFF0sJO/ZjHvylVZz0kBJSMBy3UaUcwE8bwBKSWdyEDM0r2aVamdu?=
 =?us-ascii?Q?ZYGYGSUjMAhixS9L5HvHhf8a+SJ8Bhk+fGRgAH+oTTCF+3vII93wz3pEyGSJ?=
 =?us-ascii?Q?RS9guRbEwTPLPV0aM9HNKmelfYvrUyN/zhGHx9TqZxybCKA+KkE3fgwH+i7X?=
 =?us-ascii?Q?BFvndqN1PABeaAxcelQq4A5CA6/86XDOV35mv4m1EqQyeSopq47Etdqw2l6s?=
 =?us-ascii?Q?OJtr5/LD8Ugb2sll2cI+0v/EmlO+4Ld390rjvV3yCxLZhcG6De0n9Fkp0pbi?=
 =?us-ascii?Q?4wHhXdBj/FglYbHbNv0uzcDqwKfmdyiB7aTPPuMXXDvgR2K0UGkJgb/CJZgB?=
 =?us-ascii?Q?nbqZxqcTcU/hXHo4dEjTfW+Fvkj8ywnArA2p68HV3DV3HyJiWEXnWKxLO/bR?=
 =?us-ascii?Q?wnsMcfR5Lx4uafUWv8AOJGJALyDVAMpSLl4IsK4qtQSK5h0zZAsPB6UX7CvD?=
 =?us-ascii?Q?cnJVgX5SyqA8331vpWp70Bx6BxN1A2UCV4UrAa/9yQm45k+Gm2tb4jfwq65a?=
 =?us-ascii?Q?efUc1Dj/1V/7VmFubTFPI1lGvvnrqJ5ukMcyv97eH/HTNRVNEZtIPnYMb1L6?=
 =?us-ascii?Q?5Bxvwblv525n9dy1+V2pzY47hpCMo2x8ViP4+Z0lkvRYI+OLMHmpiwsUfwYB?=
 =?us-ascii?Q?1UfUe86ZrWig1pDv+T8Nq9JemyaCi7MY7JOjWr5V+uP6yoVRYDJkeG8iFQUF?=
 =?us-ascii?Q?mKpeal83d7s9DWWxiKd9hdLHXUAMAgV42xVyarUIzbPKKasNP8lDgE+aMjSA?=
 =?us-ascii?Q?LJV6WQTI37yxeTboxmZ1RF38DewVjgtp6bYjm8a7q2M07lRz2L0EbJ6danzk?=
 =?us-ascii?Q?u83T61MKQhC4rSXEfOxDJ6qni+yj60SpvT79qlM2oGhV1un2wJmlFuVoiiiz?=
 =?us-ascii?Q?EKAWCAdzF55d7tuoXWDhIRd/tLTuho7+o0UYAEGsIYJaulsgAtI73If5nGbg?=
 =?us-ascii?Q?6Ld3fXiF/sVWcL9/WAAH8J+SgaOMVJr066zmVRZV0VeTxepfVCvWvsRUWAtm?=
 =?us-ascii?Q?zWK0glazMoRf3Kwm5GE7Gc8youNVQ4g2lyfeBSJkqaJPsTtsW8iJfPr0o3r1?=
 =?us-ascii?Q?v0w5pfq9niwfctc1zDjl1CyYT2EzySz45xPcs+9m/Z3watd7oFXvehAEVPvs?=
 =?us-ascii?Q?UI2oQeeRh4kGC8hEda2dOP2/WYmZIQX3WhpaImnkefHDGOI7TBHcxDqwerfn?=
 =?us-ascii?Q?2764gRIbPiCIT8200qUnySmceLplAJbQxLwn63lVZHAQ+Kikq/4HOn6sKCXl?=
 =?us-ascii?Q?r6xoaTE9ItAYhgLTaT4GpEM+C7TsJZPJ7huZAPebTHWRjW7u+42lKV19Zj2M?=
 =?us-ascii?Q?Rhl1Tps6IFTY2xRC7vNN7hTLiH8evliaqj6pmPY7f0KFPQx9pFjwdIYWU6EJ?=
 =?us-ascii?Q?am8GSPiOlTOKsIL4mhOG4pyeO1AOftKSPS23Ovm2UerQ1tfq4P68dWfuDrvT?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 014b1076-c327-46f2-2864-08db97be6b70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 03:20:30.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9sFpGY0MSfqnA9Nbw2xpKhg2JNJcNBdIy0pzPRMeNBtUgD8aDKzrWboMHj5tlXC03W6Haumcc4QmsibLgJxixTJWm6VVur+3qtOCR/9UlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
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

Smita Koralahalli wrote:
> Export and move the declaration of pcie_aer_is_native() to a common header
> file to be reused by cxl/pci module.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> v2:
> 	Fixed $SUBJECT
> ---
>  drivers/pci/pcie/aer.c     | 1 +
>  drivers/pci/pcie/portdrv.h | 2 --
>  include/linux/aer.h        | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..87d90dbda023 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -229,6 +229,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  
>  	return pcie_ports_native || host->native_aer;
>  }
> +EXPORT_SYMBOL_GPL(pcie_aer_is_native);

I would put this in the CXL symbol namespace since no other driver has
any business using this. Only the CXL subsystem, which is forced by the
specification to take on some PCI core work in its endpoint driver,
needs this export.

Otherwise, looks good to me.

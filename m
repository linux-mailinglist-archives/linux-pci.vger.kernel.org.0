Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDC2664A89
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 19:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbjAJSdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 13:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbjAJScr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 13:32:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F16C13E90;
        Tue, 10 Jan 2023 10:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673375359; x=1704911359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h8aIhX/CtLQT/3BE91POk85++rpkioxT+kRisKmlkbs=;
  b=NWjyUbYMgQRG25/F8CqW7WT8byXu+sWie8FsmoflMGyWZOB8WGaGxPW6
   2AdAqxRb+krxaPgBJyGcxC8x1SrXDIZl93BU5yKB5sECTJE0nGcVhqd2R
   dBGvyA1I0Wai5oGyr2Luv3mQJHYTE2QZ4ra74SoOVP796bzOexlkpUgSD
   TOqlGkU7ntON6qTV522cWRVoUBdNsvHdi6I0vglrkdpfTZHu0gJLyCxXB
   e8r7UckObwygeDxEdV3VRti5xUf/Lho3FMW1Wl7T5Mwf/PCbABCp8zm8S
   eFnDALnoTl8O0GwN66qwoqV5x08F04Xn02ok7HIPk9QKqJsnOTwOxsM6m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385530436"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="385530436"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 10:29:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687661372"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687661372"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2023 10:29:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 10:29:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 10:29:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 10:29:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 10:29:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZLsy1Xy5GUpXJdxjqzT+RgB/NPQfmxwHTtUkCgw1XQKh/oi8IR/HDtoAUx5jjGI412UqQF3iy4qOL1fCX1HQG8RQN2yipa1b0OU/vlz76O1c2MLdRru/fO671s/FlgxLw3IF3MAcOwJ4YbCfksMyeYraBeMKcYkbtGWcE3KRJ+PZvmYoi5ijmLWBlmyza/p6tdRQv72c04uHKQZ4V6B2hnzJNZsnHfa5ciQrbQuJ2L97PARHDtAbBDRVnbEXxh+hLwW2RctuUX1a+kYnbw1HtptDf6RKlfYj7zm42xj4+LFM79RXedl2Eka3FHdGQA46uxrnSTff4cAAfgrhSdksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBj2t/elfQmLs9jgso9AdhzTZZsWDUaacl75HA/lOLw=;
 b=XkoSJc1Br1Mj3z03bsC/T3StApx/DTVx21V/z/oEGybjI/ZRNYVV8Qfic/m4EPpeOgzJ6GYtdru3ymW5re6dg99UybTZ3m25ztFfDEmRA4liqT0KF1ylNiMbYEs7n/uTcAfh/hw8KmKyVABjc1GHX0KxIOYW2d4cdhSXgCZbdqhQtKL65oXkNHRQU6OlKGAX1eOFZ3Ip9X2R0NRHnnx/cyfd2BkgOgpNNEmSJU6/myeeEGs8F5GgLOTnBAxyBi97AllvbMGxmTX4LkmwIgj0bQiBNeXiJs2t7OQeyvEp6ueqmus2/5EQu6J0AASRJ3dz5RSezyTCsFoFwE+/zKAwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6567.namprd11.prod.outlook.com
 (2603:10b6:806:252::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 18:29:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 18:29:09 +0000
Date:   Tue, 10 Jan 2023 10:29:06 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        "Florent DELAHAYE" <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        <mumblingdrunkard@protonmail.com>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <63bdae72740db_5178e294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230110180243.1590045-1-helgaas@kernel.org>
 <20230110180243.1590045-3-helgaas@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230110180243.1590045-3-helgaas@kernel.org>
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: d8456463-d7f9-4dda-ad00-08daf3389058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILlycMFXtwfi0sYYef4ZBw5zYrzhqTv3wmO50dSLSMiwczcBkyzSW9fmRM6NCF2AHXE992+SaMOB6jR0YsRAN04zVsq4xXIhZs+ORrCnXx6gJlU1dAmlAuuzoamdUkq7iWwpUJiFsC2dBpnYCyDpBDOnXTWKALza/e/R9WXnaRu45CpdvV8hAvlLZFZ9ZZETrevNI0P9dh/3TsrpVXgHH9bvryM/75vs8St2sKY7ifQkHX2nr52oF5AfbTCjmr7Czqzn4t+TxTn1L9VW9ZvTdQwdZzBv4Hy4yhPI5bIq4CciATH4ubAfoWhcqIuIJGSTrdnV5oNv+jCaps9t/+8mDMOfAy6ElfTunb/P/UNsKezjtz75UyotlnD2aqIEZHeCtIdvB+GNRVXsYzu5FNmVod8fAfBCCMiuAIc+Yj+XIzvNPuyqptaN2I6/MzKlSUKhfP9nTrJcCFpPo3n8OUN/nIbbTOb9Sk9ZEBIaWs4qsaZOeKU/ZpFYnmdo80Rs2r9HgKpDvnfy0GdoJdSFpDJFUWl4z4OaXC9NrJ4IxO1L0KonH8f1lon/d5fQ4ZXN/QSqHOUqj5zVG3axtOM7PapjDV4XXAfu1j7UJbDH4bDZ/hFBoPoXbF9sYRKQfdyW2JaYRouZzlXu8C8x+Jr+9P1JxwSKUUda+MmFiD6w0lmMf5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(6506007)(38100700002)(82960400001)(6666004)(2906002)(478600001)(6486002)(966005)(7416002)(9686003)(26005)(6512007)(186003)(5660300002)(316002)(83380400001)(8936002)(86362001)(41300700001)(8676002)(54906003)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzSyPGNN7FqEGdyO+vY+0l0Fzs9wb/QFpWAHlysVAQC1TZBt0VW2s0qSFPzT?=
 =?us-ascii?Q?iovChw3dgCWyQzMFS4Z5qoBDzdaaiijI2lHlDh9ePO3GQxBzGuA0x9FUbcYM?=
 =?us-ascii?Q?u0Q8KZ+6XjZrnuHS7MHB8KwCrOSvfTudy+aueaTeWaqiydV2ON05elu160h+?=
 =?us-ascii?Q?B7I2DpIHg1Y8ku8d/9AsJ0qv+md+y9neMExrm03l09LyKw+9iNbRlt5ioPlV?=
 =?us-ascii?Q?kUW23znNHe2791tlDzObFAoj8W7VpJ0itWPPUUWaLGjGciXSdR1Zfpt1XVsQ?=
 =?us-ascii?Q?Iigi4mbQDgHWef/8bjJScyBjER+kO4+qvBMGS3j6gBcRYIIZ3MEXEW+hWfqG?=
 =?us-ascii?Q?dR/zO5OJzIFI2oHzVyu3/dNSIcyLQwkPlifQqpW1IYEB4PG7M+pUD/K+2USK?=
 =?us-ascii?Q?YTlQoWGvgxS7u2edjPPz00WH7UfZBEcmm6IZimCSVvPxTsb9JybWj0yKk+yX?=
 =?us-ascii?Q?VeFlqwRkuvqhQ/dOrQl/2NXVi6n2IbExglILwKbDLT2VF6OcXvpU4qWzgQtC?=
 =?us-ascii?Q?XYSoahW882udz7V/mUmvvYHFX+Puc9on/+Jx3GaqG+GzFfRW+p8z5zkpQMD/?=
 =?us-ascii?Q?LL2VQYTr6fAjPm4vEseluN+Jeuv7/2NtP4MYjwstimE5gOwiCfX22N15L8RL?=
 =?us-ascii?Q?AUtgG+j4mC+l2U5dugcytT12ljx+7q11ITcg+2oCqeglAFiMdTQ4PJLlDZvS?=
 =?us-ascii?Q?+qY4JFeaipSdHmbwDEHLPqFP6UGfiVfKtxiHUuEClQTGRR6qnvSKDIb8sBr4?=
 =?us-ascii?Q?hYWnF1XU0YTfmiSstrbH+q/ij2UH5sp4mDqs6gMcVtcch4G6swFLmA1uIogA?=
 =?us-ascii?Q?WCZULYJHak11wy7X/2wNXlXSBM+Opk56b6xljmlj5xtRP8gKeBoYVhoWg+yl?=
 =?us-ascii?Q?6lx/s5W9W2e5SCjMXWI3JR2wn+iVBo6X9qK/pPp77UQCY1NkT19hCvgDtZKu?=
 =?us-ascii?Q?uCrJPKWCEqPt+sPZ1D7g8Zx5vCI8F2xL6dDvrq91kKZin1xf93pmdtPj9XkV?=
 =?us-ascii?Q?5TTiq1eaBERjdy9AO89YoFsSJcgoorsA+Bq4PQHAQ17TYTyes8x1TA8+gPCq?=
 =?us-ascii?Q?1DJHr2hYsyoPHnR3qXVI7SvF+CN7bW3lCcK9KDSJnLmgFBk8eN9XruoTy9On?=
 =?us-ascii?Q?jl/oz+x+tdmb2HB/dOve5Y6tvrnO9R98wOw9gySG7LK4I1Dd52NPBOLVuhJ8?=
 =?us-ascii?Q?oYZ/C03YQ0guyTHWkhRQyyumqg7XRjoqcxhVAHurXejyNGOJA+b01fd1W0S6?=
 =?us-ascii?Q?p2rFMt7WxbOlVCZETFUJNtAhQULgl2GCaZMjP47X1utmhT0HrCqkKN5CeGO2?=
 =?us-ascii?Q?rLfVHZodjCe7tQkuLpDtJ5uK5fswRJlegbBXgJ+JBxM1NpLt7ex2ara9L7IR?=
 =?us-ascii?Q?jYDwQ5a9bCXBmP4pfYjFC1QeyjHRzEly0HFYj1l1IkDmz2CkfhU5rbnDuOlV?=
 =?us-ascii?Q?vBDxhE2rDGY54X5rjND8zfa4Eb8VRMKY4/utbbqzK+vNgFgrNW3AUILxAw9w?=
 =?us-ascii?Q?zdEMNr8I0QZIBhNBx83rzJDDbR/RDVY+lVIQBMI89KP7NUxKI25XL9Uy3sUe?=
 =?us-ascii?Q?QMFmU38JyvFV/kU7qGdVFiupJH7ThTrXgiWVfa/VQEfW55+BDFepvo7f0sa/?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8456463-d7f9-4dda-ad00-08daf3389058
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 18:29:09.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpDeB4B2Jrt4aHKLa07j5GZCjTGmY0o9rHULm9zrVvTM3vRokz9iyWfISfuOX4+Srlij/tmmI8MhCAA2Zudh0+b3ajtckagFhLtAHPdtSNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Normally we reject ECAM space unless it is reported as reserved in the E820
> table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
> means PCI extended config space (offsets 0x100-0xfff) may not be accessible.
> 
> Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
> mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
> normally converted to an E820 entry by a bootloader or EFI stub.
> 
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
> E820 entries that correspond to EfiMemoryMappedIO regions because some
> other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
> E820 entries prevent Linux from allocating BAR space for hot-added devices.
> 
> Allow use of ECAM for extended config space when the region is covered by
> an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
> _CRS.
> 
> Reported by Kan Liang, Tony Luck, and Giovanni Cabiddu.
> 
> Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
> Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Reported-by: Tony Luck <tony.luck@intel.com>
> Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/pci/mmconfig-shared.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index cd16bef5f2d9..da4b6e8e9df0 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/bitmap.h>
> @@ -442,6 +443,32 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
>  	return mcfg_res.flags;
>  }
>  
> +static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
> +{
> +#ifdef CONFIG_EFI
> +	efi_memory_desc_t *md;
> +	u64 size, mmio_start, mmio_end;
> +
> +	for_each_efi_memory_desc(md) {
> +		if (md->type == EFI_MEMORY_MAPPED_IO) {
> +			size = md->num_pages << EFI_PAGE_SHIFT;
> +			mmio_start = md->phys_addr;
> +			mmio_end = mmio_start + size;
> +
> +			/*
> +			 * N.B. Caller supplies (start, start + size),
> +			 * so to match, mmio_end is the first address
> +			 * *past* the EFI_MEMORY_MAPPED_IO area.
> +			 */
> +			if (mmio_start <= start && end <= mmio_end)
> +				return true;
> +		}
> +	}
> +#endif

Perhaps the following trick (compile tested), but either way:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>


diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index da4b6e8e9df0..ae95d1b073c6 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -445,7 +445,6 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 
 static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
 {
-#ifdef CONFIG_EFI
 	efi_memory_desc_t *md;
 	u64 size, mmio_start, mmio_end;
 
@@ -464,7 +463,6 @@ static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
 				return true;
 		}
 	}
-#endif
 
 	return false;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4b27519143f5..3ab0c255b791 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -790,8 +790,12 @@ extern int efi_memattr_apply_permissions(struct mm_struct *mm,
  *
  * Once the loop finishes @md must not be accessed.
  */
+#ifdef CONFIG_EFI
 #define for_each_efi_memory_desc(md) \
 	for_each_efi_memory_desc_in_map(&efi.memmap, md)
+#else
+#define for_each_efi_memory_desc(md) for (; 0;)
+#endif
 
 /*
  * Format an EFI memory descriptor's type and attributes to a user-provided

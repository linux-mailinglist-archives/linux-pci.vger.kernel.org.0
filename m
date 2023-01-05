Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3CC65F7CB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 00:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjAEXk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 18:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbjAEXkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 18:40:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC671FE7;
        Thu,  5 Jan 2023 15:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672961948; x=1704497948;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R94ZjhQpGTe09lkzQcuNQYden+9GKIgt0WOXyRJYpks=;
  b=Kx5afixJEFygCxr7O2ibmS+SHo12uHLkbBbuR2bRvsHiE6izBFEhgeMZ
   kWJHpTzg1hkZPbRFlbDjGAscln+tTGzBWE1y2a66XqtCcHjyt0RF2iE8g
   zENf3+sHiW+XyyQuV8pPAa8zC4w9U9Jl6kKl3oYY4UbCbe9dnBjYqwtXP
   l3vS0OsyTB/+6c8H162HDCbJTEGHQt7xbgzAmXNzEAIo+YC8hv4NVnm7p
   qKh6D088J8rQNrnAZbQMEmsZwkypVii+7oasw6+mppcmoJu8NaZakzM31
   HSLRhdyEse/7OYX8Z2nDJWA26wW2SX1+M9q1uoH1pVSY68ksaK/Dn1LKt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="324371212"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="324371212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 15:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="655758007"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="655758007"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2023 15:38:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 15:38:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 15:38:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 15:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ0s+wmGZyHAEcgU7Ei7mtSV+P1KWPTUH/7C+BOWCXx0ehwY+8RD4f505SAB1hfWpaCiGeNHiWYKbu4mGNN8/DFQQ1JCohYz84tfMLf271kLnnvqJCDuiGxq359iaU0xPvzMvTkx9jhTTi/nOo8M4CP+mhs3uUgLj+BCBeb2tk8M9RaGVlb4AC5+uBpjEa2dun4wMx9MwS+iwdeCRSqKkl77ABL4rZOHKXWh97Tyv5cPcH+Gao0wqJc2nkB8lt0kDiA9UX8HbDEYHDn4Y1DYTdo08lj+GgjJ6zHEDa2jLYD3CKiaCCuWbY5DzAKFl2cX86BBq18WjTHIYBvjF5KJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUyt9wN6Oq7hxFn8Fdmi56FEwOPBj7t6fuW0kNqB4bI=;
 b=LvVMoM9HxO0f3Vo9oVOkVjRWoh3c6vQEC3DmOszAsqzVXZxXD3hvRK3tu/ZHVcbRQtyg3OjizesGNsRVQmAs2RVX/FpsDfr1HzDSqS7PK3umMbaZg+CissJlkwENs6G+xx3F7aayuaY60uSTvNtzhr66UFDMhsfmPPtoOgCFqRklqC8DuXp8fsx0UaCkx1grsHsUTZfV6PWbCdpYjlq8c/t9pbuCd6cT0X81XSdYGbeQVQpy/l56HzdeUyJUGFrfg6NyjS6rim6oUf08GGJ4K1WYKGjJbcFFuQHGlw7zyuwWY4/SgR5QLgtTRKLlYlpkZ5Rk1ptd5Z1ZlVCH9h98HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB4871.namprd11.prod.outlook.com
 (2603:10b6:510:30::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 23:38:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 23:38:43 +0000
Date:   Thu, 5 Jan 2023 15:38:40 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <bhelgaas@google.com>, <hdegoede@redhat.com>,
        <kernelorg@undead.fr>, <kjhambrick@gmail.com>, <2lprbe78@duck.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <benoitg@coeus.ca>,
        <mika.westerberg@linux.intel.com>, <wse@tuxedocomputers.com>,
        <mumblingdrunkard@protonmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <david.e.box@intel.com>,
        <yunying.sun@intel.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <63b75f8083b79_c81f02949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com>
 <20230105223257.GA1177387@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105223257.GA1177387@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 55255d4d-0750-4f6c-5a07-08daef75fb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bDKkk1U6IUxURZCHu9hDNFfuOWhPJb9FKZDt/V/2lY30HesBpA1h/SJGoPDVQbdUZUemaZwbaaZg0hoQCWv/gpRerePhEuMEGyPvmf9Bruxkh7niY9XtCRDuFHy2ZNRrHKQ5izzq8DbghFlKnXPei5T1nBBDv3vKFw+h2kEA2zqyGxL6uGiiS9qa3nr7QAzvl5S+6NPJipeQgyLuBHDC2qGnh5CGlr6ivDaTe0m6UzENDhbNV/EFOuXKTuYTyW/8yoTseN/xQU+ht5C09yt00avssnsvXOGwBtDA7IUkJNrRUlUKW/9JBqTkgiU8rWVXlxRkt4dv3tl4hWNIyBTR5zc6cCbOrUxW1w5FnZmYbVSOzXNvat1DPhTIar1YCbmz7ryGs6cI30xXqMbhtCrOVm28tSExJj4wsDgjZ2NN+pnM/zjahQyLdnLsBID0X1iSH4FwYDTcz0vK1xlo9jvsuNglwharfUTRGde4P9fsnULgIw/KcBx2tg4TikaufyPReR4PcNi6mv1yrku5Y0VVidQdSPnxRxL+3D8PhhhsAgMRynWURkSBa8hlC7zXMZL9eRKEa6/qR8ySPBf2c4PP3MPLPoq1Myt95T3A2xXzVq8vWUGWCn8l50/WHF9ZwGp28kOxjiiqYdFdqbxmpNnSz2R/WrLiZ89dU+p9tR88Aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(83380400001)(6512007)(26005)(9686003)(6506007)(86362001)(186003)(82960400001)(38100700002)(316002)(4326008)(478600001)(41300700001)(8676002)(7416002)(2906002)(5660300002)(8936002)(6486002)(966005)(66476007)(66556008)(66946007)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8MyZJFtYCHr/xiVsYrLuJ7uud4T9p61PprO7eMISAdavycktAzzcLgLy3/3?=
 =?us-ascii?Q?ueEpqwKjOy23saT3z6Tw2/o0Ly5S4f3G8ym1+mwJovBh66dMMLRrOA0F6/ud?=
 =?us-ascii?Q?IRQOtJaxGb6D8n6gnPPnzh0gZiD8flJ9FXQ7gss9Gn2SupU9iqw3s/c13eXE?=
 =?us-ascii?Q?7Wu8lVG4sUVze2tc+DlE39rWWLJ3oTusRrb9BcWIbzEQ6OzC9DH2V1xCaMjg?=
 =?us-ascii?Q?X5P03ImIWDifgzoeNu3FDnwOe//sDKHsTCVXVAHqpvV5Zc++/B+nfUrbzhAx?=
 =?us-ascii?Q?MIoKI20KdIo2OJFTshXvRyeOj8xsFE2JSOsK7O79EluYJ3U4xvH61J/f1+Fl?=
 =?us-ascii?Q?Mf35hBVgG7kK4r45equnOmzUaT35ngOkxGaQOxGlv4bUWAG0e/yiXgQsNBK+?=
 =?us-ascii?Q?DnUlMNoJ1zjZuoWDwpi8gANTYh93+dByk8BAVy7Een31VeSlgOAeEEKWXCQr?=
 =?us-ascii?Q?MLrc3b1gf2yqXsQwuo1M+G5+7HVGK9MeHokgiRVCzhU05cK4aWoqEE2Y8etH?=
 =?us-ascii?Q?OAz6H5RPU6YXvX/n+XGFly/hcSJ9B0VJzsH1xSRsqB5b3TABrwpdRC307l7c?=
 =?us-ascii?Q?9AUPt2fZuDgN/zE1Q/j1Q1MtsMjrwfWatyFf2vl5ocqNOTNJqiGk0ETygdwe?=
 =?us-ascii?Q?1MTsYixaasxzzEJe8PCK+GUAs/lWSC8dtT//R3rXmLteyfLwQVH2fif7LR7/?=
 =?us-ascii?Q?TZ9jNsHArdTY/hhIBJ5ttvYH6f4RrAXJVZmZh3DtmsfI86lWhbb05q8onKb3?=
 =?us-ascii?Q?eiwI7yRV4wwa3zPu1/fyX70T9Ez25B9C0gxApE6tl3y6SWoT9q90XDSVAuqF?=
 =?us-ascii?Q?PdA++lC7RgNemZqowqGESzye76/XKnVlHerRGXiQzTA8wiXSmSeIxGo/0K6H?=
 =?us-ascii?Q?Mqt534Esl6U39ou/fBfoMJm1vVxh+dI6Mqum6fFjacveJCG+vzth9sTowGKr?=
 =?us-ascii?Q?JEPunBp0EiALOV6STIcf8B+ZF9HS6tFuHvJfuW80Ha3LsJhfl37V+nE0Eqmb?=
 =?us-ascii?Q?ekeC+O5mMhPnV5sks3dn31VFn39DmqS6mmK5rQGxEsNNO5n2RFMJLDMEtVF7?=
 =?us-ascii?Q?fC60DOdqvX3Qsmc/u+/ZjkUPruPoGB+xCcHMW76iJc/LIfGyTsyvyukEkzOO?=
 =?us-ascii?Q?yVtOGnYRTi+sRrlMSeFaRFRUqnM4yyUOZN/3ng8M0/rn4g4XaW950NSEv6wr?=
 =?us-ascii?Q?QMZhPvaoroK8giDTA+iv7HKQS6nthpqJQePMtcEaHmRhIJgsAa0MzeOWVLCV?=
 =?us-ascii?Q?Xk/y5NAcit0n+ZCsHJPkk/TF3xbqyARR28HGc5Gz5uKuhlPX2cVV1vXHp9ph?=
 =?us-ascii?Q?4Dd6cbbdH7sALvWEhKwwSxSKzIM7j+Kf4wH5p8Znz0NrwfIi3hiO9H/OYFWX?=
 =?us-ascii?Q?JrFrF7qmhOSxNrBkrzCjFaKtPRHpGzW0nLVwk3ae+o824Z3yRmdqAwlP/l7E?=
 =?us-ascii?Q?dzDEvVYSSC8+1Mtw67WXTLCnpyBuHQUwKpQgV9rtif3Ukab/B/aBwf1BfKy/?=
 =?us-ascii?Q?eQU8pMd9zRJsT//2+IFZOuDsorIR1mAlEqMYzKRM4ds3cWMCF/YC5uOX+iFx?=
 =?us-ascii?Q?X232g9q5Rcbi7/d/5e5szAEisBja6uSWEJ/c+yNwh3KfpFSTOHvnOVd3cbJ4?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55255d4d-0750-4f6c-5a07-08daef75fb43
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 23:38:43.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWKqpEr4XeKHC0p9V5cWfrN3rQftaVKVS+FHk8Q9vr3C1BIYPla4i9YI2g1SHk2ifqbaoC6kTbQQ/d1rDMPnvh3OML45Blp3rW7ElsEGC+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
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
> [+cc Tony, Dan]
> 
> On Wed, Jan 04, 2023 at 09:39:56AM -0500, Liang, Kan wrote:
> > Hi Bjorn,
> > 
> > Happy new year!
> > 
> > We found some PCI issues with the latest 6.2-rc2.
> > 
> > - Using the lspci -xxxx, the extended PCI config space of all PCI
> > devices are missed with the latest 6.2-rc2. The system we used had 932
> > PCI devices, at least 800 which have extended space as seen when booted
> > into a 5.15 kernel. But none of them appeared in 6.2-rc2.
> > - The drivers which rely on the information in the extended PCI config
> > space don't work anymore. We have confirmed that the perf uncore driver
> > (uncore performance monitoring) and Intel VSEC driver (telemetry) don't
> > work in 6.2-rc2. There could be more drivers which are impacted.
> > 
> > After a bisect, we found the regression is caused by the below commit
> > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
> > After reverting the commit, the issues are gone.
> 
> Can you try this patch (based on v6.2-rc1):

Looks good to me, one question below, but either way:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...and Dave, who reported that CXL enumeration was busted in -rc2, says
this patch fixes that. So you can also add:

Tested-by: Dave Jiang <dave.jiang@intel.com>

> 
> 
> commit 89a0067217b0 ("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space")
> parent 1b929c02afd3
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Jan 5 16:02:58 2023 -0600
> 
>     x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
>     
>     Normally we reject ECAM space unless it is reported as reserved in the E820
>     table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
>     means extended config space (offsets 0x100-0xfff) may not be accessible.
>     
>     Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
>     mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
>     normally converted to an E820 entry by a bootloader or EFI stub.
>     
>     07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
>     E820 entries that correspond to EfiMemoryMappedIO regions because some
>     other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
>     E820 entries prevent Linux from allocating BAR space for hot-added devices.
>     
>     Allow use of ECAM for extended config space when the region is covered by
>     an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
>     _CRS.
>     
>     Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
>     Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 758cbfe55daa..4adc587a4c94 100644
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
> @@ -442,6 +443,25 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
>  	return mcfg_res.flags;
>  }
>  
> +static bool is_efi_reserved(u64 start, u64 end, enum e820_type not_used)
> +{
> +	efi_memory_desc_t *md;
> +	u64 size, mmio_start, mmio_end;
> +
> +	for_each_efi_memory_desc(md) {
> +		if (md->type == EFI_MEMORY_MAPPED_IO) {

Should this also consider EFI_RESERVED_TYPE? Not that any known BIOS
needs that accommodation. This is more a question than a suggestion.

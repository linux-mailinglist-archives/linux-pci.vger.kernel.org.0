Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA4662580
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjAIM1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 07:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjAIM1V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 07:27:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D51400A;
        Mon,  9 Jan 2023 04:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673267240; x=1704803240;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xp/C826A5GkWPdlb3xRYQZ7UDSOwL+bMU7EO6Zn0X7I=;
  b=S6CKhr/OYgAH3nRLD+deL5V+EmNZG2H2XfHgfcLa9vV1+1SyRu1qSLJ5
   aMi/LHcItSo7tqeawpDbCwtsKi3QUkz3NLgY0HBPrNlnrK5GpV5JYjTOw
   tQomw8xSU3E/WspL1nx0kZuP82gOK5B8VxKxrB7ZNR5NYlm+qCe/OdVCE
   L8SIdCfVF//jlO7/0omDXhTLsKM3dwIWIfG+YogBjTWR58A0eIZZ8z6TR
   VYDKn23o5cq27UUiKxYvNBiObm9I8HApfDTjZJiN89PWwtx8d5SKJebn4
   wm+AudlFvFfw4YEvIg5pGwFGGqyn61xn2gu+NUAmS+5to/Ja20sTiIEKd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="310654100"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="310654100"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 04:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="745363802"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="745363802"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2023 04:27:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 04:27:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 04:27:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 04:27:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 04:27:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXFdzVmoia7TIPU2FDeaKLEs3rSuxxBVXGN+rxDwX0m4X2inuYtT97IpAnxcu4vW1ZJi7kcB8CzEsy8GAXHLkcclCWyo3uwZDUTyxtnMFQSj2yRKV3/fLlJqrIxntakZ/IFOFy/HI/0I8VSQ0rGjEQq5yr2WQfF6ltr7zcRE5KgJvWH5MTKCptQuqZ5ntUhUAld3J9/hkIwUQdT9PIPoNQcShWRjMAhtjWY1zNiUAj92bmkTJCfqwN8gGrY8hdWUkrW4pngAl+iXIr3U6laQqqXs91+7t/cZ4etigJBvA/0N/j9XPFV7bK9y91fI3be3hbhiluDfmeShqiz+l/FlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQV86gxv9RhLtU3U5N+wpG5TuxBC9nn42PAQqdDzmRM=;
 b=l69TFjyykNipQD7fTRjtwQWGLwyAS0MOHm5ckYgiHh++wiRZSN+lE8FL1UC3pgNz8uXRLpgY+7P8lIxlZDkAY5WKORow6Ca7Do8qagaMuzPhzPhPSJ/bx0Z+rLr8NGJlgrtwBtl7T99X9wz70eK3JsTiemIpHBeYfpiqaN8lhF6f4EAUxr0ysZNMAwiD1kN68ZNLBTmU79jvsvcTJ1UMuqyK5SH6tM4PYgfkYefY6Tncf3FzHJ14mcfDTi0sjg//8/Pa09xMjmAzXgyNR+r/tdbXbjh2pMoH+HzpwtulP43DUNL/hcaHHa7Wq9gP8689otFXGCT5VMakufwVRXE6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 12:27:16 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::7b39:df5f:fe4e:f158]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::7b39:df5f:fe4e:f158%2]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 12:27:16 +0000
Date:   Mon, 9 Jan 2023 12:27:03 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Liang, Kan" <kan.liang@linux.intel.com>, <bhelgaas@google.com>,
        <hdegoede@redhat.com>, <kernelorg@undead.fr>,
        <kjhambrick@gmail.com>, <2lprbe78@duck.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <benoitg@coeus.ca>,
        <mika.westerberg@linux.intel.com>, <wse@tuxedocomputers.com>,
        <mumblingdrunkard@protonmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <david.e.box@intel.com>,
        <yunying.sun@intel.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <Y7wIF/qigYMgmByE@gcabiddu-mobl1.ger.corp.intel.com>
References: <ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com>
 <20230105223257.GA1177387@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105223257.GA1177387@bhelgaas>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: LO2P265CA0425.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::29) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|IA0PR11MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c093629-9e7d-4cbf-ad9a-08daf23cd79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L52ah8/H9OnnPtELMNjOoJzQ1QD9jyaavUnNp0gW97Ty3O5XsWKZ4MKuGW4MtGzywwm1NNOsNPeRpYJ1I4sc2juDyrYni/t7T3L/UW10EH9Nyr9TD+z+a9/4UU/hMmhP2LVQpWNt+oDaoWXbT5UBXmFur+CWxELZBmJUbKjR9hC9y7B9L3u2D90QukBIqj6q5LflWzG25GHM0Zq5rqB5JgShDr6MAYrQAlR12S4882HN6no3T0pTpweDhLIUqvbU4H+Yky6JRvDpsuPso488bXCR4SPuSKbcB4KncoHlZZfJXYaEQJlVtuXqVIZF9Q/636S3ferTvJI7wNQnfinEjXjDq9UE/8qktKExDCaJSIGhKV9OTXlWqU1mh5JtQ7Oab3G9hqUdQibVZ0AGygffHxiqm3rBQxBqZ4naS0ZkFv/iKvUp7RpDyRWx3814K4BMTFRkKH3nlX7KiIv2D7F95HRkGpfPhQiMFN0iA73JGg+qxUzvy5jOKzqIKdSVJ9sY0gVmqgpe8eDPDDHBi94iAr1Ce8mZj2D8+HEJ825MpHgosuN2Dg4sxNo/lXcKmG9ikG2+mYWio3jSXx3TH9Asr8wFdYhyFgjpsotvz8zuDig3xxS6DbPfPLo3qyxcsyFX0Xo6tBtNUIlX4XIHOx6Cp6htkDrny/bxkFRn+OCw/Cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(86362001)(83380400001)(41300700001)(54906003)(66946007)(66476007)(66556008)(8676002)(4326008)(6916009)(82960400001)(38100700002)(6666004)(36916002)(478600001)(26005)(6486002)(186003)(966005)(6506007)(8936002)(7416002)(5660300002)(2906002)(316002)(44832011)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yHjYkaU0wp0Ua7nQf6dxVT9ZUYQ2k7N5XHJgKFdB5oRc0LUDZN3BCRtReYVD?=
 =?us-ascii?Q?SEa/MJodE4bQIKef08n/bv68h8ApMzJLGp91JHnFrw/i09nhBY2OmKJ4RnER?=
 =?us-ascii?Q?KulH4FDmu57rJQ/sTqq6w3C8z4MkqzDycl16tTTVWU1dFiv09Zx3CrCUKlm7?=
 =?us-ascii?Q?JEvSmSQ2qtUO9iDBmCrc1yNtLfrqa69IRz4IHXfGwIvvsIn5frNYOTfOSyen?=
 =?us-ascii?Q?T94nwdmzSYGoj2Nn5QcJTBBIHWceJF/7tVpGHPUUkePqKGmWXOXRzr+2vbjR?=
 =?us-ascii?Q?e/0iOHnU/FSUkzl00qkpIKw43gnayP7+EoEAhOu6mYb4bvRM+5zIKT4cgPnv?=
 =?us-ascii?Q?TKjSntaQu/BmUwKNZkZZ3MBdEwf8rtyyDLtyM5YY51sJhAx/GKNWQD8Wbmy8?=
 =?us-ascii?Q?UC0oxiEIRDciX7yiwHWpnwJclTQDqwhwlm/C5iDqXyypogWqzbHdhxOoAwhT?=
 =?us-ascii?Q?yWwBDCImgOfB+Z/C7h3zZHwiiscsKLXljbiuIC4ayYa1KuLauMn+aC5EJAHd?=
 =?us-ascii?Q?u4oe4zbqL+45UwbIiqL102pUQfmfm+rM3Pa/hCZAbGWMBVK0fIV5ZPG05h3v?=
 =?us-ascii?Q?ugsccO1Io+/9EcUUIjUSbM8COjrLZ/OM+0ABXxG6Z2ts9sklRv5myWIg3DGE?=
 =?us-ascii?Q?Lz82uO8A0iNpf6AsdL1BqdHjW95E0hbYPrjLMTIpdaI57dh6IrdcLSfRSzNh?=
 =?us-ascii?Q?PCUnVx18Wfq8HvL7ck+2F8LVANhNm8c8TjBZdpPp5F2TISO7p0rIU6SUNmBA?=
 =?us-ascii?Q?Ze44KyjOc3zTNeBfJZi3hGjbMV4Z3d7MsnM86XRz7Uv452WEerDMu/bpAEDA?=
 =?us-ascii?Q?PPm6mNWm+qxRb77vJRa5gEegj7SuvSNzqKzEdYW1PKISg5SkiKTTdNXCsyix?=
 =?us-ascii?Q?rm566lO4qfFdSgafaePjxvZerY+u2QtxuT/EUDtgTtNU52m3ED5dPRSOC/KK?=
 =?us-ascii?Q?CbOsSa/5H5FgmyXqADFMc3Sd4Z0TZH1xl5ceki89u4p/PUHfrX5WhbGfNiny?=
 =?us-ascii?Q?W2fZdsjgRoPyYm5WaqqBUj9MGGJlr1yVG0Ir45zI+gXdObJoMv/83KEWkYD4?=
 =?us-ascii?Q?hJH/9NudbKZ5lFsgftyaVBxyibYT3AH8i3uwvUtxHGSFHSEufuJieaDgI3tL?=
 =?us-ascii?Q?FoR9sXRleocKDc4rsWkG/ocEcHvsK9RYSBz9ch/5Pt5SEZV86UfR7htOGOtZ?=
 =?us-ascii?Q?3Eyjgi0XjJHVDheRI9k7pN7coHn9g3G0cpcUunOZ0rzodPuMzbRqWqLvUiuq?=
 =?us-ascii?Q?OhSPQZP0XjO84P3tgKLpMVQvpkNQalE41F/HmHD51nkc/fy4W7QzY20e3EgX?=
 =?us-ascii?Q?9BPkMqDZtDiuUPu+kdS2XVdz2FdaZNwAuhawhm+RRGbyLKq6ij3lmf5A2GCB?=
 =?us-ascii?Q?eJ1T5Ed56bs+a1gxoLmXZ87QdAwhGHFtBvKkWXZOAbNyhK0NY1rrXrzO2Gqn?=
 =?us-ascii?Q?YeEi0SmiS48Z4esb2GC8v2prJ2jzFbvZ0OrkNdF8RdwdMEk+KdTHyFBlcpeu?=
 =?us-ascii?Q?Y/stUDLiIKJssHjtepIzoZuGf3DeIwI6kNf+m5Uh1TS8g/PMeynSSImuScED?=
 =?us-ascii?Q?B1RZ+VzQI5G+Ebbigy9FmnLTm3ErUJWwoVNtRfq7q+hFClGB/gV1weBeGo2d?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c093629-9e7d-4cbf-ad9a-08daf23cd79b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 12:27:15.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNM/OzwpOqYU5WdX9I+Ghh+0PtvJFQ2zTkKUJ8WRjMYxhh1ht3EB947783lcsxUbfAMwPL2K4bh2T0ie3gaM2sPpgzXGmzG64xOt45BUoS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Herbert, linux-crypto ML as it affects QAT]

On Thu, Jan 05, 2023 at 04:32:57PM -0600, Bjorn Helgaas wrote:
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
This patch also affects all the QAT drivers, and causes them to fail
during the probe when they look at data from the extended PCI config
space.

Herbert, FYI, this patch is in your cryptodev-2.6 tree.

I tried the patch below and it seems to resolve the problem on my
system (S2600WFQ with Skylake).

> Can you try this patch (based on v6.2-rc1):
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
> +			size = md->num_pages << EFI_PAGE_SHIFT;
> +			mmio_start = md->phys_addr;
> +			mmio_end = mmio_start + size - 1;
> +
> +			if (mmio_start <= start && end <= mmio_end)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
>  
>  static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
> @@ -452,7 +472,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  	u64 size = resource_size(&cfg->res);
>  	u64 old_size = size;
>  	int num_buses;
> -	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
> +	char *method = with_e820 ? "E820" : "ACPI motherboard resources or EFI";
>  
>  	while (!is_reserved(addr, addr + size, E820_TYPE_RESERVED)) {
>  		size >>= 1;
> @@ -502,15 +522,17 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
>  	if (!early && !acpi_disabled) {
>  		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
>  			return true;
> +		if (is_mmconf_reserved(is_efi_reserved, cfg, dev, 0))
> +			return true;
>  
>  		if (dev)
>  			dev_info(dev, FW_INFO
> -				 "MMCONFIG at %pR not reserved in "
> +				 "MMCONFIG at %pR not reserved in EFI "
>  				 "ACPI motherboard resources\n",
>  				 &cfg->res);
>  		else
>  			pr_info(FW_INFO PREFIX
> -			       "MMCONFIG at %pR not reserved in "
> +			       "MMCONFIG at %pR not reserved in EFI or "
>  			       "ACPI motherboard resources\n",
>  			       &cfg->res);
>  	}
Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Regards,

-- 
Giovanni

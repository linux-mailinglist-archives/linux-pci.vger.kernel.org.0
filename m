Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390365E351
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 04:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjAEDQt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 22:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjAEDQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 22:16:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDAD11178;
        Wed,  4 Jan 2023 19:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672888586; x=1704424586;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=biTDTLeG/Nq9VRskuH2fTY/S1F7yl36msqCXt9aIliA=;
  b=JkRQhGiH/4Tq6Kb/iYtatibNLbBxVtMUiAnCAzZ6M1P39tZeQbc8Gnxq
   ARJK2qN9ktiiU5prqLsB/4Sn9S87d3BuYbO+lcs2xFhEVXh9vXDr9PqlG
   ehiwUBJFxhyZIT0WA9vqJsU0vySR6Jlnu7y8uYbJjnHKmoZ70udmeeWK5
   jhMuw0E1Q6+890Cmlb5w2nBXKTnSHaWTUoheQSpgR939KD334r0gKwIRx
   nByuwATheLWEEVpmLuGFE9t8NPimBVvJ9tNyWt0jFz043Fi3fm3qum93R
   ReSGRq/PyBXagYdkvQw4xUEUuAU+N0aTgKssVTr2XCYDB+5ExoBUmSGzb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322175236"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="322175236"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 19:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762933443"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="762933443"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2023 19:16:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 19:16:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 19:16:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 19:16:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 19:16:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCpcy8Pk0IuT5G2d8PcMAXcEZtOuSX2u1YZSSZgMUAk9AYyyU2j/HYQNv2uw4f3oI5rmyckNFa7tx/UYFmuay7z/1G+QUCMSc2bPzhZJvPasw2Mk/yk8W6mJn5DG2/y5loagpLBVqSanlLR+mHgPIbTmA1Gu4nKZOLubBOb+5h5GrLzIQUMeb23Sw7ODON+CGSnomDNqdj0VRCZe68nDovENvRQvlhn43V0nVoM1+1AeD1QuzGNA7ZjGqvgXjHA2DW54baYL912P6ZFEPJMSUnpslcKT7tNBrMkF9dGsQjmQhAyMhso8XDUzfpw77et8+OHd79sjWkEoi185KJwGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkN1TlCdn1VcuKTkmSKkIyFXRusWEUQq2zx8vpNeikc=;
 b=cJ7y1aFh9ohHdiFm+bysstuhkTjzB45ZlML1KJEPq/JselWHbEiXrN7NiQmsc9gz7jke0qlasx5OenmFxyvE8s2CiE/JNxVtGYv3jeJFqQyVeIRudED1eSLq+TyHqi/jfQQhFUI9dhReB94WfDTMhBWiD39DxUD80spOXtXkEnUrWiwY92Ko2ERotFpMdTPCY/B42LcmaN15nu++6g6VivLlVd52dz9qhv0DwgzuoQuXmghAreIfweTHYkQb59QPgUSfuJA1V3aE0/JmCODq4jSswt096w9FfdLKGpsa92Ia/1400/eUTZs9LtDjRnmfdNanu6R1PZOrlnETPc0Ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:16:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 03:16:22 +0000
Date:   Wed, 4 Jan 2023 19:16:18 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 1/9] PCI/CXL: Export native CXL error reporting control
Message-ID: <Y7ZBAm0wbh3Cg2UR@iweiny-mobl>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-2-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221212070627.1372402-2-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fe6059-6367-47f8-054b-08daeecb38c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5YyEDIb3apvvr0TUTXkQfUK76Qu2XZLcmTAVnEiZ7JYDpUOMnf6r0l7xUdBZzEckvOrLQdfcSRkGW/3WLQRg526SiHzq3FAZtLbMR59peR08VW2HT6u3krBrW+nxcKhw8JVZgLntXfbs5pQMy+H6E/0jGQje6yq2QXRes574gMiDkl0wAIcSim821+R8t0D7cwr4VBc52F1s2ngXXUQr2yH+W9+G7f38lmQLVylsTSDko2PmCPv6l61QvtjsIpE/hQopoZnOaA8COEaA2Yt59Wt5kwKE66LN5bdoPi65EVSXLDmcAMYDntiTm+NtudbtNDZsphpGpQwl6s+72L7gHZtE7ASHgnvSV2LJgmLPE4Xhqlfz9N/6iaXNe3F3BAXiIaAl9oRfhkX/fxSMR1hGfJ69Sd18fBiMimWbWcpApcWL+q5/5pZYP1wz5trJ4CVjHEqYFoOQWQ1grD8LNQITMTrKY5AeP/UGrq98OPAtozFNUOnIOmT0W4bmmJHIvd1S2+M9Sr+snDvQM5lt9aSSBwgE9QAQGsAvRlJ/AkIem8MDckg7t7n/9JRMdpHtcyaeltRzDFJPXYdT3UqUGplNrxktO5HMpdc/FguREHig/iuh+NebWsG6s9pJfZBY7SXV264B8KKQKfZSXT67trlKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(8676002)(66476007)(41300700001)(66556008)(110136005)(66946007)(2906002)(44832011)(8936002)(5660300002)(4326008)(54906003)(6506007)(478600001)(9686003)(26005)(186003)(6486002)(6512007)(6666004)(316002)(86362001)(33716001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x6lxtGeLOnPEcwtdZFsLqV0cct37VVZgLPpHqV/QTNe9gjJJFJyrlBwKtjx/?=
 =?us-ascii?Q?fpN7Qx4WV6ofJqrae4/DwSsO7cx60SfFKFvwlIrVLCCxusR8Ugkq+SMvwkVK?=
 =?us-ascii?Q?PdMuX/c/1rKRbXhVMqg0IA4fGnlA2HIdJBkGVrinEhddGyLxyDexpU67XIK7?=
 =?us-ascii?Q?WvmZTSofrGzASRcg9oP3DVGPOm+1EWp4RbmJoNbDLfybiYeDDBfMS23cSt0T?=
 =?us-ascii?Q?Li7lL36fDD65QtjrvvY/UPiEwEELB2jpxrLW69ivGhfqa0iYDi80CAQd9JKC?=
 =?us-ascii?Q?7ryMN1at/RlY5PGxrczrbWTfTPK/0wVclNR/SfM0+Sw8JZLfmHhP2mk62W/y?=
 =?us-ascii?Q?+slDTu0+GvLGA7u/cZWUwtNO7Ju0aBlmudlDM/OyGaie6STzuyHwbSZEOadV?=
 =?us-ascii?Q?XpKyNC7DtD/xwckzcK3DXzHKgBPUjJ2LNZC0fWEx3uJHjpr4iVYMpAxrEqji?=
 =?us-ascii?Q?WjeRPSIcdBvQay6Zm8/nI4vMBeKzLHLmhwA2UPY0D5jpMjx4rr1S02++YKD6?=
 =?us-ascii?Q?TNfdCsmfXaIRjEqM62jbIjIyS18uD149v8hNZEVknbltFr6hJjl0ftDSiCei?=
 =?us-ascii?Q?6RrAQmM1JN9pyhS5SuIqIvwHBHZJ3jXcWYEDk0aeCEcQIWAs1mnhxn/a33ye?=
 =?us-ascii?Q?u4OHiewbZZhDhVPmWTzDwaYPoETFm3LcLKTrDrEBYSWwZKjAyPsdxz1eEuo8?=
 =?us-ascii?Q?ZF6z1Kt6kWOOl1dI4Lc8BwCUQ3oqw6HZ94Q2nM+dAOEXGQJZPmxULDgXcCwr?=
 =?us-ascii?Q?JilWD26QVRb89DfI+y0M/pGTJRliN0Lzwc/+mDhD6tZx+/RrPR58G+XNVVfy?=
 =?us-ascii?Q?LtVvggxVn2eYr40bCTHCaRfsARBIeB15eZSm1Xg0x4ur67scVVJG+h9eFfPN?=
 =?us-ascii?Q?w1X50kGqjilA19nEIKSo39Tvhhe13S2YbSLx9n6sYPu3e/jcWbOhoR9jz4J5?=
 =?us-ascii?Q?H8LjOBpKaZjPEj5HsMai9utdaLvURA+iaMVvjEpPsKuHoYCA7O7E5HfupEF0?=
 =?us-ascii?Q?zon3Sv+OYt6F6JW4bQJC4jZkAQH0x0ebsJ2dG1rDOHeLq1esoYB32X8Z/n5C?=
 =?us-ascii?Q?MvBIEwll8WpcyA2KNBfktaZpRTjHOLwuy4zPrxLepTFmJdtH2aY6SMJFAW60?=
 =?us-ascii?Q?CKjj3scU6SmArtbRdXQ1djBLRcN0nwq9+oR25mQ5qXaB3Zi5vDMUbdIIALl9?=
 =?us-ascii?Q?FxV21xKKMF2m/GJ+LxGSUaAl7P6t/ChFWEHZMasXEo1GJiU91msRK0u4MBan?=
 =?us-ascii?Q?E4NuLAdPwNHFLxiIJau/HkCllIXLgRIZ6tFUXf8Jb0LQZgYpYMTwc4iPtgjR?=
 =?us-ascii?Q?sSa3qsw/3xPnDMsX/cR408736ZTU41FWLWE/JsZwvM1c74OZH1Up2ZoiBkGf?=
 =?us-ascii?Q?c2UC+OvQQRXhQXxvI/QxMg6UmkMbg+VNGA6QfN1YIrlAI14ohA3uEWM8ay8X?=
 =?us-ascii?Q?oDMgjpoz38p8EQUzqgxCPqEXv849VJU7zBdAMsXsQnpSn2URAjf6CTteWDCr?=
 =?us-ascii?Q?rRTzdUtNk4p5AEkvRYI3nklTnGHyGO8vAGUg2l90/I51xiXf5YvUn/aCPj1z?=
 =?us-ascii?Q?4Wtcn2sCL2s/Ze03Hx/sxCegIUDgbQ9I+aWiq+Cb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fe6059-6367-47f8-054b-08daeecb38c5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:16:22.5960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYnIcZsrZa7/xRWzFHAzP7nkw/JBb6yWOgDhV/+NzwcoyWzXeskTc726y5LBV8jgbzxc05d+I3Tk6JpxIGd6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 11, 2022 at 11:06:19PM -0800, Ira wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL _OSC Error Reporting Control is used by the OS to determine if
> Firmware has control of various CXL error reporting capabilities
> including the event logs.
> 
> Expose the result of negotiating CXL Error Reporting Control in struct
> pci_host_bridge for consumption by the CXL drivers.
> 

Rafael,

I should have CC'ed you on this patch.  Could I get an ack on it so Dan can
take it through the CXL tree?

Thanks,
Ira

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V3:
> 	New patch split out
> ---
>  drivers/acpi/pci_root.c | 3 +++
>  drivers/pci/probe.c     | 1 +
>  include/linux/pci.h     | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b3c202d2a433..84030804a763 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1047,6 +1047,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
>  		host_bridge->native_dpc = 0;
>  
> +	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
> +		host_bridge->native_cxl_error = 0;
> +
>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>  	 * exists and returns 0, we must preserve any PCI resource
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2f4e88a44e8b..34c9fd6840c4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -596,6 +596,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
>  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
> +	bridge->native_cxl_error = 1;
>  
>  	device_initialize(&bridge->dev);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1f81807492ef..08c3ccd2617b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -577,6 +577,7 @@ struct pci_host_bridge {
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
>  	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
> +	unsigned int	native_cxl_error:1;	/* OS may use CXL RAS/Events */
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> -- 
> 2.37.2
> 

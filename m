Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516CB64BCED
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 20:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiLMTOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 14:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiLMTNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 14:13:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A662610D;
        Tue, 13 Dec 2022 11:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670958744; x=1702494744;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m6qETDwoF7rVX1kZwHfzJfB0IH+a0Xa6gPTG16CmYDg=;
  b=Uqruci/0V+lCragpmH0iy2I/3Nw9L7SQMhDZcDL7mKUvyNFIlnnAn1hk
   USmG7X+tsVmvF4/ha90RKMcJlHXceg01T9SlolYqgcV+rGvps0c7SwmqZ
   rylOxxPrksRttL2EaXgJ62pbrKTXWJxFoN1eqcQu5fboPobuKpihR0ikJ
   DsCKL57DSZM3cSro++NIYY7s4P/H/L/AnHwt+DA1lQ6ex7pauctWqYv32
   9my/CdetSJNu18WMLeVxS/JihD1yKoZjfZpajcYAwvpxt+Ub2/QvKEMi6
   dTx74VRoMLyq/LjOdSmE5ZtrBYstMFJWo9s0N/M02TFDGwXQ8ni2LdUgN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="318256915"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="318256915"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 11:12:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="681246586"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="681246586"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2022 11:12:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 11:12:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 11:12:14 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 11:12:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZktsMqE4ACITmMS/yEEmFbHxwtEW55ts6fsgMP/Jl18dSdIfQHC9Ne1AoGzLPAnBx3ZqoR7UCWfqN240L6ZVw4Q5pg394h/0gs4mkCbaztlD2+NYJ01jmP6coo7GRoO410oq8a4oXiXfyx4ru0xbH92nJkjXwBoJHH8Ko9fSCutmo+8JvZYTXPTfRGXCkaTSH6AQ4pxMEeovP2htexIvET/r8eA7qW1PbQq1StjpBMe90LB8YnKtxusEls95CL1jUfB8NWjCn9ADdInyVJsfmsSiX3BKRxz0cV26PxwAEGJhSsxzGCbQ9wzsi0PKoEkElV59vRsFFVE9PtFCwL7tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvHiMHQpYpifBWIH6sQRuepRT5eaTxLklIr+ax7Z4Fo=;
 b=MKjUOWqY2wFfl1Hr6pgqpVfqxkBBykTj+nrjCfP0UH/qnr7EkcIlPEU5den91Zqd7Ix+FSRcmqr1GOZv7K1voKnZWFfDPY1abEZbhtWLXG1hBFwid/U5IO4hqs20erP2ddwMUMDvYrym3YJ7qSwhAMtei1r8BzPDnrnt+PGKdk+sKMRqsVHp//RSJch49nF0gkic2JkFP2khix27SgdZlpHFIFN2eLBRkT67o2zqPB7nFBaG3zWcZGvefRfScBujv+CNkr6sAr+ttCrehOjlUeErVk4ry6v4FUp+iUenGY3LicMWyE2BbIb+OWOByOCxdOsduOMLg5tNUDvRfSNcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB5888.namprd11.prod.outlook.com
 (2603:10b6:510:137::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 19:12:11 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 19:12:11 +0000
Date:   Tue, 13 Dec 2022 11:12:07 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V4 1/9] PCI/CXL: Export native CXL error reporting control
Message-ID: <6398ce8773383_b05d12941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-2-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221212070627.1372402-2-ira.weiny@intel.com>
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: a5633cf6-75ee-4254-a525-08dadd3defaf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eS2EQJbJ02rlsvb8LFclm2YEee06fA8xyRDrQjbL8RozlCdNUL6VF5IAhIR/kWE2ukZkrpfsstxiztqmVJvbPqQIOdnZ0FyqqURUyIW10ZsZkolgDYRcfEZTuSszeahiEPgnzDeR9n1hT0S7LA8wy2jA72UOSTnsbrtTDJpJW6VjSdlig13SGV/pk8BjS9YagvL9T4+Mj6w5ZVJt9kHodQa1ME1//q7V/QlUOTeg09uVoYYJ7oUu052aN3pV+jEhyyjb+A45WkujXilCyzOz6mRq2ELuw9uLZggD/pQSTbOTvsxCvcqVwgrnxjS6qkl3XfME5vwutj+shLVd3fVU6bSetg/yhqPHpEnU+BcobqJn1ik/4gtfrtb/BQzi/yXWD6fFaaTFvPrJXAFOEQmCXGpiCciUx9TejFQDRo3+yuzIAMQlSfsXvQ8uZ9gKWiYHalrB9fyZDQvZrYetlU79EYed6tmuD+k9lLaH/ufYs3ESbFQATpOxmPQUBrI0bPi6FOw88ww8Qs6aH5kHdlf7sXg8TpQVGNawSg2bj7Va5XHICJ8jusMN9x8WQ4WDE5rjHiTzJ3JdlBWnGL6cJifLRsmsuz0m2lTKfJIYeBLtW2wkUS+ixn1MBOztFsYqdxPXd0Kbky4n1Yb76pIUsSo4Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(82960400001)(2906002)(38100700002)(6200100001)(8676002)(86362001)(6506007)(6666004)(6512007)(9686003)(6862004)(54906003)(5660300002)(8936002)(4326008)(316002)(66556008)(66946007)(66476007)(26005)(478600001)(6486002)(41300700001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fg/E140xPddk9OT1FjdLtYmVJEwF3BqOljo/nQQWEHqFJX+AvsA3ABGnNtaA?=
 =?us-ascii?Q?t4Ludhj7IYZ+VFVsahSjiMmq6FJuIkJoEKD+jIcpRcSdrDVgCOy68V41XyoM?=
 =?us-ascii?Q?M0JVBchrVzjJQjlIhwgYXBUpCr8KgzIQl6MX+s10+7ZbVJWUp0ryssw0LwMW?=
 =?us-ascii?Q?bTV3dc9FBA2d8YpAUUfP6pPZ0Y4/ux8RaSgrnUbLVqvHArlO/xYCWbDeWuPh?=
 =?us-ascii?Q?HH07sir8C/bYekNqW5DB6+xxZtFRjHznEUTlIQQwYzoCFu4uk1Itw2ACu56s?=
 =?us-ascii?Q?k0XKRwrvMC6xu2ppFw4PdwPwbIANvgFiwhRDb+Pyi7hh0La/9sYq3zEslYE5?=
 =?us-ascii?Q?O1HZ9sMBG1nFpc10LXr4geW0wTUigelxHND92wqwAZIDs5hMfkSkb+S9f5iB?=
 =?us-ascii?Q?hH5EgWJp2InqjuokeG/nm7Qjf5L9TFYEfrhi4v890PqSOUCGBcy+P6RRvAHT?=
 =?us-ascii?Q?e5KnB8zyKQXkRNTGjwpS7EvkbJ3yTN24x0N2NCNndSJZ1XBmS8njPDKn/SXC?=
 =?us-ascii?Q?Hd9d8bDG1PzLUjC0mzFgacJMcoKD27dgWRwCpuScNdc0nF6GlLPt9yh+bkvp?=
 =?us-ascii?Q?AycWPj9f4vlBxZRo10l97M7/2ufq5l0psBCByBozABHk7+mUSPeGfzjsbEd1?=
 =?us-ascii?Q?oNzCvHXQpCURAX6ungVMK30fpksOPjj5FP3mb3Ya/IGtB0JbpPDl2oYnscux?=
 =?us-ascii?Q?/GLQU70FKRoPhbaGUdGCcKic3n7BTODI5q2V0RHtT8Jh8URVTBXtRW1zeCdR?=
 =?us-ascii?Q?BVe+rRnpNI/OslUAWVA02Wra8OPS1DwkhMGlxxbi6s4EaQG/AslZIAK+vJSz?=
 =?us-ascii?Q?I24Ecp/L3TjiU9EAdYLpso+rWyUoAeEok7qQWdJ3Q2+DFLGkeJ5Ovxc67os1?=
 =?us-ascii?Q?9lIyJ/ZCeoS5wFXi4hf+v02M6o5Fsz2XHfsjBYOqiWQzKtaiAeK0T+1CsAmB?=
 =?us-ascii?Q?3HKYjtX/MgVs36CVwXR27TbW5dl/BIycX/auttohpt0cNEzV7nsESJCBink+?=
 =?us-ascii?Q?3+EUGHctKA4JxSXNOqaipiZPF7F5ZvIpg2kmYP2G91FQO9np5o7db4J/cKJn?=
 =?us-ascii?Q?NST2BDJH662VJy20r7rjl1agfGVSGvtrHFpbgfUxWEcOapM7ShxwlnP2prLM?=
 =?us-ascii?Q?fZ0NbTxoExM32wMCH3A94UOO0yeidOjg3YvjPdh12zk5OjNgZtsznH/0hDo5?=
 =?us-ascii?Q?JeZNYA+g0ssb9QLY16YoExSk4+VlKaFe65uKFmkJ9oGWuzismHZikQsJeKzV?=
 =?us-ascii?Q?H3z+OMUbTvySSo9z7G4RvTPIwjww22KGucsd9N8A2dUvEMFcEGcQbDyzP7Nk?=
 =?us-ascii?Q?8Fv3AwjjMAGA2owm/SQFqr62YhwkDnywDeeNyAlYWUIXo6tbZfjHT2csLI0H?=
 =?us-ascii?Q?XZ+SNryj9lfPP0CNIMmRbb2658CAt/Rlv/PMEiQRHUk0v86PUBGV1TKkAzlR?=
 =?us-ascii?Q?ZHGEptITaU59/1mSHVfxzlQzEO0LLqy/8XRQaH+DM35z/tCYGQ2NRnY0RYr9?=
 =?us-ascii?Q?nQqx8UH50P2YzNda+w2etsxMSZPwsB5w4Sb1Ve8xQYNGniCX3soaQ3lvmXL5?=
 =?us-ascii?Q?90/iXxBbCNMRJdX8GSiGk2jiH5e7AcYam3RCQBBPCYJbnJ7+WU7TnVH2JZDW?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5633cf6-75ee-4254-a525-08dadd3defaf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 19:12:11.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +51uY0cQM59HaqSWl1h/Z8KZzFtyxxtxrJiMT8eEoEKwzQpdpjJecgRm8jaKGsTsN0vRUw9hN+i9lCEoN+OTOnEmKTavTh3OisfRS+D96Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5888
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL _OSC Error Reporting Control is used by the OS to determine if
> Firmware has control of various CXL error reporting capabilities
> including the event logs.
> 
> Expose the result of negotiating CXL Error Reporting Control in struct
> pci_host_bridge for consumption by the CXL drivers.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

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



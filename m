Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E85648A57
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLIVtv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 16:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIVtu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 16:49:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166A1581B;
        Fri,  9 Dec 2022 13:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670622589; x=1702158589;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UPIai3LOfgwBO5rh61+L2xVqgLNAQo2fVXFfIf/hrY8=;
  b=WpI2/rtO7jVrwASlTTQJmC8afIKqmpK/stBaOX5xENz1yEtUv2+cwAeu
   SgccxDf/6r2rm/BpCAQYH35WIH9/YV8MaRY6FmdOIHylAU51ZO8/riExL
   sLK6AVj86m8xnj7NuxD7jtCaYmMX3ua8PlszYTHIrFdtRS+NhENrLrGeK
   lf8k9sk8eQEySoLfbwO80FKKN1SLiHJPN+zYVlIIJnu+Ns2ueTdd2fe0Q
   D9tlT1Rwak1fYfkijfO7m+j8/jhf9e50QQ1xawszFIsrOfJR8aRnmECWP
   Gp7xy0q+zTOJc1uBqQLz7F/inqgNpCs77coYTLuESA570iB1RLMS3i2Ob
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="403810055"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="403810055"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="892809367"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="892809367"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2022 13:49:48 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 13:49:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 13:49:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 13:49:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAPYVa8/7Ffcq54DD9gdzoFu83/zWc9/sUrycUpw7S8YM8eQ7+m4GttHTJad7Puqba9LnFdyzzW0s3FMmE5Qe3BMQKkObz4FxIQ6gFUVuY2KKV9oeeAnRF6KN1+OfLRLRwn5h9JQmIJxJ0F0ZkYHpvIYtWurfL6QZYdi0m0oxpC5dQNZ1Fwt0jGQx9klLX0W0v08Webzu7fLWhMLpVcKo9ZEl8uatXRhtBuM5jaUhCHWrc/GbBbP3vFbjmI4UdkmO9RZX3e0/dkgTEAvSTyVcckvpB33JeCZCnm2fCFyub3sG6TAtyju3cMAvw8I8wR4sTBeeak0aqcfkg2/j4rcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th4NIM3KOuHJgr42P/n4ybQceK95CAnlnqwg2TS3jTE=;
 b=fPgK7C8f5eq2CYBwsIvCt5RkvVaLgXQuAL8v8b8UACH4MD0oEW5nlR39fe/Dbc+i6Ansl8aiW8g1eULepa8vTMc+BcYfsxc7OC9vCYxrERt8gcSovgkg3tqrGW4RxCprozXKPg0k4CzsEkXy2HnVqFnuAmh4KOtnkLmvdsrYQPTgItfe9ZoJFTQmHMrlu3pzQaLLpAH1+BSyBtJFQO9DrOglE3f7bGLPaNGC5oN7xk67/EBgtVJwD6mjLJIkHmMt7A7BrfJifMkFKh4L6B9J5dDZTn0DOyz+uW0rUFn4LGXgtfCX1t4S8rhV6v0b7jfD6FfRdrLptQK8eYhIkMf6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB7891.namprd11.prod.outlook.com
 (2603:10b6:208:3fa::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 21:49:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 21:49:43 +0000
Date:   Fri, 9 Dec 2022 13:49:40 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V3 2/8] cxl/mem: Wire up event interrupts
Message-ID: <6393ad74877d9_579c129448@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-3-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221208052115.800170-3-ira.weiny@intel.com>
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: d60da63e-c3c4-4fac-b55a-08dada2f47ec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4E4hoKifvmCWBPtyXDBvzMnxCkGtUbmOdIxwtqzC1yYwR4+WAsxSfPwBP6BYD5PXiQVjmTCj6PHOo13g7BhI4Kb6MYSAq11AkWzOb5RkNaQ7gfFs6Fz7EKqtzrBvEpQINuNzKyWrDQFUrenYj3lT8/K3OtZD069a0sO2SrCwVflDGQYZXXwLFEhYDXH8msdhuC8mC1Z2d1UJtLf6Wu88EFytvJBl5E85c32g+HfT1VCA9IMLVnMVu0X3BVN30tgTEU1dMK20U6LrPx1d+7U1cPX03ncl2METF1NSshyBsW58EObfaEsGeL77fwVxoHV1K09Dw3UGCalHuiXh4d5ZyhqeIC9IoO3I9FS+GdGPKfiLXArLG6l1tG9CnteImnGA8DJrcuvtTRM1PRnPx35SXQNiSQQ56fNN09Qicyk0dTdHlZ52SQCP81Vfzd1TdH8F2Rc3GGUzACWDlClJVBgrCOFJxiaRHaPNUHZM6KJCa18KSEnkwq0L/KLggijYkKu2W2ukQG/To4l4F6iPxmHZkap83Uc5uzZfKL5aS9IlUFYSqhfS9M4pzufg9dCrewoDAHTHCLGy4gT/GrjJIRYu/mSiyNlUCVfyMJ/GG1IgInHSQ4sUdmcP59gsLTEirhwwieyz4GrfYYVOIsj9ZtKGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(8676002)(30864003)(316002)(478600001)(54906003)(5660300002)(41300700001)(66556008)(66946007)(6862004)(83380400001)(8936002)(4326008)(82960400001)(66476007)(6506007)(38100700002)(186003)(6486002)(86362001)(9686003)(6512007)(26005)(6200100001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZXrqEQpgFw8kutIbJWfSeLsPAgN9yCJ/6lVBeb30ICcRgpGNrpBThqPoGFOU?=
 =?us-ascii?Q?tNcM5+RXIuI3MJTHsLJWfB8KYSJ6pcIj9cxjSB/4bPcZA+UPoW3Tsrf/jhzm?=
 =?us-ascii?Q?bLEjrVuvL197XThuwReOmjG7e52fvy6VMJezJjwcxFeFQ9i0J1k+wDUBYzfo?=
 =?us-ascii?Q?KKM1Mhg2fl0U+O0U44VgugSoPVdQeTysSzSPtfZO+KyzFQqNqeB/Pjo1zax6?=
 =?us-ascii?Q?5o8PMmU1Q7/kYT/efYVNKZcGPW/25QR5a+I893/5xIIkv33+XvB0jJtYG/B8?=
 =?us-ascii?Q?rer7MOyC/RX8XPLJ3SueoURbr9fJ001Dyog+UIEqNo2hZ6Tebw3e1QouoTVJ?=
 =?us-ascii?Q?dLGQw4y+3qxy0yMzIeRY1heh12zALxMMxmRi1W7FuCo4dZvLDsQUVCoDrDXa?=
 =?us-ascii?Q?jVp6ZorGhpXFEISmaztFitphWFwD8cA1IiOEYNDK5/UfmAjLY7ox0lE/9hRW?=
 =?us-ascii?Q?kztte+sFvo/i6YxoC45DLIPYjCajcBXtfSRst+w+TjnUItua6UibbYWUF/0K?=
 =?us-ascii?Q?mncljY3Xk9PrqHhD6Cb97AqSbryvf4CcUqeC9M34F9zUKNXnevth9wiTsWEQ?=
 =?us-ascii?Q?77d/eCregkiUObrdlA4Ju+IOSLcEOr+fwTOQ4MyRz3jQvPm9sffZGOE5Srof?=
 =?us-ascii?Q?cgCV6e8a3iUJSc1FI9eogZ7PcK0yGNBRAFV+9RiihVKI6fsTeF3jZsJEkWeB?=
 =?us-ascii?Q?VaWZ++KjWTXKt9804Zm+soVZvKjznUE6JNp3DIgbCuh9jzxu0H5H8LCTNfut?=
 =?us-ascii?Q?ZpROzsAUI1UJz3tIJxNdozohDuJoumaY0QWc1bpF8oBrAUd1SLCQy6dmnkKG?=
 =?us-ascii?Q?UH6lGOAT7RAdQkOzCb3TNeAai2oCgszf4c9JSbi3yiGWAy4gMBfCnZpy1/Ct?=
 =?us-ascii?Q?i3wNWb2DWYvEV5VQEJWoTl6r4h10pMkGPSjZt1Yym2OtGxghWd9xuSB9dNcC?=
 =?us-ascii?Q?zAATKfnJvtUUpL4vDh8PGqUUgJ4j2dozzyXQFx1g3vkymJSQHVYwSH3kaXU6?=
 =?us-ascii?Q?e8Bp4esrV+RCZ/JGWcpjJOF7tRbwynQW4DwB3ZjrBeXKxhVpNNOEN+Vc/ihC?=
 =?us-ascii?Q?JVmHR4FGnhv7nlSgVrjGk1PjJcPdvTb9+z4br/tVPHk+Mgdo3zbWQLPd/Wjt?=
 =?us-ascii?Q?30JGZunQCrOPuNETCmtDlB+KGDgezF71C0NFtX/P4C1Rpj/LlVDz3m4STEWx?=
 =?us-ascii?Q?+xwxB35oGk58EKFs0C9rbAaPcFBVxJxrWbAEDvbcJYAUWGHJqN23UxMsLaRG?=
 =?us-ascii?Q?c1J9sKv2Hz3TDwYFMl+81JsXC4zr14DiYFjrxN/rNgFWZfizZqpo+dFSCGqk?=
 =?us-ascii?Q?ErRCzN/6y4/Zh3GF00x5gGbUiL6cFQGb4zk6Tmhwrds0JsDkm375viUwMcnq?=
 =?us-ascii?Q?1dD5xklq1I5CiGhNt6DguOq4VfhFpI/JOkwAOBLbChN5QInE1uzPYQl2ELoo?=
 =?us-ascii?Q?qD1XKgYvv612Wt2t6cS5a5salPq/2JAs9rj9etSnU1c1d4AI2PhZ+k+f4/PK?=
 =?us-ascii?Q?qL4ZxFAnlbJ/1l563Gq7MyvRZJHQ/5H8ffAefxcCwIAaWCJgJygz3FI0PGza?=
 =?us-ascii?Q?r0tdr5mThGyRFVLoLjOsAgCglHEV9l4yhkA5a7vC15e2owF9krUZSF1HonqT?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d60da63e-c3c4-4fac-b55a-08dada2f47ec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 21:49:43.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ejtkia/qRiYhcZibnwOt6jwdj0rgLkoAkWGfWWUR3Boxe6BwQrxqGogXiXXMPszORNIXPSCa4bNUcoEiEeGVxW2ao6tJL3mqKTDjE0Eih+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7891
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Currently the only CXL features targeted for irq support require their
> message numbers to be within the first 16 entries.  The device may
> however support less than 16 entries depending on the support it
> provides.
> 
> Attempt to allocate these 16 irq vectors.  If the device supports less
> then the PCI infrastructure will allocate that number.  Upon successful
> allocation, users can plug in their respective isr at any point
> thereafter.
> 
> CXL device events are signaled via interrupts.  Each event log may have
> a different interrupt message number.  These message numbers are
> reported in the Get Event Interrupt Policy mailbox command.
> 
> Add interrupt support for event logs.  Interrupts are allocated as
> shared interrupts.  Therefore, all or some event logs can share the same
> message number.
> 
> In addition all logs are queried on any interrupt in order of the most
> to least severe based on the status register.
> 
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> ---
> Changes from V2:
> 	General clean up
> 	Use cxl_log_id to ensure each irq is unique even if the message numbers are not
> 	Jonathan/Dan
> 		Only set up irq vector when OSC indicates OS control
> 	Dan
> 		Loop reading while status indicates there are more
> 			events.
> 		Use new cxl_internal_send_cmd()
> 		Squash MSI/MSIx base patch from Davidlohr
> 		Remove uapi defines altogether
> 		Remove use of msi_enabled
> 	Remove the use of cxl_event_log_type_str()
> 	Pick up tag
> 
> Changes from V1:
> 	Remove unneeded evt_int_policy from struct cxl_dev_state
> 	defer Dynamic Capacity support
> 	Dave Jiang
> 		s/irq/rc
> 		use IRQ_NONE to signal the irq was not for us.
> 	Jonathan
> 		use msi_enabled rather than nr_irq_vec
> 		On failure explicitly set CXL_INT_NONE
> 		Add comment for Get Event Interrupt Policy
> 		use devm_request_threaded_irq()
> 		Use individual handler/thread functions for each of the
> 		logs rather than struct cxl_event_irq_id.
> 
> Changes from RFC v2
> 	Adjust to new irq 16 vector allocation
> 	Jonathan
> 		Remove CXL_INT_RES
> 	Use irq threads to ensure mailbox commands are executed outside irq context
> 	Adjust for optional Dynamic Capacity log
> ---
>  drivers/cxl/core/mbox.c | 42 +++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 28 +++++++++++++
>  drivers/cxl/cxlpci.h    |  6 +++
>  drivers/cxl/pci.c       | 90 ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 165 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 815da3aac081..2b25691a9b09 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -854,6 +854,48 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>  
> +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> +			     struct cxl_event_interrupt_policy *policy)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	policy->info_settings = CXL_INT_MSI_MSIX;
> +	policy->warn_settings = CXL_INT_MSI_MSIX;
> +	policy->failure_settings = CXL_INT_MSI_MSIX;
> +	policy->fatal_settings = CXL_INT_MSI_MSIX;

For Robustness Principle "be conservative in what is sent" purposes I
would do the Get Events first to make sure that nothing is steered to
the Firmware VDM, and warn the user that their BIOS gave the OS CXL
Error Control, but did not shutdown event interrupts.

I.e. if the event interrupts are still steered to BIOS then BIOS may
think it still has control of the event logs and trouble ensues.

> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
> +		.payload_in = policy,
> +		.size_in = sizeof(*policy),
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
> +			rc);
> +		return rc;
> +	}
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
> +		.payload_out = policy,
> +		.size_out = sizeof(*policy),
> +	};
> +
> +	/* Retrieve interrupt message numbers */
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> +			rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_event_config_msgnums, CXL);

A question, why is this function in the core and not in cxl_pci? For
cxl_test mocking purposes? Otherwise seems ok to keep this in the same
file as its only caller.

> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index dd9aa3dd738e..350cb460e7fc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -194,6 +194,30 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> +/**
> + * Event Interrupt Policy
> + *
> + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> + */
> +enum cxl_event_int_mode {
> +	CXL_INT_NONE		= 0x00,
> +	CXL_INT_MSI_MSIX	= 0x01,
> +	CXL_INT_FW		= 0x02
> +};
> +#define CXL_EVENT_INT_MODE_MASK 0x3
> +#define CXL_EVENT_INT_MSGNUM(setting) (((setting) & 0xf0) >> 4)
> +struct cxl_event_interrupt_policy {
> +	u8 info_settings;
> +	u8 warn_settings;
> +	u8 failure_settings;
> +	u8 fatal_settings;
> +} __packed;
> +
> +static inline bool cxl_evt_int_is_msi(u8 setting)
> +{
> +	return CXL_INT_MSI_MSIX == (setting & CXL_EVENT_INT_MODE_MASK);
> +}
> +
>  /**
>   * struct cxl_event_state - Event log driver state
>   *
> @@ -288,6 +312,8 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -525,6 +551,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
> +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> +			     struct cxl_event_interrupt_policy *policy);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 77dbdb980b12..4aaadf17a985 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -53,6 +53,12 @@
>  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>  
> +/*
> + * NOTE: Currently all the functions which are enabled for CXL require their
> + * vectors to be in the first 16.  Use this as the max.
> + */
> +#define CXL_PCI_REQUIRED_VECTORS 16
> +
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_EMPTY = 0,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 86c84611a168..c84922a287ec 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -452,6 +452,90 @@ static void cxl_clear_event_logs(struct cxl_dev_state *cxlds)
>  	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
>  }
>  
> +static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int nvecs;
> +
> +	/*
> +	 * pci_alloc_irq_vectors() handles calling pci_free_irq_vectors()
> +	 * automatically despite not being called pcim_*.  See
> +	 * pci_setup_msi_context().
> +	 */

I think a more important comment is why the flags are limited to MSIX
and MSI, that's a non-obvious CXL spec constraint.

> +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,

Since I have some other fixups below I'll go ahead and quibble with the
name. The 'requirement' is 1 vector, so
s/CXL_PCI_REQUIRED_VECTORS/CXL_PCI_DEFAULT_VECTORS/ or something like
that. As it stands today there are diminishing returns to ask for more
than that amount.

In the future, if the code knows better that a specific device could
benefit from more than the default, then it can arrange to override
this. Absent that, today there is no reason to try to ask for more.

> +				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (nvecs < 1)
> +		dev_dbg(dev, "Failed to alloc irq vectors: %d\n", nvecs);

Just fail the driver load if this happens. There is something wrong if a
PCI driver cannot even allocate 1 vector.

> +}
> +
> +struct cxl_dev_id {
> +	struct cxl_dev_state *cxlds;
> +};
> +
> +static irqreturn_t cxl_event_thread(int irq, void *id)
> +{
> +	struct cxl_dev_id *dev_id = id;
> +	struct cxl_dev_state *cxlds = dev_id->cxlds;
> +	u32 status;
> +
> +	/*
> +	 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> +	 * ignore the reserved upper 32 bits
> +	 */
> +	status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +	while (status) {
> +		cxl_mem_get_event_records(cxlds, status);
> +		cond_resched();
> +		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static int cxl_req_event_irq(struct cxl_dev_state *cxlds, u8 setting)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dev_id *dev_id;
> +	int irq;
> +
> +	if (!cxl_evt_int_is_msi(setting))
> +		return -ENXIO;
> +
> +	/* dev_id must be globally unique and must contain the cxlds */
> +	dev_id = devm_kmalloc(dev, sizeof(*dev_id), GFP_KERNEL);

Yes, the id is simple and fully initialized below, but this is not a
fast path and the rest of the driver uses devm_kzalloc() even if it
fully inits the result. So its a consistency thing and maybe a "save the
future person who adds another field without initializing it some
hassle" thing.

> +	if (!dev_id)
> +		return -ENOMEM;
> +	dev_id->cxlds = cxlds;
> +
> +	irq =  pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting));
> +	if (irq < 0)
> +		return irq;
> +
> +	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> +					 IRQF_SHARED, NULL, dev_id);
> +}
> +
> +static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_event_interrupt_policy policy;
> +
> +	if (cxl_event_config_msgnums(cxlds, &policy))
> +		return;

If not all interrupts can be steered to the OS probably best to abort
the entire event setup.

Otherwise if you can steer all to the OS, if any of the below fails that
should be a driver load failure. I certainly do not want to debug
someone's system that randomly failed alternating log type interrupts.

> +
> +	if (cxl_req_event_irq(cxlds, policy.info_settings))
> +		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
> +
> +	if (cxl_req_event_irq(cxlds, policy.warn_settings))
> +		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
> +
> +	if (cxl_req_event_irq(cxlds, policy.failure_settings))
> +		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
> +
> +	if (cxl_req_event_irq(cxlds, policy.fatal_settings))
> +		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -526,14 +610,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	cxl_alloc_irq_vectors(cxlds);

Just pass the pdev directly here, no other part of cxlds is needed.

> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
>  	if (host_bridge->native_cxl_error) {
>  		cxl_mem_alloc_event_buf(cxlds);
> -		if (cxlds->event.buf)
> +		if (cxlds->event.buf) {
> +			cxl_event_irqsetup(cxlds);
>  			cxl_clear_event_logs(cxlds);
> +		}
>  	}
>  
>  	if (cxlds->regs.ras) {
> -- 
> 2.37.2
> 



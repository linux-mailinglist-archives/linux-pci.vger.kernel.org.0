Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F031B64BDD5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 21:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiLMUR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 15:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiLMUQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 15:16:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D326567;
        Tue, 13 Dec 2022 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670962550; x=1702498550;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ihGPdmu2hyvK7jpftGzxTnFURjdU3WQV6NNETXvBpHg=;
  b=m9GkypkzC/vaTbyKBIm/mo5BeDtn0dSMLolD4L5h4v1AwAIR8Bq8WxNK
   WZs1lKNX5czH3RD8c/xVbchwn1m/vgkh9PSV9ocJthHaLqEotieIxRx57
   HTsWo+DhmgOUcgoVW1SUyen9zHgWRadRExm7cfFLFDJF1Sg3/L/eabEaa
   B1bkX1znhaDICihO/bpSkByRmGxU/gE1zBdLQl5BKyrji/C5usHSnEH8R
   ZwrpHA7h2QZQWJx8DkwBGnpw8KXNxtnst7bJvaIc115f55983578Cha+/
   k97l9G2XEqN74M7Rqn65ifDi7/5JrqogpOoi8UtkdsJbgfS+bqiq+g2hI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="320092515"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="320092515"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 12:15:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="773086757"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="773086757"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2022 12:15:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 12:15:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 12:15:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 12:15:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0x7kjkT4A45zNFfbiQCMQM0iIRKCOD8kA9uaAHzRZbUdvsNswdbeUzmSuuh5PV67GfsPvdMBejYS8LhpNXHULzAudYlsdY6a8nDTS2TBv2J309YTpyzK2uRbyC9+evf2ONqoTQ+9yKCTvAcRJwjg+Hx3LCwU+sCVpjDZJWSHZjRymJXfcNmNjo1hGDNjMq2Q+M7XzaivLwyQWgvEQ1GYbTLhkV4lnH3reOvSPB6dWHwLu7S8tFMCzLo7j+janXQQGu5drYqxDrRR5oaAIJbcfGxHSD5yxDG6calppLWZvZCvVsXkfbuT1oO3thtjsXZI2C8osaYRM7IZskrfDrrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WQph06gf9M5IXH6b5ZajZmJHOKSN34kGTvfUesmfXM=;
 b=VeHAvLoQH3eMtW8Upv7koXgDDvcfaRY0xIjMo5v163XZxukk7MeQm5u3wo4zZ5ynM2f5Nt2WeGyEl2kd2qAihbQ3ZcgnxOKUcqGxetbwBEfmhD5iwe34NJPgo9Eu1TlmHpucTmd0zyjS8PmOMVgcm3QsH2UO1/r3ZxKnbdt/Cl24K98jus0PpEs/tWkKuILCzZdxm8pTEynJS9tLQI0Pg9ZUruAcYJfCRRct/t2Q8+V0/tG4sZklHke6PxUo2+qnawkPvdmANZoc4weHfRNadWvNI4an3roUQMMR0vjJB/H9KFXDpOOf90uq7jcs8Z/juJCDEsSiubr6V04/qatcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4578.namprd11.prod.outlook.com
 (2603:10b6:5:2a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 20:15:45 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 20:15:45 +0000
Date:   Tue, 13 Dec 2022 12:15:42 -0800
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
Subject: RE: [PATCH V4 3/9] cxl/mem: Wire up event interrupts
Message-ID: <6398dd6ed80fa_b05d1294fc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-4-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221212070627.1372402-4-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM6PR11MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 696bcefc-3156-493e-3658-08dadd46d122
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A39IU6JXBox7PJmz4dBxODmbTuZUSpt/rWi4ijlA3hNtaa5wSBCaF7xFWbuAm1Oo2b76N88AgR6gn+NRIg8a/up6SrHTyWZseZXWrv5RJBLqAH0phgAZkvlQsAVORt0ZgASemjbERg46eZCyUS0qiehahY+1hwwUtACKf6PnWe7ZUlCBqHGaCtnyIFqcFa2UNjP09TvOrOZEj8X2qHA4XHJQHkZc5J1YV1/AxwLx5UvRci9w1DVGpmM6/37f/XYlLaCI4yunVBZ/kK3pzkeu659TgsLRiQ3ACK8tj+YIDqS0Lbo7Xd6hAZ/2SrprrErfQ7hm3r0C5cR2YDQDVli29ISvI0Q3snH6ma08rIcYan5HyHL50cQNAP64CUkWsWVG/V51n7oVSeSbkcznXhF8IaRuJua/gJoBv8zN29E/PIGLDNsKEipZ1hQJXC94fHBcDaH0UKvakqCT/gOJ4/9q2y0u0i+pOivkw2QNvqtWFwbBC8xaADXF29gsUuiAY8nLjYc6xpvNKjsmP8Qr+QrqdwmeQUIHDtWTqv2AsoNdwiSi58VNEyoiVaRxjAxty3+1QiCPbZjVUUo2KZn36Pr5IJH3ey8X2OWmZd7mhBhGEBZ6km/dfVe4zoNlLBDkqTlC/u12cr0TGG9u1pTHyFJz9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199015)(6862004)(8936002)(5660300002)(41300700001)(4326008)(30864003)(66556008)(8676002)(66476007)(66946007)(6200100001)(478600001)(9686003)(54906003)(316002)(2906002)(6486002)(186003)(86362001)(6512007)(6666004)(26005)(6506007)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYlJJy4Ex2xLLymcsdv3EkmgqOmngNogtuzpGf3zcgtRvFh/Wc1o+NV9PH6i?=
 =?us-ascii?Q?AQ1yRIovyKwD0yeMsbGWrfv+ywpt1N/H2hiAoATfpABp5ydcCX18Ygg+wmK7?=
 =?us-ascii?Q?M+Qe/3OQGrTJgn+KUw+fcc4LdJ2kd5wj7w6T1xoSDbNcoUGJ4ldinlzbEV8c?=
 =?us-ascii?Q?YI3d/0VVOCJTLaskUyqyBnfXyKdxUl42OGG3A6I+hRQ2eGGK5/p5G/vdO9ah?=
 =?us-ascii?Q?1haAIeZI9sSvmaLMsfaazVIjl26XICuv8/UCt74xZNfR46f/TIFYM1Akw7Jt?=
 =?us-ascii?Q?DmcQ+nSR9ulDCFtHhTSzi07p1sm0yNYc81jEEStAtRwjEzpFwzCan6UHE4R6?=
 =?us-ascii?Q?3m3DsodTdW841XbGHr8filcoHh8u4wkKSIKnOROtXX3HGAaGktbJirpnuSrg?=
 =?us-ascii?Q?TuP38AF2bUzWcVaoJrDYgOxfD64B2a/AZRin14A7HisfYmLL1rhN1zaYaeZs?=
 =?us-ascii?Q?rDc1GWi16GXc2o2oqGQXRAjaUbfyyTVuKMFT+HkZJBmUsD8D3e93Bad6DAz3?=
 =?us-ascii?Q?DXer+zrQUemxz35njQG8NMfTB2RNlnENWHlvXGQl0RetucEmi7sNn8kJDoq4?=
 =?us-ascii?Q?3kTQ74njEMuiHDrj612fe5P3WyhkTCQnML5+cOevKHrDUXKPIMm+QOHZBPQy?=
 =?us-ascii?Q?CfwO5XSwJ/zv09UI0wOZvgXiQVPhBJauPrD1JRl5LGmA1wKwxFsjBf2z9kjo?=
 =?us-ascii?Q?63wjF9FlK8qCesj0FxRrOx5Hmi4xJw5B5Bc6b0WXvySFEomIEia8XX9xRDah?=
 =?us-ascii?Q?pqvcCEdOmbYXuLEIqwX9CJ9KRXaQ/Uugm9QuSiEY2DrsfEbMQGE99jIzD8uY?=
 =?us-ascii?Q?gBJWegwF/8z4hX/5HW6suLH3yuJggMhlZEJpWJM5kCXAlQLUHoJFUsnXmnig?=
 =?us-ascii?Q?ZB868ZAgVNZLAEcqO9lvfe0/Y9X2RrYxJa7rrXvRDbhSl+P2oHykmkn7ZWvM?=
 =?us-ascii?Q?aUbI9vGBMxFvGQsnndIIoTc+BU2n9BG80ibq6UVFmLvQ4uZAZga4xcimH3Ks?=
 =?us-ascii?Q?m3VZUNpV2pnjFBT7eKBKZcyqEdHX3aPv+vImGerzzBkkOStmdr5rUnSMTqS+?=
 =?us-ascii?Q?5pvl5f6yThvOu9Jcu9gTNVbrZnG8Tkv9G8IzfTnyLMgxUsLFkzDHm3cJAlKp?=
 =?us-ascii?Q?ZfHSYA9k3ws3c2YDMIlc4IcHhM3FlJGA0IZ1VBs/IDfgeZUW+azxFdhNBrkc?=
 =?us-ascii?Q?o2KD975sMP164DFEYtuMEplmS9L4XSPf4ihTMxxBLnlibDQnHiFCqxLMSC8r?=
 =?us-ascii?Q?Y5SNjx4KFJpMzte9cFoS7vuBPv36yef669nCTKdbl7Ym1OoFD9xSM0hWLphv?=
 =?us-ascii?Q?ptrnyjSb00ASS9/Ho/6N/G9qC8nEVFppsphqFmSOfucjsrxjdvlEMFpE3hGc?=
 =?us-ascii?Q?xPyoidovh06Hp5PWXuVfxvOfaKDsC4HQQ8EgdcZbxbzOwajtkwP8uzU3PpHs?=
 =?us-ascii?Q?27OxpfWDRoI8kSwycfjYhNR85adUuclwC0h2V1J0IyH+rFbqcsjhRhc73Zle?=
 =?us-ascii?Q?WNuBz+/Jb5KoZM6NSNPaAuDZX3MODtHVEeU+LTBt3Spo9wvIqe2FknubR9OM?=
 =?us-ascii?Q?1wpf+kX50jgmRa3vKoQWVO/vU1nUE0Z4uLhKXK+eppDaXzy/lFMhsj7+lRJb?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bcefc-3156-493e-3658-08dadd46d122
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 20:15:45.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm1pZUkkfx7XJjqZ/vBVkFipdqVH/mf3v5Oo38D8JkWsMLW/ZungiqZV6PnIRHdAT7ZZDgrzHoq39uRPENjMMZtHrIN9R2MD0LvdiLAw6gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
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
> Changes from V3:
> 	Adjust based on changes in patch 1
> 	Consolidate event setup into cxl_event_config()
> 	Consistently use cxl_event_* for function names
> 	Remove cxl_event_int_is_msi()
> 	Ensure DCD log is ignored in status
> 	Simplify event status loop logic
> 	Dan
> 		Fail driver load if the irq's are not allocated
> 		move cxl_event_config_msgnums() to pci.c
> 		s/CXL_PCI_REQUIRED_VECTORS/CXL_PCI_DEFAULT_MAX_VECTORS
> 		s/devm_kmalloc/devm_kzalloc
> 		Fix up pci_alloc_irq_vectors() comment
> 		Pass pdev to cxl_alloc_irq_vectors()
> 		Check FW irq policy prior to configuration
> 	Jonathan
> 		Use FIELD_GET instead of manual masking
> ---
>  drivers/cxl/cxl.h    |   4 +
>  drivers/cxl/cxlmem.h |  19 ++++
>  drivers/cxl/cxlpci.h |   6 ++
>  drivers/cxl/pci.c    | 208 +++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 231 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5974d1082210..b3964149c77b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -168,6 +168,10 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
>  				 CXLDEV_EVENT_STATUS_FATAL)
>  
> +/* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
> +#define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> +#define CXLDEV_EVENT_INT_MSGNUM_MASK	GENMASK(7, 4)
> +
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index dd9aa3dd738e..bd8bfbe61ec8 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -194,6 +194,23 @@ struct cxl_endpoint_dvsec_info {
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
> +struct cxl_event_interrupt_policy {
> +	u8 info_settings;
> +	u8 warn_settings;
> +	u8 failure_settings;
> +	u8 fatal_settings;
> +} __packed;
> +
>  /**
>   * struct cxl_event_state - Event log driver state
>   *
> @@ -288,6 +305,8 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 77dbdb980b12..a8ea04f536ab 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -53,6 +53,12 @@
>  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>  
> +/*
> + * NOTE: Currently all the functions which are enabled for CXL require their
> + * vectors to be in the first 16.  Use this as the default max.
> + */
> +#define CXL_PCI_DEFAULT_MAX_VECTORS 16
> +
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_EMPTY = 0,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a2d8382bc593..d42d87faddb8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -445,6 +445,201 @@ static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> +{
> +	int nvecs;
> +
> +	/*
> +	 * CXL requires MSI/MSIX support.

Spec reference please.

"Per CXL 3.0 3.1.1 CXL.io Endpoint a function on a CXL device must not
generate INTx messages if that function participates in CXL.cache or
CXL.mem."

> +	 *
> +	 * Additionally pci_alloc_irq_vectors() handles calling
> +	 * pci_free_irq_vectors() automatically despite not being called
> +	 * pcim_*.  See pci_setup_msi_context().
> +	 */
> +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
> +				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (nvecs < 1) {
> +		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> +		return -ENXIO;
> +	}
> +	return 0;
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
> +	do {
> +		/*
> +		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> +		 * ignore the reserved upper 32 bits
> +		 */
> +		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +		/* Ignore logs unknown to the driver */
> +		status &= CXLDEV_EVENT_STATUS_ALL;
> +		if (!status)
> +			break;
> +		cxl_mem_get_event_records(cxlds, status);
> +		cond_resched();
> +	} while (status);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dev_id *dev_id;
> +	int irq;
> +
> +	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
> +		return -ENXIO;
> +
> +	/* dev_id must be globally unique and must contain the cxlds */
> +	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
> +	if (!dev_id)
> +		return -ENOMEM;
> +	dev_id->cxlds = cxlds;
> +
> +	irq =  pci_irq_vector(pdev,
> +			      FIELD_GET(CXLDEV_EVENT_INT_MSGNUM_MASK, setting));
> +	if (irq < 0)
> +		return irq;
> +
> +	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> +					 IRQF_SHARED, NULL, dev_id);
> +}
> +
> +static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
> +				    struct cxl_event_interrupt_policy *policy)
> +{
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
> +		.payload_out = policy,
> +		.size_out = sizeof(*policy),
> +	};
> +	int rc;
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0)
> +		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> +			rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> +				    struct cxl_event_interrupt_policy *policy)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	policy->info_settings = CXL_INT_MSI_MSIX;
> +	policy->warn_settings = CXL_INT_MSI_MSIX;
> +	policy->failure_settings = CXL_INT_MSI_MSIX;
> +	policy->fatal_settings = CXL_INT_MSI_MSIX;

I prefer this syntax for command payload initialization if only because
it 0-fills all fields:

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d42d87faddb8..e8b4bd5e517f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -541,10 +541,12 @@ static int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
        struct cxl_mbox_cmd mbox_cmd;
        int rc;
 
-       policy->info_settings = CXL_INT_MSI_MSIX;
-       policy->warn_settings = CXL_INT_MSI_MSIX;
-       policy->failure_settings = CXL_INT_MSI_MSIX;
-       policy->fatal_settings = CXL_INT_MSI_MSIX;
+       *policy = (struct cxl_event_interrupt_policy) {
+               .info_settings = CXL_INT_MSI_MSIX,
+               .warn_settings = CXL_INT_MSI_MSIX,
+               .failure_settings = CXL_INT_MSI_MSIX,
+               .fatal_settings = CXL_INT_MSI_MSIX,
+       };
 
        mbox_cmd = (struct cxl_mbox_cmd) {
                .opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,

...but that can be a follow-on fixup because I am not seeing much else
to need respinning this patch.

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
> +	/* Retrieve final interrupt settings */
> +	return cxl_event_get_int_policy(cxlds, policy);
> +}
> +
> +static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_event_interrupt_policy policy;
> +	int rc;
> +
> +	rc = cxl_event_config_msgnums(cxlds, &policy);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_event_req_irq(cxlds, policy.info_settings);
> +	if (rc) {
> +		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
> +		return rc;
> +	}
> +
> +	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
> +	if (rc) {
> +		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
> +		return rc;
> +	}
> +
> +	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
> +	if (rc) {
> +		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
> +		return rc;
> +	}
> +
> +	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
> +	if (rc) {
> +		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool cxl_event_int_is_fw(u8 setting)
> +{
> +	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> +
> +	return mode == CXL_INT_FW;
> +}
> +
> +static int cxl_event_config(struct pci_host_bridge *host_bridge,
> +			    struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_event_interrupt_policy policy;
> +	int rc;
> +
> +	/*
> +	 * When BIOS maintains CXL error reporting control, it will process
> +	 * event records.  Only one agent can do so.
> +	 */
> +	if (!host_bridge->native_cxl_error)
> +		return 0;
> +
> +	rc = cxl_event_get_int_policy(cxlds, &policy);
> +	if (rc)
> +		return rc;
> +
> +	if (cxl_event_int_is_fw(policy.info_settings) ||
> +	    cxl_event_int_is_fw(policy.warn_settings) ||
> +	    cxl_event_int_is_fw(policy.failure_settings) ||
> +	    cxl_event_int_is_fw(policy.fatal_settings)) {
> +		dev_err(cxlds->dev, "FW still in control of Event Logs despite _OSC settings\n");
> +		return -EBUSY;
> +	}
> +
> +	rc = cxl_event_irqsetup(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -519,6 +714,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_alloc_irq_vectors(pdev);
> +	if (rc)
> +		return rc;
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
> @@ -527,12 +726,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * When BIOS maintains CXL error reporting control, it will process
> -	 * event records.  Only one agent can do so.
> -	 */
> -	if (host_bridge->native_cxl_error)
> -		cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +	rc = cxl_event_config(host_bridge, cxlds);
> +	if (rc)
> +		return rc;

In the future, it would help me if these kinds of policy changes mid
patch set, if they cannot be avoided, are at least declared in the
changelog. It saps some reviewer resources to invalidate previous
understanding within the same review session.

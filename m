Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83DE648AED
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 23:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLIWxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 17:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLIWxM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 17:53:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53269747E6;
        Fri,  9 Dec 2022 14:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670626391; x=1702162391;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zNsY7LdwvlUHWBTPFZCCjko3f3gB7H1zjAqPhIclf6o=;
  b=B5jmmX8w7ycivOB+YdUo9WaRs3ea+gNc/qENWvlJY05/XU9ysivOtsYJ
   Y5qdLmGApSpOS+qg1NADpxap3KAJgCoeHubaJ8DgHNHuA0MNycJrLm075
   aTR/uE2x7iTPWFNOY2gJfY6vxhWKvdvObIdbmad8rYAO1exrKv7UqL0u7
   HcylLLQFEevA7Nn+OovFWAVFYrgzYfZZ0GqXcFuEzBTt1FYP33vkNTJqd
   C0GCsCPGpejGpaiwiuhXlO3uw42rylIKPbd2BYf25dIxvl5kc+qj56kjS
   0yIWtd/UUpdvhkH41Orl7ZAel6dUPZ9xWjkny7FiS9gviuxJz4Xg4/bz1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="297242565"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="297242565"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 14:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="736357199"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="736357199"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2022 14:53:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 14:53:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 14:53:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 14:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgQ0Q6nyewm2JGzct7Yd5sQS5qM5XPTJUHPD+83zKOc0q6t5f/TyU0750ldeUoHYOsTFpuyTPk9BIyDK0LTC2ZbRncpo+UyYvnLNtbJF50nHa8Ckls5PS3PKAc89enh+40l08up0BGQqfyffu7MpFr9itmg/RYAc9mmU9sIqPq6aiklzOp4vPwZh69zv2bQxX9howM5B9hXYbYKlqiVNvM1Cl/GfF7eV6sgnvACLyqE0zBKbe1YTB387Rn0YyLej46TExa77CX8BNCVM5/aLmZ5nhEN9MIsm5ZRxFfH/mSLvB06ZW5HjZQZ4FKfuZiQRlhpr05FoH2FMxXfhTJzjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDjjh2UKnOp+Sfp6jtY5ZTd2D9biglXC3ueCXmP30FI=;
 b=n6oZZPo+Y0TABFlPj5tiXprV+tDmscBYaOPtP+apZFR1PaePPvbp5WgC+frWjSWyOjVxgN9lhwEWOawFO20vNUxCG0bC6NnSq1/kfFnXWO9tqFoHMdp9iJKkXuJsqQ/21bShGvv7k9Al7XTQ+U3cg9LarLJDjpjauDeJTc+0lqBg+ggYHA9lXkcy8fOYYDm3vE8roq8Kp1uKjQaRHNgvwEVB08sWs3WIJ7MUydEgel3BctHVTfNPEqMWR7frPAK5/rq7Iuxdnb4YWYbauMWpx7VJupgTCyz6Mxa87owz8JsWN6hYPmorWM2JiA+TBjHhjMwMHBWNCVnXYRjqkRuvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 22:52:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 22:52:59 +0000
Date:   Fri, 9 Dec 2022 14:52:55 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V3 8/8] cxl/test: Simulate event log overflow
Message-ID: <6393bc47d518d_579c129475@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-9-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221208052115.800170-9-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: eebd6890-7982-4a1a-871e-08dada381e77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpzBveArPxLM8dLvDu0rEbSA2wsyfvm9NFsIbNSn9Zn29+L1Sb98DUZirNOhzDyGF+PxNUEk8saPtRUq0/5YZfYXiFtstffJFhT6oubCrXOBD2jW/kjslSmYYJL2m2q4Opcshu91kT4jGd15fncfVA97u15PzWM5M4f+qczDBW1tP5Qa8Nvus6CS1K8DWeVT2Dvq1Wl/VPTDmjBeLvnAUigcklhtvzRVNi0IhsfSCcZuaoQX+OgM7kzwXSGb9hIAgi+PYrBwrn0Pdsi4CgintpiHOB1BlhKCUs02PKhEeSKx3kxvIAEYbUw6rT+JECEahQ5jEGLY//q1FwYQ+YL3Izhgz+6By1CautvGDrtM5dvnCzZ1Ovi3OBVZP2EmxGOzInous/pESMVlMNQt09OqYx+L3FPihhHWTTHUBDsA1l+V6onNN/cSEdwr+xDtWVaknAeJCeTvmpx66eL+sHdn7Bjf1HjRmHXATWMQ89XldBNTDqzmGNoLqUbnffklk/amMxEf6W77ZcYHyBCWWI0tTFGQIuU67eXjkXndrOUxuIWp6tbOnQEX7Ghxor2+UeyN3Of6VT/oUpEWCWeFFFQZnwb/iURHZ+1IG32RNM5s43teySlUsR25XF/sZMKukpKHwI+CijoGxgSbr9/MA7wLZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(5660300002)(4744005)(2906002)(41300700001)(186003)(478600001)(9686003)(6512007)(26005)(83380400001)(66946007)(66476007)(86362001)(4326008)(6200100001)(66556008)(8676002)(6862004)(8936002)(82960400001)(316002)(54906003)(6666004)(6506007)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xcWuNtIWcVmT48byU1WIVE6SlwC3FxMfop0+wqutHc6oQn70X7eG57lUrmSc?=
 =?us-ascii?Q?6DLQwMl4ASRG7EaTzDSVq28RFghoQnpSHaiRst0qKycqWefs+VSwi+QTji7f?=
 =?us-ascii?Q?PiV8XqbA9Nn8ZZVzzW6NvC6YjZP2q+w38p7K79EyN0sopE/ktN/c/SmlpSl5?=
 =?us-ascii?Q?DpEb1ugR+l5DcD2yArYNXVJbwh6RAvsRATB1DdLIJ8OwBEJrGAvITLROh2c0?=
 =?us-ascii?Q?HB4I3fsFP2vymzYVYy24ej0IER1BzANUswbdlFNbY9UBrEn+pIvJGvjf8Lfl?=
 =?us-ascii?Q?icFNEArKIbG8gerc7q4yyumA1x08jEkhDTisVf8sm5AHVwTTzjAfnBVJrTyS?=
 =?us-ascii?Q?bRFi4DvUHrj5+Zum2ab7krNajNq7IIKCIvcK0gXcMoZEXxbEVEw3aXulETwL?=
 =?us-ascii?Q?yv5d7JHAiiyhAsmr/biayHxV9oUO1Ifx7jhS+gxN4CDl+SGQBvxmbVdDtRTu?=
 =?us-ascii?Q?qUKcV6iud6mV4Q8CvRSfOEt/kmvoMGOxt6eNn7ddR4ktcLoRxIctaIOVgQSO?=
 =?us-ascii?Q?VOPXkju1XdN0uWHDDY8fQ0KiU1XdMORyL3d2ZxefBCuehOBnjBuXLaxRCnaR?=
 =?us-ascii?Q?RPrI7CvtgEDZDAt78sPHSJgVOW7osPNK5s4oWz/XnpxEYeLD0KUplcsa8lzm?=
 =?us-ascii?Q?8+sXqFeyfiWz2GI20A8Sqcp7BRjyVTSpisVhCNQlvfaaK3UfnAdb+geYPPnv?=
 =?us-ascii?Q?yU4cTz94fNSSVFPRGVyCv8wgp5tJJfMhmu2nhTE6WwwTO+vp2BsXcuXNwwif?=
 =?us-ascii?Q?XtNRe9PN8qFcPZRB2VDqOfNKAcnm+X040SeP9nf8Se9IzZiDQpTPuKi6RZuU?=
 =?us-ascii?Q?RgNaSTgT6Pah8qj+e+uNIoiWd1/caXpGYD/PRIUAt4jZU5Z/3Xe5WpsrmWOf?=
 =?us-ascii?Q?RYkMpGvNflY763cQZPDUmWMMb9Ms4hXTlK2eJdD8c7MP+efvkroVMGMZ+hEy?=
 =?us-ascii?Q?wbwDg+NkTMH3WRADKT6L4zvky2FqQ8jDLGPEbXhryrNazcMfkn40kXdbEGVP?=
 =?us-ascii?Q?1pX3Ko71C/I2TMY/cnOlG9tMyC/xjAycRiSC16Mnrd9dgrbRJChQkProBAKW?=
 =?us-ascii?Q?htgky6sHCiubthMle1rXwysDLOPohJojSMZkeIlO0d42ZW3Y5tJLXLL7dr5v?=
 =?us-ascii?Q?E9XTgoTsLYBUfVfjUxSFc53k+pnvsekf/LUyDOvF4FmQIvP67lWYurVKb9jq?=
 =?us-ascii?Q?S6RhJTpTtltMG+kRkyq8ePwTmBpxACRFjWcXScvnBYat3uqeQpnBezHiRJkP?=
 =?us-ascii?Q?mJdjgwF6n1W349TapVaBIAzrg5rSo1gfCkLA+yS113tk3Mkel0FT1xKjJio9?=
 =?us-ascii?Q?PuK6ZaIVmKPuT1w/1XfF/MW3DUIBRKSetcESn7/jZeuyBhKtFnQRGEX9Ir7W?=
 =?us-ascii?Q?f6gyGBMoBryaKeYd/Zamy+isKvNHEnAuT+h8IGvm4iFZfDWz3PytfgjXIhtt?=
 =?us-ascii?Q?4z/NP4ezvkWf0js05H3VVMEA9o7GVtOI2RuELJ37YOLFhnM50deag/PcHS2T?=
 =?us-ascii?Q?lcfevlJ86f7Go1GpPCrjLsjW+GIFyYPc7fJwmc5tbqlxUHfVbjWJOGxKh3Sp?=
 =?us-ascii?Q?Dzbybjs1yBoqQbCllkRpjQr1l8PbyDnkG08LsKaUjojvyWXFgqEedxAFcARr?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eebd6890-7982-4a1a-871e-08dada381e77
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:52:59.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPQRf941NujLkZYRq/UOLd8OBvZ+PDr0XVVYhFe58SoSwsLlzjKoa0YFnRFe1sHUVk9HBomkC1r1SxcxyBw8g4yY4rNUOkFQxEOuUZ7yrVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Log overflow is marked by a separate trace message.
> 
> Simulate a log with lots of messages and flag overflow until space is
> cleared.

This and patch 7 look good to me after addressing the move to mem.c.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

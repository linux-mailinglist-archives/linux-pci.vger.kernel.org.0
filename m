Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8055397B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiFUSZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFUSZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 14:25:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D3140DC;
        Tue, 21 Jun 2022 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655835904; x=1687371904;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LxEqfNQO+W3R2GXdchnXMubzxJpdAJ5yWb1r23JCXWM=;
  b=M3AihlVViVnlK8ASjlOu+7CxkcQRDFg6YMbOagMiVjGQ2UXpsKBSpbsl
   7gj/Ztd5Yexi+PrDqpU7HxNXD0gzdW4eyF8dzrV9W9GziWvJKlcMUQr5E
   eeC6K+7pkHvggw1FGib3D1bTySMQcxsmBae8m9HNT9dDaZpkx4PnAvotU
   oHrogVqDufYAf+g+PakZx+dXWFA9gTDNF/sU4Le0KBoiuyTLWBNtAwxUa
   uggbHi8jjB3zCnKd2Iuew0KjuXlXTnyPX9R81vOkNVWVPb/K4Zc4vDXN+
   +BgvewXz7LhB52KyhIr8XKtA5eRHRHp9/ub86nkM2YNxPFA0pAKy3yetx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263235949"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="263235949"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 11:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="914259098"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2022 11:25:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 11:25:03 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 11:25:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 11:25:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 11:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGMzSyUec6guykMQ+v+XnIkjaS0h1+hBarHp0lLUVXp9w/V4KRneRUmfve/ToS1aKeNa/4QQU3SBynQOktzazpTYCd4llIdIfxzG6UtYr0+FCStPhHq0HoB/FOthVcxmW4Ce5y4XkvtH6NrmQl8yC4c42XR/Pwxd+BZebyJdgz1ajlbKYrWOFfuqeHD6NhCse1HuS36GmNctuN3bOMgwsGNu/mJpmfPxOw5UOnUSns/McjuaEDoqqamnAjySOWhRvlAkyV/x/8NNbeOq9JORBlCoY0c//WEXlq7KgMbvVD1jbfO0MNPcIwAwUe23pAAaSgsq/waZV7OVtSRmrY1TWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3jwgDTW8+C6k5OP6CMFXm3Ze0N2mUuQ5Kz8Opg11Gk=;
 b=Ry5aN/+2dRzicrd8B/P3nUCX3EPpg1/SmCboZA0BLQp7PUaHggJhcAtVTXb7ADwLDQs+WbDG3F9HGjQ4aStHUe195YbV7Qx6OSc4VfKcLGSH+JN3wJjQG/46TWsUD2H1rTpHSsitG4eFp4uGKhzgoUChoc+cny/0ozKDbsCj6N9ifLpjapPyANmyypnOZ6NkZHzrMgZguLGLM2mfzNtfIlz78fLXu6Fa3igvGuuM9Ei+8ck1MKdQj9rwFYwR0OpKxIPAdHw55wKejqBLzZPW3gypctXYehYeheTFDbnn1Nk2/o0w3e8iZYv2ldItxi8Xf1FQ3MahIzNzqOt2vQtAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CH0PR11MB5690.namprd11.prod.outlook.com (2603:10b6:610:ed::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Tue, 21 Jun 2022 18:25:01 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Tue, 21 Jun 2022
 18:25:01 +0000
Date:   Tue, 21 Jun 2022 11:24:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <a.manzanares@samsung.com>
Subject: Re: [PATCH v11 4/8] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <YrIM+GnP+g0HbwaK@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-5-ira.weiny@intel.com>
 <20220617204046.qdkza6iemkfv2aze@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220617204046.qdkza6iemkfv2aze@offworld>
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 008df86b-24af-4e23-67b4-08da53b35a86
X-MS-TrafficTypeDiagnostic: CH0PR11MB5690:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH0PR11MB569000FF9FDBB07FDF407C50F7B39@CH0PR11MB5690.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4jk24CvbTyqR3Yw6Ynig+nAtISOIRPNIr3EuYUKO/dmi52JXiIVTX2MVjm/yhohIDFzYl7NTvuMCmOxlXhjN9lw0KiwP+35Y6VuMrq5jhCdV+lSTpDkvIh/4zLPwnqKLXYZXC5sFooTo953bTHR1EbTCTlSimk7a4SVrioQfqn7N6GZrc9mRTKd9zs2lJ3+XjthGH/APWI5invx2PXKcp7erTtpbaTTbqZ4JifRZIGqWeGeOQvh9iEmXN0MERDUhVkuWFqLIQCOSUEMIVvbBpOCRhW2dmoyrvxsZ5xPl94nTEKwCct8NvbK0P5ndPq7x/hpmB2YGGrj/e+ReQK4uFKg2mFOjiUMK+K0h0YibeAyYV+xl8T0KHHh0I32GB6M6kq6a9RgQ4XJkBYXYLYLlYQtKSu3LfUlMKqg82Q9uK/StuMh24UhRuE/qlC0/kOsuPvOexylo1g/3TbGtQ/Cs/imypr9/MwQexr/PKxJE7aMINe43yIX/RyoSU2Nw9uZ1IlDWyNTpp4MvLkG1ET5Lvl5US9+ISQl6pWUSCp3diNffLoyxQxYt8l0nf4jhbx+Z08zR59rQQPzyTk25S024GAeEZzvVHt0wxFyjcKCdQeW6+zS/EogdsFIx1ATJwkwmlAk47Am+rNjLInPty3pgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(366004)(396003)(346002)(376002)(26005)(478600001)(6486002)(44832011)(6506007)(8936002)(9686003)(5660300002)(86362001)(33716001)(82960400001)(2906002)(6666004)(6512007)(38100700002)(186003)(41300700001)(66556008)(316002)(83380400001)(66476007)(54906003)(6916009)(8676002)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zfpNSwQDtWJ5CqAcIwVzT4ifyE9FnU7IiwLIGW2yBigSKOn7Hoprbef9U6uh?=
 =?us-ascii?Q?qVZw76w/fyZkYLGrtPWOLStblrWYpEbjevYgcYJZrJxQBJ1shmipv4kxLOg3?=
 =?us-ascii?Q?qB53FGrKW+7G3o9uK6StcKyYM7pGAGxv06j3p/AbA6Z+Fkw9+otmvlnskeLz?=
 =?us-ascii?Q?Jo/00YjpLzTwrCsHoQ5NHNJagU1GmI9cdgJwo/CSbIYXXs4G1x77k9ThwyFq?=
 =?us-ascii?Q?Ki0dzFC0ZSrOPttnwQdlK5e288UAmcuLlrr9DtSr+knyq9SmI/xs97WdYTXX?=
 =?us-ascii?Q?J02UDe4zWVaXQ0Fo/cMfOnfhGi6P9PZ4ABdWBov3zLeTDE0prqJ4OToC/A7s?=
 =?us-ascii?Q?UZlrnbr4CTz9UVCYg9PiCUOWfcZ47uzATXx7GZEXhfZl3pYTOsZ9E8EFJ8yF?=
 =?us-ascii?Q?1hX7Uaq0haZHahy6QImLF63NDL2njHWa+j44oLqgsKBgP/iLIANJLE4vS/Gc?=
 =?us-ascii?Q?gOhL8bfB6b10YhfjMhbwS96EA82oKFIrwcPemZcgPL7XeeIaYYN9aLEv/luU?=
 =?us-ascii?Q?L3GF4b7DA14fGHwcv/BIDYgu0k8AQMrTng/MsBejlZVsH43ckfIdImmLFWyJ?=
 =?us-ascii?Q?+1YaRlKsGhrZ+zs/Ue1MMRhFJKbWGtCckjkirC94SQjOqUuP9nk/BR2Cm/3H?=
 =?us-ascii?Q?7UpdTIMzC+OTaYl+zuDEcHHyY07ibXfOFFJeANNuW0GsenyfCpJe1jFhHllV?=
 =?us-ascii?Q?pfOE440jP66AitynG3ajL2y3MWohg5id36lR4uNVGKI9NYxrqufX6pUyeoeZ?=
 =?us-ascii?Q?WdxaDl7JWaby+nesLnIoUv+Ej4XoDo/HE27RjPsjTEefK2nE+StnnYQCpmtI?=
 =?us-ascii?Q?SAum+jk+ldwahb9WeHWO6KwdhgdPFi5uS1mFOlRSE+QPBCgKkfkh89GmcGDF?=
 =?us-ascii?Q?ejF1fQBWjGOmsvqk60TQY8Q1PPqnmJREJ7FJgJhNAXtJzMICoP9Kfkg5Wstw?=
 =?us-ascii?Q?WAmoe5/bRvpSxtRzjJEW4t31zkpYL/WnTZ2zyztl8ZLR2cQcmYoU4ypa/37a?=
 =?us-ascii?Q?4JxaVPnPxBjZDOktbHu2pVa7VLWC9LRjFWtCIpV+fFn9QFZWjLs8CR/MB33I?=
 =?us-ascii?Q?VMIogNPUXsBEwqcyAexXwqpW8k2lx4o1e+0KS7YCsxqC0yQoYLlefK2YjKxd?=
 =?us-ascii?Q?ApFJHnH/VZZtrMPsh2lBxXn4sI1Oz9FdOyIEiZaS8QfG60GvWXbKMZyzeMgy?=
 =?us-ascii?Q?M+N8rmZxRaEZG3EpZBDplyDpLcqSYcM2GSlq6nVlrFEqmi/YhlhrSIvYdo+V?=
 =?us-ascii?Q?0rx6T1kzydYq1l6hy+ua3GbZaf0R/Rs9wsk/AruD9E/lnVliHnORAQlUhwdQ?=
 =?us-ascii?Q?QoIFrwnRvk2+2lvVJmqBOGe38/WPv2rp+JzVr6CSojGQ9eCNW+VYV/HinrQQ?=
 =?us-ascii?Q?b3/eg8qYJiMNPBkBee50gRP9aNvYRlowTALy8X0+guzWr1hFpP1W2h7A40Pr?=
 =?us-ascii?Q?i5yzxnQz4TseQUI3XMsyNFO39YUbcJbKTzPHXC2wC3HFSwrOsvai67jKmvM8?=
 =?us-ascii?Q?4vZdNFy7D0c9syjpvkAyEEojmbc3ucKgwh24Hq2e2Oy8vlRnaFKB/F9CI2lv?=
 =?us-ascii?Q?siDseIRyLigggCV+G6RekJ90C+t5x1NT+l3AyfesMYuCrvkfCCU6FVwQV33C?=
 =?us-ascii?Q?rcQwK9OPrnwq+LyJ43EW80kKeKjU8uRXQOgJybPkHUus0PY9lHe+VmG2UkAw?=
 =?us-ascii?Q?+PRLyfdYLBNkpD4xtdHNdfndg7JK/0SobpERPcIxtklYZR4isyuVgpXtoOYF?=
 =?us-ascii?Q?LOW5tSVQnA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 008df86b-24af-4e23-67b4-08da53b35a86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 18:25:01.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3CJhRnTOJdye/PaD1+qq5lJ+OTx0lGhJ3Mz6S10239W9Hkuw6wRfh8S/BA6yND4q/IuWW+BNVaZL1qKR3r4jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5690
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 01:40:46PM -0700, Davidlohr Bueso wrote:
> On Fri, 10 Jun 2022, ira.weiny@intel.com wrote:
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -191,6 +191,8 @@ struct cxl_endpoint_dvsec_info {
> >  * @component_reg_phys: register base of component registers
> >  * @info: Cached DVSEC information about the device.
> >  * @serial: PCIe Device Serial Number
> 
> Missing doc:
> 
> @doe_use_irq: Use interrupt vectors for DOEs over polling.
> 
> However introducing such flags is not pretty, and this is only used by
> devm_cxl_pci_create_doe(). Do we really need it? See below.

Yes Dan had the same feedback to get rid of the member.

[snip]

> > +
> > static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > {
> > 	struct cxl_register_map map;
> > @@ -434,6 +545,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > 
> > 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> > 
> > +	cxl_alloc_irq_vectors(cxlds);
> > +	devm_cxl_pci_create_doe(cxlds);
> 
> Should cxl_alloc_irq_vectors() just be called directly from devm_cxl_pci_create_doe()
> instead?

I was anticipating having to merge cxl_alloc_irq_vectors() with other code
which is supporting irq's for other things later on.  So I kept the 2 separate.
This is also why the use irq flag was in the device state.  The irq vector call
could have specified to use other types of irq's.  But those can be passed
directly as Dan suggested.

> Also if devm_cxl_pci_create_doe() fails (say ENOMEM), why do we
> bother continuing the cxl_pci probing?

Because the DOE is only required for CDAT data which is optional at this point.

Thanks for the suggested diff below.  But I'm going to go with Dan's suggestion
to use a flag which is set and passed between the functions.

Thanks for the review!
Ira

> 
> Thanks,
> Davidlohr
> 
> ------
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ce5b00f3ebcb..44098c785a8b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -230,7 +230,6 @@ struct cxl_dev_state {
> 	resource_size_t component_reg_phys;
> 	u64 serial;
> 
> -	bool doe_use_irq;
> 	struct pci_doe_mb **doe_mbs;
> 	int num_mbs;
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 72c7b535f5df..47c3741f7768 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -403,7 +403,7 @@ static void cxl_doe_destroy_mb(void *ds)
> 	}
>  }
> 
> -static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +static int cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
>  {
> 	struct device *dev = cxlds->dev;
> 	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -421,9 +421,7 @@ static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> 	}
> 
> 	if (!max_irqs)
> -		return;
> -
> -	cxlds->doe_use_irq = false;
> +		return -ENOMEM;
> 
> 	/*
> 	 * Allocate enough vectors for the DOE's
> @@ -435,14 +433,10 @@ static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> 		/* Some got allocated; clean them up */
> 		if (rc > 0)
> 			cxl_pci_free_irq_vectors(pdev);
> -		return;
> +		return -ENOMEM;
> 	}
> 
> -	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> -	if (rc)
> -		return;
> -
> -	cxlds->doe_use_irq = true;
> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
>  }
> 
>  /**
> @@ -457,6 +451,10 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> 	u16 off = 0;
> 	int num_mbs = 0;
> 	int rc;
> +	bool doe_use_irq = false;
> +
> +	if (cxl_alloc_irq_vectors(cxlds))
> +		doe_use_irq = true;
> 
> 	pci_doe_for_each_off(pdev, off)
> 		num_mbs++;
> @@ -475,7 +473,7 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> 		struct pci_doe_mb *doe_mb;
> 		int irq = -1;
> 
> -		if (cxlds->doe_use_irq)
> +		if (doe_use_irq)
> 			irq = pci_doe_get_irq_num(pdev, off);
> 
> 		doe_mb = pci_doe_create_mb(pdev, off, irq);
> @@ -545,7 +543,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
> 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> 
> -	cxl_alloc_irq_vectors(cxlds);
> 	devm_cxl_pci_create_doe(cxlds);
> 
> 	rc = cxl_pci_setup_mailbox(cxlds);

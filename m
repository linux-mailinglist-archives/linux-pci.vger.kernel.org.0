Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1AE63304F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 00:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKUXAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 18:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUXAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 18:00:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB55CB9FC;
        Mon, 21 Nov 2022 15:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669071612; x=1700607612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tsw8DE3hKr7koV8aXHB9DRzYeyxOk6nmg6eeiJp/Uro=;
  b=GlBgXpZJ9ZnBrSW1sDCUhT0dQLJx/iEjudZ0HLJrXjTbHXpRyk0V1cNt
   qYRIf88jjyKOxcrjJGP5b2EXrlIUZOswa8ZL0Kazh7pat+BupyLBX76/0
   lmPE9m4ImIduYXo1Ylz/JbKBpAYHCRdSeN9dYoDOj0kqztNj2sPvW8MKr
   pDFHWZG6hExNHwtxqh1FNEc8EfmpppcKRlTZ1/7bEm6L89wZgOsMmhEE9
   rL70ZAcUcmPT2jZq6s/LsmPcTezv9RhssUgqt9TrTHUV0tGS3JwHyZo5Z
   cIrwpjDKlN1155DKR+4+n0K24gEZEtOuSD8SUN7VdsWmP7xbESX46jKwX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315501175"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="315501175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 14:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672262766"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672262766"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2022 14:59:54 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 14:59:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 14:59:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 14:59:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDbUheciOiUFvwU6Bx0/YX6DbT5PLz/IzS17TWfHmd+j0ojvqVNRpLiC7rZ8YY/PN8qAmr748fsaUnZAuAcTV6vjFhDGINjFSTAewYxKQauL7QS/+Q+Rr6pkcryF/f/skjPHvLP86QbFH+IA+oA8fgLzl0aetuvT7SWzA1kvJedy0PXgdWbkQF9TT7mBmLc6i9ty2ERm6NgyCUt4fyTfhYBwfwOmU0BOZK1UwON/WK6X6pPfeYhG8Y34me3sGyyRtFZzlqxkEQ0H8VA+A4rT9Gq3mzdFkOORY29t2RWGmt4e6UAIdCeDFQZ7g4ulWIQHQYjMtDfEfwRf9vRrmWgBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ5ppAavLZYIGiyqW+0D6YltcMe+QxrSfvmLKjEgoM4=;
 b=F7hsb7I2hi0pKsEBVnVids3zJWe5cPmvGitqZ7t6wFDx9YJksepNml/CO33zwQvNKf9RZiXCFaC0wF8PqLUko3tiFFuQ9vE0sPJ4SPWhHjTrYPrFmc6dIBAAgh9m8z1U07X1NIgmsYKawKHsnEXgPCE1X2gvUM1Mh5JV9l9yCqQY/SvSltUs0Za5qheA6I6LwJUv1fmdWDvU11Q/mtr0z/axtG12jiAHSFG1Kt+FaNHeSqbe+fzc2UQL0hEPojNGD5E7wBkdolk2LE46JGWLYrM7TzBfBypux9JHAEIDjUjokxax6x46wqmg3vIpeGsd/j8MK1uV7G7oSynF4FhE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 22:59:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 22:59:51 +0000
Date:   Mon, 21 Nov 2022 14:59:46 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Li, Ming" <ming4.li@intel.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <Y3wC4kX6SCr90FGY@iweiny-desk3>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
 <750c2096-fe2f-0597-a635-78cbe6b0ee0d@intel.com>
 <e7db6aea-4146-33f2-9490-9b5b902e0ec1@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7db6aea-4146-33f2-9490-9b5b902e0ec1@intel.com>
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9ce800-be38-47a5-a22d-08dacc14187a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cT4/PH/CEV1uZ5sQRdQi8JVm/F4cZ7XeUN5IeOj/tboFjYMQylWkOxLljTUEbi2fjj8T66abjOUpBm228yTndfFAGNU6tPh1Kg/jE4Jclz4XeDMtCxB52Yc8AC/P8dnVPLkfgHiPqwPpSfADAlHpjutm1QFI2YZGXA5/16wHeHOUz2eFuNPslTtZCEZv6pcHYX+wYD7zsv9La3xmLKKwVSip1leIvd+pILDH1VTozR7ARU3SEbnRi2+5rQqvK2RVdcBlN2/UNzKfdwrnVVsgZM4qYkOpLtoFiJO+TyoRGyRrmWdzNyy2h56NqD61rQWM8i9mxOQy+LGNKV9yLj6+WIrG0YuWk4zzNq96I90DK8flOlmZ/VcUhBMFHK1+HY17ahqBgQ7ZwtQzF/WchDmspmNk85xAHvrq1yx2VmZeFZdnuMgy3+ODvncWgSDEuj5UYLskDM9JkJ7+OAWbl2QtfuMafbh0coLMOBhn/f8pe/WJA4oWGHxHCr/W8M/E9/5r9HfeMIE1lIiwR/X6wHunBFE3SH5szITYgg1QS9dG6Z8VcPV1mtC3Wk59FgmC9pmcY0TjJaUy1rS1swByWYqhFA7MRivjKUFwOZSqLDC5RolnYP8yHwVmYWM982BfLdYKkCO+Nhecnz9axVBEMuV8Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(66476007)(33716001)(66556008)(2906002)(66946007)(6666004)(4326008)(6512007)(26005)(86362001)(9686003)(41300700001)(44832011)(186003)(83380400001)(6506007)(54906003)(53546011)(8936002)(8676002)(5660300002)(6862004)(316002)(6636002)(6486002)(82960400001)(478600001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?il0t3IUUji2A81OkEWFiPJZEWoAN7XcUCZc0h5JUxTMDfBC6q9opkR9CR/3a?=
 =?us-ascii?Q?iBGXnW2OTG2s9uB3EhIdJrU4rhccq4L9FeW/yGYiivXpz0hafRhuKyM6OE/F?=
 =?us-ascii?Q?qa0NY+Qmegf0WdBh4yXVd8jQ0LtvOOIabmLrGQrU4fn989adOA/ZxFKa5hqd?=
 =?us-ascii?Q?C9SX3RROWQOHJuG4b+dyYjifDgMDA/fCYp72/8JQuTxw18KjRFg73jZ8K+Np?=
 =?us-ascii?Q?TVVrA3r4xzdKUieKxsT4cAaIl/+0J4NLtRMEtaDHM5sMOutN0T0NZSISH7Y0?=
 =?us-ascii?Q?LfaAB7uePuj4OaXFqq2SAldJwSpRbIIQ+qiOQ+2egsjOoutS+JhNucT3UHlC?=
 =?us-ascii?Q?qig4KrOm4fgc2EWjaPotYL9XAy/O9p8WdndJ2zAIwTFYLFmwXNFCeP6126h/?=
 =?us-ascii?Q?cbLvtLpVg7dPy55l9p2vswlsYzRewaSvxhlza9yJ4cUrIPkQo1M/ArIdBUEV?=
 =?us-ascii?Q?CMQCJNB99xMX5Sdf9eaGAKpoj9+bQgK8H9ATSiLIzir+nZ0dXBzRxjcAvscV?=
 =?us-ascii?Q?s/Ysxq2UOx6PCACBebVQYC2UU81rPBwjBOZLZGX7cO/y59+Dbo84QpiStGpL?=
 =?us-ascii?Q?8LBPl4+KIPOcgezaVzKBJ5eTKI6D4W//YSOsjoHO4FppCxeX5k4iHwshhZ1y?=
 =?us-ascii?Q?e57e3vENAn/lOepNb2SAE8f9fMKcoZF/K9xThlBvmBbFCXwFvceppakevKUB?=
 =?us-ascii?Q?z5J1ugPcihSKwEWuqd4ISkdA5ND5dQ1L/YfXcGp85grzrxZ26fEVRXQ4t7ME?=
 =?us-ascii?Q?jb5YI3IRAQ2Th0eJKysDT/0hjERFbLbmqpvRh0zB+zb4tNOwvZsNxdNQlNXO?=
 =?us-ascii?Q?OqBrdLcoCH29CUmFhdQHuCb04ClyAL7z9vaWNhfG5lRMPtwctkJckSlEiwCY?=
 =?us-ascii?Q?APjgQHcRzP40DWYlIbFFcyI1znUnVMQ5Wc0Pp0FDOtiWxiLiX2Eg60JyjL8e?=
 =?us-ascii?Q?FYwG39X1so7BJdHJtCytE2u1htUeaX0MjmWaDVq17PMYpfRIVkEcwLpvpd2A?=
 =?us-ascii?Q?SY7Aijjns9fpj5Ir2fd1giG6BQpH1f9wKl21tqbl/ybDZKFTmBFmJFJ9wsbb?=
 =?us-ascii?Q?KyxnUrP1+vqO4L2xVRDUQ4IyudmtFaTxs+xQi/M3SiicJyMDsLDlABKc51rA?=
 =?us-ascii?Q?mUBzAYRwqP9f3YGF/sd40WLCuC3ErmSgDxfFwEVYXV8yCVBejppMg8+Qxv2Q?=
 =?us-ascii?Q?P0L2cw6C1gX8Wy+SGsrLjeStygXbmOA4nLb9uMNAPzbE7WIv3Jfa10mbtvV5?=
 =?us-ascii?Q?gR+CxjtCcIF7UFY7zgSdgypgpiQcsEOzIp5BhjWJ+nGC6UEy/rNIFcPW0s8X?=
 =?us-ascii?Q?gDgzsbstxNgZJY88lPRrP6A8ZEoK8NroIB9lBCZQpTIHQXaQLFGdXBSWBzs2?=
 =?us-ascii?Q?ochOstWqU3J3CwxyL3SP6qJfAde6rmPsixmFhqqJE5gYw8eEXG3xOnxjs1CQ?=
 =?us-ascii?Q?yN6UpO/62cR0KS1at+AF2t3bG2Ifsx8um+GH6Py0S0v0OOONwT7qPGpxLfp7?=
 =?us-ascii?Q?ggk4kzYxoWRTdhsCSSTxnFdvJuimtuwIhoPN7gWD0zS9xWd2VUaH5faNHzTG?=
 =?us-ascii?Q?RiicjlXlaDlydnx4Q1sWJnej6dDQMq/a22UCCJsP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9ce800-be38-47a5-a22d-08dacc14187a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 22:59:50.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+UGrI/XbZnNk1VsbrQ59vXZLA3LWwI8/g9C0Ppfa2hktVZcSnTK2g+aYo4Ao6lTTeFgXTJU+V2C8cHelrEEqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 10:07:56AM +0800, Li, Ming wrote:
> On 11/21/2022 9:39 AM, Li, Ming wrote:

[snip]

> >> @@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >>  		return -EIO;
> >>  
> >>  	task->doe_mb = doe_mb;
> >> -	INIT_WORK(&task->work, doe_statemachine_work);
> >> -	queue_work(doe_mb->work_queue, &task->work);
> >> +
> >> +again:
> >> +	if (!mutex_trylock(&doe_mb->exec_lock)) {
> >> +		if (wait_event_timeout(task->doe_mb->wq,
> >> +				test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> >> +				PCI_DOE_POLL_INTERVAL))
> >> +			return -EIO;
> > 
> > We already implemented a pci_doe_wait(), I think we can use it to instead of this wait_event_timeout.
> > 
> > Thanks
> > Ming
> > 
> 
> This wait_event_timeout() only check PCI_DOE_FLAG_CANCEL, that means it only detects the signal which the doe_mb has being destroyed.
> If current doe task is done correctly, I think we should wake up next task. Current implementation just waits utill timeout happens and try it again.
> Besides, If two threads are waiting a same doe_mb, thread #1 waited firstly, thread #2 waited secondly, there is a chance that thread #2 is processed before thread #1.
> 

Agreed.

However, the real problem is that the doe_mb is probably free'ed at this point
and all this is going to crash and burn anyway.  The implementation of
PCI_DOE_FLAG_CANCEL was fundamentally flawed even for the current work queue
implementation.

This patch incorrectly tried to use that mechanism but upon looking closer I
see it does not work.

I saw in another thread Jonathan discussing some sort of get/put on the doe_mb.
That is not currently necessary as the creators of doe_mb objects currently
hold references to the PCI device any time they call submit.

:-(

For now all PCI_DOE_FLAG_CANCEL stuff needs to go away,
Ira

> Thanks
> Ming
> 
> >> +		goto again;
> >> +	}
> >> +	exec_task(task);
> >> +	mutex_unlock(&doe_mb->exec_lock);
> >> +
> >>  	return 0;
> >>  }
> >> -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> >> +EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
> >> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> >> index ed9b4df792b8..c94122a66221 100644
> >> --- a/include/linux/pci-doe.h
> >> +++ b/include/linux/pci-doe.h
> >> @@ -30,8 +30,6 @@ struct pci_doe_mb;
> >>   * @response_pl_sz: Size of the response payload (bytes)
> >>   * @rv: Return value.  Length of received response or error (bytes)
> >>   * @complete: Called when task is complete
> >> - * @private: Private data for the consumer
> >> - * @work: Used internally by the mailbox
> >>   * @doe_mb: Used internally by the mailbox
> >>   *
> >>   * The payload sizes and rv are specified in bytes with the following
> >> @@ -50,11 +48,6 @@ struct pci_doe_task {
> >>  	u32 *response_pl;
> >>  	size_t response_pl_sz;
> >>  	int rv;
> >> -	void (*complete)(struct pci_doe_task *task);
> >> -	void *private;
> >> -
> >> -	/* No need for the user to initialize these fields */
> >> -	struct work_struct work;
> >>  	struct pci_doe_mb *doe_mb;
> >>  };
> >>  
> >> @@ -72,6 +65,5 @@ struct pci_doe_task {
> >>  
> >>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> >>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> >> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> >> -
> >> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> >>  #endif
> >>
> >> base-commit: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D9E62CC56
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiKPVM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKPVM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:12:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60AB38;
        Wed, 16 Nov 2022 13:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633175; x=1700169175;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hc62a3YbyVykYm3ypsZM37ybDaJk80NqUI/J0nopgEk=;
  b=l4Py173Sq1wzdZO7IMwCefcctyV8MYO66/VofxKZwdhb2eaV+R6QMCCY
   ziws7DnOeEC7YLFgmobIDsMF+Zf8WbFFp6fbJNVReMDaj1Ih7VM+essg/
   WineNGSXTDqFivGL6zN0isgeBHw26q/zVPjGgpabLq1Mp0Jpc6DH48/0T
   ri2TCIoDqt9cGCpUDORmOtufk+f3GF7Sljs39lN+cYyfaiCg2Wxlm4kIW
   HaYW7CxzPjZKFzeBvL6SAyDQWds13gL74MUzkmIZ9aiMC8tGsW2IvAoU5
   O8Z7zh+e+90KFm1E1gNB1BdKeuBj+guK+1wPxP5OqtIwpsWbriCRpUu9G
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313819938"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="313819938"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="708330419"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="708330419"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2022 13:10:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:10:54 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:10:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 13:10:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 13:10:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmY9Ba26K3i3owoGnX9KTQkm6/YX8+A360w80gQp+pQhddI5/92kMy8QLv5FknyTdT8K0wI8N6nlkNhZDW4hKyDHuqdx5s8reAMCUQeBXbApLiyN3AGjVW2uMG8bUv/1d7t661gPoEImAk7SrAwOAONs+bB/puJ7IR1X3O74qXOLaZuByZ2g/IltnFv1Y54+tCjw0Smnq/kzDUAq5MaC4qZngpxocRAvmLpRMdEVvjys1xTTFCH0WDTKha8Q9szUD8AC/a7ebtuGaT9ThN6k7qfy3saTMM8zmUEjcaGKRcwRRXRCMNJy+zuY2cBl4L/2UfjQfm8v9zuHHBuof9Rhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46jm7zCPUvnu7MsigCuPScqbdDbO5qqAoRK+yqxclKQ=;
 b=C9T9qYWCFOXlVHl7GdUAhlPjCUw4OWAhQHZMBdytCkgermHeXELy2wwFr9iuuvH2OpHDfGInlOCvPHhCEXXxO2ppvG/8ztuZ2SjgKSUwRrkqFDpw26K9/pBpIe4KOnAHkp+COozERq7RwoHH9b+bXIhWruNbdc14ISwaMk0F8q8xC8l825txTFr1YXYrjt2Pdy4qLRs9v8VtaWCXBl5rRWn27N/patwrdHB2BImCZqwwj2Q2eiNMRU5Vcs9dXC9WiP5JFh1GzuE2aONeUS2PmGYqexWJTpc0Yf8IRxNgHsnkbK6uXwANlRUpHJEE39MjTl26ab3nRTcPZ9jrF1unUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4624.namprd11.prod.outlook.com
 (2603:10b6:806:98::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:10:51 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:10:51 +0000
Date:   Wed, 16 Nov 2022 13:10:49 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
CC:     Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/doe: Fix work struct declaration
Message-ID: <637551d941799_12cdff294f6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221116100939.GA32050@wunner.de>
 <20221116182037.GA1127308@bhelgaas>
 <Y3VO07WbMI5EYAUD@iweiny-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3VO07WbMI5EYAUD@iweiny-mobl>
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA0PR11MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 55534dc3-dac7-4421-b71e-08dac8170a99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5BRjQ/ptBDLfyd/XI1IWMMEsngQKUhpkgPDWSkX6nzrPGjBRtGMSh+Pf8MLh3Xxi381YEaHJhAT3LwwwLCt9tXtLOj2GRQFxb+alJEskop8QOEtLMofNiwQ5kH7tYtZY4wovTgj+5ZHqkHQj9s3XqQsNJCUWyU66Io0lD2cxL9wk71lZQe2JJejhnmKMmAkHYZ1aeVAKQmh+FIrtmbeSmeL5eipknV/3TOmHFUqdrwukVAU9E41XqdFRjd7H0h6NZr10cO8cFwViK5hQj0Uk7Yj/6lS3II8/LZ/jh72kH8Be1GXHHixaR4fTWqLi0StN/bZ9Q80fXF+ijfkmUG2WQM1Sf86raFdOGuXpWnB46qPnVnhV4BJL86uq1qXtam1hesvQSD3UhrwIlTjQqbqz0T5X0th9R1i7ySpmcBfgaxKxE0XxxlGloJbR/Ay1pu8mmv1S3r1ug9fqEfYbDxFiDWEKtnEJgdaryAAKeVpKrApYg1IqPYrHzWnMCRX/CqdI4FY8qKgT5HBO6NhCXZx++vWG8F1zsr13jA2U3Jp5PbtJ5kBsipk/A87y1zov34iuA6XFHE9hshMmAVkyfWpksWZbFILM8/QdaGS35r1m2xcaa5DXn1q01IQ51gvguwRpQSwggskbm1CaQdGLJ8iMGSeAvSg0Gsee/jIycgIlpZjCW4xQu/RvFheloIaE+3HuczfK/QMhi4XnzMaYEtFwGZJVH4QIgv/LfP3rsPrtamt1uqTx4XsPggyldxJ2qnQK0xWiGOLp2kJXkXU4ZoiLtPSL6Ug5bSTlHYOGnB6W8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199015)(54906003)(316002)(38100700002)(110136005)(66946007)(8676002)(66476007)(66556008)(4326008)(6506007)(966005)(6486002)(478600001)(41300700001)(82960400001)(6512007)(5660300002)(26005)(8936002)(9686003)(86362001)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+8nQYdLiP91+t7p8v1pyqfuKckJCOcPpQOr2pG0s6Xve0MxHjrC4hlTuNM6?=
 =?us-ascii?Q?pwADVoDwFuP2WULWQdZrjMMRTAcqqzpD4K4m5wGokOr39iSWANg3ky4SYry6?=
 =?us-ascii?Q?S6xRAyuH2Se7d4UJa7GskXMbitUEuu48q4PtVKeXkmm9PEdQVS2rPKhySZ6/?=
 =?us-ascii?Q?cO0tjsYW1kFVkPr4MR9wQeQGuUiICQDCDSVKK68zNmVSLKAYHhXKX2e2KMAh?=
 =?us-ascii?Q?3sXx9gHw0+/BFv5oCy2SGMienPdUNT1BPcZD9MtT/4+kyRDdZGDSX2Ne+QBz?=
 =?us-ascii?Q?ckE7oNvcJgTShYQIvCRY2n40txXQdxbmHIAtsXvG8eBWmRr83Jwed9q607qQ?=
 =?us-ascii?Q?FhHGejk7BD7TNZlo8035nxT9XKuI+z9xnJeaNaq8GkFElV9qCNC+4Glgy73f?=
 =?us-ascii?Q?Kfl3AIMdVpF2sWjge/zOY2c5ln5usTAstLWVVEjtLE7guW5RNX20iyJxOTi2?=
 =?us-ascii?Q?05rsV7y+BjrgriGW20LZ6LB72rhmMAIMDiNDFOQQ1cgzUUpa0I2cXJh6eObb?=
 =?us-ascii?Q?9BZPMpE/GjKZ8IDq/xF0fa39eK3v3QOInfvmHC6OdOZ42wj7A386iWLpueLX?=
 =?us-ascii?Q?6Ip9Kh8sXASPIRhyiyBzPmScNCI72u14w7TAjTxDkomRRfAmPg9ypjiwqgF0?=
 =?us-ascii?Q?RhNpEmV02cMf9JLu4/BVaV0sbtGuB6DUCV8AWH67u22JmRkKmS3ht6LSj17N?=
 =?us-ascii?Q?Wk9XbBDNwXQvzLjZF7j+sXFE6f1UaHf7Oz+hGVN89LAfvlekb0mcyOqPEF8L?=
 =?us-ascii?Q?dDsE8QcCfiQcI7CnFhoKISwFTbGmmzvw/Oq2xF3Kyh1bIQAo83GyuxYj/LH6?=
 =?us-ascii?Q?41Ym4V7t65rVQRaWDbE9HRKgS/ZW/GjRN3rzZaJ5llMIvT/HlRaqOXn/nho5?=
 =?us-ascii?Q?iXT02sk2GE1WciK7pLaDhMY2zaVTroGvahcnUC1D8AJ6LS8mxNr04SDzssX0?=
 =?us-ascii?Q?7/qVR66TtjnGM41gmildtIzTxraRoIZMWVvftJddfN4pEMYVEx0R5U26hYl3?=
 =?us-ascii?Q?s0+ZT0nuIkOV3X5pTn02dTPUndeUF+NFsO5T3jsIs2wXTR+T37IW+YNnP7pv?=
 =?us-ascii?Q?vNkb9h7vwlBCBf+ZJ1wVWsPlUlghzdqVEtifmo7dOgk3FpSpgvE29yvLuTE0?=
 =?us-ascii?Q?m8D7vhX1N6UAqX7N9IhIDfmdWTxrgdbw18r8Te8OjMkzHmGHJKMpQVfcIxjN?=
 =?us-ascii?Q?iA4zUOaXgUHh4xBM4WZVWACLUEnclxVMLTE9Ff19zH6YVY6hNjWYjrYdxOut?=
 =?us-ascii?Q?jOtd8O3bK6bMwtUi4HRgSlfYjTjBptbR334MkoACYO9HL7u06+WYSHDDmCQS?=
 =?us-ascii?Q?+k19PyCBazZCeXc/MOVXeXxnMk0Nco+MJ2LJ2IJHRuSMVReUSeRhRcETi3BJ?=
 =?us-ascii?Q?tIOC2NV7RZQUnJ6MzEw2mco/hhY4BKNoCJOBQzR4ac5JNTBSPcfnEOvQ49yw?=
 =?us-ascii?Q?6EQOhUcjuP7wDZvTpd6kBPrnE6dbnHCssWiK843AuthSDPeC/5rRPT6OIiII?=
 =?us-ascii?Q?qi0z9MJk5pmi1fp8zyJdKOp2DkURxfIKvbVk2dYrk24TKrD0LtGSIE0m8vuq?=
 =?us-ascii?Q?BW3yyfhiFY5aAWASyzjqC6N2OqeiRlIa5ID65UFWz8Mb64qtWnb8BmrhPPrQ?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55534dc3-dac7-4421-b71e-08dac8170a99
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:10:51.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OXSXPE37zuCdrzQdVV/Ehpx/TShMbKKkM8JFcRNYlf8bYgTFPJXkyjWerkIX+rNPNrY6UccWLaaEls9DL2U1VFb7n79mEltc1XjFSD/t9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
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

Ira Weiny wrote:
> On Wed, Nov 16, 2022 at 12:20:37PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 16, 2022 at 11:09:39AM +0100, Lukas Wunner wrote:
> > > On Mon, Nov 14, 2022 at 05:19:43PM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > The callers of pci_doe_submit_task() allocate the pci_doe_task on the
> > > > stack.  This causes the work structure to be allocated on the stack
> > > > without pci_doe_submit_task() knowing.  Work item initialization needs
> > > > to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
> > > > how the work item is allocated.
> > > > 
> > > > Jonathan suggested creating doe task allocation macros such as
> > > > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > > > function is not known to the callers and must be initialized correctly.
> > > > 
> > > > A follow up suggestion was to have an internal 'pci_doe_work' item
> > > > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > > > could restrict the context where tasks are used.
> > > > 
> > > > Compromise with an intermediate step to initialize the task struct with
> > > > a new call pci_doe_init_task() which must be called prior to submit
> > > > task.
> > > > 
> > > > [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> > > > [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> > > 
> > > We have object_is_on_stack(), included from <linux/sched/task_stack.h>.
> > > 
> > > So you could just autosense in pci_doe_submit_task() whether
> > > pci_doe_task is on the stack and call the appropriate INIT_WORK
> > > variant.
> > 
> > Nifty, I had no idea object_is_on_stack() existed, thank you!
> 
> Indeed!  Neither did I!  thanks!
> 
> > 
> > I wonder if there's an opportunity to use object_is_on_stack()
> > somewhere in the INIT_WORK() path to find usage mistakes.
> 
> I'm thinking we could make INIT_WORK do the right thing all the time.  Not sure
> what the overhead of object_is_on_stack() is.
> 
> > 
> > Adding it in pci_doe_submit_task() would add some complexity, so I'm
> > not sure whether it's worth adding it unless we actually have uses for
> > both cases.
> 
> I think if we don't do something we have to document that
> pci_doe_submit_task() only works with tasks on the stack.
> 
> I would rather just make pci_doe_submit_task() correct and not complicate the
> callers.  object_is_on_stack() can't be enough overhead to be worried about in
> this call path can it?
> 
> Actually after writing all that I wonder if we can't push the use of
> object_is_on_stack() into the debug code?  Something like below (completely
> untested)?  I think this could be pushed even further down but I'd like to get
> opinions before attempting a change which will have a wider blast radius.

This looks reasonable, but I would do it after and independently of
introducing the autosensing version of pci_doe_submit_task(). Then you
can pursue this line of thinking and come back to simplify
pci_doe_submit_task() if it indeed moves forward.

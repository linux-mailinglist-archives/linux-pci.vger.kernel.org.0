Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F5F719115
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 05:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFADMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 23:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFADMa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 23:12:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD6E2;
        Wed, 31 May 2023 20:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685589148; x=1717125148;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SpRSSyNoi79Bb/O/gpcXqFSzDa9wBRbW3vrK21QGkqQ=;
  b=HOtVWZRnxUBEbBK/3P4L2Dbr7H0hYXL8nt+dYQnciuUFtRWkrmYjHTml
   +rkCTW61Qxxc7sTupGPv6fbQid50plNJDe10VMnlrY2OMkeKEg2kztsL9
   v7rQisDYXxr9G3DdKzkNhAasplx0c3/WvxFbUJqWgivO6wqgFFSIeDh8t
   6CkhAQ2EmvJbokuTa7qDUi9/l9NoSOTnFcW0q0lH/69/EwydWiCVd9REq
   Uwyz3ecFl5aeXRtXfgBKYVASDu5IsWhOre217bjh08E7hJkSX8VzFDxNw
   Wp0avlMRyfrOGxcNG1V/bVC85rVQSk102CPVBaDXlPOF7MaKKeE+yNaTt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="418935796"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="418935796"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 20:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="701369566"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="701369566"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2023 20:12:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 20:12:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 20:12:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 20:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETzKek2L4BpExna0U1xix8Uk2/pHHtzPn2dVaMjFPic7X/Nuz8bwD6JOVToGc6sgFDxC/9/OIXyGF0qqYE0J7c0oZP2UzamF73Ty2MiY/x2Mfsd+TAYrrYlQ6kNRqWWgT90Dkx9rSFdnswko56FAks/7Y03xWhfBEsVgDX6IpXq0DnF2K3eedkLlseZZsw3uhgHk3RanApqS+wMuzHGn0gLhP5JRATDQ1E42UWuaRMXOd7RIwHZdT2ydhqTtrhaHHJbFMW/eEb1Ats7Dec1d7ULEKhjJUinMMCwo72LxJWm8Z40RqgyyQM3fB60rB8pf6nKUozgNeEb/umsXhHsUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra0K3c4L5KDj1vq7eLomSlYvGFDezpDROKXuZJYu0Mo=;
 b=RQsewknfslFJzOxcTGp94Dd40hclbmweQBmpGITUCLa0+mjfPd8gg9Nhubm5V5qwqHlqhfKpx2gHKzmkrzfeJvHVCO2Jfh0l6C+8EL6eqr33qnLA2/alumGGCk8sB8t2/wUlg50G9xCVGNkSyOOgAAQyaPZT2ymosHNkk8WjTYLwtaPh4+JOa0OgspWYl2gj3nMYM4Ox/QmtkaAHnFJ9EReE/2dv4chJCNpFfhHsNpwxjsda2UnMHoIr2AX21zeFAyLl/T88Qrcv/bMCcPozET/lLHG+6qd4fhia69NzbbR5bqcCS4G8NKJre001Ny7x8CxTrW2+06Gm2WhZPnIKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 03:12:23 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::8e85:4669:fc2d:4080]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::8e85:4669:fc2d:4080%7]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 03:12:22 +0000
Date:   Wed, 31 May 2023 20:12:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, LiuLele <liu.lele@qq.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <alison.schofield@intel.com>, <bhelgaas@google.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <helgaas@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <rostedt@goodmis.org>,
        <vishal.l.verma@intel.com>
Subject: Re: CXL memory device not created correctly
Message-ID: <64780c904d3c_c35b294ce@iweiny-mobl.notmuch>
References: <cec6a8f5-a284-4f46-1ada-4edd625a9a2e@intel.com>
 <tencent_D9D9D358330CA573E23D490C6EE13E0DC105@qq.com>
 <gbsxrcjtnf67jxpqmbn57nqoslpmjtuk2ycatmau3vfsmpvbrd@c2umpofn2hti>
 <646793cc665bf_1231462943c@iweiny-mobl.notmuch>
 <ZHaubgQOFU0+r1MD@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHaubgQOFU0+r1MD@bombadil.infradead.org>
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|SA0PR11MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: c1733f04-ba63-46e4-b813-08db624e0418
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEIXzon20Po1jLZuP2tiXKNdJQzhk0SQvU0COD5aGqJcuXikzfWoirNpBE42n1eban2uDuVTS6TkQ/WKYEfJAi2LWs56IXzyT4rFzpNBolxJfX1nFzJSlcdE7TLRdFpZusvwVpIx1d7WAkx0C0kPk7DJUBVRSGwea8E3Cvg9RUzDVIIgm7PzSSdZIDjvpji0qLcJTZ+/W6aeo3F7cYft0soJrGvOlXJFFoFAYSn5xe2QUiAvCY+kL1cT30DH75JwlXUZ0RiBG3dNdUrKf0ipha+BdCcrJ8ILpWxZIansBrB+r4XwPQmSh9iJntvmUU0bSLHpUK80ixuFI1D9/WEhJr3LhrBl7Oecxl9UrIvfiKZd4Hrofn1uZk78gM3t5ceOW4zjj5uN6hlzku2eY0GRBItZ78CYlFSAVyQh98VJNrWwXD/THmAD3RxTrW0tX3OvFeTjZAz1PR1CYmo4LVn47CpciHG4Z+3lwu125gGGEm1Ak5Y5j8ZrMjHnFFsTRU/sUSzRT3qJ5SQ9ndB5wRBCqAgRNRiSBprTnUKS6HDq5zgBFCywSASeYWHP+IGlDQGh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(6486002)(186003)(6666004)(107886003)(26005)(6506007)(9686003)(6512007)(316002)(44832011)(66946007)(66476007)(66556008)(4326008)(86362001)(8676002)(8936002)(82960400001)(5660300002)(7416002)(41300700001)(38100700002)(2906002)(110136005)(54906003)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LkaABwlL0Zy17qfhrZL0LUVA2gUG9ImVWCmQvoBvn6FbNABd7GlD7MtLPU/w?=
 =?us-ascii?Q?m5pZw8tO4X477EzEEEV9w8HKA9bqTpny/29yOWFTeskwYYOwBlH7ULzvJKj1?=
 =?us-ascii?Q?mgnTADctLSQPXOTeQG7zqLW0qNranyPWrdBqmPAyTmYWveqRJHLxl5jTvXFu?=
 =?us-ascii?Q?RF68Yh3HGS39R07URaasGGHsRPaBShzuRmXYSfs9VkW1mFgU6LkIWKXOjvjM?=
 =?us-ascii?Q?Orcztor+FRDgkKi7S9WR59Kzg2iYITKt5taVlUWxDqEYOkjGmhCU84s5obWD?=
 =?us-ascii?Q?y6HUD+D+arkZ92dM5DJfnchyUAcSHeWigWfKk1oqGgmocoYanA+yumJR579o?=
 =?us-ascii?Q?xpjYkTue8o4jRxcxtGV6YP77oF2n8VDyIMhjpxYTyVy7sv3uejSAvvHSHP/l?=
 =?us-ascii?Q?ymfXVYLyUE9qpr0Pspe0Mkuliddp4aYMmcbP1d7H9RpJ11qQ3QMzQNE8N5iC?=
 =?us-ascii?Q?UR0rlmOJ4acLAXNz57QgmkS+0dD9xFTXge9K8AvmtVgbYW3XtZARuaOSt9HX?=
 =?us-ascii?Q?hij5freLhg0jocUxlm4Dv8RAFaytophI5jiUIfL0Gni51yY6I1+gu18hPPXv?=
 =?us-ascii?Q?1sCJB32L1m4FIMjIYwMIapOjXwa6GHJ5eCyGbOdgXMjm6E1KZCzov80pVR8d?=
 =?us-ascii?Q?Bwrp8iOjuoD/8vHstBebMlGLAGNgDpuHhoJoHsk1fPK8PXeJiIzlUnUWxUMv?=
 =?us-ascii?Q?QTachR0bDktvMscrfrmrZFQ6vjlvLVt1Ub4eFBZUDNvKasIiYOKU2CSxdBy4?=
 =?us-ascii?Q?OQiwkkZOFrm6xn15qaLj5dshHqs9z6PyxYnX/rK6KxztTO+uAR43nr0pQFUG?=
 =?us-ascii?Q?aOyapsv3vi9l/QWdCyKhmq3D/6dTk0OSzs7cw/zFw5j4Wv5jdbRj9izfz6Dd?=
 =?us-ascii?Q?Qg2jSRWHstFValkjTaKzlsHWv4KTv9cgN/oM1L1kukzhs7eVxorLBlspAKw8?=
 =?us-ascii?Q?K/ItCU93DxURpLb05rRPK+W2oi8c/qaF3X4zWN5NF8GXdKUNiqM98ZsmbWKx?=
 =?us-ascii?Q?+O0+HA23bgewtrjxLVOwS1IjdiGVeIY00Vu54x2qSYR++MYZ4oWQrr64n55P?=
 =?us-ascii?Q?hGgY4w2jJX9VX7hTPAZFuxbikuCrVyYnl88vHeXoH0qGVYY7THBJPUJO5kLu?=
 =?us-ascii?Q?zypblXWq28kAvmF8MS8/t+vb1Og0wxwlogHop34SDe6s+mcK4wUoRZscTDCY?=
 =?us-ascii?Q?UsJjKjhDIUpIjDRQc/BMRN/NpOcG/jpS1pSdQ9nfvhk94K/42qKTWc+hdYHC?=
 =?us-ascii?Q?s144OmeBQ6jD++e2oL+Bt2Qvt5UEIwkk4gedfM57LDIhTGeG+PXtPmgDGqbu?=
 =?us-ascii?Q?00ab3sdtbEOLRC61E0Znqszrv0/NN5WrcIXTmP1xRZcnACYJAcmwHehOrzLo?=
 =?us-ascii?Q?PukFlX3pyiuq9GbjDenSkygzT85dPsL35lsuuMA0oBF1hg0SFIAfr3pJFzt6?=
 =?us-ascii?Q?w7ZcYWr38srQvYREGBfl8M5+iuJDDo5dEMEaKyYF80NoUaGksZeVek86Q3mH?=
 =?us-ascii?Q?clzR7bBSipEimDEBTh9o+CXprsJnpXvNKFexR+ATi+K7VHe4QBlb35kMGaW7?=
 =?us-ascii?Q?qsos5DICG/RPhz2lYnWCOibJCfM3FYwR4RqgIshQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1733f04-ba63-46e4-b813-08db624e0418
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:12:22.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMlTI2MXYl6tcBJ/SO6+DfUMBmWApef4d0qRt2vxA4wb0fv8TORgpv+cSc/k4eB0zUJKYxL15Fxr9IkmAhr+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Luis Chamberlain wrote:
> On Fri, May 19, 2023 at 08:20:44AM -0700, Ira Weiny wrote:
> > Davidlohr Bueso wrote:
> > > On Fri, 19 May 2023, LiuLele wrote:
> > > 
> > > >In my testing CXL device /sys/bus/cxl/devices/mem0  not created, and the get error messages :
> > > >
> > > >```
> > > >cxl_pci 0000:0d:00.0: Failed to get interrupt for event Info log
> > > >```
> > > >
> > > >My test environment is a qemu CXL emulator with qemu v8.0.0, Linux kernel v6.3.0.
> > > >While with kernel 5.9.13,  /sys/bus/cxl/devices/mem0  can be created.
> > > 
> > > Yes, this can be annoying and would argue the probe should not error out.
> > 
> > I had to double check.  Events are mandatory on devices.  On checking
> > again interrupt support is mandatory as well.  So that is why I errored
> > out here.
> 
> The failure essentially creates a user visible regression whereas
> booting an older kernel fixes it. It is not a friendly error message
> when testing kernels / upgrading / test environments. The only thing
> I can think of is if a new kconfig symbol is introduced so to make
> such cases a bit more clearer for now as things get settled.

Ah I see now.  This is a qemu without the event support.  :-/

> 
> Otherwise for testing this creates a few cycles of just noise. And I'd
> imagine even a few developer hours.

I don't think the kernel should be changed for following the spec.  But I
do sympathize with you.  I know Jonathan is working to get the event
support into qemu soon.  I've reviewed that series (the patches I did not
author) so I think it will land soon.

Can this be weathered until then?

Ira

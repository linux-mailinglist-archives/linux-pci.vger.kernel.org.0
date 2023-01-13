Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562AD66A549
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjAMVqK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 16:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjAMVqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 16:46:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4E0CDA;
        Fri, 13 Jan 2023 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673646368; x=1705182368;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WYVHUbUYCTLYgEQOWZ6rNhQJqUeYWJVOB+Lgjg5AURE=;
  b=PCzsNTnaLMXqh90DYTxHpfuLZTDUv2P7ayAvSlu5Q/TTYpIets4doM0o
   s61QV2gPP9mVLl4vKniTzCPoVRO6/BzhNSCV+SynDTjp9fNtzPrZ2ftug
   AHo40nibmWn4M1U7jtuK2ief3lGRlefe9T3goOveMw265JKptFpmRGLPb
   noxc206d2K8OMKg3fOxjW7bn/wCJAFZ+HV6P1IZvUjWZgoy8uImtO1n4E
   cu4617XCsegepM9zwcOeL1QYIDC2ezXjwIkMJ92W+AmV4YzTFxRq6sHSe
   NwCkklvHrGWMdA42momtUuu63yenVtSms5i74BcM2+L4L9FQUemFzxf/g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322806272"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322806272"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="635914252"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="635914252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2023 13:46:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 13:46:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 13:46:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 13:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh1c2LaIEM62OIvn85uZuxqtgSL4lTLHQkE52Wy+k9iObIJ8t1JHRD/lQo1mES1c57LBKaBI5x5yJ3tCQ88hSyT/CCdkkc9KDpQh9ff6pYtGat4I81DVG573XxOeodpQ//WxW6vaa3ZXfO0SZ5sc2VY073kNKnWTT9gqMBkWAyjfZAXX8jGJkZgHa9c5X8Thxq89qb2Q14zRFOLNwYX8hSrDLEVo+9hKRtdxaqu+X8M1nYnRgPUunMVKywm2rSnlPXQ1SKzFGKS6C9wSJsq/oTz9WkbU5qqs6ukz54GajgV2nm66FBp/2GzNY/B1hs+wXRo/T/POYH9N5jSOGMmsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Exy2y6cegMvaNZGLCLBBPkkcCNwiPseg9U8S1spb2Uk=;
 b=di0OV7zzPVC5Rxzp3KTTssXaTYvA8gwiEoDp64IZjdPoGX6AgCYo+mKvH3mjmPWgMYSTVkJIDwfiT4J9zEdt4l5f1gsQZy9CO+Qc9zXHDjM8Wjqzq/3iqjdf+I/ZIicda+Z+dHKHYvH7KVV6EcFRloomvsisuB4aAKA7tf5xUAUmr68HIXX+kC2PvIPQTslQuLxyY6XZ2TIcDN6nFUnRnv8CdPc41wo7ciI6irnPb0+3whygFEonoJPgNT8mdlvD2+Dsfa46CuGFZuD0LHpNjXbX9gtI3xh/GcDY6QY3zUDnQwq4/qk5vlFOiDHWlAadEn4Hi5hOcFFO9nsygCxs6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 21:46:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 21:46:03 +0000
Date:   Fri, 13 Jan 2023 13:45:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v6 2/8] cxl/mem: Wire up event interrupts
Message-ID: <Y8HRFjA0bQKw/yoZ@iweiny-mobl>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
 <20221216-cxl-ev-log-v6-2-346583105b30@intel.com>
 <20230113122845.00006be6@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113122845.00006be6@Huawei.com>
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: ea114c7f-42d4-4590-6448-08daf5af90f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYX1QVg2pIvtHR1pi52RkVYM57Ik/RUhezdbCWGFWNqnAFZOueDIs9WMrtR1lTqb/SELUG0rkWbarc3Nwyxy4DlIezGxsAtdKmcLP9x9mOZHfxYbOgplKS88KDHL2ZTlLrd6ee8qzx9WX6tTYvVfyyK3e8LFEWjFR7atwzQ71kbPW4g0Fv+zb75B3yl8YLmGnohmYOGu2RVPVfXGPwgRL7GJ7ANT7Gn2IwrUu4No7v50kPqtpD9zL5fxqEaR0AnbHAwrlGyZS/3kdEpTDreCDATRUa893qjmUS3We78xYf68HBHw7AI51RZCvU4vJxTzrKul7cXnzxGHgR5KSXVEA1O0N0qDLFLADqjKng7Lixy09qOHyo0V/hK9b983U+FH2hLC43fLFoN0qFcChPSCCM2NLBQcVDjyU6eP1rVRqpk1EzF2k7FHUdidl55UPTv4gW8q27DPHmPc7UN8sjpTX502w6GilvkZJhDTioP1FN0Oc8UUguDB1qdw+tarLMcgDWFVIS9TEYDmSy7oerkQpyk8E70mXvxto/tzPqUh4a5QW/QEWHc0lqDnPjJx+ieZ6GHcYkrzMNOcHk0bV0C5o9154R1ViXiEL0kA6xxy2awB4zZIwsInBw6/pTFfDXuaokchhJKtg++vV46b6oYZmPMiPDGb1Epyt3jBf4JpABk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199015)(38100700002)(83380400001)(4326008)(6916009)(86362001)(8936002)(5660300002)(66946007)(66476007)(66556008)(7416002)(2906002)(8676002)(44832011)(41300700001)(6486002)(6666004)(186003)(9686003)(6506007)(6512007)(316002)(478600001)(26005)(966005)(33716001)(82960400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vcEoNMnn3yDwOM8TBC8A362jRR22NOTo/k1YTvNTN+jbzNso+UTNsqWFSo1F?=
 =?us-ascii?Q?uHPBH8FHZWerazzSlGOFxIjTPOVqiYcJ7YDc8qdgwKBWuI5WTC2ESJv6C21Q?=
 =?us-ascii?Q?IP+/WcK2ATb+opNpha1+8ktjsCh8pvEaMqhIhhL+xfuVo+ig34lp4J+PmicP?=
 =?us-ascii?Q?9oQ1ARDtTd9wFwD/pgNwZ8W1G2knBxo7peKMixPubBbshYynZXobGlneVL83?=
 =?us-ascii?Q?s/N1Ar7Ey9rhpULZxUoofmxKlD98ICcmw+0499HBVsLW6ht1ftxONIPm/Q7k?=
 =?us-ascii?Q?yLfz4thZf8KyJBcrTnPiZK9v1n8B2ouWjCOWQ6F9HhuJJ/U4bYhAGDA69MAf?=
 =?us-ascii?Q?301a4bzv5T+bywQRVkkrkL7z18XntDrKkJxgfFs6tPnXogwRWd0U0+3LckfS?=
 =?us-ascii?Q?Wyvk2213wTRBr2iE/UBicbAtlpKdzwKe79hiWsONc2toeiWoXAJWQF0yDrfL?=
 =?us-ascii?Q?Bo+RuIfHrPvjNwYuF1ZLK/OREaRTPaAain2gP62p4FDfcHRmiBZf7ELgEi4b?=
 =?us-ascii?Q?76k2VrtqefOcGOco2sgw9hmBjRXDLmRJCrExvDt9dTff76UkXYbZTf4uSZci?=
 =?us-ascii?Q?HTQUQqOAxeh5k5+nPjFXWREhJQzEFA2+MXjx33V3FFZpz+xNc94A9YiuQJvm?=
 =?us-ascii?Q?+JTG9oHAr+8pVoqAfTUqfzw6HpNabXhLaWD7eF7vuM12t+Kum2KLDNQvmlw1?=
 =?us-ascii?Q?/8Wu5eNxURWHWk+ipE5wJDN9iscYNLwmPZjMh8XWr6jo8+2DAYUPiUo6i8lP?=
 =?us-ascii?Q?Ex+/AdmNo9fq5OIfOSkszolBh4xM1dCwPGxZB8tT6rsxJ6+MH2soizzAyfQi?=
 =?us-ascii?Q?MtrZmek6RWVKaHFO1p9UxT4tD62CdWlpRJnBvrJdDnsyfd0Nn1G0ztLySzCY?=
 =?us-ascii?Q?QaixZKez/0ZKUDmYggBt2aRokO+w46ZoV6JykjX2icW2ljTcLDp1AAEL69ym?=
 =?us-ascii?Q?VbSGakglAqbR7aRNUq5gDmekoTcigp7BSEIOwpCQoixaEOoYdba1dO23GeH7?=
 =?us-ascii?Q?VhrzMyUUz3++AIfMPPt3rHGZSi4XSZcwP9IXVuCUScb9PCCyNcB+iIoh5fY+?=
 =?us-ascii?Q?xVE8Kn7OCUL4PJX/ksSoo24KKbsk7kSZ/ybEn/z+z49JNQk+isyhO9wY+dIb?=
 =?us-ascii?Q?ruH650YjcYrYuG/tYE7+JxDkFxZVdHAHmFIKEdfHU2Ol5fMT/VdE6DmqeaV/?=
 =?us-ascii?Q?C0h0hOqIbf77AwaW9lqxM1dTHZAKnIM8wnnCylsyowG+sfX7xvG5k5Wxlx7b?=
 =?us-ascii?Q?lAr6ECHZG2iAqe09BVd5fRQDwO+QXSm1x6MxyXLd0LSNWsgAHh8MA7EoeUQ2?=
 =?us-ascii?Q?sFs89y6GahQLzmLg9qenA+r9eyE218YrUVgqMuQcZOH3D3f29B4lrfgjZLke?=
 =?us-ascii?Q?r1Ke5vAfVZYCVq/SAFyrnwxTrLWpCSzwG4ottxXvbKpG8IowZavNBkjdn/Nb?=
 =?us-ascii?Q?6qQEstz3+vJYPNri2BkucFfb4ThZyuzgdhEPRF8a3hSgpxgA1Gy2z1C8OK6o?=
 =?us-ascii?Q?4rBkFm4krRDEzJ5QaM10fnkfdZt9ZhPafhZ6RXeayaG5sfZEIWgAksO0BhXw?=
 =?us-ascii?Q?Tl1Gvyt1X/sHfrTvxBBui1BeXPN6+5I9KiprnynP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea114c7f-42d4-4590-6448-08daf5af90f5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 21:46:02.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlSKsDWmQNhfylp89jI5yJ861aRLV7Z1rAYIMbqAEFUqA7Y4gU1mJH81syGR3Kbr1qw1ouvbl2O3BhUvPXYkMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5920
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 12:28:45PM +0000, Jonathan Cameron wrote:
> On Mon, 09 Jan 2023 11:42:21 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > Currently the only CXL features targeted for irq support require their
> > message numbers to be within the first 16 entries.  The device may
> > however support less than 16 entries depending on the support it
> > provides.
> > 
> > Attempt to allocate these 16 irq vectors.  If the device supports less
> > then the PCI infrastructure will allocate that number.  Upon successful
> > allocation, users can plug in their respective isr at any point
> > thereafter.
> > 
> > CXL device events are signaled via interrupts.  Each event log may have
> > a different interrupt message number.  These message numbers are
> > reported in the Get Event Interrupt Policy mailbox command.
> > 
> > Add interrupt support for event logs.  Interrupts are allocated as
> > shared interrupts.  Therefore, all or some event logs can share the same
> > message number.
> > 
> > In addition all logs are queried on any interrupt in order of the most
> > to least severe based on the status register.
> > 
> > Finally place all event configuration logic into cxl_event_config().
> > Previously the logic was a simple 'read all' on start up.  But
> > interrupts must be configured prior to any reads to ensure no events are
> > missed.  A single event configuration function results in a cleaner over
> > all implementation.
> > 
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> > 
> > ---
> > Changes from V5:
> > 	Dan
> > 		Addressed missed comments on V4
> > 		https://lore.kernel.org/all/6398dd6ed80fa_b05d1294fc@dwillia2-xfh.jf.intel.com.notmuch/
> 
> You also added pci_set_master() :)

<sigh> Yes I made the mistake of putting that note in another patch and then
when I fixed it up I dropped it from here.

> 
> Which means I can now give
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> 
> I only noticed because I couldn't remember why I'd not given a tag to v4.

Sorry I'm working on getting a better workflow.
Ira

> 
> Jonathan
> 

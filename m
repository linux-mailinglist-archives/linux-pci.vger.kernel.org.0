Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC1563A24
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiGATxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGATxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 15:53:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFEC3C72F;
        Fri,  1 Jul 2022 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656705185; x=1688241185;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6prLyCupuTtVEFj08AunZREFnH/LbP6oRCatQ2yk5x8=;
  b=IITs9PuDK4Nc2KNzv0RYs/cRBMbUwrzfM42AZ8sm3VfBBOiX9fwNUJon
   jtfogulx6Q3aNicKX76LxN/xxaviYTKoFRUNwoQEqBSR9r6kWTUFHz8q8
   8gyQjIO1+mCD1c1Wz5nIBypkUK01DlNzioD+YZOCSX8c8AQX5iHIFRdQi
   M+5o48MXiVbGDNpnCNQCvBHKTiwV/2y+z00aRliZvsPGFf8vZSSMLfPV5
   kd7h9vmRzEsavVIe8g+IBNrBVjN5BhwcbJk9/h/mTnHfesnUJV4ya9UlZ
   TscfhOqVs0XE2OFss0Z56ojxdwRjTKMn5Dn5tTjPnOpQkeHMkzP8m6+AG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="280292283"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="280292283"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 12:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="591824470"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 01 Jul 2022 12:53:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 12:52:52 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 12:52:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 12:52:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 12:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il9P2Yw3Xtezj7Rj8btnr8+jqYVlzlTmMu0YgigziiULe2hlciJ70XmNgBIgPpgz3BdhLqpukl9wQUa/Bkz4kJ1YjG3MCLr28mlgRAySyl0mnV5si1C//yTFCB4rQbi19j4nNA2Bs10vffutp/Hwsjdl8YOJqSr9+P0QXJy8TfZFLzkVQdK0x7Wg1GG+yhTevRCDJHTbRFhmI5L1ZwkA5LCkeIBwYx7gxkvmG9121KipGRWb3jBgCICml+/sitGM2JGPJaherj2Jc/EgMUFI0g92F+YMqYdRhZFAQFkWN0q1ngmce4skJaEXF6LeZ88R6FXYRn7uOcMSftMdjrGXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr/WZsbUdgcmIqyx2GTyvy2tJ2jBrmEt1U4f7HH7iCk=;
 b=U5BGoPQOaI+q6KLFJ3AzXPQq7F+m4QtqHj1u55Y2arGHwvjggakLBIycohF6p+3UYVj/1ix6MwPNIZOvuyjx9gkV81OzX30omgTzXj2Apoz27wOXgneu9lVxTCPmrM1QVEkZmnL/WuDBWNaPKEkrC/YbxfPe8RQtbWd6Lf9fPUTpnqdUFWM5ouVDMW5Neu10NH3G6VwI/TPrKh5tHllxweB04JFHht2Izdw/lbqpNqNEQIQy2D8IbCnjwhrZLuhbr/0Ph0hNg2g8/nna33aO8cybWmm3Ar+NxiSW7h+3y7gXaPsS99pv3W6BXzH8VJ7FnIj55mb0PEcVNwXp6gGhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB4047.namprd11.prod.outlook.com (2603:10b6:208:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 19:52:49 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 19:52:49 +0000
Date:   Fri, 1 Jul 2022 12:52:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <Yr9Qiv/tV8f9z+Xx@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-5-ira.weiny@intel.com>
 <20220628153317.00002e36@Huawei.com>
 <Yr01iZhuG5YHThDg@iweiny-desk3>
 <20220630163240.00003596@Huawei.com>
 <20220630161406.yglzoxn2va3bhts4@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630161406.yglzoxn2va3bhts4@offworld>
X-ClientProxiedBy: BYAPR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:a03:117::21) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd269a68-b911-4c65-ad98-08da5b9b46ed
X-MS-TrafficTypeDiagnostic: MN2PR11MB4047:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0sCr//zxVdl8IIBO0I3DhuzvJXdx5XxJDtVUjDOAEtDT1DwTAGZlR5deHx1TMtUA55Jdr6FTJUdDTAJMYYmZVn0CKhQsLmbSR3cJ4w42qREOmxAgquRvPAkKuv3F3PgpyRWEu0aPHsufAzyeiHaZFigDxXYu+T+ABOYcI38HLBrAP4OK2biB8FEBZJiSnx2yIDkdNZcWD49ggBmgqwH3GIH/jLMEV3qsBIZfzg+eLAfrWl7tmdR1CeCCxLG8OjXVPQU9A85q5QZCiKT9kEZUyZj6Far3RUNpu+47kUArSN07tltjjQlpfw2Y8orHpxVsfsS70eNPUtMQMhHMKomvvC6Ri2eVOPUZTNKr3KBR9Um1OliPqK6qyFJJ1aWZBPQiClASw8M3wuHjQ3XT5kFPpT+oXcUrsToDjrDEhhS9tDGg/+nxVT7/bj6xqOWUMSnWVAP9zkxzUQgufuSJSenC3NHirA2nk04KzNdb3fm7Z7jfP0tPjkzY6fruJlOqYz3Ge3VNTHs4MOONCRRUPYX8xiesUq6T6AYluQ0jDKxRBbxANaKwbHBYtfHzVvyj0xWCty1pITNauuYERrwFpIbbzQvaVzM9LNURwHOwscMMwARifrzVB0uztJInSznVlJNPyKRrwStZBZebKjr4dvbfUhOlcM1ljB7Oj9lmJZApqvKiznEcK5pMH12x8xsjxys6S06UnR7fuQtzOUQ40oXqZOdN6IEgzw6iwM1GORyDgDlyiumjyO6Dm2Lx0QmPYKLrczx4GAPe2YC9xAZJVEEFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(39860400002)(366004)(136003)(396003)(33716001)(66556008)(66476007)(15650500001)(8676002)(66946007)(4326008)(478600001)(41300700001)(8936002)(2906002)(6666004)(6486002)(5660300002)(44832011)(83380400001)(9686003)(54906003)(82960400001)(6916009)(38100700002)(86362001)(6506007)(316002)(6512007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y7XUx/yHeUZGj1iJpWv5VzpUN1be1owZTmLnZOf/kvdryYkkN2jKzF1Vbk5A?=
 =?us-ascii?Q?UVXrFdNJfPu3003ritMaG6b+VYjgxoNO6p7YBT628uDQl06bVbwUn5PEcW0l?=
 =?us-ascii?Q?XCkb2/Vy9mJ7R5fUb+cn58t358vz32dhijh2omSA3OvFQJ14YDoNsskuX7If?=
 =?us-ascii?Q?dT4rtL/zlEO2k8lTYgeSTQ0Jt55SSTmdQKTBn5ESbq7bdtGy0XaHAgSpNzzS?=
 =?us-ascii?Q?ML6gG4H34m1KC32PftX2Vw2NTEVYoMw2cViPsqNjcB8SFYLkqXwdBJ9loiSH?=
 =?us-ascii?Q?WclnW07cCPVadgqdHSA8RhNFHWVV3G95Q14zU6+XiWU49o7xmnnpbjFDxJ5l?=
 =?us-ascii?Q?+JDzITtmjZ9v2q+XpSpnZ2VSGOVOdziCdRCcnT3QVnYUDi81SY6GG2LBi6nU?=
 =?us-ascii?Q?65mBG6HUMrqs8ApHIAIQJEGOxr7ac9CNSWMmS3smOPraBZRkA7cEFbi8yV8I?=
 =?us-ascii?Q?ZbQeMz+YDq6z/I5FRq2BYabSV8J5tDELBD8O36eTcPEk+7Qf/CG09bvfk2Py?=
 =?us-ascii?Q?+84CtyqXXs1d3CWOYz5zd84bWQmOZNzIMgNv0lKXxkrKe+hevjTU4QMYndaP?=
 =?us-ascii?Q?GaHYKCNFlp1o9LXbxqDs1ttQwGmEdf53294PQcD8RBlXNCyPY5BoVz9n9N20?=
 =?us-ascii?Q?Oq9bk4cwYSn3AQef5FRxZOkay9iD53goEnpQ9kQe7spTWl1UYQSJET2zUq24?=
 =?us-ascii?Q?/qkjtrekWm4DGoIFEIgnT9Z2Otj0YFWaY+o/Xr3FjKikKJUOCBuWcQzlp3eW?=
 =?us-ascii?Q?hBXEK6o36xfDCMBYuJd4VskDwFHl9UI3WvWWPzXCTFZGj2m5MapmJtAUc1LQ?=
 =?us-ascii?Q?/7xpIXxBkATSljraTeflQF9YO3BIZyGTsnCgSS1H2VKNMZspxiuZz7yC9BO2?=
 =?us-ascii?Q?VN1XvDw76u9zxsjh5bZETINdctE3sJ+V/ZvaJcEjZWAb0o7EZ2iRxAoeBw1o?=
 =?us-ascii?Q?E8KbEPT6+azdBmNpXu4NNldVaBNpzgVf/R554EFWsDifeeIBQ8auM5eUDNlv?=
 =?us-ascii?Q?UviMbN4CjXwJPKZnPHeIXcHbub49Gb0wMLOCzJZFlC6oCyiinXMye89UuYaO?=
 =?us-ascii?Q?ERNQjskq5fDSkhrFwm7Nc2ibGDU28lMT//wMuPS0ow7tnCUPuy6Q0mH2XiM8?=
 =?us-ascii?Q?wzaDN+AyAF26aCYuyiPji8LwyqyuS/rO3RBLOvy1o9ovclKlCKZlMJ2eviuq?=
 =?us-ascii?Q?jJc91UGa7AWEckf1NAO82lUvW3s/YQUYZD9D0qCTrpR4gskB5wBCgPAslOCU?=
 =?us-ascii?Q?68MLr8OWINR3sP+P8UB/v7eoeRl+k8N0Cu2H8gQqMFxZBHrxOeeDR9+zFSdW?=
 =?us-ascii?Q?kGAJo083tQrKJ9n54Ojg7X82RvnxnHIiVmYq/k08V9ejrfxPl6K/HpeQttla?=
 =?us-ascii?Q?IBT310h08mfijWRy7g8UjjoQreIfBNWoEAlvd6Ha7V9atcyTRxXt86wPj1t4?=
 =?us-ascii?Q?msTdHlAkChYgSEIhPkDiCUpV553Qu2iArix6T1N57BnUw1kZm4pYqk9QNWlf?=
 =?us-ascii?Q?81kPcB/0Srby6xgLMIYPwWjGkSjbFiwT2U3mppg2lVqP8bCvo41Ydq2Mq7gU?=
 =?us-ascii?Q?wXzasABkuGf/kBNcRGDQbAmwJLMxUHw2+CB/ZBpMf4OlXLQuUh0ldjABBbfY?=
 =?us-ascii?Q?l46OK02HDmhAG8U8hWI6tPbj2VCCAA9qHnoUntplny3s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd269a68-b911-4c65-ad98-08da5b9b46ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 19:52:49.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvnXq+c83HhWDhS1w2uprRq9ryVWerkteD6+RIMznHzTCKc1wRJZyEFjbp9ZKkhrEjJh94eeIcEQRRl8biE8BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4047
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 30, 2022 at 09:14:06AM -0700, Davidlohr Bueso wrote:
> On Thu, 30 Jun 2022, Jonathan Cameron wrote:
> 
> > On Wed, 29 Jun 2022 22:32:57 -0700 Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > > I _thought_ that we did not care if some mailboxes failed or not.
> > 
> > I have a different view to Dan on this.  In my view if your hardware is
> > not working in any way at all scream like mad don't carry on... Dan
> > is keen to try to muddle onwards.
> 
> I am also of the idea of not carrying on upon any indication of failure.
> 
> > > 
> > > If CDAT is not supported on any of the mailboxes found then CDAT will not show
> > > up on sysfs (as per Dan's last comment).  If it was supported on a mailbox but
> > > no data is found the sysfs will show up but be 0 length.
> > > 
> > > At this layer I thought we agreed to skip over these errors.  If a protocol is
> > > needed at a higher layer and it is not found on any of the mailboxes the errors
> > > should show up in that layer.  In this series CDAT is not 100% necessary as
> > > devices can work without it.  So the errors were mostly paper'ed over in favor
> > > of just printing error messages and muddle on.
> > > 
> > > The xa_insert() deserves a pci_err() though.
> > 
> > That's probably the minimum we should do.  The xa_insert() failing is something
> > horrible going wrong in our software / host afterall.
> 
> Yes. And in addition, devm_cxl_pci_create_doe() should return any error status, and
> cxl_pci_probe() can choose to omit any errors, but it's still better to have it.

I don't think this adds anything.  If devm_cxl_pci_create_doe() already prints
error messages what is cxl_pci_probe() going to do with the error if it does
not fail the probe?

I want devm_cxl_pci_create_doe() to continue trying to create the mailbox
objects.  So for now I'm going to print the errors in devm_cxl_pci_create_doe()
and keep going without returning any error.

Ira

> 
> Thanks,
> Davidlohr

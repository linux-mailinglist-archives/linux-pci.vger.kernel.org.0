Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6663DFCB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 19:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiK3Suh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 13:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiK3Sua (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 13:50:30 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AB55C89;
        Wed, 30 Nov 2022 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669834229; x=1701370229;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R1w2BrvfcdQC6VD4mDza86pH0QpUTwW4tHm1Z7LrJEM=;
  b=Rr+IPKsyaeIrLoPlbx95jnNZweIpxutcmPR/u9W9PDGMMRhv8MU82Pv1
   ojvqBDT88Pr/SWA555HSNKeRe1PIR687FEJYP9RItuQTyGbBtnhvS2efp
   3ljI1RJEXLyo8LgHsiBOOYcYOSBadmuNfkNIdDK7SqlRG0wXvNWJieNIT
   BilVkkOFAwaCpWCGaLEXWOVxbXttmU9DZ/iSF9/N0udaQz16v4BsZmD7U
   qqLQNdHXSP6yalHdWJ810pmWvcA5LH73aRISaKIsTWBFjx2AgIrOOglbi
   fS7ubNZ8Eku0Vsj9TIc8HB4htok13Tx3l73YZD53Pf5FfKd0sulxaIivi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377643861"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377643861"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 10:50:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="818736255"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="818736255"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2022 10:50:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 10:50:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 10:50:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 10:50:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 10:50:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmKkakKlWj7RBYEyI22z4OyiI4HkMDjs23OENjqdcpR1b381c0w0wnuHzlxAejL0PQohAzzEzEyG9vVUnWV6pviVbTLie41NE00UYH3vMSF4vzEoYyYNijwCQds2Xtd67UPxb4Tr399tf4NAoGgwLAhaw49eaJ29EwBFsiFcVL8sSQ1i6y7FK/zMS+wSSp1qfNNBZo2r5kntW304KB6tkJFkWLlA6dIsg+v8Ty1q7EysNWrMaRhDT+wukd/Hx6toqJQPototBj8u2ojc2UwWN/ocdnYo/XTBq17+i5e4fW2jUtv5gSWq1BrlXVxYhczQU1+BZynf7cYwTl0YfrAqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6gih1F6zfGlNwf8+QwzXcQu7vzVqklqOsgkqxBc22s=;
 b=Bw4wCxtd9jV7e5Wjcjh/uYI3QG3PFXfKuVZDSpNSbWxTeUFxpvV2kv+FlvmNJZUQ33bnpkJXLrkVYIY/LYGKc9JgYrJFc5+8El1tWOquxfE2WFQXoRhuL3nOd0HWUSuE6eRvAXp/oPlist2uFXeC3WYxD8UXB4e+VKi2BAL/3gVQRvYvJHYCUplZHh+o8TG76MN2GoeLJXQ/fT2iIv/h+0fzDZTsRtjehT3hnAsV3BhIXsPMDW7jDHJnRjW0PLVPvBD4fDudu1vBq9PJ4VdiZ77R2og1r7hEASmsH8aELPu8aTSNm9yxKbXazLrD1Z6z5hQeSpVkSm72NvrUWzQTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 18:50:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 18:50:21 +0000
Date:   Wed, 30 Nov 2022 10:50:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI/DOE: Provide synchronous API
Message-ID: <Y4el6AjYKWcJhhxT@iweiny-desk3>
References: <cover.1669608950.git.lukas@wunner.de>
 <7ced46eaf68bed71b6414a93ac41f26cfd54a991.1669608950.git.lukas@wunner.de>
 <20221130153330.000049b3@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221130153330.000049b3@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a32fa09-af9b-40a6-e073-08dad303bb69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kJcHor03TaOHdpO7Q4lvDjQsAEyy7I8k0ZkSRH1oMe+wCOnS4mSDj0E7BLMmAyZuxU0+vQgqH762P1rWw5yRN70qEljE3hbvCmvu+RpfxMWlA8YfHTbOzFdOpCCsLuLxOUV6EFvsuwCTzOGDhfhWB5f5hMuIsI3lE8ECSbWAKgvy3uuA9VPuVqaj1m4YpJchO9IzmiljsYCw82DM58cHT+Y0AsM0JLotC4F41U8DCL3XUVA/QCt1ijlbUsaoqiu3qYgpsIYkE6QneFvauhx2dC5YHNrF4UeNK9M1S25IgSSfGSn5Ex5DWbxdHLe8Xo8KbawZXlJ10nt+L2RkMzKTBNP5SyBYiQIsg8WSSBFoB+gEAiVjITqYBELCV7BUe4sjlo8/ebegPAObOT+NgKygsG2/woy5wXawJqyOj7uUb7MiwjDkl7MrXpUvGv3Fz0FAn+G3Bn/PEqYcG28Zp4JEB+/hu1Cq+5jjnaoSt5MZ1diwNXibEhHh5dPBi2B065hjQMTBoWVDg4qOVhciCpkTDG4rhh0SAZpZHQasCZe/Gse7brK5OSxDoxCw/6vnG36/yVg+9pJHpkRxDKWdnnTZCz0LeWDz3VSLHI/X/phfJVrwtLKfMel5GhGy3Bigyp1H2cLCKjMherTn+zcRsQTJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(66476007)(6916009)(2906002)(66899015)(44832011)(41300700001)(54906003)(66556008)(66946007)(4326008)(8676002)(316002)(5660300002)(33716001)(8936002)(186003)(86362001)(26005)(6512007)(6486002)(9686003)(6666004)(6506007)(38100700002)(478600001)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNhxFPnysRGizo7PjYUZg+VM+S1nCGBj4Xd/NgRKPG1i2MalGxs34ymGP29q?=
 =?us-ascii?Q?7sn0qNdeApJOoLhEaxybqjWfz6RzoL05coU8vuShZoUufM4ktZ/M4nh5ViSm?=
 =?us-ascii?Q?DCKT3iO2+BPiViXzmmccyqnZT94hanAeKUe/MH+DqqKgAXVtbChMHGNBR9Pn?=
 =?us-ascii?Q?de4I5z3QJFpr1pk+gcDtGK/667ZgqRFHrkVhiID7CI4NJqU1mOpDjMyDLLlF?=
 =?us-ascii?Q?tB3ctf3R6HKT3iSx/Urct93TOpNx4+sqZF9ANmGpDr3F9Ek9J+4H6jRc3RVU?=
 =?us-ascii?Q?sfEPMdHBmk3Ff9imICraNie3ljmdH/0Ucyraga1e7CNp7ePrPjZvHWerZiNH?=
 =?us-ascii?Q?3RggGMiulHQr3m5E7QMEL+WBEE6XrQsgE0KIYDaY9jtMF5vPxrM7l80YzFU1?=
 =?us-ascii?Q?hfEY9zymv5womy9ZdNJx9lE1zO4WwIyULYPTF03M0+s0nZPYPhxR3tqjbfmE?=
 =?us-ascii?Q?WkBzwd7G90bqvf7m21xOuEkuL4zfe18018UK9wI9dispMD1qLOkS+rWHVjoM?=
 =?us-ascii?Q?RDu1ylUI/ZYPXp5iiCt9GHB9Izh5t6lvOeAxrM3lz6NhvhQZEZSQPHH18TjI?=
 =?us-ascii?Q?nYcK0xbu/PE57O/uRXOs11zAPYgRjPR4J/i8CwPOnn+6WnjQBpqyk68HgJXO?=
 =?us-ascii?Q?7UXyFWZW1U5vpe5dYU7xhvRnBcWzo3GCB8/ukjAK+IzEqVFvqFptYrzeP5qh?=
 =?us-ascii?Q?EJ/2N60odmfU94n5dY54af06Npo2yGd4961zCkZ8bWuZ6wagHHdiM/ZBDVLU?=
 =?us-ascii?Q?hq0hiU9Zi32ShMQdwkLt32cVgcg5WuUlynn03htjRmj0VfMN4fHSdzL6EaS/?=
 =?us-ascii?Q?1EygYbF2X+oSFwcjixs1kUvKm1d5xs3GoJEdHOMkw9GKTHC69ByFZvx9t0yb?=
 =?us-ascii?Q?saPZddrgFuLqqfYchSpJ+oaKHsccQ9k7FxPRuLX5u44Doi/GS9rMcslgF7na?=
 =?us-ascii?Q?al6tckYst6ns7uJqWrQdnm1Wi4ZQH6MQA/tcVpndauiAJ/s4Uz3KBPC7sEIy?=
 =?us-ascii?Q?/RZwMfBmV2XYNbzBE1IYT+RKjoV+4vRKtRWxSqR9G0+zCMos7u6gWTFIekH1?=
 =?us-ascii?Q?TP6voQfor8nPEvBn+csQa17iw1S2wLm5FqGq0ag5LUHnApx1kRjm2sAl3Slo?=
 =?us-ascii?Q?62X1s5axKeZvOA5EtrjQL/FV47K743iHsMVn788hNPvZ5mTT4XF8iqtwWhrV?=
 =?us-ascii?Q?/GF3HRqfiFSezeMriwzSpXiB7bIfa1j8nFKQ90f/TIYkhQiz+yuK9ArLHi8S?=
 =?us-ascii?Q?0teyNwvNLPW1CmqxnDjKUKcnULTEtMZf6ofEv1a8zlNnDEBsqWBCPl/R5BFn?=
 =?us-ascii?Q?fzGsiudlQDL1a7HnJHDDxuGbGhR51EXYCvSGrblPaejb+84hmdHv9umYT9P9?=
 =?us-ascii?Q?Bk7xXY2SKqbjgc/SWO/m03/5P5YpzHO7akWG2vuXyAmp0+/VwBtWI7U+8iaD?=
 =?us-ascii?Q?wTWbxKVIkfa5EBYQdefSVBZrPWgHh1kMWQco+illHuCq/yor5XaIj4/9b50X?=
 =?us-ascii?Q?m9dkNEJE6xb3ZltZWKOlPRY2ca3djdO/Ou/jf750sfd2ZOJS5CSPx5hznHjk?=
 =?us-ascii?Q?Jmf+fQgMUjWBMzMPE5uQ85uupAZW5zbj9A4Gzvtj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a32fa09-af9b-40a6-e073-08dad303bb69
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 18:50:21.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpMhCU9p0jeiC2ElqNthIgM2zcZmiF9fZ5Ytb2Qp8QSfZ4qZqqiLj6Z2fL7Qmw7Io3Vt4n4ro+zWtP0Fq4X31Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 30, 2022 at 03:33:30PM +0000, Jonathan Cameron wrote:
> On Mon, 28 Nov 2022 05:25:52 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > The DOE API only allows asynchronous exchanges and forces callers to
> > provide a completion callback.  Yet all existing callers only perform
> > synchronous exchanges.  Upcoming patches for CMA (Component Measurement
> > and Authentication, PCIe r6.0.1 sec 6.31) likewise require only
> > synchronous DOE exchanges.  Asynchronous users are currently not
> > foreseeable.
> > 
> > Provide a synchronous pci_doe() API call which builds on the internal
> > asynchronous machinery.  Should asynchronous users appear, reintroducing
> > a pci_doe_async() API call will be trivial.
> > 
> > Convert all users to the new synchronous API and make the asynchronous
> > pci_doe_submit_task() as well as the pci_doe_task struct private.
> > 
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Hi Lukas,
> 
> Thanks for looking at this.  A few trivial comments line.
> 
> This covers the existing question around async vs sync
> but doesn't have the potential advantages that Ira's series
> has in terms of ripping out a bunch of complexity.
> 
> I'm too tied up in the various implementations to offer a clear
> view on which way was should go on this - I'll end up spending
> all day arguing with myself!
> 
> It's a bit of crystal ball gazing for how useful keeping the async stuff

I agree that this is much too 'crystal ball gazing' for me as well.  See below
for more.

> around will be.  Might be a case of taking your first patch then
> sitting on the current implementation for a cycle or two to see
> if it get users... Or take approach Ira proposed and only put the
> infrastructure back in when we have a user for async.
> 
> Jonathan
> 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 52541eac17f1..7d1eb5bef4b5 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> 
> ...
> 
> > +/**
> > + * struct pci_doe_task - represents a single query/response
> > + *
> > + * @prot: DOE Protocol
> > + * @request_pl: The request payload
> > + * @request_pl_sz: Size of the request payload (bytes)
> > + * @response_pl: The response payload
> > + * @response_pl_sz: Size of the response payload (bytes)
> > + * @rv: Return value.  Length of received response or error (bytes)
> > + * @complete: Called when task is complete
> > + * @private: Private data for the consumer
> > + * @work: Used internally by the mailbox
> > + * @doe_mb: Used internally by the mailbox
> > + *
> > + * The payload sizes and rv are specified in bytes with the following
> > + * restrictions concerning the protocol.
> > + *
> > + *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> > + *	2) The response_pl_sz must be >= a single double word (4 bytes)
> > + *	3) rv is returned as bytes but it will be a multiple of double words
> > + *
> > + * NOTE there is no need for the caller to initialize work or doe_mb.
> 
> Cut and paste from original, but what's the "caller" of a struct? I'd just
> drop this NOTE as it's better explained below.
> 
> > + */
> > +struct pci_doe_task {
> > +	struct pci_doe_protocol prot;
> > +	u32 *request_pl;
> > +	size_t request_pl_sz;
> > +	u32 *response_pl;
> > +	size_t response_pl_sz;
> > +	int rv;
> > +	void (*complete)(struct pci_doe_task *task);
> > +	void *private;
> > +
> > +	/* initialized by pci_doe_submit_task() */
> > +	struct work_struct work;
> > +	struct pci_doe_mb *doe_mb;
> > +};
> > +
> 
> ...
> 
> >  /**
> >   * pci_doe_for_each_off - Iterate each DOE capability
> >   * @pdev: struct pci_dev to iterate
> > @@ -72,6 +29,8 @@ struct pci_doe_task {
> >  
> >  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> Whilst there is clearly a verb hidden in that doe, the fact that the
> whole spec section is called the same is confusing.
> 
> pci_doe_query_response() maybe or pci_doe_do() perhaps?

Or just pci_doe_submit()?

Lukas and I discussed this off-line.  Because he is going to need this stuff
going forward.  I'm going to back off fixing this and let him handle it.

I agree with him that eventually something like a 'flush' operation will be
needed but right now that mechanism is broken.  I'll let him determine if it
should be removed or fixed depending on his future needs.

Ira

> 
> 
> > +	    void *request, size_t request_sz,
> > +	    void *response, size_t response_sz);
> >  
> >  #endif
> 

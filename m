Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A058457A76E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiGSTvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiGSTvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 15:51:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500F552466;
        Tue, 19 Jul 2022 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658260279; x=1689796279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YhvAa6AF+UX61ykkeQB0zttYrFLLzzqhzczVYAewPZ0=;
  b=oCZ4toKGvvYtO0w9B2yp0LKSZuIVQqH61cdeNLUtkap7FzKAUrNlA4KV
   mMG2O7BafgqxkqPlpUT1EftsiMnuTmadMFunnfKGQ3Jhw7z+PBitMv/lr
   CZHwlQ13otR1Dn9epLSi7h6k7dXQjIYyKF7HqOyRAmYNVm6orJvKjcH14
   QPCIAm9wfYh6OSzv0t+Xc0rYePLzhMF8U78C6SbJewgOJLNGX/fCAWhyM
   n8GYjVXOemTXdfrvzFVSx7wqGZ978JSLDD3DOmQXr3RoPPk9doxfqPTpy
   4vE6i+qm8HB+uLYnHw6lj00kBHIg69almoqhftMW5DM3d8C/ER/zouqH9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="285337378"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="285337378"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 12:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="655924332"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2022 12:51:18 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 12:51:18 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Jul 2022 12:51:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Jul 2022 12:51:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 12:51:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0g+Ni/fVmvkfU4R0Di4ILfh5ohxvyGM2hSpa9LPc+8bxAZ5gkmhDOlnHElw8ZZ/5fOcoquGhueAyH39bOQVJiefc5FU/Yop5BVt9nO9tEFNbHybSK6z83wi6buwaEvumHDgQDt0DlnGs1JLhzjRLP8RNnkk+LHCS0kFGT9lzjMZWbeguydsybpxVxK7QdzQjHjZswFD17qmHjEu1x4YKGpm1LIvLA4ICq4DULbFcrt7i14ZEkwYee0C0hTc/+mllJfp7mCH7FIXatelp+YEweWpvhn+AdviznTBJEZtf4b0vtgViY3brL/ScpUIUJdeL3juh4UKShLlhi39HO1Unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiZ5dMYACtWQAvyap3RzHSCtNB7bnlWfq0MDtMML4AA=;
 b=dd2KuGBP+Ae8K9bXrq8foRFyW7JM9R13iMkxjRmo4IOAdvd7c1FvQIF2vSIro7HAte/Si3IWlPQEaLNl9VOVw9qTxEZ2SGGqaV5R+x2ojD2YEbkjv6lEQmpX4j5/o5HOUjnSDZYR3n1203kAiR6oYQ144ucFa+BvwkDPDOv3z7BFwUr+j+UEdecgP3pI7q14uzYJ00BPwEOGL6ZaxrkOQBnGqNjexZrfd3p97nj9UExFHfPp6fHG6XYguCPfLuCsVzc8O17YSwjLPKWrmDPxApZneU+sJFgM7E7/Qy7KbAyWYmIL+jXtWo2OfbDSR8GY5ujNJ7uEFTkoenlWYy6dXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 19:51:02 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%6]) with mapi id 15.20.5438.017; Tue, 19 Jul 2022
 19:51:02 +0000
Date:   Tue, 19 Jul 2022 12:50:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V14 3/7] PCI/DOE: Add DOE mailbox support functions
Message-ID: <YtcLIAIlSKQpzysl@iweiny-desk3>
References: <20220715030424.462963-1-ira.weiny@intel.com>
 <20220715030424.462963-4-ira.weiny@intel.com>
 <20220719173553.000067c6@Huawei.com>
 <YtcC9qYo1lOGZ/83@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YtcC9qYo1lOGZ/83@iweiny-desk3>
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c4f69d8-bfd1-4781-df04-08da69c00278
X-MS-TrafficTypeDiagnostic: MN2PR11MB4648:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrEY8rX2ePoIwbN1IOFN46qEDAUcANz3DpyLu1bDmW9j5mDLNWf3HKXjVeUFIlwRK7f6ZIx+Sqh1/N4nm26GW1h0se/tEbcc3TnUBz6uWa3i+btoBOfVKAGkB6W2mk3x26zHPA512IWbEAs9ciC13yDaby2unDlmXvVu989fL3uVN6UQFEGoowt5hqo0IqkvzDDfAgJ7fTBLQ9ZrZhQzo9ri5jcpSJ5jE6/e5d4q8tmJCpc0iNBQulVi2wnic7mBA4P4Dqf62ilJIYvWrQ06CpaV/SIUp5BN2Ao174n0O7jChWqyOR+5SFjLmC+RNMo1AXSJWLqhHpE4Z/7tZTfVCjLq4+YwOKjTqB7SotRKUPaWshlrbo4l8XelA0lzeozEYrG87OQqGBbRlfrNDKEkStsaTeauoJPlgLKlWjv5xWdfOBNy9Jvil+4Z4u+csfqQKWqFriq49XtCKhdhU+5bmuvZGcN7sHBra3ym8Q0K2A3yFtryB9u5sVTdy7IR7X+qxc8bo0QodUNfVkmtpeYClr5Q4qrysbIFK7BXkOnWk1OZ5RHAgyhB/Wa7r+1BWBRUt9NsCdF4wmkfn9x1PmB9XkfQy0vFFBEv7qJH10NWzq1bKudvRpkqGb4KwbxVavWmnI8pi1DEK1ROwRLDmtDFNbMvtOS1xIqSforUBelXonfUwFo6FqjWRzoSD5bQhSBgFm5PXxOCD12BLWlL13qaRronx5vDVgzUYomBqZ+xEyvcaW6iUKyib6K1tY5V7INq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(136003)(39860400002)(396003)(366004)(82960400001)(6666004)(86362001)(478600001)(41300700001)(54906003)(186003)(26005)(6486002)(316002)(83380400001)(6506007)(6512007)(9686003)(6916009)(66946007)(4326008)(66556008)(33716001)(5660300002)(66476007)(8936002)(44832011)(8676002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ZGCaXGdjk6k/PcvvSRK1nkSUIZCNkM/ZeVKYE2R4yfwVy2gMTuen/26axCA?=
 =?us-ascii?Q?f+B6/0IYXkAu81Mm4qFgsapGKevVOvtU/ajcGCwd8wE2ej6hVvJqIz9FN97f?=
 =?us-ascii?Q?YD5Svo8Sh2oa/CbrHUoY9UM4AikQMFvSSx/D2qXsLGVz8kOtmzRJVCbUTDq9?=
 =?us-ascii?Q?JsuADgbQuKU4vCHmgsaIxgzzykrY1Ktyza3y0ptN2MYNGvVkfpSXkN/IM2Wh?=
 =?us-ascii?Q?XpRhbMx++slA4amIfRB/3WM6uF7n+0IdRzQ6Dni5/3SLiqdPHjm8Jp/vLUoL?=
 =?us-ascii?Q?IbJ/U+w5VO/IVvC4RndDuGnOGK1WpMJ56gk99Hdt8OFaxHyBUdvPQsbyRb2p?=
 =?us-ascii?Q?kSfFGfz3wBDzI6nQD5U/vb2Mj31TD70lRz9Ja8krxeslVOSKDvP+eBZNVF3z?=
 =?us-ascii?Q?coNMAH41gwYvE7w1+DWcC4d4SVnAKe7bOHSQVdviqznq+WU3485F8Tlj3qXO?=
 =?us-ascii?Q?6b2CBfhZ0eNcR078Vj5J+t2rFWF7/typdMQr+kHOPpLI5qwVmdeujTHgsTLD?=
 =?us-ascii?Q?N0ulyGmcvlgCyBhrE0mAwy6Yq9SZF+dMe2S71r42CnEn0YxJQE25WD6j6P9+?=
 =?us-ascii?Q?MyTXGP6TGa0fi4V6MHuReCQvJ+RHngRfQQiQ2XCOz78pVOfHZbAOaB6dcLS3?=
 =?us-ascii?Q?RvcG2Glge8hqrnkIsiW62pg5n7jTmaQvdlqHO1ajqf2gbY8P2Cb0Za5+o03O?=
 =?us-ascii?Q?gkBEpw4CEaQDZWcXwl2PHwFECrFTCsuAwvd2JKJZwNFyDfBdTr/CCPPqhLYI?=
 =?us-ascii?Q?yqNeRPCcAR3W20p4fmpUcXSvm7AYnU2GTQCIb6N/NcT2VhxJX/DN2Chrfiww?=
 =?us-ascii?Q?njPLrZZRGfDwR0o6DEeuJn0mScMkaNK2owhr2TCTKSvzKFYG0tB4NgB3wchp?=
 =?us-ascii?Q?pO6OTaarQxzCtR+I6N13mDFiIFs+m4yemzOF9PPtf3cXhyJtSW4cbpA1y46D?=
 =?us-ascii?Q?7c9ugXT5vIPtAoI6cEo81WEhgpLdlDwDwWbBl10kUmU5WqSBBzE2A5PRd9Gm?=
 =?us-ascii?Q?2SpmXrrQjgOziMLSxufmiqhAB8TdUBDCZL2EbfJu/fuClcpZ098sVTqUvgtn?=
 =?us-ascii?Q?DCK8cJPZvcHQUmmelt2W3ch+i6onqS0EF6E0ZKPuYM/GmtnUAo/0DDR7BwwT?=
 =?us-ascii?Q?3E79WR4TELbR8M19EVEfRdzjbx6hFrR6hGUNQvd6L+PtEvRhiHkjJnK/g4iP?=
 =?us-ascii?Q?/oerpwKuixwncfQqYTAF1Qmpnyqx1w+YeBUe9iLi9HYWyGwZIedZR6zNZcpW?=
 =?us-ascii?Q?5sxx21/mX5sq05eTGH1DT7JKMjygG/bs68xUzwy9p6baZe8nU6VVtjEx/egi?=
 =?us-ascii?Q?fQbuqbOfjgcVkFvu/S93xRuFFhUleRuW6LLxwwEy6RLs+jHkcm6xIDIjodd/?=
 =?us-ascii?Q?zYTVXT3Pu16Gq3FCCiXrM4c0zoa6VAwGJPKtMh4ckY4yN01tZVagXGZumF05?=
 =?us-ascii?Q?PqEUH+oRG927khsR5HdgzH/NQVqsUft3gW9/Hs/B/0qgIaSR0qy2oNiKBCr4?=
 =?us-ascii?Q?/ITpz+5RBaZAdOTilsn6Z6t+NIh3Bp5Ca77vjKL1yxptCm9RqK0b480dvlAH?=
 =?us-ascii?Q?3AQWyAx2brnGn4CqbzngP9niHliamJ7A8lw3Uo9C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4f69d8-bfd1-4781-df04-08da69c00278
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:51:02.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn+MLdVSDyc8Bv3h6XPaRZiBmN6Yr/mY+bUqyCHu/6Fura7yhqykvnTchqABGM60jEfGda5CqksqpC3etPv7BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 12:16:06PM -0700, Ira wrote:
> On Tue, Jul 19, 2022 at 05:35:53PM +0100, Jonathan Cameron wrote:
[snip]

> > Hi Ira,
> > 
> > Thanks for persisting with this!
> > 
> > So, I think this works, but there is at least one 'sleep' I can't
> > see a purpose for.  I think it's just a left over from refactoring.
> > 
> > A few other more trivial things inline.

[snip]

> > > +
> > > +#define PCI_DOE_BUSY_MAX_RETRIES 16
> > Left over from removed code.
> 
> I think Dan may have taken these.  If so I'll send a clean up.  If not I can
> spin.  Let me check.

I'm spinning a v15 of this patch.

[snip]

> 
> > 
> > > +	if (rc) {
> > > +		/*
> > > +		 * The specification does not provide any guidance on how to
> > > +		 * resolve conflicting requests from other entities.
> > > +		 * Furthermore, it is likely that busy will not be detected
> > > +		 * most of the time.  Flag any detection of status busy with an
> > > +		 * error.
> > > +		 */
> > > +		if (rc == -EBUSY)
> > > +			dev_err_ratelimited(&pdev->dev, "[%x] busy detected; another entity is sending conflicting requests\n",
> > > +					    offset);
> > > +		signal_task_abort(task, rc);
> > > +		return;
> > > +	}
> > > +
> > > +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> > > +	rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > 
> > What's this particular wait for?  I think you can just move directly to checking
> > if the response is ready.
> 
> We could but I assume it will take at least some time to process the request.
> So it seemed best to wait and then check.
> 
> But of course we all know that also used to wait for an IRQ as an option.  :-/
> 
> I'm really on the fence here because I don't think it really matters.  We are
> sleeping so it does not really affect the system much and this is not a
> performance path.  If we were spinning I would agree with you.

I've deferred to your expertise here and removed the extra wait.

Ira


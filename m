Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC51257A707
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 21:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiGSTQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiGSTQ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 15:16:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7250725;
        Tue, 19 Jul 2022 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658258187; x=1689794187;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HmWhLWDotUgRK9swgjkk4JVEd+KxoM2/gcS5/xRuLvA=;
  b=HeaI/zIlAEp0kOOMSYxlR4qPW6iYfGAkdny0bwLXBNvOne6SyR89ieU4
   D6gtBnGKNmExAMEnPJGDOy/XHXBSaBcYxlGCGPmQyv41cjmRgNRYl4vb6
   psyPRtku10Un4+6yjcTCnDhX2CjcTbjZWS/7dZ/yJDHn58VtoYJPDzMlp
   cFph+L7DxD9B/8vEPmIiOwXO4Ql+CFbH/MRwmZSeMxKmfzHchJ3Y27dht
   Uo0xNr+pfyCElJgR2tlp/6vscv31tEXRJ3qG1UE20E5g9nW+hzOKnmdhT
   HxvSrGiK1uCJ4Iy1jnn4RGJSBcDCkM1eXipvwnptEgl+AqqhRkFSRg1q9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="269603398"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="269603398"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 12:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="700571122"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2022 12:16:17 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 12:16:17 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Jul 2022 12:16:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 19 Jul 2022 12:16:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 12:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAL9o95WVz1VM2sMxkfPaJ5bA7IVUsHADBx0ztoxL+Xoykv1xjolCftsTiiTOei/zZx11dpfPKIO93hydToxRkhIHFfxY5f6cJ8IyUyqD7IMG3ziOK3SjWFXcrQudx2C8knthqFdWu30UXUlosI+S9f6nuZpZyDUJUnMZA2pAfbBM7RG1PiTUOoQa9SdonUlIF2MDM9QbzUANOdRK+lWET+LeLyY0rH+h795fhRs+xKJOUw6KIpkXca+2OFOo+APCwD4HC2XNPrLdnmYcEHK/37N5DTKUexQ/rrE1Jj0wCyDtGZ+jOoVy6Wt4kNws/jP7ho35zuswzxMdUflCjQ8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tMkWCQjtyLBRjGhUdN0vi7yMYTzhJ3kq9PHWPjkJjk=;
 b=d7DDyCt1kWO7klgWXDvDidE1/HrZkwprFX7jyMhJhbOZ+mkOL8oTDP6FSNm4DN3mIeV//pVKdW0Z00BOVg7woA4AiO44r3i1E/GPPF0ILVXCJtAAI+ZUINToZZ13X1ywkVZGeUFeOw3e6VTP9sSFEVGHCpLmt2bZyvWXQnXwkU5lfQx9sJHSuXsZ44P3hj8KiqAlnE7x9UuM67uIFi8KShSm9hSrbn1ukqJO2skYqAgb0KUcoBzj6x1OCyvEgdtjRP8GLvPAz5c5SpVpt6wFDUUQj+C9zqxPl2IOrdPexVMGsRkRNNVgoxE4B0g9DaOv5z8q8b04J0CdGrzfzLohwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR11MB1589.namprd11.prod.outlook.com (2603:10b6:910:e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Tue, 19 Jul 2022 19:16:12 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%6]) with mapi id 15.20.5438.017; Tue, 19 Jul 2022
 19:16:12 +0000
Date:   Tue, 19 Jul 2022 12:16:06 -0700
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
Message-ID: <YtcC9qYo1lOGZ/83@iweiny-desk3>
References: <20220715030424.462963-1-ira.weiny@intel.com>
 <20220715030424.462963-4-ira.weiny@intel.com>
 <20220719173553.000067c6@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220719173553.000067c6@Huawei.com>
X-ClientProxiedBy: BYAPR08CA0066.namprd08.prod.outlook.com
 (2603:10b6:a03:117::43) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd055106-20ac-4393-2314-08da69bb24e7
X-MS-TrafficTypeDiagnostic: CY4PR11MB1589:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtV4sh6xAYAW+ipLx5rrk5au195L+KOXa1O40sjhInhvnbk+CVm1bJej6+k41HvVL3/IPZh09DIJKBktYCt3VRkIC1kkYGb3lVikxLppF9KW4D6d4YUtaNXw/M+Gfe5jkiqD5Xv5hW9IDC2EuDQ6P6EgG7Y66UDmG50drXGz8hm7ix/XsaepXFtkg0bDSkyIdXrx8UY6ArYFJ3Ibdd2sAJrpjerNaYRErtEJGfdPHNCSAO0nDYv8SsXzXRpOCYO9f9t2CZ7ahG2IBVbW+e44fX9yFkCiiPHYFaRgkwI++65WIUKn6bVWtpk/in7tXmHUdFpPxqUNbWIboaYxreqUZTYSq2i8O1h2oUMovg37XM+kFE9x9lHbgEJd+D5i+Vn74hxtuH0/FcSXmN+GVWWNIIZ/ofK8Z+qkkMjs2a1/A/GtGgmqskIv5+a2rAzkvpPWTt1VuoedBYCQd9M5eeJDwvzVpS+yKEuKP6Gj4Kf6f/443yxGGapkZzOscLEtlHO6OZLyyS+PSSzVoNRC25+prVjjUgKu+URhn6igZNOKXAQ8V5I9xXYTvtW8lrOV5vdyM5tXzhFOjubke2bf9/7cyFKp3cVcPBI0HZR0axYU4brVpfvO2gR20x9zLS9VUfTCCHL0N52p8VxzhWrCWFycMl47/1SklG41pbCk5Om2SakVKNGrWh80u9/ScLOjqS6k6/9zgG8E+msSfpV9hBIYa/O0T1raiNAr36B9RFWFXQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(376002)(346002)(39860400002)(136003)(8936002)(66556008)(478600001)(41300700001)(30864003)(66476007)(6666004)(86362001)(6486002)(5660300002)(26005)(2906002)(6512007)(9686003)(44832011)(6506007)(15650500001)(33716001)(82960400001)(38100700002)(186003)(83380400001)(316002)(8676002)(4326008)(66946007)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C/d121eTsPgDdMgAK+mjsRNOwB36oZfV/YvOjS4Lt3tXQ8m29wdUwl2VD7xj?=
 =?us-ascii?Q?/8W8U+P/6cQv/HuzPD2nKNgcoEqQojvn0DDjqhtE2lL8deYTVHDsj199vGHl?=
 =?us-ascii?Q?bOkXtMzEQT/b7CXznW5Vhn5bXuNhWag64z3dCwA66i6QBGF1OmuYisBryKsz?=
 =?us-ascii?Q?dqYPd32+Cyfr/uNxIuVjzKxdyzJVML9QALKjA6OVbr+MiP1J5jJW7ihUEyZl?=
 =?us-ascii?Q?SSjGi0dAds7iP6JVWwNK/zpSrtkXYu8Pv6UCicW3FOwMpqhT5nzdnv6O6wY3?=
 =?us-ascii?Q?Huut8q4U9edZYbsEeyUvArp3jwzaM5GFEtuSV7ofbbZayL0j9AXfM1ueY9jI?=
 =?us-ascii?Q?KFrEJ6gtgACGX1m95Eyr4KbzqZ496p4CYyKj3R9X2Vgi2WYN2RaMt+MALZu9?=
 =?us-ascii?Q?lkP4S72Mk4ceUEru8253jU44Q89ALgF9eSVtg1JH8zsY8ElFUqfRx2RJ5ILq?=
 =?us-ascii?Q?RppqS6FZtIcVSEK8YIpIiJdYfQzNOfn6NQ0DK4LJebDJTPUEYO3pMt4rs6jk?=
 =?us-ascii?Q?Vg41wSPPZaXl8+Tx2OzyoRbHydqBc/6tX/ZVTzQm8rhjgiTJ8Lb4I5cAPDdU?=
 =?us-ascii?Q?4CE6LEKuChA2Zi1NH4FcOmO8j7XHmq33IcGTVajWHaLnufjZIe/xIi2H44WN?=
 =?us-ascii?Q?uuu2+RDFF0x1GA7ftvGY7rg/8C7dHiDs0DJkNpE6lzrgT+oe/qrtxG+W5afh?=
 =?us-ascii?Q?Tj75GIxIouG3YDAHEz01qMVpRMajkagnutEGkejNKldqJ4lMg9P4O9asPxlP?=
 =?us-ascii?Q?YHzv7M066xxxeZfeOLw9/4lV991A5T6IpB4ZqKSASOCxpHoUQrqi7P3AkSgY?=
 =?us-ascii?Q?WLgXQEVA59JcFfViMEFP126OZEm/LPH3mzmt8upDSS8D0F7pqCZLA31M3J5z?=
 =?us-ascii?Q?ivA1Ml3QZJHZsBO48Ejo4tXFssK+gqnG3WzPb2ObWYCPP6+izkLorsnLz+C7?=
 =?us-ascii?Q?u/0DJB3LezHhYYvsN3yfMI5uSUj9ueoV7FWmSZsfSMEUhnwSbRVLOUcKQa3Y?=
 =?us-ascii?Q?ecaDeswvuIHbrJAryxc+5z7U/y8WMOLbNBBIKgbV2GkGvOjLQd+o8jnwGxxJ?=
 =?us-ascii?Q?isfQefgNRBeHEsDyfxfeF7dPi8EGmDxqB8fF76kba5/s60dVd102pkogm9nK?=
 =?us-ascii?Q?GtvCPjyv1G5RmiKJe1iFxyXQ0FzFnCDAVViJJJ5M/pk07whQoKkmpZaNm6aQ?=
 =?us-ascii?Q?snvDfBHNLHxM6iTVWcB2NXhhA7lpr8NWWlWZfk45gYS1uazIE5BHVP6eX5iL?=
 =?us-ascii?Q?OMnBDmpOH1BpNn2K9oR9NgJ6OU6leGCGd1ai6gTfoNXC9E8P9MwiX9gZsbgA?=
 =?us-ascii?Q?sBo7553lYxcDMOPdNJiy6Q1YoWMmbnYLNsBUWEDud3ee7LIYyShe7ei4V/Gu?=
 =?us-ascii?Q?k1KR8MH6u1MYPpJSP3NmXgz2FHjI8KkXhu7jDyLvf8zy4WFWSY4kFsSLJ827?=
 =?us-ascii?Q?9k7ItWI09D+mjcjLuXslMvHr1e7EBiOABHTXRmT66SDiGm87+Qcs3w845PXy?=
 =?us-ascii?Q?0CyugOapIv/bYyMm9Kr96eZ6yvENFsHbKusvUaCk9mwmLWzLLaMQTX1aFTdt?=
 =?us-ascii?Q?Sp/dS8nMppK2Q3etkuAUxzuMSnlM9f+DIoNRILRM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd055106-20ac-4393-2314-08da69bb24e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:16:12.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpecCfAKAn2+jmxiNxTu6hQGeWXGtl6zosTHJvVW4gtkZxwwPagWnJ+FXXMorc0cisRSHfggMlxJZcH73eh+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1589
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 05:35:53PM +0100, Jonathan Cameron wrote:
> On Thu, 14 Jul 2022 20:04:20 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> > mailbox with standard protocol discovery.  Each mailbox is accessed
> > through a DOE Extended Capability.
> > 
> > Each DOE mailbox must support the DOE discovery protocol in addition to
> > any number of additional protocols.
> > 
> > Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> > defined config space offset.  Functionality includes iterating,
> > creating, query of supported protocol, and task submission.  Destruction
> > of the mailboxes is device managed.
> > 
> > Cc: "Li, Ming" <ming4.li@intel.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Acked-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Hi Ira,
> 
> Thanks for persisting with this!
> 
> So, I think this works, but there is at least one 'sleep' I can't
> see a purpose for.  I think it's just a left over from refactoring.
> 
> A few other more trivial things inline.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > 
> >>  # Endpoint library must be initialized before its users
> >  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > new file mode 100644
> > index 000000000000..12c3762be22f
> > --- /dev/null
> > +++ b/drivers/pci/doe.c
> > @@ -0,0 +1,546 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Data Object Exchange
> > + *	PCIe r6.0, sec 6.30 DOE
> > + *
> > + * Copyright (C) 2021 Huawei
> > + *	Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + *
> > + * Copyright (C) 2022 Intel Corporation
> > + *	Ira Weiny <ira.weiny@intel.com>
> > + */
> > +
> > +#define dev_fmt(fmt) "DOE: " fmt
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> > +#include <linux/workqueue.h>
> > +
> > +#define PCI_DOE_PROTOCOL_DISCOVERY 0
> > +
> > +#define PCI_DOE_BUSY_MAX_RETRIES 16
> Left over from removed code.

I think Dan may have taken these.  If so I'll send a clean up.  If not I can
spin.  Let me check.

> 
> > +static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
> 
> This feels misnamed to me now.  It's not waiting for the DOE, it's
> just sleeping unless we cancel.  The actual poll / wait is handled
> outside this.  pci_doe_sleep_unless_cancel() maybe?

It is waiting a timeout period _or_ checking if we are canceled.

So I think it is correct for the common case.

> 
> > +{
> > +	if (wait_event_timeout(doe_mb->wq,
> > +			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> > +			       timeout))
> > +		return -EIO;
> > +	return 0;
> > +}
> 
> > +static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> > +			    struct pci_doe_task *task)
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	u32 val;
> > +	int i;
> > +
> > +	/*
> > +	 * Check the DOE busy bit is not set. If it is set, this could indicate
> > +	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
> > +	 * it is expected that firmware and OS will negotiate access rights via
> > +	 * an, as yet to be defined method.
> 
> trivial: an, as yet to be defined, method.

I'll send a follow on patch for this.

> 
> > +	 */
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > +		return -EBUSY;
> > +
> > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> > +		return -EIO;
> > +
> > +	/* Write DOE Header */
> > +	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
> > +		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
> > +	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> > +	/* Length is 2 DW of header + length of payload in DW */
> > +	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> > +			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> > +					  2 + task->request_pl_sz /
> > +						sizeof(u32)));
> > +	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> > +				       task->request_pl[i]);
> > +
> > +	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
> > +
> > +	/* Request is sent - now wait for poll or IRQ */
> 
> Could drop the IRQ given not currently handling.  Though I suppose it's correct
> documentation for this function, so can leave it if preferred.
> More than possible we'll get a follow up patch dropping it though from
> someone doing cleanup.

I send a follow on clean patch for this as well.  I suspect IRQ may never make
it in.  But for sure it will not for this cycle.  Best to have the comment
correct for the final 5.20.

> 
> > +	return 0;
> > +}
> > +
> 
> ...
> 
> > +
> > +static void doe_statemachine_work(struct work_struct *work)
> > +{
> > +	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> > +						 work);
> > +	struct pci_doe_mb *doe_mb = task->doe_mb;
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	unsigned long timeout_jiffies;
> > +	u32 val;
> > +	int rc;
> > +
> > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> > +		signal_task_complete(task, -EIO);
> > +		return;
> > +	}
> > +
> > +	/* Send request */
> > +	rc = pci_doe_send_req(doe_mb, task);
> > +
> nitpick, but blank line separating call from error handling reduces
> readability in my opinion.

:-/

I'm not sure why I did this.  More clean ups.

> 
> > +	if (rc) {
> > +		/*
> > +		 * The specification does not provide any guidance on how to
> > +		 * resolve conflicting requests from other entities.
> > +		 * Furthermore, it is likely that busy will not be detected
> > +		 * most of the time.  Flag any detection of status busy with an
> > +		 * error.
> > +		 */
> > +		if (rc == -EBUSY)
> > +			dev_err_ratelimited(&pdev->dev, "[%x] busy detected; another entity is sending conflicting requests\n",
> > +					    offset);
> > +		signal_task_abort(task, rc);
> > +		return;
> > +	}
> > +
> > +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> > +	rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> 
> What's this particular wait for?  I think you can just move directly to checking
> if the response is ready.

We could but I assume it will take at least some time to process the request.
So it seemed best to wait and then check.

But of course we all know that also used to wait for an IRQ as an option.  :-/

I'm really on the fence here because I don't think it really matters.  We are
sleeping so it does not really affect the system much and this is not a
performance path.  If we were spinning I would agree with you.

> 
> > +	if (rc) {
> > +		signal_task_abort(task, rc);
> > +		return;
> > +	}
> > +
> > +	/* Poll for response */
> > +retry_resp:
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > +		signal_task_abort(task, -EIO);
> > +		return;
> > +	}
> > +
> > +	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> > +		if (time_after(jiffies, timeout_jiffies)) {
> > +			signal_task_abort(task, -EIO);
> > +			return;
> > +		}
> > +		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > +		if (rc) {
> > +			signal_task_abort(task, rc);
> > +			return;
> > +		}
> > +		goto retry_resp;
> > +	}
> > +
> > +	rc  = pci_doe_recv_resp(doe_mb, task);
> > +	if (rc < 0) {
> > +		signal_task_abort(task, rc);
> > +		return;
> > +	}
> > +
> > +	signal_task_complete(task, rc);
> > +}
> > +
> 
> > +/**
> > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > + *			     protocol
> > + * @doe_mb: DOE mailbox capability to query
> > + * @vid: Protocol Vendor ID
> > + * @type: Protocol type
> > + *
> > + * RETURNS: True if the DOE mailbox supports the protocol specified
> > + */
> > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > +{
> > +	unsigned long index;
> > +	void *entry;
> > +
> > +	/* The discovery protocol must always be supported */
> > +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> > +		return true;
> 
> Given how cheap this look up is now it's all in xarray, we could drop this
> 'optimization'.  I'm fairly sure the discovery protocol will always be
> discovered (spec says it must be returned when calling itself as the fist
> protocol).

No we can't because this is called before the xarray is populated with the
discovery protocol.  This was actually added not as an optimization but to
allow the discovery protocol to run through the common query path.

> 
> > +
> > +	xa_for_each(&doe_mb->prots, index, entry)
> > +		if (entry == pci_doe_xa_prot_entry(vid, type))
> > +			return true;
> > +
> > +	return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> 
> 
> > +EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > new file mode 100644
> > index 000000000000..c77f6258c996
> > --- /dev/null
> > +++ b/include/linux/pci-doe.h
> > @@ -0,0 +1,79 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Data Object Exchange
> > + *	PCIe r6.0, sec 6.30 DOE
> > + *
> > + * Copyright (C) 2021 Huawei
> > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + *
> > + * Copyright (C) 2022 Intel Corporation
> > + *	Ira Weiny <ira.weiny@intel.com>
> > + */
> > +
> > +#ifndef LINUX_PCI_DOE_H
> > +#define LINUX_PCI_DOE_H
> > +
> > +#include <linux/completion.h>
> 
> include not needed any more.

Will fix,
Ira

> 
> Thanks,
> 
> Jonathan
> 
> > +
> > +struct pci_doe_protocol {
> > +	u16 vid;
> > +	u8 type;
> > +};
> > +
> > +struct pci_doe_mb;
> > +
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
> > +	/* No need for the user to initialize these fields */
> > +	struct work_struct work;
> > +	struct pci_doe_mb *doe_mb;
> > +};
> > +
> > +/**
> > + * pci_doe_for_each_off - Iterate each DOE capability
> > + * @pdev: struct pci_dev to iterate
> > + * @off: u16 of config space offset of each mailbox capability found
> > + */
> > +#define pci_doe_for_each_off(pdev, off) \
> > +	for (off = pci_find_next_ext_capability(pdev, off, \
> > +					PCI_EXT_CAP_ID_DOE); \
> > +		off > 0; \
> > +		off = pci_find_next_ext_capability(pdev, off, \
> > +					PCI_EXT_CAP_ID_DOE))
> > +
> > +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > +
> > +#endif
> 

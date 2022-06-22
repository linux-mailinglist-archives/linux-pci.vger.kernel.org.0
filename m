Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1664F556EBA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 00:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376719AbiFVW6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 18:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376800AbiFVW56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 18:57:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4931B1E4;
        Wed, 22 Jun 2022 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655938677; x=1687474677;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=up6/UfbDP2cXMkDvqFyPS++OiSQraU8ecCvx4MGjrA4=;
  b=jOPXYbVNiGHKk9FkimcD7ALefGXtNShOpEcprQ0H+mb1pcYK5stuLlcH
   wEk22TnuKw2fV9/lB6+MTVWRNNzs0C+67qeOUKzhnvpbvUGcKW39NeMen
   53ub2UmuiGv7PWvaer3Fwu++ho7OwjDrYweFNSB8tL+MRu0dGzH5FIb0U
   eXKANEhdK9mSQ5JJLDVaRgZ3/1ZRuhWOMn0tAWVByQ0FYlaVsc/A6av09
   V9Rr5J3gO+gB8wkavbejCgLYhJI6g/e3bh5FCdcEJJzSs5RSFWij9LsmE
   LehdguxsIlCaZiZ5j09HzgUUKmw6e57SJJBe+p1mjXs82FkbdZ/BVDotn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281643307"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281643307"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="655898275"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2022 15:57:55 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 15:57:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 15:57:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 15:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3MpmlJRNBarVgYCA/no8U6IW+D2J4Cq/t6XqIQHyiSIGgNf9ky2mnK0EyTUeiNoRczYhL2yW+ebP+6WYYD4UQHi78CRxN3lzjYCDQMTyJYwUN5GnWuJ4vnlpD3ftsv0fXOMdnedeaJLV2i5brEYU+Dem6f3lnMXGjc81ZLceXv2XX1ELKEUrhS/lN/XJgtoDo7fGe3LKyRM/Yw+Xo+zivcp7a75gYzYrxWeQcRo48YihI6DTjDpm5rf1olEqGlnZSrb1L83y7iY9lt41PcejBHeDYiTlC3qZHzFQ44GK55dfNp9vzkymfy7cN5ZhXcWqT8pPVD9hXYDpRs/n49WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQWYTce+XrsMjS0qTuhLu+OWaWqbNFDaHVBcsHmhY0I=;
 b=Kitz9g+W2VgSm8pysMiF3cDE9Xhk0x3oUV5huhWKbYxYzCdGKFKKhXxvPJriDbpRe7LxzlG1S74sycXhTUSNADmyLAc3su3DlJvT8CY+sweO3wZ2M4t39/PqCdGfqkDFn2GyMPoozvSedIEMmiCVQVB3xXqOwjn9OZHrySMxwWPr4NA8X9nlTV7JdWaX8rq4vOwNeaKXOFjNxPPtXJIGW0AQa99A2mnWlZ0hvQii/UqqkDDZdem3yUd8cy/Gnchu1A1DjRTtKOjxAQn4fHlcjC8L4ubQlIhQ1NB3QhssxcP3Oo7TAzYQwPGcb7pg2gYUhbIyjL7E5nnTTaBYMOrNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN6PR1101MB2162.namprd11.prod.outlook.com (2603:10b6:405:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 22:57:52 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Wed, 22 Jun 2022
 22:57:52 +0000
Date:   Wed, 22 Jun 2022 15:57:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YrOea1PQbSA09A6r@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
 <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
 <20220620112328.00004f63@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220620112328.00004f63@Huawei.com>
X-ClientProxiedBy: MWHPR12CA0049.namprd12.prod.outlook.com
 (2603:10b6:300:103::11) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66a0bf5d-c567-482f-0b75-08da54a2a31d
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2162:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB21626C35686584EF638101DFF7B29@BN6PR1101MB2162.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INZQrsz07oGIvlxFZnV1MxUJpgQkWAVSAJ3y+hboYG47R6ErGktp3rXXkTATsJnrgT44Ef2KvtLdY6DGcvtCZeKH/kpqZ3SXyL17QHNVqNsgKT3KtmqMb9u6aYSumcHcgXBvgiaJSrK7k570C7b8okcps3fl6Oe27ad4iQGWFseBx4rit8cUPXrdE+eMR+7xsOTMfWLDl2kC64OARaVr090R6rQ+eAQS9PTLx+QdGG24zU/V6GVOyeWYQ+paS2UmC6vC7wIueIFotWYcXM4VMxH5UpWFelqPg2n6A5V1KiL9aUZgXFFSWrBQ71nAY3TzrByB8ZYeMNSPjNrdZg0OsVzDdYIzce6AhP56Lv/wpirAHXbnpI64iftAqDDwn4RgUgYb3vosCgXqheGzy2zr1BlZD+lWT+4yzFSAsBc8KJ8o+gJrOJCrjQd+ivoRytocyQ3RU2NdyUo6dFdCE6qQEapb33EJ1KHybhv90XX979G+vffht0A6BRk2sVAGDjiTnIr9tTMVY/t/HC/d+sjodh3ChBfvtWJWMYFoIW41F/r3UD7cB/u3I4HjJzkRjlj1RJRnC3bJ/HaEVRyPUxq+DOTPIeihfPqhMXHEGNAoHcyfSRpCWJYF8ajZ55Q2fCqz5LLa/ASrS187S6J1e6595IN98zGfDJTLY6KKyXbLO9kxk3H9WOqoHxWseQM/zJFjDEZQj3oNK8nFEMq7S0LCOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(346002)(39860400002)(366004)(136003)(5660300002)(9686003)(6666004)(82960400001)(83380400001)(316002)(38100700002)(2906002)(15650500001)(6506007)(26005)(6486002)(6512007)(66476007)(44832011)(86362001)(33716001)(66946007)(8676002)(8936002)(4326008)(478600001)(41300700001)(186003)(66556008)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iOC7MQHof6SFoihCN2W9CH5I0c/s9IBkruMMWJZewIgwZj3HXBOzS+T4GhY+?=
 =?us-ascii?Q?jwR7c49v3baOx6j4yUUP4C70ZhlOJdGq+KGIT0BT0iLUgCM2kJKdbS0LxtDZ?=
 =?us-ascii?Q?K63Gptn/c32LhORDRgjUnApd4tuSGpM6r7utkdrYVS074g9Eu+WwcoF+a8R6?=
 =?us-ascii?Q?y4KnndHG0duAjLArNqjTBqK8B9OqA1pvV8OKvvcDgYSKfsiI6wybpD0NoTs0?=
 =?us-ascii?Q?+LPhK9XKD8PZ345uFYwrILg3erKTfNb9ymIM2HaIHE+xSEe8U+Vn2npF9kWI?=
 =?us-ascii?Q?tNN7O1ej0Ns4115hC4m8mejDy4OB5AJK1nL/Y9QkNW5voCAZlwBHVT/QQrL6?=
 =?us-ascii?Q?DBxf1Yg3GNOmUriNu2VU6VhVTt1i5VkSyU6gs02Ey+iFi9quGqt7Vk4pUey8?=
 =?us-ascii?Q?kxETnwNPR0Ho531fUzMlTF7UAE5Uz3iYjUb3N973xHvcUuFwvf1ZhjNZ9p7D?=
 =?us-ascii?Q?ivbAEftsv39QQQ21vSm2YI0KPx/aLEUdqZ9v54hGSzrfJ1FtleL9VJJFsXWs?=
 =?us-ascii?Q?kiOTNwZ5H0aebIA0qyTs5WQTLdBdqArjtvNalf1jd8pF+onqaAmI8zMcgmp8?=
 =?us-ascii?Q?0AlFk4AW+At/rGT3w0JY8erYKQs8T+a9S0qUGj6Olf67FwjNkIEKDtKGys5c?=
 =?us-ascii?Q?feijMdo3OnXJcAeaisOVM4sZ5G1fRhYne3dlmaKBzookkLiCNySfdguNte6E?=
 =?us-ascii?Q?lmXarVZx+d0FDujA7CXpiYNR6yiFWPjNvdDnyO8pVvfZ6RBGtc84TKWEQUkH?=
 =?us-ascii?Q?q7czek6i9k8sY+XeGEoFNCKtRa8OgM7c/yFNGAA+Gs9mh4yQSibX6Co2t9km?=
 =?us-ascii?Q?r9VsR3B1UzBwHgd83Nmi6jNMFSazWIOBj4rrfPpgxw6kS6MGENnCwESLFbHm?=
 =?us-ascii?Q?vT/WG5kYkp4tynW9qaoPeHAA7C1QwROA/Xu0n5dpEbGVhir41naafdi5W68g?=
 =?us-ascii?Q?wV/ZOQum17m0xrMiHrDefgESqbYtvR2YmrZN0q5uSKtMzAOif42T7tpe0oRi?=
 =?us-ascii?Q?xjicgWgpSehh12awQj9C4iPo1UUyNWuIyiaxI5IYulTGBmfJxW8Y8DFPcVT1?=
 =?us-ascii?Q?eXe/GzC8opO4FC6FxLUf+wJ2BGsUL+qa9QlUhuLK5DSJa7Y/PoCKIScZtmLN?=
 =?us-ascii?Q?u9uM62O/kxiVCGQx6O8mD6YijlW0Bx7q9tg5ve+ZqBCTrtY/tO6sOKsY7PSV?=
 =?us-ascii?Q?H4hbqspM+fWMhlfapNMDMHkenioBCp0GZYRjmQRwvQ2VXy/g5qev4j3vURfm?=
 =?us-ascii?Q?d7ZbIyMJrYoqs6ZaIgFHRjOq759D5LdD4tGCbOHQxxoWx4XQ4zcjqAV/X7xT?=
 =?us-ascii?Q?i4Uz76X2bLquDASqqkrAXvXl2pqOB+DsEeQATBKoxLeNsHb3bf9dX1T9pkJf?=
 =?us-ascii?Q?nQZeI0pgP+748SqjFk+5jOZOcezNNyiOh4LSNgtKRMPcKUmjgJJV4J6YT+rX?=
 =?us-ascii?Q?IkJxdoesZuB/oPsEZWt87LVL3t3VQMxPXe+ymMxLYxgtbZuZK4kjr+cciNf0?=
 =?us-ascii?Q?H024btrSiIyTselpW6M4jibaAfr/Yn5y+RY297FZawer+yeUUj25yeDSlD3B?=
 =?us-ascii?Q?szQCAPZ4D49PCCsa6GK4XzkRzPYsw6Qrx0HFXxesDCVctt08JTPB2ZX8VuZa?=
 =?us-ascii?Q?Cud2t69aAvJXzM1L4yOkntzMd0jyGfd1WN60kLcjk+HFkKv2gHhdRYBNqbvL?=
 =?us-ascii?Q?5qRWIH3s30DJQTjGFrR+DfCGla3lLMzYSA82TlV+rUTHnrMJ+5Ya+TiXY2F0?=
 =?us-ascii?Q?Ul4Ek5pilS2+lvLbUOh5K12bvT6dVVQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a0bf5d-c567-482f-0b75-08da54a2a31d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 22:57:52.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hzz5srQnc2bJ1AkrRsYU/rstWKBAt64bygROeNzu6tzUWitGA5D6Cfwzp1KdVNjxYU3PcxSnvid71J+N8PDvgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2162
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 11:23:28AM +0100, Jonathan Cameron wrote:
> On Fri, 17 Jun 2022 15:56:38 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 

[snip]

> > > +static int pci_doe_enable_irq(struct pci_doe_mb *doe_mb, unsigned int irq)
> > > +{
> > > +	struct pci_dev *pdev = doe_mb->pdev;
> > > +	int offset = doe_mb->cap_offset;
> > > +	int rc;
> > > +
> > > +	/*
> > > +	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call
> > > +	 * this multiple times and thus is called here to ensure that mastering
> > > +	 * is enabled even if the driver has done so.
> > > +	 */  
> > 
> > It is required for MSI/MSIx to work, yes, but if the caller that created
> > the doe object has not set it yet that's its prerogative.
> 
> We went around this in one of the earlier threads, and I think consensus
> was that it made sense to have this in core code.

Yes we did.  This is where Bjorn asked for this to be done I thought.

I verified that pci_set_master() is fine to call more than one time.  If the
caller asks for irq support I think it is fine to do this here to ensure that
support is enabled.

Ira

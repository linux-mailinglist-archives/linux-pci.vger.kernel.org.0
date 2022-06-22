Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E7556EB8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 00:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376643AbiFVW5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376575AbiFVW5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 18:57:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C221B5;
        Wed, 22 Jun 2022 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655938659; x=1687474659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AvacyKB9SajXowPTAr0a3YBSoAI0Grnu0jbMgLDay6g=;
  b=ZjuKqtscl5U4vP4XNmQ1uoZCkHk1gK4fbutiE/XDjZjUHc7Kk3Ttxlbl
   tUURDV3pfqugjvrvTbZ8rj47c3Mc2M+buNBh1u3c2XCtTw1w0JCmjFI8U
   a28uOrNKn4rwMAPP/Ma5feCbkyGjC53Y9VOEbkzs8R48G7sxGYFHfmxqq
   kmP69hRTlKNQ2xaSKjnVL3noT1/dMPbOho8sCFG0/99jWFVqgxPIG+6hA
   fzrqfaOWvuLOZgnPUyaXEx0nBHy5nwlXniibn4Wc1BIJKNnlP5sUF2Tlh
   a7NWz5Jfb6nbCcE7D5LAJZVTEOCLxvrX7JTVXoJyLD7vIrWOTseOL5ILS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281295921"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281295921"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:57:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="585923335"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2022 15:57:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 15:57:38 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 15:57:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 15:57:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 15:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCGAtRwuebDOX4/AdELNb6VFpMCUQF0YrhyDwLFpSoA4N8Z76GFQBwL3WyNJfhQkLj+2miU275I8GNnPCt74nBb12ZkE58Sgczy6a2YV37UFjC2I+O4l/j6JnXAp+PEvVgVWZa4Rn9poIND5nBLC14sbcHrcd2sgr35EiSSyyHJUKNy4Nouxcs5ZONXUn0jFAqzu2Oi90db75zi8fW0mxEE4VjwOanZXBQZbD2ANK02CwQmcvB4IxpN+3vPq8RMbWrtcraGhXxu3+TqetRQuT93gWix18NpjTQrdIyKN9ZZwbU983e/GAi8lZ3dQVnDZQppwwSEW6vUfyOzBw1N0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfIpvu0KAVccCsFf0k9aQbFuAK5b7kz47C7h6Ql71wI=;
 b=XWo2ieVXGjgXFxvVTCl/YarGxfHbOM0pWlnsboih90V1+OZZKa8YaMIzo1SL0QfJGmWHZ0OudKiQqpHhngV6OqEAQANucqcoqwgW+9S85HZC4x9OMDB+/bGiti0UQcgf5lSsKWkZONkiLjGpiqOm938qjLVUYt/iIdlglTHVDDywxysM7K+c07SzeXh4aRVAKEsG7QtQVcELUuDTnnJs9ctrN5V3DxxJ1oeUO2EMn4vS8sxC6jkZVBLEIYIyjKcwphvtWSE000IedSG1QIBbcHg2MQqXeO2upyeubSL9GgLN1McRNgIXulJSeMhd9BCTNN0+P8C+GUPztjuUlkzMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5244.namprd11.prod.outlook.com
 (2603:10b6:408:135::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 22:57:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 22:57:36 +0000
Date:   Wed, 22 Jun 2022 15:57:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <62b39e5eead1_32f38a294b6@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
 <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
 <YrObe+AdfziEPlYB@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrObe+AdfziEPlYB@iweiny-desk3>
X-ClientProxiedBy: MWHPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:300:117::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a86d2e4-4131-4607-1b23-08da54a29947
X-MS-TrafficTypeDiagnostic: BN9PR11MB5244:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB5244D3C45CD8466DC30B14CEC6B29@BN9PR11MB5244.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyBnW+sydQ0KzxGDxcv/ZsA24C/sVi/UU/jVJlHcRQGe536XF1VYW5lM7iUmACeRGHPrSJP9StfJDCS8ldhWUvFs2GwPtpsFpz/r3goKzqoZcVCaWOtq3fprEALW9U3grE3sQWg1gMWPD9RR9EhVsV9geHTUMxuD72ZNWF2Sern0l4j48TqDy3iBLp5TzMBztckd6Cpskz4YPfI6DVzZuu8BPzl5hxJGO7XNG0isK59SDsboBS4DsZPZH1zAT2xuP67eftfhGd1j5I5UsfE1ktioJg5mDvKZzv7VqH2eaiglwjlmm3hR9Fz9JnZKMREejIqQLfMwd9VWFOiW++29gjTKRdY1WWgYX3xwF6+slo/lDNatl/O8cgNUaHhIHMBKkayx9XFdtiHuyfX4EsCZhpjDYbFFKx2/4oh0gZnmDtKO98hwri69FQmQQuLbq/pUZ+sZhG74bReCTBmrfQXzY8F01c0QteEafXh4s3Sq8yC1lW8eOvrA+F5GHFuQkjOLvuLpzyYXwqeZtaxffy/OqUVHw9xlZkXs/tg31KDR451ctkhOx8By2DVPAwo6aUxnvvDpYNowX/INulMoil+rso4p5DUJPJB3ZuO1GBgsksbVGXcgfrhx9X6F1i2WifYYX0OqVEc3R7z4PmhRAQB55hU+dOep9Q9E2XVNiFgicLM62EKEv/mddKe0C6iyyziAj30xKA8acreyfmjaiErazg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(396003)(136003)(346002)(83380400001)(186003)(86362001)(82960400001)(6486002)(38100700002)(66476007)(2906002)(54906003)(66946007)(316002)(478600001)(110136005)(4326008)(66556008)(8936002)(26005)(8676002)(6506007)(9686003)(6512007)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clEhDvDEweZcQyNeOdQ2j6dZER+qMO67fOYLgLw4I0JT2QYZCi9xjzUw3Psu?=
 =?us-ascii?Q?JOeuhILimbpoGWGaK+7g9s+Vjm2igiuV1GLhrj8plOxajMi7WNo0lS83mFqQ?=
 =?us-ascii?Q?xsgKCHRUb1ICZwo8yi5CglIcFqTougRugfB3Ehm/OHP/aHUpgEC3dgdKMfd4?=
 =?us-ascii?Q?j36KESKW5NsDrraxtXPsbk1LFyrb+vFN4g0sY+qAn5KfK+8PV6LDFfn0m/Dr?=
 =?us-ascii?Q?IdneiSEU7l8VBMVT0goayhAYVl5QuM3h67T40ta4dRpJF7QKfnD3cI2HsgSs?=
 =?us-ascii?Q?KDfzP20P4866GsXOqwyguhUzPKwQzrCl916De6kIUE/fLR5bfhYFJPY23pLK?=
 =?us-ascii?Q?J3tMxvdq/DWD42xUTaAltWfJPfqP4rJZZVyAMgGG+XIaaxeMI6+rOclph6LU?=
 =?us-ascii?Q?IoWm2DpIjQfutrbQXncIlcPJ2PR4D/m2M41Xx88xCs14iDv3D2uBq6ZV/0Oq?=
 =?us-ascii?Q?qyfSpGoOkNcJSVwTwhnQOXucCHZeC3+WhbOxRdnhXH/AgrSEZ7q6LuSwWcVj?=
 =?us-ascii?Q?LGc9zRRqKZiiQo+1kMaY8V4ned/3zMMVJfGcpT3Z5I49fbaxvPZJmTMxN6wQ?=
 =?us-ascii?Q?OI61VXGOodb9asdmMOp8Faxj/KZvkDH9LDmSdjXqKDTkkG+yqv3KIL5T/L8+?=
 =?us-ascii?Q?FmReQ+w7a3HxdcCkgEPW7Ulkt7GbfpWZfvu0p5GK1Nc3gEEZdGSqzJpOw67j?=
 =?us-ascii?Q?vh8Q8eUMgwywE8Rfqh0sf9e+aNES8djS3UTzou+nssWjCKWcQZ1WSkDY9T7W?=
 =?us-ascii?Q?AG+QF01HaEF0D/YLP3eFoKhnmNvf9Wzt3wsHd19KVm9UByypk4oZX50vywqs?=
 =?us-ascii?Q?EuBb8Qpg1LAgoKBeaV9n5pI/baXzxUwgGMIQ36BZM8Y1qA2GBGmXDLgLqgsu?=
 =?us-ascii?Q?tqC4haYCqb9SGoun81YSLEMJPMcSniS86m1rScpg/B9v7MTkC3bc5lJhn9WS?=
 =?us-ascii?Q?N2+9TGK8Ay4Aii6BoTC/ymJFk0fUrzy9wwhFFVkvIyykTvCsrjdZ1FVpcj6f?=
 =?us-ascii?Q?VFlUj45Mr5CBJAT2W+KF6i0YkDeWnmW4jUvcjOO28jU4I8LmDGNSyyhZUHqO?=
 =?us-ascii?Q?fP+MoIAnd/pYA6VSbecjF6+BtD1T6WHwAzY8v2NbQoA2tdGLTiP8QQTFpDwi?=
 =?us-ascii?Q?9bc/RfILAQT9DDX6iWbufSIgIrx/dldQGmbhcwZRUZHPioPk/FaxS/S5Jzev?=
 =?us-ascii?Q?x11sE7aKC7A3tH2o/kSj0LMDm0sw2j5gqiEs29ogfXZgxWzzgxpcAuu5pjLT?=
 =?us-ascii?Q?x+ZET6SbaUczqhX8O+DpM53Eh57Ax4zGtp1DGC3FL2nReQtkn3Shn35Nc3Sf?=
 =?us-ascii?Q?uWFKIdsbiQ2M4Eg5geTSN4UFIyLG6lW1lnJYWhGhc4mJgA9CeDe8KKpnLb3B?=
 =?us-ascii?Q?/ta88+OyXC54TygOChG6TyE+VGRG2EzFGVVtAoehjz6BjGzPjqPBgj0k1mew?=
 =?us-ascii?Q?nM23P+ZXz+lO8abD8FPJeHnuct5mE+Jcf1p4wox2SN8pe+CoMeI7btI0Zd5d?=
 =?us-ascii?Q?sq9jUvel95pgc1Jho4ZSduogPbDk9BOrD11m/lodpwR1ki3wbOmBwN7e1yxu?=
 =?us-ascii?Q?LqsEvPpyYli3JJSUegVl2zHPRZF8WYYShFDpYGBQz5WhewyZ7fhVjvEWxhJM?=
 =?us-ascii?Q?Eqmvpc0QslJqbXW09Hyk5J/0+SXFToblDmrorbTdZmzqrVluoNI6V3kykUAJ?=
 =?us-ascii?Q?0fwtHrWtnImjhd5x6Hb4L0Ndn4Kgk/9WLpu355BXZFwQoXsmX6rwiDMklyNZ?=
 =?us-ascii?Q?lBVxA6OBhPmwTq4mi1ZaMn+GIDyS5w8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a86d2e4-4131-4607-1b23-08da54a29947
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 22:57:36.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET/R9zcHAi1V7qUpbLTGYbSol5oaD/+pcR/h9Yiqich00iLn8QRWCSG8ZvI8lsbqnDM4GZkQVLidAg0Rmd02vVCsointMo4+/ZTb21upweM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
> On Fri, Jun 17, 2022 at 03:56:38PM -0700, Dan Williams wrote:
[..]
> > > +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > > +			     u8 *protocol)
> > > +{
> > > +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > > +				    *index);
> > > +	u32 response_pl;
> > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > +	struct pci_doe_task task = {
> > > +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > > +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > > +		.request_pl = &request_pl,
> > > +		.request_pl_sz = sizeof(request_pl),
> > > +		.response_pl = &response_pl,
> > > +		.response_pl_sz = sizeof(response_pl),
> > > +		.complete = pci_doe_task_complete,
> > > +		.private = &c,
> > > +	};
> > > +	int ret;
> > > +
> > > +	ret = pci_doe_submit_task(doe_mb, &task);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	wait_for_completion(&c);
> > 
> > Another place where the need for a completion can be replaced with
> > flush_work().
> 
> No not here.  While this call is internal it is actually acting like an
> external caller.  This specific wait is for that response to get back.
> 
> This pattern was specifically asked for by you.  Previously Jonathan had a
> synchronous call which took care of this but you said let all callers just
> handle it themselves.  So all callers submit a task and if they want to wait
> for the response they have to do so themselves.

Ah, true I remember that. The nice thing about a doing your own
wait_for_completion() like this is that you can make it
wait_for_completion_interruptible() to give up on the DOE if it gets
stalled. However, if you have a work item per-task and you're willing to
do an uninterruptible sleep, then flush_work(&task->work) is identical.

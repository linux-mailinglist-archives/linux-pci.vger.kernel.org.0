Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26F570A70
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiGKTNj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGKTNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:13:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3A5FA4;
        Mon, 11 Jul 2022 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657566816; x=1689102816;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SZz3iCsx5EnHXkCF1HIL8Z59IEct6ZEhiMrN88JFbBY=;
  b=bWB9+YSV0TyryEbl+aqrWfin/WDUECHSPkOPsVXSRkVF7vxBlEHFQ9xv
   x6hkw9nkqzKkN+zzgh2yhhBxF76BEDNMY7A9Jk4dCIeplBAhs8gLBoJ9J
   13aeqST/TQCPKmX8rjhkZluQ+lwUFBT1Wwta2r2saKMxkdJ79RuhyBb1C
   WGfPKVK8wUhQ9YsN7UpQ21Yth6sb8RCJTdFuT2rFwNfqoCj3vkbKbGscL
   g2f13FXd5VkP+OBnmvMZJFpcgBPurWpkNtOSyb2jKnRWUjegFDa9wt3o7
   t+qiRdFm/s5d5ajluKIAqSDRKWq4VsiTa4oXVGhxH3QdyHi5yjLRz2y/s
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310358027"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="310358027"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="599128581"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2022 12:13:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 12:13:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 12:13:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 12:13:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 12:13:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYOiqJ9dxEmYdxhkSeNW2/G6iYC7/8qthYSKh7eQ/0zrNDHYY2gOsIyj/B4ZMn9OOhF+5haM+Ofya4a7FG3wgzYiqxJnmstGbNWJ4tHyaxZRp8gK9ayypJAuYwbrM1/Q1r6UncGulIdDlRCjKj5tyIQj3i2S1789lHpL+J23/MB6/iSDZAAdwkshIJfvKKPSQakye4uqeHPtQWijxQfQD8zDYGHKc5qJpuJVHfeWyRRHoNLgrx2hiuyTbQ1XRUQDwbLXhLdfTmgy5DTiLW6UbsnMfkrIBej58A8CEa3xXtuWe8KfWWtGjAVNR0uSmjpHBuVzMu/rAuqXZwlI67f4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/z4HFI+dDcminVxis0djUomRK1k95AN+t2tNq2/zQs=;
 b=OMff0Mk1jnrumITA3FsGswm4VF9IFhy3kxEKEvA/2CS8pZGp7UK4Rgf8RC3jhAtkgnt0vvDzIMUHMpxIREiRiPqgauiKD0Y0KOjdIGvhtlTRSYoG4NDHNzyGZU8c4V4R7xxTUUZmfvkvtfMLIdZ5OhOd2MXPHuxzUHBkWAFcrXkLJRYeNGIalUqzvIX0VW2YPKmqymtZj9qbkJIZBDrdPnXet2d8it3dSS3TNymg6+RH77ruholHje8W1iKhJMf9/Gt8CajF8gpxhilTpN3dqnfWATVxLgMmRznxut11ZDhqn0qpN/BnNEGVPo9swvHInDDSIlBn7QXeSscoE8NvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR11MB1639.namprd11.prod.outlook.com (2603:10b6:910:f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Mon, 11 Jul 2022 19:13:33 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da%9]) with mapi id 15.20.5417.020; Mon, 11 Jul 2022
 19:13:32 +0000
Date:   Mon, 11 Jul 2022 12:13:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <Ysx2VdJJQFWp1oC9@iweiny-desk3>
References: <20220705154932.2141021-4-ira.weiny@intel.com>
 <20220707162223.GA307520@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220707162223.GA307520@bhelgaas>
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a0be430-01b5-4e09-0a82-08da6371724d
X-MS-TrafficTypeDiagnostic: CY4PR11MB1639:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2tBS1XGO76Tx9//vBzfUSv/kK5XtdOxgziXSHHNWzAcOdXAIJNIWrZMnovQrwwsvL/G8rAVaoCecasQ9flEK6XIZq9nvMl4z2JRUzbZoT3YQarv6bQWbuP/TO5W50hI9uB80tu0Tmmw/5sz4mhMEFC2peFFdsMvgFWOexJ9vNbGhH/h7PSvFwFVc5V/BN0mCVMHMGCP6zpBlj6QGruu7P3NnwydZhTFIo4VUXh/Iw9Ok9q34ZdWEqBZ3TADy4vfoB6RsiP1hVWLORwqaWhQL0ePThAat7cXo2BpwLM+OETKbEmGT+8o8cUvSFIsjWni9t9vg+a8BkTpTmDzueBOvTtTzWV4JSJ/nrPRAWvo7V0cQ9OM0H0eJkp82LnhWNLVHAlRIMLpWqcyAGLLRI6zZfgqZBUWi9NZ+fx0lCdb7AARYKphLTXMx3Ky/VLFyD7SUWgFoN/I3Qu05Sj1DHT275j6EboKxtciGj8wckCmIE7NoKKLQuxywaLsGwigf6nofV8z5iVAug2PTdleIiOm3ZwPnT5y+imMMNSB1g2aGdmX5NYKKFMXFBSFg+tuRAc2Umx5beCK1IXyb/nG5G1uMk347llxNuL0uD6zISX+6sHUuq9+U/TJACt8Ca83xCIUKdbCpNYqLZgGIpQZFGZfT6uMPj6JVr7vw3cFLQV0C7R0nZHwQD+DNWLLRWh9X53C3a8pMkNUyC+wBfaisVekfW4VhftLLHAvojQV3nliTDfsLbxP1Jr2SsvrcBKZ5Le8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(44832011)(38100700002)(82960400001)(5660300002)(86362001)(8676002)(8936002)(66556008)(66946007)(66476007)(83380400001)(4326008)(316002)(6506007)(478600001)(6486002)(54906003)(6916009)(6666004)(9686003)(2906002)(6512007)(186003)(33716001)(15650500001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ayo1Rhpw+niB5jRwmJqCfeAUPp52hvyzDFwsNnBlclcZjNZf056ZNlKdkK0q?=
 =?us-ascii?Q?WxValJK8qGy65hWTS3fcjqpDeHIqPzjZUAJE01KD55G38zMd7vLSQZhEjRbq?=
 =?us-ascii?Q?rsjKgW61KFirxdqqV+41R5bjfXKRS67woKzRgQuaZ/X/lhGspYegtFgJRRTI?=
 =?us-ascii?Q?CIatVqHnUTW2sYZIUUU6BhR8WfLVEe6f3JkuXTOCWEjSZAh6VKOVc5KEfhHC?=
 =?us-ascii?Q?YI5Y8CW9Qh+x1lMR1jQ5gg/hZQeXTUJwNzpoF0E5ihhxYKRFksH5E8gy0iK2?=
 =?us-ascii?Q?ksqmRz7IcdjWjC1Pacd6amQUq2qCHmd+2UaW6p5P6xh5BsZTPKYzIP+KEVbW?=
 =?us-ascii?Q?7FhrHlsNsa4yJ0GB2Lxx/eaHgVn8W6ulad42woOIYNO1NzfQov3eq0R+9Zl/?=
 =?us-ascii?Q?Sz4mzKmC9UM+uQPKd7nsjbW8ySwZNHYG3XwjrVb7SUuPLxUVlwdtysfeisTo?=
 =?us-ascii?Q?B8cTSsSU8HcSU5g8v+PpTgt8dY4f0w4j+4qDOhI3SxBz+vefgokKglefAT63?=
 =?us-ascii?Q?9yregkD/7MdqlmxsX8zF4BlZEFZZCEU3ObN3r+QRmZrDnHJNMfyaWZ7AEBwq?=
 =?us-ascii?Q?bS2yobOOgM7yMJ/Mq42Cp26l2oOT6rjm6igcZrg9lLDBLRuoQMhioe7kSAy3?=
 =?us-ascii?Q?McEikwznsHHkIlLWMhRAgF2pxjm87b2HY5EbMbGIRS+i/kD6PtEVHdbppzZs?=
 =?us-ascii?Q?mO2V5pYH5snnccL1Pkw0HcogCK7A4MbgUx+pSNJXS5fZBNPe2AIVXx881bRX?=
 =?us-ascii?Q?tXo+trr243VAvekXa2jshzYwKWfA9ah/s7TW/AlS8r8mELWjh5BkmcE2OK/e?=
 =?us-ascii?Q?88je9YKdZquw0XmtO+mjx1YLOahs+1asaA9Bq7McW0UqKXBNgRQYTSJ7Pig0?=
 =?us-ascii?Q?3dc3kHrDgvU/HE55EfK4AP0ed26AD5D2CQYn0Ya/sTAGUPJezHSL+DyNC//J?=
 =?us-ascii?Q?tP6RXZsi7yAQdoTO//zePYiFn8gi+1f8jRrKIJU7VR3NNyK9ku7O7BB27yAL?=
 =?us-ascii?Q?7VyiWg2KtiR0yYfohRDxgxTCxad31mmDFhtpSw9pyCyKKy3A25JohYvdSMKJ?=
 =?us-ascii?Q?pZ3aZXSbPSOoirBedx6q8LUyad2YSEN5mJgnF3SqquRO4ce2/qxwUpKdMIB7?=
 =?us-ascii?Q?m0gPTmGXiLSFuWCnO50Q749xbh4/o0l0QZdgGv1/t2Eh9XM+YCXlJd5UET1b?=
 =?us-ascii?Q?4giYf4jC3V7FVMPVMogmW2+7430NFCJKthm6m6+9bsqPZC83B7mfN6Be08J4?=
 =?us-ascii?Q?Y9Um+aGIzSSSL/PkS6IfZHcmFP5TJspH9g0KuHj+7x7l28AnF914HLBLz+8D?=
 =?us-ascii?Q?U/n/G53+eeIqQx/5wYIdDiASntrqCN1A87wrDjjLKsnPPgJuewkFj1/yUC5R?=
 =?us-ascii?Q?6l1SkoIvNQU15HWaZqsTFPHBp+EdbtJlUyHGv5aZA8mevycmJkCDyPasTkvd?=
 =?us-ascii?Q?1jrDFiH9pfkdwWgoVdrW8djNkMUUP202v1qU9OklzJPoe4vUuJ3zCrdYR09Q?=
 =?us-ascii?Q?eR5Z83GG8eOPJPYJo0+JfqmrStTwajDkFkbFyMF6MhzLC70b9RLZyH9jK8gq?=
 =?us-ascii?Q?giXSrl40Eg5TUmxd0q9Mz2MT4avjFzBoz9XQ0iE7A2xOtGvXycQo7rF7bE35?=
 =?us-ascii?Q?KJdrsJCv5Y1oVSBWfNJT7mUPCxWc+x2P/TMd9k6lYpJw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0be430-01b5-4e09-0a82-08da6371724d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 19:13:32.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2MqjJ1+78rrobB+gk10zR7JsTgYGKe2VZ4K/5bTgpPnUxAV1QPCNqycbqhibZN/AsxnWELZ8gjeM6UHPv15hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1639
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 11:22:23AM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 05, 2022 at 08:49:26AM -0700, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Possible subject:
> 
>   PCI/DOE: Add DOE mailbox support functions
> 
> (no trailing period required)
> 
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
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Whenever the CXL folks are happy with this:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > +static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > ...
> > +		pci_err(pdev,
> > +			"[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
> 
> Since the string already wraps, I think there's no benefit to starting
> it on its own line.  Joining with "pci_err(pdev, "[%x] ..." improves
> greppability slightly.
> 
> > +			pci_err(pdev,
> > +				"[%x] busy detected; another entity is sending conflicting requests\n",
> > +				offset);
> 
> Ditto.
> 
> > + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > ...
> > + * RETURNS: 0 when task has been successful queued, -ERRNO on error
> 
> successfully
> 
> > +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > ...
> > +	 * DOE requests must be a whole number of DW
> > +	 * and the response needs to be big enough for at least 1 DW
> 
> Rewrap to fill 78 columns or so.

Thanks, I've fixed these up and will submit a 13.1 soon with Willy's change to
xa_mk_value() which he caught from the other thread.

Thanks again for all the review,
Ira


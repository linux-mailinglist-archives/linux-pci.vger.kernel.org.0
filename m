Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8BA553984
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 20:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiFUS3o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiFUS3n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 14:29:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754143B3;
        Tue, 21 Jun 2022 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655836182; x=1687372182;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=okVJS3qKrv3EGPZnGyPHnNtMpxKpXFcTol/0+GHzYxo=;
  b=k0Vr+zsBdL8/QzLQiwPpeIW5y5J4h+YLgT7WqtL3A0ME6VAp0ulxDJIo
   maRfFOvWB+hpm/CnogX+wo3SasC3uaU8s4AYkBdqCkcNo1K5uuL8a7R1C
   L2Kxv5AWW/dV7xIUF6tL/ncilmK2yCOzD0Ew2LeD85hS/e9sY4udKkRkx
   kfzKn98JiV3Ee7XjcNBpKoS0hGWNNnNUG5a9/4oDhKwycuG78BssWVdhz
   niuepOtxaHWJEjV3X/SZmSVTjdyQb2GXLJgDpfTSwsLjUUKK3lpng+lh6
   GEn5uM5wJu6mRoBJX47zScLkmZ5Wa38EeC283enaiZkztljEyPjB4d8Wj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344195719"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="344195719"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 11:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="620590800"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2022 11:29:41 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 11:29:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 11:29:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 11:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuJJtemT9SNhJiWi4fjU/ktktoKrDvl7kNYFgcK5usR96pFja+4FS6QkjtaFDvl1IYG/mXSUappysLs93ObWPhnkMAPcCFIAg6T9Zyf0yu8F/oWvFANbyXmcLp5OHpr/L2vT2srL2k5XODXh/pptevm5V0ubgaPmelFESI7eGlOXfMp9cyLZ24VIQ5MPKXhVRmVI3jwQFh55FDB4wRKEhtZ/MgwOyDuHRhUaCNZQ/jnQg/5uraN2YuxIeNS6bz5hJDGKMByH8P8KTFXMyUizk/fZYIS5wLIbI58GBFZzsUGpcnPww0mNDOCTj4wQ3xdRTFqxgkcPzARMjptQuIrclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgXPa06jTF7vxvSbARFiJxP3VZsJVHeih91sF8Y63e0=;
 b=LpKFio1dq7n4Y8r6pb49H/mysumWXqfG3ZI9ZvWlG5dCFOX9ylXHfJ93s+irRKGR8FuBkxtZE1jQdRGGC+vhkf3pxOElAEmhVB5oV/edssGfmmTrbNQR2ki5ub0XJZTnZ3etAEgY6/yCrDMPW/itpqUyOs9/lx5r4CDSsCP0+tyjm0XdPmIgwglOl8DzvY2bXqQD20bemLiv9f7tnIQa9Vy+Gtt117043O/gEuwLA7p26S1IwC6Zh+8nBlN1lm5TCfLa2OuiIs54fbTs4E1jAAplle03XW1Aq8swz3/b9QlSxJKKwbdgV2PT0b0pA95jdjDKlxS/uK6KNXvPAFHh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM5PR11MB1468.namprd11.prod.outlook.com (2603:10b6:4:4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Tue, 21 Jun 2022 18:29:39 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Tue, 21 Jun 2022
 18:29:39 +0000
Date:   Tue, 21 Jun 2022 11:29:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 4/8] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <YrIOD9ttvAabfyNu@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-5-ira.weiny@intel.com>
 <62ad11db18883_844b129415@dwillia2-xfh.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62ad11db18883_844b129415@dwillia2-xfh.notmuch>
X-ClientProxiedBy: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d064b3-3313-4d5b-8da5-08da53b4004f
X-MS-TrafficTypeDiagnostic: DM5PR11MB1468:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB1468FA92A1AA809B3F469DADF7B39@DM5PR11MB1468.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPi8Eaj1ZQdZ3XJsMW8dGmP+z20bC1hwjscK1W9nVBDs2QmJM27lwX+IfBqWdBQaMrEODQADCl86VO26j9viWvfpt/ROzgY0dJRffy6dapZxwWkNWc71LuIK1uuSm3dTFeAVwMhAi7AXvmLdOl8nD2nmlBnWM34w0TtlHNCnkrZNBuCZ0tW36T9f09ruO9eYt7t/dOA4YQlKqpT2flZHqFedu5d9QvspwYSzCJYyShZE6OEaqn/cuEd//rJ75eJhvD01GZ6/psSZwBTpvTPmylScEL32rpLFaqGWMpQlMNdJKqeUASRZ0LHVefT2nAvENzgR4192xgAWyqNxzA9aNRxVjK6V1+ZUn7GxEbpSHm2eGg6vDv6PiO7DYVvw8sYTxffi2U/ZqeZ8G9MEgp9CQySKb5PFHIN0T//SLqp3XFGDa5lWMrd0LqfPIVdh/RTZxkCw/879CVks07d6tVi3BRji2s/cL4aGOWD/4cC9Ie7JuJepkwG0w1VFXQBgrgziGqZUqypaczk6twxN3dBEseSxaduCNIefJ3izxATgdWjjwUxJIk35QQOzOHKbIqaea9l7kebOulV2G+Xattc0UsQZ+Rbhri9iqUJ1ueX8HsGnsMEvBM3YyUixX1k/gQD9w0+nf7aWCOdjiVWJPHwSeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(366004)(346002)(136003)(376002)(38100700002)(6636002)(9686003)(54906003)(6862004)(44832011)(6506007)(6666004)(6512007)(26005)(41300700001)(15650500001)(2906002)(478600001)(8936002)(33716001)(8676002)(83380400001)(66946007)(82960400001)(4326008)(66476007)(186003)(316002)(5660300002)(6486002)(66556008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U4lY5H43qRojIjpcwvQAwJ2GMH13PklfDqWelqYnoTbikhWinjvWlDdXc2el?=
 =?us-ascii?Q?dWA+92IHLHQ+EGUcGxvMDiTI3fNqIeNw5hYizwL1VvOXYJeyHlRacwKdQRF8?=
 =?us-ascii?Q?ZQ+oRdN4oE3RDYybwDcWfAxMvCjiVFoew0aDSAJmbbgWPBG9R1VY4fHB5zUe?=
 =?us-ascii?Q?Av9gwtu7Jj+xBYJOZu5xEENcQQeIDMIeA+PzyJlWHiHUrBfNwuVxFRW3Cwyj?=
 =?us-ascii?Q?xzzGS/RnyXbup59pQ6EZAazdpzqwvd2Cjx76Y8IfWD+F7KLVLJt/kQ00ZaJ8?=
 =?us-ascii?Q?4j+aR/c88ys+U5I6Ct7/Qcml+Rbz5+nNSIQpc/UQuyxxvfXlMUj3sEleBIG3?=
 =?us-ascii?Q?N9FISXIey3JFvWoiMeTCtc9jV8DCR8cZF8Wn1JyWEtezS+fNt/aP3LH65B7+?=
 =?us-ascii?Q?aWEm6/N9MEadPohQqGdlcY2tfs/lteO7t1yy+jrnb9kaPEmJRQNbHHVH6EuL?=
 =?us-ascii?Q?kE0Xp7V9mcmetvlcabeZBQ6A2ty9SsSlCRryjvnRCsJ3LFCGZz0LOIPRibfY?=
 =?us-ascii?Q?23SlYvcHMgFTinb0TCJynQvUXD+UJUlyTVm1VCXnedUaYcleNY8XOklpfdTr?=
 =?us-ascii?Q?kf34AGAl9szSZZjVi/JDLw79FAABN5t/rmNt8E5Krqf6ZnvBz6dVu1GPXj0U?=
 =?us-ascii?Q?YDirNZg3ctAjZh//Mz2tq2iU2chGmHN03ENfVCp9KyfEyLlcZWi+rDJzJJ2T?=
 =?us-ascii?Q?n+nGe5+pgM3ZvUL2GcluuXBEkH/9lPM9C04PDFvGUrIoI7JWJIGqga4xSxAE?=
 =?us-ascii?Q?l1FqzrGtXLyZH0S0i7GwmCht1QwIXMUK04SBSArJQU5DUoN/n3NhFLnyhSBO?=
 =?us-ascii?Q?qk0R53c2kN0fnmZMwNtWBnmuhGiQd+bdPQ7J70/ePP7rgjF9JW8OWLQAsvEs?=
 =?us-ascii?Q?K9aVy5h/BrL2u4JeYGa8YuuuBEbPkN+kWq+/t7j3TtOwqJ3IyhQ0p0RR73R5?=
 =?us-ascii?Q?8RU12qYFAgMe7Pzh2ShKZebdx8Yakwo3GJYnDY/6xHCkS0Z/o3sF5SMZU2ix?=
 =?us-ascii?Q?ZWM4knTingTZfHVydFtUdd/sUbXiwL/niwC8SrnmJWjWGlXIAE3NWdR2hdnH?=
 =?us-ascii?Q?SmenFvlpcecJWbuxY+XCs0OSyeUe6ioQcKCtz9kjpLzOBw+EmP/iltMmQCbX?=
 =?us-ascii?Q?1X5Bwuqb04LgA3lmN+tdTrfe0UCvxZ1l/Cq7nznm/HWch5z14sGzPc6+FitT?=
 =?us-ascii?Q?gTcCTmxv/usi4TYNVxyPCXMuA3bPtXHYNiGAlofagZ+thtcgl881+bpJwErL?=
 =?us-ascii?Q?F6Vdzw+hX3mfChrgjRyBpp+s6cyx8py0cjCvH0fvTbBOlvvLtiePiryBmnv+?=
 =?us-ascii?Q?CMs6z0q8nkLYnIH/883tF7c0Vh5+F7mfQohYILalsZX2tViWiB6AsF82gVM+?=
 =?us-ascii?Q?vYaGI0+yzaVJbLeqEpoYP1fQmr7MjlTThMVNs4bCvevFTJ7H2vRU2Py+yZQw?=
 =?us-ascii?Q?aCeIE1gQS0GF7eAsKiHvEkkjMJUUZbJMl/j4Z/ZwTclioi2ORmOM6lj4uXyd?=
 =?us-ascii?Q?VEw3cip/FRxySCpfmPMQNYi9LOWR0zUEyaEpxa0hnnJaqSGJgneM4uoTq2pM?=
 =?us-ascii?Q?c44KA8lKNxGGkPN7acEVpvQ6zaq5QJsJTMyHKvgqhuttD++lozVVBaGBw/cz?=
 =?us-ascii?Q?//eayDtNQepNp3eZzvEAOzl81dVgJsL5FgGPdvcN6yc34mwjQRdGNBwBW/VX?=
 =?us-ascii?Q?0pWysFBkfWB/cwkXI+jOHbIkkF6csKdiglLOVPm9bauVygKz/Nd8mT+nLjTR?=
 =?us-ascii?Q?IwH032xA+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d064b3-3313-4d5b-8da5-08da53b4004f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 18:29:39.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IkpxflvHU1srJIDoIoLTCQIFBmfwX3AwldvzVrYtdK9D3f8SpdwtwDJJ5doxquYsya0pCxMVDr+8bc5pcHb4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1468
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

On Fri, Jun 17, 2022 at 04:44:27PM -0700, Dan Williams wrote:
> ira.weiny@ wrote:

[snip]

> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 60d10ee1e7fc..4d2764b865ab 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -191,6 +191,8 @@ struct cxl_endpoint_dvsec_info {
> >   * @component_reg_phys: register base of component registers
> >   * @info: Cached DVSEC information about the device.
> >   * @serial: PCIe Device Serial Number
> > + * @doe_mbs: PCI DOE mailbox array
> > + * @num_mbs: Number of DOE mailboxes
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   *
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > @@ -224,6 +226,10 @@ struct cxl_dev_state {
> >  	resource_size_t component_reg_phys;
> >  	u64 serial;
> >  
> > +	bool doe_use_irq;
> 
> Don't pass temporary state through a long lived data structure. Just
> pass flag by reference between the functions that want to coordinate
> this.

Done.

[snip]

> > +
> > +static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int max_irqs = 0;
> > +	int off = 0;
> > +	int rc;
> > +
> > +	/* Account for all the DOE vectors needed */
> > +	pci_doe_for_each_off(pdev, off) {
> > +		int irq = pci_doe_get_irq_num(pdev, off);
> > +
> > +		if (irq < 0)
> > +			continue;
> > +		max_irqs = max(max_irqs, irq + 1);
> 
> This seems to assume that different DOEs will get independent vectors.
> The driver needs to be prepared for DOE instances, Event notifications,
> and mailbox commands to share a single MSI vector in the worst case.
> Lets focus on polled mode DOE, or explicitly only support interrupt
> based operation when no vector sharing is detected.
> 

Ok I see now.  I was under the impression they had to be unique.

Do you think it is sufficient to check in this loop for duplicates and bail if
any are shared?

Ira


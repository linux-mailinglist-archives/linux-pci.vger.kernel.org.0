Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5BE648AC5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 23:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLIWdm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 17:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIWdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 17:33:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0536DCFE;
        Fri,  9 Dec 2022 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670625219; x=1702161219;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6wicJX5iZ8TlQWRlVEziEVfB1PZVhtSZxkkVFfiIkTw=;
  b=RSmIlarIXGGZEazIL30UZMZBvtToZk8OAMx2JRNQxaCXboHLdbYwjpMm
   nTrZigWNsBszOPQi2XysbPiMxbmTn3LKPdFPw/e+vKpQPfDG8OT5hBkT1
   w1hJvB5eJQWf5VEhpynP26whUrj9I6r73Uq0aufypBB/fHhNQ0yrIX3Rv
   C89pwTBIr7sm1Z1gD2fBCXSZTXyxgV7RvgtuVOy8TDFCrtb/G2wZi+RCX
   izrXCWENEYLIetZDsC3FYzhOwwputRTVWdr83s13NB8eGCznQ+ciOxKeR
   8TJTFx8+6G98LLfnWhMKNRDH7YRuDnJVDdqDMZPNOQ6GqJqkMBPdtQnag
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="297239174"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="297239174"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 14:33:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="771995191"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="771995191"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2022 14:33:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 14:33:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 14:33:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 14:33:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd6TSKCkNQcTA5m6arzpBF25FrTtQeIz1VnhZTZQS4Kjs2NMUMDmlgZwWaa2qBIhjyxrEWQ486V3POsRcJtuhrVhpyHif9O8mhs4ZAKd5jqvz1xFdUdK9vGcEF3/gs5+ww5ZwlPomqudNMiAaxUucPs5Xwvup4KRnY/s2phZjecYWCPUWsugG9e4Xx3xrmrkv9ivsnmlJRFfHa1A1Cm4e/5fzWku1STcVz/1Vrrc3/Py7lqTPUcuNYAMlV4kojQfBNACyZ2FMI9cgumumEyMCDx5+cFrc+A6Ybo77LZREjFBqmk0ZuKnOErjm57nUgYhAW0aCuFxpSZkLiXEDOgoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLILC1EvCyuWf2fRlPKf4jWQo64bpTZ9oYWf4kK+iUE=;
 b=Exb3xjg3NjqgoacAhrFL3UjxuGDjDmFPA0eDcw+0vp7kWyAJAt4Zr78sOuOV3efqkvW/DqTzRD08oAAn7Vop9SC7KUhtrM4an72guCuYYrzJw7MkQ2t6g8KiNgdrZbqRKgdO6VB1VCxjGshVX4+LKBzwZJsgEcFmmyS7Gd+LvauDAyKbOFMseT7ndOhmQ33DNBYShRphDfpU62ary9KJmH7xh04PW3CXi1MZC8w9RkWRe6jWhbc8CDniCc+ntmYUOuqBE4rMoTk5+yUnh3I4ZvOMsAYgy6kxaeq70LioQHpnQAabnL7Cqr5S4m6yNc4G2sO5kKknRyWxlwAgO75pYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5355.namprd11.prod.outlook.com
 (2603:10b6:408:11c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.17; Fri, 9 Dec
 2022 22:33:24 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 22:33:24 +0000
Date:   Fri, 9 Dec 2022 14:33:20 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <6393b7b0e4953_579c1294af@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-2-ira.weiny@intel.com>
 <639376e1452bd_579c12945c@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5Oh89JFAWYIITUV@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5Oh89JFAWYIITUV@iweiny-desk3>
X-ClientProxiedBy: BYAPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BN9PR11MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 720091e0-6160-447f-72cd-08dada3561b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBMRudAUuyIXWMf2GhVwA10OgAwTnBGLBFxoA1xSfixJ2eDFjI6T4mvY5Cq7zlzXF/BQNH+wtR0qH97+Pfv17QyMcjJy9cu9ZDCcZf8Rb5zJYDIOxRZRKRwNYpLUHKFgT9dC5ig7p2Fm0GYHBpwDQY8k4rLNj9L/nlOZnwxdRXhkreZFNIRN3ZC+qvERTdU+X7rPfj2EMqLkR2BLmYOevmuvrA/VKttE437QrNNDFoKKOrCPSj0mGBwFlm34/V7R4BroQ49VQJXDjstwb3lNgLcusOFYGFGax2R0eqbPLVXLKLr+v/yhJTpZIFndafPF4pxYnWiBE4/hbkxBjtiNOjD8sr0P067XQV9N0u4ioB1LF2wf9Q9jej8WZ8XVCgNrTLRsDFpbiWwh9ZYVaMQsKgSdmxMNAOlEMpF5k0k7TNFjl+K7YXAfc/mTiqwhAMUiNU8uJxvCxKanj7UAFiSnG+gVWYdXO1PM2CHvXmaAKj9d9/B1w1iayTfhcstBjyUv25oemy7yEHjSYe4/vNqds4MfS4dVH7BqC+qjim2+4By/0Q6JJrDl/nbsdfBOxuy34oS+843Y147yI6ToaEXWUL2mzHZGn3LRnzpNZEskJ9mMshotaGKxu6kZ034BGBMK/4OwPKzKYcAYXmmmsWnfTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(66946007)(66476007)(41300700001)(66556008)(8676002)(4326008)(478600001)(2906002)(82960400001)(5660300002)(38100700002)(110136005)(83380400001)(54906003)(86362001)(186003)(6506007)(316002)(9686003)(6666004)(8936002)(6486002)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Amyq1iQuccmUpUoxnftiOP+I2yMQ+bdC4BP9wfIs2atl81qCKqVwY5bIR/9W?=
 =?us-ascii?Q?NdhxOKYNpWa9Zw43fpg2dxh+GvIyrltLkwk0mpiC7mnT7ZAaf4efB6J0eZeg?=
 =?us-ascii?Q?Qq59IPdxqzqpm0OyFjMbpW7C9e2fZw7XNE1D4YDL9HqPUttEDkmhiS1M9ebl?=
 =?us-ascii?Q?vxf24RrAB2estgEIPlpN44W55SFlWZxFAgh0+BwkL+oJg6fAdBQKGLp7WZFL?=
 =?us-ascii?Q?j/hrKa1k9eIIHur8+Wg/NvwHSYuchmwRmZM7xHLr0pv3Z9kisa3diX6W1yBf?=
 =?us-ascii?Q?Ci3K/BeTXIb/RpmKJcopu4Ld1RRSbno+4i3Rjd+LNFDk8gu+kqGrG11QQ7Hv?=
 =?us-ascii?Q?hCXX/wUF6W62EPK7MsU7/gL7T4hHjN18f88CC/r7xRjj2+na3sJ8YGA1URDV?=
 =?us-ascii?Q?ox8sVYzpMgjAARmo/LLBr0Nrm2LHEJl1o4DLpMqYnFWy06zEO+qQVF8BZKrY?=
 =?us-ascii?Q?7Ej+MqNejvtdCrqqERma2tOCQ3wdoYoWcr0ZqT+N3m8fatxJO+P+dPVmZlfo?=
 =?us-ascii?Q?UiDh1yvlqwREjkRcdjF+CcuWaaW6xpCNgMWfsr1jSSvwy7bJhuYQK+onUlru?=
 =?us-ascii?Q?MQnQQVl5cUIrPs9SIyRA4Kg/mFPnCvWqxyVbCYjzTiq1ByqlnCtcnMkSefBt?=
 =?us-ascii?Q?wYP2O2EAuftGxjwNHYSL8mCrEVkzJ4lefGZsd+ECuz1Iei9t8ew2fJKyswN7?=
 =?us-ascii?Q?KAOieoHIm06lY8hx5+SqsxiWpc2IjLxHRAULh/RU8BJabvauSDaiidcbuvjx?=
 =?us-ascii?Q?ZmTUW4X+ywTRMzdvJHQ+A7g27HlLr3k0aakz23v13a+feKPpzpnU2pcSVU3g?=
 =?us-ascii?Q?W8Vye2Sxp3qRId3vRflen1jGyrG7AAC7COtgCGq9BdiH2DayhjfWTvc0YplO?=
 =?us-ascii?Q?qrk7qYScOPWd8GgvvWv5TKThzeP4gx6CgZS71Hur9cfyWagwbRyzz+DbY0uY?=
 =?us-ascii?Q?rPjX7BHzC5xaS3knzTVJ/UcazMQOtboQQ5HcCQ9pbGttbfkhHXx0vrzGpqY6?=
 =?us-ascii?Q?HRgj3iBH9IvTWE/Jz7OzbN0qMMIv8izNT3ahb4Tp6AGSx1OXoJSbIsY5/bdC?=
 =?us-ascii?Q?5OJWS64m6VZ4Xw27JEsaQPIYMNAhG0ZZH7Yv6UfLUklxuu3QkDSBAfIvdXp6?=
 =?us-ascii?Q?ppsB1d/EIQCdvmEvGEku6jkf0arI5NY7qd7FvRA/h6Uc6iH1g4TongNi429v?=
 =?us-ascii?Q?GuiHrFHwlKP+wYuhsbdKitVCskzCCTGuV6PiIZYI03C2H3x3q3G3mHLcCJFg?=
 =?us-ascii?Q?+iiHYL005BCbbBkoC6nWupbPEu1rsIt/ibeWjZkDshgzvzmeqoIQY4nJLQg8?=
 =?us-ascii?Q?1oWhY2mzTPm5HMCBZo+APp+UQdWLJ3VDn0/vClCbSolD8oJpMcIyby2giAAH?=
 =?us-ascii?Q?c4WqKC3MQ9qE84mEN8Yld5KSBBimhlirLbnD+zVHutxg7BP3Dx0iNhJ+BcDO?=
 =?us-ascii?Q?QhDXI7AMb55t7U2XiSY4aP/NmSxAeTabxHR5Q2b/UeB7z7DWXw27jNJ97Aon?=
 =?us-ascii?Q?QLAR5MQaXmWQRdOv39oIBS8/HFw1TFMdxNsrzfoXD1E0zIPBJspwbmeN5ntT?=
 =?us-ascii?Q?eTmjWyMARtQ6qv9tYVRCw1vVQzBp45zaN6b/o1/UFGHw2GZHBcRJNgd8nrdz?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 720091e0-6160-447f-72cd-08dada3561b9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:33:23.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XD/SYv6b0O1fRjZP1ArEeD2V1NnUmDoSptl2VNrgLO9esdA2YVrMiUXiOJNQm7yNmG+tAJ7K0IhatVdX7cb0MfoU6rte97e3vDnNiorJrcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
[..]
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 3a66aadb4df0..86c84611a168 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -417,8 +417,44 @@ static void disable_aer(void *pdev)
> > >  	pci_disable_pcie_error_reporting(pdev);
> > >  }
> > >  
> > > +static void cxl_mem_free_event_buffer(void *buf)
> > > +{
> > > +	kvfree(buf);
> > > +}
> > > +
> > > +/*
> > > + * There is a single buffer for reading event logs from the mailbox.  All logs
> > > + * share this buffer protected by the cxlds->event_log_lock.
> > > + */
> > > +static void cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> > > +{
> > > +	struct cxl_get_event_payload *buf;
> > > +
> > > +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> > > +		cxlds->payload_size);
> > > +
> > > +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > > +	if (WARN_ON_ONCE(!buf))
> > 
> > No, why is event init so special that it behaves differently than all
> > the other init-time allocations this driver does?
> 
> Previous review agreed that a warn on once would be printed if this universal
> buffer was not allocated.
> 
> > 
> > > +		return;
> > 
> > return -ENOMEM;
> > 
> > > +
> > > +	if (WARN_ON_ONCE(devm_add_action_or_reset(cxlds->dev,
> > > +			 cxl_mem_free_event_buffer, buf)))
> > > +		return;
> > 
> > ditto.
> 
> I'll change both of these with a dev_err() and bail during init.

No real need to dev_err() for a simple memory allocation faliure, but
at least it is better than a WARN

> 
> > 
> > > +
> > > +	cxlds->event.buf = buf;
> > > +}
> > > +
> > > +static void cxl_clear_event_logs(struct cxl_dev_state *cxlds)
> > > +{
> > > +	/* Force read and clear of all logs */
> > > +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > > +	/* Ensure prior partial reads are handled, by starting over again */
> > 
> > What partial reads? cxl_mem_get_event_records() reads every log until
> > each returns an empty result. Any remaining events after this returns
> > are events that fired during the retrieval.
> 
> Jonathan was concerned that something could read part of the log and because of
> the statefullness of the log processing this reading of the log could start in
> the beginning.  Perhaps from a previous driver unload while reading?

The driver will not unload without completing any current executions of
the event retrieval thread otherwise that's an irq shutdown bug.

> I guess I was also thinking the BIOS could leave things this way?  But I think
> we should not be here if the BIOS was ever involved right?

If the OS has CXL Error control and all Event irqs are steered to the OS
then the driver must be allowed to assume that it has exclusive control
over event retrieval and clearing.

> > So I do not think cxl_clear_event_logs() needs to exist, just call
> > cxl_mem_get_event_records(CXLDEV_EVENT_STATUS_ALL) once and that's it.
> 
> That was my inclination but Jonathan's comments got me thinking I was wrong.

Perhaps that was before we realized the recent CXL _OSC entanglement.

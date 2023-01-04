Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8903A65E11E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 00:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjADXx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 18:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjADXxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 18:53:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F2BE0C;
        Wed,  4 Jan 2023 15:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672876405; x=1704412405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/GiFrOk1PwWLYFFov116n8UaHVn/LET5oRzqeCkalag=;
  b=Cqo5bmQZQ7yscBtH2yhac0ZB7jUa6n6WqQ0l2So/H7ymCdZKEX+4RZkB
   DEo00hXpImD0lSU1ebzfHK4xmBvxxwgYjdBR99tIQjUzKmXqAgH/S/rcm
   aOBb8Q1I/nwnnr2WycjTC9mDGUchDX/El5LkPB/BO0Zba+Fb152Y85kB3
   0i6sX0pEva0x/yGRfGmn5UdsyXfOyf1I4TO2xBY38yZSSjcz0srhsrXwV
   qRwNgPRgVFSEXyvaFAuuwjR46OjASE32xZct3Iz5IOOi9FQMpYU/CoUsi
   1rzygHnAYzsg3jIEFbkFhKA9bqtAIIWJMibilZgelYAYncRclt49IcTg7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384367252"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="384367252"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779371956"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="779371956"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 15:53:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 15:53:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 15:53:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 15:53:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 15:53:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyIb5RX4Xz8thGRrSgkOK8WZAZ1pK5OebUX4U8maynbWJiPcFbMxqU9AZ1EUgLTPnZ+pjz9RlEL5X3zV0/DxfB6awuwTCG1UxLwbHiknHKJpSSbwTkmTNRQC8icJVWpzwRWQWeH9QUUSFzpNfKwG33RJ3JZis8ei3W2w4FIe8YtVqLLGgxPA9bje9mrC9JjpHeNm/vpAUtcYCqjY9m6r0scS/1ZhcsHR0KZYIh5b6/mt/pcGeaPrCviAsZ1jzZqSlOQf94AjL/AkKOid2r762J40ZF90plGGrdpfSNlAQ6p8w8hIDe37+Cnt+hhXzAfOBvVAXU0rNOaff9AfnsZLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8CUGb7Hhn4lTK5/h1mwYxbincMismvoPflzaqo3Wrk=;
 b=nDg3p8t7ccErzNpzHLS/W1W9s6nNGCuvON4Y29lBK7LHhSKzsNsUZF7BP39UrR7CbophoMzMArGXkK84a0OuO0OHUdqBBTRRHhGtyO9jrgPxIuU3Udc3VE2m2+jHVE3FxkwpZVUn4I2cOmq9A2HoO0jYZartUccT5XPz6J9fjWOxtfuQRCT7ZM8T+b28rw2W5YRQCKdcjSubftRuzkkN1llwYRvaWxFPjVlYSq+ifRQdzofsQs9sa9ns3xQNbZuscsEKglZ6gMqLlUji9uHlFrPkQPnb8Nzakcer3JIJVudctfJcanT7uBsop1amoSkNOYvUEpZBe9uyTIAZ+7deuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 23:53:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 23:53:19 +0000
Date:   Wed, 4 Jan 2023 15:53:13 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     johnny <johnny.li@montage-tech.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 2/9] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <Y7YRaYk1Qx3d2Bgt@iweiny-desk3>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-3-ira.weiny@intel.com>
 <20221216153939.00007c41@Huawei.com>
 <Y5zo+UqOmGCE4ObC@iweiny-desk3>
 <Y55d/l1nTfpTX/1A@SR651>
 <20221218155553.000043e5@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221218155553.000043e5@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 6025035c-97eb-445a-9c97-08daeeaedb25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0kw43dt+gIsIsd3lNeIyAASRbvxa9kX45SxK+lPavUftU4kxWkl3i2YEiUeJ3EHQT5e2ZJ94MCe8aVDOUEXaT52eNr5kIKKbXEYrzga2aUWINVNtORsMg7Hwip8y5fCuOtYdDteEgxDzEbbzrbvnzQVkpQuYct+eqi0kmT8j02/jYpbDpK+8231eO6xowI6cFgTXT9qcUuDQjuUJSuFLkeNA2vys6MUEqmzRDOIyT7KP1MvXIUXjnZU0HXJBEIj6fHCJ5pqiS6kdERUbSrUAw7s5ZlSXRzPrDrOjzbd1XYykjF01/R8B6b/bbPqhpx1CnXxI+CUiSFQ5tZiwvTlDoa9KS3WAqh+0986txVMU152lA6lJGwZhD87AYQfilFqa1LI4zDGOwAIjz98EQl45ja8PYSoEzRd501y54F9NSYMF7XR0VE1guRT2GPcNI6APgNPINR50VCierlbWtrTcT1BelHoQ9M8V2R4XAxKyWzuyxEvpT67EH5W6/sJzgTylnj3Qwhnf3cPkJ/77HAouivsySP28weRSY/mjHPbQUI6cWKD+VfDJlgjqJMv2qxbFGDBEg4bM1+jWL5i6c3SyVn39Rg9h2T8e9tovo2q567gTXKXc3Jms2OCIpeSWxoyCCkVnaYJC4X3HAewxTUevQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(6506007)(6666004)(478600001)(186003)(86362001)(33716001)(82960400001)(38100700002)(6512007)(9686003)(26005)(83380400001)(6486002)(5660300002)(44832011)(8936002)(4326008)(66946007)(66476007)(66556008)(8676002)(316002)(6916009)(41300700001)(2906002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vk295WJMpxSSJex7hcpLYANAwCF4PLWsGMydKeTFWeKqw9opkFgiLIwar7gF?=
 =?us-ascii?Q?FepyOVd84/e+09hjq2swvPgYRz/ow8O5qKNXKNCymR7Pcufj+c/g9bacxLws?=
 =?us-ascii?Q?G0RgtNf0T1d7YQXS6eug3wKjuMGnzsxBA5Yupxsn7LgXR45T9sGk2/NVJ8m2?=
 =?us-ascii?Q?UFYAnmYbbla+WxAmqPY3BubQBRt7E7U3uPwR8/+B4nzFOPrQ1Z2yu42T5hl6?=
 =?us-ascii?Q?MbGyiwsag5AAZ0XTfZKKwrYOfluul1ThrLfvZe5pjhh/6hQimQ8f96NWVsOS?=
 =?us-ascii?Q?PyZLlchwMvN+Rh4+Typ8Wnk2/R6ulnMjPrMsOJELe9f1BYNmMuIyj5Xkh79c?=
 =?us-ascii?Q?94qnlDgTTikH15gOoNmIbnoPAnv/WrEMOomREeaDZ08GUbY0rsrjoY77TSEv?=
 =?us-ascii?Q?oGn3jl6Ehmh/L0uXzVWMRYu4o5Z0zZQY+mcpNi2+QWBhzO+MKKTOsnNbW7+A?=
 =?us-ascii?Q?svuJvQDIRsdDn1cLs+IIDl1zYc0WSuqEfZtrtzN7GL/hfyPZG4SZdTLwXirs?=
 =?us-ascii?Q?7ccVNHz0bAd0/DQFeb52MVqLlvU4YRaw6VuesIfhCZoocEGw+7wMVfIpApI8?=
 =?us-ascii?Q?kk4sGHFzSjmdmgK9+gb4/bwTfp+EVK/UqmxMuy1P+po7ehVG2moXwzJi8gZT?=
 =?us-ascii?Q?WxTs9n6BEiylkxegM4lgYkLeGWNLw028G/MUMHtxmNwYU22rgVXoknnOYNgQ?=
 =?us-ascii?Q?d57w1ObdCluPbT60sHxdWCHsWMMzvMS6nMaqSC15EY4IWH/WV13R/9jFbdPG?=
 =?us-ascii?Q?JofQaJ4wKYU9Hhpg7YfV5S6R4zPfh6yXjfUveKkRFAHGYC8Ctraiotj0ETdy?=
 =?us-ascii?Q?/RugEOuJMcIe2lB3gdui1Hh4tF+graPlpGoa+LIjzAuLJf4Rj3vGLPz3E251?=
 =?us-ascii?Q?djK1+aenh8qgcHC7zN1Gb9GipHsW0RVOn1FAWQDXP/ku5a/1PfPNDCddJPKx?=
 =?us-ascii?Q?lmRVGMDAg0pYkW/izALCCQcH4Gr26GaizLso9WVIXA4N3INiVTePezax7E5t?=
 =?us-ascii?Q?vNK9jVlQRjtTnGNS7YAi7Koa7NX2dbUDpFw5BTjb9d8BMs0x6w5sjD4lHiCe?=
 =?us-ascii?Q?MaUGynRcHO4ufL4mtz9Uo6ssUYebj1HesQ9kB4yL37ThVjC6SoCAunSzebJ9?=
 =?us-ascii?Q?QGkYl40eoYoAk6MWp5BkMEenTzeUIIDkpxK/s78SJMi0KBwkG85An44hGbRh?=
 =?us-ascii?Q?psg6uc2YiVMF3uPBkGwcYCBA/75a1Cj8JtzqBlK1TMnz3Gk/9PNSQUvd5mFr?=
 =?us-ascii?Q?cK92J0uJVLWUHXrZHbpShHpzj9a1a9Nbz0RtYJrc9h41M2dp2KCyFOocZy8J?=
 =?us-ascii?Q?WukYhjjZv/ZfBdeO1MRJrHfiftEcP9/fbmglX6oh5TSpvS3l6I1sOlPb17fK?=
 =?us-ascii?Q?Y72leOQp/upidzT9f5y67iBdnKih+8Jo/ezXmFlGYpQLt/BlmAzaDedSXueT?=
 =?us-ascii?Q?aR4fMZjiw5liGw4W11M9ryHsMheSfYyBDi7yen2hTxqTi82uXS2YSAYx0fWC?=
 =?us-ascii?Q?9Qd3K4psR71/87tJQW/43/nTuQi1M9MVQ0Nw1EWd0Uol+lFNFS0A+bquhTUi?=
 =?us-ascii?Q?IzFbQzq8zbEMgjn5PMbGr7stdab8F7kNxgqm/DZA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6025035c-97eb-445a-9c97-08daeeaedb25
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 23:53:19.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+UzXEpCwDBXe7hZT1TfBcw9E6vnoFEgGKHiXfQRC0/Px1ocYoBKTNkL59YjxbU1zSbyUbet3HIr9vRoIANwVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 18, 2022 at 03:55:53PM +0000, Jonathan Cameron wrote:
> On Sun, 18 Dec 2022 08:25:34 +0800
> johnny <johnny.li@montage-tech.com> wrote:
> 

[snip]

> > >   
> > > > > +	}
> > > > > +
> > > > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > > > +		.opcode = CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> > > > > +		.payload_in = &payload,
> > > > > +		.size_in = pl_size,  
> > > > 
> > > > This payload size should be whatever we need to store the records,
> > > > not the max size possible.  Particularly as that size is currently
> > > > bigger than the mailbox might be.  
> > > 
> > > But the above check and set ensures that does not happen.
> > >   
> > > > 
> > > > It shouldn't fail (I think) simply because a later version of the spec might
> > > > add more to this message and things should still work, but definitely not
> > > > good practice to tell the hardware this is much longer than it actually is.  
> > > 
> > > I don't follow.
> > > 
> > > The full payload is going to be sent even if we are just clearing 1 record
> > > which is inefficient but it should never overflow the hardware because it is
> > > limited by the check above.
> > > 
> > > So why would this be a problem?
> > >   
> > 
> > per spec3.0, Event Record Handles field is "A list of Event Record Handles the 
> > host has consumed and the device shall now remove from its internal Event Log 
> > store.". Extra unused handle list does not folow above description. And also 
> > spec mentions "All event record handles shall be nonzero value. A value of 0 
> > shall be treated by the device as an invalid handle.". So if there is value 0 
> > in extra unused handles, device shall return invalid handle error code
> 
> I don't think we call into that particular corner as the number of event
> record handles is set correctly.  Otherwise I agree this isn't following the
> spec - though I think key here is that it won't be broken against CXL 3.0 devices
> (with that rather roundabout argument that a CXL 3.0 devices should handle later
> spec messages as those should be backwards compatible) but it might be broken
> against CXL 3.0+ ones that interpret the 0s at the end as having meaning.

I'm respining this to add the pci_set_master() anyway.  So I'm going to change
this as well.  I really don't see how hardware would go off anything but the
number of records to process the handles I could see some overly strict
firmware wanting to validate the size being exactly equal to the number
specified rather than just less than (which is what I would anticipate an issue
with).

Dan has agreed to land the movement of the trace point definition to
drivers/cxl patch I need to cxl/next.  After that I will rebase and send out.

Ira

> 
> Thanks,
> 
> Jonathan
> 

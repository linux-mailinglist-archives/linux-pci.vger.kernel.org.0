Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A66D56D032
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGJQxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGJQxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 12:53:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938713D47;
        Sun, 10 Jul 2022 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657472010; x=1689008010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QFBHAGYjhE3SQGzDGN6MV80o+XHH9kuon1aooW8mNUY=;
  b=AE7xv8NYgbgU1rH1BQp2mLHXHGtG5TouHGiR137TCX0vxetTvfcZyGfB
   dwf8duZ1/745SpzMgesmOR5phmj9XrBCp2TvcppPU+OIMltfk00XV2+kO
   E+g9S/HU2nA5oYcJbEJU891KVhsjFrU3pKS6UEY1g/xpllGSMJZ6HJGTT
   ZwG9/eINRC+TI/whEhDhTSflfqsMTll6ICxmJEqPiKNAEABgqTaJGguan
   Cn0/6PhG3P8Jpr3bvVAislHRzlicZCBhYqK5IC9thMH4WoYsxnJETOqcj
   farNGR16QSRZqIaDRkvIIT97UVhc7t4p7jYWR+AKI2QmLJSqiiG/JQ8Ia
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="346212203"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="346212203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 09:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="721374037"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2022 09:53:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 09:53:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 09:53:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 09:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1E/cJ7PieOXZfgWwnDSSuX/eGwnU2I157KxdkNxyMuabMf8KVG3JukDyYOS6SmWlfY3GskLBZfYCVQjbG0Rw3Gu+62SU5lWg1j/4jkD8tfBImZ7ZihuiNqeRCw3OhuKReHlZIkeXDNdJniCyXhoEyKFMDZiUur+Sbc2VNQkLhieYj5RdHw4q1rdFrfjNSzEemcQKl/atWbRu5LclvbyVFEKk6rNqkYQDeYdpmBhWh9KXAm7TCEa+9Mh/e5Vt/55fir43mpYArU7Jq5H2ftWWraBp6c5YCc/WXMGQxxFHiJsvv4YsPWYAiA4t4v3TSocHIXOnYMTCwSNd9ROvl625Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leOqapV/6qQtbuwrS2eglE1kcAvhVLrXNumyI7vke1U=;
 b=FqmramjvwTu8OI659w1aSkfzO+T/g9nZ6ry4FjH1ZHOjNA31LVduuUpRxTIJbY1MqtkwGoKyBzVJhCFxvwR+7Q4ohRrn0oc9uWb0yARXVryHJApaIMQ07r2cPRVcZ9fAGEceRd/ASvQJdvCs49dRKmwv6yveP6ULiA5tZPZPBhoyCW/IbcDqkRFPueyZfCSLIwsUYzb5JINoGakTkR0/7Rhu9O+2g0LoHJPlUNyEbwNEo8BXfUUVcmS8gxtmfGFpdICzN2hAmPfqSLoDexF0hJTvwEJghd122o6I2JhOVoG75ju9Lztf1D786nv+jwR7kKOUGL+20LgqRkguxeDQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4778.namprd11.prod.outlook.com
 (2603:10b6:806:119::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 16:53:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 16:53:25 +0000
Date:   Sun, 10 Jul 2022 09:53:23 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 18/46] cxl/hdm: Add support for allocating DPA to an
 endpoint decoder
Message-ID: <62cb040375bd7_3177ca2941c@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603883814.551046.17226119386543525679.stgit@dwillia2-xfh>
 <20220629165652.00004ca3@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629165652.00004ca3@Huawei.com>
X-ClientProxiedBy: MWHPR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:300:116::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92eab594-2ed4-4bcf-8f2a-08da6294b4dc
X-MS-TrafficTypeDiagnostic: SA2PR11MB4778:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kJvsZXnHXaZ0X0+8LT4Y+q8wgvaUnYzxsPWsyxRLE/yXVT48HZcF8WO+n1RGbluGA+HzruEngg933orLWJ3C9CsHBEgYaKtMdzELz8WlwvxK3onrIfXpCdJIseUK508ihYbefHDMf+Sf5mNjKe4Fm+kcF/s/XcGkfQC21MUa6YPS8X1EuuUBgvKopEArAIEQaEsLKmTB+VEU+I33CpMnQQa6igUjI52EuKL10sZee56rns1UJ9dbiEzzp+CQ98gRFrbWxI/XE404X8Sbbkdt8z/ST/++hxXNPD70VISJ4n5SuOJ2G2vAlQbMJ+5vwkiOIcUp0ijJh60Slb8EPUdKjrgGEm8qSWaV4+AqXe4bv+VS92oeL2Jvfgi8YNUwInimFrBJ2UqjaH5tJecnST4pS/0K6ZYH8hdImLQU+bC98S9yyKw/5MvbinFD0lUHQqS90zTmRTrtNU0IQCA1DukQxNF9XgHaGtrue75o7ajY+ygVf7yxq2anQpb2TRWoHXcipH2m6x/fqMNR5PhcXN7Efusjft5+eSbLm2KjQgjuwtYfWMmI7tndPtzd4BHQtRSNQLvWIzDPYLrcgB0s9rJoMSYNjvlkAYoA+yVIcnhwXavuX1vsEPL/j1Ge8ANCMQKHAqJ+yLfqyXz9lzXE5z2Q6+jv6MWqstQglF61Kasz5PZRAsWiejsmbDQX3BPqY5M0KklotQNC0XBIBwVkC+xFEsz0ksONMMoob6vdFNFr5bD547SeKdUd3hB8om5UVc96CLIkEHkdu0sAgOqNa/c7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(136003)(39860400002)(26005)(186003)(6506007)(6512007)(9686003)(38100700002)(86362001)(82960400001)(83380400001)(30864003)(5660300002)(8676002)(4326008)(110136005)(316002)(66556008)(66946007)(6486002)(41300700001)(478600001)(66476007)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?soBAlym4dv9WDlCNVB/c9ksZz96yC37YI5yleybt82ubHuoXt1hI5SGAqPju?=
 =?us-ascii?Q?j7K1bbwTRxJP+nyWeN3CreoMNOk09jEW0iI1TLpDxvJjDeouGGFpnIcDs6mc?=
 =?us-ascii?Q?AnaK8sd0YiYFozQDBEhWjrNI0XGEqpUluBHi1RLvh8Tir62Vnn8wxmMWqcNN?=
 =?us-ascii?Q?NmI2kOhKtZpxtskULGguJdgWCPrycvcTqvN3W348iZiysTgYa6AtWPUO66ww?=
 =?us-ascii?Q?Lfk+8G4lXEA5lsU8whRHAHT2bog2IH2eifBYVIE7ksz7iOUXNvwKakCk4TzD?=
 =?us-ascii?Q?KQyO8mGeOTaio/Y8qzcqg70Sal2sjRanASE9lWuHVI3p+l8iz2iQVilPeIBB?=
 =?us-ascii?Q?tJNK3yqBwlnzB2hUkYpD0KhuvNWjx0I7iQGRXTJ7ldwECPsMB0r6NyjnGSbT?=
 =?us-ascii?Q?/EfsRxCF5jDF0Uca3lihaSnZS96Xks5TDL8RNDJEW+XpZz134DjOW0mSUkxv?=
 =?us-ascii?Q?Yb9ns81vQKBu665J41Ks1PeJRQvo2aVwUdFUs7e7MLJ5ib5a8rVRHtcPdpuc?=
 =?us-ascii?Q?NNC1kfMoG5EVVI6/2r5tVJSSkHxbzKIgUt8hVdfPbfEmPPZc3AR46j1Iqv6C?=
 =?us-ascii?Q?GcSNx60gkmMCgvNbFsS9ziC0Rh1QjKhT5KOKfQxMaR7GIjkl4h9xJSvIH6ZX?=
 =?us-ascii?Q?hggwa+B1pmzJONXICdpIOsZmhrZQvvwRlTlizWo1xYrcBca3oipsN7HXVXs/?=
 =?us-ascii?Q?qCX9y1QDkPWICdI3m45HJgK1VLHkUTovTjeWNIvHCX5bDdsSKYMHpzL0USJZ?=
 =?us-ascii?Q?lDxYJ4hzgobbzsA0QNfUezJL1xilYlOIo9GlcfomYMylIoi5B8cjPMMhJ51z?=
 =?us-ascii?Q?31DcMHstP/lPi35Q90tKuVUevow5O6kG3Al+XxAYH70yQC6i63wqD9CnD7oO?=
 =?us-ascii?Q?XVPjcFgKyWATXGqQ3q2Ob068F6IIoXPq4CKdQttXwn6Hp7fmEqEU0uBjCnOi?=
 =?us-ascii?Q?bLxyfIOL42J6MOG7+LZuyLQ6ROzm6WeuMXlL3i0iPUoJenoO6+nLbfSLMaL5?=
 =?us-ascii?Q?sW87/wwYDzu7tHYeywas4e0VpxqmrYXibzSQH/xmb/F/JGtdtgwhzyCSYDWY?=
 =?us-ascii?Q?1NGQcsqYGvrjfD75s8GLJ/Z8SAv/Vpxn9qxxH4fuy1vOgusPIxohVfTZbJt6?=
 =?us-ascii?Q?aBnE6SA+QjGuyFtnKkUVhoxKSJ0/14cNPZBZK9U8j9HAUaUPwysEjd51WFBg?=
 =?us-ascii?Q?GXMeJJ5TUov+G9FlwfjgvN4q5UA75IbiltyXfEEO6lrq3yIE7ONHlwSK9yIY?=
 =?us-ascii?Q?Otz37p+8DJ6IiUAFOqGyYl9rOCSG05Xv/HOYZzrGoEyQeLFUVh5yyxfxBXiz?=
 =?us-ascii?Q?5o5m0IgMm8MGEep9XCi4YYdNycre0tSq6YWUJhp+nnyzt7ZmrutqcLhNRL8N?=
 =?us-ascii?Q?rZWmwsmI3YV/Q38XRfWNChhombWoIoKxT64cu4ofiZEiaufZPzjiP+Lm+vS+?=
 =?us-ascii?Q?QwIl487MX9UXCBZzB+AGIorA+Fs4OVdGeSsKmX+Xxub4UVM4t8l5Aysb1lUp?=
 =?us-ascii?Q?Rd9ieCkbujNoFJzLGA3ojp6Ex6Kd8FI07eHr8ybycaWs61qyVgkcnSTtH3jM?=
 =?us-ascii?Q?/zrvgy1vWc0zEKludeTm8U7gWCU+UkoxIDo/VmmI4S61qpInWoUuXarJe17y?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eab594-2ed4-4bcf-8f2a-08da6294b4dc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 16:53:25.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgUZRk3nE4SySkFgZR5I1DyPoIA8FD0NhTPNFCTtCckUYutDTCM9R8p0x3i3JELXAS8vaAvrmewq//yLifUDD6kFkg8orqtLupv5HELBW7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
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

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:47:18 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The region provisioning flow will roughly follow a sequence of:
> > 
> > 1/ Allocate DPA to a set of decoders
> > 
> > 2/ Allocate HPA to a region
> > 
> > 3/ Associate decoders with a region and validate that the DPA allocations
> >    and topologies match the parameters of the region.
> > 
> > For now, this change (step 1) arranges for DPA capacity to be allocated
> > and deleted from non-committed decoders based on the decoder's mode /
> > partition selection. Capacity is allocated from the lowest DPA in the
> > partition and any 'pmem' allocation blocks out all remaining ram
> > capacity in its 'skip' setting. DPA allocations are enforced in decoder
> > instance order. I.e. decoder N + 1 always starts at a higher DPA than
> > instance N, and deleting allocations must proceed from the
> > highest-instance allocated decoder to the lowest.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> The error value setting in here might save a few lines, but to me it
> is less readable than setting rc in each error path.
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |   37 +++++++
> >  drivers/cxl/core/core.h                 |    7 +
> >  drivers/cxl/core/hdm.c                  |  160 +++++++++++++++++++++++++++++++
> >  drivers/cxl/core/port.c                 |   73 ++++++++++++++
> >  4 files changed, 275 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 091459216e11..85844f9bc00b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -171,7 +171,7 @@ Date:		May, 2022
> >  KernelVersion:	v5.20
> >  Contact:	linux-cxl@vger.kernel.org
> >  Description:
> > -		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> > +		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> >  		translates from a host physical address range, to a device local
> >  		address range. Device-local address ranges are further split
> >  		into a 'ram' (volatile memory) range and 'pmem' (persistent
> > @@ -180,3 +180,38 @@ Description:
> >  		when a decoder straddles the volatile/persistent partition
> >  		boundary, and 'none' indicates the decoder is not actively
> >  		decoding, or no DPA allocation policy has been set.
> > +
> > +		'mode' can be written, when the decoder is in the 'disabled'
> > +		state, with either 'ram' or 'pmem' to set the boundaries for the
> > +		next allocation.
> > +
> 
> As before, documentation above this in the file only uses single line break between
> entries.

Yeah, I'll go fix those up as a precursor patch.

> 
> > +
> > +What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> > +Date:		May, 2022
> > +KernelVersion:	v5.20
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint",
> > +		and its 'dpa_size' attribute is non-zero, this attribute
> > +		indicates the device physical address (DPA) base address of the
> > +		allocation.
> 
> Why _resource rather than _base or _start?

To mimic PCI and NVDIMM sysfs that calls it a 'resource' address.

> 
> > +
> > +
> > +What:		/sys/bus/cxl/devices/decoderX.Y/dpa_size
> > +Date:		May, 2022
> > +KernelVersion:	v5.20
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> > +		translates from a host physical address range, to a device local
> > +		address range. The range, base address plus length in bytes, of
> > +		DPA allocated to this decoder is conveyed in these 2 attributes.
> > +		Allocations can be mutated as long as the decoder is in the
> > +		disabled state. A write to 'size' releases the previous DPA
> 
> 'dpa_size' ?

Yes.

> 
> > +		allocation and then attempts to allocate from the free capacity
> > +		in the device partition referred to by 'decoderX.Y/mode'.
> > +		Allocate and free requests can only be performed on the highest
> > +		instance number disabled decoder with non-zero size. I.e.
> > +		allocations are enforced to occur in increasing 'decoderX.Y/id'
> > +		order and frees are enforced to occur in decreasing
> > +		'decoderX.Y/id' order.
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 1a50c0fc399c..47cf0c286fc3 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -17,6 +17,13 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
> >  void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> >  				   resource_size_t length);
> >  
> > +int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> > +		     enum cxl_decoder_mode mode);
> > +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
> > +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> > +resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
> > +resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
> > +
> >  int cxl_memdev_init(void);
> >  void cxl_memdev_exit(void);
> >  void cxl_mbox_init(void);
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 8805afe63ebf..ceb4c28abc1b 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -248,6 +248,166 @@ static int cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> >  }
> >  
> > +resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	resource_size_t size = 0;
> > +
> > +	down_read(&cxl_dpa_rwsem);
> > +	if (cxled->dpa_res)
> > +		size = resource_size(cxled->dpa_res);
> > +	up_read(&cxl_dpa_rwsem);
> > +
> > +	return size;
> > +}
> > +
> > +resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled)
> 
> Instinct would be to expect this to return the resource, not the start.
> Rename?

I can add _start, but this is only servicing the dpa_resource_show()
sysfs operation, and there 'resource' as a the base address has ABI
history.

> 
> 
> > +{
> > +	resource_size_t base = -1;
> > +
> > +	down_read(&cxl_dpa_rwsem);
> > +	if (cxled->dpa_res)
> > +		base = cxled->dpa_res->start;
> > +	up_read(&cxl_dpa_rwsem);
> > +
> > +	return base;
> > +}
> > +
> > +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int rc = -EBUSY;
> > +	struct device *dev = &cxled->cxld.dev;
> > +	struct cxl_port *port = to_cxl_port(dev->parent);
> > +
> > +	down_write(&cxl_dpa_rwsem);
> > +	if (!cxled->dpa_res) {
> > +		rc = 0;
> > +		goto out;
> > +	}
> > +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> > +		dev_dbg(dev, "decoder enabled\n");
> 
> I'd prefer explicit setting of rc = -EBUSY in the two
> 'error' paths to make it really clear when looking at these
> that they are treated as errors.

Ok.

> 
> > +		goto out;
> > +	}
> > +	if (cxled->cxld.id != port->dpa_end) {
> > +		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
> > +			port->dpa_end);
> > +		goto out;
> > +	}
> > +	__cxl_dpa_release(cxled, true);
> > +	rc = 0;
> > +out:
> > +	up_write(&cxl_dpa_rwsem);
> > +	return rc;
> > +}
> > +
> > +int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> > +		     enum cxl_decoder_mode mode)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct device *dev = &cxled->cxld.dev;
> > +	int rc = -EBUSY;
> 
> As above, I'd prefer seeing error set in each error path rther
> than it being set in a few locations and having to go look
> for which value it currently has.  To me having the
> error code next to the condition is much easier to follow.

Fair enough.

> 
> > +
> > +	switch (mode) {
> > +	case CXL_DECODER_RAM:
> > +	case CXL_DECODER_PMEM:
> > +		break;
> > +	default:
> > +		dev_dbg(dev, "unsupported mode: %d\n", mode);
> > +		return -EINVAL;
> > +	}
> > +
> > +	down_write(&cxl_dpa_rwsem);
> > +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> > +		goto out;
> > +	/*
> > +	 * Only allow modes that are supported by the current partition
> > +	 * configuration
> > +	 */
> > +	rc = -ENXIO;
> > +	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
> > +		dev_dbg(dev, "no available pmem capacity\n");
> > +		goto out;
> > +	}
> > +	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
> > +		dev_dbg(dev, "no available ram capacity\n");
> > +		goto out;
> > +	}
> > +
> > +	cxled->mode = mode;
> > +	rc = 0;
> > +out:
> > +	up_write(&cxl_dpa_rwsem);
> > +
> > +	return rc;
> > +}
> > +
> > +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	resource_size_t free_ram_start, free_pmem_start;
> > +	struct cxl_port *port = cxled_to_port(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct device *dev = &cxled->cxld.dev;
> > +	resource_size_t start, avail, skip;
> > +	struct resource *p, *last;
> > +	int rc = -EBUSY;
> > +
> > +	down_write(&cxl_dpa_rwsem);
> > +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> > +		dev_dbg(dev, "decoder enabled\n");
> > +		goto out;
> 
> 
> -EBUSY only used in this path, so clearer to me to push that setting down
> to in this  error path.

Ok.

Folded in these changes:

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 85844f9bc00b..3fa6da73751e 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -207,7 +207,7 @@ Description:
 		address range. The range, base address plus length in bytes, of
 		DPA allocated to this decoder is conveyed in these 2 attributes.
 		Allocations can be mutated as long as the decoder is in the
-		disabled state. A write to 'size' releases the previous DPA
+		disabled state. A write to 'dpa_size' releases the previous DPA
 		allocation and then attempts to allocate from the free capacity
 		in the device partition referred to by 'decoderX.Y/mode'.
 		Allocate and free requests can only be performed on the highest
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 47cf0c286fc3..65bcaecec405 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -22,7 +22,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
-resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
+resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c1ff3c0142f..e9281557781d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -270,7 +270,7 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 	return size;
 }
 
-resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled)
+resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 {
 	resource_size_t base = -1;
 
@@ -284,9 +284,9 @@ resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled)
 
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
-	int rc = -EBUSY;
+	struct cxl_port *port = cxled_to_port(cxled);
 	struct device *dev = &cxled->cxld.dev;
-	struct cxl_port *port = to_cxl_port(dev->parent);
+	int rc;
 
 	down_write(&cxl_dpa_rwsem);
 	if (!cxled->dpa_res) {
@@ -295,11 +295,13 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	}
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
 		dev_dbg(dev, "decoder enabled\n");
+		rc = -EBUSY;
 		goto out;
 	}
-	if (cxled->cxld.id != port->dpa_end) {
+	if (cxled->cxld.id != port->hdm_end) {
 		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
-			port->dpa_end);
+			port->hdm_end);
+		rc = -EBUSY;
 		goto out;
 	}
 	devm_cxl_dpa_release(cxled);
@@ -315,7 +317,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxled->cxld.dev;
-	int rc = -EBUSY;
+	int rc;
 
 	switch (mode) {
 	case CXL_DECODER_RAM:
@@ -327,19 +329,23 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	}
 
 	down_write(&cxl_dpa_rwsem);
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		rc = -EBUSY;
 		goto out;
+	}
+
 	/*
 	 * Only allow modes that are supported by the current partition
 	 * configuration
 	 */
-	rc = -ENXIO;
 	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
 		dev_dbg(dev, "no available pmem capacity\n");
+		rc = -ENXIO;
 		goto out;
 	}
 	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
 		dev_dbg(dev, "no available ram capacity\n");
+		rc = -ENXIO;
 		goto out;
 	}
 
@@ -360,11 +366,12 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	struct device *dev = &cxled->cxld.dev;
 	resource_size_t start, avail, skip;
 	struct resource *p, *last;
-	int rc = -EBUSY;
+	int rc;
 
 	down_write(&cxl_dpa_rwsem);
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
 		dev_dbg(dev, "decoder enabled\n");
+		rc = -EBUSY;
 		goto out;
 	}
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 130989846cce..feed86737202 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -215,7 +215,7 @@ static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *at
 			    char *buf)
 {
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
-	u64 base = cxl_dpa_resource(cxled);
+	u64 base = cxl_dpa_resource_start(cxled);
 
 	return sysfs_emit(buf, "%#llx\n", base);
 }

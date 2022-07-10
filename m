Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D504256D147
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 22:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGJUkb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJUka (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 16:40:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B5CE1D;
        Sun, 10 Jul 2022 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657485629; x=1689021629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IbONc405ufoNhav6dEOEZlo75/r0M5AKVYUre0wR5Hk=;
  b=aJtUiFA7BhQNixwphYNZ0UyKBeB/uUobUyk7um9lKZjxjTDMH8qWR7nh
   /8Sd6AkyZmy5JuyYpFjILx5N/KPeD+rMTY7bDAPwAZjPdVqQgOzJU5w2A
   iOihUs2GmcJNBWKewscePhjGwgTQ10p6j0K1rwxXaPTWOB60vmZRL3zH+
   7DXoPjJ0jWbIkFiwn/9zZWWS6oM8i1WmZGUz6+Fgs5+Q8BTZu3VctBz97
   jZuKuvZWG34MO5KLlld7O+t2uC4Ibcb2FOfVq09HNFvdZLx9ec1gCrCIa
   FbgpFgVyzk6Y+jc/6Po0MgVbGsPRZ+KCGv7WbsKCAmXOZhB86AOHBjm+4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="285281275"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="285281275"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 13:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="652214266"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2022 13:40:28 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 13:40:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 13:40:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 13:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeBtXBycMjafdF0IFVuUT/Bqj2tgT6Wzi8GT4UkApxI0DiKwWUFv/YMmjA2CBO2xVQBuWFDYdGETIF1QbC5J6tb3UPPbVjbcAn4VcJFNpos8ChU5tOtrJIf1+D0r65iO7YHWRn4SN+j3usxoO0a9F4SeMVDyB2zxjK2OExC1ambLh/OJVhFNwU2Ig2o8QWzw+Ep67YOWPC8Vuil7A+pNw+8rZhAfH/MWKtJ8ST+gmXyXx7PUtLp6DXMcfRjoSYCmB9oO2HFXt0Ff88DvWUOg2ZsLumGC9n7znY87zONsmVcqQHvLW3Ln0ZjI1ZdUIyaDOcxpfNqpNn6nLpEvs9LD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ezch/rWZixIWRahk1bR0ZGbZ8i3DsXEuq3bQl8zbfhM=;
 b=YPIvJp2Uh6B4eqHF1hz9V5KeJJI1/MvBLigmt2ab2Jnt2Ourgeyq0XR/kzEp9vUqOs5SIuxmvKKQAOXn9j4bzDlnl2hcIx+akzIQG3CjvkcB95bpsiB6INPNxKtkqd/iM9WkN1apjMgY1vBcoaIcwpKJQ+yaOfdsUSi0mFmbZwrt/r+yayoUMyMw2o6t2OSLFeAK0vqwsLvSkLTQDburUcd8ZX4KmrT/uFf7sXRSi1d1HA8SxZoWVcMOZC4URhvzrt8HfmNCcfHeNG0sXjF7rLyIus2Wfm8o1JdabUiSmuRJg3+FWujqGBbbYVs/BXU9Z/TGxnr+Jq1ZGw/qbNwqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN7PR11MB2529.namprd11.prod.outlook.com
 (2603:10b6:406:b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Sun, 10 Jul
 2022 20:40:26 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 20:40:26 +0000
Date:   Sun, 10 Jul 2022 13:40:23 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 30/46] cxl/hdm: Add sysfs attributes for interleave ways
 + granularity
Message-ID: <62cb3937d12ef_3535162943b@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-5-dan.j.williams@intel.com>
 <20220630102637.00001d53@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630102637.00001d53@Huawei.com>
X-ClientProxiedBy: CO2PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:104:4::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62643584-e909-46ad-4d24-08da62b46b1d
X-MS-TrafficTypeDiagnostic: BN7PR11MB2529:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/LpllopL5xxvAEK1NoqjC1vlVEyvpRT8QONwNMCvgKRJYSiUgim81UMIGDwhUFcHiuUT1XDbqyLVqIFCTDGq+G6DgUMGhjN49KuYwFQJZV1rNqP5u54qr5DRMAN8GZzUGpJtBzWqTXrrqdcb7uB3ZLZQ8eEWVSTvMovKCgyiNTM/PZz0+hIu6C/p0qoGcdDt3nJmbFiCfIQny/uw1v7tJIdKGMBBKUP1UZcEX2BW91YPs6O8Re6V8W/75Xyrn6uN7964X9lHVYc8buvoRmzsdtM4eRQRcOB27uespTR5MiWZR9Cakx3vtkbLn/k8IqYSRbDLEO54Ko0+9iqZAhG0NwaWf/7yWBE6fr8q+J1p72zviu+TDh7jjv8DLA0hK1LdMkTCMwrHp6rTEY6J8T/ddDmC7wG4ZzDeD5JibslROpbEf19gxpfSTjdbkk7q1TeLRk5xVyCpq24C1v6CeJuxVo4SEWWTMyUK7BOnLyO9LMt5cbavYWyBXma14r4tf0Q+9mvKvwNqUwMTQytnBhfTflFW23uJJjsAz9aovECPqduTxLGU0NcEyHBFvZZy3mSq3MpeFypESaV2y7f4X/6taWcl18/qDEpcCUrIfHVhbktG3gC91eQlmMTHFkkNHyDOiR4ctesx0wOhfvKVkqzyzL9S21ih4qEUPzGmhTigtyisoy8ymwapbm0msLJ8p/F/iGVp7NoW5KP0UJsnyPfM7uTcCs2AHHLT79ROtPSOhNeWTkpaAJd9YhcoZfTRYEx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(186003)(83380400001)(38100700002)(6486002)(66476007)(66556008)(66946007)(316002)(110136005)(4326008)(8676002)(5660300002)(478600001)(26005)(9686003)(6512007)(82960400001)(41300700001)(8936002)(2906002)(86362001)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZsWtKoIcQ29AwXW/GMYDXXuUxnST7K5LrjairoOFC2wl9zN2CSF7oKg2VaZ?=
 =?us-ascii?Q?C5y+GG4TcHrqSIdqEFonsfgr7hUyWzAtQbfworNkVy8T4avHzrksicqYn+QD?=
 =?us-ascii?Q?Yk689MPo3uRbNJDmLkwJUs/WkxwbrtufgxXQNd0HsqGn5a0EZuCY0wodjTz3?=
 =?us-ascii?Q?mCPnDQQNPsRy7BfqAdV06NQLdPurigRXm1QV7MtD3bvZlx2jtsmCbdCkQvPa?=
 =?us-ascii?Q?Q80YDI0RHJCuiQcamLAH8Rcl3okGfUnK4YCqpDGk0ysu5DypR9kWqN2BIZsm?=
 =?us-ascii?Q?dZD+gbs0D1pz2cflA+2mq+3GBBfzu0ypsmxnL6Lr7yecmHSlZ1zf3RkQ1kA5?=
 =?us-ascii?Q?YLn8LO1tfK0LtmdzNbOKtDpeTft2OrHBoEepnTxM1HNO71UZ1XjncK3NjIXq?=
 =?us-ascii?Q?qRXToLXnv1ty9KqoCkYO0np8NmRsCHv0WFXAhwUlT4AWe4tYZVwb2Z4G3Sfu?=
 =?us-ascii?Q?I+HTFZlreR7ZpQIvvHd9SC2hwBNLo7TJafN4szVYYy2l4etE6Nfg/SplmUxB?=
 =?us-ascii?Q?oHghM5rPYRD3mFmevk2xpTPy+jDokYgUFLXSYuf2bTR/BxN4MKdJ83s/cmTn?=
 =?us-ascii?Q?wNrXrzxNzNc25nycn4F8XgxlF9ixeskmw2elhWOEOepSsPD4pe8X5I/gjM8C?=
 =?us-ascii?Q?A+UJop7vjbfz8aQG6zl0nQ20FEDR/pzX9CPrA2BnsxSl/3CFZ948DWMhmBQq?=
 =?us-ascii?Q?/6A6GEYE4DkgypmT2gqiUEtDne5C0L0hFDA3J8rZQVTD8WSfqAUCsjpMqjso?=
 =?us-ascii?Q?DZFytjym+dB7E6Nh6rK0WcBkPQbQPbPubOxAFfyF3DmH8TGqmP04FpP4n0ZL?=
 =?us-ascii?Q?v4NxeSN5eDDdjBGc6xrWhB2vdQT1/vvwUwCCEqVeONKZrDxctEL6ldLcnDDU?=
 =?us-ascii?Q?AQJdG1U4ERlczOocA2ZHaet/LhRjE2sJlhW7021bUY67emHYlQ/s9lEzrNcV?=
 =?us-ascii?Q?EHWoJK49eRygepvboooIn0aahgupAI9DXo50pnEP/3HKL5J7i8EPCRO8DMYj?=
 =?us-ascii?Q?wmiYljaGmU1tw/1oNM0fuUl7PqN4/6QWfluPsPw694uymK9o75cgdMQ2QIWe?=
 =?us-ascii?Q?MnJ8gK+RUoQC7hlf2VJYUuFf/PmgCYR4B/LslRnomNpbCS9a7w2UV2XT1Kd3?=
 =?us-ascii?Q?FSmZarIyIwNbSWkK3B82pmAfykCTkBVeRUXxtT6wiud/pRySYlpxn92cCkly?=
 =?us-ascii?Q?C+4OscmcO1YVA9ZIFVBBmBihnljIJW04m5Wesm0CIwfMjRT2qqoG/qdOnBtp?=
 =?us-ascii?Q?36/I5bgQjE+pYPS+CE1UJqgQKJQSlRtAtnFxotIj3xs2nwQe81vw0H12wETw?=
 =?us-ascii?Q?vnVkNRnCBfc8kEcYCAzR8LB6mUgS/KVWPlvpdMaEHPQgdgFotE+/NAJbPS3e?=
 =?us-ascii?Q?FujLNNAHkrXha0fT63Qf1tGSlpaW/HFXBBvGRk0QfIC6lkxJM1+Ud0waBiSu?=
 =?us-ascii?Q?MBKjmJ3JDBu2mnXfCIdNl81W4WWD42R0ozRhOXgIRSaKCOtsWsS5wGdMzKn/?=
 =?us-ascii?Q?cVOrjC6Hp+RfdcTw2zBxP3jrzFpqyXdNnBfTsGQBsDtpJmjagF6UVJwuI3U6?=
 =?us-ascii?Q?MOWhh2yqprLmMc7OOcKUmacs0A55Us5z8o0ccdHCC5cevadfmzgUSxq4Z7p/?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62643584-e909-46ad-4d24-08da62b46b1d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 20:40:25.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSx0Csgm8jNUEHb/mIECD6ZDZTy0+iE1LD8Io/7KxfdWx0rDa+uwsf7tj+oi1yF2weUGRV0ZZiFRpXYMuEWAPyJ+VnXXlE2w6Xh5QEsYTrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2529
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

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:34 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Ben Widawsky <bwidawsk@kernel.org>
> > 
> > The region provisioning flow involves selecting interleave ways +
> > granularity settings for a region, and then programming the decoder
> > topology to meet those constraints, if possible. For example, root
> > decoders set the minimum interleave ways + granularity for any hosted
> > regions.
> > 
> > Given decoder programming is not atomic and collisions can occur between
> > multiple requesting regions userpace will be resonsible for conflict
> > resolution and it needs these attributes to make those decisions.
> > 
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > [djbw: reword changelog, make read-only, add sysfs ABI documentaion]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> some comments on docs.
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 23 +++++++++++++++++++++++
> >  drivers/cxl/core/port.c                 | 23 +++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 85844f9bc00b..2a4e4163879f 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -215,3 +215,26 @@ Description:
> >  		allocations are enforced to occur in increasing 'decoderX.Y/id'
> >  		order and frees are enforced to occur in decreasing
> >  		'decoderX.Y/id' order.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/decoderX.Y/interleave_ways
> > +Date:		May, 2022
> > +KernelVersion:	v5.20
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) The number of targets across which this decoder's host
> > +		physical address (HPA) memory range is interleaved. The device
> > +		maps every Nth block of HPA (of size ==
> > +		'interleave_granularity') to consecutive DPA addresses. The
> > +		decoder's position in the interleave is determined by the
> > +		device's (endpoint or switch) switch ancestry.
> 
> Perhaps make it clear what happens for host bridges (i.e. decoder position
> in interleave defined by fixed memory window.

Added: "For root decoders their interleave is specified by platform
firmware and they only specify a downstream target order for host
bridges".

> 
> > +
> > +
> > +What:		/sys/bus/cxl/devices/decoderX.Y/interleave_granularity
> > +Date:		May, 2022
> > +KernelVersion:	v5.20
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) The number of consecutive bytes of host physical address
> > +		space this decoder claims at address N before awaint the next
> 
> awaint?

Surprised checkpatch did not flag this, or that I missed the checkpatch
flag.

> 
> > +		address (N + interleave_granularity * intereleave_ways).
> 
> interleave_ways
> 
> Even knowing exactly what this is, I don't understand the docs so
> perhaps reword this :)

Reworded to:

(RO) The number of consecutive bytes of host physical address space this
decoder claims at address N before the decode rotates to the next target
in the interleave at address N + interleave_granularity (assuming N is
aligned to interleave_granularity).

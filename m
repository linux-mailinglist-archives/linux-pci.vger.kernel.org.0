Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6255A0FC
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiFXSt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 14:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiFXSt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 14:49:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0881726;
        Fri, 24 Jun 2022 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656096565; x=1687632565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YodQrpWcF4k45lyzlcdCN+24XnsGuu4bCmhlQYs6AjA=;
  b=dn3MK+ybQrsyI0klVxRaqcntiLTJE8dXRVBxArgX37ub5iujhyqFfkF1
   V5vDnMK7yczgLO9Q68Yv3ZtXaTxmfD+Uw7yh4ZOoCFMMEFy4eB64/Vqpl
   Vs0EIjogFQmPrLUGV6zrsnF9oOqCZ0oCBh3g9ZgPggpQPo80+vptnV7X4
   YsDZqosTlpyyTTaGUkFdXi6RwxnGkpvEFCFTdk1poQYQAFUjxDymFJqWS
   O1Sm1Zdd0PbVuTyv9pHiDDfZCXJe9tyDgxZ2GxxNk9G6WKLzQT9J59X1A
   8X2dd/14VBSv6mnN+pt1xP6SBox0qF+KfYcuODOlRmyoJfGcjsd0zwcL9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281799900"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="281799900"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 11:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="563937553"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 24 Jun 2022 11:49:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 11:49:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 11:49:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 24 Jun 2022 11:49:24 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 24 Jun 2022 11:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/Moky242F68UYmy6b8WnXUAIDfAuFnQwyvXE/UhVXAJB+M8uIHhrXYGWqJ01o2CHDTa6vnYvPjI12pIfj5r1uWukcQuM50xudNuRoqeZ/1nuR7k0iVaP7gzs0GsPCIAG0qlVoFtWcuvPlB+BXFzEo7XfYmi7JmdyEkVsg7SlKhmEp7QgGYqt5JSbmMckWeopaKiFZNLK4Y2iPvOtrrTpmH++pYvycBs0CG9+25PRHzvm4ogOwqUMLwL6LDx8Yr+7VoUJJCXL5/7dRzc1oDXAqGg8VbGjywgiNvZ1FMURoIZFNVxVlZAx8L0FpXKJ6p+syCSPfWUb1km4SRa7RvwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8bcZ7SDURjxMhZOzvkgD577alSyVDtlhGTxXDxIWtM=;
 b=HNZXLrgAXb2IXB2VHBNx7mC0fYpqUIXo/Lo8XOKPhemu+mjcO52gDxSo2BSRgH53Gn3RYljv6jsBgW9/tx5JRQcSHntQ0R9rh9v1fikKtqdc/to9zly0gHKNh9JC8H5/wUyt/WlG2ukZMK3XV9J7l1cao2n8B2euZAW2+WLE1k3QBZTlJ/KGxoVeCF/NNFm7+ROrW4nJAkuBb+lf2uaOXlP26T2C9onGOSSg+L20PRhHmfEhO1K/C/MwlZNaY+9zz9BzQoq5fy4K3sPvGH1/o1tz2sB4oPOWmHZP4XyqjSvGCOMzYUPMPVVsGCSrPGFSNR5PK+0VcuCEixSrT3Bovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN8PR11MB3554.namprd11.prod.outlook.com
 (2603:10b6:408:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 18:49:22 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.024; Fri, 24 Jun 2022
 18:49:22 +0000
Date:   Fri, 24 Jun 2022 11:49:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 40/46] cxl/region: Attach endpoint decoders
Message-ID: <62b6072f925da_8a98929484@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-15-dan.j.williams@intel.com>
 <20220624192501.00003b53@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220624192501.00003b53@huawei.com>
X-ClientProxiedBy: MW4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:303:6a::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98eaee42-0c58-4a66-52e2-08da56124076
X-MS-TrafficTypeDiagnostic: BN8PR11MB3554:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzLpQNnAdjhrQVwdxM1h2SdZDfCHAOfnTUnSUkDH2a/seELvppo+KlMRgBb3I/3bmqAVAK3xes3O0rSOI9Xi0u8x/oHEvBRS1jRxodJg5wxt9EB21ProVSP25IjBDVmX8/OCSf0RQdRp0mEejltAql47nldCBx1qiPz9xZW1liWUxckB+2wdyDtgmHaB6jH4ZrvAzh9AitJ5sMYYLtFD9MoU8RClFvAcvWafc6njXG5mWi+qlU0gXKsRRdVVr0iGpRtQaLPZOBWcLEcZCvu+wMWMkp7HY48ktzlld3/hNA/yAyH8T1gbYi08r8b9NVZDukQoz2fqAd1y/10aoWpGGcYKKUxOLmG0aqG1s/ov8L3D+sHqPL5DlGJd5EBo16grCYglNzsivSRma2nAooD9qTjozyL6a1Gj378ZUxVLCSvRbbMBCsvV3d3BigsYiVWr4wQpuWhCR3N3DfqWqq6dLpRogD/G/mJ2MaCNMFFWiwgZY1Ny2mmDD3/REF3g9KwrvX0oFAsjtOMnfGaTagjrezt2TEZGjI03skdbx2Vwgs9+YrKZcfN9j11o+VKf7mdf+U6vOtHCBiQAojLX8rt7yhGqscGpEUIPVUnzTzUJQ/3bCoFHPqrd5mfW7NjywWK1OkVyp16X+f7iBhqx2uH0gS+Jy8GukH38p6i393ST6qLlw3M86FisKy60RssgwFaeS5r5VvygFlos0H2djNhDrXoMaJgLJRAa/4UFV2Uw9TiOAQXsd4agk+/rAuk2EJzr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(39860400002)(396003)(376002)(2906002)(6486002)(478600001)(5660300002)(6666004)(186003)(30864003)(83380400001)(4326008)(26005)(86362001)(66946007)(66556008)(316002)(66476007)(8676002)(41300700001)(110136005)(8936002)(9686003)(82960400001)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vBsdSBnG8rMEW/ElA0XVaEp9qg/V61515mm0aoPb+zVafJpax4KNiv3srfq?=
 =?us-ascii?Q?VA7IR2mKEzSSbVHN/S3uTOlOCX9t4Y26VDEkd9/OFiwX4r1r+ui02U1KSuNd?=
 =?us-ascii?Q?Zf9y4yY+fIjwlmrc3JOzycOHluaZ5S/y1qSvc2o45HKsSHij6aY/rxbsD9Jz?=
 =?us-ascii?Q?tBEfsPkpSIlN8RdrEU81orrr5u4Brbo5ZhKxy+JUUiFm/Ef536ykju7f4MNH?=
 =?us-ascii?Q?V0ZVx0YML/rioSpk7MIfd4iJOh6MVpYF+2fJ/MT8hB4L1MXIGEXGYCrc/9r5?=
 =?us-ascii?Q?oKznSyvM4BYuPm4C+VzQ9Hq0SaT+8Gazn1TGj28U4Eesw8JHsR17rCoIWj+d?=
 =?us-ascii?Q?9AxUa3YaRFUUYB+2vXvu4R/YCD8j4CNILGduT+V/Sr61e5uW+RDP7x8nyFjt?=
 =?us-ascii?Q?KB7LtE2aU3kqpOfpaOxHiNXvcyXaSDcRNs520PbatcwFqw/Lc70K43lkC8r9?=
 =?us-ascii?Q?O6fCuVTLci4dBEAJ+Pr4TGTrxioqxPfIimeyV2ZOhg6zSDS/EFKRt6Z2Qg43?=
 =?us-ascii?Q?P83xJCML+pQSKc6h3HphwlVaBZ+CXCY23A/obJoXJtA317iAIirdeC6vldR1?=
 =?us-ascii?Q?XZlP5F5h+pr0htOA6YGC7bVNR/CFflNbCrgozQ8Wya5iJQ/peSuCfD811RZY?=
 =?us-ascii?Q?1Q7irNWtEEIKnzgRd9cS4Fc6Aqw8SMLrPOGVHX2ALw+p1SfvTwUFs281gG9j?=
 =?us-ascii?Q?9vIAvngGxzQFOArM/bhErqd7Mr83D/UkWhLy+OE5L2Y3Or5JcncUxJNFk168?=
 =?us-ascii?Q?H/Rm48IaHupq9JYkpcxUFn0CTfKxjlP1lOj06wqc2OOZnLcKaVsyqjHD/bIm?=
 =?us-ascii?Q?Ocv3y7gikaGY77HQ4nvuAWQrcptMpxTZD7YqMiyn5PfQ1CVXcIk4/6AYPwYC?=
 =?us-ascii?Q?bA4/vliGF5J+2fsCu3713QFUBqesd83uq76hGOOg6y1sNsaYx0WDLPfWeX96?=
 =?us-ascii?Q?FGppwNPSv8M4HCh2/Weq2Sb/ZzgKQqz4bvJshcXOyBXB6CT+eJ1Gh1CTAcbY?=
 =?us-ascii?Q?IhsaTLfofWTQxnw/+rQ3G3XzrJPZ0UCWcXqTkWN4EFhcdtERjhbNfWhT9qNR?=
 =?us-ascii?Q?tGIhRygkSTHbcfzKKdgH/oM/LtCUbKILSx4MsZ9/YTDFamt8DR44fsCc58Cu?=
 =?us-ascii?Q?eG5WLrnFd9aviKoZXd8APXBgqNrIfn+XSxFmG3hnRj4ugcsGgbLEQGQP23sM?=
 =?us-ascii?Q?5m9TgYMRbcWYXg5i13ID7QqesyvhcQ9VbOGMuYds/fzFceIYhKwOkt/S8JOv?=
 =?us-ascii?Q?lU/1lF8RG3h2DoMw8bKW9eCR5+GckF8c9WLN4xHCgYlvKW2RryYz1bZFSgMB?=
 =?us-ascii?Q?HscK/qCacsdhysE7UwcedGrd4wVTtUH/oIJduoTn/rrpSDBgbmpAN8STD5JV?=
 =?us-ascii?Q?GYV1vIpc30uvjwpKzUgImBMKeZXjg2CwE1XKUK0cTOfWTZBoAmpb/8Trpvte?=
 =?us-ascii?Q?vtA47x1jAFxFGRc9v2QRIkotumWMSVw/FnUAWFQ5G2IFK1mnyzuqYYNUQWiB?=
 =?us-ascii?Q?JAa5AbKpoed0mQKUBns40D19WsNhnVTya5qc0c/vElLVisIeEBKlwVBBhLWz?=
 =?us-ascii?Q?NxLKYKgYFdEyzKNhGGu8h1Z7PSEEoF+rkpfrLNBwvlk/rK2C9kVgnRuTbM4W?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eaee42-0c58-4a66-52e2-08da56124076
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 18:49:21.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0/WB3XVIdoq0znyxiFZN5fLBlMTO9MXm9U3vWxCD0ArsSWxRy2G59PP7bgMO/TWGMY4g7EHTONRqEqYCjLhCm49cbg9i7eDnodKxWxPULQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3554
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
> On Thu, 23 Jun 2022 21:19:44 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > CXL regions (interleave sets) are made up of a set of memory devices
> > where each device maps a portion of the interleave with one of its
> > decoders (see CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure).
> > As endpoint decoders are identified by a provisioning tool they can be
> > added to a region provided the region interleave properties are set
> > (way, granularity, HPA) and DPA has been assigned to the decoder.
> > 
> > The attach event triggers several validation checks, for example:
> > - is the DPA sized appropriately for the region
> > - is the decoder reachable via the host-bridges identified by the
> >   region's root decoder
> > - is the device already active in a different region position slot
> > - are there already regions with a higher HPA active on a given port
> >   (per CXL 2.0 8.2.5.12.20 Committing Decoder Programming)
> > 
> > ...and the attach event affords an opportunity to collect data and
> > resources relevant to later programming the target lists in switch
> > decoders, for example:
> > - allocate a decoder at each cxl_port in the decode chain
> > - for a given switch port, how many the region's endpoints are hosted
> >   through the port
> > - how many unique targets (next hops) does a port need to map to reach
> >   those endpoints
> > 
> > The act of reconciling this information and deploying it to the decoder
> > configuration is saved for a follow-on patch.
> Hi Dam,
> n
> Only managed to grab a few mins today to debug that crash.. So I know
> the immediate cause but not yet why we got to that state.
> 
> Test case (happened to be one I had open) is 2x HB, 2x RP on each,
> direct connected type 3s on all ports.

Can you send along the QEMU startup script for this config as well?

> Manual test script is:
> 
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/core/cxl_core.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_acpi.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_port.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_pci.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_mem.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_pmem.ko

Yikes, nothing good ever came insmod, modprobe and automatically module
dependency handling is the way to go.

> 
> cd /sys/bus/cxl/devices/decoder0.0/
> cat create_pmem_region
> echo region0 > create_pmem_region
> 
> cd region0/
> echo 4 > interleave_ways
> echo $((256 << 22)) > size
> echo 6a6b9b22-e0d4-11ec-9d64-0242ac120002 > uuid
> ls -lh /sys/bus/cxl/devices/endpoint?/upo*
> 
> # Then figure out the order hopefully write the correct targets 
> echo decoder5.0 > target0
> 
> Location of crash below...
> No idea if these breadcrumbs will be much use. I'll poke
> it some more next week. Have a good weekend,
> 
> Jonathan
> 
> 
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/core.h   |   7 +
> >  drivers/cxl/core/port.c   |  10 +-
> >  drivers/cxl/core/region.c | 338 +++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxl.h         |  20 +++
> >  drivers/cxl/cxlmem.h      |   5 +
> >  5 files changed, 372 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 36b6bd8dac2b..0e4e5c2d9452 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -42,6 +42,13 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
> >  resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
> >  extern struct rw_semaphore cxl_dpa_rwsem;
> >  
> > +bool is_switch_decoder(struct device *dev);
> > +static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> > +					 struct cxl_memdev *cxlmd)
> > +{
> > +	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
> > +}
> > +
> >  int cxl_memdev_init(void);
> >  void cxl_memdev_exit(void);
> >  void cxl_mbox_init(void);
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 7756409d0a58..fde2a2e103d4 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -447,7 +447,7 @@ bool is_root_decoder(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
> >  
> > -static bool is_switch_decoder(struct device *dev)
> > +bool is_switch_decoder(struct device *dev)
> >  {
> >  	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
> >  }
> > @@ -503,6 +503,7 @@ static void cxl_port_release(struct device *dev)
> >  		cxl_ep_remove(port, ep);
> >  	xa_destroy(&port->endpoints);
> >  	xa_destroy(&port->dports);
> > +	xa_destroy(&port->regions);
> >  	ida_free(&cxl_port_ida, port->id);
> >  	kfree(port);
> >  }
> > @@ -633,6 +634,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  	port->dpa_end = -1;
> >  	xa_init(&port->dports);
> >  	xa_init(&port->endpoints);
> > +	xa_init(&port->regions);
> >  
> >  	device_initialize(dev);
> >  	lockdep_set_class_and_subclass(&dev->mutex, &cxl_port_key, port->depth);
> > @@ -1110,12 +1112,6 @@ static void reap_dports(struct cxl_port *port)
> >  	}
> >  }
> >  
> > -static struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> > -				  struct cxl_memdev *cxlmd)
> > -{
> > -	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
> > -}
> > -
> >  int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
> >  			  struct cxl_dport *parent_dport)
> >  {
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 4830365f3857..65bf84abad57 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -428,6 +428,254 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
> >  	return rc;
> >  }
> >  
> > +static int match_free_decoder(struct device *dev, void *data)
> > +{
> > +	struct cxl_decoder *cxld;
> > +	int *id = data;
> > +
> > +	if (!is_switch_decoder(dev))
> > +		return 0;
> > +
> > +	cxld = to_cxl_decoder(dev);
> > +
> > +	/* enforce ordered allocation */
> > +	if (cxld->id != *id)
> > +		return 0;
> > +
> > +	if (!cxld->region)
> > +		return 1;
> > +
> > +	(*id)++;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> > +						   struct cxl_region *cxlr)
> > +{
> > +	struct device *dev;
> > +	int id = 0;
> > +
> > +	dev = device_find_child(&port->dev, &id, match_free_decoder);
> > +	if (!dev)
> > +		return NULL;
> > +	/*
> > +	 * This decoder is pinned registered as long as the endpoint decoder is
> > +	 * registered, and endpoint decoder unregistration holds the
> > +	 * cxl_region_rwsem over unregister events, so no need to hold on to
> > +	 * this extra reference.
> > +	 */
> > +	put_device(dev);
> > +	return to_cxl_decoder(dev);
> > +}
> > +
> > +static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> > +					       struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_ref *cxl_rr;
> > +
> > +	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
> > +	if (!cxl_rr)
> > +		return NULL;
> > +	cxl_rr->port = port;
> > +	cxl_rr->region = cxlr;
> > +	xa_init(&cxl_rr->endpoints);
> > +	return cxl_rr;
> > +}
> > +
> > +static void free_region_ref(struct cxl_region_ref *cxl_rr)
> > +{
> > +	struct cxl_port *port = cxl_rr->port;
> > +	struct cxl_region *cxlr = cxl_rr->region;
> > +	struct cxl_decoder *cxld = cxl_rr->decoder;
> > +
> > +	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
> > +	if (cxld->region == cxlr) {
> > +		cxld->region = NULL;
> > +		put_device(&cxlr->dev);
> > +	}
> > +
> > +	xa_erase(&port->regions, (unsigned long)cxlr);
> > +	xa_destroy(&cxl_rr->endpoints);
> > +	kfree(cxl_rr);
> > +}
> > +
> > +static int cxl_rr_add(struct cxl_region_ref *cxl_rr)
> > +{
> > +	struct cxl_port *port = cxl_rr->port;
> > +	struct cxl_region *cxlr = cxl_rr->region;
> > +
> > +	return xa_insert(&port->regions, (unsigned long)cxlr, cxl_rr,
> > +			 GFP_KERNEL);
> > +}
> > +
> > +static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
> > +			 struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int rc;
> > +	struct cxl_port *port = cxl_rr->port;
> > +	struct cxl_region *cxlr = cxl_rr->region;
> > +	struct cxl_decoder *cxld = cxl_rr->decoder;
> > +	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
> > +
> > +	rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
> > +			 GFP_KERNEL);
> > +	if (rc)
> > +		return rc;
> > +	cxl_rr->nr_eps++;
> > +
> > +	if (!cxld->region) {
> > +		cxld->region = cxlr;
> > +		get_device(&cxlr->dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_port_attach_region(struct cxl_port *port,
> > +				  struct cxl_region *cxlr,
> > +				  struct cxl_endpoint_decoder *cxled, int pos)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > +	struct cxl_region_ref *cxl_rr = NULL, *iter;
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_decoder *cxld = NULL;
> > +	unsigned long index;
> > +	int rc = -EBUSY;
> > +
> > +	lockdep_assert_held_write(&cxl_region_rwsem);
> > +
> > +	xa_for_each(&port->regions, index, iter) {
> > +		struct cxl_region_params *ip = &iter->region->params;
> > +
> > +		if (iter->region == cxlr)
> > +			cxl_rr = iter;
> > +		if (ip->res->start > p->res->start) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: HPA order violation %s:%pr vs %pr\n",
> > +				dev_name(&port->dev),
> > +				dev_name(&iter->region->dev), ip->res, p->res);
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	if (cxl_rr) {
> > +		struct cxl_ep *ep_iter;
> > +		int found = 0;
> > +
> > +		cxld = cxl_rr->decoder;
> > +		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
> > +			if (ep_iter == ep)
> > +				continue;
> > +			if (ep_iter->next == ep->next) {
> > +				found++;
> > +				break;
> > +			}
> > +		}
> > +
> > +		/*
> > +		 * If this is a new target or if this port is direct connected
> > +		 * to this endpoint then add to the target count.
> > +		 */
> > +		if (!found || !ep->next)
> > +			cxl_rr->nr_targets++;
> > +	} else {
> > +		cxl_rr = alloc_region_ref(port, cxlr);
> > +		if (!cxl_rr) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: failed to allocate region reference\n",
> > +				dev_name(&port->dev));
> > +			return -ENOMEM;
> > +		}
> > +		rc = cxl_rr_add(cxl_rr);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: failed to track region reference\n",
> > +				dev_name(&port->dev));
> > +			kfree(cxl_rr);
> > +			return rc;
> > +		}
> > +	}
> > +
> > +	if (!cxld) {
> > +		if (port == cxled_to_port(cxled))
> > +			cxld = &cxled->cxld;
> > +		else
> > +			cxld = cxl_region_find_decoder(port, cxlr);
> > +		if (!cxld) {
> > +			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> > +				dev_name(&port->dev));
> > +			goto out_erase;
> > +		}
> > +
> > +		if (cxld->region) {
> > +			dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
> > +				dev_name(&port->dev), dev_name(&cxld->dev),
> > +				dev_name(&cxld->region->dev));
> > +			rc = -EBUSY;
> > +			goto out_erase;
> > +		}
> > +
> > +		cxl_rr->decoder = cxld;
> > +	}
> > +
> > +	rc = cxl_rr_ep_add(cxl_rr, cxled);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s: failed to track endpoint %s:%s reference\n",
> > +			dev_name(&port->dev), dev_name(&cxlmd->dev),
> > +			dev_name(&cxld->dev));
> > +		goto out_erase;
> > +	}
> > +
> > +	return 0;
> > +out_erase:
> > +	if (cxl_rr->nr_eps == 0)
> > +		free_region_ref(cxl_rr);
> > +	return rc;
> > +}
> > +
> > +static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
> > +					  struct cxl_region *cxlr)
> > +{
> > +	return xa_load(&port->regions, (unsigned long)cxlr);
> > +}
> > +
> > +static void cxl_port_detach_region(struct cxl_port *port,
> > +				   struct cxl_region *cxlr,
> > +				   struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_region_ref *cxl_rr;
> > +	struct cxl_ep *ep;
> > +
> > +	lockdep_assert_held_write(&cxl_region_rwsem);
> > +
> > +	cxl_rr = cxl_rr_load(port, cxlr);
> > +	if (!cxl_rr)
> > +		return;
> > +
> > +	ep = xa_erase(&cxl_rr->endpoints, (unsigned long)cxled);
> > +	if (ep) {
> > +		struct cxl_ep *ep_iter;
> > +		unsigned long index;
> > +		int found = 0;
> > +
> > +		cxl_rr->nr_eps--;
> > +		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
> > +			if (ep_iter->next == ep->next) {
> > +				found++;
> > +				break;
> > +			}
> > +		}
> > +		if (!found)
> > +			cxl_rr->nr_targets--;
> > +	}
> > +
> > +	if (cxl_rr->nr_eps == 0)
> > +		free_region_ref(cxl_rr);
> > +}
> > +
> >  /*
> >   * - Check that the given endpoint is attached to a host-bridge identified
> >   *   in the root interleave.
> > @@ -435,14 +683,28 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
> >  static int cxl_region_attach(struct cxl_region *cxlr,
> >  			     struct cxl_endpoint_decoder *cxled, int pos)
> >  {
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_port *ep_port, *root_port, *iter;
> >  	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_dport *dport;
> > +	int i, rc = -ENXIO;
> >  
> >  	if (cxled->mode == CXL_DECODER_DEAD) {
> >  		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
> >  		return -ENODEV;
> >  	}
> >  
> > -	if (pos >= p->interleave_ways) {
> > +	/* all full of members, or interleave config not established? */
> > +	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
> > +		dev_dbg(&cxlr->dev, "region already active\n");
> > +		return -EBUSY;
> > +	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
> > +		dev_dbg(&cxlr->dev, "interleave config missing\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (pos < 0 || pos >= p->interleave_ways) {
> >  		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
> >  			p->interleave_ways);
> >  		return -ENXIO;
> > @@ -461,15 +723,83 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -EBUSY;
> >  	}
> >  
> > +	for (i = 0; i < p->interleave_ways; i++) {
> > +		struct cxl_endpoint_decoder *cxled_target;
> > +		struct cxl_memdev *cxlmd_target;
> > +
> > +		cxled_target = p->targets[pos];
> > +		if (!cxled_target)
> > +			continue;
> > +
> > +		cxlmd_target = cxled_to_memdev(cxled_target);
> > +		if (cxlmd_target == cxlmd) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s already specified at position %d via: %s\n",
> > +				dev_name(&cxlmd->dev), pos,
> > +				dev_name(&cxled_target->cxld.dev));
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	ep_port = cxled_to_port(cxled);
> > +	root_port = cxlrd_to_port(cxlrd);
> > +	dport = cxl_dport_load(root_port, ep_port->host_bridge);
> > +	if (!dport) {
> > +		dev_dbg(&cxlr->dev, "%s:%s invalid target for %s\n",
> > +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > +			dev_name(cxlr->dev.parent));
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> > +		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> > +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > +			dev_name(&cxlrd->cxlsd.cxld.dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (cxled->cxld.target_type != cxlr->type) {
> > +		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> > +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > +			cxled->cxld.target_type, cxlr->type);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> 
> At this point cxled->dpa_res is NULL.

Will take a look, thanks.

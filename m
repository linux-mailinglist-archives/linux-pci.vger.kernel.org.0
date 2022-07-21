Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7B57D20E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiGUQ4s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 12:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiGUQ4s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 12:56:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC689A6A;
        Thu, 21 Jul 2022 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658422606; x=1689958606;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H3OnOsx/IT6HQ7ik3HghrJMNdZ15WV1JcN+8SWfytA4=;
  b=VjGKacZ+R0Mc0nQ2yPueaeYvmUdSL+59D1cAD7eSOAmNXNr2yz47Qupb
   x9kxIBXbPTVCq5WXpogMVqS64SyoQJnnkOKg2j5/V6Wcx/k0XeIJSsIFJ
   Aqtt1z9RkwkasMigohuaenYs83VsoRr4ve4Abc0nCu//pt9Mxrx3CJ6bV
   0mKh3F6V/LajQrclWLT6oqG5P2CUK50UMPJB/MvJ1Z8k0NjDmCbq0DLQT
   Egec81maf9Tuni8qou/6BI62eDvx2KN+A286Q92c6PfbeKh7taLx6lls6
   7xuFJ1j15cJ3DeBkP5bYjM+NcOj57zWELpTD20zf68ubIybpYDVbYOTzW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287112243"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="287112243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="656828356"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2022 09:56:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 09:56:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 09:56:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 09:56:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLaSTDe3APUaIbPJemarxWrB21IvdMO7XzrmvRw9MW0oqgJRvIBlJmCRYOGKbyYHnt0C8uweuOEoxChiBp/OB5UqBTx/rDiGXH/R7X5d4WmYVBdFM+Yffr+0wfupwbLgW9flK6DavoApxG2UJ5TAJwTl+dwVrVqHpVnzFGmoDD6RdMoSE3IUrqFPZbeNxanrACK5avsxzuyptvOOt8UL5//56E3yfvQOsluIx+9W7mfKR8BFjMeVX3m8NhSmA68MZuDNMi9zX7Gn6x2TRz+nCJ4PQbhN+39QqfrKvZQ/BMA1AiFWEy3WeeMhZZi457FiYae4fMzONaHLVuqxv8d/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUEOGK1Pb/MKz+8mLQe18+nHKy4yEtbod0B9uY9hjVY=;
 b=Azlcw93hn5zSAi6RLG7k2IzeArrCkPE+etJ+dsAAzv5n3kFLuQxt1UyLqH8Eghw3yHmGtcdLfYXE/ceFm5g8rQXCFNl9dZMpaCe5GitTFPOTxqufen/Hb0fC8rzsyspHUqKNScSnHBPJWJE0fVNtAALBRXXYukvRLICh1Q2tV5LTKIhW1IQobrfqPMkjnrVXR+lsujBjE/9EVoU2kPWWpfGz3esOTdcDVRVHdIPhkBDarSYjUIbA9zsU0M8lT8kbB6/CXDACvJZodjrEfy/PoiQgKtrMtcCgJwETLafxZ+Ue3rNiXwTpeRMfPAiHzwHdktdKRmIKug8PBuEE0TanPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1825.namprd11.prod.outlook.com
 (2603:10b6:404:104::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 16:56:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.019; Thu, 21 Jul
 2022 16:56:38 +0000
Date:   Thu, 21 Jul 2022 09:56:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@lst.de>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 24/28] cxl/region: Program target lists
Message-ID: <62d985442819d_17f3e8294d8@dwillia2-xfh.jf.intel.com.notmuch>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
 <165784337827.1758207.132121746122685208.stgit@dwillia2-xfh.jf.intel.com>
 <20220720184151.00005b85@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220720184151.00005b85@Huawei.com>
X-ClientProxiedBy: BY5PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::48) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f53e1380-5689-4e3c-0ace-08da6b39fa1f
X-MS-TrafficTypeDiagnostic: BN6PR11MB1825:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDEeoaiCGZrCbGp1igvNmz6+eEUXGhHaIklQbRvDpioOMErENlcylBZR0AnGsNz1M2yI04/F68usJ0F81mYcmuWRhZ3MtEcGe48PdESfGehUmQkdV5Pcl19tS4e2SeqZpgZCQbiIr+5EQUd2FjIoLnVcwH+Of7/dvs8iHAIZqslT0Zm3cyTLbHCB36H6mndJrDlE4H7bOLggfX7OjOe6NVcErYHibhruS6NWAIHwvdHBxRJk29qLEDpBbIdcsKgvgjI5qPskNcKhNK/zRgB4PgjKXTDRUWQAOhGUJLhT6LQH7E2gzMD/fHlBkAooRPZgU+xmRJoo/E607bT0Voy0ASsiveGoaRmnIaX+xwmsGOWD0TKHYp49KjfGPR3Gqc84bdcu6e9vnLga1E1rPpIjYfyeX1QwNeN8LKjLLPWg7Ho40h+XMD58j3waWr1vuXycwIQdLghl6X4Fq789obM9NYelyHTiZrQIKKmzREahnOHLzPUcbjVMTTxttE+33NiDSIuw6VWzPQUKeKsrWrI3CKT9wozp5TBvak+/E7WUiAYNM4Bx20YmeR/1efcfOF+pN2VywuYd8VRRt9C9xX+pHUB0rrnYfegw2XXMHRoPLYwOThHkdKdoX9bj4pA34cGpl3Z1IY1F3zRsH1wJ6FDUl3OlbTq6CKLQXTXofrKiDpux0P88oYpFjVjjKuqDBbi2YzZloI5+5Zy/w7YLMP5glFauiRoKzffLda7kTjKT8Bd+d9/XYhQbUDyMxRNbnRzs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(26005)(186003)(86362001)(8936002)(478600001)(8676002)(6506007)(6486002)(38100700002)(2906002)(41300700001)(9686003)(6512007)(5660300002)(66556008)(110136005)(82960400001)(83380400001)(4326008)(66946007)(316002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cuntSRCAd4xpI/oC0oQZuM0u0O6bs0BKB7zo3eTMVOn2w+TBwZGgaFkzjmN1?=
 =?us-ascii?Q?5n5jSJqgMpiISTPxOWDUHKlN1t6pXe7d643KILG9jARpOUhj8EvUAmulesU3?=
 =?us-ascii?Q?b7bknrfoHJiwbJWjPPaGZQl25rJiqyBrKFYs9728+yDoheerAM2YSqx64T7r?=
 =?us-ascii?Q?RsCxl862KSNFPhXPEAwCxz7oL3ooRQkEbkyppfxNqGgNvDBbjektH4zevNZI?=
 =?us-ascii?Q?l5wfuW9EUKq8qj6yHPNP+74CbUYBa8Yuy460Yw9QrB5+bnMM1dVRd5A+vAqg?=
 =?us-ascii?Q?ZxjVlzkKGtRUnXsebhFcqJBtKEt9ARHvI3Jw50cfxe+SP0vOsJoRVOZuSTRa?=
 =?us-ascii?Q?OAIka6nj9eYCl4QT85qsoNR/IfdavCp5zaPXDBcRqavCNNXc2nseJRe+FFvc?=
 =?us-ascii?Q?PeGVyIOb9saICaAoWKQYDEDV2qgXn1xvewyHDUtJ573+2MjGmP0bODqFSm7C?=
 =?us-ascii?Q?/GHdDui55hfpVAnH9mNQxvjT8h+Z3JHpLx3nBWh1trvl69CxWN9IVbLB9D6f?=
 =?us-ascii?Q?86CCSk1SuBOaXDjFYiQOvmbBLdTlQI83PIJMYrf/MSc+v+aqS/sszCJch2oC?=
 =?us-ascii?Q?9k5nKOGB6sN0dIM5CzUPt0b0oJYAJBtRMAs821o4HDs16y/ID5zSQTeoZOSE?=
 =?us-ascii?Q?U/qPCGUQjzBdNeIPUlg66qSfbyBBvyBTN8mlmuuCWSYciSN8O6FO+0ZWb6C2?=
 =?us-ascii?Q?hKktH5SHBPgmu3DYtc/nvNoy0ildOcZUAyr825urOlvvdV0NJOaXJ73+ShNi?=
 =?us-ascii?Q?eY/42HAyUUDIkf56zHkN5VNsWPE4+0MHOc2QbsYEUDTxZx3rXOIHKH68soQA?=
 =?us-ascii?Q?a5HUuxu8oZ0CQZ5QVyrVegPARPm0OF01xEWWilNLpMM8DZTrJe7U6bgv/jyu?=
 =?us-ascii?Q?HUAqxc8kl5aQl4sLtc5wgU062MBAC33ZK26k02xnnZYUHha2xLY8Lexy9nC/?=
 =?us-ascii?Q?2DmfBeXH2WMz5PaTWvuO823J/HD+qlszhR0PwntjDoYjdnjniHQRIVwSKLTB?=
 =?us-ascii?Q?LiyrUlVmaRC/gbFULboF+RzfOPzNMuX1zaAP9r0srohr12UK7h6Jjl3HuxqQ?=
 =?us-ascii?Q?P3VdF3RrModyz0Rr/vq47WNUptXvG+LxkUNWSNHsi7DvxCsEj+KVxgMeeb+C?=
 =?us-ascii?Q?M6LSx+WT1DG3xy/tnozi93GJkA2o2HEozi2cWoHpgCHJjtlVEgK/51YFHiHs?=
 =?us-ascii?Q?FpzC76uesYWaApUW+kbC9XaUevZLa2HCc9IoKWxzU+mt/r1c6zI1Bgu/Kkyc?=
 =?us-ascii?Q?zl3yTxe7SaGYUbfqvN3cOr08I89zr0nzGqIzsTamjmEe8qdSEf3IQ00yeNJY?=
 =?us-ascii?Q?lYB4duc7v9FWEcZrXGITOcYOEHqs+oVhdZemg48Uex4wPxRoFTfUaoy/p8gF?=
 =?us-ascii?Q?iH7+9LviOZUJ3wzzgQHklOnwrOWeDLweoxHu7HzHtZZhjVcKb/U+0zQj+4QQ?=
 =?us-ascii?Q?hiFueE/sS+98tNOPedyC3s9O+FA6VkzMjs6pODDVKWvJpYUefnVitJyWCFwU?=
 =?us-ascii?Q?vWHM+Q6lkiblKbyK/TnPpesxE96g5zuqNuIv0FQs8CMijFIfjRhRoX8kAx+0?=
 =?us-ascii?Q?cgLy0Emy60bd4yVe2F5giUgvX+n1MLwBiChRi3X20X5HGH/0TYrR+2g/ecGy?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f53e1380-5689-4e3c-0ace-08da6b39fa1f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 16:56:38.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0LzNKj61W4duDCKWVVYqOQ1IabBrqx85QXqTitDjVGHinyPtPa1pOvWxFxh7autuLxNacFJHoe1wSsw7ie3OYVBxKWVdIVLnqelmanl9xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 14 Jul 2022 17:02:58 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Once the region's interleave geometry (ways, granularity, size) is
> > established and all the endpoint decoder targets are assigned, the next
> > phase is to program all the intermediate decoders. Specifically, each
> > CXL switch in the path between the endpoint and its CXL host-bridge
> > (including the logical switch internal to the host-bridge) needs to have
> > its decoders programmed and the target list order assigned.
> > 
> > The difficulty in this implementation lies in determining which endpoint
> > decoder ordering combinations are valid. Consider the cxl_test case of 2
> > host bridges, each of those host-bridges attached to 2 switches, and
> > each of those switches attached to 2 endpoints for a potential 8-way
> > interleave. The x2 interleave at the host-bridge level requires that all
> > even numbered endpoint decoder positions be located on the "left" hand
> > side of the topology tree, and the odd numbered positions on the other.
> > The endpoints that are peers on the same switch need to have a position
> > that can be routed with a dedicated address bit per-endpoint. See
> > check_last_peer() for the details.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I'm less confident on this one than most the other patches (and I see I skipped
> reviewing it in v1) as I haven't closely checked the verification logic
> but except for one trivial comment inline it looks fine to me.
> I want to hit the whole series with a wide range of test cases (I'm sure you
> already have) to build that confidence, but won't have time to do that till early
> August. However, if there are gremlins hiding, I'd expect them to be minor.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 8ac0c557f6aa..225340529fc3 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -485,6 +485,7 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> >  		return NULL;
> >  	cxl_rr->port = port;
> >  	cxl_rr->region = cxlr;
> > +	cxl_rr->nr_targets = 1;
> >  	xa_init(&cxl_rr->endpoints);
> >  
> >  	rc = xa_insert(&port->regions, (unsigned long)cxlr, cxl_rr, GFP_KERNEL);
> > @@ -525,10 +526,12 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
> >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> >  	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
> >  
> > -	rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
> > -			 GFP_KERNEL);
> > -	if (rc)
> > -		return rc;
> > +	if (ep) {
> > +		rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
> > +			       GFP_KERNEL);
> > +		if (rc)
> > +			return rc;
> > +	}
> >  	cxl_rr->nr_eps++;
> >  
> >  	if (!cxld->region) {
> > @@ -565,7 +568,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
> >  				  struct cxl_endpoint_decoder *cxled, int pos)
> >  {
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > +	const struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> 
> Why const now and not previously?

Good question.

> Feels like this should be in an earlier patch.  Maybe I'm missing
> something though.

...or just dropped for now, I can not recall a justification at this
point.

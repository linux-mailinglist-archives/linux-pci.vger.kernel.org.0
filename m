Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B37556D329
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 05:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGKDCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 23:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKDCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 23:02:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E00DB4A0;
        Sun, 10 Jul 2022 20:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657508552; x=1689044552;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uzM0c51xaSvN5/gI9Qa+a61HyKbP28jcNonUZ6jeqrE=;
  b=QjzPz4h/4VetcARS5JCwuX6BDd/AwB+EvbztZIEL9+HMVNnq+cvOEIHJ
   3kCJn80Zcs7D7C6E6Tjqz1iOfswhiohS9g/eb0yMeSIVcIZqLdBkss0HL
   wgqC8oBNbmEla6Dpr43uiJiLBidFth+Zce0kCu9OyI/ozihkyCExdeYEj
   12rqxKojSIY4DePLefD29OgtMh809a/gud5VJtgFVMad7WVX3/NKs9ORn
   WfhLopkBFwYcC+pox53xgCGuL7Rda6GFYwUDERGxhzcOmwsggmXlG99gt
   UJxETgSkSD0W8JR2OH6JYkO/ignBLRCIGCBswRxF/otdQqkg9Ccg9e5tO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370874789"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="370874789"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 20:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="921627232"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2022 20:02:29 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 20:02:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 20:02:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 20:02:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 20:02:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmrWSQSEBJsesftGyAnH1D9JHr9qi4a8aXL62mEsVMUUNKspWl8jr2FDBxoQvLIo7aK0QeG2b9Y3cJHNZIkieww0n3Wx4orKr08JQ3kv48Cuzu4iQ/JtbA8W1OgfGYDYKtys+6pYFvRKuFen1/C/eW/KonRi1hHrLTQstXdBeMmRlJNVpHYuRKYJa+COxSDTVXVZ6Vsb/KE3zblwq/mfezsWt+QVrwtGTvudbaJn69w19ptFsD+Dgd0wAxuG5EfJe7WTMv+eAsHXdAVpT8XphOiYbRNqlR5KA2n+8NBhEiB7cMf1Npw4Vop1ctUydQDBTC2KV+td3Px5NFcL6D4zSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV8sPIKNA2u3nQcSZQ2Ff0pnXQZSwuX6ELe6vPxXZkU=;
 b=Iy7AXckc+nR6/SVQO8KdFA9qsUXSIARZTZXGaUaPXZpVvdGrIF/sedQYCNaWhtER1NFZ7/J25VdBqxEqPJCE968dTZfliFiYvXJrpbVKClpNvmoFAGM2k9oIN1+sQpRhnN+fy/G+0aJoRaSFLSSCXFZDZSmwA3d2DMUMBwzy63Jt9BIzytRjvvdlgymAaLyOouATQHHFDqVCR3vFFYw8o1YhWzH3SJu6ts71I5fV93CFpadfXvlS5d0WfW6hGExfjTib1E8eEKLyVwoWJ7SdeUyczVDB4Be6AAbMWoiWL1j3FO2Ij/cONEo62U71kr+dLF2y0Z4cZ691Dt0EPKSxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB6761.namprd11.prod.outlook.com
 (2603:10b6:303:20d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 03:02:22 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Mon, 11 Jul
 2022 03:02:22 +0000
Date:   Sun, 10 Jul 2022 20:02:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 42/46] cxl/hdm: Commit decoder state to hardware
Message-ID: <62cb92bc27397_3535162945b@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-17-dan.j.williams@intel.com>
 <20220630180541.0000259c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630180541.0000259c@Huawei.com>
X-ClientProxiedBy: MWHPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:300:c0::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b353a425-5bb3-4ffe-f976-08da62e9c636
X-MS-TrafficTypeDiagnostic: MW4PR11MB6761:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqVZ3nk3VGjWCuVUf8g7YRXzWgxhUq6RtrxvhfaR6gU+khVDHasDrrp1MMpNKABs+DYqshhAx2vGGzObqR+ZeTutzqs/W3nr5BpBE7Cb/Vz0qfx8yVP6VS6ipDccx4Zsl5eJvyk9sa94Uw6Ce9LBDh4BQeAyxQt4hmHOrvbpPIhDl5xg1fvWPCKWqMv9XaPtYYJLUtCJA8YqHXjM/1Ths4yk55JuhiMUrRv2d0huzbt7cZfggl6WGEggV+BZQ7RNJnGhxC1cC3Fo2Huidtkp1TgEjaeucGpHrUyEINcoijkhbJ3WFwX4Ug/I21taKI6epa7ljZpGs3VdB6XK4rnCi7RrLqR0HauFK9Ae4tbmNtm2w8Lv3gxBO5tGDXcNybzNkHb8ywwPAjmZ/JkInve69zX13vYroyXW89V5+KGayIyqE8a7pYAsjEVvWvP5Q6MneZIBxOPhTIXGAOc9dkg/AeuOqWgWGkawJ//i/e5G1CSCkFcsXyoOkp+8AKWa3TxdB3c3S8F3U3roaLXHG3MIZBgPbqwz7TdlKGBY3HEEBb1Kx2N9ZFv6oZKbqtiEpUQbBjJWtEeXTurYCu8fWEGSptwQANeTCibVfa6X1pokulyVr6Un/u1i536gzE2YkDd2P9d48KEKjDA9ndGUXpTVEE5FdLZoBjH3bkpYxuL7NAIiiS7xY8Et/uCgQVLOX4xQXv6tNXw7abqg6JtQSxrVXB7jZmH51Ypz3Tx4sLD//wjNGvAxBWRrptgFk8ltPFRZEtZZOk+WmvFWlAUMaNfCcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(346002)(136003)(376002)(478600001)(8676002)(86362001)(30864003)(110136005)(41300700001)(2906002)(82960400001)(6486002)(83380400001)(4326008)(66556008)(186003)(66476007)(316002)(66946007)(9686003)(26005)(38100700002)(6512007)(8936002)(6506007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?La+W8HI1V9wewthsBI1uQpS3/3k/Qo9IagjgjVhUqEo6CQqsQAjIHXUO8o3c?=
 =?us-ascii?Q?kYDg2hDozAANJ+ez5yH5ixl43d+qVp+GwmCLhoYkvQOG5IlPceRoRWesfcwu?=
 =?us-ascii?Q?5IxrYo6OC66MX5/Kbbx+nWe34SVmu4XX0fEDnsesiO8p/GTMnirALvLEOoaH?=
 =?us-ascii?Q?gv3u1MNmtJVSgsQyaK/TNHMNBCORO9wF0qHsDVf3d2ZHCHyaYpwoOOIRDdqz?=
 =?us-ascii?Q?WyL84APvEP5+UtkQpQOYCMUHkhuyA6TE1l5u1zvXN3dVk1+umbWTKAeidIXq?=
 =?us-ascii?Q?lRILv/t5PXaLDINNE54z80Yq3vXbhs8bbDaXVtbqVAYzJyz+85bbp7o5vTVv?=
 =?us-ascii?Q?o1kPTgHqgjSb01AgJXvRYvBKgYzFWtfJMYqkBGyrVPH13itPbc6pHSrub8HK?=
 =?us-ascii?Q?A3ShsrKgkz9JZ0wrYkd57YnIDQNkJkMc/fg6Gm43yhtv5XXtEn48CuuNNHO+?=
 =?us-ascii?Q?lMbq+awkEr2Fxs5jFVS+rmPNuTv4LCm7e0+fyavHPvp837lR6ofZic7XI+UB?=
 =?us-ascii?Q?A45gFbq2MdZg7NJdJPNP4awC167HFTOHSqgsPQ5QpRJwRNagfG2ly2pTPzy2?=
 =?us-ascii?Q?30cbYYeZ53JDfZT5Y+hUT7dQg9FK7vT09Koidk5hYcZdfZ9oLddYtxmkc778?=
 =?us-ascii?Q?GIt7yJ3TQm+Rj9c1adosKF/KV53GRQmghLlJkETUHSozHhDXZnTBSi0OvSHf?=
 =?us-ascii?Q?hlMgxRKTyvYc8GjwMz22iK8vmFp73prehcMwDRB+QIh6GS5Aqf6GzescKwc6?=
 =?us-ascii?Q?iRS+ySqcVcz719AwXvfRfH9n+ne//LqeFPrBcnCZli/0YQUJFMDoeTOJaaYz?=
 =?us-ascii?Q?QRllLoWkKWn8SKIxQYLgiGThuMbv5rhrnYx5get/xAjTjq54Xkw7k6ndkfv9?=
 =?us-ascii?Q?zduONx5HA+erLWEQae8y+GkFCOQA15z6MMMgrIUEQZl1h6rEN1sFjI/RUYqL?=
 =?us-ascii?Q?p9g8Tvq9mzcj+0vLGmW++MsXQTbJnzSrlb060BdjUZprEHj7zQxVyDkJVsY7?=
 =?us-ascii?Q?wf24Ee50tyM7XhOPVdImzmu0pSwCsrHXjOiFg45ziMIJdFgyujIb8mkaYnSp?=
 =?us-ascii?Q?VIm+cjdQKETVU9Om80u5QQygyAVrH3kP9rJWbyZn+NMY6ddxR7YyvmOdPwMI?=
 =?us-ascii?Q?UM41gC5XP4aWjJDYq9jOsJmDrJH9EW4Jt10cA7GbOQ+5g09gIwUMSzmZ5zf0?=
 =?us-ascii?Q?L/Jhb4BRM9N8StUs8Z5M6MqL4a+yESQ1QXEXCUqsbilVlyQ682SwhCA5S6Uc?=
 =?us-ascii?Q?sZu3OhuecA/dDeB/SH6MDEGrasFKA+bs257CjPFADmFCHC6bGj0/PLRs+j4l?=
 =?us-ascii?Q?bcD7RKbC+6Bvx4LMgw0bVjpssv6BguuOPNdqYf2x6ZLV9MU+eVdX04UiOQvh?=
 =?us-ascii?Q?Y9y5Vw0Mk/DwPGVs+M6sxj8DQx9gYu5jCkjB3Z4mNpPZFsPD3LH7y0LGpk0E?=
 =?us-ascii?Q?wcZ9NtpWx+vWslb+cE3oW5PzrOseKRsq6aWJOqQh9NRpZ0CMt4pAy0mYh4nv?=
 =?us-ascii?Q?MH4d6nTcOYnuJmeReK44EL3Jt8dTKhrygyR3VAutqzpwMUvcNlkaE7OFHOKU?=
 =?us-ascii?Q?4kvRYeUFIpk79GQ1tWS4h9eIPxiMY2lwdl4j9QMWcUb1GI/wSfCli1SULZgX?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b353a425-5bb3-4ffe-f976-08da62e9c636
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 03:02:22.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uilcMi/x2a8nyKoCQ9ZP9jiTXBHXcD+4klricVL5Yco9sq9WPTN0lP+ExeIQLbeM+ufH7jD4CLiQ24J3MmL2yGTPGN91O2nZC+6Lqsr0XpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6761
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
> On Thu, 23 Jun 2022 21:19:46 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > After all the soft validation of the region has completed, convey the
> > region configuration to hardware while being careful to commit decoders
> > in specification mandated order. In addition to programming the endpoint
> > decoder base-addres, intereleave ways and granularity, the switch
> > decoder target lists are also established.
> > 
> > While the kernel can enforce spec-mandated commit order, it can not
> > enforce spec-mandated reset order. For example, the kernel can't stop
> > someone from removing an endpoint device that is occupying decoderN in a
> > switch decoder where decoderN+1 is also committed. To reset decoderN,
> > decoderN+1 must be torn down first. That "tear down the world"
> > implementation is saved for a follow-on patch.
> > 
> > Callback operations are provided for the 'commit' and 'reset'
> > operations. While those callbacks may prove useful for CXL accelerators
> > (Type-2 devices with memory) the primary motivation is to enable a
> > simple way for cxl_test to intercept those operations.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Trivial comments only in this one.
> 
> Jonathan
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |  16 ++
> >  drivers/cxl/core/hdm.c                  | 218 ++++++++++++++++++++++++
> >  drivers/cxl/core/port.c                 |   1 +
> >  drivers/cxl/core/region.c               | 189 ++++++++++++++++++--
> >  drivers/cxl/cxl.h                       |  11 ++
> >  tools/testing/cxl/test/cxl.c            |  46 +++++
> >  6 files changed, 471 insertions(+), 10 deletions(-)
> > 
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 2ee62dde8b23..72f98f1a782c 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -129,6 +129,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
> >  		return ERR_PTR(-ENXIO);
> >  	}
> >  
> > +	dev_set_drvdata(&port->dev, cxlhdm);
> 
> Trivial, but dev == &port->dev I think so you might as well use dev.

Sure.

> This feels like a bit of a hack as it just so happens nothing else is
> in the port drvdata.  Maybe it's better to add a pointer from
> port to cxlhdm?

It's only valid while the port is attached to the cxl_port driver which
sets it apart from other port data.

> 
> > +
> >  	return cxlhdm;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
> > @@ -444,6 +446,213 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> >  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> >  }
> >  
> 
> > +static int cxl_decoder_commit(struct cxl_decoder *cxld)
> > +{
> > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> > +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> > +	int id = cxld->id, rc;
> > +	u64 base, size;
> > +	u32 ctrl;
> > +
> > +	if (cxld->flags & CXL_DECODER_F_ENABLE)
> > +		return 0;
> > +
> > +	if (port->commit_end + 1 != id) {
> > +		dev_dbg(&port->dev,
> > +			"%s: out of order commit, expected decoder%d.%d\n",
> > +			dev_name(&cxld->dev), port->id, port->commit_end + 1);
> > +		return -EBUSY;
> > +	}
> > +
> > +	down_read(&cxl_dpa_rwsem);
> > +	/* common decoder settings */
> > +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> > +	cxld_set_interleave(cxld, &ctrl);
> > +	cxld_set_type(cxld, &ctrl);
> > +	cxld_set_hpa(cxld, &base, &size);
> > +
> > +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> > +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> > +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> > +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> > +
> > +	if (is_switch_decoder(&cxld->dev)) {
> > +		struct cxl_switch_decoder *cxlsd =
> > +			to_cxl_switch_decoder(&cxld->dev);
> > +		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> > +		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> > +		u64 targets;
> > +
> > +		rc = cxlsd_set_targets(cxlsd, &targets);
> > +		if (rc) {
> > +			dev_dbg(&port->dev, "%s: target configuration error\n",
> > +				dev_name(&cxld->dev));
> > +			goto err;
> > +		}
> > +
> > +		writel(upper_32_bits(targets), tl_hi);
> > +		writel(lower_32_bits(targets), tl_lo);
> > +	} else {
> > +		struct cxl_endpoint_decoder *cxled =
> > +			to_cxl_endpoint_decoder(&cxld->dev);
> > +		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> > +		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> > +
> > +		writel(upper_32_bits(cxled->skip), sk_hi);
> > +		writel(lower_32_bits(cxled->skip), sk_lo);
> > +	}
> > +
> > +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> > +	up_read(&cxl_dpa_rwsem);
> > +
> > +	port->commit_end++;
> 
> Obviously doesn't matter as resetting on error, but
> feels like the increment of commit_end++ should only follow
> succesful commit / await_commit();

Then it would need a special ->reset() flavor to do everything but the
commit_end management. As long as cxl_region_rwsem is held over the
combination, nothing can sneak in and observe the intermediate state.

> > +	rc = cxld_await_commit(hdm, cxld->id);
> > +err:
> > +	if (rc) {
> > +		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
> > +			dev_name(&cxld->dev), rc);
> > +		cxld->reset(cxld);
> > +		return rc;
> > +	}
> > +	cxld->flags |= CXL_DECODER_F_ENABLE;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_decoder_reset(struct cxl_decoder *cxld)
> > +{
> > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> > +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> > +	int id = cxld->id;
> > +	u32 ctrl;
> > +
> > +	if ((cxld->flags & CXL_DECODER_F_ENABLE) ==  0)
> 
> extra space after ==

got it.

> 
> > +		return 0;
> > +
> 
> ...
> 
> 
> >  		
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 7034300e72b2..eee1615d2319 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -630,6 +630,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  	port->component_reg_phys = component_reg_phys;
> >  	ida_init(&port->decoder_ida);
> >  	port->dpa_end = -1;
> > +	port->commit_end = -1;
> >  	xa_init(&port->dports);
> >  	xa_init(&port->endpoints);
> >  	xa_init(&port->regions);
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 071b8cafe2bb..b90160c4f975 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -112,6 +112,168 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RW(uuid);
> 
> ...
> 
> 
> > +static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int i;
> > +
> > +	for (i = count - 1; i >= 0; i--) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +		struct cxl_port *iter = cxled_to_port(cxled);
> > +		struct cxl_ep *ep;
> > +		int rc;
> > +
> > +		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
> > +			iter = to_cxl_port(iter->dev.parent);
> > +
> > +		for (ep = cxl_ep_load(iter, cxlmd); iter;
> > +		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
> > +			struct cxl_region_ref *cxl_rr;
> > +			struct cxl_decoder *cxld;
> > +
> > +			cxl_rr = cxl_rr_load(iter, cxlr);
> > +			cxld = cxl_rr->decoder;
> > +			rc = cxld->reset(cxld);
> > +			if (rc)
> > +				return rc;
> > +		}
> > +
> > +		rc = cxled->cxld.reset(&cxled->cxld);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_region_decode_commit(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int i, rc;
> > +
> > +	for (i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +		struct cxl_region_ref *cxl_rr;
> > +		struct cxl_decoder *cxld;
> > +		struct cxl_port *iter;
> > +		struct cxl_ep *ep;
> > +
> > +		/* commit bottom up */
> > +		for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
> > +		     iter = to_cxl_port(iter->dev.parent)) {
> > +			cxl_rr = cxl_rr_load(iter, cxlr);
> > +			cxld = cxl_rr->decoder;
> > +			rc = cxld->commit(cxld);
> > +			if (rc)
> > +				break;
> > +		}
> > +
> > +		if (is_cxl_root(iter))
> > +			continue;
> > +
> > +		/* teardown top down */
> 
> Comment on why we are tearing down.  I guess because previous
> somehow didn't end up at the root?

Correct, one of those commits in the loop above failed causing it to
break out. Added a comment.

> 
> > +		for (ep = cxl_ep_load(iter, cxlmd); ep && iter;
> > +		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
> > +			cxl_rr = cxl_rr_load(iter, cxlr);
> > +			cxld = cxl_rr->decoder;
> > +			cxld->reset(cxld);
> > +		}
> > +
> > +		cxled->cxld.reset(&cxled->cxld);
> > +		if (i == 0)
> > +			return rc;
> > +		break;
> > +	}
> > +
> > +	if (i >= p->nr_targets)
> > +		return 0;
> > +
> > +	/* undo the targets that were successfully committed */
> > +	cxl_region_decode_reset(cxlr, i);
> > +	return rc;
> > +}
> > +
> > +static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
> > +			    const char *buf, size_t len)
> > +{
> > +	struct cxl_region *cxlr = to_cxl_region(dev);
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	bool commit;
> > +	ssize_t rc;
> > +
> > +	rc = kstrtobool(buf, &commit);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = down_write_killable(&cxl_region_rwsem);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* Already in the requested state? */
> > +	if (commit && p->state >= CXL_CONFIG_COMMIT)
> > +		goto out;
> > +	if (!commit && p->state < CXL_CONFIG_COMMIT)
> > +		goto out;
> > +
> > +	/* Not ready to commit? */
> > +	if (commit && p->state < CXL_CONFIG_ACTIVE) {
> > +		rc = -ENXIO;
> > +		goto out;
> > +	}
> > +
> > +	if (commit)
> > +		rc = cxl_region_decode_commit(cxlr);
> > +	else {
> > +		p->state = CXL_CONFIG_RESET_PENDING;
> > +		up_write(&cxl_region_rwsem);
> > +		device_release_driver(&cxlr->dev);
> > +		down_write(&cxl_region_rwsem);
> > +
> > +		if (p->state == CXL_CONFIG_RESET_PENDING)
> 
> What path results in that changing in last few lines?
> Perhaps a comment if there is something we need to protect against?

The lock needs to be dropped before calling device_release_driver(),
after reacquiring the lock need to revalidate that the reset is still
pending. Added a comment.

> 
> 
> > +			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
> > +	}
> > +
> > +	if (rc)
> > +		goto out;
> > +
> > +	if (commit)
> > +		p->state = CXL_CONFIG_COMMIT;
> > +	else if (p->state == CXL_CONFIG_RESET_PENDING)
> > +		p->state = CXL_CONFIG_ACTIVE;
> > +
> > +out:
> > +	up_write(&cxl_region_rwsem);
> > +
> > +	if (rc)
> > +		return rc;
> > +	return len;
> > +}
> 
> 
> ...
> 
> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index a93d7c4efd1a..fc14f6805f2c 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -54,6 +54,7 @@
> >  #define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> >  #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> >  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> > +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> >  #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
> >  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> >  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> > @@ -257,6 +258,8 @@ enum cxl_decoder_type {
> >   * @target_type: accelerator vs expander (type2 vs type3) selector
> >   * @region: currently assigned region for this decoder
> >   * @flags: memory type capabilities and locking
> > + * @commit: device/decoder-type specific callback to commit settings to hw
> > + * @commit: device/decoder-type specific callback to reset hw settings
> 
> @reset

Yup.

> 
> >  */
> >  struct cxl_decoder {
> >  	struct device dev;
> > @@ -267,6 +270,8 @@ struct cxl_decoder {
> >  	enum cxl_decoder_type target_type;
> >  	struct cxl_region *region;
> >  	unsigned long flags;
> > +	int (*commit)(struct cxl_decoder *cxld);
> > +	int (*reset)(struct cxl_decoder *cxld);
> >  };
> >  
> 
> 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 51d517fa62ee..94653201631c 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -429,6 +429,50 @@ static int map_targets(struct device *dev, void *data)
> >  	return 0;
> >  }
> >  
> 
> ...
> 
> > +static int mock_decoder_reset(struct cxl_decoder *cxld)
> > +{
> > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > +	int id = cxld->id;
> > +
> > +	if ((cxld->flags & CXL_DECODER_F_ENABLE) ==  0)
> 
> bonus space after ==

copy-pasta plus missed clang-format. Fixed.

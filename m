Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1656D00A
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGJQeq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGJQep (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 12:34:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33A7BF68;
        Sun, 10 Jul 2022 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657470883; x=1689006883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cZ/aR8KxO0rHKIltZfBKEyRlaGUtmkRm+moRWvFthwU=;
  b=BEsUyx/fmNhiuxkmT/0pwAAH1y4zvAmjdfE2JVPdpJTPEXaVlYYbhV6x
   OKhdq3UaEon/1uzGvGqOZDv35u9tSFwdcS/heLS/+UHHLbYXyt2CGOd4S
   PJKSlVJT9WLebJR7GDP54yR84QosamDRnqpQ0/oiuDx7rVjDqbhM/Tl26
   ovo2ymQgE0l5SIdXM0PP+xkt3E7wcUdsAh7DzzBZdg5vUhFy1WQrV3VeW
   KJ8QIP0mZGo7l22kgXTxpMjdEBfasiUUdt7sAW8uBmxgWdwaPzbQuAe/0
   xTOYtgkoTuxwPt7zhnGj6hkPksWqs7me4vhIVhm80LY9FtJKAO4MyZzVf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370834954"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="370834954"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 09:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="771286537"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2022 09:34:43 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 09:34:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 09:34:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 09:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTnn9b5yq1cRSpGBmdRYO//grlqSiU1VcFV626tQ02EXVnYpzmMk1uHsAPnfqh42swfpFsEdlgwP3vNZG/pF3l1sWLFXdG9uo10eseTQbF8403pfL33q+jr9M0v3cI3AT2q3vKX+HQFBSeMXgPt9gVhmTF/gRTx6L9ZGcZ5GB+GygXaiupFFCY3pMKUncZ/RQp4DIEsDRI5eK4b2h7yYUsFigbNBiJm6Dt4DXwP8BFcxGaEAmCDFbLxVsQOHLnbXqQtIWBM35OodcxMuWHQ842GnPOyGDHfYhqIdTMFjIG0dNUuoj/mJAiqP3oLLoe7oXWOzvQaMRdRpEDCIf9yVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPTBeflo+9IEYCLnT1lk8pU3D9VP7Cn0G1Y62uAKKnM=;
 b=FJaRJkTcRjvhOUzoN3N7Si4bWP1X0SgFFAbXLF9gR4PCuirq/ce7MseY5LF+9yEs2JBeDso8+cUXwFZ7xSoVBZz4H8X7G8L3yJrBo/NDYi6ZsZUtr2AkCp+x3IUCIBv9QINt4EYYwxxbwFdgxNcUd4aP6PpN0W0z9NfhyKnHfa1e7vUeOeQwAn1C6jKxVj6zfZUlnHXDKtNq3fsWprguVDfgTFlJYejkzLkRmDNKN9a2zx2XS9OKGxHDAOJfEOVV5WkIFxyrS5JqJdcRQug/I4unXzh1uAkc71ejnRAOxOtVCWtjzAGUTLtQOD2jgW8Gx0uLr5DVSTGzlrYzrDrH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB3792.namprd11.prod.outlook.com
 (2603:10b6:208:f7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sun, 10 Jul
 2022 16:34:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 16:34:40 +0000
Date:   Sun, 10 Jul 2022 09:34:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 17/46] cxl/hdm: Track next decoder to allocate
Message-ID: <62caff9dd410f_3177ca294be@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603882752.551046.12620934370518380800.stgit@dwillia2-xfh>
 <20220629163102.000016c4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629163102.000016c4@Huawei.com>
X-ClientProxiedBy: CO2PR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:104:3::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c6ea5a-0e97-4297-78e4-08da629215d5
X-MS-TrafficTypeDiagnostic: MN2PR11MB3792:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfwoXFaRNN1510WLhmyxDmgkl3i6y29UV8K4/aHeHjuw5elbBnsKfWgLd11DKm7cj2GgxdB06BAQQ1yOfSONRJjz9PPJti8x7bBRfDY5Mrr5avSlAVW8HS9U/3JbPFvxmnLSJFX7Fxef/3+4z+AWi/3K1mQBEL7FTSIngUvsVrOKQ8v0sce21wkRwKRBPUXhPvUXMQf2iMriLjroicrY9giAugcP7Rg7BGUL1L7lM9uQ+7OXYrxNtjJzsGJ6N+VqhsieDWotYHrKxWLowTDf6CbjdeI/cdCoM2MpZ/rqxJjAn0MZsuh2tzwxhz4u0oBJ6GR9gyNzjf0VY+lNXYS+ZgG3hiUpUFJyG8kIDF3qI5/BtWZ7hn4u6UIqwZgXpe/0qJA/cune+3dNkMSjrFiDHluzUOfjVLsyceJWzRbqvJ6Xhz0sEHPPBKhH1oqo4nxDx0SxLFFh82tr3vJ7rBVguPfItzgd1wZM6Fw9XeaAUA5DJOhJ+OGxOPR08cLC2K9QjHYF+KmtSc2WoYH2WnjgxxLaC1W2UY+9C6nmX9Oxhmmyvkv0WNa/vQ98drp1z09zf8lyWSagg70qxnC/ZlcSbm2i+ajjdEV6f8P/1rbxPwnU+0B9qMfYsmiBw8ABRx23Po04bUSA3DDEhvkzshdBAmRrtIO4V7eVhsC/ZZpGph/nBKYkWgRmhgIWRGGrKm4Rq2OVEAOaR+/6SNWrEXnxb9OafMakU2isbKXWRa2NJyxN7Pzjjd0P3wOA33njUkN8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(366004)(346002)(396003)(38100700002)(83380400001)(5660300002)(186003)(66476007)(4326008)(66556008)(316002)(8676002)(110136005)(66946007)(82960400001)(86362001)(6506007)(6486002)(8936002)(2906002)(6512007)(9686003)(41300700001)(478600001)(6666004)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wy4edEyh50NtXNs71CmIP+73JS3V1U0+CP6g9y9V8RByRKBe9P/4dsvywgtQ?=
 =?us-ascii?Q?zh7N/nfZVMrZZpl8xanhQPNIf1i+XWK6ILedf0F6gL8UQYSovihn86txurOf?=
 =?us-ascii?Q?fEImyFb7EVWQcz0SZjHfSB9QIuaMiAjw+QjccSCgAKn4uwzIPYoxsPpvOyoe?=
 =?us-ascii?Q?3xe7Tv2YCuTU2PmNB9HTeFaSCNZHAxgqNEpkyL1J4jl1HFLgfRVG6wmpPykR?=
 =?us-ascii?Q?DlHxCeUsUyeyB9JuOEzGAGicBx/OXhMspYilV9bhZv3lKubGozFrOgUiXmBK?=
 =?us-ascii?Q?/LaZAwdNd/MGWAnJughh4jDS3qYLxjom5EWeFSNtlrfYDV1F1CS96YYVBVR5?=
 =?us-ascii?Q?ggt1voVYDOoHq31AWykAel15wplGwDv2DC9PPjN3vBhxPswR0v496tefeGDI?=
 =?us-ascii?Q?uNw4AYCmtUm5EcloWP6L25SHsk0ciP235Ntz4GWH9xWexfj5zygD6lfKL3K6?=
 =?us-ascii?Q?z+kvmPBCVdgVRvENSSijMoqc6LkKXVM+Kt17aTIKOF9vPVUP84N341XkhKJ9?=
 =?us-ascii?Q?G4nkt2Tl6Dzf2FsoxbXXSDCD/3Vxpe3oOZcFr1rr6N7BUX8DiAiQno9FWeFB?=
 =?us-ascii?Q?VnTeI3iY0uye/kwFkSKBrsNudjtttZDxkzitOnoAFOW/B5H47iZTCsxx0vqz?=
 =?us-ascii?Q?UEVLbp27P+0UOpfVqN61Ehckkaz0zwPWm2kaqLF+Bhyadf8YJtkArlamWL7C?=
 =?us-ascii?Q?H5eZ1qmB56SK1VJdWCj4XiXdS/SGj59InC079jN3E5mR02cCelwPAUndEEi3?=
 =?us-ascii?Q?mtw/vXq76CYRB3XDd1C2QnRpySdA5QejrIKosbg1+ogP6p6CygJjKNurc2B7?=
 =?us-ascii?Q?EAeqZX6bQEtuH5YEEhV2LX4LTbnZB6tN5u2mM6oJQTpDMZyIRPLzwW9QSca5?=
 =?us-ascii?Q?ewpGV8Rf0wRp/p/+yWe/5JhA+IniVeGsccDshjlJ6e7yo71yEenpIyUwb+0c?=
 =?us-ascii?Q?5Uc/W7RCMRXVmJXf0PaHZsvFukqc0FgQvGsFkdeEWGOL5w2Hq1tcRShVGQit?=
 =?us-ascii?Q?g6CO3mNYrSYW2gqH4G+8jQk02FB6xvwkRS0lnp7TVD363kLF3Jb4sBfgQfur?=
 =?us-ascii?Q?7lx2CiWZFe/9kVm5vfS/PQKhs0vxEtTdRvl+gN7qmR+JI5M6++I7sj4M50nG?=
 =?us-ascii?Q?+dZSHVvoqNphFoi9GsxCr7SF038Mm5CzE7ROCra7aWrlCDty9D7rxJVGtvQE?=
 =?us-ascii?Q?K41AmxX6jPRtMao+YN1dMbLOATV1z2G084wcAyBtUVI5NVtfd2wI5OlRqwFl?=
 =?us-ascii?Q?GphgEOmP0VRqmQsZ5eWxxodcsiFJP5OY/puLR55KK6MHmQJxRt6+Bl1ejgG9?=
 =?us-ascii?Q?FhgJX8Zvsb+m++2QNELqKmYMlDgdloEX64eg7n1+/yiqT0H4wb4Zrq//PHwH?=
 =?us-ascii?Q?OSCU/4c4aPvD+bBj290NIsqapg/nHBKEmz99kKzLEZZb4Gypeu2Eq43jKyY+?=
 =?us-ascii?Q?wZ0+z7o3fQeMBeM4dykZo6uVcvspJDntoHJYKDEswRvAkBNghNDDbcstJa6c?=
 =?us-ascii?Q?e073Wnw8oUt2SHKKG6n4zFyjdCvHGn+XrSu21xnaRwdIU1p/LCqJwm7/cGb5?=
 =?us-ascii?Q?MECJrlkAtVoO7KZ54OtNx6yGgb96C8ilFkFkQU7MC+oz9wKRh7i0l2t1CT+P?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c6ea5a-0e97-4297-78e4-08da629215d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 16:34:40.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRLahUZIEfGOmRkD9ou4IU9xvy/WL5UuemlyQ7uK5HU+nDcxkITLWifnl3Lgco8Nk+H+ER14BcWMKgWXF7scsmWh25nnR/jB7O8CU4X6KMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3792
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
> On Thu, 23 Jun 2022 19:47:07 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The CXL specification enforces that endpoint decoders are committed in
> > hw instance id order. In preparation for adding dynamic DPA allocation,
> > record the hw instance id in endpoint decoders, and enforce allocations
> > to occur in hw instance id order.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> dpa_end isn't a good name given the value isn't a Device Physical Address.
> 
> Otherwise looks fine,
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/hdm.c  |   14 ++++++++++++++
> >  drivers/cxl/core/port.c |    1 +
> >  drivers/cxl/cxl.h       |    2 ++
> >  3 files changed, 17 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 3f929231b822..8805afe63ebf 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -153,6 +153,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled, bool remove_ac
> >  	cxled->skip = 0;
> >  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> >  	cxled->dpa_res = NULL;
> > +	port->dpa_end--;
> >  }
> >  
> >  static void cxl_dpa_release(void *cxled)
> > @@ -183,6 +184,18 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  		return -EBUSY;
> >  	}
> >  
> > +	if (port->dpa_end + 1 != cxled->cxld.id) {
> > +		/*
> > +		 * Assumes alloc and commit order is always in hardware instance
> > +		 * order per expectations from 8.2.5.12.20 Committing Decoder
> > +		 * Programming that enforce decoder[m] committed before
> > +		 * decoder[m+1] commit start.
> > +		 */
> > +		dev_dbg(dev, "decoder%d.%d: expected decoder%d.%d\n", port->id,
> > +			cxled->cxld.id, port->id, port->dpa_end + 1);
> > +		return -EBUSY;
> > +	}
> > +
> >  	if (skip) {
> >  		res = __request_region(&cxlds->dpa_res, base - skip, skip,
> >  				       dev_name(dev), 0);
> > @@ -213,6 +226,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  			cxled->cxld.id, cxled->dpa_res);
> >  		cxled->mode = CXL_DECODER_MIXED;
> >  	}
> > +	port->dpa_end++;
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 9d632c8c580b..54bf032cbcb7 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -485,6 +485,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  	port->uport = uport;
> >  	port->component_reg_phys = component_reg_phys;
> >  	ida_init(&port->decoder_ida);
> > +	port->dpa_end = -1;
> >  	INIT_LIST_HEAD(&port->dports);
> >  	INIT_LIST_HEAD(&port->endpoints);
> >  
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index aa223166f7ef..d8edbdaa6208 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -326,6 +326,7 @@ struct cxl_nvdimm {
> >   * @dports: cxl_dport instances referenced by decoders
> >   * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
> >   * @decoder_ida: allocator for decoder ids
> > + * @dpa_end: cursor to track highest allocated decoder for allocation ordering
> 
> dpa_end not a good name as this isn't a Device Physical Address.

Ok, renamed it like this:

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 546a022ef17f..22b7fc8ed510 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -333,7 +333,7 @@ struct cxl_nvdimm {
  * @dports: cxl_dport instances referenced by decoders
  * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
  * @decoder_ida: allocator for decoder ids
- * @dpa_end: cursor to track highest allocated decoder for allocation ordering
+ * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
@@ -345,7 +345,7 @@ struct cxl_port {
        struct list_head dports;
        struct list_head endpoints;
        struct ida decoder_ida;
-       int dpa_end;
+       int hdm_end;
        resource_size_t component_reg_phys;
        bool dead;
        unsigned int depth;

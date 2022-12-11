Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D3664950A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Dec 2022 17:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiLKQIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Dec 2022 11:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLKQIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2022 11:08:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8106BF7A;
        Sun, 11 Dec 2022 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670774894; x=1702310894;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LOiD7UMJvrPYzhWQo+BIpi8yAc6fbPlVowYrxMVpq0Q=;
  b=n+lOqOw5sprvvmP0M09xx8F6/7WA3juXSufij/NG+KElAE1nTUQVdDyJ
   sQ68iNRbXdoFNkufjuRUwlE/ofGw8Y0ZY91I7Iu0HWo8/9shZFPFy04Kc
   Z9cMIGiwXLHwThNsHEQIh1rtaFHYI8dqaT6wQVAJmNqO1dbvqU8S9PcoS
   47rHB1sRUlsaa7BlUyattm/vtZCWSv6fKSg7VMHSOlr4m5z+B3wcOEfF/
   7bh+piJbLjk6B9Ezg0I7AgpU/ykENPUtUSMpckXbC/l/rUBafF+pWVvQB
   kPytE2NY0EmQwAxgy1/VN89A/iaHjnTND/tEXW+lLbDmCxtCfqxwqq066
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="379919914"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="379919914"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 08:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="650063845"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="650063845"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2022 08:08:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 08:08:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 11 Dec 2022 08:08:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 11 Dec 2022 08:08:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTO35D3ePp4zgeOTmQIGISzFRmAQs3mGjDcxUGn2aqnHaBUDy0tEBLjyqzAUILe0lW6KCeDG8uDuU/ysNvf42vfjOe1v1Al+06QSAHC3lR1Wy9g1QJZWyOe7+KvO5e3KHsp8Xn4nDdB3Gn7jxAX1u3lCBBGWwqGVagYgRr71Gv/EhZcEHHHGgXvhM2f1NXB4cgf5sD9WDVj+JVL1DyZNSuXfcpsoieQxPjte6O1Rg3dv9D0aa0cWUoDc8wkTmhzl/HDG8j5Jr5PaoPpCX6Ldv9/BcENCEiyzkoysgfNMxArSRgHnYd/ic0h0MWgPVw/oEpcJaOSBUm9lxmH1jItQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxB91JPLClnFptqJrb/sHLW+zc6vbhbFxMbpR7tCYQU=;
 b=EtvSvTYjI+O3fXTmefJ4dx7W3fJoMhcoai300h22jW+rZDhx6EXNK9AmVeOclnnZk1aoIMlhwiY2EzOnjimANI3k+gML475UqvvuxJz7lf33FnfV989QH2SvL5J+LSVBQHiuKY186gf9ywJYE3+09ZHAs68Q+m7TCqWjvnLihyxxbRP0goIsYSrPjK/OBqsZNQsffLCHMHY1wuIdztlUQ7fdRzCpQ+bQePi0G/B1etGnKfywIHL0qFzrKFjBAkdohsdxRMDYtOKaWcFZ3I2d8lv1EKMAfej1T+JU65b707WN1ni+ScDYuDqgSfx8SevOqsDMHpcog/vHOL3vAd/23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 16:08:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 16:08:09 +0000
Date:   Sun, 11 Dec 2022 08:08:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 3/8] cxl/mem: Trace General Media Event Record
Message-ID: <Y5YAZSmO2KXr1CdP@iweiny-mobl>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-4-ira.weiny@intel.com>
 <6393b0e7971ba_579c129446@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6393b0e7971ba_579c129446@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: c67f598b-13cb-4a19-1a6c-08dadb91e582
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCAI7Y13RUolkFlXx/wrwzBeQcTGV1lAI5okgJYerhrxJCgq9/O7J4ykttlobO0Mfx5D/YkOF3Z/SiuE9pCF/M+XS+kqYvVWPFcb68adc9Z5rK12p4XRdF3FUP1IOqdGfUFSmUJfqxtkTLxMdWgH7KWvxRCwerrQ5XrHoarsYOtnKqtetrxqi/yc2WYw3wUGJtr7G35MnAF4fl/TEsg3sK5ZgmMHzKAOT4U79BFpZDA7tidotgSdZZa4g/yKiwCpNQaHspFcgexGig6R/2uOrhR4bPdhf//rwMiqI5mXlcDEJefLJcoKzd2i0i/+PAQ7YKTYdE5BzS/i30IBZnVVeCAJ6fi6dNFJBQrPFdEL1zK9uqOW0culvQ6M0W8CS4bWxtArO/RTGhGkRA6njxMFYoPELqc4c4kRXmaWfVXsmWhMmPWQ8AgohgpO395on6tHVMjGInRotObVlOe/mCvyPCujDVQJZyC/z8iUmnJ9HjpZPoo9Rflxtzc6WCMx9MZqWpO2XqsguIAe2WceF9NMRPr9kY0m7LIsVHjie3waZtirX+q5avmsR983boMbR6PC0ELFWoFZ3C3JHy01FDFUPRpkIr6+EgHgTut4erbXWECDUkqq9bqI9kP95U4//eSQJ/AKIANxhOYrxrDNIZCqgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199015)(86362001)(6486002)(478600001)(54906003)(6636002)(316002)(38100700002)(82960400001)(33716001)(9686003)(186003)(6666004)(6506007)(26005)(6512007)(4326008)(8676002)(44832011)(66946007)(66476007)(66556008)(5660300002)(8936002)(2906002)(6862004)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kM5jRSkD/cP6VxF2TpU7a3FqzlD0cr87UtqiCv1mL9RG+5sfOfcrWW5MeEjn?=
 =?us-ascii?Q?ealls3Igfvx1DxLd8mdCls8YeTW3yIMu5PgbjvlTCp5pRDNJGohSNM7NDO1I?=
 =?us-ascii?Q?vmByijEXN0mZjwpNgd/b0rct/ZHiF0KXJn4e5MaQKOKlONiolZy+y+PgkzbN?=
 =?us-ascii?Q?yMWQApRr80S1Qbc2ImshkuL+FrfIl0zoulfuwxKrwM5EOhpnkSZg5TlqFw5D?=
 =?us-ascii?Q?Urr5b8eIBN2OxQjujzIj2Hj9opTlX37YqKPWzBMFqnaBH31iRYtjlLBHVkHY?=
 =?us-ascii?Q?C109GcQ9tq6pwJ0y4u9sj28wXMLG9pmLLeuBiRZkB7fE8FOEnXQtZ0Nj1b/F?=
 =?us-ascii?Q?L1IVwWGPJ3V6XZK3ZrgYdKui6mdY3uSslHPBP6uWqwipQ0oG0s0JkD9BcmGf?=
 =?us-ascii?Q?kqkDNXxJmSqIS630RTMoqliEmbBsdSVwlwtKEkTsEVjBqW7SSf34CKuQ8hdq?=
 =?us-ascii?Q?FTmqMkj4ceycJvBC0exH16P/zbAREEZNxMVdI0zA0uexI1JrgrR3xqNaN07m?=
 =?us-ascii?Q?hqaQUjh9WOYDAd4uovITKy4v2reXFLvbUrrfLVQlOHYIg6W/uFdxzSyUhalh?=
 =?us-ascii?Q?99H0CKNJBgBgsvmGpPgFHRrbGu3wxIFe8sHH7rIRxrmK/HSTnP7QhZuoHxaM?=
 =?us-ascii?Q?f1Xo9WvRkKBpI7UFXUmrCATc+zspizDFGm/6wDdqtHXPJhIMO1d/v46fpoiR?=
 =?us-ascii?Q?6jBihC0LCTVUzfkWJbzuWYDSwQpnIU+P+bUXMsiyKdJQ80jrcgwciC4fGi5A?=
 =?us-ascii?Q?J5eG/JcKzJ0qphf+31lDO0AJS2VNpDzrtjfvCh7pdrjTfwzYWZsLcO0TNnZv?=
 =?us-ascii?Q?0vbjp4bmVCtIHm3UZl7iiQ+G/Wmg8yuU3Dpzsl5mhWmCgqm4ugjK3hPdQcBN?=
 =?us-ascii?Q?QEr4x2p/EhmBFElOPgN8klKR1WOQrN9hZ4nxky9LRBo8bkn5bB5v73E+IkfD?=
 =?us-ascii?Q?LPVz6ylHe9nUXOqbp0lLDEcI/RoJSrp/W187TgavRF9anYaD3+zIpLqICH+e?=
 =?us-ascii?Q?ndlhsUuHJTm8p/j7I+aSukp9ILshdN1wc7kQzANrj847YOtFx8/XqRlW7mkv?=
 =?us-ascii?Q?d5Pznx6Llm8d3lLzAWueJ/H75kiES7JRxCTT+Ti+aTW65Je5NjPYtt1h+xc2?=
 =?us-ascii?Q?JBEDlvyY2Oya1FYCQzWCIBz1xAwxjQKBQtLjB+/2j/BeTR0GYESh98RrCvG3?=
 =?us-ascii?Q?I/iLibpMiuNZvRAr14vnTEVInfxvIZkDRwJVLrlEWnFK0p8cPH8a5RApl8I7?=
 =?us-ascii?Q?q30T7KJXOmXM9B6nguICTcg/chwNMU8zoUBEsVGxtY9hF15f4FAdgOjBqdFC?=
 =?us-ascii?Q?U+NkWh4rDtqozbPHVfEgdefzyt7JCWRoZAtN1zNAKAEFZ3JA2Y0enidxZuiv?=
 =?us-ascii?Q?U18JtdTJ988FBVBc6Wedbh/yGZ/rZHmb7x12qIP6SwA62sspvA6dt9uYLGuL?=
 =?us-ascii?Q?lQ+j4OqIPwQ4ppaAESz/sg4WQtqQ0JgYop6HLqs2tFgzZuMAz87Nz9Ylj90t?=
 =?us-ascii?Q?WRcwjWFqOT7xbMowfLbS8kBzY1bhfF1XQgCA4FMSvSFPn4p9q6qjrFmF4ddA?=
 =?us-ascii?Q?B3VWNoeubDzfy11EreYrBu+T0PaUOfh9qlO2mSmC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c67f598b-13cb-4a19-1a6c-08dadb91e582
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 16:08:09.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsGANAUJcJ9hZW/o3LKF5kGjrKHoDUeq15CjnStSJ78YmaJavkfVxnxmJrhVSvLv3eWX85vCC85bvFD2hqJmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 02:04:23PM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> > 
> > Determine if the event read is a general media record and if so trace
> > the record as a General Media Event Record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V2:
> > 	Dan
> > 		Remove trace_*_enabled() calls
> > 		Pass struct device to trace points
> > 
> > Changes from V1:
> > 	Jonathan
> > 		fix spec references for CXL rev 3.0
> > 		Make flags all caps
> > 
> > Changes from RFC v2:
> > 	Output DPA flags as a single field
> > 	Ensure names of fields match what TP_print outputs
> > 	Steven
> > 		prefix TRACE_EVENT with 'cxl_'
> > 	Jonathan
> > 		Remove Reserved field
> > 
> > Changes from RFC:
> > 	Add reserved byte array
> > 	Use common CXL event header record macros
> > 	Jonathan
> > 		Use unaligned_le{24,16} for unaligned fields
> > 		Don't use the inverse of phy addr mask
> > 	Dave Jiang
> > 		s/cxl_gen_media_event/general_media
> > 		s/cxl_evt_gen_media/cxl_event_gen_media
> > ---
> >  drivers/cxl/core/mbox.c  |  30 +++++++++-
> >  drivers/cxl/core/trace.h | 124 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h     |  19 ++++++
> >  3 files changed, 171 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 2b25691a9b09..0d8c66f1cdc5 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -718,6 +718,32 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > +/*
> > + * General Media Event Record
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + */
> > +static const uuid_t gen_media_event_uuid =
> > +	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> > +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
> > +
> > +static void cxl_trace_event_record(const struct device *dev,
> > +				   enum cxl_event_log_type type,
> > +				   struct cxl_event_record_raw *record)
> > +{
> > +	uuid_t *id = &record->hdr.id;
> > +
> > +	if (uuid_equal(id, &gen_media_event_uuid)) {
> > +		struct cxl_event_gen_media *rec =
> > +				(struct cxl_event_gen_media *)record;
> > +
> > +		trace_cxl_general_media(dev, type, rec);
> > +		return;
> > +	}
> > +
> > +	/* For unknown record types print just the header */
> > +	trace_cxl_generic_event(dev, type, record);
> > +}
> > +
> >  static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> >  				  enum cxl_event_log_type log,
> >  				  struct cxl_get_event_payload *get_pl)
> > @@ -810,8 +836,8 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> >  			int i;
> >  
> >  			for (i = 0; i < nr_rec; i++)
> > -				trace_cxl_generic_event(cxlds->dev, type,
> > -							&payload->records[i]);
> > +				cxl_trace_event_record(cxlds->dev, type,
> > +						       &payload->records[i]);
> >  
> >  			rc = cxl_clear_event_record(cxlds, type, payload);
> >  			if (rc) {
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 24eef6909f13..82462942590b 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -223,6 +223,130 @@ TRACE_EVENT(cxl_generic_event,
> >  		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> >  );
> >  
> > +/*
> > + * Physical Address field masks
> > + *
> > + * General Media Event Record
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + *
> > + * DRAM Event Record
> > + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> > + */
> > +#define CXL_DPA_FLAGS_MASK			0x3F
> > +#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
> > +
> > +#define CXL_DPA_VOLATILE			BIT(0)
> > +#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
> > +#define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
> > +	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
> > +	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
> > +)
> > +
> > +/*
> > + * General Media Event Record - GMER
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + */
> > +#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
> > +#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
> > +#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
> > +#define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
> > +	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"UNCORRECTABLE_EVENT"	}, \
> > +	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"THRESHOLD_EVENT"	}, \
> > +	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"POISON_LIST_OVERFLOW"	}  \
> > +)
> > +
> > +#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
> > +#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
> > +#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
> > +#define show_mem_event_type(type)	__print_symbolic(type,			\
> > +	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
> > +	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
> > +	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
> > +)
> > +
> > +#define CXL_GMER_TRANS_UNKNOWN				0x00
> > +#define CXL_GMER_TRANS_HOST_READ			0x01
> > +#define CXL_GMER_TRANS_HOST_WRITE			0x02
> > +#define CXL_GMER_TRANS_HOST_SCAN_MEDIA			0x03
> > +#define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
> > +#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
> > +#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
> > +#define show_trans_type(type)	__print_symbolic(type,					\
> > +	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
> > +	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
> > +	{ CXL_GMER_TRANS_HOST_WRITE,			"Host Write" },			\
> > +	{ CXL_GMER_TRANS_HOST_SCAN_MEDIA,		"Host Scan Media" },		\
> > +	{ CXL_GMER_TRANS_HOST_INJECT_POISON,		"Host Inject Poison" },		\
> > +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,		"Internal Media Scrub" },	\
> > +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" }	\
> > +)
> > +
> > +#define CXL_GMER_VALID_CHANNEL				BIT(0)
> > +#define CXL_GMER_VALID_RANK				BIT(1)
> > +#define CXL_GMER_VALID_DEVICE				BIT(2)
> > +#define CXL_GMER_VALID_COMPONENT			BIT(3)
> > +#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
> > +	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
> > +	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
> > +	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
> > +	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
> > +)
> > +
> > +TRACE_EVENT(cxl_general_media,
> > +
> > +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> > +		 struct cxl_event_gen_media *rec),
> > +
> > +	TP_ARGS(dev, log, rec),
> > +
> > +	TP_STRUCT__entry(
> > +		CXL_EVT_TP_entry
> > +		/* General Media */
> > +		__field(u64, dpa)
> > +		__field(u8, descriptor)
> > +		__field(u8, type)
> > +		__field(u8, transaction_type)
> > +		__field(u8, channel)
> > +		__field(u32, device)
> > +		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> > +		__field(u16, validity_flags)
> > +		/* Following are out of order to pack trace record */
> > +		__field(u8, rank)
> > +		__field(u8, dpa_flags)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
> > +
> > +		/* General Media */
> > +		__entry->dpa = le64_to_cpu(rec->phys_addr);
> > +		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
> > +		/* Mask after flags have been parsed */
> > +		__entry->dpa &= CXL_DPA_MASK;
> > +		__entry->descriptor = rec->descriptor;
> > +		__entry->type = rec->type;
> > +		__entry->transaction_type = rec->transaction_type;
> > +		__entry->channel = rec->channel;
> > +		__entry->rank = rec->rank;
> > +		__entry->device = get_unaligned_le24(rec->device);
> > +		memcpy(__entry->comp_id, &rec->component_id,
> > +			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
> > +		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
> > +	),
> > +
> > +	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
> > +		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
> > +		"device=%x comp_id=%s validity_flags='%s'",
> > +		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
> > +		show_event_desc_flags(__entry->descriptor),
> > +		show_mem_event_type(__entry->type),
> > +		show_trans_type(__entry->transaction_type),
> > +		__entry->channel, __entry->rank, __entry->device,
> > +		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> > +		show_valid_flags(__entry->validity_flags)
> > +	)
> > +);
> > +
> >  #endif /* _CXL_EVENTS_H */
> >  
> >  #define TRACE_INCLUDE_FILE trace
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 350cb460e7fc..a5f5d4a380af 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -456,6 +456,25 @@ struct cxl_mbox_clear_event_payload {
> >  		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\
> >  		sizeof(__le16))
> >  
> > +/*
> > + * General Media Event Record
> > + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> > + */
> > +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> > +struct cxl_event_gen_media {
> > +	struct cxl_event_record_hdr hdr;
> > +	__le64 phys_addr;
> > +	u8 descriptor;
> > +	u8 type;
> > +	u8 transaction_type;
> > +	u8 validity_flags[2];
> > +	u8 channel;
> > +	u8 rank;
> > +	u8 device[3];
> > +	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> > +	u8 reserved[0x2e];
> 
> If you reflow this one again to make capitalization of symbols
> consistent in the trace prints perhaps change that to decimal, but
> that's not a blocker.

Done.

> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks!
Ira

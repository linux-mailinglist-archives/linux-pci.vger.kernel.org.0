Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6FA543E99
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiFHV1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 17:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiFHV10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 17:27:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC4F8254;
        Wed,  8 Jun 2022 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654723642; x=1686259642;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=296qNbsCWCJREHoqv1VyzVB89H6mr+0umvjDoM0LOsU=;
  b=hGePXzxiNEA8F/SzDfbIQY45h6ywgBPXfIO7nmEAR43beeJ5Jh+lU9eW
   ZjEYyjE+ysgpnMyiPZ6wUfuTKqM3s8aoIc6EXJaaUS8aMPk+xx/hsxXGq
   huLHvuSFadVBAB2BKrmKzXSXVQSCgOSS9O4oTurDeS1ilITOX82TThMxd
   RBNTJEuPrHFEQelJQe+OJJ6/nT0bTDESgzMhdc3YhMQB8iy8+MNy450q8
   JKLpUNI/4TIZpRUNv6/wmGx6VarOT6DGFv31fyqZsVcIwQtFQRqvLjNYX
   VUsutVBnP/MQyPMHBmNuB05dTLlyJp4wCWek3UVLBC9oTq425LPKZfXu9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="256882223"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="256882223"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 14:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="670789764"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2022 14:27:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 14:27:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 14:27:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 8 Jun 2022 14:27:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 8 Jun 2022 14:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZAfPslxTyBKe91mnNoU/Bcw77m9WkBGHDlqnnbZihDoVNORDQqN1oDPH/OTqDslYwehS9X57oum+ovFjcg42sk+5zMWG23O0mN6rEdz39CS4/2Qughn/iUvaXnQS1BDaLk01eaKcieDnM+Xf1iuU8HsutspbyM826a8KYxRt90/y1YeWgxUpOx4f6UoklY7B3js+lLbqZk4vTWsFuB9HFs41E19SmwvujXvyUitlBCtcSWC0KOUHiQj/4xvIQuYI7LXdzzl8mqYMBr5niWJCYV3Rm96S9R/KsgomTGTI/3JGB9G02CD85/EsgDzRHfJZ+PLNLO0+4KfuXNrJQW20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXffH6px5g3WWPfq+nKUeT+bNwiL8L1Jn8btnLuHymU=;
 b=OpwTnOHWrO6FQeN/TawV4CbeTh1PnQnqEGS/JfuPjIOlalPKSNUPHREWH3a9HIQ0VpEi42lewZuJ93AL9Qq7yd0AOnag2FF2Lv+xI5TRX46UApOn4YK+aLve0Uyce7yCNw+XqyQDnY+fj36YMxZHBy/vXR1EfqAZ4ywaRoXaDYxCBgZtJ9+vI4/zdRX30FRgQatj7rOOK2Jc2xTEEw1MJLk0YSHuk6SO2n0MVx8t9w8HlrRK+UptxIoaVyuocNv+ve+153RJ1Fg3CfaTqbUXqfHqYGyfjaLX1+Ql2We0iwoegOmjvblEGbL/XORls6LNZEmuKIkmawTgdQEKZHphSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR11MB1734.namprd11.prod.outlook.com (2603:10b6:903:125::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 21:27:20 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 21:27:19 +0000
Date:   Wed, 8 Jun 2022 14:27:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V10 6/9] cxl/port: Read CDAT table
Message-ID: <YqESPug9duS6BMfQ@iweiny-desk3>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-7-ira.weiny@intel.com>
 <20220606181541.ysb3zqdpe5cuk4e6@bwidawsk-mobl5>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220606181541.ysb3zqdpe5cuk4e6@bwidawsk-mobl5>
X-ClientProxiedBy: MW4PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:303:87::28) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b89fe9-d54a-48ef-1041-08da4995ab06
X-MS-TrafficTypeDiagnostic: CY4PR11MB1734:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB1734F9553896F30C7F5D8A80F7A49@CY4PR11MB1734.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTwDKEQt1vMkUWvF6kOHjgaRYONq4KkWz3tI7ywyppbW9MHSFMCWntNxG43dzYixzDJ6dZKajPa4oGjTFEKBkSoPLvp5eR0Fdz+W02+E8p1LdJHPIpUV/rEnsCxHXWSekItFXOsxzD9MlQdvmQP8uYC6A3i3AWtBmUM33cuGOArkWpK581Am9yGR5elIXVT1ts3WiFAcWDrkzVzZu/5RkQ6nx3zAQEjh8AhIaTnh6d4O0XOztRbU825TQJWEd52RViK9bsMu047Gr+R6dOlJ6ZbDyIK1iBYN7NaN7RLpDNyZ1LVwiQ9m4bTDr8XJw1VEwwDis/aOe6tDdF9frrdtdXCubwNZ/K1qwZ5nkNTLpgu2pJjZNKOq0h0T5myNwXKWnAiCACJ1N8BmhvYM13QcVbQ0cTyb2DBoZxYs0Lbg24cbGzfNTBaSDM78xd1VZoOp9WqZgin0P2WWhNAK+yOU1tPc7DLM/eiejVJTCkWVcnVDqrvRsRDjyo3PmSflp/+crqULrb3tx6zPOSQhzX1ikjDdkBFOOB5AucHMylk1LeBoUI1kxKtpLu2LLoOBEP0nmUMbSPr1uqiE8UhWwepEv3u4NSHdgK42bg1f0cCOM3GEBAefOeCX00fDAEg6Hx5d0yp5MiWNjhzok0P3Q6vF+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(316002)(8936002)(6486002)(83380400001)(6666004)(6512007)(9686003)(26005)(5660300002)(38100700002)(33716001)(53546011)(54906003)(6506007)(44832011)(186003)(86362001)(82960400001)(66476007)(66556008)(8676002)(4326008)(6916009)(66946007)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y6qiM6mhBUxws/sEsz7oWQY+EiSHHdP0HHWXu/RhlmZLxgjUhZI3Nxlav+qH?=
 =?us-ascii?Q?hRSIaeUbIZpJk2OBsA2fnkD0QNN/DiZ/Zs0z3xUL52EjZ9TsYygf5yOgIbsG?=
 =?us-ascii?Q?pA9FbuQrAcr2omMNPEhuEzuPbMicubvBEQG85WgUx/WN7VARS9hELXbdTOur?=
 =?us-ascii?Q?5Q21f6AtH+h2HX7CRs+rcsa5VzVEJKdtejscgaqdgW5fbj+4W4mB2nmoREmO?=
 =?us-ascii?Q?FMEK5ZHVHgRMSvj/lmusJ/Bm/1ytcwfxi3i7HyIGl6eMXWI6ToQ8vgTItWLL?=
 =?us-ascii?Q?6kBIwzhNc4LBmHfD2cZvvjJHn4hXMuXN5yckJxyPhk4+WWF7SEAHmamTDEDa?=
 =?us-ascii?Q?QZyBlTyGZp/SsEG7AnPij5dQa7HYSrBw1A9DcSexT191njc/FuzBC8slUsOq?=
 =?us-ascii?Q?XsuZFZ72AoFzCAhF7f0J5r9nYN/vSF4CHnm1IQup6ppJbvo1z4ZOZ4tT53SS?=
 =?us-ascii?Q?7bcgY+IQIAm8W8cJAoaqmdWXDa4bYTrKoNx7/ozyLJhxOw26EW/25f6HwXbl?=
 =?us-ascii?Q?TsOfLGDaVC5TmPzHr0p6XcOtjyjnozHQEOQieu96ImEvxIROPtFYFpZCFjPI?=
 =?us-ascii?Q?mtdIB63mD7icyeAYJCMVCZj83PUvGTYXfI1SEArsjSLwN9UVIJ34pkK96hNK?=
 =?us-ascii?Q?z2AE4nJfW/UPWoAp0Vdg2OKLmFiSdRe2e8lg75LzN3N6yKe2+uPDn7n6hRxp?=
 =?us-ascii?Q?sQZQl+rDVEkRiWYIqLwFIhOqgPNzDdiA8S26iCRaodgBMpHEybxXLL6NMEe8?=
 =?us-ascii?Q?cKCPqL/AOWAzuleRwmo4ZSbhXq5ksky43G3okjjA+EIIrVn+K5qBVW/muCet?=
 =?us-ascii?Q?zIZPbvZ5E1FWqEb2V1l/sc8F7bIiDnN87iU3A2b+fpyTrBSnmx0u2q/xxPnp?=
 =?us-ascii?Q?ii8Tj5fnX9utzQeGiV76f80lCwZwqaCFbqowRUzOydSpjBFCCGtQGrBKja7w?=
 =?us-ascii?Q?M74q0mI+X5K8/C09NfhAZPJ8ia4CpWUbYR85twIjYSTDok1ZQe9WNGgViyIB?=
 =?us-ascii?Q?rqljyf+ZYQamz8PiBnToB9jJ9s5dyqX/XPvLCsNsPWUMHjnuGXCKGnwDziYf?=
 =?us-ascii?Q?ZA6QrboDTwDPsJmJzX6anXd3yUznE/c6tqvkm9Dk/5jWQKkc/+HD9USfodTg?=
 =?us-ascii?Q?D+Hd6OSp6bF1qgfrjd9aO9KtMvc6tajPln9lIJt72eywxkEEZby8zrqIXIc1?=
 =?us-ascii?Q?iO5vE57gfZypAyzmWuOE0urJ1c4wgKGLSFqAn0MRWl910kif6clKezaXq01w?=
 =?us-ascii?Q?Xo/C/cAGjGRykByHtXWwndgYPhuQesCkU5kvP/Wg2GsFgXNKhdigMT9UFRtv?=
 =?us-ascii?Q?PEnSZV70ag8J3F+b4P3e7TFhLz7E9fd0+shD95xj4ZdXLUKug82SQXgH+NLo?=
 =?us-ascii?Q?cNY8fQitMEqSSBRCg+hLClt2+egV+vvyVVK09zITvZEiMZTMQaC/1SKWiu2I?=
 =?us-ascii?Q?8ae5upst/+BZaX59IUrLbmKRRnNoHHmRFqT8h//mb+3Q1+VEqGjVHgM4KrGm?=
 =?us-ascii?Q?4lLietDgtmIerS9X1Nj5H2HoKdJhbMHvM4uRCcOqsxmcHd/Xssc49///Y2ud?=
 =?us-ascii?Q?f9rb6ZsIYbRbtqZl11fKgQqD6wruD5KZnm1j3LG5/MXg51Cs+hYqg8hJX1Oh?=
 =?us-ascii?Q?eXlVgEt3hTiSRicyLl+KvRFbLLIs/TxDXrPZAoFjDh+HXKeKKAAx1KbjZHeI?=
 =?us-ascii?Q?Gn1MgpNQgFT195Cu5Nj4Gv2FqPon2QrBod3NmUTPkMQlkX8rZsw/hvZq8Nty?=
 =?us-ascii?Q?+syEo3sXDQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b89fe9-d54a-48ef-1041-08da4995ab06
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 21:27:19.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSQRY28mh1w2yQB78gft7pVzGXbI0reGcqfh0vgW0aKf3mAbrC8lvnMS3OskmBQJEggZUYsZB7fqjEbsImB1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1734
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 06, 2022 at 11:15:41AM -0700, Ben Widawsky wrote:
> On 22-06-04 17:50:46, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 

[snip]

> > +
> > +static int cxl_cdat_get_length(struct cxl_port *port, size_t *length)
> > +{
> > +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> > +	u32 cdat_response_pl[32];
> > +	DECLARE_COMPLETION_ONSTACK(c);
> > +	struct pci_doe_task task = {
> > +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> > +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > +		.request_pl = &cdat_request_pl,
> > +		.request_pl_sz = sizeof(cdat_request_pl),
> > +		.response_pl = cdat_response_pl,
> > +		.response_pl_sz = sizeof(cdat_response_pl),
> > +		.complete = cxl_doe_task_complete,
> > +		.private = &c,
> > +	};
> 
> This is looking like something that could be nicely populated with a macro.

Probably.  But I'll leave that for another day.

> 
> > +	int rc = 0;
> > +
> > +	if (!port->cdat_mb) {
> > +		dev_err(&port->dev, "No CDAT mailbox\n");
> > +		return -EIO;
> > +	}
> 
> AIUI, !port->cdat_mb isn't actually an error.

It was when I was trying to get this to work...  ;-)  I change to dev_dbg().

> Does it make sense to simply
> return 0 here?

No because this is just a helper to the read_cdat below.  0 could be used to
indicate 'no data' but easier to return an obvious error.

> 
> > +
> > +	rc = pci_doe_submit_task(port->cdat_mb, &task);
> > +	if (rc < 0) {
> > +		dev_err(&port->dev, "DOE submit failed: %d", rc);
> > +		return rc;
> > +	}
> > +	wait_for_completion(&c);
> > +
> > +	if (task.rv < 1)
> > +		return -EIO;
> > +
> > +	*length = cdat_response_pl[1];
> > +	dev_dbg(&port->dev, "CDAT length %zu\n", *length);
> > +
> > +	return rc;
> > +}
> > +
> > +static int cxl_cdat_read_table(struct cxl_port *port,
> > +			       struct cxl_cdat *cdat)
> > +{
> > +	size_t length = cdat->length;
> > +	u32 *data = cdat->table;
> > +	int entry_handle = 0;
> > +	int rc = 0;
> > +
> > +	if (!port->cdat_mb) {
> > +		dev_err(&port->dev, "No CDAT mailbox\n");
> > +		return -EIO;
> > +	}
> 
> Similar to above, maybe just return 0?

Same response.  But I'll change the messages to dev_dbg().

> 
> > +
> > +	do {
> > +		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
> > +		u32 cdat_response_pl[32];
> > +		DECLARE_COMPLETION_ONSTACK(c);
> > +		struct pci_doe_task task = {
> > +			.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> > +			.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > +			.request_pl = &cdat_request_pl,
> > +			.request_pl_sz = sizeof(cdat_request_pl),
> > +			.response_pl = cdat_response_pl,
> > +			.response_pl_sz = sizeof(cdat_response_pl),
> > +			.complete = cxl_doe_task_complete,
> > +			.private = &c,
> > +		};
> > +		size_t entry_dw;
> > +		u32 *entry;
> > +
> > +		rc = pci_doe_submit_task(port->cdat_mb, &task);
> > +		if (rc < 0) {
> > +			dev_err(&port->dev, "DOE submit failed: %d", rc);
> > +			return rc;
> > +		}
> > +		wait_for_completion(&c);
> 
> I'd use the timeout variant, but if you don't want to, see below. I can't quite
> tell if pci_doe_submit_task() is guaranteed to end with FLAG_DEAD at some
> point...

Yes it will if it goes south.  The issue with a timeout here is what should
this layer expect for that time?

> 
> > +
> > +		entry = cdat_response_pl + 1;
> > +		entry_dw = task.rv / sizeof(u32);
> > +		/* Skip Header */
> > +		entry_dw -= 1;
> > +		entry_dw = min(length / 4, entry_dw);
> > +		memcpy(data, entry, entry_dw * sizeof(u32));
> > +		length -= entry_dw * sizeof(u32);
> > +		data += entry_dw;
> > +		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);
> 
> [0] looks suspicious...

Actually I have to claim ignorance on this one.  I've carried this from
Jonathan's original patches.  I'm not as worried about the [0] as that is just
the first dword.  But I'm confused as to this entry handle now.

Jonathan?  Help?

> 
> > +
> > +	} while (entry_handle != 0xFFFF);
> > +
> > +	return rc;
> > +}
> > +
> > +void read_cdat_data(struct cxl_port *port)
> 
> I think you need kdoc here, specifically because you've opted not to do a
> timed wait, which means its possible to wait forever.

Sure but we are not going to wait forever due to the DOE spec.  But I'll
document that, sure.

> 
> > +{
> > +	struct device *dev = &port->dev;
> > +	size_t cdat_length;
> > +	int ret;
> > +
> > +	if (cxl_cdat_get_length(port, &cdat_length))
> > +		return;
> > +
> > +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> > +	if (!port->cdat.table) {
> > +		ret = -ENOMEM;
> > +		goto error;
> > +	}
> > +
> > +	port->cdat.length = cdat_length;
> > +	ret = cxl_cdat_read_table(port, &port->cdat);
> > +	if (ret) {
> > +		devm_kfree(dev, port->cdat.table);
> 
> Usually, when I see devm_kfree, it's a sign that it might not be a good
> candidate for devm. You could consider plain kzalloc, and then putting the kfree
> in the port destructor. I don't see anything incorrect though, so it's up to
> you.

I like it this way because we are really only doing this as an error condition.
And it is less error prone to use devm.  Technically devm_kfree() does not even
need to be here except that then we could potentially have a lot of cdat tables
floating around until the port goes away.

I can put in a comment to indicate why this was an anti-pattern.

[snip]

> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index ddbb8b77752e..71009a167a92 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -75,4 +75,5 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >  struct cxl_dev_state;
> >  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> >  void cxl_cache_cdat_mb(struct cxl_port *port);
> > +void read_cdat_data(struct cxl_port *port);
> >  #endif /* __CXL_PCI_H__ */
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 04f3d1fc6e07..fdff20cf79e6 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -50,6 +50,8 @@ static int cxl_port_probe(struct device *dev)
> >  		return PTR_ERR(cxlhdm);
> >  
> >  	cxl_cache_cdat_mb(port);
> > +	/* Cache the data early to ensure is_visible() works */
> > +	read_cdat_data(port);
> >  
> >  	if (is_cxl_endpoint(port)) {
> >  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> > @@ -80,10 +82,58 @@ static int cxl_port_probe(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
> > +			 struct bin_attribute *bin_attr, char *buf,
> > +			 loff_t offset, size_t count)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct cxl_port *port = to_cxl_port(dev);
> > +
> > +	if (!port->cdat.table)
> > +		return 0;
> 
> With visibility setup below, do you need this?

Not currently.  I was envisioning a later dynamic state for cdat.table where on
error this could have been set to NULL.

Ira

[snip]

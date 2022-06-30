Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F88256105E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 06:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiF3EnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 00:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiF3EnG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 00:43:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39FDF;
        Wed, 29 Jun 2022 21:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656564185; x=1688100185;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pjIwi8tgoojHv3ihYCJG519Zt2DeXx/IM5gQKYz0WBc=;
  b=fOWcZKxaAaBueGRFgDFabMWEWZ/Gjd3ETzX6c237I+XtMEFFcVt5UgjA
   wxHvCYpWzKbX5bSAwEXz2OuKqO9tyOk7CflsHVo/8OEsfL+K9wHiVTS4s
   UZi4hBGVHHr86losxJe8bvXveukN0TCUgaDjD4goMPoPtrHaG1UPYzD8i
   WFNq1A8B/lM5BR+q7rVpzlUYVusEpSpxx9jimUqX/QVFPnYyAW8qJHwOa
   hAkaWCDR1IuOzL/YT4e8f7i3zmrjwCbwYrFakKG3lVVQR2RgHL+C6dTw6
   SDkpYEjCDHK408yHohTWWvcJoYVjzFZwZOelze+JBV2zDo7flhk3IsIxj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="271008582"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="271008582"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 21:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="541117425"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2022 21:43:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 21:43:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 21:43:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 29 Jun 2022 21:43:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 29 Jun 2022 21:42:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9SmV7t9uU4Pm8WUBdJXdPgzPQLjsuYSP/db3HsCd7OmvTulFDYS7ucM9vI6Z6hL3epD34o0b1aUdDj/6U9N8B0nxS3sTWLFphvHvGkO//V6qjXB9lT4pWJUtH7caojWqKoYuSrjQJNMD7AQ2AaAR6vIrlKybbQa9/zbaIYAa45/uPXT4BJv5+vHCRFM999ertgiazfVT9vzDcWWck2fmvZWFDYYu9hdhDsEK8a+6ibgq4EmoTDJzVePSyw8tDhn2pkSgwbiVPRCjMr6XKgMRjr7+L/kGnS0sqADOZm9SzANjUnEa2QtQcBh3CZHCEW8Y3e4xE6f3J5m+KwV+WBRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMf54bE0V6/1jeGe3n7uJh5zNlxCwjvfeQAkcSuTOlA=;
 b=LRS9bGW2FxGHYxPPZWoFK8Epa0ND+M2WSyiS7oCV8RsKEFRK5WJhC90niJ7GjCo9+ONlfxDVH4moXrAb/343Txwu/F1DTelQHFQ9UBO+niVESN08o0ZZTQ/lsGRIyLNCoMCRiYqkX+kLS+unKEhOo0OxM8rUJyLh2puti2Ff08Wl2hWBGCFVytU3a777VibjXbxQBcaATlROIDD8R0vFKZyaQo7tOo6Viwj/cYVd4WHmRbIVvgrXsQrxem6qJ05aHUpbcwciqIURntP1wU3HqB5C3M6UyPhp720MwaN5qzkmUMFpYsCHQWYA1vMOUlnR3+grteyx6VfUiGAHMpvvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Thu, 30 Jun 2022 04:42:50 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 04:42:50 +0000
Date:   Wed, 29 Jun 2022 21:42:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 7/9] cxl/port: Introduce cxl_cdat_valid()
Message-ID: <Yr0pwgbJJT7HmtDA@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-8-ira.weiny@intel.com>
 <20220628154942.00002064@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628154942.00002064@Huawei.com>
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e646763e-b4ea-4bda-ff2d-08da5a52fd15
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5770:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0AzPN4Jzh6qp77X888+g94QRdvn2V/Zfr4NpcHjKtuYwxvdd8P7Kg+J87gXo93SRDIj4AKAwpboEHXcrldAlCLZ9TfdvdU1oW6UXifGd2LqOt1cuoXO87ok/bJy3/4y19dDPqBINV7KgXs++mN46bWyyGrXmWSna4ARBjX6QKwIaewlM4FpFbP3jEUifZX9yty2S7UinHvSj4DOz9vsW3qvu4VMwLmLonGiwzpWk9Q2y2KCRAi4QTZRS6trXbJMI27op7TAR+4rUwkFK9tMMRYhdm4U93r8QGJ8Ayl4awxhnqtmWvjyephv0gLVR3xjAU7e8TUMH5ZiMljosm6sl1+007DmhZEQZM6NKY5dUExEQxKsJfB1r4HSTrZf/dnP5U/qpx14bySH6XwxKD2HGH9H9vuW29qL821its0UIYNwYc7Dk20dxkYbjHfVEp4DHw8RA8tBQGYzKyVImp2uwz8QagErvfy85MdFk7uHmhcZ5rDAtpScI+/MqUpxyScFRzcyBtzibmgdPeRIvoA45u9NbnNGtLpdIEB54kKPMMyNRuM9biD7qtwxq7POr5u3CXPe/XR3NcTN9R4V2POV/0nPPzKwNTwPyDf1KJSN5gRngqDcxqlq2epFA2pGNy7PttISJjqiufp7ZIZKbrFaPw8xiGc45hR8QzE2AasMqak71GcaJbUrvKQfBHocfoqLYRLOUtgesR9sq1Eekiyf5mlRej45Yuyp41TXpaxq7oWm20RF2cJq4YEM00Ed6GoxAlPJkxaqqiFzQ9vD/c1V0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(366004)(39860400002)(396003)(346002)(4326008)(38100700002)(8936002)(5660300002)(44832011)(6486002)(86362001)(316002)(2906002)(33716001)(66476007)(478600001)(54906003)(6666004)(6916009)(9686003)(8676002)(6506007)(186003)(82960400001)(66946007)(41300700001)(66556008)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wLgj8KtBlOSUG0+38kezNbqGJMpQpmEcp8AatZb/odxza7YRsoap4bJkYHaU?=
 =?us-ascii?Q?Ry6VHqImdJWW9CQzfolfg3cSL4pxPbo9xS5WDIJaN0MRJKAEz22FPUOslGy+?=
 =?us-ascii?Q?oAhjctv1oioKToRFpCvYAj+8sfPGF+r+1vhpVfgdtX2cPRUj92EESARolKVz?=
 =?us-ascii?Q?biQRGlkoRBbuuY9vh6aN3+EsXgFAi4w7YfpuyWmeFRhzRzk3sxCCSIB+uPeE?=
 =?us-ascii?Q?dpXwhs9QiSDVxOgUHtg60oSrrUgzUJCNbyFTt7so6MZ1PZANtIiquBNy7Kne?=
 =?us-ascii?Q?iSl1zZeNpIc0dab6fpFDYYkDgXckVD2Xm9JOZ7pw78vXcD31Jz7I55ggEkTK?=
 =?us-ascii?Q?x4XlNSN3PCtlx6RARjfY4K+HxyulMl7zVQ/DTPJ9gAodR7zqKh0hnu6J2ehP?=
 =?us-ascii?Q?zm3EJvSHzQXiW7/poSI1wwszoRm9Lxhdu1iiV7IfcB85x2XGH77c25L2P0w7?=
 =?us-ascii?Q?cz7XIVlBPdw+H88HB+48ibj89dlroOd9NeuQ6Q5afneFWpREAOhYDMdwxB5N?=
 =?us-ascii?Q?43SqqTNXsymCd3UNAemSpGVAv++ytXQc8P/qkV9nT7jmx6p6nU2ODQF91mC0?=
 =?us-ascii?Q?Rx2Pgs3XJ8tpqJBcsgJn7U54LGV3m+3JCyOg/jtYm7VepvvYfE+s3uiXrQFH?=
 =?us-ascii?Q?o5Y34btyTeNtA2+azBcoqmrXswH81UpP0bkKV9jX7hCIus79LhGcaYOCdafU?=
 =?us-ascii?Q?CmxivW0Sd3uq9tTgSThRy+Cjvyv7AVlSpYQC7HgQwVPVt8bH9wkn2lOoMeKc?=
 =?us-ascii?Q?qp9XLhTOMhj5V2p7xd57P1hmm2lRzzcZNDgpZosCx373LBw2SHa2iSQH7whs?=
 =?us-ascii?Q?b+LzuMJZqwNG9weTg1GEgWWFhf2bL7N9MtgP4XHN437JD1mGS03lBrGobhMp?=
 =?us-ascii?Q?TbkypBXTVcKs41IXqOnA9FJztWq03pb8PF2kAlI+BYaLiHFEdFhz7l84SlB/?=
 =?us-ascii?Q?piciTcGH69sHCJzHBQ/Sy6wtof29oNLss08KE9jG9eZmujCPZ44te25brjKF?=
 =?us-ascii?Q?zpQPGnAFTMvSAoej+IKVFtgwA9PUOBAftoa9j1PGmrJkfqwuuOsoqkP/xwP/?=
 =?us-ascii?Q?KCDlXdhf6ZIs9EjVfj2rSMBUh/eiVwVC8YrplFuF/mB9D/uE+PIwoAmnp/Tl?=
 =?us-ascii?Q?8doccE72Xgokb1HajM8HSpYdguvgZ1Ec+Jjdh4wyyg6qSbeK1Mbn7BLde/Hj?=
 =?us-ascii?Q?yQ+Yz1vCScXzpFV/P4DxnGCbnq9w1QbSk0XpFjZOtWj3la1r5WDWXERUxAwB?=
 =?us-ascii?Q?SIA5kItwSTIiTYimBQ24vU2dexdgUTAgAwZV/KzbhPSeUog6wgtrvaDCFZy/?=
 =?us-ascii?Q?cJGVpcdbk96nXRPIPDr0jHNfVW+DGPQGorgu3eRpw1gK93co6wRUo4YAzuxM?=
 =?us-ascii?Q?ikCcP55ADDEdZYAPkv1r3iAOmndYsMuD3JOAWvnaC1G0HnyinrPIJ2m6ExuJ?=
 =?us-ascii?Q?7PbffXECqBpX9IH3EMWkdTRxQYD/ycKrh+nPtPMTYPAJ/5SULSB5qPV5KBYn?=
 =?us-ascii?Q?E02+9r055DDLo90SecxKJhgFYvL/z01YuXiM1YWo9OjE6WYsQAW5V/Mm7U7x?=
 =?us-ascii?Q?rpAPT42YJ8sieSE9Aa6X0OmCBZcfISBbQR1//gLKfdUpxIJ3ww/4pkQkgi/u?=
 =?us-ascii?Q?fh5Bzkwwa7XidSKjSlDK5AlzLJALhVfIDqWhCOb3ylo2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e646763e-b4ea-4bda-ff2d-08da5a52fd15
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 04:42:50.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFgvBTcoDOterjuArdbVATIEcr/V17D3PxJJiVpHPNOkYFbjCMsnddiL6FhX9sKJmBy9BGu/LUlRPVRQhwblUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:49:42PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Jun 2022 21:15:25 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The CDAT data is protected by a checksum and should be the proper
> > length.
> > 
> > Introduce cxl_cdat_valid() to validate the data.  While at it check and
> > store the sequence number.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> Minor ordering comment.  With that tidied up
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 4bd479ec0253..6d775cc3dca1 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -532,6 +532,40 @@ static int cxl_cdat_get_length(struct device *dev,
> >  	return rc;
> >  }
> >  
> > +static bool cxl_cdat_valid(struct device *dev, struct cxl_cdat *cdat)
> > +{
> > +	u32 *table = cdat->table;
> > +	u8 *data8 = cdat->table;
> > +	u32 length, seq;
> > +	u8 check;
> > +	int i;
> > +
> > +	length = FIELD_GET(CDAT_HEADER_DW0_LENGTH, table[0]);
> > +	if ((length < CDAT_HEADER_LENGTH_BYTES) || (length > cdat->length)) {
> > +		dev_err(dev, "CDAT Invalid length %u (%zu-%zu)\n", length,
> > +			CDAT_HEADER_LENGTH_BYTES, cdat->length);
> > +		return false;
> > +	}
> > +
> > +	for (check = 0, i = 0; i < length; i++)
> > +		check += data8[i];
> > +
> > +	dev_dbg(dev, "CDAT length %u CS %u\n", length, check);
> > +	if (check != 0) {
> > +		dev_err(dev, "CDAT Invalid checksum %u\n", check);
> > +		return false;
> > +	}
> > +
> > +	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, table[3]);
> > +	/* Store the sequence for now. */
> > +	if (cdat->seq != seq) {
> > +		dev_info(dev, "CDAT seq change %x -> %x\n", cdat->seq, seq);
> > +		cdat->seq = seq;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  static int cxl_cdat_read_table(struct device *dev,
> >  			       struct pci_doe_mb *cdat_mb,
> >  			       struct cxl_cdat *cdat)
> > @@ -579,6 +613,8 @@ static int cxl_cdat_read_table(struct device *dev,
> >  
> >  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
> >  
> > +	if (!rc && !cxl_cdat_valid(dev, cdat))
> > +		return -EIO;
> 
> I'd prefer those handled separately as flow is more readable if error
> handling always out of line.
> 
> 	if (rc)
> 		return rc;

Actually rc is never not 0 here.  :-/

> 
> 	if (!cxl_cdata_valid)
> 		return -EIO;
> 
> 	return 0;

So this is all that is needed.  But the previous patch needs some clean up
to make sense in the series.

Ira

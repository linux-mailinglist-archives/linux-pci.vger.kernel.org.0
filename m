Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8C560FBB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 05:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiF3Dkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3Dki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 23:40:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AACC183B3;
        Wed, 29 Jun 2022 20:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656560437; x=1688096437;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M4kZq5FcB7DP6BJ0p0F18onmB+f1X02DX424RY9eGCg=;
  b=ap7oJ3frv1/5J8rt+o7a75j47EC9uI5lfdEW/5Sa2s+fC3SJ3+0Zft3R
   0ltiqDSY/nyqtuU2w8xt0u4cZwuYqTMbJEUBWO0m6FuG9P/GVAw7IMdaX
   wF29tXMQ4rJsV0VEqLDFLIwd+WU7uhknJkVdtru97B1LAUEQGWRd7B/N6
   6PSocZeoKxVjrhDSGEY/ghsBaD/Dzr+zOX84nu5SqZLEN/sWCcDyEQquj
   ZXiiOxEkTUF0ywhjykJDS05Leih9ZCvrrGX5on5++mPLikaHlIpOOyJQx
   J3vc/5NdsphUliMLFJHUfu9VUxhYbdT8pYsK23qNms6bZke7v6VltedRW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="368545399"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="368545399"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 20:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="680794885"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2022 20:40:37 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 20:40:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 20:40:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 29 Jun 2022 20:40:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 29 Jun 2022 20:40:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ84bYWtHz9948UhuCgVRhchBASI5kTaZk2LZ2/K9cjkYnx+g/f/LU/9hIDforFWSMXsT6UR5CnCVU8l8a8gh3mPFTFT5kJja62tAIsrs5/XQGH9mdn7UK13zWU/b3weXomtk8QHHPckpi0BRpEAFdHdxv5neCI/DcJQmulOqZrRNnF4TXKkYZOjR9j+0Q5xe2ura5ba6tWOszZZTIuKmViEofMp27lPmJZ+D1LFWR6Y8oVn6LBGYd6TWwfya5AfjCbsAK4fxoEpw4MPtqrPTfKbm8/+qZ2gePvxKI8at+MkUq3EEcN9caU7cDXNtkwdh4a811yjV1Ch8ypqL7vVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U2f3DSA3fq2Kc1JxGSkzwNBVOQZVUUBqEr1CeJr5rY=;
 b=Gal+Y+LxccqVVqF4V7KhwSTlZaCR9j9rIzZujn9nqkWwzGuNQdZ/J16WBo7EmCBDC+y4G5PVurV6bQTx8k2ld43/5JKgCmeDC1rfQ05gzJgFAw/V7kj3ooxR4jdGyAf9O6jrEd8YGEpCI1qFEvZsgmcjPF5EF8wMV2pYln0ax2K8p7ZkRE/V//2ewFa0DRiCeHZkzxFylh4mkTm1AWYB12LWZxV2G7cWmAkuO25wPi0eCNBoDZLlAhn0qLkGWGo7L+fJJ5lHHa7Ogatjw+Pp6+vhIO1bO9iQnnKR0E2+8dar1GB4za9vnZJxo5etK2hwaY95RsbQI3KrOSg28gZUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN6PR11MB2002.namprd11.prod.outlook.com (2603:10b6:404:4a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 30 Jun 2022 03:40:34 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 03:40:34 +0000
Date:   Wed, 29 Jun 2022 20:40:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <Yr0bK4RUnreNTy86@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-9-ira.weiny@intel.com>
 <20220628155720.000034cb@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628155720.000034cb@Huawei.com>
X-ClientProxiedBy: BYAPR01CA0017.prod.exchangelabs.com (2603:10b6:a02:80::30)
 To DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd7aef9a-6c37-4b70-dd96-08da5a4a49cb
X-MS-TrafficTypeDiagnostic: BN6PR11MB2002:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ENW7tfS9PgRgz32uYa5FMnk30BO4AD9G75xBYF2RYjWCQRR0BOOGJloqvYHcMtdu0k7v5e5IKugdoNU5cjMbTvNsYn01UhZ0Wr4p/4Wc3cSzxwey8D3exUNEBAGXrNCcjn8Er4C26UtFzmcxK6kKZiG12grHrCey4F++N8bw7nG2RGlCinaeKCK00VwNHMlIiGTicJqQ1N6c8C+HR0KvJzx/4XbpIywPglk8tX8KiqFAo9a5jaYhifJptoB2fQKaRG8yquftR/u9lxbtRFjm6n9vqLBbo/OVBYrKEoL1ZfCK44fQRCuYvb2UdVzVNUwhFHQ9lhPTqmFzdqzkBftfvW1KbrbnMYbr6qR78EeHO+ISmyzNLY3Hv8cjSOhorve1JhfUm6Fidy7/0cbXJ3OGpFZ5o7DYSpeIcRnalRVBN/AosVMv8k4d/1C9+oQYYyR4/PTuwbrZWMDo/OYrGp3ZC4zdGqNHVMmqm2p++2Eow2bT8In1vJJOs7JB8BsrXAcw8Oj4pHK9j6D2isLIi7vzX2gUDXClkmoHG+QMvmkCdcSBLsqDfMU/+ynktY20UustiVC2vHqkOQj5U3XfR4sGVzIc/3lrgCvbmMnmqrSt4Y1YByPyCaAMVcT80DMOmu3SlgkVnWVoXq1798YIHPDhsZ29h9ZNGzfk6Qdsr7sBiGbPm+IUOeN6JzatCGZU0fGqqhT3OoJMmwm3uwvgaZpuj88Ve/1os4kPXi7p1D7Qp5qr36OwTQFBqYNqrLLSSxpmmhKdyrlAK4tQQ6ZyGUB7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(346002)(39860400002)(136003)(366004)(478600001)(6486002)(2906002)(44832011)(6512007)(9686003)(6916009)(316002)(86362001)(8936002)(5660300002)(4326008)(66476007)(66946007)(66556008)(8676002)(186003)(83380400001)(54906003)(38100700002)(6666004)(6506007)(33716001)(82960400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tNF9FzwQGGX9WsQI+Y6CRHUZqDNy8tCPaqoPCmIKKt05xf2qCiVQWzA7rbdO?=
 =?us-ascii?Q?8C6V+OO98VbKLdpp+N99eIr7BCG8Mcj+eg2JEI1s/VHYEqNKm3wPMTh6Rc9m?=
 =?us-ascii?Q?WZP0hos8ONnDD947crBKKhNR8nu+pSnBM9EV0DwJ/CWEJhMcDGJLrj4KbF6z?=
 =?us-ascii?Q?AJc0Aob7Je302yTCsuHJtGMxwu6t8F+08Dd6UGJuWto8qLBKAN23ZqGChcbF?=
 =?us-ascii?Q?vORB3rXoK/Ejb+M0/OKri9z0qlM2LKvWZxZ0JYBW048lEyTIaJ/VeE3hGknk?=
 =?us-ascii?Q?spVloRP/9KwQ/D2H6c9PbHLvNm36lKsVTNfzjIRd0Mil1DU+N+AAiMZtSa+O?=
 =?us-ascii?Q?k4I/g1C9sX/M4eFyy2YVnMQdrNVxZOzDOF18B1sK116jIWR2JshAmZ4Oc3/v?=
 =?us-ascii?Q?jdgkwU5WAQrqC4Uh5UkA/zNX/F4aNzp512f2V/XIQiQ94KW8x8VNmyqeqkfJ?=
 =?us-ascii?Q?LDAKZodBVsU2C0NM6d7SIavsawmqnb50oRqR9xEuLXuUXVCAkCT2qM0EQDog?=
 =?us-ascii?Q?dhtBdYqbT8eyEjiLtM9sN73kAeXgF62Q/A967bDdlwWqZ8EDR7Fsb4500uOb?=
 =?us-ascii?Q?zkIP/74GfNhQBB6YKRd9I3j9zX5hya9QQHtAVidRPy+N+ltS5PSDiHrPk8k/?=
 =?us-ascii?Q?k96CTncB13bT1MmlrNTsftXHjeldxAlKA2CEsnEFVrpI+jxcScgcTwDdvL9I?=
 =?us-ascii?Q?QfuZoFAWrxfnE2D8wTtQ+d0NKYvKeUu1REU5B8xZ2Javbqg0UdOwXrYPXArv?=
 =?us-ascii?Q?/1UDQ1AiWgowFqKk8KZcPlALwmP0+C8uDWnhmVE2wP6ng04MWDpDH37JAOW0?=
 =?us-ascii?Q?O5GddykvhyZ4zIq6E+dkvgbroTuW9sN+I/NGxrMNK20ovevACb3/FufcWNcS?=
 =?us-ascii?Q?0l4pjxoMqgE77VCb2YUnp6SI+SaNY3enbzCaJ42Trnd/EMaiCBQoWpUl0MDy?=
 =?us-ascii?Q?DqQxMS6OY7Cfj8m/oCKnNYkMtLIVxFNuMhPQ4QRXbpqW+laGCIrgpHXNUbYo?=
 =?us-ascii?Q?uaQxF1rnbViiKNYVOWsryYZTe/gnXNXGxFbiloyIlSwbiq3ZVniWPUYCtiFC?=
 =?us-ascii?Q?MDKArVGNUecVc7ZWvtW+ZsPTj9C/XO+X31VkzAax9is7TihIHEmrige0CQs2?=
 =?us-ascii?Q?dP+XZ5rTJ3gVJoBpkNmSH+F+FilE1iU0Tzi4uAmjbWed+u91m/YlqGOdAy6M?=
 =?us-ascii?Q?u1yHTWc0mr1HulXY+OShK+wWdiqNhiFNk3AofwtpiqXrP4JSMEDfYWTub9gB?=
 =?us-ascii?Q?IKHk1qKIiXQkPPuScpk6MGMAuwmR2E7Bz3GCcC8wP6dLIm8BYeig6rbYO+ZJ?=
 =?us-ascii?Q?73dXkUaB09LowGBd+udnmkHIK1dk2qq7haZLbG/RtW4BfgZD8frHSLgTjHqz?=
 =?us-ascii?Q?rfX1Lbr/Zcs4n6+rjyJrsMQtDvb/9FOWFgI9hdmEEYC7WrhTEaNTOY8GDi7b?=
 =?us-ascii?Q?CH/zpsM0A+GGoejUIg8xMsGssicKwcH8wM+4ABy2/51wO3aywy8zel7qknNn?=
 =?us-ascii?Q?X7nmsi0tzDak/LMmUD5iubRNzdFZxFxzhCWil8jEabqp8hECDIzVzNU3+YFY?=
 =?us-ascii?Q?oN92pZU5JediL5a0fGql9TCQcWevMvTkQOTzKI4gWTrhlaEb7tLq+XD/RyBw?=
 =?us-ascii?Q?tszdbtyVCTDJa41Vh4aHIhVp+LX0JvyY9TlYL0a7J/dU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7aef9a-6c37-4b70-dd96-08da5a4a49cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 03:40:33.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6Qz+Mm8fEaJQvUqlBUjCYMm6OeWhaqt8Ihe2bbqpk4KTfFWhs99tRniK/xJ6JnOeccVyzp5aoq8ZQ9Kd5tybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2002
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:57:20PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Jun 2022 21:15:26 -0700
> ira.weiny@intel.com wrote:
> 

[snip]

> >  
> > -/**
> > - * read_cdat_data - Read the CDAT data on this port
> > - * @port: Port to read data from
> > - *
> > - * This call will sleep waiting for responses from the DOE mailbox.
> > - */
> > -void read_cdat_data(struct cxl_port *port)
> > +static int __read_cdat_data(struct cxl_port *port)
> >  {
> >  	static struct pci_doe_mb *cdat_mb;
> >  	struct device *dev = &port->dev;
> >  	struct device *uport = port->uport;
> >  	size_t cdat_length;
> > -	int ret;
> > +	int ret = 0;
> Fairly sure there isn't a path in which ret isn't set...
> 

Yep.

> 
> Mixing ret and rc is a bit inconsistent, maybe scrub patch set for
> one or the other. (My fault originally I think :)

Ok PCI uses both ret and rc.  :-(  But CXL seems to be consistent with rc.  So
I've used rc with the new series which I think satisfies both subsystems.

Thanks again for the detail review of the series.  Hopefully there will be a
new version out tomorrow.
Ira

> 
> 
> >  
> >  	cdat_mb = find_cdat_mb(uport);
> >  	if (!cdat_mb) {
> >  		dev_dbg(dev, "No CDAT mailbox\n");
> > -		return;
> > +		return -EIO;
> >  	}
> >  
> >  	port->cdat_sup = true;
> >  
> >  	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
> >  		dev_dbg(dev, "No CDAT length\n");
> > -		return;
> > +		return -EIO;
> >  	}
> >  
> >  	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> >  	if (!port->cdat.table)
> > -		return;
> > +		return -ENOMEM;
> >  
> >  	port->cdat.length = cdat_length;
> >  	ret = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
> > @@ -658,5 +652,30 @@ void read_cdat_data(struct cxl_port *port)
> >  		port->cdat.length = 0;
> >  		dev_err(dev, "CDAT data read error\n");
> >  	}
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * read_cdat_data - Read the CDAT data on this port
> > + * @port: Port to read data from
> > + *
> > + * This call will sleep waiting for responses from the DOE mailbox.
> > + */
> > +void read_cdat_data(struct cxl_port *port)
> > +{
> > +	int retries = 5;
> > +	int rc;
> > +
> > +	while (retries--) {
> > +		rc = __read_cdat_data(port);
> > +		if (!rc)
> > +			return;
> > +		dev_dbg(&port->dev,
> > +			"CDAT data read error rc=%d (retries %d)\n",
> > +			rc, retries);
> > +	}
> > +	dev_err(&port->dev, "CDAT data read failed after %d retries\n",
> > +		retries);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> 

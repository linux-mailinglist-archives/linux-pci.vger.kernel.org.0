Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75C8553D93
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 23:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355651AbiFUVXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355248AbiFUVXS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 17:23:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8F331DE9;
        Tue, 21 Jun 2022 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655846069; x=1687382069;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+Lbz/7/r89zhmtBEhodW1I8Ne+iUMRr5TzGts3QoHoc=;
  b=ZXKBC3WlIduP9P2602b2GqwbtRP9/TYUb6Bu9P+m+ejm1nc3NziEcuiN
   HFqKRXFnZeMl4IcBbwVTa8ZIFpz/nQSh1WjVXhukFqOdbO+sFHpWLw3+Y
   KqcjxwtRcheoE/7LV9wd5Q59UuNBSN04TFjIkygh1bYIM90PzdAD7G9Bg
   KxRLMuz7TVB+BkiKCvtpkbAB6D5i98s8T1FdW/dW5SiDOGCxRwKd1E7Dh
   bpVvcMu1mUv3+5Qcxa60QOa7+askpKEQfYMvAuaxb3+xpEpPk9FMAGOv0
   kf2xzKalAAjRxagSFC9funIum7jksTjE94ZmL/MTsvkkqqI7P0jlmekFu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260669716"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="260669716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 14:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="730013738"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2022 14:14:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 14:14:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 14:14:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 14:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRhWgZS2rBNPshTljEwffreMGymFr56ZkF/4P1e9LAqBruGE92vtF7Hv9YfaZ6jfrM86LgDgzfCmv/vaWyYQjyAXmK+LPuZjKHNhYUjtKh3bsDS+TyUedXDUCEKb4qYl4THNilZDPTtT4jXlh7Zida16ALXpueFjJ9Jo1AmLKYCcp+kbfA+2miLha67gXFGml+3A5z4lLAQFBsbJheK4wJ0WsOb7Lof7+daCuuhnDTDUwl0ojQR9FTfD3u+m1LbG3d24AwvZOQUbsl7TBeoBZE+7oms7o3aIXg5HERANhfB6xcwErSfDsvTzaulWU+vpxB1XmVLD1xacDnKVzR7gXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i26OD8DWoHiKLrvc/nY2R9Xtjiz10rmXooEF/EYC0t4=;
 b=j1F5CMK/TtYOFpYGA955qUVpAjoqOSOjFFTc58UMa2zWLOTbtO3GJExUoYpwTJMtZRGBmXjkE445aVq8BnagyFlVM8N//lCX3E764iRFm5HIP8jX5Vir2usGBekZuaTPNwM761Y1Wg7rI2cjzzLEQ3uVT1nevLOd6iiZbVelKvm3mv6HFTD76gDlUS6kazOxXlNJ3vjAT88SNdw+TtWvMF3XGYZt+7ErICisw62//awbmb4yMvR2DEJWmdZgsB9GCWF3qx1VitNyvwbopLkVs0mBe5Pq461DH5A+qAf2wqClI/x1IDQlUx6rljCAC531IjOVHVwoUdazdh2vU9Ezzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM4PR11MB6042.namprd11.prod.outlook.com (2603:10b6:8:61::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Tue, 21 Jun 2022 21:14:21 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Tue, 21 Jun 2022
 21:14:21 +0000
Date:   Tue, 21 Jun 2022 14:14:17 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 5/8] cxl/port: Read CDAT table
Message-ID: <YrI0qQrvM7MzKeLy@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-6-ira.weiny@intel.com>
 <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 112a6642-b627-436e-7226-08da53cb02c5
X-MS-TrafficTypeDiagnostic: DM4PR11MB6042:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB6042030BD1E93161F5B8B64FF7B39@DM4PR11MB6042.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQ0VEaNm+3PIcE82EjrAffkrnXI8qqtaKilA+0+FlLNhsbJq7rLOr4MO/NKQZMBuE1n7Y6lSuyKvQmF0QFd3y5RivhD1kxshbJmwbzRzyaI/C+E1ypLuXAg030IjyCVx4tkn0+ycPMxXCwJQz9/jjxHVkJ+ttugHQjAW9UGcZeucTwms+BUeEJildTHqyX+u7o1vq962J2+GIalkLYCETzUhFdP52aj4ZKzXuGOI5ZJ6RIl6/UA8co61bRft3y5pDYtgxiGIY0mGxsB1PLS6MttFBwy3bNpCRm9DdAu+n4WWdbTy87R8NIDX5BuqdhEOMFM85LnRgpu4o7mB09J9WtPb9an3kEsQu1qH0zg4rAv5gV8hfeU2KNHwLuVKoFogMuSN+pZ23vAB9HavwnEJCEK0zzV7EH6o3kPbWKErZLuE8bWYpOwaaCYpoDmC5TS5cg8G3DZp/TByxCc8n4pOhH/PSdYFykYmsOXH8HqPFjdu2DvWkFe/ez7I3qJsdcIPEuhbGdVo2mGS9051Y228MGnr7kdep+8S2Yy3tVING/fBjadYxjFP+DGdFtFi580lQpEgUJs42wEWi+rg5E3TV713uG0HPrbPN6WEcKUPoZ/kuFkrSKJdnEnRh2c5lmcEreQG2EoeaWyEDY3P+ZI+dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(2906002)(4326008)(66946007)(6486002)(38100700002)(6506007)(33716001)(9686003)(54906003)(6512007)(478600001)(66556008)(26005)(86362001)(6636002)(83380400001)(186003)(41300700001)(82960400001)(44832011)(66476007)(6862004)(8676002)(316002)(6666004)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PEMsxQEVtZqUfw3U3/O7d21jLU6hQUj0bI2X/hJBnY08PGPr7esbnEGe06pv?=
 =?us-ascii?Q?zPHo9OpDi0Dkht1bUf8/7guBrlcK/pUoYOGzE0fes6jsSjjQXhjiVmdkurNL?=
 =?us-ascii?Q?npkPIiSrADF5CkVfd2tkwR04OhN/kt8DVG+f6Zlog8yEpvEYf2HhRC9T1atY?=
 =?us-ascii?Q?k9pXDzpm0hOnuf9uYpFo88zXNVLREZB/orRr6I61pQq6q1qrnzxNMX8mn8YS?=
 =?us-ascii?Q?lEx7ISSxxoJlLavd41znOvnm3l/i2KHnGy+e0B+YJvNTjnsOft9R4erjesL/?=
 =?us-ascii?Q?2FH/G31gVWMoAP/24j7beMdK+KmLvEL1t1rCS1y4JTLE66sV/GHbRVpmFigQ?=
 =?us-ascii?Q?oahLjMzvmLRzLP6ev9tJhi/CEj/SZ8li8wMelpniLkP9dtVGWIHxt64LiTJ2?=
 =?us-ascii?Q?Y+C0/K2T+4Tn+l+dNkAFE9v0kMMnceT8DkhQyPBwolYsMSBikmGQC7v5AS6V?=
 =?us-ascii?Q?5zkurqoaolJviJzPuPDKiBTMk19l6usScDM3lkEcNxRpe7bE7iF6G89/UuiV?=
 =?us-ascii?Q?3g1d3u0fi3hKz2TPUBrvEzGw1stnkp0G0lIEdeNqNBQccMgRiApeyOsRKNSa?=
 =?us-ascii?Q?urauknjFXyLoN30rpO+KXSMul+mek9JQUyMp3yZ2YJiPXEyJK8/mhuVSFTCH?=
 =?us-ascii?Q?SlVSqmRoitstaLUsLA8n+LS7Lvz8UQa/hm9j7XKqsYDYrb0YqVVO1EDOjREy?=
 =?us-ascii?Q?//m/ZnjKsEueWNqh/V1ZCbPlnGI8155xv/wND1TYUhgp4REOCNi2kIZpzKqk?=
 =?us-ascii?Q?GazRDTRHX3d49X7EsZae+9E/tPdeBnpvD/gXCxlchrW/x11qE9x7KEM/S3sB?=
 =?us-ascii?Q?bOw828m18fgDwsOnk4aTROtRdezxPHF6gobPkqz34oaHNW8fw2qBy+UTHQwY?=
 =?us-ascii?Q?Hn+OjvAU787W6X6BhbKZ7/CnXMb22BrJmFpO2kjbe6GiMvsnFjgnpgvcj4bo?=
 =?us-ascii?Q?/MbqNfeC0RfMMZhCBQLHVtpsmWBSZG3Rw+dUgt8O7Cc9WimI+5y7lBzrUUhQ?=
 =?us-ascii?Q?sN5uqCFKYC0s2sO5acDuhP1+3+6ecy33fqWmDuTzctsk/CzgRFa2vItYh9so?=
 =?us-ascii?Q?gwoVKo8bDtwshQzair+rvefIgSAS3o/TXDJyGg3By+7YbOfkAI8QpuRhf8JZ?=
 =?us-ascii?Q?x51dmKqjOOMJ1JNHhfBuEOq91uSI+DOP4bWGVxDIzU3+Vb7egoKasZKLzJSp?=
 =?us-ascii?Q?pw0+oyM+Wx7VVVwLZA9oZ5GXgIRHatnfP1Caaoxou+1mTzpKjFf4YwThAbdK?=
 =?us-ascii?Q?ksFNZZ55bxhyWYYNzxyfxEkAzAia3z0A3aw78mpEhBD4twjkYFN7uXg6yfEj?=
 =?us-ascii?Q?4deMymaFQpWWZxv3U7nd2oO+M0qFZ+n42/jIJtc3PlS9l0w/NYvWKv5WrHBL?=
 =?us-ascii?Q?cjw3z9SmjDLzdyNG7zaWfdtCzWnQ5Z3DCzF4S/1ytPf88eAAuc9A0SmXcL1v?=
 =?us-ascii?Q?B8Zi16HS0vnJsSit3ECIVDUCQVEopVJgjuOND/Uq+8ZgFHcFo8FtS3lHvxfu?=
 =?us-ascii?Q?AmJWISO4yFUzsTjLRH5JmhnAojnW2tYO4Hx3EgrBHgiMhXch1o6JhFUHuGut?=
 =?us-ascii?Q?fWhX+dS7s9hT6i4UhcNQVP0TZZGaf8FzbKQy19L/vo34ymnsGOmkNVRYd9ZJ?=
 =?us-ascii?Q?AGg/asSpVb4ju9IuHhwEbqkQESuZ68Xq/Ta5XJSp+v9r6tvBsabnGz8dFY1C?=
 =?us-ascii?Q?NJzC7Bpg5tnVBLkDcbZzPFyYa1eVo18aV20C9lxhaZFH3kABRpI+ObxthFCL?=
 =?us-ascii?Q?BIn4V3l+9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 112a6642-b627-436e-7226-08da53cb02c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 21:14:21.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7qH3VqYsNzfZxNqTk42HZfGDCEhz+jiu2fB4d6eF4aWsJgdY8hjdWlAfFf8lPGJKB78VxpJuwzeHc7wJ47dxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6042
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

On Fri, Jun 17, 2022 at 05:43:34PM -0700, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> > +
> > +/**
> > + * read_cdat_data - Read the CDAT data on this port
> > + * @port: Port to read data from
> > + *
> > + * This call will sleep waiting for responses from the DOE mailbox.
> > + */
> > +void read_cdat_data(struct cxl_port *port)
> > +{
> > +	static struct pci_doe_mb *cdat_mb;
> > +	struct device *dev = &port->dev;
> > +	struct device *uport = port->uport;
> > +	size_t cdat_length;
> > +	int ret;
> > +
> > +	/*
> > +	 * Ensure a reference on the underlying uport device which has the
> > +	 * mailboxes in it
> > +	 */
> > +	get_device(uport);
> 
> I had written up a long description grumbling about "just in case"
> acquistions of device references, but then I lost that draft.
> 
> So I'll do the shorter response, but give you more homework in the
> process. How / Why is that get_device() needed? What are the guarantees that
> ensure you that the last reference has not been dropped just before that
> call? Hint: what context is this code running?

I'll check it out.  I suspect there is some reference on uport already taken
such that if port is valid uport must be valid.

> 
> > +
> > +	cdat_mb = find_cdat_mb(uport);
> > +	if (!cdat_mb) {
> > +		dev_dbg(dev, "No CDAT mailbox\n");
> > +		goto out;
> > +	}
> > +
> > +	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
> > +		dev_dbg(dev, "No CDAT length\n");
> > +		goto out;
> > +	}
> > +
> > +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> > +	if (!port->cdat.table)
> > +		goto out;
> > +
> > +	port->cdat.length = cdat_length;
> > +	ret = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
> > +	if (ret) {
> > +		/* Don't leave table data allocated on error */
> > +		devm_kfree(dev, port->cdat.table);
> > +		port->cdat.table = NULL;
> > +		port->cdat.length = 0;
> > +		dev_err(dev, "CDAT data read error\n");
> 
> Rather than a chatty / ephemeral error message I think this wants some
> indication in userspace, likely the 0-length CDAT binary attribute, so
> that userspace can debug why the kernel is picking sub-optimal QTG ids
> for newly provisioned CXL regions.

I thought we agreed that 0-length or CDAT query failure would result in no
sysfs entry?

This message was to alert that a CDAT query was attempted but the read failed
vs finding no mailbox with CDAT capabilities for example.

[snip]

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
> > +
> > +	return memory_read_from_buffer(buf, count, &offset,
> > +				       port->cdat.table,
> > +				       port->cdat.length);
> > +}
> > +
> > +static BIN_ATTR_RO(cdat, 0);
> 
> This should be BIN_ATTR_ADMIN_RO(), see:
> 
> 3022c6a1b4b7 driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}

Are you suggesting I add BIN_ATTR_ADMIN_* macros?

> 
> > +
> > +static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> > +					      struct bin_attribute *attr, int i)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct cxl_port *port = to_cxl_port(dev);
> > +
> > +	if ((attr == &bin_attr_cdat) && port->cdat.table)
> > +		return 0400;
> 
> Per above change you only need to manage visibility and not permissions,

But the permissions indicate visibility (In the kdoc for struct
attribute_group).


 *              ...  Must
 *              return 0 if a binary attribute is not visible. The returned
 *              value will replace static permissions defined in
 *              struct bin_attribute.

And the value returned overrides the mode.

fs/sysfs/group.c:

create_files()

 82                         if (grp->is_bin_visible) {
 83                                 mode = grp->is_bin_visible(kobj, *bin_attr, i);
 84                                 if (!mode)
 85                                         continue;
 86                         }
 87 
 88                         WARN(mode & ~(SYSFS_PREALLOC | 0664),
 89                              "Attribute %s: Invalid permissions 0%o\n",
 90                              (*bin_attr)->attr.name, mode);
 91 
 92                         mode &= SYSFS_PREALLOC | 0664;


So I'm willing to add the macro but I'm not sure it is going to change anything
in this case.  I think to make those _ADMIN_ macros work with is_visible()
create_files() needs to be changed.  :-/  I'm not sure if the addition of
DEVICE_ATTR_ADMIN_{RO,RW} intended for is_visible() to be able to override the
mode?

> also per the comment about the error message in the CDAT table read case
> I think it makes sense to show an empty attribute. Only if the device
> does not claim to have a CDAT should the attribute not be visible.

Ok I can do that.

Thanks for the review,
Ira

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static struct bin_attribute *cxl_cdat_bin_attributes[] = {
> > +	&bin_attr_cdat,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group cxl_cdat_attribute_group = {
> > +	.name = "CDAT",
> > +	.bin_attrs = cxl_cdat_bin_attributes,
> > +	.is_bin_visible = cxl_port_bin_attr_is_visible,
> > +};
> > +
> > +static const struct attribute_group *cxl_port_attribute_groups[] = {
> > +	&cxl_cdat_attribute_group,
> > +	NULL,
> > +};
> > +
> >  static struct cxl_driver cxl_port_driver = {
> >  	.name = "cxl_port",
> >  	.probe = cxl_port_probe,
> >  	.id = CXL_DEVICE_PORT,
> > +	.drv = {
> > +		.dev_groups = cxl_port_attribute_groups,
> > +	},
> >  };
> >  
> >  module_cxl_driver(cxl_port_driver);
> > -- 
> > 2.35.1
> > 
> 
> 

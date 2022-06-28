Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F755D206
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiF1DZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 23:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiF1DZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 23:25:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD462558C;
        Mon, 27 Jun 2022 20:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656386711; x=1687922711;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qq5NLYpNb7o2kgayMbV8N6bi1ZScr8LqQCODWFG/rNs=;
  b=bh9pycfUHaWYaopRa5jSwXpGv+iKqflxOkF3qovtlmUnkcZ0oiRPwQue
   J9Xk1lxVNjVCPKamt9LDL3OGfnL99uX+ZNWVeeiWiMo8+z2fS5hJhx5gd
   1dp1qj8dU4G6F7GHQFNtwVCdyw7Ek1o3HGN3+vVEQ5h2mjos3MuYVGc0t
   YFMSbrIxue8nJuodJ7GMp7iI91SrD8YtxaluVnckTuPvVbKkTc9qX+WgR
   2xIMAISvQrpMfm/9GTDx4k1dZa7hWAqM+A8NjIrpxA6HutNWuWC+rd97C
   HI5N9Fb/2pn9sMD28G99EMlxQcVlkmgwtvJm4R3lJtOto+5uomDEoaQV9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264663334"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="264663334"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="540341999"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2022 20:25:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 20:24:59 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 20:24:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 20:24:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 20:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WriTXRv2fQ64P3B4fKrzBQKifhZnvQdbSl4OwStAQRejLJ2j86nvcFWGu3AdZ7d3TX7sFlBAWvTBcCRIR68uFSKFKNVxVZgdoxuZdJYabAAiQoPcrNGtyvKImiOpDqWk1LSX5+CFWMd0QIXB7W8e2UpTn8I/GKAIuojFS4RrnkCCNFBDsdf3ExP/0RAsS9Bl2eXv1TFXmuXIZAaLPHRgFnnYbUip7QtRMQg+xTDhaD58JH1bbhOxTZ8Ups498uyhCVMDSiZgsTy9QWd9wtoPZSHOa1acMBbvmJ/HP2Xg82MOwkmNDWikIu6DgfRyVWMXAIWbSqeENXXaS5Fw4oXgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAU3SiX99KIwfn/iG4RHnvqYgTR0XU9xIyTAELOKD60=;
 b=Yg1oWviBYUymYM3Al+Auadi7Jt58AUiT+Nb0pF2BwbyVvg0xq1PqIT+oaZYJeiulwMrVSadriRg/+rV0MrI54xVX5ny27bTffty2Eh/joUApR1UtUVGUypdy9CrU0XDariHb8IZIaUPcvKRYIICWdwWIhVm1DHLDTp7ko+GDB6snqdELdRPfhpHKDy9O0L9OKqgtclpkdr99Cq0yTarOPPsBo78J/T6qFyzb9Q2KoBqG8bLBnAEQxllDkfMbgdXaBXV+wgegDlXczdeOk0mqCdQm+KaA9Ias6OrUqsIKIHCr0zpJ57prOwXtGkFSVF4Bvc1qtfn6sUBqmkTm9z+eeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.16; Tue, 28 Jun 2022 03:24:58 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5373.017; Tue, 28 Jun 2022
 03:24:58 +0000
Date:   Mon, 27 Jun 2022 20:24:35 -0700
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
Message-ID: <Yrp0c2wD/L0HHvgG@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-6-ira.weiny@intel.com>
 <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
 <YrI0qQrvM7MzKeLy@iweiny-desk3>
 <62b23c9b3726e_892072944d@dwillia2-xfh.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62b23c9b3726e_892072944d@dwillia2-xfh.notmuch>
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e594c04-8dec-4486-5f40-08da58b5c740
X-MS-TrafficTypeDiagnostic: CO1PR11MB4818:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flTl8t7u8INpXZjMguGAm57tGBSO/kVjDm1GSguuw1ZjMJXTfGJFOrZsyL85SdVz42PlFI1paZKpP7ld2NWMw0c2Ha46A9I+iunjQUMu2eqw7LFWYfMaqRCdeA9loOnPG8OYAs7sm2771+i4i5sF6wX7PO8kGUSL6s/Y1lcIisSdNDpD6r9h2oRiR3l3U1qKwkTwZG9OrSFRAv9Uf4WU/DgrHWdbkfR7BNeeJWnrfbWaBeZliccjz644Am7Tl7IwU+ZiQDwO3XYcIOOwtcTs8N8/tguKPnTzJMIElABPxH0OyQrk1kjgUi5HcuTqK5w3InZAlR+RxjHoK5ZD1XtpsE0rQoqijE+UrDVAXLeSbLbzUgbhkisHOl2ommPth0wuwkAHvlpJyommXT/jL7+Y3U5z2aLPhbjxXkog2kHpj6wiTTuPnqy2zmrcGDkfmGiE+cm1csOSpf2TlShCb4Xjc8hzTyjpyOeEI7IBbFrK+CMxmsPVb59SQ7+8/xWrUDYIZuamzwWDz+couimKXf0wnn92ZUed0osMONXfwR26KzlQZCQkEoJarFbxta+4c2DyShbYlf4PDwOCZ6ElTaPZvarGPZ8TIBErvLHebOQfHck8D4kybADEFw8djwWpfqG6LZI90OT2SInfDeLzi1okDbIQl0wr+6tGo5AUR0nm3GlxQ9+p+Nwju2apHe8a32FmvWCifPrsVLrWvom72O7Vluxx2Wt44VYIA/gpoREM9eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(376002)(39860400002)(366004)(396003)(44832011)(478600001)(6486002)(66946007)(5660300002)(316002)(4326008)(9686003)(6506007)(8936002)(8676002)(41300700001)(86362001)(2906002)(66556008)(6512007)(33716001)(82960400001)(6636002)(6862004)(6666004)(54906003)(83380400001)(186003)(38100700002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eg3+qacv+YBfxgxWO214IUAOs7BPFawuKzX+b9ZL6n9ewVCXQmM8tV3EVEkj?=
 =?us-ascii?Q?SScwdgV08mx+EEUVHGj3I4oCzkmPi/OZgxFe3rYvtGDYyTrQUcEOlaO8uKt2?=
 =?us-ascii?Q?bzpXUd2myweKRG5jD5RNxGizzerZAgh55XCQVQ3tUwDUspaFo8bh8EEMwabW?=
 =?us-ascii?Q?5T2Sc267Xocn4eY6SdhUaZq0qkcBhXKeU4tiYLeRebpQUXMfg6JvIlkMdDuo?=
 =?us-ascii?Q?7ghjMXGlHLEfMjYqka6mjT6UKw+NPF0+tBJq0oSPJsa8Fxn6Sb94jbVR8CtA?=
 =?us-ascii?Q?5T6ytiOvPMKuJUeIKAw38Nn8DLIJk+Wy/88AjorCu8stWeF9iWjiK+s1UaXm?=
 =?us-ascii?Q?aqSrWBIRcLbTM7Xovfnf0vDN6Drxxr08SG7XXsI7xaOXCT8RcEpG6Cp2E+PY?=
 =?us-ascii?Q?7V+dDwES+XXcnyKdJtV6brWEWrFhR45iiZ2mu40IO6bAt4Zfqdz10nzF7clX?=
 =?us-ascii?Q?FETnM2RMEDRsOWSfBI+nQcix1/xnublFIVbOzwuIfyrdhWdFwm4zieCv61Bo?=
 =?us-ascii?Q?q34njc3BFOBw92EF7xEhx0MXpDt/aKr7f3gAsguSbEVTW/KsQYJ6oUAjBX+w?=
 =?us-ascii?Q?z9c/BLweNBf91RlqJklE71n67YbmP6Ummk7PLWE/X/cQjkHlmVo+99UBhble?=
 =?us-ascii?Q?uxVMnA5qXzbLnvgdODiFIwa9khBlzBWVocU/rAUVRWtIkLRkYCfyz9StXZHh?=
 =?us-ascii?Q?j3WZLhrzrICOn8GtgGgHhOd2B2ukvfGq6bIvXj7lh4VgEBZL1/ua9TiDsXZ8?=
 =?us-ascii?Q?+AvsS7B7uiCKm6tJPTtNwSSXxmhKCjr/8nfrGDZbvr4J2WOreBKvoxwMAw0D?=
 =?us-ascii?Q?mYWlZ97PPROQHrrDCh66ZOL2KqCSfBWFgIDSMwT3uPxWD6OvAzlL2SdQRG4D?=
 =?us-ascii?Q?w03a0/usNm3iprSpLDFeL62tWRE0Fktp4lZvQkwF524g+TDLiDRLusH/rPrc?=
 =?us-ascii?Q?CZVkFl1BHJYXbv10pdjvfw7ne/NifbNkrnTvLr1Y95xO5oU1zdmJPPO60+jX?=
 =?us-ascii?Q?4NFuWHpypAeFc7iijMx7B2rvp99/B1v9YtUSMSeoow0A6kmf/ITA7G0peIzS?=
 =?us-ascii?Q?ayMgpp+jVcWqTj79TGIToKte/vaW/I2gL6aRrnH9jw0v4whlb6GFo3XWPnor?=
 =?us-ascii?Q?Jh7BUyxG4RInCTBDicvAEghIT9ntzOXmJ/n2smXSzgndI+kcKM7l/oBKnlJP?=
 =?us-ascii?Q?wHjBTEogItpLsKdYxtbjadf7gqJ9QghMyLP7aKL5c9fyep3NS0wWfmcTuXV2?=
 =?us-ascii?Q?vGUDDTNh9LOdwIjnXX0VZW80RM82wgLMbpePdzUjU/2euaPnSzfL/zM5mY3v?=
 =?us-ascii?Q?juQJTNpbsMzYVdhJzcdpDjLT5gJDekPiOo+XX8aSkXWdulnmdQ+LsmV15cEO?=
 =?us-ascii?Q?RRav78AYXRyCQHubLRu+Mxr1bbyjSlzwha7biWtKWHiEgU2DqfWNXy05Fj0+?=
 =?us-ascii?Q?Kkfd1iF2ZqkB+2/mDI2RNRcXMVUWbyCUIjmJHIHBW/o8Ehut+YX1NjYAT/WB?=
 =?us-ascii?Q?jC+ac0p7n6RBDBnVrkpnhudhxvbNINuybg0A0FpNlYOw7Vn+lEgQM7UW3PpP?=
 =?us-ascii?Q?8UU3roxCvDAV3oJpv4SGr3QYdj0U7yUwDvnZqJIjAyNb7BGjgg/yUMN59LgW?=
 =?us-ascii?Q?SA6O2HoyDgyUsfzDDL7LzriQKqYVqqAXsj6wOVm9iCiQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e594c04-8dec-4486-5f40-08da58b5c740
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 03:24:58.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9RyfNyCyl6Jq+QYTILGEPkqmny7pNX+TtWmrFbrIKUgm9AhrCEukSG4eKx4DSdHjQbzTD26r4KpVsQXu8j6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 02:48:11PM -0700, Dan Williams wrote:
> Ira Weiny wrote:
> > On Fri, Jun 17, 2022 at 05:43:34PM -0700, Dan Williams wrote:
> > > ira.weiny@ wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > 

[snip]

> > > Rather than a chatty / ephemeral error message I think this wants some
> > > indication in userspace, likely the 0-length CDAT binary attribute, so
> > > that userspace can debug why the kernel is picking sub-optimal QTG ids
> > > for newly provisioned CXL regions.
> > 
> > I thought we agreed that 0-length or CDAT query failure would result in no
> > sysfs entry?
> 
> Oh, I forgot about that, but some new rationale below...
> 
> > 
> > This message was to alert that a CDAT query was attempted but the read failed
> > vs finding no mailbox with CDAT capabilities for example.
> 
> ...right, but that's an error message buried in the kernel log. I was
> hoping for something where tooling can query and say "oh, by the way,
> the driver tried and failed to get CDAT from this device that claimed to
> support CDAT, remedy that situation if you are seeing unexpected
> performance / behavior".
> 

Ok I've added a flag which indicates if the device supported CDAT or not.  If
so the sysfs will be visible but the data may be 0 length.  Which means there
was some error in reading it.

> > 
> > [snip]
> > 
> > > >  
> > > > +static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
> > > > +			 struct bin_attribute *bin_attr, char *buf,
> > > > +			 loff_t offset, size_t count)
> > > > +{
> > > > +	struct device *dev = kobj_to_dev(kobj);
> > > > +	struct cxl_port *port = to_cxl_port(dev);
> > > > +
> > > > +	if (!port->cdat.table)
> > > > +		return 0;
> > > > +
> > > > +	return memory_read_from_buffer(buf, count, &offset,
> > > > +				       port->cdat.table,
> > > > +				       port->cdat.length);
> > > > +}
> > > > +
> > > > +static BIN_ATTR_RO(cdat, 0);
> > > 
> > > This should be BIN_ATTR_ADMIN_RO(), see:
> > > 
> > > 3022c6a1b4b7 driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
> > 
> > Are you suggesting I add BIN_ATTR_ADMIN_* macros?
> 
> Yes.

Done.

> 
> > 
> > > 
> > > > +
> > > > +static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> > > > +					      struct bin_attribute *attr, int i)
> > > > +{
> > > > +	struct device *dev = kobj_to_dev(kobj);
> > > > +	struct cxl_port *port = to_cxl_port(dev);
> > > > +
> > > > +	if ((attr == &bin_attr_cdat) && port->cdat.table)
> > > > +		return 0400;
> > > 
> > > Per above change you only need to manage visibility and not permissions,
> > 
> > But the permissions indicate visibility (In the kdoc for struct
> > attribute_group).
> > 
> > 
> >  *              ...  Must
> >  *              return 0 if a binary attribute is not visible. The returned
> >  *              value will replace static permissions defined in
> >  *              struct bin_attribute.
> > 
> > And the value returned overrides the mode.
> > 
> > fs/sysfs/group.c:
> > 
> > create_files()
> > 
> >  82                         if (grp->is_bin_visible) {
> >  83                                 mode = grp->is_bin_visible(kobj, *bin_attr, i);
> >  84                                 if (!mode)
> >  85                                         continue;
> >  86                         }
> >  87 
> >  88                         WARN(mode & ~(SYSFS_PREALLOC | 0664),
> >  89                              "Attribute %s: Invalid permissions 0%o\n",
> >  90                              (*bin_attr)->attr.name, mode);
> >  91 
> >  92                         mode &= SYSFS_PREALLOC | 0664;
> > 
> > 
> > So I'm willing to add the macro but I'm not sure it is going to change anything
> > in this case.
> 
> The change I was expecting is that with BIN_ATTR_ADMIN_RO() this
> implementation changes from:
> 
> 	if ((attr == &bin_attr_cdat) && port->cdat.table)
> 	         return 0400;
> 
> ...to:
> 
> 	if ((attr == &bin_attr_cdat) && port->cdat.table)
> 	         return attr->mode;
> 
> ...i.e. this routine only modifies visibility, you do not also need it
> to enforce the root-read-only permission change since that's already
> statically defined at attribute creation time.

Ok.

> 
> > I think to make those _ADMIN_ macros work with is_visible()
> > create_files() needs to be changed.  :-/  I'm not sure if the addition of
> > DEVICE_ATTR_ADMIN_{RO,RW} intended for is_visible() to be able to override the
> > mode?
> 
> The intent was that one only needs to look in one place to read the
> permission, and is_visible() is (mostly*) only left to change the mode to
> 0.
> 
> * changes from read-only to/from writable would still need is_visble()
> to manipulate permissions, but you get the idea.

Yep, done.
Ira


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A910F5A1614
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbiHYPr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiHYPr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:47:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE92DB02BC;
        Thu, 25 Aug 2022 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661442475; x=1692978475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VGHQAk0zSEolaD28LtQnPlFhPs4zXT9DnJDhOakuOsQ=;
  b=HOObR4jAouUwkhQNiqdcQ38QxWTx61K0uS8yCqB9VGqvafCa7si1WvWh
   C+n+82QQHVdtcgURo/1HXPKm8/nZOWkjtvBi31k9MT+gBCRxvX7n+v9fl
   UAB5Jd2RVpKe5fGfn/lAHcnJcJLuTPF0zXksQU6QgjyIFYKPm80/XsjAN
   /IrY9UtMBixH8OmxPm7pjYzDzky195zAJ+kIVkBJzuYWr6OeDLjWsNOCZ
   uFAMceDnLe1XbLraDYUoplLTI1h/sA6otLVtrLnbc4JZfymJ45JW2Tl42
   ayQhZw1TYxb9+HZhTDm2bajmBMW6wXqXd2VS0eRWGSa8J2Er0FsKqikBa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320354888"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="320354888"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 08:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="938376445"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2022 08:47:33 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 08:47:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 25 Aug 2022 08:47:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 25 Aug 2022 08:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrZ2hWZVhxIrKTLHEw3xrWCeIPFoHKPwk1PFJyOYs7sMW2FGYl5s30MblZKs8SIbG6pKM1ohDjC8MS/X4ufuT+Oe4fGzZzrh1h/2St+3Dyp6BljGgxPn7450dcdtn1QLy6YUrz4PPqBYviagSTCZu+7uzF5cW7XJQe/2BRPUwc+8tbtYba9NX6DvdsLTjzH2+cYLui6G5sxu0JYdQIBacbK98ZG88NLg+C0DaO9hZMuJkt8k8ccAVwkEckC1KeaVaT+tdmdgwc1U24jYS7nJ7SLMjg0Er24uhCFw/S7mI9JgYhRJljegM0Yx1N5fUZj7Y4rqurs2TbYQSYyGl8o8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WXZgDVGrwzyyGXV88kwr68+K9iaCQqptrTreLrm+uM=;
 b=EETv0Ysw994Ny1Jm5XXRI19TB1Mru6SNOXqiRxoEiX7GZt+VetLnGlZBStzXYJrPSxFynCI4LLd7RXMNPKkwxDafl5yfUOaq+zifVWyoBO+15es6/8uaY83V9Ia8CNqfhl2crx/GLVe6e3cetp/OszT8fk4fmNOJI0NpAKrwF/K68WDisks4DrCC0B0eObD9i2S1H0CB+59/MF/H0e1H5lAuCl7CA/v7MqH2dWJBji1YQDn9SR8Q+V6r4uDKJ70ruEyUNoJw/A1VLjmlpoBlj+jOX9MCav4OybP+iRu0diG2iQOF8DyrKn2koTG384xkua+fh/zgCOrKgzPMHTaV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4090.namprd11.prod.outlook.com (2603:10b6:5:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 15:47:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 15:47:29 +0000
Date:   Thu, 25 Aug 2022 08:47:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <YweZjRYVcT5uCg2i@iweiny-desk3>
References: <20220824232450.723179-1-ira.weiny@intel.com>
 <20220824232450.723179-2-ira.weiny@intel.com>
 <20220825160658.000051a6@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220825160658.000051a6@huawei.com>
X-ClientProxiedBy: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74c748fd-629a-4090-09eb-08da86b11d93
X-MS-TrafficTypeDiagnostic: DM6PR11MB4090:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LlS4O6v7SerKqSm1UgAzQYYBA54b4HdSVUkHPr7FAFP7gVvHxNYRyNZ2nrVJMpbq23xkSC7AoDBu1phss5t5tm/MuQoavx7pAUBk8a7K8nzWhI7aRIARcnwN7oY1ViiXY0zs3Yu+MwAt3oO+KCFvyc7olv9aWUwVR82h+pA833Xy3ar8GJMGtxj9K9LnmHbPijQviTgNb1GOKGN/wo9ArPwdfuItLIOOrEN+tSGKzBXJXZNVGKX+N0nhFEHZicETTeWQLrS8cVeY7CvxrxZMazEtLu1p78WDTccmP1syndmip/7Vd9NgMONeYzxUNXcO5x1fCC836G7gOcdJnw8SodoZMbtvKoTf+OCya/uc9LmR1qbHGoj0yGyosfL2R2WNL/W50hj5GUpyNGuxMZsRHGb/WA3Er+wpvqYuw40RFaRFop6PF7f0MSFufwV4FMzKx9o9gkXaj3RehTfTEB3Eaw70p0MlANs40Bp5Z9EB8XJ+DqDYEKQcYi2BMndQFY4qG2ifbUPHHgLq5LM4ASvAkBT7Vjtoyo60G3UGkEPDFsliOlf7pKogLphixcTqGm9fbR48TknPj00cF17+onGooM/KHsS1fxNRmb6VrfO4QVwNQ5qdjhBqsMYeJ78pLX54Gxo0uEAh4LvM6WJ0XTy1KozMJyq/pI+yoXEOyPz8TizNShnMRHiM38ETjWfDaAyqoXbNYn8/ATjNfSpVDUKYRs4RLt3v89h/vb+M+eWUvN8uN51mHp1irvDnIPJ/v9U/ZQd8lUY2RMzkyvUR9BRZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(6486002)(66476007)(33716001)(186003)(66556008)(4326008)(5660300002)(8936002)(8676002)(966005)(44832011)(66946007)(9686003)(6512007)(26005)(478600001)(6666004)(6506007)(83380400001)(41300700001)(82960400001)(86362001)(316002)(2906002)(54906003)(38100700002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RD7sRe8jD5AvRXyjyX0WbC3O/te8OV2MW2ppzn8oXvpXIL0aL9yHyUtQ6Akp?=
 =?us-ascii?Q?ckCp+uzAq7S3dKdqIiXdz5DsQrnpbkW81Y0Dj1gn+d5N75B4WwqO0Bu3e3Zi?=
 =?us-ascii?Q?BkBfjBGJR8A+o/QGER9oEUGAsaiD+EQpdkHHpfaMPQEde13Mu9F+ee0NXUjX?=
 =?us-ascii?Q?TzfeHrEeKBjer36jGspwRfgdqG9jLvyduvty5CSBw/3///PF8DevzaQX6IVk?=
 =?us-ascii?Q?PJMtS/l8oMoTTsV8TbWArlMP9uCOBsnwgkfHMJV9pgvu2yG5PeyZF1CvNNRC?=
 =?us-ascii?Q?Yv6tIbdSvL7aXj4Idtv9up6QPMDNA6CpCkE9Vjzudy9II2XlBgvNyp3CVLqa?=
 =?us-ascii?Q?h4/rS7s65sfDX0jtgINzHYusrHLqPDG6FG2dXDPR/NvjT1CUvSTVdLkEODpE?=
 =?us-ascii?Q?BhMJot+/CXlGkl7urKhbKEuHMM8hz0zOKDW+0GT/g57O7F4WY+hEJl6kVFip?=
 =?us-ascii?Q?taMCDY1LvbVfcnExZ7UXvIUN1727MaVe6WsfAKBN7uoWLL/QN45Mq5hc0pOE?=
 =?us-ascii?Q?kiy4R0UJ/cAcbYOOnek3JFxkrgFXmFf+Yy2aPwBkGwUHIAsLILqKSyu0Gdr6?=
 =?us-ascii?Q?XJjFqbMHFstB+atywvMbe7Jy8ijLGtKo/OnN1auRsMciSf4C/4tZhQPiJxB+?=
 =?us-ascii?Q?pyt+4cxqNcwZJE9HicrPwdzwZ+IqvwLgZgFkgcafFyMmOoZ/MpggB3/CfKEe?=
 =?us-ascii?Q?UQVufGbC5C6JwWShdw7eUa2WCs4lQB7igHstVHPwAIMl/yRyvUgrYDVORodq?=
 =?us-ascii?Q?sqNQ0tY3fV8+PEx97o1Ju/9u5msafWCHD+wjEadMPAlMo6ANQjEjI5xDwV7w?=
 =?us-ascii?Q?LmPrc3ipxEE6yC6EL5FfCYXMighd+W0N4248N5iRSuzQJhKG8PI1+qJBG2mX?=
 =?us-ascii?Q?Q4kW2FUNWFwc35SHHbKylEOdpxw8TQsOPfKYgZtlXBjsvxOKQ8pDXibYNmG1?=
 =?us-ascii?Q?ikYUXQAThCFe2eoYo1XMAb/Q9zMTbSUDHXi8VQ2337pP2YGIC9TS4TmL52Ou?=
 =?us-ascii?Q?um1diDnAkg7QOr32CtbHsU5gzJPTjUEWRvtcTbLJP2YcuzdfuEehXFWWvq34?=
 =?us-ascii?Q?t30cGmhUGKuAHJpEh7Odas4q5ugnxlLm5+h8RJjwt4w/W+k1wQ5WDcPvXEd5?=
 =?us-ascii?Q?N3UHunsCf6nwVRqEYkRmgWqI+qkP/+QWpEj7hQiZRCsJEIX0TN1zhtvCzYYM?=
 =?us-ascii?Q?LZ1cWTkrzgQdZZSpdbGoUy26MoXXG5zFkKgDrG/jUiPRKZvNDOy5HyTIbVWo?=
 =?us-ascii?Q?2dZLvUEVz1PPoGN5ZyjuHbIi2tG8zBJwYdDO9h4eZ3R0Os1CAniecFLOjGSH?=
 =?us-ascii?Q?cw3WEg1Na1iXdXGLKlPmNlsJse71yxTjJK29BnyY64ZnTVqEInbjsn/r9n+W?=
 =?us-ascii?Q?oub1znmHSFTIJhzo9RWyGPa+Z/t5TUojp0mG/nb7mUWSH1GUQMbXZNqVQB7j?=
 =?us-ascii?Q?erxIMWYIrG4qzCCWYzBFo2pXyoINoxgYpnRd46594SiMC0ESSpA7DuYXwmam?=
 =?us-ascii?Q?wd6zQOEFK9C6Ly5VVxxMaJEvJRGFPLZywdulroq1nGLGEiB/euZ3bjS8RWN/?=
 =?us-ascii?Q?05/QRuz7/yVaQzBbPM4g8qE4tyiRgl8mPv1IxJsD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c748fd-629a-4090-09eb-08da86b11d93
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 15:47:29.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w53bfHEMUTcRg6TGXFP/YRl12VRO0fm04o0cb1JnWMt+ZxnE076+SYpBIP5dhaXEsFlse3CUO1dwlnXhlYUMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 25, 2022 at 04:06:58PM +0100, Jonathan Cameron wrote:
> On Wed, 24 Aug 2022 16:24:49 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > PCI config space access from user space has traditionally been
> > unrestricted with writes being an understood risk for device operation.
> > 
> > Unfortunately, device breakage or odd behavior from config writes lacks
> > indicators that can leave driver writers confused when evaluating
> > failures.  This is especially true with the new PCIe Data Object
> > Exchange (DOE) mailbox protocol where backdoor shenanigans from user
> > space through things such as vendor defined protocols may affect device
> > operation without complete breakage.
> > 
> > A prior proposal restricted read and writes completely.[1]  Greg and
> > Bjorn pointed out that proposal is flawed for a couple of reasons.
> > First, lspci should always be allowed and should not interfere with any
> > device operation.  Second, setpci is a valuable tool that is sometimes
> > necessary and it should not be completely restricted.[2]  Finally
> > methods exist for full lock of device access if required.
> > 
> > Even though access should not be restricted it would be nice for driver
> > writers to be able to flag critical parts of the config space such that
> > interference from user space can be detected.
> > 
> > Introduce pci_request_config_region_exclusive() to mark exclusive config
> > regions.  Such regions trigger a warning and kernel taint if accessed
> > via user space.
> > 
> > Create pci_warn_once() to restrict the user from spamming the log.
> > 
> > [1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> > [2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> One comment inline.
> 
> I'm not totally convinced of the necessity of this, but done this way
> it has very little impact so I'm fine with it.
> 
> Other than the comment about not realigning things...
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

[snip]

> >  /* drivers/pci/bus.c */
> >  void pci_add_resource(struct list_head *resources, struct resource *res);
> >  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
> > @@ -2486,14 +2502,15 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> >  #define pci_printk(level, pdev, fmt, arg...) \
> >  	dev_printk(level, &(pdev)->dev, fmt, ##arg)
> >  
> > -#define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
> > -#define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
> > -#define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
> > -#define pci_err(pdev, fmt, arg...)	dev_err(&(pdev)->dev, fmt, ##arg)
> > -#define pci_warn(pdev, fmt, arg...)	dev_warn(&(pdev)->dev, fmt, ##arg)
> > -#define pci_notice(pdev, fmt, arg...)	dev_notice(&(pdev)->dev, fmt, ##arg)
> > -#define pci_info(pdev, fmt, arg...)	dev_info(&(pdev)->dev, fmt, ##arg)
> > -#define pci_dbg(pdev, fmt, arg...)	dev_dbg(&(pdev)->dev, fmt, ##arg)
> > +#define pci_emerg(pdev, fmt, arg...)	 dev_emerg(&(pdev)->dev, fmt, ##arg)
> > +#define pci_alert(pdev, fmt, arg...)	 dev_alert(&(pdev)->dev, fmt, ##arg)
> > +#define pci_crit(pdev, fmt, arg...)	 dev_crit(&(pdev)->dev, fmt, ##arg)
> > +#define pci_err(pdev, fmt, arg...)	 dev_err(&(pdev)->dev, fmt, ##arg)
> > +#define pci_warn(pdev, fmt, arg...)	 dev_warn(&(pdev)->dev, fmt, ##arg)
> > +#define pci_warn_once(pdev, fmt, arg...) dev_warn_once(&(pdev)->dev, fmt, ##arg)
> > +#define pci_notice(pdev, fmt, arg...)	 dev_notice(&(pdev)->dev, fmt, ##arg)
> > +#define pci_info(pdev, fmt, arg...)	 dev_info(&(pdev)->dev, fmt, ##arg)
> > +#define pci_dbg(pdev, fmt, arg...)	 dev_dbg(&(pdev)->dev, fmt, ##arg)
> 
> This realignment is a lot of noise.  Do we really care about one diffentlyu
> aligned entry? + if you are going to do it two tabs rather than a space
> following the tab (I think that's what you have here?)

I struggled a bit on this.  Not aligning makes the final code look odd while
the patch looks good.  Aligning with 2 tabs pushes everything past the 80 col
standard.

This seemed like a good compromise.

Thanks for the review,
Ira


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C959CA2A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiHVUiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 16:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbiHVUiv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 16:38:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE813F49;
        Mon, 22 Aug 2022 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661200729; x=1692736729;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L1JKI3Teo35fKplr/WkSwRWlWYHPFD8SYCN4Wqb2jVs=;
  b=Y+fPyTUEGQIj0Qwsa6tsGSTuh12Kwdvlopp+3bEA4gzGsZwPyL1QfTlH
   HNspgzXtw5s8CMRSsJxcyte+Zfmw1cCsr8JovQ/PWgOm13tHPA8AtR7JG
   8WJW/X1S5UIz66pN77nC/ky+pWKlKY6svToSgsCt1ddtcE4chyDvt03ld
   8G1j/iWMFXbC/4bjxelXGyAVSX3n9YoKLlJ7l+cY46mKZMkw8E5b/H8RB
   pc/E0NtRJs9j9CAeog28/SyptBTQCyMsb3tMHQdxNV9GHJG4DJua5WQPR
   YIcPgbULn5pf+hM+V2jke6Zuxo/7PqOMcLlUF9S469KkNjBa43w3vI263
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291069509"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="291069509"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698422163"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 13:38:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 13:38:49 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 13:38:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 13:38:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 13:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMroaNhHtCEyBXVFn/6a86vp3khWX0hDRocLl9RQAElyj5/dKWihbRJdb3VV9dqzPjDT2yX51F37cSeKXSQO1PAXvRws4BtTbWy2TqK2+i0ti4raSB0G2bB5EJqRSBntdoPh3YClUU1I6AvAKweTW1IclFX82tmHZFxinQX3LJRv2sE5YOFMhGoVnlz3dxfkoD/wmcmr5cyKROe8zOooRF7khH0UjMtDxrnB0VhHgnVDfok4DWguO7DBbUa3yWhValN73MGfmjZXi/2hYizNjwDc6vhg74xzIMjJ9k0eISouWfk4fAsFaOAEBiGGkXUTeEEfInyveAKYq3/YHS7whA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hUTJLOxl0bP+khqLNOLg3DOJ6sQQeUfEkzIm+GS8Rk=;
 b=EyRhtM8oZtQ4rDtwgKvoeS9E74f42zGl0Klv64Ns4ezIioyS63fOXtQSs8z9eQ9xu5Df3xbI2fITQZZhC8DFRMKM+F9VN6QTNFVJCYeNhhkQeNjF7cWdT6d2qjHyUZCCHC26z90LP6bPP2ICMhjrF22Aaff/2gWHohJ/9yQ6iHfHeTW7dvnUitMRzKEmk7V+n/MKeDIXAzZI7OX9ffzCEAYhJ4DYb0aOn4L7KOU5Zktxd/Ugps3dyiiLRIWqLiJORsDRfOq6vRLd8O6GZtd1zC41HZ4UVQ6z3uO8OYzePS0FRXcXnV/sMif3teiOj6iXuRMnFJnQRC90u1+Y+DuogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL0PR11MB2930.namprd11.prod.outlook.com (2603:10b6:208:73::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 20:38:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 20:38:10 +0000
Date:   Mon, 22 Aug 2022 13:38:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <YwPpLWgG37ObTMAP@iweiny-desk3>
References: <20220822005237.540039-1-ira.weiny@intel.com>
 <20220822005237.540039-2-ira.weiny@intel.com>
 <YwMktMqN0oFgCeZn@kroah.com>
 <6303dcb63e3e1_1b32294d9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6303dcb63e3e1_1b32294d9@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9613723a-d7c7-4bd4-8a9c-08da847e3a44
X-MS-TrafficTypeDiagnostic: BL0PR11MB2930:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuVFevXclbqWm2wAqNlPMEO7qzOIfPBIS6hXhY092EG7VlD7zRnWNaHKgfoE0DlJRp9kyg73NTODtwrrFV+JRgzphtYI3wdQEoKkMhW28d1AraoGZQ1/fkbiOnDlgM08X+ehqpQ9/2RuI+qoiP3AFSw++xkPq5iTZcFBCBEGHXn1d/d8tIgdduyYDSd/iCN+HdYbI/jahJtmf8QhY44FH23c+zhZjV73BvWvFs2B3CMHI2dFtY1Nz4XEB0x/2weZPPfnfsmV2U+p/AMuA+4ScJZO2EUrCwZ/3m8d8zN/hDVcMLWYM9ALbTciBgLN7ElvBtcVg2Psi6qzTZ2zOS45GfDlZ2vXNJApLBuzdEbo8s4LDvGUGP1bM6L8WIQS/kzPd2Tk4SSQdBZkb9YLiuvPjHf+8Z9qFztQXf8cZfLAiv09WexRGo2T5O/ThvlnANk66EbGGQ0V2W+FeRd8WR7X9viIFohcOEgsJOcBNtmfMuTUmB7iHnNLlFK+uqIei5hUECjiLzDIoEy1cNMcbTGuCf+nHq8SQcImxG/qLA0/k/4GXm0woWhmeL/hDLkqyyQZgfsolVs8jxqz0nx+osLbeGoGliYwGdXaZKQVdE3TFsNgd3CpVO9bO+fSVr5fNTv5iSGKTOPqlANIh/CaI27M99rUJgq5lMdUil/SB0BfWJdA1thkv+CL2BG81MpYZM4VA9iW5OjD0Zxzd5IcX0vXIGh1WfS5Vi4NH+7/e3Y07kcZrjBzc7RVniChiVJkPltXA4f3Cv2iIE81QbeemKLNXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(44832011)(41300700001)(5660300002)(6862004)(8936002)(316002)(86362001)(6486002)(966005)(478600001)(66556008)(66946007)(9686003)(186003)(26005)(66476007)(4326008)(8676002)(83380400001)(33716001)(82960400001)(6512007)(6666004)(6506007)(6636002)(2906002)(38100700002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmMoZ8FTGD8b/0dspk2Jm5QmSLGqGsd3hyqqfRhiK7xKigD61oSlDM7VOqA7?=
 =?us-ascii?Q?yO+Dw+cWcVU9gc+ZPOq1cDSO4mULQh6ER8mzMC4olP4rtKpuSyShfdP2SnIQ?=
 =?us-ascii?Q?HlTo1mOV6zEOxrvs35P3nNivYgWqpHnX7YsWbA+w9g6J8+Q/dwILCH0CWhoN?=
 =?us-ascii?Q?OVS3fe6KsSbTWg12A6rZU0ODbbKalScTOFEzYmyZ/PTUJWmfNnls3eXNfdjq?=
 =?us-ascii?Q?ws9GWk3Eg0C89MAAEUzYz2bYt6mfB+GsP7to1KtvmMUrvU4QXzVbH3m6sCDC?=
 =?us-ascii?Q?rMtE9YsEznSgCROzMzyS1Omr6bW4zCnuhd2hTsZ50HvefHKxMmcXbnShQOs5?=
 =?us-ascii?Q?qgjdDfT3lMKzqFJ9l3zL67+xN0LWUImMPrYFeHdXi+js4jdyEYhaQ3x7vvrB?=
 =?us-ascii?Q?ntdJ7S2BK/kQ6hcmzK7SVEFY+ccdUOE7hAp0lor2s9wf7WAfDWOlo+fzyutd?=
 =?us-ascii?Q?MVoFxhQuwgPM+fcPIa4QHdVmBIvfmLVumATXw2kPJXIiMUx82n44KBa+Iyo8?=
 =?us-ascii?Q?2PAkRaZxRq980dydYY2w1OyL23gFjm9FLZCYzijUER7EZT6WDg/7ZV7JO/Rm?=
 =?us-ascii?Q?96SAtj0Ns8NqiZvZD4sIQVgFPsw2KrhiczLADer2NLPk+HucyhZMTbUEPiv5?=
 =?us-ascii?Q?NZP3NRnvPvJXsbAtzuPlLMXRcvhTwDEsKaXDKhNTd3DcqB8cOV1A6nsjQwn9?=
 =?us-ascii?Q?6IRhUFpZIJdEI0qCu7gIJu8xOB2zZASBU0CfexpZc8nImzdnQjmPs4g6Hl7x?=
 =?us-ascii?Q?8rKWTis/L3Ohbp9/R8BtfEmxQYp2ZN4wq9eBeFOaZOR1xxrXEQf4NTj9aGgZ?=
 =?us-ascii?Q?wqizfYFDmKXXajBaAmeU5WSo5ShRo0ubYPaNKjel+cxwJKhXYAME641/WabH?=
 =?us-ascii?Q?ORWFxBP7Jx7APK8Esmtlhs9DUtoLjL9DQzyybB65B1Wd7cLa4oUIfxhb277a?=
 =?us-ascii?Q?z2RFUR+bVZongR3RaqRWEb8eLe6nVcJBD3n5AnADkoEkXl2OMbUXADzZqJtQ?=
 =?us-ascii?Q?ubwZA6HTa4xRzH9ijxkJ6RHeUIHbXQyL3uKXNG8IMJVdgKBn3e5BLZO+6iDl?=
 =?us-ascii?Q?dTjQ9I2BFNpD8or8MxI/nZhlSW2IxyjMonJzTy5Bd3MKtWmDkb0H+fzgJxLZ?=
 =?us-ascii?Q?rsY9s9HxOt0MnHyNCC7BlX25mi4l63Qx/s00eBgRuLIJkmUFkqXC45CZv0ik?=
 =?us-ascii?Q?mOFJMzZEMlh0OZj4Nl3uhUAEYYK6+15JXjy7rBoI2I4KLUgCKxl0ncl1JHLS?=
 =?us-ascii?Q?/7OS66uo0RFCmEH2M6gjQt+YGMy+JOQW4mszjDo9aaBJsken8/ZaNRmApSl3?=
 =?us-ascii?Q?NJ8DvnVHB37Nsw8Zu/jTBAaXzw9P63O8u9ZuoBUHVB4JYJxKWfqrhjJZI5Oy?=
 =?us-ascii?Q?4lZeZZqm+4pW80L86t3wpxDzzPh3nSs91Lpa8nVch2darbSBtVkWSGNaTvYG?=
 =?us-ascii?Q?Lgnb6Q7G+M0ZkO/64ns5CRo7zb9IT6lxdgFzWSv+GFqE7DjUv4NMehwXPxoE?=
 =?us-ascii?Q?Eu5NEXOF6HVkEjmenS5pBQQtrCDkDe1iqnczZ653ktLIbls2R11gZ2Rgr0xz?=
 =?us-ascii?Q?LdnYbRtAeF3TnK3KVD90TaN1qTyNJTxwBWC/ovC5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9613723a-d7c7-4bd4-8a9c-08da847e3a44
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 20:38:10.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJk4mBN2Av0waI4XRfhgrXqy8vhEq36TbLF8RflUzjwbrNW5hbkTyi5Ru24sft+cThDJYwIFnRZWSNi9KTbRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 22, 2022 at 12:44:54PM -0700, Dan Williams wrote:
> Greg Kroah-Hartman wrote:
> > On Sun, Aug 21, 2022 at 08:52:36PM -0400, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > PCI config space access from user space has traditionally been
> > > unrestricted with writes being an understood risk for device operation.
> > > 
> > > Unfortunately, device breakage or odd behavior from config writes lacks
> > > indicators that can leave driver writers confused when evaluating
> > > failures.  This is especially true with the new PCIe Data Object
> > > Exchange (DOE) mailbox protocol where backdoor shenanigans from user
> > > space through things such as vendor defined protocols may affect device
> > > operation without complete breakage.
> > 

I was about to respond when I saw Dan's message so I will respond to both of
you.

> > What userspace tools are out there messing with PCI config space through
> > userspace on these devices today?  How is this the kernel's fault if
> > someone runs such a thing?

It is not the kernels fault but multi-party actors on a DOE mailbox can result
in the kernel getting incorrect responses for it's valid query.  After my
conversation with Jonathan during DOE development[1] I'm more convinced that
this tainting of the kernel will be valuable.

[1] https://lore.kernel.org/linux-cxl/20220704074508.00000cac@Huawei.com/

> > 
> > > A prior proposal restricted read and writes completely.[1]  Greg and
> > > Bjorn pointed out that proposal is flawed for a couple of reasons.
> > > First, lspci should always be allowed and should not interfere with any
> > > device operation.  Second, setpci is a valuable tool that is sometimes
> > > necessary and it should not be completely restricted.[2]  Finally
> > > methods exist for full lock of device access if required.
> > > 
> > > Even though access should not be restricted it would be nice for driver
> > > writers to be able to flag critical parts of the config space such that
> > > interference from user space can be detected.
> > > 
> > > Introduce pci_request_config_region_exclusive() to mark exclusive config
> > > regions.  Such regions trigger a warning and kernel taint if accessed
> > > via user space.
> > > 
> > > [1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > [2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > Changes from[1]:
> > > 	Change name to pci_request_config_region_exclusive()
> > > 	Don't flag reads at all.
> > > 	Allow writes with a warn and taint of the kernel.
> > > 	Update commit message
> > > 	Forward port to latest tree.
> > > ---
> > >  drivers/pci/pci-sysfs.c |  6 ++++++
> > >  drivers/pci/probe.c     |  6 ++++++
> > >  include/linux/ioport.h  |  2 ++
> > >  include/linux/pci.h     | 16 ++++++++++++++++
> > >  kernel/resource.c       | 13 ++++++++-----
> > >  5 files changed, 38 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index fc804e08e3cb..de41d761bdf5 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -755,6 +755,12 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	if (resource_is_exclusive(&dev->config_resource, off,
> > > +				  count)) {
> > > +		pci_warn(dev, "Write to restricted range %llx detected", off);
> 
> Note to Ira, I would expect a message like:
> 
> "Unexpected user write to kernel-exclusive config offset %#llx\n"

Done.

> 
> ...this probaly also wants current->comm similar to the
> lockdown_is_locked_down() warning.

Done.

> 
> > Will this allow any user to spam the kernel log from userspace?  You
> > might want to rate-limit it, right?
> 
> It should be a once-only message. You only get one chance to trample on
> a configuration address range that the kernel cares about and then
> tainted.

Yes my bad.  I should have thought of this.  Changed to pci_WARN_ONCE().

> 
> > > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > +	}
> > > +
> > >  	if (off > dev->cfg_size)
> > >  		return 0;
> > >  	if (off + count > dev->cfg_size) {
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 6280e780a48c..d81d7457058b 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -2303,6 +2303,12 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
> > >  	INIT_LIST_HEAD(&dev->bus_list);
> > >  	dev->dev.type = &pci_dev_type;
> > >  	dev->bus = pci_bus_get(bus);
> > > +	dev->config_resource = (struct resource) {
> > > +		.name = "PCI Config",
> > > +		.start = 0,
> > > +		.end = -1,
> > > +	};
> > > +
> > >  #ifdef CONFIG_PCI_MSI
> > >  	raw_spin_lock_init(&dev->msi_lock);
> > >  #endif
> > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > index 616b683563a9..cf1de55d14da 100644
> > > --- a/include/linux/ioport.h
> > > +++ b/include/linux/ioport.h
> > > @@ -312,6 +312,8 @@ extern void __devm_release_region(struct device *dev, struct resource *parent,
> > >  				  resource_size_t start, resource_size_t n);
> > >  extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
> > >  extern bool iomem_is_exclusive(u64 addr);
> > > +extern bool resource_is_exclusive(struct resource *resource, u64 addr,
> > > +				  resource_size_t size);
> > >  
> > >  extern int
> > >  walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 81a57b498f22..dde37bfa0ca5 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -409,6 +409,7 @@ struct pci_dev {
> > >  	 */
> > >  	unsigned int	irq;
> > >  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
> > > +	struct resource config_resource;		 /* driver exclusive config ranges */
> > 
> > So the driver only gets 1 range to mark this way?
> 
> No, config_resource is just the base of the resource tree to walk
> similar to how iomem_resource is consumed in the current
> iomem_is_exclusive() implementation.

I had to double check but yea, Dan is correct here.

> 
> > What are the ranges for typical devices that have this problem?
> 
> Unfortunately DOE is an extended capability that can pop any number of
> instances in that per-device list.
> 
> Although I also think there is potential to use this in something like
> pci_iomap() to trigger a future warning if userspace mucks with the BARs
> that the driver is using.
> 
> > This still feels very odd to me, how far do we have to go to protect
> > userspace from doing bad things on systems when they have the
> > permissions and access to do those bad things?
> 
> Right, this mechanism isn't about protection as much as it is reserving
> the space for kernel implementations of DOE protocols. Outright
> 'protection' is already there today in the form CONFIG_LOCK_DOWN_KERNEL
> that prevents userspace config writes. There just are not many distro
> kernels that turn that protection on.

I agree that there is no real protection.  This is just a way of us knowing
that bug reports have outside influence which can have real bad consequences.

> 
> > What are you trying to protect yourself from, bogus bug reports by
> > people doing bad things and then blaming you?  That's easy to handle,
> > just ignore them :)

I think the problem is that the bug report could be very difficult to know that
something bad was done.  I'm ok with ignoring them.  But this makes it clear
that the bug report was potentially user doing bad things.

I see bug reports being something like:

"Kernel issued query for CDAT.  Device returned garbage."

Vs

"Tainted kernel (error message seen) issued query for CDAT.  Device returned
garbage."

The first could be a malfunctioning device.  Where the second can clearly be
pushed back to the user to stop doing bad things.  I can't in good conscience
ignore the first report.

> 
> I asked Ira to push on this to protect the kernel from people like me,
> :). So, there is this massively complicated specification for device
> attestation and link integrity / encryption protection (SPDM and IDE)
> that has applications to both PCIe and CXL. I do not see a path in the
> near term to land that support in the kernel.
> 
> DOE being user accessible though, lends itself to pure userspace
> implementations of SPDM and IDE infrastructure. I want to develop that
> infrastructure, but also have the kernel reserve the space / right to
> obviate that implementation with kernel control of the DOE mailbox, SPDM
> sessions, and IDE keys in the future.
> 
> The warning helps keeps proof-of-concept and/or proprietary DOE code out
> of production release streams on the observation that end users tend to
> demand warn-free and taint-free kernel deployments.
> 
> Similar to CONFIG_IO_STRICT_DEVMEM, just turn this warning off if you
> are a distribution kernel vendor who does not care about DOE vendor
> tools affecting system state, and turn on CONFIG_LOCK_DOWN_KERNEL if you
> are on the other end of the spectrum and want protection from such
> things. The warn is middle-road option that I expect most distros would
> use.

FWIW I did not add any Kconfig for the feature.  Should I?

Ira

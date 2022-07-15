Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CF5758FD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiGOBKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 21:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOBKN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 21:10:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496EA5F9AA;
        Thu, 14 Jul 2022 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657847412; x=1689383412;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CAcLQLxmhzCHjN/LK4TmBEXn2f+JE67h30eAVEHrJro=;
  b=baJXqtFUQNrgHSMV383z/E4f3MccI00oBIkp2pZaPglOWfglcOqC810C
   Stf6SV9JNLsruNFTkWiaNxKXY2h0YKohCZ6II7pR1WhRRklSefGIV+y1a
   dcFKa6hu51HjhmCYTxJcy4vLCdiMKf06si942BIYMMVpa7iqTxQZctxm6
   bSo9hp73M5NsyZWpoTwSm1AYOD9YdAkxYrt573WXbI/ylvQm2OrvrQKm7
   1oX2G9zgdiSYf/cEFnxFUvUJtNPaRWh+XQT2TDygsRig1SDh53EaBoyig
   wbzPNVIL7nhSY+S1e0WQUvTPKKPktdKK46yA89I3TulRtCbT1LDh9H7nS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265461709"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="265461709"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 18:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="685783817"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2022 18:10:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 18:10:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 18:10:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 18:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noc0MY9wiIWmJav8tm2GUoQmFSv2f1c7hTtJ7ab+BWre7/Uoefg/wwGd9ymRmxNxVnJ/jtwZzh12jLBb7yqxvM5ZsHzVZEajR7xl1awrgSg64ObPhtPEoQoraz1xgwHOTajq/GWHT6YRHp6lZCBwTu6O+BiwrTprJuPjJn8L5rzEbWbNrYtLHP4jp7ih0I8AnAwpUq0NKHZCoiLjNDGsImD3wTZvEXuD1aXXef259+yrE1r/OB+00ztmqIULHPZO6C79ZV4HaBUICPeAATJBp2qaAAHAT3KdkpeLhDlV8PuDTQjFHNaCFLH5eVzVMkmXBLPHEpHwA/pbTbbFe29Ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M317RRx68lIK3w/ekgvw1jJX/P2knjuxSQD1dRZ3KFU=;
 b=QglpgNcryps9Gfx5O8a6RHDqNJJjW+z+Y9rxNHkCEcKAwRRnJZNDfW6P2in/N1PZdv4TrjprZugtAIbzh7tdBFDQ6PATfb2VO9l17lSbEltSclE1P3qzuXusXjKwrf3aTkkFy9ccIU7yAa6a4RyoFU1Ubj39aH3/8Jv9rUz9CTkAT+h88CCikBkHK//c89L64AJ6ZoTgafdG3WySqMBeaOGazsUGohTyY524MAEXWJ4Wwej5jCDRvr2g9CbUeWj6wnKN0s0haGAg9yhHXoJ3WHYXXGsu8+Wlfg8e/ARjJlM6Db3AudwutkhABewcUEDW2fL2RPh75bS+YDA2Ocjl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM6PR11MB3723.namprd11.prod.outlook.com (2603:10b6:5:13f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Fri, 15 Jul 2022 01:10:04 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 01:10:04 +0000
Date:   Thu, 14 Jul 2022 18:09:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 6/9] cxl/port: Read CDAT table
Message-ID: <YtC+ZZSMGtaYAtWO@iweiny-desk3>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-7-ira.weiny@intel.com>
 <62d0387522e5b_16fb9729432@dwillia2-xfh.jf.intel.com.notmuch>
 <YtB0loLvlKbgcA43@iweiny-desk3>
 <62d07a37d25ed_16fb9729491@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62d07a37d25ed_16fb9729491@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe2b2705-5078-4351-6829-08da65febfe5
X-MS-TrafficTypeDiagnostic: DM6PR11MB3723:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rMM45iy7WQZ+fuDK+RR2+Q37ro4grFrqf+Did5jxIMsX79kceZIFbexLEReA/7/2DQCwUoAKYBUQ76AaENWN6mdGCR3lfVy+TQukOHx6zSYf9gmOZG/oFisMQG94aPDE6H+YiGewg9IR3WmiT70kCbxnmDV3F90GNX6pZM9rHwAnCAiwV2ywAzdd1kUACPJtT9eqjP1A0DcHMUxUG5XcUfmZPsvpk+JuTA0ReMr9IlJe+xdJD77OdH5jBMivgaO+rRA3miQ48A0VP+8FKVg6XtDOoEJJe3URJJ8rT8dzKlB5Ckeo99QUreQmANpt47hHmollZX2KZxFs36NnceoRCXfyGMelTIqDrZiQoebupl/ifP4D95kUH/ep7+y5iYc2pZ7xYd6+pBEM59OQZvE/1xgKb+xXjNA8qR2TbrgYF70rwQ3GGy5xHE6zERLnve+rQHczpzHMHtpKWFemG9h9ctNvDgpYPBl3u1XWmcDsmmBBlC9tiPMiRlN+tmlpTCbiH2gV12iUOQgzACfITfWfehWv6WAbqnz59avlrCWggJCo/Rv4uRq7qitrSRbYWHmf0pC6gKr7GwcnJ+gKnId787Ed4Ey2KlSa3bSRSd/Lgv4lH4d77d7pHzZlbLzxpvbcwVqQug0S1nmn/YidkYelLPkL0YI58ctRJ6xfn/1kPDwBMXkPdLVVWh96AvlbIfx/KKuc3D+ZXmi/EosOsfq/nHrhKQ7voH7fWmp1wM9/AfmTjMyvJrSz/shRzmDY8NcCk3LgNoUqLu/7G4C1QY8clgjArJH1iHJcXIQTDbZjIfVjX74bN7l3TXqPpYi0R1H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(396003)(136003)(39860400002)(376002)(6486002)(8676002)(54906003)(478600001)(86362001)(38100700002)(186003)(9686003)(66476007)(66946007)(6506007)(41300700001)(6666004)(4326008)(66556008)(6636002)(316002)(83380400001)(33716001)(5660300002)(8936002)(2906002)(6862004)(82960400001)(6512007)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gdSVjt8x/VVX4U871TpODnK7V+eY965F/AbwEj8RhYypg2ijpbzQHD8l5YQn?=
 =?us-ascii?Q?SaJtvQ45ohbBX7qdMS3T0sA2s4SGAFfJMHXX1FubhkTCwThjrVMmJYxgmYli?=
 =?us-ascii?Q?ZgpDyr+NxfmA+ZeovJsjua1obGpuNqiyIQYMFnpJuIUbSGbB0Ssg/X3LX4HA?=
 =?us-ascii?Q?S7u9aGU+kfgTprRpgUMEG6OjeBsiRXlsrbwo1JVET4ks9e7x1u4KmUm6gnOX?=
 =?us-ascii?Q?oBHyJU9bJsZUJhLr6S0MBoXiPd1ZV+hVV4uFZk7QK23L3HHqFM1s99HfRXHs?=
 =?us-ascii?Q?cH4uxqn0DjkDHWsxPLbJOQ4P4hg18/RMRWUtTbhwq603PT1gB+fDBlHzcPX1?=
 =?us-ascii?Q?ZB/UDVDCu9XDIdRoVlhQ80g40wj3YCfQEIeoeC6AV2OhT3zFvp/vX9O2AsX+?=
 =?us-ascii?Q?8qglg1pEEEojDLt5FOwXMQK6lTxiWWNxX/Ai91hrhFff0x7rLDXPn15WkH90?=
 =?us-ascii?Q?zqSJhAwnbFoTlEsii16dUiALlHAuKeNjMXjCBFnEYN64c60zc565aScDng6v?=
 =?us-ascii?Q?uCGXmP6WVog/BD0a6yS8Il0alj9cYbpjch1LTotFQLoXJc/htv74hbmxFI+I?=
 =?us-ascii?Q?9mFJMaqcm0ROOnSm/04DAHd3jFIUyS36m9VqnuNm1glJoC8DpVOnfgIcn3/x?=
 =?us-ascii?Q?VXpmSFEqNyo5pZx0+/RQQks9gbejn8TS/Wq11qnHhM63A7EhuuEo2qoA5u32?=
 =?us-ascii?Q?qUwlu3WItPH61s4Rpe/rD+6boUmnhzaltQeDjjweM2XkDS8cxX1j3dLPCY9G?=
 =?us-ascii?Q?ZckehOUeWMY1teXxRJEFXsebaR66Kv3yxXK7m2MK1rSDh/+WS/oEOG4TkwZX?=
 =?us-ascii?Q?yw6xKgaIDUc2Eolqet67bLaUkSZIoUHtw16O7ql/Ogh3m1H68kTOxxzJrcwN?=
 =?us-ascii?Q?nJG4D9SBycQp2V2nlEm6QzaEwdqBxebj606zCH8yxyY8Q4TXkowEhErVUwpf?=
 =?us-ascii?Q?u50bPziq9K6s5ClmDAZew1G582QQVAy7kpAoFgGXVZ5EzqwDCKk51B4PGfWX?=
 =?us-ascii?Q?9JGekId8dMB8w1oIILJzgxS0bCEWSuJr9/3DuFqV7XDhydqYUAoSDYGx8Qya?=
 =?us-ascii?Q?+JeuR6NVpgV/zJc6U8xPsZyTCBbnkUMQFQ5314NKt5twdY/FEhp8lIWNrAmi?=
 =?us-ascii?Q?34yGtjN26CK2faDrS5hChcK/CGZql4G85sJJ87I9bZA/9BIRjMTQNnV9JJvc?=
 =?us-ascii?Q?Q/oqaMj8ZinBsa+KJWqPBjA9thVeKqPAmQN+9n7bNd50K3daFjjvoTKZLLcO?=
 =?us-ascii?Q?JW7pfpIqkSSX2rPLaYw00yrmXI6ie7RvRILCip1HvM7qXw7rgMTlP6A8Er2x?=
 =?us-ascii?Q?Kk5Ah86WQj9r9PT971QrcDbh97wiUwGTji7qhYRFfIp2x1XEzvSwDHWanCB8?=
 =?us-ascii?Q?9ssvUOvu9vf4Blpymezh464YhFX2pVOytoguB/33LEBftADJlLwQMgNQVTXE?=
 =?us-ascii?Q?ALzCFCVypw63chxLNWpDPahlrJC2KCuDKjlk49oYjB2Ao388PnJ7CfhEeAXH?=
 =?us-ascii?Q?jTZiHfmy/5B2zw1p51PxwOfRNTtPlStYOGzxrSEbuKzU7q53uGlhHaRFvjMr?=
 =?us-ascii?Q?hyeiaoE35RH4h3MydVLR8nKr6+C+qeyqfd7gx+LN5VAwDYAoxBEbFzsIIfou?=
 =?us-ascii?Q?4LpRw5++EtKaSacy7AuCWXqelv+vokXDZlfeXiu79Wpo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2b2705-5078-4351-6829-08da65febfe5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 01:10:04.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q79xKBg2bUjNlzWQTLUJz6VAYv+ppPTlSBqj40dsHP8IbuqiD2+bQSUjNHRuEXqM/ktMstDcPROLgLLW/acG/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 01:19:03PM -0700, Dan Williams wrote:
> Ira Weiny wrote:
> > On Thu, Jul 14, 2022 at 08:38:29AM -0700, Dan Williams wrote:
> > > ira.weiny@ wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > [snip]
> > 
> > > > ---
> > > >  drivers/cxl/cdat.h     | 100 ++++++++++++++++++++++++
> > > >  drivers/cxl/core/pci.c | 170 +++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/cxl/cxl.h      |   5 ++
> > > >  drivers/cxl/cxlpci.h   |   1 +
> > > >  drivers/cxl/port.c     |  51 +++++++++++++
> > > >  5 files changed, 327 insertions(+)
> > > >  create mode 100644 drivers/cxl/cdat.h
> > > 
> > > The bin_attr additions to CXL sysfs need to be added to
> > > Documentation/ABI/testing/sysfs-bus-cxl.
> > 
> > Done.  But with a very simple text:
> > 
> > What:           /sys/bus/cxl/devices/endpointX/CDAT/cdat
> > Date:           July, 2022
> > KernelVersion:  v5.19
> > Contact:        linux-cxl@vger.kernel.org
> > Description:
> >                 (RO) Raw binary CDAT data.
> > 
> > Is this enough?
> 
> It should talk about what it means when this is absent, present and
> 0-sized, present and non-zero sized.

ok.

[snip]

> > 
> > > 
> > > > +{
> > > > +	struct cxl_memdev *cxlmd;
> > > > +	struct cxl_dev_state *cxlds;
> > > > +	unsigned long index;
> > > > +	void *entry;
> > > > +
> > > > +	if (!is_cxl_memdev(uport))
> > > > +		return NULL;
> > > 
> > > If this only supports endpoints just call this from the part of
> > > cxl_port_probe() that does:
> > > 
> > >   	if (is_cxl_endpoint(port)) {
> > >   		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> > > 		...
> > > 
> > > ...and let the person who adds CDAT support for switches refactor it
> > > later. I.e. find_cdat_doe() can just take a @cxlmd arg directly.
> > >
> > 
> > I was trying to make this generic for all ports originally.  But in the end we
> > punted and said end points only since we don't have the plumbing for PCI port
> > driver yet.  Won't I have to move this back when that comes online?
> 
> Yes, but:
> 
>     if (!is_cxl_memdev(uport))
>             return NULL;
> 
> ...in this path has no reason to exist in v5.19. The need to consider
> switch-port-CDAT is at least a full kernel dev-cycle away.

Ok removed this check and called read_cdat_data() within is_cxl_memdev() check
in cxl_port_probe().

> 
> > > It's
> > > enough that this patch located the cdat cached buffer on 'struct
> > > cxl_port' and the 'CDAT' sysfs attribute under
> > > /sys/bus/cxl/device/cxl_portX.
> > 
> > I'm not parsing this sentence?
> > 
> > .../cxl_portX/...
> > 
> > does not exist?
> 
> No, I'm saying that the sysfs location is fine, and find_cdat_doe() need
> not consider switch-port-CDAT yet.

ok.

> 
> > 
> > root fedora /sys/bus/cxl/drivers
> > 12:46:39 > ll
> > total 0
> > drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_mem
> > drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_nvdimm
> > drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_nvdimm_bridge
> > drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_port
> > 
> > endpointX points back to the same place as /sys/bus/cxl/devices/endpointX
> > 
> > root fedora /sys/bus/cxl/drivers/cxl_port
> > 12:47:03 > ll
> > total 0
> > ...
> > lrwxrwxrwx 1 root root    0 Jul 14 12:44 endpoint3 -> ../../../../devices/platform/ACPI0017:00/root0/port1/endpoint3
> > ...
> > 
> > root fedora /sys/bus/cxl/devices
> > 12:47:59 > ll
> > total 0
> > ...
> > lrwxrwxrwx 1 root root 0 Jul 14 12:44 endpoint3 -> ../../../devices/platform/ACPI0017:00/root0/port1/endpoint3
> > 
> > So what is different from what I'm doing?
> 
> Nothing wrong here, sysfs CDAT location is fine.
> 
> > 
> > > 
> > > > +
> > > > +	cxlmd = to_cxl_memdev(uport);
> > > > +	cxlds = cxlmd->cxlds;
> > > > +
> > > > +	xa_for_each(&cxlds->doe_mbs, index, entry) {
> > > > +		struct pci_doe_mb *cur = entry;
> > > > +
> > > > +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> > > > +					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> > > > +			return cur;
> > > 
> > > This has me thinking the doe_mbs xarray is overkill if all the other
> > > DOEs are just enumerated and then ignored. When / if more DOEs need to
> > > be handled then we can think about instantiating all of them and keeping
> > > them aruond.  Otherwise, just do this pci_doe_supports_prot() check in
> > > cxl_pci and throw away the rest. Then cxlds would just carry a single
> > > @cdat_doe attribute for this first use of DOE capabilities in the
> > > kernel.
> > 
> > I was hoping that code could be lifted to the PCI side later.  For now CXL
> > could handle all DOE's.
> 
> It's only a couple of code to fetch the CDAT DOE out of all the DOEs.
> 
> > At this point CXL devices are the only one using DOE in the kernel.  I know
> > there are other PCI uses coming but for any 1 device only one mailbox object
> > should be created or we are going to have the kernel drivers conflicting with
> > each other.
> 
> In what scenario would a PCI driver conflict with another PCI driver for
> the same device?

If the ownership of struct pci_doe_mb is not clear each could iterates the DOE
offsets find that the same mailbox supports 2 different protocols that each
needs and they both create a struct pci_doe_mb for that offset.

And bad things will happen.  :-(

I know that we have cautioned implementations not to make the protocol support
on mailboxes too complex but the spec does not preclude this.  You have
explained in the past that the CXL drivers are parallel drivers to the PCI
layer.  In this case PCI should eventually control the mailbox objects and 

> 
> In the CXL case cxl_pci finds the one DOE it cares about and throws away
> the rest and nothing else in the kernel will ever conflict with that.
> 
> Don't try to solve future problems until they become present problems.
> 
> > So I'd rather leave this series with CXL controlling the DOE mailboxes.
> 
> Sounds good, I'm not asking you to change that, just asking for this few
> lines of filtering to move to cxl_pci.

Ok.

> 
> > I think later we will need to lift the mailbox objects to PCI and CXL
> > drivers will need to query into that side as needed.  There was a
> > version like this before (Probably Jonathan's) and I think the aux bus
> > moved it all over here.  <sigh>  Sorry getting pretty confused myself
> > at this point.
> 
> Sure cross that bridge when we get to it.

ok.

> 
> > The code change you suggest is easy to do but I think it would be better to
> > land this and then lift all of the mailboxes to PCI in a follow on series.
> 
> That follow on move is not prevented by just the small move of this
> filter to cxl_pci, right?

Yes I'm starting to rethink all this and I think this will simplify this patch
set and get this support in.

> 
> > > > +#define CDAT_DOE_REQ(entry_handle)					\
> > > > +	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
> > > > +		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> > > > +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> > > > +		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> > > > +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> > > > +
> > > > +static void cxl_doe_task_complete(struct pci_doe_task *task)
> > > > +{
> > > > +	complete(task->private);
> > > > +}
> > > > +
> > > > +static int cxl_cdat_get_length(struct device *dev,
> > > > +			       struct pci_doe_mb *cdat_mb,
> > > > +			       size_t *length)
> > > > +{
> > > > +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> > > > +	u32 cdat_response_pl[32];
> > > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > > +	struct pci_doe_task task = {
> > > > +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> > > > +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > > > +		.request_pl = &cdat_request_pl,
> > > > +		.request_pl_sz = sizeof(cdat_request_pl),
> > > > +		.response_pl = cdat_response_pl,
> > > > +		.response_pl_sz = sizeof(cdat_response_pl),
> > > > +		.complete = cxl_doe_task_complete,
> > > > +		.private = &c,
> > > > +	};
> > > 
> > > I think this wants to be macro'ized to something like:
> > > 
> > > #define DECLARE_PCI_DOE_TASK(vid, type, req, rsp, priv)
> > 
> > I was thinking the same thing after you wanted the task init here too.
> > 
> > Can I follow on with that work?  I think the following members need to be
> > wrapped and hidden from the caller API.
> 
> Since this patch already needs a respin you could just do the simple
> DECLARE_PCI_DOE_TASK() now and figure out the hiding of @work later.
> I.e. keep the INIT_WORK() in submit for now.

Never mind what I said.  I was thinking you wanted a generic macro to declare a
task in pci-doe.h.  But I see what you are saying now.

Ira

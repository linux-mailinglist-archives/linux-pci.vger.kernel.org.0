Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DDF556EF2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377133AbiFVXSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358375AbiFVXSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 19:18:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCD83EA97;
        Wed, 22 Jun 2022 16:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655939918; x=1687475918;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MUNY5ADLt7XePmsaWfWbd6ZvaSX4sBlK3AWXzcD4cOM=;
  b=PCosBskzRChb90a8q+RknWGcr185iYbcTnlO2X/n5l4cdkYYVq+albv/
   8smZHggx+A9SZBjZ2nYxy4GNdJL0VD8sKdoJDizU9hwZSaf67dnzoBwFx
   Ig5yoYqzBTX0N0yV8yCLug0h7zuRM/aFm6A6Tll/F94VRlebLaYhyxjXp
   t5Xf1bXSWgEsAld1PpKDcBvEEZeUHv4IopBlDjSi2mB8gPhmbhIod5W3d
   8fXVKcxRWcRqrzT1GMWBJQ/qheWuTO3aSEZTHtr2gRmSUQaCHcoyfdhJX
   eDRf1q9GAYJjsSmRiN6m38EF8+O7SmmcGVrAtYh1iSdAgIbstSX5TlkB4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280618414"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="280618414"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 16:18:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="677799103"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 16:18:34 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 16:18:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 16:18:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 16:18:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmoO5YfRBWuw4Ien3GD/5SJyrj2AR1pDmQXZxQqP+RcGVKVXWjwUlALocivg6mIjkm6yGkBo3Y3Ey3F0Gr1MSndu41335B3XfnfTZgVpeCravqkJL+bTjV3EUn0prDSfmKRPiN0K+Owdd9bqj8odmUyfAvsREk2xKEEzEJXu1awkQnl+ik+xRpElHGgi6P0n5Wvw4p8zahKzC7GUKSmw2lexVnP64YT7gvfPxJ3zfq/TbNsAQqXwJ2p5pPQzZXylXO+61EBhJFrs+bOgSW69lFk2WSiOmwxs2chaz9uNy6cXDjKi91rxKC0npB8jxcbK6Wen85eNES3WnCu4OGwAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7jNEc4w5VPce3uvWzDRsUjHi/sQXh+DYZLNqbERz2E=;
 b=MjjwDhomJunq9ZBfzJCFshK3IA5PJ1v4EnSKEHvHQZSRI2fFgsTO0gtZK5TEXmdmIcE8G301uwbX7K85AkluvA+6Cfx3W7gcn/GhNJKnbIQPdbkKGQJ+loFjihBPpQeOnNSDyKWfFeff4iuuWiZ0d5PIa7weD6CPn4qnXyK0Js93CLKXRV0D7y5o9kYbm0q2mgHMM++nXDqlPzREglln7GGlIKfgp3lpABZ3qqOCrj/Cc+fqR5diHD1hR6xwL0rwT05X51i2D0iG7twaT4K22wVdQJHN9GZDzhlRGRAzbKDsVQE1evcVranG70vPyP4Al0IOYwi2nxHHdeWRFcwORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BY5PR11MB4038.namprd11.prod.outlook.com (2603:10b6:a03:18c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Wed, 22 Jun
 2022 23:18:32 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Wed, 22 Jun 2022
 23:18:32 +0000
Date:   Wed, 22 Jun 2022 16:18:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 4/8] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <YrOjQ3IkGZpe1lpN@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-5-ira.weiny@intel.com>
 <62ad11db18883_844b129415@dwillia2-xfh.notmuch>
 <YrIOD9ttvAabfyNu@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrIOD9ttvAabfyNu@iweiny-desk3>
X-ClientProxiedBy: MWH0EPF00056D06.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:10) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b32214-989a-4aa3-1790-08da54a585c5
X-MS-TrafficTypeDiagnostic: BY5PR11MB4038:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR11MB40381BA013DBB013E75A5CC7F7B29@BY5PR11MB4038.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHeNAzwT2i0Mjv5uuz5Ws4Fg9fVhIH32xtTCFbZ/iUmw+rzt27De8SapJf6XO65qZ77jyW1MVXk+fFDb3aMuXRZ4IhBoxvo5XEzq5seI7W/UN3uRnAz7M4SV24BowzENX/DH4zSMMBpAe8OJKi2cy9lmQFUjMrTFbtmFjWq3e6QkWXVPjyqKGF4dTNYyKCU6ebCq+dK9u5lQkL3t8ifL0nx07vJxBPtvewKvJTgDKY47rbabN9840DCwyfCjNMIlWeorZCjMR2ojb7YrgFMZlQk5ishu6SHJV5Bk1BrAjo6K4IEwQ48Vj3eoJgIQWWOzKk6zMNTNPTX69bgKJnyHieKGbCBv4Ue98lDbVJa3/GEx+l8n9fuGzi48nh4NZuT29Ji8ZO05HQ2yLxrgj44iVu5jUmsfRC/KNnTjG/uURJy15xaBNvioJ2ir90z9IJBZY5XYXweHUAfDPjhCB56IXgicxVvVif+ZU/nFqeUEbdv+by2KzOFnb0i3kdPRT5k5so88ieC1yEoyr1DogdGHbvAwy4tIb0h6DLbmp3EwoRvwkRXOKyc++d6xLXjDhisnhnQhBl0kCommTUSpn3gJjPJajCwqTH/5EXvsZw3twDGQMOk0b9IOjEi2EQbx+by41k3o13kjqaI+WI1RNTi61yaDqcnaypLTP9C0JIOcc8V+JbVuGzuIDfSor1Cb5wRwJdrMdZdz3H/sOOT2PaNZjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(396003)(346002)(39860400002)(366004)(82960400001)(86362001)(26005)(83380400001)(54906003)(186003)(9686003)(6512007)(6862004)(38100700002)(44832011)(478600001)(2906002)(5660300002)(66556008)(316002)(6636002)(66476007)(15650500001)(66946007)(4326008)(6506007)(6486002)(8936002)(33716001)(8676002)(41300700001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bkmqoImBR1OL/i9Jk5WZJL5lGOcUC5fNMUUCydaob7KKqPUeTFsssZt2L65B?=
 =?us-ascii?Q?lsPY1+mHJThTwPVtmmUM97texcPcQSFQtNL8+nUXmZhjktJlj62ZvlHMase7?=
 =?us-ascii?Q?4RMLdTnQAo0dGhkWXZ+fjpLPyQkuey32764Ukyq8M3tMwz/duphqlp+iTPn0?=
 =?us-ascii?Q?hSY659dy7kV0daSXTN75AOTfWNHahYUWHZ65kCJVbiEj/yBUZku4aotn4ZVQ?=
 =?us-ascii?Q?0IB5evBxquX5uV0g1DRp+S2UTTC8CWcDC5WfEtfiM/KOJPoI9/G3t/Isl8hM?=
 =?us-ascii?Q?Tmf0HeKqM/DG1Siw75qjjZ+T9cTVtscB86A0SvsJB6xGdyIgOxk5WtHXCJT5?=
 =?us-ascii?Q?4+jlsORCgZT809mPIxBdDiYY327W4/HTKURWPO/YrWE8ZIirO6hfRGMuVwHQ?=
 =?us-ascii?Q?0qQfvx5tER6ktIwVhyB7p/UgtO8oc44hZ2r+lk3KYkvRejNgrJidvdesl0cr?=
 =?us-ascii?Q?HU2qVq3QZsEUb27eCUUdtngJz/ivOztGfX1aI6Qrwhm7eVLcUBykTtitisqM?=
 =?us-ascii?Q?aPiuXpXdaXzNmgIacR9I50fUCLyp+yzLwC7J2OSlcne2OEvwc+i0GFp4YKK6?=
 =?us-ascii?Q?lzi3PDqTvoxzGyBr8VKqJoIp4dUVwmeErLBTzTG2b8dtDx3lqJdoLJR5cKJi?=
 =?us-ascii?Q?iJtohWsszdizh1Uv3PXj0dV/Yqm6PmZK53GyTPYTAohaA6bPXclh360bpnbg?=
 =?us-ascii?Q?pjYhtSeWX4VadZECBRyUBEqV309gMYuEiAJ/ru92tO+S9ZOcXe2KeU5uj4Dq?=
 =?us-ascii?Q?cmOCPq02B6UVHvgYZlDzmsQhst2+znY5ppoe0p3xBN18GpM1iy3sG82Hp6hd?=
 =?us-ascii?Q?a+jO/SmXUFtVQYx5ne0ntVQZb2h4KTEMIiAWJH1LQ61js09uy30Z8d+exBU1?=
 =?us-ascii?Q?Xaq/15q/EFrMAfaH3PUSJFpz5TNLfM4dOE0giJuVW+wPbHBoGFFQjOCV60Et?=
 =?us-ascii?Q?BLQq98LUoLa+CDDPk9c1ty06Y6YhAPnxd4EM5l3FYf+BgQfcHXxsOx9SBfxt?=
 =?us-ascii?Q?0SErJlbsutfiXvpiircTIUysw1xoPSRoRpQ7C635QeFMtCKvve6EtVhPFMz0?=
 =?us-ascii?Q?icRJ4yezlALPFk4bsAqgQQtOGq+EKVr5PW3xM+quYEzH1QwpJ9fjgu0uD0N/?=
 =?us-ascii?Q?AIsLuz3jtFthAH4rgfqWbHDjZg6kRcffQHvgg0WAcu8ICzJQTFS1WHZV9Qlt?=
 =?us-ascii?Q?DVVrP3kC3WIPVFf/bSI1MKh3E3xG54FEBiNwvhSB44z8J8Dw4dv6/I1GLTjX?=
 =?us-ascii?Q?2xIPjcd5V2ZR+PIu50SSveu8iLLAGm5hd0gzu5LgYWFhfiRyaI8rNAybJLlw?=
 =?us-ascii?Q?+xiwUw50/WacAHtIEDs/buDs9pjenFjWi+bD4yoYeBuFp2gCouiD4TGSXH5z?=
 =?us-ascii?Q?0M55Um4cdvfuPeKX0M2iiZY38kFyYVP/qYHHZp97U6ohqOie1KU8OhQYawWo?=
 =?us-ascii?Q?Db11DY+2rAqGXUsoBYRjHU4gJsFKpe6i0qJznjNNivD4r0PBYPaP2H+/Pzvb?=
 =?us-ascii?Q?4F7dvzZPk2l0SE+I7s1iCYX2JcSQgGUJ9/LYRB/uMukV5/AWpeWUP8OaVT8l?=
 =?us-ascii?Q?rIc9U1dokoaFRssNmGijEdPnRYrE/XQJN9Hu7qWjJ96VgS7CLaxDeoPwlxfm?=
 =?us-ascii?Q?Bwfm26ZT+BMwgfSq5nhgLS8v5VIl1Z6a08734Ms3f/R4g/xdTVRRBlnzS4LA?=
 =?us-ascii?Q?60NxewXTapRW33nb6SZ0kKEvvHd2caSJLSBzw9xeQ+M4R9PwPrVg15qB5Nfk?=
 =?us-ascii?Q?ncRNeyO8r+oqFfigeeBAGs1lk9QBKdk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b32214-989a-4aa3-1790-08da54a585c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 23:18:31.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAeZmA93gxCe8wLmBwmbV5hBNdC0aFbGRSp7gGfOmrBdr5uTq/C0jW5BQKy28SK5Nwp1FshOCAQc26bLHR1XcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4038
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 11:29:35AM -0700, Ira wrote:
> On Fri, Jun 17, 2022 at 04:44:27PM -0700, Dan Williams wrote:
> > ira.weiny@ wrote:
> 
> [snip]
> 
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 60d10ee1e7fc..4d2764b865ab 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -191,6 +191,8 @@ struct cxl_endpoint_dvsec_info {
> > >   * @component_reg_phys: register base of component registers
> > >   * @info: Cached DVSEC information about the device.
> > >   * @serial: PCIe Device Serial Number
> > > + * @doe_mbs: PCI DOE mailbox array
> > > + * @num_mbs: Number of DOE mailboxes
> > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > >   *
> > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > @@ -224,6 +226,10 @@ struct cxl_dev_state {
> > >  	resource_size_t component_reg_phys;
> > >  	u64 serial;
> > >  
> > > +	bool doe_use_irq;
> > 
> > Don't pass temporary state through a long lived data structure. Just
> > pass flag by reference between the functions that want to coordinate
> > this.
> 
> Done.
> 
> [snip]
> 
> > > +
> > > +static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > > +{
> > > +	struct device *dev = cxlds->dev;
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	int max_irqs = 0;
> > > +	int off = 0;
> > > +	int rc;
> > > +
> > > +	/* Account for all the DOE vectors needed */
> > > +	pci_doe_for_each_off(pdev, off) {
> > > +		int irq = pci_doe_get_irq_num(pdev, off);
> > > +
> > > +		if (irq < 0)
> > > +			continue;
> > > +		max_irqs = max(max_irqs, irq + 1);
> > 
> > This seems to assume that different DOEs will get independent vectors.
> > The driver needs to be prepared for DOE instances, Event notifications,
> > and mailbox commands to share a single MSI vector in the worst case.
> > Lets focus on polled mode DOE, or explicitly only support interrupt
> > based operation when no vector sharing is detected.
> > 
> 
> Ok I see now.  I was under the impression they had to be unique.
> 
> Do you think it is sufficient to check in this loop for duplicates and bail if
> any are shared?

I'm still removing the irq code from the CXL layer but I had to look a bit
deeper at this for my own knowledge.

I don't think shared interrupt numbers is a problem because the
pci_request_irq() used within pci_doe_create_mb() specifies IRQF_SHARED.

drivers/pci/irq.c:

int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
                irq_handler_t thread_fn, void *dev_id, const char *fmt, ...)
{
...
        unsigned long irqflags = IRQF_SHARED;
...

So I think this would work even with share vectors, right?

Regardless, setting up the CXL/PCI IRQs is a bit of a mess.  So I'm still going
to remove the IRQ code in the CXL layer.  But I think it is safe to leave the
IRQ code in the pci/doe.c layer for others to use.

Ira

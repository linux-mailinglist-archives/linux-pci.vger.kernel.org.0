Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7B56D14E
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 23:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGJVBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 17:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJVBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 17:01:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFD013CE2;
        Sun, 10 Jul 2022 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657486895; x=1689022895;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gXgfNJC4f4xtoxxuxplAlvK6rw+aU6hTk1m9tYsAd/U=;
  b=KblM+x56aKPbDCG7Bdrweht1VcYe50i4t6gcgPXKS0DgCZV/3rrz+MIV
   vxVizFyz4oeWuLisPeLuYPik7hq3XCfaNgKwi691fr6Amf7OZbST7o79R
   kX51hAVmrR2K+mpLHp0ETSIbGhjWpi8cuZ1EbESZO6Flp1l6iy+YuK8P6
   7Z2LLDgUUJhXv1OF1yp3dy1RLr3O3ReiAdh/PQ0qXFjMnBbceyZgkKQO6
   p7oV5twjw5ZF3XH77p9v7mfnwAMrMOhiR8jY/a0nAsl9TQiLHN3/wYkND
   BkutP37Xd6D3aQ9So4Kl3FDVvc+uU52BY+WLkvIgUSw++2+H7WFdH4Oz5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284559914"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="284559914"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 14:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="594670578"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2022 14:01:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 14:01:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 14:01:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 14:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byAeMnnZfiHktrTNqSTyRrBHQoASDnuyPTKHbRnB0cYIMiVVD4YFu7Y2ADc2qyvrKtNiMLeQAwjF+b3es7rCNP+FOG+FTKwiQMfHJbrimYo4ReG9vUopb7agukrAAb4EFIC4KWXNMYdhp1pUNxlhEjMRbxBF5Y0dtB49wlHo/6WSYgrjA6pL6w3cB2oXb2G2Yx0Iz0KvCHQvg3LQCH4ElqiW8lIHV+0U3xkbV1gA5M6LmtHP7iN8aWi7ptuz7f0vToKr5kV0Xa+wLlu4rjTQbv07m4ZRXtM5ZqAqxP1zN+aJwsEv8BTfB4ZThF1lWWfA0Op55RuRwjS3Kerlh+c7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z19lfXIn+leg/b49qdKvYYsqwQuBk88JC5YjkMw29H0=;
 b=IzCC6wSDl3oFQz7zWO6QJRrLLk6xEDldvqiPfjdAq6qb139yjxF7oG8Rtr+dpz9SrgjudCCMqojkXBL81OLBg2aBeLQ73lWud+DIAw+ZjqoFX25CL2LUB4eEUK3XKpjxFgSIVFbJ+noqW2+LFRwDFFHbRK+XrA6Q8JRfuaPVFsjoz4Dv6yPRmLg5tEZD+TJ+jQHT3HMdefrcpY67fH1VH3HLrlksS7asmAhHZUHOFJMXDC1zW1T/z0AcEf2Z2MyPnw/cpgd6t8J2ZP5cs8s7vFIG/g5b1miYuX4G5Lh1gUy6a3hn1yrt23escIUkSeMHlln8uRkA0J8HUJeyBrcMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6467.namprd11.prod.outlook.com
 (2603:10b6:208:3a5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Sun, 10 Jul
 2022 21:01:32 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 21:01:32 +0000
Date:   Sun, 10 Jul 2022 14:01:29 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 32/46] cxl/mem: Enumerate port targets before adding
 endpoints
Message-ID: <62cb3e29daffa_353516294b6@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-7-dan.j.williams@intel.com>
 <20220630104820.00006d6e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630104820.00006d6e@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:303:84::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ef2caee-44e6-406f-e41d-08da62b75dc6
X-MS-TrafficTypeDiagnostic: IA1PR11MB6467:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZGc4m57x3vA2lr5OXwfw8d2/AJxZMLKRYyLyh9b6wW+nW/YG8NZrg1DZGNA0lVeH+DKfcgtYZrB1W/NjwXWElGUWdzflGUGsgeL7/DNHRZdb+NbBNc8zfnLVU7vgusz3KveCUeznWYreNUJCVmK4vBGnD/rnIJYO7w9mLhSSI9am7Ntry/+jsRyVuDZTta0zjs0f5Re+kERAhk5lgVNNnVUPrvHtgFiNr+upLHnxOEhssJgZ0FsE61F8Vb7d1vm3+SNjzDSX08ztAnWtibwKbp1cRa2S+jiNjVeC27kHWJfCCI/eO5QthLxAXdyC/S6lpV5mmKF/wc0a3fchvCbgeF0Ccz06Kby1kxM0ZpF/L6XFTD/sO6RF8DjmpRBhUHH1YyX1GAwm/SzKcnuhcsyfxpiv/3oM0GXN6EOMvDlEa4IV1KudQP8eTo9ZYOuYigTW6TK6ESxKItWfqdV4H8Ldq3lBkXgrgFYs/nqaPEkqn0zmYUKkc1f4WfxQoSTtJ0z5dMM09rf70xsArqbW0SZRg7d/eiN0ATyL/IzVEThJjGzu4Lkxzqrrp0S9svpSuAeVPt3WTnPdEW32e0i5MBpG2mRLf2TaobbB+3Dt8mHyu8vrU70LLpsMwZ0i9hY8F7L0wd1ce1ufDO3qu32iYWDQ3Mgz/VQJBxtyGZ0nCeukACaF3jrd4vER5jEYvYFzkGh09/7ivAOZF4bzyZLkHJVo1+IsgBiEF73fwL8rLHHA/t1VGGBWKvW9IsX1rW97936
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(366004)(346002)(376002)(5660300002)(2906002)(316002)(8936002)(110136005)(478600001)(83380400001)(6506007)(6666004)(66556008)(4326008)(66476007)(6486002)(66946007)(186003)(41300700001)(8676002)(26005)(6512007)(82960400001)(86362001)(38100700002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yT6Is7ZFfxW6nyTSVGsBaDvYk6hgYVmfqyCBNrLyRgyboXnFGeERu1h14mLq?=
 =?us-ascii?Q?LCA5qK9Bl/RlYHzp/2+D846G7aCp8agpP9augL2QHP6ySbENTwzpjHsDclbx?=
 =?us-ascii?Q?vE4qA4F9yb8y7Rui+Lrm6zKdnlsT7isNvEZ7etNQVaxQBXlMbSZnRuOuiBom?=
 =?us-ascii?Q?r1fTGqB/Fwa+UldDVzWD1aQktr6mPAIia9BGBl9yFr1vjFlYFEAO9wtFFDJO?=
 =?us-ascii?Q?wJiI+k9KOZsIhzM2Tx9sX03BQCSOlZ1zR98xFGMwM0RPoceFq9zPzLT8As3h?=
 =?us-ascii?Q?ERjiN9tAFGuN22Oe44QQyNO27sW2LrS9uuegYbtLcEN7zkwPX7Qzxo9QmAaa?=
 =?us-ascii?Q?fCPhotTUuHJxtXMPB3dYgi74X/m/nVwB4n1SrnnpmZ3M/C4wJeDk0fvMhjJD?=
 =?us-ascii?Q?OLYbRfNWFPmIs7kRt3dpDkteGVRxvjmwQgspLWtnmXVV9r08j0+i27Z8zeZA?=
 =?us-ascii?Q?YEQ7ziAnulJK7dGhFtyukFfGMxRUzD9pxFI7Nk4Mlg4P4um45WT7WYbFmOC5?=
 =?us-ascii?Q?jF5rBt7DYi4o0EgiGKR+fe6ujHGSjJwJZTE9+flLMo/7BuTR7p5XWX4CM6mQ?=
 =?us-ascii?Q?VR6QCqGQZiF5G4touTVqsJke124RCPvBQril9+tALcpVR0l41Kln0fRwVStr?=
 =?us-ascii?Q?1Eb65dE3MCM3CI54x3eyccsK3X3o3G6/oMO/NydGbqrYN1/8RzdTbiy56qq4?=
 =?us-ascii?Q?NremlHtHhykhHUMCj5fSqbBr0NHG4ZJD6KcLrnsYetCGFJu72VxberIwYfEc?=
 =?us-ascii?Q?qCXhmXYtXSxx/s19F7DjRRrTf9H1AAI3lqYIIAozCYDw6kBpmf99AHEO+Uo3?=
 =?us-ascii?Q?hzwDvsFqe/kf+9D9hpr+l4WydqfAqljmCbqlwc7RKoOrx2eepWLf825thcSY?=
 =?us-ascii?Q?dSZNWCzMj/9pTEW3igcICKz4DXDQZW5zPPjlFchWy/Xk8y0/DypsRRMq2YOq?=
 =?us-ascii?Q?uCVrHEdzWE/WxVpK2XQsnWt8rygmgOXwo4467fkrV61UCIRPJgcomL65nLI4?=
 =?us-ascii?Q?w8mFbG97lKGU4VKRHXRykcH3PDUpFh/uWBxf2/DziFPTNSGnx0FyjcyEb+wr?=
 =?us-ascii?Q?itWdmmNbldr0rT4H0YB3OZDjYT0uf17FG3bWVFAaF2BxX7uEe0r0z82DwXM4?=
 =?us-ascii?Q?eLVWpS/RrzsgPzhATqVrzn8aGq49SxoM/5Zg0cbTIQHzlTmNkrhjFdB9lxtV?=
 =?us-ascii?Q?oeiSPOxC0y0MTNW6krIFFNAEjqrhKM29M8CfptdzqgPwP6gUYDpUVFKnp/bH?=
 =?us-ascii?Q?VwN5UMbnXo3TIwSBbXWNSe6PDh0tY/7NeSn58lkJPBlocWQxBX0JoPKOMdAN?=
 =?us-ascii?Q?7ZqBCTtz+kTnQ3gV9tYAGkAyFonBydj1TFE3/+W+OEUmFNmHrfLbpF6OvI4U?=
 =?us-ascii?Q?LcO2FUYR4QFnI/2/6iR1GxrKL/EY1wU07uqViY2jo6Yqft46yTQGctg+CfEm?=
 =?us-ascii?Q?2ovAEtxjil3AqkfIRMEZ2xP1xZQcKezU+f5d+C8diaDKeZsMCwf70S0AMz84?=
 =?us-ascii?Q?xXnIL8l4hjZL3gXxbkf8TWfST2s+kdsoC2x2rntbbRf3SKngUooFlNSym+IX?=
 =?us-ascii?Q?+mMPR2hfA/c8f7IfTBTQ5nJDsMbi2IHi1442x/r3SwdoXNx3JVXRY1G8XzfT?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef2caee-44e6-406f-e41d-08da62b75dc6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 21:01:31.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRlY03Onjd0UFnEZKK7Qcre86iidvs2Eh1FdkIPAKfBfE/3vMlVwXkOged2jsVXD563FjgrOndchTylror0T2wciomCbuHXPwJZd2Lg/Mq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6467
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

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:36 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The port scanning algorithm in devm_cxl_enumerate_ports() walks up the
> > topology and adds cxl_port objects starting from the root down to the
> > endpoint. When those ports are initially created they know all their
> > dports, but they do not know the downstream cxl_port instance that
> > represents the next descendant in the topology. Rework create_endpoint()
> > into devm_cxl_add_endpoint() that enumerates the downstream cxl_port
> > topology into each port's 'struct cxl_ep' record for each endpoint it
> > that the port is an ancestor.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I'm doing my normal moaning about tidying up in a patch that makes
> a more serious change.  Ideally pull that out, but meh if it's a real pain
> I can live with it as long as you call it out in the patch description.

No worries, I would expect to be able to ask others to do the same and I
should be more careful to collect these unrelated fixups separately.

> 
> With that
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/port.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       |  7 ++++++-
> >  drivers/cxl/mem.c       | 30 +-----------------------------
> >  3 files changed, 48 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 08a380d20cf1..2e56903399c2 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1089,6 +1089,47 @@ static struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> >  	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
> >  }
> >  
> > +int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
> > +			  struct cxl_dport *parent_dport)
> > +{
> > +	struct cxl_port *parent_port = parent_dport->port;
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct cxl_port *endpoint, *iter, *down;
> > +	int rc;
> > +
> > +	/*
> > +	 * Now that the path to the root is established record all the
> > +	 * intervening ports in the chain.
> > +	 */
> > +	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
> > +	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
> > +		struct cxl_ep *ep;
> > +
> > +		ep = cxl_ep_load(iter, cxlmd);
> > +		ep->next = down;
> > +	}
> > +
> > +	endpoint = devm_cxl_add_port(&parent_port->dev, &cxlmd->dev,
> > +				     cxlds->component_reg_phys, parent_dport);
> > +	if (IS_ERR(endpoint))
> > +		return PTR_ERR(endpoint);
> > +
> > +	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
> > +
> > +	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (!endpoint->dev.driver) {
> > +		dev_err(&cxlmd->dev, "%s failed probe\n",
> > +			dev_name(&endpoint->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_endpoint, CXL);
> > +
> >  static void cxl_detach_ep(void *data)
> >  {
> >  	struct cxl_memdev *cxlmd = data;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 0211cf0d3574..f761cf78cc05 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -371,11 +371,14 @@ struct cxl_dport {
> >  /**
> >   * struct cxl_ep - track an endpoint's interest in a port
> >   * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
> > - * @dport: which dport routes to this endpoint on this port
> > + * @dport: which dport routes to this endpoint on @port
> 
> fix is good, but shouldn't be in this patch really..

Rolled this into "[PATCH 25/46] cxl/port: Record dport in endpoint
references" where @dport was introduced.

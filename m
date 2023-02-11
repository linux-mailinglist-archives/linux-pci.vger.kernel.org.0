Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E276C692BB8
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 01:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBKAEu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 19:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKAEt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 19:04:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE507CCBC;
        Fri, 10 Feb 2023 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676073888; x=1707609888;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tmSp12sjza+qDZf1GicMlKPcjO/P2UliyrOsH55RxYc=;
  b=HEq0RFyVrdVwUxaPYTPrS04aRo3Ftg7T78+Ao7Pkc6yzGxwwG1sVU2qh
   dveiItf5fIUhWn5wiX9yYNZU9fxBWGs788l0ieyWpdJ0wqc6cRcN9Jf8N
   2CHlZcNGp4SEkNnuBvFUl9+75mnglV90OMaoD2T5YsPGfd2nRkv35M/2e
   8w7UHOgHYuliDM41m2QQE+A6R2L0Ha5aHmQEP0r2RyAP6I1oHjjzuc5M8
   X7seNWuy/CBMwvuzcnc3NwIJ3vxQ8qYZyxCzCtM6zX1nk6WpBORn00YWp
   2HBSYfiaQpDx3lbqfXTMtYKYCKXreDqK0MuTLAfFxHt07rH6iABCe1eG3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="332699361"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="332699361"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="913712860"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="913712860"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 10 Feb 2023 16:04:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:04:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 16:04:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 16:04:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClqV5nr953uou9q4vK+rX44xObJ6yMsL9PfIpSe8bJedJft6FsmUb+JffS17pUNPz67p/NiQLziwPLRVTGBMe6wvahWXGjwFjj7QhN8AW35IM5NexYCGyy6aF0ZpOCiHcRRyYTYJLH+qsqgQZPCVrpnpWwfMY9QpiYALf9UX85B/VKQgIvdNccGIXPc2j7k8+phVY1cc1BC0kXCyJ0niEsHMcS1FWpAdEFS4t5xkGiPyrVHPLUlaihvWBDUiEmnHhF1BGV85DwpCok1K4zwfwux/2kX5ed7VPNFK2YvZ+qikltEQJqJri12WKbjnT6oDH/RttoYj67xTnLPQu1lcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T6PgJALrNavNenGL49envfS20/+WNrhgVjxzELAHbs=;
 b=cz9EGIwTMounM0vkfsE7HjZ5eBicD5g+znHAORKC0g80gqIlPQuDAGLYmROtR9CSMOhWHYGhvZmiya48qez8i9juLy6V3MbTVj9o5zLS9EHgUrur5MpqcEzuD21AB7hGubCU8efZ7ZEtyg21AniOLn5grNUyIeB+qxpAuFe2qKe/1lvGK5jEFyFdmoR5hLUaYh3Y9HXLg2FUYQtYmd7vtXBfhLcdIiCqEutq5uw7OXMZyxPMS3ouL80IQZrGbdWHtUn6S3gM0ZEDNmvBmKDQKE0EHDo11Zm9BdiY3zVGKh0nyT3Cu+YCS3ubygL3eZFoeTEOMfjielsGH0Bn87LVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6773.namprd11.prod.outlook.com (2603:10b6:806:266::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sat, 11 Feb
 2023 00:04:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 00:04:43 +0000
Date:   Fri, 10 Feb 2023 16:04:40 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] Collection of DOE material
Message-ID: <63e6db98ae212_1e49432946@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <20230123223053.GA994135@bhelgaas>
 <20230210213915.GA15326@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230210213915.GA15326@wunner.de>
X-ClientProxiedBy: BY5PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::43) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: d35ff4fd-770e-4f72-b1b2-08db0bc393d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YII9ZBrIbjC0e79AhLILiHBsceHoQsFg34VkiQ2K+hWU536bEywjxOnQKIziDVAezC9Y9CtYX0YXmxcci3W2mqDcE4qBzbiB4R5Jln5oyFAR22lYjQgMBcJvY87NvZs3PsYMNVZpABGor3BWxx4do5ZIlDkMDCeihe+2AUKAaSQ11jL45h5Sh7RYUsYqibZomPSECE5a4ViSGdLrFx4Jr4/SoaswhgMQUC3Oq5ocBWTUrsJ7YUa6Dwbo3tDB90uD7QjJQxy6qOCM/oEaaM9cfpMO7Vgr0901fh1pFmudsVLOGzuqyFzP3VL5XkU9V5Z49HzbQ+Qnc0XjbIKGUkDe6/nTLcl/Iqf4zKOsnPDhSC+5zSzqKNNA4Bn3LcUT7QdPG+m/3UgPErHgIspugj4WP4Y83GSgAUN0vasWcFlPzhe1Dj5uk10z0pNSR/lwPBLeXGq8i5G3GkTLfviAbiaKEPGDtLoNCfOU47b9G/Xs8zHtbvEsXKrCBM3D6vxn3UlVHsW8mMUokkQeM8zxzJqNBBREf5o74f71Fkci4ySWQrMVUQXz1dYDF/XLEBFOa/wXjnYPSYUPeRfMGGmwbx5i5W1m4f/1QJLcOs5+vXUdFf5Hva+3A1pGWau+uCdAdaOxEoBycdAMo/qchN53bRRlVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199018)(38100700002)(82960400001)(26005)(86362001)(6512007)(186003)(6506007)(9686003)(478600001)(6486002)(316002)(110136005)(8936002)(41300700001)(66476007)(5660300002)(54906003)(2906002)(4326008)(66946007)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/F5l/CKXvIQG4nFiPBiZoI6ylzTp0axIkJzandUwPz4owJClMdyebl6kkMp?=
 =?us-ascii?Q?mOBrLyKFOHUz02QzQz7F6ODuBmrAlCNZpuP5P+c4A8PykbNkrgXf7ufpKFng?=
 =?us-ascii?Q?oI8Qbk4d83EsRSAVXqdDIZFTi8alBbclwDGsO8pQ341R13HCkuTwbJGsxnau?=
 =?us-ascii?Q?Scw7b39phty1rfqqn34KR5QOFyzARznfLd7GHp2FZ7sO51DBOcN63eA2SJfU?=
 =?us-ascii?Q?WsBf0msIb6gztcsBJ8okj7BSxyEF5mmEyBiIKUNygZ5BrFgfjvKm0xPeQk3R?=
 =?us-ascii?Q?1uScnTJs0rQuHvKfIE06/jAKGShO9OB7TE4QBXyNFH/TyvdQp4nBgS0j+QvA?=
 =?us-ascii?Q?C9FkZ0y1twe0PuqLZQHPUeD3ccXpzRbJ+zxGk8fK6WWiWfvUJNI7JnnWZqzl?=
 =?us-ascii?Q?uzQXfb4lBKMHLxGQ397taUYQbBG1vGkwpAmuTzTUHl26Y5debgJJOOGUZ78W?=
 =?us-ascii?Q?wzVEJ2g+UFDKCIULvwV/rYO3GQtCfqZD3C/vpM6IGtEoU1KRuRA8XUZsomG6?=
 =?us-ascii?Q?dlF1I4zQabXstdSjCYELBSwtAyEJ9ExAfmKDMBuYodrOilNQ5F3OqCCQzUgj?=
 =?us-ascii?Q?EHzU+5uZJWv3Zo0oAsodLsIqJsSVQsTuJvRu3oBIg5uM31n4SvmnIGHWKAEh?=
 =?us-ascii?Q?YFe2PzoqP+UyWXNu0XPmBHjpyFOA1/poQxWMqEgiJbQ6DGvff8ERsAQUvKam?=
 =?us-ascii?Q?n/hnO09vFVpOrYihdoCNXYsKiuTUFv+OMsIHZZMxWwq3jin0Rin6npYMADTW?=
 =?us-ascii?Q?1aOccO65PCG/VVjHKq55rRXKWuD83iO4V487cK0CeWGC9G4dMV+maMuorBKN?=
 =?us-ascii?Q?bAAD+74l6AYswW+Hja1TbWUKmBAf+1UDitkQQhcqcgyRiWcMt6RwAQ8OiKpi?=
 =?us-ascii?Q?SbQw9HP3ivu7sA6sq/+RULNZeNWUWIgVo3wTL28aDY3HHPHstX5d2mKhAhbI?=
 =?us-ascii?Q?ncqNnUxL667uyJpF2qN5NSo2YRScchgOZbJgK8j1DHk2qI6cQMNfiDITHzdG?=
 =?us-ascii?Q?1+mZjq35VdPkq9FavY3Yt7P2jX66RQM/NHES6IdX5YrjtPN5WfPGKrsGsoDF?=
 =?us-ascii?Q?4cB8Dt+wTw8PpX6YdVVmCJYu+a09jD2J/Fy4jXyYRqapaMz0PQgaK1PUCdr+?=
 =?us-ascii?Q?vMC8UPGenaKXRua1+I3NAVwWUBrZhY98QiGaAFpFfSLSdFQVM/h1rWd0kzua?=
 =?us-ascii?Q?IowiHvz1o9K3RYC46eijOTT5+perUK6ZNxI2O+pMCl72baoyrFFgN6YNnz4d?=
 =?us-ascii?Q?769cU2mc7rdb5baJfa9OiTBfJ9z5Rp4lZb1Da+YlspYwXQyhg4GZtRFeuEU6?=
 =?us-ascii?Q?vzePZPUr7MdwbCM3XdnCu1haZ5eg1o84qqT4bKFUPVJZ5N4G50N/LC0e5+O7?=
 =?us-ascii?Q?DOzlnG2RZYKDlCTvLAO9aspCsrb74MazCdSryZ3v5XHvZqrOOZ2ZmgKcszVu?=
 =?us-ascii?Q?rDHNfuGPgPqJPPLYQCVwXXalKvgLYwlE7MlW91QyXLpWj8314+iRHP5LTifd?=
 =?us-ascii?Q?cUm2gxQUUbg6ipNmo34++BAHhyUtn12aevepYOTW1vE5HQQxk4JG5iHZ6g8r?=
 =?us-ascii?Q?+KWB2Ru/6t0QoKuM8D/iGL3l7H3iAh03rVi4oPx1QPzjO8y1IHPXcZRtj44q?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d35ff4fd-770e-4f72-b1b2-08db0bc393d6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:04:43.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdPBg7MbjPuGvw/FwLI1p2NZrA3MaY/bVIqKYLLdhlWigoryP5TDSWGG+FDqGWg0GwTyZBR9zZjPFadRf7Um7vMqZjk8ak8McXG2gULa7H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6773
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> On Mon, Jan 23, 2023 at 04:30:53PM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 23, 2023 at 11:10:00AM +0100, Lukas Wunner wrote:
> > > Collection of DOE material, v2:
> > 
> > Do you envision getting acks from the CXL folks and
> > merging via the PCI tree, or the reverse?
> 
> I do not have a strong preference myself.
> 
> I've just submitted v3 and based that on pci/next.
> 
> The patches apply equally well to cxl/next, save for a trivial conflict
> in patch [13/16] due to a context change in drivers/cxl/cxlmem.h.
> (I'm removing "struct xarray doe_mbs" and an adjacent new line was
> added in cxl/next for "struct cxl_event_state event".)
> 
> I recognize that it might be too late to squeeze the full series into 6.3.
> However, the first 6 patches are fixes tagged for stable, so at least
> those should still be fine for 6.3.
> 
> I believe Dave Jiang is basing his in-kernel CDAT parsing on this series,
> hence needs it merged during the next cycle.  So if you do not want to
> apply the full series for 6.3, then the last 10 patches should probably
> be picked up by Dan for 6.4 early during the next cycle in support of
> Dave.
> 
> All of those ruminations are moot of couse if there are objections
> requiring another respin.
> 
> Dan, what do you think?

I am ok for this to go through PCI. I will go review v3.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA3864A97E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 22:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiLLVZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLLVZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 16:25:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2380E1741A;
        Mon, 12 Dec 2022 13:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670880306; x=1702416306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aDteQ6DtvW9h+ePCbnreJu+ubUxADDdM3EbGrxhOak4=;
  b=P5bYi5K9jvLpML47WbIF8/g+ZSfdhBgt82iT/qDsc0XUGu/twNpLHwz4
   33l2uVhZjWMEcAo83VohByS29r2rJUNqogz6XS0P6ABxqb5tYG20pJmWN
   fvCd6UlVr0Y4iDa6YkYAf8PJjWVpWPHTtzpU/I4Y13AIPZiTUiC09hqcd
   pvrSKJ2ls5ySCajNeMScUbEpSzwR90jsrOoVch+M+C16wWo/um5/qKm5B
   S6/88GXZOaWsZ1SfHPtMMXVKQJwRzmXDTytZH91z0dpM9BCRhxKiNII8q
   zb4XqloKRA9lpitQQlHFou8MKKmIh5VDC21U5d1a4JWxnKACdPVl0um3T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="305610955"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="305610955"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 13:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="716955399"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="716955399"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2022 13:25:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 13:25:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 13:25:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 13:25:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 13:25:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7YzorSKCc6hEeIBvIfgL8+FrtISj/nUWD4vFW1cJ1/uj93uQdxnbtnyj7msKawPN+hpt+8UK/sMqJq3G7+sfxQwp3FHDba2diH6DtT/TAOQd8n0oU6dt3C3iw9vXLU0oc2sBvw0Fg5cdQus0vm9Ze1YglUdhG/1OBgkxjdXjdMoNrdyDiWvEcZa2DRTxL9xZs0Y+f9zy+U7Aq29CBM1Y6HA2uSDTAqsGAR4a2tlWHswzAgQZP2MSVcRjuhSOGSJeYBCiCzgvU3UeIWCyLZHTlJ/0YOolXeQ7gH1vDD4oa8A6mjLjruwtFVkWwo9II0736B+9emOZsfc+jBN4ZbT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9NFwJ87h7/7TvXk6VxCsBkcvWfZy4/rt2kc2PqazjM=;
 b=HzuyiNCCb+m027vm3nkgZ91fIPdXsSQfU22qKQ7M2QtAtqy6hC1dfB8zXsGUS0cxTdhY0Dtf4MDtzRJ8+rYu8n5hvRvV/erHQGWJpEnuyQlC8I5eofxzodp6lESsrvWp5tMrNvuTigak8g7Q9a4NSTYHvsdL9QWuO2zYwO5Gov5vo3hvKaSLOEU0IU1AlUDh/gBAZWNMUPR9DbbbTYTapjnEYozCfye6dBf9ZtKSAAuqmLWJ+feovQXP43JlaKLE07F+kpmT8hPPmUxjJsobHi2ThxyShwE5RvVZBzqFgzKuC333TxbX8ERq0gK8144wtgGOTGk541OpmdvTa4/vDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 21:25:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 21:25:02 +0000
Date:   Mon, 12 Dec 2022 13:24:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/9] CXL: Process event logs
Message-ID: <Y5ecKKUv+cz0s3N0@iweiny-desk3>
References: <20221211-test-b4-v4-0-9f45dfeec102@intel.com>
 <Y5a88UgaE3EzJFQh@iweiny-mobl>
 <20221212161613.mz42m7n6eswjwdjv@meerkat.local>
 <Y5d3ArpuLYl4g4Mc@iweiny-desk3>
 <20221212185459.x5wn42exhhycckun@meerkat.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221212185459.x5wn42exhhycckun@meerkat.local>
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a92f885-b375-4c44-1688-08dadc875488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pt0mCmLJZssiF/0XQ1DLqvaxAuJra4f2YVdHSlY8cn05DqGVpFey6Km8bzMoGquKs1xli3AOMXnVMrQ0y6U5xhZNkdCUTnT5QTt0ju1zfNpUDOSe0rCUHAJK5fjESQphrYpHWTOEd9OYuXbJsOrvpMJiMZfvwqd5HJDH2Wffqnhk2KD9RuocIJuWcrQjlH5lz0XMorwCNUZ8FG2PS6ybiLiCHcfidSDiVvbghUL6T3UEQTDu5L30gpdJVHL5x/n71vvRdawQRgdSSJ//tI/7LONoe+GlxfG1ZEkHBfCpHBp6/1VvG4gVOPOykA885WmTpk/U1gsvfaB0QzI0hn00to2hSOyHgqP5tfWzEzEj8MWMpAyfg19i1W5PIpTsvF75a3TL1+clsaKFNkbOhoYNkblD+V5SxDciaaEiZt7yKkVDojiKO2jrHFryA9YdxEX6+K+/B/wxzFY+yrZH0pccMydu31cCcy/5DsF8MyH6CwHbG24VK14HCThbFhTVbEvFec/PHpw3ZvTybpMhaVLsM2UIaHPPXqigYnuPg+HY9++IgGqkZMR9MQrmw5qVPfRv1ZRyoOzAl5y7IpZPcCl1WZCaJS+HBEsvc5jgbT3oF68qT95qGoWb6HxZll8BDyz8Rc98yTvM5mCTpJ542hs6ucFwLYdYzespXlrzL2mUB2Bm2f9i7MaSpKWhGvs22hCyZZNx8KgU955ZHsQZYHtp3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(86362001)(2906002)(6666004)(6506007)(5660300002)(54906003)(41300700001)(4326008)(83380400001)(6916009)(316002)(8676002)(66476007)(66556008)(66946007)(9686003)(82960400001)(186003)(44832011)(8936002)(26005)(38100700002)(6512007)(33716001)(478600001)(6486002)(966005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZoUgnmy6izkldmfYa3n3ukdaBAlGeoF9C7Y21Tjl28YBCPwCzqjK2LQzu8C7?=
 =?us-ascii?Q?ymkq2z87G9eR3V5S/khAR77DviQh07m8Gyn3VCPTop4ZPnnB0kLs1f6cYnfq?=
 =?us-ascii?Q?pOIrCMCt7hDOcM/FnM3eUArB12ud0HJ58hT5U1Sqbx6G+KS39zf1Kg7BqQ4q?=
 =?us-ascii?Q?WNzpPcaE0a1WnpYX1Y7wAkcC4o3VFT9KRW2HuHQmfJ/RRPy/5ln4AlA/Ud2G?=
 =?us-ascii?Q?XoU2x7euSnx4IqB+ZyjPzcyGc6s8IOSsRULYf5MBr5mln7vC8jO3BrrnX+J1?=
 =?us-ascii?Q?fYh7dAGlvDnmIefe81k2I3cXQ58oULwZ9DtySkJFlWBnGrvyN4gRlFZQYY0f?=
 =?us-ascii?Q?4ccqDrRUiBFtYAThXo9slsaLuCskvtXaaPWITisnXR1wyZPJNt1U/k/3IYWm?=
 =?us-ascii?Q?eR4VinzKazmXGa675gtmXEEacAuVvUGH8vm9vhmHE/OmnI/uDMEq6dboMHzK?=
 =?us-ascii?Q?NFR+bt4cUtaGv0C1W6hPJi5lRveifM6DPdY4PRPXzkbDqLNW06TAOpNAAPCo?=
 =?us-ascii?Q?5sPOMR/1MAUaTenPTEjM2Y1jzktW70HrcpHm7YlIPaOeRmQNzOYueqWs8i3T?=
 =?us-ascii?Q?UECyZ4BLybPN8wV9LLqQQKZnuRED6rMrWpS9G6P1+BPzV4aoj14wizljRIzD?=
 =?us-ascii?Q?l6v/E1jiCu/HcgTU12LPc2hl0A2IHXhsxy7smDru7vmb1jEkUOt6Jcs0Zzif?=
 =?us-ascii?Q?qsVpEYmG8ly5ysPSTpAEtqbkS5nItVDhxbO1Lb07MDPYzeazJ7ENxuLACIhI?=
 =?us-ascii?Q?ADz0YvAy9JUX3YUGN/62AicQLKl2ZNbTf6oJdugQjIpPrSoiBIZvmNK8Jnoy?=
 =?us-ascii?Q?TA1ZOGAffYAbf+hyFLCB79G9LIVjkYalkTKO927wSZtQlJHBOUsDBi/hoCVl?=
 =?us-ascii?Q?c3g0neQz+WsQSNG7/hBBSJBPw0XmeRpNlMQrggg4YfX1nvjwoxjN1lKvRlUP?=
 =?us-ascii?Q?tC26ANY19kKo6RNcZa0O2ma7bnQSoliVnQpXKcjHsMF4xwmv9dKmsgHqeHBK?=
 =?us-ascii?Q?71F2MxM8dXLePpyM0k8LB47kT7pDkmmUKFiLwwhdhP7Cqm6Crlz0XA8FY2og?=
 =?us-ascii?Q?Ga64Jgsvr4jjimSh9yIl+99iuzqIQ+iTxKulOeZNKMA+sX2FMMTzAJcm8xP7?=
 =?us-ascii?Q?Ok6BgR//mglrCtfibg85cUWOwzwcRsJY2haEdiCQEGOUBg6guQRhlToU9Y4C?=
 =?us-ascii?Q?LcOMk44JSjldTtAjxB5vPFXop/Ts8plRCnv1AQ4AphheywR81kmJf8wNOh7Q?=
 =?us-ascii?Q?8jPuglNu+xKYUCskczRVT1KKyrXc6hzQKkl4aDIDQoMXhNxttYI02+gQ82ls?=
 =?us-ascii?Q?C2xF4O/8FOm1Ihoyu/8YZpYdmcz3JVRz97fPD499Lit96gHVTZskunilSSLf?=
 =?us-ascii?Q?3x2C13ONYdivVLd37PMAx/PtWBHOpU38rLkxGe9jJWX1GfC7xN3xTKceb+Qa?=
 =?us-ascii?Q?ByhQsv4jsxdt8B6O4dOVA8O+xNYggz49nii/UmSRx4YITbhpMVFsBvC7MmUp?=
 =?us-ascii?Q?9hJE8oNvCqcrFQaLL/g3btuTzIDj5f6xXLBXrCQOmcYIhmaINDv/J/Nyd5yV?=
 =?us-ascii?Q?cngkzsFwT9EfK+Ns/EC1P1c+vdDPlKQOTGQUXSi3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a92f885-b375-4c44-1688-08dadc875488
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 21:25:02.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PURbxJnp+PesJOrpbT1hNieb0AxeGQMJz0MH23YHi6sASkJ3zzgzXt6f3M2WDW+qq94UoIYvLYG3D5bCBQESbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 12, 2022 at 01:54:59PM -0500, Konstantin Ryabitsev wrote:
> On Mon, Dec 12, 2022 at 10:46:26AM -0800, Ira Weiny wrote:
> > > It fills out the To: and Cc: headers but doesn't actually send
> > > actual mail to those accounts. Mail servers don't actually pay any attention
> > > to those headers -- all that matters is what destinations are given to the
> > > server during the envelope negotiation.
> > 
> > I did not know that.  But I was kind of coming to that conclusion based on
> > what I saw happen.
> > 
> > > 
> > > I do realize that this is confusing. :/
> > 
> > Only to those mere mortals such as myself who don't know squat about mail
> > protocols!  :-D
> 
> It's completely normal not to know how that works -- and you shouldn't either.
> 
> > > Should I include anything in the output about this?
> > 
> > Maybe.  I'm not trying to put more burden on you.  But for the ignorant maybe
> > it is a good idea.  I did panic when I saw all the to/cc addresses filled in.
> 
> I added a large notice about that to the --reflect output:
> 
> 	[...]
> 	---
> 	Ready to:
> 	  - send the above messages to just konstantin@linuxfoundation.org (REFLECT MODE)
> 	  - via web endpoint: https://lkml.kernel.org/_b4_submit
> 
> 	REFLECT MODE:
> 		The To: and Cc: headers will be fully populated, but the only
> 		address given to the mail server for actual delivery will be
> 		konstantin@linuxfoundation.org
> 
> 		Addresses in To: and Cc: headers will NOT receive this series.
> 
> 	Press Enter to proceed or Ctrl-C to abort
> 
> Hopefully, it will be less worrisome to others in the future.

Yes that should help a lot!

> 
> Thank you for trying out b4 prep/send!

NP

Thanks!
Ira

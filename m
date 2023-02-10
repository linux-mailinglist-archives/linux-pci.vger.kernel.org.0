Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1648F692B79
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 00:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBJXj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 18:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBJXju (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 18:39:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD35255;
        Fri, 10 Feb 2023 15:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676072358; x=1707608358;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qyq05NMfc3Jo/VG+M5NnZWir4ht7fXNU7VOs3pEGoT0=;
  b=k1cLSToiOwkTlEoc3tQ06VeLPdafJImUfVAvuuC6clTpYPq7tohm8cpj
   dSVnv+WtA5FR+t9rG3D4vP/ntXEKdkr7KcqBnXvAp5hAAiA9+G38Zb/I2
   h5WF2maDNZmab/34mN6OefHdFmcQK1OGmbUqWdk+48hZU0aI5M7mqYj6C
   do8vi+W8KUqgf8NkbXno0jIdTkIc5WqoUc4KJybfnfOvOCDEyH4W+uUH9
   sjxGXQEPRLuRFDfpKNuj05WUQ333/DSI0AMnbUV76Bh+wUh6GQH+GF0jC
   wFzp+9u4u7/gHC4sr6smjKuZgUaZf+zVzUUQPVfulpc9vES/k0n5iUOek
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="318574929"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="318574929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="668213777"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="668213777"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 15:38:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:38:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:38:58 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:38:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ1YjjPb424HO1fueAvrShNTw0mjEkRr8XOjqro+fAlIa985+12vv5KAkPd1YnWbOWK9yB3pyZ7oGnCoDaagdu92mc4vrWs/ZanyHjyArjr8gnU9hd6RoPjfjJSsJlzrNj9S2fYCCsSwG7tBVjC2pp3cpeJzbsbhs2R+4LuQnCSc78y8sT5LQbhYoLz7iLSlY+XONTuYkPTE4P8bDwTgaQ2OZDcrCuSaoKVKCmksbDHTLg8cNKYnQpAo9cXZ0M9m/SPtqHEH7M7VmApIFEctq9OTqUbv4RGtpEaiXtsxQtpWZ2AxExw8LdycwDp8kVfvAGNyi5zVP3cM3vffj1hRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCKAB1MzOix+h7LIt6YbNW+8CNCdgzzONo6sf3dM7Do=;
 b=gyLBNgXpAcm1/Z+HrAtpS1P8l++E9daTKBXznfaO8HRDmnhI/Vl54Qy6PiEUJQ90QHT+2rf82PewhQszkXeFGC58TLClfVZfcBDtkjKkQaqmUTIwagkG/b8aABjXJvtMbmmN2eyEk2i5JpmO9eXw4VU0wmK3gonnuYk3DX42ekWzKuTlG3JDmg2jjEaaNW1Dj5WVNtRFXr+1/aR8/fwW67xDwlSiQqmG1wLYQ6anwchPpGoDyVhGCmCdYa3TNzFNum+IY6MQM2ficZFABNFs92b4v+kKwmX6yyQS9bkoqQcTDKCb40rZ4y800GihVZt18T91n9be7r8BNGgkyFZamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 10 Feb
 2023 23:38:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Fri, 10 Feb 2023
 23:38:56 +0000
Date:   Fri, 10 Feb 2023 15:38:53 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <bhelgaas@google.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6] cxl: add RAS status unmasking for CXL
Message-ID: <63e6d58d7c371_1db5d0294b6@dwillia2-xfh.jf.intel.com.notmuch>
References: <167604864163.2392965.5102660329807283871.stgit@djiang5-mobl3.local>
 <20230210225223.GA2706583@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230210225223.GA2706583@bhelgaas>
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd935d9-2862-43cd-d792-08db0bbff987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OvPSxPVLkKJvByf7jcjlExcHhZITNplSSh2XAPt354oqpHaj0FsMbwt4LMibOiiN8c/bWxWhOQg1qEi/j+0S/TtualfL7pgNpW6TuKKNGDZsE+BQuwFwo0YB3TFl8HKe/J4PfxtRqDcsCrIBbwvOsVfGLx1znq827HdYqQo0rvOvOBT3A9lieDGhmCS2hYcXzbJdMX4SLUvpqBKFYoVD8Fy4ib164X8TaGxc74/KEb6VEkDLhZIRc6E2LRPiPdJQmjjS5uaKwtYOl2lM7QqbwaI+uKEUuIXUVjllhLC0CBCKLY+7z8h7MUwTRCsflEBfQxnJtcQozv+eFYxGJk+TlQ/clfXScYl1rZgWzHkHEt+g9CeYWyrBiEq+vTvhsu9smVb4kazE0OhuJBvS6r6ip0OlKu2n+Vl8eagtufO1vX4F6YFVjmJRbohgfLHSm/R6Sce0olDxGEdprJ3nRLWF5FntsdmvXWj8k0p4OGRx+67piGreT+SUNfXMavURxYMmfNr4d5CeHQXXytHtWXao1RPzi1V3JQVoLycCLEzz1vzgpG7yc0oRYpRPeQhXh1eilBz2a4ATerG5IKUyP2j3hwi5d7lrmV8nmWyJ6vCorHlZ2vxLQkzGF6stSlZGjd7y1RRBsKbSULKAws0/tJSg5c2MU/BWYDrB1onMObhQ+XwG2wzHzrfJKG8RJ2GvfM+TzGZ2/WkevdAmpe5Y95JI7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199018)(316002)(966005)(6636002)(6486002)(83380400001)(110136005)(478600001)(26005)(186003)(9686003)(6512007)(86362001)(66556008)(6506007)(66476007)(4326008)(66946007)(2906002)(41300700001)(8676002)(38100700002)(5660300002)(82960400001)(6666004)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0h410kK9H72mvUvARsiQ3bhrcAwyl0MN6WydLfPhiQVRbdUf2irX5ADHvshR?=
 =?us-ascii?Q?pytAgaAa+YFOze4Za6XX8YyVIYuq72RP5f6D9rm+PKpzQBEqqZ6QEbF1xdT3?=
 =?us-ascii?Q?fTrdNWQ1LcEVmObtvAn8UTJZonwH64zOU4/slvS4JIsZdo+upvH8CWgpKSDb?=
 =?us-ascii?Q?nOMbzthNGXCzX54I2Suj7Bcl9aYWE9bt2bGmu09tCMo0lzPCk7zdk+4ix/IH?=
 =?us-ascii?Q?w7K7HisdXplRRKoyM7YqmGNB2n+cTZtUbZBw5sDOLLnJ0nZHHoc6iMYsFKRp?=
 =?us-ascii?Q?xPDPqNGh2234rHA8h/XYG88S7nVkjFAtdmL6Wi+aQSodQHLDP4SH/mbZ0h9o?=
 =?us-ascii?Q?FRh/0eAITcQ6jRH1fsR/6VSHorvy/BK8xTQMLzOY1HbXq2EKEZa0Ih1K4rSM?=
 =?us-ascii?Q?1f86DTMKtJuZmKjcSCB7+2/JiyWG7bTxF9sfAT5BN/GOp1fIlXbluXufgIUY?=
 =?us-ascii?Q?yONjUoTPv43mifeAIWjn1TbB2Wvi4qr2bxnQQrxjf1TUNk632cm1tPUChGAB?=
 =?us-ascii?Q?vMlA012beDgK3tcm+YbYvm1MMvH+6O+/NqWPOnDQjwvmieH1426hQ/yatQ8I?=
 =?us-ascii?Q?RIk6gWvtZPyfot+G3JPchablivEQQf8TlKg2OSyvUOEWod7AxdF/m+yMmCnt?=
 =?us-ascii?Q?dSkKWvHbIV9GB5J8D7Lp3dRTWvisTjEN6U7JIDWwK///18GzJBSciffa5k+5?=
 =?us-ascii?Q?ovazoyxeo/ZdttpnM1If7Y08cQdVQfrqe/S1HzZg7jnBbrkPyk9eoCuxoU1x?=
 =?us-ascii?Q?Ckbe5qnBp+CWslgSVli1qp5GcLViR1M9UXtZJpCJWZdxz9X6q/HcvV81rI04?=
 =?us-ascii?Q?g4AxGBvnnwiBBOa+ftPdm7tsYUYNPIouhX1egBZUnaB/Lot/tgTi+331x5ro?=
 =?us-ascii?Q?PUv8HbOmTwsZZ3c4o6FwNau74NNC897mPI2NZi84/4x1kfie8alltcaHZfqF?=
 =?us-ascii?Q?GQBnUqEJnyVrW7KaTnLbt9idl/j1FRYAN6e5ftbri4Zvuo3lQV3NtcDkSg1G?=
 =?us-ascii?Q?JWSmtze4kyMc+MKZVzwaYfccd0D28GpVqMynvK5Yw1G1wWxTSfRlI9RU3d+p?=
 =?us-ascii?Q?uIO18qazEM23FLeYSkmVYBuoHALB3A+6xedNMgtbQ18kbKPcaM3/FRTE+BQV?=
 =?us-ascii?Q?IZsqXBfxV0AxwCvTeWxJjxnTLi7vksn6zH3Nq8C0pe9ekONTA0GJ1xCNB7th?=
 =?us-ascii?Q?lDJzNc4Ou7qkwz80qLgcBhELOYKq37G0pr8daSQFk5y72a0b8CX/VMjSfQHW?=
 =?us-ascii?Q?aKThy8tZpGkMB7p6fAGoxIHXsChXwUuQd4Hz81jtj+tFkwFSnXVSBFmPlmnE?=
 =?us-ascii?Q?8WVaYq/Y+6ZuwAs1mUzOR0BV339CyU8mLpPGqBPmv9tGllYPozRCgTEQSUe4?=
 =?us-ascii?Q?xVQdwrXP+DOumux+l1xt8qd4XS8GRghOchCG8/I5eHm338A2r51XOhHsZga3?=
 =?us-ascii?Q?inp156quM+fgtjjC9lwCfVRR0v29GLS08GuN+SlwNEEt5DC4qJxD5gJ3rqx7?=
 =?us-ascii?Q?HKcQBXYDIEmC2ylnXKl9VBsbeelf980Yu7XTXe7/XkrEM6t7KVJaPs7U9cGJ?=
 =?us-ascii?Q?B+LPbCqzZYSNm6mM+Yer5BLpmNuMcjnvJAKEByOxZer138FcQEU5RxN/9t20?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd935d9-2862-43cd-d792-08db0bbff987
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:38:55.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPKXaQehgxGcRV0d4GVEiKhPZUIfj05w8lM/Twyw39gC23vH8cgWtIIHdAkBKMhjVDqZ+KuSQ4RGINHL2BwS71aB4xKcQfrkND8E2dccQLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
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

Bjorn Helgaas wrote:
> On Fri, Feb 10, 2023 at 10:04:03AM -0700, Dave Jiang wrote:
> > By default the CXL RAS mask registers bits are defaulted to 1's and
> > suppress all error reporting. If the kernel has negotiated ownership
> > of error handling for CXL then unmask the mask registers by writing 0s.
> > 
> > PCI_EXP_AER_FLAGS moved to linux/pci.h header to expose to driver. It
> > allows exposure of system enabled PCI error flags for the driver to decide
> > which error bits to toggle. Bjorn suggested that the error enabling should
> > be controlled from the system policy rather than a driver level choice[1].
> > 
> > CXL RAS CE and UE masks are checked against PCI_EXP_AER_FLAGS before
> > unmasking.
> > 
> > [1]: https://lore.kernel.org/linux-cxl/20230210122952.00006999@Huawei.com/T/#me8c7f39d43029c64ccff5c950b78a2cee8e885af
> 
> > +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > +{
> > +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +	void __iomem *addr;
> > +	u32 orig_val, val, mask;
> > +
> > +	if (!cxlds->regs.ras)
> > +		return -ENODEV;
> > +
> > +	/* BIOS has CXL error control */
> > +	if (!host_bridge->native_cxl_error)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (PCI_EXP_AER_FLAGS & PCI_EXP_DEVCTL_URRE) {
> 
> 1) I don't really want to expose PCI_EXP_AER_FLAGS in linux/pci.h.
> It's basically a convenience part of the AER implementation.
> 
> 2) I think your intent here is to configure the CXL RAS masking based
> on what PCIe error reporting is enabled, but doing it by looking at
> PCI_EXP_AER_FLAGS doesn't seem right.  This expression is a
> compile-time constant that is always true, but we can't rely on
> devices always being configured that way.

Oh, I had asked Dave to do that to try to satisfy your request for a
system wide policy. So that if someone wanted to modify what errors get
unmasked globally just look at that value rather than re-read the
register, but it seems I over-intepreted what you and Jonathan were
talking about here when you mention "system policy":

https://lore.kernel.org/linux-cxl/20221229172731.GA611562@bhelgaas/

> We call pci_aer_init() for every device during enumeration, but we
> only write PCI_EXP_AER_FLAGS if pci_aer_available() and if
> pcie_aer_is_native().  And there are a bunch of drivers that call
> pci_disable_pcie_error_reporting(), which *clears* those flags.  I'm
> not sure those drivers *should* be doing that, but they do today.
> 
> I'm not sure why this needs to be conditional at all, but if it does,
> maybe you want to read PCI_EXP_DEVCTL and base it on that?

Re-reading the register works too.

Some of this may want to move to a more core location once/if CXL devices
beyond the generic Memory Expander Class Code start arriving, but that
can be saved for later.

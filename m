Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB35500F0
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 01:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiFQXoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 19:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiFQXof (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 19:44:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44956C13;
        Fri, 17 Jun 2022 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655509474; x=1687045474;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yn1DxA6BoS0yFhWQF8dVJA0BdefY2eJhPg2bKXzVS5g=;
  b=EGEoe/XP1lpuuqJar6XwXoZpdvhXWO5faRh8+9kbaIAr26WpJfe32HTJ
   CR7jVOckZ8IcAYqJLxmCOyWJJc6QbvMNp4Gmswh+D85CaijC/tTQpqBSA
   0F8ZkPphsrJkwg1pPYCJ5PrEmlEvLDGZOaof+Dnu8P+g2dYlfwqnGGUU4
   O7X5ZEN4juvwW9a71EBvRg9eBsHzjK89QfuhVB02RgbOitRGj24E+0/pC
   vdRNaVTm4CUiM2JDnriSKGgiLqgAVbpC6Be24Fy5j0HzoMT7baBO0dVmp
   V5MhcVhXhd35+XrWPsGk4qqVglUbZliBaE2QHRAXStOAhp+130bAYoMwg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262649797"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262649797"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="912804347"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2022 16:44:33 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 16:44:33 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 16:44:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 16:44:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 16:44:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXvZ5OofHZCOrN/GAGofnZ8g1Y61Z9oQ6MaUCZmIq8ASpjIRy5kKuvpD1o1w4K1Jb+2PhyqfpkTXridTiT1OvzSCSYEsYsdH6LpwHKB5Wb7ujsgkEmNnvUI/9hcENmY+NGrPGEziDh0uHjHHhXlmT6MNQbCWQgnJC+rFy5rQqMjpozqNIv9op49xrsw8a8cZ3OHMAu4UMwS+6qUc/25gd1jRHINyc82qBqglNkX13KwKjeQTBHfcFFcnw2XVZcWf8rYF5tfF5Yv2V5XG8ZuaNwEGrjNeqvHbBVYgLwQSIW+yVRGH5iGafecbGr46IaS9ELyyzO5oFeT6Kqj/x5nozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLOqQI7ILNXLybmXhMdJR6+IxncDLDWitmplkf2+okg=;
 b=czorZxwoZP8UFeTtfVKwq+p+bcbf20rOrEZ1mt+P1KizAEhS+i3GiEJJAKziGudx73mxGzOANKATJGTNEXVrEMk5kt08H1y7RLZQk7ez8Ovvqqv/GhuTDUjt3EpeKNdUDqb/JuoyZ/HF/lBRAIVdQGNpGu7k4zREF3GLxY8I1vzvRf4c/r48PAm0YEI1JUjN60LzFaHQla7ER/amE2Y4ncmkquhVxtzXV4Ye0y83GVLopx2aUC/STWGZ6bi522jXetCnJhywm2TSHLTRiE3Qd7LzJVjarM2g8V9IzDjFsJzaOolXC3b5KK1sWaEsvav4WXe9xZw3DyEw7I0L+sizbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN7PR11MB2612.namprd11.prod.outlook.com
 (2603:10b6:406:b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 17 Jun
 2022 23:44:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 23:44:29 +0000
Date:   Fri, 17 Jun 2022 16:44:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V11 4/8] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <62ad11db18883_844b129415@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-5-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220610202259.3544623-5-ira.weiny@intel.com>
X-ClientProxiedBy: MWHPR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:300:d4::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c2bb112-c4e3-4822-34c3-08da50bb51c9
X-MS-TrafficTypeDiagnostic: BN7PR11MB2612:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB261247EB61DF6CFC9F1F99CAC6AF9@BN7PR11MB2612.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+J8LGeNitD292mAZsgx9UTgS+znLjr4shT0FB0IyD/xgOX2xa/H+YBl9YpFOA1Tr/19HqRYELU7l0d6Aaz42cz8EXxbECL96c1DOcVgWsKO4NXYXWBTGpqfiXkfKTAXEFgteOXalOYjYMJhXPf4fj8jJvcHsVObL8XyH7+zFHyqB6fbA21nkq6ykCeDTk1yCIj8z4luzuoKpmpMLBS3ACJJtvvSruNWgkbch2E9svpiJetlOqMit5KRFM2ZL6+btQSfmW8myQpQrksrSbFYIJzeGBI0SZDRW1seD+yLV5gPBnVUt9q9E9oVtuBF2fTMSSJRjbyclLPx2pU8nNZyhsEMnTCGhNVqsol4H7x3h4YZ1TgBA94eVU4U11gX9lBx+ikzlz3cXJSzzhBiWYAepUzY77pn7A0GnOX0uvmT96SzdB3kktKJf5iegTF47iJBy6N7v8Y88BqnNojAmVdQwG5onTnNn/H4RhtHGJwuRkpK9knjV4efrGE6LySYtYUTyosSl10Q0ijUU46ABxSQZW8YoSxC32szCTQGT0cAsQXow7czfCF0jEZwv/YiHLagMX+msYRJ1AKSc6Q0M7n2FZULHc+/7lrCu/XHPWfG2/7ZItcaACHpRr+IZBHrTR6sAK21jsNYHOEsRLqsg/EQrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(110136005)(186003)(38100700002)(2906002)(6486002)(316002)(498600001)(54906003)(82960400001)(86362001)(5660300002)(66476007)(4326008)(6506007)(66556008)(83380400001)(15650500001)(26005)(66946007)(8936002)(8676002)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z07aPPDBNZPfj8aVaZo1byMgl5NCfzsZWL3GXm5EYilStsgFg+HQ95s5mQ89?=
 =?us-ascii?Q?ITF6Mju4kCebGkajx6dmiNGegss5VAIrvZ/jt3/9LHuijGRWC6hGbGJsqtaY?=
 =?us-ascii?Q?9kxP38Oo2yuVE2xk86z3aWrPbRKLPMggmLe9b6RApyfvyh9iEb3qoBKE24Mi?=
 =?us-ascii?Q?yb2NR7l0u4jU8IpHm4ub8n17gDodITXayZ7Sgmt5pim6IpFKWdJ9v95HSuei?=
 =?us-ascii?Q?QYAU2rrKB2ivv2Zwic9S7M5YoWWngz/LmEkK30hczS4E1zUdRaovHr9B2sxw?=
 =?us-ascii?Q?d00APwbqbP2zqViJons2fyjlJZdE5s6Mic8OpaFOVjLBloDFBnCmoJSmYa+Q?=
 =?us-ascii?Q?LKer/cR+3tKBZmLaY+DEYjKnPt2sVtFKbUbI5dcP5eE4afsEIIHagm7s+AHK?=
 =?us-ascii?Q?zRHCqzD/nOrnhryCH3xwE7QFhVeQ+cmLAPj/BaMY3UbVI8kL67YbO3ahvB6H?=
 =?us-ascii?Q?YnKFm+nWQpr8BMgjRpWwAfyykeyHM5NS4+f2Lps7/om0pbj3lznWPwIdNnwk?=
 =?us-ascii?Q?FAU25G2QzlLtpDgTwfWUs2h9/fIgClhNBWJmMujGSG8wnmQpJgzrelS77Vrv?=
 =?us-ascii?Q?KJp8Duaed7zucuXP1WDPOS/LQoUhAAnVhQlVihWZEB0ChfLGZOEEv4QJT0zu?=
 =?us-ascii?Q?TVfmQ/F3W/+ZrP4GITnzFDMTBQ1hcZPWY5NGvagh2byh/RoTr/9efJWeuWO7?=
 =?us-ascii?Q?6s9+DPQB/4//7PsH9wIUw6H7RQ+nNUK3qGn+PJ8sWzguHFbTz9GGD6KQtlXh?=
 =?us-ascii?Q?lDhYiYyU+4TnDObFcF+7DuLNHNkAl7jFjUHDjuWoxlMyVlQfQyfaT/9bH0/I?=
 =?us-ascii?Q?WOZzI+iOTIDDCMsUbWBmLQ9lxQZ5eVF1Opiy96zHt334c7YxlCChQbCwp9FH?=
 =?us-ascii?Q?ly9TyuGYjRR9QGXDo50qwNzAZ25b/ZreO0RV/uXvvUhTSH4sQBoHFbz2IAmf?=
 =?us-ascii?Q?0izaSviZA8NJqmCADsW26ljTVdLT1Ytejw29Cm/7LfF3uyQtOyVzQEN68No3?=
 =?us-ascii?Q?0b/PSLhZEj6yd2pmdNPTchuO5YGMaiXsB1RiIUPe9Y/ckOzu+RNMmKDwBCqK?=
 =?us-ascii?Q?W9FRI3nYgo3kNeiK17mkRotkCzOP5b3dRAlmny0ZNrV6Fc2DIAEA2LmeWV+3?=
 =?us-ascii?Q?IN2HInZ8Qw3NsqtrytrKxb9p+TgRd34HvhqB7beNIwMw9DNwmd3Bq4IZAK5f?=
 =?us-ascii?Q?rbjMDAU7pmgRs/G80OJmkw9baf9CbfhhtpclRMF7e7QNzBGT9VUt6j8MFFbP?=
 =?us-ascii?Q?jWo625BwNZaqSs/nmqBeOXaLz85k9pPQGcqlWMgFRD9nApmVjFnPh5L4MSsy?=
 =?us-ascii?Q?K+CriEDIkuxV6qn1fR80y2LnpKfTYutYejipLOHR3e74y6pJ4sa0MmFjEa9n?=
 =?us-ascii?Q?ZlKin+otJIAr1eSvwVWz9hjL7hjCEGZQ8ZB0tyPck6InRPw8X1W8dnJjZcF3?=
 =?us-ascii?Q?e9ZHOBLt3nvAnVsPHo+2URE0NFw0jRI0h6pgx+aZBCUhBvN/UR6ExGvArZfF?=
 =?us-ascii?Q?xlWzIfs9TxlCOhkeYVu4MUhDGgtxThE6uzZ5fh1Nscng050bRnItaOK/XCqH?=
 =?us-ascii?Q?LVAuHbIn02eOj/p6/re6EQOlprNxHkvin9Sl+e/68Pgi8hFN7IkmaAC0DTC0?=
 =?us-ascii?Q?QTuRA2U44lTu4Vt8BQvKQDpkp7sRUh4Mm3ZkNWCA6SeqVIKMGiTXbYaod0m2?=
 =?us-ascii?Q?E1tfs8zaLkD5nPj7apYWt0qqxxzzMaVLn56wShgKEVU7A7h0WF88HQaubkw6?=
 =?us-ascii?Q?+9cisIcrumGqKav1LtgKg3EJ8oKE72E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2bb112-c4e3-4822-34c3-08da50bb51c9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 23:44:28.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6yCraDNWsdRTdhWgeX6Q+nyfXBEd3qlJeU8yvxIwnPezrREkC0dgeApWXcZvClNSj1pTuv0y9gMTlwEay+bGHwkTEu9pcTi1TX2MVIypg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2612
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DOE mailbox objects will be needed for various mailbox communications
> with each memory device.
> 
> Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> as found.
> 
> It is not anticipated that this is the final resting place for the
> iteration of the DOE devices.  The support of ports may drive this code
> into the pcie side.  In this imagined architecture the CXL port driver
> would then query into the PCI device for the DOE mailbox array.
> 
> For now this is good enough for the endpoints and the split is similar
> to the envisioned architecture where getting the mailbox array is
> separated from the various protocol needs.  For example, it is not
> anticipated that the CDAT code will need to move because it is only
> needed by the cxl_ports.
> 
> Likewise irq's are separated out in a similar design pattern to the
> PCIe port driver.  But a much simpler irq enabling flag is used and only
> DOE interrupts are supported.
> 
> Reviewed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V9:
> 	Bug fix: ensure DOE mailboxes are iterated before memdev add
> 	Ben Widawsky
> 		Set use_irq to false and just return on error.
> 		Don't return a value from devm_cxl_pci_create_doe()
> 		Skip allocating doe_mb array if there are no mailboxes
> 		Skip requesting irqs if none found.
> 	Ben/Jonathan Cameron
> 		s/num_irqs/max_irqs
> 
> Changes from V8:
> 	Move PCI_DOE selection to CXL_BUS to support future patches
> 	which move queries into the port code.
> 	Remove Auxiliary device arch
> 	Squash the functionality of the auxiliary driver into this
> 	patch.
> 	Split out the irq handling a bit.
> 
> Changes from V7:
> 	Minor code clean ups
> 	Rebased on cxl-pending
> 
> Changes from V6:
> 	Move all the auxiliary device stuff to the CXL layer
> 
> Changes from V5:
> 	Split the CXL specific stuff off from the PCI DOE create
> 	auxiliary device code.
> ---
>  drivers/cxl/Kconfig  |   1 +
>  drivers/cxl/cxlmem.h |   6 +++
>  drivers/cxl/pci.c    | 114 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index f64e3984689f..7adaaf80b302 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -2,6 +2,7 @@
>  menuconfig CXL_BUS
>  	tristate "CXL (Compute Express Link) Devices Support"
>  	depends on PCI
> +	select PCI_DOE
>  	help
>  	  CXL is a bus that is electrically compatible with PCI Express, but
>  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 60d10ee1e7fc..4d2764b865ab 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -191,6 +191,8 @@ struct cxl_endpoint_dvsec_info {
>   * @component_reg_phys: register base of component registers
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
> + * @doe_mbs: PCI DOE mailbox array
> + * @num_mbs: Number of DOE mailboxes
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -224,6 +226,10 @@ struct cxl_dev_state {
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  
> +	bool doe_use_irq;

Don't pass temporary state through a long lived data structure. Just
pass flag by reference between the functions that want to coordinate
this.


> +	struct pci_doe_mb **doe_mbs;
> +	int num_mbs;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5a0ae46d4989..72c7b535f5df 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -8,6 +8,7 @@
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/io.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> @@ -386,6 +387,116 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return rc;
>  }
>  
> +static void cxl_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +static void cxl_doe_destroy_mb(void *ds)
> +{
> +	struct cxl_dev_state *cxlds = ds;
> +	int i;
> +
> +	for (i = 0; i < cxlds->num_mbs; i++) {
> +		if (cxlds->doe_mbs[i])
> +			pci_doe_destroy_mb(cxlds->doe_mbs[i]);
> +	}
> +}
> +
> +static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int max_irqs = 0;
> +	int off = 0;
> +	int rc;
> +
> +	/* Account for all the DOE vectors needed */
> +	pci_doe_for_each_off(pdev, off) {
> +		int irq = pci_doe_get_irq_num(pdev, off);
> +
> +		if (irq < 0)
> +			continue;
> +		max_irqs = max(max_irqs, irq + 1);

This seems to assume that different DOEs will get independent vectors.
The driver needs to be prepared for DOE instances, Event notifications,
and mailbox commands to share a single MSI vector in the worst case.
Lets focus on polled mode DOE, or explicitly only support interrupt
based operation when no vector sharing is detected.

> +	}
> +
> +	if (!max_irqs)
> +		return;
> +
> +	cxlds->doe_use_irq = false;
> +
> +	/*
> +	 * Allocate enough vectors for the DOE's
> +	 */
> +	rc = pci_alloc_irq_vectors(pdev, max_irqs, max_irqs, PCI_IRQ_MSI |
> +							     PCI_IRQ_MSIX);
> +	if (rc != max_irqs) {
> +		pci_err(pdev, "Not enough interrupts; use polling\n");
> +		/* Some got allocated; clean them up */
> +		if (rc > 0)
> +			cxl_pci_free_irq_vectors(pdev);
> +		return;
> +	}
> +
> +	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> +	if (rc)
> +		return;
> +
> +	cxlds->doe_use_irq = true;
> +}
> +
> +/**
> + * devm_cxl_pci_create_doe - Scan and set up DOE mailboxes
> + *
> + * @cxlds: The CXL device state
> + */
> +static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u16 off = 0;
> +	int num_mbs = 0;
> +	int rc;
> +
> +	pci_doe_for_each_off(pdev, off)
> +		num_mbs++;
> +
> +	if (!num_mbs) {
> +		pci_dbg(pdev, "0 DOE mailbox's found\n");
> +		return;
> +	}
> +
> +	cxlds->doe_mbs = devm_kcalloc(dev, num_mbs, sizeof(*cxlds->doe_mbs),
> +				      GFP_KERNEL);
> +	if (!cxlds->doe_mbs)
> +		return;
> +
> +	pci_doe_for_each_off(pdev, off) {
> +		struct pci_doe_mb *doe_mb;
> +		int irq = -1;
> +
> +		if (cxlds->doe_use_irq)
> +			irq = pci_doe_get_irq_num(pdev, off);
> +
> +		doe_mb = pci_doe_create_mb(pdev, off, irq);
> +		if (IS_ERR(doe_mb)) {
> +			pci_err(pdev,
> +				"Failed to create MB object for MB @ %x\n",
> +				off);
> +			doe_mb = NULL;
> +		}
> +
> +		cxlds->doe_mbs[cxlds->num_mbs] = doe_mb;
> +		cxlds->num_mbs++;
> +	}
> +
> +	rc = devm_add_action_or_reset(dev, cxl_doe_destroy_mb, cxlds);
> +	if (rc)
> +		return;
> +
> +	pci_info(pdev, "Configured %d DOE mailbox's\n", cxlds->num_mbs);
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -434,6 +545,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
>  
> +	cxl_alloc_irq_vectors(cxlds);
> +	devm_cxl_pci_create_doe(cxlds);
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> -- 
> 2.35.1
> 



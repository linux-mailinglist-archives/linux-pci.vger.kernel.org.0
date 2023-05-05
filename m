Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27D6F87AE
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjEERdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjEERdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 13:33:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01E40C1
        for <linux-pci@vger.kernel.org>; Fri,  5 May 2023 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683308012; x=1714844012;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JpVETd4nfMRtHv46GCjoG5cXF8gS3lSjqbsf66oTFzQ=;
  b=YsVzavQZGxZLT6Ccbx86riI2c9p6oD2Ij1HdpW4cGP9Svmxgf4rWWeSJ
   vUBu2n2Q9dTFRre3jrIV1vjdr6B0z9xk4qKzWdjbJjz3eerhAqBEleLZO
   O8WVMsAJve5rMyTqG4QOuVU+s7F20HJBrtO02yyRtmRmfzIrnZYOP57/2
   Okzx7xWyEg5uLva60s7LjeRyNzpXZtyCS6JEXn9vRDSnlX5h6Xh7TLDN3
   dmKkYf7iXymQmFYLHptHVtVYL1t+u0Ixzu9DPGrmJTxHtvb14ID9LlXgv
   v3JnlsGLii0QemnPrQCGoOUvht8K6LiHNIqEJ/YqfpeswIN9FkwmwvREg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="333687606"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="333687606"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="871955985"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="871955985"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2023 10:33:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 10:33:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 10:33:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 10:33:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 10:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwAlFwEqhSQPRvlW5VpVmfMCLrVThJgLAZtkmO+DIIsZVA7Uv6mwcH1+6n2/tklxp2dzvQf39qYghtzg1OQtlx9r1hQj3YIRnFdlhQ9lnDbciDf7yzAtwmUEMungq4gLUBD2vFxNyGP7MdgxJY2eIv314/Az/hOANDCAbAhR3VLzO7THdcmuz5n1Uqyje8I4IhhZpcDaoAcHlqgCudy8UuGp7C/HlRMCpQVOWLNPIkTwaznOS+M5sNAfn5Xm4VXUc4rB0cNEB8cOS2NxKIxNNgJ+K36SL3bG6JB0wcXTIM3wvyiyksDj0MqQ652SmC782hj3ZdfhCqg8+nPOPHDmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d2QAuFpj29G9JezBZOBNjmWuw80fb8Mo0bMSFv9Y5Q=;
 b=dD10N17pp6ZRtS2JR1h1SIEs7to7KlApwDFK0imw6tkFyfRYPH036JSPdiA9EDRVxIe2HGYxQxZ4SaK6qJm9PsxcMun8agNfDhhyyb8wz/ySEyBI5kmlh8o9mlhOCC1g39MVUeS2kRPJ1y5359h3IUsal43lMFiJud+aorLz085upoOTtDR2VR4zN+SQYRDjO8VpX2Ev8itCMGghJuYcdu8NBguz4IaP1BvDfIguGL7MkhycyWXpqa4LAhOIx/85mLT6Ev88To1QxkNw7LRh/55cXI9EP/WHOeLA0+Bk23aqTP1MoJBdTJNkwmu+BrG0k+fXwJKIJxTWiAWTkgYKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:33:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 17:33:05 +0000
Date:   Fri, 5 May 2023 10:33:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 2/3] misc: enclosure, ses: simplify some get callbacks
Message-ID: <64553dcf3991e_1e6f29426@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
 <20221117163407.28472-3-mariusz.tkaczyk@linux.intel.com>
 <645446ab23922_2ec5d2945c@dwillia2-xfh.jf.intel.com.notmuch>
 <20230505134534.000066b9@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230505134534.000066b9@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2fd6ff-f1a4-490c-460e-08db4d8ec8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpbxHRgASZyVtkmjGeiURLDmseKYA42SQ7P5WWp0oRLl06x7M8/hCSE+vfcfy/64YJb0NEMAN4quARQXa0Ms8p7C+057kSk3fuNCvjHTyiyuOIeTXXGGYOmZhpDpQYWOId1u3QO4jn3QLyK4M64sb7hgpfoR24/1wKolGeB9QoWJXvdNNfqtjaGlvye1uN71ykEYyzMMm2QG2rPzbbnR2jZhRCXD0sTioI4/SrVoteWzIyAsrNO68WFdf419W6OThWVYlyi4F8HvzteOeeTY+fT2vttXnikExLEO18yahVt2dbED/KoBTv8ekQ3qXAvEZ4G6iEBBkwyeBQXzGmHbkQh+QX3gNY7Fuezo+NL4qKJ6oeGvoAbdXSbYkR78xe51XRw6ND2cgVXDZsYrHOFDeEipHlZBVKQlwgDxvKX4mAcUM7oN4AbQNDuWxs0E7ibWttXw/ZW//5aFgQgSksSkAP4eriXEmQrf5Vzo10KijQNnKKY1xm2hP5wGhzBJPwULwsUabycV1l88cbvOnDCZJY14MmbW2ngVdBX2TYSqjhpVd28VsyFSlqYEN1kV9N9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(66946007)(66556008)(4326008)(478600001)(6486002)(66476007)(316002)(110136005)(86362001)(83380400001)(6506007)(26005)(9686003)(6512007)(41300700001)(8936002)(5660300002)(8676002)(2906002)(38100700002)(82960400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RfyAsNKSM5+8QzliL36qI/sw+AvPaSenESjXWoRgJfHGfgsLpz2g7FaapvMX?=
 =?us-ascii?Q?NVtwuu3MqYXg6hwr9oQiTIhWDWt1TlYlksEJY7/+U31Mb/Vgbc/lV9aJFZFK?=
 =?us-ascii?Q?u9ZX4XWVpJULIqAydWAqVrfuzjW2HmQ8Bnae6RNL9mqRn386MwNJYQDSt3jX?=
 =?us-ascii?Q?F6OpJfNNi1yROCBKjr7wuk1S8YUvbngTm7FpfAXzMlgc1/qUyZfpewNn0XDR?=
 =?us-ascii?Q?IXPDiF94x9BP1NorOeuSMoPm6C0fW27Nlq2KZzC3RBrcxW9sBWEMFCPrzLpF?=
 =?us-ascii?Q?MQ3Ce6IwC7NLBCatb+wRLI3APHLiIKLMxReWD74qZSU/1wwo5QUNYLLl7gqr?=
 =?us-ascii?Q?rvviIOIAm/R8hg8nxolGO4Ter5TQFsqIivmmO1hdKiRdNOqUpRjrBL4EI3N3?=
 =?us-ascii?Q?ZrWpAWuDt4KcUjHfKtN1gO8t9UfWj2EjCfOCmXNsoNmKSM2Cg2hg46zZBYE+?=
 =?us-ascii?Q?7nnPwgdc56G6S+AcspGFUyPfkB2xALeTX/+hbZugKGxQkUS65ffrhyOJLXLB?=
 =?us-ascii?Q?GhV5DeH8IwqfYr2Yr+qzbCrJRDGWW9pozFnkCy0RCq6bueimID/TtQ0QmXwG?=
 =?us-ascii?Q?FfxEMvLLRaYGOS+gVaecVEjcefMIwj8JsSQZBHA2u6EqaRGqE825xSarN3Rt?=
 =?us-ascii?Q?SK38JulQ0+36Xs3oq573O9k4jCDT9lwYMCeIleyqz0poTNsyTFYmQbz1nBgl?=
 =?us-ascii?Q?sAzCRz3mIAt7FcMnVbZuNAwCnQuYg5+MGPo7lvFZdHfrnUFT2NIT3aittQ9p?=
 =?us-ascii?Q?D6O23G9fYtlEzh42mUMYmKOnc4mU65k0FGLJC5PGigHgCRVKXgJ1FfYptUns?=
 =?us-ascii?Q?OdfaqPyhwIrUjPd3A8ObSjSlIjNIZtDq4MZ3YR0Q/juCsIbbCPxlH+TGNPo6?=
 =?us-ascii?Q?PGrW0ILttRCBWylta5bYZb4xHD3aAAYlCdA+zZAkGbcrq+Kc7frCsGoify0Z?=
 =?us-ascii?Q?EAtvatk+sVhpt7ocg1Be62hSSnamN5PR8acFKLFyKz6FsxqzY260+Ni9z8f2?=
 =?us-ascii?Q?YNq1yjJNNwMoDkmrAXINsUv/5EgkE1pzynzEO89Y6NfOe1XfsgjrdL4cnnYx?=
 =?us-ascii?Q?6WGPJlgIo8cA6H7/T6bBhPpd2m+CV0XadEOrk8Pun0af5ay/EaXtx3HjnAWQ?=
 =?us-ascii?Q?uS64hxe+dRdgge2QPDUh5Fh3Ocz2i+ha5nbFp8yqAQXbJMvpwDNkQsVNkMgi?=
 =?us-ascii?Q?NgtGRiqFbmk604V9g6K56GyZL7vUN3RZ4WqvFc+Zra05yMZcvPEJhvYnwj9i?=
 =?us-ascii?Q?F8eCwHLM0yNtdP9pTxi0RwfvOfdErcQO5iBtU/UHd+en2FOiiHjLz+QZs3I2?=
 =?us-ascii?Q?c4GXi8IIK7rHzvWH6s+D2tbSY5vmGt53IUoiXQwCvtb436F18ily9K20KrCv?=
 =?us-ascii?Q?nAecwII9/0BAGpvlBAi+WkCs1lqxY/9mU0/fvRX7H13hYVeynsVNy4ybOxGX?=
 =?us-ascii?Q?zik4qdPwoMLBaMXNiPxviDf/BOvQeX+fayiRDG0W1fL6iVXeNjtd7r+fSHd3?=
 =?us-ascii?Q?vRu1IsUbxO8Zw/5l9DM89WP/RAlj0M/IKR8OPpJWgixKOj0EvH+ACwm0a2I9?=
 =?us-ascii?Q?iafd3BeQqNHmnU2GHTs/5R0HC35EEka7vPgf3vqNrZcYidTS1ra6D22UwkZG?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2fd6ff-f1a4-490c-460e-08db4d8ec8e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:33:05.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO+JuN4h345U10jAyNVkQ2OVWs8iZ2+kE0MDYm7Xtidsa6OX2W/XjHrPderCOH8vEfyJA01xl8GdTRufLWk2x+WrfX/8+NJ3B+AWINZGd7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mariusz Tkaczyk wrote:
> On Thu, 4 May 2023 16:58:35 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Mariusz Tkaczyk wrote:
> > > Remove active, status, fault and locate variables from
> > > enclosure_component struct. Return then directly.
> > > No functional changes intended.  
> > 
> > This looks ok although it's not a clear win on the diffstat. Does this
> > make the NPEM implementation easier to remove the indirection through
> > "struct enclosure_component" for reading fresh values? That would help
> > make the case.
> 
> I did that to familiarize better with this API. I determined that those values
> can be just returned. They are refreshed every time on read in get_*led*(). I
> believed that it makes implementation simpler for reader.
> 
> It could save me from some questions, "why not to reuse existing active,
> fault, status variables" but it is no clear benefit.
> It saves some memory because those variable probably won't be used in
> NPEM/_DSM implementation (at least draft I left doesn't not use them).
> 
> If you don't see this valuable let me know, I can drop it.

I think the problem with it is that it now requires a get_active()
implementation where one was not needed before, see my comment on
patch3. The attributes to cache the values allows a 'get' method to be
skipped when 'set'+caching is sufficient.

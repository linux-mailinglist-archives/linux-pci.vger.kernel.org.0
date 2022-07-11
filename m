Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EDB570AF3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGKTty (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGKTtx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:49:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC30248E1;
        Mon, 11 Jul 2022 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657568992; x=1689104992;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AyBQ5PScvQMsV1t67wDUOdR71lV1NJCdrCnm8bOtFxk=;
  b=MCygsohKN+OKa47VQO5LqKdFYZrlw8xDbMdfNmd95Od6g1PvzlBRYBoV
   Y149HOClmX3U5H6uccsNGOcjk3UCb0PgtFQUOO8rly8h74HBHlMLY1r9X
   765StHm1QpnGaiMt0zvptDuqrOHd/MeBJdt3LvjuqQUz0BsY9aLZbyLxn
   M+rJXvcA02KbqMn2FXJYM5i2Ha3bZopnLfhtRU1nCv8zboe7pVCqICetn
   0d/zAXFuriEBJ3tOHtoY/QjSvnTQ0qL6tvvyD8qrHKXw3WhbZmDsfY3N7
   tD8QCCwI/rUOgxcR77yq3ZxBxLClcsgqBltTdrcacs28hrHO3axKS639b
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283509660"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="283509660"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="737215774"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2022 12:49:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 12:49:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 12:49:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 12:49:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 12:49:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwjOZQdlEHdIQiDvnJv9ct2HkuU2z8gaYbffj38LuhHiUFTAS4bvIPYFH1LwYibHMpyryLfIjQ0YNgawx2wu7FS0WjStPkSNMaJ4ex18PnqJswIixQ/EmA9pkQf4Wah/lQgrhkrObqxSwV6yl2VaoNboy4Y+v4TVE3j/HCJ5+bgg4exUdczIfsv1TUl/9Ft/nWJ5O4ttji7Vpkx1fmLJO0XOAaTYrUEiSsYj89Dhu+ANY2qEYnsDPiOAnL6AILJR7LZuFGiikJXmd09C9AJOd4sroHZ2xqQyVMQz1b8D5bJnojYx+OC5h0oEkOAlt8Xs0nGaQJ3zUftY06j7uBINGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXqAnf2sV/lRXhD5821kqGypO7LV2xnUObBekyvas4s=;
 b=CvvL6YyjvYwxDKtQqSFiWwGWtDbzpN5ahDCutpBOD0TiBsj0Fk72b/lntttvR5gHriRTVFQBIP9AwN0wec3hORm9yKZGOFHowRmtZGtLumhv80+vY7uRwPXM57n2k4Naf9Ukju6CJgTEwnP4PzZavCx+HfAG/lpQ94O6TK9o7Eg/gWiM8DaD4sNVetz2ZDlX0/HZVQYB0x4iBvW7VzEAY4SaT3r53MRQ771NNVfgXSsOHYvgFh9ftffN9jLyTXeSz3Bj6V4BgG77qOz7FYiUkDWOAzw2G9Ncdsp/dRbKIIdzCbPEWqxk8LeAS9z1z1Na3EwZ1S6sCm49hBx8O2oLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB3150.namprd11.prod.outlook.com
 (2603:10b6:805:d1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 19:49:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Mon, 11 Jul
 2022 19:49:39 +0000
Date:   Mon, 11 Jul 2022 12:49:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 45/46] cxl/pmem: Fix offline_nvdimm_bus() to offline by
 bridge
Message-ID: <62cc7ed125008_35351629450@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-20-dan.j.williams@intel.com>
 <20220630181432.000040a2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630181432.000040a2@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c5672b-e45a-424c-cbd8-08da63767da3
X-MS-TrafficTypeDiagnostic: SN6PR11MB3150:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Askdt+cXzJ629bj3oqOmtnpj4rMSt/9+AE3OMTK369uPaS+fjmTXQvOBHtu6BHJJt/UDQooFR8yacSA8EImlsYpIsOx34qJYOuXcaxIB75/60uFipodp2tcnCiKDdLPiYVrvu0e4boggBn5yrdTQ9UbsEy7OX57J1at6Q8dn4LoHwVZcicjQ6PbTWTnUWvqW5cbTY1t8SAaZTvSM0xhMtVWGeh5lG260LmLZ2dkfwcip2akeT4M07COz09AiLDuLYCMrcELSVVF00On6hhinviBevcIPfLt010nKT5hxuvxVwFxRKVgldbpdeh/srGokFeDUXkjbNwKRUUHRjuIX60TfobKxMC+YaBoSJjW3LGv5gIcadqc+1HvfoeVJuLfLyMJx285FC7fGDxiymTTFJ+wGO0f7YWltW/aslk/HwtukhjBuwgZh4UdSVRaFRMVoY7b+3e6kouC48Vm+RSxH3DQHU2bxc543KxdaU51bs6lGxbwcYpDegMGuJP0i+wYhcYErJ12s9oF/X4ovEalHGS1LJSt9tKrPF7ez24HINhHMMeuBO3fuWMljZg1GlePcVUh1X+7QtYVDWXeH8qPhm2rDj+kkRtwBk9yyrbJtOfDf3B9Ezy6dCLs34OF7zWKAdoR25lXfql2nRPCnsMP0a2o7QrTPtL/vc/zByJC3v+lj29lwfTdtYOrhD2xCI/l+ZIIrtKKOQWyXVZcDyoNp8dRNzybkUWqq+8cBS+RS1yscmEtKEwje/SASxsHisdzO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39860400002)(366004)(396003)(38100700002)(186003)(316002)(110136005)(66476007)(5660300002)(8676002)(9686003)(4326008)(66556008)(66946007)(82960400001)(41300700001)(6506007)(6486002)(8936002)(478600001)(2906002)(6512007)(86362001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1TsJBHF+V/+xyEn1MiH+Ay3ZxgoRuRtovQmfFYW++VvRkGqtI1FNDvMpi8my?=
 =?us-ascii?Q?zOGlLLqcBk/P6SgO9DpYCJ0UNH4GOOt7zwozfiySQEYhfUzoocCxBs8whxfO?=
 =?us-ascii?Q?0Oo8aUwxE4f/Wq3gU63QfdgyYClRgD3I433xkPlMmI8utIZFHXCLZW4Y3wHS?=
 =?us-ascii?Q?iUvNFEHxhD2akIVM2vm7Z2M/8aJ4vDGzIAJ/CNQ9aPSUSqSOBb/fRcZ3E4nK?=
 =?us-ascii?Q?vL7SfnOZOSl83yNWTrgpU9bWEjYkeiYJudM+KH9QKf/nr4EaLCwdy8aKsiBK?=
 =?us-ascii?Q?zivM2lIVqr2Kql/ezhfb5+qdCfi8fq8Kg/BSN4e6FLqEau+A+beBRp8t21jN?=
 =?us-ascii?Q?A+tOWubdik0wm/dBjXbAw8A2dcQtuX9yX2gYrjOjPpx3AWjD6APIDbYUzim8?=
 =?us-ascii?Q?rIlbMmNrbgawhMszxeJ/hdihK4yrcBDV1JLBQ8u88HlFNTBCGf1IrUjjYkBd?=
 =?us-ascii?Q?sS75NDfCh4Sc9PA9izYpumL+PGnUrUtwC4Y/zGfOxUXhH1XSy2zN++uZDTVc?=
 =?us-ascii?Q?k8QJt5ZSmDEzsJ8V9prAG0m3F9ulPqI9fh5CPQoW/LLdE9tte9LN622lHWPx?=
 =?us-ascii?Q?8x0/r5drL4Vp3RwEK4ZJIUDoSFtDe67IYnXY50a1Ojw6eMURBrZkeWRsZtMA?=
 =?us-ascii?Q?/5vmxHd9CyzkbNpLGDGEz0lbsmbnrXxoAMQ0RSbYwpjIVydxfCcL9Sg72dK0?=
 =?us-ascii?Q?LoUi6mMaHimOiE/7Km9P5TdYiD6i6+4tHwT8hNDEoYI05sivTQY0FaqmB9ux?=
 =?us-ascii?Q?i7r1Wl8Z16qd5zOpaLpl90gJz6XraBQ345pl3StWrf6g+cLBpaNmF9Png6yt?=
 =?us-ascii?Q?A+aaIz54y6K2Nb+2+nj3xUixooomWpXC4HbTbZljC5pY3JlP8UlkAMcaqevN?=
 =?us-ascii?Q?QDePhcSDzeQo+sHWmFHOWRoTqwQENVzC+Z0Qp1OqA7pNsw0x3mcOM1Mtz/uF?=
 =?us-ascii?Q?zknAQdBYL3N8oSv+xeeyZBrt2CiRkGv/iWSCz591F7WK9oZ5U7Lj2ImqlnS0?=
 =?us-ascii?Q?PDqBAhgSNg0XB/htAd3IE4X9eFBfi6I0b/FEHWp+sFBTAyU9uP5RQANUmHyy?=
 =?us-ascii?Q?SvAnhkLxHcR1/OLbrgwJpXW5VzE4+7u3o+uSUMLGFrAxGI14dkGEJsyrQWVp?=
 =?us-ascii?Q?sidyyoi/LAXPdnqGo/3cceUVaQG/gZIG+T0MsVtMzISPoE9ZD8Pu4I1ZFArj?=
 =?us-ascii?Q?K4c42ATKkNlLxti2hkX3zqKI5x1JXWK1+407bPSSgcY5eTC4uhARD0wFfarz?=
 =?us-ascii?Q?gtHe0NQSPZ8mPs7QbTb61kqIMIYJcplimAF9G4XNxZze6S1Rijtu3KSDYcFC?=
 =?us-ascii?Q?yjKzXaI3HGUyeHYcJw26a3CevuFCQLHO1pwU7a0GT2Ryg67vUQoc4WHRjQr9?=
 =?us-ascii?Q?4UcDkWRFe1duB5zNgimTgwYljq1tkOB4UoiRPP3JLKHeyIdC7HUKUabO5xGz?=
 =?us-ascii?Q?yP0syeUpPENhMSpyIBjEEGmZaa7kKN02S5RIz1lELl76KwjHOpy+IVuzAxV+?=
 =?us-ascii?Q?QFbBXPhP6fSNNzloSqHbr7lLKgguKenlCTR2Qo0bgprpbM6SRmHPhgY12woG?=
 =?us-ascii?Q?PECxeRj+CgLjtAxN6DUJntcIT6TzaNxFVGTIKPhlxAWUHa8Apd1IWw3vf9Ux?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c5672b-e45a-424c-cbd8-08da63767da3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 19:49:39.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExTWpHxjv3Xd4Y+KYsYlbwLAIvpU7yXYKgXsqTMxqGuVqbcnNzTfnt2+Qp9ZQ32PhQkeNmXqMMTgaUPh6wL6qvNnt+gwCGpPtkotVN5eXVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:49 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Be careful to only disable cxl_pmem objects related to a given
> > cxl_nvdimm_bridge. Otherwise, offline_nvdimm_bus() reaches across CXL
> > domains and disables more than is expected.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Fix, but not fixes tag? Probably wants a comment (I'm guessing
> it didn't matter until now?)

I'll add:

Fixes: 21083f51521f ("cxl/pmem: Register 'pmem' / cxl_nvdimm devices")

To date this has been a benign side effect since it only effects
cxl_test, but as cxl_test gets wider deployment it needs to meet the
expectation that any cxl_test operations have no effect on the
production stack. It might also be important if Device Tree adds
incremental CXL platform topology support.

> By Domains, what do you mean?  I don't think we have that
> well defined as a term.

By "domain" I meant a CXL topology hierarchy that a given memdev
attaches. In the userspace cxl-cli tool terms this is a "bus":

# cxl list -M -b "ACPI.CXL" | jq .[0]
{
  "memdev": "mem0",
  "pmem_size": 536870912,
  "ram_size": 0,
  "serial": 0,
  "host": "0000:35:00.0"
}

# cxl list -M -b "cxl_test" | jq .[0]
{
  "memdev": "mem2",
  "pmem_size": 1073741824,
  "ram_size": 1073741824,
  "serial": 1,
  "numa_node": 1,
  "host": "cxl_mem.1"
}

...where "-b" filters by the "bus" provider. This shows that mem0
derives its CXL.mem connectivity from the typical ACPI hierarchy, and
mem2 is in the "cxl_test" domain. I did not use the "bus" term in the
changelog because "bus" means something different to the kernel as both
of those devices are registered on @cxl_bus_type.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832495752D4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiGNQcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiGNQcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 12:32:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A7665D42;
        Thu, 14 Jul 2022 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657816331; x=1689352331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BZx8YIgt2djKZY5jFVdkIv2d9ftAuvqIIuNXUQS8M8M=;
  b=lxKOtfc9ScJbucTnTbRQ8EXBkQ/i2JJVV23born6Ry5bcuXql+k4rYKQ
   AWUnLKHXswZsdiSf7PPql6cUK9PPC+VJR0a19c1WSPLcn1g7yyVN7ss4Z
   H6Qag5Dw04eRwqMFKnlptkBeDCeikMSLSLS7mZOSPqu6jC9MKfOixFHj2
   xqOTIo9zBEB/QxpUi5JWAIyrmsqhLtBltr+c+o8lYhECogG7Ijmd3vrtg
   1xNGiz4NHxZ6/tcQZtWByd9ZPtB0I/um2St4AOcw16oGMnh8Da+/Mnpgh
   bQPaMgis6k7P30vzDAdbfillophCzdeFWMfT5YomZQCehu2mEp/2nDdEg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283122644"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="283122644"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="600183189"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2022 09:32:08 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 09:32:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 09:32:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 09:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaVZeu+xXk3gHYx6dKJ6l3NY6cZ2qpfRxlpaKyxMk0J0R130JmCUCPLuo09RFXafnkd6ABrU0v/v6B4oOTy0ZqTzXLPFO5IyfWyYehuiU9RAzDwFNaGz5y+1sXLobyuISsPQlnJvn4xu3ghFrJcOGCyDsJwH3x7J6LTVSqFKbDzUXSL5rzl2PyP+f33wr9+ZzvFNZl3tXnUWMYw0TrIkcck5DA5/wtNIMmSj6zosGrjwtfjNcy8E3Rp4iIlw4NhcdqD1caOYI7v8VmKSmvwBIhohqnWLalaewWuD0yyHAT8iTvJryVYfYqkXZBS63+P5CpKtcMD1SLEek7fP7MSyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/BXrLkXl/5EVS1aDNSACuxOOu1clrrklhDwqLpATy0=;
 b=YlyT3l8ro2evBhGP3EO7zwWgvCQ72ccbC7KAsu7mSHAviTaH8lMN2T5MThIYe9QpPN8WJX3AaMoObisbIkCLognHuBi07Zm6ELmc1/ZfTxnJF2o16S0VZyq/WHyxNOmBgjDJLCueFKUKpAC9fz2w1HAeh4GVGS7XGV7pYuhPmDGWHV3bvvyzoBP0XUR/7ZviJkzvMgA8pB61/OxuDst/2A5r58lwTVy5IkFEJX7cq9N34gFJZvpfCAgHoSsxpmoRBAd9dBptaDP5CUG30m12zuLk0RTw+cUGXo6nwcirB91yd4/pUy910R5w70ebUDg7qzsJCrbIiStiltLUwaIdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB3563.namprd11.prod.outlook.com
 (2603:10b6:5:13e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 16:32:06 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 16:32:06 +0000
Date:   Thu, 14 Jul 2022 09:32:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V13 9/9] cxl/port: Parse out DSMAS data from CDAT table
Message-ID: <62d045039d44b_16fb9729443@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-10-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220705154932.2141021-10-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57f14f3-631b-43da-e8ed-08da65b663ba
X-MS-TrafficTypeDiagnostic: DM6PR11MB3563:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcnCKevLFCRn5mC91YjFbnMzUHAqzgqX17CYd3ingf9rJL3uIQ9lTHIcvGJ2Jck3SBvjvUzJ9+SIczubdmR8kkpfbpeihjkPrNP6j0y1SI3vBkNBobwJBS3UL+V72jgJ1G0pmLSDbtFU0ycncOxUDk9zhq92aBOS8D84nvvFdSyGG+IiHbeWsgR1N8QKsga2NWhHJ6geV2uARm4iVkfHE85i/7oSA3wDtejWJw/pN5uxcQcs/IASIhu2G9Z+0NzauxdAuDibt8t4+jLkVf6VI2xLnto15MJnnlYiY7CUSdse8gyb7hLkdcFhyoDNgD69Ud+dtT+wOy2fytgWRN2xo/TtcvNFF6+RAIVA5Eog9g/AU6pl2QbWOWlRUFCfE2o6KM6iW1sWAylOzYCLaVOy+/C0uwpxRa1hKbK24foDByHAvxOokQzaAcQvICBF6Cn7ROXeCVkqcg71PSndceC05rMMbmOzz4yMO5Bz8G4QWMo7h/8z1R2VgHM63wrjgbS6hFRPbLnQAl1pdhKH3B3MU5mXkrXk9rLcyOJWyoc1SJTV6JKwtfWzbPFroAV/j9imcBHSrJ8Y0fXEC8tedU9nerujEFLETGpggNk1bECg8tOr5RC+y/L1RpI6gi/Sxs8rlsCWpB0P2QAPN3NlbCS0nRsWpZaZr0ioMYj1I4yu3AVc2cmr+KEt7iuJR9aB8JnhnTGyAi5oWOO8/qAo6ZQJLl21AUPgAm4abF1WbYe6iDS06UxviNmZBbRFP5GEZV4Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(396003)(376002)(136003)(54906003)(6486002)(478600001)(2906002)(6506007)(8936002)(38100700002)(4744005)(186003)(4326008)(26005)(82960400001)(6666004)(66556008)(66946007)(66476007)(41300700001)(9686003)(6512007)(316002)(110136005)(86362001)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+RF4CG1IPqA3crgllH2GJYmf29htWglQ9LCl5eit/hfuA9COacEiJ8GCAlc?=
 =?us-ascii?Q?fDjyqjhDgrwlbGlyyJO716jWHIx93lpxY4UUekNrY7l2IpFMKiFEc9HhRP+N?=
 =?us-ascii?Q?M/imAR5K+y2hD6zB+RzfMzaMocSXE1oCHzqs1rEDDpz7atycg8uwlzOux72a?=
 =?us-ascii?Q?sqdtyD/0nGkA6HAs1OCP5Ud6o1gHJ6Ch2zJAZVIJewfGs/oqs9mgGoGNc1yW?=
 =?us-ascii?Q?KI3U3ZV8oyDqi0A/hdU8viYujCo6di370mK+ek94Rp8ouJln2H/zcYZlPDCk?=
 =?us-ascii?Q?z8DrsJKpjkQYscdakEcP6icU/D9YSYUnjcxDaWqNqranJn9dzaA+ZdoF6Epd?=
 =?us-ascii?Q?Z+hzMC4Oye0rgW9BqlzxbAPMhfgQMimux/JKZubx42eWWMEq4hP0y5FcGelK?=
 =?us-ascii?Q?BjC/4qnMxF3hpC5TwQBOFJ6HizKU/CSZdXCPgldPJzYSLz9Rzuo+OO/gL6Uj?=
 =?us-ascii?Q?zXwbeJz5D1pqkeCfMPoZ3yi5Fw/of9KdKmli3hNT+BVOJPzBxLTnyB+jE2yF?=
 =?us-ascii?Q?M3YIm93ngAYmrzvSs6PNRYjecL+cISGoYttIdm34l+4G/Pi7gP+waDQy2BZN?=
 =?us-ascii?Q?Kxp5PeNX8CB7c2AYY7eqtWHGzYHF7a2WpaZWnlk40dMh2EU5XrtMGgo+/QnB?=
 =?us-ascii?Q?oM4lpYAxnaHK3Amt8k+5plMWM88+p0Z+XbGo0R19VrGAgAnUhgX1GS8bBXK8?=
 =?us-ascii?Q?ffL7MZPghZ8FvvsjhHgFPOSINDFcxzPScLU01usQ9pRwEkdh4reXDLbLGFGF?=
 =?us-ascii?Q?bFTTnkoSUC74rzVpg/rPGMfAx86EmLYvF8SmoEwmzq34RkHKfat4pxXiWI9i?=
 =?us-ascii?Q?5D48XzovSVwn8r48j08qHDHV31WbKeZNr92apojGKfxDNj4ruOu1gYE3TmWD?=
 =?us-ascii?Q?79RQsms34kpplbnIjxLbq6J3yZyQbvtzIPPOaia7lO0DNPWO60SWLdGlqDil?=
 =?us-ascii?Q?HRn0YmnsX1Zfs+ysva+mHS6nCFUMLHTyU92KCH+48pnnZq6fdaxRYAD25P88?=
 =?us-ascii?Q?TiV9PG5U2f+rxbDIqKf91y4Gp3NRYQ6nq3MoM3DOvwgwry4vxk+PawgAv8k6?=
 =?us-ascii?Q?muKUfLzZur1E19G9SPENTvOabSJ6O60uL/IA+qfsVG9xC+j97uvzWCd+oPNM?=
 =?us-ascii?Q?RRxDt2kzooW0CbWFfKMVQqzY0cSphp8xIZFB9yLtrw+4y+bJ1q5ruWt1BhSD?=
 =?us-ascii?Q?5fK8WrjD1vQyTVw2nUP1g6aA9rBye0R+Lyq73owNpv2sr5JGJihgiO4GmAn/?=
 =?us-ascii?Q?+f/kVLawKfjIhF1sABtgskUnN4vM+B6G245gH82TLHdNm3RGawEkHcXTiEqX?=
 =?us-ascii?Q?jsbQ9LP4Z+HDjcCC+GDR5/tvXG6y0A8QwJd04jR7stiZupoOSmF1/YiQBP5+?=
 =?us-ascii?Q?JIPBdm6DER0haWCxBuPKXnIISe0blefiNJiA4fjTqNaq4R0dfPkDV/NgAXok?=
 =?us-ascii?Q?v3epSsvx2JjPvN7PkjtBxIFRNs3aKRQft93jEqYEV4cBqhYJgyDI/2NYLuwW?=
 =?us-ascii?Q?N92sXPO4H5cByNDGFRYiA4+EA1PEJbymT03y7C3VbILCvdQ6XmA+hiJ3+mJz?=
 =?us-ascii?Q?2EaMe5CjZLfcs8Pl6ozrWrl8V+3ELNtCHxuq0VZAmzfU9Qh85mqQJ7cAuIs+?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b57f14f3-631b-43da-e8ed-08da65b663ba
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 16:32:05.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxTafb4gzu9f+AsAnrW8Pyj1SxPyX5nqBsKNAXIkr9iXylnlX3/T/1Wo2IJ+JUHkHgddZbYfTlEsjBibACU8vtw0eZ5jiJFT62VQ4NLcZsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3563
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

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL Ports with memory devices attached need the information from the
> Device Scoped Memory Affinity Structure (DSMAS).  This information is
> contained within the CDAT table buffer which is cached in the port
> device.
> 
> If CDAT data is available, parse and cache DSMAS data from the table.
> Store this data in unmarshaled struct dsmas data structures for ease of
> use later.  Ensure DSMAS headers are not malicious or ill formed so as
> to cause buffer overflow errors.
> 

Per patch 6 the parsing needs to move to a refactored version of the
ACPI table parsing, but for now it can just be dropped.

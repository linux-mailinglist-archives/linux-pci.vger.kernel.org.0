Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C4575638
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiGNUN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbiGNUNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 16:13:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CF026AC0;
        Thu, 14 Jul 2022 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657829633; x=1689365633;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oOnmkvj2BCjpAvRRszz0RcGjAY4UIdYk4FP5kkT7kRQ=;
  b=MzLN+haPoQs+iuw31dKmGkVQH1g97a3u5TC2eW711qPyBoBY+qqcntSA
   knXyKKJvBfnHoFZhjHFGhGOn+BqRMHdiOw0YqWfNBHbvj52DAMsyNqlJy
   zLmvzLUsf2mnXeONpIziYvRJmKu8uSyNNBRDz/PV9OeropQodHG5lAgs9
   Zxozkq8v8EWsTVhQr3FP5Ohlm0/Z6UOXuNm4FjkCqRgusYjwiSAw+lnYi
   fmJ5TXXMxyfyxD/TnY3p5S29jJAx5LXCtCeuxBNXWRCnpJgbrP2LfuBvK
   3+tRkSW8LAv9s3J6Tb6nsAcrdsrg1GlHhlmqkFqTv1dGtW99czMpATAcD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="285643988"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="285643988"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="596220012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2022 13:13:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:13:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 13:13:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 13:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEg5kEIMlDY7JRjrSgElG+jvBwWiVYbwBZbrD2BgPQZI6eI7vk4cEspVttGcRP5/MxPM3sMnTRRiqpEDN2JV2CgsvfWP1aGL8DRN2n57vgzpigEe1A2spXkPWcGG9SkQnWgrDWudPFgVp9zOLldrOHTYEwLVds4sFByIdx0Km2T7ft+YyqCpQnH2MN+IrnZ57+IIHCsalBW8XOh9bo4pvuqlKdhnCJ06LB/CX92HhqVI39c2023AimqGYEA8W/+FZsxU6N6RBinqTXqUHNvbfjwQRBxNrulrSYZy39//kCDspsIi3Z4zjnPL8pOS3+ZdNvG/632L1XVF3yEW5sWapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdc/OjJdSoBR3zrIJUZPvsIAKCOEW9OcuJX1Vr9xtnE=;
 b=ZMooZn914G5JbVHTpnz/4EqAQWjgzWh9Qkfyw6de2V58OaAdhdkNWfS9dviTGIX7wS2Mu39qGuWSIpb8tJsd9BwpcTCK9LFc+Svvg2XTMvtqX/klDQjuEaND1b+DypEJEWMT5vGUxyq3EgJvhH7nBoXwpxmQ74cOfBV1uv/ttIaWtfclC+bM1pqZ4Vlt/Zz/EFwP6xXBKUnz5CU/uCe95qqyryPULU1x6nX8A6In6a+bmnu2rFkn4DW9PBmAkVMMOaQ5YxgTOZkbvUzOkaS3U3MF+RpGRIBeQnJxvM6DH+Yph3NP2AqrThV+z4yF2FzXEFUVsqGDbwMOVtm0dMvAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR11MB1926.namprd11.prod.outlook.com (2603:10b6:903:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 20:13:49 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 20:13:49 +0000
Date:   Thu, 14 Jul 2022 13:13:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <YtB49QRceabLTV/7@iweiny-desk3>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-9-ira.weiny@intel.com>
 <62d043d8bd04c_16fb9729422@dwillia2-xfh.jf.intel.com.notmuch>
 <YtB3GySfcm5CfG01@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YtB3GySfcm5CfG01@iweiny-desk3>
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a563e8e-aeb0-4b34-7e6a-08da65d55cd6
X-MS-TrafficTypeDiagnostic: CY4PR11MB1926:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmIseLNHQpaEA9Ut3jhJ0/Ur+RbOHcYzaJWCBzSpwgj9LSQDEQdsyvVSbMYhvXuat4DEuI2jqBTDitEGqPY9Jl8/nn8aI5sJv+8VKoO6M5Gjv29B+HU9vYGuBvxX47L+U4tvKp1n1UD5vNS9I9TDPOXmCG1g5VI3rTaz5DeNDupTxzgV/XGyKXOFzn00bZhaTzNY2mcJdq9Civ4SM3ofmGgTwZQ6jsfzPQLP4zBsw6XgKvsx1V7xfikl0LHA73JTRoVGT8iRrNE/0n5l1xhMcxwTcXG+kxf0patv9e3ur/jnR/HaBrI3bHLTTvmUpC7vP1LXRVBi2KP2tP/hwhLLEGz7q7EsqGFdtJiB3n4thQrwzflSEJ4z8HawnnhgVtqQkCvBp51jXbaYKQQsVxTbp1WPGEXLZ2UvT6dcbRtz/xJMBSvQuyja8j1pOhi8zFMrtuTRNTNqoVWo0Chx1Z3rSq5mSodvWti3xcEOfTYlVMcHFkYKO3VowWYNxrlF9Oytp7lQsk8acHrl2IZ7tsOuPn1wNsc4AdLA4deubYFOJB9lSfLawfqVktZ+JztG9API3zjnoy3s67Imd2YezsJSzNxc8tZNIEvQrMLNXAYNFM0Z7WMN1DIih5cAxR40PSITlJOXoVbjepwQZ9aqc678qpZFOKbrvskJahUpBl+NWSGvRKpiRO++MmQIkIftupDoObeXd8KcXNVT9gWGt4TYJL0QCwNeGFIvg6hV2yaC3KbnDVQ3WXj5+8h72U6aTsApkZuPh4tIbWHb3kfCwd3YlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(136003)(396003)(346002)(376002)(66556008)(6506007)(2906002)(6512007)(41300700001)(9686003)(66476007)(82960400001)(66946007)(4326008)(6486002)(86362001)(6666004)(186003)(6862004)(38100700002)(8936002)(44832011)(316002)(8676002)(54906003)(478600001)(5660300002)(6636002)(83380400001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2AW4Q/c8QOiEpk9lvtVFh8+ZeKQQwTKwyHfk15am4yBgp79IojmqNBsARh4?=
 =?us-ascii?Q?XUi3QkRFZtETO7yCQp1iZRHT7yHCCMc6pw8oJMWt4qqMTRiCLQ6qFAtfE+MY?=
 =?us-ascii?Q?HT1xJmYfM222s11xuF09UaQO9JU+q7eQi5O7fsNjIlUpu7uw0m0SqTxyNTfn?=
 =?us-ascii?Q?CIyR4TW2Bu15Deqyk2vzQJ8nnUr4McjDN5AcYNfI0LFL9vNmPpJhCZn9rSWN?=
 =?us-ascii?Q?GB7+Zbt2auzxEqVv4eYBnFR2aVBcR9oWik/jdY0TLF08TW3Dqf6ieZDCJy23?=
 =?us-ascii?Q?rCGeVs80rRiJRla/vq1JvVjTGwpePyCKXCkdJZYi1kqY8+KtBn1LJpUQHgKA?=
 =?us-ascii?Q?d5NIds0kwlDmUDr2v2lNuPBVve7w387JDbmnCacWM+X3Ca5tziRwHB2qOU79?=
 =?us-ascii?Q?2Ch+musU7k6L0p2F6p44qIMXs2u10KyOmIVw9psMb4w/Rw3d7ReJBOHkGPFm?=
 =?us-ascii?Q?bMiMFIvXKsjoB3B+7kUe9vLrAjp/slzXvX2Sw859UDn/ADU6zbFkZSsWtzwm?=
 =?us-ascii?Q?gZLN56IHdL7a7i4NpU7ZjPEun53bK4WvOpO3ufvy4WSjyeRDwe/6+jlqaE1W?=
 =?us-ascii?Q?thJWcJvEHArB+r4aJjr79+L6PXvK1MSoiZ2MnR/ldVMyQrYcvFVTwfa/McSZ?=
 =?us-ascii?Q?Ypvqmsw1y8ynpdO7rxwTJcurH+6r6vrIM0Pf2gO4mvULS3b7GbSSIlQTivA1?=
 =?us-ascii?Q?mGvQXPKPrcYKFMdRyzaTWZSjb1wIYrxcbOsfwHDJ/8ZZBl2ow1qVndRB1L7h?=
 =?us-ascii?Q?Bp6YJDr4qHD4ZQ6yrcjvkC6j5SJn++PfIHVCoGNCkis8fKzQTSL11G7EQ1x7?=
 =?us-ascii?Q?DaKoqlc7EQSxhxdD+4HPuI49UlEIzP62lqHX7jD6TMPTxB1s8h86j6blCqsu?=
 =?us-ascii?Q?9nljGRcRvgDjsGQtzJTHHOuze7/19mkCqM2OZhl3GbYcKsE/xd+EyGQQcBv/?=
 =?us-ascii?Q?TLMPvfV9cgNGpStDx9kG8hng+6WAILf5w7jPutWFhsW7u9M0S7FMyPzyXbSo?=
 =?us-ascii?Q?1fAbhTE134wB0wxo85bjynXN570BL6g75y1TpLi/Ar1koUTuTssco1Fua+oK?=
 =?us-ascii?Q?/1VYgKfsycfqZrO31Tf/2lnDxFbFEKj6z4YJlK2m3T8DFU8txdUFV//VVApP?=
 =?us-ascii?Q?EYYBoakrJWc0DtfkJV0BRhRWkmObfTwsoWKGMqq9GU34NWzKzfkM/AI260xa?=
 =?us-ascii?Q?Mv5IM+1XyXx4uITt1T6Vgy5xsIgLNg78u8zSh2/EhORzej6dkaPJjAU/j1Zt?=
 =?us-ascii?Q?/Bt7WKofdBUIuBxjMoofwkOFnxjC+Ru+nsY99oDBFxBOpWxkpwASnderBDeg?=
 =?us-ascii?Q?zvRewxZGYWPKLMJ2dR+WZxNoupiBdRSOn4ols4cDfatW3alqDbvIqcRMHkJv?=
 =?us-ascii?Q?SYVjgXONFJLOzrHA45jb0Aw18lYppLc5Zsprof+dwDafCzSei0irIuT4b9HE?=
 =?us-ascii?Q?WcYSAagiwYXjFrWz6f6an57jt9ogsTnSjSw4UaUcGYt6L0joeoxrl+LsbDv4?=
 =?us-ascii?Q?TtuooV445u7lOOSZ/UZpZYzXVFQzRRvJXihwSbMVJbkcp4d+22McW4q6/APd?=
 =?us-ascii?Q?4VgJjPuIBRMCCyYMbciSTJNfvRmWTn5ey7ynY/eQSwXGYztJdmKyJGUJO50b?=
 =?us-ascii?Q?U4QYdd4BSlz8lwHOoh5swnk0QWMe1gzENDfsTIiLEhl5HvK8tDjEYZ1sjOAJ?=
 =?us-ascii?Q?JUIPiA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a563e8e-aeb0-4b34-7e6a-08da65d55cd6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:13:48.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzbnxb/BaJWwXGIjPoeTyqP7U3dBBVyJmHGt2x5PtUuuvzARvZaRgNQVGunRK1pOX7I5dewUrBNjnCbTsIrFDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1926
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

On Thu, Jul 14, 2022 at 01:05:47PM -0700, Ira wrote:
> On Thu, Jul 14, 2022 at 09:27:04AM -0700, Dan Williams wrote:
> > ira.weiny@ wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The CDAT read may fail for a number of reasons but mainly it is possible
> > > to get different parts of a valid state.  The checksum in the CDAT table
> > > protects against this.
> > 
> > I don't know what "different parts of a valid state" means.
> 
> This text is stale but given what I know about how other entities may be
> issuing queries without the kernel knowledge I'm not 100% sure that the data
> read back will always be valid.
> 
> Regardless, this has already caught a bug in QEMU.
> 
> So I'm inclined to leave this check in because the checksum is there and should
> can be validated if only to detect broken hardware.
> 
> I can update the commit message to clarify this.

Oh wait I thought this was the 'is valid' patch.

I can remove the retries if that was all you were concerned about.

Ira

> 
> Ira
> 
> >
> > The CDAT
> > should not be changing as it is being read unless someone is issuing a
> > set-partition while the DOE operation is happening. Rather than
> > arbitrary retries, block out set-partition while CDAT is being read.
> > 
> > You can use {set,clear}_exclusive_cxl_commands() to temporarily lock out
> > set-partition while the CDAT read is happening.
> > 
> > ...and since this series is only for enabling 

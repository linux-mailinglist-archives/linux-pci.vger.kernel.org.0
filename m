Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28E797B48
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 20:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjIGSMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343620AbjIGSMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 14:12:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E9E47
        for <linux-pci@vger.kernel.org>; Thu,  7 Sep 2023 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694110310; x=1725646310;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PJGpjL+fdPlp1jqJeBzlrsQ4LBLcZOsSVX7J1+87pSw=;
  b=LAc2oP7S2NPJ6py2zfS+QKCKe42JXHtWpbCNPTyvGn+iOEb63g2rzXJW
   rU+EjXnIZDVhdEYa8NFWtUp98TpZjvKrOx8lbScSEfrg7ygqYtX2TW6FR
   PUP0r/TabWD6KD2d3TXrlu+ZRz6RsU8tBitCXcJZ+rLhfzwg5GL7QRmpY
   GvyPlUsy+EmUxMtpIHZW/wPoQZeh2QdvFrhh1emg5BHvCsUsUJVyzEp5M
   /0YbGmq3mverMTIwkJK66eIWhNYtvgp2rYRNRyTxihxSBmFLnitkRRimO
   2dyfQ9bc/+ahLs7/8ulqLJRubNZ2gizZmAQBprAc+Sh0VmL73dyrbHHFg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="374754971"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="374754971"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="1072909480"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="1072909480"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 07:29:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 07:29:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 07:29:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 07:29:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 07:29:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAlN2eFSQr58GLOBH3mHQ1Hh+izTWsr8pJ+lDBySNoQ5HI5NVexri32cbutmRXRF7FG03gJgSoP2P8K7QTJ4yZ92wTcyeCVk0lZVf+dubJWIdhgrYLAt/oHdACbZVrmLCKbsgmW2oMVnntbxU2pBtdfQRpJRm/wNA3zCFQOPBqeMmVO2N4PcHyr0WGePl2fpHU1ZAFJLQww/VhcgxG2s9gCeRYBRAGT6AxM+FFhcHmjLp8mjI3FF+YNDAATBzaHrMTQoIyNHgVVy5UNVTUbkYr/NIGfVQ3x6xcLChXKQlEshqKBIQ14mrETrJJrYYEFKIJRQzIF9QcNgmHyrucwOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb6+Ixa2L4Ry0RbRYkIGOZ3JYBV2I9uirrp0oAsYpfU=;
 b=WKS/YyV1m9lzjhPVKIBHGo46ZeMZyWF//pjDSKMCFJS6T9UGEG9bly4ibHE+S5DbTWmKO2FKbkeu4k9E79Mv+j8aSyWJUo9yUgE3fch409MZGXuWxIw7LghBV8MfIr2Fv9nvXaLCCWWPJxAbuGf66b94wFSutwThD4bwo4KtLq7MYbqizDaEkHcIKbIP4BN3W6lhmh336O6n2Iq+i6mh9AIIGGgHRWzeHa1Id0HMjcHXtAgoHC0ql3CoQ9C3CWymbjhTP6gLD/qmf2Gi6LFbJGr7shnIPd5jAZJe7bNYUJ69PMN9uwNZe1uUIAQMgOy3UxCallgqjXz/3LqSdOvKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18)
 by SJ0PR11MB5071.namprd11.prod.outlook.com (2603:10b6:a03:2d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 14:29:12 +0000
Received: from SA1PR11MB5948.namprd11.prod.outlook.com
 ([fe80::357f:cb81:fe70:d9d6]) by SA1PR11MB5948.namprd11.prod.outlook.com
 ([fe80::357f:cb81:fe70:d9d6%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 14:29:12 +0000
Message-ID: <4ea426be-1b36-b163-51d3-420fe6b6573a@intel.com>
Date:   Thu, 7 Sep 2023 16:29:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] PCI: Disable ATS for specific Intel IPU E2000 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        Sheena Mohan <sheenamo@google.com>,
        Aahil Awatramani <aahila@google.com>,
        Justin Tai <justai@google.com>, <joel.a.gibson@intel.com>,
        <emil.s.tantilov@intel.com>, <gaurav.s.emmanuel@intel.com>,
        <mike.conover@intel.com>, <shaopeng.he@intel.com>,
        <anthony.l.nguyen@intel.com>, <pavan.kumar.linga@intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20230906201329.GA237399@bhelgaas>
Content-Language: en-US
From:   Bartosz Pawlowski <bartosz.pawlowski@intel.com>
In-Reply-To: <20230906201329.GA237399@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::12) To SA1PR11MB5948.namprd11.prod.outlook.com
 (2603:10b6:806:23c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB5948:EE_|SJ0PR11MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: ae83f2b1-144d-43f6-2245-08dbafaece30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhtxG7G/Anu/h+E3yHXo6tOQOw5Bm3XDtxdevOXGpvXyJaw7reCSjOj5mx+hIpac8ba7i7P0M6Wrp4rKQdcLe4fKTp2e0FoRGwFLn2F2jBOhUfOyusyrI5EhsCoqKsQYDbs3U1VnsIGgMKaXWx3unxDiAT180/k700vo+wqAc10T5MbWA+ZHbnscmaQa/C6ZlyjcHw0wnRLPtsnweMXxpE3RvKFw3uZboDd7XZ43szqN0H2Y7uYN9U7XGBrZkm4ME3R/023PoaaZqlArPAAS7EHrsxVJ2lfPd6j/lMlMtggLS1Z/hSv5OTefquV2swjmhk3yyNMxCthY3y4xIRb00orENvNQwuk96CogcJD+DacA3ChCXPECRZm2o6CNSU5OHmMtSsjMEMftrs26D3FXFBEukm7paurtVy0gBPYyPk+BAc0lcr9WfqRN/RHE9EtwheeReixCQgRbTDv1+MvoGleCU83oJvH5xGo7IDC+wuCAOgaGo9VZknnVA5Z3vCeWcbs8Uf0lhDjCq0khS7mcsK+mHxnyLGv7UC5tWVk2b/13lbem4x8gyl7UWcKX/OV5+5426fBt+tFRZJGNg+73o+7u/82NFEbuAShoIB+xc5iZpKtTosh85+5WtFotpLE6oszIM2x0A5YnQl1/Ri3nHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5948.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(31686004)(6666004)(53546011)(6506007)(6486002)(38100700002)(82960400001)(86362001)(36756003)(31696002)(2616005)(26005)(107886003)(6512007)(83380400001)(478600001)(5660300002)(41300700001)(8676002)(4326008)(8936002)(66476007)(316002)(66556008)(2906002)(54906003)(66946007)(6916009)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFFUNTRSTWdCTVZyYjN2TEFJZ2tZYnNibkY2UUh5dkdsWHVDQUZyc3IvT0pM?=
 =?utf-8?B?ZDIyZVZPR045T1ZPNXdGVmt0OWl5VDAxMisxSGR0aW1TaGdRcHJnWENXcTIv?=
 =?utf-8?B?ZnloeHYzbzFObWJlditEK1lSOVpCUjhyTHlUWUl2N2lYZzQwMHY5cHhoSXdI?=
 =?utf-8?B?ZE1SOVlYUi9MeGJjNWpoUCtrVHZEU0l2WDN3Yi96L09BNGRwMEpWaVU1U1FI?=
 =?utf-8?B?U28wUEc0SkJZNFJXUWRoR3dNdTRzdUtuZXBVc0MyUENLcVB3QjA3NjdYalhT?=
 =?utf-8?B?QXErNW1Jd0J3WFRPOENyN2x2cjZCVGE5YWFaQS9QTUxUdUY1RTFuU1BEMFNT?=
 =?utf-8?B?ZENpTmxGV0t6K21kSzlXdG9XdVlvTmlTKyszYmI3VWVXd3d1V1hJSTJ6eDE1?=
 =?utf-8?B?VERSQkNhdHFsamNldGVKKzdncEhMR2ZtRlRDbE9uWjdreHh5TTh5eGp6V1Nl?=
 =?utf-8?B?dldtcC8vNmZ4Zm5aZ05aU21HamJpa3dxdDBURUx5cEpQR1M5TkpsRUhqbnZ6?=
 =?utf-8?B?SXU2VGFSWmhzMmorUWF5cy9PVHUyZXovREc2WTdpKzd1a3lzZHA4Yk1Nb0V6?=
 =?utf-8?B?eWIxbURHWmlaeXNabEFaNmRFR0NjM2xOaUJaZ0dpMlQrS0xUcEZuWTdIY1Nn?=
 =?utf-8?B?OXZ2elRMaWVnYStlakd5MkJBd3BSWjdtMSs5WjY0MDRGdCtRWG1Ycm1ZNUtT?=
 =?utf-8?B?L25Wa2t0MDlSWElnYjdQamhLTzE4VFFuR0xSZ1lDNHlhV2lVTFgyU0Y1aDRt?=
 =?utf-8?B?RzZyUHNFYXFIWXAyN3lPZlBFSUNHcklFemUvL0VMWTA4dDZGbXFSR0ZrYTdT?=
 =?utf-8?B?NmxLS0t5MjY4cldyNEhXSHlzTU91QTUwdUFMZ3luV05PT0FqbXQ5NzVHL29l?=
 =?utf-8?B?Q3dJYWtyYkhHQ1FFV09GUVVKMGR6bFoyYmw5VzZVYStBZGgzZHRYMUc2dXJG?=
 =?utf-8?B?QlhSUys1QS83YldMbDdpV0pLZlJOaFlZMS8wOC84WXdjMWR6d2t0K0xRb1Ex?=
 =?utf-8?B?TEhEWHZhSkZiMWI0WmRFaEd5V0lmRm1tTStoemk4VDNvTHFTTTZYSm5zaUFz?=
 =?utf-8?B?QVgrV0xuNithWnNxQllycHh2Z09NSHBPdjJWbCtMWDdmM0Y0T2tpOWdGWmpW?=
 =?utf-8?B?NG13M0dMUHI1cmI5WmtwUlJoZW5WeW1xS0NYekE1c1lLdHEwU2s2TWJRL1Nx?=
 =?utf-8?B?eGEvS3NlL0dEWERTbEE4d2k3R3VVVFhUai94T0RuRWRicFR2ZnorY21GbEcv?=
 =?utf-8?B?MGE3eTZpSDJnMnB0ZWRpSEV4V3FCcUYzbUlET09rK0daSGJneWZRclAyaWlj?=
 =?utf-8?B?ZXY0dXpuSWlnMlB1RC9BbWRpWnhBS2h6ZXp4VVB1UXpJNnNveVRCSG4wOTZ4?=
 =?utf-8?B?YzNXc3dUME5vVTZFVGJ2WnF2eXVORERiZnIvd1Jwb0hVem9xZnFzZGl1ajR3?=
 =?utf-8?B?VGVleHJTYjBtb29XMzdIUHVOYWdReDJlZVRCWE1PUzAwc0VCY1IvSE1nV01r?=
 =?utf-8?B?Y0dGYVVYVG9aK1lkVVhFMXl5Qk52NnYyeGtibERVSmZEdmFVbFJpOGxtWlBs?=
 =?utf-8?B?S3FGZUlyRHErTDMxM1BrcG1YMUJITzZNcDJaSGlJNWlUK0xHRlFWd2liam02?=
 =?utf-8?B?ZjRWdzZ0L2hNMy9wMkN3dDFpaDZFRUwvTHdIdGt2b3FiNElrMXg3VzM5aEdi?=
 =?utf-8?B?QUc2T1JINlJlZlNuU2FnM1VHNTRSV3UvOExtbzN3cW91OVhKOVlOdGpkQjZ5?=
 =?utf-8?B?SitobXF6VzAzUyt0Y0Y5aWFRbTlickFjUnFMempJcGNoWU1YNFZFSysyRFdj?=
 =?utf-8?B?Z3ExcklsUmd4Y3hjZ0VDc29jZi9OQXdXNkxoT2JNVWFkeWt4UlcxanE3Ympu?=
 =?utf-8?B?U0xsZUQ2d29VRnZJZXR0V1ZhL0hPcDdGL1ZSWWdUbjQyN2l4a1pHWXhqQmEr?=
 =?utf-8?B?Y3B3SjhvdEs0cUdDc05ZbHZrMFFCWEZRdnhBS1IrdVBIMmVSSWtRVmw3R3Q1?=
 =?utf-8?B?TXpwaWFkZlBTOGhZcFpFaXdHWVJZU1UxMG9GV2dURU5pRElCeEx4Slg2SkM3?=
 =?utf-8?B?U1JNaTNBQjNqdk1PZDFGejJCdDdmdVc2dlJvdDEvM2VyRWRhSjBIam4wVUt6?=
 =?utf-8?B?SXlPaGd3eHkvYlplclQ5K2k1VDdlNXczRlR2SmFWWXpFaTluRmovdUV1MXND?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae83f2b1-144d-43f6-2245-08dbafaece30
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5948.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:29:12.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DF++l4vsn9I5ThN3ouefu63iq9tF4sLzNxqSdfbQvd+W2WkaroPMHRbBwhcpDkQxGz+YrrfCUQlqBbR5VlAeRo0YOKV1P5sv4/xvvKMojdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5071
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 06.09.2023 22:13, Bjorn Helgaas wrote:
> On Wed, Sep 06, 2023 at 11:00:19PM +0300, Andy Shevchenko wrote:
>> On Wed, Sep 06, 2023 at 10:59:20PM +0300, Andy Shevchenko wrote:
>>> On Wed, Sep 06, 2023 at 02:06:23PM -0500, Bjorn Helgaas wrote:
>>>> On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:
>> ...
>>
>>>>> +/*
>>>>> + * Intel IPU E2000 revisions before C0 implement incorrect endianness
>>>>> + * in ATS Invalidate Request message body. Although there is existing software
>>>>> + * workaround for this issue, it is not functionally complete (no 5-lvl paging
>>>>> + * support) and it requires changes in all IOMMU implementations supporting
>>>>> + * ATS. Therefore, disabling ATS seems to be more reasonable.
>>>> Can we reference the commit that added the existing software
>>>> workaround?
>>> See below.
>> Oh, I meant the second question here, i.e.
>>
>>>> It sounds like systems that (a) don't require 5-level paging and (b)
>>>> use an IOMMU implementation that include the appropriate changes might
>>>> still be able to use ATS?  Is there a way for them to do that?
>> ^^^ this one.
> Sorry, I'm missing your point here.
>
> The comment mentions an existing partial software workaround.
> Presumably that was added by some commit, and it would be helpful to
> know which one.
>
> The comment also suggests that if the software workaround were
> completed (or if a system didn't require 5-level paging) and it had
> related changes to its IOMMU driver, we could still use ATS even on
> hardware with this defect.
>
> So I'm wondering if there's a way for an IOMMU driver that has the
> required changes and can tell that we're not using 5-level paging can
> override this quirk that disables ATS.
>
> Maybe we want to unconditionally disable ATS on these broken devices.
> In that case, I think we should just completely drop the comments
> about the software workaround and IOMMU driver changes because they
> wouldn't be relevant.

This software workaround was shared only with E2000 customers and not publicly due to it's complexity and tricky design, so I think we cannot refer to it and I'll drop this comment.

Regards,
Bartosz


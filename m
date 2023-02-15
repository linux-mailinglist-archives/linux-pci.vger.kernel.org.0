Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567EA6973CC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 02:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjBOBpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 20:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjBOBpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 20:45:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83F3431C;
        Tue, 14 Feb 2023 17:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676425548; x=1707961548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gdi063Z+ibQux3k3uw2fw3Vf3cmNng/WRlSxON+eF88=;
  b=HkWRIxjpzy62YubPoy8IF2KIEl47VrZ4jnhAp7vSx3e+8jWvjBiljfg7
   xWDfQxJ90E2QS/9EbzHF86dKB3nsxeN+C9Dnf5BqpDTtNSg6l3wKflmKi
   GETfbomZRibvnQa44EBpNxBLyyU8FfV9rTjtMBDUTTKF0l5Up00vNSoz0
   TKV8td5xcxEpxUs9dqnYYfGEWaPmjxssU9vw7eIZXTE2BIlUzDwh3cRpU
   9N4M0oW4d/6UyPx31pEwXFLYVMu7fBxZtKxD2Co2uGBuMu+j+5dY+0cZT
   O+3BxeUbLOE/K0Yb4wLcPFNTFvHqwy0UH88XNtN0USxKmC28j8nyY3nVR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393722933"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="393722933"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="701851075"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="701851075"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2023 17:45:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:45:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:45:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:45:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPkfKjtVuTU3Qe6t7QTSYPdVh1ZEiIWxV/8JRL8M27BFmpNM+G97bGlTxO8OgW35/PZzjdWYAS6t+UoScKbCsiw6eiKdJ6OXZNybhowGYj9+kab4+SE1YQSyxDfbuO6Xac2nF+8tPd0qVif1K5We9DjXlkmLb6p0/Nmi7Jk82KDWge03Nze3cqJSH820iEFi0YoZD7LimymRvVbh5Sa9tPr++HKwCP0N5ZwTFN4u1VnWIeAXH4LuBfxAQDV++Q0CCBiPO9ewnz6QLJy/dLaWLWZ/I3qzMvgCeGJomfWY9sfE8473OAzcNepMdzZ/jlRsky46NgKNbRoAtwFr4UiZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2XmwaNfFurvBhaOpMeyZqv0XI7FIjZLOqZYPHhOBww=;
 b=W30ezv0iVLKlKWti7FNavePtjERejTUArjuOGyY10itfVar8DRZa/YW7k9kFkQuXmqJEQZ3+9pEFS8KO9oEsI5W3donW8IA/fixpQGzXLmj+upUhytWCazmndtBwFX6Em7gUr5bt3WLTMnwgHfUrlVTe1hHXqrqRrtyLBZQtidMqAHZoCmMOtvQNEx/ThTGQL37k85mINCpEryPDVSuiqMwCdqKUzrCr4K5nnruoocoSnTpv3y7Zs4WBRJvSix8E6vvvuzlzchn/7IO+qLcdYN6c6hXKqdBftS9S3ad5w6w7rWhfUCcomHBEsF5syoIM9pTd6D3Bh9prHs1aZhMKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 01:45:44 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%5]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 01:45:43 +0000
Message-ID: <bfb6ba90-7e4f-58ab-79a7-a31cbd8f3be7@intel.com>
Date:   Wed, 15 Feb 2023 09:45:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 07/16] PCI/DOE: Provide synchronous API and use it
 internally
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <cover.1676043318.git.lukas@wunner.de>
 <5953272685cd245a400e5e0bd964573d9102eeb8.1676043318.git.lukas@wunner.de>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <5953272685cd245a400e5e0bd964573d9102eeb8.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f007468-1617-49c3-0eb0-08db0ef659bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvdzDjwcmlzq+X/W3fwuh1E+eZImHTV+pzJVPW4TahcLp/BPnn/hFsy1arLVgdZysJGvezcfroGdjwkqJkxYG3FEZJif5wtuS3IGiLcYot/mvphFVPKsmUbfFAmMIZyXNvphgO4FL9DoFPDWAwx62oFLiQgjYaxsqCkRGuExP+RJUjJa7K13m3eun9bMaRl9vR9WOBrto2a1tpdr4ipbgvlXoojEvaTvYlWtUspom8fLvUVB0UJfO0cc9/GYC384Ps1F/du8hQFKzVpaUrYLEHTzOPabT3FqaDzQuJgJsGsLtXTEI+bUPk5p7WHKo4QkSu9MAowxuy5IdiJi2xM1wNrw/7tJtqzBugNSTPfttYsHJ7yN7Qvx0jYanSdaONnBkFbZTFpy/ebytXauaHTsA0EI5kT2Bm762WWhJBTaGmPPBCBN3/AhDgzSJGt+4Gs3+889PEQbNojLPhi5BVD1KrYC3JC+5duQw6w+6cx4kCW505F1lwx4VHK73Rl0GP38mFt9624e9+Pr/5qAqCs4J6beiC7Jg1Ue6ahLjf5DLnpM+W+Ilw7rLNhRQqt/qUKcS447t/Eg0cUYcEo0cjp9iPgWwMNomFOw1rDDPlSfd6mTyTHVFL2jBuBcquZGdNHeHpU0h89Rl+eSY3g2LMXZNC06yQGNo+kwCQsTIWXaAUYt5qmr2V7ckvNsX6tmmIYynbfi3n3GjzRej/5N3Q6LS7h+B+2/Hz1YQ9G2ZAz/9AM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(54906003)(83380400001)(478600001)(2616005)(6486002)(36916002)(53546011)(6506007)(6666004)(36756003)(186003)(26005)(6512007)(38100700002)(41300700001)(82960400001)(5660300002)(86362001)(8936002)(4744005)(31686004)(31696002)(316002)(66476007)(2906002)(66556008)(66946007)(4326008)(6916009)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzNXTXpTY01aeWhVYUNYQjJaMVREUTk0NUIwbjNYbG1neVZOaVlvSmt3ZDBS?=
 =?utf-8?B?anhRbjlGU0R3Z0pEaFIrTTNDN3h6eTErS1N6bFVlSkU0MDlNQmpaV1BSOUZk?=
 =?utf-8?B?akRybVhBaUJTSG1ONTlDUXNGR05tWkFiQ0NEZDdoeDVzRmxsdDY5b2s1V3VR?=
 =?utf-8?B?ajVyT1dXODZmVFVIOXZyczNISUh2OG5FRTI1UUxIVUpsWjRXK0VpVzI1SjNE?=
 =?utf-8?B?d1ExaEg0TnN3NWo0VTcwWXEwYXRDd3A4eWlEdjlETFFIUGFua05mc2I0cFk0?=
 =?utf-8?B?WmZ4WVluVG5tWjhCSDBSNHFXcW9wTjY5UHVJSVlGVncrNWFLNmVTMGE5MVFP?=
 =?utf-8?B?SFBlQnhBdnJESzlpNUNFTk5VYzVEMS9ZWEtsbWpaRkJUYUNOYldwRDZ3TU92?=
 =?utf-8?B?RVhSc3J1OGFkM0xwdkhvUDV1Z3FvZjRhbnMzNEdEdGdOMFZXYjBiZzFyaW9D?=
 =?utf-8?B?RndYM2VaS1huYmlJRlVrc0FOYUkrQ0RDd0lReC80WjFqYkdBWkpaSUp4bURP?=
 =?utf-8?B?L1p4N3Q2UG9UR2cvY09jVU42THNDczJmWnQrOG9USm8yVzRTU1FpNTFOaFZn?=
 =?utf-8?B?aUcrT1ZLa1NuMXFJT2MydWJxV1QzOEoxQ1BBNDA2cXF4bFkyUktNU1ZiK0cz?=
 =?utf-8?B?MkdVTHpBeElXdVE1YzdXSkJiOXVTZktMSkVxV2NuYy8yOHNIYXhGTFFhS09x?=
 =?utf-8?B?c2s3aDhkQ3c5a3kyR2xiakFxUUFaWml0QTVuQzJQZzhMZGFkRktHY0tLT3lJ?=
 =?utf-8?B?alV6WW9vSTN1QkRZSlFSNkY0anBWVGwxOEV1UDM3Z2RvZ25qc2RzUEhLdFh2?=
 =?utf-8?B?djA3R0ZoalQ5dWdlbFVONW1vZXlONnEwNm1BeStQTFhsWTZONFMrK3JZTXRi?=
 =?utf-8?B?M3crWkJyUkhTbUxHUHJlY05sQjBiV3VKNlZOTFhTMmFUSit1eE96T0lqR0g1?=
 =?utf-8?B?WFNpOThuL2FYSGJuWndLMVdJZytidUV3ci9WZENGOG9BeUlBVXZpMnRUNlZt?=
 =?utf-8?B?bW90RlBnUTFlQUIzU2VxWmw4L2lFaEJGZ1YyOWx6SldxYnZINHQwa1NkbzZC?=
 =?utf-8?B?cnF0YmZaMnZ3emVmeVE4cVphQzFlZjVXaGFzeVBkYVBPR2tBZ0xhQTQ5a0NZ?=
 =?utf-8?B?bHRMZ0tZYng1OHplMVRXbSthaEpVcEJQdC8zK0tkS2NUSmc5RTQvTTB0WmRx?=
 =?utf-8?B?ak4vMXFyOE5YUlBSQjRCdkR0eDFzTUxZK1VEaHcxcWduODdpREE2dTN2MlAz?=
 =?utf-8?B?Z2Z6aFl3aFlqMFBPWDhROXdFekZZZjdDYnZLaEEwNnpIUlNMTmdKVHF3dGZ3?=
 =?utf-8?B?SzBwMVpNSVdWelQxT3FaYzMyVnIxblRYVmdJcHRjcVFPMHdnVHE5RlI5VmJx?=
 =?utf-8?B?ZUhWVzZ4YXR4KzFMTmhzSHJ0OGlRNGk3aTFBdE9GcCtrVVA2bHU0U1FvSjJk?=
 =?utf-8?B?c0hZdmx6VWxBSDBPVU95Z1RwcTZyZzZFUGF3VEFOaW1kN2YwQzd6V2oxanlI?=
 =?utf-8?B?Q1M5SkwvRWtwS09HUXU0d0xDZVhUZldiYVloTmYyYTdaOUJTMzdUTFVYUlJY?=
 =?utf-8?B?dXpjaDRqZVFtZDA2Rk9lK0loRzRLeWZnRm1KVVNPVTQrK3UxRmVod2xBQVM2?=
 =?utf-8?B?cTltNHBBdC9PZVZ0Y1VUSHVRNG43TzIwTkYwK0J0Mm1LK3h5UGU1VmM3ZFVX?=
 =?utf-8?B?VjFFL2JXTkNLVlk1WmxlMGJaQW5pTzl5ZWE0QWJFaGV0NnQzNUdkTU02eEhI?=
 =?utf-8?B?SCtpV280bytNM2lFcjd6ckJSekZNU3VFYlFwZEVYUS9Ta0lhVzRYTWVuWEVh?=
 =?utf-8?B?QVk1TjFpYkJPMUxkODdwUjV1QkVicG9OVlcvaGtJdktkaENqUEZaQ0d0TTBo?=
 =?utf-8?B?WjFWMU1OQm5PV204M2dXR01CQ1JCc3NKbDFnVXhRS3VDRGFXYmpiaURMT3cr?=
 =?utf-8?B?YXNxU1Nlc0NEZ0p1NTROTU45QSt5enVoR3BXM2kwZVA4UUhWdk5uVHZsZHBQ?=
 =?utf-8?B?akVJLzBNcHBDMk1QTmlJL3BLOGZ6T1ZuYUlOUWpoaDYreTlDZzY3a09JeWVC?=
 =?utf-8?B?SW9BK2RZYTlRbEs4OFJERWdVSzN5VmlqaU1BNE5Eb0FOTUJHdmQxS0xWZ3Nq?=
 =?utf-8?Q?GuraQBibaqBCxxsoQ+QoZXw1t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f007468-1617-49c3-0eb0-08db0ef659bf
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 01:45:43.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgW2kthccmb8tYPsp3ocWxBp8RabKuBz+1+YL3GRDSZloVI1yWCoQRWDBpuscYpOhUjQEn0zpEJTOuB5MJ+WXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/11/2023 4:25 AM, Lukas Wunner wrote:
> The DOE API only allows asynchronous exchanges and forces callers to
> provide a completion callback.  Yet all existing callers only perform
> synchronous exchanges.  Upcoming commits for CMA (Component Measurement
> and Authentication, PCIe r6.0 sec 6.31) likewise require only
> synchronous DOE exchanges.
> 
> Provide a synchronous pci_doe() API call which builds on the internal
> asynchronous machinery.
> 
> Convert the internal pci_doe_discovery() to the new call.
> 
> The new API allows submission of const-declared requests, necessitating
> the addition of a const qualifier in struct pci_doe_task.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ming Li <ming4.li@intel.com>


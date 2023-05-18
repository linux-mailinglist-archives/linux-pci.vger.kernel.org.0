Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E44C708641
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjERQxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 12:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjERQxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 12:53:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D61311D;
        Thu, 18 May 2023 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684428822; x=1715964822;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LIf4f/2ILzMdE7QYHyioK8PC0ClFgzFfLjK3Dby2vAE=;
  b=NxfPTiynYe85MywNcZRvkIewIVyGZs3pIVewo0W48ai9Nj4DPwBdoxfG
   8/b7YCa69cI7FXnX8FJFxLTU5o3lNygjWb6k+jxYaoYxVeS/IAl2Rg8pU
   zXpwT5tvrWyBNPZdhA5onzErdUDjkVarh8wZwRvcbZSwq5SS/7HCAuuPb
   JQB9L6RG2+YBNmE/01J2QOMOi3YWWQnVL3b7AgYyN0L59Vrt798KFgwlM
   yyax64lNxgZCYjW3LIHz+0bAsVAExGAT+T0ydp0rume2GZ/RAuEXlDSAE
   FQ2+iBEc6Gcqu2s8fb0XJuSg40jEvHqhdFaY9ucW2W+JPKrEPk6KpMoaU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="438468373"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="438468373"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 09:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="732963028"
X-IronPort-AV: E=Sophos;i="6.00,285,1681196400"; 
   d="scan'208";a="732963028"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 18 May 2023 09:53:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 09:53:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 09:53:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 09:53:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 09:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTYS52vneRMF6B1SJtknomY8kON6EmrYXkIKJSOp+eIOu1hSkR99FazmKzgsz08dfSlNcDeAurcFI5C7T+gDjWNlycqVPz9fWzAWZHLTzVaW4O7qs78yyB1mKQQcLey/Kg0s8HKwgxSGnJE9KSQAc3t7vfxQAIKstm2dFgpTJrMKAGH6C75n6ge9SSbt+ViPw3re2EVgnqrGegltD4YCZh8ZzgLmOHKvJwwst+0EtcmuaijG1X2GdVmc9MODHPjtsQGLzYCxardnvwffPP84GfY+I6crKdD/ag8BrJJOZMfRcJaJWwMtuN1ywuijdzAVHpJMwtqC8wCoV8gZ1OugBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiNVHMRZRgjKJsPlgxcLC7Vv43LhrmjaOmxRpNWnEm4=;
 b=kCtYhAvf9e17UsyTpGivThsh3pfaCbkGQPeJ44D0A1UTIwAq3yk3YevgX4aldGnJqE01iQH4G8mdee80Byvm0SXTIdLCNIL0sM/GJdMdTSn8J5msjIsrzpvvrXCoCdPtS8mefTqqgIYfJXgLbZKHf82Klg/Z6YoaOiaf6IBLj3yKtV1J3SOU3AL6PqONHcpfdMAUV42B3I/4wFsnDyPSHC0cgikUtIzXcwGRPDDRFfx3Kp7Z61nidFCIXz4yx8hVaQYfX60jzQafQRwA7sFD0OtUoZOUquVnk4uNgx/iB6FxQrJC8T/A+yl0F22hNTOQJG7UhfFmVsDbxTC2W2adzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MN2PR11MB4693.namprd11.prod.outlook.com (2603:10b6:208:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 16:53:37 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::64d9:76b5:5b43:1590]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::64d9:76b5:5b43:1590%2]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 16:53:37 +0000
Message-ID: <996ee80f-f3d0-d0f5-d045-4636c35ce9b2@intel.com>
Date:   Thu, 18 May 2023 18:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/20] x86: head: add dummy prototype for
 mk_early_pgtbl_32
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
CC:     <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-pm@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20230516193549.544673-1-arnd@kernel.org>
 <20230516193549.544673-6-arnd@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230516193549.544673-6-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MN2PR11MB4693:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c355bb-406c-4694-ca43-08db57c06c49
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hZE8KcRWPJEjjVJ9PWCThrVafr+v7p0i5tuamnd3bQKveNYHf85txfZIeAdjg4VBVYy5a+U5ui4m3WUWnPosIWuG9bARGU8Hs2elA6qXInmJW5dARcqWFj38cEjnAILZyHQuyAwGvPo2hFjRpk/K9OK4WTDEqAevBmdMfuyXwtCA79qHtnaJtvEveGCZKAtWzvyOcHB9wygWLNzs+Uu1stlhhWpa2gpKuGNLUscTsYAHFvkUpZ1E5TNQM3z+J0a4ZbsUTAQ5jS6FLAx3F7iaqicv22TQHLgRbG7g2+6hHffO+WQNeDLvPIodMAG8yP9xj6PijKEAryHADTdh6JPJoPmWFvpqof7fpG06LFoHNPRAnhZtfQ5hPa6c5Zm9oGza8xMivjonNtPHZIcnpQlwOgF4KH4X02cqCy8DgTBWS9Awjvnc2T7bztIeKW7EbSLIKQAn+Tb0jjTREZkh9AwrGdsC1LSD4KpLmbM7jyuAtomnbghimbUnhh+9cjHzcDHI3pZviowsbnB6rLlvfze6BCTktNG7jab7x3URqwMGlBsdNVDpgpIdqCdE+gS5cfnZzxKlOakFyRjfTFQGmODi9pj9ueao8aZjG5sFYs4bHDyKM7iQSVfmKJQVyDA1y/6HwYAFVkCbfMBY/S6NKv6GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(6512007)(6506007)(26005)(36756003)(83380400001)(38100700002)(2616005)(31696002)(86362001)(82960400001)(186003)(54906003)(7416002)(478600001)(2906002)(4744005)(8936002)(31686004)(8676002)(316002)(41300700001)(5660300002)(66556008)(66476007)(4326008)(6916009)(66946007)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di91Nzh2WG5sZXZPTUFlRTREZUpWU09MMmhoZ3Y1T0FPVS9xOUZzYkNnTERP?=
 =?utf-8?B?YTJFTjNjQURHdzdObTd2cjZaREhxd1p6TVE2WXByTkNabVlCOHRCelo0WXRv?=
 =?utf-8?B?b0FFQ01wSlB0SEdnNC9jdW1uSG9BNjVtSmRpaFd1SEZRLzV3SmVTVzZQeXZR?=
 =?utf-8?B?TnIxRGVXMC8yN01PcHpjdFA3VVZUVWdwRVozbUVDQmpYUWNhRTg1OG1tMVFz?=
 =?utf-8?B?Qnl5N2ZkanZiUHMzRTRFOEs5RHNrcnpwRFU3dmVQK2VxTDhnUmNqU04vZG90?=
 =?utf-8?B?UHZlcTAwcXkxM2UvYXUxUytOaE9NL0FUQ01xa0dZNXlTQ2lhcG5YL1hlem1j?=
 =?utf-8?B?NFFaOUhTK3BTNk9HbmZ6RlhROTUrYnJYL2lxeTRDb0lacUVNb081Vm10MGhP?=
 =?utf-8?B?RWRCRDlSYWZUeFNsbDRrdTNzZE5NTEZIdENVRExMRGpZVzZSWFRNS2lDWEUv?=
 =?utf-8?B?eU4rRmdEYThQaDcwRXlQRUNoYllXMEp5a1kyb0E3ZmZadmxUdUdSRk9raW4z?=
 =?utf-8?B?Vk9wYmVkYXBYL2dDZVk4QVdCeko4dWp4SFFDRFd4YXRHOUl3N3lCbndrUnlq?=
 =?utf-8?B?dWZhd1g0d21NQWVsK1V2bnI5bmdhUGNCcWFQNk1hVGNCNFpVS09MRmFQNGJU?=
 =?utf-8?B?dUJRaXNZVklSNW5CRk5OaHFtNk9Nc01VQTZGaXVWQUtRYSt4dkVjUnFrVzJ4?=
 =?utf-8?B?N2pXMUtBV25KYTVhcHh5ZmFLZGphZEFCVjBFdGcrQ3A1L210OHRGZitvUzdt?=
 =?utf-8?B?RFNLMW02R1Q5ZStFQ2NQdlhOVWhYb01nbFNXU3pGWkZsOVNQRnMvOHgyaWlC?=
 =?utf-8?B?QlFOc1dTSTJJZ3cvazJWMW9lZmd2Wmg2eHkyOC9zU1RnbVBTNVVJY3NUNno0?=
 =?utf-8?B?VU1leWx6N1ZFd2sreC84M2lkeEdNZDluT0Y4b044Y3dNTU5hSTlqdEx1Sy9K?=
 =?utf-8?B?M1pLRGJraUZoRGRtc0J6YUlwLzIrb1BYVitoaG9SM2hpWmw5ZDMwVldEc3dR?=
 =?utf-8?B?ekVrZWJyZmtRSkpRNzhyS2xoOGFLZHdTVXJKbTlaaXJYRUEvWHRhQTRtVFA1?=
 =?utf-8?B?UTR1NU9BL1lpSlRZV1VrNmdJby83NEVvZ0k3TTlRTGJXS2QrQWI2Y3QyYk9y?=
 =?utf-8?B?OXNMSm1kTTBWRUVQL2pXSk95eVpsNE5IbTJzdlJ2bEQ0L3lHVnh3NlBLQWZF?=
 =?utf-8?B?Tk5XRG01bHUyd1BQbjFjUU8wSTJOaU0vZHY2VytncE5qNVFpT1ZnUUFFN2lr?=
 =?utf-8?B?SW5saUhyR1RHY0lkRnRvSGZSVjJCK1pDZjlLT1VTNHJ1VzJuaDJqVzYzdXZO?=
 =?utf-8?B?NmxISmROZUVNdlFzemJTYlhwOEhNNUYrWktRVm1rSHJFSU9MR3J2ayt5TDFw?=
 =?utf-8?B?ZU1GSlJnR0lDaUtlLyt3Mk9GRDdhbTk3b0hqejNIMm13Vlg2TUxRTHRHRHJy?=
 =?utf-8?B?OTc4RFBDYnQvWkRrOGNNSS80K25pQkJtTzNHb1FreTZoUjRRYWwzd2lnVXND?=
 =?utf-8?B?RFRXYkdMM2FwbHpZUnVqV1M2amdXNGNFWUljaDVsNGJyZXZUUDNXclUranlT?=
 =?utf-8?B?YWttcCtZTmp6b0VYbGZQaEdiMW9NMVd1N2NoNm5WNnBKVnllbTAxV3lMR2Zk?=
 =?utf-8?B?Z3lZRjY3aDdCVlB3UW9wRHBrV3oyQjM0MUFoNC9MRDhDK3ZsOE8xVHlIOTM4?=
 =?utf-8?B?SUxrM0dHZGY2aGxyME9vaml2Zjg3c3piRExjMU9XMVRZcm90RlpobUluMmxE?=
 =?utf-8?B?aE82RDJSOTJsdGJpS1hucE5XRkxXVjQ5ZTJwRnFuamNXbGxlazBTellTZ09p?=
 =?utf-8?B?M1ZCVnN5VHVMcDhLaVJyWkVXNkd6dkFjTytBaWlubDJ5STJQd3R6a0N4bmh3?=
 =?utf-8?B?MFMxNDNSdkp3K2x2MHg3anF5emRGcU9UemkyKzBLbVBPd2lJRHgxYmk5MVdz?=
 =?utf-8?B?ejduSjlrR3pzQlRZMzVvc1QxS3lGZkEwSmp5NU4wQ0E1Q0pvT2tUdUlkSXFp?=
 =?utf-8?B?amRqNkZFNnJiVTJrcXN6TGRlS3dNQ1VKRGlWODBlZzZqR1NQVXh5V3pJRW5W?=
 =?utf-8?B?WERHekhFSFNrVDVoc1Z4bWM2ZG5HWUMyeG5rckgwUmEvcHhQOUlVbFVRdVhY?=
 =?utf-8?B?NUNZRXMzeUpyVzA4RDkyYUsxMnhtRzFjbTZtN2FmNWYvdC9xRUY0KzgrWFJF?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c355bb-406c-4694-ca43-08db57c06c49
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 16:53:36.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unuITrb1NbgY33qlq+dkhVF/KvZ2G37sJ7EbviQNjPmyDmWyOJCWsTe6Kij8lrVqTeVDjiYnTOvNp7pOF86IQa9d3Bs4jBqN59xhZTWv/54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4693
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 16 May 2023 21:35:34 +0200

> From: Arnd Bergmann <arnd@arndb.de>
> 
> 'make W=1' warns about a function without a prototype in the x86-32 head code:
> 
> arch/x86/kernel/head32.c:72:13: error: no previous prototype for 'mk_early_pgtbl_32' [-Werror=missing-prototypes]
> 
> This is called from assembler code, so it does not actually need a prototype.
> I could not find an appropriate header for it, so just declare it in front
> of the definition to shut up th warning.

                               ^^
                               the :p

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'd say, for the whole series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

BUT apart from the Xen part, it's all black magic rituals to me :D

Thanks,
Olek

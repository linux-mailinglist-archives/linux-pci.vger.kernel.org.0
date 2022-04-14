Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4196501A93
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 19:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbiDNR4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344186AbiDNR4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 13:56:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB37EB08C;
        Thu, 14 Apr 2022 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649958853; x=1681494853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aLbcb2I1jiP01GmtoQYW6ZxPrfcu+8ZeIIYG1YjI8Jc=;
  b=IXRevJaJW7TooxyIWfbWR7BNfCcMKJwLgLbc9kLCsVkYRmc94J5W7l9Q
   GdSEeJJoVyVA2HQAuI5hApALg9xf7QBCmgt1LEnks4MpdsHNb8IP8Elzv
   Q62IFOQ6Ycv6IQaCAYusiAHXaPc8ooodxl6wowUbxyiA3QLMVrK9W/lyL
   cvntxJvAODMpuR6VBfpT5goAUBCgpB96pz5Afh9lL5AHQ5PTqLhzDQyDn
   xN4JXWfdrctvjaVy2yPW8erxcN2lhTE8O8lz0IDTS/ZP4hDCMAIqNh1ct
   3lVSg5TeQz/yT49ZFfFMS9dsu32/KRmymV5xjZp4o7Dm6tx7ekVWrYwF6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262439639"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262439639"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="645712695"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2022 10:54:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 10:54:11 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 10:54:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 10:54:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 10:54:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2jyVio4mqTaRW3672vjIzCz2wjstfEjhLNrtGUv9lfmUwzxD/3nNPvxTPCDRCNXktRSObJC+0OwS7IpBzFbVs+O+IZlZoMsWnATQKMd1I6TmcB2n2gFYzjqC9o8ng8ytCwME9Mkz1SYxyhXNV+zUV/0ADNAcckyLKWDouTHcan4qBxYaZCDDePJVw4eMRAENYQd0sJey+ElK/PV0Qmp6xllhANI6XlycIOL2FfCm3vvqIRhajX3H4kINYHj/TtpX7iLHZ7RPCyaD9FRBXfv6WS6kSHEkOCdflLmS6/2gbq2PHwA/r8IQx81l6uQ2r5sII143rIPdLq1N7JLoRq0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBYf6Yyik4WCzYj9L7iefWfDk2SoGpkq2QBWfFKlzlQ=;
 b=ZE03jjyEA9qxy1O6R10iSZ6UFfKhJtN9fgztVBPqElFDftTmuwN/J55FFQy/B3vWlzbxNpBXaDgRoOJ2HLkJoWzJEtH3GL4nOpw8+jxH2LGayNGY3cn/v0qYd5ppQ8yh1qmyG1rgL9UUTG7ItH2eRE9gQi6ZirRn3hHyKC0BfRRWUycXbxTp1L3ulxIy2y/3KCx9h6L+g655fg0PQiNWscCauQRco0NJgOELsZFkGzMwuipDaNoo9dhYUvJAxi+DMJtX4TArSDDXJ/W+ns7aEuWODAUH3wtEwvj77X1V1Z9MizCJfQd8LM4SqDptb6wCNEKKOGv+VK2PlEdR1Mg8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 17:54:08 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 17:54:08 +0000
Message-ID: <ba571993-90fb-ae67-6617-0b63571298be@intel.com>
Date:   Thu, 14 Apr 2022 19:54:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Content-Language: en-US
To:     Rajvi Jingar <rajvi.jingar@intel.com>, <bhelgaas@google.com>
CC:     <david.e.box@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220325195053.769373-1-rajvi.jingar@intel.com>
 <20220325195053.769373-2-rajvi.jingar@intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220325195053.769373-2-rajvi.jingar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18c68f93-8e80-4e3b-38c9-08da1e3fc62e
X-MS-TrafficTypeDiagnostic: BN9PR11MB5244:EE_
X-Microsoft-Antispam-PRVS: <BN9PR11MB524468C7B348BE4EF77834B7CBEF9@BN9PR11MB5244.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbW6gA0sRZvXtxQfvswOQpwpapkf7KgeaQrTRnuuh0HI6/YizVWxzLm5fD0FUMqpJSRtqAQqg6wAWAAGix0HIR9Z2cBkP/nYykDf+DuIc1HdNcU6gzRMwOky62DQWoM7iiv8OwW4TpD+RnpgdPuF5nqtM6iVV4dc+wryfDtnmQtFrC2qRSX06NGXlwaM9TDJN0UyMv4CeS/V5d0EWk7vKprQYpyIh2TzSdGRVO48rb4Cg/Qo3x6uQXOgsx3RfGtwqvtZqwWJHhRUHbc6NDqJlPkUCuQhnDDszVlabImhk/V1SYIPVQ52dhJZCIZE0dULzyIBKMngverhw2fFNDp4MQA2iPmBoOKDQNlBsRM+KC5DhQzqxzaFXpp/KhpZOFgbttmrFpy+SA5xUHPqMUR6jmePeRz1h8BMX++vT12M0T2wxSRzZ5UEJwikLf4Ti9IzlmIKw3cFMOns5s9K2tZONrv/GVg2/QQmENL+R7OyKsdDNq4UTD6M7sScC8qhz68/mpX6stHFEoU0iA2TDvYQOpBj4WbrtjefSCLGglV6dClLeSQP7wmMd9aRux/5DY1hnVcTTnJcdayzzlyRy9MxZygigfxE+I6ZzAjK0GzQIn+7mQBzoH50blqfH+5n+QdJ4EDibjfkIXfP3Syar1Fr3ONJYyZJ7rhB9K8B7G9lT6MYpIoyR3JkBeSNynXcx1AfnasyoNAYaI9kWG6Gmy+ubgKMHF8oLdX5ERmWcZvIs1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(508600001)(36756003)(82960400001)(66476007)(66556008)(66946007)(6666004)(36916002)(8676002)(31696002)(31686004)(4326008)(316002)(8936002)(186003)(2616005)(86362001)(6486002)(6512007)(26005)(6506007)(53546011)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZYb0RyL2hESHJtYkRiUDZGd3FnYTFOSkRCd1I5UFJPMk83OUhDR1cxQ0Jq?=
 =?utf-8?B?ajQ1ajk5OEs5bm5MSmV2R0dpZ1l3QzJSeThEUmdPR2Q3aDBuKzRNdDdmL0Yv?=
 =?utf-8?B?dmx2V3MvT0lxaUhveUFOUEFwMjJZd1Ryb1pVOUFIMXZuLzB5RVAzMGRwUkFR?=
 =?utf-8?B?MDgvNmo5cktvUUZDTXNjdkVkVjdsZXZ2R2dOWHIvRmZZVVM3Zy9KVWNwTWJw?=
 =?utf-8?B?OWpqcERJaytWRk8rc1Q4ZHA2V0xZWWxHeG9reWdzSGZkcmNjVm1TZzZYbzZO?=
 =?utf-8?B?MDd0K1hBaDljTU5FNGhnMS9XcTkrU2dwSklmN0VJUlA5NmRlMkI3clo3ands?=
 =?utf-8?B?UG9ZVHA4K0lJMjN5NWR1Yk1WZlFMakl5SllwT2FZMVBEMFpBa0pmTEV0UFZ6?=
 =?utf-8?B?azRrL1pXY3gvTm9hZm1Cd1NFOUxjdmtOREtXRHBYaTBEVEJNMGJGUjNFdng5?=
 =?utf-8?B?ZjBMcU1oRkFMQnkrK25Db2RKUldvMTh4NlhxRWpsUDh6ZFU0ZExydlNrQWow?=
 =?utf-8?B?TEJEK05PVVJ5cm15aHJ2T2JTaVc4TmtFdkhUVEd5aE9XRmV1Z0p1YnFMczl6?=
 =?utf-8?B?Znl4aU1wVVB2RkJVMVRDYXVNUlZTdk1NdnRvRXAwS3QxSWZCL1F4bzJnS0dS?=
 =?utf-8?B?c21mUU5vM2paTzYweFVyQWwxNVRHenhwc3A1UHA5L3dub0hwMERHeWltVHFw?=
 =?utf-8?B?K2QyZ1haaS91ZXdjaGtLWjJ4Z2lPb1F0SitLVitmTGZuNzU5cUdsTjdxQ0Nx?=
 =?utf-8?B?MXZrTDBoaHFzbDRCY0I3ZHBER1ZZWXY3MFJJSjh1RGJ3MTg3RTllWGd2Wklk?=
 =?utf-8?B?MnQrY0pudXczTm1OWUkzTVE3YVMvVWloTm51U2xhQ0RVcTBkbFp5TVgzL29M?=
 =?utf-8?B?OFhBMjcxcnNjdWRyOUNrTzR6UHp5Y1FpbG9ISlpoU0N3c25uRlAwQm1vQnJv?=
 =?utf-8?B?alhRSEF0S1ZPejZDeG5XRC9EdFo5RDNnYUtMQzNsSXBSQ1VzSFNXNVlDS0Nx?=
 =?utf-8?B?VnpSaW5Zc3M0bnU2NXVqZm5VY0txYWhUMlZKNHB3Y3J2aFJiUUlYaTZNb2Rs?=
 =?utf-8?B?T1VBTUI0WXFmbEcveDFOYStBalFQdVVSWC9pZnRIanRTV1BwbUF5aFpyMTFV?=
 =?utf-8?B?c1lJK2VmOWZsbG1DK0tNRHRHQkdvaTVWZVBGbGgvaWhKak11b2dnMzBDSDlH?=
 =?utf-8?B?WWtMOGhqK2pOLzludTdBcXI2R3FURHlkMmZFeTEyWnhpb2RhdU5VYXh1QVVl?=
 =?utf-8?B?N2lGcGc1M2FMekN5MGZSY2I3OFQrckEzaEdNaG9SS3dhNWdPeXZFWUJQdmxR?=
 =?utf-8?B?RkpVbE1MWmJSaFFiUitQd0p4NERaVU9EOTd1YXNOcVFpVEEwcmZEeUNJNWpX?=
 =?utf-8?B?Snl5RUdSMXdObWJtYUJLVTZETytYakFrSWN5SlFXbEFvY1ZoR0dSempjbkI5?=
 =?utf-8?B?STFHZ1JsNDhZTzNIUHpZdVphV1k0c3JlN25xOVhha3kwRURpRklLU3MzVSsz?=
 =?utf-8?B?d0I0NGsxVFdzT2RRR1c1VVMyODFlMkF1aldBM2V5TTd4eEhYYjRhT1hlODFK?=
 =?utf-8?B?QXk2QWFTUE1TNGlOUis4ZGVSTGl6VFlnenFjZVhOd2UwQlpMZ3ZKSFVndHp1?=
 =?utf-8?B?YVZPQ1gyTzU3OTRQaVQzRklwOWJydWhGSjF6aVU2bldaUnJVZXFZKzZkZmN4?=
 =?utf-8?B?REQ4bVlXMWhZRnQ5NTJGN1NjVTVBUXhBMURnK3NxMlp4RVVYZXdqK3Rkdlor?=
 =?utf-8?B?R3lPeGZlUC9ONDFWTHNwZ3hhc2Z1TU91RU9sVEFQUzBqL3NjY3E3RHRScUhl?=
 =?utf-8?B?RTJBTE5sbGF3MDdmUFpudy9ERHB1Sm45SGFaVzR4NCtnRjBNYmdMZ3R3K21H?=
 =?utf-8?B?QnREc3RHaUk4aCtzMGNyOGIveTVnckhBdGJUZjhXSVZlOS9OWmc4MmRFb2RY?=
 =?utf-8?B?ais4ZHB4ajYva1lhWXBIS1pBSXlBbUcxMkhCWjAxRGRlVUs4RXJoS3B4V1hJ?=
 =?utf-8?B?ZkQ5MVA0Y2xJVzhQVFJqa3VjWkxlMTd4Vm5nWEVYSGU3N2VLakJndk9rTG1C?=
 =?utf-8?B?eE1XTlY4RHVCc2xZUTEranVsenAyWndZelp2cE0zazVaRVYwRCt4ZlNaK0FO?=
 =?utf-8?B?NUNkcHJVRWFmQmsvcjdValdKU0JQV1lMQTBrbGE1ZWVyOFl4Q3dZUnBHVnU2?=
 =?utf-8?B?ZmoyMmJoMDFrVWhNRXNkeU5HdktIODFFbXFDWVU1dEhtZTR2ckRtcDVVZmxG?=
 =?utf-8?B?aUkrdXpuL1RabUpSUEpNMnViM3MxNEt6a3FsZldVcXZwWkFSNGZWUnZFaGRJ?=
 =?utf-8?B?MnFXZndLeXBtRVlmK2NMWjc3Z0RMbzJEczk0V01HMTVQSWN1MFk4a2Zrb2VV?=
 =?utf-8?Q?v0Hl09pEIYdoVpXs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c68f93-8e80-4e3b-38c9-08da1e3fc62e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:54:08.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEo1edL3KPj8cGd5GSnyjE6Hd9eDEBJiCqJ3pDvt0LrU9mS6+/I2Ueh7HW8Vhnz4gosr78xVwW6OC9kjzLYmwdX90ph3n19jouA7egE3UO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/25/2022 8:50 PM, Rajvi Jingar wrote:
> For the PCIe devices (like nvme) that do not go into D3 state still need to
> disable PTM on PCIe root ports to allow the port to enter a lower-power PM
> state and the SoC to reach a lower-power idle state as a whole. Move the
> pci_disable_ptm() out of pci_prepare_to_sleep() as this code path is not
> followed for devices that do not go into D3. This patch fixes the issue
> seen on Dell XPS 9300 with Ice Lake CPU and Dell Precision 5530 with Coffee
> Lake CPU platforms to get improved residency in low power idle states.
>
> Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>

Sorry for the delay here.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   v1 -> v2: add Fixes tag in commit message
>   v2 -> v3: move changelog after "---" marker
>   v3 -> v4: add "---" marker after changelog
> ---
>   drivers/pci/pci-driver.c | 10 ++++++++++
>   drivers/pci/pci.c        | 10 ----------
>   2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 8b55a90126a2..ab733374a260 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -847,6 +847,16 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   
>   	if (!pci_dev->state_saved) {
>   		pci_save_state(pci_dev);
> +		/*
> +		 * There are systems (for example, Intel mobile chips since Coffee
> +		 * Lake) where the power drawn while suspended can be significantly
> +		 * reduced by disabling PTM on PCIe root ports as this allows the
> +		 * port to enter a lower-power PM state and the SoC to reach a
> +		 * lower-power idle state as a whole.
> +		 */
> +		if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> +			pci_disable_ptm(pci_dev);
> +
>   		/*
>   		 * If the device is a bridge with a child in D0 below it, it needs to
>   		 * stay in D0, so check skip_bus_pm to avoid putting it into a
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..f8768672c064 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2660,16 +2660,6 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>   	if (target_state == PCI_POWER_ERROR)
>   		return -EIO;
>   
> -	/*
> -	 * There are systems (for example, Intel mobile chips since Coffee
> -	 * Lake) where the power drawn while suspended can be significantly
> -	 * reduced by disabling PTM on PCIe root ports as this allows the
> -	 * port to enter a lower-power PM state and the SoC to reach a
> -	 * lower-power idle state as a whole.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> -
>   	pci_enable_wake(dev, target_state, wakeup);
>   
>   	error = pci_set_power_state(dev, target_state);



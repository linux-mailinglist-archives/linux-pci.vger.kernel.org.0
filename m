Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718D67B8C70
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 21:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245665AbjJDTKv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245625AbjJDTKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 15:10:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C783CA;
        Wed,  4 Oct 2023 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696445996; x=1727981996;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dW/dkNl1wqU4puBUJijnvOTIGItv/qp+Q0BD228Rbxw=;
  b=mMgwIOXSQ3olQb3GlIH6oeztIb1xkPYshiGMRIerazCfNS1QGRpl9EL5
   63ehOLZUxyuGfTOdp86UT3tMaHFy6FoCkSkpLWu2PJb4zy1ldwFLkwjJQ
   kq/mn/pK1uHDKAxJrqeQnnaoH7PHTXd9RPjeWG9wjCOblRzQBWHZHHDuq
   833WPAvTdWu79TssFiWcmvpMg2K9nY0cjgqj0zKn9HXdgxS7qkw/96iGa
   eeCxfVvQ2t0Mzj58pyu4NVMTc0YNnVVBHUM522l5s5FGYNdYOLbaBvaug
   Lnh9pCCBa57os0MJ6BjH4YGSRmxw0K4nhJial0XFKuYuLBGhmYdVnyn92
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="373610299"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="373610299"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="780913177"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="780913177"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 11:59:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:59:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:59:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 11:59:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 11:59:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hogUNx+4gHzuCxOTxvWYt8d+d7Vvy6vfJNXu2E0dhsF1zvjwTnwhdIO45hSyV8x7wx87z+JKlqHhnuzDPMcf4nctGhSElh3EPhLoC3tOikz1zCNyjp64YbukTZTr3eGdf9yTBbFbS++7XyGPepp5IyMp0lQs2XVRiBn372fiCEgZzbwlnEAn5LatgpCoQbsA/mgLYbT51zzxO6L/Nmq5VHEf3UW7f1/2Ml1hauxYrUvV9UD5zzb8VJ/mwE3Eyxx+oFe09/NGUDtpZIYarKzlTGkFK0BZJTE8HwUBCI9Boo42r8iLZ/NQRVYEpXKUWjiwBLyt1ODM77+alXFz5h7uWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hEx3OL7Y+QeCXo2FiB6KbCHiiTpo9By9Ex2dhWq5Fw=;
 b=DdwSy35QMKCSDVNX8YKAOOfwPK0rOh4ul4kH7H/zBByHXG7bXP99jV0ixcB8a/RV+QRvIYmD4WdBJkfbKw0WMDYaGh5q4EE9pm0oeL/L88h1lbrW6ixNh845DGSwB8UvuFdh8zjZ9XSOWtFGscCymdIClQbKvKe1D2t/vcV0ghYG1iX1rrE4h0aDQkcy1gpPGjLRhaflQTOZv4CdyADfVOULPiMK8K2PTzxKxr98X1DEiHz1nPTSn2LO2cYUodA+82b4IZHAZU61XPSUfbgrJZoirGdyP7EH3H9IsZ3ZJ3c2c7t9T5PEmmWzxrhHUGaWE2n/hkZDYrhQqmC3J41trQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 18:59:45 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6813.027; Wed, 4 Oct 2023
 18:59:45 +0000
Message-ID: <4b92d9a5-5ff9-4a51-b5f2-6bbef286a502@intel.com>
Date:   Wed, 4 Oct 2023 11:59:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: reset first in crash dump kernels
Content-Language: en-US
To:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        <intel-wired-lan@lists.osuosl.org>
CC:     <linux-pci@vger.kernel.org>, <pmenzel@molgen.mpg.de>,
        <netdev@vger.kernel.org>, <jkc@redhat.com>,
        Vishal Agrawal <vagrawal@redhat.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231002200232.3682771-1-jesse.brandeburg@intel.com>
 <9f339067-2d59-80ab-4a8a-51781c623fd5@intel.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <9f339067-2d59-80ab-4a8a-51781c623fd5@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0348.namprd04.prod.outlook.com
 (2603:10b6:303:8a::23) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|DS0PR11MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba57559-31f8-40f8-e2db-08dbc50c1303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX5vD4Mxa1kv9F1OmrIavEUWb2BP/YvOc8VpW4H9IGtt2ZB9yEzqhZHDBLRT85ltBtXzikqm0TgF1S2GhEN+1icPsKt+bjRw8a3iELT2sl5kT6Q3MFEcG2KKQxEgLfjIY2VjbG40vNqtw13UKPjqYjsgACRvZTAbXI/xd6eSj+e1qPoWCttr25jxGYAB710L/DbAnuQh/yXg+mAr9mzH48MC0MrRQp4/ZF6hHA+PiyScZt1PpAfmeFOGT1ZG+x5PWYPUbK78h0MlD/gTQ9gAnBjJIql3AXSli0Wr51+8hcyFpNS3RkEtaDxGHH4dBPJuE/kMcUrTpBTmqfVe8UpB0FzCFolq2ShyM3W4OqssuRnL3ETn1v/qYkuBo9cRUdJKyHOMNonvUO92oiWE41c1cwDWuPohjqhfdf+JNoZ94IEktOG3iw3XtvlZdHTbPE1Sfai431l6uCJqv/NoE7Rif1SUY+maJK9+Z8V+5OrsfowHJp6v56HYgEk9qJJXysq/b49ehqFi+UuVlHYc/x/KRrVufe/L1pziYGdYHG083t8HJ5OmQt9Jdb3j5Z7cECg0ibwzr+H2yEWNNgqO4Wl617YOpJZ6BXonmoklHlqQRLZ8mgsZRNEPF/Ngdd3f1BuPiZg4WLmSz5KjxqB/JBIIyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82960400001)(107886003)(83380400001)(26005)(44832011)(5660300002)(8676002)(8936002)(4326008)(6512007)(31686004)(2616005)(6506007)(53546011)(6666004)(478600001)(6486002)(38100700002)(316002)(66946007)(66556008)(66476007)(54906003)(36756003)(2906002)(31696002)(4744005)(41300700001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NOTytTajJjTmtNT2tuNU1hZ2U4bjZzayt3aTd3MDJSdWFIcEF1US9rQlRE?=
 =?utf-8?B?WEhydUxEQ01HYzFXN0tsZ2IrTnp0OTBGeGtnaFVvQ2tYMGlZdHk2d2RIVkN5?=
 =?utf-8?B?Uk05T2cvcDk0Zko2UHd6Q1FIVko2V2VIdndRSWVNMW1aaXQ1UVNkNDc3dTFl?=
 =?utf-8?B?T2YwWDVsY3RMc0x6R3pyR3pUWTROUW9HeEI0NkpEYTNxa1hnM0RoRHpKcUtO?=
 =?utf-8?B?ZTJoUnN0YkI4TXhMTXlnZTkzVnRnY0tzcUc0eHRuRXc2a2FRSE1neXdtSUtN?=
 =?utf-8?B?cGsxQWxaZlVJZWkrOFZGNFBwcWxhMjFCTXJWOW16QWtwMlZMM0xuSnQzWExh?=
 =?utf-8?B?SGtOcWhjVnVDTFgrSGVibFhGbkNMYWQ4YklucEhVSHNqazM2Z0JoRkxHYXVS?=
 =?utf-8?B?RlVYS0VEQy9iUkN1Sk80ZUVhOFJJeWF1NjlKLy9hOHk1QlJRbWtYb25VTnY0?=
 =?utf-8?B?Z2xVVlJTSDRCNnY3K2RVSDU4empGbFl6R3ZaU2ZLMUtsUlB1dGxJWEVnUzQv?=
 =?utf-8?B?ejJjRjhjbUlUaTIwaHVROEtMQ0hWOGpob3g3Q2pHb3NyU0JXREpsMEpvZlFT?=
 =?utf-8?B?aUZuc09ERlFiQ21xV2JYZVA4RlZwaE9XSmRxNVVnNzV4WGRicVJFUi9UbUJX?=
 =?utf-8?B?WE9YVDBTZmRkM3QvN2hXbFRpZll0RlpjYjBNYnlPVGdUYU9HKytLNmhGR3hN?=
 =?utf-8?B?WkhuK0MwTTRoR0cveGlDWWlMeERlZjJMYlhYeWZUdDJoYnI2SnlDM2tpcHk4?=
 =?utf-8?B?T3RHU3JWWk4zRTlIeU1HZWRxZWIrY3hXS1RXd2JzYjlkWFN4azZpb3o4dkVh?=
 =?utf-8?B?VE5nb0U1QUhzcnpoQ2xwTU1rVjZndExQd0t5elN5RCtIQSt3QUcyYlp0QlUz?=
 =?utf-8?B?OElEbWhXMWVzZktFWFN2RFR6SE0yWDBWSTZ2aGl6SnVrUjFrTGlveG1YaUFx?=
 =?utf-8?B?b2lXQWFDK1FMMEhBZzlPLzZxU1ZGLzE3cEh1MkRvdVpsMHVpcEM5RUpmTzdF?=
 =?utf-8?B?aTFSdVNRNjY4MkpHVzkzM1dJMXk4UlBsSk9aVmVMd1V1a2RsSTFXMDFSZnI4?=
 =?utf-8?B?LzhVWHhZeEZSYjhQUE1BQnBIdktzNTNxWjhNU2gzSnFaNmJ4ekVYckdkelU5?=
 =?utf-8?B?WGxnVnI0bEFmRlM4bC94K0E2M09qZWs3WjV0WXVIaWFBRmovUUpkTWxhU0dC?=
 =?utf-8?B?RWszZEFycTBVODlkRURyNVRNdmdRZEwyUHZYWmttUmhibUNtZkUzeEN4ZDEr?=
 =?utf-8?B?d09KWnQ2Z3lmcURGMVM2VytlZURZNXdKTlM5ZHMyNE1IUzFIZ1FHNlJSMm5Q?=
 =?utf-8?B?U012R0p6NEM2Wlo1Z0FjM1hzWFg2cnNQYkM3TmhyMHNRTkhJRUxFVEcwUDc1?=
 =?utf-8?B?RzdCeFVhUytCUmFTSmZGblRvZ1Z4M09EbXhnUkVCdnRGUDF0VnlDMk1XYXhR?=
 =?utf-8?B?M0N3cDdNYTBuWi92dG9xeEJPN05KWjZHWUd0WnpYTTNNQjVJRytNVXpGNkFp?=
 =?utf-8?B?TnoyNVhHSEwvK1piOTRjYS8zelFHeFpJTGVTOEZPaVBESXpLWUt4U0NDS0RV?=
 =?utf-8?B?YjhnZ2I2amx2Y2o2MmJrQ1hkRnI0V0E4YkZvTDkwUThOaFFra1M0YkZVODl4?=
 =?utf-8?B?RDlPWFIxWDBaRTdZallKclZ1bktyMlJQVHZvS1pydmhldm5aZGliRTJHUkZP?=
 =?utf-8?B?eDVyTEFYMFEvbEFNTUZBTlJTUGhuVnl3STdJRmxYUXRJbW5WcllTRmhQNWxZ?=
 =?utf-8?B?UHY3MFVvdEJadlBTUHpMT3RXMWVsdXhZck1xaWpVYllnSmZZeTZMdmpFY2Rj?=
 =?utf-8?B?cnI5Z0RUN25jZEt4b2NabUx1OEphbm5PMm9pRG0zL252VU1hMXFJYTZSWk9r?=
 =?utf-8?B?SXFlVUhNRlluL2FSTk0yTmVCZW5ZczMzS0R2SkNyUkxlS0VPUXEyYVc1Um80?=
 =?utf-8?B?QXJ6cjdld0tIOFhwUkRRRGZaVFIzYSt3YjZsdFpOSWR5OWVlRCtSMGw4NUhw?=
 =?utf-8?B?bU9tOFdWK2xaTnY1MzBBN21YTmlPRFY5b3NCeExkcnVTZ3NOekx6Zjh4am9X?=
 =?utf-8?B?VjlQWFozSnc3SytwWjR5djBpNVlOV2FpcUJ5TGhFYXo2S3k3MkZnYkE3YWpT?=
 =?utf-8?B?WnQ3SDNOOGQwUzd0alFkbjVzYm9lcmpRd1Y3SEY3VXZGQlV6UkRDSEJzU0w5?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba57559-31f8-40f8-e2db-08dbc50c1303
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:59:45.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJl9QVkpL/uOYtbzngnlPLuONcpmKjhkZAUgeXp3xKp+LxBemVZSzG/34vqkxREiXfnyel8KOL6YLGN7PhjfpEDU/dIfIP4mc8BigK07lq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/3/2023 3:41 PM, Tony Nguyen wrote:

> This is missing a Fixes:

I'm not sure it is, as I hadn't put it in thinking that there was 
nothing to "fix". But I guess I can put *something* in here in order to 
have the auto-backports work nicely for stable. v3 sent!

> 
>> Reported-by: Vishal Agrawal <vagrawal@redhat.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>



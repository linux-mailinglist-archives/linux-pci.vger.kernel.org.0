Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7775833E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGRRLL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 13:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGRRLK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 13:11:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDF188
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689700269; x=1721236269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v99rs/ftkQBmWzyhvHlOxZ6W6Q4rRVTzsWYBLTJ+NtM=;
  b=likiHNhOSFTj5k9SuRrV/4rOGqUoSddGkjKIgQlapzLCA5HLRoerPP46
   mgMFYeFOmL4nwn2yFy0vlqiWryq/s6FaweAcvLGFMmQemcYVH32Nm54by
   VaJH4j02oT8tZoirirkXMQ01EeOSQZ3pBOcyIz3f3w+0ZxvOodZObqYKf
   CXaSZotQ204VNlsMM2/Yv/iQRnWfYHMLD+8wyIbzTykREkiPLZ4k5Fdl+
   KP2uMRUPGcZF4bSE2TYd9fh1qUJ0TD/IJ4dPuDOzmAkqe1v8lfBdFhZGp
   OPOh9kKCWBqYzW7QLM+YpwfJA6b5o4k5NSa4LcWwCj3pusdIgwQwIWnD4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="368906470"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="368906470"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="837342739"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="837342739"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jul 2023 10:10:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:10:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:10:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 10:10:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 10:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7Uzd/d9VxWuXm9ShQS8kP60IXyjdDzEmOaTGnyInrieXxR5haG1dWAxC9qb4Biwtri5pjn/duyXW/3LzVnxRKmKK9knO9xAYdsLUeLcDdqyMYfW5lzb6r6emVurqNnyUOdiQ9bZU/9x5VgBY6WxL8n1w8PA7XavEALH9t7P1rBlz0fTzPmBeFk1NNNXNZYoeS9zU2ugtAuBv1j5P6JM9ToJgl66xiJUHHGssTtUJFppfA5ZUCz1QArQD1uoVtfOyC+rHKdhAnOJB8tQENQjVu3XOCDbO6UNjdDRqg3jqcFW+uRhetDrsFDHgQMzhJAtOUt7XSZ1hP4R8F6qkrfctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h05Nr3AgBwDNzAPJv7EkFclf2RYBwXubzW8+P42JnYc=;
 b=FZb8yvO/p1uskZZxM4F1426kc7jtQjzJ/b8WF0eZD028sJuXAk8cNPRtRpH65Rz6M/yLfLQcX9amV4ARptsY+qsLrkzo/rzdne5TDjEtUJA7wMgmQ3nyGOWKCFGzb4+I0nn3FO8GBnvUr19zH1LcWrLwuZblYBksDXeDyb1CUue+oiKAcVrmeTxCgKmIA5QFRg/hsMZT/Q3aKiBRWN2RN4oZDtc2yxWc4TNyfSGQL7M31KxsIMhufHeIXakGmRIB38B68Sxx2aL22mFoQ5KSbr8yLX7Rr8+F8L9J9tSjaNOjz7stjAeu5ISDKBB54epqcEH0moMyyC49NDbDR05dEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by PH0PR11MB5784.namprd11.prod.outlook.com (2603:10b6:510:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 17:10:45 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::3d4e:c4ae:f083:de21]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::3d4e:c4ae:f083:de21%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 17:10:45 +0000
Message-ID: <06c17403-fb5e-ff14-4707-829ede312336@intel.com>
Date:   Tue, 18 Jul 2023 20:10:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Correct the short
 interval between PTM requests.
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <intel-wired-lan@lists.osuosl.org>, <linux-pci@vger.kernel.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
References: <20230718164544.GA486141@bhelgaas>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
In-Reply-To: <20230718164544.GA486141@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::7) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|PH0PR11MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 257654d6-9642-426f-3fdc-08db87b1ec62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQESmrN6ybnJfRBfXq8qFu8HMLeG3qxZHc6XqlpAoMlrJTMrM0npd42FcDLjqOuSvN5vQ0e0A78zf2uJuMFpRySHmsotJorv3GaJ3voyxOphchLv4CIC/iSNNh3k2IghBJoLM/jb2Ma+N64fzjs/6H0wxpQ279mC7DDYt66b2BmlyYC/Ohcw4ySvwtSmrAaZD1DhWg0H1TKnWzCUDodnfp1e4OunHsnxCjnXLMdO6fBcpIcqje7llhzUjxaqeLW7VI/Af3bywj3CKfDbTzjbwDjUJQe962GQCRbbEpJyJe02r9B1tMQ3oA8OdyhUPgljkrPrHk4zafRV0e97RD5UzWWTbSa0eRFRK03dNVhYkFd+jkFXEofbiTj50r+uwr4gMnseD/MQh7CgyV1AhFiX2BwJr/bAoB9a3gOXJeqzRCwwXeMgILS7PDvsGhGZmkQWPx4M0wvBxNRq5NATSC+M5oEJVTZTiPQt6m7PlMJp40kWMzTPvFrPNRGa39i+1YtKrzkPeoKOnxpRNGfmKR4XcsQ7mzG5IkkjibV+UhAyQQhFsVp/j4jtkV4pIE+Xl/hYLNQEj/Bt3yLA1jEVlv6TtsYXe9YstidDosYWIgSU+Qg8/3gqOn3idqHhCZp8q6wpSTRc341jCPtdSAjfPHb+eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(82960400001)(38100700002)(31696002)(83380400001)(36756003)(2906002)(6486002)(54906003)(8936002)(6666004)(6512007)(478600001)(2616005)(26005)(53546011)(6506007)(5660300002)(966005)(186003)(8676002)(66556008)(41300700001)(66476007)(66946007)(4326008)(316002)(86362001)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHN6ci8ramlMMkxpb0g1cHpNNyt0NEtwdkpmenBzODMwVE0zZUtqVHA4eTFP?=
 =?utf-8?B?cjBGYklSWi9BOWpGaUY2bnl4T3JIRkdpNHNPcmp4QVBYdGJDb1EySGEvdDlj?=
 =?utf-8?B?d0hmdlJSYUFUaFEwdUhCNXVrS1VFRmxDRFpuWDk4dVU1bUtqTTQ5YlR2YUJv?=
 =?utf-8?B?QmJwaDIwdERHcFEyOU8zN282WWVWTUJmZmFESForZklPdjFGNGpQbGNpQjNL?=
 =?utf-8?B?R3hmU1JBOVQ1VGhuTTJmcit3ck5XQTRlWFBtU2VMZHRRdE4yUzZ1bzFMUkhJ?=
 =?utf-8?B?bW1mQnkwaVJqQjdKZW0vcGllQmNzNlZaaTJ3b2VVaGxTbE5ocWV0NFFMK3dP?=
 =?utf-8?B?VTFNNUdYZXhodHY4V0piUTlrWHhxNkpNS1JyU0hmVUxvbUM5czlTYXlXZUtv?=
 =?utf-8?B?TFU4eWk3WHM2NzJXV3JEd3hOWGtiMFVPMVRQUkE4RjhjMU9aVnpUS05UMGR5?=
 =?utf-8?B?YjJzYW95UWtvT1MyMXhReXZ3UUM5aXRiSkZLSG9aL3JqTXBKYlZZMFdBYzBQ?=
 =?utf-8?B?Q1ljZUFXd3BmUjIxcjd0WTAwYnB5WDZRZ3VYTE5SZ3FITzRBRUN3Sm1wVk5y?=
 =?utf-8?B?eGdTY2sxNVBVVG9RcjZlYlFBSHRtSkk2eEFXdzI1WmlWYXgvWUxOUTV4aHJq?=
 =?utf-8?B?ckliblpsMUFId2IyTFFYMkt2aTk3MU9GYnM2ZjlSUWthc21RNFA3d0dHeUF1?=
 =?utf-8?B?Vjk2V1M0ZWRPazFUQTRVUkhVZHZlUkx0ZHJkR2Jra3ZZQmplOTROdEhUb0tu?=
 =?utf-8?B?NkZjWGJiV2NMR0ppNDZLWlArMzZYRFZhdGpwMmVRbkZmMDg2eWhkWGpvTE8x?=
 =?utf-8?B?WXN0QWc4bFRRa0phMEFTbDgzUGpiL1plUGs1UGV4VjZxNnFwVzZ6WFBlU3lB?=
 =?utf-8?B?WW8zMHYxZGo0YnFsSHdEMXNveERyeDFjbk9FT1d6REc5cVVPcjQ3c2FMMXY1?=
 =?utf-8?B?ZjlJM1Q3U2oxV2UwZitKYXJEL0hHNkFBNmxRQXROSWFTZjZ0RDJXbnlCNTZW?=
 =?utf-8?B?bzZIWFFFOWdpc1QwVjh1a2RyemFrcVZtT1A5MWU4cW5qbGt2aGFQUHZRVXdU?=
 =?utf-8?B?dkRlczgzMlVvbHlYZWFuWXhvK1Frd0x3U082WHdZemNqVDVKWHgxTFVKQ0Fp?=
 =?utf-8?B?YWZBNFVxV1NCa2FqVUpUQzN5M29JR0F2QVJSMlFDQzJ1Y1RqOGtXMzlDVVcr?=
 =?utf-8?B?ZXdsZXd0VUZTQzBWMmJHVmsxcnV6OEtKQUVSK0xVVlhmenFBNnA5VWJiUjdO?=
 =?utf-8?B?d0ZzQS9IVlJ6SmtlWHVLVHhpU0E2WW9Yck83YkNBK2VaTmNPWmZjaC93VDc3?=
 =?utf-8?B?bElwd1pSN29rSFA1NjVQMnlkOENsK3pMQkZmaFdqUnJLVjVGOUVwanBWbzUz?=
 =?utf-8?B?eS9UZlo3bVdhU2tlUUUxRUpQb0ZlSkZKL1hqSWhqWnRteWdPbzREN1JNWFBV?=
 =?utf-8?B?U2w2cHYxWWJHY0Q1Q0FYdTJ6ZVhoRG5GV1M4ZjdNemJ0YVR5a0ZZTDhFZS9w?=
 =?utf-8?B?QmlabXIwd1NDdENGYUk5YTVlb1NSOGx1NzRhSVRlQlF6WGJxckIwR3BNRDlT?=
 =?utf-8?B?cEhzWlpTY25VUXhXZmdTWW9EeE5DamR1QS9ISzN0a2hZM2toV2YyZEdiR21Y?=
 =?utf-8?B?Q3NOaGlFMTR4RVUrUi9TQnd4Mm1lRFQ3Nzk2R1VBMFJTbnNyZ0YzNW9FZmVp?=
 =?utf-8?B?Nm0vbHJKMG1UVUVjd1ZBTHVtbEFTTm1OT2NaVGd2QStPc2RVRWVwTy9UWVlU?=
 =?utf-8?B?c21TRkt3NnFRT3RjZFc3WENydTlhYzRyM0xlSG1tY3hPTTV6ZWdXS1IrWXZv?=
 =?utf-8?B?c1FaREF3d0dpMklOck1tMDcvNDVwYUpRVWNLdmdnUGEyR1F5V2ZUNXVtcXNN?=
 =?utf-8?B?UDM5bTFkSklYNFNmOEU4eXYyejZRek9vR2k2Y0NzUVVOVERpUnRWdHdTREZu?=
 =?utf-8?B?dUVsNmRtR2M4NzRnQ25neXUxdEhqZnJSYWs3S090OVBXUUR2T0tqTGhBelVB?=
 =?utf-8?B?ZFA0K3VyMGZEVG5zOStIRUY2ckhlOGRXM01LcGxicnlxUHhoclZFa0g5S1lF?=
 =?utf-8?B?SFc1TG1UMHlWTFdCeHNRWDhSenJKWGszOHIyQ0pMUFEwTFhtdTlTeGR1M21y?=
 =?utf-8?Q?GAl2VvIzA1lFW0m0DOJjqfw+L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 257654d6-9642-426f-3fdc-08db87b1ec62
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 17:10:45.0349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UhGApy3ursBv1OzZO3L4WrZcEwGiuUyKTLTDBWYvYMUZgcYPXOA9VMzW7AEu5rLEsUhWjO2vE4bVkbDzklOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5784
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/18/2023 19:45, Bjorn Helgaas wrote:
> [+cc Paul, Vinicius, Kai-Heng, Guilherme]
> 
> On Mon, Jul 17, 2023 at 08:19:27PM +0300, Sasha Neftin wrote:
>> With the 10us interval, we were seeing PTM transactions taking around 12us.
>> With the 1us interval, PTM dialogs took around 2us. Checked with the PCIe
>> sniffer.
>>
>> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
>> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
>> index 44a507029946..c3722f524ea7 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
>> @@ -549,7 +549,7 @@
>>   #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x2f) << 2)
>>   #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
>>   
>> -#define IGC_PTM_SHORT_CYC_DEFAULT	10  /* Default Short/interrupted cycle interval */
>> +#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */
> 
> Not related to *this* patch, but from looking at igc_ptp_reset(),
> where IGC_PTM_SHORT_CYC_DEFAULT is used,
> 
>    /* PCIe PTM Control */
>    #define IGC_PTM_CTRL_START_NOW  BIT(29) /* Start PTM Now */
>    #define IGC_PTM_CTRL_EN         BIT(30) /* Enable PTM */
> 
>    ctrl = IGC_PTM_CTRL_EN |
> 	  IGC_PTM_CTRL_START_NOW |
> 	  IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
> 	  IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT) |
> 	  IGC_PTM_CTRL_TRIG;
> 
>    wr32(IGC_PTM_CTRL, ctrl);
> 
> Obviously this must be implementation-specific PTM configuration,
> which is fine.  But I assume even though this sets IGC_PTM_CTRL_EN and
> IGC_PTM_CTRL_START_NOW, the device will not actually send PTM Request
> messages unless the architected PTM Enable bit in the PTM Capability
> is set (PCIe r6.0, sec 7.9.15.3).  Right?

Right.

> 
> I'm asking because Kai-Heng has been working on issues where
> Unsupported Request errors are reported because some devices seem to
> send PTM Requests when we don't think they should.  See
> https://lore.kernel.org/r/20230714050541.2765246-1-kai.heng.feng@canonical.com

I know. This is a different problem. (I can not reproduce, we will try 
to get HP dock). We will think how to help here.

> 
>>   #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
>>   #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */


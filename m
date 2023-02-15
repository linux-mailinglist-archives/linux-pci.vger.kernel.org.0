Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0266973C9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 02:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBOBlr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 20:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBOBlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 20:41:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033122A9A8;
        Tue, 14 Feb 2023 17:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676425305; x=1707961305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C+Jj919D1ZbYhAvPcMQzVIQNUZmea8Dh7iKQSGXVglM=;
  b=dYEaI9r1P79H40IDxO3dwitcHR/5n3BquOzV528l6O8JM38SCjV8gWyD
   BVJZnf6hfgSKaJjm5rXEhvKZ+3s55icKMncjTWAmzumLXaI/Wzj8E68+W
   iMaVDzbMREJufM0nb+cPYjwVZfzkhUJe5XPb64UgSYBg1DjOnQXS0G8wh
   Wqf2mt3E2FLP6OlYcmGdObaxVP0QVZfUD1tEap4OLnz0qbmH9t7lOjGnl
   5c60kW87bDaJTIWDw/AE6KY5D48rlQI9D7Iw7XYnRXtMe26++HJPbVLWi
   ZBUZIVFc6Lvv+ntNrVzaU6ZdJFotWENIBcUddi/p638wP8L3VFhnt0u4J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329036346"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="329036346"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="843381822"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="843381822"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2023 17:41:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:41:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:41:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:41:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUmHMPXI0hbQ8yWn3V42b4EMIVcmq9n7AeyoeWJ2MDXQa5lbZ3v/4uQLJvHq+r8SQME0nxEcO32OLo8viOxG17z/LqS9izB/H7hxoDSMToEItXqyQONWMzXeT6DNiv16LXKZDJ5CHcmFsdgUIeLCBWRMysMA6uCS0Xt+ecjEQ4gnGIzNS42iQIn9zlPSmOdr38t65gM7jyEopAyQDX1RmlvsygMBSGz8Z1qjxZcSLkuSuAoMOntCSKmpXFXLTp0cH7Rltb4uPT6Q9kHJMHso2zo4LaUPa40MRUV11ayct8Zs6NTNiPRFC7zimOs6n5R3KfhmkJOwBvAOxRfGdkWtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLmPqrXVLkb5XySPLM5LHwSz07PjW5HrtYsztFrb9AQ=;
 b=I3OnfENQnvHf2Lw+/BX787me7BW1DbAzV7YIg1EU8pX8nmk/IgNTAE05++lDuLn+wjlE5ff6RLU1FG1KXu6FgqVUPAF1SW8x0IuFmMj0tfpzKxw6VIzpDyiB51+tcJMiXyQZH25omEi485cuPvQsnVmXXPnFR/jM7ThYdM/dJ422ekCeDbShCRTO8PUmRWjd9eWGX2dEFQ4mFJSKdTQrwToDWvEoXJz462RFS9Kzn/Ba8/dsvDa6wEU8UfsWJQGkOk7SKEKpLFPWVj3yOJFBuWEJvthNuudgnEBl/GKxIH9h6RrHx0GPJoX+hu0JwXIPuFe7xzpAtqGebztxGGLufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 01:41:40 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%5]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 01:41:40 +0000
Message-ID: <7967c780-d4d6-e802-4d5b-7bde4ec71644@intel.com>
Date:   Wed, 15 Feb 2023 09:41:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 02/16] cxl/pci: Handle truncated CDAT header
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
        <linux-cxl@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
References: <cover.1676043318.git.lukas@wunner.de>
 <7f7030bb14ad7c8e0e051319cf473ab3197da5be.1676043318.git.lukas@wunner.de>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <7f7030bb14ad7c8e0e051319cf473ab3197da5be.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: e59b2fe8-693e-4d96-9dde-08db0ef5c864
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmvOIYTzCu8kHtjxdoVkBCXiB+SEbkEqLEqTAU0At00w06RZMPdlm1IKLXwuEtAN4AJX9TN7IM8bBgpDMNIwfDvr4Mv4bJEaoLn3HBVzzws6IwmQvNWSgIWvj1ZwnsG98HPhrFBhABzYzOt+AQ7yTftbdEPAUBxuCdJMeEG54/fojhHRoZNx90tEbw5Y86gRw5RlxA4PWLN3+dqELvgRDzjmHrXGYtjoGnWFXY73rOa7yUbbf8YA/uo5IIZ0hghEdeBe27JGLOIewOOUjn8vyvq6LY9PVGzBP62PMPLiDk+hW80YeiJyrc5WtXg/JUdjJVbnp/cydegARrkYCmShtiMNIu/ftx01JYyP23gXJWBfJ/XLIMxzAjbcxPpvLd3DIPBBsjU9dyKAQ8YFfKhu7EtkaAQStMP5+7DbJfXmDcWDkcL8zDygMJSuz9Qrw1F/aoLe6D/ziqH54QbhL2jsF2RX6l1SIl+U9b6WV6kOLB9ih6JGe8rmv5nHNeK05me3h0NyZHBIvTdIvLuQONSZGjG7i2mtZPHtc/qEJdcVSGrLS8pnvGOzrAu7n3/lloxLwnZf3owbrYGD+2AXFW2DxvLGlbKRGYFaTgevR07qrKljPe9KJUTXvm14x98nQ/uWzfpkGq44phxs818oUnB/aJ5gjTuM9yQBR5OZoCD04Sn2VlGdTJXWcoyeJZdNiCQlyzlu3RejHUcvfRKAtm5Y5n059pZjL0AHQUNLwZRnUPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(54906003)(83380400001)(478600001)(2616005)(6486002)(36916002)(53546011)(6506007)(6666004)(36756003)(186003)(26005)(6512007)(38100700002)(41300700001)(82960400001)(5660300002)(86362001)(8936002)(4744005)(31686004)(31696002)(316002)(66476007)(2906002)(66556008)(66946007)(4326008)(6916009)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2trcHhkdFp2WHVRVGRlSWZxMVZMZTlVM0Y2eGY0THF1eUdrMk5jdmpyTU01?=
 =?utf-8?B?QlRnVzZpaGluekRPNWNmaFFLMHlmS29zTHJ1clZUbG1zQ3ZCS2pSNDhNdDdI?=
 =?utf-8?B?OGhpdCtwMGJvaGJqZDFSSzBubUljK2R1UTdKVk1yU0oyZERxeGRiSWM1U3dB?=
 =?utf-8?B?WVV5Q0NsWmhXZjdJWUJwRTFXYkxWWllaSllxZUl4bUczeXUrOWdhZnNwWWpr?=
 =?utf-8?B?R1ZDZnR6ZkRvbWRqM2NqYUsxeDZOdGk1d2NZSEdTeFk0R3MvZjNNSHFPdGM2?=
 =?utf-8?B?bzVON1pNTWNIMzEwbHlUSG1tbFh4eXVwd3BYMHVRaEJWaHIxaWd2QmR2ckYz?=
 =?utf-8?B?c1RYaGFuZ0tBUmp4ejNCT3V6bGlDSG5OTlA5cXJKbktDUzltNjBrTE9HM1Bh?=
 =?utf-8?B?UjRlR1U1QW95QTFmcWpid29lVWQrYm5xZ2RCUzFEd2h6R2lCajRnRkk0MHNy?=
 =?utf-8?B?WjMrK00wbXMyd1V5UHY1UVdUdVdUb0lHVFFBcFRlS1ZHVkRCcTM4aEZkT1dw?=
 =?utf-8?B?QUlqciszelZUNVMxSEF3SmhGSFViZ1pKc01nR2ZpSDJVcWRDYWpzSE5GVWdn?=
 =?utf-8?B?Wjh6djZjZTdZdHd4UGpIbzlMRXBYVFhDK2hFOTBGNDBQZzhHeUU3V2tjbnlG?=
 =?utf-8?B?TlFCYmpBWXlPd2RjY1k0ZWY2aVFGQ3ozclVLVFFTOU1EUCtKT1BRWXBwMEp4?=
 =?utf-8?B?dCt0c2IrbCt1Z1djUjYwMGJ3ZGlMM2V2cThFWHdrNVJPV3dzdThTeUpURHNY?=
 =?utf-8?B?WnFKMm9NT0x2QytneFp2dmNEMWVSa2hhOWI1ejlIZTZIM0JMRUVBaW45TVRq?=
 =?utf-8?B?ODBTK2h4ZVFxNlR5cWRtL0l0bTVaU2tyU1NBRFNwdStxN29Cd3pKWi9zU0ZD?=
 =?utf-8?B?eGE4dmdpRDdPMFJEaFliNEJ6cnA1ZkwyUlcvZ1RzUXgyTWF0ZEhqK2pJdk0x?=
 =?utf-8?B?TWN3Y0V0RlkrMC9CbzlEZXVQRG8wTTJCZmJtN3lVUHpCd2RNUXI0aVNzanJM?=
 =?utf-8?B?R3EyU0ZOdFZ0UmZ1Z2VMM2hDbXlzYjRMNUwxRjJwb0k1ZG9qazZjMGNIeS9z?=
 =?utf-8?B?cVdIY3VZTTNyU0htWGZWMnlqQXI2RWQ2YzdDTHN0Tm9yVWRPdDZqNDZrVXcy?=
 =?utf-8?B?YWNJNU5aczJ0Nk9BYWRVNFdtN2cvVnNPNVBVYU5xaUdOLzFabFFwNld5dFZK?=
 =?utf-8?B?enVzVFlvb0xmTmkvYXZhZVlKQlFRRFZnUzlFbWQ5QVNKYXFmbTFVWmY2dW1R?=
 =?utf-8?B?T3QrazE4czVWcWgzYkxiTUtXQ1RJVDB3aUFCUnp0VFd5VWtHWW9hTk1YYlc5?=
 =?utf-8?B?UERXaTRDU2R4aFc0aFFVT1ZaWUtmTUovcmh6bjZWVEMraWlINFJYMVdXK3J6?=
 =?utf-8?B?ZVFmeWtrWlgwSnZkTitSOUQ5cDJTdmdrTGhWY0NnWDFGTEh1RDY0MXVVYndJ?=
 =?utf-8?B?VG02UWo0TUhxRkN1RVhuYUpPTnF6L3REbGowK0xxUlpyOWtjSEwwU1FtTm1K?=
 =?utf-8?B?ZUZEeldwWTA2SUVtVm5WSXl6OHQ0bTBjcU1welY2Z3lPNThkd1BSUENKbHRC?=
 =?utf-8?B?ZU94RzhBcjBlc1RHUVhTZWtWMUNMZUxsaE11Z2dmbDNwaGVVQmswNEZ4cktB?=
 =?utf-8?B?a0ExNTFxRFlGWFpHem1sV2JVS2ExV0RWbGpQM0tTUTdHTm8rR3JyWWQ2UWlK?=
 =?utf-8?B?dkNrSUVYMVNpRFNmLy9NcFNBd3Q1eG52Z1NKZk10NU9ubURWRmJ4cmdNczBq?=
 =?utf-8?B?amg0dG1GUHVkZ0RuRzRMK3JrdVNybVBZakF3OUtXSGQrNlRSdktjYkpPZHhX?=
 =?utf-8?B?NEt3ejB6VzJvS1ZJZ2toYzE0SXQwSXNwN2RGOUdJUW1jUU5VSW4vdjYrUTUw?=
 =?utf-8?B?NEpOZzVVK0Q2dWdWQzJjOVQ4L2l4bXZ4SEN2L0treUhlYSsxeENSTVc3TVpt?=
 =?utf-8?B?TzBxUTIzNnk3NCtPYmZkR3cxNWVoaGhwMGdrOHdOUnNvVVVvMlhXYmFBTjAw?=
 =?utf-8?B?WjZLVXA0MnUvRXFYS1VGSExwOXhaeE5KYzJlSDlRVVZJb3VNL0NyUjFEYlNR?=
 =?utf-8?B?aC93RWxOb1RjbEVXaXk3U1plWVVPVWhVa1BhbFlLaFh5TmVJeEI2L2lOU21D?=
 =?utf-8?Q?SbQgd68ulD7SXj3YUdtOtG0A2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e59b2fe8-693e-4d96-9dde-08db0ef5c864
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 01:41:39.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htuFJW0UodOYFKIxHnSMmaNZb5TF51/9JpNJHE6RuZcUsmN3eu8WgjUrT1qdhJ2IAP0zM97ehcQHJ5p4I0aQ3w==
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
> cxl_cdat_get_length() only checks whether the DOE response size is
> sufficient for the Table Access response header (1 dword), but not the
> succeeding CDAT header (1 dword length plus other fields).
> 
> It thus returns whatever uninitialized memory happens to be on the stack
> if a truncated DOE response with only 1 dword was received.  Fix it.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Reported-by: Ming Li <ming4.li@intel.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Ming Li <ming4.li@intel.com>

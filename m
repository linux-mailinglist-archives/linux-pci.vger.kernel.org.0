Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE99777E48
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjHJQ37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHJQ34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 12:29:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942139C;
        Thu, 10 Aug 2023 09:29:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/qj6HMOaPc8Fc3DStcVWUzQFNgkXcD02M0V/vuVl/R3wjosRJDtzJhYex5tP3CvaVX63xwaQkH2RvZ0+rKMx/g/VCrFphmovfphDhtkfIVtt40V/bY4LzZollc/TFPB48bmjuNJCeXFqAwI+C6HuPwcGTsDCnRaneNpZcwYSS09nXi4XztX26GdKy9PiIaqw1Gus/cPqaeddN7j6t3FE+VVcI3KvSRoAhCgyrwC3vSL+zsG3RueT0s0w/C7cGp5d/y7IHak3GzSUWnkK3MtvJ+hSrzRLZ6L1l++7tDqv+unIRTktbVq8F2eoEYaw8uQ/B7IqrSxXTNXqrEf0UyIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMbgPGbXVEjk8z7mvKUejX6SoUMaE3e0QlUQkpVk4bQ=;
 b=j9gkdsyboWD/9wagmUrssxeVBY9PB3sXqG90rMIE6LY+GG6jmql9NdAxiFjfbaDLVexNItFkTXVVJD4/YiCePXEdi4IjB+hGstwdUbS5TdxjlKtZn/+TdgjkkLYjFiRLo+xOY8E2DUnyTlBlt/v3gUuCgoQv2xJrBvzAQRpclj07D5/gnhiImThQCei/usQS1F9GIB0vDyRMhjmhmdTkh9Lml8ghzrp/GReMOVC4osIkQ8Fdsl6bjK6bvB+Ec99Q9ApcEPB9JwmL7QtoV9XzMR+odZFGZ3FXcP3VTRO8IbOI240+pDnfLhakg0QPW7AcUzoJBnHNzokmsL4/N3hJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMbgPGbXVEjk8z7mvKUejX6SoUMaE3e0QlUQkpVk4bQ=;
 b=5VkKsNGsMyKWRkBXvFq4HQAoy/RXmb+/QTTd8dRjOFAVMPBVZQCP1YNxz75/B4iCl4uFa85SD+pTiIzxHKu1mQuCZuUPIdD0kgs6ubrD7FO6QbMxkgQlhPFcnqAV9T1f19zXY/UVduzGlLFcnLzH9SBisIe3mHl3LO9Z3bPnQb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 16:29:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 16:29:52 +0000
Message-ID: <c07aba63-6ca0-4889-aa98-30248f86c313@amd.com>
Date:   Thu, 10 Aug 2023 11:29:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] PCI: Split PME state selection into a local
 static function
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
 <20230809185453.40916-9-mario.limonciello@amd.com>
 <ZNUOo+OKEv6zfPSY@smile.fi.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZNUOo+OKEv6zfPSY@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0143.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: f07caaad-ee12-4a0a-c93e-08db99bf062e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OpadpaynxRl9Tf9MQ78kWalAt7lohz4cCAubbcWEv5pnge9rkQVr1xRWtoWgMElK3lIjCiaF/yUlsVM/SWPGBghsC8Wyzzpxezf/j0mftq7oEGxgU6jkZddAKhUlYHrno4oMp3wF627ys8+IaxbULbw+2sWMhtafAYpqTWqN0uEsvk/efH5wnnLc0kus+m/qeIarl63PV4poUp4g5v4xJA7K/YwBBCqPBeqzKwnN+r1FkhLh+oSUEG4t/3XPnOfTXi5L5SNfU4qhhS8BUGHI7+DY+LfTGxT4W9ek7ACbA3ddo3OJDkI8IDcLTWOqBTm/YPrW5FQxdz3uBsVqxBaSPTovv8f1i8XgRUuWOv0m4c9ljOxCPb0KeboPOXBEMdkMaziR+QrrpGST9/XIAGXpSQextjuaF1PU0JOeKh+d79KLdQg4e/DFn1tB1WBWNsnrTvGlh/0ZWETlY9OQtByLlrLakfipBx+k+2VKBic599gsugJ8Tip0EaLNoiriziIP/ePRI2r01JPbR9jgXb6Kif2dSaQ1YJAw85WEw8VgQHCT77QcMukWfVOpG3vAPjiheYGJmlWIj0aamCzBxZUIcSz24dW4PF/2QNTftutZBdjSWERPnKqJzWSb7r9KugyZjgoCnhKnt/8+UZhtM5tbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(136003)(39860400002)(1800799006)(186006)(451199021)(6512007)(54906003)(66556008)(66946007)(66476007)(4326008)(478600001)(6916009)(31686004)(5660300002)(6486002)(316002)(6666004)(41300700001)(8676002)(8936002)(6506007)(26005)(53546011)(86362001)(31696002)(36756003)(38100700002)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtQS2loQ1pVWlprYUQrR1puYkRjcHZWOXNWQ0JmRkxvV3ZwVTgwZHFKS1k5?=
 =?utf-8?B?d2FRVjg2ZU5iRk1YMkFJb3BwdGk1eXd3M1lScnFGSnlTNVl4MDFoU0hIZ0My?=
 =?utf-8?B?K01STzF5eUVyTnBVWmRqYlJ2b1I1Vm1kVUxHd04yL2xpc1c0Wk95MVBwbU14?=
 =?utf-8?B?b2JvbnFVTGpSYjY5YXpDSXA4aUtwWDgrS05xSGFGSU5BYUNOQXZTZlE3WEVX?=
 =?utf-8?B?czZRUWZUYzRienJnYW1XNVh6ckUrcXJMTVQxYlpPRzcyNmtaSlhKeFFCMkd6?=
 =?utf-8?B?Mmg3NG4wekRQUWh0MzNJNStlZlRvYkd1RGlqdm5YRDByRGdaWGdDN092aVBu?=
 =?utf-8?B?a0w3MXUzbmF1bnV2RGVDanpLMlpGZ0dvcnQwcFdOeitCaEs5bDF3Slc2TnJl?=
 =?utf-8?B?OE5XVE1Wa1ZJcy9hcS9uT3YwRkN2b0JYMllOQXNKMVMvdDhiZktNaXU2eUl6?=
 =?utf-8?B?Q213MGJXZ25GbFhtSHNvaXp1UTZOc09PRW0wOU02QUJJWWkxeWVnQmJEYUw5?=
 =?utf-8?B?ZmF2MVJiMmUzNGh0M0pMZzBUdVgrY3h1NE8yV21tK3VpdXd1RThSRjZSZEVa?=
 =?utf-8?B?WW8rL21IQlJRUkI3MVcvUzJBSjdyNVhWRWo3QlBwZDlROXFXOTROdUQvM1Bq?=
 =?utf-8?B?UlFCVXRVUjBpdUlsOEZNa0ZPL2pVUlV1VzVBZ2RsUW15V1Y2ZzRrTE1pYUUv?=
 =?utf-8?B?SWJnSmNvTHBPTlRRTjgvYkt1dW1oKzBkV2hlLzh2S2hnQ1JISEl2MkMwdXFW?=
 =?utf-8?B?UlZaS3lIWHBjenlBNVp5c1AyMHRML0d0K29CYjJyQUxDZ0tlRjlNbjlEc2dS?=
 =?utf-8?B?Y1YwbEx4NE45YmFMWHpaSDZpQUlVSTFuYW9YVU4reURHVnpETDZoVy82cElv?=
 =?utf-8?B?VWZBSzZGSUFMZ2VaYnFJanMvNGphZzRmUVE4UU9Zbm1qVUJmUW9GSXJicndI?=
 =?utf-8?B?UEpmQ0FKeTY0RGJGOVhPUXAvT2JPYU1DMm5LaXBmT1YwSHh6WlBWY2dRazNU?=
 =?utf-8?B?elUvbS9TQ1BURWYxOWlpd1JvMXRsaU9sSS9kYjVmZVg4R2JiQXc4RnpiNFpJ?=
 =?utf-8?B?V2hoYmxzcGczVGJJVFV1UWdsRXZ2NkxkSUVCNTFsdjRrVHR0WWd4cHJJNVNF?=
 =?utf-8?B?YUxHNjJHOS9oYU9hay84eTQwWER2QlpXVFo3ZWxESjkxMERES0NMZ2NwZVdS?=
 =?utf-8?B?TFFROFAyZnVVNFlFU3BHQThZZFBzSUFUVkRUTlM1Qjl4TDdhRGhxTyt0SUVT?=
 =?utf-8?B?Rmo4Rk50UXJ1aU5TRHlsbElZRmhQQ0ZTaGhiV0lhdWt1b3FhSDdNNktrM2sy?=
 =?utf-8?B?TEF4elYzRlhzeVBMbFB3T3JRU3owV2kyZWxnT1JRTmFvcEViY2JmNHVQQ09o?=
 =?utf-8?B?dVpDbVI2TkN6SGpQOTlTNG5Jb1RSdzFDcmpFcVc5dFdrZ2l3dlFpa0Jsditt?=
 =?utf-8?B?ZWVKWUE3TWxnbXYvcG56UmdHWlhjdWw2ZWZPaU92bUE2S0tlc2FxTXdjejFF?=
 =?utf-8?B?S2xvTVZLTlB0OWI2bEoycEgwTVR4c28vNWFCUXdjL3FmTnd1dWsrODBNSDNW?=
 =?utf-8?B?UUNzeTFxckExTmlVN2tJZnJrRks5NXpPRzhydmZMT3RkbkR0UUNsWFVvNDJH?=
 =?utf-8?B?c09CQXluOXUrMG1IZFpCekVPL1hKQlIyeGFiT2V4a3ZWR0FKbWphTEM0Y0dD?=
 =?utf-8?B?ZkFpNyt3N1IzMHZaQmhPOE9QRFZya3RJSFpOcm84Q3Y1SUw0Zk5uRHRZbjZJ?=
 =?utf-8?B?MC9heU5Vb0l1dTFYbzUrbHJhQkx5ZnBhRHVzRjNRTmpYR3E5RzZLK0NWMXpM?=
 =?utf-8?B?UFplb1paWEFYYUpldU9Wa2VKVVdrdkRYd0VjRWhjN29hMHo2VExydExoODQ4?=
 =?utf-8?B?V1Z1RUk0RkM4b3IvcmN0RFdjVjJaaW9YM09vd1o1MjFNZ3c5djFnZTJiM2x1?=
 =?utf-8?B?dXUxTDEyLzFBYnBadXAyN0V6T3llVitINnVsWUhRS0lFQkxMeTdFYUVuMnZj?=
 =?utf-8?B?V0w0SFpRRE81OSsydmQ0YjFwV3lBMWJWTVpIeVR4WGVrVFlIdGZFRGZXN3pu?=
 =?utf-8?B?ZkhNU1p3UGIyWSswVC9BSnlQRkVUYjExYlZCOHFDK1pCUzI4V3ZOWk5VaW53?=
 =?utf-8?Q?mygiYh6xf6rmbDQ8rkIHFJY8k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07caaad-ee12-4a0a-c93e-08db99bf062e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 16:29:52.6647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCw5oIEan5L0VoKMjSlkdhGouQ4EssX1YHWgFfS9C+4vAEb0c7w2Der6lfLOcyy857VzdTSR4dpX+HaeLMeCQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/10/2023 11:21 AM, Andy Shevchenko wrote:
> On Wed, Aug 09, 2023 at 01:54:52PM -0500, Mario Limonciello wrote:
>> When a device is not power manageable by the platform, and not already
>> in a low power state pci_target_state() will find the deepest state
>> that PME is supported and use this to select the wakeup state.
>>
>> Simplify this logic and split it out to a local function. No intended
>> functional changes.
> 
> ...
> 
>> +static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
>> +{
>> +	pci_power_t state = PCI_D3hot;
>> +
>> +	while (state && !(dev->pme_support & (1 << state)))
>> +		state--;
>> +
>> +	return state;
> 
> Sparse won't be happy about this code (with CF=-D__CHECK_ENDIAN__).
> 
> Basically it's something like
> 
> 	return (__force pci_power_t)fls(dev->pme_support & GENMASK(PCI_D3hot, 0));
> 
> (but double check and test the logic).
> 
>> +}
> 
> ...
> 
> Yeah, I see that is the existing code, perhaps amend it first?
> 

Are you sure?  I actually double checked the sparse output using this 
command before I sent it.

make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' drivers/pci/pci.o

I didn't see anything related to the line numbers for this function.

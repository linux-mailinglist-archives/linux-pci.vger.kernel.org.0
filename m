Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634683DEDD9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhHCM3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 08:29:33 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:57454
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235309AbhHCM3b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 08:29:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtPJ3jK76Bq8fZnyz1C/+ntxPmV/iPPwP/A4MtkvkeLWuHNS/TFtxVTleF1/1CruV+3LNpfzVv9kzbrHCDv+cpGJDqKYb7Iowi+zNiKYCTs+KIBOmB1uJHLo+ROtY4Oh7RjvO/Edwv6jFPrwXahb29prIiucI5cSD7djrYmvAaLsjzZZfontCc1RHT48tsPMOSYEdtwAfdYtpmqrtizjtqgsBd9F6P5FBENCLeN1cWGwV5BXKtI4KAbPAYMA7ixynkcjV+bD1v1lK9ru1XvkvhQEcDfa9LadhufqcHmLJ7a9i6QLoUYoX8bzz6Zo/VXKZ25MjF7PlYGmYNzPa5JxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOopGFOu1g6oI1jK39YohAMMyTh1sn/tuTKVUhI+O+w=;
 b=YyF+tSYYrpxT9E6Maq1d8rVQ9hdi7SnqMKHl1RH5QW9l/bDE6xoRt6mUjBGnYiCPktu9TN1dJwnffjHFAVA5CF+cTNpYX1qGTDYzyOiRmXPPyBacGfwvnRo24d3PdsuWo4R8NEPJ8oYZhK8bg8YL5Afnb+pI1ED8NZ8HM4M43i/aVsNzOrWIkK/+GzMd6Arc2wTK7xXKspjKnounbv40TzMkehX8pC/tVyoxiAX9+s5BdYhXfWZBWqppMGO/EEyOaK7bYWur0zJW52X2/TlpgJH4pXMiNs8i8zYvTID05N1W7nEOk1/4F3uXG6Ls8vMizURjleVUl6ejhi0vA5KuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOopGFOu1g6oI1jK39YohAMMyTh1sn/tuTKVUhI+O+w=;
 b=1FnzkwEFfrBLN3HN11riApF5yaI6NYWS9JjwpLk6qYXsS8uPOk4Zbj3trx4MpkN/Styof1O6rVvrVfYQmgp4catDuOuvdA8wQ5TII5tO/LqRz00Q3XKWn387/tPySFY9uqwTu73i6/rLlRk5YdRI/PpitiI7WtZgSCvGMeOPxJE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 12:29:18 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 12:29:18 +0000
Subject: Re: [PATCH 3/4] thunderbolt: Fix adapter init handling during switch
 add
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, bhelgaas@google.com,
        YehezkelShB@gmail.com, Basavaraj.Natikar@amd.com,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-4-git-send-email-Sanju.Mehta@amd.com>
 <YQgOj7elfCp7l4OO@lahna> <6da505a4-abad-ab8b-7706-17f83a35ff41@amd.com>
 <YQkG2oeZ4nRpzx4R@lahna>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <7f7c90cc-86db-3aec-a3ee-50af48732452@amd.com>
Date:   Tue, 3 Aug 2021 17:59:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQkG2oeZ4nRpzx4R@lahna>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::21) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.136.44.125] (165.204.157.251) by MAXPR0101CA0059.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 12:29:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdb0edc3-c222-411b-5881-08d9567a501f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5088A182301C9246A536A1E0E5F09@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsHriFna7c24kBzflvfbwZFEaJyh0N2Qlq3GVMMjQ2USfJq28iqiixyzE/PruM6jXUEPs1fLR0u37rqtwHx2rpjFKA6T7XRQTW3PP66F3imDXBpUJ7oUk3XqHjY6Hn+LMPRJCyY1tM2fTHFIX/KUYPR0u/EecZxwZzGV+XicMigd6yvrOByFOTkgoablPPxBSAqTFH0VbMg3aDjBfBqTwyiulCj+1MOmiqYXn0jNoYajgLrhNb0O0MOt49fmpZlDsNn8grZ20Z9exKz1r30m0leatk2nZTw79oq533QkRAXBDyBaq8r+pCYRvqC90WYfpp/A5VsUrwyfgQC2OT7p5EUQRqHdW5lmMq/hp+6CJo22NU7lwu2eHYB5qBZW4qClj5XT0tAKp29zHSdcQQfclACcWzJGUT6T2BBMxJ0a+gjQle30Zcd3/pao3YTaUIuaubyNXPgpLZNWvqPjwMEjsrzHOgmqtTQ36az9ROUV4xB2ght6OSmLC7XwB/+E05/g20ma6LbLvU2lm3bVLYyw81SlNFyNrDArD5IjiExVIXm7ujD882IedBDy3LqadTX8Y6WnGGTcQZwZG021oNAEojz4xLZbfi3zY7IywnJ8RUFBsM52QoVMp7BnLE6DoIrW1VfisdkGgZZvOXVEYxHAJGixxIHEh9vDOPR5zigFxUpJEc2hBXRWmz9cnxwm2J04EZahokldzG6LERixxp5UOKRHqf2/7G4rEPS/ak4QuPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(16576012)(2906002)(316002)(38100700002)(66556008)(66476007)(66946007)(6916009)(53546011)(186003)(26005)(31696002)(31686004)(36756003)(8936002)(66574015)(6486002)(8676002)(6666004)(4326008)(2616005)(83380400001)(478600001)(956004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpmN1pQQVJNMlZLUkpUZ2RTeUQ4ZEJkNFJ1UWM0S0F6dTdjSmw5SGl5eUcz?=
 =?utf-8?B?NzFJOHNwZXErcFZtMjMvWXNiOFhDWVJSMUxpVWdKQ3B6ZmZURHdYaWFyYkdT?=
 =?utf-8?B?VmNpVWlrRmdFaTJRVldvemRnZDFaZ3JRcUxYQXVzVWlmeGwvTmIvVHB3NmVY?=
 =?utf-8?B?WXdyZjlQTkM4Z0ltVCs4d2Z6ZGxSMTg0TS9JNWVWYWFYYXl3N201KytrWXRW?=
 =?utf-8?B?alBKUUN6SHVyeWVpSGdoWGV0dE9IZS9Wa3dKSG9YRnM5djIwM0pld3VhUHVV?=
 =?utf-8?B?dEdBWm43QlN5RXJPVVBDaTVBaUwzK0toQjJjOVRiU1M5eDNsbXN2WVNzSDFS?=
 =?utf-8?B?azBVbyt3ZkZGMUtsSjNDaW9oL2NMOFgzSEtHV0Noay8rNUZla0VQeEpsRXJO?=
 =?utf-8?B?KzlsTGZERFBBaC81Y0QvMzgwdnFvQzlnZ2Q4am51ejAyV25Kd0FLWkQ5dmQ1?=
 =?utf-8?B?Z00xV0JSU1MxYnRFcEtIMVZYbG1NT3ErVVhXWGl3d2pvZGR5ZlBnbytOM2tR?=
 =?utf-8?B?OFNTcDNxcVBSQTZsMXA2aDZzaTdRb2tCZWZhWWFjb1JNRkxkWm1ya2tVYkZu?=
 =?utf-8?B?QzRQMXdML25HUkJ6MXpsQU1CVUdTMUxVSFlLazM2MDQ2V0pxWGh0ZFRhV0M3?=
 =?utf-8?B?VnZ1aHpybkJ5NERONis5NkxuaEV5TDQrb1k3aUh5b28zamJrTE4zd25tWmc4?=
 =?utf-8?B?U2RZcUsxUXZLM2VvTVVQM295ZVpqb0tmbXRFSWMxSS80YzducUhSdll3SGNO?=
 =?utf-8?B?N25ISS95T0pHa1lxaWlxbFBsRDdGbzRMRDBReWxhNVJmRUFHbDZEdlBZYlRj?=
 =?utf-8?B?M1VaMFc5WFFNdGIzNk4zMVlodFZJWVBwdjJ0OWNFZ2J3TnlNQzF4ZmRhZzFW?=
 =?utf-8?B?SE9ISWpnZ1phNUFmTFM0YmU1eldiaVRxTjNYWDRoSU81UUFhWk1HN2ZxOHpn?=
 =?utf-8?B?eGVwOEFRTUIvdzdaMnlhT3NtaFdSaFNKWHNKTVJHVTMvNDVmWERFMnhqY1Uy?=
 =?utf-8?B?R0p5OHp5UTVSNk5jMUN5ZEp1VXJnQzA3UVVuNjhtTmg3NG9VV2VqRHpiWlVW?=
 =?utf-8?B?WXNRdGNJUzNDOFROVUtnbWtWMVFJRWlERFdVZExDbndUcmJyTGxONnd6NkFJ?=
 =?utf-8?B?Z2Z2TWhMbmhsVWZiTjE3WXNGU21uSFpYSVlVR1VaSS9PRkpGdVlsUWMydzNQ?=
 =?utf-8?B?SUp0anU1eFp1WCtyL05mVjdZeHppb1VBekdzck1PZEtwWFNUTFVzdVVLS09i?=
 =?utf-8?B?akhwVC9wMWFMeHpsYlVHRjd0Y3U4ZUpZVCtjVzIrMEZOWmc0SUZxVzlGZzhu?=
 =?utf-8?B?L3hIU0NBMlJNQ09WdlBvUXRCVzV5UHZubjdDd0VCOUdkRU5PSHhNMmNkMHdw?=
 =?utf-8?B?a3UvTkxSeFU1VkVVajBSeThxaGt1TUJKeWtvN1ZFTExaTGRpWmhyaUJleWNj?=
 =?utf-8?B?bDJORTJoWit3eDljT1l5alVJWThGLzI5WTlMRGFTM0RnZmhKYmI3T29ROGF4?=
 =?utf-8?B?UXpuUW5lNnIyZmtFZ3JCRmR2WUJoMlFCajRhRkw0ZmRmb2hxVmplU1htM3JX?=
 =?utf-8?B?dkM5MW9saHl6ZzhLb0JnVWkyM0Rmd1pYUjhWTVhsNlZ3aGFGY1VUQVJsZjlU?=
 =?utf-8?B?Sm9FdVUwTUVWUkhjZnhvVTRDcTh6Z3dER2FMazlIdHl3UCtWa2x3anVIMzlK?=
 =?utf-8?B?cFlxUGV2dUUvL3liSWF0YUNISkJHWXBhR1N5a0JwVTBFQTg2dStkSTdsRzg0?=
 =?utf-8?Q?/Hs5MbpVjBavcAFcv1lqjdhhUwjIfR1KfvQEV7l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb0edc3-c222-411b-5881-08d9567a501f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 12:29:18.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjovVagi3dA7FHCAX9acgXN0HlfA7EEWs7X73s1sTO7esJLOejRBWNaQbfqp5Grbox1UnFcrOdM3oaR/ska+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/3/2021 2:35 PM, Mika Westerberg wrote:
> [CAUTION: External Email]
> 
> Hi,
> 
> On Tue, Aug 03, 2021 at 12:23:44AM +0530, Sanjay R Mehta wrote:
>>
>>
>> On 8/2/2021 8:56 PM, Mika Westerberg wrote:
>>> [CAUTION: External Email]
>>>
>>> On Mon, Aug 02, 2021 at 07:58:19AM -0500, Sanjay R Mehta wrote:
>>>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>>>
>>>> Adapter0 (Port0) is the control adapter on the AMD USB4 host router.
>>>> As per USB4 spec in "Section 1.8", Control Adapters do not
>>>> have an Adapter Configuration Space".
>>>>
>>>> The read requests on Adapter0 time's out and driver initialization fails.
>>>>
>>>> Hence Disabling the Adapter in case of read-request timeout and continuing
>>>> the driver init.
>>>>
>>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>>>> ---
>>>>  drivers/thunderbolt/switch.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
>>>> index 83b1ef3..effbfe4 100644
>>>> --- a/drivers/thunderbolt/switch.c
>>>> +++ b/drivers/thunderbolt/switch.c
>>>> @@ -2747,8 +2747,9 @@ int tb_switch_add(struct tb_switch *sw)
>>>>                       }
>>>>                       ret = tb_init_port(&sw->ports[i]);
>>>>                       if (ret) {
>>>> +                             sw->ports[i].disabled = true;
>>>>                               dev_err(&sw->dev, "failed to initialize port %d\n", i);
>>>> -                             return ret;
>>>> +                             continue;
>>>
>>> Instead of this, would it work if we start the loop at 1? In case of the
>>> control adapter (0) tb_port_init() does not do anything useful anyway
>>> and it actually would simplify that function too if we get rid of the
>>> special casing.
>>>
>> Hi Mika,
>>
>> If we start loop from 1, it will work for host router
>> but this will skip port (0) on device router which may be valid port.
> 
> For device router adapter 0 is also contror adapter so I think we can
> just skip it here unconditionally.

Sure Mika. Will send the updated changes.

Thanks,
Sanjay

> 

Return-Path: <linux-pci+bounces-813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE3680F708
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 20:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39E6281F96
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B06356D;
	Tue, 12 Dec 2023 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jeK1c7WG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB236A7;
	Tue, 12 Dec 2023 11:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwsNenw6zbwZwDn5nMymVMHmFHaGcO2bmG4DbDA01K5gApaLsc9WP4b8raHIhgq8x5IZ0pTMqVmrnXOijEpQ+Ix5TH+4tuMZWFdvQXFZZWThxnJ6Tg7KHerdobAoZeO9vjo7TD4csli6A3LhqLN9KEkBXVywAB3N39KTWCbnHeCq/9oTVdBy9xVuBQlXiKJCv595kK7/pn8G6+k708ZlCGUZkYbhQKrhPyWstnG/J30sGlLtmfSo0D174W8++sYxFnFjrgB3u0aRrg2Sc+QSwRiLSTeuRe4+l+5Ly9LWbLAIJJHBUj7Ro1KumY4BUn7h9BfHOtZ6ghQrO1gKZeifRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOqK51FT2UDKBXDZF4I6Opc+9SX/j2M0QsCxnK/q+lE=;
 b=i5f5333escOa26Np/qsONhnLEOjooalM5i2XwckSLAMwXJsVuiZ2XFEP9s8BsTyta9xExADwqddg0QY6cGbehoB9u/i9+GIbFX5GRs1JmLVI0MH8LVPodKwQe1YRdH1+52YSfuWEwThwOqDxt2B+JD+NjWXxHCZYZYJvlTMr5Gq7Stg32qXTi+aA34mXrgVyyJUF1+Sz4hEZDwrZqY8rvZpc1QZ9G/a+64pFXKkyGwNM7vuCwN6a/anOx+pn/gr2hrjoxDUKIMPss3E0mybDfsIwea7A9suJJB9bBzvAeORr5KHnXmqq+uHd5bNv4AaB4tZAfmfxdo4C0Yxf8g9WJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOqK51FT2UDKBXDZF4I6Opc+9SX/j2M0QsCxnK/q+lE=;
 b=jeK1c7WGlvV0x4DC4IrKJyok/9TLcuJ1n7O9bnqIUzBaJGAKcimfmysvWdMeJ2hBT/7aQiyS/9/zFhCfhGSt97gjVkZY3ZSiw5AzYppKudc1yGF8wLz6j6IiSEE1gfvh4qck9rwpMGWyae8GAm7OhBmMfmItkiQDNR0QRHv4Ys4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 19:41:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 19:41:37 +0000
Message-ID: <d61a0a3d-2adc-402f-be4c-2f99a65f5b04@amd.com>
Date: Tue, 12 Dec 2023 13:41:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PCI: Refresh root ports in pci_bridge_d3_update()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Hans de Goede
 <hdegoede@redhat.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
References: <20231203041046.38655-1-mario.limonciello@amd.com>
 <20231203041046.38655-3-mario.limonciello@amd.com>
 <CAJZ5v0g_HWFnt0a5fDnb73Q14C84O+RPYVF104TDK7T_Ox3_EA@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0g_HWFnt0a5fDnb73Q14C84O+RPYVF104TDK7T_Ox3_EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:806:121::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: eea9c356-3eaf-45db-5e25-08dbfb4a5b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YpfrwXgaBsyg2CA57xmFhYWLv06HvQ61OEgxonATSr+ubnmcjCPprpJ5gc9sBhPqB0UVca/8g4woiuc1RcEenp2PnXuohPeVG/yAAck2t1TP4YO+kof0dPS3SFwWyOhdXG5XIP6okyx2jwO1BpNn4FyEzad6cg/i28yE8P+DogqOoxZJy/tkBBFfPLDWYfq56wvzSQ+1HARlYdN9l10Q9z/bOPISEPez4mPinPC+YKQH8nAhXncnoqtowDBbimQ7Cg3KS23tHNRaqdSnZX/dcdypKyOduK2UBZY7NRTX+I8tViQgFiJF0cdcwJFge6Fi+D2Pz0/bgWmeM8uWyAc7AvL0bqzNxDd0QSLjPbkJL/CGv0tSvvW3UaGMe7Su8SZmihpISdSuFPxZOX17V63gcbbUmTZejYUPu/34sSGWAdJnhQnzpRLnfV4EppfBM7QtsFL5mpA4tWL1NYSMod8T2fpFxEwm7BApRbSeD0KhS52CHYzvwJQQHm8q7rdYWEfFjwtqorzHK2j34Zuq3U+DgKJ8TAUKYti4NTxBTQHO4nizvfSTG6bAfA4qb8Xvw7HN5VYPWSTx2EfyDGc2SjYWiWiY/vj8N7UbNLwImUGul300qGCSdljaebrwd7AOq82PO/YM6XHhgrsiG1NcjlCxjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(53546011)(6512007)(2616005)(6506007)(66946007)(5660300002)(4326008)(41300700001)(8936002)(44832011)(7416002)(2906002)(6486002)(8676002)(478600001)(26005)(316002)(6666004)(66476007)(6916009)(54906003)(38100700002)(86362001)(31696002)(36756003)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHNrYkc5UkIzZStZQlRKOWdJdnFvdklYVlVtWTB2aGpma0l4dkQ5NGxvZTlp?=
 =?utf-8?B?OUp4MW5TeG5SNy9mL1RRS1M1S1ZRM0ZqVHdqZUl6WnVBOGRCTkxrV0dYUnBQ?=
 =?utf-8?B?WHBISTRnR3JPMHBTdDJBdFM3RlhBdDhBM1Uwd2xSVlB4Qmc2K3NralNudzJm?=
 =?utf-8?B?K1VLYjRvWW8xRkpkNWg4TVFhZVhHakFpRFVYbVc5MGdhcis5WDllVkRtUDI1?=
 =?utf-8?B?OWtMZG92YUxMTjlRM21WaHY2emdKS0ZPSTR2QlpiNk84aFlITU53KzZYSDBL?=
 =?utf-8?B?UTFpbk5zUllsMUREdGdXM1dLOFJRR0xYUXhrUzRQU1BTT1I5Z3NldGRRc0px?=
 =?utf-8?B?VVdIN3Vjdks5dVZuRkJ2VXVEV0dwZ0RCOTNUVkhNd1FGbjdFQ0l3QU9wVTJN?=
 =?utf-8?B?TG5DZkdqNGF6NmlIMDZldEx5VVdLNVh2U3U0b052Nks4TTFuMjhVdG9SYUZi?=
 =?utf-8?B?ejZjek5weCtvRGJ2TUR5UlljMlpVSmNWbGM3TmwxWUFJWHlwcUM5Wjg2SXlQ?=
 =?utf-8?B?MURXQXR5SkFZVnZJM3l1eTlpWkV4L3EvS3VobDBjTXZhaHJTNEZsVTB1NHRO?=
 =?utf-8?B?OCtVb3dsaEdpM0NtS1psSWpWWGhUNE9ybFJiY2JXeDlIc0V2Wjh0T3VCWjhY?=
 =?utf-8?B?dEpiK1hMVzdhM1duUGd0Rm9paWc5MENnd1VKOVcwdlJkZFlVUXdOdm0xY05Z?=
 =?utf-8?B?dTdsMnFpbitYOCs2ZENDQjhsYW1pc1hvVTB0S2R1b2hGRmZaQ3VES25Obmk1?=
 =?utf-8?B?bG1BN21sNm9QQ0dXZTZsTS9ZbCtYT2JTUHBHQWcyRnVVcFUvVkRHSjhsdy9F?=
 =?utf-8?B?WUhWd09OTDVmRzJBYngwVTRUVjltcVhaWVZBcjgrZlRoU2l5Y3c2M0d4NDYr?=
 =?utf-8?B?ODMyVzcvNmoyeWlFM0tQdjlSaWorRDJzWmFBTGpoQ1FzZ2xOK0k4eStFa25j?=
 =?utf-8?B?cHI4THFBbWtMeWlGdkxVeWhLejRQMi9TODk3elpBNllKNjVHSzdBcFlaSEdZ?=
 =?utf-8?B?N3JjNXV2aGNwVUpnK0llOUpnSjAySnVQUmxPR2NFRzUvdTk5YkpsZlhNajlw?=
 =?utf-8?B?QmU0OEVsZEJXdGJCbDlIaFJNUWhkUmREamlrVEpYWGVoV204T3kweGZtZmtp?=
 =?utf-8?B?WkFXQ0UvNWFTVmR5M29md1g1T2p5MHFiSW1idDhueVNlbG00Tlp2a1FkdVBT?=
 =?utf-8?B?OTlEaTZTWEZQdi9KYmd0SXI5SUFUb2FoRExPS0FkNXdZd1FWWi9VcUhBZ2JL?=
 =?utf-8?B?NVA4OU84WG15N2lQdkd6Q3R1b1JMTWRXSnVQYzBwZkk5Q3BpRU52M2MxMkk1?=
 =?utf-8?B?MmFiOUNidDJDOHVhd2lvdExhazBwMGRFcjU1UHBSODJUakkwVmtCSW0zTWZj?=
 =?utf-8?B?VFFpOWJ2QXhuR2p5UHFmSzBZVUFDWGdPOFlKelN3Znl1akhaZzVUQzk3Tzlm?=
 =?utf-8?B?akVKVTJZcnltU0YxSVFneWlWMFgwbW95alVoWTlYSWFHUzhCVnNqL1ZYcVEz?=
 =?utf-8?B?T0ZCcm9nTysvNS9zUDJBT2lKQXhrNmhLbkpsbytxTTZicXRmcE9GUXNqZWEr?=
 =?utf-8?B?UUovZmg5UVdtZk9FNXRHSE5tRThaL3ZuUzg4ekVUMVNqWWJRczlKYkhyRVh3?=
 =?utf-8?B?Tm5YN29uYTN5L293SDBrOFQ2OE5PNVVyRWgzZU9rb0N1RzVFbk9GbWpQRXBp?=
 =?utf-8?B?b0NCaEdFMnN5ZDdlNWU1WHJyN0o1TjE5Yy9BQWY4MklsTXlSUGRTL2Vmc3hu?=
 =?utf-8?B?MG9GeWpDMlVEWE12eHpKVXp1OHdGUjlDL0NLVm8vUjB0R0NrWFgvWW5oRFd4?=
 =?utf-8?B?UWhmM3FWOGhid2pYTis2clJFRU1vUUl4bTNpODN5ZVJsQ3dHRVFMU2g5RGRr?=
 =?utf-8?B?a0hTOHFVdFNiYTVUL3lUVmRWYlAvNVdYaGREU3AvSmdVNm9USFgvUjJzSU02?=
 =?utf-8?B?UkxwbHBHbFZLdnh5UklzWWNHVWhTNjhiOU44dy83Q0ZSSEpMLy93VkYyQzIz?=
 =?utf-8?B?YTRvT3JOL0U0RjJGdlRSTHVmTzBCdXErVElOVFM2ODRKZUdwUWxQRTdDcmpq?=
 =?utf-8?B?ZXJNT21taVNxU2dzSnFoWFlkRWhQMTliZXJESFlPcE82QlZ3RjRhU0N5clJO?=
 =?utf-8?Q?Jm3z8RziygS0QRT8RY2KiAUdf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea9c356-3eaf-45db-5e25-08dbfb4a5b00
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:41:37.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3JgOAZNLshx4ARa3gCm5DEz/l+X6GtFj1HZGZabyvxPgTa1G+jWkYAP/ONgSaY30KVGTaznj0ZMmyC0xrT+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828

On 12/12/2023 13:25, Rafael J. Wysocki wrote:
> On Mon, Dec 4, 2023 at 7:07 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> If pci_d3cold_enable() or pci_d3cold_disable() is called on a root
>> port it is ignored because there is no upstream bridge.
> 
> The kerneldoc comment of pci_bridge_d3_update() explains what that
> function is for which also covers why it does not take effect when
> called on root ports.

I'm sorry but can you clarify the intent of your comment?

Are you suggesting we should introduce a different function/logic for 
root ports, kernel doc should be updated, or root ports should be 
special cased in that function?

> 
>> If called on a root port, use `no_d3cold` variable to decide policy
> 
> It is unclear that this is about pci_bridge_d3_possible() which
> applies to both D3hot and D3cold, not just D3cold AFAICS.  I don't
> think that no_d3cold should affect the D3hot behavior.

IMO the semantics are confusing depending upon what device you called 
pci_d3cold_disable()/pci_d3cold_enable() with as an argument.

Both devices and root ports are used by existing driver in the kernel.

If you called pci_d3cold_disable() with a device, that actually prevents 
the /bridge above it/ from going to D3hot as well (bridge_d3 is set to 
the result)

> 
>> and also immediately refresh whether D3 is possible.
> 
> Which isn't correct AFAICS.

Why?

> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 72505794cc72..3d4aaecda457 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3023,6 +3023,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>                  if (pci_bridge_d3_disable)
>>                          return false;
>>
>> +               if (bridge->no_d3cold)
>> +                       return false;
>> +
>>                  /*
>>                   * Hotplug ports handled by firmware in System Management Mode
>>                   * may not be put into D3 by the OS (Thunderbolt on non-Macs).
>> @@ -3098,7 +3101,11 @@ void pci_bridge_d3_update(struct pci_dev *dev)
>>          bool d3cold_ok = true;
>>
>>          bridge = pci_upstream_bridge(dev);
>> -       if (!bridge || !pci_bridge_d3_possible(bridge))
>> +       if (!bridge) {
>> +               dev->bridge_d3 = pci_bridge_d3_possible(dev);
>> +               return;
>> +       }
>> +       if (!pci_bridge_d3_possible(bridge))
>>                  return;
>>
>>          /*
>> --
>> 2.34.1
>>
>>



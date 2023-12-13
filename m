Return-Path: <linux-pci+bounces-898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1855811D0C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EEAB20CCB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D75FEE9;
	Wed, 13 Dec 2023 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1+mCqGDh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269CF2;
	Wed, 13 Dec 2023 10:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYETg7bLv52vXgrnKplIA+sfOVIvTaftxPnIeFeHQZd3IeA8tBqNDyD9GWLl3yvkpnUqYrTjCnPzf/6arkZ2TIOKnTsx2KaCbGR9lqUXo+KUSs7o90KOdKKkMQkClH7oVgdaxTUGlRt7RPrP5Umx4dB3pBCivq3WQCzLoMdOdXi2ryxNie/Lr1A3nfDqxye+pFPg+WHbM6d8FbMeUWMG6ytud4ZOSBWEueupqnFG8IkWZTBlJpWR4qsdIAThciVggaHLDN4BTpLlScVmL7YvtMg2nXyhF09D3Og3wvDGAKmGqOxXmbBzSpeL0aaghq8q6UIKLvz15CyDI8DJGbwRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx/I4wmAi4vJ5v5A4KEBe1Vzciyz8/9yofOItOck1n4=;
 b=EtBzO1vIGi7q1rZ7zMbFi7/f0XpWC3HkvLsixct7lNrCeq9Su5GOEiZ1D+uJ9RqMy9ygW7lRXjFbSNQvyZGY/3wazP/RET/t32eds8QQKZ+Oa1KZ6kooocpYrLshpXLRnWYN3lYQxnU/TK/kyPVfE+q03X2uG3cLELeLVCuo3PQCBd5225QWxmDB18wYzA982k4azULZ+bW6KO68yseHpUjvDKNi8yjzUEBAj2shFqB5x/JL7KlIyROWm/zLn/WyuW6IhlRxRixErwPfFRWm0C92YjBBpZd8O4IHjnHz5sJ2rdDMevYG+o6KOLLu//FwhPesNUmmnXWK3a1wX8iSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx/I4wmAi4vJ5v5A4KEBe1Vzciyz8/9yofOItOck1n4=;
 b=1+mCqGDhFB5TaqfbB9HNBqTpm5qhe5tActcIVIk/R8r5j9XmEuF7Rvi7bCGfGpWkmAC6En12l1Zhoxguau0ITNPkoWoIZ1wzjcWCaV0pk75s6feBYT+//ErCoTiMHwxanRwQid/My+MoaiTzTtwfFiFrK4XI36RG930fMJKa7wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 18:42:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 18:42:07 +0000
Message-ID: <766d621c-695d-4ae7-87cf-690cb8d066df@amd.com>
Date: Wed, 13 Dec 2023 12:42:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at
 shutdown
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca
References: <20231213182656.6165-1-mario.limonciello@amd.com>
 <20231213182656.6165-3-mario.limonciello@amd.com>
 <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0025.prod.exchangelabs.com (2603:10b6:805:b6::38)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbf6834-e579-40c1-efb9-08dbfc0b3530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U5VyL/Giji9zoPQgIUbdlOzsjo0VVFRpfPv/uLJ7862afu/Gh1uYy+iNwy4hGwOG412hI2bZnrCCR808WgCDJtfwKuYpA1G5SoSYDCEhzOtC/6eHjI7mGDsAv5ILS1RgyuLF95j9oZCpWnP07r2EsHnlQ+1f1zEyJmoAtVKfv/9KKQdXCTnqt96lWxNSLwJRytG1Y2x0OwBfMj6YBGVgNR792JMe0xlqQnFKmQsWDiYna6rUpwZCENv8ZXX4jW3ktMAAwb4SjZ9FGwtTL17EuTgFdUS03Ic0QidQToz6AqTRVJiM2HzE0NJTL3EVIJ0odNUJ/JgRkqK7WdVbHhi79iFG+HCdk/k6cG4qAw4FuaV9u95POk26Pprnmwtxv91Ph1m/aI846jkirmQrbWi9/zl5FtASJK4YnF3eRkF4Y6l71jBBejEq8xh5Gz5KX1LAxMk2jXjPH3AHfG7vo8FgjgTT2vQ9j33nHs8cYZeMm4Pl2jjzYAckJY4tHJKvjELCqK+XReIweh39xnq9YaIwXWsxsZT482uMNwgQCiDt42kWpYzihYHTRpsaJ6YKG+GCT6RQ5+BNXTqnPpFbLdof/bwBOa8UWNynBeWnJDld7ylRd+I+BwgkRsw01bT8vODzADrBkD0+EaIewQXKIH1z69Q1+97hHkvjZYsvGzYiqhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(53546011)(6512007)(6506007)(6666004)(26005)(36756003)(478600001)(86362001)(31696002)(38100700002)(41300700001)(83380400001)(2616005)(6486002)(44832011)(2906002)(31686004)(5660300002)(8936002)(4326008)(8676002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0ZTWXZYaURHS2gyV09ZNGh4RTd6U3BZUWhuZXhiRWF3dC81UVlkeUxZUzdN?=
 =?utf-8?B?SWNhZ01vWTdyQzRXTzVXVTBNZE44Z2k4SU9ZTkt3cU80LzV6azBFem11bk91?=
 =?utf-8?B?NnIxQnZLeVpvcVdHRG4rS2hvRDBrY1lVd01mYWdaUTIvYUtKZjFyaktibUlJ?=
 =?utf-8?B?anIxMzRDcllSTm9qY3NBVHJPb0dYQTdQK2UrMk5hK1d4SFYrTnFOSjh6SWhJ?=
 =?utf-8?B?VDE1bkR4RFJ0ZEdSdlVjeFh2dFZRa1gyNUIwQ29jT012alFITzRoSEI5eU1H?=
 =?utf-8?B?VE9zMTg4VitEQ0RjLzB0YnFDRzA1MDJPMUNZTTdiL3FzbVNxZVhHZCtCSENY?=
 =?utf-8?B?Y1VmejlGMEMyMW54cm1hNjJSMnlLSWdEd3lKOVE0eE9Ya0treDcvTXZFTlFo?=
 =?utf-8?B?a0lzMXBMb0FMaHM5cHZlUUxPOHNQNGZqaUQ5b3pHYy9rOGNpdDBHbnRsalhD?=
 =?utf-8?B?MmxROTFMT1lZd2dJYUZLeWVDSVhOZk1rYUJQZkx1UUo5TWJJMUhmVlh6NmFM?=
 =?utf-8?B?T1k2TmI1Z1dCbmJSRTFZK3ZRd2RGMkZYRFFoNFAxdFU4NU5iRzVJZTNiRGZU?=
 =?utf-8?B?YjR0Q1lJcHVYOURyN0FIN3JoV3dOeFp1NTR2QWt6SEJSVzJ3UHd4aUxwTXRQ?=
 =?utf-8?B?Q1pmMDRVcUV6M21UWWpGZU52TUUzbDlJVFVlTnBZQ0N4S2FiUVBiWUFiaG5N?=
 =?utf-8?B?Zmp1VkNWTGhlRnpZVlVkbEFRZDdTM08vbnhKbTRrV2xycmc1SWZJSFJLQkE5?=
 =?utf-8?B?ZzFzbkhONHorV0haNTVmUnVDR1pkb3VzaFJJSGFXT2FrQnpmTjFnTzRhTGpU?=
 =?utf-8?B?VUcvZFJXS3h4QkdGdVlGMXdLM2JTRC9EZTF2b2V1YThpbkF2dWY4STlNWE1H?=
 =?utf-8?B?WEN1Wi9ncVJ4bnMveXlzRExEZHAzbjhpa3Z1dFpGT0RIUTM0Tk9FWlRJK0Nx?=
 =?utf-8?B?S0JpUmhRMjVTSnBpYkEyejBnd2hpdTJtUk4vblJyUGY3Rko1dHlLbGxITzJP?=
 =?utf-8?B?WmgxSzZtakR3dWc1ZzJZRU9teCtocGk2MjFwT0MvTlhtdzZFYlBmR2NlUGpN?=
 =?utf-8?B?Qmk0UkFhS0JtN3JaQkhIYW5wRTNrT3NYckFRUGF1bGhlMFY1bUFJZE5IaVho?=
 =?utf-8?B?SkdtdlRsMjk3RjhRM09ha0Y3L2JUOU9pS0dTdTVkK2k0b2pwMDd2MTRrVjYw?=
 =?utf-8?B?WGhBOVpUTzU0NjVzblNDdE52amQxZVoxRTVwVDI2TnlZNEtteWp1YkRRMjJ6?=
 =?utf-8?B?YTdjbEF2MjltL1BheWI5QzBUS0pNQUFYaUh5dmdRR1hPd2QrZjJFVUMzVlEr?=
 =?utf-8?B?MGpvcVBUT3Fld1JOWWdCbVVUaU9aUTJ3ajI3ZzBJbjF5dTNiRkRjN29lVlZr?=
 =?utf-8?B?Wk9nT2Y2V1hyLzNiWksvcWtmcloySFRYV0pBOHh2NzlWOTZURHZLUUEzeFRI?=
 =?utf-8?B?MlRsNmpYTHlRbmpQSEJubXhQeklaQzRzVFZWUldhL0NYWks1Q0RNc0tiU0Jl?=
 =?utf-8?B?c2NPSm5OUWEzV0xoWCtYcVg4MXdxZGVkT1JBY3lRZVZVSGFtZFJrU0J5Z2sy?=
 =?utf-8?B?Nkg2NGtHZlJZU2RvVm5qdHVURzF0c05zT0h4WnRFT2RJWHZ5WGd6YjVYZFpQ?=
 =?utf-8?B?UkVLajZCV1RSYnBwanZMZVBxeEZFMCttMEcwOG1ZbDhHNDhOTndMTUZJUU5H?=
 =?utf-8?B?anplK2ZzUGRObnVPZEcva1cvbk9hMkJyenY1c0pialhtbmxTZERMeTJ0b05N?=
 =?utf-8?B?NUtKV2VPTzhXUHFOZ3VGa1RhZGc2eEErYll3WTh3QjNOcGN6Z0dzOXByVFE3?=
 =?utf-8?B?NXkvZkJnUEJ2TmhSTC80UGtxV3NDcTJsODNOSHJMYjZJUTRCNEVRMk1tWC9O?=
 =?utf-8?B?MUZqY0RsQ2s2djdzTERJb0lrVlFaSHlKQStsY2hpdDJFbjFnanpPWVpPTTRr?=
 =?utf-8?B?M0wzTlhjQS9xTFg5WWZIbUxHS0E3TndrTU9udU1jdG1qNFlZVGlEQis2dm9S?=
 =?utf-8?B?aXl3dlZTM01VcXYzbVVubjZrYmFzRjFHbUJFY2s5Si9oT0FBcHRTQjBOVDdk?=
 =?utf-8?B?LysvU0kwNWVtWXBjT2lTeUlrWkFCYjMvOHpiOTFOMyt1L3pMemVnS3p5M3p6?=
 =?utf-8?Q?JwUtCsrSm7HFTDmWtKfd6nZas?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbf6834-e579-40c1-efb9-08dbfc0b3530
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:42:07.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFAobbkg+GLi7Z9soW7vHAbmDAPkaPxcKEpWdaYjFJYrQhHSmUy7pYzdOe+5xk0fQx9MghwkgaslKaokUIfmDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356

On 12/13/2023 12:38, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 7:27 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> When a system is being powered off it's important that PCIe ports
>> have been put into D3cold as there is no other software to turn
>> off the devices at S5.
>>
>> If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
>> power resources may be left enabled and devices may consume excess
>> power.
> 
> Isn't that a platform firmware issue?
> 
> It is the responsibility of the platform firmware to properly put the
> platform into S5, including power removal from devices that are not
> armed for power-on.

The specific issues that triggered this series were tied to the PCIe 
ports for dGPUs.  There is a GPIO that is toggled by _ON or _OFF.

Windows calls _OFF as part of S5..

> 
>> Cc: mpearson-lenovo@squebb.ca
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pcie/portdrv.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index 14a4b89a3b83..08238680c481 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>>   static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>   {
>>          if (pci_bridge_d3_possible(dev)) {
>> -               pm_runtime_forbid(&dev->dev);
>> -               pm_runtime_get_noresume(&dev->dev);
>> -               pm_runtime_dont_use_autosuspend(&dev->dev);
>> +               /* whole hierarchy goes into a low power state for S5 */
>> +               if (system_state == SYSTEM_POWER_OFF) {
>> +                       pci_set_power_state(dev, PCI_D3cold);
>> +               } else {
>> +                       pm_runtime_forbid(&dev->dev);
>> +                       pm_runtime_get_noresume(&dev->dev);
>> +                       pm_runtime_dont_use_autosuspend(&dev->dev);
>> +               }
>>          }
> 
> Wouldn't it be better to remove power from the port after running the
> code below?
> 

Yes; I think you're right.  I'll do some more testing with this.

>>          pcie_port_device_remove(dev);
>> --



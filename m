Return-Path: <linux-pci+bounces-895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E78811C98
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922571F219E1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4C824A10;
	Wed, 13 Dec 2023 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TS7AYprz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A41B2;
	Wed, 13 Dec 2023 10:33:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQqg73IFOD1MaYusqbC2H/j6+RWDErY9JX+5YfBvrt3gBsbS09cc3yRgaFu3Z9Cr3kZimZKmlw1qXwi5tcdpnPC6RRexDcwbQnDZupqSX4RPbW2sJ4FluzdkHXuF+8A/98Mz9gYO17oJvqot89J/xMV00mBoF7MYQFp4XLZALFYqLIdCNAFyDwtdSvzOGMjoXDr9uft/TObzX959HRGfGB5jlsLAXb4msDjD/BIkjBOZB2bAQzSRfWz9u77HK42Lqsc/fCD6BoZwHGEEnvz0v46M8Sl1leQbWtcgMQJdTcbnNnK48k+NnGemHTi8gKPiYHyzfp6Uz2bl72+WTLwvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UBKqZOD8bh6KMxX2ZivlKWkHznS+zOoVvAy7OrWZZQ=;
 b=MDk5xTKQnSEf0cLkn6+y/TX+VqhVf37ABLVOERVoVu+pUsEbzPWmsUEBntdaJ4lHGOvR20RdkgRUw4vvEuwB3mtQgztPvnJtPeZVKV1+EY01h8H9aIsY1CSf5MfE6MlWDnhAksZVdTsp0o0Tj1f5qHuoy90UbRkieuEnTNliJ5CK4qDSQ0gJmvQWUSRKCNrwNJHoeGnG2UatXO0QNJYG62qIevLKMCd7EwS2199aSydOVind1rQbO+0ANXN49wWRHMrlzCuirGpADboUwI/ljnNIBQlpG97HGEpg4XpujWYCrviWewzdmki316FjvGBR7pEKdIUywhJwZChR5lrzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UBKqZOD8bh6KMxX2ZivlKWkHznS+zOoVvAy7OrWZZQ=;
 b=TS7AYprzAz26qxu8t/llpynbUJVbr9WnALEXZG7y1QLqVxQWiqrVHqAdkpsrxtdBUMPTxn6B3oh1WWTBYGuyYiAH7CdsArbmWv7dWu2FzTkU6vC66/ybT5C3C2R1snBevf+mqCP0xbIxc1nXf1NJqPkZ71HiZVLk9QzYFpSGeDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 18:33:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 18:33:10 +0000
Message-ID: <d03fd5a4-4f22-45e3-94b1-7ba735ea196f@amd.com>
Date: Wed, 13 Dec 2023 12:33:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: Avoid runtime resuming devices if system is
 shutting down
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca
References: <20231213182656.6165-1-mario.limonciello@amd.com>
 <20231213182656.6165-2-mario.limonciello@amd.com>
 <CAJZ5v0g0j2fpaHUdvxAkfo-3bRp=GRrKOgespUnz_BqX6timOw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0g0j2fpaHUdvxAkfo-3bRp=GRrKOgespUnz_BqX6timOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0153.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: d8eef8f1-4285-4fd5-d68d-08dbfc09f56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/J35GGyHbtgMkJLHilsoFsOudb5wGIPC0nZP+kQHkqo3f9SZJNnIff4QeuQyTVER6QTcBTX7FDs6yzkqTqyrHlSw+k6EgOs6NSzFwcW1AB/dqjOW+HqWyBkYgLnPbvv7GdCROeinOh1N0nR1RPVnDpTs3PaKbG81lH1yes7FldWkbC+FI5RGLMbOLEASQPA+s84Y4MK99I18e5o6tcm1MhbiW/r8NgZBiAP9Pdy7wJ2kPEowY69LU9jagcDuaxMr67n2e/a6cS7sdWuRzB5RFs+aQVfSU7wFokUZRDOl+c4aKkHQQ2WKm8xiXws9Wd0aEieGeCOqX4SDqlCKxVn2WWeRLtFLY9t6jPNNdidbcSGDBuvOvDw6Ifkxutu2nCa6Vor84Ja6gG7iTRyAFSIlV73sS7Wcg/S9IjfEvzrZdIyhfVIehZzAZmxgMpGb8JN4mX6O3PfNYdo+kQfEAnKbc5HnmuWlKJxDB49Q91V0zc69RQ8TLGgXIL2Aoc95enJ7r56+4bBU2+cn7tqMOWJ3La8+rw2dj4YQ8om56LKgAtrABE1pbRwDJhuwqEXHnCkSX9vcci/SAsQYa28oMC2rUYbf9JBL3a7KCGsLSwHQ93/tRKiEt//hQ1Q5/BKyK232jMPDfxf70zaIrr5ayd75fw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(53546011)(83380400001)(6512007)(2616005)(6486002)(4326008)(44832011)(5660300002)(8936002)(8676002)(41300700001)(2906002)(38100700002)(478600001)(26005)(316002)(66556008)(66476007)(54906003)(6916009)(66946007)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZMejg2RjVtUmFadytYOHhHMndZOElVMTd1LzJRY2MvZ0JwcngvNFdIT21X?=
 =?utf-8?B?NTdRWXRPL0RMc1dJZW41NVBLK2xoTm9DV3BTQmRZQmhpM1RwQnUvQVZreElP?=
 =?utf-8?B?NGxRbXBqMTJpaXh0WWYyaFdXTHBBZVNPVStBaExyOVA3MDRqcStuQTlTR0gr?=
 =?utf-8?B?VVVsb2oyVFJ4VUFidWxRYzlRZlBtT0hEMm5yRDg3dEZkZEQ2SzFQZmlWaitW?=
 =?utf-8?B?SDVNM0ZFT1RyUUNkT3ByYXFQS3FLT0pYeTBFaTAvQW5ScXpHRDNEMGNHbjk0?=
 =?utf-8?B?KzQrVGlGaU5oT2lnTVk0Sng4R2dRTXhwcldBKzVOV1R3VG1aNTBZaXd2NXpR?=
 =?utf-8?B?dEEzSXFGeWFJZ052SzROTi9ndmI4RUhtTnNxbTg4eEpSNmpQOUgyL2pHVzhi?=
 =?utf-8?B?RWdvSTYyK2lpc2p0VjIycXliK05qNzV5L2VpVnBEOCs0citvcTBtb3d0anNi?=
 =?utf-8?B?QXlTNnRYSVBiTUZURmFzUE1DR29BZUpYZUluZjZmNGRYMDgvMWwybWFEbHlI?=
 =?utf-8?B?aSt6SDFQQmdwSDVWYVlySHEwUGpGVHB5SmdxUGJxN0xmUG9yVXVrVFRab1pv?=
 =?utf-8?B?cEFpUUNYT1JVTnNYR2R3YmFOZE1NQjNXRmpDazZkMnFMREJMTTd1ajRIK0pk?=
 =?utf-8?B?M3B0NGlLbi9aZ3ZmMTY5a2grZ3NmZzJTNUx4K1hqS2t4dnhOZ25BTWdIdklY?=
 =?utf-8?B?dDAzMnNHK3haWjJmcVo5ZnFzd0Z2blM3WGpjYnNyb25MNW5GYVdSTTkvVkQv?=
 =?utf-8?B?K3N1NkpqVHBCdHJhUjNoNmtIWVlXai9LZlAxS2l6ZXB3TXR5OXM5NXZLNENP?=
 =?utf-8?B?bTBtQW9mRVNNM1RHc3JoY29yOFN4Z3I5MUZDcFZ0RElFZC9idVoxWk4wMFVN?=
 =?utf-8?B?VGFBTUJaT0tTVldXQUwwdTNtUkRRTjFaVmlsWWRiOC9scGEyRkY2bXdMdW5I?=
 =?utf-8?B?QUFWWWx5VUxsUkwrVnhOWUJEbk9KV25WSTZMaFRPRWhMeHVaTGhpdkdyWnhk?=
 =?utf-8?B?ZHdEVUUyTmVzTitrWHAzZytBTTJOZEFrSm1SSWQyK1RORGNzcU1VbW9wbGZS?=
 =?utf-8?B?SHhraFBSVW4yQmx6cmV4T09vL2w4ZkVnaDJtS2M2VXVCNGVXREYvd1kzMDhw?=
 =?utf-8?B?MUJoeTdzS21yOXFqVFNiTUZzdGx3NzFhaStDeFo5SmtPeU9oZEtoQ1dKVjhD?=
 =?utf-8?B?TDIzSWZPanhRWW1pUHB4VkJvc2U4ZnA3VmpUcFgweEVPZXVqdmNGVGY2VHpC?=
 =?utf-8?B?cXpyaTRRWXBNTDVLMFkxMFZDeXNnbS90QlB6Y3lUdVRBZ0VCSldqQi9SUzZk?=
 =?utf-8?B?V2RIaG1KTlpJWmgwUnBqblFUQ2dEU2c5ZEtGTlIxVEl1MEtPajZjRlFnMkRL?=
 =?utf-8?B?YnZHSERkYVZkSnhza0FFVFQrK0tkcVdTMXFGb1VlbFFqeEdTaVM2SUppa1RK?=
 =?utf-8?B?dWlmSTN4dXpLM2taK1h1Y3ZnKy8yR0NBZFZuckNXS0JlTlFISWx5elFJRDZv?=
 =?utf-8?B?eVVHWHdPbXdWZlhRa2tLSldodW9zRUhNMVVpQWo0ZHpzZ2o5MnNCQVgrUUhk?=
 =?utf-8?B?MEp0VndLRTZyaGtLV1RTTEYwWThiRENlNU5oR3N2Z0ZwSW5EWW54L241bE5Q?=
 =?utf-8?B?YVN1VmxobGZHVVYzMy9HNnp2bjRobzd3WWVnSm9zMjREQ1g3eWxWT1hURi91?=
 =?utf-8?B?L01lSWFXSjhCd0w3VlBKTnYvdXNmSnVXTDVEZ29wWFN2ZTJ5TUJCRjNuN3lU?=
 =?utf-8?B?T1hUWVRZU08rOG5weTR4UUoyT0VYTDhXZWtLNzYrVXF3VXkwWUlTM0ZndW1q?=
 =?utf-8?B?M3U1bFlHQ3BaUjBlQlQ3SHRMRGZaVm85WFZKczdnRGZCeFMrYlJTWC9teVVi?=
 =?utf-8?B?Q2tOWVBsbUdaSElXdjZjNlBYT29yYXRQbFhVRDdUMnJCbkVFRG1xSlFZekgy?=
 =?utf-8?B?WElaZm5wRGo5eGlmdDB2cXlIRDRxZDRJSU9tamtCMlVmYnNrOWZhNDd3ek16?=
 =?utf-8?B?QUZ6Rjh5WjdjYm43cXRjZWxNQ21tckVwdjJ5Z1FGNUJkdEIrQ3JEK3lidm0x?=
 =?utf-8?B?aXFLZ3pTRGhPVU5IUUV6aW5lN3FUMzN3Mm1HQk1UWEVscTZvMzBLSXIxL2VS?=
 =?utf-8?Q?2FQwpZQ3frhGdDda/Eq0EEG9a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8eef8f1-4285-4fd5-d68d-08dbfc09f56a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:33:10.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWfGEio5xUSHTNwuVpCk3QN3CuAgizs1sYGpY8aaiHs0t3I8v3prZjwFyYiZkWVrybbQ64aJATjHgL0p5OKpQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648

On 12/13/2023 12:31, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 7:27 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> When the system is going to S5 resuming devices is unnecessary at
>> best and may cause problems for power consumption at S5 at worst.
>>
>> Check the target `system_state` in the pci driver shutdown() callback
>> and skip the runtime resume step if the system is being powered off.
>>
>> Cc: mpearson-lenovo@squebb.ca
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci-driver.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 51ec9e7e784f..5a6f7a786952 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -507,7 +507,9 @@ static void pci_device_shutdown(struct device *dev)
>>          struct pci_dev *pci_dev = to_pci_dev(dev);
>>          struct pci_driver *drv = pci_dev->driver;
>>
>> -       pm_runtime_resume(dev);
>> +       /* If system will go to S5, don't wake up PCI devices for shutdown */
>> +       if (system_state != SYSTEM_POWER_OFF)
>> +               pm_runtime_resume(dev);
> 
> What's the guarantee that the driver's shutdown callback will not
> access MMIO regions of a runtime-suspended device?

This is something that may need to be audited.

I have an expectation that drivers will runtime resume a device before 
they try to access it.

> 
>>          if (drv && drv->shutdown)
>>                  drv->shutdown(pci_dev);
>> --



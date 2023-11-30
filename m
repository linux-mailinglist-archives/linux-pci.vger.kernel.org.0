Return-Path: <linux-pci+bounces-304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AE67FFB5B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 20:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE8E1F20F43
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A6552F66;
	Thu, 30 Nov 2023 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a0z329yU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86693;
	Thu, 30 Nov 2023 11:30:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPhuV59PSApy921ot8fyfuc0+GfxKJI8HSygoV/7YsOmtfR8NUC6xzwWC0d1+CcEATqXyOJjaTaz4I4HdtHVZGivhI/wftDCIgmQJ/LlU94as3CUc1UdPcfqB9ZuozrT4PDCUDhqEiPRNrFYJppUaG06gqAEmzanUUJGZQeORqXc2ge8IDPn/HTBmMb3lk1VOHt120R9Twv8feex+v85EzPwzdr6Joy5oGrC/5KjsmjHKDqiGOWmuk5FP3jXdhoO4q3WhbifPP2UNf7x1QIu9dCOjQTEC1J20wzsNlHooiF8TX7OM3Qvn+l+Fx2rHEpta7zXfa1IZXyqvhpn1WLw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg9hcDTdu2zCF/tBIHho3pNTpJOPzngZeyNuAuy+xwU=;
 b=XW68RH93UE4FaDsecTG+mQSKM/2U19raiGuPsP2S4oRht+yX5v5IJ5mfD0FwRijw6JOnMPn5+QVAO5xAfJjFy0+qDcXxVkqrr8/nytiQo5+57uWUXpE9+KYSNM5bb+Jk8Psx4SJZc3KijjJbXxqNJbiHFXJ1UOunwsxqb7ARCYEi5uLL+pckmh4fqzQrUgHYrNVHJR32xrJZdDbaFLOih9Slr/Wx02dpevddunApr989j3dTR7ZJMh4usNE+F+tkX4J2sHQaZIbQMH8ETp5CU+4a1FxxhWjLizBQECnQBjI4SKk6cAdT8V90RFHdIamU/L8l7T28TkgYWi7zH0ECkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg9hcDTdu2zCF/tBIHho3pNTpJOPzngZeyNuAuy+xwU=;
 b=a0z329yUsTG5XitZzchzYiEndxJNOSgJ82dUr215ndp0Ufy08KAvrReLoJjWEaN3KuzYVi/8QSr1tkhKMgSb5luPq5P9k/U31wXF4UdqViHz1YGDeEYtx1N5Wm72AgUcIsINwV1Ysv6Gw/qoNrVCDdIX4FVXxrBOLAiv/NVmGJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 19:30:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 19:30:39 +0000
Message-ID: <72e6a193-414c-4f45-9991-3c011cdb35fb@amd.com>
Date: Thu, 30 Nov 2023 13:30:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: Call PCI ACPI _DSM with consistent revision
 argument
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20231110185503.46117-1-mario.limonciello@amd.com>
 <20231110185503.46117-2-mario.limonciello@amd.com>
 <CAJZ5v0hAw99pfdrqgg8AxfeCHcBWeoB2J9bR1sN9a2dU=x79Ag@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hAw99pfdrqgg8AxfeCHcBWeoB2J9bR1sN9a2dU=x79Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 20dc9c18-58d3-4771-03e1-08dbf1dad5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6pF2yrqSZ1gpHj5uPM1XbjKFkITE1mkpB7XxAjrCKFdmtJc5zBq9lOb229iRzIz6OpxXJ1z18Ag74P2NRYaFLsw+Od7mD0JOkJAjNgCN3Yuq4uBmROPyIohm7kO5rtHN+amXDVszWCviPUs+0BpG/4HvnJT/hfqVwmpWM5mSMGKdvO1Sfcfb6q+jTUrmto97X/zqozOL7zB5Ga+Ox/tYoA2depzhuCvsx0HgAz4svijEsTGc2S0kML18zZd9iGjAhSf6Shxj+2Ez27Eia3yeElrSS1rmDoDTV+a4ac+2+J2i22hiM1+rJOLdWgRM9TEJc40mT9E4XiGDIXBPSjxBrWNNPcWP2Q+E5wsNQy/jrgLsDsg+eVjc+mjg60u7E+3sNwh6yXfPUXeh763sLWdZPS7CINDpWE19JYICS3B7e2FSsUoBQkpadpK2NflgPAhYe/+oMDITJQ0ZcW11PzrQgN4gZATcjTYNnNDMCVhqtZ4uJx0+HznFvNAm3An0fE0e/Q8BjtDm+RcP9fii/icU5400rxbh61CatEwVUXc6hfjr0+fC9j0XPxBnPt8SwkjTkZpz6DrmW2p2nO1uaIDpLZCNDGMQqQJ0kq7OrTgjEpGE46/giokv1yRncDiCYnwHOEXBcozolyk9CeqBTVmrCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(38100700002)(36756003)(31686004)(86362001)(83380400001)(5660300002)(26005)(44832011)(31696002)(2906002)(2616005)(6512007)(53546011)(6506007)(4326008)(8676002)(8936002)(6666004)(6486002)(66946007)(478600001)(966005)(66556008)(316002)(54906003)(66476007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ZLbUxoaG1KVEtzc1Rqb2lGWWt1UmNjc2ZQbzlOeU0zaXVDekdycUpNYWxo?=
 =?utf-8?B?bzh4SW5WRnJvN2M4N29LeW1aT2JvSnZqYTZkdGNqVUp1SngwQmFkRGFiKytV?=
 =?utf-8?B?UVhWWWloYWlUTHIwTzl0WFltbWtjZE1NZWF3TU9Pa0tPeEdhZ3R5T3dveHcx?=
 =?utf-8?B?eDZ2S1RsN01rS2hwWnNOYVJCdWN1RDhkQWp5TmRES1BxbTZRTWx3SkcvcmFS?=
 =?utf-8?B?UlAvWEIrOElTd0xDenF6aDg2L05mYU91YWRLd29INjkveUIzcGxDRlVsQXR6?=
 =?utf-8?B?aVZDMk5QczZURXlENUNLR0VnSHFQMm1PNUY5bnA3dmkySXhhMUw5RDVDRWRU?=
 =?utf-8?B?K05ERlBuVmo0OGo5bTRmRXo2WGJqL051YTJQVktVaENmdXBvb2lMSWRpZGdn?=
 =?utf-8?B?eW90d2NnMEZVVEFZeHBFTmo5ejY1YS9oalpEcVh4Qi84ZDJGWTBsUnF0dXpw?=
 =?utf-8?B?Rk0ySERyVlM5UUdkbkRQbjFsTis0WHRGYWZBcWZ2T1hITHVDU1h6V1NGMnd2?=
 =?utf-8?B?Wng2ZER4NXROUkt2YisyS25sOTU5V1EwMm5ZUWg5OWdqWlBDRmhWR0laZUpi?=
 =?utf-8?B?NmdaOThmVWpwQjA1L3E0ZTZzb3F4UStKbTlNMVNqNExFRm1sSHRFbHlMNDg4?=
 =?utf-8?B?R0VQVkpVbXB5QUdBMEoyQndSOU4zelNlUERXSjVhNDBndFFFK2JIU1hTdjRj?=
 =?utf-8?B?VWh5MUk1NTBQMEJpYUFzUEVVK3BLY0FEd0pGN0dERGpiL3hseFRhaUVucWxs?=
 =?utf-8?B?SEhZcUpjQ2dpYWJQRW93OWNGZHNYOVJ1eHgxZUdJOUdKV044a2FKbCtIRWwz?=
 =?utf-8?B?L3ZnSHNmUS9pWnlwVGdpWENQQWFNRFdEZ2t5QlZGeGlxMjQzNng0T0FTM0Vh?=
 =?utf-8?B?eXlRbnZ0Vi9oWVovam85TkhNdjF2d3BjSG1RZXo5SnpIWnBIUlhPc3FZeUVp?=
 =?utf-8?B?MEdIQzU3YWFxTk5KeU9nVzJSNzBzOEdMZGR6eE9RVit0cFNFaUN2Wi9oWDNj?=
 =?utf-8?B?NHdXdUNtUm52d25icWczdW8vVGoyNi8yaVZVWEdwMU9lQUZtQkpIRk9GNWF0?=
 =?utf-8?B?YTJtZk8yNHpGeU5QVnl0Ymk0NTA1T3Z6UFE2aGxJR0xFODY4bFhGME43SUcz?=
 =?utf-8?B?WldNNlJmZm9QeG4wWVRPcnNVVTUzeTBFakRvVk1ibkFWakJDTk9hK0wyTStq?=
 =?utf-8?B?M29iTWcxUHppQXRyTllaUlNFT2RkQUc1bzNMdTRnOThvOWF5a1AwdDV0Tmww?=
 =?utf-8?B?TjBlU3dBTjU1TkN3Mml5TFRFdVJzMFozVTNkSVY5RzMzdi9oS2M4YmQ4YUcw?=
 =?utf-8?B?bWp0WVRXN21ucjA0SHZKUjNoNENJaS9FdVlaTjUycGVvTVpCWm95dFZoS1E5?=
 =?utf-8?B?dmFyUGVicjNGcGVmTnhrRmo4MjJQWUEvNUc5SWNyVzNtbnA5NVAwQXpPSmpM?=
 =?utf-8?B?elZ6Z0cxdFVDUE1uRkFad0ZGeHlEUlpxdGtwUTcxT3NVMjR3WGgxWitzaVRI?=
 =?utf-8?B?aHJMaHI1QXhTamFQa1pmcVdOdlU4NkRtdnNCT3pFRTZheFFLWUxod1N2YWVa?=
 =?utf-8?B?bm9WSDhmZkJwS1B5YVRna1RGRjQ2Tmx4Z0xnZktSNzI0WmZzOVBxYS9zeGth?=
 =?utf-8?B?anN6VldXWlZSVHRSN1NQZ3l0V1Z3a2NrLzUxRk9KdGJzUFIrTEJoQ2EydWNx?=
 =?utf-8?B?dlZCS1JocFlPam8zVXpQYUprRWxXUmhrOEJxTnNsZHZKbnZQdGtGS2NId0s3?=
 =?utf-8?B?M0FXOTZRYlhFN0owT0crQlFiK1ZOcTNBdjNTTExGWFdYWHh6bnRBNzY5cUNm?=
 =?utf-8?B?WmN6RzFkSUlEWC9Vb2ptNEs4MElEcDY0cU9iOFIwMnJndmhBbDNuREZPZUdh?=
 =?utf-8?B?RlBQWGEyTGR6ZzFMNVN2UXdCTDZBL2IrdEpPSndGSU90a0hETmphaVZLblF1?=
 =?utf-8?B?NG5FTUFHVWtBQ2daZXdEV0VWc01nTFV1ZTRJa2dCV1lZNXhDemZEUlJjTHpF?=
 =?utf-8?B?b0RJSDZBdTlVWG5YbjBuWWp1WExPV3dla091aklMMHhPZEd0MG5tSHovSzM5?=
 =?utf-8?B?QXZPQ2tubDRXUlQ4SXcxc21JbjJQVnlxY0xXcnBlbnhKUUE4Z1NCTDdkN25Y?=
 =?utf-8?Q?Bt54DLnvtfBo8iEMeENy+1M7S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dc9c18-58d3-4771-03e1-08dbf1dad5c3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 19:30:39.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41/QJBDV+tUf0Angvb6Ewf42bzWFul7KJbZg2FhM8EHhY1kl5ws04L4x6sE9MneEAnrMTH8rGMIKZmKquOFq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083

On 11/30/2023 07:34, Rafael J. Wysocki wrote:
> On Fri, Nov 10, 2023 at 9:32 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> The PCI ACPI _DSM is called across multiple places in the PCI core
>> with different arguments for the revision.
>>
>> The PCI firmware specification specifies that this is an incorrect
>> behavior.
>> "OSPM must invoke all Functions other than Function 0 with the
>>   same Revision ID value"
>>
>> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
>>        PCI Firmware specification 3.3, section 4.6
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

Thanks!

> and I haven't seen much activity related to this series, so I'm not
> sure what's happening to it.
> 
> Regardless, I think that the remaining two patches are better sent
> along with the first users of the new APIs.

Bjorn,

If you agree, can you please queue up the first patch?  I'll shuffle the 
others into the back of my mind for if/when they're needed.

Thanks!
> 
>> ---
>>   drivers/acpi/pci_root.c  |  3 ++-
>>   drivers/pci/pci-acpi.c   |  6 ++++--
>>   drivers/pci/pci-label.c  |  4 ++--
>>   drivers/pci/pcie/edr.c   | 13 +++++++------
>>   include/linux/pci-acpi.h |  1 +
>>   5 files changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 58b89b8d950e..bca2270a93d4 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -1055,7 +1055,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>           * exists and returns 0, we must preserve any PCI resource
>>           * assignments made by firmware for this host bridge.
>>           */
>> -       obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
>> +       obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
>> +                                     &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>                                        DSM_PCI_PRESERVE_BOOT_CONFIG, NULL, ACPI_TYPE_INTEGER);
>>          if (obj && obj->integer.value == 0)
>>                  host_bridge->preserve_config = 1;
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 004575091596..bea72e807817 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -28,6 +28,7 @@
>>   const guid_t pci_acpi_dsm_guid =
>>          GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
>>                    0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
>> +const int pci_acpi_dsm_rev = 5;
>>
>>   #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>>   static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *res)
>> @@ -1215,7 +1216,8 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>>          if (!pci_is_root_bus(bus))
>>                  return;
>>
>> -       obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
>> +       obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
>> +                                     &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>                                        DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
>>          if (!obj)
>>                  return;
>> @@ -1376,7 +1378,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>>          if (bridge->ignore_reset_delay)
>>                  pdev->d3cold_delay = 0;
>>
>> -       obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
>> +       obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>                                        DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
>>                                        ACPI_TYPE_PACKAGE);
>>          if (!obj)
>> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
>> index 0c6446519640..91bdd04029f0 100644
>> --- a/drivers/pci/pci-label.c
>> +++ b/drivers/pci/pci-label.c
>> @@ -41,7 +41,7 @@ static bool device_has_acpi_name(struct device *dev)
>>          if (!handle)
>>                  return false;
>>
>> -       return acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
>> +       return acpi_check_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>                                1 << DSM_PCI_DEVICE_NAME);
>>   #else
>>          return false;
>> @@ -162,7 +162,7 @@ static int dsm_get_label(struct device *dev, char *buf,
>>          if (!handle)
>>                  return -1;
>>
>> -       obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
>> +       obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>                                  DSM_PCI_DEVICE_NAME, NULL);
>>          if (!obj)
>>                  return -1;
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index 5f4914d313a1..ab6a50201124 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>>           * Behavior when calling unsupported _DSM functions is undefined,
>>           * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>>           */
>> -       if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +       if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>                              1ULL << EDR_PORT_DPC_ENABLE_DSM))
>>                  return 0;
>>
>> @@ -51,8 +51,9 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>>           * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
>>           * optional.  Return success if it's not implemented.
>>           */
>> -       obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> -                               EDR_PORT_DPC_ENABLE_DSM, &argv4);
>> +       obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
>> +                               pci_acpi_dsm_rev, EDR_PORT_DPC_ENABLE_DSM,
>> +                               &argv4);
>>          if (!obj)
>>                  return 0;
>>
>> @@ -88,12 +89,12 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>>           * Behavior when calling unsupported _DSM functions is undefined,
>>           * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>>           */
>> -       if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +       if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>                              1ULL << EDR_PORT_LOCATE_DSM))
>>                  return pci_dev_get(pdev);
>>
>> -       obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> -                               EDR_PORT_LOCATE_DSM, NULL);
>> +       obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
>> +                               pci_acpi_dsm_rev, EDR_PORT_LOCATE_DSM, NULL);
>>          if (!obj)
>>                  return pci_dev_get(pdev);
>>
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 078225b514d4..7966ef8f14b3 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -115,6 +115,7 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>>   #endif
>>
>>   extern const guid_t pci_acpi_dsm_guid;
>> +extern const int pci_acpi_dsm_rev;
>>
>>   /* _DSM Definitions for PCI */
>>   #define DSM_PCI_PRESERVE_BOOT_CONFIG           0x05
>> --
>> 2.34.1
>>
>>



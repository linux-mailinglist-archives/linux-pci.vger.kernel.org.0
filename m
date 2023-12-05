Return-Path: <linux-pci+bounces-529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB954805F2B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 21:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CFAB20F7B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01866DCEB;
	Tue,  5 Dec 2023 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UXRsQGTp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4389D3;
	Tue,  5 Dec 2023 12:12:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTuZiyJLQZj5TSchqRt8KkkqTgEm9ErAGcNzru7kA72M2qbHDl3Gw3/fibRbravgA49bgxL8+BWcsDCEyLHAYq2CwAk6AXt0QNcrbI8m3ITNeV8Fx6TEJrIS3X79/NhgVWoan68JJW5tJSeB1Naik9dQ3JM8mUHq4E2Vybvrgi35Q2ajxmAacyprniWfmuYz9mIp6RjiwSUIqvSdAxTKPkb8A9dx1SYLODcAFyyB+rgTn2kTXAksQ/qAD266n4kuUW7EYFU8RC5Zz9gGyeHI0HhFBAxzqZIUiHozs+8I92Aa3dDEi0bjm+/wwQmbi5ZnuIyDkiOpLmf1352aI7fiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XS/SHKF6NynZSBh6ki/T1d+tFXGgd3eRM6LF728VOw=;
 b=EzRHyyLWDQiVcJMsShNnRwDLw2SzznPuCBTh265FpYVCbBRVEoZAcHLrKt8kqIg6bwdqOr8eNfC/fJJjboa6GSZetDulCWWb9gUMVL5xljTmw8lrhFO737xWfQVMmthEjgDHLhc/7kE+EWw7RjiKU6HBApCuS3AXtmTIzowNr8Bm1zJDVlgY03qK3mfbZ60e1bp+0WBc/XYtoTiG3x1mycZEZNNtU7ks+xTua02lKXRAiFI3tGnm/LBRjA+5Nv2UqPq67qtOH/c65bU6oQjFZKOvWPqoQ3sEuLLq2TxQczE0RODjAcvxSD7CD8Hir934nBf6XhH/Hh0le/ycIaSrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XS/SHKF6NynZSBh6ki/T1d+tFXGgd3eRM6LF728VOw=;
 b=UXRsQGTpL61+g3daAyowX/pVCaYgeShMGGllxnT4YnUxcpAts/O7fPh3Ltbl3N0Ifu5/cDDFSsXeTBV2j5UHna1TPieMyBAeKXbXrngBRUqR/TdwxCd/rDFDOz58IUrnerlwuKyhmeJzY+B4MAwUuGi2WTA+khLlFk0+A+/J5i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 20:12:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 20:12:56 +0000
Message-ID: <73628abc-dbb8-4dac-b83d-a78462b327b8@amd.com>
Date: Tue, 5 Dec 2023 14:12:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: Call PCI ACPI _DSM with consistent revision
 argument
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231130222930.GA488440@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231130222930.GA488440@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:806:27::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: ea60c7b4-157e-4376-e85a-08dbf5ce9207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wqBrqfOctfeP5em1vxwY77eVBkxBSW3Z4hP3IQnaKak3YIGK4g6xf1CeqwbwFCnTrWJtpKoEUi3xuXKblScZ08Ev8KmxhwTriHzCdKJa0wbR/PDFIr7uu8bmQcxdWudKL8cYuYVaVPrfJXeMcIfTSSSn2EBmY48BMzqtNBW+rfSoA3yccumqhdZlR+6CzDOvitj4gxNq8M/nvbLatmCehCw0mKTCEYQVwEMi1g2N7E9tLQ8FaHgmy/pTT+chdTIJbSfWcPfz8gqR1CwJrnHmY1BbyOsmvVvOemxuV1NardQWEfQjxhloQfetm1z88vGQsJtVOANMfYeHh3tLoBCquVbg6P8MKM9kDWNIYm4+bM/0C11Dw47kyLdxDB5FRspe8Ndt/585NHMAWjRB/JfTA9M24a8Xj2P6o6KvFZfwdx6OqaZEggqURWnj48nQtMmNDvMans5iFkrv51naJmK0HCo9oCACUcADQXzy7luuvB7aMBlKldqWt2+FV/7uOYKPipfjgExG3eONCyMNZEwBLSVImkGfWeaAmKTkjyF+Qy6/UFjT0XrQioD6w5VB8LO3Y86zfxrUqUcQrppG7jZk+p3WAE3lXYPOb0EgAC1Br69+fG3me2Zb2S6gP9Ux0KWrNTPt4OkMSFfq4yVRwD9XDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(83380400001)(478600001)(6512007)(2616005)(6506007)(53546011)(26005)(966005)(316002)(66476007)(54906003)(6916009)(66556008)(66946007)(86362001)(8936002)(36756003)(4326008)(41300700001)(8676002)(31696002)(2906002)(44832011)(5660300002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG03TzE5QmVMY1lzYjhFRmprRExZSkNVRjZJNDJUQlpwSHZSc0V1MWtTckFk?=
 =?utf-8?B?RzZHQ0gzME9HNTFjV0hqYm9RMVh0YkpQdnNYRlgyUVU3d1FwcUxHTENGK3ZX?=
 =?utf-8?B?RjlzZ2pjSzVWdUl6WHBIbkxEM0pqT2NlWTQzc1M5Yi9sS0UvT1psNG4xY2hh?=
 =?utf-8?B?SUFYcFk4eTlqTTJicGhScDdoUk9idU01ZmpzRE5NdmRaaXZ1ZDVkR3BBVkJR?=
 =?utf-8?B?dnQ4Y091L0lITDVIdkhSODdINFlyT0UxNm0yOVNXMkZhYURYYzJjVjkxZmYz?=
 =?utf-8?B?THpVNnlhMGhoQms0ZEY3RkthOENmd0JtSlZDSi9TWEphMHQyRE1vZ2ZZRDls?=
 =?utf-8?B?QVhtZ0xnZ2UycWZkdE04YUcrZW5meDFSK0FHVm9qL09VckM4SVQzUHJYakZt?=
 =?utf-8?B?U05ST0p2Z2JxNHEwYng2QnhaeVJtQ2FRdGhJN1NSL1FDNC90VWpmV2tlUmdo?=
 =?utf-8?B?M3pnbGUwR2Q0N1NjdTVvMllKOEUrTXhwR0ZkaGxyNFFWTjk4T3RETnphK2h3?=
 =?utf-8?B?bE9PdXlGenJ0NlRrV1VpVUxOWHRMcGhCMWRJVkRJT3h5THpoV1dLSU9oTDht?=
 =?utf-8?B?dUlObGF3aFRucFY2ZjZGTjNucm5zc21QNUZGeTk2SEk2bDRZZUFwVStCd1Rj?=
 =?utf-8?B?SE9VTTBmUHd1YmF6MzF6N0swRjNjdzVxWk9ZZENQcDFXdVFIdlpCcDlvNmdO?=
 =?utf-8?B?cVJzeFJuSmxtRFNLM0JFVno4TUs4bU11VFZOSXo4VVltVUpRMXNKNHJYTlU4?=
 =?utf-8?B?eXpYcEExNWVwZE44QmRFdHJiZlB3WitnU3hHdFZVZzdlaFc0eTlJNGNyMmZM?=
 =?utf-8?B?NnYrd0ZHSHo1Q3oyL1NldUlrcEtZa3dIck4wTFkrVzF3R0xLWTF3bnI5OGFq?=
 =?utf-8?B?ampiUTB5RW1VRU9GNStHVHk5aU4zcDRjdms4UUJaWmMrbDBOR3k0WituaitU?=
 =?utf-8?B?ZjlST2lXVTJCWTdZNEU0dG85UnJMWkl0Ulh3akdJamxySi81ZmhIYUhGcCs2?=
 =?utf-8?B?NEhlVXJkQW93eDUvWUtEZmZiL3A5Z2daOHkxczQ0cTFaYnlFZFlubGEzdk1x?=
 =?utf-8?B?TVg2K0F2WjJzbld5eU85UWUvQlVtY1dFYUtwN0dxT2VyL0w3Uzd2WWFhMGk0?=
 =?utf-8?B?cG55RHhmMVI1cFlhTnUva0lGNXJQWExpaTdHUXl5c0J4bFd0ZzJaRnVSOGEw?=
 =?utf-8?B?RGVxS0lmZVlmMkg0enJmcXo4a1hlSnhtSWhFNW9nVEYyamxJL3dlNW10RGhT?=
 =?utf-8?B?c3NQTHVKd3dwTVFCNFpXb0ZTTGdBa3MzYXVYOEdZVlB4T3d4dFAzK2pUaWNi?=
 =?utf-8?B?MmM0YkJ2QnNBdmwyN0hJY3RvY2w5M0VRNU83ZXFmTU9tcWpud3hmY29ybXpP?=
 =?utf-8?B?QWQ3MUduQkxKWFNQSVJWcjh3dWpqcDNGN2IvYi9CRUlHZGJPMVFENXlGcTFs?=
 =?utf-8?B?T0hDUVBpbXY3S01Td3hUQkZhRHZyMm9GVnkzRWpua1ZXWFJLRWdMVHVLVklR?=
 =?utf-8?B?Q2lNTGxUZDhXVGNPVHFWY0MwSVBpZS9HVGljYm1WOS9CLzFFQVdvRkVRaUYx?=
 =?utf-8?B?Rzh4MzVCVzBDZ0VqSW1OR3dyNlQ1RW1uVW9zTEJ6dlpxdGhZbVVOZDFmeko2?=
 =?utf-8?B?UHdjbmVTUHlaVjFVc05HVFFnTVhTTTZuaHlnNk1oRGg3dS9PZ3p4N2Z6KzdU?=
 =?utf-8?B?RG9FcDUwUmVRWUFhWmJsSTNlSjh2ajE0M08vTEFQNWFRaWRBTTV3VWR2TFRn?=
 =?utf-8?B?OWZiamZhMGNpSUw2bWpwTUFYOTdBcE4yNW4yNmJNMlJMd2RqSmpZVlNXYXZ6?=
 =?utf-8?B?ZnMrb0lLSk4yemJ4c21Vd2xPMjJTbWRCcHNxcUZLdWxPeGxlK1NTclBvTXIw?=
 =?utf-8?B?djV0bjNpSWJORTN3dUF0Zzk3L1c2Ri9SL2o3ZkNNL1B6b1ZyTnFjMXo1bUJU?=
 =?utf-8?B?MFBWdTlzbFZ4NFhrYnVxdWpXWUNqUVZxQmhzOEsxTHlTSzFiS245cGxrYTRH?=
 =?utf-8?B?TG93dk0wQjhIeGtmM2h4V0ZxRlhDT0tUWThaN3YzS1V5dG1xRTRRc3loU2Nr?=
 =?utf-8?B?a3UyM0JIM0pPdUkyN2RwdXBGaE84NkNTd3d4UWozdUZnV2dRVk1aZjlnTnc4?=
 =?utf-8?Q?G0usexJHIohwL0d39Ff3vT8lF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea60c7b4-157e-4376-e85a-08dbf5ce9207
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 20:12:56.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHdeAb1lRWT8gyorP8fFhnp3yeje6/9WJ/5x8rRXk2n872Tf+QYwg5dJQbv1M3xM4Eko3FbxEI30npM2eq5oDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060

On 11/30/2023 16:29, Bjorn Helgaas wrote:
> On Fri, Nov 10, 2023 at 12:55:01PM -0600, Mario Limonciello wrote:
>> The PCI ACPI _DSM is called across multiple places in the PCI core
>> with different arguments for the revision.
>>
>> The PCI firmware specification specifies that this is an incorrect
>> behavior.
>> "OSPM must invoke all Functions other than Function 0 with the
>>   same Revision ID value"
> 
> This patch passes the same or a larger Revision ID than before, so
> everything should work the same because the spec requires backwards
> compatibility.  But it's conceivable that it could break on firmware
> that does the revision check incorrectly.
> 
> Is this fixing a problem other than the spec compliance issue?

It was just a spec compliance issue I noticed when implementing the 
other two patches.

> 
> I agree the PCI FW spec says this.  It was added in r3.3 by the ECN at
> https://members.pcisig.com/wg/Firmware/document/previewpdf/13988, but
> I don't quite understand that ECN.
> 
> ACPI r6.5, sec 9.1.1, doesn't include the "must invoke all Functions
> with same Revision ID" language, and the ASL example there clearly
> treats revisions higher than those implemented by firmware as valid,
> although new Functions added by those higher revisions are obviously
> not supported.
> 
> PCI FW also says OSPM should not use a fixed Revision ID, but should
> start with the highest known revision and "successively invoke
> Function 0 with decremented values of Revision ID until system
> firmware returns a value indicating support for more than Function 0"
> (added by the same ECN), and I don't think Linux does this part.
> 
> So I think the fixed "pci_acpi_dsm_rev" value as in your patch works
> fine with the ACPI ASL example, but it doesn't track the "successively
> decrement" part of PCI FW.  I don't know the reason for that part of
> the ECN.
> 

Do you think it's better to respin to take this into account and be more 
stringent or "do nothing"?

> Unrelated to this patch, I think it's a bug that Linux fails to invoke
> Function 0 in a few cases, e.g., DSM_PCI_PRESERVE_BOOT_CONFIG,
> DSM_PCI_POWER_ON_RESET_DELAY, and DSM_PCI_DEVICE_READINESS_DURATIONS.
> 
> Per spec, OSPM must invoke Function 0 to learn which other Functions
> are supported.  It's not explicitly stated, but I think this is
> required because a supported non-zero Function may return "any data
> object", so there's no return value that would mean "this Function
> Index is not supported."
> 

> Bjorn

What are your thoughts on the other two patches in the series?
Should they wait for a consumer or prepare the API to match the spec.

> 
>> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
>>        PCI Firmware specification 3.3, section 4.6
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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
>>   	 * exists and returns 0, we must preserve any PCI resource
>>   	 * assignments made by firmware for this host bridge.
>>   	 */
>> -	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
>> +	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
>> +				      &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>   				      DSM_PCI_PRESERVE_BOOT_CONFIG, NULL, ACPI_TYPE_INTEGER);
>>   	if (obj && obj->integer.value == 0)
>>   		host_bridge->preserve_config = 1;
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 004575091596..bea72e807817 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -28,6 +28,7 @@
>>   const guid_t pci_acpi_dsm_guid =
>>   	GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
>>   		  0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
>> +const int pci_acpi_dsm_rev = 5;
>>
>>   #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>>   static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *res)
>> @@ -1215,7 +1216,8 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>>   	if (!pci_is_root_bus(bus))
>>   		return;
>>   
>> -	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
>> +	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge),
>> +				      &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>   				      DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
>>   	if (!obj)
>>   		return;
>> @@ -1376,7 +1378,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>>   	if (bridge->ignore_reset_delay)
>>   		pdev->d3cold_delay = 0;
>>   
>> -	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
>> +	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>   				      DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
>>   				      ACPI_TYPE_PACKAGE);
>>   	if (!obj)
>> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
>> index 0c6446519640..91bdd04029f0 100644
>> --- a/drivers/pci/pci-label.c
>> +++ b/drivers/pci/pci-label.c
>> @@ -41,7 +41,7 @@ static bool device_has_acpi_name(struct device *dev)
>>   	if (!handle)
>>   		return false;
>>   
>> -	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, 0x2,
>> +	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>   			      1 << DSM_PCI_DEVICE_NAME);
>>   #else
>>   	return false;
>> @@ -162,7 +162,7 @@ static int dsm_get_label(struct device *dev, char *buf,
>>   	if (!handle)
>>   		return -1;
>>   
>> -	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
>> +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>   				DSM_PCI_DEVICE_NAME, NULL);
>>   	if (!obj)
>>   		return -1;
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index 5f4914d313a1..ab6a50201124 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>>   	 * Behavior when calling unsupported _DSM functions is undefined,
>>   	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>>   	 */
>> -	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>   			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
>>   		return 0;
>>   
>> @@ -51,8 +51,9 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>>   	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
>>   	 * optional.  Return success if it's not implemented.
>>   	 */
>> -	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> -				EDR_PORT_DPC_ENABLE_DSM, &argv4);
>> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
>> +				pci_acpi_dsm_rev, EDR_PORT_DPC_ENABLE_DSM,
>> +				&argv4);
>>   	if (!obj)
>>   		return 0;
>>   
>> @@ -88,12 +89,12 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>>   	 * Behavior when calling unsupported _DSM functions is undefined,
>>   	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>>   	 */
>> -	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, pci_acpi_dsm_rev,
>>   			    1ULL << EDR_PORT_LOCATE_DSM))
>>   		return pci_dev_get(pdev);
>>   
>> -	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> -				EDR_PORT_LOCATE_DSM, NULL);
>> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid,
>> +				pci_acpi_dsm_rev, EDR_PORT_LOCATE_DSM, NULL);
>>   	if (!obj)
>>   		return pci_dev_get(pdev);
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
>>   #define DSM_PCI_PRESERVE_BOOT_CONFIG		0x05
>> -- 
>> 2.34.1
>>



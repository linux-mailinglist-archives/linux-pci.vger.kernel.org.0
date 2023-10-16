Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E17CB558
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 23:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjJPVey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 17:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 17:34:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE4A1
        for <linux-pci@vger.kernel.org>; Mon, 16 Oct 2023 14:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7LhLL5fPQfu75QDUe7Hu7Dhh+dDxx851blyDkY7xqtr46qvBiPJAtlnI0479HyxCRY1q85SxsjSl7Iw7IIqT4sXv/V+SL3J8egUfVEwwROu2GMvyp6PyKksnL37bX1qOv81VFWi1+SyIQ4HAgvZDpWWafZiTdOKqpfL44ykPaJ3RMae/FnpFrLmAsQml/BmnySJIFENvqc2Ki2vbJhYNlGJxzwwIrP7yQo56lxM1ROxRZCZialWmq+1kjBbRilx1pZ0o+PweQ6bcbYrWuqhpLhPy+Z2AGmY3CqA6j9h004RLnmFl/AwVcq7VAOtfByr1yIvOUu1e5IpYZAuU4IgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v4agjnVHnEHnvfI3lTssY9HKuY0n01uwwFV6JASHDA=;
 b=gCfz2g4gMUL9+ga48sdSvWiPbJ8CNWNr9lLLoLEymgokAIHoCZNTBsYTkUxYIL8GH9RIziTNCPYk3au2aG1mwQ3j3ZrsJD5Fx4VI/8wngtOna+nVJxE9q2zIqbxFj8AAhJyY0AI61JOQSl1OJspx4LKMNSHQ99CeybtDdfb9M6DeOBZeB5/tzS8+KTOuecMJUSdH/kLRuf1biswJexgvEHhgUGkIIrx2pJf0KAAdaLvB++BFpu0XQbCWEblIP+yz1Q92eeue8fIs2iAzoAddwzvC3YR4rZLtz+4YYyfYgPQ4X5IEMRUwdynAER+aZ1jB9PJo1fHFotaQAg9Ing/yzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v4agjnVHnEHnvfI3lTssY9HKuY0n01uwwFV6JASHDA=;
 b=5FhW7d5g3DIPwjpPmpK7cDoPsUyhBlD5MoK2ys5wNktvpbdfyzONrv+N8BLgwguJYYyM/Hy/8YVhQVIUuw9x7ztjJYAmiDNQ8VEJcOxzo81eKao91b/iyxAf5HO30eBgwdIoTin+0TWUm/INLq0X2FWYpKy/Hayf/AMuNB1iOyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 21:34:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 21:34:46 +0000
Message-ID: <1ff61826-0cf4-441e-9e7c-7d8e4cce0606@amd.com>
Date:   Mon, 16 Oct 2023 16:34:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 4/4] platform/x86/amd: pmc: Add support for using
 constraints to decide D3 policy
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <20231009225653.36030-1-mario.limonciello@amd.com>
 <20231009225653.36030-5-mario.limonciello@amd.com>
 <CAAd53p52668p46Bocx2z4VejGFvWz+JUHuz_J762zsD3sJPgUA@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p52668p46Bocx2z4VejGFvWz+JUHuz_J762zsD3sJPgUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a124a81-2354-4491-be9c-08dbce8fb794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQrjtVgbwnNWvYKTiSzsi4wIpXByINxieYkIBQyVTQBrKmprnCGQbwoKG4zQBFqKvJ67bzW1/FDbt8SJNXFTo8yRhi+W+CdbKXiyKd59uIBqe4kvwj9mV5eW0vaiBkMkpTw+AYhC4Rll1h8677lL0e5cTpFjVbo3l36jtFtxIek/H2atDQHItc7ozaRjQKJMU23bLqQec52WhqhUy449upKMdw1KbJNXuQRLP1FeivPWSfCLFtQLYAwF3c7GRa+TQzeUpwyO6nghasvr7KQw/QoBOGFzVBLlSXhAD3rg7GwLjcb31MM/FSEav4SM5lsxGKuKK9QPqx6hgrEUNI9kZ5y9Y9iTyImzUlBfefmlcB6xuFxxSnmVicLJI04vI+w9x7nuojRQm/VGhqsr67MqR5+jlgPQ/uaQ0nzhcuOB/cMLj83zH3CU7kKakUp6AHyAKaLTCI+HFwePv7POexAH8PdE9iVfQaUGcNRugTQ7Ur8NpCKGQhHt4DX1BornmaOKqZh3UvyqPDQfLOEiG1rwpoXG78rNB41zzGSlCBYBGStSuWbjyH9JB3gPj2KBl5rg0wkzVRDEbKJWMYu/vpGZG60e76p4a0gWMeUbyrTKq3X1F01G9zaSt0nVQGKD+V9wklMEyjVsjq/ol3UptgnnPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31696002)(38100700002)(86362001)(478600001)(83380400001)(31686004)(66946007)(54906003)(6916009)(316002)(2906002)(66476007)(966005)(6666004)(2616005)(6486002)(36756003)(6512007)(41300700001)(8936002)(5660300002)(44832011)(53546011)(4326008)(8676002)(6506007)(66556008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXd2ejM3WC9vNnJuM2U1ZDB3bDNZOXVkeXpWaWd3T1IwSFUxS1FnWEhWSGVO?=
 =?utf-8?B?OFZCSDZEdU1aNnNrL1lYOUpSZVFkanpNN0t5ODl4aWF3bSt1VGcxdUFJVUFD?=
 =?utf-8?B?SG9HaTBjTDg0YnNldUY4NEJuek56M2NjWW1NRXdwSjVZR1RGUnFnckI4WS8w?=
 =?utf-8?B?QmIxWlFDRTNHYUZrblBKQ2J4ZE9rY25EWnczUG9mMGkzT1dpSGltVWh0RG1r?=
 =?utf-8?B?N2ZXNW5GM1NFYnpxT0hvYUUvM1V6WW15bDVuYzdibzRzNy9hTDlGRm5Zek9P?=
 =?utf-8?B?d1lqeE1HRzNPbHI4UVVlRUxnSjl4TTExR2ZtQnZxQUdWbTh5Sm91R2pDQkhh?=
 =?utf-8?B?aTF2ejl2blZCNHlpV290Y3c2K3lQYUlBNHhramlyaFl4RzR6ZlRrYUVPNWh3?=
 =?utf-8?B?SDQzc0o2VGNna0dTOU52amVTYXlkWlkrQnhoUDhRNnlzZjF2USs1VzZqa01l?=
 =?utf-8?B?dHZaUExOd1MvUzlaS0poTWk4OVhJMTVsOHVndWNsWm9LemFXVlBucnpOVXJy?=
 =?utf-8?B?Yk1sc2M3NytSTUNwVzhLQUlSbDhLY2IwUnhuMnJGeU02aWM4ckIwZjVPNUJp?=
 =?utf-8?B?eWNZc1lHbXhHRElFUWtYekdvSGUxMTVaR0xtRm5JcE5XRDA4UEYvUW4rUERx?=
 =?utf-8?B?SUdWcmx3aTdHOVhZOUNYQ01yY3Zhd0xRdU9URXluZEJOa0d0ZDIyOGhLcyty?=
 =?utf-8?B?MS9lZk01WnRnY2RzNEFRY1NFZUYxWHJKYXcxTkYwYXd6ZVhPU3YzUlhwUDNL?=
 =?utf-8?B?WWNMWm5pOVVodkJjNUNiR1hlSnFOaHRsQklVUGdQUUpBTDE5ZU9FODVlV3Ra?=
 =?utf-8?B?REhRQ0U0OUlzcUFtdk5MaVFPM3JscUx3eTlvWlVyQU9ST3N6Y1BZRFdEcmhU?=
 =?utf-8?B?c1dXWjJHTGc3cDJKVlU3Z3ZlVElTV0gxNjJrdzc2VlBiMnJ1SDJFVWh2a3hK?=
 =?utf-8?B?bkdBSzVPZGEvRXVHQ2hoNUxoNm85UDl0TUlwQlA4MytiUGNBTXJEcDJNTkdi?=
 =?utf-8?B?ODI1M1BBOGpTTkpjdjhpeGNFM2w0T281N1Y3Z3QzQU55c09wd01pOEJKNm54?=
 =?utf-8?B?TVJOVVNlQnB3Ty9TWVQrNTNRcVEwektIbWJFN1dsZ2h4dlVOOVRYTnQ3QUJK?=
 =?utf-8?B?c2tYVmJSaHh2bURDeFNDNmhvVlhrTndyc0FqT1daM3NEeFZrVkxaamZOcHpI?=
 =?utf-8?B?K2d3NzFMdFJxK3BMYWtnZ2w4TmV4OW9oUFpqL3ZmWTdzZXlWSE5ydGhQK0po?=
 =?utf-8?B?Q0gwQzJpUlhTNURIMHVMbTdaTTJPYjRyN21FV05yOEgvTjFIajYzUzBEYnp5?=
 =?utf-8?B?ZDQ2VmZxekVBSTVuKzhjNXBnUU1CcDRkdUJLN1orWnRtQkk2VFVlZEFPRGJy?=
 =?utf-8?B?dlNhTkhnWWZwNUdzR3VZTDd2Sm56aEFpT1RydnNMQ2FTcW4veWFwbXlnbEdw?=
 =?utf-8?B?b01ZckVIK09rdnJJNGx2aHFoa1UyYjdYSzV4ZEJrcFBUOG9tbnE1SGJNeXA3?=
 =?utf-8?B?N0hyeTY2YVFNR3UrRVB0RmFoeGRTOHl6WFd4bXFrWTYwYUJnd0dCaHJkY2Yx?=
 =?utf-8?B?dFVZbXhrQzNhU3FrNzNvMlVMeUMvYnZ0MUxRYVlMVzR4Ujl4dTNySjF2NUoy?=
 =?utf-8?B?SEpMN3FGdktoSSsyNk5NOUxyRC9CeUlIOW5OWHVxeFJJU2NJNGlmM2J3Y2xp?=
 =?utf-8?B?V20vd3d3UWhSWnFEZXZVbHZsdGtibWEzTEp6dFBiSUhrL2RvaWQ0cDh0QXZ0?=
 =?utf-8?B?bUpSejA4N3dlSmdVS292SE44OWkyK2Vqd21lNWhnNGFvSkRDMm5DZ3dQVDRD?=
 =?utf-8?B?bm1RV1BnSUhMU1VYQ3diTDVXZmtmam9lQ3p3M1IvcUN2MXV2Wi9MeHZ2dGR5?=
 =?utf-8?B?SGpTTEdxa1RNSVNQR1BKZjlMdHFHR1J5RS9kdENjZmw0bmVHL2YraVA1Y2Vt?=
 =?utf-8?B?V0FXb0czMXpXRk5zdnVRVk40QjRLTWw0MmYyTjduZUtlQ0NlUFNLZzU0V2li?=
 =?utf-8?B?TUNXT2RraVdoVm9LT2dXSVNwSXNtSHNmYzE0T0tZVWo2R3M0Tm0wTElxazIr?=
 =?utf-8?B?d3dONGVUaG1IMWJ5QUx5TnpNaEFSdFI4dkpqMVgweExpOTc3eWdoM3J5eGg5?=
 =?utf-8?Q?mwcvMobRCQhJS3BBHrgw+Xw1d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a124a81-2354-4491-be9c-08dbce8fb794
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 21:34:46.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S04qjeQckSHBHipOC/n0r4fKJaTtGYwTiDCjzjHLakU7q55aaX0H6gg0Yfvxq+Nm0fighZfdUpMtqjkSaRWdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/15/2023 21:11, Kai-Heng Feng wrote:
> Hi Mario,
> 
> On Tue, Oct 10, 2023 at 6:57 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> The default kernel policy will allow modern machines to effectively put
>> all PCIe bridges into PCI D3. This policy doesn't match what Windows uses.
>>
>> In Windows the driver stack includes a "Power Engine Plugin" (uPEP driver)
>> to decide the policy for integrated devices using PEP device constraints.
>>
>> Device constraints are expressed as a number in the _DSM of the PNP0D80
>> device and exported by the kernel in acpi_get_lps0_constraint().
>>
>> Add support for SoCs to use constraints on Linux as well for deciding
>> target state for integrated PCI bridges.
>>
>> No SoCs are introduced by default with this change, they will be added
>> later on a case by case basis.
>>
>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/platform/x86/amd/pmc/pmc.c | 59 ++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
>> index c1e788b67a74..34e76c6b3fb2 100644
>> --- a/drivers/platform/x86/amd/pmc/pmc.c
>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
>> @@ -570,6 +570,14 @@ static void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
>>          debugfs_remove_recursive(dev->dbgfs_dir);
>>   }
>>
>> +static bool amd_pmc_use_acpi_constraints(struct amd_pmc_dev *dev)
>> +{
>> +       switch (dev->cpu_id) {
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>>   static bool amd_pmc_is_stb_supported(struct amd_pmc_dev *dev)
>>   {
>>          switch (dev->cpu_id) {
>> @@ -741,6 +749,41 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>>          return 0;
>>   }
>>
>> +/*
>> + * Constraints are specified in the ACPI LPS0 device and specify what the
>> + * platform intended for the device.
>> + *
>> + * If a constraint is present and >= to ACPI_STATE_S3, then enable D3 for the
>> + * device.
>> + * If a constraint is not present or < ACPI_STATE_S3, then disable D3 for the
>> + * device.
>> + */
>> +static enum bridge_d3_pref amd_pmc_d3_check(struct pci_dev *pci_dev)
>> +{
>> +       struct acpi_device *adev = ACPI_COMPANION(&pci_dev->dev);
>> +       int constraint;
>> +
>> +       if (!adev)
>> +               return BRIDGE_PREF_UNSET;
>> +
>> +       constraint = acpi_get_lps0_constraint(adev);
>> +       dev_dbg(&pci_dev->dev, "constraint is %d\n", constraint);
>> +
>> +       switch (constraint) {
>> +       case ACPI_STATE_UNKNOWN:
>> +       case ACPI_STATE_S0:
>> +       case ACPI_STATE_S1:
>> +       case ACPI_STATE_S2:
> 
> I believe it's a typo?
> I think ACPI_STATE_Dx should be used for device state.

Yes; typo thanks.

> 
>> +               return BRIDGE_PREF_DRIVER_D0;
>> +       case ACPI_STATE_S3:
>> +               return BRIDGE_PREF_DRIVER_D3;
> 
> I've seen both 3 (i.e. ACPI_STATE_D3_HOT) and 4 (i.e.
> ACPI_STATE_D3_COLD) defined in LPI constraint table.
> Should those two be treated differently?

Was this AMD system or Intel system?  AFAIK AMD doesn't use D3cold in 
constraints, they are collectively "D3".

> 
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return BRIDGE_PREF_UNSET;
>> +}
>> +
>>   static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>>   {
>>          struct rtc_device *rtc_device;
>> @@ -881,6 +924,11 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
>>          .restore = amd_pmc_s2idle_restore,
>>   };
>>
>> +static struct pci_d3_driver_ops amd_pmc_d3_ops = {
>> +       .check = amd_pmc_d3_check,
>> +       .priority = 50,
>> +};
>> +
>>   static int amd_pmc_suspend_handler(struct device *dev)
>>   {
>>          struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
>> @@ -1074,10 +1122,19 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>                          amd_pmc_quirks_init(dev);
>>          }
>>
>> +       if (amd_pmc_use_acpi_constraints(dev)) {
>> +               err = pci_register_driver_d3_policy_cb(&amd_pmc_d3_ops);
>> +               if (err)
>> +                       goto err_register_lps0;
>> +       }
> 
> Does this only apply to PCI? USB can have ACPI companion too.

It only applies to things in the constraints, which is only "SOC 
internal" devices.  No internal USB devices.

> 
> Kai-Heng
> 
>> +
>>          amd_pmc_dbgfs_register(dev);
>>          pm_report_max_hw_sleep(U64_MAX);
>>          return 0;
>>
>> +err_register_lps0:
>> +       if (IS_ENABLED(CONFIG_SUSPEND))
>> +               acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>>   err_pci_dev_put:
>>          pci_dev_put(rdev);
>>          return err;
>> @@ -1089,6 +1146,8 @@ static void amd_pmc_remove(struct platform_device *pdev)
>>
>>          if (IS_ENABLED(CONFIG_SUSPEND))
>>                  acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>> +       if (amd_pmc_use_acpi_constraints(dev))
>> +               pci_unregister_driver_d3_policy_cb(&amd_pmc_d3_ops);
>>          amd_pmc_dbgfs_unregister(dev);
>>          pci_dev_put(dev->rdev);
>>          mutex_destroy(&dev->lock);
>> --
>> 2.34.1
>>


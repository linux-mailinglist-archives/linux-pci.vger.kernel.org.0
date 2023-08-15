Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EA277D1E6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 20:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbjHOSci (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbjHOScL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 14:32:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1CDF;
        Tue, 15 Aug 2023 11:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6mbACqbBPYTHSR84ZDOtFCUophGBaJ0u0JNjsNGeZwA4ZS5PseMgJXrjZ6VaMVJ7H7Ej07+wT88RpSbi/8pdEF+xkhbdjNPQ0Ksv9IjafY4A9cEodBoA0LVqHF4Tuyy0pSuMQELlkR81xQKPyQhodez5Sm2uc7xZVQkWp+5TmtlMbI/J5Fq/rkHu8yfw0NWwRlyBR+eUkEVWZah1NNMDyTzY84lgtqoHaDOUf/xYZ4wntu5cYDfZbuivRt/Q9w4SZ8qzFhTMhQxEU6psqYOZ+6L9uQccHn52aiaylPKWubT7E44KqdVM2VDYJcan6TVjLKGPthzRswh76XzuxhmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoTbP64ehQAE1a16flXd7oZkoehgZ8XUCgtshi39Z/E=;
 b=WyC/SHxFfRt3ehDOv0iTuxxxlP6ammR6rh+ez+W5G22JLMPRHYkLZU0EPxzQAdKrHAD9KjQFg9116lBR68P0dhHo602hS4i/qrRhBuwaxitzsJ9xgwi2EG34ahE+g/r+bXiKIL5XpP9MZT/p9mYZF62juHkU8C8CnnZY0ltpH708ky6lNgCa/aVuI59d8syZ2YcL1rp5dl1TDgkjFP3JzJ9PUYSm1o61wIdofBXbPX/jtWlR+QnWxE38KcBlS4SDNviGe1bcV2AEMxYeF7vjnTACC2sjudP8+QCmKn/QKwAnBaHU42JCx8MAmgkr9KFnXtvPterAcUMWR5X1QzfPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoTbP64ehQAE1a16flXd7oZkoehgZ8XUCgtshi39Z/E=;
 b=h4ZxoV0LyEVYdZNt2Q/GwJoCLyphnH9ykS9y5UPezHasgfnho5DHNbybqR3j8LOC5lXprmX2DXTteC/v/hYixBeW/TSrhJN2YQMRS5l6KIynyXDpGSqO79vQ0e6svR/eWgvGRlIe2xPqFo8vmKkIV6b9Zd/nyIsIFLtrIN5K3tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:32:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:32:08 +0000
Message-ID: <88d86ba9-d21e-4284-847c-3b0d99cc2403@amd.com>
Date:   Tue, 15 Aug 2023 13:32:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/9] ACPI: Adjust #ifdef for *_lps0_dev use
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230815182832.GA233199@bhelgaas>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230815182832.GA233199@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfb7302-c9f0-4012-049e-08db9dbdee80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yd7uvdSRSk+IahmqkOtFWIyzKS/LOLf2fSbsajTF7tGjDLArSxKQUngEw+0RFT6vretyi6RIxHkYCcLbRsecYJedRIsepGgpfn7jNO9up97Zm2gwfabvOiUtsKs314Kyq4vdp/K3XVUIhRBGPP3SP+F7DUFPNB50Z+wM9G4DLWm/vuYPLkJx773V4NVBgND+6XLeh3kJH6q+qRowfzhfM7Of8b/OCrhettb/PeH4F4OWqPzt8SvUIQbhcDCWtPOv0MdJIGrbOYZIPf6tZuQCLLC3o0mTQEKlXmdaaJI2J7tk8sfVs98TcYJVzkV+QsFzbDDqvHgj+o2yMCTCP62pCscYE1rF/uQVdwt8BdVCudzsJG6tNQDyg0km5pdfjhRjcsMgk11waaovDxZAMhl0fcSbAt6hpviRXl+FC5GHePonbV/kBptHLqW/dktUQv9L4ULOBEBrLebeWCq9Rv2KcJE/sXMN1TTCEUeoDMH0/Sgk/tB6HslrDQhX/O9msJwA/wgWJBU9MNQZf8mT9EaVt3fPpwNHbpR/mYcwIIltEsxzJYWPfBAqDZrcl+lay68CFVfxbCmmbSi+0CMBB+GYVUJmI02rqGuBiLx+4A0u3l3pvwoMb8Lm63/0Z2+VJjRWxdAFxZZkTgOuQt4HOrDNHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199024)(1800799009)(186009)(478600001)(86362001)(6486002)(2616005)(36756003)(31686004)(31696002)(6506007)(66476007)(5660300002)(66556008)(316002)(66946007)(41300700001)(6916009)(53546011)(26005)(6666004)(38100700002)(83380400001)(54906003)(4326008)(2906002)(44832011)(8676002)(8936002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjI0enVRbm5JK1JlU2FoUC9haGVWWG9GK045Mm9MMDdkSWJMVSt5SWxWMXhy?=
 =?utf-8?B?c0pXVlVXMzF3amtPR0h3aVZzQ0xvbnhCTUVpaWVqUE04Nmk2TEZqaW1yVW5y?=
 =?utf-8?B?NVFraXRiTEpxbEd4VmRHQlV2TzVKUDVRS3NWalVUTE8rVlBFRmh4UE43R3M3?=
 =?utf-8?B?Vm40dFNMa0VLUS9oM1owMi9ycndqYVd4anNnRS9pRkFKajZBcmdoRWlNU04x?=
 =?utf-8?B?N0Z4VDNDVjg4Y3hBVmlhbUx2bkw5bjlwTXlSa2dyb2NIUEUxKy9NUUwzYjVr?=
 =?utf-8?B?Y2M2RUFVdzZkTnd1cHV3Z0pIUmlyeEtCVitObnZyd1BvQkVYaFRwV3kxc0Nh?=
 =?utf-8?B?RnN2RUR4NFFPZW5uYWl1ZlRTZWppRDZSZ0E2MEhycGZuQytLNFUyN2tJZ1lw?=
 =?utf-8?B?MUQ4bzB0MGg3NmpEVmw3MVNPRTcyWXR0RmszRFM2ZEZXZzFnRnIyZWVGZHo3?=
 =?utf-8?B?NVNFTFFVenRWa0N4cG9IcjBCRG9pR0NyZmNkaktkMG9jdktUYkR6U283amta?=
 =?utf-8?B?MmpEdzFSaTRZU1RSQXpJWEFWNTNnNHBpemNYYWxVSW9lWUZsbUNHVUM5VVpO?=
 =?utf-8?B?NXhTcy9EVTE5TG5QV0N2OHJTRDFGcUlNUFVJQ3JSRWRBSTJTaEZGcmo5eWo5?=
 =?utf-8?B?SWFMUXN0NHV0MXQyV2NrUlpuNlNFMDRYYTBaTzlMUXdIRVYxMUllSUxiTzBV?=
 =?utf-8?B?R243VjlCRXQxUUVwMEdDSUZ2dElEY0ZCNUZyNkZad1BxeVNvbWJQUVR6eWJU?=
 =?utf-8?B?VnhoOGpMeU1lOWV5Uko2bmdSOUZ5UVIrdm4rZHBXRTAzb1VxdlpCUi9aSkRz?=
 =?utf-8?B?aWs5WWJEYUtmVy96ZFBjY1V3eDVOM2VPS3R4K3M0SVNQQ2JRN2pDR3hYS2l1?=
 =?utf-8?B?aSs5QTBIdFVldTh2TzNIdVYybzNsRzZrR3lTRXN0eVFyQW96ZHc4T2VDaUl2?=
 =?utf-8?B?SExBQ2lhUGNaMEtVOTBiZ043Z09xUitjaENaWTA3eitoekV1NDcyNXdBSjZy?=
 =?utf-8?B?RzBhUytxR3pLVmpnM2tSWGNNT3FPd1NtZHNHWmdOVUtJYVoyajBlVUF6RFZi?=
 =?utf-8?B?TVRVZVlkMXJCd0pRMUQ1U3V5TEJzQlBuakhLWFFUTnhVMHhmVTZRRURSMFBV?=
 =?utf-8?B?MHh1czJDQzBQU2c3L2JZenJMZHFLYzN6SFQzRDl3c0k4R2l4SURKRGNlbW1x?=
 =?utf-8?B?QlgvTmViVzVRdGJpVTcxYzRKNC9YRDVsdHNEemwvbDBydS84Q25FNGJoeGxo?=
 =?utf-8?B?VTMwb2s4ZFZtNTBMV1pwRzVwZGJ0eFVmVVdlRE9rb25ab0cvMlUyWFlDc2o5?=
 =?utf-8?B?WFh5azFjTkNMTzJ6eFBsU2JrVDMzRnMrcXNGZit3V1lQUDN5NGpkd0tXc0pZ?=
 =?utf-8?B?RlRtdEYySGhkVVNTOEpEaFFZNjBDUGVLSVZiMUhIWjJkYlpqd1d1RGUyVVA3?=
 =?utf-8?B?MlhLMjRGM0ZtOWhtVXVaOXNCQWhSUlAzVGl1R2FMNC9ydlNZVnM5dkVNOW9H?=
 =?utf-8?B?WGtlYnZKL2p6SE5ZSDJYRWNjdzBOUVQ1YnFwcGZacVdjWVgvU21ubzllUlZR?=
 =?utf-8?B?ZmtuNDhyckRocWhWWnR0UE1wR000R0t4MlA5MjlhMklQMVNmbXdWckNlc2Vr?=
 =?utf-8?B?TkNoTGFFMjNyZ0hsSG1mMWYzMUUrejZyTUlWT2JGNGMwNCtEb0VFd1JFc2Vh?=
 =?utf-8?B?STN6TWJKV1BNYXhJSGwzejNGMzloYjV6Q1Nib2JDYWwvbkx0cTgwdSs4QzdI?=
 =?utf-8?B?R2w2ajdPSUZhR25VbFU1bHBmOXZseVRySlZOYzVHOEdZWGtmRFIzbUxUck1X?=
 =?utf-8?B?TlZmNTVRcCtOM1ljcFZVa0dmN3ZnV0hGZjhKYzdlaVVnWjlnKzNlbHUrVFJJ?=
 =?utf-8?B?b2lFWFpSR0NFR1VFQ0NaMmlUczVsVXVnRmVyMGVjRk5UeG5LSWpmWlVhb0NY?=
 =?utf-8?B?L1ZCLzNxT1BWNjJoWlVaT0FEaXJGUmNvQ0d0RkxCK2QyV0FFNEhJSldYTTA3?=
 =?utf-8?B?bHA0UzdKSHdlMkVIMjBMQ2lSc1VhTTNmZHk5RUNHQ1QyYTYwYi9OeXJpRXpw?=
 =?utf-8?B?U0p0S1lTZFBMYjNXQmlNbHhJN3pEZkhIdm1EVHR0Qk1vUG16RjVHdXlSNUp5?=
 =?utf-8?Q?o/ZVfJBGISwaFk6sxypX4xNME?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfb7302-c9f0-4012-049e-08db9dbdee80
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:32:08.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcS1ocRTTN6iNnyl2kxv+x2H7/Xm7fDWkgO6YqqHcglBsto455UcTkORGlKKt1LJ3jE37i5Qb1JSCbE8CgJUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/15/2023 13:28, Bjorn Helgaas wrote:
> On Wed, Aug 09, 2023 at 01:54:46PM -0500, Mario Limonciello wrote:
>> The #ifdef currently is guarded against CONFIG_X86, but these are
>> actually sleep related functions so they should be tied to
>> CONFIG_ACPI_SLEEP.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v9->v10:
>>   * split from other patches
>> ---
>>   include/linux/acpi.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 0d5277b7c6323..13a0fca3539f0 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1100,7 +1100,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
>>   
>>   acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>>   					   u32 val_a, u32 val_b);
>> -#ifdef CONFIG_X86
>> +#if defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
> 
> What's the connection to CONFIG_ACPI_SLEEP?
> 
> The acpi_register_lps0_dev() implementation in
> drivers/acpi/x86/s2idle.c is under #ifdef CONFIG_SUSPEND (and
> obviously s2idle.c is only compiled at all if CONFIG_X86).
> 
> Both callers (amd_pmc_probe() and thinkpad_acpi_module_init()) are
> under #ifdef CONFIG_SUSPEND.
> 

My thought process was that s2idle.c is from drivers/acpi/x86 and only 
can be used in the context of ACPI enabled sleep.

But I could see the argument for CONFIG_SUSPEND being stronger.  I'll 
adjust and make sure the rest of the series works with CONFIG_SUSPEND.

Thanks,

>>   struct acpi_s2idle_dev_ops {
>>   	struct list_head list_node;
>>   	void (*prepare)(void);
>> @@ -1109,7 +1109,7 @@ struct acpi_s2idle_dev_ops {
>>   };
>>   int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>>   void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>> -#endif /* CONFIG_X86 */
>> +#endif /* CONFIG_ACPI_SLEEP && CONFIG_X86 */
>>   #ifndef CONFIG_IA64
>>   void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>>   #else
>> -- 
>> 2.34.1
>>


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25572780D0C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 15:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377401AbjHRNxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377477AbjHRNxx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 09:53:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA4EFC;
        Fri, 18 Aug 2023 06:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTtSeqKGjyb4DfN9H9/+uRAjY3Pw5FqzU7YxQ4OWr4OoqozhZsIDVHwBZ41/1ZjyicmM1KGwD7as5voKt6UWQL2bEcP/wPwRcWdbd3u9SwEGQ+TsVrMZqwy5VpdDRbV+AvKJ50ePZhqY2NuKgMLh0tmSrGrULufOQKsSSnzp+kWJ0naShSFxDBSNIwasZcW/0Bpqv3mYj4cUT3iPDtfn/R6BfLO3cO5KSQLHDtfuA9KGUBRy9BhyPuF5A9wJvzfpzyEe472p3z/T1Sc/QbFL667fOHLZQ/yPWIO9fJVmTK9ybtKonmJWgsGUDB3iVemeaN3mdIDC5NIOIqap6rB76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpxpeQKfjCLAFy0Ky4cb0/4tyJHyaGTbXmCCUtEc0Vw=;
 b=WZ0NfUTjgCGxB7dZRGjsbWeqikXorNgjwGH6WkEXiEKI/tvsncVNq13B7HWgmnelicmgd45ItpDHa8+3K5u43+2waLXHUSMsDBG2NexNQ1reVmWae0LWDp5VLCOKlafJGvGYdaBtBBxL+itj5eDuGPZ3MgcRp9toqFfeDHDjZnThh4XVr3YSZsJDCEALLOYcun5qHCYtucnTFepWNzCc0NraIHh/KpWcmRe7NKXOPj1DsmircTcm0ExrqhrFeUNqM4OVEfs/6b9mm2hpSNY/Lfrdn7tu78/jm2nEjzLg9kuhAqgYPcIjLxkPaIv1/ZGB0AMWhK8sXQKdptNsJ5HP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpxpeQKfjCLAFy0Ky4cb0/4tyJHyaGTbXmCCUtEc0Vw=;
 b=Qnb+kLShTvVj2o+sk0/fFdy2W1lOLJvd/lVc/EVNsndvgiLS9lSnjQXe/0FiXI57py9GXfLd4v6rhdROnFLbC1nHbiDfclfSlVO2cHcHc+OBodhPm9wzoEYUdnrtDbcqyWiGavxuiolGe2H7V49SDGjJ8MfpJC6n+5V4MpRsgTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 13:53:48 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 13:53:48 +0000
Message-ID: <ce9fcec5-8eb0-40e1-b78c-78fcc4efc737@amd.com>
Date:   Fri, 18 Aug 2023 08:53:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/12] Fix wakeup problems on some AMD platforms
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <CAJZ5v0jbhq0Wnnk7qg0--bLLNY+YEWDahiJX4yuBzE=5Q2i0NA@mail.gmail.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jbhq0Wnnk7qg0--bLLNY+YEWDahiJX4yuBzE=5Q2i0NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ccf75c-61c9-4d9a-749a-08db9ff28b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkMOYdeXzVFPKBUKfavw+iJcwWLw8lucExvVn38aC4wn/PBi8IafccImh/r7nY0fqO1QHb+e5f0Tm2bHlEKZiEqcJpI9UwPCztryP40Cgeg+ZgaRkJy9KREpCAfEM7tPGT3hU7LV73BOgMqE2ccbL5TsNWSh1D+mlup8sAqkgKNOLPOmPIekaCxMvmRkMx6dL8gTZYa0SmS++FPs4eGDCQx4mAzZGEP9tD4jRlxUqVECV45OkGK855zZ4EMIBgvNX4ToCVPy+8OQrVh9nLsr3S68/RT1VqzEjgY/uvNqKy1OmF367Rn+8bgN34dovRlDmy/zVdvSb/qkw76JHuHFgMOFwCrQhe58X0FTHCP3LWBPLzT34APrILaT9uWZ7b+dckLSHPUsfESruNjxRtcXmQd77RHVxRF4YmahvCAyWgg/Lt3/g+u93raClTBzGdq/LWpwYoirIbuwv9IuzXYzSev4GcJEk10HpD/biapaTcuILwxEMnsOi4XuH7io/ROfKZpiBxs0v5WxrveaQ3Fp9K9h6c/6+Xb32r1zLz5ebV314QKJDVamLikkwciqb8/xCMKg7SGkCWUidE6A7pfvky26eme1n2Th2I3Mwf8vqbvsJ/IhJsxeVurtmHb+Bi2hL2NUOYeHaC6oKFaJnZ0C4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(83380400001)(66556008)(6916009)(66946007)(38100700002)(316002)(54906003)(66476007)(478600001)(44832011)(2906002)(41300700001)(8676002)(4326008)(5660300002)(8936002)(53546011)(2616005)(6512007)(6666004)(6506007)(6486002)(26005)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDhkbU5KQ01mMXJOeU8vZUcyYzFBaDZXUUtZRjFiUjRHWE5panM3RHM0NW5N?=
 =?utf-8?B?LzhoVk4wTGhnYVB0MjdNL3ltV0QxeXh1dGhNcHczcG5DOWg1aktlM09PMWVM?=
 =?utf-8?B?UUxhaGt0WVBFMnBiK3kzTnBQV0tYTG51NUpoRzJ4YVhBZ0tScGVmWXkzd1ZX?=
 =?utf-8?B?YWljMVlzUUk2QnNZMVI1akJCeXRHelNSTGpGZzVZeTEzYWtaQmtkQUE0NFBT?=
 =?utf-8?B?Z1NhWUdOVUVQaGtoaDZPZktVMnRaQ3AreitwZ29MSGZEVUh3S3RkSnR1Skpk?=
 =?utf-8?B?blZEbTMzNS96Y0piN1ptdFdQOTc2MlZsQUlJNmxacE1FdVgrb2ZmOEZFV0N0?=
 =?utf-8?B?UWU2Mkw3cVNjUC9MaE8wWGRlZWpNV3BBVlIzQWgzM2U4NGZ4WFBCcGIwR3d6?=
 =?utf-8?B?c1p4R2ttbi9SSjdkT1dTdVF6SE1hMjMwVldrUlBKNzQvQzB2eU44b1psUXpD?=
 =?utf-8?B?NnJnNmFxakt1K1lBa0pLUFZhUUJuMGVJbWZRVkVjVkR4bTIzMDRZTkQvZWhP?=
 =?utf-8?B?M3hKUTU1bDQzRndUMDdOQlovbm1Cd3R1Ri94SnhlUkRDZ2JRSjNNaGN1K3Q4?=
 =?utf-8?B?RUsrUmZJb2ZQdXdmUEljNjZqTkJpSW93MC80YndoNG5TRngxR1dXWGlKRTVm?=
 =?utf-8?B?RHl3KzhMNlE2dE42SmEwVFY3T3gvRmtxVDJESlpiZitYNVpBbVZvNVMwYmkx?=
 =?utf-8?B?M2JpNGVCekNwMGthTW1JWC9WNlJPNkd6aE9WSUtlUkc5bHp5c0ZSYkN6Z0RZ?=
 =?utf-8?B?VVJYK20xVjhUWHh1SElCb3ZsVUpnekF4L2xtMVNndFl4UVJsRTZMTFBpK1NY?=
 =?utf-8?B?Sm9SdWRsU1Avc0hqOFAzSTE1N0JZY2plbmo2VmgvTW1xc0dpemIrOXR2SHVY?=
 =?utf-8?B?RzBHdXdYMmJtdEV6SnRUUWZldEpkRDlSdUlGS2N1UWdubGg5NTh3TE91aC9X?=
 =?utf-8?B?d2NCSnNHMXdLWTJnek9qTEJTWTYxb0xXalRyNWlOTGwxZnFwbk1tREVyTTFy?=
 =?utf-8?B?S2Q5dFZFSFNXODdxNXZ5am5aMmo0OHVpYWVzeFNYODBvdXg1MVp5Q0VSbEhX?=
 =?utf-8?B?WlNseHB6UHVsUDdRakYxZkhMcS90bTNGdy9LY2owUjVxemdPRDdYb2E3d1BG?=
 =?utf-8?B?RnYzV291Z0Z6RHpWTGdFejRSSW0xdytYU0RyaHZPSkprVm1LbzBLL25UUlJa?=
 =?utf-8?B?TEtOZVZYZjIzNHZQZk5PdmZGRE94T1IvN1lTSkNzUTQ2UnI3SzZYOGlQQ2xR?=
 =?utf-8?B?Y2VXV3lweEZuSUJ4UE9nVEd2ZnZBVWh3RlBvNFIyb2IrNXNxcE85aTVLcjRr?=
 =?utf-8?B?ajhmZWdvRjI2Q2p1eDZGRjBZQ0FPNmhNbnN3U0l6eEE4QjljZG9YNXNTZFBo?=
 =?utf-8?B?UlQ3Q1RIWlFxN1RRazZQR1dmdURPbkhKTlJhU21VSFlrMzU5MmRsRHpCWSt0?=
 =?utf-8?B?ZzBQN0ppM2hSTC9EWldiMzRuOUkvc1ozTFRuQ1RuM01JRUtTclhjU3hkVmFT?=
 =?utf-8?B?MDJTald3MFdubDAyanpzdjQ4V2RqOXRUSCtOajBEZllWM2UrZFFOT29IOFJn?=
 =?utf-8?B?ci9GZUYvYmxDMThWazF4TVJFaVFDcnhGelMrM1JldTRCd3o0ZC9SZTJydU51?=
 =?utf-8?B?S3VySTJtRW10dWJEVXkwYXZpcm9XNUJ2Nk9RWlpBT3ovYjFJbkVhZCtDYkM0?=
 =?utf-8?B?aksxSnRUOHBYRjVNNWJmVUZ5ZmRQVk5CSW5jYk9JQXhHeEVHeTFNcTN1YmxO?=
 =?utf-8?B?Z0lPNXpGNjFhNm9KUGtETCtvOTl1MFJGRjBZUGdUZldJeXhVWGhBWEVmUVJo?=
 =?utf-8?B?V1RrdG0zWkZ4OE5DL21nRHhHZmdTdzRJbGg1UnFEa2NqQytwbFd6YUVTWGVw?=
 =?utf-8?B?NVBnL1ZyMUxOaEtlWmE4WHMxa09jeXlrdGZWenRDUGZnOHhXM0w0TGQ0QUdY?=
 =?utf-8?B?UFlwc2Ztb0ZyeVE2V1JGc1lnd2RtN21UNlZicGQ2a3ZhM2RXSmc4cjVielVZ?=
 =?utf-8?B?a0ZMUnFQTkxBWU44UXNFZVViZ3BIUlpXdytzMmFXZlZZOVpWVGFDd253aVU5?=
 =?utf-8?B?VGtubFhxQTZ5NXp1SjlzbWhlYWE4d3FyUjBXU3lQSGx0QVU2b25jUXJSa21G?=
 =?utf-8?Q?c2c0uCV+KWlckqnfphp04a8MQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ccf75c-61c9-4d9a-749a-08db9ff28b96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:53:47.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1UKQHZj3Gt3250KuVnUUZhuqiiLJTDzvMD2JHwnsHdpgfVUfQ7BcEvUHNzWfjc9ebeuho7g7lWdoRPapDwVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/18/2023 03:06, Rafael J. Wysocki wrote:
> On Fri, Aug 18, 2023 at 7:14 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Problems have been reported on AMD laptops with suspend/resume
>> where particular root ports are put into D3 and then the system is unable
>> to resume properly.
>>
>> This is caused by the policy used by the Linux kernel to put PCIe root ports
>> into D3. This series adjusts the policy to be more conservative and only
>> put root ports into D3 if the platform has indicated that it is necessary
>> to do so.
>>
>> Andy Shevchenko (1):
>>    ACPI: x86: s2idle: Add for_each_lpi_constraint() helper
>>
>> Mario Limonciello (11):
>>    PCI: Only put Intel PCIe ports >= 2015 into D3
>>    ACPI: Add comments to clarify some #ifdef statements
>>    ACPI: Adjust #ifdef for *_lps0_dev use
>>    ACPI: x86: s2idle: Post-increment variables when getting constraints
>>    ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
>>    ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
>>    ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
>>    ACPI: x86: s2idle: Add a function to get constraints for a device
>>    PCI: ACPI: Add helper functions for converting ACPI <->PCI states
>>    PCI: ACPI: Use device constraints to opt devices into D3 support
>>    PCI: ACPI: Limit the Intel specific opt-in to D3 to 2024
> 
> I think that patches [02-08/11] can be applied before the rest of the series.
> 
> In fact, I'd like to do that and expose a forward-only branch containing them.
> 
> Then, patches [1,09-11/11] will become a separate PCI/ACPI specific
> series that should be somewhat easier to grasp.
> 
> What do you think?

Sure, this makes sense to me, but we'll still need to land it in the 
same maintainer's tree since there are new symbols.

I'll adjust for the other feedback and split it into two series.

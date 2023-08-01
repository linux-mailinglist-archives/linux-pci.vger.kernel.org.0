Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75F776A777
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 05:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjHADZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 23:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHADZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 23:25:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A31BC7;
        Mon, 31 Jul 2023 20:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDh9TPU44AErJp+lIY+yXWmlgyNXEzAyQ6QFTL6dunyZwBcFluHPlUTjrQ4eSX0ymZwCdD7LMqwI4GUQYMFYEskjhZUux4lK+M88jKdR3E+xbn8URAgDbOGL56/Eh+YgLhLEK684Mc/8P7GY1fFYDb2BH5/3OyBdau4fZh6juoMywB4ykpPT8a+VmEDFN0exjzjRTLEc1TokQFFplGC2J3F6kqrjhAV1P9nF5+jzbCJbCEtoB/NuOLoa6GpVhU62TgA4w4sR/8cMCnZLKrubFZSJOcNKWfU8me7cgysprKNzh44yfAWXx+9J1O3QxPQGUwDWx56oQBW62BVbObl81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLhZ6pmMriA5soi0BnyJ/8q2ol8zJBqp8ZJOpLm9Khw=;
 b=JfzFPNX7XGaTD96FJfvGu7wN0G+nGmjqK9QXNH1Ysjwhw2NUNMiB/VmloerAptFf8iNXu1snUJyVct/hN7iAkLF8AbqdeTU4asrJMA3CpTxc2q8KDSsUv6g0Ngsz/m6s+mcQtKhFgVc7sOLQ42JldjCm0xOi3EkjCFMborJYxZuxgy+RlFi7/rZT10EOP1fvT8O5UF4NiaxQMp5/uqRx1u4CUTgPqNtlWoDTXCNkhsBnlScLOM3ssId5WYEUvGanmQCYTXaD4eLTIdPubTeG0vU7t4ur0iWRV1qyAq46QKNHtvvcAAkbKmPukPA6OB8IeURSuP36Qo/54Hm1+u7rqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLhZ6pmMriA5soi0BnyJ/8q2ol8zJBqp8ZJOpLm9Khw=;
 b=XZ1yIj6q5WzDoC++cu+ncowoyo0SeJKbQcblr+7eQZQVidvf1tSule1B4GDwY7f+5y81Gjhn5pIXDbWIl4ZFRB3Hc41h0D0C0A4HbVOg3LWxm0a3rYLLjZBG4w0I/ONZDJYkrPpgCpaDsEgK5MP1nWEM6g3IXSJEYjNKTFF+ZL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 03:25:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 03:25:07 +0000
Message-ID: <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
Date:   Mon, 31 Jul 2023 22:25:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230711221427.GA250962@bhelgaas>
 <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
 <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
In-Reply-To: <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0059.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8f9d14-8647-4ed1-4d4e-08db923ee7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPsaFbr+8nMzTMBthf+CnVQAiygESaoLz4TiWz1Nmtfebuf0JB0Vy5uNuSMkxpBG0klVr3DiCR9tov93/ID+ReT4NWmGQn4i0YZmU3CUbuQDPaBn0tX87WClEGoSEOGodEeTk3gUaCPUde+JUGm84i1iiVxNTeTUKKAW53m4EUxowLeJtWpaZ9x39c+r98tRY2GOcQ/77jJsT9gLDmx/PWaglRyKotCpM5AWrCxYZNQu7iZXAL1n4OPhte2QtUvC3b3QFZCGv3ZkzKRIfBxo7aJUQ1despLBXGkmb8ZrsIa+sLsxkW8Vc+cqUpgZyOOB4zEksUOUFWRlG/XC4gGXUNaNuizMc/qyl566K2ica1+imivfpj0qWpnHd+F5BXhn2QdUX6eRn/hmTSiIVwYKyjs2lXyFNXkCrjVS0geRhiIg3vcgntVXADQ2o2+hAW/2LQ7wLzPxdYqPQLyNgihfwTJMgOK9A0Am+szoJF230NFQ7i8Plir9WN515RLBO27vf/Mm5L2Qj2ZghxjC5vTSLEj7UywaKSHf8powL++lP0b0FkK1MoOmKgFVUTTQPSJspglh/KrMsxo/o1DL//qvNafc4BiwyzIW8WMWLLXaHsccTFHqaM4dKOUtx/Lp48wmGQa1oxIKLM0FudR+PtzVkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(36756003)(478600001)(38100700002)(31696002)(86362001)(6512007)(6486002)(7416002)(2616005)(53546011)(186003)(8676002)(8936002)(6506007)(31686004)(5660300002)(44832011)(4326008)(2906002)(66556008)(6916009)(66946007)(66476007)(41300700001)(54906003)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmlzV0VvdUZBNmdVVnlyYml2bDlhR01ldHFXRHArUm02czgwdE9xUmo3Tjlz?=
 =?utf-8?B?amFHYnV0ZldOS0JmVjNPQjlzWmdPc21mWGhLQnU0Vi91K1I5VVhxVGtYbWpx?=
 =?utf-8?B?L2V4U3dCTXlFUm1jczQ1bGdINWdyeHNEU0M5VVZZR2p2dXdiZi9OOWNOam9v?=
 =?utf-8?B?U1d0RzNKZ1ZDRlZWWGM5cmRBVXZRODU3N1ZpTE5OTXdwaUVpVWNLNVJjOUg3?=
 =?utf-8?B?QUtMQXg1MnRwdk9iUlNJMEJMSmVPOW9iZUhqWGJHT2RIb2dzTnBkeE1hTE1L?=
 =?utf-8?B?Q2UvY3d4RFJnamtDWElTRVVBOTRnalpvZHRQTHVPY3pWWXgxWDdPWFk5SDE2?=
 =?utf-8?B?ai9XWHd6UVp3K25nZjdUQlBOenVNTlJrLzdzbXVSNVAzd09sUXNrVjBudi85?=
 =?utf-8?B?R01jYU1NSllkMzNqVWZMNzJJaUswaThsZElpalpTSlhFMEVSbUR2UHZqbDNV?=
 =?utf-8?B?aWNKYWtrS3QzK092eGNnK2M3YVlPYzJSNVFLb3ZScFo5d01odGFpSnVMWnc3?=
 =?utf-8?B?aWU4OTdNWDB0REo0TkdJdDhyN3hnbTErV25oZTIxUTVkS1JLN1RTZDJ3NnEw?=
 =?utf-8?B?Q1V1MEo2NVJkSGN4eWZlOCtkWHRmMkpITFN3Ny8yWW40SUZTZWNBcFFlY2Ix?=
 =?utf-8?B?ZitteHIvVFFuZnhyYTY5SFQ2WVRNbitOeFBJakQzTkFXMXh5S3VGWU1zaDlq?=
 =?utf-8?B?REp4aG1pd0tPblZqaUxwNS9UeVNwU2RXYzAvc0dEMDcwYjZOOTZaREtoblgw?=
 =?utf-8?B?aFRhZnkrUCtLUFJ1aERUdFE1M1FpNHJ0ZFU1c2x6TU9rNE9hMUdrSkRzbGRH?=
 =?utf-8?B?TlpVRk1MblpnM1BPTjhacWNzdjBtZ01YZFczMVBiYllyc2VhZFNWUkNabk1P?=
 =?utf-8?B?TUZ1N2VGdkdxWXJYaHlNNDBPa3pPZlBtaS9QWU5TbU0vVG05ZGJHQURNL0dx?=
 =?utf-8?B?R054MWZtSXVvc2g0cnBxMXlPa1Z4SWxzMTM3aDZ6M3VhUVpPbk5acjkySzhE?=
 =?utf-8?B?NW8rZGRyU2JIWFgrREFCM055MklMWWdhdXJHWjh0enRMU2VtemtTWUUrelpD?=
 =?utf-8?B?dWk0Z2dtTzlUKy9JSHd0d2FVUnFMaGp6djBHWUFkZXI2cnJxTVgzTlhNWEsr?=
 =?utf-8?B?Yk9lWEJ5UFBScFl6bGFkSkpkMHY1d0FHMDN1K3lpb1J2SjROajBocTFwYWwv?=
 =?utf-8?B?KzNwemhKSTZRZG5EVE1FSUhBQUVJOXhPQm5WUEtLblhiRmN6cXhyeWorbGdm?=
 =?utf-8?B?SFI0MWJHbjlSOUNnc2pKUm9xWUI3YTZVaXRYNlVpbjZYNmZtTjVPNHh4V1VT?=
 =?utf-8?B?L0p2M1daT3FkNloxaFljRkVzWVJDUW9EQ3FJdmpXMUdvang1MTAzQ2cxZ0x2?=
 =?utf-8?B?R2JjU0hpaXNGTWFrUDlOemdKRkVncFF6TU1DZnBaR1FpemUrS3I4Y1Q0VHhu?=
 =?utf-8?B?Qm5ZbUZTTWRGbVB3amE2L2lsS05Hc2toUDFLdnlERHlVQWFDa0YrTS9yQ3NK?=
 =?utf-8?B?MGIxdk9lR1QvWVBmdGpZRXpYKzU5OGpPRks0V0JZbkZxQ0N5U29LeU5iWjVi?=
 =?utf-8?B?MlRNUkxMM1dITXVlclFhb2NqSWFpeW0yZEZ4dmh2Z0JrajByUnVMakNueDhE?=
 =?utf-8?B?LzZGVEh4cGlMWDFHYUhhZGJidlltQUNoNkxlVVp1UHhUQVlRQVJFZUZOaVZk?=
 =?utf-8?B?SXRrZ2tNelNlNzAvRnAyY2htRVFiZkdkWHBadVJ4SWttNzljQk5BV0dVZ05Z?=
 =?utf-8?B?enhwTS81ZFJWNnFYRWxDeVlwVVdFNlM0YXFjSjFmdFdTQ0diM25BN1FaSEcx?=
 =?utf-8?B?aVZ2WWNLakE2cWYyWGZ1dy9ONmVRY2tVd0dpZ0FtdWN4ME5rblhhT1JQR2FZ?=
 =?utf-8?B?VFJqUjY3L2RjT1dtVlBQRFY1bjBIY3FBeTZ4L3JJT1Njc3NCUDRLdThhakNo?=
 =?utf-8?B?aGw4YWNsbnBXZXdnS0Ircm5OSjNZVUlGWkJpM2haR29jNDB0TGtiQVZ2VzQz?=
 =?utf-8?B?WjZYZGNQemdmUGtBRTU4QkpxSnptNnBBUTN4R3lrdXJnL3B6V3IrR3U4bnN3?=
 =?utf-8?B?WkpIUHBZbU5waDJvbStlTU1YRVBDN282cnBrYWZKcFR1V1pJZUtNS1pOWHdJ?=
 =?utf-8?B?TGxBdng3ZC9DNitzcWVqNTM3SXlFRU4xNFo5ck5EMlV2aE8ycmZFVE1BRmxW?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8f9d14-8647-4ed1-4d4e-08db923ee7c6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 03:25:07.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83myY+2BkOzms4Ztkp1rJXart4p67GQr/0+NRAjDSS2nWczCVABrH7p8Uex0EQJLJg4U4ldjikBjVYvbL48hFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/14/23 19:46, Limonciello, Mario wrote:
> 
> On 7/14/2023 2:17 PM, Rafael J. Wysocki wrote:
>>>> Generally speaking, pci_bridge_d3_possible() is there to prevent
>>>> bridges (and PCIe ports in particular) from being put into D3hot/cold
>>>> if there are reasons to believe that it may not work.
>>>> acpi_pci_bridge_d3() is part of that.
>>>>
>>>> Even if it returns 'true', the _SxD/_SxW check should still be applied
>>>> via pci_target_state() to determine whether or not the firmware allows
>>>> this particular bridge to go into D3hot/cold.  So arguably, the _SxW
>>>> check in acpi_pci_bridge_d3() should not be necessary and if it makes
>>>> any functional difference, there is a bug somewhere else.
>>> But only if it was power manageable would the _SxD/_SxW check be
>>> applied.  This issue is around the branch of pci_target_state() where
>>> it's not power manageable and so it uses PME or it falls back to D3hot.
>> Well, this looks like a spec interpretation difference.
>>
>> We thought that _SxD/_SxW would only be relevant for devices with ACPI
>> PM support, but the firmware people seem to think that those objects
>> are also relevant for PCI devices that don't have ACPI PM support
>> (because those devices are still power-manageable via PMCSR).  If
>> Windows agrees with that viewpoint, we'll need to adjust, but not
>> through adding _SxW checks in random places.
> I think that depends upon how you want to handle the lack of _S0W.
> 
> On these problematic devices there is no _S0W under the PCIe
> root port.  As I said; Windows puts them into D0 in this case though.
> 
> So acpi_dev_power_state_for_wake should return ACPI_STATE_UNKNOWN.
> 
> Can you suggest where you think adding a acpi_dev_power_state_for_wake() 
> does make sense?
> 
> Two areas that I think would work would be in: pci_pm_suspend_noirq() 
> (to avoid calling pci_prepare_to_sleep)
> 
> or
> 
> directly in pci_prepare_to_sleep() to check that value in lieu of 
> pci_target_state().
> 

Rafael,

Did you have any more thoughts on this?


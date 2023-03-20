Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E133C6C23FA
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 22:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCTVkF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCTVj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 17:39:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CE6C17F
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 14:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJPGa8ZqHsCZ0luEjJILG91ukB7LW432Zo5AL2J1woHSfFqGRBNUpu023RucV/WGJ+g9jeuUzbCfxYhGQzq01tMMccVSGFa8U8CxGxONYbHzQrMLrwSn7/XmwcCyqzRBUPcEECnt/bRNyMxhTaJLM5VRA3mkmt7zFf5+kAw2tjtUEChhcVu8wjq53Rno6HCY4ZyIPGMl5j0G3/pf2DDTQniNholN0VAiX4cWkGzKipu1WkUCG+ASC3hZG9buETpruL2SuH0MeSUMpr1nhRHZf0cnz+Gmynk4G49C9MwRHMAMSWTJ7Vc/KB1u74cTulb+Oheoynrpu9bpw0p6eOHDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s9ZqQLF7Fk2LOKqWOdmtcKhhb7JLkUsLYzt1Sqf0Sg=;
 b=gY/tt3TEc8YGB7qQlpoWAIG2hnzQko8V5ZyCB3hs7ikm4T1s1HmtMK8Sn8dae1nG1hynFhOPwE8vJuO2ilImfWHeUJKLwh9vnppGd8QYXQbOMGiSha9w4AUxaoEaIgWI7Rz/64GT3EAJsQCs6tIYXmzMnVnWqatV3g5BURe99UBuEOgqEM6HkxlCOKbypR421OgFzqhtSCgyJDQBY8XkxM+3o5kS1P6kqMQFGnMK078tpn9eyxE0gsuJympQ2Cm0ruvdoeCw5U11jGC+m1czWl8z2dW6yul+E68al+n7nuGZb3zHaxi0RPGtW3glzx08sphltfeyEQtjjKtAnQ/VVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1s9ZqQLF7Fk2LOKqWOdmtcKhhb7JLkUsLYzt1Sqf0Sg=;
 b=Z0AwuMTTaJN5PdyHUeUiNcVleiFTXEdftgNqmCl87zvt7wiX2JxjbQjGMfIVfwUZyIHFYncV6bzvIElNm0C16sGQ0XraFxWzF1PM+2ZdX41KEUwPfqiTL5lEIiNuL4cjNx/Svmbc04+LCIm9fxyufh+dyIeLtvB0JvKmcpz2iRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 21:37:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 21:37:20 +0000
Message-ID: <81c13f51-45ee-76da-b780-96ce636ac187@amd.com>
Date:   Mon, 20 Mar 2023 16:37:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230320213028.GA2323315@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230320213028.GA2323315@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:610:b0::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: b4731c48-d8f4-4fda-d12c-08db298b48f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayGfiLIK1BT0DNhK5SR/yq7B1978avMFdg67U0bDgMOyrbPgfOhE1reAmiUH+wjNXqcxZOOJ5+6nfJ866yg1cuZ5sfaohR5RL9G2OfXzumIqPyg/1XhqOrcsh0+ZgqEu+gqWwemVviF63S19gZPrubo2xQwY6kND2/W3o4GcFGJGKLVtOy57kxYonHr9U/k/QAixBKYsS+4YDbgXIFLdbE8O0H7YXl/mmsu/zy7VI30K+zYg+sVtT7nK6P3oBWF+z/ZLnNKBYbdHTvHmq/dg/Ehm0zTZ14WfzcOCT6fL0a/VqU21iX3Nc1wa00DRcrOSSsILGdkfAP/WBZGulSvW/Y7+i3GjpgcNK0Z8QVtNkhOBH6c4wSufRigs0XgahrJn341aT12F7vhhExghtnnhMxnPr6f5LeEac4Bf9vdiKiyvdivz4hMYi5FX5zw7+7ooROo/21l3ZIYaMJjjwExZ9BXl8g4r2jUYNjqH4NYDRrbAyztD+ejliIhS2x2OX04ejeYY6W7ByDuZ02ZHdT2LTNNHnuA8VawbwwgLCbCyNv60E3iRYHDzboKTir8qlEpBnfCaa9IGwG+3fSIKCV2aKhy8hTc3fwIsLT5DehgfvwzITdWvw/WrNEk+XgiMppXCwtUVDVL72pWRg9G5I/lUgOQbLY64FoMq7EMnPtIch12YhjNW21Nv8mwCrMPdKg6m4H+PQ/iUKILFAqqjcWyRO71uhyqB/H8eC+aNo/pSCKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199018)(2616005)(54906003)(26005)(6506007)(6666004)(6512007)(186003)(31686004)(6486002)(316002)(66946007)(66556008)(66476007)(83380400001)(4326008)(8676002)(478600001)(5660300002)(41300700001)(8936002)(2906002)(6916009)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpJVWt3cnRIVzJ5YlU5aTFYdnlodC9EL2dnY0p4SStMcEtsa3l6MTZrVWNO?=
 =?utf-8?B?bW5Fd1REVTFtUThOQ3pQalRYVCtlOTV4bE4vR2tCeWpPdmJhd3A2Tmx1VUxE?=
 =?utf-8?B?YmtSUkdQMDZ3QzAyME5Ec0cwNmp5NGVKUlVuVDZ4ZFVjaHE5R094MVV2cjNK?=
 =?utf-8?B?RittdlJRa1g1cjNObTVoZnhabllEMllBakpCV3RKeWEydkVSaDlJQ3l2S2pQ?=
 =?utf-8?B?NnQxaTdXdWhvUUVtUFVwUHlzS1o2NE9KaVYxZlduUmV4eEdqZlN4WFRVc2xZ?=
 =?utf-8?B?TndQdVVrNE9qVitLODU3RmRWWlhRY3MrL2YzV291OWt1L0JpbXVxNnpPaDh1?=
 =?utf-8?B?NTlBYjNOMUZiVkdoWXZ1aVNmVVhacTFFL1F5S0xnNTRmZHBaVlN5NXBMWmhv?=
 =?utf-8?B?VW92Mk5RZ1R4OENUMmtFYm9lYUlaSFVpaE9SMi8rYzc2MHFHS3gzVVExWlZo?=
 =?utf-8?B?QlRXb29aZCtrRWVEd3NxWlQ5Q0NjK0YzbG90YjZ2aUpHNisydDdqdU9iOEpX?=
 =?utf-8?B?S1NQWFNwVTlwTmIwSkZBVEZWc25WQWsvVi9LSTFXUmlNcFlTeC9kd01GS24y?=
 =?utf-8?B?KzNiSU9uemxkWnRKWWdhWGkvRDdISnF4b1NQM1lnMTNQMUtPQVBweWRsMUUw?=
 =?utf-8?B?S2FxWTNtQUloZjdzbVpmTlcrZGorRmFOZGpmWXU1RlR5ZXdiODFWQnhBWTNa?=
 =?utf-8?B?dnNwQk1QVlhTaW45dmR4Y1BqYUg4UEhuT1QwY2k5dTF1NlRRcDljcGJFUmFv?=
 =?utf-8?B?K1g3RjFrT1hNZ2VnM2ZEdW45ZGsyWTV2Z2tYS2ZTaWhxaURya1VPdHNEbTZC?=
 =?utf-8?B?R0tPaXp6WXVKY0tTOVFRTVV2UjZDY0RHNFc1Zmkyb01udTBiVngxRFRUZnA2?=
 =?utf-8?B?SnVCM2E1MC9PbENwUmdFRUIrMWVUbWdQT0E4TTYzeFUyd0FXL1NEeFR2dFVh?=
 =?utf-8?B?WEM0amx3ZFZxSDFvbkRDdDduUkJiVXMwOXJLQWg0dkthVEpVdUtNNDhRQ2Q0?=
 =?utf-8?B?RTQ5SUlZSCtKRXNyWlFPWUpVQXFSV3VFRXlEWHZaakhkeEIxT2JvSllLcXhF?=
 =?utf-8?B?bWl4ZjdyS1pqYVF2N2hqRUwxdVFvNVo1ZVQ5bWtqU1I2c0hIU29pS0FSWDVH?=
 =?utf-8?B?RFVUaFo2MVlwUFFXWUw0TG5EbmFGTnVvTE8zMjRva28vU2phTGlZblRvakor?=
 =?utf-8?B?MXRZekRzOTRDdi9WNzV0cisvRmZuWi9hRFdqcjE0YkxZdTIyMFo0Y1dTbTNY?=
 =?utf-8?B?Vkh0eklOcjJkLzF1MTJVeGg3TzBCamZWeTNlWTgzUGE3VVZvZWRMTHdIRHRu?=
 =?utf-8?B?dVh6NXhPVGNvUmszTWdNZ2VyOEV6R2dhS3FPMHVwZHpzeEVwcGZlaStOc2xT?=
 =?utf-8?B?aTJRZC8xWWVKOW14dk55ZUpwSWRtbUtNTmhrSUlPUVJuN1RUTkFFSktzVHY3?=
 =?utf-8?B?K1JlNEpPak1ZZ1VRaWZmbG4yaFBaaUkyNEJFb2E0QXBHZC9CbnU5Mld4eXli?=
 =?utf-8?B?SjVVdy9hTG9Jck52K2JNalBRdmtlTitJWkJZL0JzbnA0dnhRR0VuQ1F0c21F?=
 =?utf-8?B?cnJaT2lwckJmM0ZsdHlrVWJZRm1xZENNa25nczQ4bXBsNVJyT3U0RlIrWGpr?=
 =?utf-8?B?OFVsVElIUjV3UFRjcUpyclVHSkFaTTR1T1IzekNmWGhoWnJoY1ZDM1g2WG13?=
 =?utf-8?B?b2lTZ2ZrdWFkcXduTGU1bW5KRTJIdGxWai9xaU1nV0M5QUZjdDFFV2g0KzY1?=
 =?utf-8?B?bXpLQ2E5U0YyOXV3REYwWUN1VWlXS0FlWHQ2NXcxQVgwcTVWeWZDamZSNjBy?=
 =?utf-8?B?bjVsdUFVUnd0TTNvZUpndzJ2M2ZHM0RMSmpqS2NoMmVyWCsvZ1NTUzI4VVZ2?=
 =?utf-8?B?UnpzYVUyMDBEaTdJaDB4OHg1dHl0bWtNVEc3QitJS3IzNTVrUmswTEJadWhS?=
 =?utf-8?B?QVpUcXRHSmhvTmExRDFpd2VHZU1wQm91azBncUdDNjRMVXUrNTkyZjd3RHNv?=
 =?utf-8?B?Y3d1REsxeC95S08vc1V2RzlSWms1bzYyeTNmK01LR0NuWThvL2VsK0V5MjBt?=
 =?utf-8?B?Z3hjR3FFTngwTWhwc2YxSHNhNlcxcUphM21ROVhyeVRwZU56Z2FGWUNYREF6?=
 =?utf-8?Q?T/3ij5JqdsKGal3dCcg8xDvpM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4731c48-d8f4-4fda-d12c-08db298b48f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 21:37:20.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNbvfi1NwArgwH5Wk4cr6qBkk0xh2kcovlczCJ9JJDEBJ5vnt1q+4F7cLQeRKn3zLLWUFuspE7fOWmmrf6zpWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>> When I say "BIOS" I mean collectively "all" of this firmware.
> 
> I don't understand the point you're making here.  I don't think it
> matters whether this device-specific knowledge is in APU
> microcontroller firmware, BIOS, Linux, etc.
> 
> I'm trying to suggest that if we zoom all the way in and look just at
> the PCIe TLPs, we would see two config writes that put the device in
> D3hot, then back in D0.  A working device should end up either back in
> D0active with MSI-X fully enabled (if No_Soft_Reset is set and MSI-X
> was originally enabled), or in D0uninitialized (if No_Soft_Reset is
> clear).
> 
> But with this device, apparently some additional software intervention
> is required, i.e., after the config write to go back to D0, we need
> two more writes to clear and set the MSI-X enable bit.

My point is that's only needed if the hardware wasn't initialized 
correctly.  If it's initialized properly then it behaves like you expect.

> 
> Let's say somebody runs coreboot on this platform.  Does coreboot need
> this device-specific knowledge?
> 

Yes; the exact same bug will happen with a coreboot implementation that 
had the initialization done improperly.


>>> If we need device-specific code in BIOS or Linux, I'd say
>>> that's a workaround.
>>
>> Something I'd like to point out in case it wasn't apparent is Windows
>> doesn't actually hit this problem.  It doesn't matter if the correct
>> hardware initialization code is included in "BIOS" or not.
> 
> That's interesting because it means there's something we (I, at least)
> don't understand about what's going on here.  Maybe Windows never puts
> the device in D3hot at runtime?  Or maybe Windows disables MSI-X
> before putting it into D3 and re-enables it after going to D0?  I
> don't know how Windows power management works, so I'm not sure this
> tells us anything useful about Linux.

Windows does put it into D3hot at runtime when nothing is plugged in, 
just like Linux does.

I believe you're right the difference is that Windows turns off MSI-X 
before putting it into D3 and re-enables it after going to D0.  So this 
behavior doesn't happen there.

Basavaraj - can you please confirm that?

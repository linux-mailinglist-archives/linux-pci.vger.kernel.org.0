Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B106B379D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 08:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCJHoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 02:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCJHoJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 02:44:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9C6FFF9
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 23:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3nVXv6GgBgLRg/edD5K2e5Otd0Uj/m3JgEFDY3Gfmm1jsabQlJoJ1ANECRqIrKOXp3ECFPPoqzZSjZwJJofczbngEiGrqNCM3jKYjlBKKWyKWZE78OGYuStGigVM3qJt0H20E5LLC8oM8TLR99+/B4iXjCl1zKCFu82EUS8CpwQmHUR+hHWWu9efTHcHEmSz56QQVfguz9uzndaP/QTXYlzzoPNolHD5ZAABPAYKNshMqq1YnUIQq2q+2ad/hzkgIV3ZsEy0Nnil1g9BPZeUFnMVjYlCVa6RI/5PSv4bbZWd4//szPZejc8Kfxc122fH32FhaINIFEN7tS3L43KbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM5TPZOsfVXwUHCjKaAOdBXTa3BpLJlO9/UfF2Hb2i0=;
 b=Z+M/8uq8sbRkQEq2FEOmemsC5U/OUUooOZTeytaWubjNWiahtWTuDBP/n87WtyIyVO+PfS9sKvwy7Xi7+eNyefSBwQFYgwjOmFR/j+D3v054YpeehAfvtvkxNEKCW//ziDj4uRddPxC4RzNdg1yNxrR2OV80KIV6wDeFQFH0vg2u/KTvf1NcY/1/SJrXb/1L3NaZ/gMOyDah69jyd83ln08NIRIFoNOTjrtdOMu2HeASG+wi/cjIqQE1VU/ZcerZeb482mX3lM0Pp12Wqs0TOFuVEXj2O7sr3G+t4E94m2jD9sVWqoksY/o+k6jxQnIouKdjQyArhUYL1C1un4ZtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM5TPZOsfVXwUHCjKaAOdBXTa3BpLJlO9/UfF2Hb2i0=;
 b=2icFh0G3rApVJtk+vsIHk0Vx2TP3uw6O8F0DIhzCejgP6DkIZNggbZu6aIWU3lfTEdv3XbWFjb/sqiiB1PdXVUP/3ftOzlNoSdL8gZ/NN9QMPquvYPQZMJ7rB0h5OHM1vcb2AMBk5taTaIpnOio9aQmMeEYPk6ZlITJh5UrG57U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 07:41:52 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::3ac0:104f:8959:a7fc]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::3ac0:104f:8959:a7fc%6]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 07:41:52 +0000
Message-ID: <ddbbfb50-24b6-202f-7452-c8959901c739@amd.com>
Date:   Fri, 10 Mar 2023 13:11:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
References: <20230309223051.GA1178661@bhelgaas>
 <0e1bd2cd-ea0e-7f2f-3d4a-62e9dea892b8@amd.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <0e1bd2cd-ea0e-7f2f-3d4a-62e9dea892b8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 149b5f56-47eb-4a10-2ebb-08db213aea13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tqLMM1Fvx3MztOYN4HF8NfZ0HF9qPlxImHj/CXZjDMu0RNUecoUshS9ZWakGEkTGxQpI8X2/DsqSGJPdvTXZ4z7VmPvGsYj9lttwODPOSWai5ImNFUS/SIa4Kiwzzf0KR6ag6TKwsuQhq7zDqIQX5rPHZkcPr5J0GFth/cz3ajMDkUzpWgWUfH1zk4uGJz1LUMtJ0lmDWZIwOQNQ3BVeX5Pc+LFytHRC+H6qic16O7njce+EdzZNo8SxlWbdyG8S7X1I89nlKbm82urjeH/Nm3+ZaiF/U57M+xoLYzG8tUAkcIxy3rkKNP1CAZpnxH2VkAlDItwNfCZLrMtNCDjQXLsqvbnyK50b7GTVi+XUgymgJmflYXNgwI5wEl6FZ+zJnA5H9KSHdTwvvNxyTFXjE7tJobU4ebarrswkVZqAi6du/PhiHu3F5ktGfwNruGfUOTYjHTl32k29SrCaUYlDU+9nrV/ItF4PcKvypk22HJaLm908PY6L6zgEeUVkRT302p6JG7nvOSedqMCWMzoBIO5xcTfereudAfcdn7M/G/oGMAcPqVZclP6lhncyiPZefXQtVNUuQCdKN7/qMcoM05Zh0+XjeJnMMhqh4tvg08Y+0i5CJ8zfpjs0Bchj1P5sr6KfssuHsMfOB5XrXp4PjuVOwu0sdLYrxNsowfibhNGbP1UE/3t/0mjM3Gjq/tr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(36756003)(110136005)(54906003)(478600001)(41300700001)(966005)(6486002)(316002)(4326008)(5660300002)(8936002)(2906002)(8676002)(66476007)(66556008)(66946007)(6506007)(26005)(38100700002)(31696002)(6666004)(186003)(2616005)(53546011)(6512007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0R4M2pjSkY1cDJZeEN2eFBTM1JrRmZ5ZWE4ME1vVldPQVVjbDBmSnJCeWx5?=
 =?utf-8?B?aFQ0Ni9vRk1DQjcwY1htNmU0ZjRyUmp4MXowYkFYMTF6NVBiN0RGRkozNnNh?=
 =?utf-8?B?RC92cDFyVitXVTd1ajcyL0hxdlljbkxkUE85Y1lnaE8rZzVpOEJjcStWOWEr?=
 =?utf-8?B?SmxYR1pmN0R4YktSQW9FL0F3MWxtbTJjSTZzYjdnN2hFeUJBYy94blVqL2Vs?=
 =?utf-8?B?VW1FcjJhTzlLMHU3eHh1N2FMVDBSVFlpRlVDTmdVZlV3bUs4d2tLempGWFBn?=
 =?utf-8?B?a0VnT2xsc1lxRTN6SmczQmQwemZoV2d1eUpma3RNbjlGR1hGb0t6WEcrdlZZ?=
 =?utf-8?B?SVRjNlQyeU82Z01QMUlpUzFqa3p1b1JyV1M5d1I2a1pIdG5XNCthNndCNlJx?=
 =?utf-8?B?NlZpZDk5Qk5obHN5bDM1dXFzSU5aQmkrdGdDSXcwQ1ZDM0lmd1gxZ0ZmYTM2?=
 =?utf-8?B?Q0hEV01YTXY0eHoycW9xcW8rYlJ1cnB4OFFBZFlQM1NzdVJuTUJkUWdZRHhN?=
 =?utf-8?B?WGtIZ2JURkFYcXJNWXpLRmhYeW1wd1gwcXZuUm5JM0ZSZEhyNWNIVjkra042?=
 =?utf-8?B?eFZtNzQxSUUxakEvRGRrVm82SkVaSVpjNWEzbUE5WVZqWDYxbjVnc2xiUEZz?=
 =?utf-8?B?bEhWbXhpZGFZS210S0hjS0RGWURLOTh1ZmdYU29SeHM1UzRwcXczcFEwbzhG?=
 =?utf-8?B?cko0UlVKS004ZUtYQmhrMnRaS1VzNkxhbE5OK04yMnNHZHRuMjRjbEZDVUw1?=
 =?utf-8?B?aitIVTBZakRtL1FaUHdBdWI2T3lQcXBaMFl6bk5iaEhQOGk1NDgzeGJEdU0r?=
 =?utf-8?B?WXpIMjhpdWpUeW1iRy9yUXRlRjBTbzltNHI3MnBTOGxPcnNHY3hvYlBKZHhL?=
 =?utf-8?B?cUJ2elRZWFBzSDFCVUhOVEdJVk1POUVPdllFVEJrWVBlMWpFS0pLcnFPWlp6?=
 =?utf-8?B?L3lwWmdsMldaVjE4MDQvcWdUOFI5cTY3QjdkcEEzTFQ5MjQ1RjlNNHZWd3Rl?=
 =?utf-8?B?UlYxamg5UW1JVDBzZHRrK0dPL1dqN2lRc1lZZ2hJMXU2MEJBTm0xRDdsd3cz?=
 =?utf-8?B?aWxOUXhoaXNRRldHWEpEdEhSWW1USG1pSTBOV2hTY0hLSGlRZHpvT0oxR1RP?=
 =?utf-8?B?NU5CTGx1THNPNEJveGhYdkc2TGpQRy93c0ZRL25pRDk0bkVqdHRlNkQ3dFpt?=
 =?utf-8?B?Uzh6L3VSdDJCMUdaWEl0YmtEQXpNc2c5eWxDVlhoakpDM3FEempUUXBhMlly?=
 =?utf-8?B?YmQzQyt5cDBkZUVrckFSLzdta2JXYlA2d2tMSUF2VGIvb0FrT2U0TU85bEhm?=
 =?utf-8?B?RERxWWlSMG1CWW1hanE1UVlqYmJYMXhBSldiK0gvOEhIM2RRUmZYcFVvdHJ2?=
 =?utf-8?B?Wk5hckVNU2hHdTNUanNXNElZb1pLbk9Iay9nZFhIa3BmWWo1Z0o2ZTg4V1Bn?=
 =?utf-8?B?dzVIaDNyYUE1cFEzZCtVNEUxaTVzWUpqaUM1ZDNhV1lBRHRZQVpsTXRYNnha?=
 =?utf-8?B?Smd6UW1YMlFEY2RvekRvLzNLK2NPUDJKRCt6ME45V1ZvMXJMdGh1Vi8vU0lo?=
 =?utf-8?B?ejVoeHY2Q2JVVlA2U014eFNkbGpLSDJQMWh5MU5hWGxqUEVPSlR4NmhhelVu?=
 =?utf-8?B?eHlnTkIvZGhBMnNFcUM2NXdySVZ2d0FocFR0SVJsaHNSNTRONWEyVDJhS3Vp?=
 =?utf-8?B?ekNsR2JidC9FZnNEZXVDSmVIbUFjN3p0ejBZTUhXbkRqZHVCZHpyRGRzZmdY?=
 =?utf-8?B?M2dEeTRaWGVBZFRGQTkxS0ttWHZtS2pDamx6MjJacFBzMlA5NGFxdXdxTHY2?=
 =?utf-8?B?VGN5WjF4Zko1TmFmNXl5MUwwM3Nwd0orck5ydEloUzdDa0J6KzZKUmp3Yncr?=
 =?utf-8?B?b0o2UWNQcktFVlJ4eGdJNllPcndkVU1rY2srY2FVTXZQV3NmOE1CR1NKRWhG?=
 =?utf-8?B?YmZ4MjV2aTNtMSthSGl4ZVg4QWx4OEI5Y216NE5VUm9JM0wreDBXYmJkQWYz?=
 =?utf-8?B?NzIzNWlkSGZIcmc1YVNxMzhJQzcySHFybFB2aUJTZ1U3U3ROQ3ZXaXY1VUs5?=
 =?utf-8?B?RzNtTjl6RUhaQWhvSlhxT3F2Ynk4dDY1Z1ZtM0Q3ZEVKQW5EckZWSHBFNExw?=
 =?utf-8?Q?q30KfJ3pb+jX8H8y7hAm01hn1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149b5f56-47eb-4a10-2ebb-08db213aea13
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 07:41:52.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIP6KOVRhEgty8tQjO1NJTUOPtfSrT5IkOpIGC3RtEmlaGkYNERMsGx/q/4PN4PfS4RsMwTtZ29i1H3hV+XrWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/10/2023 6:27 AM, Mario Limonciello wrote:
> On 3/9/23 16:30, Bjorn Helgaas wrote:
>> On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
>>> On 3/9/2023 12:25, Bjorn Helgaas wrote:
>>> ...
>>
>>>>>> https://gitlab.freedesktop.org/agd5f/linux/-/commit/07494a25fc8881e122c242a46b5c53e0e4403139
>>>>>>
>>>>
>>>> That nbio_v7.2.c patch and this patch don't look anything alike.  It
>>>> looks like the nbio_v7.2.c patch might run once?  Could *this* be done
>>>> once at enumeration-time, too?
>>>
>>> They don't look anything alike because they're attacking the problem
>>> from
>>> different angles.
>>
>> Why do we need different angles?
>
> The GPU driver approach only works if the GPU is enabled.  If the GPU
> could never be disabled then it alone would be sufficient.
>
>>
>>> The NBIO patch fixes the initialization value for the internal
>>> registers.
>>> This is what the BIOS "should" have done.  When the internal
>>> registers are
>>> configured properly then the behavior the kernel expects works as well.
>>>
>>> The NBIO patch will run both at amdgpu startup as well as when
>>> resuming from
>>> suspend.
>>
>> If initializing something as BIOS should have done makes the hardware
>> work correctly, isn't once enough?  Why does the NBIO patch need to
>> run at resume-time?
>
> During suspend some internal registers are in a power domain that the
> state will be lost.  These are typically restored by the BIOS to the
> values defined in initialization tables before handing control back to
> the OS.
>
>
>>
>>> This patch we're discussing treats the symptoms of the deficiency
>>> and avoids
>>> the impact.
>>> This patch runs any time the controller is runtime resumed.  So, yes
>>> it will
>>> run more frequently.  Because this patch is treating the symptoms it
>>> needs
>>> to be applied every single time the controller exits D3.
>>
>> This patch runs at *suspend*-time (DECLARE_PCI_FIXUP_SUSPEND), not
>> resume-time.
>>
>> The difference is important because with this broken BIOS, MSI-X is
>> disabled between the suspend quirk and some distant point in resume.
>> With non-broken BIOS, MSI-X remains *enabled* for at least part of
>> that period, and I don't want to have to figure out whether that
>> difference is important.
>
> I'll let Basavaraj comment on the timing here with the behavior
> workaround and sequence of events.

As replied in the previous mail, Bjron's suggestion works well and holds good so I will
change the quirk to apply in resume instead of suspend which also resolves the issue
as below i.e. restoring during resume if MSI-X is enabled works.

static void quirk_restore_msix_en(struct pci_dev *dev)
{
        u16 ctrl;

        pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
        if (!(ctrl & PCI_MSIX_FLAGS_ENABLE))
                return;

        ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
        pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
        ctrl |= PCI_MSIX_FLAGS_ENABLE;
        pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
}
DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, 0x15b8, quirk_restore_msix_en);


Will change the commit message accordingly.

I guess for the questions below we already answered.
Please let us know if you need more clarifications.


Thanks,
--
Basavaraj

>
>>
>> We have fragments of a coherent commit log, but it's not quite a
>> complete story yet.  I think so far we have:
>>
>>    - Issue affects only the 1022:15b8 USB controller (well, I guess it
>>      also affects some GPU device?)
>
> Same device.  It's just a way to access the internal registers.
>
>>    - Only a problem when BIOS doesn't initialize controller correctly
>>    - Controller claims to preserve internal state on D3hot->D0
>>      transition, but it doesn't
>>    - D0->D3hot->D0 transitions do preserve external PCI_MSIX_FLAGS
>>      state; only internal state is lost
>>    - When MSI-X is enabled and controller transitions D0->D3hot->D0,
>>      MSI-X appears enabled per PCI_MSIX_FLAGS, but is actually
>>      *disabled* because the internal state was lost
>>    - MSI-X being disabled leads to xhci_hcd command timeouts because
>>      interrupts are missed
>>    - Not possible for an enumeration-time quirk to fix the controller
>>      initialization problem (why not?)
>>    - Writing PCI_MSIX_FLAGS with a *different* value fixes the internal
>>      state; writing the same value does nothing
>>    - A suspend- or resume-time quirk can work around this, and this is
>>      safe on *all* 1022:15b8 devices regardless of whether the BIOS is
>>      broken
>>    - The same approach can't be used for both 1022:15b8 and the GPU
>>      device because ...?
>>
>> Bjorn
>


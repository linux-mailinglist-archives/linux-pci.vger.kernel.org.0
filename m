Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47836EE23
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhD2Qae (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 12:30:34 -0400
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:58391
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232004AbhD2Qad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 12:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5kg6xiVDAq3xsh+FZy5fAxuobiBT7r76iHn1eE12+CuU0advnI48GmicaBw24u5MW+TJWRQDPCSJVjjgbrrx6upwNvOWgGyU5nQqlI1J3fto6LgnKFcv0W4SFiiAGRFP7sc+euGYEjc4bO9Tp4GaTdW8k8sNrqVmKZoO3YwesBCJmw77XsKB36DGn6AFFyI7rdquy8a9LPeOrxjEq4itukhv71IlccEu5o5WKq7kFkVVgRY3Kq/hbR7hzthohMIFS3OuOWbcGl7n52t8+NBVtOlorDusEE5KKECgxCXDadf2qYKKMZjNSQqb7hOdxy7ZGfKwg4qXm7Gl00ZxI6jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BWtAvNoe1+dQgI0kWBcKinnCDcXWfo85W8x4jkrZFA=;
 b=oGguoV8njiVbBVFUjObHW5r+5/cjUD92OChhwyPCsY+wIQjX9qn+xY5SEVFKvKzTBrPutAVtCkxqSlrv6KqU/AOCnXKGyiiwhPMdxjED5C35acDStKFIVbydRfyTiCVzFPk6Gq4f2WCG+y/YURr3BbMCjLxWmWYatgY5GIeOlVvbOtahhKsnjF52r3h6VogA+nKPZf8a4a5lT3YRxRqfaUdfpZBlYaDzTF9Gs/AAe2bTb0IaVmPpplPfToRhZXp27VOGkfv53R7VthjalXtxUtBggzrWcrfed5oZSf7qoxML5hxbt2Hlv1vCdgLFLpEsNW9RQOWiQExv15IcL8P3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BWtAvNoe1+dQgI0kWBcKinnCDcXWfo85W8x4jkrZFA=;
 b=TXWfuI4GoMv2Db7R7BTrQ7BgNmmb24O1FygYa09GQZq4bsUG9POfca8rNQ3XAmSEJFJrjREh2MKqWNNiWtFN5ClIyc4w5GaNbTkfnB4X26uSRBaCjwo0P5tODPyIwfneV50sQ+EX8wVMtvEr7DXWE6KebwJcibd+WqhKFdl5pbA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 29 Apr
 2021 16:29:45 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 16:29:45 +0000
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs with
 drm_dev_enter/exit
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com,
        ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
 <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local> <YIqZZW9iFyGCyOmU@phenom.ffwll.local>
 <95935e46-408b-4fee-a7b4-691e9db4f455@amd.com>
 <e760ada9-b4a7-c6ab-18f7-0bcc1b5442c2@amd.com>
 <a0cfd25b-f9fd-5788-d2d8-331b69102622@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9c91bdae-d78c-202b-8b58-6977929f1273@amd.com>
Date:   Thu, 29 Apr 2021 12:29:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a0cfd25b-f9fd-5788-d2d8-331b69102622@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 16:29:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b976961-053e-451d-6aee-08d90b2bffe3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470ACA450E8C186666632E9925F9@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w46Wrv3Oo2jKNhp3AcO+6RSczJ1DQEAJC64H4+YLs9zBhQJ7R4KqX7Rl85ajqTxY986ZHPDT8GLe6fCw/Xiv7tpPjJ/1Mh77TJRcm3onPQyN/1BIKAXNWvymqrq9qnp3i1rhJ7nlkXWkTFxJv8ScUunvmppigCMZB0xDVKkNgvlUkwoWrrVF7plicyUEkDwgfABDcx9AZjCGFRjHCrYgdbYweo7rRFr8xvcNpXG5JT7bWKS/3O97l1FyB5Y6nIs9KLUkRylwuWSbLQf/Ls7Aor4ZPWjf/ZLg3m7fJET0nzJkxnPyBiFCUJXYWJoPOgb6J4omGgwKAe0szlwnzq8YnvdfLh1zRx3WOYvyXtH+4XLbd2Hie+e5WrPGvEKxJhz45Rr239YSAGJd0Dz71tGV17biRy8YGIZAjAxOQHqpzcsKyE63wD8xHvKUOw9iyqasR4rc+4tHOgn+n3PtRDLhtCCRXoed015LDYuolBl1UpQdu0YscH507UuVCIW9lr1BZOR4L8m0yvrh1F48AGbnTRR+fe/C8yL73tKqSCY5au30Db5gE2w6EASxhtQsxHA8NRy0/nrV3i1x3E58A382nJJ9Udu8qDgin9bbMce5nN4Ta4hmu1kezB8NST7oTvbCj3Xn5hFL5Kn0O51XZsS71I4aLUGBiM1HzU/dEMvn8ZrY/LzunX9Q4F9A27CCGumaPgC5jz/0r4UVptu/kjDjiEfr7J1bc1tr8tiBeqJmQto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39840400004)(8936002)(16526019)(86362001)(110136005)(38100700002)(478600001)(36756003)(66556008)(66476007)(53546011)(186003)(6486002)(956004)(4326008)(2616005)(8676002)(966005)(16576012)(66946007)(44832011)(2906002)(26005)(31696002)(5660300002)(316002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MmM1b3dNTGphMkxIRTk3ejFWMXUvaVlsMGRaU0ZpTmNaU044enpRN0QwWVJ0?=
 =?utf-8?B?QWVpT3U5ejNqeXBZengwVW9QTEc5Znc3QkM5ZDBKSmRncmo5UzIxWXM4YW1z?=
 =?utf-8?B?NnhNcXNrTndCbWVNM1hPZGYxV1VDNmIyVnFKaGJlR0pzbE05dGNPMENRLzZx?=
 =?utf-8?B?cEhKQWpPUmJsdUlCc1hlaFU2bVg3d2ZtUHFOT0tqeElpdVFqVWc2Z2UySGUr?=
 =?utf-8?B?Tkx2bHdPdy8xU3o5UFJ1NkozOUZwOXFEc1pFc2F0NXdNVVFYQzkwUWVlQzB0?=
 =?utf-8?B?aFJjNmpmY0JsZk1VeXgxeFB5ZG5UZ1l1UmFXektJTStmanJiZmRSSC9ndXVh?=
 =?utf-8?B?L3RjaDFUMUQ2SkFXOHJwWEF0RmV1dWgrR2cvRGhtakdBL0l3Qi9nRk1Kclgz?=
 =?utf-8?B?TC9GSUxJTjkvYmVXRmxmdG15WDZDd0M2aXhndmVkcmJvekROeUdaOWREdVY2?=
 =?utf-8?B?L0hrT3BFd2FKQXptT0JPT1p0MnE1aFdpY1N3bWdNVHh2QzdoMFplYzFGQ2M3?=
 =?utf-8?B?ajI2czVVZGozK3hVeXI5T0NKKzJnWE1QZlJFekpwODdPT1RPMzZwU1hUYmdB?=
 =?utf-8?B?QllzWUhXbkI2Mnk0RHA5OEs4eDRvZGRGekZPek5kcm5QM1NaWU1wbDk1ZXBN?=
 =?utf-8?B?REFNQU1hT3g2VDByMjZmL1AxN1YyMUEzSU9DRE0rekpKbVlyV0h3N3o4N2xn?=
 =?utf-8?B?ako1T0Vnd1JPVUp2SjJFcURCK0k1cUNWUFBXRXh0TWR6d3pmZ09jbzZaQnZO?=
 =?utf-8?B?ZENGQ2gyNVRyVHN3RnluMXBFdmYzMWtmNFh1eHkrUVBPQXE1Z0ZRZUFnOFph?=
 =?utf-8?B?SEJpOUtEdjVzeFN2UGc2bkxqYkI5Y2NaeE9vam90dUNIU1NDY0ZveXNrS1V5?=
 =?utf-8?B?OENBc1B3ZVpNaTFmeGQ3WTJQd1RxdXJnVnZJTmFFMFZsc0VDWFQzV3FKOWhw?=
 =?utf-8?B?OS9nL3hGZWNnVDJXWVpmT0JWZDcrRnpTSnUyZUp5R0FYcmEwUkljK01JZ25Y?=
 =?utf-8?B?SHQ3bExoeWR3aEhtb29RRzB1d1k2U3RJeml2N3krL010NW9oUEdOVGVHSWtL?=
 =?utf-8?B?SE94ZG1Gdk0xRTIyakIrbmdzS0xIcEtMTFVPNHBYWTlnbkZDV3B2Rk5oWEs4?=
 =?utf-8?B?Q3RFWkYrYkdaMzAyMWo4SC9OdXBSYkFLRUt0SXUyZWpsekZjMkV4MXZLd0xX?=
 =?utf-8?B?S3BIcmNSOGxRU21qcGl2OGZNbk84VzB3bnF5MzhqMzN5SGpqalIwR0xaRUtj?=
 =?utf-8?B?clpzc0VNV01vSkJ2dDM5ZlZKalEzMUxrTm1ha04zdUdqNmtiZ0VQcG01RVls?=
 =?utf-8?B?U3ExQU00WjNaRmRmUU1MSllkQ3BJNzlBbkUySnMxdkdmSzZNQzJ4SWxrcGdN?=
 =?utf-8?B?ZkRuNStsbnVCRFRxTDFwMmIvdnAxTC9YUEl2eW5aWEZMWU50dm14bTgrZlVm?=
 =?utf-8?B?U0pjdDlsTmovcnZBd2VmekVvMmJVRmJTTEpqeHNDU3ZicVkvZkFNay96VzAx?=
 =?utf-8?B?dEVhZUswWUxXdkVZRU5sdlNJcW5yZlFhcnFaUE5Dc2YyaGViNlk0SU9ESi9V?=
 =?utf-8?B?WHM2ZEJ4by9HNEdlckpSNW9YTXpSNW5pUGRzSFVtQzd4T0JXM1YzSEVJRGZU?=
 =?utf-8?B?NjR5UEMwREdhTXBIMDVQdzFueFNxenNUQTJKMDQrN0sxRUtUOUxhNUUxL085?=
 =?utf-8?B?bjZ2QTJOSVV1RHpOVkdsSWIxaXdHQzdHK1g0RDFjUXhaTW5Ud1Z6c3UwRGNZ?=
 =?utf-8?Q?ffnDLFhY4dsLVOmKs2Sjus4DQ6vAkKNsyVMgKQx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b976961-053e-451d-6aee-08d90b2bffe3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 16:29:45.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KccR35TQOZHGdMAmde5s/ykCPqGqvU9XXHs88ezcHHH1sSCxACFYjqdRDZIgoU6zA4E1qR6EY4EritpKi1iIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2021-04-29 um 12:21 p.m. schrieb Andrey Grodzovsky:
>
>
> On 2021-04-29 12:15 p.m., Felix Kuehling wrote:
>> Am 2021-04-29 um 12:04 p.m. schrieb Andrey Grodzovsky:
>>> So as I understand your preferred approach is that I scope any
>>> back_end, HW specific function with drm_dev_enter/exit because that
>>> where MMIO
>>> access takes place. But besides explicit MMIO access thorough
>>> register accessors in the HW back-end there is also indirect MMIO
>>> access
>>> taking place throughout the code in the driver because of various VRAM
>>> BOs which provide CPU access to VRAM through the VRAM BAR. This kind of
>>> access is spread all over in the driver and even in mid-layers such as
>>> TTM and not limited to HW back-end functions. It means it's much harder
>>> to spot such places to surgically scope them with drm_dev_enter/exit
>>> and
>>> also that any new such code introduced will immediately break hot
>>> unplug
>>> because the developers can't be expected to remember making their code
>>> robust to this specific use case. That why when we discussed internally
>>> what approach to take to protecting code with drm_dev_enter/exit we
>>> opted for using the widest available scope.
>>
>> VRAM can also be mapped in user mode. Is there anything preventing user
>> mode from accessing the memory after unplug? I guess the best you could
>> do is unmap it from the CPU page table and let the application segfault
>> on the next access. Or replace the mapping with a dummy page in system
>> memory?
>
> We indeed unmap but instead of letting it segfault insert dummy page on
> the next page fault. See here
> https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=drm-misc-next&id=6dde3330ffa450e2e6da4d19e2fd0bb94b66b6ce
> And I am aware that this doesn't take care of KFD user mapping.
> As you know, we had some discussions with you on this topic and it's on
> my TODO list to follow up on this to solve it for KFD too.

ROCm user mode maps VRAM BOs using render nodes. So I'd expect
ttm_bo_vm_dummy_page to work for KFD as well.

I guess we'd need something special for KFD's doorbell and MMIO (HDP
flush) mappings. Was that the discussion about the file address space?

Regards,
  Felix


>
> Andrey
>
>>
>> Regards,
>>    Felix
>>
>>
>>>
>>> Andrey

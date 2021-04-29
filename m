Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C3736EE09
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 18:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhD2QWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 12:22:32 -0400
Received: from mail-eopbgr770072.outbound.protection.outlook.com ([40.107.77.72]:50112
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232004AbhD2QWc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 12:22:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQO5E+rH1A8OYuNSTYQNMwJemZiao5ZQWyedLMkVM0rNJmRRM5FYpK8DfIyKX/aqXWDyeq5ai49N/+ZdWA12c823Wi7Dg8xwFtNMigfbQsgNqZdAywTKnJoLRcrwLrwOhQeAX9Itm6RCo90P/An17JnkDP5dTASCPhxNYfhmmQLCsWEJbhk80kmTox5tvJxN2UfqhGP1GGG/Y+EvWcbxbJcFo5GqtAK4TGSXFJ6PZqoY+KvYCIhfedMi18p1EGEqgU9i0YOvDfQkfEup+VZLT++WBM5rrgXiA91jKKxqE2qOhG3nfdAB+bARWjR6PtCQhx5jk/wbk0rku8R5+UoVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u4kwoTZkp0gQAx62plYAUc+XDs+Gy1jHax+dJPAHhk=;
 b=Yp54DoUx8YMGrAxP4J7cYkhyXZ0TNSXQTZA8HAFvE2xLKBLxLEDFECPmCZW1cT+5QtfKFxbsySrRM4vQWURueRVPxDnsWZO7CEQ9lS6tWdOj0NohGGLq5EcDUmG7C/GN8R8Oj4IXBPJOhZ2a6dYbvwmc1AqBTayuXbuzBs9b2nO7dBrCVhA62c99zeLIbVF28wpId6jTtFRrcnGzC9TafofMJyHJaMYB9GPs/LP/FiMNlEnLoofBrXwsFXt+9kygzp4C/GG0XXa/s34Ty4hBszgH2jJj+TP2kC1zPTiP8e3pnW1rZZGIdC2/nUexgnF8UqpjX3l8Ged2i9usClu/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u4kwoTZkp0gQAx62plYAUc+XDs+Gy1jHax+dJPAHhk=;
 b=0NZhXrMCzE9x+12HsJWsCCYGnW9myznIqdMswLNuocuqQpDhHA6JJcpXut7TTkCNwDWxDJCvV3Wf8Ts/9hniGMLXlH+WhnkQOiaBVzrK9Ehqt6NocTTGWzttEjMejnVi3eLGS3eHqNvSscdh2k0qLuaSaI49CyQGNICyWhQUBec=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 16:21:44 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Thu, 29 Apr 2021
 16:21:44 +0000
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs with
 drm_dev_enter/exit
To:     Felix Kuehling <felix.kuehling@amd.com>,
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
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <a0cfd25b-f9fd-5788-d2d8-331b69102622@amd.com>
Date:   Thu, 29 Apr 2021 12:21:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <e760ada9-b4a7-c6ab-18f7-0bcc1b5442c2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:497:888:9bb9:54f1]
X-ClientProxiedBy: YTOPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::25) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:497:888:9bb9:54f1] (2607:fea8:3edf:49b0:497:888:9bb9:54f1) by YTOPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 16:21:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dc37bff-3673-4ba3-3db6-08d90b2ae0f4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44160306BEA2917CF7EEF5C0EA5F9@SA0PR12MB4416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7fH41+Zi2EP5QaSF5AStZIjs+tMbCaOigzBX7awsfifi0lyt/NQND0vBUa2MkYAy4dH8TGRlGhyUnixA830xG7qujNZhWwYYyKW31C0QA/XUzRDG1kOMhw8cT+D3QiMF+qIfqKvUwB6kI34pFH/nUAhvQ2YgqYPjT2/7wwL1mn0mCwzOg0hqk+M/y0PyDAgpYof6ggaOpr8fv7Xd+ktIHkzc7HUrGrLe1zCEVpltY70r55D+YckoDV+KMdBGnRNcE3ZMb8Tym+aCYJo4KP9bNYfyEEOYqlhK2zEABkfnS/Udrlv6YmDIt22CuP0oHvkhhwGZWCig4L8X79shft01xMDPz+sZ78Yb9qmkLuRDRuhS+rPUrC1h55VpRJVswyWz18hol0nspihG4rgmHjifTtniHNXpWu+Cl5SsXvEXGcQKzmEj0vPmMmo/Htor9MQcG/yfEJzwrIYzVb/3JX4i4LZuQ4JNMWNMPMnCRLeGTIqVfCsrI3PATX+x/iICDS/XzYpQscJhnb/feChooIzyLf8fXG/K0RNaFaYaquQCN+2IkcxoBfJepWbJk1EJ5jx6izns4XFqxorUDhEQ40BF2LNNRQbxcsrh8qre2COD40qAukLcWpdPrDoUMXpTykvPx1/mxutRapzlpXyMM01rq+uHsjHcXusXxiH91BZahYrGTdeZY5FTfLdJd7WP1VstzkFveyr+n4BJBumEz85Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(396003)(346002)(376002)(366004)(31686004)(66476007)(31696002)(4326008)(86362001)(66556008)(83380400001)(6486002)(186003)(16526019)(316002)(8676002)(5660300002)(2616005)(38100700002)(2906002)(966005)(53546011)(478600001)(36756003)(66946007)(8936002)(110136005)(52116002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M29GcjR0UysydzNMRjE5dG9qQVNUeXZ3cGVlenhuTS9NcHNOMWo2dGlGVWJB?=
 =?utf-8?B?NFhTN0JpTVMxMFIzcXZSUnhxQjJUK0hFQlVReWdaVG5KdmEvb3pCcVZQWEs5?=
 =?utf-8?B?QVBwSGVmQ0Q1TXhINDFoZ0FiVCtNUFFGYlkvYVZQek1GQlhvNjBzY3FoQUtk?=
 =?utf-8?B?dHRpWE9aT3NWdmZ6Y0Mwb2tMWTVFTFJOMCt5NVVhWWRNK1dUMlpVVEpOMXhF?=
 =?utf-8?B?NmFHcExHMnhWM0taTGtRRkUraW1sazJGd01sWGwxRm0ydDlNSjNqN1VXQXFT?=
 =?utf-8?B?TWhQQUg1Zkt0aE1IVks0UHl3cnN1cWRDWE5MUllhOHRxajBoN2NPWWxBQjhh?=
 =?utf-8?B?WXgzanJTeHcyQy9qQlI2S1F5bGt6NEswNGxsUHM2M0JLWEl1RTJ3ZWdWcmpX?=
 =?utf-8?B?QmcxQWdUODNUZWdJd3N5dURCWTRkbWU1Q3VZZEZJdEh1VitJYkRUT3BIZVVR?=
 =?utf-8?B?NTFNQTZUUFhFaVlvNDVYOGdyejcrOFFJOENNN1pWNmUvQ3E1Z2U3WTJaNk9F?=
 =?utf-8?B?ZEN4R1pxOHNxQ3JjaWJjKzdOUmxNbkhnOU50em9XMFNnWGVYQzBXL2k0VlJK?=
 =?utf-8?B?OWh5K3pmVGZ2ZzQ0UzcxcXZwckVCT3BPa3JVc3hQYk5aUk5qb2V4Z0pzblJm?=
 =?utf-8?B?NDdzSElLZUtTTEttRHUzQVd3V1JEUGVQNTJ1RVpZamNVUTIrSFlmSXR6WUln?=
 =?utf-8?B?MXhRR0VVM0xEMzg5cWtTcHo0SGNJVFl2Tjc2Nk1ndGhBeEtmUkN0aGVSRTlG?=
 =?utf-8?B?QWRmMUp2OTBlMjJJYmtuTGN1MmZubU5oQVltQlRMSUowc3psTnRMcExMSEx5?=
 =?utf-8?B?LytIN2FqcnN5cWN0b25pK2d0RUppNGR6dFhiSmRkaHN2ZUFmUEZSeFBvSUJC?=
 =?utf-8?B?cFJRMWxQZktvODR6c3h1cERYTGRLb0xUSVRTWjBjL3FKNEFaUVlZZDhBOEN0?=
 =?utf-8?B?aWU3bXNyOFhiWjl5M3M2RTIvUFRiS1RqVTUwL1ZkUDdhU0FvMnhFUXp2bXhF?=
 =?utf-8?B?MUdlVUptUjNvVzB3bmQzSEh3ZEM0Ym91am9kNFRCR1pvcWhxUmpSZC91Ym03?=
 =?utf-8?B?WC9NZzRNajlsUmJ4NVFrQ0pmVC9JV2pZblp2bFJUTFVNSXUvajc5dDZac0Y4?=
 =?utf-8?B?Q1VpKzFpc1JINHBwR3N3dzZ5K0VsaTd5YlJFalhUVjVXa1Rnd2tKdm1zczlt?=
 =?utf-8?B?T1FCWlh1ZHNJVUVJMTJWY1VmVWF5eHRlYjc0am5xc1RaV1g0SWpVSzU3RndV?=
 =?utf-8?B?Vkc1Y2lqWm84dXYwSXJCYko3dVIrNGFvSHNHejZMN3BvYkI5T1Q3V2hhSGlR?=
 =?utf-8?B?ODlQVmVwYmJraHJUcWpBT1l3SVVPdEFRWEFXVVJsS3FQSmZHVnZhZ2RmRm9E?=
 =?utf-8?B?QkVNZGgwM1hEdCt3SVl6TGZFbHZJVU51Mkt0dHkzaWR0bDZyRXpHN2g0KzZQ?=
 =?utf-8?B?dHBTbVlhOGpLb3FvMlU1dUdkTlF3bTRIOUhsaktrT1NDMEx6ejA1elZJUWFB?=
 =?utf-8?B?UUxyODdZNk5VRGFEaEJHUUpoZ2paZGFrZzdGM0plakZYM2luc0ltYmpWcGx2?=
 =?utf-8?B?MmplSU40K2kzN09yR1ZwZXhpZ0ZUazY5cm01a3pZK0E1T3BmY1FobUpLdmJJ?=
 =?utf-8?B?WEM4UENDVlE2VFV2Uy9PSUFMdHI1cHljb1duTFVPZFZKdDUyTHo4eGlLa0xa?=
 =?utf-8?B?NEN4U1ZYQ3dXRW01RGVtaHEwZDdWN2lLcDhJVkxKWUltMjRvbElhbTBBbXkw?=
 =?utf-8?B?dnJtVFZHK3M5ay9FWFRwWkdsYzgrMEdRUHlZZ2xSdHF6RVlSMVhiNUdyNlJY?=
 =?utf-8?B?Yy9Rb2szeVJuRXVLNVZ5bFdsdVlEQ1ZGZ3VlSFBoNEhuS1k0WkV3ZGU3TWUw?=
 =?utf-8?Q?d02hoP5NsHZKW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc37bff-3673-4ba3-3db6-08d90b2ae0f4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 16:21:44.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XJHCwDH/Qwx4ISkWtqr5xpt2Jhy0xqRfU9hzOkFt64w4NwEeoOT/IwAPX15jd73kApHvlnUexX1umE5M++5iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-29 12:15 p.m., Felix Kuehling wrote:
> Am 2021-04-29 um 12:04 p.m. schrieb Andrey Grodzovsky:
>> So as I understand your preferred approach is that I scope any
>> back_end, HW specific function with drm_dev_enter/exit because that
>> where MMIO
>> access takes place. But besides explicit MMIO access thorough
>> register accessors in the HW back-end there is also indirect MMIO access
>> taking place throughout the code in the driver because of various VRAM
>> BOs which provide CPU access to VRAM through the VRAM BAR. This kind of
>> access is spread all over in the driver and even in mid-layers such as
>> TTM and not limited to HW back-end functions. It means it's much harder
>> to spot such places to surgically scope them with drm_dev_enter/exit and
>> also that any new such code introduced will immediately break hot unplug
>> because the developers can't be expected to remember making their code
>> robust to this specific use case. That why when we discussed internally
>> what approach to take to protecting code with drm_dev_enter/exit we
>> opted for using the widest available scope.
> 
> VRAM can also be mapped in user mode. Is there anything preventing user
> mode from accessing the memory after unplug? I guess the best you could
> do is unmap it from the CPU page table and let the application segfault
> on the next access. Or replace the mapping with a dummy page in system
> memory?

We indeed unmap but instead of letting it segfault insert dummy page on
the next page fault. See here 
https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=drm-misc-next&id=6dde3330ffa450e2e6da4d19e2fd0bb94b66b6ce
And I am aware that this doesn't take care of KFD user mapping.
As you know, we had some discussions with you on this topic and it's on
my TODO list to follow up on this to solve it for KFD too.

Andrey

> 
> Regards,
>    Felix
> 
> 
>>
>> Andrey

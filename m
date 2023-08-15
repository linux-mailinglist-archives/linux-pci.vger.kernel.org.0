Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0B77D50D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbjHOVXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 17:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHOVXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 17:23:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1055919B6;
        Tue, 15 Aug 2023 14:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3T81sRM1PvQNJi7kAQPEKb0PGV/WVA2Xqf4lWJY/QvuABAKpHPvmdFYowz2V+xXtWszj4eWaTuLvl0Vk3Ialc4JWCwVOkxfHbySSz8wS8GxxI6KicUyOnX/kAijVjhFPUYegdy5o6UxJtYI+suWEbmhuLKHDb7lKd7d0WLTyZRKxRxoDWYfMi6pFopgaW0SRECspvQng3NE4Wcyykny/N259tXL552jorvzMuythWal4xjnIZfaSD36R/NixdwTkhvNiBXLj575WsvE0Z8x1ejRS/QTBJlMGv5adDeliXXQRqS4HxqUCeJmuNBP4szBLgRIzYGpvS442IogZOgxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3bE5WntX6yPzDoJsE6t4bDSjjl3fQRFxkSHAD+o6yk=;
 b=ONu+lQpufJNcyjYvbRabajE7agBsRRGE4XTLd6Je9ubNTQKQDa/CaneOtmqAASjUuoPgRsmjZ06oPRyqDDCeVYVAiT9w3fMn8sHuqNjBUQs2SeZTGEaDzLN//WNqAaGUN1DMiHg/p2+VO/3UpOiS7PzNxyODR13jE8SSdm20YNTNmRX0qk6to/dkXB0m94m7JJGvBpzu/yyxJn/6W6k6JSJp9/+p+2BdyjZ+4TUplnEPnMen04c5pzzCjS/xw/1Kda+GmPTOqvMWrmCHzJv193601dMiuK8qcobt6Equ2U/EU8J32rKS1vLh6FaHHWAN+dmxTyi1dssCgVRvtpmRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3bE5WntX6yPzDoJsE6t4bDSjjl3fQRFxkSHAD+o6yk=;
 b=YSPvqbk1k8go6qpaXMFuZ2TLxA5YT0tYBdjRxy7SQP6C8uY9B0AN+AV+XYOAUbX0+kvXswnCGJhDSerQrQYolxc3xr4pN6lBnnrAJJkawFIa5kyPv72F9RyhJ4KlqBHjUZXbRiQBOzSYo7Y3f+JbhiRZf4R2t8FCUpyqd0bdzNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM6PR12MB5006.namprd12.prod.outlook.com (2603:10b6:5:1b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:23:02 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::54fc:703:94d8:4241]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::54fc:703:94d8:4241%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 21:23:01 +0000
Message-ID: <1c0f0e51-d1b5-b46a-2333-4b1315ba10e0@amd.com>
Date:   Tue, 15 Aug 2023 14:22:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230622063105.GA624@wunner.de>
 <d64f8de4-cac1-ccca-33fe-1fda418837e2@amd.com>
 <20230622214247.GB11993@wunner.de>
 <4599d885-219f-3ee0-f425-62746f31cc67@amd.com>
 <20230628132526.GA14276@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230628132526.GA14276@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DM6PR12MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bfe1ec-2fb2-4696-5942-08db9dd5cdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygqGGU87kkN1JWBsTyEHXHtyENDEHpIVgDcsvjlFyPj/Ej4gTl2L6OOWUF1ofjo9ooripJHgu2DwvuYkf38kwvYB8K3OFkTuNP25AmNxAUrCW3Jkaldo4IEuJTsKlgAKvDU9DzX9yfquUjqnNA//6kaROS76Sreh/Gw2in0aTqcnGA2blGm3cBzqlCwLqX1nPlozzSsMtaU4kIYiMGDEXhE0O1Baj7IwMnkjDw56WedhPsvHnFSCuuB5ftwwl/LyH9iMSiG6/b9ZNbjm/v8pcwKmBmLEHnk5vGoFREOu98tSWxXgZNGUQTE9I+IQTXKoGhwD7KVjjr6W+sP98KUDpsr5n1+wrvhifPThkimpsZR7t+CMCDLdfb5MZeOarD2/NF7C3sLq4iJBN7wh6a1ta+YBujxaKkkacMpekzsKeEmWKf/CmTjOhTBfjki1YvNDHiDQrrROB99AW9lLfdZ9cQB+MA4dpsCbgd1Uhd7Vi5YaiN1i/oqHGgiITF1tMRJquwGK5wkygv5GgBi4RKWxqCIy3eELxidp9yo3DzIgbqEnw6SFgjsxjXvoVFzMZtYIBUM8cfo+8b3sabnPDYe/XM2gCgnYZ3IGdn/27Lam/ZlA0613Wic69dfw2fTFFkrJxoiK+FI001LqErjMsrAPsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(1800799009)(186009)(451199024)(2906002)(8936002)(8676002)(4326008)(6512007)(6486002)(478600001)(86362001)(83380400001)(54906003)(6506007)(66476007)(66556008)(5660300002)(6916009)(41300700001)(316002)(66946007)(31696002)(2616005)(36756003)(31686004)(38100700002)(6666004)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJwamRBdEpmNmUwaVlLeVFqL2VBOW9IaCt1Q3lmWjM3RVBucTAveGUyUGlk?=
 =?utf-8?B?L0Z4WlB2bzF6dEcwV0hWRjhRL3JJQ2lFVDl6Z1l1S0NxcGFWQ2x2bmZuS0ZU?=
 =?utf-8?B?Z0V1bDd5K3NtN3N1Y0FPYmFGSWYrMlN3dHBoM0RSRC84M3hreUZ2YXRJSUVI?=
 =?utf-8?B?ZUdnZklEaGx1c2VCaUZkVGpmWElJQlNoUU91MFhodU1CeVplMmluUUVuS2hQ?=
 =?utf-8?B?UTZGTmFFQTRoaEUvWVg0UUR6ZEt5c1RERTZqQkZHV2YvbW14anhzQ2Vxc21t?=
 =?utf-8?B?WnliOVZDNXNoTmsxT1dZclNlaUJDU2FqTW5qb0RVNUcxQVMwd1lRamZOY2wz?=
 =?utf-8?B?MDR5bm52S1Vja0dlamV5NUx3SVJVSjNzWGJhQmlQZTk2N1JpamxycWxCcE9T?=
 =?utf-8?B?Q1NJUWdGU1M4WUtIOUh3UEZwazc2S0NrMEVOcDhrMjBZTzBGaFQ1M0U5MmMy?=
 =?utf-8?B?dzV4MWZRUEs5bGVFZUdtOWtaeVlhdHRZREhpbS9oQjdmaEhkOVFEVmFzc1Y5?=
 =?utf-8?B?REgyZWduNXBHQUhIdDlKRGNNamdqZGxCcWFEbkJNR1piTHgwVm84czdEaGJt?=
 =?utf-8?B?Y0hQUmd5RUE0enY2ZUpxcWZtU1NxSHl1VWhNcWJESjFyQWFQSnVDSVhzV2hN?=
 =?utf-8?B?TjVBMmwxejNjVU5VTWVVSTZWVkpoK2dLZ2Fid2pHYjZQZlNCMGNSK05nQklE?=
 =?utf-8?B?ODR0blpYWWZ4UzdXVGtEaEdLTExsOHNyV1B4aDNZNXQwVFpCd1c0cEc0citv?=
 =?utf-8?B?SXRMWUhZTWtEZ05SWnYwZFk5TktZcGQ5UlM3bmRrb1RKQnJlR215S0crNjNI?=
 =?utf-8?B?VXlVQ2pTN3k3cWNQR3dCK3kvbWl4TGIyUlRhSVoyUXRqcFFiVDliR2MzRjF2?=
 =?utf-8?B?UU0xNnVHbHYwWHJDdy9CMkxEZzk5Y3JTNERDenpDbnJTTmtmbUQvR3FvTlRw?=
 =?utf-8?B?aHlCSTFjZ1E5U0dtbDNVOVgrQTN2NGM5MlJxTXkvNEJwbGJia1dZTzZXd216?=
 =?utf-8?B?UFZwcWRNWndBLysxZGJhczBuRkpveFVKM0plOEFrdVplc2dVU0I4QkxaMm1P?=
 =?utf-8?B?VTEzbE5qT001SG1qWDJhOWxKSTNBUDlwWGh6SWlwUE9pbm1PYndCbWhGcU5N?=
 =?utf-8?B?UWpSa1lkWUg3dVE0Ylk3QVgybmE5NUNRTlA3U2o3WjJjVlpvNTNnd0JzaitY?=
 =?utf-8?B?ZytoT01nKzVhWWphckg3RCtLOEs0ZTFuL1poNVkrL2V5NVE3NDBzeWNVNmFS?=
 =?utf-8?B?THloVjhtNnlnNWVQWTlqenR4RlJvU0pGdTlpSjEzZ3Yyb29UUE1KNmlKWTBS?=
 =?utf-8?B?aFEzeHZhMVBpV2hKejRqam44NFlFZkJabkxPNzdpSEVmTmFmUGZIOFMzcHpC?=
 =?utf-8?B?ck1wQjQxVVBWTFY2czA4cXp1OWNDN1pCSjVNT3h1NXY4OUZtOWJjZGd0Si9q?=
 =?utf-8?B?QjhvNWpLd1ZuSzA4dHZWV0ptV2dCRVNqYm8wcXVDUHRQQXE3cXV4TDdNNU5v?=
 =?utf-8?B?Zi80U0pVUHgxa01jMFIwT0VZUEVOdkp6aWNGZU0rb3IrWTI3bmwwYjZXNmdt?=
 =?utf-8?B?SzRiUC9aUTNZZC9PRXJsd29RcUIwb2MxenIvVWhSUmhXNjFVVHYwNUZmWjNh?=
 =?utf-8?B?amRNRU1UWXhEanB3MHJFaGNoNWJVVnBMS0ErMG1Lb0toeUlEblJUSnVjNUd2?=
 =?utf-8?B?ZXEySGpMekdrS085OVMrK2FkWDRQak1SSVd0aGhrajdTZnRtdnkwU05XVzdL?=
 =?utf-8?B?NHNCZDJGcGNvR0liNEQ5SGg5QWw2ZDMyendwN0FNbkxMYy9hbUNoamIrQVZS?=
 =?utf-8?B?c2U0SEQ4MEI0UDF2WlYyaGFuc21GMlg0QmdGdWRkTmR1cjhSSTF2bUZzRDRm?=
 =?utf-8?B?TE94RHFRTlBMczlHSnBXVlNKcGgwZFo2aWhVL3dsaEpqSjdSdkxadXBBdmlR?=
 =?utf-8?B?U0pyTWVBcmdUQWJ1OEg2eERQeS9NTmJEcGNON3VteHBPQWhoT2FUQjBYNGIv?=
 =?utf-8?B?TndXZSthaFU4bklsR3hFMkNxL00rc3h1MW84QzZEaU5UY01jR1VzcjA3U3JR?=
 =?utf-8?B?UStPZ3F2Q2tkK2EvUzREUFhPQzdZbW1GbitZUDliU05GNW9mVWdSNTVPK1Y5?=
 =?utf-8?Q?2REM3fcUQnwZ02+BsHD9I4R4p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bfe1ec-2fb2-4696-5942-08db9dd5cdf1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:23:01.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D+meN/ZoG2yZSQVl0jBis3TS/akY2MRK7GANPapo4revLeaF7hsluD/FVcz0ruvsVHCIvxSJOt9iQW7RyvePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5006
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/28/2023 6:25 AM, Lukas Wunner wrote:
> On Tue, Jun 27, 2023 at 10:38:54AM -0700, Smita Koralahalli wrote:
>> Okay, I see there are no objections except for Bjorn/Jay's comments on
>>
>> "But there could be devices where AtomicOps are nominally supported but
>> untested or broken.."
>>
>> Would this be an issue?
> 
> I think you said that BIOS enables AtomicOps on certain AMD machines?
> Or did that observation only apply to 10 Bit tags?
> 
> If BIOS does enable AtomicOps, it would be interesting to know which
> logic BIOS follows, i.e. how does it determine whether to set
> AtomicOp Requester Enable on Endpoints?
> 
> It would also be interesting to know how far that BIOS has proliferated,
> i.e. how much experience with various Endpoint devices exists in the
> real world.  If it turns out that BIOS has enabled the feature for
> years on a wide range of Endpoints without any issues, I think
> that would render concerns mute that enabling it in the kernel
> might cause regressions.
> 
> I don't know why the spec says that "discovery of AtomicOp Requester
> capabilities is outside the scope of this specification".  I imagine
> it would be possible to set AtomicOp Requester Enable, then read it
> to determine whether the bit is now indeed 1 or hard-wired to 0.
> In the latter case, AtomicOp Requester capabilities can be assumed
> to be absent.  So that would be a way to make do without any other
> specific discovery of AtomicOp Requester capabilities.

Sorry for getting back to this very late.

The approach taken by our Platform FW is not as robust as how it is
handled by SW. And also they haven't come across issues for AtomicOps 
similar to 10-bit tags.

Hence, I worked on the approach of reading back the "AtomicOp Requester 
Enable" to determine whether it is indeed 1 or hard-wired to 0.

I came across two issues.

This approach did not eliminate calling pci_enable_atomic_ops_to_root() 
on all drivers as some of them enabled AtomicOp by only checking for 
32-bit and 64-bit Completion capabilities.

And, on internal review I received comments that this approach wouldn't 
help in determining the presence/absence of AtomicOps. PCIe r6.0 sec 
7.5.3.16 [1], states "AtomicOps Requester Enable is permitted to be RW 
even if no AtomicOp Requester capabilities are supported by the Endpoint 
or Root Port", thereby substantiating devices that hardwires this bit to 
'1' is also valid..

I have sent v4 considering all these constraints. Let me know what you 
think.

Thanks,
Smita

> 
> Thanks,
> 
> Lukas


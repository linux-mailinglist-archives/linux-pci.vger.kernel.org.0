Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F79740257
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjF0RjB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 13:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjF0RjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 13:39:00 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6812B;
        Tue, 27 Jun 2023 10:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzC3UrIt/7Zob+b5foZxSohhUAsoP8zDt7pWMQHRes7DjFp2UgmAKU8UPSw0GIBNDaWp3JqOrdavY9UGfhpMW8LSQLvyNZ0dkIGtCUZYILJocxQO23QC7QcaYpKk/UuQhqF2A+SF0Jkh0t7sR7GpnZKBCllZ0Z5cvOEF6Vk5gu9O+ttiLuwP8/0h/365lTMhmz33/9LauZkbrJ6zi/eKwjSHPZDkvTP7i+ckXMdjE7C3eA+t4B3QrAVkdJOmpOuhjf+vgqByznuYTXaWkkXLHS3aIDMvX4fGwltI/ddLLRdOlnXJUU2ubhUbOvpajYecBhnkggj5NhwIgkpzK+Z7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agy9EA8M/olftJ830uJdQU8FWjH7TNoBMt97e0ZRyvg=;
 b=EPXDXRbMT86nxlw7iGac/jGQAzgj4dX63WEszmtyvwo9lypLFeG69I/FxNnr12kVWvntwQ6vOSOQxzaIxIL9rhz/1VRXMBarPxyNysUko5NNypZIVlfK2PUX++o5XsZ864dms3R4ZPOTduQwvhOS4HYEHdO2qveGtvLVxKBFg3RGbwGsy4z46xf9ZE6YvOJYai05Oc+LZqqJQ8wcTnvWVFbLPBZI6JKmDcaZfyI4Zu0BGgt3oZer1Gl2N3IndnhVngE3TpVk7IrXMcMix2xuIScuTRRlhmgrXW5s0kkRCr5Dpf9uKHhOgyoEGzebLkTv1cbMFl0UDaU8eibbCQfNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agy9EA8M/olftJ830uJdQU8FWjH7TNoBMt97e0ZRyvg=;
 b=W9YpOOsbleRCnXyNUGzN1UCpCFstJAgU07KGczrM4QyLg82xtB7+vVN72bu1AeRxJv8QHLJO76DUN8UXVqzzlZBNdzfBY/2KGrk9O6q/3afbz5JX3O7Ids5DSYGxKMyOnHQwHYjd+tqcDK0XCJy/4xH0m2AbSS0T3cDCp3sfNFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 17:38:56 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 17:38:56 +0000
Message-ID: <4599d885-219f-3ee0-f425-62746f31cc67@amd.com>
Date:   Tue, 27 Jun 2023 10:38:54 -0700
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
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230622214247.GB11993@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0115.namprd07.prod.outlook.com
 (2603:10b6:510:4::30) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: c8256abc-5112-460c-3cd6-08db773561c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCBRSPF4GaJkU8w4n+j5gCDw1XtDM9T9+XCO4UewDC0/Pk32v6b4ZG58R2bTJJ1hmKYHKwNZxscEvQdclZtu7fsokkQTjvNHRADcrZWXHcIUFX7OKZdOTc8VlkDA6ZnKElceIRMDKZpnOvbqL55cjV2TwYIfvsVSZ2jDC3AHTVCE5cO+xaHnQd+Mjr11SRSjupFQvh8VNssPwSpGVE4ili+ooeNuwYsat1dz5txau5ZQfdqya+tj6EMy9tJg7VZMOCy2uvYFFvVNHqyMWY2IPZurjEB3D7VbfNYUer3kOC73mUgDFLayle71neRltEI/Kl2w+YuJoP2sAeUwUXj6dT6RoGvYfM6k09S48F5BbIGExvTcJ5Kk81rRzqVStw4S7LLidAKAoc+DVWUN9K3GYZgYKkrmCV4ZGjtGzF/KIVFJY7QFmUX3gX2Zue6i6pjXwBoQvGUdGzCySLdgNGD0/8j9MdRf65TDp6M6fH4FXZj98mfnHtenMpW2FgjNU43KQweVkYWLJSs/XF7ygypuxiM5dVohbuC6Xow58LAu5U7PRcbgL+24FKFgFUoOaivmIOFusn6tAiuaSJWAGbIqQ6hLkAdeuAgYA8c0Uw50Nfw0+6StGq1YAYRkwgY/GWYYN4ksXsq5XUUkbE33OWu2rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(36756003)(54906003)(478600001)(2616005)(26005)(186003)(53546011)(2906002)(6486002)(5660300002)(6916009)(66946007)(31696002)(38100700002)(8676002)(86362001)(316002)(4326008)(41300700001)(8936002)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBvOGUrUkRObUlNUDVVTlRXQ01RTFlhYnNjN0xqVTBpbGx0Y0Evb2JvakEv?=
 =?utf-8?B?QzNqc1g2QTJTYnloSlhObUoyZDZhTHFwZzNJZFZCT3E0MjJCUCtBY3VLSG8v?=
 =?utf-8?B?U01BT3puV0VCcnVsU1BBeUhCcmVHZll4aW5yVnlKblp5WDZpTzZZaFRCVUdz?=
 =?utf-8?B?ZVdlYmRVR29meXpVYjBFUFhhUnpQNjh4N2ZoN3FDR1RKQmVoSDlRakNFUHdw?=
 =?utf-8?B?bjl0NWV5MU5NaTlZVUZDZEZ3WmsrbHFMZk5JQnRub2R4TUwzNzFlb2FkVCtW?=
 =?utf-8?B?Mk5rSHZUakloQTBHWkV6WDZPZWpOelI1VVhJUm9NaEVnNzVlMzdKSFFPMHFY?=
 =?utf-8?B?VG91Vllta0FtWVlXZkY2NjU4YTkvNHZaM2dUV2EwcW1YSEsvbnNSUlZRU0NE?=
 =?utf-8?B?SE5sTEdxTlErQnNsaXl3dUFTYlF2c0wzUGNzZCtmVWFaREI2ZFZyeTR1VXpL?=
 =?utf-8?B?YitvdHRpVyt0RVNwUG9hTno1bCtZRVYwSWJ3aUU1MXE1Y3l6ekF5T1ZUN1Zm?=
 =?utf-8?B?RHVGM2FEbUx6ZnU2bi95VjBGUDI2N1dUNXRockJNL3pVRVE5M1BwRTYvckJl?=
 =?utf-8?B?Y3FGRVYzWmJJbklQVDErY3JDK2k2aWg4OEl5dUpYdHp3dkFVKzFPMmpIbnJy?=
 =?utf-8?B?QVNPcklGbWtCTWNrenh6OUxhK1FqUi9yRVkxME83dURhSFU2MGpXQURqSFBC?=
 =?utf-8?B?U1B1M3FYczRoa2ZUVWcyUXFBNmxLYWZzdnloT1BCbUxENWRFaWJzYXpUdTNv?=
 =?utf-8?B?eHdTTnY3VVhvSlBHM082NXIzNWxIZ1g4VG1ZcSs0YW5zemVnNEhYNnVFUlhw?=
 =?utf-8?B?MmJscGVjTHc5OHFBaVlORWJ2dS9KM2F2VURIclFSL3RKTkFPVG9LRHV1bGdu?=
 =?utf-8?B?UXhVR1ZZNXhQdUV0WE1sN1FZeGFTY2VjY092MGZwUy9VNHIwb0JjWmtwd3JU?=
 =?utf-8?B?a3BBcUd2R1NaZ1V6by9CRitCanM3Qlh0QzRub2piMUcwSWxzbXZIYnRHUVhH?=
 =?utf-8?B?VjY3ZnZnZENCMno2anVxdU9IbXJTcnA0ZEZpREVoV3E4SlIvWXVUNnhKVTBF?=
 =?utf-8?B?QnU1Ry9paElkQW5qWE9mMjNsVnYxT1hOL2R1WldDKzFnSUVxMkxGRzI3QWdz?=
 =?utf-8?B?b3UzRkY3SExTZTVCUDIxWXFPREZhZTYyU3YvdnQ1azJmaHJmaDVsYUxNMWJw?=
 =?utf-8?B?MGtYSmFiUk1lY1FjL1k1SVZhWUs4d3lZUlJFSHlmUG5Iek0wZjQzQXo0VEJu?=
 =?utf-8?B?WEo4aTZsZ0JIcEdUazJkVThrNjJFQTA0L1dQNTRPR0FPSzZhM0ptTEZsdWU1?=
 =?utf-8?B?NVVtaFBnK1ErNDF4SDRVaHZLblBoT2N4N2RuTDFPdFdJYjNkYkJNb1VTd25H?=
 =?utf-8?B?N2pUMnFWMkVZZVh1V282STlkelZQLy9PZjNyRVlkMVZDY2hEM1djN1F4YThD?=
 =?utf-8?B?ZlFIYzFIdE90QXhPMFNUY0hMcmNpYm1FeGJBS0ZiVElLUitheDdKMFNlM3ZP?=
 =?utf-8?B?eFcxMGVEdE9GaGxPdVdHd3poTWtXWkg2SGJjWmEraFI2UkNEdE0zcEM5V2JD?=
 =?utf-8?B?Wk1mRnRmcUZ1SmdldFJFOGpUV2plZlFOczM2K0Q2TytCYTRBWnA5Y0JOZWhk?=
 =?utf-8?B?dzhubkljOFFaQnZUdlVxbUZrMDJhdzV2QlZUaDdvdmpOZytUSG9OdmZ6QXJs?=
 =?utf-8?B?WVhiTmVMaVpxckNzRFRHMjFzVGpmNlNLU3hsRHdkc2w1aENla2pYQzlpUWo0?=
 =?utf-8?B?UkltblhocGxUeGUxUFRoOWxRWHF5d2dEaEJmQVV0MWYveVJxeHNWY3ptbmJL?=
 =?utf-8?B?TzFtVXMrTWZoeXc0anEwUmhZMFJoalU2N0FuNVgyOHVBY1RGR1BINjZEU1Zo?=
 =?utf-8?B?ZXlWZXdyNjZ4TEdiRll5UWtkVXhIUnJRc29MN21LTEdSRjNWVW1LREJuK0Fq?=
 =?utf-8?B?bExSaVBhSkw3NytyZ3RvZnVZR2xFR3FxNVQvN2k4RjcwdDhLWFdmRUdDeW03?=
 =?utf-8?B?d21YV2EwcWNTMVpxUzdXZmxFSUZubmdXNDlqVWsxa3ZPdWZRT2d1WWR2MHQx?=
 =?utf-8?B?MlZqN01jSGVLOTJoeFZGT1BGYkJoWlhSVENuQTkrSHFnUEZEVUt5T0hoM3N5?=
 =?utf-8?Q?8mD/VQDksSmvHiqY7BkeM0vvV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8256abc-5112-460c-3cd6-08db773561c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:38:56.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9WphixH0g2zhXSTLKIqIbXj1SOh+ueLfzxzL2jlVl9+4ZaGqEBrjA39jQ4LAX0nYenF/LKSpp5AYFIL6LNYVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/22/2023 2:42 PM, Lukas Wunner wrote:
> [cc += Jay, Felix]
> 
> On Thu, Jun 22, 2023 at 02:02:12PM -0700, Smita Koralahalli wrote:
>> Would it be fair to just reuse pci_enable_atomic_ops_to_root() for
>> Atomic_Ops configuration?
> 
> Hm, that's a good question.  I'm not an expert on that corner of
> the PCI core.
> 
> But indeed what you could try is amend that function to not only
> *set* PCI_EXP_DEVCTL2_ATOMIC_REQ if it's supported, but to also
> *clear* it if it's not supported.
> 
> And you'd have to call pci_enable_atomic_ops_to_root() on enumeration,
> e.g. from pci_init_capabilities().
> 
> That should obviate the need to call pci_enable_atomic_ops_to_root()
> from drivers, so you could probably remove the call from all the
> drivers which currently call it (amdgpu, infiniband, mellanox),
> in one separate patch per driver.
> 
> An then you could drop the EXPORT clause for pci_enable_atomic_ops_to_root()
> and make it private to the PCI core.
> 
> So that would be 5 patches (enablement/disablement on enumeration,
> amendmend of the 3 drivers, making the call private).
> 
> I'm not sure if anyone will cry foul if you do that but if you want
> to give it a try, go for it. :)

Okay, I see there are no objections except for Bjorn/Jay's comments on

"But there could be devices where AtomicOps are nominally supported but 
untested or broken.."

Would this be an issue?

If not, I will start working on those 5 patches.

Thanks,
Smita
> 
> I don't now why commit 430a23689dea, which introduced
> pci_enable_atomic_ops_to_root(), chose to add it as a library function
> which is only called from specific drivers, instead of universally
> enabling the feature for all devices.  Adding the commit authors to cc
> so they can chime in.
> 
> Thanks,
> 
> Lukas


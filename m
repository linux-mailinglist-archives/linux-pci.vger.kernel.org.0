Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8377DF78D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 17:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjKBQWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 12:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjKBQWR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 12:22:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD3E111;
        Thu,  2 Nov 2023 09:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTrze9U+OcGXmDXeUcFybSxb7CB2tfP8F5y3KPdA1HC53g8Ath36zaJ7xxe2r8nS/is8rS4iXMXRXJ+8fyt+QYdDjzYbBpL6lv2IL4qQjev+R9qQZmGfbiMSSl5At0+XIRHKFHJAMoxOCsPjR1wOWn07wjiCW3xiDuG6QsK8draczohCxllmFp/3iI0xpKLLv0tWxD2aw5+hoVgzkRtfKr4PvfZDczHKy0qIpedCGz57HL8VNviRs01Az3UuLy+wBHZYpkvquFl7VxqmnToS9Pryi/nh7lN6flfaLlcTqwoT7Eg6i5XHew2XemEtxbToSt6VboGSE9PfFj1vAvuyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ5rhoqwvhPhcz0s1QkwTaB4pRYnF3E1kJOVb+FSYM0=;
 b=ZCoUufgseOU5JyowGaKGg2OoOMLaPFYbLogjxh4W6kKINEpcRorZT2yOHGs6zGHLvyrmgMSrUbbCI55nVtEpPwJrqffGdn2Jo17DOIqb8Lhs7tPFNgDW0uaXspD+un5kbDaLNaljs1VftPiQiKmCj0SUVTnaj3N9aHDcW7BuduZiO2xIyBTtJhYJSkIYiDbmR3A0OFlh7daPh25j2htCg8bMmUgquFRzxkGujIYYkpIMujys5cNO8DkSgh4UQO43dNpv6whoR1lbHGm5ImTvny58szCOTtrYE52zVJN0d9Ps3uryFMFlqFxUPO//1UZh6RYJQ7FeKjGJA7USZLv4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ5rhoqwvhPhcz0s1QkwTaB4pRYnF3E1kJOVb+FSYM0=;
 b=0ZFnSk3mby5HHdPBtF69XU4+iVrtvns2qLY8mMmGTaLvwtcAenFwcXTho9fJBfA8cxD+ojQAQ89Mqx+Tkf5sHx5UfC9UeFj7HodbeVZSkuqT2M1bJoNQVecb4f65JxSDB8dU/oK8jpYtEMHIbMp06j9JJAJyIi55iaWJaqe0kiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 16:22:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Thu, 2 Nov 2023
 16:22:08 +0000
Message-ID: <67e7d200-52aa-44b9-8e87-e416e3d53a6c@amd.com>
Date:   Thu, 2 Nov 2023 11:22:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Alexander.Deucher@amd.com
References: <20231101225259.GA101390@bhelgaas>
 <928df647-5b20-406b-8da5-3199f5cfbb48@amd.com>
 <20231102152154.GA22270@wunner.de>
 <bb4d8fad-dced-4fed-9582-2db50643e868@amd.com>
 <20231102153345.GA30347@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231102153345.GA30347@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: fb070266-6eb1-4d15-6a1b-08dbdbbfdc1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qubG+kNAoLJdt5HaGUK6sSXCy6k+WUazWK1XwjjskxoKYb4RSzD4vF+ztc0FCUPz7htoQ42Mc7HiKuRhph5MMFw1dSGlGVbwbnLNVMFItKi36M87rOvi/h8YvODCDW5+dUlXtpJCMGuSGcGMkiTNB5w2wKjwzgxwtghzMwpPYGD6ewHJf0+FXNAtSnnzmqZfXL0y33dhZBXFrB8PWTZJ9uGhcoYZmK0unKjZ0O2cj662tC6mdisf3wfQ/y4qg5MT89cUbKSaT1mWPHaz1qm8VazqMLtUiRDybBsl+ymoSeAVVJD+kx4oyjKwDGw8ysNuoGlobKca88htZmdIgMRY6fPV3oF4xFRHoYb2+fEXJCMKFkTlarcZ0dxEDFw2iW0dS8Q7/iMgcY0y7fnMDEGyeKGhv7yPk/+/9yGPTO+NXbI/97RkEew0FjxmdjOSVVqAVXMNggQIyGORr9f3yz4IdhUhkcUML2KiCcR1O8nzTkHB9nv+Uo3yJ02y0qKNW+plkvCRG3Yi0kxcM27Amr3bfZzFYYdsMKVVVvw0i01jiBQUmpGj5UIDUOaQHSFdzeo0swPaJtNmBP0DAn739BcLuVPgerCgfcq9k7gj7z3iHsSjWkeY0emxkFHC/yDWInKjJLGX6Vjg7hWji/oFLBrHKNCSduhRDMIVCZxqHD4esG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(36756003)(31686004)(966005)(6486002)(8936002)(8676002)(4326008)(38100700002)(6512007)(26005)(6666004)(2616005)(6506007)(66476007)(66574015)(6916009)(478600001)(316002)(66946007)(53546011)(66556008)(31696002)(44832011)(2906002)(86362001)(7416002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0ZuWDg0cW1ob2FrVjBweFd1S0xnL2ZkdG9LYy81RFFCeXRVZDZ4V1VZa296?=
 =?utf-8?B?WlZmenBHamRvRnFoU2s0NzZ0TlljY2Q5bTh6ZnZ3ZWM0SkNMcVpFZTF4OHVk?=
 =?utf-8?B?UHZPRkI3RDZNMkphOEpYWm8wT0FPOTZxM1RReHRHNEkyelJKSVJBdHFrOHN1?=
 =?utf-8?B?dmVZTGExTExGQmRtUThzZVpEekU5MjBQRjRHQU9MdS9ITXZDaVNManNZMVJy?=
 =?utf-8?B?SEVpRzhSSTdsa3N5SE5Rd1Zxc1RLTkVBdThRY28yRFZhdVUzbTRKMjR2R3N2?=
 =?utf-8?B?bFY2YWVyN1FKQzBKM2JlQTdEeThldlpSRnRQWjhjc09VUGU1ZjV0TWpNVURQ?=
 =?utf-8?B?VEhUNjhlTkpPMzl3Rnl4cXZNMVk1OEZvZVk5OHc2WXBFbnYrRW5QNEp3UGFQ?=
 =?utf-8?B?TGgyQlNHZFEwZVM0d2FxWFkyaFBqZlUxblNaZ2N0a2Y1b1IvMzBXdVR2a3o3?=
 =?utf-8?B?Y1pESTVGUE15UHNtZkc5Q3hGOVB4RE5LL0UwQ0c2MExwSmt3aEdDS1h3cEtL?=
 =?utf-8?B?S0p0YWxQcU5xcTdaMVIxaFAvVlhGdzJhdUhSWnRJVlE3VFVqQzgxK1gwZklY?=
 =?utf-8?B?b3lJSEYwZlF0c1Z2cC9RWTF6b1FQS3A2ZE96Ymdyd2czVmNEVWh6b1FhUHYv?=
 =?utf-8?B?YWp2R2RFYkhjR01JVm1lK3JEZG9EKzM3Nk50R29VZ3RGUGxlYnhVTTNrTkxa?=
 =?utf-8?B?aC9VQTd2ay94SElhVUpNTFljTXFCdDhmR0Y4T1lzOVoxZFl1a0tlejFuOU05?=
 =?utf-8?B?TUpha0J2a0R0REhSbjZWYTNnbk1CNTI1eE1lbk1Sa3lqOXJsVTBRS1dGaEY3?=
 =?utf-8?B?TUFGQ3hrcTBHZWlJMWdlSGNRd1pWWkVVMHRkYjZ2STdvVzArZm9KRVhZOU56?=
 =?utf-8?B?ZnBZR2VJWktjMjlZdmN4Y1BjdTBpK1V4b2x0RTI3NzlUYngvT1htM0ZPamNz?=
 =?utf-8?B?b04yczQ1VHhaNVVvRUswYVU0VEJMaHVpMHpJcVBXMXByZzUrTmdWZGxzcVdS?=
 =?utf-8?B?K1l4YlVZNGZQQ1M0b2k4QU5hbUVjd1MyM0ZPaU1SWGJscXlWbHVFRGhtT3VH?=
 =?utf-8?B?WDdKakM3ZUtPR3FJWkFMb0t3QXRkL1BQWVFZTFo4UFFQRElwQkM2L2EvdnpE?=
 =?utf-8?B?Z3o5ODQ1dGtwVElyNzZ5ZTdDRi9wSGt5b1FNNkZWZXBYOUZzVzVhVzVBeXpj?=
 =?utf-8?B?MGhQc0pyMncwY25OaWNHU0ppR2Z2Z3JRUUVGWUtGbVE3S0tmdXR3RWc1a1VN?=
 =?utf-8?B?KzA4cmxtdGxHVzZIQWVhOUx5UnFLTmFVVlhsOG9ySTU5QWJONTVoQzBLWjNM?=
 =?utf-8?B?ZUF6dkVlYmRhendXa3ZNbHJ0dEptK0pHd2FDbGJnTWRZUDBqa1RKaXlXMU5v?=
 =?utf-8?B?bUo0cnlaOEp2YUtxUjFTckU4NFJuY0daMmhHUHRKWnY5bk5UcnJ2SnFoVlpm?=
 =?utf-8?B?UWJEU3VJd29pZUhHcUV4MDZWVFdHcTVGbVc4N3hFQWpQeXQyRnRHL25pZWRB?=
 =?utf-8?B?QWt0azhHS2JOSzF6S2RiUkhoTG9IR1ViNEYvVVJDTm9aU3YyaFNuajRpK2ZG?=
 =?utf-8?B?eGZ2YzVVR0xJUXdnTWJ1eGZCQXpSemFPalNnUlJyVlMzMEJXVGZLc0R3RXhN?=
 =?utf-8?B?dmZTa01lRFdnQVhmeE9sZXRvR215dkdSMUlndlFSTFA0QW1Ua1BwdUZVM3JL?=
 =?utf-8?B?ZVA2eEcvMjFXdjkwSDJQeTNPK2JWbzc4MFI5ekdmRFlxOUxVZ2p4b2JRNDJT?=
 =?utf-8?B?RVdNNG42dWVid0FNSStyM0xCODFhd1VvN3hnN2dOV1dCQkU3d3NwZ0NJTnVw?=
 =?utf-8?B?aE84c1VQa3JzNmlCbFNNUEwzUFowTU8xa1J2elZ4cTJ2U3dBRFVTaHI4Qm91?=
 =?utf-8?B?Vy9XMEhMSG1EVVFKck1OYlQzTWgxazRoYlFvZGYyYVZDRndOdGxBYStLS08x?=
 =?utf-8?B?ZE4vVEFaY05uZngvU3NFemo1di9mcFJMVG1rWlEvcWxkOThPcVBVOXV3aSs4?=
 =?utf-8?B?NkdrMmFxVUEyeHYvaVBLNFRIYm1WUzFLUEpsTlFPRmRjZVZzYlRHYTRFYkov?=
 =?utf-8?B?dkFCd0x4L3pZV1ZJMjBDa05PaGxXeWF4N1hHRndRcnNxYnVJdys0ejhReEJk?=
 =?utf-8?Q?Pj4M+AN3uf6ZA3Z2FBFcDX9AM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb070266-6eb1-4d15-6a1b-08dbdbbfdc1a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 16:22:08.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xV418wlJPRJpKYfyVjulhyLxhOS6KTlkZjcdmFtPIlKVbWsAGu/WTiPF0RMOnYYtaPZHuAsHWfIZTU5difPoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/2/2023 10:33, Lukas Wunner wrote:
> On Thu, Nov 02, 2023 at 10:26:31AM -0500, Mario Limonciello wrote:
>> On 11/2/2023 10:21, Lukas Wunner wrote:
>>> On Wed, Nov 01, 2023 at 08:14:31PM -0500, Mario Limonciello wrote:
>>>> Considering this I think it's a good idea to move that creation of the
>>>> device link into drivers/pci/pci-acpi.c and store a bit in struct
>>>> pci_device to indicate it's a tunneled port.
>>>>
>>>> Then 'thunderbolt' can look for this directly instead of walking all
>>>> the FW nodes.
>>>>
>>>> pcie_bandwidth_available() can just look at the tunneled port bit
>>>> instead of the existence of the device link.
>>>
>>> pci_is_thunderbolt_attached() should already be doing exactly what
>>> you want to achieve with the new bit.  It tells you whether a PCI
>>> device is behind a Thunderbolt tunnel.  So I don't think a new bit
>>> is actually needed.
>>
>> It's only for a device connected to an Intel TBT3 controller though; it
>> won't apply to USB4.
> 
> Time to resurrect this patch here...? :)
> 
> https://lore.kernel.org/all/20220204182820.130339-3-mario.limonciello@amd.com/

That thought crossed my mind, but I don't think it's actually correct.
That's the major reason I didn't resurrect that series.

The PCIe topology looks like this:

├─PCIe tunneled root port
|  └─PCIe bridge/switch (TBT3 or USB4 hub)
|    └─PCIe device
└─PCIe root port
   └─USB 4 Router

In this topology the USB4 PCIe class device is going to be the USB4 
router.  This *isn't* a tunneled device.

The two problematic devices are going to be that PCIe bridge (TBT or 
USB4 hub) and PCIe tunneled root port.
Looking for the class is going to mark the wrong device for the "USB 4 
Router".

I looked through the USB4 spec again and I don't see any way that such a 
port can be distinguished.

I feel the correct way to identify it is via the relationship specified 
in ACPI.

FWIW I also think that that all the kernel users of 
pci_is_thunderbolt_attached() *should* be using dev_is_removable().

amdgpu is going to be switching over to this as one of the fixes I 
mentioned for that bug:
https://patchwork.freedesktop.org/patch/564738/

If nouveau and radeon also switch over we can probably should axe the 
function pci_is_thunderbolt_attached() all together.

If you guys agree I can send out a separate series for this to go after 
the amdgpu patch merges.


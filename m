Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750C15505A2
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiFRPOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jun 2022 11:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiFRPOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jun 2022 11:14:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB912D;
        Sat, 18 Jun 2022 08:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2ZRIktKoEMU2PeJn2jntfIqY+Cmudty50P54fgzP89sHAWyb7E7s+b7vWSbOBR7s2nDCu88q1YnYBDOJeFQoXdFEfk7j1v8XSLqYWNzrYDuBHdaoEO67NWEHDrPNMONAcr/5KGfr44gPk6k7bPpBwz4fINFeg2oROZQf3ohKIHjPIarkUbEvjNrsneFg2V+CdojkqGIwSRx4guoNENZM+ZNscMBGVBtWewHdSrO2tq3QpVwG7gBEKkujiR0sZjss5PxkjyT8qa/hlBsPashOa/+KUa16H/dA9ngOJ7qigpSYoh2jJiBzm9KB7JHbnbvAwjcncli42h7rZxeXDNUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0GvFY0Wz7IY7ZcKxaLzmbnNGV1Z0dLN0nI/+h3J8Gk=;
 b=XimVZsjBO8Rb/dyVp7+J2p1PKNZ3OIa8j+tP+GYkSXZpVz7C4y0GyZeyCQYqrxvg5aVXbgqCay3064Gco6nFnZe8TKxyFTVJd76/q3ZNJ+hmE1VvlepdBVxhtlRei1LI8YPdWD73T4ITBAeV2ggr9rQhbBtjr4u0IVTmLTuUg1PaGlgmr6A07RMYf0ZXzYZnFGf93t48Q95g62rB/ubHqCy0RKOcNJxlJ3HPt0pEDUx0tAg+URGPZZraU7XrlcF4cBr4xgMZ8rBI+zhrMNjc7tF9jX6L9lIpfv9Rz3wRqUCLoUXTWioyAI0rJfZ906VURiRaCLR+i2qhyZDuL88tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0GvFY0Wz7IY7ZcKxaLzmbnNGV1Z0dLN0nI/+h3J8Gk=;
 b=GhJMvmSIBsviNgZlqI9mTDZle0pj2FI6QrZSr1MZhQrPSVfgNhdxzGZw6qtYvq8qyQ7zzEKv9ZkjveJrhXKkDWbd5UoIIl47rYVQMkYCxGIPK0MoW8qWjTarQuSRmylytDgR67vXQYuICirV5Gk4UXuE/q0mOBd+ZNP8RjIq3M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Sat, 18 Jun
 2022 15:14:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5353.019; Sat, 18 Jun 2022
 15:14:42 +0000
Message-ID: <21bce72a-3537-0ff2-2553-4d62cc86ffbd@amd.com>
Date:   Sat, 18 Jun 2022 17:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Intel-gfx] [PATCH 1/2] drm/i915: Add support for LMEM PCIe
 resizable bar
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-kernel@vger.kernel.org, priyanka.dandamudi@intel.com,
        matthew.auld@intel.com, Bjorn Helgaas <bhelgaas@google.com>
References: <20220617184441.7kbs4al7gmpxjuuy@ldmartin-desk2>
 <20220617203252.GA1203491@bhelgaas>
 <20220617212727.h5r2o3schvl73bbk@ldmartin-desk2>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220617212727.h5r2o3schvl73bbk@ldmartin-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0409.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b244796f-40d2-47fe-f550-08da513d4510
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5611:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB56118D4F734D866BB962F34683AE9@SJ0PR12MB5611.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISNXeIzEZMrq+SrfyeQI/20iyMmkNkoWXnpnDjCfXWiy2eI/TYDXWYfvqqjuSVS1vC6Pk91OVNHbfoWUUOQ1DHQyoz6Pgzzwx8+U3GO6TR1/XtKe1Jag1DuhVXMGPrfstSlmBEIGt164ls25XSVZl9p1aJjCPx5YOaARJsA+mPxNGk3r/ZPftgFbgwiX1ItFm3Ypaek8D0wNRexuib900Z+bvYN4zdb6AFcnSRo3lRlg0leB74yxP3bo/aah1i6pLtMvfYYfppr5g7Q/n+u9EPp7TznJvzAJ3ZFHPFJs8Sctwc9Y03dRyD8ddO74jPjHe0iGEnam1Vl55Yx3PKIjO4baAN1yUU4VJ5aw4AzCz1DgguEmBmMfOzKC02M8BM3m4OInILRh3aZqcBWfTCmZPnN9FyOAl+1vYIAiQj0isu+TxCq58kG8ovTOcHD6y5MNBqYPr1kN1k8TrXfjSjgTIKAA5Xk/Fp6BRndICRAo4mBXQe5crDFCaklsKLZgpegni+tf2/PgrnB8y6lNDM7PYL7cPSnOKVDrBH1bg3Yho1Bi1BJzJyCoKBGu/dOoY2gf/4NJle4ZIqurPBqGww62fxOAxipJMIBkEOvaklgW+g6g8ZwBu4AR3uBt2rWD0obP3pU10Dx02589dWyTKPyT78YtkahNepkonpfv8qMwwlYjaZua7Ay+LbKJVLvVxAU0N9eVzjiMPaYByV3sOetlytGDSkoNBhPbXzt1DK1dEDaJWY4YOmfiy9JEV/+TmmrwcjFskqTL4OOFzwP3JB9qCAaVecPa0dH/Ry69yJruOK9t3YkV3Gxzl762340Sv/aGkrzrLSGBEjD1CqyPrpmS69Ct7NbAytCzeingDgH96TI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(83380400001)(8676002)(66476007)(4326008)(36756003)(31686004)(31696002)(86362001)(66556008)(66946007)(2906002)(6486002)(316002)(966005)(2616005)(6506007)(6512007)(38100700002)(5660300002)(186003)(110136005)(54906003)(45080400002)(498600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anFKUlkzZ0xGeWMwZnc0SXE2Tk9rd2Y0Q0NwV3A1TE1Od1IzcVp1OFNyUUNZ?=
 =?utf-8?B?QmtGR0lwNS9QZE9wcDhDUWZoZXI1ZWI5SWZDTFpkazhrODNaZHF3NmNhcnFt?=
 =?utf-8?B?S2VLUG5SU0RwelpjWmUwMkcvT2JIWXhzazdFaXJORXcyUENYNnpIM1JzYU1q?=
 =?utf-8?B?YVBPOUwvMm0xR0Evb01TY3p4WEs0ZVdMWVJDVVlpM2FlU3ZDZ1lSalJjY1RP?=
 =?utf-8?B?Ui83QVNsT3pDYU1TbDExQmQyVnBTbHl6RkpTdWIyUHA5TDZMMXcxMVo1M3k4?=
 =?utf-8?B?QjgyN1FPM3BBd0ZXRjlvMXRjWnBEZGxCKzd2N3A1cG9zSUZ4bkZObG9iaVFr?=
 =?utf-8?B?OW5QZnV6TC9BSDFBYk9JRFlQZU9CZ01weW1EanlEeE1qSm5lY0kyenF0N2pl?=
 =?utf-8?B?b1I5b0Z6SzNid0I0V0dTQWNsREVZT0RIL29TeXppTDczZ2hKY0tPSWdRa0RM?=
 =?utf-8?B?S1hEU0w1Nlk5M0NFRXJIVmloZGswNUljem80SW52L3QrWCsxVmNiWGwyUkJw?=
 =?utf-8?B?TkxPUmluN3doRG05aFhNZ3pDbHNHWmFxMCtNeDdFMmNNdUhoVnFwR3Z4Q3pp?=
 =?utf-8?B?MzdvMTE1Z2djaVBaRXdmcXRlZEdBOStLZTVXd09ORXJ0ODFud2NnQnIza2li?=
 =?utf-8?B?SXd3dHZWQmFTVjNHQWdsL0NRMEVXSlFwZVVGY0NGa2grTXhJdWtFWnJxV2Y1?=
 =?utf-8?B?cnRtMjRiRkVERmpoMUpkVVJLQ1dSOFJCcWJZQ3NJOGQxNFdDYWhBSlV6VkxM?=
 =?utf-8?B?QklmU3VFemJKWmYrZ2xsdGpSd3FrSmk3a3hTeWkxbHR4QTM5dmIyT2Myb2hS?=
 =?utf-8?B?cjdpL3JGUFRBZ2M4dkxZTHpIaTRsNWV4TzFoTCtUdDFOZFJudHliUk51UDJY?=
 =?utf-8?B?V3h3RHU0cFJUYUtzNHV2Rnl0WlRZamZTS1ZYUXFtekJwQTlKc1ZRMXp0YmVw?=
 =?utf-8?B?WDhGa1Jrdm1kOWtwNXpWaXM3aW82SlM3UzdvWWM0UTdzMTE4M3g5WFBNbjB6?=
 =?utf-8?B?OThEak5WU21TblBVUWRvZGErU084ek5FYm10V1F4cm9WRU12azFLYTZPc1Js?=
 =?utf-8?B?TFVtUHViQmEzM2tFdldVWlVURE5sRFpRZ1AzbWlVVFNNUTQ1RUh6czZQSy9z?=
 =?utf-8?B?R21WU3VmU3RGeFNONDcwL1J4S2NhUjcwRHkwSlY5NEFtbklMTTkrSnlkUzQv?=
 =?utf-8?B?RkV2ZFdRNjA2d1NnL1JUOXU2dVovTmNaTnRqVVNzMUxTYURua0hxUElLN0lK?=
 =?utf-8?B?T24yVFpMUENwbzRCTWtRWGYwM05SSGk2ZkFYOG5PanNKdG80MGU5Z3diQjFS?=
 =?utf-8?B?SC9vbCtJTFNxYlU2b1pSdHBxd3pxa0d5T0JZUlBweEtHa09mOWNUcms2ODln?=
 =?utf-8?B?bE1McTlPOU00YWI3eFpnamVLeHRKdXV6dEdIZXEvZGtER21uUm5VbWNqcUZy?=
 =?utf-8?B?T2hZNkNiVXhZRWVLOTJuZ0s2YXR4VVpyMkJqcmF5RDJLK2VDQ2pOZVJjZGtN?=
 =?utf-8?B?STNrVjR2Wk1aNnZaRXFVNGxkSmV1OTB5TkpPeVcxc3lIV3dsQnhzTHFBV2RB?=
 =?utf-8?B?ZnZlV3AzZzh6dkVuampVZEsvdk96Qkh1cUtOa0hGS2RNdUhidU5FbWt4b2Mv?=
 =?utf-8?B?aDFSdEI1elZJK2JsMndtM1UyeHZ1cm1SbUlPOS9oZC9iMmhvclQyS3FXZTYr?=
 =?utf-8?B?b0lvdlM5M0R4UU8xemgveXNrZ3ZlbkdaKzk4bFNqTVRjWHVEU0ZoblJSYmtW?=
 =?utf-8?B?NUdQVTBZZDBWTWNUd0pWemd6YTFaY1h2M0hHdC9DcWlhYkZkaWJRaXF6STBW?=
 =?utf-8?B?dGlpK2VLb3R2bDZOd0VCOEgxVStYRGJjU3AwdjZFek53OXhWbC8xZGtwekhp?=
 =?utf-8?B?aFU5Tjl0Q3lEQTEyU0dNSmNybjZBci9pMmppMjNNcHpUK1F6akVIMGNPcmRt?=
 =?utf-8?B?S2ZuTG8vaEtUNU9pVmdvZk5oUkhwTDhuYStiUHVIM0l3VEVzeE1ra1dvUkRJ?=
 =?utf-8?B?US9xcE1hZW9DQklrSVRySDMzUUpOb0RTcGhYamNpMG9SWFBCUmtKdG9WMHR3?=
 =?utf-8?B?aDRsMGFrdDRiMlhSRTlmanVDdHhlMWZVM29OcG5RdThIb0FZTlQ0cTM4TUdV?=
 =?utf-8?B?bzhqUUNxdTVrUW9xSC9pQlVlQ1p2aUp4bkkyc3M4QWtlS1VGVTVRQ3FGQndh?=
 =?utf-8?B?MGw2SDB1VmRveHZmVEU1VTFEZzd1MEFYU2tmREpKak1FSHI1SmJraTNPS2to?=
 =?utf-8?B?RnZyZ290cGNkczdyWTFVUWVoYWc4OGhmYWR1WlZpa3VoTzQ2alBRL3NSSmRJ?=
 =?utf-8?B?dE9EcmZhZWpaMVhJVUgzOWRHSndZS1dOMldxNVhWb09RL2U3SkNndmpXVGdV?=
 =?utf-8?Q?n91XiGYgbItPEVcrKBYrqDalr6pFS0XUZvn2DoDa+9gsL?=
X-MS-Exchange-AntiSpam-MessageData-1: IPxk04H6r0i4Xw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b244796f-40d2-47fe-f550-08da513d4510
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 15:14:42.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/Bx1oUNgv/zANs2WnRFTWowFVsNNOTQaTH5sBZIOVoH2BwzvMLGSGnfeRhUuAMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 17.06.22 um 23:27 schrieb Lucas De Marchi:
> On Fri, Jun 17, 2022 at 03:32:52PM -0500, Bjorn Helgaas wrote:
>> [+cc Christian, author of pci_resize_resource(), Sergei, author of
>> rebalancing patches]
>>
>> Hi Lucas,
>>
>> On Fri, Jun 17, 2022 at 11:44:41AM -0700, Lucas De Marchi wrote:
>>> Cc'ing intel-pci, lkml, Bjorn
>>>
>>> On Fri, Jun 17, 2022 at 11:32:37AM +0300, Jani Nikula wrote:
>>> > On Thu, 16 Jun 2022, priyanka.dandamudi@intel.com wrote:
>>> > > From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
>>> > >
>>> > > Add support for the local memory PICe resizable bar, so that
>>> > > local memory can be resized to the maximum size supported by the 
>>> device,
>>> > > and mapped correctly to the PCIe memory bar. It is usual that GPU
>>> > > devices expose only 256MB BARs primarily to be compatible with 
>>> 32-bit
>>> > > systems. So, those devices cannot claim larger memory BAR 
>>> windows size due
>>> > > to the system BIOS limitation. With this change, it would be 
>>> possible to
>>> > > reprogram the windows of the bridge directly above the 
>>> requesting device
>>> > > on the same BAR type.
>>>
>>> There is a big caveat here that this may be too late as other drivers
>>> may have already mapped their BARs - so probably too late in the pci 
>>> scan
>>> for it to be effective. In fact, after using this for a while, it seems
>>> to fail too often, particularly on CFL systems.
>>
>> Help me understand the "too late" part.  Do you mean that there is
>> enough available space for the max BAR size, but it's fragmented and
>> therefore not usable?  And that if we could do something earlier,
>> before drivers have claimed their devices, we might be able to compact
>> the BARs of other devices to make a larger contiguous available space?
>
> yes. I will dig some logs I had in the past to confirm.
>
>
>> That is theoretically possible, but I think the current
>> pci_resize_resource() only supports resizing of the specified BAR and
>> any upstream bridge windows.  I don't think it supports moving BARs of
>> other devices.
>>
>> Sergei did some nice work that might help with this situation because
>> it can move BARs around more generally.  It hasn't quite achieved
>> critical mass yet, but maybe this would help get there:
>>
>>  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20201218174011.340514-1-s.miroshnichenko%40yadro.com%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C8096027f68484d0656b108da50a82e7d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637910980509199388%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2FfntE2FTQ8wmLnz4wnzk94R0GMLEwVs7Mj18%2B9Q6PJk%3D&amp;reserved=0 
>>
>
> oh... I hadn't thought about pause/ioremap/unpause. That looks rad :).
> So it seems this would integrate neatly with
> pci_resize_resource() (what this patch is doing), as long as drivers for
> devices affected implement
> .bar_fixed()/.rescan_prepare()/.rescan_done(). That seems it would solve
> our issues too.

Well we never ran into any of the issues you describe with PCIe BAR 
resize for GPUs so there must be something you do differently to AMD 
hardware regarding this.

Additional to that keep in mind that you can't resize the BAR before 
kicking out vgacon/efifb or otherwise it can happen that the just 
released 256MiB window is still used while you try to resize it. When 
you do that you usually end up with a hard lockup of the system.

Regards,
Christian.

>
> thanks
> Lucas De Marchi
>
>>
>> If I understand Sergei's series correctly, this rebalancing actually
>> cannot be done during enumeration because we only move BARs if a
>> driver for the device indicates that it supports it, so there would be
>> no requirement to do this early.
>>
>>> Do we have any alternative to be done in the PCI subsystem during the
>>> scan?  There is other work in progress to allow i915 to use the rest of
>>> the device memory even with a smaller BAR, but it would be better if we
>>> can improve our chances of succeeding the resize.
>>
>>> > > Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
>>> > > Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>>> > > Cc: Stuart Summers <stuart.summers@intel.com>
>>> > > Cc: Michael J Ruhl <michael.j.ruhl@intel.com>
>>> > > Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
>>> > > Signed-off-by: Priyanka Dandamudi <priyanka.dandamudi@intel.com>
>>> > > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>> >
>>> > Please see 
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F87pmj8vesm.fsf%40intel.com&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C8096027f68484d0656b108da50a82e7d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637910980509199388%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=d4cf7HQ6t7y1Xobwjdt8im%2Fh0E5IZsXgzQDpsB2vCU4%3D&amp;reserved=0
>>> >
>>> > > ---
>>> > >  drivers/gpu/drm/i915/i915_driver.c | 92 
>>> ++++++++++++++++++++++++++++++
>>> > >  1 file changed, 92 insertions(+)
>>> > >
>>> > > diff --git a/drivers/gpu/drm/i915/i915_driver.c 
>>> b/drivers/gpu/drm/i915/i915_driver.c
>>> > > index d26dcca7e654..4bdb471cb2e2 100644
>>> > > --- a/drivers/gpu/drm/i915/i915_driver.c
>>> > > +++ b/drivers/gpu/drm/i915/i915_driver.c
>>> > > @@ -303,6 +303,95 @@ static void sanitize_gpu(struct 
>>> drm_i915_private *i915)
>>> > >          __intel_gt_reset(to_gt(i915), ALL_ENGINES);
>>> > >  }
>>> > >
>>> > > +static void __release_bars(struct pci_dev *pdev)
>>> > > +{
>>> > > +    int resno;
>>> > > +
>>> > > +    for (resno = PCI_STD_RESOURCES; resno < 
>>> PCI_STD_RESOURCE_END; resno++) {
>>> > > +        if (pci_resource_len(pdev, resno))
>>> > > +            pci_release_resource(pdev, resno);
>>> > > +    }
>>> > > +}
>>> > > +
>>> > > +static void
>>> > > +__resize_bar(struct drm_i915_private *i915, int resno, 
>>> resource_size_t size)
>>> > > +{
>>> > > +    struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>>> > > +    int bar_size = pci_rebar_bytes_to_size(size);
>>> > > +    int ret;
>>> > > +
>>> > > +    __release_bars(pdev);
>>> > > +
>>> > > +    ret = pci_resize_resource(pdev, resno, bar_size);
>>> > > +    if (ret) {
>>> > > +        drm_info(&i915->drm, "Failed to resize BAR%d to %dM 
>>> (%pe)\n",
>>> > > +             resno, 1 << bar_size, ERR_PTR(ret));
>>> > > +        return;
>>> > > +    }
>>> > > +
>>> > > +    drm_info(&i915->drm, "BAR%d resized to %dM\n", resno, 1 << 
>>> bar_size);
>>> > > +}
>>> > > +
>>> > > +/* BAR size starts from 1MB - 2^20 */
>>> > > +#define BAR_SIZE_SHIFT 20
>>> > > +static resource_size_t
>>> > > +__lmem_rebar_size(struct drm_i915_private *i915, int resno)
>>> > > +{
>>> > > +    struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>>> > > +    u32 rebar = pci_rebar_get_possible_sizes(pdev, resno);
>>> > > +    resource_size_t size;
>>> > > +
>>> > > +    if (!rebar)
>>> > > +        return 0;
>>> > > +
>>> > > +    size = 1ULL << (__fls(rebar) + BAR_SIZE_SHIFT);
>>> > > +
>>> > > +    if (size <= pci_resource_len(pdev, resno))
>>> > > +        return 0;
>>> > > +
>>> > > +    return size;
>>> > > +}
>>> > > +
>>> > > +#define LMEM_BAR_NUM 2
>>> > > +static void i915_resize_lmem_bar(struct drm_i915_private *i915)
>>> > > +{
>>> > > +    struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>>> > > +    struct pci_bus *root = pdev->bus;
>>> > > +    struct resource *root_res;
>>> > > +    resource_size_t rebar_size = __lmem_rebar_size(i915, 
>>> LMEM_BAR_NUM);
>>> > > +    u32 pci_cmd;
>>> > > +    int i;
>>> > > +
>>> > > +    if (!rebar_size)
>>> > > +        return;
>>> > > +
>>> > > +    /* Find out if root bus contains 64bit memory addressing */
>>> > > +    while (root->parent)
>>> > > +        root = root->parent;
>>> > > +
>>> > > +    pci_bus_for_each_resource(root, root_res, i) {
>>> > > +        if (root_res && root_res->flags & (IORESOURCE_MEM |
>>> > > +                    IORESOURCE_MEM_64) && root_res->start > 
>>> 0x100000000ull)
>>> > > +            break;
>>> > > +    }
>>> > > +
>>> > > +    /* pci_resize_resource will fail anyways */
>>> > > +    if (!root_res) {
>>> > > +        drm_info(&i915->drm, "Can't resize LMEM BAR - platform 
>>> support is missing\n");
>>> > > +        return;
>>> > > +    }
>>> > > +
>>> > > +    /* First disable PCI memory decoding references */
>>> > > +    pci_read_config_dword(pdev, PCI_COMMAND, &pci_cmd);
>>> > > +    pci_write_config_dword(pdev, PCI_COMMAND,
>>> > > +                   pci_cmd & ~PCI_COMMAND_MEMORY);
>>> > > +
>>> > > +    __resize_bar(i915, LMEM_BAR_NUM, rebar_size);
>>> > > +
>>> > > + pci_assign_unassigned_bus_resources(pdev->bus);
>>> > > +    pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
>>> > > +}
>>> > > +
>>> > >  /**
>>> > >   * i915_driver_early_probe - setup state not requiring device 
>>> access
>>> > >   * @dev_priv: device private
>>> > > @@ -852,6 +941,9 @@ int i915_driver_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *ent)
>>> > >
>>> > > disable_rpm_wakeref_asserts(&i915->runtime_pm);
>>> > >
>>> > > +    if (HAS_LMEM(i915))
>>> > > +        i915_resize_lmem_bar(i915);
>>> > > +
>>> > >      intel_vgpu_detect(i915);
>>> > >
>>> > >      ret = intel_gt_probe_all(i915);
>>> >
>>> > --
>>> > Jani Nikula, Intel Open Source Graphics Center


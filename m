Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5E698952
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 01:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBPAfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 19:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPAfx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 19:35:53 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02DA42DCF;
        Wed, 15 Feb 2023 16:35:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4E1uowMANCLuaCPHKddMXG6aJE37YlCYBawMBXyYVNg9Fnde6LJ7dbEEQRs43f6HgecY9HnJsM7vt0Er1hX2tI15ki8XzeAKvlONrO8kPGQum5yfNyxFqD14I3h6Dm2txDUP6Z37m2di8LvFutv3DZA/VJ/NnTok+Bd1jFxgtljk/RevgcvrkiS4MbJYx+l1B3kGVpGTGLgwUIqreHeYnUUJwkC5ue+DDMwXP0Es4MMwFJJPHK+ZVbqNt7YpFyT4tcndd4aPcZD6fjdPpThSJwB2ybJXcMJehywlpteQzuWvyHDQvvdUIweK19/G1E131wtYhFGA1oTy20I7hIGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq/cu+FQ1UcGAnTuLdWwawSf/qUVCWrNpoYN55apkn0=;
 b=ayzPzAQIaj8IwRQBegA/9CLORUUDVSvmG1UrnEJTln928PjvN+Au4Sog4kPiCfu9qrCUocLYmeeD/TgXQCJmkSrz1RS1mbd8rroQ/SjgbFnVhC+84muccdXTe4BTC5ACKQfTVlqPk/lBbZZp3Dl/pfA3Z2IGmFvvN71mSDLXaBjdET4bWHmXpa2/OplOgw7iq6R9WKyoRmzLGihY9ndqymttxjDfockN5bmNM+JyWEWP3M8bC3vqnkobnsjKTbuyQ16tv0qUqV5d41KRWCNrhMYwHWXs4yRuyoZh5qlrEAfuhARQ1o/eFI6UBJ66wJ3nkYb7Kn6GPVoot880i4LU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq/cu+FQ1UcGAnTuLdWwawSf/qUVCWrNpoYN55apkn0=;
 b=d3ZCoOl0MU/8ap+eZLdLolgYvFw+iwHXmZkZY3Z0vrDRMpshhU/T3Ec4SyBPgH0yU/ZCEV5SryYOftxnt5hG419WIYZgr9WIBdOoOJe+/gE1JvjEuNhVj4cui0sOhe0NfUL2esUNslc/x5hOcuFr6QN4M6lYpfKfj9omJomKcS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 00:35:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%5]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 00:35:48 +0000
Message-ID: <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com>
Date:   Wed, 15 Feb 2023 19:35:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230215153913.GA3189407@bhelgaas>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230215153913.GA3189407@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 07abd02b-3d05-4a4e-25e3-08db0fb5bf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tViI/6Xr2IZ8f74e5PDJfXVySh3WzQs5sBlERZNiS8Sw/SeIVJQvtukiATxy6crLkmjWVd/2/T9o6hnjObkPR1+N2dFOdy+xlICoC70lO3e2Nd2r2G0CjEvMA4u2nH0XjLdcAJ2IpkPrxMnohyK2hMmVslzG5pobxb/aVGs3r8OZ98/ddzkHugH2yzddq+wr15e0utzpzYz1c4alJC9ZsmCbcR8zE3MVOriHbqIRQAt2RwfFADjBdpYC0XFfEL74lCXF8gm6g5So1gpNV7SHZrA2z+Zd7mZt3uRQVUBqRBoXNNi9dtMhSZnU00QT+6JLiaHqwjMwJEt5RsgqyjFU95FUjuwuh7SCf6yO3y3jE7s376DNu4sFUC4w5uW3adcdpY6940BWn3PV9udGlw2H+sh/T5pTvEBxX5JaXp9h48h8ZojpQE9M0ue+qV/HM9Ql4M6Zs40u+4XcdebL4+urC7jEOrbFkjEi7myHyW85iImdHae/Li0z5qxcFLy9AWEPL1vqT7/NFN7tJmg8fi2JuGMTu0/h77A6EnX3xqnquTcbzYtWaJsYANfxWDP1YdeSXphe2RAkOLKku0R231LaUXICy+WkEk6kt1on4+y0/oyPG45f7Gch01sSi3EkWMMQ3+Kf2gau8oC5q9gtUrtU5OF/nKX6HtVwM/J9Yh9Y1GKjKGH0LsmqqglSoUudIdMHZW+laQXvVmKDGMPyeKkLMeOh0oFE9P4R9NAyTeKyBTy4u3GNz2A4PWM5Lp2H/sLWVT9b7HZRQs4d4Lb6py6izg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(44832011)(7416002)(26005)(2906002)(186003)(5660300002)(8936002)(54906003)(53546011)(6636002)(6512007)(31686004)(6506007)(110136005)(38100700002)(31696002)(316002)(83380400001)(6666004)(86362001)(41300700001)(66476007)(66946007)(2616005)(478600001)(36756003)(66556008)(4326008)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnI3TmoxM2xEMmRwN2U0dEFxV0FYS3p1czlxRTJmT1pMdDZtU0diaUNsMXAy?=
 =?utf-8?B?Rk1ndVZFRmVodTdOc0ZjNjVqc1FPZUN5WitiNXM2UnRoYjZsOG9tbXpFUHRZ?=
 =?utf-8?B?TEJBTjJGWWhxa3pCak5yYm1yZEMzK2RVM2plRFozUStQaUZ0cGtMVldWcFlB?=
 =?utf-8?B?c09HeTFjQVRJV2wvUWh5RUFyMHEzcVg4MkpTNHN4RFhHMVpONW5CcVp0YXZk?=
 =?utf-8?B?VzNtYjJCU3JxTDgzMjByUnFSTGtmWEJLOTRUZGZMaWlIZDJ2d1dLNS82NTln?=
 =?utf-8?B?dzhUQmJuaTN0TmxtRzdOamxtU0gvRkQ3dkR2RDdyWnpZOVQ3bFhLL3gvcUcx?=
 =?utf-8?B?SHY4WktSSUJWaHBEMmRBR04wZmdmVEI2dS9ZZlUxMStGb1B3M0NYZHBaR1Az?=
 =?utf-8?B?WnczT1VnVkpzSHJzcWxudkFuWVFsaEErT3BTMWNHbjhhS1U0a0J2cUxFcVJN?=
 =?utf-8?B?Y29UWFptVWw1MHJBbWhDWWdZK0xFbkF3WlNnaU5iM1RWUjhqcVA5WEdaSmp0?=
 =?utf-8?B?S3NzdENyZ0laNHV2dDY0ekZDdTIxSHljNlArS2RNSXVvQytaS1ZYTElOdjNZ?=
 =?utf-8?B?R1Z6QkhpUTlRWXVjd0UrU3E1RTNKQU1OYm1YR25TcUg3NlcrbDNxaWFvLzlG?=
 =?utf-8?B?K05TZzBnbGRhWHJocjIwdXRtVlcwUnM1cjRmNzNvMUpBRXFUQ3Vza0RwTk1Z?=
 =?utf-8?B?eTQvSVZaRDY5RWRyQ0N1ZTg4WlZUTCtFTzliRS9jQ1poemUrZTM0bVZYTkRF?=
 =?utf-8?B?Y0cyZGFoR1BtREVzeFFJRTl6YnJ5VG9nNEQra0NrdW5ZRzVQK2c2WWFOdk92?=
 =?utf-8?B?UjRIUDlPaFVvby9LN0YyRzlUU0lScUJJRVQrY1AxeXB0YzdvNWEwNDJ1UnpS?=
 =?utf-8?B?VkFSVG9LQkwzNGJZZnNkMGJqclB4YVlYSFllelVTdy9hYlRyWEZxYklBaGtX?=
 =?utf-8?B?NWF1S1QrTUdpTDJZaXVSa1k0U1Z5RHNWY09yYjcwcTUzeU9HeVpFNlA3cTBa?=
 =?utf-8?B?dUVMV0cweFFucGNXK0h3UExRaDJGbnRxZThXSDh2dGtlVnpBVGpVTk1qKzNE?=
 =?utf-8?B?bXB1ank4VEhmRVE0OEZVbGh5NnVYYTVnMFVHMGw0MHN2ODFzb051cWgvMXh6?=
 =?utf-8?B?RVAyQ0NJdVBpZHhsME1rQkxjSzBBQ1lPVGt6VzdpRVJaYnc2Qk9zT2YwWTdL?=
 =?utf-8?B?NkJZaFNSZGR5UFRIdHB3Y05OWWMrdm9lYjVGVitVMUJSWGo3Nm1yTTMrYnpv?=
 =?utf-8?B?K0NUUGVNbDJSYmJNMG1ONWpFakRraGs2SkMyandZbG04QzdIeTdod25vZmpS?=
 =?utf-8?B?NE9GN2l5emNQbDB3SUdPSGZBbzVCUTJ4R1FBRElyay9ZUnhNak1Tc3BTaHkz?=
 =?utf-8?B?blZQbHlQbnlaTk41RmlGcC9aOUtidmFlK1Qwa3NURTNDQUtjQTgwS3FUeVpS?=
 =?utf-8?B?SU1XREY4RUFHenNmdHEwRjcrcGhkNDdES1MzS1BxZWtXRklXcWlqckdXRjNB?=
 =?utf-8?B?VGlWL0d6WGQ2SXBSbUZJTVpPbk9nWDVvangxYkdvVWJVYWlaVW0rUWI1UVkr?=
 =?utf-8?B?Y0M2eHJZamVhblJES2pCNEFhVUh3ZndhY3RTTnZ3L2Nyb0NyNmdFellFUHZB?=
 =?utf-8?B?b2g0SDBTajJrZDQ4cWRiVEpTWUtNTldZeW1nSzFrOXFsUWVLMkIwNjZsYmdo?=
 =?utf-8?B?eTR5T0kyUUlwQjFuY1hneURDeWxvbE1Wdjh1RFh3eWpsTThoTUdCRUY1L0Va?=
 =?utf-8?B?a2dqeHlnZ2xTeHpoY2NFVTZqR3M0WUx6Vm9SQ1JvOVBuYmhGLzZDVXVYNHZz?=
 =?utf-8?B?eE41YzRmdVdXWFhLWEl4MDVtMjVqVnRwQThwTzVOb0t0bmNEaVAxNFpSOC9q?=
 =?utf-8?B?VFo1aXJHTlVubDFSc3RrWHBOcHdvdjMvMlFNR1ZWNVc4bWpYVUR2am9Fbm90?=
 =?utf-8?B?VCtVMC8vWHhvQmdDOFc2Y2lraVhDQ3ZWRjV3R1lkbDZMazdxMHhaU3owM3F3?=
 =?utf-8?B?ak9odENUM0ZSN01URXVqUWtSR241dUJKVDY4N0RhcGdycGhKSTJ5UUNlcWJh?=
 =?utf-8?B?OW5JNzEzR1NNUW1Gbk90SnRLS2IyeXVqTmUrS2RPVEZVdGowZXhlTEUzNWdp?=
 =?utf-8?Q?MJgLaaGjW4wgaKn50CGavqUhy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07abd02b-3d05-4a4e-25e3-08db0fb5bf67
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 00:35:47.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MM+QyW6UzRVjoFFzFQG2jlyjm00EiYeko/Eg03hrGWXU00z/SeKjHt229iyUGH8BJoCC8S64pRokNn5IeYQ3xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Shimmer, Aaron]

Am 2023-02-15 um 10:39 schrieb Bjorn Helgaas:
> [+cc Christian, Xinhui, amd-gfx]
>
> On Fri, Jan 06, 2023 at 01:48:11PM +0800, Baolu Lu wrote:
>> On 1/5/23 11:27 PM, Felix Kuehling wrote:
>>> Am 2023-01-05 um 09:46 schrieb Deucher, Alexander:
>>>>> -----Original Message-----
>>>>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>>>>> On 1/5/2023 4:07 PM, Baolu Lu wrote:
>>>>>> On 2023/1/5 18:27, Vasant Hegde wrote:
>>>>>>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>>>>>>> I built 6.2-rc2 with the patch applied. The same black
>>>>>>>> screen problem happened with 6.2-rc2 with the patch. I
>>>>>>>> tried to use early kdump with 6.2-rc2 with the patch
>>>>>>>> twice by panicking the kernel with sysrq+alt+c after the
>>>>>>>> black screen happened. The system rebooted after about
>>>>>>>> 10-20 seconds both times, but no kdump and dmesg files
>>>>>>>> were saved in /var/crash. I'm attaching the lspci -vvv
>>>>>>>> output as requested. ...
>>>>>>> Looking into lspci output, it doesn't list ACS feature
>>>>>>> for Graphics card. So with your fix it didn't enable PASID
>>>>>>> and hence it failed to boot. ...
>>>>>> So do you mind telling why does the PASID need to be enabled
>>>>>> for the graphic device? Or in another word, what does the
>>>>>> graphic driver use the PASID for? ...
>>>> The GPU driver uses the pasid for shared virtual memory between
>>>> the CPU and GPU.  I.e., so that the user apps can use the same
>>>> virtual address space on the GPU and the CPU.  It also uses
>>>> pasid to take advantage of recoverable device page faults using
>>>> PRS. ...
>>> Agreed. This applies to GPU computing on some older AMD APUs that
>>> take advantage of memory coherence and IOMMUv2 address translation
>>> to create a shared virtual address space between the CPU and GPU.
>>> In this case it seems to be a Carrizo APU. It is also true for
>>> Raven APUs. ...
>> Thanks for the explanation.
>>
>> This is actually the problem that commit 201007ef707a was trying to
>> fix.  The PCIe fabric routes Memory Requests based on the TLP
>> address, ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with
>> PASID that should go upstream to the IOMMU may instead be routed as
>> a P2P Request if its address falls in a bridge window.
>>
>> In SVA case, the IOMMU shares the address space of a user
>> application.  The user application side has no knowledge about the
>> PCI bridge window.  It is entirely possible that the device is
>> programed with a P2P address and results in a disaster.
> Is this stalled?  We explored the idea of changing the PCI core so
> that for devices that use ATS/PRI, we could enable PASID without
> checking for ACS [1], but IIUC we ultimately concluded that it was
> based on a misunderstanding of how ATS Translation Requests are routed
> and that an AMD driver change would be required [2].
>
> So it seems like we still have this regression, and we're running out
> of time before v6.2.
>
> [1] https://lore.kernel.org/all/20230114073420.759989-1-baolu.lu@linux.intel.com/
> [2] https://lore.kernel.org/all/Y91X9MeCOsa67CC6@nvidia.com/

If I understand this correctly, the HW or the BIOS is doing something 
wrong about reporting ACS. I don't know what the GPU driver can do other 
than add some quirk to stop using AMD IOMMUv2 on this HW/BIOS.

It looks like the problem is triggered when the driver calls 
amd_iommu_init_device. That's when the first WARNs happen, soon followed 
by a kernel oops in report_iommu_fault. The driver doesn't know anything 
is wrong because amd_iommu_init_device seems to return "success". And 
the oops is not in the GPU driver either.

I guess this could also be handled more gracefully in the IOMMU driver 
(i.e. fail gracefully in amd_iommu_init_device and let the caller know 
that something is wrong, don't oops in report_iommu_fault).

Regards,
   Felix



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB19165D78C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 16:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjADPvT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 10:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjADPvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 10:51:18 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB41BF56;
        Wed,  4 Jan 2023 07:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgs3NcmNywSvqK6nvb45GS7bVfTh2fGBYPq6Bi2iDGxnX7o9DwEeOIVlHaYj7LIfDtNjfv3rhxTV9zOcw2j1ZbTrO5utGpy6VyuNJY+XhLblRGUakiaoL2UP+BgjWYjfwCXsmF4Vt9A2U8vk1QW9cfAy8lgAXAaz17qccRhqUlQntSx1f6TK4MLwUzNEAsTmcRRG3qcwg6RPOFpcZTcmipN9tU8kRcom6d03oLK4NAPCulGGVfL2iu7acUyX7iuMjOUMZPtdXBn7FTNXYgevARUV7qgswpXQ7pXJtGqm7U7kwQUT3kRnZmPA8QkD77izL2q4oRP56GZeeKPPXgw6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM/O7xJ7y/FRSjrGRWKXek3jN5H4+84S/KIDKfK4b90=;
 b=cKZHOpmh+NzcUy0CDy/XMJAkhetbnCQYIucShHOYlCW+9vtD9rudCq3Hy9g+zYd8NLl1J37/02eJnH7ziPDEJAbct3/sQKAvEWif5xJFd31Xn2H+iurqg0ffx96THWRbbyV3fosIPq9FUbmrZVDbEMFeM5xf5qzOAg3wRzDrG2yhIGqgsVyVJW9+UqFHaCr6eIha4O23Rd7c9VhRgNOTsfC7vlQmoFqmpmpLVxySMHDcNkM3ixIk6itJ9xuOblYNCSMYt5a8EnZ8Wo6z31EzBJrbdOjdfeCInx09BXZgkq7I179P9xmE9znoKMsReSgLeMUkaMffEAP67OuDjdfWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM/O7xJ7y/FRSjrGRWKXek3jN5H4+84S/KIDKfK4b90=;
 b=nnQyxRSw5qk9qmPJ/Yx3ZPKrD+cmqFb07knPmS/7oEeAWLY230sQ/FzC0dWcrqMwV1Bx6Cc4uboG3QUEmGc1lcWLBGP+oVi5bJQDvtA0efAhajaWt44ZAZuPxGWBy6Qp7QDgUJRiDs3FXJt9Be5MFEoUhYHtwr9fOZ9AGyonqN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 15:51:13 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 15:51:13 +0000
Message-ID: <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
Date:   Wed, 4 Jan 2023 21:20:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e46729-4f4b-425c-4481-08daee6b81aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6QZBYSwW5UfIIJkUSSYb2eigRy5tvFi6rN1HM9OVerICegdh920JzvN4J8Y/m4AcheEdt3SvYg8OJXYDMo/eMBm+EXqrnHFRqJ/Kg2v/2fgO8/EGRqkotaeofebwWmxys3ryPLLGokt7rO54t4XFuOcUxWAAZ/vqvOd3EUmCLo5FiuY4bwJP63Bvs2zAzWkj0AAkiqZmON27/QyfCv4onbtdCm+DqoKvyuXWIf2vwKcaKn3oU8DQ5MjSLqfcJFtjk+Dju3bO6U7KXpN+SmV/DiMwnVFUXRdbNRMUY4j76HVj4ox8iGD9HjtTtzCHOZDm5uUYwzVyQwpLjRzUZiwc3bdubKUaq5hwIks4PWNIkYteBEdyn6WDss4cv6hctQJeIloGVctaq5ErFq14zRjTlyc9Tv2qdhL0KwxmbPNdsdBuOiaN58qKilFq0EHwsxcMfvYtDru+fZBEFLG5ZUiT5x+icb7Kc3KxCe/eDd+IsJVEPgI5JDNWoJzUZg8zJxvFHl/Fjuyo4A4ZcNuv0FQ2W1emD1nm4W/JuNqdLkIxhvRZl6TdHXU4N3Lzuh3/4lumwOg+c2RCs17E6TaFpwe0fxzQajwRx0TYoRrnj0OMBDzynTfEYUeemQvbufRBL12LWcvfG6iS4qzMh7FZ1LO+Dqdr2Q9QR9WA0C2VCwhuiBEQr9FG24LDOZtVVa/8x//LUkP4VcEzoErxg0KgDIdTBVK0ejr12UY9p1KPlpOf9gtrIxm9Hba1OsS1X3GhfaB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(31686004)(36756003)(86362001)(4326008)(5660300002)(66476007)(66556008)(66946007)(2906002)(31696002)(30864003)(44832011)(38100700002)(83380400001)(45080400002)(316002)(54906003)(110136005)(8936002)(478600001)(2616005)(6486002)(966005)(26005)(41300700001)(6506007)(53546011)(6666004)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHE1RHZUWk5uS0hpTVVQZXJIVFlISGxXTmR0ZFM5R29uVWh4R2J5ZzB4Ykpw?=
 =?utf-8?B?ZG5lck4wT1ExSHdXNThKNXZVYkFEdnNaZC92WXhLc1RGMXRYSnE1cmFYa0dF?=
 =?utf-8?B?bkdQaGErMmxodUY4TGt6b3dZdDcxREtqeDBWSDZscFBYc1dndXNHNTJiWXow?=
 =?utf-8?B?NnZrOCtaYU9GWTZKaE5xVmVaenlFTnZmRE8yNm1FTzZrZk9ReHRwZDZoVWEw?=
 =?utf-8?B?Q2hCZUFGRitVK3ZkdzJYOTNEcE5JOHRWTGVua0YrMVA0eGN3QSt6ZVN1djI2?=
 =?utf-8?B?b3ZSbTJIVGVIck51VlZFSkZVZXIyWXk4Ymk0L25nQUdzMFVXOWtneG9jbkFP?=
 =?utf-8?B?VkQ4YmV2bHZ0MWFQMytNdU1mWGVLaG9nRk1rUGlLZkQraGVvL3BHOThIaW5Z?=
 =?utf-8?B?aGpXY2RnbG93SGczODdWZzRoNlBNS3czcjJ4dVhBMHNXQnFaWERGbEFGRWlm?=
 =?utf-8?B?ejREbG1JY212UFo4dVVsSEp2WjBUb0lqZjJqNmZVVHpMbHFkZjBnMW5VZXBG?=
 =?utf-8?B?T0UrNUlsOXRQanVNamd2MisrZlhDbDJtZmdSRmFYVDN4S0RBOXQyQU1TcFJM?=
 =?utf-8?B?amV3eWdUelR3ajVQVUgwR3dsSHFNTzdSblNPRlovenJIOU01QlpkdndDQ211?=
 =?utf-8?B?ckpFWk5JNHhuQXdsUExHdTVGQ2FRV1VJN3NaSEdraGRUNzJwYkxsbFR5ZXVn?=
 =?utf-8?B?QXJpZW9Od09abjE0ZTNhWHBsTGVGa1gvajEyUEJub3lmS3dxdWhCNnZwZXVL?=
 =?utf-8?B?VFBvaU9xZEhEUXBrTXlqVzcxbTQzUWp0TmhsUURheVA1emdtc3lrUHFjRGpL?=
 =?utf-8?B?Qjl5N1RabVY1bXZxeUk2QzFHY3JkOFY1cTRlNzhsT01pRUZqL29lSzdCYy9Z?=
 =?utf-8?B?WWY4RS9PWndsSGhiMFNnajVIWk1BdXQzSHFEWVdSOVdVRVFienZKOHpxUi9V?=
 =?utf-8?B?S2dVZlVnQTA2T1pndDBmVlRlY2tZWDBEMCtnQkd2THFDeWNKMjErWC9VaTc3?=
 =?utf-8?B?ZXpSK0VEc3FPUFhMRE45R1NjVGNuYVovWEJ4cmhKckpVQmpvNlgvam5aZC9j?=
 =?utf-8?B?MytxWEtWdFM1TUY3VmhMNTVpRVArUGxmNmhXWkhWT1hSQURiTU9GMUR2Vm9V?=
 =?utf-8?B?SXM5U1VsMGQyNCt1c1lKcU9lQnhUclRJUnNRMEZWcktEOU9VdVpWRUs3NUZJ?=
 =?utf-8?B?bkZqSS9nc1BqaHFvbVhPUnJ5NVI5NnhkeUdaZlBOd0djVWJFNDhMdEFuenhD?=
 =?utf-8?B?MU0vUFNnaUpzNnIzRzdVVmNBUGFSUGNvQm1oOStiemRhTVFYR203TXdzM1p5?=
 =?utf-8?B?ZFVyREtKVitoVW9wTlpWTExxa0FRRDEwd2YxVDg2N3dNS3VYdU1nVTh1My96?=
 =?utf-8?B?d1MxTytNUzl4OGFBY0U5TXhxYnc2VVJlYmJ3aVNRNDlVV3lJN1pQRzZjTlhO?=
 =?utf-8?B?b3VFVDNoZVVqeGF5WHluNDdrZVprQ1VwcVNZRlJUQnkvbHhKNmVQRGpqVjRm?=
 =?utf-8?B?SEVia1d3Qys5SmNlUFpPYUllQTV0VWhRenUrdU50WkFMcjBhYURtR1d2dXVI?=
 =?utf-8?B?c1NyRElxVmJTS3R6TUlLYlJTK3FlcitjaFZHM0lWS2RXMHVhYy9SaU14VkJw?=
 =?utf-8?B?VDBqb0E5eGkwdTlpekFRZGtyNlluSmtaZklITXJCaDdad01lTHNUam9yUVU2?=
 =?utf-8?B?cEl5ZDc2dnZNZzV1RE1SWW9NOWhsY2xzem5uSjhrc0xpOEQ5RmtCdXBtTXgw?=
 =?utf-8?B?disySjVzR3gvRWVDSnBWT3FuM2xuNk1RVXZrcTFWY3l0OTBrOUp4Nk42U3Uw?=
 =?utf-8?B?M1g2eTVzdmY0Z0syc0dyYncvK2liWThBNzdpUkxvOUVCNzBuVityc0VNbFYr?=
 =?utf-8?B?cThGNE5DeHdxNnBhLzZNRVl5bVFadzZpcm5ZNW1FZXVNWmhSamxObjlzZU1s?=
 =?utf-8?B?aWRuZi9vVlZNVVVmS3kzTVpLaEU0aWJXbE1yYmhoZnFvaXZlQy9Ec2swd2F2?=
 =?utf-8?B?Q09ta01PWUNQZ1l1aXZYeDFta1NRR0gwQlkxdy90UUpLd3llL0RSc041RzNL?=
 =?utf-8?B?ekI2UXcweGRkQ1JIM21vbWZPVHFoUXlaMEk0ZWlCMXpUeDIvSER5djVscThW?=
 =?utf-8?Q?y6Wm6pbqSUbriFi7FWYwZSKXH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e46729-4f4b-425c-4481-08daee6b81aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 15:51:13.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNL1I2KgIN8GwNDliymYVvdYIvmUlq9qZale49QZXjh+AUhDGQeNiwnbjuNWSVXBf1Yqg3kI8VLRrPWr+/EzeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/4/2023 12:24 PM, Baolu Lu wrote:
> On 2023/1/4 2:55, Matt Fagnani wrote:
>> I reproduced the problem with 6.2-rc1 in a Fedora 37 installation with early
>> kdump enabled as described
>> athttps://fedoraproject.org/wiki/How_to_use_kdump_to_debug_kernel_crashes 
>> https://github.com/k-hagio/fedora-kexec-tools/blob/master/early-kdump-howto.txt 
>> I panicked the kernel with sysrq+alt+c. The dmesg saved with the kdump showed
>> warnings at drivers/pci/ats.c:251 pci_disable_pri+0x75/0x80 and at
>> drivers/pci/ats.c:419 pci_disable_pasid+0x45/0x50 involving AMD IOMMU and
>> amdgpu functions in the trace. Since those warnings' were
>> if (WARN_ON(!pdev->pri_enabled)) and if (WARN_ON(!pdev->pasid_enabled)),
>> pci_disable_pri and pci_disable_pasid looked like they were called when
>> pdev->pri_enabled and pdev->pasid_enabled were both false.
>> A null pointer dereference occurred right after that which made amdgpu crash.
>>
>> [   13.132368] [drm] amdgpu kernel modesetting enabled.
>> [   13.133766] amdgpu: Topology: Add APU node [0x0:0x0]
>> [   13.137596] Console: switching to colour dummy device 80x25
>> [   13.143717] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
>> [   13.143970] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874
>> 0x103C:0x8332 0xCA).
>> [   13.144205] [drm] register mmio base: 0xF0400000
>> [   13.144209] [drm] register mmio size: 262144
>> [   13.144310] [drm] add ip block number 0 <vi_common>
>> [   13.144316] [drm] add ip block number 1 <gmc_v8_0>
>> [   13.144320] [drm] add ip block number 2 <cz_ih>
>> [   13.144324] [drm] add ip block number 3 <gfx_v8_0>
>> [   13.144328] [drm] add ip block number 4 <sdma_v3_0>
>> [   13.144332] [drm] add ip block number 5 <powerplay>
>> [   13.144336] [drm] add ip block number 6 <dm>
>> [   13.144340] [drm] add ip block number 7 <uvd_v6_0>
>> [   13.144343] [drm] add ip block number 8 <vce_v3_0>
>> [   13.144347] [drm] add ip block number 9 <acp_ip>
>> [   13.144388] amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS from VFCT
>> [   13.144397] amdgpu: ATOM BIOS: 113-C75100-031
>> [   13.144425] [drm] UVD is enabled in physical mode
>> [   13.144431] [drm] VCE enabled in physical mode
>> [   13.144435] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ) feature
>> not supported
>> [   13.144491] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
>> fragment size is 9-bit
>> [   13.144503] amdgpu 0000:00:01.0: amdgpu: VRAM: 512M 0x000000F400000000 -
>> 0x000000F41FFFFFFF (512M used)
>> [   13.144511] amdgpu 0000:00:01.0: amdgpu: GART: 1024M 0x000000FF00000000 -
>> 0x000000FF3FFFFFFF
>> [   13.144524] [drm] Detected VRAM RAM=512M, BAR=512M
>> [   13.144529] [drm] RAM width 64bits UNKNOWN
>> [   13.144623] [drm] amdgpu: 512M of VRAM memory ready
>> [   13.144630] [drm] amdgpu: 3572M of GTT memory ready.
>> [   13.144653] [drm] GART: num cpu pages 262144, num gpu pages 262144
>> [   13.144705] [drm] PCIE GART of 1024M enabled (table at 0x000000F400600000).
>> [   13.158820] amdgpu: hwmgr_sw_init smu backed is smu8_smu
>> [   13.175036] [drm] Found UVD firmware Version: 1.91 Family ID: 11
>> [   13.175097] [drm] UVD ENC is disabled
>> [   13.186675] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
>> [   13.187879] amdgpu: smu version 27.18.00
>> [   13.193760] [drm] DM_PPLIB: values for Engine clock
>> [   13.193773] [drm] DM_PPLIB:     300000
>> [   13.193776] [drm] DM_PPLIB:     480000
>> [   13.193779] [drm] DM_PPLIB:     533340
>> [   13.193781] [drm] DM_PPLIB:     576000
>> [   13.193784] [drm] DM_PPLIB:     626090
>> [   13.193786] [drm] DM_PPLIB:     685720
>> [   13.193788] [drm] DM_PPLIB:     720000
>> [   13.193791] [drm] DM_PPLIB:     757900
>> [   13.193793] [drm] DM_PPLIB: Validation clocks:
>> [   13.193796] [drm] DM_PPLIB:    engine_max_clock: 75790
>> [   13.193799] [drm] DM_PPLIB:    memory_max_clock: 93300
>> [   13.193802] [drm] DM_PPLIB:    level           : 8
>> [   13.193806] [drm] DM_PPLIB: values for Display clock
>> [   13.193809] [drm] DM_PPLIB:     300000
>> [   13.193811] [drm] DM_PPLIB:     400000
>> [   13.193814] [drm] DM_PPLIB:     496560
>> [   13.193816] [drm] DM_PPLIB:     626090
>> [   13.193819] [drm] DM_PPLIB:     685720
>> [   13.193821] [drm] DM_PPLIB:     757900
>> [   13.193823] [drm] DM_PPLIB:     800000
>> [   13.193825] [drm] DM_PPLIB:     847060
>> [   13.193828] [drm] DM_PPLIB: Validation clocks:
>> [   13.193830] [drm] DM_PPLIB:    engine_max_clock: 75790
>> [   13.193833] [drm] DM_PPLIB:    memory_max_clock: 93300
>> [   13.193836] [drm] DM_PPLIB:    level           : 8
>> [   13.193839] [drm] DM_PPLIB: values for Memory clock
>> [   13.193842] [drm] DM_PPLIB:     667000
>> [   13.193844] [drm] DM_PPLIB:     933000
>> [   13.193847] [drm] DM_PPLIB: Validation clocks:
>> [   13.193849] [drm] DM_PPLIB:    engine_max_clock: 75790
>> [   13.193852] [drm] DM_PPLIB:    memory_max_clock: 93300
>> [   13.193854] [drm] DM_PPLIB:    level           : 8
>> [   13.193973] [drm] Display Core initialized with v3.2.215!
>> [   13.309967] [drm] UVD initialized successfully.
>> [   13.511031] [drm] VCE initialized successfully.
>> [   13.515217] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>> [   13.515442] amdgpu: sdma_bitmap: f
>> [   13.515549] ------------[ cut here ]------------
>> [   13.515555] WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:251
>> pci_disable_pri+0x75/0x80
>> [   13.515571] Modules linked in: amdgpu(+) drm_ttm_helper ttm iommu_v2
>> hid_logitech_hidpp crct10dif_pclmul drm_buddy crc32_pclmul gpu_sched
>> crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3
>> drm_display_helper wdat_wdt serio_raw hid_multitouch sp5100_tco
>> hid_logitech_dj r8169 cec video wmi scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse
>> dm_multipath
>> [   13.515620] CPU: 0 PID: 477 Comm: systemd-udevd Kdump: loaded Not tainted
>> 6.2.0-0.rc1.14.fc38.x86_64 #1
>> [   13.515628] Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52 12/03/2019
>> [   13.515634] RIP: 0010:pci_disable_pri+0x75/0x80
>> [   13.515642] Code: 54 24 06 89 ee 48 89 df 83 e2 fe 66 89 54 24 06 0f b7 d2
>> e8 1d e1 fc ff 80 a3 4b 08 00 00 fd 48 83 c4 08 5b 5d e9 2b 8b 69 00 <0f> 0b
>> eb b6 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
>> [   13.515651] RSP: 0018:ffffbaf4407ab8e8 EFLAGS: 00010046
>> [   13.515658] RAX: 0000000000000000 RBX: ffff90aa00ac4000 RCX: 0000000000000009
>> [   13.515663] RDX: 0000000000000000 RSI: 0000000000000014 RDI: ffff90aa00ac4000
>> [   13.515668] RBP: ffff90aa0e0c3810 R08: 0000000000000002 R09: 0000000000000000
>> [   13.515673] R10: 0000000000000000 R11: ffffffffade4e430 R12: ffff90aa011a8800
>> [   13.515678] R13: ffff90aa0e0c3800 R14: ffff90aa011a8800 R15: ffff90aa0e0c3960
>> [   13.515683] FS:  00007fabd67feb40(0000) GS:ffff90aaf7400000(0000)
>> knlGS:0000000000000000
>> [   13.515689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   13.515695] CR2: 00007f5689ff54c0 CR3: 0000000100f16000 CR4: 00000000001506f0
>> [   13.515700] Call Trace:
>> [   13.515704]  <TASK>
>> [   13.515710]  amd_iommu_attach_device+0x2e0/0x300
>> [   13.515719]  __iommu_attach_device+0x1b/0x90
>> [   13.515727]  iommu_attach_group+0x65/0xa0
>> [   13.515735]  amd_iommu_init_device+0x16b/0x250 [iommu_v2]
>> [   13.515747]  kfd_iommu_resume+0x4c/0x1a0 [amdgpu]
>> [   13.517094]  kgd2kfd_resume_iommu+0x12/0x30 [amdgpu]
>> [   13.518419]  kgd2kfd_device_init.cold+0x346/0x49a [amdgpu]
>> [   13.519699]  amdgpu_amdkfd_device_init+0x142/0x1d0 [amdgpu]
>> [   13.520877]  amdgpu_device_init.cold+0x19f5/0x1e21 [amdgpu]
>> [   13.522118]  ? _raw_spin_lock_irqsave+0x23/0x50
>> [   13.522126]  amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>> [   13.523386]  amdgpu_pci_probe+0x161/0x370 [amdgpu]
>> [   13.524516]  local_pci_probe+0x41/0x80
>> [   13.524525]  pci_device_probe+0xb3/0x220
>> [   13.524533]  really_probe+0xde/0x380
>> [   13.524540]  ? pm_runtime_barrier+0x50/0x90
>> [   13.524546]  __driver_probe_device+0x78/0x170
>> [   13.524555]  driver_probe_device+0x1f/0x90
>> [   13.524560]  __driver_attach+0xce/0x1c0
>> [   13.524565]  ? __pfx___driver_attach+0x10/0x10
>> [   13.524570]  bus_for_each_dev+0x73/0xa0
>> [   13.524575]  bus_add_driver+0x1ae/0x200
>> [   13.524580]  driver_register+0x89/0xe0
>> [   13.524586]  ? __pfx_init_module+0x10/0x10 [amdgpu]
>> [   13.525819]  do_one_initcall+0x59/0x230
>> [   13.525828]  do_init_module+0x4a/0x200
>> [   13.525834]  __do_sys_init_module+0x157/0x180
>> [   13.525839]  do_syscall_64+0x5b/0x80
>> [   13.525845]  ? handle_mm_fault+0xff/0x2f0
>> [   13.525850]  ? do_user_addr_fault+0x1ef/0x690
>> [   13.525856]  ? exc_page_fault+0x70/0x170
>> [   13.525860]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> [   13.525867] RIP: 0033:0x7fabd66cde4e
>> [   13.525872] Code: 48 8b 0d e5 5f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
>> 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
>> 01 f0 ff ff 73 01 c3 48 8b 0d b2 5f 0c 00 f7 d8 64 89 01 48
>> [   13.525878] RSP: 002b:00007ffdd89bc6a8 EFLAGS: 00000246 ORIG_RAX:
>> 00000000000000af
>> [   13.525884] RAX: ffffffffffffffda RBX: 0000563e4d23f0a0 RCX: 00007fabd66cde4e
>> [   13.525887] RDX: 00007fabd6817453 RSI: 000000000174fb66 RDI: 00007fabd3bd4010
>> [   13.525890] RBP: 00007fabd6817453 R08: 0000563e4d237c70 R09: 00007fabd672f900
>> [   13.525893] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000020000
>> [   13.525896] R13: 0000563e4d239060 R14: 0000000000000000 R15: 0000563e4d23e450
>> [   13.525900]  </TASK>
>> [   13.525902] ---[ end trace 0000000000000000 ]---
>> [   13.525964] ------------[ cut here ]------------
> 
> This (including the following) kernel traces are triggered by the
> following code.
> 
> 1698 static int pdev_pri_ats_enable(struct pci_dev *pdev)
> 1699 {
> 1700         int ret;
> 1701
> 1702         /* Only allow access to user-accessible pages */
> 1703         ret = pci_enable_pasid(pdev, 0);
> 1704         if (ret)
> 1705                 goto out_err;
> 
> [--cut for short--]
> 
> 1724 out_err:
> 1725         pci_disable_pri(pdev);
> 1726         pci_disable_pasid(pdev);
> 1727
> 1728         return ret;
> 1729 }
> 
> pci_disable_pri() and pci_disable_pasid() are called with PCI PASID and
> PRI not enabled. There are WARN_ON()s in the pci code for such cases.

Yeah. Error path needs to be fixed.

> 
> This happens in the domain attach device path. I haven't figured out why
> the failure of PASID or PRI enabling will cause the domain attach device
> to fail. And also why pci_pasid_features() and pci_pri_supported() are
> not called before pci_enable_pasid/pri().

PASID/PRI support is verified in amd_iommu_device_info().
For AMD GPUs (PASID/PRI supported devices)
  - We allocate new domain called V2 domain and then attach device(s).
    amd_iommu_init_device() - > iommu_attach_group()
    In attach devices path :
      amd_iommu_attach_device() -> attach_device()
      If domain is v2 domain and device is PASID/PRI capable, then we try to
enable PASID/PRI. This is where we are hitting WARN_ON.

I think if attach device fails then we should put the device/group back to
default domain so that we don't hit these warnings.

Matt,

Can you please test below patch? (its not a fix to original issue, but to avoid
kernel warnings/traces).

> 
> commit 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on
> upstream path") requires ACS P2P Request Redirect and Upstream
> Forwarding are enabled for the path leading to the device when enabling
> PASID because PCIe fabric routes Memory Requests based on the TLP
> address, ignoring any PASID. I guess this is the reason why
> pci_enable_pasid() returns failure and discovers above buggy code.

Can we get the lspci -vvv output. It will tell whether ACS request support.


-Vasant

-----
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..f81ab787eee1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1702,27 +1702,26 @@ static int pdev_pri_ats_enable(struct pci_dev *pdev)
 	/* Only allow access to user-accessible pages */
 	ret = pci_enable_pasid(pdev, 0);
 	if (ret)
-		goto out_err;
+		return ret;

 	/* First reset the PRI state of the device */
 	ret = pci_reset_pri(pdev);
 	if (ret)
-		goto out_err;
+		goto out_pasid;

 	/* Enable PRI */
 	/* FIXME: Hardcode number of outstanding requests for now */
 	ret = pci_enable_pri(pdev, 32);
 	if (ret)
-		goto out_err;
+		goto out_pasid;

 	ret = pci_enable_ats(pdev, PAGE_SHIFT);
-	if (ret)
-		goto out_err;
-
-	return 0;
+	if (!ret)
+		return 0;

-out_err:
 	pci_disable_pri(pdev);
+
+out_pasid:
 	pci_disable_pasid(pdev);

 	return ret;
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 864e4ffb6aa9..4228e44b4950 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -815,6 +815,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	return 0;

 out_drop_group:
+	iommu_detach_group(dev_state->domain, group);
 	iommu_group_put(group);

 out_free_domain:


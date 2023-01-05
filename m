Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9C65E93D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 11:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjAEKqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 05:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjAEKqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 05:46:36 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F653D9C5;
        Thu,  5 Jan 2023 02:46:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQd0Qsrx7AqflRuGEMZeHt9LGzEhWDYGKXqKs9WP3Zj8+AyhIZUhZkBt3mgdMTL6UpVAvU8FYOUEeWMdVjlaIdPyT3UxVMyWETJPflhJzESif8mYHCIhbn3SZNU259FDtpau2ZJlfKbbbl/7oATvunjZbi62rARMwfLfp6p37UwT9/oNuF0Vrl3MQWsrcYTK1dk6s15bs+O5Ac2GhgXCV7qD5uRH8nOsvNHdWU/ZGqyflrN6YnFw4xU0zrKkq/PDUgflsX2I1wh5YHY1O15R7p/znOfRiwUR1aO1UKL+B+w2PbJTheVWwPCr4Cs6b6mpYwGV67uJK2yK2Cpf0t/CLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzOR7M5MMtY6U51Ebpt6eVVqONQrnMeDIgLtKdkY9IY=;
 b=U8w96lTDsJH3C46Ic9vS+9lFLeepjXcUj9map/Hgg/jCgNQaCXa/J3E4VBKR29w3yAUGXLTR0x199sVieq4USICMfhl0aKVT1UFN9tdbX8t3Y+R4GBMbDaoJ8ucrX5V73uC2eLEOZrLZQAeDJKRclqf1+GZicU94LqbR2skTiI1+1iwHHaynxFf1BfK5z6N5KImZ34kq+HQsR61M49crQK2nJadhcxWiwENYb79o63+9NZR2I4a+N16as2xc8soZ/nDL+CA90j75NA8vX35TiYNVdJsGARAsRkSvz5BhJHakz/s7VhVZkxDk1mt3pW3JkssMdma724BJ8LThcQ9X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzOR7M5MMtY6U51Ebpt6eVVqONQrnMeDIgLtKdkY9IY=;
 b=gbKzFjKKRUVnwU0s3Jgi3wedZDvhgeVavkjO5gs2OlYgiDBODCKncWZh9qQdgndrG0hOCeAlfqis2nbBXkIQwgohDRebGTq6ydv9gWYKr6pPaWYg8AZMUXB4Euk4+xOD6ULmHmKNTxSKgKgDPeASRD8apaDwpr6H48bPn/l0O0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 10:46:33 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:46:33 +0000
Message-ID: <86099ef0-5a8d-bd1e-4e38-a3b361a68f10@amd.com>
Date:   Thu, 5 Jan 2023 16:16:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Alex Deucher <alexander.deucher@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <6b5baa30-c218-0845-d6c2-32ac21ed6a6d@linux.intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <6b5baa30-c218-0845-d6c2-32ac21ed6a6d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: e058a813-a7dc-4ba1-ed8a-08daef0a1c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skHuxbQkbfJGgQVr/zHrTefBR09SOXsCAVd1Z+s0KOZNn3hAPl5eQqhgAv1d7m21EQXmUbHW5XYTMJ3vKJXss/OTlo63tlMyPXq4QNPtnW3qrgo8kesyfbjtrEzt3FzDIkiTzoyw7smcRuhbT1CX7dLY/iGlr6F2vOauPwSwRnRYBYCflvevz5nhsfWZU3fveL/RDcnwa65q+fm+kW6M8fExVB63M6espD5jR45mto1GohwRnFD9hCOY3Dj5ORjxl6U94dxeCUNkAtUbc479YRksUebWlci9bo+1+uMbIdNI3w8+uWjVQ5mSJgd1SLIfuEOPTGNfkQXw5tSD5UiZNacdgJS64aN8GOoMp/InwJ5aVucS0HXuc4Vw6bJ8/TEbNcY6HCUiPO2Sv9VxU3jCPdCudAsRMyJ5BOqr92qPKrsuDvOleC01rv+LYfBH+oLRt+J73WRpirscGrtyWlGuaTJ9g69HEV8PIK1OMgWe6NUjSuuTsvvyZyn3PyTyEsTRO1RydZzYA4/RIh5j97V/nFi9fQQAQ10+ABQIAq4G+wS4vhu3pJMKwLONiLz48H694gxkJZ8QDhXSxnDu4tpR68u4PBFE1F7Pqo0LQ38qJV0klHaKDulSlP3maNVMZboqFjdShZVjV5vke1wG/u5eN7X7Bo3LgznXagFZI9pG9iVIbPfhnB1fJNylwuF2PLFtskKq7nRUnvI1JEqfjr2Berabufvz4JNomUOrqpdBw8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(54906003)(186003)(31686004)(110136005)(26005)(6666004)(478600001)(66476007)(66556008)(2616005)(6486002)(66946007)(6512007)(83380400001)(44832011)(8936002)(5660300002)(41300700001)(4326008)(2906002)(316002)(86362001)(31696002)(38100700002)(6506007)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNMQkYwMUs3K1FIc1RtN1hqS0lOVG1RbmZwVW8va1RjOVJoblgzTlgrak1O?=
 =?utf-8?B?V1ZpYkxxNm1nck1DZWI2ck9HSUorM3NuVUN6bHJYTlhYZ0tFOVlWb2dsT2I0?=
 =?utf-8?B?eDAyVFAyb3Q2WnhvK0JZR3czY2ZJNHJuTmxqenJiSVhIT1ZFME1zTTVKSGN3?=
 =?utf-8?B?aUozeWprSEQwVEpYajFzbm5hY3hocUtEZllXdDVPZytFdHJuMU00cHNRTDVt?=
 =?utf-8?B?a29UZ21tQkMvTEQxKzI5R2xUVHdmY1VNcm44YnNrRGNqakVxdUlxcHB1Q0xy?=
 =?utf-8?B?UGpyVFpWbTE3V2dldzgySkdPTDBqdmtGRUtiQllpWjVMUTUxR2ZlYmVjOEVG?=
 =?utf-8?B?S0RmYXBBWkpzTlJYMTFDQWFZcm9RWWx4elg5Z3dMUytlelEvNUF6Y1ZuZHR3?=
 =?utf-8?B?MnFVdmRTbmtDenI4ZXpKaDJJTzJuRmhuTlVZblpyNGJDam9zNlVscWVGVzl2?=
 =?utf-8?B?ZFRock0xMG9CMktRMlA5clpJaFdmOHVRUlpCWEZDNkdQcjBpZ210UlEzYjdC?=
 =?utf-8?B?d2xPSWtUdU43MXFyZnNsYzlTQzl3eG1CTEJzM0VmM2Vkd1ZCeGZ1UC81R0NN?=
 =?utf-8?B?aVIvNWJvUmh3Y3pkMzFkeWJIRktSUmxCOERxOU5TZ1MwRkwxSWhjRHFaR3VX?=
 =?utf-8?B?dWlpVEVaUE1hQ1M5ZU1jK29MNWl6anB3bmJIaWdBRUxnQjBmYjdDeWR4eUMw?=
 =?utf-8?B?d3dpamYrR0E3b3NiNnJCUVZ0ajdUNUpPcDhQazBlMnJaVGJVVmhGVkhoV3R0?=
 =?utf-8?B?bVZMS2RxemVROXFsb0hNWFVGeDRSWFZidUNSRzhuc1pWS0d6cjVPVEVYYlFJ?=
 =?utf-8?B?MXRhN0Y0ZEp4Z1lxSmRUcXowc3RnRFVoNGU4ZW8xcWpkOUlXSzdaMTJEdFdu?=
 =?utf-8?B?bHlFcjc4VVFqc3BXcm1RclUyZXhHWEs5YzU5UWlYNkNjcUZIbm5YdGdXSjU3?=
 =?utf-8?B?d0JZS1VoRENLbkJOcGxXdFptLzZVRTVjclNpVzZoTHBsaEhmenBQYjJSOTZi?=
 =?utf-8?B?QnFvWmxxQWZiQjhySXlGUE1hYmVhRmc2MjRMU1kzMVpucGphbUxid1laWits?=
 =?utf-8?B?ak5wTTJGMjkwZG9ybVV5RExxMisxRkNQQUFpWEZxZjR4M2REd3RVdVJMNC9k?=
 =?utf-8?B?a0xKODVRVmtsT014TDlEN1dsSVNGb2VRelR4STRBUjlXTnRRaEFKSlhONENo?=
 =?utf-8?B?UTI0cHltOU50VEVnMkNLSWQybEpnMVRaNWNWc3RHSVF1cVlna05pcWtjOXo2?=
 =?utf-8?B?WDh0M29VTmdhSGk4b292eEVRK2ROZzRIeXlSTE14TFRnZU5EczNtUzVlWHl1?=
 =?utf-8?B?aUFHemtSbTFRL3F2UGpoaHBDdi9DdDhqUnJmOWNmRXVtUzdjVGUvQThkOUZO?=
 =?utf-8?B?dW1xQXpOOG5EdFg1MkEzUml1RFIybGJGUVZiSHprVkxoaWszWi9SNFEwdkV1?=
 =?utf-8?B?VjVuS1Q1b1dxVzN2N1dDVG9CSjVSR05zRjBPUHhaZk9iaG1jeHhiMmE1OGQ5?=
 =?utf-8?B?VS9ESGNjNVp0RXlGYStJTnVpK0dkdjU0c3NuZWpiZ3RXS0FWTm43eURFTmZV?=
 =?utf-8?B?WmRRdVdxajBtckc3cDV2TUh1ejdsS3o5UnBvTjdZNVNDbnlHNFZYa0g0QXM3?=
 =?utf-8?B?by92eDhWZDRoRjVUcmhhTUFuZy9BdE04U2tvMUpUV0E3bld6TU0wRGJiODhz?=
 =?utf-8?B?Y0RWbFYyYlhHUHY1UEViN3FEWHVrTGdwejZBbjlvTXFlZDkwVnVqZDRzZnBJ?=
 =?utf-8?B?Z1dibzZQUDlBOEEzMEowdXhIRnBadmVmWlhOajdTbmFGbVhzaWIxSnNxK0xi?=
 =?utf-8?B?MVVNV1RqbGpkNkFGZ3dUdzFkNEVjdXFOTXFicTJ5Tm9mOHRpTjBtN2hIREd6?=
 =?utf-8?B?ZWFhcXFmVlE1SzRiRWpleGFGeDJpaDVXdXZuOGMycEpyc2xmbUx4Ulk2TW1o?=
 =?utf-8?B?NFRlRURPUFRBOXdsc2NCcUN2QkxaMktBT0h1TlBydWswZkNEakRaZVlKeHdF?=
 =?utf-8?B?VjREeDZRT2xYN3htczJVQ0REcGZSWTNoYmZRZXluOEh3RmYxL2dRY1grck1J?=
 =?utf-8?B?MmMyZEtJWjdzUGliZnpKZHFzTk8vdUFGKzV1NStrRFA2WmxIcFJ6L2FxOFNm?=
 =?utf-8?Q?5v3c5TZUtE4Isb1gGHdW7GrYK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e058a813-a7dc-4ba1-ed8a-08daef0a1c6d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:46:33.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JrbJUeeqH0CiyjVv80yLsenIE0dEbIJBjkNtlWNTceuRJ2HRy7WCPfp+lUt/KcINyB77CZWwMHhGlSrrEEJ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Baolu,


On 1/5/2023 4:07 PM, Baolu Lu wrote:
> On 2023/1/5 18:27, Vasant Hegde wrote:
>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>> I built 6.2-rc2 with the patch applied. The same black screen problem happened
>>> with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
>>> patch twice by panicking the kernel with sysrq+alt+c after the black screen
>>> happened. The system rebooted after about 10-20 seconds both times, but no kdump
>>> and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
>>> requested.
>>>
>> Thanks for testing. As mentioned earlier I was not expecting this patch to fix
>> the black screen issue. It should fix kernel warnings and IOMMU page fault
>> related call traces. By any chance do you have the kernel boot logs?
>>
>>
>> @Baolu,
>>    Looking into lspci output, it doesn't list ACS feature for Graphics card. So
>> with your fix it didn't enable PASID and hence it failed to boot.
> 
> So do you mind telling why does the PASID need to be enabled for the
> graphic device? Or in another word, what does the graphic driver use the
> PASID for?

Honestly I don't know the complete details of how PASID works with graphics
card. May be Alex or Joerg can explain it better.

-Vasant


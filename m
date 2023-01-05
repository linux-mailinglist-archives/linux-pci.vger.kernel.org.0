Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC565F00F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjAEP1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 10:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjAEP1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 10:27:30 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0D3D9CC;
        Thu,  5 Jan 2023 07:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA00of1PhD0QFH/tepkILdncpewTNTpgxtQFsApQCJReeU0Ql5evtVfOst+3CKaZaD2+kv7NXOe5NH2LI8XUELgmINGmL4pk6ww2pNXSVAWoHpq0vI4Clv2DwIMVHHbqJQ6iG+iyjTmhBdW8UJkRytPtqgk+qFQg6+2qvDK0K134oCMX+NGNP0DXXchAYDZIFVDj3/lP1iSzFsH+dK1fT5139OF3JU2NSvMc8PLJUNcyL3kZ0Rh9a0RNC7o9pmK8WenEFIWGu3D5N2mZ3pgE7gSJq0/hdKmU2ygpSMRG4Xzh2VGgrgxiBG9BYTq/VbujiEwrWnqPMuvGqso7tbm37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wOLw3SkgGmfYYjJZ2pYlAYL3E5bEKLqPTAB8SQ3GhI=;
 b=FC0KM3EH8U5yt1q00iSp/DoCpvNU/tbzOrQHAVXUgNIqlt6mcFSaik45jSwS7rRTnAcpPPruhXWeOjKijaC6bOTx3PBjSZGqwtPJ/BYdHYOVFgzyhFugvtFiAwATQGMjNEhdRI0JZ2Av6u4jGF5+ZwBs+/ledEA1srjCiHs5QyeRTFvxcmopdnfH/EWf6iPHM754q3e6a4Se+AXyjJHyD8RxwSpxQOzRE8TJtpKekjXr6eJMl14cMJfcVP0SIaHi7JNpNU+RIgZT9K8Z4VoXfeAynr+JbbI3cbDT52vLawsYzVn6N2tXYkFSf/Q1tW2Rl3Bz83dkVeqIriMbq6ejpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wOLw3SkgGmfYYjJZ2pYlAYL3E5bEKLqPTAB8SQ3GhI=;
 b=0kz4vRrkPf1YQWT3o1Fh3Qhmvi/rhQch8eRGLZQE2Jbx5znHf1H3nSz4KvYEsqjmA1CVHvqDjvQg6Txv57HcaxQgCwenbJ/aMEJwSgGvuRDVXt2YtmalMnDziqnDitFinAlIfUjUODp1mQHsZs/hWAff586T9J2npvTL8z7pgI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:27:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:27:25 +0000
Message-ID: <12db77f6-736d-a423-4cc0-e536eb7bb712@amd.com>
Date:   Thu, 5 Jan 2023 10:27:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
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
 <86099ef0-5a8d-bd1e-4e38-a3b361a68f10@amd.com>
 <BL1PR12MB51448996E36254ADC80B5BF6F7FA9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <BL1PR12MB51448996E36254ADC80B5BF6F7FA9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0085.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 432f6ba8-a0e4-4831-9fe3-08daef31590b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccsmt9mgELu8Ea0VnTNf3fzQW4N4tOyhPDHDnqqkMR10OOdGE+KtoUlphXquP7Wv1nf0xqTUd/32mG6P6vUAmac+YYaX0Yf+NrAY7/PKNNZjoVEDIWy+MJyuwfDUSl1//2H4/XsUhWi2V+GuqfbBE0npg7If0TZtBRSaetXMSLmdketepoB6mXVffhRjPJZw5pFz0pxYQHnFtM8EQdcAUT6YhdiXPghrfOjuQ77PqNFLja5ExuNAsPvfNw9+V7sumnIQtZSYzDCK9MtXoGjSBL/hnqedL35Wwdk/HZQ4mwFV/V0TeyEkcNnJW6rcTMXe/KIFnkqXngOuOVlVcxfVGNLyIQomem/OjspBubjcAO62eA4qAJz1p5xOxYb0mDuLRbZ2ot0bu4JZLD+uSTAqz7t2yxSSPyqw2QqlvDMlgPpE4ewtrtF27s2qg5UqbXc26Uh4GdtbnPoq+1qcRHYEOfogdfMnneX0RSRBWnSDHdDXb81/KPrFp9B6E+k3Iy1oH5b+HI61o2Xg2E4G5nMqgxtfIZNGwDCz3w8ynCnrXsTl6qWDl0bWri/kPWvGSOtES62dcGnNALla0qeIRYXQhCwY7aw302smPGIFyrpI2m/eoI5Pel0rLr/6MBBIGINyq554ZHja4trgrQttISJ4JfaHwmKFwEy3sFYthP6WjhZpGisVKylAZWebQExKD4ZTp3uUQBBPCt7FIcD9oxVB/p5Pofi6kUElTqrJiU1ouuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(38100700002)(36756003)(31696002)(86362001)(316002)(54906003)(31686004)(53546011)(110136005)(6506007)(6486002)(478600001)(2616005)(6666004)(26005)(186003)(6512007)(44832011)(5660300002)(83380400001)(2906002)(66556008)(4326008)(66946007)(66476007)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnRnSGQrWXQvQjlOVjJ6NCtNem9QOG42SDZ2RGJvOFlHQko3SVJneFRreUpo?=
 =?utf-8?B?MmZKMVcwTVlUb0NRV2g0bFJhdEZZSXVRU3pVV0trWDA3aytRV3lOelJtUHBo?=
 =?utf-8?B?UkhkZ2g1ejIzS1RBaWJLUkp5dERzVkJEaU1kOHpIZTV3VW0wL2U0NFlmeE5T?=
 =?utf-8?B?czhLMWpha3ZpQzN2OG8rTVo0eGFxeGsyWlhpR3pxazlhNitaY0g2Q3lBSCtO?=
 =?utf-8?B?WkRNUmxpYkRIUFB4TlorL2dYSjVDU0dmMEJPUTRNaVNGeXdqMEN6WXprck96?=
 =?utf-8?B?cTNMQkxrUkE4REVqVTRoMElVZUFxNU5qblRKLzI0THJRb1h4RUlva1ZXMDBq?=
 =?utf-8?B?ZlNzL0tpSUtmMFdGZHYwQXNRaE54Z2NMVXZtanBvUG9BaG5HWmdtdnZDWGF2?=
 =?utf-8?B?L0J3MTM4bVpvaFkrK2tyL3E3QmhxSEVqUEFYMTMrd0phcjZSUGVFWnIxVnBp?=
 =?utf-8?B?dnB3bkp6THJISkM0ZXpMS0ZkbTUzSEQ2RXF5Ymx4ZHU1YS8zQUF2RWxnSFFu?=
 =?utf-8?B?dUdoS3llOWxaSWMwMjIwdWlJRDduSzNHQSt0azRib3F3UW9GQzJGT051a0Ji?=
 =?utf-8?B?QjNNaXJNNjE1SFduQVFmUWNManYzUHoxeXZQcE5TZFJxRnFlK2hhb2FnTHp2?=
 =?utf-8?B?MjlrejdTbForVTFpYjF2Qm4vTGY3ZHVwVFdzUHRsTFlscDhkNm1PY1U2amFw?=
 =?utf-8?B?cElZUXFQTzEyMTdHM0hITll1NDFXSzZZaHlmWjY4dFE4ZGUvcHR5dUt1MVdP?=
 =?utf-8?B?bk9YL0wydXM3MlhjMTFHRm96QjdCaTRTa2trUG1HSXJBVSs3LzhhUTFtdjhq?=
 =?utf-8?B?MG1ZUzZPMG9MdzF1SUNYZTZkK3JuSUk4QnBVRWtpcDdFMis1UFY0V0gxME1V?=
 =?utf-8?B?VG1Pd3dYcnBTMFUxUTh6WVBkaXJRZnY4UHR2bkdpdVk5bWNCQzZUM1ZiZ0ox?=
 =?utf-8?B?MFIxTjdadVF6OU1Da0VoaVBwMWRNVDhIUzFwd0t6ajYvSW82UElwWUlzdnBv?=
 =?utf-8?B?QTM3c0xnZkdOQlltU09QQlpWMmhBK2E3Z2hTRGcxR2Qya1NVYnRVbWhjbnB3?=
 =?utf-8?B?REF6T0s1b0FSSTZWT0FiWUtCMkZkQmxOTG52bVJhdU0zL05jU2N5K0VKOUxn?=
 =?utf-8?B?enNUUTlPNlB4b0dXY09TSFdDWTQ0dEZMN09tYjBHTVZVd2M2dmNNK01PeU1i?=
 =?utf-8?B?em9ZNkYyUVhOT1NmeGlFSXp3OFlUNWVPelhvdWpQamd5OWVNbVdlaG8wRjBN?=
 =?utf-8?B?b1phMHdMbm9yQW9PMk90UVk5QnBacjJteVJMWFhSbmo4UUNTaDM0UUR0U3ZM?=
 =?utf-8?B?ZExOWG4wd2tJTEZ4cSs2L3pjZkExR3NKM3lNa3NmMm9taXBNZWIxQ2s2dERh?=
 =?utf-8?B?TU5sU0xyL3owOGp4VkplSmtmWnR2OGZFRjJIZW9xVUorbUVJb2RCS0FGWWFE?=
 =?utf-8?B?TmxFVmJCQ1dMZk40Sm5uVGZSWjlLSFdXeGozMWFWK0dTR3FFL1BJWElrRlJM?=
 =?utf-8?B?bmorU1RlT28wWURRaDlwcUxiRWFETXk1NGpmQyswcEUzSEdGbVZNR0IwdmRv?=
 =?utf-8?B?MDJLajk0SjNEdnRxZXE4dkFHcExUYnRtUDBHckIwenhwK2hVZUxQQWxxMUVW?=
 =?utf-8?B?TkJkT0ZiSlREdmRGdjErMC9LbThERmdsQlh3SjRoaGNVSkpRWHQ1ZFNhREhS?=
 =?utf-8?B?WDNLTGRqK3JsRWQ4RGE3bk8yazE1bll5TXl5TjkvNDRZT1hOTy9NV3B1Ujhs?=
 =?utf-8?B?U2h5NnBrMnIvSkhFSjBZcGo4c2k3VERTU3lhWXBnTjNRalR0b3dYYUJCSkVr?=
 =?utf-8?B?RlU3czVDN01sMWtWdWhqRnZ0OUU0R3gzN2t4M1V5Y1VyTCtKRzBxVk1mNWtx?=
 =?utf-8?B?aUc0YS83VXEyWFZSWENYL3cvVVhjSzhITExzVTkvT0Y0cFp6WFljanBxRTRH?=
 =?utf-8?B?K1BOZnBOS3FsNlk0em84OUc3bFZBNzIvR21PNEpkWWRMZjV1dmhSc3FHNGhF?=
 =?utf-8?B?U1pMQXhUVGVaemQ3cWplNzRHYzJwWUZWU040TW5WWEs4UWJRSEVQcUpTeklC?=
 =?utf-8?B?WGVBZFBPNGNIWitmUjcvcU9IbEtmdnhTL2plTFdqeTY4bFpTcDdxdlJkM3Mr?=
 =?utf-8?Q?6QbyBil4SluEm9OEmc+cxK1TU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432f6ba8-a0e4-4831-9fe3-08daef31590b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:27:25.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPT2TiNghBD5EdfUiMCpsazlQ73Ertm/P31h4EeFQi2hlt6/kULYAfs9jWfJBLMqFH8UCodbZhChmgR4UnrojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2023-01-05 um 09:46 schrieb Deucher, Alexander:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>> Sent: Thursday, January 5, 2023 5:46 AM
>> To: Baolu Lu <baolu.lu@linux.intel.com>; Matt Fagnani
>> <matt.fagnani@bell.net>; Thorsten Leemhuis <regressions@leemhuis.info>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Joerg Roedel
>> <jroedel@suse.de>
>> Cc: iommu@lists.linux.dev; LKML <linux-kernel@vger.kernel.org>;
>> regressions@lists.linux.dev; Linux PCI <linux-pci@vger.kernel.org>; Bjorn
>> Helgaas <bhelgaas@google.com>
>> Subject: Re: [regression, bisected, pci/iommu] Bug 216865 - Black screen
>> when amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
>>
>> Baolu,
>>
>>
>> On 1/5/2023 4:07 PM, Baolu Lu wrote:
>>> On 2023/1/5 18:27, Vasant Hegde wrote:
>>>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>>>> I built 6.2-rc2 with the patch applied. The same black screen
>>>>> problem happened with 6.2-rc2 with the patch. I tried to use early
>>>>> kdump with 6.2-rc2 with the patch twice by panicking the kernel with
>>>>> sysrq+alt+c after the black screen happened. The system rebooted
>>>>> after about 10-20 seconds both times, but no kdump and dmesg files
>>>>> were saved in /var/crash. I'm attaching the lspci -vvv output as
>> requested.
>>>> Thanks for testing. As mentioned earlier I was not expecting this
>>>> patch to fix the black screen issue. It should fix kernel warnings
>>>> and IOMMU page fault related call traces. By any chance do you have the
>> kernel boot logs?
>>>> @Baolu,
>>>>     Looking into lspci output, it doesn't list ACS feature for
>>>> Graphics card. So with your fix it didn't enable PASID and hence it failed to
>> boot.
>>> So do you mind telling why does the PASID need to be enabled for the
>>> graphic device? Or in another word, what does the graphic driver use
>>> the PASID for?
>> Honestly I don't know the complete details of how PASID works with graphics
>> card. May be Alex or Joerg can explain it better.
> + Felix
>
> The GPU driver uses the pasid for shared virtual memory between the CPU and GPU.  I.e., so that the user apps can use the same virtual address space on the GPU and the CPU.  It also uses pasid to take advantage of recoverable device page faults using PRS.

Agreed. This applies to GPU computing on some older AMD APUs that take 
advantage of memory coherence and IOMMUv2 address translation to create 
a shared virtual address space between the CPU and GPU. In this case it 
seems to be a Carrizo APU. It is also true for Raven APUs.

Regards,
   Felix


>
> Alex

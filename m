Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0056665CCE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 14:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjAKNlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 08:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbjAKNkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 08:40:09 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4DD639A
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 05:38:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgJNk/OfP5/sgu0QN9gxPPobP408t6U+wpyciqzfSNHkJRGrVJvtPQVRf3CmHu3hmuZ7TUQW1jsDcHzwa0MNAIbyZ9/oZ1lhuvdeecgh7eoqiV1Y1x5gkIM3TQBB4cMwN7gHOCi9R6mVgwoLPGD2EoACgbb6w/EKV9Jm6kEao7Gk3Tb0rGF0Pg9qEkCVt0GKItI09ph+T+JbAJYmldRc1hMAPct0ldHBqDFmk+a8GX/La/6lPqeZN/2CEhwR56hNxhvayKdEIbMNRA+kgENi3J9rqNdzDaKhVctCH+yyzFnTjs6W+gylGJE3n/EVC+CY5xMAO0I2oiVIL8rNIQZQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrvlZAdzuwKa5hrj+EjQhRDwCkiwN/+I+C9fbt64n64=;
 b=B2IMMymg6ilOKdgt9kly3gApRFLHt05R9kvDLw+XQjJb58eCkAshBxi5+OHJLHlMhQO1A8IvlgFxCAL+18NhMv4H8EX3Odr1hQtxhV16zd6C7qA9OAHZ+kGT8rqYWDtQcUq9P31D3rLKw/mgJX+JiEfx1yM8DYGLyst/g5kjLoSiThj7M2b1YOsnhU8kfF7+BGDDkAzjSD9PZKCJzWopIp43dTkPjonKhIm0paip/YF1kTM4QpzgjDevjDegW3rgW29YgAH8+6COCKUt1z7NrjRwX2I8tpMK/iUHf763yYOJS6viHSTNX2Z9Jg2zR9KjhfO03UaqO06l39+ruYemQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrvlZAdzuwKa5hrj+EjQhRDwCkiwN/+I+C9fbt64n64=;
 b=Cxx693mbixh2InKRxkCKGYH3boW97wMM2w4YfGStEUlrnTu1JFRNsnmDuVo2TwlNpfRaoXX6I3w6RRxqu8tZl7XYk3Fu/Mj6hKuLWBwED15vm9MNG53VOdP7HQlbgzQ9qryr8BjeqlevVDoX2ncU9Xz4SOoHX9EAhM9vRnRdemk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 13:38:41 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 13:38:41 +0000
Message-ID: <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
Date:   Wed, 11 Jan 2023 14:38:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <Y760hRDQbXRlc2Yz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfdefeb-8017-41ac-6631-08daf3d926c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fM6SJFek3VAXLp3JKUlbcb4w0uKHW3/2CKfl8uCwxLBPfBx4E2KxA4KHr6oIt+MPCgqULUD6BQs608mJV5/Xbkgub74meXP5jM7EG0yLlGg5DXgVNgZBDB7IkxJ8iCCZ9/hFCqwI37smyviwWX9JmfnMKdNPz/taI8pDMeXb5jRgwUI1KwZJstgdDfmbdVZMvKMhN7ZFkyQt1eh5zRlNwAVK6/Xt2jIxdAZECTODACJEdCgpav7N77qta/P1EKcuX5ndOdXdT+ltgNNAFrk8WxT0hgPCZc/OIs0NHYqqfbQJpSOX6w8nGIG/DoM80Q/Gj5w0BXpqHU55UzsQDEupQ61m1XxNTWz7b6rG9gHiJLjwmjYXkSHVAFYgqCnc7ZpBEx/ykdlpAaXpaoQHCVhGQWTxPgcFsFybRnarZgoBvvaR6UxaHdViLAeGQFqbrueWZIGQ0OUOQjFqKGDmzjIxxYKW66pUQVOkr5dCRtntBP8KYdbL/ebWP2Fo4tvUR1KUp8EzFHfnc3Q0eOYcN8GvsnrIHrD3Jz6w1uTfNRCb5T7ZMGXbKWxhpXLfJ4bqKMDP+TV1s/UAPhQ2Oq6BwNnGwtnurkThOzQyZaFxTmBztio6JxX62S1FES9alxDDYFhCSpfUEwoOMPHttkIWCo31mQ5Q1Fb+g18C1b4gevBugNZkAl7SKWdkE4oLDYkKtgCCSoahB9CTK3LdHeoRg5EGD1kuuLvbMq5YDjAIsTliCiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(86362001)(31686004)(2906002)(5660300002)(6666004)(36756003)(8936002)(41300700001)(66556008)(66476007)(38100700002)(8676002)(4326008)(66946007)(83380400001)(66574015)(6512007)(31696002)(316002)(2616005)(110136005)(54906003)(186003)(6486002)(478600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTR4a2hWYmpFeDRmT2lNa2RtQVZrbVNCSm9aNmxQQVRoVnptaGRhRU51OEts?=
 =?utf-8?B?SWRJZXZoQkFXQ1MydFo1dnZiYVM5VDYxaDliMlhyRUhVN2tabVZPUWV1eUJO?=
 =?utf-8?B?ZkNKNWZkQ3pxdWNMcVhRemxNc0RWNlhBSTNXQ3cvSE9SVE4rMDlOSENhbUor?=
 =?utf-8?B?aVhpV0RiaHR0Ly8zZzNsUUg4UjdqaGlYL0VxcWRCb3k3YTl3eWRjSEhrb2Qy?=
 =?utf-8?B?N05MUUdnQzdIMDBhTE1vdEc1Slg4djdod3RYMUE5a1Z3WDU2VENUOCt3SWhM?=
 =?utf-8?B?ZG54bFN0UWUzVmlCWTFrZnJTdHpGNFlPMS9naUtUOERieFlMZkpmWlRUM09K?=
 =?utf-8?B?R2hRMVltUnczcmZnNE91VHFyV0xzUkNPMTJGdEx0bm9lcUZJN0VKekw3SWsr?=
 =?utf-8?B?N0VyWG9JYmovMERzZlFOMHRqa0xjZWlvcDBpdi9kUWpLT0R3QmUrR0EvN1Jv?=
 =?utf-8?B?a0NCK3NUOVlHNGYxSDhObFBwdWJ0WGIwQml2M3VyQ0dobnpMTFpKdysyLzlK?=
 =?utf-8?B?dUdwc3ptb01xa09YUGFTR0N0dndaNWlLOU1RKzNKd3oxS1k1b0VRZk16bEpG?=
 =?utf-8?B?Y01kUUtlSVRmYlZ4Q2VRS3BJbFk2MEVpeW9VZG0rUW9tOWRxOCtOZXZaRHE5?=
 =?utf-8?B?QlI0dG1Hb1Npbmp0aWdMcnBWWGVaVURiVEorMlJDSGxxbFZpeWdHTXpveUgr?=
 =?utf-8?B?cHZrMTdEdnYxWXhRQ3hEdlozaWhmTE9WWThkTjk0NXFDc1FPaFhrWGlVaXBk?=
 =?utf-8?B?WmdBSXdhd05zeStzRllNTWdFTUJ6NmkrQ0V5aktKVk94NzVDYVRnMjJ4b2hH?=
 =?utf-8?B?TG93bTVsTlNXaUY5QXArWWt6aDE5OGx3ZWhUS0tpRmpzV2NLK1UrL0cwQnM3?=
 =?utf-8?B?WSsyRC85citaQnFrYThBbzZBUHlsZHZrbVc5cDE5N1B1cFhMNWZIS2tyYytQ?=
 =?utf-8?B?ZU1pcVl4WVZtazk1K3N1UkpvNU5UbG9vNzFwNi9ZQ0dsODlkdG1IdWNvbVZ0?=
 =?utf-8?B?bTVsdHlXYy9sVzVCamczKy92elBtN0ZEbFllQ2lDdjV6QkhzZ3NPd3dXcnpG?=
 =?utf-8?B?T0FWZEE4d2lqTlRSTWxqdmVsRHI0cWFEbmZ5WHZrREVrL2lwQ0VoMUs0V3NJ?=
 =?utf-8?B?YmM3amV6R3VydjR5UEI0RThkNkU4aHdGVGRuNVYvSTRJemJZUWhKUy8yMWNJ?=
 =?utf-8?B?aDdHdGUvNGRVVW53RTU3Q0xXRm9xREx2MHZOYXVwRGhFUGU5OTVhcDBudWF1?=
 =?utf-8?B?QjR1eGFvTS9SaWM2VGlnaTltcTUwd1Q2dS92alpKUVp6MCtrcDUybG5MdjE2?=
 =?utf-8?B?VFZlci8wTVI1RmlZd1lSYUJBdXhJSU9iSzMxOE1wU3hhcXRpWDY5TVFQVmp5?=
 =?utf-8?B?NlM5UUVubzdvak1RaFNFeWYxQWhqTHJWaXdoNTZybXFQUHJnNEFKWlNSSTA4?=
 =?utf-8?B?YnhBK251dVFiaFF1Nk5LK3FEbHhmWWM0US9jMWN5OHg3QnZhTVNveXpkQ0pn?=
 =?utf-8?B?M2FpYTREQ1YydHZmSVFOOEo0WDBxK2E3OXV1dWFjQWdlSnJ5SEVhb2xROUpu?=
 =?utf-8?B?SG1aQmtZMHpIL3NNc2FHMDI0b2d4T0hhMFJSdDlnTkJRbkNQMXYwTE42L0Vp?=
 =?utf-8?B?VjFOWjFzK2RSOWU5aVhha1VFOTNNZEdNNWpkWkt4WnNrT3pQK1R3czFKOWNn?=
 =?utf-8?B?QlJQS09yL0hNa3N6bERDR09jelV1RWtHTXZwbjlUclFranhzczBLNEFWdUxn?=
 =?utf-8?B?MFJ5YVhENWdVM0F3dW5yK0ViSHB1V1d0bXJaWlRoVmhHQ2YvdiszTytPMlA1?=
 =?utf-8?B?WGthd3pMb01WVDgrUENwZmoxTURqVGRuZUdvUFZCMHdXakxBbUlVZU9LemtZ?=
 =?utf-8?B?RE54VmlUWEtOUnJEUWY3RjFDNjNnbjZVb09US2hYakluTnhrZFBENW14RlA5?=
 =?utf-8?B?RmNyVWVIY3doVWgzMkc5VUk1c2lsSlBIT0xMODZqN0Y5dURLSkN6QUQwQmgv?=
 =?utf-8?B?MXhXMmR2bElaS2RidC9uckEycUN1UzR0RzFJVEpzUjI2U0hJVFhkaDRVdGNx?=
 =?utf-8?B?emlDc3hrK0w4bFQvbTdKWld2dnBrUlN0ZnlVb3JtUC9xM2dIYU52WWJrUDAy?=
 =?utf-8?B?NFluL0JhdjNzNEVCMlZDTkphTTBKclBRbXRabXB4M2JSRkRTUVl1Z3BLV252?=
 =?utf-8?Q?cIZfhOZI5iDFncQPXmfiz9igFn03cEkweZ02lXopdeUJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfdefeb-8017-41ac-6631-08daf3d926c9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 13:38:41.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgFJunyEAHKyQT6XRO6dg33vMSIdM/Q3po7ZTj1ZZ4TiR1SqHN9hR/U1GAJrq2Rn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 11.01.23 um 14:07 schrieb Jason Gunthorpe:
> On Wed, Jan 11, 2023 at 09:57:45AM +0100, Christian König wrote:
>> This reverts commit 201007ef707a8bb5592cd07dd46fc9222c48e0b9.
>>
>> It's correct that the PCIe fabric routes Memory Requests based on the
>> TLP address, but enabling the PASID mapping doesn't necessary mean that
>> Memory Requests will have a PASID associated with them.
> It is true, the routine assumes the device will use untranslated
> requests with the PASID.
>
>> The alternative is ATS which lets the device resolve the PASID+addr pair
>> before a memory request is made into a routeable TLB address through the
>> TA. Those resolved addresses are then cached on the device instead of
>> in the IOMMU TLB.
> We should pass in a flag "device always sets the translated bit for
> PASID" and skip the ACS check in that case.
>
> The ACS check is not wrong, and it is definately necessary for devices
> that do not guarentee ATS and PASID are used together, we should not
> be removing it.
>
> Given adding the flag is trivial we should just fix it, not revert this.

Well exactly that's the point, adding this flag is absolutely not 
trivial as far as I can see. We need to go through multiple layers of 
abstraction since this is the low level function and nothing high level.

Additional to that the check doesn't seem to make much sense to me. 
pci_enable_pasid() is called by three functions:

pdev_pri_ats_enable() in the AMD IOMMU driver while enabling ATS. As far 
as I can see we absolutely don't need the ACS check here because ATS is 
a must have.

iommu_enable_pci_caps() in the Intel IOMMU driver. This also does some 
handling for ATS, so here we could check the info->ats_supported flag if 
ACS needs to be checked or not.

arm_smmu_enable_pasid() in the ARM IOMMU driver code. No idea what this 
one does with ATS. Here is the only place where the ACS check might make 
sense.

So even if we have some need for this check this seems to be the wrong 
place for the check since not all necessary information from the higher 
level is available.

Regards,
Christian.

>
> Jason


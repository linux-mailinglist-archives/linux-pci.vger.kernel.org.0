Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8836F564
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 07:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhD3Fkd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 01:40:33 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:1761
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229482AbhD3Fkd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 01:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na4jGtg48aBCHW2wZN6BVNCjjqjnftnpvcL/A2DcNowpB6JJF3mKJJEzOvRAJEyLA1oP/vOkC0nrIgZxDp3Ujtu+4YW737ZKhVPnEEuGwPPxRa82GJ78jrHZ6hltxA/ESkA/sFu6HFwl8RtXfSaqCYgRFlZ3mIO7PpL+C8kxUDlPk4X6QrvtifLvIFCeoP/YMN8KiW7yMYXNNH3h7xdJl3QJsTj5z1U3ffuEaRSO6ESe58X46JVsw8i/wChNO51gVQazrONh19lNc1FeOw3WyDEa3hJ3G+cLqFVIK8RsgZpYF0sX7NZOURY+hrG3QwObpET5iQxDA8490aA4sMWGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVnPCL9/pI9ViXtlRPsLi1Nm/kjhXq1xsxRGfGXrQpw=;
 b=CO4QDBk0T3B31VPgqzDFW17C+tgSTr1r/KzncnpuKEKapkbTXEICY94bqHWJ07jNuLml58pMt/nTVlxuOk1rHJQI3aGUtTkXa6ndGlW84ATLAo4qYeOiPk8TBk3p7BxQjXuCu36pN59bpi1xJYokeQ/dK5zIvThxYCiQSpVrqEswqargKJDhuB9TK/TzXUZDM7TKxE7oVI49Jt1Jr93M3P2lVbgG8PTGvjjwQEDLcv0Z2PQMODvAebe9Q+T5fmQlIrzodEBo4hdKxhLz+uYhUtTVOgXpYX8XE3s+ixLVMKG7TwdRA8drSHuBa+xBJ+tkUrcyTK4kID8tNKBT0KRcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVnPCL9/pI9ViXtlRPsLi1Nm/kjhXq1xsxRGfGXrQpw=;
 b=ZnB4e205/H0RLdMEf+Va+wukQg/mF04I50hVhUB2/I9WCho2pOaNmgVXSUYptwjzIsyxuZINbeT2sl3lsb89k5d/6ShUwCYO2vdRCSDQAv4SYcjyb0U9fMi6VP/IryrtroHNls3W0qGSOBqhtlvmDp0cSJj5ggbOP3vKgc5/FcI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.26; Fri, 30 Apr
 2021 05:39:43 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.033; Fri, 30 Apr 2021
 05:39:42 +0000
Subject: Re: [PATCH v5 03/27] drm/amdgpu: Split amdgpu_device_fini into early
 and late
To:     "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "ppaalanen@gmail.com" <ppaalanen@gmail.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-4-andrey.grodzovsky@amd.com>
 <MN2PR12MB4549896A55131D4A327908E4975E9@MN2PR12MB4549.namprd12.prod.outlook.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <9437bddc-b944-3f7b-deb5-6068cb12a48c@amd.com>
Date:   Fri, 30 Apr 2021 01:39:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <MN2PR12MB4549896A55131D4A327908E4975E9@MN2PR12MB4549.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:497:888:9bb9:54f1]
X-ClientProxiedBy: YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::21) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:497:888:9bb9:54f1] (2607:fea8:3edf:49b0:497:888:9bb9:54f1) by YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Fri, 30 Apr 2021 05:39:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f77a0cef-4024-4c46-09a3-08d90b9a5ad3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4381E801E73408261915568AEA5E9@SA0PR12MB4381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5lUt/sTu1sH7wNdsS2+wNoPWMRmcS0jY4vla6gexyxexDgSVdLRxmAkAyfGeugBywehdfbwz4LGQPPUIiE6o/gnzryI+y6ZUMeWL+AYIVuNPtsfPo5rbaPMFwoZmpuahUxegyvu2dra6BU6MvrNXGGGjEFd18FIa3UPhVtRuBf44g0lfdemu9HgikVSV1407jJkNWTVQbv1UZeUR1wdaRG6eOql1QGF1eWmMOucfY2IETTyJtn3GfpilV0zNDDNeGSDKOaLvJIfzeFU3SmypQia11yVZ8/TxNORhx0MHwz7s1uXs65mZ8PhBeh8n4q8LEBJlDr1VbK51EF70bZhw6CzifMA37klQOgzE7ZhNttPjHlPvfIxbjDDUHyR3OCPsjtg87HEodwb9gmricZLteAMUFwQMg/2kI8vdIJTNXLOD+BM5Nr0aseoQLBM5O9ZFsw+d0jLjL/OcMvN4USFskCGIYVFPrRsxzFNcA92LNKABVWioFVuIUa6WJn0gj0z+ZnHdc01KfV0IQFCwUZih9MBSs2vED8Dlt5BQOWSLPRjnMtteLpT6jeQb6VTuFtKGR46aKHri87XoBNKj/WabnZ07w3rfiMQX1yDSUlDdeIHsdSPNztiYzIgWc+EcXENgM0Gqi2IYRjoz4v3EFm/jnWu5PYcCOp5pb3AJ8KXuWyU0c/B9KK6S1jaRBQ0pDBOWoETs1nwrmYo5N4q+rvi/vuHM5COGqxTBnpQfi4yqE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(31686004)(6486002)(83380400001)(53546011)(6636002)(478600001)(31696002)(966005)(52116002)(2906002)(66946007)(45080400002)(54906003)(30864003)(316002)(38100700002)(4326008)(16526019)(186003)(44832011)(8936002)(36756003)(110136005)(8676002)(66476007)(2616005)(6666004)(5660300002)(86362001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aVJmK0pXd1hiUlM2UllqMTZPUlphUGxCbjJHc1NlRHNMc0N0WE9GMS9rcnFH?=
 =?utf-8?B?MVZ1d0F5YlNiL0M5TEI3Wmk0ek9LRjE5S29DdmlqQWp5NWhKUXZaOFRxcHRr?=
 =?utf-8?B?ck9ESXdoZXpxK2prTUNGWnNMV2FRZjRZa0tteUJLeFRtbzM0UVJ3R00vVmVs?=
 =?utf-8?B?Zms4OXVtRVpYYjN1STJjeWVwMzdZVVlLdU9TNnZwTWpDMExGSkt6MW45b3F5?=
 =?utf-8?B?WlRRWU1UL2ZjcmhybUZCL1RwaWhBVXFIS0w2K01KVklQQllPbmYwSWxRNXBN?=
 =?utf-8?B?bE85c3V4cGFoNVBnMXFOZ0xiZm1oekY0ZGFBMTQzdVBXSldGaEdxSW15WEkx?=
 =?utf-8?B?eEJVaSt0UHZtQnhXZk9KMURkeVlxd3gzREgvMFR1dWIvZVNaNmc3YVpxNzZl?=
 =?utf-8?B?emZIaTJEN1FIRWNYdkNjeXZ6b1FLb243QTIxL2pNcmRkSSthblljcVJIay9H?=
 =?utf-8?B?dDVRVEFlbmVVY3hzUVNJNkdURDJlZE5TRG5IcFJhOHQwMHUramR3WkdWVVNS?=
 =?utf-8?B?ODlRT1RyL1lMQi8rKzlleG5BcmJBSXVpUHJpY29FMlh3ckNXOUtwbFByWWJ2?=
 =?utf-8?B?MkFoNVJxMnkvOUY5N1gvcFFpQ1FLSnZ2RkNFL041RmI3a1UzZEdjVWd0ekdr?=
 =?utf-8?B?Z09LVENUdmNVY3c2VmJYRjBiSXFlVmh2NDBJd1ZUZXo3M0VCOFhBeUZyakJi?=
 =?utf-8?B?cHlSazBwZDEyQWlQamY4ZXBpU1Q1b3U4UjkrMHN2YjJGMmw1azlwQmFKaGNi?=
 =?utf-8?B?OElSby9WczRZN3cwWnlhMWdyeXhCNjNDWFBiNUNaZ3BoZ1g1cnhqdW52b1RK?=
 =?utf-8?B?enFxaWxyWkJMaFV3ZHNmRlpOMnFqNjA3N1pvNnZYb25rSnp3K2VpeXJUN3VP?=
 =?utf-8?B?Mnc0WXZJYTJ5WFZ0bEJBZTFnSFhidWxWZzRQRnRRWFRhV2FPOWtMS0RoNG5m?=
 =?utf-8?B?WkE4aUc3eUI5M29heVB0TE5MS3g5emQ1ZTB0eCttQWZoOEltWmVrRDZMYTlD?=
 =?utf-8?B?aVh6RjBzeXBRYWF2cG42MjBHSTVnMWN2WjJIN0hWK25QbXptT3c2WDNkT2xl?=
 =?utf-8?B?YVMwc0ZscHA4UFdPTmFYMkhkZW43c0w3bDhpdlcwZk0rUWtIeUY3anBqZCti?=
 =?utf-8?B?MEd3MEZ6Y3orMGtsZUc4elM1WWlCUmtudElGaE9ETFp6ZFYwNTB5ZXBHcTRH?=
 =?utf-8?B?VmpnMUlrbTZ5N3pTYkxWOG1kb01ibEdhQmVBdGNjV285SU96ZlNuakx3OGlL?=
 =?utf-8?B?aElpUmQ3SThuRFNEVTk1U1ZhNmtyWTBZVDFaV1N1a1pZU09LQlpNM2VXZ2Ja?=
 =?utf-8?B?SzVKVjNsZnZHaS96K2NJMS9MdGNvcW5Ja2I0dVBiNTRHVk5FRFRKc0VLaTJU?=
 =?utf-8?B?OVpyTTJSck90TXNBc1NsMFVIUVMvZm5ndjRBSlZnQXZ3L2ZoNDB2Y1Nmcmo4?=
 =?utf-8?B?c0U5WnlrY3dvVmQ5WUh3dHJROGRxMFN2TUpmWHV1K3A2R09DRnQ5anNGWXBL?=
 =?utf-8?B?WGRpVEI2SXNMYzBvY3RqVm1xOHhYazBiN2dxeHlIVW8wVGJEazhjV2dLcUg0?=
 =?utf-8?B?UWFheUFOU2d0SHJFc1dJN0REd0JQVGFucW9nbkJaWlFCOFJPVndXTzY2OFZz?=
 =?utf-8?B?aDk4QnEyTGo1OERLQUJlNlVTVGJkeHhWMEZCZ21OS0J2ajdvKzh0QVhZOE5K?=
 =?utf-8?B?djMwZkVrNzhwLy9lRFNqQVF2ZWx0cGlSbm82ZE9tYjRKcFNJYkI1SDNGSTV5?=
 =?utf-8?B?WkFSOVZWV0tjSHdBUUJlSTFETXhublJQUHVCRDA2aEJFVG91RnNxcHJlOFZO?=
 =?utf-8?B?akxvS3VMR0xlYzJYa09OTnBCMzA4UGhDRmlVcEZwUTNOQVd3alVTZFdwdUx3?=
 =?utf-8?Q?YqNmmjyjbgiDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77a0cef-4024-4c46-09a3-08d90b9a5ad3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 05:39:42.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfa27oT3dCFL4lnR9J11kftNDkD2/sm/8JjuxfvJq/QNbDGYW4UjzKDaWQscOkXI15Jm48xTMVk97wpyUZe93Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-30 1:19 a.m., Lazar, Lijo wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> 
> sysfs cleanup is a sw cleanup to me but done inside hw fini. sw/hw 
> separation is not strictly followed, or name it like stage1/stage2 fini.

The thing is that it was called early_fini and late_fini before and then
according to Daniel's requirest it was changed to fini_hw and fini_sw

Andrey

> 
> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> *Sent:* Wednesday, April 28, 2021 8:41:43 PM
> *To:* dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; 
> ckoenig.leichtzumerken@gmail.com <ckoenig.leichtzumerken@gmail.com>; 
> daniel.vetter@ffwll.ch <daniel.vetter@ffwll.ch>; Wentland, Harry 
> <Harry.Wentland@amd.com>
> *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; 
> gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>; ppaalanen@gmail.com <ppaalanen@gmail.com>; 
> helgaas@kernel.org <helgaas@kernel.org>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* [PATCH v5 03/27] drm/amdgpu: Split amdgpu_device_fini into 
> early and late
> Some of the stuff in amdgpu_device_fini such as HW interrupts
> disable and pending fences finilization must be done right away on
> pci_remove while most of the stuff which relates to finilizing and
> releasing driver data structures can be kept until
> drm_driver.release hook is called, i.e. when the last device
> reference is dropped.
> 
> v4: Change functions prefix early->hw and late->sw
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 15 ++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 26 +++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 +++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/si_ih.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c     |  2 +-
>   17 files changed, 79 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1af2fa1591fd..fddb82897e5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1073,7 +1073,9 @@ static inline struct amdgpu_device 
> *amdgpu_ttm_adev(struct ttm_device *bdev)
> 
>   int amdgpu_device_init(struct amdgpu_device *adev,
>                          uint32_t flags);
> -void amdgpu_device_fini(struct amdgpu_device *adev);
> +void amdgpu_device_fini_hw(struct amdgpu_device *adev);
> +void amdgpu_device_fini_sw(struct amdgpu_device *adev);
> +
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
> 
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> @@ -1289,6 +1291,8 @@ void amdgpu_driver_lastclose_kms(struct drm_device 
> *dev);
>   int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file 
> *file_priv);
>   void amdgpu_driver_postclose_kms(struct drm_device *dev,
>                                    struct drm_file *file_priv);
> +void amdgpu_driver_release_kms(struct drm_device *dev);
> +
>   int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>   int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6447cd6ca5a8..8d22b79fc1cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3590,14 +3590,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>    * Tear down the driver info (all asics).
>    * Called at driver shutdown.
>    */
> -void amdgpu_device_fini(struct amdgpu_device *adev)
> +void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
>           dev_info(adev->dev, "amdgpu: finishing device.\n");
>           flush_delayed_work(&adev->delayed_init_work);
>           adev->shutdown = true;
> 
> -       kfree(adev->pci_state);
> -
>           /* make sure IB test finished before entering exclusive mode
>            * to avoid preemption on IB test
>            * */
> @@ -3614,11 +3612,24 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>                   else
>                           drm_atomic_helper_shutdown(adev_to_drm(adev));
>           }
> -       amdgpu_fence_driver_fini(adev);
> +       amdgpu_fence_driver_fini_hw(adev);
> +
>           if (adev->pm_sysfs_en)
>                   amdgpu_pm_sysfs_fini(adev);
> +       if (adev->ucode_sysfs_en)
> +               amdgpu_ucode_sysfs_fini(adev);
> +       sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> +
> +
>           amdgpu_fbdev_fini(adev);
> +
> +       amdgpu_irq_fini_hw(adev);
> +}
> +
> +void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> +{
>           amdgpu_device_ip_fini(adev);
> +       amdgpu_fence_driver_fini_sw(adev);
>           release_firmware(adev->firmware.gpu_info_fw);
>           adev->firmware.gpu_info_fw = NULL;
>           adev->accel_working = false;
> @@ -3647,14 +3658,13 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>           adev->rmmio = NULL;
>           amdgpu_device_doorbell_fini(adev);
> 
> -       if (adev->ucode_sysfs_en)
> -               amdgpu_ucode_sysfs_fini(adev);
> -
> -       sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>           if (IS_ENABLED(CONFIG_PERF_EVENTS))
>                   amdgpu_pmu_fini(adev);
>           if (adev->mman.discovery_bin)
>                   amdgpu_discovery_fini(adev);
> +
> +       kfree(adev->pci_state);
> +
>   }
> 
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 671ec1002230..54cb5ee2f563 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1249,14 +1249,10 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   {
>           struct drm_device *dev = pci_get_drvdata(pdev);
> 
> -#ifdef MODULE
> -       if (THIS_MODULE->state != MODULE_STATE_GOING)
> -#endif
> -               DRM_ERROR("Hotplug removal is not supported\n");
>           drm_dev_unplug(dev);
>           amdgpu_driver_unload_kms(dev);
> +
>           pci_disable_device(pdev);
> -       pci_set_drvdata(pdev, NULL);
>   }
> 
>   static void
> @@ -1587,6 +1583,7 @@ static const struct drm_driver amdgpu_kms_driver = {
>           .dumb_create = amdgpu_mode_dumb_create,
>           .dumb_map_offset = amdgpu_mode_dumb_mmap,
>           .fops = &amdgpu_driver_kms_fops,
> +       .release = &amdgpu_driver_release_kms,
> 
>           .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>           .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 8e0a5650d383..34d51e962799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -523,7 +523,7 @@ int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>    *
>    * Tear down the fence driver for all possible rings (all asics).
>    */
> -void amdgpu_fence_driver_fini(struct amdgpu_device *adev)
> +void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
>   {
>           unsigned i, j;
>           int r;
> @@ -544,6 +544,19 @@ void amdgpu_fence_driver_fini(struct amdgpu_device 
> *adev)
>                   if (!ring->no_scheduler)
>                           drm_sched_fini(&ring->sched);
>                   del_timer_sync(&ring->fence_drv.fallback_timer);
> +       }
> +}
> +
> +void amdgpu_fence_driver_fini_sw(struct amdgpu_device *adev)
> +{
> +       unsigned int i, j;
> +
> +       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +               struct amdgpu_ring *ring = adev->rings[i];
> +
> +               if (!ring || !ring->fence_drv.initialized)
> +                       continue;
> +
>                   for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>                           dma_fence_put(ring->fence_drv.fences[j]);
>                   kfree(ring->fence_drv.fences);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index afbbec82a289..63e815c27585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -49,6 +49,7 @@
>   #include <drm/drm_irq.h>
>   #include <drm/drm_vblank.h>
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "amdgpu_ih.h"
>   #include "atom.h"
> @@ -313,6 +314,20 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>           return 0;
>   }
> 
> +
> +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +{
> +       if (adev->irq.installed) {
> +               drm_irq_uninstall(&adev->ddev);
> +               adev->irq.installed = false;
> +               if (adev->irq.msi_enabled)
> +                       pci_free_irq_vectors(adev->pdev);
> +
> +               if (!amdgpu_device_has_dc_support(adev))
> +                       flush_work(&adev->hotplug_work);
> +       }
> +}
> +
>   /**
>    * amdgpu_irq_fini - shut down interrupt handling
>    *
> @@ -322,19 +337,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>    * functionality, shuts down vblank, hotplug and reset interrupt handling,
>    * turns off interrupts from all sources (all ASICs).
>    */
> -void amdgpu_irq_fini(struct amdgpu_device *adev)
> +void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
>   {
>           unsigned i, j;
> 
> -       if (adev->irq.installed) {
> -               drm_irq_uninstall(adev_to_drm(adev));
> -               adev->irq.installed = false;
> -               if (adev->irq.msi_enabled)
> -                       pci_free_irq_vectors(adev->pdev);
> -               if (!amdgpu_device_has_dc_support(adev))
> -                       flush_work(&adev->hotplug_work);
> -       }
> -
>           for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>                   if (!adev->irq.client[i].sources)
>                           continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index ac527e5deae6..392a7324e2b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -104,7 +104,8 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>   irqreturn_t amdgpu_irq_handler(int irq, void *arg);
> 
>   int amdgpu_irq_init(struct amdgpu_device *adev);
> -void amdgpu_irq_fini(struct amdgpu_device *adev);
> +void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
> +void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
>   int amdgpu_irq_add_id(struct amdgpu_device *adev,
>                         unsigned client_id, unsigned src_id,
>                         struct amdgpu_irq_src *source);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 64beb3399604..1af3fba7bfd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu.h"
>   #include <drm/drm_debugfs.h>
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   #include "amdgpu_uvd.h"
>   #include "amdgpu_vce.h"
>   #include "atom.h"
> @@ -93,7 +94,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>           }
> 
>           amdgpu_acpi_fini(adev);
> -       amdgpu_device_fini(adev);
> +       amdgpu_device_fini_hw(adev);
>   }
> 
>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
> @@ -1151,6 +1152,15 @@ void amdgpu_driver_postclose_kms(struct 
> drm_device *dev,
>           pm_runtime_put_autosuspend(dev->dev);
>   }
> 
> +
> +void amdgpu_driver_release_kms(struct drm_device *dev)
> +{
> +       struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +       amdgpu_device_fini_sw(adev);
> +       pci_set_drvdata(adev->pdev, NULL);
> +}
> +
>   /*
>    * VBlank related functions.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1fb2a91ad30a..c0a16eac4923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2142,6 +2142,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>           if (!con)
>                   return 0;
> 
> +
>           /* Need disable ras on all IPs here before ip [hw/sw]fini */
>           amdgpu_ras_disable_all_features(adev, 0);
>           amdgpu_ras_recovery_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 56acec1075ac..0f195f7bf797 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -107,7 +107,8 @@ struct amdgpu_fence_driver {
>   };
> 
>   int amdgpu_fence_driver_init(struct amdgpu_device *adev);
> -void amdgpu_fence_driver_fini(struct amdgpu_device *adev);
> +void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev);
> +void amdgpu_fence_driver_fini_sw(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> 
>   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index d3745711d55f..183d44a6583c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -309,7 +309,7 @@ static int cik_ih_sw_fini(void *handle)
>   {
>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> -       amdgpu_irq_fini(adev);
> +       amdgpu_irq_fini_sw(adev);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>           amdgpu_irq_remove_domain(adev);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index 307c01301c87..d32743949003 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -301,7 +301,7 @@ static int cz_ih_sw_fini(void *handle)
>   {
>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> -       amdgpu_irq_fini(adev);
> +       amdgpu_irq_fini_sw(adev);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>           amdgpu_irq_remove_domain(adev);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index cc957471f31e..da96c6013477 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -300,7 +300,7 @@ static int iceland_ih_sw_fini(void *handle)
>   {
>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> -       amdgpu_irq_fini(adev);
> +       amdgpu_irq_fini_sw(adev);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>           amdgpu_irq_remove_domain(adev);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index f4e4040bbd25..5eea4550b856 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -569,7 +569,7 @@ static int navi10_ih_sw_fini(void *handle)
>   {
>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> -       amdgpu_irq_fini(adev);
> +       amdgpu_irq_fini_sw(adev);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 51880f6ef634..751307f3252c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -175,7 +175,7 @@ static int si_ih_sw_fini(void *handle)
>   {
>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> -       amdgpu_irq_fini(adev);
> +       amdgpu_irq_fini_sw(adev);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> 
>           return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 249fcbee7871..973d80ec7f6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -312,7 +312,7 @@ static int tonga_ih_sw_fini(void *handle)
>   {
>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> -       amdgpu_irq_fini(adev);
> +       amdgpu_irq_fini_sw(adev);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>           amdgpu_irq_remove_domain(adev);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 88626d83e07b..2d0094c276ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -523,7 +523,7 @@ static int vega10_ih_sw_fini(void *handle)
>   {
>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> -       amdgpu_irq_fini(adev);
> +       amdgpu_irq_fini_sw(adev);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 5a3c867d5881..9059b21b079f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -558,7 +558,7 @@ static int vega20_ih_sw_fini(void *handle)
>   {
>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> -       amdgpu_irq_fini(adev);
> +       amdgpu_irq_fini_sw(adev);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>           amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> -- 
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C71f92dcef6d04dfea28308d90a5818c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195764790324%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fzGS6ZXYffGH0DE%2BEM4jxyB8yDGpYO%2FmT%2FKAtgig1Tw%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C71f92dcef6d04dfea28308d90a5818c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195764790324%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fzGS6ZXYffGH0DE%2BEM4jxyB8yDGpYO%2FmT%2FKAtgig1Tw%3D&amp;reserved=0>

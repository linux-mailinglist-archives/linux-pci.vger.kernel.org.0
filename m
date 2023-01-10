Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134FC66447E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAJPWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 10:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238940AbjAJPWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 10:22:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F163B8;
        Tue, 10 Jan 2023 07:21:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWwYNPM2FztQW2/pGg+0y5ZJjeeFLVjfm/zbaXmN3l3kKc/wZ/GlCLVXZ0xCXzqib0oBD4R/TzhKfaszR7WXkAE8o8kKwEWAY2zM6FMWjFzOfjpU0tvl7H0ON2qVoB6skVYvbkXMoLlk2YxbgALV0sVniWIvqCEOgrooUipGqC1evY3yb8KW39mzyUvZV7QLhlRMhsVqQ7kl82VIQ3DKs4KPQB5nnVXlxhy6yHiX9dz3orAExjM/1LtunTlNc4I0J6iewyu1Zbmk2uJmIdth4KmeglBzKIyoZaQtL1rDfdtyM+V+Vxunp3FPMxyNJHWjKFGPMmINroKW0vp/bzy2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1zOmcGmINDkFaKerVryJEwUNj+BiluiWkz0yymmY7Q=;
 b=dNcv6fmf7RBEUjmdTDOfJiKK3vXLM2FtQtcOszeSxycs/3dkuLfa0qWOu6Z5kZm06T0XQzBRBwl9iD1mLKOMDaG3arAU2nx571MsxH/ZV7SXw3BzyIHt14YZfwCn4jy3QnfunuPfr2U7GPhK51ffwaw7YX6A4swSzJ3uZepuAFNxf3MgUJ3zeNmXagcDsc8lKDsfM1/KMyH4eLgudonYSFmg6M5iYNHG5OthEYmWO7VsJVFaP9PH0Q2OwF7DQ8s2fCceAHOHAWu0Xq8CWpr1ypaZynrt1CdFjZlUxbE8H+kQYJo7bJMPhSzYI22aNwO7G94LFwvgprwQEe4tR3xxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1zOmcGmINDkFaKerVryJEwUNj+BiluiWkz0yymmY7Q=;
 b=BHLwG0natE523uM5RAsMzkkAHAVKSexHj58AJCGxcTpioklWUzzD7sDr4jzlyU3HZDi5gx60yPwuyAiKGL8lVspHRssaaGcS60NTQP4ed8u/dwm4f6oZ6Hl1mlHsXSjZH+hu6QLj4xWHjaz0GUSa//7MQYkeCUrYjebtQBgrFw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:21:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:21:57 +0000
Message-ID: <b45d7e1c-5850-5885-f0f2-dc08e0f146c8@amd.com>
Date:   Tue, 10 Jan 2023 10:21:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com> <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
 <fa99d96e-6897-850a-8a46-98b03696e0bb@amd.com> <Y72CDYBjXi813/KY@nvidia.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <Y72CDYBjXi813/KY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTBP288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f12e026-2c19-41e5-83f3-08daf31e696a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1j1E5pey6jxekmcNQI09QMyHXHcK8pAHdNT99/v1nkBBGlHqcrSdcmNHvwlFiyxf11Z0AKNUSpvDiywhNmkazhk9kAo5/o9c2vbrmBVKX5t2jg/GzEJ32eJ+dFueI+y3Y+S8Jk+qqPK4K+G4JrA5q6KdV4e3SWpEpSX7OKOx2m9ylWX2eTpbg4WpXfsfG+JMkz8QWfiWmFJ3CtbKwyL+3hrhgWe+TEhlUq1daDenZPRM1HZjiXdRY/sgFT2bUCKlqOg3zEkk0NjO0Ebg/1NX4ymhJoLAdv7SqlpNsc1yfYyxMW0DRggb+fdQTB1aWeeaLscOJd+cxH1Ca5qsUVZlFUMh89px1JGTn/guCNoYC7n623hOfgB3FfcMzY2YwI7VcoeegOloHVcaeI8yXxMOXpv6iqmVSHxtNQttwACE1yO9lUq4T94BhZmb6pqtGrJYT/anAHTcNKXsbGQy/JWQ5ttPFLNIHgH7cmcK63qq1sJ1RQr/rO6fCWn3CbERNYnkIFobmrvjIyoG0JDwh6kC+YHxcTG3+Uhwq9giBNS5BgV1sLX5ZcaYoJidX8dZ1ZIMW1vCa4wqVeWLiwJQ9xp/IByInkyheezHoQsDFc3fzAgEl6AEBWQj1fVGZFFH6WYYKDth9gHWUNdg6H0y3AmWnKS/BnRITamBiOv0h2YfH5JArLZcN+DP9yYFmwTNWOGY9ykDRI1CK7UpAk6YZpl2cGCkZfBOz+UCMGfE7UHc87YjeVduISHrVgNYgKOYpWbfJc1e9hVx/V4iApZu1v/uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(6506007)(38100700002)(31686004)(6666004)(2906002)(478600001)(6486002)(966005)(2616005)(7416002)(26005)(6512007)(186003)(44832011)(5660300002)(316002)(83380400001)(8936002)(36756003)(86362001)(66574015)(41300700001)(31696002)(54906003)(4326008)(66946007)(6916009)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0IrcG9jRXhJcG50MmdiVHk1c0xrWW45ZVRoWlZxNUpzVHY5M1AzVGRRNjJx?=
 =?utf-8?B?ZU5XMlJXSktRS0RXNEZhS2VDdDlqREplQnU3bitZelR0TktVTEEzbUdUVG8w?=
 =?utf-8?B?TldsMkRWRnBMOXVnRDE5ZC9NbFZyYjFkQTlmTERxRlpDR0dKMGsxeFhwU1dz?=
 =?utf-8?B?Tk1KMUd5ODU5aThVbVJBU0lOb1BoTkRHcXRyWnFYYW9PSWFZZHVScDRrcExz?=
 =?utf-8?B?Tm11Vjc2SnhpamJoS2JCZ2I4WnlpNUZVakR4cTVoRXkyMWw4L1ExUHJrMXl0?=
 =?utf-8?B?WjZNNHZoTmRSc1podytvSXV2SDF2Y1UwRGJIYm9pamhKUzJWSzJPb1lSLzBn?=
 =?utf-8?B?VnBNc0lLT3llVWJnYmtaRW9zQjRTdkRWSElBZk1GWEhLRnNkSlkrTFFDYTJ2?=
 =?utf-8?B?elJCWW4zVFN5cHo5UXB4RlRHUEVsNXBUakFicElyQ01BN1UvaXJMZldFNXlU?=
 =?utf-8?B?ZGZJaXk5T2JTYWJvU0t5S1ZZMUl3bGl4RWZYWk55S2ttS1ZXNzJabUduVHRG?=
 =?utf-8?B?M0hRSzhBWVhncVdkYVlWbUZSaHMxbE13S3MxZ0o1UnJsVlFqY283VWd2c2xn?=
 =?utf-8?B?eWRIb0FoVU5pVUU2bU1KT2MvenFLMmVZM2xtL1JzdmEvcjhwR25ZSUlQRkhl?=
 =?utf-8?B?bUtVSE1aN2VZRkpoSFAvd0VaaXI5SlhHbXl6L1h6bEVDd2VxRDdCWWJHZmdW?=
 =?utf-8?B?aEUzV1p3a3JqK3pPcmZaMGswYVZPUzdLVVU1cTdkS2k4dk14a2JuRkpGV01Y?=
 =?utf-8?B?N1AvSzNTbzZsZ0VSMmYwN0w1S0JFMWRjeUZYY21jbmRheGgzdkZSUFIxUUVY?=
 =?utf-8?B?ckdlTGlnVmtLK2RuVjJta1FhS0xGTWhTSTg0YTJLWGFXS01vZGVzcjRlZUIz?=
 =?utf-8?B?d3BHSGs2ZVNaUnBEUmRZenVsdnZYVzVHUk9laWZFbFRwREI2VXhPSVZaMEJt?=
 =?utf-8?B?NHNjWExsUGh3K1ZBZzg5YXlYUzNDMllCL0lJTHFnWTRkeUttWEJacVdwT1Mx?=
 =?utf-8?B?SW80YldWOFBmSDRINXNXZlBhZHEzSCt1dEtRd0ozeXY3VUZFTWFRT2pyWXk4?=
 =?utf-8?B?SzVRbVFQdjJTV0V0RzVNS3RJWHA2RXNuQXEyYlU2Q1pwUWRhV3FBRXhVNzhY?=
 =?utf-8?B?M015MFlHd2pWVlloMmM0VGtiMHU4RG9USTkreVIvYlYycFhUYTU5QmVqRXZP?=
 =?utf-8?B?Y1hGY250OEtSMmhFU0R3ejg5ZE9CRDk2dURvNTl5NkhsRTJyYW0xRzJucjhU?=
 =?utf-8?B?a3pLTmt6RXh6N2p3bEwyNUN3VXRaMnlSOHRRckFUN3JmU1NyL1hMeXRtdW9y?=
 =?utf-8?B?eVRHcHhmRndXeTBrMGdrQWJCZlhnS2oxOXFlYjEwRmFVck9PR2RuZUtZRmtM?=
 =?utf-8?B?aHNzQ0xxYXJWNSthbitYUGFIckx2YjQ0Wm8walRmRm9FWWtQbGdqNS9Vbm53?=
 =?utf-8?B?WCtSNUduMkdZMlM5SXYyKzFXaDdNaWR4d1VDRFhNelBpL1FqT3JicnVsSUx4?=
 =?utf-8?B?T3pPY3ZldWdCdkRjR3ZlV3M4Qm1vNE01RU9iRW94OTZkTUFVd1RSRDFpRTdk?=
 =?utf-8?B?Z3dEMzZoVVdyTmFIeDVqMzgrWVZoZ2VxMHU5N0JmRXh5d3h5UXlWZDNXNC92?=
 =?utf-8?B?d0V4ZmVzNitWV1BRdldJVFpMaXlLckhBZHdQSnNZaW92dmVucUJXZnk5WU14?=
 =?utf-8?B?NVEwQnRFTmh4emp4VHJoQWFGTnY3SG1wQUVUV0pNMnB0b2I4VXMzVFNSUVNC?=
 =?utf-8?B?VSs2Vm9Tc2pkYWEvTXZKUk1pdEgxTHdiaXBTY0JEOWVOV1gyb1p0OWRDRGg4?=
 =?utf-8?B?a3BMQWkvZzNjL0hqYWRxSjZ5SzNWcFg5aEdTMHQ1YUNCQm1UeGJaYU9PZWZ0?=
 =?utf-8?B?RWhNa2QzaGZtRHhwNFBJS2xnZnZUMkZkQnQ0aTVvQ0NuVU9CYWp6c2pXQU51?=
 =?utf-8?B?dVRIK3ZrYVB6SkxoYlpGMEpVL0dZRy8zb3pra21PeXRnN3pmZmlQQVplNHZN?=
 =?utf-8?B?RDZlaW5tclQ2VTlNZHUwZ3NNWkpHREV1dXA0TUpQMGhkMjltSFF4SXFRZGx5?=
 =?utf-8?B?VDdxakFOVFRKalA4SkFoSTAvU0dHQ3AzRmVQdlR0UEUzQkZaRjZrdXZGZ2JR?=
 =?utf-8?Q?0JryAUSwbNYogJmVwZRH9wUor?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f12e026-2c19-41e5-83f3-08daf31e696a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:21:57.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kTRR1MngGRHBoBN9KHlhryfvLdWZ28unLKXIjyQYUeAfDwXdBHsYVGmOCrJmez5EY2JZS+7XRheqLDyQJsOCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2023-01-10 um 10:19 schrieb Jason Gunthorpe:
> On Tue, Jan 10, 2023 at 10:05:44AM -0500, Felix Kuehling wrote:
>> Am 2023-01-10 um 08:45 schrieb Christian König:
>>> And I'm like 99% sure that Kabini/Wani should be identical to that.
>> Kabini is not supported by KFD. There should be no calls to amd_iommu_...
>> functions on Kabini, at least not from kfd_iommu.c. And I'm not aware of any
>> other callers in amdgpu.ko.
> The backtrace from the system says otherwise..

That log is for Carrizo, not Kabini:

> [   13.143970] [drm] initializing kernel modesetting (CARRIZO 
> 0x1002:0x9874 >> 0x103C:0x8332 0xCA).
Carrizo is supported by KFD, and it does support ATS/PRI.

Regards,
   Felix


>
>>> [   13.515710]  amd_iommu_attach_device+0x2e0/0x300
>>> [   13.515719]  __iommu_attach_device+0x1b/0x90
>>> [   13.515727]  iommu_attach_group+0x65/0xa0
>>> [   13.515735]  amd_iommu_init_device+0x16b/0x250 [iommu_v2]
>>> [   13.515747]  kfd_iommu_resume+0x4c/0x1a0 [amdgpu]
>>> [   13.517094]  kgd2kfd_resume_iommu+0x12/0x30 [amdgpu]
>>> [   13.518419]  kgd2kfd_device_init.cold+0x346/0x49a [amdgpu]
>>> [   13.519699]  amdgpu_amdkfd_device_init+0x142/0x1d0 [amdgpu]
>>> [   13.520877]  amdgpu_device_init.cold+0x19f5/0x1e21 [amdgpu]
>>> [   13.522118]  ? _raw_spin_lock_irqsave+0x23/0x50
>>> [   13.522126]  amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>>> [   13.523386]  amdgpu_pci_probe+0x161/0x370 [amdgpu]
>>> [   13.524516]  local_pci_probe+0x41/0x80
>>> [   13.524525]  pci_device_probe+0xb3/0x220
>>> [   13.524533]  really_probe+0xde/0x380
>>> [   13.524540]  ? pm_runtime_barrier+0x50/0x90
>>> [   13.524546]  __driver_probe_device+0x78/0x170
>>> [   13.524555]  driver_probe_device+0x1f/0x90
>>> [   13.524560]  __driver_attach+0xce/0x1c0
>>> [   13.524565]  ? __pfx___driver_attach+0x10/0x10
>>> [   13.524570]  bus_for_each_dev+0x73/0xa0
>>> [   13.524575]  bus_add_driver+0x1ae/0x200
>>> [   13.524580]  driver_register+0x89/0xe0
>>> [   13.524586]  ? __pfx_init_module+0x10/0x10 [amdgpu]
>>> [   13.525819]  do_one_initcall+0x59/0x230
>>> [   13.525828]  do_init_module+0x4a/0x200
>>> [   13.525834]  __do_sys_init_module+0x157/0x180
>>> [   13.525839]  do_syscall_64+0x5b/0x80
>>> [   13.525845]  ? handle_mm_fault+0xff/0x2f0
>>> [   13.525850]  ? do_user_addr_fault+0x1ef/0x690
>>> [   13.525856]  ? exc_page_fault+0x70/0x170
>>> [   13.525860]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>> [   13.525867] RIP: 0033:0x7fabd66cde4e
> https://lore.kernel.org/all/157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com/
>
> Jason

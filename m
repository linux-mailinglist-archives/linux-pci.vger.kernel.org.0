Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD521B8F1D
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDZKtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 06:49:41 -0400
Received: from mail-eopbgr700077.outbound.protection.outlook.com ([40.107.70.77]:51361
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgDZKtl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 06:49:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1K1ox6Tm7u2ZJFRelpMMEh5DrtzhWwPaef3mLGG+2mzmOKynHtzjLXAN4K8Z4Do36NSyJBc6AW+l2ih16UoqVwIFrOcpzs3x9HUqL2f2Ua6imKLHwivVhTsgF02UP2bNxdIHOBzFUl47BmK3zrQswESXf04LqDjpkQ/CancbdNPRbe5zd1BAheNsCqwn3MMCr7mwIvoOFLUdHUsqSfctY0y7xi5P4m3p0cy/Pth/Ux8vkE7NRpQZxucn3CdxxDT+72FJ2Fw6jgD69YtxcbMBL9u+uTQ0hb6aoftzdT6F83QIc+TPa2gRqqjPLPpJixIV9A7v1mSJyf08darsWn1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egXL1zdiruVYU+gljyMYGy61tvRflVi2Ir4s45t5iAw=;
 b=bNS1J6AnpnU3Si9klVv2dNtdJaX8q3uFlTemKvjS2zB730OyLDygqLxKGvF0z8yWlgYb8kiy7Ws1qepwOC/1Uzfw8412ZZvBDomIy0DvQtRw8NWOYNgyDnQfK89T2Ud2tKqqMjTS+ZVLHbPkGK/VDKmThQ7Zye7E0n0CQOU61DN9pUc7aU7pnrvprBuR3O26SKzfPY+rRhvIsQ0lnYLlKSpgRY6q7m1DSPOdEVmbirYi6o3THeDw+LbYrvNI2mNSR17fNVer3sDH9XJ0wJfqMpVocYrP+x3MMKJSPFR2YZnvg/V9JOLdLgOj09tgmloyjEB6vsE0DiidpptrVab21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egXL1zdiruVYU+gljyMYGy61tvRflVi2Ir4s45t5iAw=;
 b=fMiFvHQeskTlDgdDJjxpIQJRBFlBdnGptTuEaY/7QFwgF2kHa0U8m/M+XCUrPRH08xXf3mPUhJHp6rkgRuXoTaClCk0uVeLVRT8hrdHODIrVRVhTxBePDWC7JFSUoDqVPdnyxghQPiQ1QF/jLQxrT/JqgTPc7tx3NONd6memgeM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 10:49:35 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 10:49:35 +0000
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices on
 the root bus
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        jon@solid-run.com, wasim.khan@nxp.com
References: <20200421162256.26887-1-ardb@kernel.org>
 <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
 <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
 <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com>
 <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com>
 <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bb75500b-55e9-1491-9ea5-c0794452e097@amd.com>
Date:   Sun, 26 Apr 2020 12:49:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:208:122::27) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:208:122::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 10:49:33 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6da8ddb4-be0c-4864-6c04-08d7e9cf8222
X-MS-TrafficTypeDiagnostic: DM6PR12MB3241:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32410C40DAEEF3A4781596C683AE0@DM6PR12MB3241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66574012)(36756003)(2906002)(31696002)(5660300002)(31686004)(86362001)(316002)(6916009)(52116002)(6666004)(478600001)(8936002)(66556008)(16526019)(81156014)(186003)(66946007)(66476007)(6486002)(8676002)(2616005)(4326008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxjqDHCz9TiQZiunLO6vmeRD5lULN5h+HUTUGGJx+qjzCSoG6OrhG+tXGoi0ccyXQ71hSQuTMcx5a4M7bs9QTtOC0k7qok33Y7rb5rhiX/0uRGcg8XQaJMXSDmshYC5/Id+Iz5JqOAsb8HtvxxLKWRdmrGMvXGexVeT+CGpTtIuZvLGDLYfXcV4O9WYbuhoXxDnC8D2mWeA9GY5ONe5+ydPJCs56DajUK87TvAPYPuJGh4Nc9qedqDcyYX/HbGKDPERzwih24tYo9zhK1Bi7HoM3sbnCrpoL/1Y7MWGpiBAoFyQ/nMfSH/zBUKDdL6u7876fkVf/28DiWxAqx0/T4m5BlaT+3jXzl4UBg/tiF/PFGttuW+/kyCi19+8YYz2pTQ9DERb0O6hjqIEw1OzRtTTNmDQ1QAxe7OSQ7OuGwYk9e7/aI5ozPNOg5gHEUdSB
X-MS-Exchange-AntiSpam-MessageData: 8m6TyXW5OE5wFhhDQyA5+6CuBrJ7uk+QOJC8l1SV4K9hxh/m6592/50ENGN/HFH4D3FaXCkyQ2YNeXh0IVD0++nFOH6k9+oi4Flh2KmL08JWnmNxDgrA/dLue937Nos5beBmH+05wH37sKCI2kxCHZsEW4sZcIaOzVAtk2P/PEsXptem30rxNI9R2pEGNQYGRZNQJLeitFgcz5B+DtVQ7rAfeOsENJKennXucURTmE+vtrjHvPS3VI5aP2bJ+qzhQbNSV/cjgeTtxeIs3DskAX4HlEbxHV3h2chGxOCCPSpqpR2WEeZiod5S2Uszv93RdE6hcG3Q/iTsSaHEt/t63qF1SdJS36bi5XbpUi9K2U2lBT8fq/1QsFpXH1rzt008o1xB0ul4oYb/mvwBRTRbEkSfWfN9ZWTMpjMyybZIxiDGr83rPRqTsXYgM/qLn9n3NIzPPFAxCHLSX5w+stzKzglzTaqigJk5mZyGKmr4bBP8JQQZ3OK9gWu3xkVoMpFungnvPi3xIPzdm5r1zbWU9+lBSDa5pBM1VvHkBJLw5aYrBdOzir/IcqqPskJxLoEF3zQg7ct2oLDNs5QdafxWCUYY4mE4swXbynEBn7dino8PT1bROco4RhvDES0Qoehpv30+RdFCWgrM89PfuUkhRfmKAxYV5yeNjR8GB30OQxefpI6xJQxpHGMRb6UikdI3raOGws+UomFVcufLXnzkwm7DWmtjZOt8W365nU2C7BuEZ79rf6X4NB6v/j7wG9YqiX2y2ZzQCCGBa2olTgLLHJUv/Fv1XQ2EKjVIlL2SGs7+WraV6HHLY34ml2gXCCyoVZEtKtIe3hxMtnEOerPkgktdUn+5zJuKxlweulP8iNc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da8ddb4-be0c-4864-6c04-08d7e9cf8222
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 10:49:35.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3paoYGuu2EEGx0sWDpG3hFPRgCqQeiMgFwR/A4ogVSm9uE/kqNcDzSFEyRF8MzIK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3241
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 26.04.20 um 11:58 schrieb Ard Biesheuvel:
> On Sun, 26 Apr 2020 at 11:08, Christian König <christian.koenig@amd.com> wrote:
>> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
>>> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>> On Tue, 21 Apr 2020 at 18:43, Christian König <christian.koenig@amd.com> wrote:
>>>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
>>>>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
>>>>>> bring the bridge windows of parent bridges in line with the new BAR
>>>>>> assignment.
>>>>>>
>>>>>> This assumes that the device whose BAR is being resized lives on a
>>>>>> subordinate bus, but this is not necessarily the case. A device may
>>>>>> live on the root bus, in which case dev->bus->self is NULL, and
>>>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
>>>>>> will cause it to crash.
>>>>>>
>>>>>> So let's make the call to pci_reassign_bridge_resources() conditional
>>>>>> on whether dev->bus->self is non-NULL in the first place.
>>>>>>
>>>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>> Sounds like it makes sense, patch is
>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>> Thanks Christian.
>>>>
>>>>> May I ask where you found that condition?
>>>>>
>>>> In this particular case, it was on an ARM board with funky PCIe IP
>>>> that does not expose a root port in its bus hierarchy.
>>>>
>>>> But in the general case, PCIe endpoints can be integrated into the
>>>> root complex, in which case they appear on the root bus, and there is
>>>> no reason such endpoints shouldn't be allowed to have resizable BARs.
>>> Actually, looking at this more carefully, I think
>>> pci_reassign_bridge_resources() needs to do /something/ to ensure that
>>> the resources are reshuffled if needed when the resized BAR overlaps
>>> with another one.
>> The resized BAR never overlaps with an existing one since to resize a
>> BAR it needs to be deallocated and disabled. This is done as a
>> precaution to avoid potential incorrect routing and decode of memory access.
>>
>> The call to pci_reassign_bridge_resources() is only there to change the
>> resources of the upstream bridge to the device which is resized and not
>> to adjust the resources of the device itself.
>>
> So does that mean that BAR resizing is only possible if no other BARs,
> either on the same device or on other ones, need to be moved?

Well we don't move any other BARs which currently has resources 
assigned. Otherwise it could happen that we change BARs while somebody 
is using them.

See for example how we use this in amdgpu_device_resize_fb_bar().

1. First we make sure that SW isn't accessing the doorbell any more and 
then release the addresses allocated to the FB/VRAM (0) and the doobell 
(2) BAR:

>         /* Free the VRAM and doorbell BAR, we most likely need to move 
> both. */
>         amdgpu_device_doorbell_fini(adev);
>         if (adev->asic_type >= CHIP_BONAIRE)
>                 pci_release_resource(adev->pdev, 2);
>
>         pci_release_resource(adev->pdev, 0);

2. Then we resize the FB/VRAM BAR to whatever the driver thinks is 
appropriate:

> r = pci_resize_resource(adev->pdev, 0, rbar_size);

3. And last we restart SW access to the doorbell and double check if 
resizing either worked ok or we could fallback to the old configuration:

>         /* When the doorbell or fb BAR isn't available we have no 
> chance of
>          * using the device.
>          */
>         r = amdgpu_device_doorbell_init(adev);
>         if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
>                 return -ENODEV;

Regards,
Christian.

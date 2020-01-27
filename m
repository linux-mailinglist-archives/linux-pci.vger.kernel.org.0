Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0714AA43
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 20:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgA0TNG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 14:13:06 -0500
Received: from mail-eopbgr690077.outbound.protection.outlook.com ([40.107.69.77]:3878
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbgA0TNG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 14:13:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVqfxLNzrqHtncLyPG4ytHufNpBxn5tME0vWCop4c97NYGvDbb6cesziTHYRHgV68ASvAeiImXqBaim6AH+xv9Mt2hvYNk51LUl0fPr2eFlF1Kets47JtX4tFhvY+b3YvMD6dQhzdbjNZsvtJm6NgsHlTTdPVKpPLBu0jyIdHUnkig7C9KiVO8bQd6pu0lgpahU6IF9NGbqEjTJrEyj7mEQdBwd0lSU2qor46kSU3tJLLINOmR06tIyCuJwOJbZO1kBJvLQWIUyBFlPPWyl8XCV+yM0RGNoRUJLTmQYDzLOQ6XpVe0Uux1vsGi/F06QBf+08oNjQgnbBvX1TaAvp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKhWnEPJQAyyR//L6c9b45FVZ9uKgIWCmnHL2pnMNQw=;
 b=V9mMEZQiVVabGmCegcTbgef0XXZkOGJG6WTHNhlO3YuVhBRMDRliGo1ntUdZ+HO9tRdTj0ls1oqyPZNnxUfl9gSKXXO5UPQwlPWl5geGE4Jf80OOJcs4AZ/8jX2LAHgqVeVPgJLB02kbxEV6w99owOH+GnpA2vtr1Kl0PV7d1BpllBWYBEZ5KsG4Y3sHNH+XvzNvsPPJvsZhDhvNZ759Ht5ejagyJhhNH8X2vQzypKFXKpmnCd8OZYGNgw7t9cdAx1wnwcD+7gTAgVpDVcHJFegetk/m4n+e6eeEgs9JoycPGcZrhbN6uWV1bUpMFOgDh1tUZDnsh0tsMyVYg/WsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKhWnEPJQAyyR//L6c9b45FVZ9uKgIWCmnHL2pnMNQw=;
 b=rR6DiUV5J6QDKUiFXWv+GJ38UBrrwrewPF7MUwUQsoIjfKQ9m63cg6RBJvejk3ikdQer61CDzgtykj//mnXFsjCgbrNdz9LGGFGkdqNjS3SGNLnKFO9MQCXAYrZHY5TN6a3r2mAJTijkYfs6JcwoHLfPaupxShszNfy8U6idEtQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from BN6PR12MB1699.namprd12.prod.outlook.com (10.175.97.148) by
 BN6PR12MB1859.namprd12.prod.outlook.com (10.175.97.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Mon, 27 Jan 2020 19:13:02 +0000
Received: from BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::64:3847:8cd3:9e0a]) by BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::64:3847:8cd3:9e0a%6]) with mapi id 15.20.2665.026; Mon, 27 Jan 2020
 19:13:01 +0000
Subject: Re: Disabling ACS for peer-to-peer support
To:     Logan Gunthorpe <logang@deltatee.com>,
        "Skidanov, Alexey" <alexey.skidanov@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Heilper, Anat" <anat.heilper@intel.com>,
        "Zadicario, Guy" <guy.zadicario@intel.com>
References: <BYAPR11MB29171883468FD79722FF3652EE0B0@BYAPR11MB2917.namprd11.prod.outlook.com>
 <3b62f9d6-5b93-e252-3419-3fe5307f7935@amd.com>
 <c09a2da5-25e5-445c-3f34-ca6c96686130@deltatee.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1f3f0f67-865b-0657-da17-896c7b1053fb@amd.com>
Date:   Mon, 27 Jan 2020 20:12:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <c09a2da5-25e5-445c-3f34-ca6c96686130@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::12) To BN6PR12MB1699.namprd12.prod.outlook.com
 (2603:10b6:404:ff::20)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by ZR0P278CA0043.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Mon, 27 Jan 2020 19:12:59 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1631120-3e1e-4e39-08ff-08d7a35ced69
X-MS-TrafficTypeDiagnostic: BN6PR12MB1859:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1859580789A62DCBEF85E2FC830B0@BN6PR12MB1859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02951C14DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(2906002)(6666004)(16526019)(186003)(53546011)(4326008)(110136005)(54906003)(66556008)(66946007)(66476007)(2616005)(498600001)(36756003)(52116002)(31696002)(86362001)(31686004)(8676002)(81156014)(66574012)(81166006)(5660300002)(8936002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1859;H:BN6PR12MB1699.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/onza5TUEcrSxRjn6URLjJ+7OfIqzl4QjqEXpzehDg5Gd5+YCUQTPICRgqAFNLL2DyXs22gQQGvH6s69vVB5+h8/xdXFZwmccPuvtF/iYoNtWLx7cq3U1KFrFMIWE+V01apGv6VxVE5rf35ipyvHKtp71tckz/yrPrP3RwEFLDS2wyhecPqryhvP1Z++/4iAaHC6piIfQTNv05IESCgBE7TTvxejYveCGgLKs77MdhzhRO0dPmr9l4tlEzt0HDvzNq65/XHz1TpZlLQJlIDgu1TrJbFG1G1fYASBcRlzqYTG/fI8kDk8db9oGlthfajkJOy00dSpOh9DGwuQ+6/9jqdk/WirrR/zEO8UoqOiwJLsEOCY7ynt2L7UKNwuSKI4Ab6GVD1gFNgHpQg2Fbtw3b7IZvh6etHafWwoOuew+2HXoP6N2Uf2ASlM6SxImci
X-MS-Exchange-AntiSpam-MessageData: Wx3Jim7ygy8ZlOXu2WG3J8ZHfTTvVgycYUh24cLeCxmmCl7uEyZobaojz9g8ruLVqOWv6110xLlg1F68iU20QYHYuH0Elgwv1zYqEdeNFj+wSK6ViuL9pPrBNNEV/bMwBzZCdHjBZL8DT6jDKVVzSE9X1w76aZLxCk7QKBNgVdTQ5n3POLieOdVP12QS5S2kJ37kJL0k052hVMlmRPHdfw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1631120-3e1e-4e39-08ff-08d7a35ced69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 19:13:01.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lr9TGlp5AFegIqjFiRTIXNCHHFOAB9XCRd0wVpP9OXIhw2oxwxVc979H/83lr4LF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1859
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 27.01.20 um 17:58 schrieb Logan Gunthorpe:
>
> On 2020-01-27 1:18 a.m., Christian König wrote:
>> Am 27.01.20 um 08:18 schrieb Skidanov, Alexey:
>>> Hello,
>>>
>>> I have recently found the below commit to disabling ACS bits. Using kernel parameter is pretty simple but requires to know in advance which devices might be participated in peer-to-peer sessions.
>>>
>>>    Why we can't disable the ACS bits *after* the driver is initialized (and there is a request to connect between two peers) and not *during* device discovering?.
>> That's exactly what was initially proposed but we have seen hardware
>> which reacts allergic to disabling those bits on the fly.
> I wasn't aware of that and haven't seen anything like that.
>
>> Please read up the discussion on the mailing list leading to this patch.
> The issue was the IOMMU code does not allow for any kind of dynamic
> changes in the groups devices are assigned in. In theory, this could be
> possible but you'd still at least have to unbind the devices from their
> driver because you definitely can't change the IOMMU group while there
> are DMA requests in flight. Ultimately it's easier for most use cases to
> just disable it on boot.

As far as I know you can't change the ACS bit either when there are 
transactions in flight on the affected devices/bridges.

Otherwise what could happen is that the response of an transaction takes 
a different path than the request. That in turn can result in quite a 
bunch of ordering problem on the PCIe bus.

But the idea of unbinding a device, changing the bit and rebinding it 
would probably work.

Regards,
Christian.

>
> Logan


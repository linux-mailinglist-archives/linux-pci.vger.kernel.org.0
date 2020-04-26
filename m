Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE901B8E21
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDZJIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 05:08:20 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:6141
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbgDZJIU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 05:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0POEs51MU++k9pgZMdo4d+UTG4OH071cCiuJZqX9UlmNiNuxt/of+iQbVJYpvmn+RH8X2GkcrvpCLN6EyftOrXPmPGRTDGrrFgUXbIUVju0sNH4bejoVvXG8/If00e1RxnbJcfOWoBLz5wbGJNY6LMsbLCF+B+xLYIldv25fY5ylFuFSoyLBN7GwidpfNzt97hcCSklSWxZaHAgcRcwv362J/3wEqQnGFjOue5bsIt5DUDi3U2dd3g4Zmd4bDiNmkybSUFiH7I/gdZ3398H97y8xYbKI/icrHoLmoD9+Flr21NBd41+UUARYClpQZYpRhotxOxnz7CMQj9JN9MYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O34nxvsIS57GMs7MqHjRoDMZWPqiEgtw+oBFuneVWcU=;
 b=gBGCMO7F04tlpFxsg3XuRsu4/E2uQLwzxTVZdOUBcLqxrKT0OjTMNlMJGyqO72SfFH3R909JmqwEDOKlb2WPVtT2CIkfw1tneNd4y3MQvutCbdqY2k48gb6kUCLoCJS+nVhTSOBqSeKv6T60PYloChcBakIP/zd4UoBs5xDIN0LMnVLTf4h3t0YWV53iU6/0EBMV7YHkxR2nowN49v7/ZFCIxjPjnzp5LnPUntQ0lJI4P9FcAyRikT1ZfUImpB0KIABuRtJsMk2Q7YE71WaWvFo9wQdiAuusWCBcJMfvF7xc0CYR16pmlHCXU+b/GDo6k65Tu5CgpFMjT+GTeB9nIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O34nxvsIS57GMs7MqHjRoDMZWPqiEgtw+oBFuneVWcU=;
 b=E9UTBp8dLgqYvdwlsvlyU70+MJAAz2luTOiV0yjrMt8DJzRd8bFAM/uz3SUxIDRDPz1pCiwS7a323QWelvnKqfRojwqd/i/HZI56vDFHv5tca7+1LZfRDIRM7C7b37Y8FZcc7VXImQjwBez0NLvcPkfTg4ox4KnZEsLb6Di2ZOQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 09:08:16 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 09:08:16 +0000
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices on
 the root bus
To:     Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, jon@solid-run.com, wasim.khan@nxp.com
References: <20200421162256.26887-1-ardb@kernel.org>
 <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
 <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
 <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com>
Date:   Sun, 26 Apr 2020 11:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 09:08:14 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df704743-acb8-4b20-4416-08d7e9c15b3f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-Microsoft-Antispam-PRVS: <DM6PR12MB435559CF8D989E46DB5AA4FC83AE0@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(66946007)(6486002)(86362001)(478600001)(31686004)(186003)(16526019)(66556008)(110136005)(31696002)(66476007)(5660300002)(316002)(81156014)(8936002)(6666004)(52116002)(8676002)(2906002)(66574012)(4326008)(2616005)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A06DaPyJE1P1bmNP/rIlNhTRNXSQDuTJmA2/Rstq5Cvw/oYy9PfIJqfMkFF7JBfJ1uNXfNphZDM01l8EVXk9u+sajz4DR+my1g/tgGnMWq5I4Co8zgHB3Bs0JmbKP1Rg17DPC4+uqkIaiIiR1xkyd3P0z2iOrysE6DYcJYWOaMcy7nSZ2m9O845uL4wpi7ILBTKvCzCSrZziXGNXqrlTBioucOBehJvvJwuYLSLr7kKYuZy2Bt4sygnbY+YtB6urfOZ8tJ/orqti09zTzcvFbvYl16g9rNdT/PwPG44OKCeKLzZD/d4g0ZKAexiH90Hridh8/wVcxx3jjPhIDWkAHD5PLJCzVZt5cj9Ls1fO1bFBXdb/5OvPUmc+5iqVEGzU08OoBY/7uojVfeycI/Ur/ItU1tiL9i5KVpwxnb5D+7eLzsHsL7SXr2LZaoouMVcz
X-MS-Exchange-AntiSpam-MessageData: AIv1nf4Kpxgn2qIQwI8SECKM2BOhozjjR/+HgYDflm5TkCE3k4f7QJKh4XtRt52kkJj52lHJGBqIHkVRtY9hwSSdyjGXy2O5ZsDFix9Sp7sQ6wAQYjanBgp7oIc/7Nwu50etNd6gLFBQJimfbA14BvjjPJDgb61eXx16rxBrA4gmYsKv1qbDea6mQROamc4NJOCpPGBRnz0WbEhz7HAQLd2010yyfkn6bPYZfZC5jg/VhEe6RMUIf2bVEKAyxt/zhHlRaHaMs2BcGjEIWKTQhrDe+S4lNmb/V0SxaJyIlxTHxUaZP5DtoTG3OFb3PLN3/5UQ3TSFMytxHEkanCb7/u/VeIRQFTiTBr2jvpwi1OeE9ouotnk77VWg+tFzeEJmg4lxil6FlVPow03b6t7N1B8oQ1z8j4trhQ3jbCxSG2s2wetwsqtyxAO88F0B0y4Sn8CVqjrvNaF24i+i1yHSdxwHRMWgMJKay1qfns+WG9SV8bIFOi2DtpaFrv07j5w+ZFTnot2io27dVMLegrhJ2duUcfa5PXEePy+nGOx8EWtwRrHaGlWsY5mffywPWmbikBIwB8xKH04f9MqMfXHx6zoOTthhAs9YTBeAca2d2vLkyLEvaJvbdvZgh2UL7dShC37tm1e07SGwmj7C+LLabxYX839Ahtp2Lr/JvBiG3+1ZGkcsKoGkn7qD/iE1n22nnyL5hFOzTZh71wyBvAAU9lEsY9H+1gqABAdO9Hd5sUIHLLSOAtuWlThm0orYjq4o5QX+G9iH0b5UjZ8yjAiluwEmhVyXHkx+tUJWvitFKc+gReXWRlPZ1mSs9dAFqvYcyd8T9klZeptz2o8HM/OK8QsVF1gJqKJPpSwyxeMlDy4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df704743-acb8-4b20-4416-08d7e9c15b3f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 09:08:16.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72AidBeRRmr2iBIp495QI+4VgpUm8YFj7tjHB+CVjs7U8TXJI72JmiL0GHxcZDAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>> On Tue, 21 Apr 2020 at 18:43, Christian König <christian.koenig@amd.com> wrote:
>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
>>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
>>>> bring the bridge windows of parent bridges in line with the new BAR
>>>> assignment.
>>>>
>>>> This assumes that the device whose BAR is being resized lives on a
>>>> subordinate bus, but this is not necessarily the case. A device may
>>>> live on the root bus, in which case dev->bus->self is NULL, and
>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
>>>> will cause it to crash.
>>>>
>>>> So let's make the call to pci_reassign_bridge_resources() conditional
>>>> on whether dev->bus->self is non-NULL in the first place.
>>>>
>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> Sounds like it makes sense, patch is
>>> Reviewed-by: Christian König <christian.koenig@amd.com>.
>> Thanks Christian.
>>
>>> May I ask where you found that condition?
>>>
>> In this particular case, it was on an ARM board with funky PCIe IP
>> that does not expose a root port in its bus hierarchy.
>>
>> But in the general case, PCIe endpoints can be integrated into the
>> root complex, in which case they appear on the root bus, and there is
>> no reason such endpoints shouldn't be allowed to have resizable BARs.
> Actually, looking at this more carefully, I think
> pci_reassign_bridge_resources() needs to do /something/ to ensure that
> the resources are reshuffled if needed when the resized BAR overlaps
> with another one.

The resized BAR never overlaps with an existing one since to resize a 
BAR it needs to be deallocated and disabled. This is done as a 
precaution to avoid potential incorrect routing and decode of memory access.

The call to pci_reassign_bridge_resources() is only there to change the 
resources of the upstream bridge to the device which is resized and not 
to adjust the resources of the device itself.

Regards,
Christian.

> Bjorn, did you have any thoughts on this? I could make
> pci_reassign_bridge_resources() take a pci_bus, and handle the root
> bus as a special case. Alternatively, pci_resize_resource() could make
> the distinction, but it will probably need to duplicate some of the
> reassignment that goes on in pci_reassign_bridge_resources() as well.


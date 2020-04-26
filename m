Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012AE1B8F25
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDZKxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 06:53:31 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:6175
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgDZKxa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 06:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjnYuU7Vptu+nXRrEoD+811MQyft5FT6/TB4MuqwOuairo//3iwXVFEDIsy6ZCR5zGH46h+6iPyelUTXkYwGP3XTyPckPmP9nte8neWVwWdHEhGFqjLQaiiB5FwZBVH1WLUcrzRxva8ld0+i8KwaAvGsz1GTAnhieSN7IqoeFkNG0+L0CafwQu2YpF8y5rcG0DXUJTo+/2GXX+cjb0RNVnhhb6t5hn6mpo5klS6SikJIvbp6Ul2VcnNDi+27BFEdFFYaTSSQQWNQHDkfVjAm2GUCzMV7uU0hYvU/L0h2Mv320H47oAHDnSbCN8qW262vd4S/JjTkMkRRyyI0WMYdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I75UV2pW9bkEk2E99yveoklKCLAMOOZ2J7naYO/Uvh4=;
 b=hKifaA2EarWCgBFFMJulz8GW66pE1dQpYb4SqRJJHy9Cpc5XXt9rvVSBAWUA8Xh4N1tOiA/23jmbl06Fj3c6CsP8S6K22YMH8h8gDfdqiVfnE/oAIqKCflZojx7p6hfCk8C+ljQkgsqaeKi23CQJqoccwdgC0CkEMfXaLCM1VGIpy7aOlXRc/XPuEHarCSH7CHXfjbnZ+oIqfw7GmT86CWbUVTEGRC5R2A9gNUXzVJaZ4JsOONqdj8dK+tQ8A26wpvN4iSQuxHZQU7ECsxQ9IeXiDygkyq9AkOWO7gADivWBRFGaNBs1iP6WIKgOps41PLjyUTw8TULr1ItfwDvjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I75UV2pW9bkEk2E99yveoklKCLAMOOZ2J7naYO/Uvh4=;
 b=LHrmjRgAztIGBAU4y5sSqTGcZ3msb4Rwtipi8SJnAM3E4ZPVTihjrRBsqi/mkiG5nIWaJKsfj+5x6t4qccPo7YFXO5G6bXJwpFoaSvcemjXoyHnPfFYfgxh463AGZPWEsG4q1n9WRZNLtzMEW/ZaAonJUGSmMIEJ1c8ikd/9Orc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 10:53:25 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 10:53:25 +0000
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
 <CAMj1kXFWfhYPwfO29Qv6w1-Dk=Ph+ZZEXPgvqf5Abrg3qf2jWA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ea3f1f02-e7da-8baf-1457-ecfe3d95bd02@amd.com>
Date:   Sun, 26 Apr 2020 12:53:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAMj1kXFWfhYPwfO29Qv6w1-Dk=Ph+ZZEXPgvqf5Abrg3qf2jWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::26) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:200:9b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 10:53:23 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa4ee688-7356-4f5b-82e5-08d7e9d00b96
X-MS-TrafficTypeDiagnostic: DM6PR12MB3241:
X-Microsoft-Antispam-PRVS: <DM6PR12MB324199800F6D4BC82BED05FE83AE0@DM6PR12MB3241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66574012)(36756003)(2906002)(31696002)(5660300002)(31686004)(86362001)(316002)(6916009)(52116002)(6666004)(478600001)(8936002)(66556008)(16526019)(81156014)(186003)(66946007)(66476007)(6486002)(8676002)(2616005)(4326008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2FwCSsXVrbDhXV7c3H6dkmlm/m2MnCEahOZwgIoAXzCOaqA67J8bo8U+AbwI+Btbp/jZjOdvp+MumuHhlpssy+xzWRwab14c5BU6yNxoISRrE2UeekDDHjQm5qQF2imDYD9kNJHOhUQvL6Q2qYjHtp4CQhNz6K8OdlJ1wTxCPzMmsn/cqTWcOa5jVOueJjuafVeYS6mxNMnhqsdIXUTE43QCgMmt1EK2MD9zBFTTQhspoJPHwHGk1rXXg8a27ERWn2J0+scR1qMNdzmgnx6nyImWkgvcdfhGz8WEP5HX3N4MZA7nHd1e2TdU0ykwLlHtgCnx0sGyNFiqD0xJBS26NTPuPZg2SYuhVhqSVsFqBV15lEHbrOQR5iNe6ctQ0Wm9v8IE6CQBOudxCv1JcBhOpRp16bFUrtZNDHLxbFd3TSGCu2xtCeP04reIvlwgvUx
X-MS-Exchange-AntiSpam-MessageData: aGy2Tfd/xd1gbovl7G+b0+JvtrZ3iskF6VDNOWnD3kNtalgPd1bMbccnS97CCHp+uKb7KOfH/enGL/lkiJPALxP6u05BL18QlFLiTN8eVcz1JZC/ZfD7qpdxWhontvg98bVGtLibJrp6mlvbznLru4uwRf+MbAalPWnyocL47VEV5Vn/yD5BcE1NK909lKnxgq7qaqL/DDZJELfgr3kZ3wXJwpasT/UgwVGAnJGDjSIXXCoMZxSSRPs2t6nOZMHaCv55tSxe3AoxkStXqeDIDo4e1VnNfQTJ9E4zrbue6dsgEgPeLPIAQmY7PYHk2b2S4nxs2v2hkPdtrMHeyf9ItDTGmG1Dh+kc08WxhB7oaCqHdihWX2HppTSNGmZPlgbKId/eJQ28C+mPLERzqeWM5l4+lhH97h8FU6DPidQgmMOW2joHQ3SPQexRp9zrq5GPh8MNeprawb2SpcnKg8OqLmOzVtQC/RYBDYT4PPl0dQhBUIBXl/bgtgKU4FTdK2caamzagj6z4kC/t7n0nHT3NLI2xvhfWBlWOjmw15+qnEmG3YuEG91dPRZkNTFfV/iI0+sEWKYkYpGLYt87GqVKsEpIIdNbgyWWScFRz93nFGuRtIYCrWgDVHNm0kbVcpQSlqfKiPTGqiQJJ9p0N4jMc3AerRA/Uv/7efKB5sTdXQZXTMufV179kUuH7fbwO4t15B39pThxy1aEtWrEe5K7AWC9zEhwrOpae5tOqAzjDy0Z1abeQPidBhAKm2v2tdKq6S4bUDU9WDp9yi4DEyeOy3be6Fc2Y11jthIV79z5QwORfRZdWfQQtDdI1H91dVcbdzwX+dq8VVungcDaQkh6oELZb8LdiOAh8qxF1i0KgrI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4ee688-7356-4f5b-82e5-08d7e9d00b96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 10:53:25.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHzHkCU5SKHNASchBEyrLjc/BxcUoNrAk3XJYUU6N147MB97q7ZfKbvS4al1unGu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3241
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 26.04.20 um 12:46 schrieb Ard Biesheuvel:
> On Sun, 26 Apr 2020 at 11:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>> On Sun, 26 Apr 2020 at 11:08, Christian König <christian.koenig@amd.com> wrote:
>>> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
>>>> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>> On Tue, 21 Apr 2020 at 18:43, Christian König <christian.koenig@amd.com> wrote:
>>>>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
>>>>>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
>>>>>>> bring the bridge windows of parent bridges in line with the new BAR
>>>>>>> assignment.
>>>>>>>
>>>>>>> This assumes that the device whose BAR is being resized lives on a
>>>>>>> subordinate bus, but this is not necessarily the case. A device may
>>>>>>> live on the root bus, in which case dev->bus->self is NULL, and
>>>>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
>>>>>>> will cause it to crash.
>>>>>>>
>>>>>>> So let's make the call to pci_reassign_bridge_resources() conditional
>>>>>>> on whether dev->bus->self is non-NULL in the first place.
>>>>>>>
>>>>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>> Sounds like it makes sense, patch is
>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>> Thanks Christian.
>>>>>
>>>>>> May I ask where you found that condition?
>>>>>>
>>>>> In this particular case, it was on an ARM board with funky PCIe IP
>>>>> that does not expose a root port in its bus hierarchy.
>>>>>
>>>>> But in the general case, PCIe endpoints can be integrated into the
>>>>> root complex, in which case they appear on the root bus, and there is
>>>>> no reason such endpoints shouldn't be allowed to have resizable BARs.
>>>> Actually, looking at this more carefully, I think
>>>> pci_reassign_bridge_resources() needs to do /something/ to ensure that
>>>> the resources are reshuffled if needed when the resized BAR overlaps
>>>> with another one.
>>> The resized BAR never overlaps with an existing one since to resize a
>>> BAR it needs to be deallocated and disabled. This is done as a
>>> precaution to avoid potential incorrect routing and decode of memory access.
>>>
>>> The call to pci_reassign_bridge_resources() is only there to change the
>>> resources of the upstream bridge to the device which is resized and not
>>> to adjust the resources of the device itself.
>>>
>> So does that mean that BAR resizing is only possible if no other BARs,
>> either on the same device or on other ones, need to be moved?
> OK, so obviously, the current code already releases and reassigns
> resources on the same device.
>
> What I am not getting is how this works with more complex topologies, e.g.,
>
> RP 1
> multi function device (e.g., GPU + HDMI)
> GPU BAR 0 256M
> GPU BAR 1 16 M
> HDMI BAR 0 16 KB
>
> RP 2
> some other endpoint using MMIO64 BARs
>
> So in this case, RP1 will get a prefetchable bridge BAR window of 512
> M, and RP2 may get one that is directly adjacent to that. When
> resizing GPU BAR 0 to 4 GB, the whole hierarchy needs to be
> reshuffled, right?

Correct, yes. Because you not only need to configure the BARs of the 
device(s), but also the bridges in between to get the routing right.

Just wrote another mail with an example how this works on amdgpu. What 
aids us in amdgpu is that the devices only has two 64bit BARs, the 
FB/VRAM which we want to resize and the doorbell.

I can easily disable access to the doorbell BAR temporary in amdgpu, 
otherwise the whole resize wouldn't work at all.

Regards,
Christian.


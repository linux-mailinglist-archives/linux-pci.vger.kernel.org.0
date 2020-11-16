Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C12B3C5E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 06:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgKPFTb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 00:19:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56876 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKPFTa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 00:19:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AG5JCok040603;
        Sun, 15 Nov 2020 23:19:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605503952;
        bh=3oB89CbTYHpl2o9ZDiCY/Ic+iLDClTkUpWMbGhciyBQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GYfchMo9v/DfW6ccVCdckXt4QZKgJrL3G5GMw28kA7JYyz4+K1RKIyv2vPK3lbKr3
         ZLOzNKKyuxJCbpJx4GQD2KGQllnePA8bn5omu05e5fUJZ3DmF/xYaSYt6Z7lwzQI5/
         6COYbZey3qpLaDR0yZjxfqZmD5s4S0UJ76Pf1zq8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AG5JB5Y049190
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 15 Nov 2020 23:19:12 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 15
 Nov 2020 23:19:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 15 Nov 2020 23:19:11 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AG5J6v5020556;
        Sun, 15 Nov 2020 23:19:07 -0600
Subject: Re: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Sherry Sun <sherry.sun@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
References: <20200930153519.7282-16-kishon@ti.com>
 <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <d6d27475-3464-6772-2122-cc194b8ae022@ti.com>
 <VI1PR04MB49602D24F65E11FF1F14294F92E90@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <30c8f7a1-baa5-1eb4-d2c2-9a13be896f0f@ti.com>
 <CAK8P3a38vBXbAWE09H+TSoZUTkFdYDcQmXX97foT4qXQc8t5ZQ@mail.gmail.com>
 <5a9115c8-322e-ffd4-6274-ae98c375b21d@ti.com>
 <CAK8P3a33XSvenqBhuQpGmtLbYydyzY2OQh73150TJtpzW24DTw@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c720de5b-bf76-162f-24cb-07f6fe670bd2@ti.com>
Date:   Mon, 16 Nov 2020 10:49:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a33XSvenqBhuQpGmtLbYydyzY2OQh73150TJtpzW24DTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On 12/11/20 6:54 pm, Arnd Bergmann wrote:
> On Tue, Nov 10, 2020 at 4:42 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> On 10/11/20 8:29 pm, Arnd Bergmann wrote:
>>> On Tue, Nov 10, 2020 at 3:20 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>> On 10/11/20 7:55 am, Sherry Sun wrote:
>>>
>>>>> But for VOP, only two boards are needed(one board as host and one board as card) to realize the
>>>>> communication between the two systems, so my question is what are the advantages of using NTB?
>>>>
>>>> NTB is a bridge that facilitates communication between two different
>>>> systems. So it by itself will not be source or sink of any data unlike a
>>>> normal EP to RP system (or the VOP) which will be source or sink of data.
>>>>
>>>>> Because I think the architecture of NTB seems more complicated. Many thanks!
>>>>
>>>> yeah, I think it enables a different use case all together. Consider you
>>>> have two x86 HOST PCs (having RP) and they have to be communicate using
>>>> PCIe. NTB can be used in such cases for the two x86 PCs to communicate
>>>> with each other over PCIe, which wouldn't be possible without NTB.
>>>
>>> I think for VOP, we should have an abstraction that can work on either NTB
>>> or directly on the endpoint framework but provide an interface that then
>>> lets you create logical devices the same way.
>>>
>>> Doing VOP based on NTB plus the new NTB_EPF driver would also
>>> work and just move the abstraction somewhere else, but I guess it
>>> would complicate setting it up for those users that only care about the
>>> simpler endpoint case.
>>
>> I'm not sure if you've got a chance to look at [1], where I added
>> support for RP<->EP system both running Linux, with EP configured using
>> Linux EP framework (as well as HOST ports connected to NTB switch,
>> patches 20 and 21, that uses the Linux NTB framework) to communicate
>> using virtio over PCIe.
>>
>> The cover-letter [1] shows a picture of the two use cases supported in
>> that series.
>>
>> [1] -> http://lore.kernel.org/r/20200702082143.25259-1-kishon@ti.com
> 
> No, I missed, that, thanks for pointing me to it!
> 
> This looks very  promising indeed, I need to read up on the whole
> discussion there. I also see your slides at [1]  that help do explain some
> of it. I have one fundamental question that I can't figure out from
> the description, maybe you can help me here:
> 
> How is the configuration managed, taking the EP case as an
> example? Your UseCase1 example sounds like the system that owns
> the EP hardware is the one that turns the EP into a vhost device,
> and creates a vhost-rpmsg device on top, while the RC side would
> probe the pci-vhost and then detect a virtio-rpmsg device to talk to.

That's correct. Slide no 9 in [1] should give the layering details.

> Can it also do the opposite, so you end up with e.g. a virtio-net
> device on the EP side and vhost-net on the RC?

Unfortunately no. Again referring slide 9 in [1], we only have
vhost-pci-epf on the EP side which only creates a "vhost_dev" to deal
with vhost side of things. For doing the opposite, we'd need to create
virtio-pci-epf for EP side that interacts with core virtio (and also the
corresponding vhost back end on PCI host).

Thanks
Kishon

> 
>      Arnd
> 
> [1] https://linuxplumbersconf.org/event/7/contributions/849/attachments/642/1175/Virtio_for_PCIe_RC_EP_NTB.pdf
> 

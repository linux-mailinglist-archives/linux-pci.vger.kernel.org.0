Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEACE2B49C9
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 16:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgKPPqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 10:46:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50180 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbgKPPqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 10:46:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AGFkOVu104239;
        Mon, 16 Nov 2020 09:46:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605541584;
        bh=o5t+uCx7ItW5nQ8KW3HQTL7wK+HIkVDh+GCe1ihPz3c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DtdiSme0BqH/yuobIwTbIKCjyIO6bx5eU05TvxHWl3p6amKLx5ifo0vnGrTFhC9AD
         5AAbAi+6yBVh8xleMDNipZtJljAODjGz+cuJq1EgOd2PMEgTaj0W1164Fit+yRph3M
         gD1VuUd3SDpYjYr6LfoUk2Dkom7KhSrf5be1fluc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AGFkObf046972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 09:46:24 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 16
 Nov 2020 09:46:24 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 16 Nov 2020 09:46:24 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AGFkHxS052842;
        Mon, 16 Nov 2020 09:46:18 -0600
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
 <c720de5b-bf76-162f-24cb-07f6fe670bd2@ti.com>
 <CAK8P3a0nTdtADPa_5jduDm5MpBiwBNgs7cYokK5qBZ=RkL1Ktg@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a590bff0-ba9e-8e19-4f09-4838d8afdbb6@ti.com>
Date:   Mon, 16 Nov 2020 21:15:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0nTdtADPa_5jduDm5MpBiwBNgs7cYokK5qBZ=RkL1Ktg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On 16/11/20 9:07 pm, Arnd Bergmann wrote:
> On Mon, Nov 16, 2020 at 6:19 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> On 12/11/20 6:54 pm, Arnd Bergmann wrote:
>>>
>>> This looks very  promising indeed, I need to read up on the whole
>>> discussion there. I also see your slides at [1]  that help do explain some
>>> of it. I have one fundamental question that I can't figure out from
>>> the description, maybe you can help me here:
>>>
>>> How is the configuration managed, taking the EP case as an
>>> example? Your UseCase1 example sounds like the system that owns
>>> the EP hardware is the one that turns the EP into a vhost device,
>>> and creates a vhost-rpmsg device on top, while the RC side would
>>> probe the pci-vhost and then detect a virtio-rpmsg device to talk to.
>>
>> That's correct. Slide no 9 in [1] should give the layering details.
>>
>>> Can it also do the opposite, so you end up with e.g. a virtio-net
>>> device on the EP side and vhost-net on the RC?
>>
>> Unfortunately no. Again referring slide 9 in [1], we only have
>> vhost-pci-epf on the EP side which only creates a "vhost_dev" to deal
>> with vhost side of things. For doing the opposite, we'd need to create
>> virtio-pci-epf for EP side that interacts with core virtio (and also the
>> corresponding vhost back end on PCI host).
> 
> Ok, I see. So I think this is the opposite of drivers/misc/mic and
> the bluefield driver were using, so we would probably end up
> needing both.
> 
> Then again, I guess the NTB driver would give us the functionality
> for free, if it shows a symmetric link?

Right, NTB driver would need "pci_dev" on both sides of the link. But
that would also mean we cannot use pci EP framework which actually uses
"pci_epf".

Thanks
Kishon

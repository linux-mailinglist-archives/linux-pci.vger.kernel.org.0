Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2872F2B039E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 12:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgKLLNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 06:13:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56664 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgKLLNN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 06:13:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACBCtoK009036;
        Thu, 12 Nov 2020 05:12:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605179575;
        bh=EFLylIoHv+6MexgkkHOndI5G3qy16unmmsW+jt8yB/w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=H6pXY2SnxNwFaa63fqv6JYZ5xjb/rX2758wnZiol5AmICMXFsQrHOouRKygIKRNkX
         ghlgbq4W8ssKXAxdWBaAYCGEF3tl92dRksFHmgMqASmVndGxeMFKH+c7D1+RHFlMKZ
         KAfdivZvJIG2KdBo+j4aEREhrDOAQBQWKsRh7INA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACBCtZF108612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 05:12:55 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 05:12:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 05:12:55 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACBCnIs005765;
        Thu, 12 Nov 2020 05:12:50 -0600
Subject: Re: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     Sherry Sun <sherry.sun@nxp.com>, Arnd Bergmann <arnd@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
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
 <VI1PR04MB496067EB79873EEC9329B9B992E80@VI1PR04MB4960.eurprd04.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c3e7cfaa-fda9-46f8-ec9a-b26818bef7b6@ti.com>
Date:   Thu, 12 Nov 2020 16:42:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB496067EB79873EEC9329B9B992E80@VI1PR04MB4960.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sherry,

On 11/11/20 8:19 am, Sherry Sun wrote:
> Hi Kishon,
> 
>> Subject: Re: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express Non-
>> Transparent Bridge
>>
>> Hi Sherry, Arnd,
>>
>> On 10/11/20 8:29 pm, Arnd Bergmann wrote:
>>> On Tue, Nov 10, 2020 at 3:20 PM Kishon Vijay Abraham I <kishon@ti.com>
>> wrote:
>>>> On 10/11/20 7:55 am, Sherry Sun wrote:
>>>
>>>>> But for VOP, only two boards are needed(one board as host and one
>>>>> board as card) to realize the communication between the two systems,
>> so my question is what are the advantages of using NTB?
>>>>
>>>> NTB is a bridge that facilitates communication between two different
>>>> systems. So it by itself will not be source or sink of any data
>>>> unlike a normal EP to RP system (or the VOP) which will be source or sink
>> of data.
>>>>
>>>>> Because I think the architecture of NTB seems more complicated. Many
>> thanks!
>>>>
>>>> yeah, I think it enables a different use case all together. Consider
>>>> you have two x86 HOST PCs (having RP) and they have to be communicate
>>>> using PCIe. NTB can be used in such cases for the two x86 PCs to
>>>> communicate with each other over PCIe, which wouldn't be possible
>> without NTB.
>>>
>>> I think for VOP, we should have an abstraction that can work on either
>>> NTB or directly on the endpoint framework but provide an interface
>>> that then lets you create logical devices the same way.
>>>
>>> Doing VOP based on NTB plus the new NTB_EPF driver would also work and
>>> just move the abstraction somewhere else, but I guess it would
>>> complicate setting it up for those users that only care about the
>>> simpler endpoint case.
>>
>> I'm not sure if you've got a chance to look at [1], where I added support for
>> RP<->EP system both running Linux, with EP configured using Linux EP
>> framework (as well as HOST ports connected to NTB switch, patches 20 and
>> 21, that uses the Linux NTB framework) to communicate using virtio over
>> PCIe.
>>
> 
> I saw your patches at [1], here you take a rpmsg as an example to communicate between
> two SoCs using PCIe RC<->EP and HOST1-NTB-HOST2 for different usercases.
> The VOP code works under the PCIe RC<->EP framework, which means that we can also
> make VOP works under the Linux NTB framework, just like the rpmsg way you did here, right?

Does VOP really work with EP framework? At-least whatever is in upstream
doesn't seem to indicate so.

The NTB framework lets one host with RP port to communicate with another
host with RP port.

The EP Framework lets one device with EP port to communicate with a host
with RP port.

Rest of the trick should be how you tie them together.

PCIe framework creates "pci_device" for each of the devices it
enumerates. NTB framework works on this pci_device to communicate with
the remote host using PCIe bridge. The remote host will use NTB
framework as well.

So depends on what interfaces VOP device provides you can use either NTB
framework or EP framework. If it's going to connect two different
devices in turn creating pci_device on each of the systems, then you can
use NTB framework.

Regards
Kishon

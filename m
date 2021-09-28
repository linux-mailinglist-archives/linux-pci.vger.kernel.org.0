Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776E241AC20
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 11:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbhI1Jn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 05:43:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36688 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhI1Jn3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 05:43:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18S9fVO4090139;
        Tue, 28 Sep 2021 04:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632822091;
        bh=5fhOQ797DjnUOCYG8CdLtVIlk+Gj6NLA3HvgmCL0G5M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=THAo+h53Zr1RHOwJMp4KhBktULaanaSdhX4B71d/6Gd7oZy0fmIPhwRgFmUMzmxXf
         zGk6EwrqaXhZBP3r9pvHyy5uxQN4jY4ZaK7ZXgWwagyEPNCWLV6CFhs28cv7AGlG8S
         4LgPniUYkiw+YSkppOF54ud010h6n8G6n2TKjlqM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18S9fV5e099692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Sep 2021 04:41:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 28
 Sep 2021 04:41:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 28 Sep 2021 04:41:31 -0500
Received: from [10.250.233.140] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18S9fQvT124042;
        Tue, 28 Sep 2021 04:41:27 -0500
Subject: Re: [PATCH v2 0/4] PCI: dwc: pci-dra7xx: miscellaneous improvements
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luca Ceresoli <luca@lucaceresoli.net>
CC:     <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20210531085934.2662457-1-luca@lucaceresoli.net>
 <20210621144109.GC27516@lpieralisi> <20210813155328.GC15515@lpieralisi>
 <46422460-ae9b-3c04-1f59-54bb6631317e@lucaceresoli.net>
 <20210928093009.GA11323@lpieralisi>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <406047fd-4ee8-af7d-41d4-d2c152df8847@ti.com>
Date:   Tue, 28 Sep 2021 15:11:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210928093009.GA11323@lpieralisi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 28/09/21 3:00 pm, Lorenzo Pieralisi wrote:
> On Sun, Sep 19, 2021 at 11:03:00PM +0200, Luca Ceresoli wrote:
>> Hi Lorenzo, Kishon,
>>
>> On 13/08/21 17:53, Lorenzo Pieralisi wrote:
>>> On Mon, Jun 21, 2021 at 03:41:09PM +0100, Lorenzo Pieralisi wrote:
>>>> On Mon, May 31, 2021 at 10:59:30AM +0200, Luca Ceresoli wrote:
>>>>> This is an series of mixed improvements to the DRA7 PCI controller driver:
>>>>> allow building as a loadabel module, allow to get and enable a clock and a
>>>>> small cleanup.
>>>>>
>>>>> Luca
>>>>>
>>>>> Luca Ceresoli (4):
>>>>>   PCI: dwc: Export more symbols to allow modular drivers
>>>>>   PCI: dra7xx: Make it a kernel module
>>>>>   PCI: dra7xx: Remove unused include
>>>>>   PCI: dra7xx: Get an optional clock
>>>>>
>>>>>  drivers/pci/controller/dwc/Kconfig            |  6 ++---
>>>>>  drivers/pci/controller/dwc/pci-dra7xx.c       | 22 +++++++++++++++++--
>>>>>  .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
>>>>>  drivers/pci/controller/dwc/pcie-designware.c  |  1 +
>>>>>  4 files changed, 25 insertions(+), 5 deletions(-)
>>>>
>>>> Hi Kishon,
>>>>
>>>> I'd need your ACK to proceed with this series that looks like it
>>>> is ready to go, please let me know.
>>>
>>> Still need it - please let me know.
>>>
>>> Lorenzo
>>
>> Should I resend the series?
>>
>> BTW it still applies cleanly on both the pci next branch and on mainline
>> master.
> 
> Kishon, please consider ACKing or otherwise comment on this series
> to make some progress.

I had already ACKed this series
https://lore.kernel.org/all/598ee439-6882-5021-1351-f403e762430f@ti.com/

Anyways I'm adding it here again:
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thank You,
Kishon
> 
> Thanks,
> Lorenzo
> 

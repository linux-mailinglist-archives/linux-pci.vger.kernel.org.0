Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE58C1E0527
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 05:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbgEYDbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 23:31:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36096 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbgEYDbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 May 2020 23:31:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04P3Uesi113639;
        Sun, 24 May 2020 22:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590377440;
        bh=9cexhtub3y0goU+WxGAF1+hYEGx59cbcY4t24Ede1Qk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HPCy/TGnaj9AFsCDRYeU4e8AbQKzxIv+Ulz6d4L0iD75o0+7AFtzurQl+H6ZE6cDv
         wYIDMBOtwch3ToHPnkYhLM5/Dr08XIPnZ7TLOX4Nj8LTnFwj/SruOqHPSNA2ijY+Xt
         ullPKfZ6kT/C8faITmUgokmBqbEeO/mHNimFxkQo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04P3UeK1037735
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 24 May 2020 22:30:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 24
 May 2020 22:30:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 24 May 2020 22:30:40 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04P3UaY4024489;
        Sun, 24 May 2020 22:30:37 -0500
Subject: Re: [PATCH v5 03/14] PCI: cadence: Convert all r/w accessors to
 perform only 32-bit accesses
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200522033631.32574-1-kishon@ti.com>
 <20200522033631.32574-4-kishon@ti.com>
 <CAL_JsqJjXUUgTbSAi83w4Eie-sVTrkLLMGh_PRQsd8k2vuua4Q@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <df29309d-8401-4040-eb1e-90bb3af93a82@ti.com>
Date:   Mon, 25 May 2020 09:00:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJjXUUgTbSAi83w4Eie-sVTrkLLMGh_PRQsd8k2vuua4Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/22/2020 9:24 PM, Rob Herring wrote:
> On Thu, May 21, 2020 at 9:37 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Certain platforms like TI's J721E using Cadence PCIe IP can perform only
>> 32-bit accesses for reading or writing to Cadence registers. Convert all
>> read and write accesses to 32-bit in Cadence PCIe driver in preparation
>> for adding PCIe support in TI's J721E SoC.
> 
> Looking more closely I don't think cdns_pcie_ep_assert_intx is okay
> with this and never can be given the PCI_COMMAND and PCI_STATUS
> registers are in the same word (IIRC, that's the main reason 32-bit
> config space accesses are broken). So this isn't going to work at

right, PCI_STATUS has write '1' to clear bits and there's a chance that it
could be reset while raising legacy interrupt. While this cannot be avoided for
TI's J721E, other platforms doesn't have to have this limitation.
> least for EP accesses. And maybe you need a custom .raise_irq() hook
> to minimize any problems (such as making the RMW atomic at least from
> the endpoint's perspective).

This is to make sure EP doesn't update in-consistent state when RC is updating
the PCI_STATUS register? Since this involves two different systems, how do we
make this atomic?

Thanks
Kishon

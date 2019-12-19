Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E42126346
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLSNRr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 08:17:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57998 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNRq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 08:17:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJDHdR9054319;
        Thu, 19 Dec 2019 07:17:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576761459;
        bh=2DtoSfwQF0HK6yLy59cfwpATaGf4HB72ZXQDZhbGl2s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R5PjBEQOKxDt+PpPr87G052DkxfTxvOu3MtDbQn065YlSubStXr7K4hZB73OqtaFe
         JwNVPEMoiMDd1/T7Gj7+BGcPtzp8NUBNPXj/3axcoE39K/5FlOuTgx0KovUghIYWGt
         ZrTBgxHviOq2wqLla3e9uYgd/S3xp356LMSYsAI0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJDHdCb126202;
        Thu, 19 Dec 2019 07:17:39 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 07:17:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 07:17:38 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJDHZa3046472;
        Thu, 19 Dec 2019 07:17:36 -0600
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-6-kishon@ti.com>
 <20191216144932.GY24359@e119886-lin.cambridge.arm.com>
 <d1ee4579-a3da-6a73-3516-a6d264f80995@ti.com>
 <CAK8P3a06XLSa-FHNGsN=b10JrddjbOKAvfU=iXdMa+0L43m5fA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9b40e71a-c18c-a958-84fe-c5a126fe8272@ti.com>
Date:   Thu, 19 Dec 2019 18:49:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a06XLSa-FHNGsN=b10JrddjbOKAvfU=iXdMa+0L43m5fA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

On 19/12/19 5:33 pm, Arnd Bergmann wrote:
> On Thu, Dec 19, 2019 at 12:54 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Andrew,
>>
>> On 16/12/19 8:19 pm, Andrew Murray wrote:
>>> On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
>>>> Certain platforms like TI's J721E allow only 32-bit register accesses.
>>>
>>> When I first read this I thought you meant only 32-bit accesses are allowed
>>> and not other sizes (such as 64-bit). However the limitation you address
>>> here is that the J721E allows only 32-bit *aligned* register accesses.
>>
>> It's both, it allows only 32-bit aligned accesses and the size should be
>> only 32 bits. That's why I always use "readl" in the APIs below.
> 
> In that case, can't you use the pci_generic_config_read32/write32
> functions with a cadence specific .map_bus() function?

pci_generic_config_read32() is for reading configuration space registers
only. The accessors I added here are for the controller IP configuration.

For the configuration space access I use
pci_generic_config_read32/write32()([PATCH 11/13] PCI: j721e: Add TI
J721E PCIe driver).

Thanks
Kishon

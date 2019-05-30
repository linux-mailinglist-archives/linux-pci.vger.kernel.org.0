Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6572F73F
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfE3Fsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 01:48:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53810 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfE3Fsn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2019 01:48:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4U5mMax004090;
        Thu, 30 May 2019 00:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559195302;
        bh=BULubM0Khr8oCYN7XRSztHJqd8sQCkB0CspkSrcCSs8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JqMSTQDEN3DD/f9IU93pGQi+pxbGR0gUzru9HPsXlFgonVjBktxFmcA4HKjqyMNKk
         3LUDpm3n1yShUoMl+NBe8T6vJg/pY1uHqqBtUBKkbAdq0AbrMM5qsNIZj5bFFw/w6y
         WtNki2NsNBuoG13U6/MsP4mBxk/K0Lt5Pe81ojQ4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4U5mM6w010753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 May 2019 00:48:22 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 30
 May 2019 00:48:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 30 May 2019 00:48:22 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4U5mGmj071595;
        Thu, 30 May 2019 00:48:17 -0500
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Vinod Koul <vkoul@kernel.org>
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com>
Date:   Thu, 30 May 2019 11:16:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Vinod Koul

Hi,

On 30/05/19 4:07 AM, Alan Mikhak wrote:
> On Mon, May 27, 2019 at 2:09 AM Gustavo Pimentel
> <Gustavo.Pimentel@synopsys.com> wrote:
>>
>> On Fri, May 24, 2019 at 20:42:43, Alan Mikhak <alan.mikhak@sifive.com>
>> wrote:
>>
>> Hi Alan,
>>
>>> On Fri, May 24, 2019 at 1:59 AM Gustavo Pimentel
>>> <Gustavo.Pimentel@synopsys.com> wrote:
>>>>
>>>> Hi Alan,
>>>>
>>>> This patch implementation is very HW implementation dependent and
>>>> requires the DMA to exposed through PCIe BARs, which aren't always the
>>>> case. Besides, you are defining some control bits on
>>>> include/linux/pci-epc.h that may not have any meaning to other types of
>>>> DMA.
>>>>
>>>> I don't think this was what Kishon had in mind when he developed the
>>>> pcitest, but let see what Kishon was to say about it.
>>>>
>>>> I've developed a DMA driver for DWC PCI using Linux Kernel DMAengine API
>>>> and which I submitted some days ago.
>>>> By having a DMA driver which implemented using DMAengine API, means the
>>>> pcitest can use the DMAengine client API, which will be completely
>>>> generic to any other DMA implementation.

right, my initial thought process was to use only dmaengine APIs in
pci-epf-test so that the system DMA or DMA within the PCIe controller can be
used transparently. But can we register DMA within the PCIe controller to the
DMA subsystem? AFAIK only system DMA should register with the DMA subsystem.
(ADMA in SDHCI doesn't use dmaengine). Vinod Koul can confirm.

If DMA within the PCIe controller cannot be registered in DMA subsystem, we
should use something like what Alan has done in this patch with dma_read ops.
The dma_read ops implementation in the EP controller can either use dmaengine
APIs or use the DMA within the PCIe controller.

I'll review the patch separately.

Thanks
Kishon

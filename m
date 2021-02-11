Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29A318C89
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBKNtE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:49:04 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:38754 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhBKNoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 08:44:23 -0500
X-Greylist: delayed 2385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 08:44:18 EST
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lABcx-0002tK-O0; Thu, 11 Feb 2021 13:03:23 +0000
Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        daire.mcnamara@microchip.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com
References: <20210125162934.5335-1-daire.mcnamara@microchip.com>
 <20210125162934.5335-4-daire.mcnamara@microchip.com>
 <CAMuHMdXJQF3c1b6SXyHnuyA_huO7ZiKJ-_xm1r1h7VcGsv=n9A@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <d47ee0a2-7d9c-5c53-2977-09fa054e856b@codethink.co.uk>
Date:   Thu, 11 Feb 2021 13:03:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXJQF3c1b6SXyHnuyA_huO7ZiKJ-_xm1r1h7VcGsv=n9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/02/2021 13:07, Geert Uytterhoeven wrote:
> Hi Daire,
> 
> On Mon, Jan 25, 2021 at 5:33 PM <daire.mcnamara@microchip.com> wrote:
>> From: Daire McNamara <daire.mcnamara@microchip.com>
>>
>> Add support for the Microchip PolarFire PCIe controller when
>> configured in host (Root Complex) mode.
>>
>> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Thanks for your patch!
> 
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -298,6 +298,16 @@ config PCI_LOONGSON
>>            Say Y here if you want to enable PCI controller support on
>>            Loongson systems.
>>
>> +config PCIE_MICROCHIP_HOST
>> +       bool "Microchip AXI PCIe host bridge support"
>> +       depends on PCI_MSI && OF
>> +       select PCI_MSI_IRQ_DOMAIN
>> +       select GENERIC_MSI_IRQ_DOMAIN
>> +       select PCI_HOST_COMMON
>> +       help
>> +         Say Y here if you want kernel to support the Microchip AXI PCIe
>> +         Host Bridge driver.
> 
> Is this PCIe host bridge accessible only from the PolarFire RISC-V
> CPU cores, or also from softcores implemented in the PolarFire FPGA?
> 
> In case of the former, we want to add a
> 
>      depends on CONFIG_SOC_MICROCHIP_POLARFIRE || COMPILE_TEST


I'd say having it on COMPILE_TEST if there's no polarfire includes
would be useful to allow compile testing of the driver by the build
robots.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

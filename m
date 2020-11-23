Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB852C04DA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 12:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgKWLqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 06:46:54 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:46228 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgKWLqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2020 06:46:54 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1khAJ0-0004vP-Us; Mon, 23 Nov 2020 11:46:50 +0000
Subject: Re: [PATCH v17 3/3] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     Daire.McNamara@microchip.com, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?Q?Javier_Jard=c3=b3n?= <javier.jardon@codethink.co.uk>,
        Sam Bishop <sam.bishop@codethink.co.uk>
References: <20201022132223.17789-4-daire.mcnamara@microchip.com>
 <587df2af-c59e-371a-230c-9c7a614824bd@codethink.co.uk>
 <MN2PR11MB426909C2B84E95AF301C404B96100@MN2PR11MB4269.namprd11.prod.outlook.com>
 <2eee84c9-aa24-2587-5ced-1c2fe30a1d50@codethink.co.uk>
 <20201118163931.GB32004@e121166-lin.cambridge.arm.com>
 <557a37d9-3694-ede1-d7b0-adfba4345fc0@codethink.co.uk>
 <MN2PR11MB42693A7C10C71C327763FA8B96E00@MN2PR11MB4269.namprd11.prod.outlook.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <17dca2c7-18b0-1530-bbc0-f8f92e968a45@codethink.co.uk>
Date:   Mon, 23 Nov 2020 11:46:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB42693A7C10C71C327763FA8B96E00@MN2PR11MB4269.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/11/2020 10:04, Daire.McNamara@microchip.com wrote:
> Hi Ben, Lorenzo,
> 
> We're working through a few issues with our FPGA design file to get PCIe working on our Icicle Kit board.  FYI, PCIe on PolarFire SoC is not directly connected the CPU complex, instead, it is routed through the FPGA fabric.  We believe we have resolved these issues around enabling/disabling clocks to FPGA fabric and memory protection layers and have been propagating the fixes through to our public facing FPGA and software repositories along with other unrelated improvements.  All going well, these changes will arrive shortly.

Thanks for looking a tthis.

> Ben, if you just want to use PCIe on Icicle Kit, the easiest path is probably to keep an eye on the README in our yocto-based repository @ https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp
> [https://avatars1.githubusercontent.com/u/51128733?s=400&v=4]<https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp>
> GitHub - polarfire-soc/meta-polarfire-soc-yocto-bsp: PolarFire SoC yocto Board Support Package<https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp>
> Microchip PolarFire SoC Yocto BSP. Microchip Polarfire-SoC Yocto 'Board Support Package' (BSP) is based on OpenEmbedded (OE). The 'Polarfire SoC Yocto BSP' layer is build on top of the RISC-V Architectural layer (meta-riscv) to provide hardware specific features and additional disk images.
> github.com
> 
> Lorenzo, I'll post v18 of the driver, based on v5.10rc1, and roll up any fixes needed for this PFGA design file shortly. I'll also add MAINTAINERS section.

Is there any way the pcie driver could detect any of these issues and
flag up user facing message saying "FPGA configuration required for PCIe" ?

I will keep an eye on the yocto repo, the USB is also not working
under Linux yet.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

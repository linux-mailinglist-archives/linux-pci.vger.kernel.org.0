Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748C1120415
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 12:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLPLgt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 06:36:49 -0500
Received: from foss.arm.com ([217.140.110.172]:51260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfLPLgt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 06:36:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF3B1FB;
        Mon, 16 Dec 2019 03:36:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33F133F6CF;
        Mon, 16 Dec 2019 03:36:48 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:36:46 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Raspberry Pi 4 PCIe support
Message-ID: <20191216113646.GT24359@e119886-lin.cambridge.arm.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216110113.30436-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 16, 2019 at 12:01:06PM +0100, Nicolas Saenz Julienne wrote:
> This series aims at providing support for Raspberry Pi 4's PCIe
> controller, which is also shared with the Broadcom STB family of
> devices.
> 
> There was a previous attempt to upstream this some years ago[1] but was
> blocked as most STB PCIe integrations have a sparse DMA mapping[2] which
> is something currently not supported by the kernel.  Luckily this is not
> the case for the Raspberry Pi 4.
> 

Hi Nicolas,

This series looks good to me now. Unless there is further feedback I'll ask
Lorenzo to merge this when he returns in the new year.

Thanks for the log2.h efforts - perhaps this can be picked up again one day.

Thanks,

Andrew Murray

> Note the series is based on top of linux next, as the DTS patch depends
> on it.
> 
> [1] https://patchwork.kernel.org/cover/10605933/
> [2] https://patchwork.kernel.org/patch/10605957/
> 
> ---
> 
> Changes since v4:
>   - Rebase DTS patch
>   - Respin log2.h code into it's own series as it's still contentious
>     yet mostly unrelated to the PCIe part
> 
> Changes since v3:
>   - Moved all the log2.h related changes at the end of the series, as I
>     presume they will be contentious and I don't want the PCIe patches
>     to depend on them. Ultimately I think I'll respin them on their own
>     series but wanted to keep them in for this submission just for the
>     sake of continuity.
>   - Addressed small nits here and there.
> 
> Changes since v2:
>   - Redo register access in driver avoiding indirection while keeping
>     the naming intact
>   - Add patch editing ARM64's config
>   - Last MSI cleanups, notably removing MSIX flag
>   - Got rid of all _RB writes
>   - Got rid of all of_data
>   - Overall churn removal
>   - Address the rest of Andrew's comments
> 
> Changes since v1:
>   - add generic rounddown/roundup_pow_two64() patch
>   - Add MAINTAINERS patch
>   - Fix Kconfig
>   - Cleanup probe, use up to date APIs, exit on MSI failure
>   - Get rid of linux,pci-domain and other unused constructs
>   - Use edge triggered setup for MSI
>   - Cleanup MSI implementation
>   - Fix multiple cosmetic issues
>   - Remove supend/resume code
> 
> Jim Quinlan (3):
>   dt-bindings: PCI: Add bindings for brcmstb's PCIe device
>   PCI: brcmstb: Add Broadcom STB PCIe host controller driver
>   PCI: brcmstb: Add MSI support
> 
> Nicolas Saenz Julienne (3):
>   ARM: dts: bcm2711: Enable PCIe controller
>   MAINTAINERS: Add brcmstb PCIe controller
>   arm64: defconfig: Enable Broadcom's STB PCIe controller
> 
>  .../bindings/pci/brcm,stb-pcie.yaml           |   97 ++
>  MAINTAINERS                                   |    4 +
>  arch/arm/boot/dts/bcm2711.dtsi                |   31 +-
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/pci/controller/Kconfig                |    9 +
>  drivers/pci/controller/Makefile               |    1 +
>  drivers/pci/controller/pcie-brcmstb.c         | 1007 +++++++++++++++++
>  7 files changed, 1149 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>  create mode 100644 drivers/pci/controller/pcie-brcmstb.c
> 
> -- 
> 2.24.0
> 

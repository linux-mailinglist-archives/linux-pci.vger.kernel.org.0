Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2A13BF17
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgAOMCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:02:46 -0500
Received: from foss.arm.com ([217.140.110.172]:35804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730234AbgAOMCq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 07:02:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38AC231B;
        Wed, 15 Jan 2020 04:02:45 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E1A3F534;
        Wed, 15 Jan 2020 04:02:43 -0800 (PST)
Date:   Wed, 15 Jan 2020 12:02:38 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, james.quinlan@broadcom.com,
        mbrugger@suse.com, f.fainelli@gmail.com, phil@raspberrypi.org,
        wahrenst@gmx.net, jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Raspberry Pi 4 PCIe support
Message-ID: <20200115120238.GA7233@e121166-lin.cambridge.arm.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216110113.30436-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Applied patches [1,3,4] to pci/brcmstb, please have a look to check
everything is in order after the minor update I included.

Thanks !
Lorenzo

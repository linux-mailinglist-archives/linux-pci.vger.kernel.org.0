Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964CD1D19D3
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbgEMPr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 11:47:28 -0400
Received: from foss.arm.com ([217.140.110.172]:49580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgEMPr2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 11:47:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8EE931B;
        Wed, 13 May 2020 08:47:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0513B3F305;
        Wed, 13 May 2020 08:47:24 -0700 (PDT)
Date:   Wed, 13 May 2020 16:47:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 0/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Message-ID: <20200513154719.GA3486@e121166-lin.cambridge.arm.com>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505161318.26200-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 06:13:13PM +0200, Nicolas Saenz Julienne wrote:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> co-processor, VideoCore. This series adds support for the later.
> 
> Note that there are a set of constraints we have to consider:
>  - We need to make sure the VideoCore firmware interface is up and
>    running before running the VL805 firmware load call.
> 
>  - There is no way to discern RPi4's VL805 chip from other platforms',
>    so we need the firmware load to happen *before* running
>    quirk_usb_handoff_xhci(). Failure to do so results in an unwarranted
>    5 second wait while the fixup code polls xHC's non-existing state.
> 
> By Florian's suggestion I've been spending some time exploring the device
> link[1] API in order to see if that could save us from explicitly creating
> probe dependencies between pcie-brcmstb and firmware/raspberrypi (patch #3).
> Technically these dependencies could be inferred from DT. It turns out Saravana
> Kannan has been looking at this already. A new boot mechanism, activated with
> fw_devlink=on takes care of the device probe ordering on devices with
> consumer/supplier relationships. For now this relationship is created based on
> the usage of generic DT properties, but has no support for vendor-specifc DT
> properties, which we'd be forced to use in order to create a relationship
> between our two devices since our setup is highly non generic. There will
> probably be at some point support for such properties, and we will then be able
> to revisit some of this code.
> 
> All this is based on the work by Tim Gover in RPi's downstream
> kernel[2].
> 
> [1] https://www.kernel.org/doc/html/v4.13/driver-api/device_link.html
> [2] https://github.com/raspberrypi/linux/commit/9935b4c7e360b4494b4cb6e3ce797238a1ab78bd
> 
> ---
> 
> Changes since v7:
>  - Address Stefan's comments
> 
> Changes since v6:
>  - Make rpi_firmware_init_vl805() more robust
>  - Rewrite comments and patch descriptions to be more accessible to non RPi
>    fluent people
>  - Removed Florian's Reviewed-by in patch #2 as function changed
>    substantially
>  - Tested with/witout u-boot
> 
> Changes since v5:
>  - Fix issues reported by Kbuild test robot
> 
> Changes since v4:
>  - Addressed Sergei's comments
>  - Fix potential warning in patch #2
> 
> Changes since v3:
>  - Addressed Greg's comments
> 
> There was no v2, my bad.
> 
> Changes since v1:
>  - Addressed Floarians comments
> 
> Nicolas Saenz Julienne (4):
>   soc: bcm2835: Add notify xHCI reset property
>   firmware: raspberrypi: Introduce vl805 init routine
>   PCI: brcmstb: Wait for Raspberry Pi's firmware when present
>   USB: pci-quirks: Add Raspberry Pi 4 quirk
> 
>  drivers/firmware/Kconfig                   |  3 +-
>  drivers/firmware/raspberrypi.c             | 61 ++++++++++++++++++++++
>  drivers/pci/controller/pcie-brcmstb.c      | 17 ++++++
>  drivers/usb/host/pci-quirks.c              | 16 ++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  9 +++-
>  5 files changed, 104 insertions(+), 2 deletions(-)

Applied to pci/brcmstb, thanks !

Lorenzo

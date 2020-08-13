Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A147243829
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 12:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHMKBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 06:01:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMKBT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Aug 2020 06:01:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3CB4ACF3;
        Thu, 13 Aug 2020 10:01:39 +0000 (UTC)
Message-ID: <a6aecb7a4d270cb23430d25850c85a332555af55.camel@suse.de>
Subject: Re: [PATCH v5 0/9] Raspberry Pi 4 USB firmware initialization rework
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de, andy.shevchenko@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com
Date:   Thu, 13 Aug 2020 12:01:14 +0200
In-Reply-To: <20200629161845.6021-1-nsaenzjulienne@suse.de>
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi everyone.

On Mon, 2020-06-29 at 18:18 +0200, Nicolas Saenz Julienne wrote:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> co-processor, VideoCore. This series reworks how we handle this.
> 
> The previous solution makes use of PCI quirks and exporting platform
> specific functions. Albeit functional it feels pretty shoehorned. This
> proposes an alternative way of handling the triggering of the xHCI chip
> initialization trough means of a reset controller.
> 
> The benefits are pretty evident: less platform churn in core xHCI code,
> and no explicit device dependency management in pcie-brcmstb.
> 
> Note that patch #1 depends on another series[1], that was just applied
> into the clk maintainer's tree.
> 
> The series is based on v5.8-rc3
> 
> v3: https://www.spinics.net/lists/arm-kernel/msg813612.html
> v2: https://lkml.org/lkml/2020/6/9/875
> v1: https://lore.kernel.org/linux-usb/20200608192701.18355-1-nsaenzjulienne@suse.de/T/#t
> 
> [1] https://lore.kernel.org/linux-clk/159304773261.62212.983376627029743900@swboyd.mtv.corp.google.com/T/#t
> 
> ---

We were waiting on a dependency to be merged upstream to get this. They are now
in, so could we move things forward?

I can take the device tree patches, I guess philipp can take the reset
controller code. But I'm not so sure who should be taking the PCI/USB
counterparts.

Regards,
Nicolas

> 
> Changes since v4:
>  - Adress Andy's comments
> 
> Changes since v3:
>  - Rework dt patch to include root bridge as a separate node
>  - Update xhci-pci patch now that the xhci dev has a dt node (it was
>    getting it in the past from its bus)
> 
> Changes since v2:
>  - Add reset to resume routine in xhci-pci
>  - Correct of refcount in pci-quirks
>  - Correct typos
>  - Use include file to define firmware reset IDs
> 
> Changes since v1:
>  - Rework reset controller so it's less USB centric
>  - Use correct reset controller API in xhci-pci
>  - Correct typos
> 
> Nicolas Saenz Julienne (9):
>   dt-bindings: reset: Add a binding for the RPi Firmware reset
>     controller
>   reset: Add Raspberry Pi 4 firmware reset controller
>   ARM: dts: bcm2711: Add firmware usb reset node
>   ARM: dts: bcm2711: Add reset controller to xHCI node
>   usb: xhci-pci: Add support for reset controllers
>   Revert "USB: pci-quirks: Add Raspberry Pi 4 quirk"
>   usb: host: pci-quirks: Bypass xHCI quirks for Raspberry Pi 4
>   Revert "firmware: raspberrypi: Introduce vl805 init routine"
>   Revert "PCI: brcmstb: Wait for Raspberry Pi's firmware when present"
> 
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |  21 +++
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  22 ++++
>  drivers/firmware/Kconfig                      |   3 +-
>  drivers/firmware/raspberrypi.c                |  61 ---------
>  drivers/pci/controller/pcie-brcmstb.c         |  17 ---
>  drivers/reset/Kconfig                         |  11 ++
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-raspberrypi.c             | 122 ++++++++++++++++++
>  drivers/usb/host/pci-quirks.c                 |  22 ++--
>  drivers/usb/host/xhci-pci.c                   |  10 ++
>  drivers/usb/host/xhci.h                       |   2 +
>  .../reset/raspberrypi,firmware-reset.h        |  13 ++
>  include/soc/bcm2835/raspberrypi-firmware.h    |   7 -
>  13 files changed, 215 insertions(+), 97 deletions(-)
>  create mode 100644 drivers/reset/reset-raspberrypi.c
>  create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h
> 


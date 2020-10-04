Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64A282C16
	for <lists+linux-pci@lfdr.de>; Sun,  4 Oct 2020 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgJDSA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 14:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgJDSA2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2020 14:00:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F9C0613CE;
        Sun,  4 Oct 2020 11:00:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qp15so8688798ejb.3;
        Sun, 04 Oct 2020 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xk499YfZyBuik3RX+VLZefCdXI2lXnKFIqJ/ddrg99o=;
        b=jMJnsdlFSxKBL5QSU0XKIRdAMyDNoXz9cHDbVp1VUZzNVlWnWuD5gO+acKPx9+QmYm
         6T0KJW32giwDN4nPHUeTQrzt/vKPQPu9Z03TSdaxN0u1ZFMHw+vWbPB9mHAKngfu2fLC
         t8lRSJV3iNAS5CdZATnSKCM9X1ZqiTQKigdl6ZNvygll9pebNl0Nv3mErrQt+OBE09mx
         SsVt08vmQiclTHcB/9E1k5P7MYfOUEEhlo/FmXOS6tEPzBbyb7aye2h1pgAblYoPBRN+
         lY9zQsmNLsfTLnOE194W2QKz0uLahfu3skEZUTthqyvdrb0A8rEKlw7ElpwP903oh4oD
         AVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xk499YfZyBuik3RX+VLZefCdXI2lXnKFIqJ/ddrg99o=;
        b=X/LsZfo+OXsY/jrl5kN6iP+y37wuiSqjpNx9YDpA175muMGXzSTk1rBKQSrjvsjdql
         QWoGvDdahU0b2m9aXwtB1xaAq0QDsQ7FYDzC2tMoZxPKcJ+65YQqF9kVVWR5HQVfM7Gs
         +Yr0d4CqRKt/8X9bv1rsP0BUw6BICniMoJxbRJ6jw7eKOPvnMQVfPLxhSlqlEJ7VwaKD
         zO24pWhSmBWuwHvFvumBjIIaCuVnI4zItGASmWRWDRJkXJ8D3Il+dcQFiToaKS/9X+dE
         65CsZ+PML2P/ngq4hpZsLAotuYNBg2iAm+2uV/I6raxcEeAPd9ZMyHYbSTfRJULBlaQi
         qmBg==
X-Gm-Message-State: AOAM531Hx5VyxZM0tjGZMOv0B63M70H/KwFPM4FXm4fQnJ0QQ0D3sQ7G
        GQbWgpKxSVEBHSio8jHFLa0e5nSh6Xg=
X-Google-Smtp-Source: ABdhPJw4GTvelU5yeWl6EDYPUr4m4pPkJSKBGA9WExk8Mn4yS+XoJWPcQHMxYHBLrS541OK750uuHw==
X-Received: by 2002:a17:907:2115:: with SMTP id qn21mr11562677ejb.278.1601834426520;
        Sun, 04 Oct 2020 11:00:26 -0700 (PDT)
Received: from localhost.localdomain (p4fc3e21a.dip0.t-ipconnect.de. [79.195.226.26])
        by smtp.googlemail.com with ESMTPSA id n11sm6065906ejs.38.2020.10.04.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 11:00:25 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, robh+dt@kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        systemchip@etron.com
Subject: [RFC PATCH 0/3] GPIO support on the Etron EJ168/EJ188/EJ198 xHCI controllers
Date:   Sun,  4 Oct 2020 18:29:05 +0200
Message-Id: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I have a "Belkin F9K115v2" (wifi router) [0]. It comes with an Etron
EJ168 xHCI controllers soldered to the board. One of the LEDs on this
device is connected to one of the four GPIO lines provided by the
Etron xHCI controller.

The goal of this series to add support for the GPIO controller on the
Etron EJ168/EJ188/EJ198 controllers.

Unfortunately there's no (public) datasheet available. I have Cc'ed
Etron and I'm hoping that they can either provide a datasheet or at
least some code-review feedback.
Instead I used the GPL tarball [0] for this device. Inside this
tarball the relevant "reference" code is in:
  linux/kernels/mips-linux-2.6.31/drivers/usb/host/etxhci-pci.c
Unfortunately it uses magic numbers for the registers instead of
human-readable names. The register names are what I came up with.

For reference, I have tested this on a patched OpenWrt build with the
following .dts changes (I am showing these here so it will be easier
to review the whole series):
	&pcie1 {
		status = "okay";

		xhci: usb-controller@0,0,0 {
			compatible = "pci1b6f,7023";
			reg = <0x0 0x0 0x0 0x0 0x1000>;

			#address-cells = <1>;
			#size-cells = <0>;

			gpio-controller;
			#gpio-cells = <2>;

			xhci_port0: port@1 {
				reg = <1>;
				#trigger-source-cells = <0>;
			};
		};
	};

	leds {
		compatible = "gpio-leds";

		usb3 {
			label = "green:usb3";
			gpios = <&xhci 2 GPIO_ACTIVE_LOW>;
			trigger-sources = <&xhci_port0>;
			linux,default-trigger = "usbport";
		};
	};

In general I followed [2] because it says:
  PCI drivers should have a really good reason for not using the
  pci_register_driver() [...] The main reason [...] is because one
  PCI device implements several different HW services.
My understanding that my driver fits into this category.

I am sending this as RFC because this is my first self-written GPIO
driver as well as my first PCI device driver. Any feedback is welcome!


Best regards,
Martin


[0] https://openwrt.org/toh/belkin/f9k1115v2
[1] https://www.belkin.com/support/dl/F9K1115v2.03.97-GPL-10.2.85.tar.gz
[2] https://www.kernel.org/doc/html/latest/PCI/pci.html#how-to-find-pci-devices-manually


Martin Blumenstingl (3):
  PCI: Add the IDs for Etron EJ168 and EJ188
  dt-bindings: gpio: Add binding documentation for Etron
    EJ168/EJ188/EJ198
  gpio: ej1x8: Add GPIO driver for Etron Tech Inc. EJ168/EJ188/EJ198

 .../devicetree/bindings/gpio/etron,ej1x8.yaml |  48 +++
 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-ej1x8.c                     | 311 ++++++++++++++++++
 include/linux/pci_ids.h                       |   4 +
 5 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml
 create mode 100644 drivers/gpio/gpio-ej1x8.c

-- 
2.28.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7FCB3AA6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfIPMu3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 08:50:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53689 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfIPMu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 08:50:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so4093522wmd.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Sep 2019 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0nWXjEKuyezEGLTlcOc5a95BxXTlVx30DizfXSeliY=;
        b=rCcoPIlrwFYixV0LYkox3EHEWUvNOSmGLVZr5kMmD8v9E4IyKfdkDQSIWvEui/KKuh
         GmfhSKP0nsPa/pvtOtmMfUqNtNxD4LOxUG4mC09v0Z+6hbiaoouuyEmbSi2R6HzIhIcp
         1Fxc50tbkGLdh+IpSlrXopG/0K5wIxL8/MbFIEv2eGaV9/HICIQw2mSCnYuum97wTzq1
         Rxo3OfhlWw5DMCmwSPNejV3DzEgEkj5x7M2ucP58Kz5/FpR/eu5QlBElqOXgoC4G25vZ
         iuIzjhePr/rH6ZSQwjjx14oCB3niPwUoex6SW6Np5cxXkaGSCDd9tPSCyJOpiF3AMrXr
         7bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0nWXjEKuyezEGLTlcOc5a95BxXTlVx30DizfXSeliY=;
        b=odGaCzKr3dQOxm6zJD5rcyDEM+Ui6+rNk2l7bJC0WR2Znco+BcqkyU9+axzyLOqVVm
         +415ewBTzuN6LmlYOcDSqcT8GUIoisyswDJym/5IqaDW2xIs9HF02+6i9X/jCfm/ctPP
         VpjWs0bUEkn7Gsw2h3D9eHCXf31ziPJet4H4HedEIj5+gUupQ21ETfZsd+T1ySjZiRJn
         uXvv9eZ/kak5Q0AlQuYZ2qxCcI2qcIk6F/G9+Q2rvOAR/GmsFyNGTdLVMzaUBAk1exIx
         UdCLU8weLDDeZ7JsYvRXKzmz7FScW7hY4jBawekzgwXLYrbLVMZ1xjTJCOkW9o6ONyC/
         I01g==
X-Gm-Message-State: APjAAAV6P7lNA7PuZSLkrxsBMJdyRuh3+alV3n9j3GWiOxB6UfP0+NGR
        cHSbp2AKihMjLIJVd1h6EEHpGg==
X-Google-Smtp-Source: APXvYqxt1quSs6ZODA5XRA7qdpJ1rjqMP7CeuDbJm5vLj3TnHa4eGsYXp/6f5dSgZsxBwneSvqn0tQ==
X-Received: by 2002:a7b:ce0e:: with SMTP id m14mr14440842wmc.138.1568638224331;
        Mon, 16 Sep 2019 05:50:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12sm15109960wrm.23.2019.09.16.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:50:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, andrew.murray@arm.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 0/6] arm64: dts: meson-g12: add support for PCIe
Date:   Mon, 16 Sep 2019 14:50:16 +0200
Message-Id: <20190916125022.10754-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset :
- updates the Amlogic PCI bindings for G12A
- reworks the Amlogic PCIe driver to make use of the
G12a USB3+PCIe Combo PHY instead of directly writing in
the PHY register
- adds the necessary operations to the G12a USB3+PCIe Combo PHY driver
- adds the PCIe Node for G12A, G12B and SM1 SoCs
- adds the commented support for the S922X, A311D and S905D3 based
VIM3 boards.

The VIM3 schematic can be found at [1].

This patchset is dependent on Remi's "Fix reset assertion via gpio descriptor"
patch at [2].

This patchset has been tested in a A311D VIM3 and S905D3 VIM3L using a
128Go TS128GMTE110S NVMe PCIe module.

For indication, here is a bonnie++ run as ext4 formatted on the VIM3:
     ------Sequential Output------ --Sequential Input- --Random-
     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP /sec %CP
  4G 93865  99 312837  96 194487  23 102808  97 415501 21 +++++ +++

and the S905D3 VIM3L version:
     ------Sequential Output------ --Sequential Input- --Random-
     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
  4G 52144  95 71766  21 47302  10 57078  98 415469  44 +++++ +++

Changes since v1 at [3]:
 - Collected Andrew's and Rob's Reviewed-by tags
 - Added missing calls to phy_init/phy_exit
 - Fixes has_shared_phy handling for MIPI clock
 - Add comment in the DT concerning firmware setting the right properties
 - Added SM1 Power Domain to PCIe node

[1] https://docs.khadas.com/vim3/HardwareDocs.html
[2] https://patchwork.kernel.org/patch/11125261/
[3] https://patchwork.kernel.org/cover/11136927/

Neil Armstrong (6):
  dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
  PCI: amlogic: Fix probed clock names
  PCI: amlogic: meson: Add support for G12A
  phy: meson-g12a-usb3-pcie: Add support for PCIe mode
  arm64: dts: meson-g12a: Add PCIe node
  arm64: dts: khadas-vim3: add commented support for PCIe

 .../bindings/pci/amlogic,meson-pcie.txt       |  12 +-
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  33 +++++
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  25 ++++
 .../amlogic/meson-g12b-s922x-khadas-vim3.dts  |  25 ++++
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |   4 +
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    |  25 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |   4 +
 drivers/pci/controller/dwc/pci-meson.c        | 132 ++++++++++++++----
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    |  70 ++++++++--
 9 files changed, 292 insertions(+), 38 deletions(-)

-- 
2.22.0


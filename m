Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066E67CCB3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 14:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjAZNwd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 08:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAZNwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 08:52:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44038B58;
        Thu, 26 Jan 2023 05:52:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y11so1913421edd.6;
        Thu, 26 Jan 2023 05:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/utpGi9Sj4ZWSR6S5xWYZJs1OXgTpwnJji6XxOBsQHk=;
        b=e1P+20j/6nhVWppBGex+gw+GwZFJt6OcOd7V2PJc0RKeAADWDnRBEWyhBNtEQE6EgQ
         YyAMhXDnYKc3JwOwK3eQxdc/Ms9SdxecN+cJG+QJQk+KE0F49AEbaVUf+nHjCqDhedc4
         VRPSv/cT5ohxhTy0CH6AtLzJTGRXgN3BBvlX622kAKyhZ9YyGt6jhfaeVNvBeXBJBwtM
         iPXcgqq9KzeUfQcvWafFr2YYUX64C9JKMVLIAv7Mnutdp0LmEfcUItG03mE57T1yLJUX
         vXZo82WXoyQ02MLS11uLz+AULhye+hb4Vfw/YrIA/MPVQ5DQyyaczb1c3xwTvvCfImbb
         h4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/utpGi9Sj4ZWSR6S5xWYZJs1OXgTpwnJji6XxOBsQHk=;
        b=y9aJZR1WVzZLE2pN0DaMlh0morWtqEiFU6DgYxO+3f13bAF7nexUr3Tnokrv7w1Z55
         qw1rUFXh/U0UjJPSC24Id3qqHDLgTdKqdU6Ggt1T/A3IBFetVDEpDi/uHa1AuMKsxJ7h
         tGSa/usXN+lspVfDIAUxO21+usTXXZ1bfYNA7xOevTdfK7jaoSpxs7LBr5CqjWQkzavj
         OqGobPDNsGQeNDgeRNnCRU9UjAl1O/3APM1EaOCB546oqDNN0+vhr9FqpbsKd/dENRaD
         JFo4m16eLogwnSzyylvxx+a4xCqPiHQk77jOCtpn7Xl3yRvI71dYbQ1GT+6BZpL5jMm5
         LUvA==
X-Gm-Message-State: AFqh2kouj2CGwN0xpKz6o5dg33iBFExwj+s43ajKHfKbi2A03KQ7Si9V
        FQdj58XNBCNcVBNJs8V6v6M=
X-Google-Smtp-Source: AMrXdXtFieJ03Uo5sU104yDj5AjQBhROWXTyTZVJMlAx8ealwxx/EzBpGCQxg79gSkOclJ89dKKxKQ==
X-Received: by 2002:a05:6402:43ce:b0:461:2288:6808 with SMTP id p14-20020a05640243ce00b0046122886808mr39285650edc.21.1674741143906;
        Thu, 26 Jan 2023 05:52:23 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id t15-20020a508d4f000000b004a0e2fe619esm591611edt.39.2023.01.26.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:52:23 -0800 (PST)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, wenrui.li@rock-chips.com,
        rick.wertenbroek@heig-vd.ch,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/8] PCI: rockchip: Fix PCIe endpoint controller driver
Date:   Thu, 26 Jan 2023 14:50:40 +0100
Message-Id: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a series of patches that fixes the PCIe endpoint controller driver
for the Rockchip RK3399 SoC. It is based on Linux kernel 6.0.19

The original driver in mainline had issues and would not allow for the
RK3399 to operate in PCIe endpoint mode. This patch series fixes that so
that the PCIe core controller of the RK3399 SoC can now act as a PCIe
endpoint.

This patch series has been tested on kernel 6.0.19 (and 5.19)
on real hardware, a FriendlyElec NanoPC-T4 RK3399 based single computer
board connected to a host computer through PCIe x1 and x4. The PCIe
endpoint test function driver was loaded on the SoC and the PCIe endpoint
test driver was loaded on the host computer. The following tests were
executed through this setup :

* enumeration of the PCIe endpoint device (lspci)
  lspci -vvv
* validation of PCI header and capabilities
  setpci and lspci -xxxx
* device was recognized by host computer dans PCIe endpoint test driver
  was loaded
  lspci -v states "Kernel modules: pci_endpoint_test"
* tested the BARs 0-5
  sudo /sur/bin/pcitest -b 0
  ...
  sudo /usr/bin/pcitest -b 5
* tested legacy interrupt through the test driver
  sudo /usr/bin/pcitest -i 0
  sudo /usr/bin/pcitest -l
* tested MSI interrupt through the test driver
  sudo /usr/bin/pcitest -i 1
  sudo /usr/bin/pcitest -m 1
* tested read/write to and from host through the test driver with checksum
  sudo /usr/bin/pcitest -r -s 1024
  sudo /usr/bin/pcitest -w -s 1024
* tested read/write with DMA enabled (all read/write tests also did IRQ)
  sudo /usr/bin/pcitest -r -d -s 8192
  sudo /usr/bin/pcitest -w -d -s 8192

Summary of changes :

This patch series is composed of 8 patches that do the following :
* Removed writes to unused registers in the PCIe core register space.
  The registers that were written to is marked "unused" and read
  only in the technical reference manual of the RK3399 SoC.
* Fixed setup to the PCI Device ID (DID), this was written to a read
  only register and therefore would not update the DID.
* Fixed setup of the PCIe endpoint controller so that it would stop
  sending Configuration Request Retry Status (CRS) messages to the
  host once configured, without this the host would retry until
  timeout and cancel the PCI configuration.
* Added a poll with timeout to check the PHY PLL lock status, this
  is the only patch that also applies to the root complex function
  of the PCIe core controller, without this the kernel would
  sometimes access registers in the PHY PLL clock domain when the PLLs
  were not yet locked and the system would hang. This was hackily solved
  in other non mainline patches (e.g., in armbian) with a "msleep()"
  that was added after PHY PLL configuration but without realizing
  why it was needed. A poll with timeout seems like a sane approach.
* Added a dtsi entry for the PCIe endpoint controller. The new entry is
  in "disabled" status by default, so unless it is explicitly enabled
  it will not conflict with the PCIe root complex controller entry.
  Developers that will enable it would know that the root complex function
  then must be disabled, this can be done in the board level DTS.
* Fixed the window translation between CPU space and PCI space.
  Allows up to 32 memory windows, with (1MB) page allocation and mapping.
* Fixed the legacy IRQ (INTx) generation of the PCIe core in
  endpoint mode.
* Fixed the generation of message signalled interrupts (MSI) of the
  PCIe core in endpoint mode.

Thank you in advance for reviewing these changes and hopefully
getting this merged. Having a functional PCIe endpoint controller
driver for the RK3399 would allow to develop further PCIe endpoint
functions through the Linux PCIe endpoint framework using this SoC.

I have tested and confirmed all basic functionality required for the
endpoint with the test driver and tools. With the previous state of
the driver the device would not even be enumerated by the host
computer (mainly because of CRS messages being sent back to the root
complex) and tests would not pass (driver would not even be loaded
because DID was not set correctly) and then only the BAR test would
pass. Now all tests pass as stated above.

Best regards
Rick

Commands used on the SoC to launch the endpoint function (configfs) :

modprobe -i pci-epf-test
mkdir -p /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0
echo 0xb500 > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0/deviceid
echo 0x104c > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0/vendorid
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0/msi_interrupts 
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/pci_epf_test.0 \
/sys/kernel/config/pci_ep/controllers/fd000000.pcie-ep/
echo 1 > /sys/kernel/config/pci_ep/controllers/fd000000.pcie-ep/start

Note: to enable the endpoint controller on the board the file :
arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
Was edited to set the status of &pcie0 to "disabled" and &pcie0_ep
to "okay". This is not submitted as a patch because most users
will use the PCIe core controller in host (root complex) mode
rather than endpoint mode.

Rick Wertenbroek (8):
  PCI: rockchip: Removed writes to unused registers
  PCI: rockchip: Fixed setup of Device ID
  PCI: rockchip: Fixed endpoint controller Configuration Request Retry
    Status
  PCI: rockchip: Added poll and timeout to wait for PHY PLLs to be
    locked
  PCI: rockchip: Added dtsi entry for PCIe endpoint controller
  PCI: rockchip: Fixed window mapping and address translation for
    endpoint
  PCI: rockchip: Fixed legacy IRQ generation for endpoint
  PCI: rockchip: Fixed MSI generation from PCIe endpoint core

 arch/arm64/boot/dts/rockchip/rk3399.dtsi  |  25 ++++
 drivers/pci/controller/pcie-rockchip-ep.c | 149 +++++++++++-----------
 drivers/pci/controller/pcie-rockchip.c    |  16 +++
 drivers/pci/controller/pcie-rockchip.h    |  36 ++++--
 4 files changed, 137 insertions(+), 89 deletions(-)

-- 
2.25.1


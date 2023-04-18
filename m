Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206B66E5AC5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDRHsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 03:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjDRHsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 03:48:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884E7289;
        Tue, 18 Apr 2023 00:47:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u3so18830849ejj.12;
        Tue, 18 Apr 2023 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681804063; x=1684396063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slOsWP9dy0zTlu7ombkr/cRCckFIfTiMBYYVFS3qfQo=;
        b=gmi9fGZmBcEBdIgLF5KVDMoX76tDEIAGXPtEyAmT/R5wxZ9UUxjTTJ07IAlVBXh+ah
         RtC8mQ7qepF/w+ibQLXKAHXzI6iHIf2WdvI/WYWyB1Utj9QiGi8+jitp0Pefv0XMtD1R
         VSevoddk9k7IvFthUse5QN9DfWKhKUjey0ll1i/w8tafG0AMJ6Jax+A2ZWj74Behk1OB
         bhPab33ThF6Yw85xZ94wct6koTL/uEzLPlAlhxf9ahUPiWGoAD7bWFSg2ztgmWtoHske
         /pfxbVVFQMwg5Hnspynhm8VhMdpbgHgZGBieLIzy4GdCuSM1Q739rpj4NbEYv+ZJ3d5M
         h2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681804063; x=1684396063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slOsWP9dy0zTlu7ombkr/cRCckFIfTiMBYYVFS3qfQo=;
        b=Uf1OTTiaGB6Nrh61w5lQqzSMz4+ojlWr2O/stflVvtsbRyfH4H8RgjOehVOMRxNPQb
         9DfiN1lH+YDfte0H8AIuN9vin2CNMjMbfy+i3+LJfksswMxslz3V+KWJkAX4ljHBNbjk
         r5sdWKKEX1Y7NAMj+OeDI0FHknHX9jqWAgMSntfAVAxYKTt9eJ4FRjvGWgILsUhf70kd
         R0quK9jY+qvNyuiiMGFIHTt2Nulp5e8qCTxMBkphrcGbPnBVMGp1ZLdVUSVyFaslJq39
         Yr9UjutztcVn4l6Lbhiv407oZ/GmGiwGT76F1Dnyuq7IQ9FIUssvA3jg4hgA/RFMAoAY
         ddBQ==
X-Gm-Message-State: AAQBX9fyR6DxhPX4rrRqIbxnaBJ9ll4T6d07JuSuD8g+hF6Vu/CPix+z
        VTIn+qUQcm30SGT5IH622+HFmu+eMCy8uA==
X-Google-Smtp-Source: AKy350YgkNlI6WP3hpYR8IbVNvNmINGaN965qYF1GSX6dnaXIDKE+CGE4249jxd6RkEGubYgVbGeRA==
X-Received: by 2002:a17:906:1e4c:b0:94e:c926:ae6b with SMTP id i12-20020a1709061e4c00b0094ec926ae6bmr9642545ejj.16.1681804062865;
        Tue, 18 Apr 2023 00:47:42 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id gs8-20020a1709072d0800b0094f694e4ecbsm3048545ejc.146.2023.04.18.00.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:47:40 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, dlemoal@kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Judy Hsiao <judyhsiao@chromium.org>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/11] PCI: rockchip: Fix RK3399 PCIe endpoint controller driver
Date:   Tue, 18 Apr 2023 09:46:47 +0200
Message-Id: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a series of patches that fixes the PCIe endpoint controller driver
for the Rockchip RK3399 SoC. The driver was introduced in commit
cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
The original driver had issues and would not allow for the RK3399 to
operate in PCIe endpoint mode correctly. This patch series fixes that so
that the PCIe core controller of the RK3399 SoC can now act as a PCIe
endpoint. This is v5 of the patch series and addresses the comments received
during the review of the v4 [1]. The changes to the v4 are minor and none of
them change the logic of the driver.

Thank you in advance for reviewing this patch series and hopefully
getting this merged. Having a functional PCIe endpoint controller
driver for the RK3399 would allow to develop further PCIe endpoint
functions through the Linux PCIe endpoint framework using this SoC.

[1] https://lore.kernel.org/linux-pci/20230417092631.347976-1-rick.wertenbroek@gmail.com/

Summary of changes to V4 :

* [minor] Added "reviewed-by" tags from the mailing list to patches 1,7,8,9,10
* [minor] Added missing "fixes" tag in patches 10,11
* [minor] Added missing "signed-off-by" tag to patch 11
* [minor] Moved split of long line from patch 8 to 3 where it was introduced

Summary of changes to V3 :

* Set the fields in the standard order in the dtsi and removed unnecessary
  change in associated documentation, thanks to Krzysztof for pointing this out.
* Added comment to explain how MSI-X capabilities advertisement was removed.
* Changed Damien Le Moal <damien.lemoal@opensource.wdc.com> address to his
  kernel.org address Damien Le Moal <dlemoal@kernel.org> in tags.
* [minor] Simplified code where a power of 2 was applied followed by a ilog2
  operation.
* [minor] Small code changes, replaced constant variable by macro, splitted
  remaining long lines.

Summary of changes to V2 :

* Fix issue with memory mapping from PCIe space to physical space
  There was a small mistake with the number of bits passed from the AXI
  physical address to the PCIe space address.
* Disable the advertisement of MSI-X capabilities by the endpoint
  According to the technical reference manual the controller cannot
  generate MSI-X, so the controller should not advertise this capability.
* Add the alignment value to the endpoint attributes.
* [minor] Clean code (line length, variable names, small refactorings).
  As pointed out by reviews on the V2.
* [minor] Fix error in variable name.
* [minor] Remove a patch that introduced unnecessary late parameter checks.

General problem statement and overview of the patch series :

Problem: The Rockchip RK3399 PCIe endpoint controller driver introduced in
commit cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe
controller") did not work.

Summary of problems with the driver :

* Missing dtsi entry
* Could not update Device ID (DID)
* The endpoint could not be configured by a host computer because the
  endpoint kept sending Configuration Request Retry Status (CRS) messages
* The kernel would sometimes hang on probe due to access to registers in
  a clock domain of which the PLLs were not locked
* The memory window mapping and address translation mechanism had
  conflicting mappings and did not follow the technical reference manual
  as to how the address translation should be done
* Legacy IRQs were not generated by the endpoint
* Message Signaled interrupts (MSI) were not generated by the endpoint
* MSI-X capabilities were advertised but the controller cannot generate
  them according to the technical reference manual

The problems have been addressed and validated through tests (see below).

Summary of patches :

This patch series is composed of 11 patches that do the following :
1) Remove writes to unused registers in the PCIe core register space.
   The registers that were written to is marked "unused" and read
   only in the technical reference manual of the RK3399 SoC.
2) Write PCI Device ID (DID) to correct register, the DID was written to
   a read only register and therefore would not update the DID.
3) Assert PCI Configuration Enable bit after probe so that it would stop
   sending Configuration Request Retry Status (CRS) messages to the
   host once configured, without this the host would retry until
   timeout and cancel the PCI configuration.
4) Add poll and timeout to wait for PHY PLLs to be locked, this
   is the only patch that also applies to the root complex function
   of the PCIe core controller, without this the kernel would
   sometimes access registers in the PHY PLL clock domain when the PLLs
   were not yet locked and the system would hang. This was hackily solved
   in other non mainline patches (e.g., in armbian) with a "msleep()"
   that was added after PHY PLL configuration but without realizing
   why it was needed. A poll with timeout seems like a sane approach.
5) Add dtsi entry for RK3399 PCIe endpoint core. The new entry is
   in "disabled" status by default, so unless it is explicitly enabled
   it will not conflict with the PCIe root complex controller entry.
   Developers that will enable it would know that the root complex function
   then must be disabled, this can be done in the board level DTS.
6) Update the RK3399 example in the documentation to a valid one.
7) Fix legacy IRQ generation for RK3399 PCIe endpoint core, the legacy IRQs
   were not sent by the device because their generation did not follow the
   instructions in the technical reference manual. They now work.
8) Fix window mapping and address translation for endpoint. The window
   mapping and address translation did not follow the technical reference
   manual and a single memory region was used which resulted in conflicting
   address translations for memory allocated in that region. The current
   patch allows to allocate up to 32 memory windows with 1MB pages.
9) Use u32 variable to access 32-bit registers, u16 variables were used to
   access and manipulate data of 32-bit registers, this would lead to
   overflows e.g., when left shifting more than 16 bits.
10) Don't advertise MSI-X in PCIe capabilities because according to the TRM
    the controller is not capable of generating them.
11) Set address alignment for the endpoint mode.

Validation on real hardware:

This patch series has been tested by me with kernels 6.0.19, 6.1.21-24,
and 5.19 on real hardware, a FriendlyElec NanoPC-T4 RK3399 based single
computer board connected to a host computer through PCIe x1 and x4. The
driver was also tested by Damien Le Moal <damien.lemoal@opensource.wdc.com>
on a Pine Rockpro64 board [2,3,4].

[2] https://lore.kernel.org/linux-pci/20230330085357.2653599-1-damien.lemoal@opensource.wdc.com/
[3] https://lore.kernel.org/linux-pci/29a5ccc3-d2c8-b844-a333-28bc20657942@fastmail.com/
[4] https://lore.kernel.org/linux-pci/ea29e339-6f61-5bbb-7290-03df629d5b11@kernel.org/

The PCIe endpoint test function driver was loaded on the SoC and the PCIe
endpoint test driver was loaded on the host computer. The following tests were
executed through this setup :

* enumeration of the PCIe endpoint device (lspci)
  lspci -vvv
* validation of PCI header and capabilities
  setpci and lspci -xxxx
* device was recognized by host computer dans PCIe endpoint test driver
  was loaded
  lspci -v states "Kernel modules: pci_endpoint_test"
* tested the BARs 0-5
  sudo /usr/bin/pcitest -b 0
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
* tested larged transfers e.g., 100kB with and without DMA

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

I have tested and confirmed all functionality required for the
endpoint with the test driver and tools. With the initial driver commit
cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
the device would not even be enumerated by the host computer (mainly because
of CRS messages being sent back to the root complex) and tests would not pass
(driver would not even be loaded because DID was not set correctly)
and then only the BAR test would pass. Now all tests pass as stated above.

Best regards
Rick

Damien Le Moal (1):
  PCI: rockchip: Set address alignment for endpoint mode

Rick Wertenbroek (10):
  PCI: rockchip: Remove writes to unused registers
  PCI: rockchip: Write PCI Device ID to correct register
  PCI: rockchip: Assert PCI Configuration Enable bit after probe
  PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
  arm64: dts: rockchip: Add dtsi entry for RK3399 PCIe endpoint core
  dt-bindings: PCI: Update the RK3399 example to a valid one
  PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
  PCI: rockchip: Fix window mapping and address translation for endpoint
  PCI: rockchip: Use u32 variable to access 32-bit registers
  PCI: rockchip: Don't advertise MSI-X in PCIe capabilities

 .../bindings/pci/rockchip,rk3399-pcie-ep.yaml |   4 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  27 +++
 drivers/pci/controller/pcie-rockchip-ep.c     | 221 ++++++++----------
 drivers/pci/controller/pcie-rockchip.c        |  17 ++
 drivers/pci/controller/pcie-rockchip.h        |  49 ++--
 5 files changed, 181 insertions(+), 137 deletions(-)

-- 
2.25.1


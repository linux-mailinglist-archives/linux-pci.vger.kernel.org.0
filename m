Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B3696603
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjBNOKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjBNOKf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:10:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217429400;
        Tue, 14 Feb 2023 06:10:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eq11so17534740edb.6;
        Tue, 14 Feb 2023 06:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QenPsko859ZHfQ0b3Tf7Htt4mz+imDSGceCqocw9waQ=;
        b=JHhEXIF94es4A9c3HbBIUfZxo/gHaPS3ZWJotViS17PvJDk+gQ3O367Prm2lRff3eR
         Nw5r1SJI86MK5u1x8KyfRkWr8C9SMw18YhFCne/V/7xHwzgK9LmIj2iKvlkq6N3o7qgL
         uBbZT7vMfa8NcCpdyJItDnoX2VZ2fp/lIa+87UnWDNKGNt8F8a0MywZfVQ23LRnaGwiN
         jxljpPQCfuGNyO58bOP5QCZlIKyVJUPUAVNj4ZMr2tm1sBEKBccbEbra9PeUk7DSEOjj
         siBTkWF0wLQ/Qv50W7oJ66U7GL7qbliAmiwPREBqnI70k/69FhFOivafaqPErnLqX6KJ
         fqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QenPsko859ZHfQ0b3Tf7Htt4mz+imDSGceCqocw9waQ=;
        b=Rz9j1Lu3Xc5eTYvdLBZIjvz8M2JzoTQQOvVsB9BWaDqYy0ykchlGUYrlqndhzQ8YyA
         rzS8+x185drFs8dIaX+4OalZvUh6z4c2hfnC3WSv0gXAjE9gw9cZziCHkrB3WgjE2jpY
         X1ZPG1C5zA9l7SLxN6qDHA6HZboonSdY2JE9y/CvY1MNjvz8c91nmejWOxkph5nFKUui
         hzEE66mh4aaIn/Nbqh3UoFjfF4gXQvLv+QuOFki56+L1GgGj7G25yT9jsv5i/eBkpjgT
         k4Ft78EiuS4N4DbVS+8+zOJtUnfNeZhvsjn37z5JPe+SrSDd2xH0zSlpnxIS8i7s+B4R
         pVyQ==
X-Gm-Message-State: AO0yUKUCxZW66FkJhhQNolihEa2oqmHvwxZ00nNLMD/ZgeHp/X3VVEmH
        EkLcBEFhYTeC5c4U+sGiZYM=
X-Google-Smtp-Source: AK7set+Uxw4ZE/1QScURPseXp3JqiUWKJRo/59zJGJsLgglvyWI4GBknEzz1DIQfZzTxlIwlPrYM2A==
X-Received: by 2002:a50:d750:0:b0:4ac:b2c8:aeaf with SMTP id i16-20020a50d750000000b004acb2c8aeafmr2921632edj.26.1676383790331;
        Tue, 14 Feb 2023 06:09:50 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id n11-20020a1709065e0b00b008b13814f804sm332241eju.186.2023.02.14.06.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:09:49 -0800 (PST)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller driver
Date:   Tue, 14 Feb 2023 15:08:48 +0100
Message-Id: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
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
for the Rockchip RK3399 SoC. The driver was introduced in
cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
The original driver had issues and would not allow for the RK3399 to
operate in PCIe endpoint mode correctly. This patch series fixes that so
that the PCIe core controller of the RK3399 SoC can now act as a PCIe
endpoint. This is v2 of the patch series and addresses the concerns that
were raised during the review of the first version.

Thank you in advance for reviewing these changes and hopefully
getting this merged. Having a functional PCIe endpoint controller
driver for the RK3399 would allow to develop further PCIe endpoint
functions through the Linux PCIe endpoint framework using this SoC.

Problem: The Rockchip RK3399 PCIe endpoint controller driver introduced in
cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
did not work.

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

The problems have been addressed and validated through tests (see below).

Summary of changes :

This patch series is composed of 9 patches that do the following :
* Remove writes to unused registers in the PCIe core register space.
  The registers that were written to is marked "unused" and read
  only in the technical reference manual of the RK3399 SoC.
* Write PCI Device ID (DID) to correct register, the DID was written to
  a read only register and therefore would not update the DID.
* Assert PCI Configuration Enable bit after probe so that it would stop
  sending Configuration Request Retry Status (CRS) messages to the
  host once configured, without this the host would retry until
  timeout and cancel the PCI configuration.
* Add poll and timeout to wait for PHY PLLs to be locked, this
  is the only patch that also applies to the root complex function
  of the PCIe core controller, without this the kernel would
  sometimes access registers in the PHY PLL clock domain when the PLLs
  were not yet locked and the system would hang. This was hackily solved
  in other non mainline patches (e.g., in armbian) with a "msleep()"
  that was added after PHY PLL configuration but without realizing
  why it was needed. A poll with timeout seems like a sane approach.
* Add dtsi entry for RK3399 PCIe endpoint core. The new entry is
  in "disabled" status by default, so unless it is explicitly enabled
  it will not conflict with the PCIe root complex controller entry.
  Developers that will enable it would know that the root complex function
  then must be disabled, this can be done in the board level DTS.
* Fix window mapping and address translation for endpoint. The window
  mapping and address translation did not follow the technical reference
  manual and a single memory region was used which resulted in conflicting
  address translations for memory allocated in that region. The current
  patch allows to allocate up to 32 memory windows with 1MB pages.
* Fix legacy IRQ generation for RK3399 PCIe endpoint core, the legacy IRQs
  were not sent by the device because their generation did not follow the
  instructions in the technical reference manual. They now work.
* Use u32 variable to access 32-bit registers, u16 variables were used to
  access and manipulate data of 32-bit registers, this would lead to
  overflows e.g., when left shifting more than 16 bits.
* Add parameter check for RK3399 PCIe endpoint core set_msi(), return
  -EINVAL when incompatible parameters are passed.

Validation on real hardware:

This patch series has been tested with kernel 6.0.19 (and 5.19)
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

I have tested and confirmed all basic functionality required for the
endpoint with the test driver and tools. With the previous state of
the driver the device would not even be enumerated by the host
computer (mainly because of CRS messages being sent back to the root
complex) and tests would not pass (driver would not even be loaded
because DID was not set correctly) and then only the BAR test would
pass. Now all tests pass as stated above.

Best regards
Rick

Rick Wertenbroek (9):
  PCI: rockchip: Remove writes to unused registers
  PCI: rockchip: Write PCI Device ID to correct register
  PCI: rockchip: Assert PCI Configuration Enable bit after probe
  PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
  arm64: dts: rockchip: Add dtsi entry for RK3399 PCIe endpoint core
  PCI: rockchip: Fix window mapping and address translation for endpoint
  PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
  PCI: rockchip: Use u32 variable to access 32-bit registers
  PCI: rockchip: Add parameter check for RK3399 PCIe endpoint core
    set_msi()

 arch/arm64/boot/dts/rockchip/rk3399.dtsi  |  23 ++++
 drivers/pci/controller/pcie-rockchip-ep.c | 143 ++++++++++------------
 drivers/pci/controller/pcie-rockchip.c    |  16 +++
 drivers/pci/controller/pcie-rockchip.h    |  36 ++++--
 4 files changed, 128 insertions(+), 90 deletions(-)

-- 
2.25.1


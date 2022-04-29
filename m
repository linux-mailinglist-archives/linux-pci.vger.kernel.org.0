Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613C751498B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359215AbiD2Ml6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiD2Ml5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 08:41:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0FAAFAD0;
        Fri, 29 Apr 2022 05:38:39 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id r8so5206604qvx.10;
        Fri, 29 Apr 2022 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+dxdp5rrl14/eORvrLB8L3RavPWDRGDtxwA0AijHS0=;
        b=EANN7oTOPbgNT6aPWLJ3jidqnFmPU/PO2+Gua9a0sPGBRzbptwMDRo0wKSgRLbHsK9
         gkuuic9aitbXcvRhkO6zzQyqTQzBgSnE9LTCMRanDZq/RJqYJ18NEKqx811n/xtqX0GX
         2KIS12D8Ln39n+JKaXCBlNXnP6u5G26GU6QJs6trZtWoJOov+siVqD/PdRxEopdJUQdt
         RUPJtzwhVVpImWLB8Vgcg6M3mStk1mu/dY5rBv9gJDYGGrYK91iRZpun21OoeY2uvRTV
         DP7nAZf4fI4JOYSm9kLGa85vnjWGFLy4zg9xTLY2Z/wBvRum7myBWlXAb5e9NcEgIWXj
         hCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+dxdp5rrl14/eORvrLB8L3RavPWDRGDtxwA0AijHS0=;
        b=Gd2x4eHlt0287Qmjs4dT0fZWId466Ee0YnXnbN3y+Jih8V4g1aY4ZOJ4mN6brXTt7u
         EGI9iVbkL5g58CsoaQfpcmmymnOuaCnY5+ygchxE07DHz4T4yD1HlNqEkVvH1X8WlyXv
         j4Yf9BidpSlFZ7q3C7NaueKUS0I3PdXqRq6vNwtUN0LZiX06YbJhC4mw9FFo3IwhpVya
         PvBTOLRo6E2Y10C4BuomHn4XAQXODOJYMHD/eRV7ujHZa11E6LB4HHBdkufyVMCfJHtS
         2Qc+VXDAkw+b2C2kfFPdJL+uk5qGLidSJNo+GFLfpT6Tiguh3pA1MS4D2ezxsm+X581/
         VzRQ==
X-Gm-Message-State: AOAM533JkNR3ZBUfU1Msb3sdhuLS7Nk8PKIRxYK4gcTqi2mr85GagbvF
        Q9dUahP2TeEHH/GlQkVgiBE=
X-Google-Smtp-Source: ABdhPJwD6ARY0Qg7OhPhaRZ2aJoyeHoWzMfqlNR6k0S7Sh2YZmG5qHY1oEVs8qx99m23l9ocRQp3PQ==
X-Received: by 2002:a0c:d6ce:0:b0:443:f22e:6dd with SMTP id l14-20020a0cd6ce000000b00443f22e06ddmr28013580qvi.111.1651235918751;
        Fri, 29 Apr 2022 05:38:38 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v126-20020a37dc84000000b0069f9c375519sm1431644qki.46.2022.04.29.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:38:38 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     heiko@sntech.de, Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/5] Enable rk356x PCIe controller
Date:   Fri, 29 Apr 2022 08:38:26 -0400
Message-Id: <20220429123832.2376381-1-pgwipeout@gmail.com>
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

This series enables the DesignWare based PCIe controller on the rk356x
series of chips. We drop the fallback to the core driver due to 
compatibility issues. We reset the PCIe controller at driver probe to
prevent issues in the future when firmware / kexec leaves the controller
in an unknown state. We add support for legacy interrupts for cards that
lack MSI support (which is partially broken currently). We then add the
device tree nodes to enable PCIe on the Quartz64 Model A.

Patch 1 drops the snps,dw,pcie fallback from the dt-binding
Patch 2 resets the PCIe controller to prevent configuration bugs
Patch 3 adds legacy interrupt support to the driver
Patch 4 adds the device tree binding to the rk356x.dtsi
Patch 5 enables the PCIe controller on the Quartz64-A

Changelog:
v9:
- move reset_control_assert out of rockchip_pcie_resource_get
- fix various formatting mistakes
- fix a checkpatch warning

v8:
- add core reset patch
- simplify IRQ enable/disable functions
- drop spinlock
- only enable/disable IRQ requested
- only pass the IRQ register bits used to irq functions

v7:
- drop assigned-clocks

v6:
- fix a ranges issue
- point to GIC instead of ITS

v5:
- fix incorrect series (apologies for the v4 spam)

v4:
- drop the ITS modification, poor compatibility is better than
  completely broken

v3:
- drop select node from dt-binding
- convert to for_each_set_bit
- convert to generic_handle_domain_irq
- drop unncessary dev_err
- reorder irq_chip items
- change to level_irq
- install the handler after initializing the domain

v2:
- Define PCIE_CLIENT_INTR_STATUS_LEGACY
- Fix PCIE_LEGACY_INT_ENABLE to only enable the RC interrupts
- Add legacy interrupt enable/disable support


Peter Geis (5):
  dt-bindings: PCI: Remove fallback from Rockchip DesignWare binding
  PCI: rockchip-dwc: Reset core at driver probe
  PCI: rockchip-dwc: Add legacy interrupt support
  arm64: dts: rockchip: Add rk3568 PCIe2x1 controller
  arm64: dts: rockchip: Enable PCIe controller on quartz64-a

 .../bindings/pci/rockchip-dw-pcie.yaml        |  12 +-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  34 +++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  52 ++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 119 +++++++++++++++---
 4 files changed, 191 insertions(+), 26 deletions(-)

-- 
2.25.1


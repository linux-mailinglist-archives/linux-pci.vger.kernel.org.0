Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8A6B7C1A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 16:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCMPkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 11:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMPj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 11:39:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF64D29434;
        Mon, 13 Mar 2023 08:39:58 -0700 (PDT)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C78D46602179;
        Mon, 13 Mar 2023 15:39:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678721997;
        bh=eJniK8rCzpUyXvy4JnDVP5rtDR3ZlqisZg1RKZ1F/6Y=;
        h=From:To:Cc:Subject:Date:From;
        b=W/YJmEwosez2cINBjV3QmWBmH4uS8xXbIVB7QRpOHShkbOJg+83K7Cf5Jv8b8ce6E
         A7iDwfE6f9x5a1E3E55GGLva3wFebYuMsDUvfbYbXvjz0LUf+SOBIWsrWjvGUdk1sg
         +6V/FQieN0IH7Jr78TnnSDnYhjXGrOv5YbmPdlJGtzmK23Jw4A32SnZJepAjybSqjY
         qFMHT9fZsoenZtTpwo7f+K0eNRa7LZrrtg9zGRWAM9UWU0oytJxzaMeROA8bLbJCXa
         6R1DhyJHEvK3HZXy6GgAgJnGDibrULQHQ3k4XcYs22GkkBDIJkbENtHzGwUBCvCeXV
         kSxRbO9qNYWkw==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 0/4] Add PCIe2 driver support for Rockchip
Date:   Mon, 13 Mar 2023 15:39:49 +0000
Message-Id: <20230313153953.422375-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I am assisting with PCIe and networking bring-up for Rock Pi 5B (RK3588).
We sent this series a few days ago:
https://lore.kernel.org/all/20230310080518.78054-1-lucas.tanure@collabora.com/

From that conversation we decided to send patches for Rockchip that don't
require GIC/ITS implementation. We will send that in a separed series.
Making easier for reviews and unblocking patches that don't require
GIC/ITS implementation.

This is work based on prior work from XiaoDong Huang and
Peter Geis fixing this issue specifically for Rockchip 356x.
Plus comments of Robin Murphy about Non-Coherent properties.

Lucas Tanure (4):
  dt-bindings: PCI: dwc: Add rk3588 compatible line
  PCI: rockchip-dwc: Add rk3588 compatible line
  dt-bindings: phy: rockchip: Add rk3588 compatible line
  phy: rockchip: Add naneng combo phy support for RK3588

 .../bindings/pci/rockchip-dw-pcie.yaml        |   1 +
 .../phy/phy-rockchip-naneng-combphy.yaml      |   1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   1 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 184 ++++++++++++++++++
 4 files changed, 187 insertions(+)

-- 
2.39.2


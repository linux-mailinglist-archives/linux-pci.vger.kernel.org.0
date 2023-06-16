Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762F5733704
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346138AbjFPRB3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344913AbjFPRAo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 13:00:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAB630F1;
        Fri, 16 Jun 2023 10:00:42 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-215-052.ewe-ip-backbone.de [91.248.215.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B5C06606F5E;
        Fri, 16 Jun 2023 18:00:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686934841;
        bh=nZW8jIngftAoIkAle/riuzj5bsvkOIB+Gq2bER8yW54=;
        h=From:To:Cc:Subject:Date:From;
        b=cLLVx+z2fOqD0rp76NdCTqrbkAPVqTvc4l+7f+Hx/BlooEfYSq0uIFfmv2evuckov
         NoWDgqB9g6vq31sSu2jFakd5DiEXk6y+DTEKcMQnrkTZ0mqig/Wm9eHokkqb2pV0lA
         nKypubAz+UQhaInYuqqiGjqjABPVqSqx68FBczpiXUUgG1STuinJVMDM8fqihAdTFd
         wW13DBU23HbAtK3UHTAgJgvkEaEhj23kQSFbMFuwNf0b6nm7buAFa5VEBU0WS/i7TZ
         S0PXY97Zhxe+H2PMtIXBWPpc/GGNZwE8K7TIzewLaERz/4BGAvuzC9j4/EdxizVkpy
         NoA1d6aX+w+SA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0F76248058E; Fri, 16 Jun 2023 19:00:39 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 0/4] RK3588 PCIe2 support
Date:   Fri, 16 Jun 2023 19:00:18 +0200
Message-Id: <20230616170022.76107-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This adds PCIe2 support for RK3588. The series has been tested with the
onboard RTL8125 network card on Rockchip RK3588 EVB1 (&pcie2x1l1) and
Radxa Rock 5B (&pcie2x1l2). The final patch in this series depends on
the combo PHY support added by the SATA series [0].

[0] https://lore.kernel.org/all/20230612171337.74576-1-sebastian.reichel@collabora.com/

Thanks,

-- Sebastian

Sebastian Reichel (4):
  dt-bindings: PCI: dwc: rockchip: Fix interrupt-names issue
  dt-bindings: PCI: dwc: rockchip: Add missing
    legacy-interrupt-controller
  dt-bindings: PCI: dwc: rockchip: Update for RK3588
  arm64: dts: rockchip: rk3588: add PCIe2 support

 .../bindings/pci/rockchip-dw-pcie.yaml        |  58 +++++++++-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  15 ++-
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  54 +++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 108 ++++++++++++++++++
 4 files changed, 231 insertions(+), 4 deletions(-)

-- 
2.39.2


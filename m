Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC07529A7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 19:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGMRS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGMRS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 13:18:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3511C2699;
        Thu, 13 Jul 2023 10:18:57 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-214-236.ewe-ip-backbone.de [91.248.214.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C9050660704F;
        Thu, 13 Jul 2023 18:18:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689268735;
        bh=8SNAy+HvH8jQ2JIS228H02hqVwZkE4Q7e2sspvBi+Rw=;
        h=From:To:Cc:Subject:Date:From;
        b=U8nI13odssM7oE33SH8LuPAfkYxOW48OW0KhbokYZWk/yQ5pWtyIvFgdnL7KnfiCn
         qclTNdpJfONcLQcIRuyudlZI3sh5i9a/8Oma3sHyqluGxDGEpYyNAsinoIQNn0zufp
         rh0KQvg9TDXfEaW9yGfeaPpIiYrAuSCYMjyR1Z2HNMtrUPtz3M9lL44+Vsvsj2aSHW
         fsBvca5LKECMhkI7n9uc3DqY/0dO9fOIuXGGN+cJ6kKkU458TUIS2iWD7Cc0Rws2P8
         r73NMTCkxO2WSoaghP7u3n7AxnWZSlxH7CvTXdrBCAC5QxFmPZ3ch4kkRpcAjFV0Xa
         Qhb3XLi+jlHdg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id C896F480084; Thu, 13 Jul 2023 19:18:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>
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
Subject: [PATCH v2 0/3] RK3588 PCIe2 support
Date:   Thu, 13 Jul 2023 19:18:48 +0200
Message-Id: <20230713171851.73052-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This adds PCIe v2 support for RK3588. The series has been tested with
the onboard RTL8125 network card on Rockchip RK3588 EVB1 (&pcie2x1l1)
and Radxa Rock 5B (&pcie2x1l2).

Changes since v1:
 * https://lore.kernel.org/all/20230616170022.76107-1-sebastian.reichel@collabora.com/
 * Dropped patch adding 'RK3588' (queued by Rob)
 * Updated patch adding legacy-interrupt-controller according to comments
   from Rob and Serge
    - added missing additionalProperties: false
    - added all properties to new required property
    - removed useless quotes around interrupt-controller
    - added Rob's Reviewed-by
 * Updated patch adding the missing RK356x/RK3588 interrupt names, so that it
   provides more details about the interrupts
 * Updated the DT patch according to the comment from Jonas Karlman, so that
   the addresses are in 32 bit address space starting at 0x40000000

[0] https://lore.kernel.org/all/20230612171337.74576-1-sebastian.reichel@collabora.com/

Thanks,

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: PCI: dwc: rockchip: Fix interrupt-names issue
  dt-bindings: PCI: dwc: rockchip: Add missing
    legacy-interrupt-controller
  arm64: dts: rockchip: rk3588: add PCIe2 support

 .../bindings/pci/rockchip-dw-pcie.yaml        |  48 ++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  76 +++++++++++-
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  54 +++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 108 ++++++++++++++++++
 4 files changed, 285 insertions(+), 1 deletion(-)

-- 
2.40.1


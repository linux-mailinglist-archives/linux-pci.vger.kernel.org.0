Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61F7756ACE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGQRf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGQRf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 13:35:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B35B5;
        Mon, 17 Jul 2023 10:35:37 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-171.ewe-ip-backbone.de [91.248.189.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C8B636602329;
        Mon, 17 Jul 2023 18:35:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689615315;
        bh=UU4KGgu8RlPQoKudc9GjsMWwW3SITngefu1mV+NgQcg=;
        h=From:To:Cc:Subject:Date:From;
        b=F6/uz/GiaXgc9Ic/keIGvkOBL24+/kpGMZuaaIy4CtWXCXPFjURzQbp2hv/eivLO6
         nbTFikqKdLkCu2icFLkARl4ge5pX2870nMmA1sE7L19p2rXgER+7+mXYBJm4wi7ZXA
         i7H3AtPl5ZNG8Q2DE8RTyfw67ZycQvYyLoktX253Y0+ElDwIzM/IUR2kTC1BauV9qi
         zAtCQ9Wol7suTuT9Vem0SgylvJWSMuhdTnzg/z+6okJSIt0F/GYD1KswIpYLWmAjo/
         lRfm/ErsEfbZKliNc2YY0q3BDlGThCjUtTwBjiW8AmuwyRrpQCi2wpf84EFMbai/dR
         rQYfC5Bt9RwUA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id D1BD1480C72; Mon, 17 Jul 2023 19:35:12 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, John Clark <inindev@gmail.com>,
        Qu Wenruo <wqu@suse.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 0/2] RK3588 PCIe3 support
Date:   Mon, 17 Jul 2023 19:35:10 +0200
Message-Id: <20230717173512.65169-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This adds PCIe v3 support for RK3588. The series depends on the PCIe
v2 series [0], since the the same binding is used. It has been tested
on Rockchip EVB1 and Radxa Rock 5B.

Note, that the PCIe3 PHY driver is currently missing bifurcation
support for RK3588. Thus after this series only PCIe3x4 is usable
(in aggregated x4 mode) without adding support for the PHY's
"rockchip,pcie30-phymode" DT property, which allows configuring
how the lanes are distributed. Aggregated 3x4 mode seems to be the
most common configuration. Both EVB1 and Rock 5B use it, so I
cannot test anything else anyways.

[0] https://lore.kernel.org/all/20230717172651.64324-1-sebastian.reichel@collabora.com/

Changes since v1:
 * https://lore.kernel.org/all/20230714175331.112923-1-sebastian.reichel@collabora.com/
 * Collected Acked-by from Conor Dooley
 * Dropped deprecated and useless num-ib-windows/num-ob-windows/num-viewport
   properties from DT (Serge Semin)

-- Sebastian

Sebastian Reichel (2):
  dt-bindings: phy: rockchip: add RK3588 PCIe v3 phy
  arm64: dts: rockchip: rk3588: add PCIe3 support

 .../bindings/phy/rockchip,pcie3-phy.yaml      |  33 ++++-
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 120 ++++++++++++++++++
 2 files changed, 148 insertions(+), 5 deletions(-)

-- 
2.40.1


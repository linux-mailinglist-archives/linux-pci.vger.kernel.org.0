Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6980F7541E1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 19:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjGNRzh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 13:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbjGNRzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 13:55:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A914687;
        Fri, 14 Jul 2023 10:54:47 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-179.ewe-ip-backbone.de [91.248.208.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 53ACE660705D;
        Fri, 14 Jul 2023 18:53:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689357226;
        bh=FczUiEAzzQBtsoR9lRmrYRZD3J3QEHCfLQl3HWDnUwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Wy1bcYH9MbPGBu4PRaxJWzSZljL9LaYiO7taf2v9yJttJucxlOoUBVr9L3YW067dj
         cohcOyDK/L7T2W19rwR4Xd66NmcIFSTiXT4nIk+Cpx4flkVVIQZ4L6kWo4wMyJKk9F
         DWrDCps4s9zVD59p6wQdYWND3LbvOEMLoNK9GBrTD44Nne41CSwA74N4GWdGTUKku5
         yaqpGKGs49qxsSszQnrXZfAGaqv8N4YgC+uITs8FTVhjSHlYzERfBs3oWaDONmDQq7
         1xQkfDCK++rkEjfhsd3hMf3mdw07BVXHEFKTFf6+hRuGvqubOVWodpvL7LF7ma0WR6
         QrKR3owvuhqHA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id C01224805A0; Fri, 14 Jul 2023 19:53:43 +0200 (CEST)
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
Subject: [PATCH v1 0/2] RK3588 PCIe3 support
Date:   Fri, 14 Jul 2023 19:53:29 +0200
Message-Id: <20230714175331.112923-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This adds PCIe v3 support for RK3588. The series has been tested with
Rockchip RK3588 EVB1 and a PCIe wlan card, I will also test Rock 5B
next week. The series depends on the PCIe v2 series [0].

Note, that the PCIe3 PHY driver is currently missing bifurcation
support for RK3588. Thus after this series only PCIe3x4 is usable
(in aggregated x4 mode) without adding support for the PHY's
"rockchip,pcie30-phymode" DT property, which allows configuring
how the lanes are distributed. Apparently this seems to be the
most common configuration. Both EVB1 and Rock 5B use it, so I
cannot test anything else anyways.

[0] https://lore.kernel.org/all/20230713171851.73052-1-sebastian.reichel@collabora.com/

-- Sebastian

Sebastian Reichel (2):
  dt-bindings: phy: rockchip: add RK3588 PCIe v3 phy
  arm64: dts: rockchip: rk3588: add PCIe3 support

 .../bindings/phy/rockchip,pcie3-phy.yaml      |  33 ++++-
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 128 ++++++++++++++++++
 2 files changed, 156 insertions(+), 5 deletions(-)

-- 
2.40.1


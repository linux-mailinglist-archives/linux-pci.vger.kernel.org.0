Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18D6B96FF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 14:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjCNN5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjCNN46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 09:56:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D672D7A8F;
        Tue, 14 Mar 2023 06:56:00 -0700 (PDT)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B8C16603089;
        Tue, 14 Mar 2023 13:55:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678802159;
        bh=6DQmp7EOc/vZBH7Agp0m4MGPepgjsuaiBjh47b5ACbc=;
        h=From:To:Cc:Subject:Date:From;
        b=KFeu9bmgQCCt7vY17t9enfuXXo172EBdEpRc3cgQxMbZZM8OqdV7NsT2SzFUZWUul
         40mttmj1eCPqRUDLqu5oENEtn5xJS/eWk7CtmtnqBdr5Uj8yQ2QVqOi03zTm4UbDcl
         binjMFjerBQHYMUgxSkbzXRkUJnSx/yCsW2kFv3xj8dF9vugAAvqYoa8NMiLDrNHOG
         +xHUCWR034ujStkdwDIrcYnGLrTM6K/nGdxlSgaOVUlbhQng9aINSkrO0rf37qbueE
         XXjCHza1TJiIfzV7u1ZMcU9q2oGCRJ29YA/YlT07xW6LBiSU1OIB7O2X7cvbgrYk26
         cnTTZ+XO8aGkQ==
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
Subject: [PATCHv2 0/3] Add PCIe2 driver support for Rockchip
Date:   Tue, 14 Mar 2023 13:55:52 +0000
Message-Id: <20230314135555.44162-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Since v1:
 - Don't add compatible string to PCIe driver, only to DT Bindings
 - Improve commit message for "Add rk3588 compatible"

Lucas Tanure (3):
  dt-bindings: PCI: dwc: Add rk3588 compatible
  dt-bindings: phy: rockchip: Add rk3588 compatible
  phy: rockchip: Add naneng combo phy support for RK3588

 .../bindings/pci/rockchip-dw-pcie.yaml        |   6 +-
 .../phy/phy-rockchip-naneng-combphy.yaml      |   1 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 184 ++++++++++++++++++
 3 files changed, 190 insertions(+), 1 deletion(-)

-- 
2.39.2


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D254CA8A7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiCBO6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 09:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiCBO6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 09:58:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0062AC5C;
        Wed,  2 Mar 2022 06:57:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ACF161681;
        Wed,  2 Mar 2022 14:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABA7C004E1;
        Wed,  2 Mar 2022 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646233070;
        bh=HJ9UOZ8Pda2J5esQVLz0rDdDpMg6S97CEjZqU1QUEgg=;
        h=From:To:Cc:Subject:Date:From;
        b=JDFNBYKm5iyiz514HuoZO8pnX5BtyJdM4oKs88W7tr/Ouxqnx2+s3tUCfp9pyekig
         UVlEDj67L5MtnhLnVL55rJArrulfZNrpryXR7NFxhzGFCfSgqh84euSnRao1f2mo/5
         gVhDDHsUH91OnVc2j931CSRbzs6ecVrNQxlnXzJxv2AvEj6+u6CFmJUr2cvGSXWl+6
         uJ0yI9sECkULgPdK9SuMbJxEFH9ye1hEsXc+TuaMyVKFEYrJW25INCCwvnbRfLg+OM
         g/lp20w2jr+QNfrCekejtWyhr2t1ieMtGv/Yq/8oTJbReXPcFG4sY/uU0h/ioJnge3
         odEUKzT3DyHRw==
Received: by pali.im (Postfix)
        id EE8DB677; Wed,  2 Mar 2022 15:57:46 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: mvebu: Slot support
Date:   Wed,  2 Mar 2022 15:57:29 +0100
Message-Id: <20220302145733.12606-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series add slot support to pci-mvebu.c driver.

It is based on branch pci/mvebu of git repository:
https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git

Changes in v2:
* Dropped patch with PCI_EXP_SLTCAP_*_SHIFT macros as it is not needed anymore
* Dropped patch "ARM: dts: turris-omnia: Set PCIe slot-power-limit-milliwatt properties" which was applied
* Added support for PCIe 6.0 slot power limit encodings
* Round down slot power limit value
* Fix handling of slot power limit with scale x1.0 (0x00 value)
* Use FIELD_PREP instead of _SHIFT macros
* Changed commit message to Bjorn's suggestion
* Changed comments in the code to match PCIe spec
* Preserve user settings of PCI_EXP_SLTCTL_ASPL_DISABLE bit

Pali Rohár (4):
  PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
  dt-bindings: Add 'slot-power-limit-milliwatt' PCIe port property
  PCI: Add function for parsing 'slot-power-limit-milliwatt' DT property
  PCI: mvebu: Add support for sending Set_Slot_Power_Limit message

 Documentation/devicetree/bindings/pci/pci.txt |  6 ++
 drivers/pci/controller/pci-mvebu.c            | 96 ++++++++++++++++++-
 drivers/pci/of.c                              | 64 +++++++++++++
 drivers/pci/pci.h                             | 15 +++
 include/uapi/linux/pci_regs.h                 |  1 +
 5 files changed, 177 insertions(+), 5 deletions(-)

-- 
2.20.1


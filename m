Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604EA4E7022
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357541AbiCYJk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356718AbiCYJk0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 05:40:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF0117D;
        Fri, 25 Mar 2022 02:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47967B824E8;
        Fri, 25 Mar 2022 09:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA112C340E9;
        Fri, 25 Mar 2022 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648201129;
        bh=zNqewQWdGWqQ/uwlakUo9ehQGDWTaBy5w6WBU6XmIEU=;
        h=From:To:Cc:Subject:Date:From;
        b=gjL6MxwsDRR4nXlG4HIh04laHyGrN88mXBMJuv8M6Uud7PFynQgOzCp4I4CGT6hKU
         RW44SOupMI6vRp+2gDDuB7qVVY1tD1pj4/SpaLWHKcz/wjuFLfOkuDAeqxwKjt8ki7
         vsnFY+BCBNjLJnpg51pUk8ffcwVVekklQZum9DU6xfbwhuB3CSjeYHkYebnYgJhBXw
         4pUJfV7DCV0CkBb09wcriXz/kgXN2G/GQRwsv1LtxsOE3ffR0S87ueLklOLBlHDDfh
         OWd8XEQiblv9HUvqdxK4QfmIIULWkVq00m5IX/x6F7ezRQQXETyxvkQ698hRBnojN9
         Qyw88DR/MWuSg==
Received: by pali.im (Postfix)
        id 17BC97DD; Fri, 25 Mar 2022 10:38:47 +0100 (CET)
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
Subject: [PATCH v3 0/4] PCI: mvebu: Slot support
Date:   Fri, 25 Mar 2022 10:38:23 +0100
Message-Id: <20220325093827.4983-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v3:
* Set 600 W when DT slot-power-limit-milliwatt > 600 W

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


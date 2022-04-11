Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83DB4FC476
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 21:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349297AbiDKTDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 15:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiDKTDg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 15:03:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0ED32045;
        Mon, 11 Apr 2022 12:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F14A5B81867;
        Mon, 11 Apr 2022 19:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85295C385A4;
        Mon, 11 Apr 2022 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649703678;
        bh=F3IVYCcv84WeuyRoIp+9Ax43Yu2K2bXuFY+2WqsXMr0=;
        h=From:To:Cc:Subject:Date:From;
        b=mqYOpwzlrBPRAfI8M9B0GGVUGk+VczSp/OGw1nbBe0v+hp1v864RWzs/zIG7FxwQ1
         e07llQ7m3dDMxax76e4wfkv1/AkrdZvrPHK9Vw83LL1fPdasR3wQcU8ClmUcK0iAkm
         nt7o518VtYD1eIRFf82BDjolNKnJBtbLpIBR3NPFDGcCIh1iCAiotbK6yPGdYrvV/M
         MH1/mZAkiIz7pW3+lSdRmHzE5ta1XeeAKIMRBfYsbfx0KjL6cFFUQsJr8VHjQp80c/
         gzk2VdnqRGGAVxwDzx3u/Gy9DNSmy307d1ZAfjdOEP8tLjj8ibn5SS/qXvsPJN2uQS
         q+0COb8nk3Q0w==
Received: by pali.im (Postfix)
        id 5DFB6947; Mon, 11 Apr 2022 21:01:15 +0200 (CEST)
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
Subject: [PATCH v4 0/4] PCI: mvebu: Slot support
Date:   Mon, 11 Apr 2022 20:58:55 +0200
Message-Id: <20220411185859.32722-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series add slot support to pci-mvebu.c driver.

Changes in v4:
* Set 239 W when DT slot-power-limit-milliwatt is between 239 W and 250 W
* Fix returning power limit value

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
 drivers/pci/of.c                              | 70 ++++++++++++++
 drivers/pci/pci.h                             | 15 +++
 include/uapi/linux/pci_regs.h                 |  1 +
 5 files changed, 183 insertions(+), 5 deletions(-)

-- 
2.20.1


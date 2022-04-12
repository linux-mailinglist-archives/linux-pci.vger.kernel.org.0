Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB24FDD2E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiDLK6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377246AbiDLK43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 06:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6936D8FE4B;
        Tue, 12 Apr 2022 02:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B0361864;
        Tue, 12 Apr 2022 09:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1FDC385AB;
        Tue, 12 Apr 2022 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649757030;
        bh=big4IiYwCUrp5tFic5/ifdQ2CpsrM8sTB+lb/TU8tAw=;
        h=From:To:Cc:Subject:Date:From;
        b=P2QjXjkTYafeccqtUTLaoYUtvLkYeVp5QaSleN+WSHm6miGw4Q6TmrfOldma4PHDa
         9106N9V3OFyhaU7NSYvzBgUMvmmhFv54V6qRHKzVcyUCUp+2NHrUl5mTMlD1FeM4Fa
         r/R5uyKZGHVFGJnox/Iki6u8Ob6fB8jTknKmusMRCU+oPWx7glvlhQfqxO2t2w8itw
         AitupK+oP+zt0aD8z0RuyA/OS0YHOZ7gjnoNeCg6jcEwpWwqEEDR5eRL5vTudD1MbW
         sRmn0bDAGeM2ycKVMJq1a+2MSMoePkMS5lUd7wwLINsG7D0XVTEEAVBRvBqEJeut+u
         25NKDyAX0atQA==
Received: by pali.im (Postfix)
        id 7BB9DA75; Tue, 12 Apr 2022 11:50:27 +0200 (CEST)
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
Subject: [PATCH v5 0/4] PCI: mvebu: Slot support
Date:   Tue, 12 Apr 2022 11:49:42 +0200
Message-Id: <20220412094946.27069-1-pali@kernel.org>
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

Changes in v5:
* Fix compile error due to wrong patch rebasing

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
 drivers/pci/controller/pci-mvebu.c            | 97 ++++++++++++++++++-
 drivers/pci/of.c                              | 70 +++++++++++++
 drivers/pci/pci.h                             | 15 +++
 include/uapi/linux/pci_regs.h                 |  1 +
 5 files changed, 184 insertions(+), 5 deletions(-)

-- 
2.20.1


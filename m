Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659285EC5C9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiI0OTf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiI0OTc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC122BC8
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 07:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7398A619EB
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 14:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2989AC433C1;
        Tue, 27 Sep 2022 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664288370;
        bh=TqW0UwINqhnNZuaWMGDZ5GwxrhxmTz6HVjmYbKvZi+c=;
        h=From:To:Cc:Subject:Date:From;
        b=iqg6NuCEAYHZ+bcDrupY9CM4LimhL5AC7x3ZLUEL7kQ9NAOGwcmhHJgvxbDdVewVh
         28lwe4V0uJGW928/Q3cvtkMIeG4XMpznSr2PZjvTzRNk0qc5o64WS5tnoo5G9i/i6T
         kQL+NG26g7smDi8nBvlFXqdplwsWmed/liyYQKNZEhzNX/2gPYD65c8jwJO0uffyDA
         qUTRlCGHQqxMxd5Q9gML7l6SYxbnRkyiHEfqOEQ9aAfUil+5DG02s80TfuqiNUK2pm
         9LrqLiXR2z6Ao0SKNJ00475ZLJ/EJePZqG4cGE86HRoG9A+mhh+cv5m6GvcfDEPlUB
         eIdtEGy93RZRw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 00/10] PCI: aardvark controller changes BATCH 6
Date:   Tue, 27 Sep 2022 16:19:16 +0200
Message-Id: <20220927141926.8895-1-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo,

here comes v2 of batch 6 of Aardvark patches.
The original version can be found on the mailing list archives [1].

Changes since v1:
- dropped first patch,
    PCI: pciehp: Enable DLLSC interrupt only if supported
  since it is not a dependency for this series and Lukas Wunner
  considers the change without value
- added more explanation to patches 2 and 6 (previously 3 and 7)

Marek

[1] https://lore.kernel.org/linux-pci/20220818135140.5996-1-kabel@kernel.org/

Marek Behún (2):
  PCI: aardvark: Don't write read-only bits explicitly in PCI_ERR_CAP
    register
  PCI: aardvark: Explicitly disable Marvell strict ordering

Miquel Raynal (2):
  PCI: aardvark: Add clock support
  PCI: aardvark: Add suspend to RAM support

Pali Rohár (6):
  PCI: pciehp: Enable Command Completed Interrupt only if supported
  PCI: aardvark: Add support for DLLSC and hotplug interrupt
  PCI: aardvark: Send Set_Slot_Power_Limit message
  arm64: dts: armada-3720-turris-mox: Define slot-power-limit-milliwatt
    for PCIe
  PCI: aardvark: Replace custom PCIE_CORE_ERR_CAPCTL_* macros by
    linux/pci_regs.h macros
  PCI: aardvark: Cleanup some register macros

 .../dts/marvell/armada-3720-turris-mox.dts    |   1 +
 drivers/pci/controller/Kconfig                |   3 +
 drivers/pci/controller/pci-aardvark.c         | 258 +++++++++++++++---
 drivers/pci/hotplug/pciehp_hpc.c              |   4 +-
 4 files changed, 232 insertions(+), 34 deletions(-)

-- 
2.35.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE945F04E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 16:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377810AbhKZPJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 10:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbhKZPHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 10:07:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A48AC061394;
        Fri, 26 Nov 2021 06:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16AB0B827E9;
        Fri, 26 Nov 2021 14:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F894C93056;
        Fri, 26 Nov 2021 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637937830;
        bh=2XIXUqn3rmvs2jKnXm8FsegNV2jP9zSM2yorfQ+9KAU=;
        h=From:To:Cc:Subject:Date:From;
        b=O/aCITp4ImZZprzinafiszuQzab6PqFPPl8V/S0tqW8ErOgZjuHsXbQVrtbUVUNqV
         Fg2qR9/fhdapvNL5X3sM7Ccys0mnSenNIcm57Ek96YXkYnYyxi7tX4/Y/8mlGA8Isa
         e0x+Zjc6euiyWUOP6haeF/wAcKXmOrKe6dQEGLSrXequAGsuqLTmmSiJb0JVxXTG+u
         3NZ0ww+v5IUTNxeYP0qKZxveNykZ+iW7JmKn1VMww3sn6CepJc+sH4XUNvJtfiJNCS
         JUnciNivNT0xp/yhFFhLEop6uIXnC5jHNzDLa4VBSRxIkludDWjGPkyqg/xjpAnjY8
         eYp9NIp2kWxYQ==
Received: by pali.im (Postfix)
        id 5DD2D5ED; Fri, 26 Nov 2021 15:43:47 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: mvebu: Add support for unbinding and unloading driver
Date:   Fri, 26 Nov 2021 15:43:05 +0100
Message-Id: <20211126144307.7568-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series add support for unbinding device from pci-mvebu driver,
allow to compile pci-mvebu.c as kernel module pci-mvebu.ko and allow to
rmmod this module.

This patch series depends on another patch series which converts
pci-mvebu.c driver to use devm_pci_remap_iospace() function:

"arm: ioremap: Remove pci_ioremap_io() and mvebu_pci_host_probe()":
https://lore.kernel.org/linux-pci/20211124154116.916-1-pali@kernel.org/

Without usage of devm_pci_remap_iospace() it is not possible to bind
device to pci-mvebu driver again after unbinding it.

Tested on Turris Omnia - Armada 385 board.

Pali Rohár (2):
  bus: mvebu-mbus: Export symbols for public API window functions
  PCI: mvebu: Add support for compiling driver as module

 drivers/bus/mvebu-mbus.c           |  5 ++
 drivers/pci/controller/Kconfig     |  2 +-
 drivers/pci/controller/pci-mvebu.c | 91 +++++++++++++++++++++++++-----
 3 files changed, 82 insertions(+), 16 deletions(-)

-- 
2.20.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCCDF2193
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 23:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfKFWYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 17:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfKFWYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 17:24:30 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BBF6217D7;
        Wed,  6 Nov 2019 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573079069;
        bh=Xy+DIH7MEANaKoM9K+2wqARWqaH+cn09tnuHFknczJk=;
        h=From:To:Cc:Subject:Date:From;
        b=bKZTmeTnK1YFe67jpCEGI9u7TB+tWiQD4zT+FZj8WBRUIpt3LWqI66aVSjMo6tDZ4
         wFgl15fuoAsARl7BrPk7N6N1uvznh5JOyQznd/U6p5Mp5xy6UdhcpmwLvKmyC4/Cuo
         zAOgvPUYMXNf63500Uo4RW7M3Ed0H/LM3mnfdzUk=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/5] PCI: Clean up PTM message and Kconfig/Makefile nits
Date:   Wed,  6 Nov 2019 16:24:15 -0600
Message-Id: <20191106222420.10216-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The "PTM enabled, 4dns granularity" message has an extra "d" in it; remove
that.

Remove the PTM and ASPM Kconfig dependencies on PCIEPORTBUS, since they
don't depend on it.

Fix the Makefile so PTM and ASPM can be built without PCIEPORTBUS.

Bjorn Helgaas (5):
  PCI/PTM: Remove spurious "d" from granularity message
  PCI/PTM: Remove dependency on PCIEPORTBUS
  PCI/ASPM: Remove dependency on PCIEPORTBUS
  PCI: Remove PCIe Kconfig dependencies on PCI
  PCI: Allow building PCIe things without PCIEPORTBUS

 drivers/pci/Makefile     | 3 ++-
 drivers/pci/pcie/Kconfig | 3 ---
 drivers/pci/pcie/ptm.c   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog


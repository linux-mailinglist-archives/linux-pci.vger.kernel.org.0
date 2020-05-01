Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF4C1C20CE
	for <lists+linux-pci@lfdr.de>; Sat,  2 May 2020 00:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgEAWk4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 18:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgEAWk4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 18:40:56 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8043E2166E;
        Fri,  1 May 2020 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588372855;
        bh=C3gIAfy2H6olDp3Ybz9ADNUO6ANydRnBsN+/20doKhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=u9XJTBGVmhCwLmqudV29B50QPNqOL5QACEhkHQa8sffuEHhAvbAdZBWKAxtun4VGZ
         0EkMMbs1nFSsjv418I3Ijetuu/U2lDDu+ro9n+cRxZHH2atdq2rOinfO26Yw3tn5SK
         fwwG6jnj2lsUCQFojI+tIUFdEuqt3Xl/QDBq1dgM=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Aman Sharma <amanharitsh123@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] PCI: Check for platform_get_irq() failure consistently
Date:   Fri,  1 May 2020 17:40:40 -0500
Message-Id: <20200501224042.141366-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

All callers of platform_get_irq() and related functions interpret a
negative return value as an error.  A few also interpret zero as an error.

platform_get_irq() should return either a negative error number or a valid
non-zero IRQ, so there's no need to check for zero.

This series:

  - Extends the platform_get_irq() function comment to say it returns a
    non-zero IRQ number or a negative error number.

  - Adds a WARN() if platform_get_irq() ever *does* return zero (this would
    be a bug in the underlying arch code, and most callers are not prepared
    for this).

  - Updates drivers/pci/ to check consistently using "irq < 0".

This is based on Aman's series [1].  I propose to merge this via the PCI
tree, given acks from Greg and Thomas.

[1] https://lore.kernel.org/r/cover.1583952275.git.amanharitsh123@gmail.com

Aman Sharma (1):
  PCI: Check for platform_get_irq() failure consistently

Bjorn Helgaas (1):
  driver core: platform: Clarify that IRQ 0 is invalid

 drivers/base/platform.c                       | 40 ++++++++++++-------
 drivers/pci/controller/dwc/pci-imx6.c         |  4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  4 +-
 .../controller/mobiveil/pcie-mobiveil-host.c  |  4 +-
 drivers/pci/controller/pci-aardvark.c         |  3 ++
 drivers/pci/controller/pci-v3-semi.c          |  4 +-
 drivers/pci/controller/pcie-mediatek.c        |  3 ++
 drivers/pci/controller/pcie-tango.c           |  4 +-
 8 files changed, 41 insertions(+), 25 deletions(-)


base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
2.25.1


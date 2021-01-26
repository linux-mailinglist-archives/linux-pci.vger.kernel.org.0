Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98443054E6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 08:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317208AbhAZXfz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbhAZWD5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 17:03:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26C5020656;
        Tue, 26 Jan 2021 22:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611698596;
        bh=PjLdb1g4kw8PtYtdIzAw1ZX71mqARuQm1ANuAin2i8g=;
        h=From:To:Cc:Subject:Date:From;
        b=rd5O9y+HYCDiR6M1Z8iC1O0vFayxIYIjBbW2wcJg7d72ma/uhBK/uCMnvA8pC6Vyh
         HGXUvnOJtqznNUQsx3SUO6jVPNvRgN8V7feEEea8CFrctBBdrzfFFOV/Ce+U0K1san
         NPOqYOpIc6p3y4s08UzsEuB5J+5XNiin3tR7pYb8dwx3jNOA7nrJaGkpB6jSNcF738
         4ZvBx4D+pD9VAXNStULo7vp0mGMoes24mTKteOxFH5Zn+u1O4wAg6OM9WdkPPiVINb
         fDigwegBurip6lDKw6A66OwVdnUOIUkh++qdWZTsx4itHgzNWC7V1g9EbKqB1Slv8b
         l8Bn6cbVFT7sA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI/ACPI: _OSC cleanups
Date:   Tue, 26 Jan 2021 16:03:08 -0600
Message-Id: <20210126220311.2925565-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up a few _OSC-related things.

We talked about the _OSC failure message in the last patch long ago, and I
just dropped the ball, sorry about that.  Previous discussion:
https://lore.kernel.org/linux-pci/20200602223618.GA845676@bjorn-Precision-5520/

I'm happy to merge these given your ack, Rafael, or you can take them if
they look good to you.

Bjorn Helgaas (3):
  PCI/ACPI: Make acpi_pci_osc_control_set() static
  PCI/ACPI: Remove unnecessary osc_lock
  PCI/ACPI: Clarify message about _OSC failure

 drivers/acpi/pci_root.c | 40 ++++++++++++++--------------------------
 include/linux/acpi.h    |  3 ---
 2 files changed, 14 insertions(+), 29 deletions(-)

-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2959C3D1715
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 21:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbhGUSrr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 14:47:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhGUSrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 14:47:47 -0400
Message-Id: <20210721192650.499597025@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626895702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LF8YFdjdkW8dMUJ0dZ2Yk1aIs4MGBPEdVHXD+nWbtGI=;
        b=Muw92HYdHxVzCu7S9yYuM7zdRsR61lahosE1mZU8/UdW0GoBq7cEPXabH21mcefL1Rra7d
        qkPqtI3Ja/IiZXLeANBFANYAy1Ov0nSpxNnVp41NgNz60TqTTJV1rTDGWDjyChWRPLy+vv
        JTUwpCZE7jy6LwnR9woDXjiqYDAqztF7xgnkL6QUulUAV5+xXT5oJnM4WXYhlOcesgQfMm
        SlE11ULByHEgQqaMnoQeP/z2gqdSFsp2at3a/M/KbA3mLHvCLJSAOtwyyCbcDyFqujTZ4w
        2Rp79ogDyqAghbOdAAkY/RDVugkd4DvYrew0Ori7ZKseim/40LgwcXMNfQjG4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626895702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LF8YFdjdkW8dMUJ0dZ2Yk1aIs4MGBPEdVHXD+nWbtGI=;
        b=doh6xw3uj3DCH7etF0JQBaE6sQaBR/6H+8CttmJ7/NaLMjoz/lAQqw8MKuTBzXfaQaTCWg
        g4r29pYjBHmDwHAQ==
Date:   Wed, 21 Jul 2021 21:11:30 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: [patch 4/8] PCI/MSI: Enforce MSI[X] entry updates to be visible
References: <20210721191126.274946280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nothing enforces the posted writes to be visible when the function
returns. Flush them even if the flush might be redundant when the entry is
masked already as the unmask will flush as well. This is either setup or a
rare affinity change event so the extra flush is not the end of the world.

While this is more a theoretical issue especially the X86 MSI affinity
stter mechanism relies on the assumption that the update has reached the
hardware when the function returns.

Again, as this never has been enfocred the Fixes tag refers to a commit in:
   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

Fixes: f036d4ea5fa7 ("[PATCH] ia32 Message Signalled Interrupt support")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/msi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -311,6 +311,9 @@ void __pci_write_msi_msg(struct msi_desc
 
 		if (unmasked)
 			__pci_msix_desc_mask_irq(entry, 0);
+
+		/* Ensure that the writes are visible in the device */
+		readl(base + PCI_MSIX_ENTRY_DATA);
 	} else {
 		int pos = dev->msi_cap;
 		u16 msgctl;
@@ -331,6 +334,8 @@ void __pci_write_msi_msg(struct msi_desc
 			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
 					      msg->data);
 		}
+		/* Ensure that the writes are visible in the device */
+		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 	}
 
 skip:


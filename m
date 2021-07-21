Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ADD3D1717
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 21:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhGUSrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 14:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhGUSrt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 14:47:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E21CC061575;
        Wed, 21 Jul 2021 12:28:25 -0700 (PDT)
Message-Id: <20210721192650.594990678@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626895704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4sVdT7vB64GCrxlmQGZUm2NVgD4dstdg4hyqLY16mPw=;
        b=1uOZ/4pkUaSan/C1chFJ8DpZJmafXWFLNUDDLVblCwP27CBGd7Zj4qRgP/lr0nf+lOx4Ni
        yOdqGtk0GSMjgSPTT6u0jpiyYU8HZbpkMiXl3R5leUADiqIL69JwLUDbGA5z27cGYxxJwU
        BwjBcS1CcmfvrQ8pGvxQfhs04DdWLzmBlxgZVKZJq2cBDEy6rZ4CBysglzUuw2Py73+A5I
        na4h5Nb/RpSBiPc7puKkdiHWvyrBAbT69L5jenZSbQRV11WmG/3Xnrt06Mru2+YaUSVY0+
        cauXy893Pf+IX57kc6ZU6YhEo9V+TJoPcb3vhKlC2W/44I78oPTyIcX6XfeC6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626895704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4sVdT7vB64GCrxlmQGZUm2NVgD4dstdg4hyqLY16mPw=;
        b=ojhhhtU+zeNQkHNiFTc/chpXxVp5wXTrdMabsOsGyFz93nuaKAq/Cre6kxx/Q65MwsMHoe
        FbC3VVgBUy5A0lCg==
Date:   Wed, 21 Jul 2021 21:11:31 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: [patch 5/8] PCI/MSI: Simplify msi_verify_entries()
References: <20210721191126.274946280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No point in looping over all entries when 64bit addressing mode is enabled
for nothing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/msi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -612,8 +612,11 @@ static int msi_verify_entries(struct pci
 {
 	struct msi_desc *entry;
 
+	if (!dev->no_64bit_msi)
+		return 0;
+
 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->msg.address_hi && dev->no_64bit_msi) {
+		if (entry->msg.address_hi) {
 			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
 				entry->msg.address_hi, entry->msg.address_lo);
 			return -EIO;


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01093DAF11
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhG2WfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbhG2WfE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:35:04 -0400
Message-ID: <20210729222542.992849326@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jjGNcCOmrTWZsysH9SrPCPLLXLLNsn5HmBKnKwQMdV0=;
        b=eGxF3/2rYX/oxGIsP5E1+vdSZLJQVIffwL2BHmA8k9+fdshGxN3kg+EjVyV0QedGGeLQcJ
        NDiJE2MertOtUmA6shOwfMr4h6tnWwgJbi8ioDdZ8pU75g3FQ04QXp/djLCp5X986PZP1f
        lzniFm2iIKSJDV1I4QlW+xYdJrrmlHvv2KDLWd9dc3ez9OCvJVrp9OfC+hPihzT7dL78fp
        RHkz+rGOYdlyOzFgnRL/kaNhnxgV2G+qz3/I4G4TadVI1Eo7e2Y6CaYQJJoffLd0+9FHq3
        sbz7cgJk994eINShWlB2Ttk8GNcDDmu5Sus8BC24CIObnM1TFH4xw2WufZ5jcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jjGNcCOmrTWZsysH9SrPCPLLXLLNsn5HmBKnKwQMdV0=;
        b=9rQAG6I7Q7FtxAZayHgKu164PZPVg3RTBmzS/kpfojkkPIEy81kSYSD1I6YvR7Sy3moAWK
        FWGBWWrJUO17SbDQ==
Date:   Thu, 29 Jul 2021 23:51:52 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch V2 13/19] PCI/MSI: Simplify msi_verify_entries()
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No point in looping over all entries when 64bit addressing mode is enabled
for nothing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -613,8 +613,11 @@ static int msi_verify_entries(struct pci
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


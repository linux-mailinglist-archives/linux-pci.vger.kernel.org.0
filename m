Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349785135B0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347729AbiD1NyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347855AbiD1NyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 09:54:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA8287;
        Thu, 28 Apr 2022 06:50:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651153854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCGtFkm7vYpLzkgi/vPjKkxFD15BrWI9YEH1owpKlTI=;
        b=JHF1x9+aYskUyJAqqRbUsp6urutL55NEvbWQRqrmpeiyXlu/CKpOLnVWQXVl2Ebx4J0fPr
        d4NPU4WSfR4jTCyhPyZSiMdK2p+XqoRa4+QB9bMo61m31occ7org2KitZci+tJ0LJl7gN+
        C+Ppe4rNZ8PAFrHyl4rgHBq7bE6uiuAyFTnGgg3i5d1C+7m6115QBaNFaYTE+HR9xmEQlA
        pkbl3TsYSbAEDfYmN3qs/JyKa83Fx0E4vwpyC9bdHK5E2kXETqolIHza2QN9AW2592QSez
        SYygIayV5OwqhmpsAkOY/7BfknosBfPotFGuXMDMXEnEUctTmuXX8ff/XnW4KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651153854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCGtFkm7vYpLzkgi/vPjKkxFD15BrWI9YEH1owpKlTI=;
        b=rvop2lxwc/NZ5bIp8mBZLz9aR19pADzzrZP2H+kpgUqoth9GhBjDWP45UaRsePTuHnWbUU
        np744uxYgsQMtYAQ==
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Dusty Mabe <dustymabe@redhat.com>, Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>, x86@kernel.org, maz@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/pci/xen: Disable PCI/MSI[-X] masking for XEN_HVM guests
In-Reply-To: <87wnf9uxnw.ffs@tglx>
References: <20211210161025.3287927-1-sr@denx.de>
 <163948488617.23020.3934435568065766936.tip-bot2@tip-bot2>
 <Yi9vH2F2OBDprwd8@jpiotrowski-Surface-Book-3>
 <43418c23-5efd-4d14-706f-f536c504b75a@denx.de>
 <c4a65b9a-d1e2-bf0d-2519-aac7185931d5@redhat.com>
 <Yi+lwVRTu8xxi9Gy@jpiotrowski-Surface-Book-3>
 <Ymj3zzjQ9PwYaX/p@eldamar.lan> <87v8uuwhs4.ffs@tglx> <87wnf9uxnw.ffs@tglx>
Date:   Thu, 28 Apr 2022 15:50:54 +0200
Message-ID: <87tuaduxj5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a XEN_HVM guest uses the XEN PIRQ/Eventchannel mechanism, then
PCI/MSI[-X] masking is solely controlled by the hypervisor, but contrary to
XEN_PV guests this does not disable PCI/MSI[-X] masking in the PCI/MSI
layer.

This can lead to a situation where the PCI/MSI layer masks an MSI[-X]
interrupt and the hypervisor grants the write despite the fact that it
already requested the interrupt. As a consequence interrupt delivery on the
affected device is not happening ever.

Set pci_msi_ignore_mask to prevent that like it's done for XEN_PV guests
already.

Reported-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Reported-by: Dusty Mabe <dustymabe@redhat.com>
Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Fixes: 809f9267bbab ("xen: map MSIs into pirqs")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/pci/xen.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -467,7 +467,6 @@ static __init void xen_setup_pci_msi(voi
 		else
 			xen_msi_ops.setup_msi_irqs = xen_setup_msi_irqs;
 		xen_msi_ops.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
-		pci_msi_ignore_mask = 1;
 	} else if (xen_hvm_domain()) {
 		xen_msi_ops.setup_msi_irqs = xen_hvm_setup_msi_irqs;
 		xen_msi_ops.teardown_msi_irqs = xen_teardown_msi_irqs;
@@ -481,6 +480,11 @@ static __init void xen_setup_pci_msi(voi
 	 * in allocating the native domain and never use it.
 	 */
 	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
+	/*
+	 * With XEN PIRQ/Eventchannels in use PCI/MSI[-X] masking is solely
+	 * controlled by the hypervisor.
+	 */
+	pci_msi_ignore_mask = 1;
 }
 
 #else /* CONFIG_PCI_MSI */

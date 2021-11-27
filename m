Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1BC45FA2E
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbhK0BaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:30:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348975AbhK0B2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:28:22 -0500
Message-ID: <20211126230524.778704986@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ehi/wwF9q+UnZyXX27wliNOB9+x0r0rx0yUOBA3VcWA=;
        b=tBqZQCS9YU5DQpG9i8DUNduY8gTY7v/4YQu54X5TVPfWTJxEl1sWWl/HfMF+G+eu7JvDrV
        pxCTgFKc5Blqt/xEtzShloketg00LpTL2NKF7AyK5nApd2TxxqF8/u0EUbfP0W3eorxL9c
        1QegDgE/8KUERShUS2zseXBocvpPm8vPoS6qwIs6+NMHBT7VnwAC1WZ2NZ1QtoxN3g6E4j
        TZwnKb3qDVmz+0w6AteZclp31CHEB3S5aVxclM1t7QipKUtArv55/x/2SasN8+/AwikpG+
        TLNHhcFPNQJ/XcNbC/Spc+Pz6iSRmK/XxJJPWi+SWHREd6MXKbdxTCJjODGCDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ehi/wwF9q+UnZyXX27wliNOB9+x0r0rx0yUOBA3VcWA=;
        b=IUBjpcQCmstxohM+19EemWaO5DY8ZMH/BRfqndD9sy2xafN+yKVHugwJ5S/co3Uu7fJfg6
        Sws+rYuNB9M2oDBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 14/37] genirq/msi: Consolidate MSI descriptor data
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:39 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All non PCI/MSI usage variants have data structures in struct msi_desc with
only one member: xxx_index. PCI/MSI has a entry_nr member.

Add a common msi_index member to struct msi_desc so all implementations can
share it which allows further consolidation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -142,6 +142,7 @@ struct ti_sci_inta_msi_desc {
  *			address or data changes
  * @write_msi_msg_data:	Data parameter for the callback.
  *
+ * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
  * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
@@ -162,6 +163,7 @@ struct msi_desc {
 	void (*write_msi_msg)(struct msi_desc *entry, void *data);
 	void *write_msi_msg_data;
 
+	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
 		struct platform_msi_desc	platform;


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C7045FBFE
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhK0CVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbhK0CTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:19:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F087C08EC36;
        Fri, 26 Nov 2021 17:31:50 -0800 (PST)
Message-ID: <20211127000918.779751933@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CFmm+AWRwXcJQSLL7VY9/FlDxYE98PyZd7GrvqHxiD8=;
        b=e24VzNipUk4hxg1PHC6IAXr9weR7Gc/SoXDfA3RHuL3eUYXW0KQ0vmOx1Rup57wdQ4/c0M
        j0SsM53zaTsEp+xcsTJcjjvt9idxHze65/F9ku69wsdFH4O1IR3xnNt1kBpYgjtuq1EJx3
        G4+8DqRMVr0EurGDQTIs906q+2dXCPyTndaD2DMJHPeXSLph/ufoqB5pa8guu1m5SJm17L
        kBtRWLOCwVpFplTZ//BIVum2PpChXwXEF/pgcDF3hqzjYmEihoy8xv/uTBJ/AHXGcWoyWZ
        FCUJcprzFqND4a981S/J+eyIOTEK4LUqOJJk4OnVzXGII9RmrCOyMXoWJHxGBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CFmm+AWRwXcJQSLL7VY9/FlDxYE98PyZd7GrvqHxiD8=;
        b=gCM9TtH7kdRRuRtrS2dC9nAFXYnyiZU34H6DDhO0H4O61lGny8X8mQzTO3e0hAM5LNj6ef
        CHes+qC3TZO1npAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [patch 05/10] genirq/msi: Add domain info flag MSI_FLAG_CAN_EXPAND
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:24:37 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Not all MSI domains support runtime expansions of PCI/MSI-X vectors. Add a
domain flag so implementations can opt in.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -494,6 +494,8 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 9),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 10),
+	/* MSI vectors can be expanded after initial setup */
+	MSI_FLAG_CAN_EXPAND		= (1 << 11),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,


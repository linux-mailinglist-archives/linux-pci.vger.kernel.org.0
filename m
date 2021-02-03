Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8103630E5ED
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 23:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhBCWOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 17:14:38 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:32796 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232091AbhBCWN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 17:13:56 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0D72B40395;
        Wed,  3 Feb 2021 22:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612390376; bh=jSQ7gPD0eg5i7tdOXR7I0dbZcd3MOQ43M0ZUh6bw2F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EjI0JqH+P66rNI7cZN+JO1EBPEOFzIG4DW/r75l5QlqIUXXytfl6VoiKaO5VZBnbu
         D21CgD6o2iKs+Pz2CL9OsfvQ8GuTlfxnkjGeuZaIeWnHTh+QA54F/CG77UeJ/YepM8
         w1K1tL/1MDxAoE8JG6TyM+BEFVZsN7J2Z28OZazAFkZ/OEOYQ4o2BwwJwyaWJ+PSD/
         63LOszWo6vFxmVo/A2PRRzpFVxdV6cXPiIiG7v/amcG6w9athYUPYqusKCwcNTvJrE
         yEPByU4y/HONtRWA7vaPCkSjN23ZJxmpLltG5OkqOQxuCpkD79pVfCTYRbYVD5wnQQ
         5b79MTMtGJIIA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id CA38DA024D;
        Wed,  3 Feb 2021 22:12:54 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [RESEND v4 2/6] misc: Add Synopsys DesignWare xData IP driver to Makefile
Date:   Wed,  3 Feb 2021 23:12:47 +0100
Message-Id: <1a1b9d4893fe4ef1ff906a5813a0b18895da90ed.1612390291.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Makefile.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e..bf22021 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
-- 
2.7.4


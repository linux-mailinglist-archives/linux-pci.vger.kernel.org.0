Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937E0672CB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGLPxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 11:53:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLPxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jul 2019 11:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d+uVjR6QAVfdzOeq4qPz73+f8euI+Vxn5E0RMe6El4U=; b=f7LRWmeBgzWzIyXt2V1TmUszb
        jZzS6KjedilIylSKZofEVmkhUy2HJCJKR0KKd5Or7ZFrTLK1iQC0MmuzC0jicHxthkV/v23+SS8np
        vob2GpLxoMzye4k7nnljioLZchBAaPgc5DgfeyUbR3V7dttJMiFd8QTaD3tn9kRQFciNa40o9wOE1
        8kipLKDeZyKFkD5D75cT4fm5xSGCdHfEz3sCVqwar8/VakZwgL1N3kC7B7m1yGUrepZAT8LOYc1p7
        dP7BjQGq+D8WDw6U3l7zrvc9LUcp30xNFB85w4wDDmqTU3HLIPJIvQqI3xwY3B9DzmEAMSfnO2YaD
        OYU4GS/RQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlxrN-0005vz-N6; Fri, 12 Jul 2019 15:53:21 +0000
To:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Sasha Levin <sashal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
Message-ID: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
Date:   Fri, 12 Jul 2019 08:53:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when building almost-allmodconfig but with SYSFS
not set (not enabled).  Fixes these build errors:

ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!

drivers/pci/slot.o is only built when SYSFS is enabled, so
pci-hyperv.o has an implicit dependency on SYSFS.
Make that explicit.

Also, depending on X86 && X86_64 is not needed, so just change that
to depend on X86_64.

Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot
information")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jake Oshins <jakeo@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>
---
v3: corrected Fixes: tag [Dexuan Cui <decui@microsoft.com>]
    This is the Microsoft-preferred version of the patch.

 drivers/pci/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-52.orig/drivers/pci/Kconfig
+++ lnx-52/drivers/pci/Kconfig
@@ -181,7 +181,7 @@ config PCI_LABEL
 
 config PCI_HYPERV
         tristate "Hyper-V PCI Frontend"
-        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+        depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
         help
           The PCI device frontend driver allows the kernel to import arbitrary
           PCI devices from a PCI backend to support PCI driver domains.



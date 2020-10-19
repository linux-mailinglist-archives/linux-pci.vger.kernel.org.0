Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F16292260
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 08:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgJSGPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgJSGPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 02:15:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7794C061755;
        Sun, 18 Oct 2020 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=byNuAlZMqUBDf/Ni087inEqcMCUxOCKj6p7sxgD8Ioc=; b=Wu9P2lzpc8m/LaFoouYosaRITH
        PJLe/3a8le5x0OU8RwnMmg6SacAIbOEGUxhUGC3QKeDZSEMdIoRVFhmGU1EQQkMyPBAqBMF2zG2BW
        xSCGLNbWDBd7cBktLx5xsgkF6VB/O1JhuhAC9MbiH7AlbI7lnWSDahdhdDCYXdC5nJneNjg/djlNw
        dLWfPqKEOf5JyzhgIVmMogQr+kyp7cVAR7SJJd/UWyff3TMFvgjxi+FIQdyktL3nSfNAmgeF8vV6s
        NoVJvG1IZQSwUC2jT9Zvr9pFiejq1jmmp+hh9adiknxyua54sPJ118yH+kQzKQlV3uneteYyhPuxi
        elXNyN4w==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUORe-0001BX-9t; Mon, 19 Oct 2020 06:14:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: export pci_find_host_bridge() to fix MFD build error
Date:   Sun, 18 Oct 2020 23:14:53 -0700
Message-Id: <20201019061453.32295-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix a build error in drivers/mfd/ioc.o by exporting
pci_find_host_bridge().

ERROR: modpost: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host-bridge.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20201016.orig/drivers/pci/host-bridge.c
+++ linux-next-20201016/drivers/pci/host-bridge.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 
@@ -23,6 +24,7 @@ struct pci_host_bridge *pci_find_host_br
 
 	return to_pci_host_bridge(root_bus->bridge);
 }
+EXPORT_SYMBOL(pci_find_host_bridge);
 
 struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 {

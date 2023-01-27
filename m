Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70867DDBF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 07:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjA0Gk2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 01:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjA0GkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 01:40:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06116951F;
        Thu, 26 Jan 2023 22:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=to66d23I47sb8h2oeV/vfz/qgeMBrJ25h7jvcPNuY+0=; b=wRYMb+i6bqH9dHXXk5GVuorcu2
        iGJdYPHmscCf4HNEd2kBEjJZDs6Uvm8dd8bVHw4DxpEMwlRDT9r6+xXerlpfGFC8D6fGsX/a/WbHv
        BngXyqAuHfWKWcFUxDYtMakog51ufr09VBi0AihWKO3HUfvUOX3eVbpR9TpXb/OZUw3xTYZx1MsDP
        4wBaktEdTa2qyGcMDaSipil2uTvAEDGVFnG6x2J/y4Ogb/Dqt3pFubGjVWiLm/o3qr94Yj1dZYhId
        3han/gTtoyPJc7wjG6W4BN6r8+4M9PoFXDjDugC2aCBvr5HtuUCo5tO7MJ0KajD2fONLbFzzjY5LK
        Bm49/xHw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPL-00DM0u-HM; Fri, 27 Jan 2023 06:40:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 20/35] Documentation: PCI: correct spelling
Date:   Thu, 26 Jan 2023 22:39:50 -0800
Message-Id: <20230127064005.1558-21-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Correct spelling problems for Documentation/PCI/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst |    2 +-
 Documentation/PCI/msi-howto.rst               |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -103,7 +103,7 @@ A sample configuration for NTB function
 	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
 	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
 
-A sample configuration for virtual NTB driver for virutal PCI bus::
+A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
 	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
diff -- a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -290,7 +290,7 @@ PCI_IRQ_MSI or PCI_IRQ_MSIX flags.
 List of device drivers MSI(-X) APIs
 ===================================
 
-The PCI/MSI subystem has a dedicated C file for its exported device driver
+The PCI/MSI subsystem has a dedicated C file for its exported device driver
 APIs — `drivers/pci/msi/api.c`. The following functions are exported:
 
 .. kernel-doc:: drivers/pci/msi/api.c

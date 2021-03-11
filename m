Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15172337F74
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 22:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCKVNk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 16:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhCKVNJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 16:13:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88A6364F88;
        Thu, 11 Mar 2021 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615497147;
        bh=BvAwNoKUbu9mt2UMQQ05n0bLigFOI/7pwibaGMVJQII=;
        h=From:To:Cc:Subject:Date:From;
        b=rDpsIFnFIKurq/5VvCUaT+oHjPLUqq99c21V9mkJjCEoK4nfBCqrOxZbhAQpSG4H/
         6K6p/qdUEjlKYsS2y0+6BpbxvO3AVc6zAxFBv8IwhNaftqw2/h/cVChUngibmNHaYX
         vniHlHcqJvn5LLMmbD5CnF8dTX2IDLEzgh7E4RtgycX3BUn8b1ccHpkYmD1oOBn1mp
         pz3/8eppiqsaeruSqbd0R2e1wvRvcklghhi5+R80GApWCk5NQsMm9XRfrf9fZK1BfI
         /mOY8c251a+EvQbRvxgZkHkhczpmmA8TtMCghiEdmK/TMmwxp0JSdlVCGxqE0It6Fp
         ZKbWDjK1XHYHw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Update PCI patchwork to kernel.org instance
Date:   Thu, 11 Mar 2021 15:12:23 -0600
Message-Id: <20210311211223.2168267-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We now use the kernel.org patchwork instance.  Update the links in
MAINTAINERS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..a3c2e930b3d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13843,7 +13843,7 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 R:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
+Q:	http://patchwork.kernel.org/project/linux-pci/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
 F:	drivers/pci/controller/
 
@@ -13851,7 +13851,7 @@ PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
+Q:	http://patchwork.kernel.org/project/linux-pci/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
-- 
2.25.1


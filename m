Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6D3F82FD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 09:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbhHZHQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 03:16:59 -0400
Received: from foss.arm.com ([217.140.110.172]:40310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240191AbhHZHQv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 03:16:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 020A5D6E;
        Thu, 26 Aug 2021 00:16:04 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 773E43F5A1;
        Thu, 26 Aug 2021 00:16:03 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 4/4] MAINTAINERS: Widen brcmstb PCIe file scope
Date:   Thu, 26 Aug 2021 02:15:57 -0500
Message-Id: <20210826071557.29239-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210826071557.29239-1-jeremy.linton@arm.com>
References: <20210826071557.29239-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The brcmstb PCI hardware is now split across multiple files. Include
them in the maintainers block.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eee4c926003b..ec2c7a294495 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3514,7 +3514,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
-F:	drivers/pci/controller/pcie-brcmstb.c
+F:	drivers/pci/controller/pcie-brcmstb*
 F:	drivers/staging/vc04_services
 N:	bcm2711
 N:	bcm283*
@@ -3595,7 +3595,7 @@ F:	arch/arm/include/asm/hardware/cache-b15-rac.h
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/mm/cache-b15-rac.c
 F:	drivers/bus/brcmstb_gisb.c
-F:	drivers/pci/controller/pcie-brcmstb.c
+F:	drivers/pci/controller/pcie-brcmstb*
 N:	brcmstb
 
 BROADCOM BDC DRIVER
@@ -3888,7 +3888,7 @@ M:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
-F:	drivers/pci/controller/pcie-brcmstb.c
+F:	drivers/pci/controller/pcie-brcmstb*
 
 BROADCOM SYSTEMPORT ETHERNET DRIVER
 M:	Florian Fainelli <f.fainelli@gmail.com>
-- 
2.31.1


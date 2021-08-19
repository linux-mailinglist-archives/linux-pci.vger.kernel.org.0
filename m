Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA85E3F2296
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 23:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhHSV6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 17:58:03 -0400
Received: from foss.arm.com ([217.140.110.172]:47574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235827AbhHSV56 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 17:57:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 871B41474;
        Thu, 19 Aug 2021 14:57:21 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E893B3F40C;
        Thu, 19 Aug 2021 14:57:20 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, sdonthineni@nvidia.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Widen brcmstb PCIe file scope
Date:   Thu, 19 Aug 2021 16:56:55 -0500
Message-Id: <20210819215655.84866-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210819215655.84866-1-jeremy.linton@arm.com>
References: <20210819215655.84866-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The brcmstb PCI hardware is now split across
multiple files. Include them in the maintainers
block.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd25e4ecf0b9..605a385cea36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3500,7 +3500,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
-F:	drivers/pci/controller/pcie-brcmstb.c
+F:	drivers/pci/controller/pcie-brcmstb*
 F:	drivers/staging/vc04_services
 N:	bcm2711
 N:	bcm283*
-- 
2.31.1


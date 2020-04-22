Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA21B481D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgDVPDx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 11:03:53 -0400
Received: from foss.arm.com ([217.140.110.172]:51230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgDVPDt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B5BD30E;
        Wed, 22 Apr 2020 08:03:49 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.2.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FA9C3F68F;
        Wed, 22 Apr 2020 08:03:48 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH] MAINTAINERS: Add Rob Herring and remove Andy Murray as PCI reviewers
Date:   Wed, 22 Apr 2020 16:03:36 +0100
Message-Id: <20200422150336.10528-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Andy Murray decided to step down as PCI controller reviewer and
Rob Herring is willing to help review PCI controller patches.

Update the respective MAINTAINERS entries to reflect this change.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..4fd752f5ca61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13038,7 +13038,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-R:	Andrew Murray <amurray@thegoodpenguin.co.uk>
+R:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
-- 
2.26.1


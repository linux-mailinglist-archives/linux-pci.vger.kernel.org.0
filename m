Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B8AB21AA
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfIMOQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 10:16:55 -0400
Received: from foss.arm.com ([217.140.110.172]:44442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfIMOQz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 10:16:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 195271000;
        Fri, 13 Sep 2019 07:16:55 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BC773F67D;
        Fri, 13 Sep 2019 07:16:54 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Add PCI native host/endpoint controllers designated reviewer
Date:   Fri, 13 Sep 2019 15:16:46 +0100
Message-Id: <20190913141646.13254-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Andrew Murray as designated reviewer for PCI native host
and endpoint controller drivers.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..08d97988034d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12442,6 +12442,7 @@ F:	arch/x86/kernel/early-quirks.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+R:	Andrew Murray <andrew.murray@arm.com>
 L:	linux-pci@vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
-- 
2.17.1


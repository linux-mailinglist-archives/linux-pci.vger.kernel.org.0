Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BDDAA6BA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390200AbfIEPFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 11:05:39 -0400
Received: from foss.arm.com ([217.140.110.172]:46544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390198AbfIEPFj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 11:05:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0B0C28;
        Thu,  5 Sep 2019 08:05:38 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957F23F67D;
        Thu,  5 Sep 2019 08:05:37 -0700 (PDT)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Remove unnecessary header include (../pci.h)
Date:   Thu,  5 Sep 2019 16:05:28 +0100
Message-Id: <20190905150528.20417-1-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary header include (../pci.h) since it doesn't
provide any needed symbols.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/pci/controller/pcie-rcar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index f6a669a9af41..ee1c38c2fac9 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -30,8 +30,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
-#include "../pci.h"
-
 #define PCIECAR			0x000010
 #define PCIECCTLR		0x000018
 #define  CONFIG_SEND_ENABLE	BIT(31)
-- 
2.21.0


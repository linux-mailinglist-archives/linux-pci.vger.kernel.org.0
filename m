Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098CB3B8DE7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhGAGzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 02:55:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:52327 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234209AbhGAGzs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 02:55:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="206660456"
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="206660456"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 23:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="489828534"
Received: from pg-vnc06.altera.com ([10.142.129.88])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2021 23:53:13 -0700
From:   Joyce Ooi <joyce.ooi@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Joyce Ooi <joyce.ooi@intel.com>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Replace Ley Foon Tan as Altera PCIE maintainer
Date:   Thu,  1 Jul 2021 14:52:47 +0800
Message-Id: <20210701065247.152292-1-joyce.ooi@intel.com>
X-Mailer: git-send-email 2.13.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch is to replace Ley Foon Tan as Altera PCIE maintainer as she
has moved to a different role.

Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66d047d..7693c5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14148,7 +14148,7 @@ F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
 F:	drivers/pci/controller/pci-aardvark.c
 
 PCI DRIVER FOR ALTERA PCIE IP
-M:	Ley Foon Tan <ley.foon.tan@intel.com>
+M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
 L:	linux-pci@vger.kernel.org
 S:	Supported
@@ -14353,7 +14353,7 @@ S:	Supported
 F:	Documentation/PCI/pci-error-recovery.rst
 
 PCI MSI DRIVER FOR ALTERA MSI IP
-M:	Ley Foon Tan <ley.foon.tan@intel.com>
+M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
 L:	linux-pci@vger.kernel.org
 S:	Supported
-- 
1.7.1


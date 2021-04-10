Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922A735AE91
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 16:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhDJOxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 10:53:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234816AbhDJOxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Apr 2021 10:53:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 78580C0122;
        Sat, 10 Apr 2021 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618066389; bh=hSMiiE5yY/Kmol8iEahtysLfqdzwvrDySsXziVJjQ98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OmyWQdQTudifMc+fv8BFpCrGoAFVZZjeYyJlg94F7BRKwJ9tvrDsH3fxCOHIctXDp
         HpsKTVBJvZOaCgV6ypRHrN2oLbC/VzVRHYX1p4ct+Q6RHc7hNAYzwm++iWWXFIHmKe
         mIgWkBUR/kC445u6uJZgzx0hHozWOhRN3mpZcbAZjn+9Gv923aFeLcPGiPN9gEcOuW
         SYLiBX7cMqKCLHw8WB78nkIKHwbVTiHToXON7A938H3JJyHMVF4Gd/d+68UePCCB+l
         O4BE2pEDBnFIKDenb9Tdw+NOTxPLuQH4IeQ3T+Wck9Gvu+sCxCV1sn/sRwCk5Sf8fw
         2+uQd92SuKfXg==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1382FA0231;
        Sat, 10 Apr 2021 14:53:06 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 1/2] dw-xdata-pcie: Fix documentation build warns
Date:   Sat, 10 Apr 2021 16:52:58 +0200
Message-Id: <42ed2d9d27579291dc7cce89c0164bd9255fe337.1618066164.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
References: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
References: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes documentation build warns related to indentation, text formatting,
and missing reference on toc.

This fix solves the following warnings:

WARNING: Unexpected indentation.
WARNING: Block quote ends without a blank line; unexpected unindent.
WARNING: document isn't included in any toctree

Fixes: e1181b5bbc3c ("Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver")
Link: https://lore.kernel.org/linux-next/20210406214615.40cf3493@canb.auug.org.au/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 14 +++++++-------
 Documentation/misc-devices/index.rst         |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
index fd75c93..cbc9f69 100644
--- a/Documentation/misc-devices/dw-xdata-pcie.rst
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -17,24 +17,24 @@ information to /var/log/kern.log or dmesg.
 
 Request write TLPs traffic generation - Root Complex to Endpoint direction
 - Command:
-	echo 1 > /sys/class/misc/dw-xdata-pcie/write
+echo 1 > /sys/class/misc/dw-xdata-pcie/write
 
 Get write TLPs traffic link throughput in MB/s
 - Command:
-        cat /sys/class/misc/dw-xdata-pcie/write
+cat /sys/class/misc/dw-xdata-pcie/write
 - Output example:
-	204
+204
 
 Request read TLPs traffic generation - Endpoint to Root Complex direction:
 - Command:
-	echo 1 > /sys/class/misc/dw-xdata-pcie/read
+echo 1 > /sys/class/misc/dw-xdata-pcie/read
 
 Get read TLPs traffic link throughput in MB/s
 - Command:
-        cat /sys/class/misc/dw-xdata-pcie/read
+cat /sys/class/misc/dw-xdata-pcie/read
 - Output example:
-	199
+199
 
 Request to stop any current TLP transfer:
 - Command:
-	echo 1 > /sys/class/misc/dw-xdata-pcie/stop
+echo 1 > /sys/class/misc/dw-xdata-pcie/stop
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 64420b331..30ac58f 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -19,6 +19,7 @@ fit into other categories.
    bh1770glc
    eeprom
    c2port
+   dw-xdata-pcie
    ibmvmc
    ics932s401
    isl29003
-- 
2.7.4


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0F32B17F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbhCCBv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:51:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:39046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577482AbhCBGW5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Mar 2021 01:22:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CDCBAF7E;
        Tue,  2 Mar 2021 06:22:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 03/44] PCI: remove synclink entries from pci_ids
Date:   Tue,  2 Mar 2021 07:21:33 +0100
Message-Id: <20210302062214.29627-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The drivers were removed in a1f714b44e34 (tty: Remove redundant synclink
driver) and 3d608a591b2b (tty: Remove redundant synclinkmp driver).

So remove also the PCI ID entries.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 include/linux/pci_ids.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a76ccb697bef..8a18517696c1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2065,8 +2065,6 @@
 #define PCI_DEVICE_ID_EXAR_XR17V358	0x0358
 
 #define PCI_VENDOR_ID_MICROGATE		0x13c0
-#define PCI_DEVICE_ID_MICROGATE_USC	0x0010
-#define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
 
 #define PCI_VENDOR_ID_3WARE		0x13C1
 #define PCI_DEVICE_ID_3WARE_1000	0x1000
-- 
2.30.1


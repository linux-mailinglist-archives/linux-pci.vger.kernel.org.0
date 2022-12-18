Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22B464FD93
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 04:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLRDks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Dec 2022 22:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLRDkr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Dec 2022 22:40:47 -0500
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 19:40:44 PST
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4AFCB
        for <linux-pci@vger.kernel.org>; Sat, 17 Dec 2022 19:40:42 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 3223C2F20229; Sun, 18 Dec 2022 03:33:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from ws.lan (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id 880AA2F20227;
        Sun, 18 Dec 2022 03:33:47 +0000 (UTC)
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
Date:   Sun, 18 Dec 2022 06:33:47 +0300
Message-Id: <20221218033347.23743-1-gremlin@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2a3a7db44fe354a5"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------2a3a7db44fe354a5
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Although unlikely, the 'id' value may be as big as 4294967295
(uint32_max) and "virtfn4294967295\0" would require 17 bytes
instead of 16.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dd7cc44d0 ("PCI: add SR-IOV API for Physical Function driver")
Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
---
 drivers/pci/iov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


--------------2a3a7db44fe354a5
Content-Type: text/x-patch; name="0001-PCI-IOV-virtfn4294967295-0-requires-17-bytes.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-PCI-IOV-virtfn4294967295-0-requires-17-bytes.diff"

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9522175..ad54a07 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include "pci.h"
 
-#define VIRTFN_ID_LEN	16
+#define VIRTFN_ID_LEN	17
 
 int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {

--------------2a3a7db44fe354a5--



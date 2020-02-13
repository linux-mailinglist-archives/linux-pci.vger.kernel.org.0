Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58C115B6D7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 02:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgBMBsy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 20:48:54 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.163]:34154 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729333AbgBMBsx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 20:48:53 -0500
X-Greylist: delayed 1776 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 20:48:52 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id DCEBC7EC
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2020 18:52:24 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22jwjCKZ2AGTX22jwjOTJ6; Wed, 12 Feb 2020 18:52:24 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5757znZEcKNE8shq95boWLVSi/ziQ21brLl/oUcyXoM=; b=jf/taqfsOGtyyeJF8aKUd1ZDIN
        vePbajlrmHcxYxPBVSHOWFUHMxIjTvIZFCADlnKzCQYe6i38c0TWW1iBT3KJ+TgF+4qGxM24DRHgS
        7RR0gEZfC0xTRSZGIai/DiQDymW7ZngJb3IdzhyojB8eNXnOt3kMBhwX1p21pFVuwWC3aDPUc10ZJ
        u59hiQroxBDv4LOfDLZ88VRfwxB+vjoHZZKxDqzG3RD8bn+BzcbCp7rmTf2y6sfCKfj/uutAgGKdS
        GPI5+md7Agd7BY5019sTYEd0XJ/X++B2TykqhBOWOkKy4kMsxZ+LDw2D7APnj1K2VZmWoh686LEHI
        sworcfag==;
Received: from [200.68.141.42] (port=21707 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22jv-003mS8-1n; Wed, 12 Feb 2020 18:52:23 -0600
Date:   Wed, 12 Feb 2020 18:52:21 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PCI: Replace zero-length array with flexible-array member
Message-ID: <20200213005221.GA10532@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.141.42
X-Source-L: No
X-Exim-ID: 1j22jv-003mS8-1n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:21707
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 75
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca835a98..3217b8cdb1e0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1521,7 +1521,7 @@ EXPORT_SYMBOL(pci_restore_state);
 
 struct pci_saved_state {
 	u32 config_space[16];
-	struct pci_cap_saved_data cap[0];
+	struct pci_cap_saved_data cap[];
 };
 
 /**
-- 
2.23.0


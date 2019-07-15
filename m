Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3327B69CD9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 22:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfGOUec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 16:34:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46768 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbfGOUec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 16:34:32 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so36228952iol.13;
        Mon, 15 Jul 2019 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBie7otf80rgDGiazaDW8PBGVn1VumKxsE27SC5Sres=;
        b=rC6eJWEwepYtls3lBXBpmXnPCiwbJl4joI/yxVusE/cMPcigm20YPxLZiAOYf/yC6i
         jcEZOh5ERS2NzfUip2c7VhCpduwmb7Tc3a+ddiJa9zNF3lOBWX5Fg9ftQDpfDatgobpl
         YrT/Tyl0yONCz+ecZAsUOEpYBicP5v9vHBtOKA4gJ0f5mIlx3hUOXpxwQy3us1xB9F/2
         4fkfPSz4xK4tkiMPCO952rMKOS81FquaSzb52oM4bSCpp/Aa5WbEETwAtlX1iaPDogNh
         hKFvNFyuiE6gSiVNvX9HPFW9Pymed5iAAPMNltJxsz9yvpPEs75d+WIku8RRM4GVmk9e
         s/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBie7otf80rgDGiazaDW8PBGVn1VumKxsE27SC5Sres=;
        b=npJ23p9vqcmj19M1KQVBvE2ZGpAW9cRMJvXRexCFkkWj8SR67Q/15x8b1lKrjjinFt
         Eum92EYqHDgoavRcGhFZKFohWLpem8kURgVNT/wkXNcxZM4cmb8Z4IBAx+BDETAKTgEL
         QrBOdqfpMwXXhfmu52t3tHGj+gzTvWCFdR0h04txxU4CrX5kwaM+zUtZP+57jOYWloLj
         SBBpKjXpAAefHD9TFGdw35PpFljfzsqkZRQgwHFy9n7RIMWaV+grwCt+aZJck6DVGIqB
         G23L8GZ8NSfdyN+jDwj+eWVaV7AK9lZ8Y4A9FxqewwmN/BtV05ji7lS+2pOE7PofcZGp
         SF7w==
X-Gm-Message-State: APjAAAXN63ljGhq1kU0huiwjLRIXcLOpB/wSUye754S3X7AOuWHGcaCi
        et8CFs/VrmLttXDNce3ZcXJo6AZDR5qgmQ==
X-Google-Smtp-Source: APXvYqzDvTSFTIC6paITsqmFwwpFSLkd7vvCTB7wHn9UFX+ASKNtctCq+iLLhMby6ygx4Rc1nYMWbg==
X-Received: by 2002:a6b:621a:: with SMTP id f26mr21256111iog.127.1563222870832;
        Mon, 15 Jul 2019 13:34:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c81sm25401252iof.28.2019.07.15.13.34.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:34:29 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH v3] PCI: Remove functions not called in include/linux/pci.h
Date:   Mon, 15 Jul 2019 14:34:16 -0600
Message-Id: <20190715203416.37547-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715181312.31403-1-skunberg.kelsey@gmail.com>
References: <20190715181312.31403-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the following uncalled functions from include/linux/pci.h:

        pci_block_cfg_access()
        pci_block_cfg_access_in_atomic()
        pci_unblock_cfg_access()

Functions were added in commit fb51ccbf217c ("PCI: Rework config space
blocking services"), though no callers were added. Code continues to be
unused and should be removed.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---

Changes since v1:
  - Fixed Signed-off-by line to show full name

Changes since v2:
  - Change commit message to reference prior commit properly with the
    following format:
	commit <12-character sha prefix> ("<commit message>")

 include/linux/pci.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index cf380544c700..3c9ba6133bea 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1656,11 +1656,6 @@ static inline void pci_release_regions(struct pci_dev *dev) { }
 
 static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
 
-static inline void pci_block_cfg_access(struct pci_dev *dev) { }
-static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
-{ return 0; }
-static inline void pci_unblock_cfg_access(struct pci_dev *dev) { }
-
 static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
 { return NULL; }
 static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
-- 
2.20.1


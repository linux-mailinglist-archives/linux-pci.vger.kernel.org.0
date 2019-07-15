Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AED69A9D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 20:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfGOSOX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 14:14:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34387 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfGOSOX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 14:14:23 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so35701114iot.1;
        Mon, 15 Jul 2019 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CgFpi/G6FRfEhg2ENE40pkx1SrTXZfEq01yGYbU6XA=;
        b=Heged3crnrk04O0adpX6AEYcXlV2LPpm0oztxz5/RU1+M0u6cUp0AkRUtROlNXss1R
         FL074FdhRA/FTqiFvbT7WQf+zEd5KGornhzMhvri7+MUvXk5F6SBUS2x74A2xzpFp/W4
         y/wtmmzpNbFi1yBSiM6+hYAu+d0z9hC2rXJkORpEa22J0SnVmiEN9M1kvemWEwwYvuE9
         J8Rg+wjoVCOzN40XNXiDJXLCLOuKBLD3EpETDJccXmiVbKAyq7YvP/XOg+6WenPya+tu
         tvooCtN+fJiNVwv6RKqu4Yp514WNiX0JI/eWSa2T82n5SsbpR6c5/3QdE8EQYXic4Q1g
         NWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CgFpi/G6FRfEhg2ENE40pkx1SrTXZfEq01yGYbU6XA=;
        b=sa8/Duakfih33eYJxdMF7xp/aAwgmi/2JhUSa6knJiYSSV1SstMdLTSqRDqYuMsqfY
         kQo/LxjJJpYq8kdhXhgcqYb7oedI5BWJUNrZ59R0ZU2qdv+vtUvz/YbLUAD5zssJxO9k
         n4o/692SrQkSS/yvPAFLYqGpRjivCF4Up4xbbtbtr+1F+yckEmIKAn+y3rP8kMF9PeTU
         usuXUpFdT+C3Uai2Y5NrOowr+TmyBPf91uGB64VJdmOqgGPyYBs2uMZRT82UV6kfMHpD
         uKoh3zr7fuKgpmguTIpaOUpslM+o26dZZLg7E15qd5R46qqCha65rCeu4GttG2XO/TP5
         5Ptw==
X-Gm-Message-State: APjAAAXnHNAdRpcmUiBz97O4R6j02TWPrCovRJZVIfrs1kTbEi6PDUcB
        2JrB4ZXDHi7b2TiDBrFOfdE=
X-Google-Smtp-Source: APXvYqxdvaO67R4gUBB8DXUMFyjw5/z1SSNdlMZgavt374G+NRPBD0fagJHZNv975I7fbBzuuXWa0A==
X-Received: by 2002:a5e:9304:: with SMTP id k4mr26971156iom.206.1563214462397;
        Mon, 15 Jul 2019 11:14:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id i4sm26766336iog.31.2019.07.15.11.14.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 11:14:21 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH v2] PCI: Remove functions not called in include/linux/pci.h
Date:   Mon, 15 Jul 2019 12:13:13 -0600
Message-Id: <20190715181312.31403-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715175658.29605-1-skunberg.kelsey@gmail.com>
References: <20190715175658.29605-1-skunberg.kelsey@gmail.com>
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

Functions were added in patch fb51ccbf217c "PCI: Rework config space
blocking services", though no callers were added. Code continues to be
unused and should be removed.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---

Changes since v1:
  - Fixed Signed-off-by line to show full name

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


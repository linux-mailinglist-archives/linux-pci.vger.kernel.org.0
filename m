Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D7169A48
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfGOR5G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 13:57:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35834 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731078AbfGOR5G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 13:57:06 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so35579225ioo.2;
        Mon, 15 Jul 2019 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+7ww4nMe/nR0KgmrIwE3A+VEVsFzprY0gsLNuLUbtFM=;
        b=O5qlkCRJ75FROVNu3ynQcg4VDkNxeJYe4oV+ylciJbdlnDecCDsfF8OrP/ZJNP6pK6
         kEMvlZuC9C2owMdj4NQ0yGxtqqr5UOPGUsrZpSqN18m/KaBEtaXMKOvgtkW2Opl3sSIQ
         yGYwAPKGVGcUZxmY5fsPbW21ndnXA8qJpHy/VFJ8mWrA5YJH6xj8H0TPmwiRO3rDgXpn
         K1eDWEz5lhB8jqQMK/NpQGaCulP0boNs91zJOUBUMmjfWXpVJS4H7/dF6N5JFYZz9hVj
         6/3gV/SksIp+ufE9MdBqJsPUdSX1/oGTWNhIkpHaUmKVG9Z0VRl/fuczo4p7gesZWvGp
         9lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+7ww4nMe/nR0KgmrIwE3A+VEVsFzprY0gsLNuLUbtFM=;
        b=slSKXGj1N4yRAbkTmI5t4kbT/m/+3uWhJIA0WuB66WR79nssdaNo3eESMO6BJqoeY/
         x/hC5SReckkLNPvUqQ2gZoEy3DST4S4mMQwMbnBWCd1JQsp6jkwmIuGznZK4WpwzfqwZ
         MSmh8WsI4cLQxl9Z0XiIiLBIOzpuJkHaWB75CJPfEiX18BgHBgMWE7MhJ/LOooU6rCsw
         UkeZuWGOQ9+5im/yQfMFFB1paW+sl0T7TORQGx6UEFChV/auDX2AI3AK7ijc6Zebn9F8
         Kzc5IFmJBiI7l+yhH58TAeG3wfM72+BvmyTFi9rucMBtFVJicFAIEoVCJ5IMbX/3WdFT
         LCUA==
X-Gm-Message-State: APjAAAWPDduY7MCc3hEXAZriPgqfL3A00sqvoCFb5sqWIgwYXxQTo7fO
        lu36XbFnRkg330rq2IDJdPg=
X-Google-Smtp-Source: APXvYqx7N6klSty8AFFYMseUQFcGw1zU2wQ4tVi81SKmh3s1r4bP1ZjvRB516UIc8dlGXMhyYFd05g==
X-Received: by 2002:a5d:9643:: with SMTP id d3mr27278555ios.227.1563213425343;
        Mon, 15 Jul 2019 10:57:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id r7sm13808940ioa.71.2019.07.15.10.57.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 10:57:04 -0700 (PDT)
From:   Kelsey <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH] PCI: Remove functions not called in include/linux/pci.h
Date:   Mon, 15 Jul 2019 11:56:58 -0600
Message-Id: <20190715175658.29605-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Signed-off-by: Kelsey <skunberg.kelsey@gmail.com>
---
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


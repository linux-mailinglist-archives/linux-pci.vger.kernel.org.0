Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A321D6EA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgGMNXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgGMNXD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53618C061755;
        Mon, 13 Jul 2020 06:23:03 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so13695316edm.4;
        Mon, 13 Jul 2020 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ExF6es49alDYSdqAf6nfQyrFV/rkp6/B8fioIMr76uI=;
        b=RYu8pxNgdnsOJ+hiYOZPlgYabzTbyLX+KMaw5u1yC21ZGr8PmNJw4tVllr1m9KBdW6
         e1yZPoxl4y5vSPwSff+H5xY+hBFKa0xapp3KqR4lMOytc87Cu0xtS6UAQ4fu6FzUAJfZ
         pRYjhi9Q0FHBszC+QXNaDkBU76r+evf62OFLkBk6jgs5Kkgdu9YNMR8DApOdJrkbmxIX
         n9TgJiTaWqPLAjmiPdhuOA+y8c3N0T4ztzYJqgMxaTrD6ZraQP9RiV9P1137SC4/OST6
         tP3QAy3RnsKQrlXqfirjGAvj0zomjFPkEZf9F1WuUKjG9Zo92zd6cdt1pPsPih+31Wya
         V/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ExF6es49alDYSdqAf6nfQyrFV/rkp6/B8fioIMr76uI=;
        b=la+pUI9C1DVBeCYXdzPy/VsdDA979SrjVlmLv0KKvfufNTyQ9n8oEHqTRsglILY+Ow
         g22ySiwACOC/DhB/W6gZNyne6WGf+LlhF2azslTVI3DEJnfIXg6+U1YlDblKCRURxrIs
         zUFnvQVISaao9lnz8x6uFEfBL13f3W7vOEuWorJ69FozkBHvhHwhBSS2CSm0Reo0Ak+6
         fgtqpU9TaCa0cXq4F0mMXGz6YP03bMBa8DuNEFaZDyei2JgQoOBN2lQWmQXw9NQXxRHf
         FUF7h9Hatq7TxxC3EkSxSlh9/av0K+83EiRxCueDbc453m/6BDVq+W9gcr7/qfz9jH/J
         HvPQ==
X-Gm-Message-State: AOAM531IRihLEU0dNUXC2y5Z7udV8J6tZO7zAofiPFSmJxTvMRdNXA/c
        8FqMgEgJobDeLJ3RJ5hUN16pb2aj0+K2Qg==
X-Google-Smtp-Source: ABdhPJx62O4aj0c9a5CqnQR0S5T4oeckXkZ/F5P2u6F1htBXN0jjErRFVTWu9CQ+3ieaAac56zRjXw==
X-Received: by 2002:a05:6402:1805:: with SMTP id g5mr80230354edy.357.1594646582069;
        Mon, 13 Jul 2020 06:23:02 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:01 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [RFC PATCH 18/35] bcma: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:30 +0200
Message-Id: <20200713122247.10985-19-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 drivers/bcma/driver_pci_host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
index 88a93c266c19..b64ba68bdc8a 100644
--- a/drivers/bcma/driver_pci_host.c
+++ b/drivers/bcma/driver_pci_host.c
@@ -244,7 +244,7 @@ static int bcma_core_pci_hostmode_read_config(struct pci_bus *bus,
 				     PCI_FUNC(devfn), reg, val, size);
 	spin_unlock_irqrestore(&pc_host->cfgspace_lock, flags);
 
-	return err ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return err ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static int bcma_core_pci_hostmode_write_config(struct pci_bus *bus,
@@ -264,7 +264,7 @@ static int bcma_core_pci_hostmode_write_config(struct pci_bus *bus,
 				      PCI_FUNC(devfn), reg, &val, size);
 	spin_unlock_irqrestore(&pc_host->cfgspace_lock, flags);
 
-	return err ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return err ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 /* return cap_offset if requested capability exists in the PCI config space */
-- 
2.18.2


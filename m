Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36A2C7A0F
	for <lists+linux-pci@lfdr.de>; Sun, 29 Nov 2020 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgK2QrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 11:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgK2QrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2020 11:47:18 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C7DC0613CF
        for <linux-pci@vger.kernel.org>; Sun, 29 Nov 2020 08:46:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so8793183pfu.1
        for <linux-pci@vger.kernel.org>; Sun, 29 Nov 2020 08:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePbNVNuf2h+BXgSDx7rTfQZRRCtnCpZLYv1u6UwyijE=;
        b=LxXgVcAvuYRMX8jRzkuJygJWPYX0Vxzy+sAyq65jEYJWpqJH0b48mTNasd+tcJLf1f
         uYZcDhZ+mmSxsxNRIvnrzvFZSXYQJRukmHGz5KYNtpAGKlO3B6d4SA3iISK2OmRMjXbS
         V5WFnI7p5ZMMHs+kSYCNLuzXJXM4Y0D3OdXk5RitjOXew0H/5x749hQVd8HKG9G5Phvz
         I7p40g7iSBNMsdxapQEBa0OyS8NU3s2qM24HOkktUiveIbT3MgvQgyZH1ls9Ys2pIVZE
         10RNt+q1gsyWSZVZzdC+Jmy38NWHHwC44gbbrioSvMK4b/j4w/1Ffp6OIuxAoJkFL03t
         Jubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePbNVNuf2h+BXgSDx7rTfQZRRCtnCpZLYv1u6UwyijE=;
        b=uGydCmbmdHc/wHjBUDFXRLaw/L3QhS94xySkju4fdDSYmfTFw06HEOqDr0H9ok/KT2
         tmNoTrej45kQLTn5L3T3RyaLWz9Q34gRcQ3uLedsSMSUYY9TM5rHyQ9tVnAaAgwn7R1A
         aJmLq9N+u8Qq9q37MUtRjSDjSxst4PmgI7feVlOaP5MEPVhrdy9+Kd4j6cyB5JklOdeV
         EJDgbYhy9ycJfN1yrUzVDBdFrK6Q7rS8XgOhMN18UW6OCQaSwptjB99FjOcJjf7scYN9
         fOByaBKkDhgnMBct9OBsgsO08VVF22MxXYf+vnGn4Qva6WeY+ZFdBNOpI28MRvmvNKgU
         IuxA==
X-Gm-Message-State: AOAM533Oi2zOtzmxzZekKhmJh4Smyg8Ocv7psFLaEHg+EVGBlNf1iBMC
        zSbABBSWCX9EjTY3majpcPI=
X-Google-Smtp-Source: ABdhPJxWtS3E6RQcvY/kw2ez6XNN8zvQWUDwtVFRi7Nt2jkvWBFj0NAMTap7505ZCOvyGANk6l56XQ==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr21906563pjo.120.1606668398125;
        Sun, 29 Nov 2020 08:46:38 -0800 (PST)
Received: from localhost.localdomain ([124.253.118.66])
        by smtp.googlemail.com with ESMTPSA id g16sm13684476pfb.201.2020.11.29.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:46:37 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v1] PCI: Return u8 from pci_find_capability()
Date:   Sun, 29 Nov 2020 22:16:26 +0530
Message-Id: <20201129164626.12887-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI Capabilities are linked in a list that must appear in the first 256
bytes of config space. The pointer to capabilities is of 8 bits.

Change the return type of pci_find_capability() and supporting
functions from int to u8 to match the specification.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
v1 - change return types of supporting functions of pci_find_capability.
---
 drivers/pci/pci.c   | 8 ++++----
 include/linux/pci.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..5caae09e0d20 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -399,7 +399,7 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 	return 1;
 }
 
-static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
+static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 				   u8 pos, int cap, int *ttl)
 {
 	u8 id;
@@ -438,7 +438,7 @@ int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_next_capability);
 
-static int __pci_bus_find_cap_start(struct pci_bus *bus,
+static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
 				    unsigned int devfn, u8 hdr_type)
 {
 	u16 status;
@@ -477,9 +477,9 @@ static int __pci_bus_find_cap_start(struct pci_bus *bus,
  *  %PCI_CAP_ID_PCIX         PCI-X
  *  %PCI_CAP_ID_EXP          PCI Express
  */
-int pci_find_capability(struct pci_dev *dev, int cap)
+u8 pci_find_capability(struct pci_dev *dev, int cap)
 {
-	int pos;
+	u8 pos;
 
 	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
 	if (pos)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a79762c..19a817702ea9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1063,7 +1063,7 @@ void pci_sort_breadthfirst(void);
 
 /* Generic PCI functions exported to card drivers */
 
-int pci_find_capability(struct pci_dev *dev, int cap);
+u8 pci_find_capability(struct pci_dev *dev, int cap);
 int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
 int pci_find_ext_capability(struct pci_dev *dev, int cap);
 int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
@@ -1719,7 +1719,7 @@ static inline int __pci_register_driver(struct pci_driver *drv,
 static inline int pci_register_driver(struct pci_driver *drv)
 { return 0; }
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
-static inline int pci_find_capability(struct pci_dev *dev, int cap)
+static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
 { return 0; }
 static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
 					   int cap)
-- 
2.27.0


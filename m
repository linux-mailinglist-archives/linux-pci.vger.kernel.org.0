Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B7D2B6E4C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 20:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgKQTRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 14:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKQTRb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 14:17:31 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73FC0613CF
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 11:17:31 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id g19so800638pji.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 11:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dpv3Vtg5vqLA90R+rlo2PRGIMTldlcoURJnFcnkg+9k=;
        b=DacGbQXhvF2/oDJarOOitDPGudRYd96K+W+S1yovH+/ox64CHWmxpR3BEw7znXZkA5
         W6p6zEHHo/n1rrJ08Zw7KGJRKS/D2eTupcWl65sLIRGNcPMmTei4guy1wc683nnztGXp
         BUQsy7/BTuToGRZ0VSGZWd4iXtJWRGXJ1wUoH/Nuj2BXmJ/AoM1kMZZ77TmCAZMUCMpw
         EArVKlCB4uFE40DiV3lTco82OcZrFmUxHZ9jajTqbf2son8ZaRZp8QiORpK4GM/N3yYH
         7Fsi/g/en4mzNAdf5cYUCr6J0/Sqg5IhE5qtg5G8I0FEvzk9WxDLSHOyJ2WKG0wpI4Rs
         cemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dpv3Vtg5vqLA90R+rlo2PRGIMTldlcoURJnFcnkg+9k=;
        b=I+yCvvKASwto+NlNf6D2kYGjovv6XwjfyeuGjbA1ZfD9nuhxHklQbJPruCYlx0VcpU
         cTZeUIrbZsj2LsVGmgi3PybAUyj18sSAVp7ydcruSGNc/1kLJkVoN6q8Z94zb/GhgtG8
         uHcuzhYPWu+4yKAMkjraXwrAOjyy7QU1iYBhPa4ScthM9nh8i4ozJF8+JMglX4t3jJ11
         dNc83JswgJSeVumWi6HMHuvf52i3PSBfBRLZVcIUkkYsRDIMl8nisO6zfkGjbzbYTGnL
         a13wLz1H8+2WS/g+vUToe2TPVYFTSyxS/2AfdroLDnnXP88tWcPis/knQ9InILWsQR6Y
         kebA==
X-Gm-Message-State: AOAM5309pu06B5trIpVQtYPcj+FmUGlVWfoPDrETttHWIggisnN2bpx3
        2RFa2LQJatC8yfNCeVr3+uY=
X-Google-Smtp-Source: ABdhPJwI+d0YvJcqf66Hvd4PP8z2uKvhci/ij+wUKUE1p4ue/199Os3b70gjnUU6HpF8YYb9gTvtkw==
X-Received: by 2002:a17:902:c3c9:b029:d6:7e88:cfa9 with SMTP id j9-20020a170902c3c9b02900d67e88cfa9mr891301plj.64.1605640649174;
        Tue, 17 Nov 2020 11:17:29 -0800 (PST)
Received: from localhost.localdomain ([210.56.123.179])
        by smtp.googlemail.com with ESMTPSA id h32sm19073591pgl.36.2020.11.17.11.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:17:28 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH] PCI: Change return type of pci_find_capability()
Date:   Wed, 18 Nov 2020 00:47:18 +0530
Message-Id: <20201117191718.17885-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI Capabilities are linked in a list that must appear in the first 256 bytes of config space.
The Capabilities Pointer register at 0x34 contains the address of the first Capability in the list.
Each Capability contains an 8 bit "Next Capability Pointer" that is set to 0x00 in the last item of the list.

Change the return type of pci_find_capability() from int to u8 to match the specification.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/pci/pci.c   | 4 ++--
 include/linux/pci.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d4d5a2f923d..05ac8a493e6b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
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


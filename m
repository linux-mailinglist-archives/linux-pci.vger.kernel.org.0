Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5648455D55
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhKROID (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhKROIC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:08:02 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A05C061570;
        Thu, 18 Nov 2021 06:05:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so5776450pjb.5;
        Thu, 18 Nov 2021 06:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MV39JGkKDIkXiPRnH+W6MhpRBxyv9EoW3jrMZU+eQgA=;
        b=BlIoxgRHAtlgaOA4X+KHVoZAtRRhSolSqdc/mUyB/pQLj6YVZ5NFGN3eQi6c5hQdoh
         S3ioEu71pyjzWILjnXCGEwswEB8Woji8zTq3Tu97wbK7Sh3WegwGOUl4pvGZTCC8sXYt
         paDdTGZrNN4cY2Arv6On5cUy7+4Pp3yWuIq8/F3wTeDQj1QoJSUbMPV8xmI49BhqT0LJ
         N/1eC3FVxHdhfpvq5qMQ+QeUVDPXtNozLP1tN14Rd4y5rXcmgV5oYTFTZBHrfayrGvE/
         CUZGMW+ZOcjI7WPA0JvxEsgTyP9877Kwda4jnLqi3O+gQsDZJJuyaKoOHrAOilp2N+JM
         b3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MV39JGkKDIkXiPRnH+W6MhpRBxyv9EoW3jrMZU+eQgA=;
        b=mb+hsvS4TmbTzzP94/KOFhShTV5VrlPWFK64++QZMixw/74mH82zXvqdnbvvVvxYQP
         kY9pf4MKBhTR3/Hk8OcVyVeMPlGc2ZsSlnxRsddsfAgTxdZoebeRJEkAFn9e9jb00szR
         cPDAM/nwZqxGyA2mu7BbBNG1QSw5ycl33Gq9/UOqFlODgTV2ptl5r8vJKaQZWuMm22QO
         ZUid1nuNnITQDK4ye0c/sKtP925x4JpFvZARMd5j7vdxMce5RXCZpOppAhIM061McdKR
         Bsf8+lByf2NoDGxgatmR/qNWmeFr6Ep+etysIr0njtwR0ISDasmu+rkDfHGpLO9UmhwR
         /WZw==
X-Gm-Message-State: AOAM5330MfHBCiLO1fM3z42KgHT8qtaloL637MUqYijrIoRCNflp+9NW
        3hUpWZ8BbFE6na9y8tjUG1w=
X-Google-Smtp-Source: ABdhPJztsAl12367c92Fw/hcVl1vu1Gs8QO8s7YyCtOAlPzDY8J+Wko11a7iJsaUTWNOAkmhz5U/Dw==
X-Received: by 2002:a17:902:b7c6:b0:141:9a3a:f213 with SMTP id v6-20020a170902b7c600b001419a3af213mr66374177plz.15.1637244302278;
        Thu, 18 Nov 2021 06:05:02 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:05:01 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH v4 03/25] PCI: Use PCI_SET_ERROR_RESPONSE() when device not found
Date:   Thu, 18 Nov 2021 19:33:13 +0530
Message-Id: <29db0a6874716db80757e4e3cdd03562f13eb0cb.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use PCI_SET_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index eac0765d8bed..e1add90494ec 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -529,7 +529,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
@@ -539,7 +539,7 @@ EXPORT_SYMBOL(pci_read_config_byte);
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
@@ -550,7 +550,7 @@ int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
-- 
2.25.1


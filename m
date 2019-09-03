Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CFCA6906
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfICMxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 08:53:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38565 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfICMxO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 08:53:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id h3so9060845ljb.5;
        Tue, 03 Sep 2019 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEZthYw524yVcJR/0nWXghYNjoOOpe+Twe/N3MC7BsU=;
        b=dGHwRhNcCRm2RuYWrzGQbdU0QOFB6cskl4jxwYgbQUSJKWCB7a0Yh5i6KQNYUGD3k9
         CrPcANF1TKqyqFbRuEWiRz3r/MhDhfGLYnNwOccAuoDBtA7s3hCzWZiWw9op9Wwmh5Aw
         cMeZTzFC7Ya1VV9CdqdjswusVnnldfaJFkPJQ4xAh6T5oySe0xQL93jte/krorO8J1Xh
         5wdd5lQ8nq6ptFyMdfkMaX6JjaNPngcUts1j2wGlsrQVKf2XfrSpeVN5PBI0+CdPHcOb
         dJV4EhK7MggwWmq2OOmDZqz+Y1gc6KtNEfTYVoiPknkAGF2gPijh2v/eoIAH5NghAZii
         /cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SEZthYw524yVcJR/0nWXghYNjoOOpe+Twe/N3MC7BsU=;
        b=OhGUe9hGHMoRR5sc/RqJAH47M1uiDjW9OOT8W7IzGKuCN7jAgUlgcVfXmydaboKsQz
         rLGxYDIpYtPS51Y6+Gn9nXZnY5ufCpQqTyIfTNiFnTBwCWnc4StTk8ak0J2sARH6ezum
         RTfM3a8ircq9ZFCsIGdoh8tAVIKnKimoVOvHjbXAxT6ebR3cR8d1pJKlknHSDdyhg05i
         Htshkd6y220KXLTPiHI16MqzdhKX7pPknuVgCVZnRNLZ9szckxhX7+4H90APLJPvVPxL
         FVbGqRe1DhmgaXIUlcidVj3N2bdiqekyizlKEK8ID2bLc74VDs9geCsqJD8UuGU+IbPa
         etmw==
X-Gm-Message-State: APjAAAURBxTG2g8mYk/3jkzBIcwITUnqYtgq0G2etyzYMXRTP2KxvG7V
        5WmiNxJXMtCqm3bvqiWaML8=
X-Google-Smtp-Source: APXvYqxX8GaR3Tgn3fK7mMSvyl0/rvSNlrXhvq24Tmm6N0Z4610MsOOhUJdJdbGb8S88MQu7J1iu5g==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr4875440ljj.189.1567515191984;
        Tue, 03 Sep 2019 05:53:11 -0700 (PDT)
Received: from SKHMSE-04.hynixad.com ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id k6sm246364lja.78.2019.09.03.05.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 05:53:11 -0700 (PDT)
From:   Andrei Leonvikov <andreil499@gmail.com>
X-Google-Original-From: Andrei Leonvikov
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Leonchikov <andreil499@gmail.com>
Subject: [PATCH 1/1] Fix ARI enabling for a NVME devices
Date:   Tue,  3 Sep 2019 12:53:15 +0000
Message-Id: <20190903125315.10349-1-andreil499@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Andrei Leonchikov <andreil499@gmail.com>

Signed-off-by: Andrei Leonchikov <andreil499@gmail.com>
---
 drivers/pci/pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1b27b5af3..ed5f0888c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3149,9 +3149,12 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!bridge)
 		return;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_ARI))
-		return;
+	if ((dev->driver != NULL) && (strncmp(dev->driver->name, "nvme", 4) == 0)) {
+		// for NVME device this field always zero, but ARI can be enabled
+		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
+		if (!(cap & PCI_EXP_DEVCAP2_ARI))
+			return;
+	}
 
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
-- 
2.21.0


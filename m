Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4552D279456
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 00:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgIYWp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 18:45:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46103 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgIYWp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 18:45:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id b22so4476912lfs.13
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 15:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJUlW6VQi2+gk/DtFaoRGqsfjnhzxnoMqZnWUQAmweQ=;
        b=RHu3zLW82TSiJVi9uwRoa5UeigNhaxmxeYQqnw7vdsIYu9U8bDl/WwN+tAK78Mtd9e
         9DGsEEXjPcyX0yzQm4m9n0dH5nK0Qwin7IiTPvp4lPSElH5GfBZGLHuRZbQlTaCHo6Ny
         zKFYA3cJ1S24CQI1BnJPJg+rp+KajVVCgbgbK24laARWmE5Hve8t62E2WQD70Y19sqLi
         mNbxVsTvDXSeNFPwjDBYXi0pWgck5WK3Nobu1zwuPpee4R5aRb4TJroZQloTST/pyKl5
         mA3Ke8tx//PNLIFmwnSpgOQUIzSx9+MeUwQMGpKxNXtZC8Bao3e4Qp98F984EgYbdc8U
         W3QA==
X-Gm-Message-State: AOAM531QCL+81AUmeoKlf6k6UZG0fsGbkTNuw+8j3qCMEk3GjckjAvvR
        RhyTesS2gnJXIB/oJ8f/2mXGTo+rDzye2g==
X-Google-Smtp-Source: ABdhPJyjpt8Of8q6wBtzfD8txUGWgwSuC8JaeUigGSnmz8t6acw4srcWte+ZBwwQFnilelvW/fN7XQ==
X-Received: by 2002:ac2:454f:: with SMTP id j15mr306074lfm.562.1601073956793;
        Fri, 25 Sep 2020 15:45:56 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e65sm335143lfd.143.2020.09.25.15.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:45:56 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Fix comparison to bool warning in pci.c
Date:   Fri, 25 Sep 2020 22:45:55 +0000
Message-Id: <20200925224555.1752460-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Take care about Coccinelle warnings:

  drivers/pci/pci.c:6008:6-12: WARNING: Comparison to bool
  drivers/pci/pci.c:6024:7-13: WARNING: Comparison to bool

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e39c5499770f..487e7214743d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6005,7 +6005,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 
 	if (flags & PCI_VGA_STATE_CHANGE_DECODES) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
-		if (decode == true)
+		if (decode)
 			cmd |= command_bits;
 		else
 			cmd &= ~command_bits;
@@ -6021,7 +6021,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 		if (bridge) {
 			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
 					     &cmd);
-			if (decode == true)
+			if (decode)
 				cmd |= PCI_BRIDGE_CTL_VGA;
 			else
 				cmd &= ~PCI_BRIDGE_CTL_VGA;
-- 
2.28.0


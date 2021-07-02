Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79F3BA4D2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhGBUvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 16:51:53 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55855 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhGBUvx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 16:51:53 -0400
Received: by mail-wm1-f51.google.com with SMTP id j34so7382206wms.5
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 13:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10oXadjisSG6IULhcnPD9e2Y6meG9j0iGoNhGOJk3Yc=;
        b=p91yuZ2JGdtEvd8qq+KDZanXYq4FYhLbVw7WDRipohqHzk54sbYtMRRyBDXL09bjBk
         32i8gPkOLIVoqfQKrLlxYCiUQCTGTJN5wbhqtmo4QzFH6WPliOMSTnxUct+wHzeBcRSw
         1nphuekEhI/emJahuxY4pwOmsBRnJ4UlqvZZB+QtMWLmUdGssi3jAP21Gss6SleAICEP
         oNhbTRd5yIpnZMJzUoUhPkjquvbbpFrx6wKqWi205a4M3qVF1SoeoNqr2Ns1NFzCiSd0
         CrucM7VgSMJpcQHfr64mkl+ztF2r7I2vK0doKFPdMjfczbI0evsac857xlcwNbzl7jHL
         lFJA==
X-Gm-Message-State: AOAM532anTbyentrowd8gBevwDlV6d11TXZpo5CDLDqfBAxuWAgKh5hh
        IuApdwOREA5S+AdbpHPna5I=
X-Google-Smtp-Source: ABdhPJwLuEbapAR7V3Pw+8ClQaJQbnfb36RLQnr+xY4232Cx5nZVHc6leO+slvB5YSBHT+iH//idvw==
X-Received: by 2002:a1c:208a:: with SMTP id g132mr1685951wmg.140.1625258959009;
        Fri, 02 Jul 2021 13:49:19 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id t17sm4120742wrs.61.2021.07.02.13.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 13:49:18 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Fix kernel-doc formatting
Date:   Fri,  2 Jul 2021 20:49:17 +0000
Message-Id: <20210702204917.1655556-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix kernel-doc formatting of function pci_dev_set_io_state(), and
resolve build time warnings related to kernel-doc:

  drivers/pci/pci.h:337: warning: Function parameter or member 'dev' not described in 'pci_dev_set_io_state'
  drivers/pci/pci.h:337: warning: Function parameter or member 'new' not described in 'pci_dev_set_io_state'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 37c913bbc6e1..e313e3a02c95 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -323,13 +323,14 @@ struct pci_sriov {
 
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
- *
- * @dev - pci device to set new error_state
- * @new - the state we want dev to be in
+ * @dev: PCI device to set new error_state.
+ * @new: The state we want dev to be in.
  *
  * Must be called with device_lock held.
  *
- * Returns true if state has been changed to the requested state.
+ * Return:
+ * * true  - On success, current state has been changed to the requested state.
+ * * false - On failure, current state has not been changed.
  */
 static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 					pci_channel_state_t new)
-- 
2.32.0


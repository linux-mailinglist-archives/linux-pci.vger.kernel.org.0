Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891B483393
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfHFOIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 10:08:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41569 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfHFOIC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2019 10:08:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so84828204wrm.8;
        Tue, 06 Aug 2019 07:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3I/0mLICIdXJjIirYonvMMd0Ui1WokJ1/uiCix86QbE=;
        b=UgxEUALeAbtzBD8c4wZt6Vyw0D4sysSB7a8gjR5G8QsHXR+/zSJaiKtFCFIwPkEKDq
         7gk4E8T8oNy5/VsmBDqYYFO9rdUbNDuukukBPW6bQNksJ0V5+/B9T6nNMVuUffVKyWbc
         o9UwpLoARljKU09H2ip+L0n/MqVfJiXhtc5RmqjH+InVSn5AIgMLRa2yWJIBFHwBOZLy
         jltGD61oItO5wexnKCR92hUJLUySrMMF3UXdoyV0ONY9GRf1b9k//9EbwH/75FM7b503
         3RdnQG7xb9gHyQ6rQftmen/1sL6dcEvbIFOlGinUu2MuE9czxwdNcYGK6mLUEnIDI8TR
         qjVg==
X-Gm-Message-State: APjAAAXsh39A2bRKTkAoDhOtJ7yQxmN3PrZAYwEEtuq2AHFzarwc7fiw
        gxYNJ9FHu3w2PHye8AUj5CM=
X-Google-Smtp-Source: APXvYqy/o0BoWizFr6r9rCsfifC7aLByMMjAJ7paSO9dvT3pmex0RYbEi3b9VCHTyd65T6y5g37O2w==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr5103951wrj.352.1565100480114;
        Tue, 06 Aug 2019 07:08:00 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id f204sm146742145wme.18.2019.08.06.07.07.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 07:07:59 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: use PCI_SRIOV_NUM_BARS in loops instead of PCI_IOV_RESOURCE_END
Date:   Tue,  6 Aug 2019 17:07:15 +0300
Message-Id: <20190806140715.19847-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's a general pattern to write loops with 'i < PCI_SRIOV_NUM_BARS'
condition. This patch fixes remaining loops which violates this implicit
agreement.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/iov.c       | 4 ++--
 drivers/pci/setup-bus.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 525fd3f272b3..9b48818ced01 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -557,8 +557,8 @@ static void sriov_restore_state(struct pci_dev *dev)
 	ctrl |= iov->ctrl & PCI_SRIOV_CTRL_ARI;
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, ctrl);
 
-	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++)
-		pci_update_resource(dev, i);
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
+		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
 
 	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
 	pci_iov_set_numvfs(dev, iov->num_VFs);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1fa6519be..e7dbe21705ba 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1662,8 +1662,8 @@ static int iov_resources_unassigned(struct pci_dev *dev, void *data)
 	int i;
 	bool *unassigned = data;
 
-	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
-		struct resource *r = &dev->resource[i];
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		struct resource *r = &dev->resource[i + PCI_IOV_RESOURCES];
 		struct pci_bus_region region;
 
 		/* Not assigned or rejected by kernel? */
-- 
2.21.0


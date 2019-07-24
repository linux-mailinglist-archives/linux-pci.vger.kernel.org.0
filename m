Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E06B74232
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfGXXjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38608 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbfGXXjW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:22 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so18152107ioa.5;
        Wed, 24 Jul 2019 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHIcdZJ5DH84ujFpUNF0zbPMo8AZLf+hnT10L/puUdA=;
        b=Qk+DAsNep7be2o8vxasuB63X1XihHLXN+ZYWVBogQMSCyNVadQYOYO7BC4q8JFCJpH
         IDpu6/S5LtY57NZcKNSJd7NcfHUVe1rseFUhj9lhIgBKrde0Rh+H2pxhPHprAPVXYGr4
         gY1OY9gT2hKlITPmDMoT1ymbZEQlm3sYvSmJbgc4oVBGgwp9R1Y9XajbZJn2PIdT0rPn
         T1KCfUvNSKzVTrzbCLWNAN23YaGgEPn1CZc3iGwkhLWuQBOU/+LoJacoY74t01PPofm6
         2Fd30Fvy2oDPKBZ46jufPxEkQ0D3f1KIZf/+6oDaw5YkOS474KdfMvF1uNxLTRLJU1cL
         +OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHIcdZJ5DH84ujFpUNF0zbPMo8AZLf+hnT10L/puUdA=;
        b=DsPKmBit0Y7ay5zyo5tfd5uCQF73NPLUFGVv4IrJrlkqCBq9UCQ0EaJE7UIgmdtcTb
         8P7YtF1ECmPdKIHn1klpGvRL4aUfUYoAuHA9F3SuMseu0xGL+n0laIy04TInh1xjLBB9
         3oAL0BWMifZqLe6RJM5HcmMD4ItYXMDvbG9Y1CfYJieWvDaXSWsOCHQgYhvRhA15EASP
         5RHr1wMAc3Olw9LsK4e7nwR0kxTEfVq3hfETXLI7ad2BORjeAaSiEqo2bGkwGyMwwLHp
         7AKrCH0IcQgnj9Nu7DSsJEH5EAj2cWLKIfUwsvdHNU7334Opjzw9mGyopiuBz6jNHXKV
         bGxQ==
X-Gm-Message-State: APjAAAVYgGQ9fhjGbKR6p19EBkFKKec2pMdUOTL9eGpRHCMFqjboxaTV
        zd6jkzHDk7mWszl6ZPcgoiA=
X-Google-Smtp-Source: APXvYqw7D0LWHVBi4GlpZqzVDpgwErE+kicK1CPnm/4ij5UTN/bhW3vaCwtXopOyzvrK/3V6EDb57Q==
X-Received: by 2002:a05:6602:2183:: with SMTP id b3mr67144001iob.249.1564011561758;
        Wed, 24 Jul 2019 16:39:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:21 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 02/11] PCI: Move PME declarations to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:39 -0600
Message-Id: <20190724233848.73327-3-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_check_pme_status() and pci_pme_wakeup_bus() are only
called within drivers/pci/. Since declarations do not need to be visible
to the rest of the kernel, move to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 2 ++
 include/linux/pci.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 708413632429..ad1fe54ab8ee 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -89,6 +89,8 @@ void pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);
+bool pci_check_pme_status(struct pci_dev *dev);
+void pci_pme_wakeup_bus(struct pci_bus *bus);
 int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
 void pci_pme_restore(struct pci_dev *dev);
 bool pci_dev_need_resume(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 238449460210..e1f784de459f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1236,8 +1236,6 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
 bool pci_dev_run_wake(struct pci_dev *dev);
-bool pci_check_pme_status(struct pci_dev *dev);
-void pci_pme_wakeup_bus(struct pci_bus *bus);
 void pci_d3cold_enable(struct pci_dev *dev);
 void pci_d3cold_disable(struct pci_dev *dev);
 bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
-- 
2.20.1


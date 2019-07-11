Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53D2661AF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfGKW07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39671 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbfGKW0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:14 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so16157226ioh.6;
        Thu, 11 Jul 2019 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7Q+88/1r0u7c2B6QjPHmF5D3UfMD7VkncBOPB4xqnY=;
        b=WBoEHXu0KZ4DEZnPjfSX+XW+fGJCDiT5qC5+TC0Bw9R3Zg5bndhAmFizc7RNrWVpaX
         iNkFBOdQTjpiaAijq/F9tfezaY9SICoZZJbCjjCtxwSxyg+6nh+KscU5fv/gEdi6sqCI
         hAKC28MCHrf8Dr+jXdjUZDlGKj/Lst9vRID1mTykfPEiM2JPoFp3bw0Bbn/4knPZE25K
         aML2JaHGoZ6pBA2d0qAlnav+RI/dQHe7x9pzLYzEThPBeYKuzFk9tN1QeEFpDE4T2u0h
         42tzZwlLjwT7ptCTYFHHB03PhMsVh9bqav2+AP5pRVRESUDKD609P2FqAIw6rB26jmJX
         WBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7Q+88/1r0u7c2B6QjPHmF5D3UfMD7VkncBOPB4xqnY=;
        b=rDJvgQTqbrxqkaaacWHNb4yYvwmWpa0dUrcSxn/R5fPu459s7Tel6fkcOJOGDVpSHn
         RisO4dTqCSM+xchpsNcAEyIxh2gA40PxHNLXJ3NcOPuKCnLMqgvqb4V7irkPX7zT03rB
         b+xRvnbvMMDE0U8ePAUAyGzJD+EQiQrOA8+5D5yVHSvCV/GpbOPcV+tRn4l8GTW9YIS/
         jGuGt5/0+wYVYeURWCj5ZaJmadoERFOVzwAPAhShS0gyR2jlbKT8catuRzzbQG8ZCzye
         8IBPb00gxONTdD2mcf3x3Jqc4pGrcY9A8dLH0iq90JDLT+evICCdob64KSY78L0Bok6j
         /C0Q==
X-Gm-Message-State: APjAAAVnLsdkMkyWRU+6ILRbgcmEU8AntyJk2D3OeEPh6awgg5tOY1pt
        1KoVf41XJ1TqApWBM9lMSHCRC+4V4CZRRg==
X-Google-Smtp-Source: APXvYqzIOpFYThRbBahecvJaRJQDIcL+OA8MrF+nPbgf4gJ2Cl91cYTYiwTeyF2E0q03szbbyEW5tQ==
X-Received: by 2002:a6b:641a:: with SMTP id t26mr6958337iog.3.1562883973499;
        Thu, 11 Jul 2019 15:26:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:12 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 02/11] PCI: Move PME declarations to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:32 -0600
Message-Id: <20190711222341.111556-3-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
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
index 7e30fbde5c84..800fe8989f48 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -85,6 +85,8 @@ void pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);
+bool pci_check_pme_status(struct pci_dev *dev);
+void pci_pme_wakeup_bus(struct pci_bus *bus);
 int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
 void pci_pme_restore(struct pci_dev *dev);
 bool pci_dev_keep_suspended(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3bda6a87a815..cedebb08a32d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1187,8 +1187,6 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable);
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


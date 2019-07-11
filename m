Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6462661AC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfGKW0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43825 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfGKW0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:16 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so16112075ios.10;
        Thu, 11 Jul 2019 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ojyucIvKYu7CDUehRCpB+nredG5sCsEyfgfj3qkRIiw=;
        b=i/mEcKa+xHrz06ZIZEmoKfO8o/1ZFEOiblV2dinwYFXK6eAxvmnu+0vvfkAbwYS6O4
         fuAICrMduoNmJHBRxgAXr3bxwCy3RrjtDIpwobjGSj4QOlgWbSowotg9OI3XiSSNKK43
         UQEru/kEstdUTG9/lvkyL3okm7v9jVQYdpYCMg1MNwEK9NogLATOPdfsnsaT/q07NdvZ
         yIvN/NhQUCE5DdOz+bpGkADj5zI5L6QGyl5kJjqZgXolX4xQmTRFYsuZDK9jPdixYFCP
         Qde3xuqEue7CeShjiNMlJRB43SqPt37mwJHiomcrbAlXKyHy/6HhJ9BiIcgkzR5y+Qgx
         DGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ojyucIvKYu7CDUehRCpB+nredG5sCsEyfgfj3qkRIiw=;
        b=dCP8dOhCILMoLLZ4iXxndTFfLOveB4vnkJbw9CzecJVY/X1Y+OsnRPfNvPELrr6KtC
         G2sDINpdUMCrRqSFjaBOipLVb50Dg3fYUteHk08bjQnCCjiIReKHqeCYQcHzup+bBiMO
         WFCNoH1DY2WvKhrRehWt2q6NCd9Bw1ASi+O99UfYM5imAF+78/0eXSYqzSIUUvVxEGdl
         YMyHRVpHrhGPonYQ6+Io8rVJH9fs+FCNUu7S9KcpYw4DAbuigoRni2FuGrhgeIvbY9BH
         0nslDywR8WyoqQniYuDEL8glbtmw7LvLSDLJ6BSz4WvyOJouZwSf91O8vmXeRafk2Jf/
         5enQ==
X-Gm-Message-State: APjAAAXkTZMSiA8WOnQPqyiGeBRw7S2Ee4dW3sJF0haeoUF5PG0IbPRM
        XC1TE+qp8kJ0UAVUUaFyp2Bd68RWJM7adA==
X-Google-Smtp-Source: APXvYqxVaWyX7BoBLPXUnidLV1bwccbWvm2pLjuPiRmmJRziC/3nXuJ9jBAfSDZji5oj4xFHzZojEQ==
X-Received: by 2002:a5d:940b:: with SMTP id v11mr7205793ion.69.1562883974909;
        Thu, 11 Jul 2019 15:26:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:14 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 03/11] PCI: Move *_host_bridge_device() declarations to drivers/pci.pci.h
Date:   Thu, 11 Jul 2019 16:23:33 -0600
Message-Id: <20190711222341.111556-4-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_get_host_bridge_device() and pci_put_host_bridge_device() are only
called within drivers/pci/pci.h. Since declarations do not need to be visible
to the rest of the kernel, move to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 3 +++
 include/linux/pci.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 800fe8989f48..f2ba33613c21 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -100,6 +100,9 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 
+struct device *pci_get_host_bridge_device(struct pci_dev *dev);
+void pci_put_host_bridge_device(struct device *dev);
+
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
 	/* Wait 100 ms before the system can be put into a sleep state. */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cedebb08a32d..39e609ea316e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -639,9 +639,6 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
-struct device *pci_get_host_bridge_device(struct pci_dev *dev);
-void pci_put_host_bridge_device(struct device *dev);
-
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
2.20.1


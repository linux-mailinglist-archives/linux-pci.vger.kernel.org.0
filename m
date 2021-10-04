Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5CE4215DD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhJDSDJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbhJDSDI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:03:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5FAC061745;
        Mon,  4 Oct 2021 11:01:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so542618pjb.0;
        Mon, 04 Oct 2021 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7sq5HEJs5lGnG+J8tujUids2AjtGM7weFegW7/rlp0=;
        b=DCLTSaQ07PyQGYWXH1+2Xsfdvw5DGV/I8XtRyOJbPaLb7kUI5hE9bZs5tBKfKfnEZv
         yJWA9rYnr0brHhmOMVeV+trr2fiBrUYwjSZbYSZwDmP9r/JS76OU6s/3AdycKZWfYTFw
         CIclJY0tQH0UeDsZcm6RtmrZGNXAT160EC6VgsC9hOtIq0iSkaWcZ0KkM1D96wVVTdxM
         U+yKA9jvbDs9v12WOHtt4EpvmMzklJn+8vLlgMBPU0VuViSjzLx2CwTYViJ73cL/+5xP
         vGqSeNgUdhH7az1nnmJYLp6QV6XxCG8nLT0xkZmBoClJDUKZ/T4ZfTcgZV5MYU4BQyQC
         CewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7sq5HEJs5lGnG+J8tujUids2AjtGM7weFegW7/rlp0=;
        b=gGDmz3spj+dZDma/u/VZ/a1y8edYSGABWRtOuyLRFzB3JEIZGvAvPN4maaHs3xwP2T
         ttY1vOcOUr8H83zk+Ab/80Yic4h9RqKGsGUMAPUyuXyat5HvqX8dbp/eKhGS/EAgCb1k
         phumd+dvDdRsvQ+EaAaYnpFi56xM5wDd2KcYTgltVLuG4W+PGMHVzJJtvQ0JSqiXg5Jo
         jTHVIFUYkKU/Cxoa1GWU+BcjWIla36KGCUMpL0B4PpeCuyWw6iu/bQNn/TbvMuq0Oveb
         ieNr0V6JTAShRJcEBCMGwPyfLeM5nGq5GohVDB8A0cY4797fCaB03aeZDTrG/3k6o+eO
         w3tA==
X-Gm-Message-State: AOAM5309NLlPnLB1bbB8nYF4NtmMZmvn6o812E1dGAcTjAwwu6w45Wp6
        5uVErnw+50OZ4xhZuPwr2r0=
X-Google-Smtp-Source: ABdhPJxqQ1dbB0F5R2hGORk15/5zZpFg9rCi0DkVZQ7y0tE2wiTwWP4DlAOal+8YQvciNlfn7Vn2pw==
X-Received: by 2002:a17:902:a503:b029:12b:2429:385e with SMTP id s3-20020a170902a503b029012b2429385emr966754plq.64.1633370478701;
        Mon, 04 Oct 2021 11:01:18 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id z2sm3641004pfe.210.2021.10.04.11.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:01:18 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, tsbogend@alpha.franken.de, ruscur@russell.cc,
        oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] PCI/AER: Enable COR/UNCOR error reporting in set_device_error_reporting()
Date:   Mon,  4 Oct 2021 23:29:27 +0530
Message-Id: <b583172ece1fb1dab3d75c6007ec8c443323158d.1633369560.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633369560.git.naveennaidu479@gmail.com>
References: <cover.1633369560.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The (PCIe r5.0, sec 7.6.4.3, Table 7-101) and  (PCIe r5.0, sec 7.8.4.6,
Table 7-104) states that the default values for the Uncorrectable Error
Mask and Correctable Error Mask should be 0b. But the current code does
not set the default value of these registers when the PCIe bus loads the
AER service driver.

Enable reporting of all correctable and uncorrectable errors during
aer_probe()

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/aer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9784fdcf3006..88c4ca6098fb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1212,6 +1212,7 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 {
 	bool enable = *((bool *)data);
 	int type = pci_pcie_type(dev);
+	int aer = dev->aer_cap;
 
 	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
 	    (type == PCI_EXP_TYPE_RC_EC) ||
@@ -1223,8 +1224,18 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 			pci_disable_pcie_error_reporting(dev);
 	}
 
-	if (enable)
+	if (enable) {
+
+		/* Enable reporting of all uncorrectable errors */
+		/* Uncorrectable Error Mask - turned on bits disable errors */
+		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, 0);
+
+		/* Enable reporting of all correctable errors */
+		/* Correctable Error Mask - turned on bits disable errors */
+		pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, 0);
+
 		pcie_set_ecrc_checking(dev);
+	}
 
 	return 0;
 }
-- 
2.25.1


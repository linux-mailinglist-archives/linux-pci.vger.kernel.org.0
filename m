Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB39421180
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhJDOgM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbhJDOgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:36:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089AC061746;
        Mon,  4 Oct 2021 07:34:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h3so6077059pgb.7;
        Mon, 04 Oct 2021 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pWZxY1yQdsUwMEG6Is0voI7d8xdXhwobuZZscOdeBw=;
        b=DrFpdMFEIQmQvoRS5VddB8m+GxhSGCKG1KDkOK4n9yhcyXAsA58jrgorq6Pa3ESPyX
         FmghPXRm5yzs+2NAlYgyVwYaBN8Cv05+e7PF7rxZHGSUT43gTCwv1xFxwQmTmKsOx6B8
         jGSfBj8NXKIOWkHN5MKcyLasaiyV9kyAIFWYOCqvp7LvpibYuqIydO0AwOF7/6xRs0lE
         pYgPgE0OgJ5s7PpzGDxtFdliRnOmLL0xZUxtjlIsJMNBRD3cQhchDclojgZgOj0jaTt6
         hTDWgEo66zRdLi4N/P0wbSJIt444hUoUD3P8E5oN1lxHId5MOo2g3OP8M6UOzdKowoSq
         hWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pWZxY1yQdsUwMEG6Is0voI7d8xdXhwobuZZscOdeBw=;
        b=8K93uvgEwIzSAjjivKJRoTLtvuGM1aaC2E2gPYwqkc/Oega8Vln+PFSKHcy4HEPOij
         cUS/WadPk+Oqmk9+JAofDyoaHAyJgCCbL8xE9aX5SxuDxVIVyq/c5LdkyDMcKU2vPfQi
         PMl69D30l3DxZp3whUoKD5j264w+Xis2azvmBaazHQ9YE4OnQfImvXeShPa1HA8esiA5
         N1DUsSJYxVOe6zldGbrDv5cUqHsa8wo1kLLPuevtGjz2lFAQ36k583eGc3zJiupjiNy9
         yKFRQBQYwI3Lj+MAsixR4sruBweooTIsHWng9ThwoHaMbw9PEWi4VxSaSTXf0v6OTwr8
         FNlQ==
X-Gm-Message-State: AOAM532agvKXAYvp+8I3ppYJwWfXxY/I6JutdlKCvQkoeSIe1yQkGf2X
        69prXnhUjlnr713vdHv2K/M=
X-Google-Smtp-Source: ABdhPJy+sWf8xBhC0RvZ5PKZWz/DDoInn++6/IvE8D6lUPdNyv263NSKhV+bEgdAgv26xYa63HLULg==
X-Received: by 2002:a63:7d04:: with SMTP id y4mr11390118pgc.131.1633358062410;
        Mon, 04 Oct 2021 07:34:22 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id q3sm14489146pgf.18.2021.10.04.07.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:34:21 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 8/8] PCI/AER: Include DEVCTL in aer_print_error()
Date:   Mon,  4 Oct 2021 20:00:04 +0530
Message-Id: <b86533084b7098fb1d9d03a73e842f023cc6ace7.1633357368.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633357368.git.naveennaidu479@gmail.com>
References: <cover.1633357368.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Print the contents of Device Control Register of the device which
detected the error. This might help in faster error diagnosis.

Sample output from dummy error injected by aer-inject:

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000, devctl=0x000f
  pcieport 0000:00:03.0:    [ 6] BadTLP

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index eb88d8bfeaf7..48ed7f91113b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -437,6 +437,8 @@ struct aer_err_info {
 	u32 status;		/* COR/UNCOR Error Status */
 	u32 mask;		/* COR/UNCOR Error Mask */
 	struct aer_header_log_regs tlp;	/* TLP Header */
+
+	u16 devctl;
 };
 
 /* Preliminary AER error information processed from Root port */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 91f91d6ab052..42cae01b6887 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -729,8 +729,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x, devctl=%#06x\n",
+		   dev->vendor, dev->device, info->status, info->mask, info->devctl);
 
 	__aer_print_error(dev, info);
 
@@ -1083,6 +1083,12 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	if (!aer)
 		return 0;
 
+	/*
+	 * Cache the value of Device Control Register now, because later the
+	 * device might not be available
+	 */
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &info->devctl);
+
 	if (info->severity == AER_CORRECTABLE) {
 		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 			&info->status);
-- 
2.25.1


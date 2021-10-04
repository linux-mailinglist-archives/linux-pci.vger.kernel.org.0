Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5C3421116
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhJDOOT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhJDOOR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:14:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6D6C061786;
        Mon,  4 Oct 2021 07:12:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q23so14606502pfs.9;
        Mon, 04 Oct 2021 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pWZxY1yQdsUwMEG6Is0voI7d8xdXhwobuZZscOdeBw=;
        b=NUydINFeaaYz+i9WPJbGyeQUsYFP9zSERxwD1Jn6Zy3MiwxkpVvQ3g86oUYweoEXDn
         g7AO/boeGyjJTIfJs+jbcZvYQnaMw9L97HPI95jvHheem05IGEyontOjc0UTaTno4QTd
         fMOc4+ztxfQkYeEjO6chiS+rUMQKcVKzRBZHPqeoqq3ImqAXzW/9+m/Tps0r9Q9BujQ0
         HY/BmFj4rlxn+bOKAZY3EjI734hi0507/9dFVNHsFShpknbny5hjumwJL6CVQANs/7DF
         6tod9my1Q5SU43oRK2wEoF0yRZzbY754966s+x8u1QlbRbLLB4tutM5+B4uA0I4juRv3
         iq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pWZxY1yQdsUwMEG6Is0voI7d8xdXhwobuZZscOdeBw=;
        b=yBtgyjmxMyV8/4DIm0EdUlJ5JARw+mHkZSFAVRowHjRf0pR2M3YqvXJcQrJ5909GuR
         WLW/mGJuRT+VByi5t3U1vLey1UT+iDuloKmJmS3lOhI+2vNOKr5QR8ix2pZhATvnQP5G
         ACY7ymcl0VRcbBS9J8CU6kTRfyf6cEHikw3Qm0vhVYjqzg69msuuy5+7uwd+JSIZD+xg
         tHz7VARsRkr6EGRef+6l+RKTiwdLvQiDXUvq3Nj55zYG49raxmKd830la4jzZYRU+dAx
         pvjMYdya3cBLA4i86dFFCON6yFVuYwh66cS9NpJSooWyL3QynGhi84GjwFcsCVaLf3gG
         GM/g==
X-Gm-Message-State: AOAM531pP63EzX+Ymz+vdHPsc8d1el0gPza1szSPJBblg+ENyFIWhJPR
        aNht1h6roxKnCVLr9w2fo0Q=
X-Google-Smtp-Source: ABdhPJy637X8uWvHNOw8XJA6f1F6uN2R7daksnQfvQ4CYbdoIpgTFzTfpXCbIoBTqV1cSFppFJQK8w==
X-Received: by 2002:a62:1ac4:0:b0:44c:4c4e:1d3c with SMTP id a187-20020a621ac4000000b0044c4c4e1d3cmr10348659pfa.8.1633356747885;
        Mon, 04 Oct 2021 07:12:27 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id mt5sm4266860pjb.12.2021.10.04.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:12:27 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 8/8] PCI/AER: Include DEVCTL in aer_print_error()
Date:   Mon,  4 Oct 2021 19:42:05 +0530
Message-Id: <e39df4392e514bae8dbd373a3c92d994d8c2ae49.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4948C439D03
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhJYRK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhJYRJi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 13:09:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AEEC04319F;
        Mon, 25 Oct 2021 10:02:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i5so8365896pla.5;
        Mon, 25 Oct 2021 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqjk8A2jWPq0oF4j9f9pzp1s4umWD0fjXGGtRVK6pjI=;
        b=Km6qa7as2zKj4ahv0p9FX7MpcWGD6tjOML1ZhOUQeUR0KuKrOM/Y0B/OyJfcY7k+wV
         vxBWCUFtyHAC9xpI7R+JpBoHX7mIBWtExK6dpDNOvdxr8x585+K1/QoH1n9W51ljXFIe
         Ime4psXupDQ8xMItucMuFoc8wY9NLuiKaSBK9NCeCLy4GpEaqcgSw4MigLRUmPBvRKBV
         zeGByhYX/WSCf8Rw50ZVEGRzOm1ClghUP3ygjo8N7vdrD6cgqrTBfTZqpLCwQ5gg2s9A
         hpWhkVoMpqIKr+Z8t1u0lgEIc0EPdLIJCebjyg1jYoq/0ks0XSKGoaFxjA2/LD1Bz+gE
         HU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqjk8A2jWPq0oF4j9f9pzp1s4umWD0fjXGGtRVK6pjI=;
        b=P7yxLr5iTIFcAVeFGYDGuwWDV+ptd7ttWlMsQxZj/y9xPOx2rFyFvhf9+QbuK3Wxnk
         HZ0sfq1dbbZyq6Gq0DcszAXcMg5B7l5j0kLkdjODl07PSGIUmdWD+OhXwPtm0Fm8ucku
         AaOYTih6NRtm2O0oXxK7xhsWmPmPAdqKjhXMSFpwyRvI+S9HDvxe9Kwbh5zkDCkvLMUB
         EgCD+02t1iDytIzyagrkvTi0IkJUUM94QyBX0w0h3rtuR7HbEeoAZzkec0qcX9ggxKb1
         ZIw8ouEawhI3aBWCsH1MxXzwSayvVnVBUWD3d+9VfgilYkik5gprSNSR+6jqYafqPdui
         haZg==
X-Gm-Message-State: AOAM5328CmcaVQSgPSvauFG97pEB898sfrIjoQJrMohqFqEHibSR1qFM
        oK5PWAaBqmQJ1XZVMIrE/JomnjyGEPa3gg==
X-Google-Smtp-Source: ABdhPJwvg9sfWgMNprK2Vf152fcQgXoPVYpKGuP89MlymuNgLLjfTAnceEvjffU47QWeOG5XuHfFZw==
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr21825917pjb.212.1635181351786;
        Mon, 25 Oct 2021 10:02:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:df8b:7255:8580:2394:764c])
        by smtp.gmail.com with ESMTPSA id g18sm5100858pfj.67.2021.10.25.10.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:02:31 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 5/5] PCI/AER: Include DEVCTL in aer_print_error()
Date:   Mon, 25 Oct 2021 22:31:04 +0530
Message-Id: <656b4eab7fae68de86bb0a52568fb93822833828.1635179600.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635179600.git.naveennaidu479@gmail.com>
References: <cover.1635179600.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Print the contents of Device Control Register of the device which
detected the error. This might help in faster error diagnosis.

It is easy to test this by using aer-inject:

  $ aer-inject -s 00:03:0 corr-err-file

The content of the corr-err-file is as below:

  AER
  COR_STATUS BAD_TLP
  HEADER_LOG 0 1 2 3

Sample output from dummy error injected by aer-inject:

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000, devctl=0x000f <-- devctl added to the error log
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
index d3937f5384e4..fdeef9deb016 100644
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


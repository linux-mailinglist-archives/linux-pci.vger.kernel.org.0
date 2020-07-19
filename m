Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8BF2250D9
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jul 2020 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgGSJTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jul 2020 05:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgGSJTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jul 2020 05:19:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DC3C0619D2
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2020 02:19:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cv18so5164938pjb.1
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2020 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWbYFYIu0qmpjpMid4/cfRGsYGBLqRNDtWeBkoqnf5A=;
        b=rC2GFMbMxjpanuQEyU77O8+3zi1kZc8k8jQBHQAf8DpBIY0sGoarQmDx7HUPuwhNw8
         UMdGr9CDreP4AS0c7TrC9rBX56IDMERQsewgZViXdC0hIV6s3nDNKmYUbm1bhhIw/N3u
         nKd4nAfy2KyaxgDR+W0Mgrt7Mb9SoXFO1JY9nd/h2WtaU/ls77Wa6ommXenIBiWmvbLh
         Ux3tPOe0fLIZ/5ntBpVHKASHueSdonvoCB+i+wtraxyl2hLfTfQTDV+3CVGuwDxaBLFM
         m6cvp9KnnFT5DTVpld/QNYtZa0Trkn3l0tf829u+LIpBk96bbimM+cfeN0DggPNFgoJr
         K0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWbYFYIu0qmpjpMid4/cfRGsYGBLqRNDtWeBkoqnf5A=;
        b=KMfCnAEHxi3kv1Wn9gNPZ56qO9o5tVZHykVcr1Iwc5Z1IFQW+ZiRDzq0NxpkYLqb6o
         odhzAyAnNDLrBBgarwfZSts7C/EahbncOKVEC3hl5mbTzXhYC1lzEXuePom/eI6w0gV3
         M5NBe91fzcKST6Y2y0rPmHz4BIw391s7Jj+5GnpPPf2gD3Vr5JJ+0yvs0yoe1HVesOQO
         Xj1h+yCm3sdIBdwHHQefRmcsD20AYnbnOunhty5F5ptg67u8yzQCy4Wg8dsVhOzzJx0k
         rUuK+Pkl9BqMYEoFaRP2KLV4tT3D1FhtSOnLHpwHcI42RlOrd5s8J5+IJkNcsLBtwhFB
         FlwQ==
X-Gm-Message-State: AOAM533YFWuhxBRgiZExBlCsxEnOJZQxBFxJWuw+iSkrUmHe3E8Aagd2
        EcetwB/UawGbTxLnadPOFdppOWOt
X-Google-Smtp-Source: ABdhPJwAXKUYaWVNPxCUmds5HcpiXZAFEG/x3gxMolkVKLxl5HOSSXLF3fAX1lVImFgYyxyjDQ3lTg==
X-Received: by 2002:a17:902:d68f:: with SMTP id v15mr13853753ply.109.1595150372359;
        Sun, 19 Jul 2020 02:19:32 -0700 (PDT)
Received: from localhost.localdomain ([124.253.248.36])
        by smtp.googlemail.com with ESMTPSA id s10sm11138270pjf.3.2020.07.19.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 02:19:31 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Add _DSM Function definiton for Latency Tolerance Reporting
Date:   Sun, 19 Jul 2020 14:49:11 +0530
Message-Id: <20200719091911.20395-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI Firmware spec rev 3.2 defines function index 6 for LTR _DSM
Add a define for usage in LTR mechanism.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 include/linux/pci-acpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 5ba475ca9078..2889bf7f2a39 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -110,6 +110,7 @@ extern const guid_t pci_acpi_dsm_guid;
 
 /* _DSM Definitions for PCI */
 #define DSM_PCI_PRESERVE_BOOT_CONFIG		0x05
+#define DSM_PCI_LTR				0x06
 #define DSM_PCI_DEVICE_NAME			0x07
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
-- 
2.27.0


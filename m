Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DF1C3288
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 08:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgEDGSu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgEDGSt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 02:18:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE25C061A0E
        for <linux-pci@vger.kernel.org>; Sun,  3 May 2020 23:18:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so19384506wrg.11
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2020 23:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDlG0Xw1x/kgXl/YkAa69pkzlhWwY8X9N+5Bs9v5cew=;
        b=Wx/Ea1rpn6/dIelkYV8bMF7ToJsTIKXw6Vw1nBXW5kLruk0Wm5iH9Kj4JRFs7ScP+t
         utJfe4Z/iu9XmLtFvAMdE1wvN8O43r8pOi5POyaWVti7HtqwCc204/4HyukBBGe63nlO
         wG0Kevnm9vzowJB2tW8/xJg6O4ZMd62LDdF8dcvcMPuDqNymyTdkfyIdEDE7je/sg3st
         FeoHjy88pMvgwteC+xb6UBidfncENcfAaJAvGsWXmZ9+ROUTV4XJkptg9OPGgC931vmz
         PCyefSolyPlm6cUYRD8I3JkuTrlhphO0K2rp1dZGhIyfeW8mjHdTwgQHwQvO1qbI8Xl0
         vXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDlG0Xw1x/kgXl/YkAa69pkzlhWwY8X9N+5Bs9v5cew=;
        b=QCmvauoH0ocfBwN+C/QU0h7e/lSXBlEkPOYuqSTA1d4Pg8EQPWXFtz/RlqfYA1yMuQ
         QBgw1muNJQbGbOmyrQVjBAXBhgTLswHl70BSSsZN51FrP2uamgtsWuG9ivA7R63vHQZy
         0K3EbJ6HxYDhuP8imJ5aLuCP+HVmZYWN0Y4lDi1P7/gUTefz/TzHHgOzRW69uwUP/ZQa
         CevaP85UlYw/T1JFWGC9ItG9sE5rCi4bFvuMU4YyDEObvkG261j7ynBDzBWPxBPJ4iDw
         dmOTxZiMp8/+qrxscPYEBTOnrVHs4kVGqC5QldTkWmbQqKDl2xIOryxBFQbl2Jp2mcjA
         fbcQ==
X-Gm-Message-State: AGi0PuZkBkbcyV2k7hrV32EyuUMf+hduwk2R1RnfIc0F9oqV1W7Cr+wy
        D1UlHRzya3vRL2K6uSf4ZEk=
X-Google-Smtp-Source: APiQypLxeRYL85Yfp7NqvJbDkFX8Zn2rtvi8+uBh0Q7eXtp4iLsVAYK8ybnOjPP+WDnbmJSBysldWw==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr16966244wru.174.1588573126967;
        Sun, 03 May 2020 23:18:46 -0700 (PDT)
Received: from net.saheed (540018A9.dsl.pool.telekom.hu. [84.0.24.169])
        by smtp.gmail.com with ESMTPSA id k23sm11559004wmi.46.2020.05.03.23.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 23:18:46 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, yangyicong@hisilicon.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: [PATCH RFC 2/2] pci: Set all PCIBIOS_* error codes to generic error codes
Date:   Mon,  4 May 2020 07:18:12 +0200
Message-Id: <20200504051812.22662-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504051812.22662-1-refactormyself@gmail.com>
References: <20200504051812.22662-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

PCIBIOS_* error codes now set to negative value generic codes.
pcibios_err_to_errno() is modified to reflect this changes and the function
is now marked deprecated. The function now only returns negative error
codes.

These changes effect the consistency across pci and pcie accessors.
Now they all return 0 on success and < 0, otherwise.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Yicong Yang <yangyicong@hisilicon.com>
---
 include/linux/pci.h | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..ee87def7242a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -661,32 +661,31 @@ static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev) { return false;
 
 /* Error values that may be returned by PCI functions */
 #define PCIBIOS_SUCCESSFUL		0x00
-#define PCIBIOS_FUNC_NOT_SUPPORTED	0x81
-#define PCIBIOS_BAD_VENDOR_ID		0x83
-#define PCIBIOS_DEVICE_NOT_FOUND	0x86
-#define PCIBIOS_BAD_REGISTER_NUMBER	0x87
-#define PCIBIOS_SET_FAILED		0x88
-#define PCIBIOS_BUFFER_TOO_SMALL	0x89
-
-/* Translate above to generic errno for passing back through non-PCI code */
+#define PCIBIOS_FUNC_NOT_SUPPORTED	-ENOENT
+#define PCIBIOS_BAD_VENDOR_ID		-ENOTTY
+#define PCIBIOS_DEVICE_NOT_FOUND	-ENODEV
+#define PCIBIOS_BAD_REGISTER_NUMBER	-EFAULT
+#define PCIBIOS_SET_FAILED		-EIO
+#define PCIBIOS_BUFFER_TOO_SMALL	-ENOSPC
+
+/* *
+ * Translate above to generic errno for passing back through non-PCI code
+ *
+ * Deprecated. Use the PCIBIOS_* directly without a translation.
+ */
 static inline int pcibios_err_to_errno(int err)
 {
-	if (err <= PCIBIOS_SUCCESSFUL)
-		return err; /* Assume already errno */
+	if (err == PCIBIOS_SUCCESSFUL)
+		return err; /* preserve success */
 
 	switch (err) {
 	case PCIBIOS_FUNC_NOT_SUPPORTED:
-		return -ENOENT;
 	case PCIBIOS_BAD_VENDOR_ID:
-		return -ENOTTY;
 	case PCIBIOS_DEVICE_NOT_FOUND:
-		return -ENODEV;
 	case PCIBIOS_BAD_REGISTER_NUMBER:
-		return -EFAULT;
 	case PCIBIOS_SET_FAILED:
-		return -EIO;
 	case PCIBIOS_BUFFER_TOO_SMALL:
-		return -ENOSPC;
+		return err;
 	}
 
 	return -ERANGE;
-- 
2.18.2


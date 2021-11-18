Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E812E455D4E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhKROHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhKROHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:07:37 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BDCC061204;
        Thu, 18 Nov 2021 06:04:36 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g18so6104816pfk.5;
        Thu, 18 Nov 2021 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRVr/MvmbDbYCYZVQvovIm632g48TSctaBpAr4pPMBs=;
        b=ki3zJclRT5gZaLLE08IwbhWAxIbTzKFMLWGKODRFKxJMYkkPV57hmCyWQs7c+DPosB
         5mGT3f3d4Xo32+oDwKv9/J9AYz0Y6ZUF4Ipfd/dezlJppudIle8DSVT2t52Axq6FE2ot
         pk0I9ygiRZzF/58Mf0M0Iyyx4J1CAb84WkGwpfjx/lMlEYg2kQ6SLyCGodPMAHwZpthr
         zUord0VXRyBh+6WBJIxc+wTFGBSTEJ4ll7/W3L4JjXvX//SDdLbzbAeJorDa2ip/qyCV
         uafNAyEYulpT3XpNjH5DhcLk5X+YBwhuElAMWAST4BDJSDBuEF6VmBIm/tNDUMfCBcUf
         knMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRVr/MvmbDbYCYZVQvovIm632g48TSctaBpAr4pPMBs=;
        b=MLBRkBcPhAf9CL+jWEyj81/NmAEVogFqYq5/9EIkSZ5illiY2z0ahsVRS2PbL6/C3R
         +m4hKXzpgJDvHjg8G+NDxUaLLjPfHVrQyoA9r+WUwS9tV/AsjqH/pqvKg5njkFE495Oh
         9X4bs5KnUpbN6xpxhlHg05Cek3F9InOELWBOHN8MRaVQ8coE/yBiZ0vVBE72ITFvLjHN
         fWPndNCNUdSQVEIAVikwktbnN1R1R/50kLpG3982ychldnvkYYwkmd+yJqmU9S12EgQM
         StxOUcSbYplJCayJYv5j9t/k6ogVdQCFTamTleevlthqaXzooodr5/l26DWnkcsJOuYh
         SZoA==
X-Gm-Message-State: AOAM530iDX2llRN/hdZhZtA+dWSwJDIFMzsCzwtJaixq485uOXQU457s
        U7N5Ey+k76Vep2VFVyabuDY=
X-Google-Smtp-Source: ABdhPJwgSJAJzb9GnmZhNCiuC4sXvl/+OpI7uHAkOxqyhJ9kXcl1osCLvoOYPljMeoii6U1rnBhr8w==
X-Received: by 2002:a05:6a00:24cd:b0:49f:bf3f:c42c with SMTP id d13-20020a056a0024cd00b0049fbf3fc42cmr15229341pfv.54.1637244276068;
        Thu, 18 Nov 2021 06:04:36 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:04:35 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v4 01/25] PCI: Add PCI_ERROR_RESPONSE and it's related definitions
Date:   Thu, 18 Nov 2021 19:33:11 +0530
Message-Id: <55563bf4dfc5d3fdc96695373c659d099bf175b1.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Add a PCI_ERROR_RESPONSE definition for that and use it where
appropriate to make these checks consistent and easier to find.

Also add helper definitions PCI_SET_ERROR_RESPONSE and
PCI_POSSIBLE_ERROR to make the code more readable.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 include/linux/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..0ce26850470e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -154,6 +154,15 @@ enum pci_interrupt_pin {
 /* The number of legacy PCI INTx interrupts */
 #define PCI_NUM_INTX	4
 
+/*
+ * Reading from a device that doesn't respond typically returns ~0.  A
+ * successful read from a device may also return ~0, so you need additional
+ * information to reliably identify errors.
+ */
+#define PCI_ERROR_RESPONSE		(~0ULL)
+#define PCI_SET_ERROR_RESPONSE(val)	(*(val) = ((typeof(*(val))) PCI_ERROR_RESPONSE))
+#define PCI_POSSIBLE_ERROR(val)		((val) == ((typeof(val)) PCI_ERROR_RESPONSE))
+
 /*
  * pci_power_t values must match the bits in the Capabilities PME_Support
  * and Control/Status PowerState fields in the Power Management capability.
-- 
2.25.1


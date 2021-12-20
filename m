Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18947B0BC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 16:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhLTPzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 10:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhLTPzT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 10:55:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C61C061574
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 07:55:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAF7D611F9
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 15:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2348C36AE7;
        Mon, 20 Dec 2021 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015718;
        bh=oqc0GOf2gWxFxNbGatLX3dSDjwrvM0cZ3p6+/fjmhNg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XMQYOiXBjC4PIj6fEjkrSNRVSSNPEJvm4LJBUZ9w6B9xTbuJ9+BheBP3ooZL155mD
         ddpploF2g2RokTbQDRjNUqQ+jCmoUZb7CyUoITb7qZt6GgBxQoL0rgEjibXZcu2UYH
         LTj+qGCOuSmTf0yjcrhhCL1dSKqUmbFIk6LMqeukMbAdSdIDSLRRXSg8+GocFCUsMp
         Q6AdREteG4P9XdtnBP60Yrtgks6pIpMUFNZoG/7ujkW6nRIZrss20u5jBrRfwiHFTi
         UWqTIeFz+e0PwYhrEOZrPQRFOCpd422dIhDuVzwilzqxl3NSaWcJt/dCV+l7T11PF4
         WlIAEsa7vIhBg==
Received: by pali.im (Postfix)
        id 732D82860; Mon, 20 Dec 2021 16:55:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 2/4] lspci: Simplify printing range in show_range()
Date:   Mon, 20 Dec 2021 16:54:46 +0100
Message-Id: <20211220155448.1233-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211220155448.1233-1-pali@kernel.org>
References: <20211220155448.1233-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use just one printf() call with width format argument based on number of bits.
---
 lspci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lspci.c b/lspci.c
index 17649a0540fa..67ac19b61a29 100644
--- a/lspci.c
+++ b/lspci.c
@@ -378,12 +378,7 @@ show_range(char *prefix, u64 base, u64 limit, int bits)
 {
   printf("%s:", prefix);
   if (base <= limit || verbose > 2)
-    {
-      if (bits > 32)
-        printf(" %016" PCI_U64_FMT_X "-%016" PCI_U64_FMT_X, base, limit);
-      else
-        printf(" %08x-%08x", (unsigned) base, (unsigned) limit);
-    }
+    printf(" %0*" PCI_U64_FMT_X "-%0*" PCI_U64_FMT_X, (bits+3)/4, base, (bits+3)/4, limit);
   if (base <= limit)
     show_size(limit - base + 1);
   else
-- 
2.20.1


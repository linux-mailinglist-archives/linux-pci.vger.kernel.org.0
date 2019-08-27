Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF5D9F5F7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfH0WVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:21:50 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48382 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0WVu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 18:21:50 -0400
Received: by mail-pf1-f202.google.com with SMTP id t14so404769pfq.15
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2019 15:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wPnUIXwCje9aioFwSMDUTow4aP7pSBCci968MTKmxQQ=;
        b=DdqrFlgDVEKBQRVomjmwGlh+g1qgU4hmZKsta/aQ5aRsMW9z4MQJfZot5WL/rvHKT7
         iF5w+r1VrrTBp2XIwotbSYASAMLUhwb40F5Zg89vSzH08qYTkCJGvdDWOchP84tikp9e
         rSJgwWuDa25OB3hj7O8UvPBtF/GRkbhXhf36MipO/bcYKIEA1AqvtPMfgY23nmSSSUGj
         2U8gVr9i397FVT7pmFsp9L8p758k/uD+gh/7gGIlmR+3DNetyIKnVl5kuXerOQyOsnzr
         0YmfG839b3HE4F83Z6ShA4KYsUidQ2COKZMQA+54vkgN/qGZl9bodtCLF9qtELgdBiI1
         hI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wPnUIXwCje9aioFwSMDUTow4aP7pSBCci968MTKmxQQ=;
        b=gBpHf0lnxG5azocRwMi0RYQUWi+dujxKFxKkNBO3pUxrkVNRdVdSTTqzt6tekwQDq5
         q5lwCDfYulr8Jyazejd/X+v5CcVPNFilcI4U5usMOz8uJSrZy1Blo04+PLUzuheVZjV2
         m27+r6P6IlQ+Y1Wi2YQtui8vnV2afcZLpQVRUHg5uCn3b/YtN6KNjA/FxFy1xRtWwx71
         TdSAAmZtogedbwxxnnxprqUhNb08qFY0mWkRzpZZZUB8zJz39YE22IQtrVrXA5/grFMU
         vgR6xe5A9UvT90CuqtduFCyEU1s6yYCKuC/nldQ+MOwAJ70w015nWPd6GyBwBdHDelH8
         mCMg==
X-Gm-Message-State: APjAAAWofcKQKU1uNl0v9owQipo2fnI8o7WskQvvq9kdsN1qMd71jBXD
        fg+PP6io8R7CHL05VSzzv8CKtVbDE9bB
X-Google-Smtp-Source: APXvYqxtskkh8g9jAVNThHQtjXrbaE3Q7xH0UD9TjZRkMlkr+CxfWcD3QxLwidkiGXvaW+Vd2RCLr9hC0nhV
X-Received: by 2002:a63:40a:: with SMTP id 10mr636802pge.317.1566944509926;
 Tue, 27 Aug 2019 15:21:49 -0700 (PDT)
Date:   Tue, 27 Aug 2019 15:21:44 -0700
In-Reply-To: <20190827062309.GA30987@kroah.com>
Message-Id: <20190827222145.32642-1-rajatja@google.com>
Mime-Version: 1.0
References: <20190827062309.GA30987@kroah.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 1/2] PCI/AER: Add PoisonTLPBlocked to Uncorrectable errors
From:   Rajat Jain <rajatja@google.com>
To:     gregkh@linuxfoundation.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The elements in the aer_uncorrectable_error_string[] refer to
the bit names in Uncorrectable Error status Register in the PCIe spec
(Sec 7.8.4.2 in PCIe 4.0)

Add the last error bit in the strings array that was missing.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: same as v2
v2: same as v1

 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47d04fe..68060a290291 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -36,7 +36,7 @@
 #define AER_ERROR_SOURCES_MAX		128
 
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
-#define AER_MAX_TYPEOF_UNCOR_ERRS	26	/* as per PCI_ERR_UNCOR_STATUS*/
+#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
 
 struct aer_err_source {
 	unsigned int status;
@@ -560,6 +560,7 @@ static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
 	"BlockedTLP",			/* Bit Position 23	*/
 	"AtomicOpBlocked",		/* Bit Position 24	*/
 	"TLPBlockedErr",		/* Bit Position 25	*/
+	"PoisonTLPBlocked",		/* Bit Position 26	*/
 };
 
 static const char *aer_agent_string[] = {
-- 
2.23.0.187.g17f5b7556c-goog


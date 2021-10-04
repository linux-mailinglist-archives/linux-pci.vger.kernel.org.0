Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584D742116F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhJDOee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhJDOeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:34:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A7C061745;
        Mon,  4 Oct 2021 07:32:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j4so17495plx.4;
        Mon, 04 Oct 2021 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
        b=WJdx7P1TcAyVmEBiXMfx3i9JFf4eNjyW5Vq4oC9/fr/nJcEBpUnxCpI18WECXbYHf/
         KB0FXtM9rD6QyJDHR1zVnlxE6P4XVj8uhGsKSNaP+QdsP3oGBF7fsZcQGjOtCIGFAuZl
         8IyyhVKmRUEZzn8r6VE20PgzYSuV7j4ULaVauXMsqj3kjQetN3trtemqs1QXNMkPh7Ck
         rQEK80gn8TSK+com0w/V2PsVKRY3D5UyJNqo6SPhnAUSfeAhEDsOTWKWQ2ym4UnUGw53
         RLjTjWvlr9RUBdPDUiSj4Tqn6XWMh+eALMls0QIVsiNPuUn6GEDyb4kQ/aYbEJDb0fc5
         ORuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
        b=vH/ZyQsvtir3MgoDyrMwcOYReg2/ik6ewdvcfasnDRYJgV28EKniW8RWSwnAyb0Mt5
         OHzxATAVjsuf1eIwDqHt8G0xhpoZ8QBJkoDxujHB3CGRTVuD1u7LVys0VauZHUulmBwD
         U7ZdAGsOSNbOgb00WkC/zJgWjHrZgNNqY2pakH8N7GG9VcsP9tLnRsEn+tAf3MdlmJ9v
         knU8l/T92sr0ULj6jFzWW8KQsnJrQdMUG+J+Z+EvcA9UgGZqbxoisd6ZJqQCH6WIE0RI
         k0LsJ2VeHhPWNBdLkggkSTWscRWQdftrquUDyfcodU6OobpIwNMxJ7AG5XeSG84rHlqF
         2l9g==
X-Gm-Message-State: AOAM531WXGq5gLY3TDHaYH5hMBsXXTn0lo9lquObR2MH3TxvNkt30vZx
        tzvKabiDbTlx9anaD73qXzk=
X-Google-Smtp-Source: ABdhPJxtTQJnIxU5EdOGKPVOhIsZXoI5Jz8mKWOddwDBmK5s1XWXwrVNaKGUsgVKJPp+b6Hs3D14Jg==
X-Received: by 2002:a17:90a:1db:: with SMTP id 27mr37619533pjd.106.1633357961959;
        Mon, 04 Oct 2021 07:32:41 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id q3sm14489146pgf.18.2021.10.04.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:32:41 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/8] PCI/DPC: Use pci_aer_clear_status() in dpc_process_error()
Date:   Mon,  4 Oct 2021 20:00:00 +0530
Message-Id: <71cec6aef2535b48911bd98bd010012643eb0bd0.1633357368.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633357368.git.naveennaidu479@gmail.com>
References: <cover.1633357368.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dpc_process_error() clears both AER fatal and non fatal status
registers. Instead of clearing each status registers via a different
function call use pci_aer_clear_status().

This helps clean up the code a bit.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index df3f3a10f8bc..faf4a1e77fab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_status(pdev);
 	}
 }
 
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F9E422F06
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhJERWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbhJERWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 13:22:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91481C061755;
        Tue,  5 Oct 2021 10:20:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so123640pjb.4;
        Tue, 05 Oct 2021 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
        b=P+WtH3IMZqtUvBm5H9fMw9DkmxTpj9xDSJjyGL7A64Uyef7vOxtT1+71U5DwpJz9BF
         tFNkTjq14XrRxR35pQ2LG8xelzcnyqJOZeCllFYuLfBuYSQrS2XM5vb+amlwWQYvXML+
         bMoFMOoM+fQocWCzlMqISl30VSZGX7i4dvK2GZRUEVWmdwsjVZz9QkBz1ndtcGtG0QVm
         YqclJ9Y4OH1rQdMR2h4DfHgPPebH6E5VXsAg7UtWi17GKtsxNGIN3pu3NWgtOXbyMl8d
         Nqf8reqqrkiaDwGYfIyNTSfJ8gZcGkMYY6WUcBdrDnt62jpRuPfzrn7MrifNHc4tfwtx
         8O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
        b=SQSgfdoVXhgANMacZKBKZe07MGVry555XkkD800w5jNivx8JcrNeIayctON3sCWHIi
         OKgZwQED81/hjP1FnqxtVye4hHmHt7GIqEoPbAquuQw5sU85VUzoBYPq7uTMCMw26WnW
         sI8UKyWBZq0ZY9bebeLrJKmaweREYHsxVJl/EO6QCRlTSzUQWzpr17TZVDWFwU352027
         QgvA6kA3SiBgfuMxxvu91K1v4G1HujR4uY63fOwHv5OkscVMwzYtR9qa5ZL8vEv8BPV+
         PjwQ5VmbRXw+dCXpX3RW3x/KliTiXS8qEHRu3pEEd4GgSCfw2VrjgEm6AGNchdyY6wA/
         ZmtQ==
X-Gm-Message-State: AOAM530CbY21yvhdmlUcCn/wqMwWG8VjKg7hVbL6XGhXUpKTO9/e2sW8
        j/P2aCxqZFC5AEj1P3geAao=
X-Google-Smtp-Source: ABdhPJzxqc2t34kz5KgXjU7wEFsOAyUW6poe2t4eqVtMHyzkzQNDJDQfNcauVu19XLiaFPM/+9zQJw==
X-Received: by 2002:a17:902:b7c9:b0:13e:e094:e24c with SMTP id v9-20020a170902b7c900b0013ee094e24cmr5196351plz.3.1633454419116;
        Tue, 05 Oct 2021 10:20:19 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
        by smtp.gmail.com with ESMTPSA id f25sm18476722pge.7.2021.10.05.10.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:20:18 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 4/8] PCI/DPC: Use pci_aer_clear_status() in dpc_process_error()
Date:   Tue,  5 Oct 2021 22:48:11 +0530
Message-Id: <f0d301cb1245a8e2fd9565426b87c22a97aa6de7.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633453452.git.naveennaidu479@gmail.com>
References: <cover.1633453452.git.naveennaidu479@gmail.com>
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


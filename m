Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0838C439D01
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhJYRKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhJYRJ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 13:09:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616C5C04318A;
        Mon, 25 Oct 2021 10:02:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so11934765pji.5;
        Mon, 25 Oct 2021 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=N4v/A7+QJCcAbm+CvFlnlwM7C67m7YvUb7uDA62Ea6M2zy9mFn7L6qlzyseS/M/hvG
         tSJbimFBdC4p5RReqa2wpV6Qqjd4P24XzwxeLbj00xU7hcRRw5znumqH2s/fOHMfjSX9
         o5nd/AIPR73SqODv5t3sS3lZf5iijuK80MsyWyIw5o0FWX9YKrLpr3FlXwhqmXj9ObM3
         vPpoGZ6V4Jv4wDgtx2wXumflnIweN5T/qLoY7NBdAFL6pkNwLJgP04wR0lIKTa5RLweC
         RqPKrKht1tvRKs6JR6I7M00dsZt0Vx5DzJDUHy6IhLUn99V93sH7dP35x73mQfuyLXxC
         urFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=MFpHAdeurAEKW2EVweZpcP5VUcJdcBMyypn7siBqcwV7xscgnkfqE0SlGTe55+Q2wq
         /HviQ7WdYt304CCUULBKgt+P2NBCm/u8mp4zvbXnJBRVVC2I937L6lyTuzJccr8xc7k8
         Ubo8mNtJK+4UDEAmxhXvVZm6FVkM7wPl7SEbZN2yhy/JTpMYhX2TkoVTtOoNf42G37MW
         7VAo6YtpAgQtI1/sKGuQNBsAL0sXoHbzDpv+KjSEsDEg6xRVmtGDAU6LF67CGsCYRBaC
         RqqHQDnArX5ZEn5C9omRTSsZh6qrZzzgJC3W9FaB3UDsbFrTp+VxNGfRRVFpnj2UAvu5
         18Zw==
X-Gm-Message-State: AOAM530kIxnMOm4uCae57PV1J7R7Zzr3PdwbPNluLvdtvGqW5hAHZ93Z
        gLBNW0B/2w0d2ZE5i9Rxy6o=
X-Google-Smtp-Source: ABdhPJxPfl0ou0aD/UXHIs1Nj72QAYSTX4fl/euKCb4hAOQJajxyiu9l4DhyC9t/Ht92fYZ9ThIeJg==
X-Received: by 2002:a17:90a:fe16:: with SMTP id ck22mr12789728pjb.186.1635181336216;
        Mon, 25 Oct 2021 10:02:16 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:df8b:7255:8580:2394:764c])
        by smtp.gmail.com with ESMTPSA id g18sm5100858pfj.67.2021.10.25.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:02:15 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 2/5] PCI: Cleanup struct aer_err_info
Date:   Mon, 25 Oct 2021 22:31:01 +0530
Message-Id: <10d354c32e7517ad16e9f37bd4595de83dd7ccbc.1635179600.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635179600.git.naveennaidu479@gmail.com>
References: <cover.1635179600.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The id, status and the mask fields of the struct aer_err_info comes
directly from the registers, hence their sizes should be explicit.

The length of these registers are:
  - id: 16 bits - Represents the Error Source Requester ID
  - status: 32 bits - COR/UNCOR Error Status
  - mask: 32 bits - COR/UNCOR Error Mask

Since the length of the above registers are even, use u16 and u32
to represent their values.

Also remove the __pad fields.

"pahole" was run on the modified struct aer_err_info and the size
remains unchanged.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pci.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1cce56c2aea0..9be7a966fda7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -427,18 +427,16 @@ struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
 
-	unsigned int id:16;
+	u16	id;
 
 	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int __pad1:5;
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
-	unsigned int __pad2:2;
 	unsigned int tlp_header_valid:1;
 
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
+	u32 status;		/* COR/UNCOR Error Status */
+	u32 mask;		/* COR/UNCOR Error Mask */
 	struct aer_header_log_regs tlp;	/* TLP Header */
 };
 
-- 
2.25.1


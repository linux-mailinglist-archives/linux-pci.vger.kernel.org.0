Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA14210F5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhJDOK1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhJDOKZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:10:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D06C061783;
        Mon,  4 Oct 2021 07:08:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 133so16665225pgb.1;
        Mon, 04 Oct 2021 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=E+TFvkLSQJvOplJzbRd6c4bA6eLdXlCzyriCZA5Wqc5TF+e74RZsBLXqc+tXDXAo/q
         UT8xkQl/rR1/w3AnnhPL/CbF0ZIkA/LvQ6x6fuWClo9NoC4MJwQXx0YQhvAs5AaXZf/I
         qkoxe/YLVKpRnpMmU1vZUjYBdXK5GaAJn1g0qNajQ0H5Dom4MkRP2/ffU1Y2vqx6hmhs
         EJcNuEt7Rfc6ie3j7rn6pJHwM8SeyKzzZPY87cBOiVYdWOY3FAeNnddsOtEJc5Cwm7rm
         fJQVevf8GK/Lm14YRbw5ihnNv7QdHEn1R2+B/FhHolky0LEd05k0bvAmqWrQZ/0+rwjS
         rSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=QFMZCuu5bh6JrV1XRQgS61alA86YntT3b3zZdyPWQPAFB9THwaDGLUK/ZUDVMy4lvy
         rEOp3qtcb7DaiAgLL+GoKIELCQ5V4oLvWBi8+fAAsMTxlhrZq9q4eMlcJgT9PvvBnXtp
         mhlRZr22T0/6zbBp/L5X7fmV9miZDjuTikwoeJDVTeWzkhIpJgjBHW0gix9nU7+94bs6
         l2x8cxuS9To4SeO3NjG2pcw8mXqoNmNFUcr9F6nleC/t3M8nLxrtQtiYMR3uW9/saNy0
         nMoDM3D3I/vCq8RakMrFdz38ys+qI9bjUiQsUCnNcQwWCeYXz/B30CC5GFntuFcssUXG
         WpiQ==
X-Gm-Message-State: AOAM530OnSDnAdYHf2rJSzy7kcjGpx/JJpgX2vHCpRJC2Pm2yAWwCUs4
        1aiBBRWjdnOke/1vId9DLEY=
X-Google-Smtp-Source: ABdhPJyck3KTFEhO5ILC3yxxjpAI2DOPtg7DvJQM0OSyr64tht7atYOar8FVU3irGbi8qaG1HdUo1A==
X-Received: by 2002:a63:7543:: with SMTP id f3mr11075085pgn.449.1633356515744;
        Mon, 04 Oct 2021 07:08:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id p2sm15274135pgd.84.2021.10.04.07.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:08:35 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/8] PCI: Cleanup struct aer_err_info
Date:   Mon,  4 Oct 2021 19:36:28 +0530
Message-Id: <247efb0e4168393f4aee5e267a9aa8b3a8adff0f.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
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


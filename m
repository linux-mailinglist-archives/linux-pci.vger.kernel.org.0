Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1619D421162
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhJDOda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbhJDOda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:33:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D038C061745;
        Mon,  4 Oct 2021 07:31:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so115541pjb.1;
        Mon, 04 Oct 2021 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=qv8zIopXqjv7B/cSRZ3wFwRISLoio93IP+EmFxrBZNfRmhYbTplZEVW9dbeqkXSexO
         xC3ATUpxmJRydYGgHKT3jX9RRk2qOU7MqZ9BmxZ6Y3BlGHKqMrtbglNX/7S3JP+vJVNU
         U3qE9ecrnlJ5AaPehV0/Eud3IiTAY7+4moUA9fpjiLZjPLT92K24ftq6+UvV2j5Lovtd
         tqH2P7rgEp32UWbjhvU8aMXRoDyzlxgoq4DkDk/g6hBpL/LgNHnzh7D4kCZjvD9R7RYq
         yHs67pCK6OfFDCdXNQDTate3xFUKIr+gHHSHRPSOFAa4I1B0hh4WRKbU4PFzYDYT26Fl
         LsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=yYM6/e1b8+MzyXeu9gsND8Oj+E6C4e0o0Ms1+SK+uzfq1pQE6gvh2FYTIdyJ1duyAT
         XFGjEq/9MA2L74B5JpPUmsQBSTVL/Zrqpkncv0Rp6TiJaoZfBoKqT+VBfKbd7ScFF/xU
         HfBmEA06eZVaZNft+Nq6VT92Byco8BFJ97aUxk+dY2fWm4HjKyvPJ4cQ1kWFziYT2PnB
         Np4LkpVJIUpzvlH2tdHEVW5lH6ceLzSnnbQEwJW2T3HzIA5SJqELREgKnaENwRGwmz8O
         hf7A84Yd09jKx9syBdpEbZ9/VP+Z5XE1BHQw/vCxz5hf2CnUyrH2oYvAapXCiBv3GLBP
         Pv4Q==
X-Gm-Message-State: AOAM532JMnDOuiW2SOPZCpaa5I7KUXkK1EmNSrtmzZ44qrA4YBllA3Mp
        ni9MrMljjIie4HCC6kQIMYU=
X-Google-Smtp-Source: ABdhPJzR4Ghi3JFA5L9/8cvKQIXgFoRIAEnS77Xg6YAAEkbaN1BHaaNb+r1kBF2MKHApzqX5Ds9q0g==
X-Received: by 2002:a17:90a:f287:: with SMTP id fs7mr9466092pjb.98.1633357901102;
        Mon, 04 Oct 2021 07:31:41 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id q3sm14489146pgf.18.2021.10.04.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:31:39 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/8] PCI: Cleanup struct aer_err_info
Date:   Mon,  4 Oct 2021 19:59:58 +0530
Message-Id: <247efb0e4168393f4aee5e267a9aa8b3a8adff0f.1633357368.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633357368.git.naveennaidu479@gmail.com>
References: <cover.1633357368.git.naveennaidu479@gmail.com>
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40C422F00
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhJERVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 13:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhJERVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 13:21:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E5C061749;
        Tue,  5 Oct 2021 10:20:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y5so2777220pll.3;
        Tue, 05 Oct 2021 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=A71fO3tGGjwz+OnHBY6HhMFyXvWq8AS2PEZEnxn0QPthRZFnOLoiXs4GRkH44Fgdpl
         BCtSZsHnbMw+J/VBXutV0WFpyIh6lu9NnI7mlhc899K/fsgBufh5I5Oy5T+x6kEUwQT1
         P2O6Wt+F3bQOVRQayknlFt8VAXQCCJfG7jOBXgT+a9jEe+6Z251sGpvTCQajheWVGtiF
         TyqLt0U4e6fqJEcotNV7OM45+WmP0HTFw7QCuORT/mLLLLEcFm/GWJ3rej0agW1LW175
         d1Fnbb6vpOY8V/3u6Say7gT9+ej81ABLd+flMzAlKo1hUBgPyn5dtAR/zVNKWLwEmG2M
         jDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=Grt/vnvranbqHDuiZjjIdQELyplgNWS3ZhNZdqkXkHziTlwfAgmRPn1SIfz+qXvSyy
         3DdCfufpGAfUbHjlq40z8RPc5FVPf1yY6G8elw9bG2zvrK6ztZl2uuNLE+Ri9cxMp0al
         vSsTtnT0vU6nA1dOLaHSTcDWpNn6KMfD/dOTled6wN50uRKgtqVKGhBrm/HbCSNEVogF
         XOisX2zE2IOMopCGzGZGs6NSt/Qfhz8t2a9pRXMzmb73dQcBY3QjBqrluLEWn9icKZqf
         yVZYID5mLRRKgYsusLowkff6z80vg6lm/it0UsXOLOYDRRIDJLhoOb1UPBaly9WmAm0M
         fr+A==
X-Gm-Message-State: AOAM530rwPBaM5c+yfV8EsavRe0rJGbgE9p75v7tG2x7hVDoYcn9SWP2
        2V03kh/JqFjFOSiEEJiZ0F4=
X-Google-Smtp-Source: ABdhPJx6mC9P6YQA9us0MGZNTH690yOdvv8Qd05OPcQYLlWaJDLvVp/f+i52bWzPefweCBqHH8+YGQ==
X-Received: by 2002:a17:902:b093:b029:12c:843:b55a with SMTP id p19-20020a170902b093b029012c0843b55amr6271410plr.83.1633454401296;
        Tue, 05 Oct 2021 10:20:01 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
        by smtp.gmail.com with ESMTPSA id f25sm18476722pge.7.2021.10.05.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:20:00 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 2/8] PCI: Cleanup struct aer_err_info
Date:   Tue,  5 Oct 2021 22:48:09 +0530
Message-Id: <a6f477dec0700f17933be993897114a7d7a5a282.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633453452.git.naveennaidu479@gmail.com>
References: <cover.1633453452.git.naveennaidu479@gmail.com>
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


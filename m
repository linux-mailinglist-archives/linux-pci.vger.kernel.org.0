Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA85542967B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhJKSJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhJKSJG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:09:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4481C061570;
        Mon, 11 Oct 2021 11:07:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so57820pjb.1;
        Mon, 11 Oct 2021 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Avo3ZmMmZNUWQ5EbnH2gCv75rJX+nPxKzCshM1jhNkE=;
        b=XU0Bm06oTzc+kDweoSZWKTbZfXcxYBFjbb2qZj8hRUwUobVINapWvCas7dpwGUvfJw
         mWUNs+I0hl6vjawT8/YGO0XgeEm5/hcFVB51PzhCXf8W2CtwjsOipckWUa9jM9v1CWzy
         0dObet2/YKK6sF+5gpqKjS1jVe/JGQkj68mDql1vadeAHRW/Yb7WWWKE0fok9AjTyKGh
         Mgg/WwCADP1DEZArTnttZRNK4sjc+mANaJMit16c+wPAQCGmHTc/EMqcXDwnKKlwP3lF
         5d5lpFmUEyU3rDeePMURYjan/efqJZCUN+4IV3Y9FYQGKS/SYT8umlXOkXxEGFJdXaHP
         tziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Avo3ZmMmZNUWQ5EbnH2gCv75rJX+nPxKzCshM1jhNkE=;
        b=Kfsf1INaykhO16YUeEPFCYthxby5IMG+kyOdt95lXjOQW8+UQZgA9OIq+llojf15vw
         yIVqshYzndCVc58XVTEXdH8UDJ1zqtysW9Mc4TU4ixmp+h/10If44lsJXOiHVFXgTD4q
         J5i7/1eMeAB8uBW/pJBMUTd8J2qOuFL6P8qwZheE+41LOQ6ByF2vhMHCZMHDkX3U0Uyc
         a6Fcw56MrThFL1UqdfBvRaIF6xwrV/2uPpYcsecnZsK4hmftzaINUxp2zOdx1JBZK5SM
         4eNohZanAj+faFf09e8h5EL2x4bdJTYaeWqXc7DxhxFmlwN809CK5mBqw8CJB85a5pxi
         MM+g==
X-Gm-Message-State: AOAM530TCNfjSMTfCzX6PG+RjjqT8RX9SDf48xpkUORtrZVQ4Vr72QhS
        ZHQMf00n0Ley6U/vju4x3JE=
X-Google-Smtp-Source: ABdhPJwblQisXQhgJ0cSa+0Jwyf/uAjHurg3rsbuIqTqyFI+rOTVSPKbf9K0BLqq7G3V4PNEt65PtA==
X-Received: by 2002:a17:902:ed0b:b0:13f:4318:491a with SMTP id b11-20020a170902ed0b00b0013f4318491amr4577255pld.4.1633975626234;
        Mon, 11 Oct 2021 11:07:06 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id m28sm9020677pgl.9.2021.10.11.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:07:05 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 15/22] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Mon, 11 Oct 2021 23:36:38 +0530
Message-Id: <84ab7a23647e0673d99a8cf59e9c89af9b862354.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a5987e52700e..db81bc4cfe8c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -538,7 +538,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 		int ret;
 
 		ret = pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
-		if (ret || vmlock == ~0)
+		if (ret || RESPONSE_IS_PCI_ERROR(&vmlock))
 			return -ENODEV;
 
 		if (MB2_SHADOW_EN(vmlock)) {
-- 
2.25.1


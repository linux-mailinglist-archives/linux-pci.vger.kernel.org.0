Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAB44295DD
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhJKRkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhJKRkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:40:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F76BC06161C;
        Mon, 11 Oct 2021 10:38:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y1so11767872plk.10;
        Mon, 11 Oct 2021 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTDymu/kK4gMRJAHOJpsOJeHyCsZ/lww9DjrtPbDpJ4=;
        b=HwHRRV+S/RE+GIDbxexsfa91uds8RaTJQMPwbLhyAkzd491qats0xSsaC4mhiRl6Jq
         gXXjtWMCRFCl24UDsqtfCnqLD1Cbtd/93S7HO5AgB4ueGG4bEHV+hcSl1HJMqS26/8sA
         AKDOYmV4WnzsAqwxPmP3185eWqTzwnWRl2QPIf3ODwukpfqNg79k8CXYXbmjBmwmlM7H
         JLjBNNDOGJ+Mxf3ToELn+xPiqYpbj9hM9X5kn0apcvp1wMCYCAV20W1pQqigoIPr8oqY
         TGxAUPwne4Rec2JXIdYu17BaZHyNtS6uIqjuojEWOKeCG+TbAaPT/AAhWcUg9ysN4hhq
         wH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTDymu/kK4gMRJAHOJpsOJeHyCsZ/lww9DjrtPbDpJ4=;
        b=pEySNMGyfKN0LhsuGrEnaujwUsG5yy6keiiDjkenRyt3junaA3t6EcHB56bVO7oMwO
         0fb2kE434Zw9nkXAY7/mIPsVxmJoqo5S1AGtZpZAUBiLv2vi/Vb+HAzCTh20wXnOGpqC
         r4zif068qL9Yq6zL8DsYMHBvJciETqaWZfNHr3uBAfi4dpfVvk/TbPShtKh3+cqrArtC
         o1a/K9al8UtgA7R53YZYeQKbn5U6d4JPG4rz059vRD+UM2WjLZmWtT+/UIH80WCPFEm0
         1wygVF7NXAbu9qlbcaklqLDeZnEqgXdQtEmrA8XDJweoqf6vUgGylV6HlXmSqCe8+uTZ
         930Q==
X-Gm-Message-State: AOAM531MbS8/QzG1i8jH5G3lMUkVTy/ddLFaUTtkmAAAJ2r9HbjuTUZ9
        hdYAxTIT6a72KSJFGt0nqfo=
X-Google-Smtp-Source: ABdhPJxEBdoXamrVCKeesJUkEsfNWnP0PDrt34jLeyC7FqCvn2xqaY1LwruNHL9Qwq4e9o9alifRPA==
X-Received: by 2002:a17:90a:67c1:: with SMTP id g1mr335114pjm.177.1633973888608;
        Mon, 11 Oct 2021 10:38:08 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id c12sm8456919pfc.161.2021.10.11.10.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:38:08 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/22] PCI: Add PCI_ERROR_RESPONSE and it's related defintions
Date:   Mon, 11 Oct 2021 23:07:53 +0530
Message-Id: <5b4ba38fa56c7625d391383a3aed47dea6726946.1633972263.git.naveennaidu479@gmail.com>
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

Add a PCI_ERROR_RESPONSE definition for that and use it where
appropriate to make these checks consistent and easier to find.

Also add helper definitions SET_PCI_ERROR_RESPONSE and
RESPONSE_IS_PCI_ERROR to make the code more readable.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 include/linux/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..928c589bb5c4 100644
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
+#define PCI_ERROR_RESPONSE			(~0ULL)
+#define SET_PCI_ERROR_RESPONSE(val)	(*val = ((typeof(*val)) PCI_ERROR_RESPONSE))
+#define RESPONSE_IS_PCI_ERROR(val)	(*val == ((typeof(*val)) PCI_ERROR_RESPONSE))
+
 /*
  * pci_power_t values must match the bits in the Capabilities PME_Support
  * and Control/Status PowerState fields in the Power Management capability.
-- 
2.25.1


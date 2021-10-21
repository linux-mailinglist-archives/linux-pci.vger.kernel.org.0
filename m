Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8CC436532
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhJUPMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhJUPMe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:12:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CCC061348;
        Thu, 21 Oct 2021 08:10:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso781421pjb.1;
        Thu, 21 Oct 2021 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szm9mPrVF9g7VHjr68cY48MjU0fXHj5hkhxS0Uhiec4=;
        b=kzhKz8HKnq/yurgUnRRmdMnpoO4/E0k9gxB0o6nvZkLULxDO/GXx/MQ04A4PT92FZ1
         fGMd51fYe7BJJomc6FYPAhwkSJFS+5njkw33/E4TIiIkQoZrPJ7HEzZsbiOLaz28kbju
         sYjWzeIr1owBkBsMQRiYSiissNBK0MhsxWMadZlUsbqzUctoqzURKC8Qjxvfb8+ZfmzT
         rGtm3yAMC0z7Fs3AFOyuk0RAvdNarXTjk4G4e2l+GVhhzS2x892CfRbvf8H70szLOkx2
         E3V5M98AYF9SrcgGsJOG7OAZPAy2TTdHAb7DSeiYO82oiXtqtYbl82JDl4HjQPHm7LQE
         evpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szm9mPrVF9g7VHjr68cY48MjU0fXHj5hkhxS0Uhiec4=;
        b=HQNepnpzmm4yiYUQhCUcNdy3S4unfYqj3jomrhjsW/TtBylvYMWZvThALknY6w09Mn
         u4I1kMZCM7rAbaVB/XFSXf+Kz9w2MkVJqec4hT5hPF1sw+gttjpdkhZUteLTO/XAc63K
         vC75NmKzSNcj9VS3mD14yQT+mWkhn2XgfD+AIr7+5Thae0+Q/HSGvalIW7kBmaez90Dj
         mfHc4FV+/znk2Rpyce3E9ZxDTJjExTj48QxrnxX+jcYDDQFF3io+jRFUPtL2VSzDO3cF
         goTD3F9SAN0Mi/yZFqgBgu7pissO8u3bJSWMqlJOVaH+VeQDdEsRe3fNNI3oCJufCkDv
         cuKQ==
X-Gm-Message-State: AOAM533LIqz2NaqDFzCn4DPW5xlUNUJZWGmkAN9g+nhQ/ZB4Vssu1i2j
        spsEgjgb16Rrso+veIZ8Wv8=
X-Google-Smtp-Source: ABdhPJwVrzLwzW5dNVxm5WaGcslw2IFkRx5KjyYZwwVA7XYHIn4ISCyJaDYSwbRx4bq3u4ZOxnFu2w==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr7327842pjg.202.1634829016181;
        Thu, 21 Oct 2021 08:10:16 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:10:15 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH v3 03/25] PCI: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Thu, 21 Oct 2021 20:37:28 +0530
Message-Id: <70e5763e4aa58876a7129ac3ccf600efd27162c4.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 0f732ba2f71a..a6bcbad04d89 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -529,7 +529,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
@@ -539,7 +539,7 @@ EXPORT_SYMBOL(pci_read_config_byte);
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
@@ -550,7 +550,7 @@ int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
-- 
2.25.1


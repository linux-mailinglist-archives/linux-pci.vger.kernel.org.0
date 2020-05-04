Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9078F1C3287
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 08:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEDGSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 02:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgEDGSa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 02:18:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CFCC061A0E
        for <linux-pci@vger.kernel.org>; Sun,  3 May 2020 23:18:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so14308593wra.7
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2020 23:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WclkHowIn1eEFLPIX8/qTgQi4T5DsnmjpScbqAksDNM=;
        b=g6Uje93L2ADOfNq4pmMdT+5ZI0cO7fZeRWCsFL4JIST09bl0B4wnxSWLjB31YSrF6m
         oPjZMmaJIeT7aan1WWIyhcrVn8MXWefHvPQcSePT3A0X5ZrGcb5zNm2AzCuiUwBYp41w
         NKggLXoBMW5H/9JiVFHXIAkJoimP9nC4XpTZijwUXJVzK1pE97TfK2eS+Z5B9hMsC0ft
         dNV00q4lzkEcwGRo9IbOuWCitmYEgEJzuNj5uptz3Nv4AQ4/e8WiInvvWtqnTBkkyRWG
         A28qs3LvQ2mR1U5Psp9m4L7cmqEQAsBHKDhqELihPXdAp/FYbG24UwqemooSIc+sT/pk
         8A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WclkHowIn1eEFLPIX8/qTgQi4T5DsnmjpScbqAksDNM=;
        b=hlRp+rJAvbGTExkoGm/WjcxcMY0F1I+e8DOdjBgLnv0xm/zbkXELbcmiwOFnnMeGUN
         5dPWt1UNUZzwYM1KbGY2GOnDjebINnOk/GdmEwgkKK7dMcEOZ6pgU35argTulPDb7UEv
         nB4ZsHkR3405k5UIEXxgckA5xq6PgykYnOGVlEijkZBkBNZGoj2/5e8NVtU3beJjGxbe
         yf/IcPhKtLni8iAv9Is3hLxaA0JRP7z/d6BMgpvzR5ESwa9ROb8fTAPF6cT+EBofMk+K
         uTa5b58ovRa18GZOtR1t/86lpWKxoed5M+Oo8+YY4uUyG7XmYgzTmXi08pjNFA/zIeMV
         Fhsg==
X-Gm-Message-State: AGi0Puan9SPFFKXZAJqIBALn7/BACsC3txd8qi1Pr1RLovLehD5AGiT9
        T/0GjPgXgW6U8QrjMb2QmNTpRBTbMoGltg==
X-Google-Smtp-Source: APiQypKyIv0tlwVvPhhyvhsHX7VKgIJcx1piu6dtkImNtCdsR0Wsfb9R/LM8ocur4I0o5TkFilflIQ==
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr18388015wrq.358.1588573108741;
        Sun, 03 May 2020 23:18:28 -0700 (PDT)
Received: from net.saheed (540018A9.dsl.pool.telekom.hu. [84.0.24.169])
        by smtp.gmail.com with ESMTPSA id k23sm11559004wmi.46.2020.05.03.23.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 23:18:28 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, yangyicong@hisilicon.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: [PATCH RFC 1/2] pci: Make return value of pcie_capability_*() consistent
Date:   Mon,  4 May 2020 07:18:11 +0200
Message-Id: <20200504051812.22662-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504051812.22662-1-refactormyself@gmail.com>
References: <20200504051812.22662-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pcie_capability_{read|write}_*() could return 0, -EINVAL, or any of the
PCIBIOS_* error codes. This is behaviour is now changed to ONLY return a
PCIBIOS_* error code or -ERANGE on error.
This has now been made consistent across all accessors. Callers now have
a consistent way for checking which error has occurred.

An audit of the callers of these functions was made and no contradicting
case was found in the examined call chains.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/pci/access.c | 64 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..10c771079e35 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -402,6 +402,8 @@ static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
  * Note that these accessor functions are only for the "PCI Express
  * Capability" (see PCIe spec r3.0, sec 7.8).  They do not apply to the
  * other "PCI Express Extended Capabilities" (AER, VC, ACS, MFVC, etc.)
+ *
+ * Return 0 on success, otherwise a negative value
  */
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 {
@@ -409,7 +411,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 
 	*val = 0;
 	if (pos & 1)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
@@ -444,7 +446,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 
 	*val = 0;
 	if (pos & 3)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
@@ -453,9 +455,9 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 		 * have been written as 0xFFFFFFFF if hardware error happens
 		 * during pci_read_config_dword().
 		 */
-		if (ret)
-			*val = 0;
-		return ret;
+		if (ret)
+			*val = 0;
+		return ret;
 	}
 
 	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
@@ -469,7 +471,7 @@ EXPORT_SYMBOL(pcie_capability_read_dword);
 int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
 {
 	if (pos & 1)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (!pcie_capability_reg_implemented(dev, pos))
 		return 0;
@@ -481,7 +483,7 @@ EXPORT_SYMBOL(pcie_capability_write_word);
 int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
 {
 	if (pos & 3)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (!pcie_capability_reg_implemented(dev, pos))
 		return 0;
@@ -526,56 +528,92 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
+	int ret;
 	if (pci_dev_is_disconnected(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
-	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
+
+	ret = pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
+
+	if (ret > 0)
+		ret = -ERANGE;
+	return ret;
 }
 EXPORT_SYMBOL(pci_read_config_byte);
 
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
+	int ret;
 	if (pci_dev_is_disconnected(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
-	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
+
+	ret = pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
+
+	if (ret > 0)
+		ret = -ERANGE;
+	return ret;
 }
 EXPORT_SYMBOL(pci_read_config_word);
 
 int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
+	int ret;
 	if (pci_dev_is_disconnected(dev)) {
 		*val = ~0;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
-	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
+
+	ret = pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
+
+	if (ret > 0)
+		ret = -ERANGE;
+	return ret;
 }
 EXPORT_SYMBOL(pci_read_config_dword);
 
 int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
 {
+	int ret;
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
+
+	ret = pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
+
+	if (ret > 0)
+		ret = -ERANGE;
+	return ret;
 }
 EXPORT_SYMBOL(pci_write_config_byte);
 
 int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
 {
+	int ret;
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
+
+	ret = pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
+
+	if (ret > 0)
+		ret = -ERANGE;
+	return ret;
 }
 EXPORT_SYMBOL(pci_write_config_word);
 
 int pci_write_config_dword(const struct pci_dev *dev, int where,
 					 u32 val)
 {
+	int ret;
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
+
+	ret = pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
+
+	if (ret > 0)
+		ret = -ERANGE;
+	return ret;
 }
 EXPORT_SYMBOL(pci_write_config_dword);
-- 
2.18.2


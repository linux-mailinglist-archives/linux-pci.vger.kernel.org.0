Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1761C436592
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJUPQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhJUPPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:15:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C719C061239;
        Thu, 21 Oct 2021 08:13:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so579960pgl.10;
        Thu, 21 Oct 2021 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LKQ8LDQCLH6CNvMc2EuzCtN+mwerjwkO6CrMvPuNtM=;
        b=oCM89KnePSBKcy6kffqfID2nl/IafVElh379aYNbnhSVPjR/XU8OAJmQGIsU1XiOsM
         Pc8vcBL8x0zsObp9BqaJut35pC5eqUIZTdw/ZkMv0oULb4PgYl/twh3esle884EXCvpj
         zXe7Jir243mgAfmy0RbhQpuCzePGsE25KGsTYlnNxmGImKUyywSdQB6gEZZUEPQQGEVf
         xAAJUIeSZGwEikgZR09/wVbUNzJuoSKof+ogQhnqaJ+Dq65ndV5jxg2/SAB9tneEVKLf
         ZG5zjxKNZplXTQRWdr68P2CR2s4APH6S9zX2Aaqc2zOyqd+EXXDnWUdPgaQjg49Qx8SB
         Pp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LKQ8LDQCLH6CNvMc2EuzCtN+mwerjwkO6CrMvPuNtM=;
        b=iN2Cr+HILSVXz4A3gnQPN904iKoP9a+qowq00dWr3q6KvY6pJ+eL5qrBfCEIqwRpss
         o+4qnrenVjRtE4p3+nBFU/2JLEgavBHgTxL15/zfBzPuKH7V2HO8l18T4DfdxcE1kDTr
         nv6Re7SpC/dPocPIBt18xy3O9317kBykBjk+IUVDTwVEUy/aXicA/QcqFJAHFAZO+SV2
         l2ul79FvQk1oNXtIuyk6vHVoaS0LvV9JHv3jhxcVViznTK9CZyzB5Vh0FlczFEQXTgTd
         YCi210qWw5817z1Z0VgLWFM2JDznw+y8VvgP7yoDCG4dVALOvXsEAr5EetwPuE1V3Bm4
         E1Dg==
X-Gm-Message-State: AOAM532Nra3cb5GXi4slq1emGjImE+aSTJiUaUfKtdzSbpy3QNhSJcs/
        iaZx39TVpFnFm9KrSv5tQmvo3LcmrlhxnEVs
X-Google-Smtp-Source: ABdhPJxznvgzZqfYWIDGri2iQZkrb65SSVK3bkT6SK4TKqrHIaofGr/C5IMiuCQcc4kOLZls5+zaAQ==
X-Received: by 2002:a62:2c82:0:b0:44d:71c3:8a3 with SMTP id s124-20020a622c82000000b0044d71c308a3mr6267013pfs.84.1634829196915;
        Thu, 21 Oct 2021 08:13:16 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:13:16 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH v3 16/25] PCI/ERR: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Thu, 21 Oct 2021 20:37:41 +0530
Message-Id: <50db352f97df56d37f3af99c8999d6136436aaba.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
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

This unifies PCI error response checking and make error checks
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pci.c   | 10 +++++-----
 drivers/pci/probe.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..4eaf29f004bd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1077,7 +1077,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return -EIO;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	if (pmcsr == (u16) ~0) {
+	if (RESPONSE_IS_PCI_ERROR(pmcsr)) {
 		pci_err(dev, "can't change power state from %s to %s (config space inaccessible)\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
@@ -1239,16 +1239,16 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	 * After reset, the device should not silently discard config
 	 * requests, but it may still indicate that it needs more time by
 	 * responding to them with CRS completions.  The Root Port will
-	 * generally synthesize ~0 data to complete the read (except when
-	 * CRS SV is enabled and the read was for the Vendor ID; in that
-	 * case it synthesizes 0x0001 data).
+	 * generally synthesize ~0 (PCI_ERROR_RESPONSE) data to complete
+	 * the read (except when CRS SV is enabled and the read was for the
+	 * Vendor ID; in that case it synthesizes 0x0001 data).
 	 *
 	 * Wait for the device to return a non-CRS completion.  Read the
 	 * Command register instead of Vendor ID so we don't have to
 	 * contend with the CRS SV value.
 	 */
 	pci_read_config_dword(dev, PCI_COMMAND, &id);
-	while (id == ~0) {
+	while (RESPONSE_IS_PCI_ERROR(id)) {
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
 				 delay - 1, reset_type);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..8bf4034ddbd4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -206,14 +206,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR, bit
 	 * 1 must be clear.
 	 */
-	if (sz == 0xffffffff)
+	if (RESPONSE_IS_PCI_ERROR(sz))
 		sz = 0;
 
 	/*
 	 * I don't know how l can have all bits set.  Copied from old code.
 	 * Maybe it fixes a bug on some ancient platform.
 	 */
-	if (l == 0xffffffff)
+	if (RESPONSE_IS_PCI_ERROR(l))
 		l = 0;
 
 	if (type == pci_bar_unknown) {
@@ -1660,7 +1660,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 
 	if (pci_read_config_dword(dev, pos, &status) != PCIBIOS_SUCCESSFUL)
 		return PCI_CFG_SPACE_SIZE;
-	if (status == 0xffffffff || pci_ext_cfg_is_aliased(dev))
+	if (RESPONSE_IS_PCI_ERROR(status) || pci_ext_cfg_is_aliased(dev))
 		return PCI_CFG_SPACE_SIZE;
 
 	return PCI_CFG_SPACE_EXP_SIZE;
@@ -2336,8 +2336,8 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 		return false;
 
-	/* Some broken boards return 0 or ~0 if a slot is empty: */
-	if (*l == 0xffffffff || *l == 0x00000000 ||
+	/* Some broken boards return 0 or ~0 (PCI_ERROR_RESPONSE) if a slot is empty: */
+	if (RESPONSE_IS_PCI_ERROR(*l) || *l == 0x00000000 ||
 	    *l == 0x0000ffff || *l == 0xffff0000)
 		return false;
 
-- 
2.25.1


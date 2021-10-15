Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8777842F603
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbhJOOru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240736AbhJOOrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:47:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C514C061762;
        Fri, 15 Oct 2021 07:45:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v8so4408854pfu.11;
        Fri, 15 Oct 2021 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wg9CIjlvFpQ0mVyLruVXTyXRfH69nmtxShZyyO67k10=;
        b=O4C9zYJL9l7EbrlGSDp0OOYmbfrQI/mk7hKB2KetLAfTJkrzFPw/c64gcGjsOAg/gS
         XisYpdLBtUdscG4+zLFIqn84JjKco6cDb3F70hnPwsx4kPYC84CdTP6IGTuXohsBXQn6
         gM8iJy7Qdmuy3rI16l9MgKjozQXgOxJepwN9ZHaDjPSmwyX2mfK/CnxNmWqc0nYK1+Gw
         Vionef2tPDP17XYMqXM2N2ATJwtpPWgr1nGPNBkW0HT0ecGB3nObThlDWfpb/8sWHyVU
         yrFOp0FpZgJcuwXofxQ+qSkUD/OLZ1nfxhte3aeIdRCmGwHQa8I4M3Ba3Lm8PCBKisx2
         L35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wg9CIjlvFpQ0mVyLruVXTyXRfH69nmtxShZyyO67k10=;
        b=PltK+d3QdTwzDYyfqJSMJHvYHdRj8l6ihzLJZc5X68DoMUPt8oJxUskrophHWQ7Mq+
         GmQEkCQuq72rmdST5QBzz2ldglfIE7yTCyNA7jgc4J8nRKPWWfpZQAgXIjo2nqptbsOM
         HAjbGtu8685LLdI0/PJatFbgzBk+eYUs7Y2Li9pKVaX3B5LJv8Cjkm8mU8ZcLl14fyHi
         4OPfnnSmg7zZQIWYvAaR91nvj3+KW9XH0M1ip/cDAKcLeWuNSB6HDKXeSRFCv2ZUvEFY
         LPidVSKHjdTizvUPKq4MS02C9tEzRvdGW5Mmr/EtrRm6QZxyIrxYttnJrF3MHgCjdJRV
         HasA==
X-Gm-Message-State: AOAM531IZMMWMTK1Z1J7nYFShg/euy9ER9O5SOV9IKThXGGybyzwjPWI
        2UuP9+PH3EkNk188P8KMScY=
X-Google-Smtp-Source: ABdhPJzVsujjyhtu4qdgTMOPdGHq2Omqc8DYqIdFvZ6lxYZhtdKrpABl9i6841s5RVRY23eQjwq/QA==
X-Received: by 2002:aa7:8d86:0:b0:44c:9006:1b44 with SMTP id i6-20020aa78d86000000b0044c90061b44mr12215663pfr.36.1634309139012;
        Fri, 15 Oct 2021 07:45:39 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:45:38 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/24] PCI/ERR: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Fri, 15 Oct 2021 20:08:57 +0530
Message-Id: <69fed7552be7c516bc92ce1e3bbb3249dfb74860.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
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
index ce2ab62b64cf..c1575364d1ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1077,7 +1077,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return -EIO;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	if (pmcsr == (u16) ~0) {
+	if (RESPONSE_IS_PCI_ERROR(&pmcsr)) {
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
+	while (RESPONSE_IS_PCI_ERROR(&id)) {
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
 				 delay - 1, reset_type);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..55b94d689eca 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -206,14 +206,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR, bit
 	 * 1 must be clear.
 	 */
-	if (sz == 0xffffffff)
+	if (RESPONSE_IS_PCI_ERROR(&sz))
 		sz = 0;
 
 	/*
 	 * I don't know how l can have all bits set.  Copied from old code.
 	 * Maybe it fixes a bug on some ancient platform.
 	 */
-	if (l == 0xffffffff)
+	if (RESPONSE_IS_PCI_ERROR(&l))
 		l = 0;
 
 	if (type == pci_bar_unknown) {
@@ -1660,7 +1660,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 
 	if (pci_read_config_dword(dev, pos, &status) != PCIBIOS_SUCCESSFUL)
 		return PCI_CFG_SPACE_SIZE;
-	if (status == 0xffffffff || pci_ext_cfg_is_aliased(dev))
+	if (RESPONSE_IS_PCI_ERROR(&status) || pci_ext_cfg_is_aliased(dev))
 		return PCI_CFG_SPACE_SIZE;
 
 	return PCI_CFG_SPACE_EXP_SIZE;
@@ -2336,8 +2336,8 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 		return false;
 
-	/* Some broken boards return 0 or ~0 if a slot is empty: */
-	if (*l == 0xffffffff || *l == 0x00000000 ||
+	/* Some broken boards return 0 or ~0 (PCI_ERROR_RESPONSE) if a slot is empty: */
+	if (RESPONSE_IS_PCI_ERROR(l) || *l == 0x00000000 ||
 	    *l == 0x0000ffff || *l == 0xffff0000)
 		return false;
 
-- 
2.25.1


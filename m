Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4835429668
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhJKSGp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbhJKSGo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:06:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7639DC061570;
        Mon, 11 Oct 2021 11:04:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso34113pjb.4;
        Mon, 11 Oct 2021 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wg9CIjlvFpQ0mVyLruVXTyXRfH69nmtxShZyyO67k10=;
        b=KwLjn5HVCPAN1VyO03eoWTSqXTyEkZVSRrK3txPHLLIh9DhiOwh/bWPmuYTP1e0iL6
         YCPUrRJkFuvEpLSZ6Se/vQtD44PWVShCYlpelWNoiFet280Bxh/U8X11avhIBa104k8s
         /Oi5LcHFsMiFjCRQJNnrObmG7WygfC1yAkfZeVLuaIpEVIfbFDTwTTOM6+MVbavO0G1D
         RO+fuy+VtuMrUg3U/UGarY5fgbMvj3MAbVJRK34KsZ07IFSNSfxryKngR1uTNMcrb7BC
         DDvYMkIT4n3w44QNHlHcJ4s9eQd2GQ3AkQcHyHFU3HwscstwjIGrAEsxSucysWHQH50H
         6HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wg9CIjlvFpQ0mVyLruVXTyXRfH69nmtxShZyyO67k10=;
        b=WBKflUg3K9R4I/MwcHbrGonsoqw89N2VEwJtnmfXV0SmOx5Y8Z4R0nGLl2Goyubafc
         vmbUpQJ3kRhMyIfkoZOFk/xyhVkczvzu7wi6qznTRp7WcJSVVSpB+esK7+e1wa0XnEFS
         3N4j8EdFAh7I4wycRnVDat5JMiOedMIOol92g8fm2jTkCCHDSo2YaF/P2/v7kHM9ftik
         kXEfV2mfpNO3FomJAOjm4EpwwTMQD1Kj/CJ5Q52tWK/nv4WgpfIT/0VoEXf8nx6JZvyq
         u7omexGrc/QjvXQgPxoURT3gojEW/H8aRfiv1vbfYklFvzmKroP4RGFAWWH+ur53bmfM
         nENw==
X-Gm-Message-State: AOAM532jf8YF7D5PtyRYK8CJXdyBms5cy2uRi5gvZxcMVRswn7WyquJ4
        h2P7db+hK+YpuEaASXGMIVXtRwmtxQWVy1v2
X-Google-Smtp-Source: ABdhPJx8PGs9R92IcdI05aUBG80Gz5bw7EqeWjzkCHnfBwTDDyVwKJ3kiszV1+1ZvjzwJfFZp9JNJQ==
X-Received: by 2002:a17:90b:3a84:: with SMTP id om4mr476908pjb.153.1633975483812;
        Mon, 11 Oct 2021 11:04:43 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id u24sm8341425pfm.27.2021.10.11.11.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:04:43 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/22] PCI/ERR: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Mon, 11 Oct 2021 23:34:21 +0530
Message-Id: <5117401f4ff1ff8b0d0ebad0ef5b7b7adfee201e.1633972263.git.naveennaidu479@gmail.com>
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


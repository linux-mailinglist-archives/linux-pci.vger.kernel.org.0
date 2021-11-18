Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641EA455D82
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhKROLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhKROLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:11:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8702C061570;
        Thu, 18 Nov 2021 06:08:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso5853149pjb.0;
        Thu, 18 Nov 2021 06:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqepzKgKYKi0P/3AF7cx3PfHQnBbwZONrKqYokz0hlw=;
        b=UVcUH05cevJt7DhkBXedOq96PKvg/OMKRZzlqYVaDh2NHhIU4skU5s/MLYh9LrYbUg
         anK7NJo5BlOG0CJAhhYuQo6HgFLcIKSqDo/Fo3apB0yQBc8QxHwsoLQ4mEKsmdPqk03j
         EGHwZetKrtO75nyrF4BT0EAvLDvrUMCpnlt5jf7qboZzlFsWIyGaausOAETQfrytNCXn
         fDQPHFM+oR8nMT8xe2NeSdPA/qwP6xqyfzy6ZWXOzU47M5qkEPlgs6s/4qf7ENEua6Gx
         OnMqNuiTqkqZ72PyOPEx68/xxDW021+iDLsJA4l1j5EHAM+16WydrjdTGunvZzNtCob8
         1lsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqepzKgKYKi0P/3AF7cx3PfHQnBbwZONrKqYokz0hlw=;
        b=3zaSejH4iepYoZWTpO6nMADPJHuCol8KfrfEjHQLUX97DNZM8mIjzv0i2YX6gQHCP6
         VrzIvnkfEiaP14KMFysls/nl0ndC976awInzUS1npgjCKF9rEkFxWGgi2RFeF63fk7M1
         tJ6ONcDeTNee05XfKyJnKGQbCb7C9jQYbWjyOOXYoDCyVASKM1ZAKZtyL25sqa8aO4kG
         Kl4TIE14rx+nxYB380rVJ0uw30nBU0Gt/LfCjINoeAhXNscCNWu/ff0Goz8x/Xwie4SK
         uyaaE0HNQcPl/TIAA5DJyICQ0MsMEc8+QOAlxdxGvuW0GY5LkC5F1BX82yQhd1jTZaCq
         EHxw==
X-Gm-Message-State: AOAM533cTqfhAt55fYDswo6vpuwDriiVQuukM0xBhE9yM/Jss2vvhoTz
        MVQ4DEyXJTWLzYVMqBHWHS8=
X-Google-Smtp-Source: ABdhPJz++pJuPHrS+vU1AfDbegw9RqV6bph8Lx+Xo2st+ejZBGqczMctqLtmJraUUKXa9EOgtQVJVQ==
X-Received: by 2002:a17:902:dacb:b0:141:e931:3b49 with SMTP id q11-20020a170902dacb00b00141e9313b49mr66184334plx.45.1637244497153;
        Thu, 18 Nov 2021 06:08:17 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:08:16 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH v4 16/25] PCI/ERR: Use PCI_POSSIBLE_ERROR() to check read from hardware
Date:   Thu, 18 Nov 2021 19:33:26 +0530
Message-Id: <f4d18d470cb90f9cb52ea155b01528ba2e76e8d6.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use PCI_POSSIBLE_ERROR() to check the response we get when we read
data from hardware.

This unifies PCI error response checking and make error checks
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pci.c   | 10 +++++-----
 drivers/pci/probe.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb394986a..bc82699ed105 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1115,7 +1115,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return -EIO;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	if (pmcsr == (u16) ~0) {
+	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "can't change power state from %s to %s (config space inaccessible)\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
@@ -1271,16 +1271,16 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
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
+	while (PCI_POSSIBLE_ERROR(id)) {
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
 				 delay - 1, reset_type);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 087d3658f75c..c48fe1ab1961 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -206,14 +206,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR, bit
 	 * 1 must be clear.
 	 */
-	if (sz == 0xffffffff)
+	if (PCI_POSSIBLE_ERROR(sz))
 		sz = 0;
 
 	/*
 	 * I don't know how l can have all bits set.  Copied from old code.
 	 * Maybe it fixes a bug on some ancient platform.
 	 */
-	if (l == 0xffffffff)
+	if (PCI_POSSIBLE_ERROR(l))
 		l = 0;
 
 	if (type == pci_bar_unknown) {
@@ -1683,7 +1683,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 
 	if (pci_read_config_dword(dev, pos, &status) != PCIBIOS_SUCCESSFUL)
 		return PCI_CFG_SPACE_SIZE;
-	if (status == 0xffffffff || pci_ext_cfg_is_aliased(dev))
+	if (PCI_POSSIBLE_ERROR(status) || pci_ext_cfg_is_aliased(dev))
 		return PCI_CFG_SPACE_SIZE;
 
 	return PCI_CFG_SPACE_EXP_SIZE;
@@ -2371,8 +2371,8 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 		return false;
 
-	/* Some broken boards return 0 or ~0 if a slot is empty: */
-	if (*l == 0xffffffff || *l == 0x00000000 ||
+	/* Some broken boards return 0 or ~0 (PCI_ERROR_RESPONSE) if a slot is empty: */
+	if (PCI_POSSIBLE_ERROR(*l) || *l == 0x00000000 ||
 	    *l == 0x0000ffff || *l == 0xffff0000)
 		return false;
 
-- 
2.25.1


Return-Path: <linux-pci+bounces-44305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B8D068F5
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 00:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A943013EB2
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DC330B3B;
	Thu,  8 Jan 2026 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YVE73Gy7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB31A76DE
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767915741; cv=none; b=m5buT0OqjpSCPnba8JQy1/e2cnSrmerXiM7l5tj9A8Hns2fSx6ATaA3Zb0Kg9EIDCegINKlBpk7D+QV7nJUf1JDzaCua8b1i9n+Bgybi2BMvoZ655clYEbnchFqTXTLh0AIDVIBwJ1IzdEcdWyUNTm99qXO32msFayP2uQG6b88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767915741; c=relaxed/simple;
	bh=q1WJ/tknsGfRiD8moFkTOed5nAXvTgq3ret8KECqKMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQOPIw5V2tSU7TgiWYF7nAojR9ilxvvfXA4ML9Dect/f9a3CJSdGxrHSzrIc+g2Bs3rcJUoh3vNLeSnwG/D6J78c33WAIdiji9nWIG0wT/fI7roR1Y1ac3jV8j8qRpBKhOWhI46Fsy+QfL7wIfrTTZg4q7zH4j7eryezrMGEBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YVE73Gy7; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso1644759eec.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 15:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767915739; x=1768520539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9inY4Dn7b85AeLEK8fRSnnQcqPoH5Aqe2MencsS1B8=;
        b=YVE73Gy7t/2eDAz2riBA4AndgK3O6wVgLcGalxxylWXNCAkaNuo2Vw7MqkPlWoGqG2
         vLP0HTHSRYPbV//BOzUCHPtxq/OONL1RbDWy2w9fJl8nZNmfF4PLMoDNZ6VhKUK1lYgz
         Qzj1QPF81Ta6O07MX4W5txTKM2hKHTIhB+FFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767915739; x=1768520539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9inY4Dn7b85AeLEK8fRSnnQcqPoH5Aqe2MencsS1B8=;
        b=C49BOzji20j9xkhc54HWa5Xz4eRFGTcyteRkS0oM0AQ5VN3jKI79QcPoCgl6uwfCQC
         iTCcV6SYvk+lmMwQNwpOIxjhAL/fLvP0vBxBfRjSIGWEV2B2EwBH/W4SUTKGGEU5FgST
         qjUObtjAT2Ym+lgAv3AW1b7Q+Z07syOJnKvqH5Q42BvcGQaw1nTvhoLnVaRpFumYw5uX
         h3L8O3EEGV1KFeul+A2g1mvdoEGa0KBytwV6Tq1dNgv/dqoVn4Uss7vRpb60a9gsBBLf
         OLkcO69SgSFIF9GmhKrZpGV398DghtmFawaKe+4UGnWahI6q3x9uvkvos7hL90Z4tChb
         VJcA==
X-Forwarded-Encrypted: i=1; AJvYcCVmpbYqqbKt8rImCKflG0run86LntN41ZyDBabZVkoZvOHGRJsCmdG7H+V0j9JYZIfsLAozJlJhJTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXfFW+AdaVMJYjcIDh0QAvaeYnCvRAkWgWC/mRU3eZcQ3kwJb
	oSIx5456LzKBv8U0JJ2axOnUNNNQKvkIbaVUAEiuNNdVfbEzzR8Zx7mnHdavWclMRA==
X-Gm-Gg: AY/fxX7QfZmFO0v5B7qsx9WnNl1Yi/IMBhqF+ZX19d5z6OIaWDeQG61/lix9wliTtSV
	XXM4CYEo1MWdhetRexB/DhF7IiCZIz4aTllyKPH6Ix0SaWUU7y88aF/tnZD/6HlZ/v+tsX47Os6
	Jf6sJyl2pYvICRE0uwh7SLSG/XZRlAyKVBH/57urm5eqowFo/PgFYwkhYjbWR7aUvzSicNrlv0H
	3r3koC5PnFXjP1s6bu8C4fGi+oV8GHMXuRBa7RxtPRZEQ/s0cl8eYJQlDNathPKiReg4JLq9AFl
	jidITJCiFhWm8sRe6XPXsDyGK6OP8koDG9k/T2DQskYZptLqY4Abw8ELyhIrb3yfGayZvORSYG4
	Cp9X3gZV9HA32xsbf3Ln9lLhW1zeNeM3U47E0L2+MFYuSSxAG/lHGmJ/SdJQOI43Du5+IGCEoWi
	vDL9QbTlnuqD0IvBz8/IrG2CWoDtT1XqbUugPWAxNryyfKTmU/Sw==
X-Google-Smtp-Source: AGHT+IEd5xjYdSwbAVqr9+dYrpsdym27z2YDGMurEb5Fj2LJWyZXFOnDjVN4fI56rz6x0MybpuCRFA==
X-Received: by 2002:a05:7301:6790:b0:2b0:59da:f798 with SMTP id 5a478bee46e88-2b17d294b83mr8744620eec.21.1767915739474;
        Thu, 08 Jan 2026 15:42:19 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d9f4:70dd:b942:60f7])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b1706a5d3dsm9358795eec.13.2026.01.08.15.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 15:42:18 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/ASPM: Allow PCI PM L1 substates without ASPM
Date: Thu,  8 Jan 2026 15:42:01 -0800
Message-ID: <20260108154200.1.I7beb66162d35904e7e05830a666de03ed75e6b76@changeid>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Configuration of ASPM and PCI PM should be mostly orthogonal, where PCI
PM L1 substates can be enabled/disabled independently of ASPM L1
substates. The main restriction is that one cannot enter L1 substates
without entering L1.0 first. In practice, this means we cannot enable
ASPM L1 substates if ASPM L1.0 is disabled. Notably, PCI PM L1.0 cannot
be disabled [*].

However, we're enforcing unexpected artificial dependencies between PCI
PM and ASPM.

Consider the following sequence on a given device:

1. Initial state:
  L1.0, L1.1, L1.2 ASPM enabled
  L1.1, L1.2 PCI PM enabled

2. We disable ASPM L1.0 via sysfs

     echo 0 > /sys/bus/pci/devices/.../link/l1_aspm

Expected:
  L1.0, L1.1, L1.2 ASPM disabled
  L1.1, L1.2 PCI PM enabled

Actual:
  L1.0, L1.1, L1.2 ASPM disabled
  L1.1, L1.2 PCI PM disabled

I suspect this is an accidental misapplication of ASPM requirements to
the PCI PM configuration.

There are similar artificial dependencies:

1. enabling L1.x PCI PM unnecessarily implies enabling L1.0 ASPM
2. pci_{enable,disable}_link_state() have the same bug

Relax these dependencies by:

(a) narrowing "PCIE_LINK_STATE_L1SS" to only mean ASPM L1 substates, and
    updating some corresponding naming/constants
(b) applying the restriction (that L1 substates require L1.0 support)
    only to the ASPM variant.

  ---

[*] PCI PM L1.0 does not have a configuration bit to disable it; it is
    entered whenever the downstream component leaves D0. (PCIe r6.1 5.3.2)

== Behavioral impact ==

Besides correcting sysfs behavior, this may have some impact on other
drivers. For instance, drivers that call

  pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);

will now only disable ASPM L1.{0,1,2}; L1.{1,2} PCI PM may still be
possible. I don't expect this to be a problem, since ASPM is typically
the problematic one -- PCI PM typically only takes effect when a device
is runtime suspended (D3).

== Historical note ==

It seems this mistake originates in commit aeda9adebab8 ("PCI/ASPM:
Configure L1 substate settings"), where PCIE_LINK_STATE_L1SS was
previously named ASPM_STATE_L1SS, although it represented both ASPM and
PCI PM substates. This error was propagated further in the other commits
marked with Fixes.

Fixes: aeda9adebab8 ("PCI/ASPM: Configure L1 substate settings") ++
Fixes: aff5d0552da4 ("PCI/ASPM: Add L1 PM substate support to pci_disable_link_state()") ++
Fixes: 72ea91afbfb0 ("PCI/ASPM: Add sysfs attributes for controlling ASPM link states") ++
Fixes: 80950a546089 ("PCI/ASPM: Set ASPM_STATE_L1 when driver enables L1.1 or L1.2") ++
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/pcie/aspm.c | 32 ++++++++++++++++----------------
 include/linux/pci.h     |  2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cedea47a3547..4d1e79886518 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -221,9 +221,8 @@ static_assert(PCIE_LINK_STATE_L0S == (PCIE_LINK_STATE_L0S_UP | PCIE_LINK_STATE_L
 					 PCIE_LINK_STATE_L1_2_PCIPM)
 #define PCIE_LINK_STATE_L1_2_MASK	(PCIE_LINK_STATE_L1_2 |\
 					 PCIE_LINK_STATE_L1_2_PCIPM)
-#define PCIE_LINK_STATE_L1SS		(PCIE_LINK_STATE_L1_1 |\
-					 PCIE_LINK_STATE_L1_1_PCIPM |\
-					 PCIE_LINK_STATE_L1_2_MASK)
+#define PCIE_LINK_STATE_L1_SS_ASPM	(PCIE_LINK_STATE_L1_1 |\
+					 PCIE_LINK_STATE_L1_2)
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
@@ -902,8 +901,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 }
 
-/* Configure the ASPM L1 substates. Caller must disable L1 first. */
-static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
+/* Configure the L1 substates. Caller must disable L1 first. */
+static void pcie_config_l1ss(struct pcie_link_state *link, u32 state)
 {
 	u32 val = 0;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -953,9 +952,9 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	/* Enable only the states that were not explicitly disabled */
 	state &= (link->aspm_capable & ~link->aspm_disable);
 
-	/* Can't enable any substates if L1 is not enabled */
+	/* Can't enable any ASPM substates if L1 is not enabled */
 	if (!(state & PCIE_LINK_STATE_L1))
-		state &= ~PCIE_LINK_STATE_L1SS;
+		state &= ~PCIE_LINK_STATE_L1_SS_ASPM;
 
 	/* Spec says both ports must be in D0 before enabling PCI PM substates*/
 	if (parent->current_state != PCI_D0 || child->current_state != PCI_D0) {
@@ -994,8 +993,9 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		pcie_config_aspm_dev(child, 0);
 	pcie_config_aspm_dev(parent, 0);
 
-	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
-		pcie_config_aspm_l1ss(link, state);
+	if (link->aspm_capable & (PCIE_LINK_STATE_L1_SS_PCIPM |
+				  PCIE_LINK_STATE_L1_SS_ASPM))
+		pcie_config_l1ss(link, state);
 
 	pcie_config_aspm_dev(parent, upstream);
 	list_for_each_entry(child, &linkbus->devices, bus_list)
@@ -1376,9 +1376,9 @@ static u8 pci_calc_aspm_disable_mask(int state)
 {
 	state &= ~PCIE_LINK_STATE_CLKPM;
 
-	/* L1 PM substates require L1 */
+	/* L1 ASPM substates require L1 ASPM */
 	if (state & PCIE_LINK_STATE_L1)
-		state |= PCIE_LINK_STATE_L1SS;
+		state |= PCIE_LINK_STATE_L1_SS_ASPM;
 
 	return state;
 }
@@ -1387,8 +1387,8 @@ static u8 pci_calc_aspm_enable_mask(int state)
 {
 	state &= ~PCIE_LINK_STATE_CLKPM;
 
-	/* L1 PM substates require L1 */
-	if (state & PCIE_LINK_STATE_L1SS)
+	/* L1 ASPM substates require L1 ASPM */
+	if (state & PCIE_LINK_STATE_L1_SS_ASPM)
 		state |= PCIE_LINK_STATE_L1;
 
 	return state;
@@ -1626,13 +1626,13 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 
 	if (state_enable) {
 		link->aspm_disable &= ~state;
-		/* need to enable L1 for substates */
-		if (state & PCIE_LINK_STATE_L1SS)
+		/* need to enable L1 for ASPM substates */
+		if (state & PCIE_LINK_STATE_L1_SS_ASPM)
 			link->aspm_disable &= ~PCIE_LINK_STATE_L1;
 	} else {
 		link->aspm_disable |= state;
 		if (state & PCIE_LINK_STATE_L1)
-			link->aspm_disable |= PCIE_LINK_STATE_L1SS;
+			link->aspm_disable |= PCIE_LINK_STATE_L1_SS_ASPM;
 	}
 
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..5781aff12748 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1865,7 +1865,7 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
 #endif
 
 #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
-#define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
+#define PCIE_LINK_STATE_L1		BIT(2)	/* ASPM L1 state */
 #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
 #define PCIE_LINK_STATE_L1_2		BIT(4)	/* ASPM L1.2 state */
 #define PCIE_LINK_STATE_L1_1_PCIPM	BIT(5)	/* PCI-PM L1.1 state */
-- 
2.52.0.457.g6b5491de43-goog



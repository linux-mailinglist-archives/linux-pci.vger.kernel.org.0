Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6121AC88
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfELNzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 09:55:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51791 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELNzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 09:55:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id o189so11418542wmb.1
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QcttfJ8ayGt43vNoJ2m1jvjxPKB+r2rp7o5oowmPgYM=;
        b=e4f50ldz9NGJYsapG3sDIOmTYrIXsQMXD7MhSkY3O/RMjmLBcWQVfLnESC0/DnyCGz
         u7qNvut9VBTtmTjhWGdUIgC4yTz75MJugjq5pHxfFAxD7OGxyaCIPqGK7wvj5ELDi0Oh
         05RAe1soPbeR+tGSTSsH+k0U/cubetrb6oeNynLHjeaBtn7mHAzd0cfajEqR8CmuA7zu
         +MGKjZuK1khlmZd1vPZFFW9XupmU4Ke8b05zHd61+C6u6FP3gkHSUJVrA1dnQ+QJ7cLd
         1cKh/E4+zWGLZJgMeJ7DBTZ88mqNf59v4867NCOfXUPU37SifY9Uqt8oYlJ8QeweBlyU
         tU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QcttfJ8ayGt43vNoJ2m1jvjxPKB+r2rp7o5oowmPgYM=;
        b=Q1zJ5fZyMWkWpTZPcwRt27BDwzzF7aYgwF8mGwCJ3ALZUr9yKH4laB/s7Z2w8ilO0q
         LO3+Q1UdTtzGh00HE/Rz9EO0R/2v0QtzwfpHG9BvWooSO0Fsc1FbB/qBs4QVOIumkm1/
         dNHPSxrPEYOXklo5K3xHejDmxKERIgFO/RUXjj3wTsUHrKyYWm8RioT2Va4vuFksVAJZ
         U05M/GCJ8lDXboN0MKdaG1v94Dx35RVFLcmRMlz4ulVjFRRXSGeZJTcemWieT06HdiVy
         ISaziHk8v4NxkiTlmyk/WUtu6BA4s93q1ueUQbD6rCE8uFGjXQz34Ydf7iPl0Xzvea71
         HiCA==
X-Gm-Message-State: APjAAAVY/dKiC4d+GLKejTNykwL5enlDQi9UvZrGM7xvxpncykmuazQU
        GB2pJRBUTcIQuruv5diYrzrSwF1RlaM=
X-Google-Smtp-Source: APXvYqyCiBtfbmmEJgRqj5mIBc3I3O+ZCfx5sA6Iy4717YEhJIcKsz1u4hUKcVfDHSSGKxNhnZ5K6Q==
X-Received: by 2002:a1c:2dcd:: with SMTP id t196mr212117wmt.141.1557669307499;
        Sun, 12 May 2019 06:55:07 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3? (p200300EA8BD457009C2751D89ED5DAD3.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3])
        by smtp.googlemail.com with ESMTPSA id z7sm12545017wme.26.2019.05.12.06.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 06:55:06 -0700 (PDT)
Subject: [PATCH RFC v3 2/3] PCI/ASPM: allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
Message-ID: <9b702eb1-6997-c5e9-2321-339246378609@gmail.com>
Date:   Sun, 12 May 2019 15:54:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So far Clock PM can't be re-enabled once it has been disabled with a
call to pci_disable_link_state(). Reason is that clkpm_capable is
reset. Change this by adding a clkpm_disable field similar to
aspm_disable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- no change
v3:
- no change
---
 drivers/pci/pcie/aspm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 511f3e018..7847be38e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -65,6 +65,7 @@ struct pcie_link_state {
 	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
+	u32 clkpm_disable:1;		/* Clock PM disabled */
 
 	/* Exit latencies */
 	struct aspm_latency latency_up;	/* Upstream direction exit latency */
@@ -162,8 +163,11 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 
 static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 {
-	/* Don't enable Clock PM if the link is not Clock PM capable */
-	if (!link->clkpm_capable)
+	/*
+	 * Don't enable Clock PM if the link is not Clock PM capable
+	 * or Clock PM is disabled
+	 */
+	if (!link->clkpm_capable || link->clkpm_disable)
 		enable = 0;
 	/* Need nothing if the specified equals to current state */
 	if (link->clkpm_enabled == enable)
@@ -193,7 +197,8 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 	link->clkpm_enabled = enabled;
 	link->clkpm_default = enabled;
-	link->clkpm_capable = (blacklist) ? 0 : capable;
+	link->clkpm_capable = capable;
+	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
 static bool pcie_retrain_link(struct pcie_link_state *link)
@@ -1105,10 +1110,9 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		link->aspm_disable |= ASPM_STATE_L1_2_MASK;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
-	if (state & PCIE_LINK_STATE_CLKPM) {
-		link->clkpm_capable = 0;
-		pcie_set_clkpm(link, 0);
-	}
+	if (state & PCIE_LINK_STATE_CLKPM)
+		link->clkpm_disable = 1;
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	mutex_unlock(&aspm_lock);
 	if (sem)
 		up_read(&pci_bus_sem);
-- 
2.21.0



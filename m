Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0F98298
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfHUSTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 14:19:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50335 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfHUSTB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 14:19:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so3088119wml.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2019 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rVtfzdrmRFBQnHI9A6IJKPt4rgOl7HXVD+rwCQXJ+08=;
        b=eRN7mOfPs/ZjrdqQGpfH90j/fgv0WSpIpKF9tLgiAdy2a5mQuSTwqj2HiMriNZaYVy
         kxlLEcnQYEaMd06uv9/E2wMNtIeiXM/ZjeskdP825hV/m1yAyJQTy4S75mqv+ytHUlaS
         ykFhCA40FMbKZFcBZwvPKhoAFoBdirXQc/H4eQggFpUy6SpC/Dymrdr5mE+soPpTlGwZ
         LkSfx8WqwpoBRwmY6f/8L8D4omeLHWQ7W4BDCXC+NkPM6CfrF1mx2Iel8FrvfVHC++C6
         yUtE86f+YgzLwKeoW8DL8xTPSEVc4pw11gPHk2bJW7MA7nXv9lJ6mhYZO7YGZ0xxateL
         bz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rVtfzdrmRFBQnHI9A6IJKPt4rgOl7HXVD+rwCQXJ+08=;
        b=QIXlrOKCWGdFv0sUKf/Bypt3o8nCFy7vco1kcVY8Ylz9nrXQkDaeQLA4luVmE8qhN2
         GDe4502Umzt+qZhQUHh593If8vmmxncz182iO2E0GY3f4UP+pSDih3b0FyZKMxgRHqcs
         yeskRdldpFPnj0eNbN1Fs/ptpGV0wXm8RNSiUIB7vErnvVAgbMARrbTgCB9mN/kZgGjY
         p5r68s3+DbN7CNcLv6ZNz5prXDHONM+Y+mw57qgpkFocH6LB02V+vjqS8hZMeP1C9T4D
         U+q96rja1YOS+V3Gfaowvz7A1x46IZ9iTKJVjqmDbnsiASZ3zQUJprd3/4PvbCttt3OH
         DFSg==
X-Gm-Message-State: APjAAAVAHV+vx5EKpXBXg64EW22wYBF902Qeyt2qBAuD680NDuc++4ic
        iMQYK/JvOLD0ctCU97c1RRG5/SP6
X-Google-Smtp-Source: APXvYqzWb9OReeF74w2r2jgvfC38duPte83a330OAiVam894mm3QsDcB435poFjG2sIaXRzdWLGjCw==
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr1558378wmf.101.1566411538865;
        Wed, 21 Aug 2019 11:18:58 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:3d5d:5315:9e29:1daf? (p200300EA8F047C003D5D53159E291DAF.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:3d5d:5315:9e29:1daf])
        by smtp.googlemail.com with ESMTPSA id b4sm1082563wma.5.2019.08.21.11.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 11:18:58 -0700 (PDT)
Subject: [PATCH v2 2/3] PCI/ASPM: allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
Message-ID: <d100911d-9cb1-e970-1f99-323d70ccdb7f@gmail.com>
Date:   Wed, 21 Aug 2019 20:17:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So far Clock PM can't be re-enabled once it has been disabled with
a call to pci_disable_link_state(). Reason is that clkpm_capable
is reset. Change this by adding a clkpm_disable field similar to
aspm_disable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pcie/aspm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1c1b9b7d6..149b876c9 100644
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
@@ -1107,10 +1112,9 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		link->aspm_disable |= ASPM_STATE_L1_2_PCIPM;
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
2.23.0



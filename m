Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF091A83F
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2019 17:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfEKPdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 May 2019 11:33:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55060 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfEKPdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 May 2019 11:33:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so4275187wml.4
        for <linux-pci@vger.kernel.org>; Sat, 11 May 2019 08:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aw8sA8VJsiJTaz6dQUugxGZhkspxCJcDsPk3dgAjmAQ=;
        b=jVqR8DHFPOZn7MOUOQD7tqDUnt0BGnukE0OzM3zfFFpRblfY/KSopTjuSF7WIPKWMC
         8oTN59g1jRYRB5v5uc9xtb5UNJEkUYQpsNwNuf4OiUO5ARwJTgJOqWvZuO6lBsvw07vd
         fmgchDMZiROBm8St6iZg0gT7mgoJkS9/qTC4A2l9ePo6l9gAi7Exolr7/hpiH8uwXR86
         SdUE4J17yEMpxpAM69Qp0oASpu69K+jxDW45f2BEEZ9Ip6RtJm/RRTbLTRNS92+eg5d6
         i5ZDyqhG6eRh7c+zTLsJgHr7AFmao6pkU1iMv1ogQ8FL2jfI1AGRLxF2WZvFvBj/lqvQ
         SKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aw8sA8VJsiJTaz6dQUugxGZhkspxCJcDsPk3dgAjmAQ=;
        b=OVJsFxLQksLIVgXeJBMIzk5c6us3+G9LYukOe9o43XSiRoCwySdEvJ8dOVmaEywm1p
         k3aqsgxemN6DbeHJ+1EsnxADEKQyx4p1O8cupW/NllS/FYy5qvdJ0tYci34ve6Q7+IAE
         03UJ1JBel+nOk+PkxvOThQvlQpmw2zxbmuFzyUn3FsDs2vGCeuCmPYwpDrA6uATkPczB
         9bb95B5er0atOiApPV3SaLNq+wphWhywJSEWjxIgmP01WFTP4Zh7ovBkXjT4Stlfjdte
         NmD8Pg+vWZA0eVxvLsz7hrJXhM8SALewv4KXC2lpix0jRDahgDi6Pal8BCoYX0oT7mnL
         6H/g==
X-Gm-Message-State: APjAAAVuXHXWwpMZrXsjVhs5nkrpJvqvyRVbwgJGEdXl3iClF1W5pLqL
        vgdDQnG+My8CA/ouaB5GI4d4GZJ7HF0=
X-Google-Smtp-Source: APXvYqyoQJkrL8jYls13xwASf9xYL2ghtZZ8Lq4SW/rOAeIna0QnGmsXaWdrxC0U1ZSIqoVPrliYLQ==
X-Received: by 2002:a1c:cc15:: with SMTP id h21mr10407236wmb.85.1557588810263;
        Sat, 11 May 2019 08:33:30 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:152f:e071:7960:90b9? (p200300EA8BD45700152FE071796090B9.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:152f:e071:7960:90b9])
        by smtp.googlemail.com with ESMTPSA id y6sm11401618wrw.60.2019.05.11.08.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 08:33:29 -0700 (PDT)
Subject: [PATCH RFC v2 2/3] PCI/ASPM: allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
Message-ID: <e8fb4613-6607-429a-200d-ab8632f0a6ed@gmail.com>
Date:   Sat, 11 May 2019 17:32:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
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



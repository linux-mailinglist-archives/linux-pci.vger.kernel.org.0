Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017F99BEA1
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2019 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfHXPmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Aug 2019 11:42:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33473 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfHXPmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Aug 2019 11:42:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so11311008wrr.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Aug 2019 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rVtfzdrmRFBQnHI9A6IJKPt4rgOl7HXVD+rwCQXJ+08=;
        b=hGu97r4nTZ15USgR7dmUp3AZ5hPexGXVFBoP44Z7Tl/4HMO952ohhOxDegLA+B+zyI
         Zq8pu0MYZfT6blZy9gf7t2SBdn7ZylYpIVE21KI1fVbTjEaoI1eNz7Vc+W7hNG5kZ4+2
         fj3nnoIGhC5mjmsG2E7QkqhUarcEo+7IkqXsWJyn9XwfxmBfTv4i8Bk3Ma9nkrPTGFmJ
         XwvKDBibc+RMndnXtBGiWzHykQ4c4jzpIAREmCnJI1bQs21uWmPLRV3d+S3cH66ZRCGe
         /GHF+1PWHUE0kz/GSLPl82rSnFm0NhcQvQDUusVKccdYuqRijAg+r0fi9mq2At5TDr0s
         8dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rVtfzdrmRFBQnHI9A6IJKPt4rgOl7HXVD+rwCQXJ+08=;
        b=XFCDlq6HruPIJfXyC6BRZRUH9h88YsjiDHBM/cCMKv97AJPnrRPY2cuqY+ZAt13jAO
         WCEQojcigp3Ga5QGssq+PfYTGpOwQzuWS/mzn8Kskp5ivfXj/eCUpUsMtdKiwbZQvdcu
         3gP748RHoqYi5r0/ZiMo1qvYuyIRxiCKfkMvdC87axh4bLmWdDZLjLccX0wJPnQOG1hf
         EyAqZoaxewVaUOY0kOGkxU+I4T7vcpd75o633hakC1Wi7hcz6ZcZIM195VXTLHL2v2G0
         vhIKh/ehtGJq69X8jNDkPL8uwK5+NyFyZ8qZslu/qSbHoptynLT5VdkmP2rTNEIA9WKI
         ZN9A==
X-Gm-Message-State: APjAAAUmf3YUY7+KZHbYZN8v754oYhNEBIEV7CPsUbGmDrS0bXLKdef2
        mGKK/y57tRo9YAp2nPP7oNSAxt6m
X-Google-Smtp-Source: APXvYqxdAujIbMuQ4v9ySJxU2ldGMSqht/NEigzedLVaaJV/fih3w3LMVbuSgM0/HiV8CIdR3pW9dA==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr11877573wrw.15.1566661340305;
        Sat, 24 Aug 2019 08:42:20 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:2069:2121:113c:4840? (p200300EA8F047C0020692121113C4840.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:2069:2121:113c:4840])
        by smtp.googlemail.com with ESMTPSA id a19sm18345910wra.2.2019.08.24.08.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 08:42:19 -0700 (PDT)
Subject: [PATCH v4 2/4] PCI/ASPM: allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
Message-ID: <25196d94-cf75-da11-97cc-ec6f18b321b2@gmail.com>
Date:   Sat, 24 Aug 2019 17:40:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
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



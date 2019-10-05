Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FEDCC9CC
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfJEMJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 08:09:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43666 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfJEMJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 08:09:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so9290511wrq.10
        for <linux-pci@vger.kernel.org>; Sat, 05 Oct 2019 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XLEDj7lJ59wa9ec0V3EX//kc9AMcwJTkEP5jkJV1YK4=;
        b=gGcGlLjxYIdwpqznDgsRp1NM52xTzsyUGSXC4h2AQAyJHDHugIOC6XyrMftIDwK+Ed
         VLLrBWiwb6bjLq1DDIS+9Q4PC7f6E5wVWljCxQV6w42wsyg9uH1AyrNzThCbhigqTK+/
         xZPpkCZ6UEz2dAWbRj8aAsVw1Wk8Xs4OdZppPaI9k9AIm3lmIz8VQ0owFF+c1zB9twfI
         eXq//5/BQnOS1+lILTq+3ilBgv2xe36NvfVlq0XBzGojMuJG6xWHo+Yg1pC6Vdq73j/f
         BMsVBAhkXBIgXm5veWdNDLp6zbBK7p1bum6floxj4+vKn/a3WPLazwUVHnVoX6NlIBou
         KLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XLEDj7lJ59wa9ec0V3EX//kc9AMcwJTkEP5jkJV1YK4=;
        b=n4jyaap0zu78yLXskj/1EDE9LfgVXspu1NfoadunfRDMym+V6tUcw731M31TpsQmBH
         K+V/6JhamwsG/Pk1VedKalZ8jg3VqLlZysnecAdOC27V9DVwGeXRJEX2D8dZbEsF9oC0
         LHcGlneAqXf+vyEIvqeHmW7FpgmU0U5XhIYQPwbzTeFoItholWQLByetaM8GRz1aE5PV
         a4mwUox8xRzeH55H2Aua2NQaKgAbuOZzhpABo/8yvRMCrkizQmg2+F1b7Rv4NKOQhY6T
         0EEQHqvO3752g2luaRyKOya9Uk3YiBr75U0Fooo6frrNWgHZQfAAP93xJxJX7/2Kxj6c
         3ILg==
X-Gm-Message-State: APjAAAXIAltkBY1kJ7k6fmkwf7QjU62wsAPusQcB2GwCXaKiqmCH0xo3
        tnBRIzmGsJ/M45ftCO3+IuI3PU7/
X-Google-Smtp-Source: APXvYqzAcAqUNzXT7jBuVjwrtPxoRGYlrjcGEnd3Un88e+q+6vrvQBcXGysbHQrWF/HajP+jXEJOeg==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr15028175wrn.200.1570277379855;
        Sat, 05 Oct 2019 05:09:39 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:78ef:16af:4ef6:6109? (p200300EA8F26640078EF16AF4EF66109.dip0.t-ipconnect.de. [2003:ea:8f26:6400:78ef:16af:4ef6:6109])
        by smtp.googlemail.com with ESMTPSA id y186sm19132158wmb.41.2019.10.05.05.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 05:09:39 -0700 (PDT)
Subject: [PATCH v7 2/5] PCI/ASPM: Allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
Message-ID: <4e8a66db-7d53-4a66-c26c-f0037ffaa705@gmail.com>
Date:   Sat, 5 Oct 2019 14:03:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
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
index ed463339e..574f822bf 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -64,6 +64,7 @@ struct pcie_link_state {
 	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
+	u32 clkpm_disable:1;		/* Clock PM disabled */
 
 	/* Exit latencies */
 	struct aspm_latency latency_up;	/* Upstream direction exit latency */
@@ -161,8 +162,11 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 
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
@@ -192,7 +196,8 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 	link->clkpm_enabled = enabled;
 	link->clkpm_default = enabled;
-	link->clkpm_capable = (blacklist) ? 0 : capable;
+	link->clkpm_capable = capable;
+	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
 static bool pcie_retrain_link(struct pcie_link_state *link)
@@ -1106,10 +1111,9 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
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



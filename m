Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675F4C40EA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfJATTK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 15:19:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36421 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfJATTK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 15:19:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so16878027wrd.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2019 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XLEDj7lJ59wa9ec0V3EX//kc9AMcwJTkEP5jkJV1YK4=;
        b=RJAz6UJtrVJ5cVEpzehQL3R8A9GzE3jsEfxeKwywrI70xkNnKb9pb+ghSZ+WWCb0bD
         GWyBAUEpspPucE2/H5V9p2F1xctLIW7Yn9g/CcH+QmJhnuZhMfNvQSnREsnxWBbZ7aPe
         OSZhfuPUit59tO70njdUi6KA5M34002pqycrfFvJEn//aIk5b3tlz+hMQESJ8xiDJvGd
         SABhXinpkSetEhtuQOosuypHFMN2xWlrbLQ0Jft/EXCFKaekkUQPn/tP5tFhZyrOhPKm
         iRHZ54CK+dSXSepuRiNaHkI1l0ZP/JhPSSQTHDIDunm+l33EyePD2IYQyjUIVsYlsQv5
         Uk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XLEDj7lJ59wa9ec0V3EX//kc9AMcwJTkEP5jkJV1YK4=;
        b=uatS4or3FzP5S0WXRquPD9lkGPrEdE0xHvjENso+3zdeREMXUnIsU0sq8CWyFcv9HX
         O9uwB5UzWV1LIAjDwmwC/ARzQ1YxCEhK0hoh1iWBQV1/O+lLDM66Lowm1tNQURpS2lpw
         ylOfFjJXNYeJ+XwbVY+ItdlMER3b8FwzMpIHtkZrZ9iF3JGiUvho8X+ZPT/zCbvMf6tF
         q2ZYGUbER+RP7J44QpnVcoj75UH+ZBL7bt8UWLmuSZa3b68frbq4YMmpWENDrytvPmtZ
         zyTXeZ/rEE0Pk3R/PBl+8Ce7219d+2MzUAf9IjdjfFvVQFaPpmpWy1NekUMuJz+Tyb6U
         g+KA==
X-Gm-Message-State: APjAAAUmcDWFEcOzv6Mqm5IKm7XDv7uCPE+hyJyA/X9DAQ2SObUPrrlt
        9qpPGye8Rxs+p52VR8IQ7ER6oa7L
X-Google-Smtp-Source: APXvYqxQgfVHYBuyH/E+mKYpAU1200WhIaq3prm1svQFXzeasuy/vXHU85jcqPH5DIV1i1aXd/p2zQ==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr20117730wrj.185.1569957549151;
        Tue, 01 Oct 2019 12:19:09 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:ad11:16fb:d8da:de15? (p200300EA8F266400AD1116FBD8DADE15.dip0.t-ipconnect.de. [2003:ea:8f26:6400:ad11:16fb:d8da:de15])
        by smtp.googlemail.com with ESMTPSA id p85sm5661597wme.23.2019.10.01.12.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:19:08 -0700 (PDT)
Subject: [PATCH v6 2/4] PCI/ASPM: Allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <0577b966-6290-0685-123d-c675baf97caa@gmail.com>
Message-ID: <2dc07439-034d-0781-0f62-578ca39f81c4@gmail.com>
Date:   Tue, 1 Oct 2019 21:17:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0577b966-6290-0685-123d-c675baf97caa@gmail.com>
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



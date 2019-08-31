Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C25A462A
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfHaUVP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Aug 2019 16:21:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38253 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfHaUVP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Aug 2019 16:21:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so10825010wme.3
        for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2019 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QwI7vXDYlvIApsTBwHQIWtgOUS8kocR7BXXXZ5uchHI=;
        b=mLlQqVbFxMiusHHQ9jn9pTJRf0ovE40puaOy1oRPxIH8ZG8wPqoIeAPuH7UJr1HTdE
         uht2tP4Ib5OV8MaZHA6lyDDQq4LTiuCvAQfGqodglTqo/TtdRbThU9fhs+nPZJ0tm8pg
         Xr2D7MLZ5j6SwoTuDN1HeczIVMzqOb5OVZ67x7UDSVwuADbmZTZgD/BQOmnlBOREmwZ3
         ADy2q78kHhY1gLGUEa95ekxGrRG/aMCUHgMHCu+XUlG82igEWiLEs9j09gk8m0nb0D1O
         imYCbpWmP4uGn8xWi2uRWG0vy2qqHWw6NQikzwZMzhhxo0kBZas+QawN34B46V7esw2f
         TJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QwI7vXDYlvIApsTBwHQIWtgOUS8kocR7BXXXZ5uchHI=;
        b=hje7uFiba2pJPnalignVgj41O9Qm0gCF/s9xyEgaAznz8R7CenN5K5KUwF6pzF22Z1
         lZLquBkQPxRNici34sWqFMA5GRd+f8oSUdKwsDTmbNT7jTx3rRFX01C9DR9nK6Idku1r
         osIE6Ri28mW6Nk+z1TSqn1irtV9QSVr4tIiGNeI2VqmNMAK17tIMtDpkFs2HBHmpxrhu
         ljKwM57O/0zPL0/ktAfdp951IRe+k0BF0xCcBTnhA4CVxzncZemoT0Xu3oLctVBG0FzA
         ZsfIDpoBRJes9+gUml7HCWjwn8IJGeUU+jHOoY14ihw88cYplY6OkbC2UMfbuGf7lxtj
         ALPw==
X-Gm-Message-State: APjAAAXBV8T92wf5vrnVRAmtru8R99S7H4PedMItneowdKCgkqhBnFvo
        A0zqdrMARNCnYOF0QILWmGrAV8ZG
X-Google-Smtp-Source: APXvYqy4yyWUNvmCu+3PnQd2r0/xOkybZnUWNRSpeaAXH8YkDbuO8CJoNsPIYhYAqQPBEp3A6762NA==
X-Received: by 2002:a05:600c:24a:: with SMTP id 10mr9836668wmj.7.1567282873211;
        Sat, 31 Aug 2019 13:21:13 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:9586:e556:3a4d:c04? (p200300EA8F047C009586E5563A4D0C04.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:9586:e556:3a4d:c04])
        by smtp.googlemail.com with ESMTPSA id r23sm11538013wmc.38.2019.08.31.13.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 13:21:12 -0700 (PDT)
Subject: [PATCH v5 2/4] PCI/ASPM: allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
Message-ID: <6a050164-8a63-f271-566f-2553ef579b5e@gmail.com>
Date:   Sat, 31 Aug 2019 22:16:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
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
index 6de7a597a..f044ae4d1 100644
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



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E093F28B3C
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbfEWUFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 16:05:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53220 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbfEWUFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 16:05:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so7111134wmm.2
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kgoy6MzCDFZksLCgPm3ckOOZ7Ci44vWIX+S6sDXfwtE=;
        b=uR41fvb8SB92vY5ZwRC/nkNyHDaXEw3e4ZmReN7zM0b4+dfKmztnK/h334o6nVFZbE
         qzEeBqLbgtH/Sd8bA3VLxKtRxx2Qw6YO6WQbCRV3biCGD+zaeIX0EkgDTiNNwBiKOcAD
         ahWeunmyVJb//qQmOvgTPNgqf/mX9J4QeUnpuFA8CvQu4kIstE9H+IuFqypKqtrkJbbP
         OXr8p3weS6+rYwaFHDUuuwT2CtRG7yr4eenP6hw4FkqcVDAEBsBW4lYIX4wq4QG2Hngz
         AMOtwz10P3BCvhrJsMw1uvJVPapAkiKjdcvCzA6e7UMjSRiDZ/eS7r1Vi0dDANUuME4D
         UQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgoy6MzCDFZksLCgPm3ckOOZ7Ci44vWIX+S6sDXfwtE=;
        b=tNKjbd4RU2Sl/UD5WA/XNqT3JwdASDJ5+sUhwu5SCQfSP5+SmyrRXp60fBGowr49OH
         0xnrxOcsQSV7vNNCYyRvM+mvdOUqXNIZ2M40q8Y/oRoJtdyPpOjjysHIiLj80Y+1uvPK
         Yyo/xN3fNzJ7S1KSysNwdAfZvpU37odq63oSmz90zofdvAPA5fIIvQrFJIPamo5LnqNl
         L9bZce7oW8ego0P8wptrp7gUZ2TQv+2Sw1TU24v7Y8n4U4SrCeKzsMMrssanKXk4w/U0
         t3kC9l7iVdOr08AfJhi0N/yO1vxxNzb9ee7nkorFkbRVQzrR67qXl0BCMDemH6Ab/AFV
         GyIg==
X-Gm-Message-State: APjAAAX6k0J8fy6E01eD9pOmW8TjwBtLtqm43tAuyTB/ffFWORa7WVMK
        CALxbn4rMjuwWCDMxYqquqKkPDm6
X-Google-Smtp-Source: APXvYqz2dDFnXcsGWqpLO9/g9IKzlwyJ3PbEG0awyZY7Su09zrv3zWgvecW+5aB8bAHg5aAS0B9NNA==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr12496986wmh.14.1558641948524;
        Thu, 23 May 2019 13:05:48 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be9:7a00:3cd1:e8fe:d810:b3f0? (p200300EA8BE97A003CD1E8FED810B3F0.dip0.t-ipconnect.de. [2003:ea:8be9:7a00:3cd1:e8fe:d810:b3f0])
        by smtp.googlemail.com with ESMTPSA id q9sm912738wmq.9.2019.05.23.13.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:05:47 -0700 (PDT)
Subject: [PATCH 2/3] PCI/ASPM: allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Message-ID: <02603196-4ca1-789d-f59c-6f172fc69fae@gmail.com>
Date:   Thu, 23 May 2019 22:04:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
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



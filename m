Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D979A77C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404346AbfHWGQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 02:16:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41624 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404334AbfHWGQO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 02:16:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so7496989wrr.8
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2019 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rVtfzdrmRFBQnHI9A6IJKPt4rgOl7HXVD+rwCQXJ+08=;
        b=QlOAdWJq10m7uwPXm7jBgwmOCPs/Z7GxpNU24vlERml1gVVb5w2SO4sMRoGIDmk/Gx
         PL4IRf6P54HC1Z9Ns7kDQmSH/INJjWtf4cmnnx92jj1Z2HVAWOlovwdPdY/4Y++jXkkQ
         mR0N30bTJ+GigDSUUkpkZSDpXdw9FufoDT7uja1A/UKL3IB7ClxWLUSxsLRhjcZW4Och
         l027ZPnij+XT2sbPttpyaqlyXeXEJArh1MwEQ0aFxGeFZX7W+fph0a255uiPzNMPkCpv
         fYGUM9p6EzIpFTAdQVTYNOW4Kl2JLlVOOSu6VAyH3FVCtwRhsD1J+IwjLOX9+F8nNOfA
         F3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rVtfzdrmRFBQnHI9A6IJKPt4rgOl7HXVD+rwCQXJ+08=;
        b=euqZYIcUPO/2CDKqyxICzhAADLtz6L9J17Z8JoQhDP58yqgw8jqu2/6zpXi3XrCYf0
         IGh27Wr9q/uLpslMbxqWeL8YQH4FDPDYSCoYJRy9vy37EPRf99Xx06+d3BlNf7yxQFWx
         mbS53kAPZCvsr6PmtsZZfmC0cfNO63bmuKl76t5zL4z+UShF62sgg8klzlwWNBgeCteD
         3I7Q2C82gbpqhy4koFQAxC7joxGR3EjFDTpQmI2m/mOYpQDculeXIYGGY3ors9EE9Ww5
         WgbbNTxcTQ2phQ5Y7Yp6V3o8MyI9QzSzKh4Lhz5cn5o1kJzQ/wM9BqJTUMaU/as14nIz
         YlbA==
X-Gm-Message-State: APjAAAUXndt4b4yF48p+HUBNJAGOPxWK4e1NPfzGm2seZIw+oWwd0bpt
        6HrIUJGMdCYYcFq1leAz8tku3TgQ
X-Google-Smtp-Source: APXvYqz69gflbtaxiLet/quQO2eIqPt+3TrlLXeYRAd+lEAuCEBTtDBO1TAJNaU+UMV5fJTjkFnEFw==
X-Received: by 2002:a5d:6a12:: with SMTP id m18mr2212604wru.306.1566540972793;
        Thu, 22 Aug 2019 23:16:12 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:34d1:4088:cd1d:73a7? (p200300EA8F047C0034D14088CD1D73A7.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:34d1:4088:cd1d:73a7])
        by smtp.googlemail.com with ESMTPSA id u129sm2058764wmb.12.2019.08.22.23.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 23:16:12 -0700 (PDT)
Subject: [PATCH v3 2/4] PCI/ASPM: allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
Message-ID: <80d3f3c6-f08a-dcf9-ed66-70201a90c3ae@gmail.com>
Date:   Fri, 23 Aug 2019 08:12:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
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



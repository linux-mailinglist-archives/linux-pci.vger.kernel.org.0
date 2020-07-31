Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBF2234525
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 14:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbgGaMCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733033AbgGaMC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 08:02:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01EDC061574;
        Fri, 31 Jul 2020 05:02:26 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so16378962ejb.4;
        Fri, 31 Jul 2020 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MwqyF9CqW8A2iZOP3zewT7pOoo+Y4wjTCBBLr9pFHV8=;
        b=lHoHf9/m1kx7BZ7ww7TnAOjVdHgOjMgE7yLieOTnDqQNJxPrzZpx4X7luLE6X5qwZS
         MSfM/WDG7Z7cYyAiYMXIgsf1/QIs51JUxiIZRyCPeJq5PHrzXYxoL9BclsHkuD1PanUC
         KN2TTvAcBF4bg2m0vXqdzEoStoCvDD/GLmoS+SebIRyOdOr6Eg6ZksoFBxWVKMYxIfo+
         bIEm18ANbRdC7thEM0MAPhXn+OJ1s0C2E7tVzn6L91sQsZhNgOe88CHyvFgroBFxhBlS
         26c6SmuBWXqQk1wEhtz7P/KBka4UMvcRd8VoKGhOPGOWlRPPvTUpLoV1+aGynqXJqYbq
         2UqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MwqyF9CqW8A2iZOP3zewT7pOoo+Y4wjTCBBLr9pFHV8=;
        b=mXO4CtjnGnWpGQXJId15HUrT92EeFb1dnOsIaC3JukKdHwt5W2S0Jwrtw6DXXp3x6U
         +V82TksGcCo2A80liQLtqJemUb4pIt92VzG+LXNaUWWWbAfRBkmN9CuzX4PWqIGNZxBw
         9Q6Rr7+3fZMmHGK+VHm5cFw/NSNkN/nPPPoRb1qyD77VM6wT3XhBsxpMq4hL681OGnSR
         uf7CdI+rQfV8GzDeixBG7bGaHnVDqpQQriv6Jl+DGSaZ2UXxHhmL63fNr7Jx7gzV7gsB
         Ph3S37GiguCbP34B2y7MpXolWvMZyyCi6GErxgLo1hjkEUGM2PukOFNzA+8isc8sU1bw
         EVtg==
X-Gm-Message-State: AOAM530KOIruYvLsuXd2iWenaEqhmV2P+6F8yF1ppcRO8MEbti6JucQF
        KY+z/9LzW5vNlPbt3muSfe4=
X-Google-Smtp-Source: ABdhPJxTrzSFodIyak2PVFdWY/r/1cAygHW7Lv6TgpA0BgOnyI9xtpwXpNfkEtXqEA40584a4tXzpA==
X-Received: by 2002:a17:906:8748:: with SMTP id hj8mr3778605ejb.477.1596196945471;
        Fri, 31 Jul 2020 05:02:25 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id j5sm9091734ejk.87.2020.07.31.05.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:02:24 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/12] PCI: pciehp: Check if pcie_capability_read_*() reads ~0
Date:   Fri, 31 Jul 2020 13:02:34 +0200
Message-Id: <20200731110240.98326-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731110240.98326-1-refactormyself@gmail.com>
References: <20200731110240.98326-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On failure pcie_capability_read_word() sets it's last parameter, val
to 0. However, with Patch 12/12, it is possible that val is set to
~0 on failure. This introduces a bug because (x & x) == (~0 & x).

Since ~0 is an invalid value here,

pciehp_get_power_status():
Add an extra check for ~0 on the value read. If found, set status
to 'Power On' and return.

pcie_wait_for_presence():
Add an extra check for no ~0 to the exit condition of the loop

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b89c9ee4a3b5..39305aabc3a2 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -278,7 +278,7 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
 
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (slot_status & PCI_EXP_SLTSTA_PDS)
+		if ((slot_status != (u16)~0) && (slot_status & PCI_EXP_SLTSTA_PDS))
 			return;
 		msleep(10);
 		timeout -= 10;
@@ -399,6 +399,11 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
+	if (slot_ctrl == (u16)~0) {
+		*status = 1;    /* On */
+		return;
+	}
+
 	switch (slot_ctrl & PCI_EXP_SLTCTL_PCC) {
 	case PCI_EXP_SLTCTL_PWR_OFF:
 		*status = 0;	/* Off */
-- 
2.18.4


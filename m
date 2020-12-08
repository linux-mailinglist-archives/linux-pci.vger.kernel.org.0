Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81DA2D2AB5
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 13:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgLHM0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 07:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgLHM0h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 07:26:37 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2DC061793
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 04:25:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t4so16000574wrr.12
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 04:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=5smxybzdNqxuKrC+BBuXRw8M7U1qM/sbfnyqES1mr5c=;
        b=A4CajI+tBrwLM2s75q2bpmtFYA6/9V4tMk2Lbl952mkHeTyOjjkuSzgebkOI/iGXFT
         zTOy62ujB48XCBj/eDWUB5+zUGT+x9LqqEQ6FG1GgJDdYYV41dlDGWOPwiQ1m43jgqn6
         +1lM7vcHL2UKzy0YzKYaQHp5xmiTbCfi8u6WwmZr7rk61qINBDYBrABPOm1Qk+y1ZLTl
         VDJ08ev3ZC74aXA4nTvQibx9E5Za5zl18sBrjXVKLLc8H59YAjKFD3+wwN+zdX6Q8/4/
         XUznNdt2TJ+Pl4S6qqgtvdH/uoJnz4zPt6cUFAk/qXbQs8yTtNKxtLa0DeRP0HtWHMQ/
         Ot9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=5smxybzdNqxuKrC+BBuXRw8M7U1qM/sbfnyqES1mr5c=;
        b=Bm044PEppJ9/2ulYVEOfti32KrEXpbUoRl7eE73UKt6KD+5/2ljZyLw8Sh8gmmVIqF
         BredtbJ1SvQCR4NZTRks9aDD7cfr6y+ZdKk/2P6Qhbv4K0/zqRz0W2P/j5uLplw46HEv
         8HIQEq+2ltVtV5DnfYFdYuZ2afc/PIF8Y3sKkkutwCw82SutU5z6YXNR3nxqe4dDWZ/g
         tl+xBwYncQgrnc1KiiSp/T5RHTO08rgjKuipEJ5JAWXMxqNg1dolSLdsavN4MTcZ98T9
         j4zQX7lJbo9lxTvH6c9ezCaW/EZgt4ofjGE/ALe3yaixW2KnkCHmlib7HXxEivJ/iYDv
         813g==
X-Gm-Message-State: AOAM532pVihFB6fTRxvDsLRZeq+7b6mD7AdQx/xqyWFXuY+P+E7qRMr1
        8lyurWKSXGQzft8/yjd3mk7OyhH83y8=
X-Google-Smtp-Source: ABdhPJzmLMdqZFlElFF25rwU+cORKR2jbWJmA42TcqEZN+qWJPNBkj+gOPtnWRFxdDK6BMVrxJz1Fw==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr25610434wrn.114.1607430355849;
        Tue, 08 Dec 2020 04:25:55 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:580f:b429:3aa2:f8b1? (p200300ea8f065500580fb4293aa2f8b1.dip0.t-ipconnect.de. [2003:ea:8f06:5500:580f:b429:3aa2:f8b1])
        by smtp.googlemail.com with ESMTPSA id a18sm19483214wrr.20.2020.12.08.04.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 04:25:55 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Don't bother PCIe devices with trying to set MWI
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <86740fb7-5257-881c-e83a-7753f3b4badd@gmail.com>
Date:   Tue, 8 Dec 2020 13:16:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't bother PCIe devices with trying to set MWI.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9c49b96c2..b7f0883d6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4347,6 +4347,9 @@ int pci_set_mwi(struct pci_dev *dev)
 	int rc;
 	u16 cmd;
 
+	if (pci_is_pcie(dev))
+		return 0;
+
 	rc = pci_set_cacheline_size(dev);
 	if (rc)
 		return rc;
@@ -4374,6 +4377,9 @@ int pcim_set_mwi(struct pci_dev *dev)
 {
 	struct pci_devres *dr;
 
+	if (pci_is_pcie(dev))
+		return 0;
+
 	dr = find_pci_dr(dev);
 	if (!dr)
 		return -ENOMEM;
@@ -4413,6 +4419,9 @@ void pci_clear_mwi(struct pci_dev *dev)
 #ifndef PCI_DISABLE_MWI
 	u16 cmd;
 
+	if (pci_is_pcie(dev))
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	if (cmd & PCI_COMMAND_INVALIDATE) {
 		cmd &= ~PCI_COMMAND_INVALIDATE;
-- 
2.29.2


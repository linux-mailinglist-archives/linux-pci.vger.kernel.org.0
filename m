Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAEBCC9CE
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfJEMJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 08:09:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46028 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfJEMJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 08:09:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so10044269wrm.12
        for <linux-pci@vger.kernel.org>; Sat, 05 Oct 2019 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BKkF5+b2V8NBAHrbTEiaIHhBc1cU2f8cEaSBQmS03Ds=;
        b=X3SyAQSSak2hP05fmj8yhwHvcCzDj4wv7V7CgDXvSmeH+V3TmIlHcvCHAV34F4UBmU
         Uoew9WjdRNaYJ7323e+wuqZWiLzvpQTZCGiK53AL4gLq4cIJ9aaLwPMalO9rf6trbWrm
         7qmwk19Y3aq88+SDT7afm7CS9OFTruUTYuef8vRaKDr9GaM/gc3iFHpWepZhqAf/WWq2
         xL6aKRGO1HyVTAdclfEAttdm1Qy/tEDTcEr4sy2iFhRuay/+hF3rovt195fxdfZN+Pdf
         01kgZcztvZOwGG55CiAN4WUEy7dzXp7aWl/e8eNbL2XwEP53Yk1USZg/w+1r4PLHqJq3
         asAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BKkF5+b2V8NBAHrbTEiaIHhBc1cU2f8cEaSBQmS03Ds=;
        b=FdKd3UZG0PjvnuLYPBSJbCFze/eElRLD6VDBhrncIJwvPZ5l/eybQF0JKT6com3YUE
         bVKtdRkiMpSXTkk72KB7Lnb8WmanUyJ8eMleH1qbtPGRnImBdjg22TC/b32kyGvwMQSA
         J9rgx5+QpH2+HXIpWNXseh/hO6aXFHy7T5NpC2Rr0BmK6cFYe0/7qREAq5WIGZtJ2A26
         NV8HFlpJpnA7L9u2MTJ7yjI4dZ9upbciHXts2IbOgbkwxdHb0ADb2d7PhUMRP49ZDvx8
         NGnxWw2Q7Li1PhUhOOaQNTTFz1PY4dMmV3un6VeyWkOQmpLhG/ZcYg9QkGx1wWzIFvHC
         CdZQ==
X-Gm-Message-State: APjAAAWn5ey2pC5BN/WQ8S+MRRgTTuYUkIdZjbQ5IqOx6dagONGYdYOC
        YUFMqbiwDaMqaANTBX1XIsDRytnk
X-Google-Smtp-Source: APXvYqwpNohVLrP1gfYcWSymByu6xHSZNfeJG5KzHzZJb3UjFOXG06QWv4fh9NPyubBQtUoYboyhAw==
X-Received: by 2002:a05:6000:11d0:: with SMTP id i16mr5916749wrx.217.1570277382305;
        Sat, 05 Oct 2019 05:09:42 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:78ef:16af:4ef6:6109? (p200300EA8F26640078EF16AF4EF66109.dip0.t-ipconnect.de. [2003:ea:8f26:6400:78ef:16af:4ef6:6109])
        by smtp.googlemail.com with ESMTPSA id 13sm7050727wmj.29.2019.10.05.05.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 05:09:41 -0700 (PDT)
Subject: [PATCH v7 3/5] PCI/ASPM: Add and use helper pcie_aspm_get_link
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
Message-ID: <19d33770-29de-a9af-4d85-f2b30269d383@gmail.com>
Date:   Sat, 5 Oct 2019 14:07:18 +0200
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

Factor out getting the link associated with a pci_dev and use this
helper where appropriate. In addition this helper will be used
in a subsequent patch of this series.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v7:
- add as separate patch
---
 drivers/pci/pcie/aspm.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 574f822bf..91cfea673 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1066,19 +1066,28 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
+static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream;
+
+	if (pcie_downstream_port(pdev))
+		upstream = pdev;
+	else
+		upstream = pci_upstream_bridge(pdev);
+
+	return upstream ? upstream->link_state : NULL;
+}
+
 static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 {
-	struct pci_dev *parent = pdev->bus->self;
 	struct pcie_link_state *link;
 
 	if (!pci_is_pcie(pdev))
 		return 0;
 
-	if (pcie_downstream_port(pdev))
-		parent = pdev;
-	if (!parent || !parent->link_state)
+	link = pcie_aspm_get_link(pdev);
+	if (!link)
 		return -EINVAL;
-
 	/*
 	 * A driver requested that ASPM be disabled on this device, but
 	 * if we don't have permission to manage ASPM (e.g., on ACPI
@@ -1095,7 +1104,6 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (sem)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	link = parent->link_state;
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_disable |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
@@ -1188,14 +1196,14 @@ module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
  */
 bool pcie_aspm_enabled(struct pci_dev *pdev)
 {
-	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 	bool ret;
 
-	if (!bridge)
+	if (!link)
 		return false;
 
 	mutex_lock(&aspm_lock);
-	ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
+	ret = link->aspm_enabled;
 	mutex_unlock(&aspm_lock);
 
 	return ret;
-- 
2.23.0



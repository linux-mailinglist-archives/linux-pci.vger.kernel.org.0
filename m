Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456673628EE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 21:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbhDPTwm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 15:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhDPTwl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 15:52:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19294C061574
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 12:52:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u20so10336246wmj.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HOj00Gk52N7nOt2IKSKSD/MvqQ/sL2eaeADGpmhPkkA=;
        b=GWTH9DXUsq2aHRI4ZXgh9WlPis6AcsjjbDWYeCp8m/xSjOuT/fEX2CLOvDe8jszrUV
         SGxbtFVhcRLevRU9HTcezoauiamJyYt+MLstSliJ970PKpJHd1yS9HETpw6Vdd4cq/Nx
         ceQEiecxtsIyz+d8eaE0RuZYJRHXA0m744LFejKg6acx2AZxrQTzKe4CiiWLxrdRqs5B
         3ryZtz7+ZjqxeIK5BxXfgK7rLniMJkvaFVmGd3S1S01vPZpGIl2Wkx2bEpgl55Gw/Z/K
         VmtUt9e1RoO9tqSNwuUFqPADep5TDZtcT9YhzCNaMHHblhAM2pEN4clU/i/+tT+zXR5f
         LWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HOj00Gk52N7nOt2IKSKSD/MvqQ/sL2eaeADGpmhPkkA=;
        b=FlDhzZ5JJ1FdRn13mRe86V3nZs3LYnZNpiBpvB4QR2IudomYpLFH2cUA6zmV7cvs2o
         pd7H7ZBlZxLgq/vreYy8Lbjbq7KbFvmDTgxvtq4RG8VE/uMjA5skK2JZq4wMS9A08R6n
         +w91f3/b+goxBMaRGhKTc0R3kohpNzi7WZmO7nIEZZXWHjpmlA+ThCZqe6e3+iMY6iuB
         +a4/scQGJB77bP7FXFeL2ubxlr629/996IvIERKkzkCctC1OHWqNZAAGueUzpxKklo8B
         LP/tCE2kl/MTyg8B5bN1L6/VqW9j6BauWvEB9iTqBMp68LuivU2QPqEJOz7bQya67AME
         8w9Q==
X-Gm-Message-State: AOAM5333vtbV7TD3nBWJ3nLVzqE9FFivFfvEQbqDw3upjtNukptkup1y
        ts72IkPz+edvBdfxN7Cnq5EjPYje2Gjs/w==
X-Google-Smtp-Source: ABdhPJwdRupUZOk14TyyOpADKjzOvWTsBoeqvHg8hFRwL5/zkVG3T9amvm3yO09uWBoKUQ8VbNpabg==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr9595186wmi.126.1618602733557;
        Fri, 16 Apr 2021 12:52:13 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:90ba:9dfd:13a:f370? (p200300ea8f38460090ba9dfd013af370.dip0.t-ipconnect.de. [2003:ea:8f38:4600:90ba:9dfd:13a:f370])
        by smtp.googlemail.com with ESMTPSA id u8sm11885860wrp.66.2021.04.16.12.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 12:52:13 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Add helper pci_get_func0_dev
Message-ID: <75d1f619-8a35-690d-8fc8-e851264a4bbb@gmail.com>
Date:   Fri, 16 Apr 2021 21:52:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The combined use of the PCI_DEVFN() and PCI_SLOT() macros in several
places is unnecessarily complex. Use a simplified version and add
a helper for it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 42f762ab0..60573f27a 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -28,6 +28,12 @@ struct pci_vpd {
 	unsigned int	valid:1;
 };
 
+static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
+{
+	/* bits 2:0 in devfn is the device function */
+	return pci_get_slot(dev->bus, dev->devfn & 0xf8);
+}
+
 /**
  * pci_read_vpd - Read one entry from Vital Product Data
  * @dev:	pci device struct
@@ -305,8 +311,7 @@ static const struct pci_vpd_ops pci_vpd_ops = {
 static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
 			       void *arg)
 {
-	struct pci_dev *tdev = pci_get_slot(dev->bus,
-					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	struct pci_dev *tdev = pci_get_func0_dev(dev);
 	ssize_t ret;
 
 	if (!tdev)
@@ -320,8 +325,7 @@ static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
 static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
 				const void *arg)
 {
-	struct pci_dev *tdev = pci_get_slot(dev->bus,
-					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	struct pci_dev *tdev = pci_get_func0_dev(dev);
 	ssize_t ret;
 
 	if (!tdev)
@@ -414,7 +418,7 @@ static void quirk_f0_vpd_link(struct pci_dev *dev)
 	if (!PCI_FUNC(dev->devfn))
 		return;
 
-	f0 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	f0 = pci_get_func0_dev(dev);
 	if (!f0)
 		return;
 
-- 
2.31.1


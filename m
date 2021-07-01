Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E43B97C2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhGAUqf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 16:46:35 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41897 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAUqf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 16:46:35 -0400
Received: by mail-lj1-f170.google.com with SMTP id h6so10263380ljl.8
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 13:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQF8cLAtr4vueW7JSMUMX/IBfK/Lv//HrORl0QoGClk=;
        b=TA6Fod1aWN2YoC7zdytK6spFM0+NujFcK0f6OIW5GYfR/VqlVkSC8vRTpBFHPHEVCp
         a5aoUZc94xxsK8fjx90VLvNzXf6q0HsacyEEW4Yh+h9yUEoruCRg9dQKCPOYumBu0VYl
         HgqiwKFMANyvVVdiuBuJV1ppXgPB4iU5Ws8UrQWTqxeYTL5NSMTCKLTbrqrwuB9DUh+2
         Z5Cp+s6C1rCiXH3Tek2wpvIsISN2HFhSPsLo7obyytHzzjVvS4G9E8Oux+XvN98wJMXu
         T4c6cmdw32wQee9N/e242GO5WFJJZRdsTaMIFvE2U18uxiQDYFK4Gx+Q/VZROsV1v2AR
         e6SQ==
X-Gm-Message-State: AOAM532hyfx0+pTRQoC05mfpTA6S2yFc3I9WyXnk3R4hyXNH8IcQ21Wj
        fGU/2xLVdZmw41PoNluSRwc=
X-Google-Smtp-Source: ABdhPJxsNX3q+LRBdTiuUvN3gUVBZL29ogbKwTVEs4+iAwE0kaiAYYiTHT+ozqWLZjJVmS0oIIGzZg==
X-Received: by 2002:a2e:a706:: with SMTP id s6mr1063996lje.169.1625172243348;
        Thu, 01 Jul 2021 13:44:03 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w8sm69942lfq.27.2021.07.01.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:44:02 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: artpec6: Remove surplus break statement after return
Date:   Thu,  1 Jul 2021 20:44:00 +0000
Message-Id: <20210701204401.1636562-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As part of code refactoring completed in the commit a0fd361db8e5 ("PCI:
dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
code") the function artpec6_add_pcie_ep() has been removed and the call
to the dw_pcie_ep_init() has been moved into artpec6_pcie_probe().

This change left a break statement behind that is not needed any more as
as the function artpec6_pcie_probe() return immediately after making
a call to dw_pcie_ep_init().

Thus remove this surplus break statement that became a dead code.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 597c282f586c..739871bece75 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -445,7 +445,6 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		pci->ep.ops = &pcie_ep_ops;
 
 		return dw_pcie_ep_init(&pci->ep);
-		break;
 	}
 	default:
 		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
-- 
2.32.0


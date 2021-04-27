Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E743D36CAA6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhD0Rwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbhD0Rwm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 13:52:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A168C061763;
        Tue, 27 Apr 2021 10:51:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h20so31318621plr.4;
        Tue, 27 Apr 2021 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jiipAsdDAcWlKdQjKY9n5M1r8f05IAR9cMGWFIS34F0=;
        b=hPMjlmoOuIUZ3C5DGZchaD2tsGt5B76Llw9rbAkVaizKoIZgvw060WzJHMt5oKMjbu
         LGiYJRjTQojS9n8vI/CfsucS9s42iSiunAazCphzMnAtGiP0Jry8hx2C6+Q5bOIuU53+
         3gSLZ6aPTYQq3tHZG2OCFZuWEXK25fouBZudK0lfifTD9Omyj2w3nZPKV/Z/Sh9E9Ytz
         HkQNM9ItJh/s6boqBuzxR+Pliqara/Yl5PF+cCUEuuQA3K9CL+2zAG+OOLy2sTEePvi3
         4DycYR42e4mJ0XkwCb2TVnqUBmkwBqPet2Yh+yCayLN9RD6B9Ww8Vz0Iy8nF9IxYitgU
         eR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jiipAsdDAcWlKdQjKY9n5M1r8f05IAR9cMGWFIS34F0=;
        b=TiznaZEHCMtC2Mk9m69+WqaCyyQTvAgeJfjUECjmL8xXPM8TE9BKAs1f7hpRXvTO7L
         qfNK8RHo4mjxeNM15i65qv9NR6psT2Iskl9VJJrGH/oU8lQJwkGBV0obAVgRPFpJ88dB
         3XxC0VJTYFQmCsuIhKqFlPpoKd8wB0FSqGjraLMUL+jjQdnTvHh/P3eDOnFrvqPBqEI4
         ryzH9T1VucJd6pzyv5LyCyhy+EDbJOV/kOwQfijjXcp6fRVg2T48iJ81WYhHYoacIlD8
         njqAqevtpBAxaOLEQSsiPdRtp6skNWKih/nfFBym/rijMl49YzqcLTWYGOGlgPGqmQxu
         Q9LA==
X-Gm-Message-State: AOAM533qIYB3JdsTqaJonE6uu14wF2vH8I7Ml7QYw0DTmYaHthCgsgyn
        bF0yykuPs3rRpzKgQGGCRnTQcnMg1YA=
X-Google-Smtp-Source: ABdhPJynTAfXzItwN2Cr+tVlU0GDgflTrBaY3jF7/6SbzWDHNNgu/uH9c/JnVpRZbze56TA1Eqx1IA==
X-Received: by 2002:a17:90a:a60b:: with SMTP id c11mr28260596pjq.125.1619545917681;
        Tue, 27 Apr 2021 10:51:57 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h21sm2456833pfo.211.2021.04.27.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:51:57 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 4/4] PCI: brcmstb: add shutdown call to driver
Date:   Tue, 27 Apr 2021 13:51:39 -0400
Message-Id: <20210427175140.17800-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427175140.17800-1-jim2101024@gmail.com>
References: <20210427175140.17800-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The shutdown() call is similar to the remove() call except the former does
not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
if it does.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index d3af8d84f0d6..a1fe1a2ada48 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1340,6 +1340,15 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void brcm_pcie_shutdown(struct platform_device *pdev)
+{
+	struct brcm_pcie *pcie = platform_get_drvdata(pdev);
+
+	if (pcie->has_err_report)
+		brcm_unregister_die_notifiers(pcie);
+	__brcm_pcie_remove(pcie);
+}
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
@@ -1460,6 +1469,7 @@ static const struct dev_pm_ops brcm_pcie_pm_ops = {
 static struct platform_driver brcm_pcie_driver = {
 	.probe = brcm_pcie_probe,
 	.remove = brcm_pcie_remove,
+	.shutdown = brcm_pcie_shutdown,
 	.driver = {
 		.name = "brcm-pcie",
 		.of_match_table = brcm_pcie_match,
-- 
2.17.1


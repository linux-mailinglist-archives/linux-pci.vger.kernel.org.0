Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA1845A69C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhKWPlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbhKWPlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56608C061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i12so19113122wmq.4
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9wk5q1358/5Vlb56q2MYNKy0d2YBmk+eon1csfd8FM=;
        b=M2AX13dlw+7wLdodh5vsTckcKtzjf9M0ypxqromaa1VyajkbR2ekvrhMoz4CA1cZKV
         AH4os3AQczHrov14bjL7d6w8wvk0PoPrEBj996yuG6kHXhUxQjGCZ/BP/hCBYRSLeyJ2
         IjgE/Tvw1JWs1NnVBR7AdpOXWnIA3CUEasgm8AiJfgrM8rW2u5JUAJwKfrcnj/pIoO5F
         9V6n63pMw9SlR8ztUxap8Nd59FNwhyyuxX5kvvrQIHKkO+DXzDGudGqeynW0jRGAUzZ4
         SCcj8JtcCNkTIao0GaQRD7J+bf1jzvOnCVCcnMXQvAG1y7H8P559JCegKxt2XJXUC7b+
         dU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9wk5q1358/5Vlb56q2MYNKy0d2YBmk+eon1csfd8FM=;
        b=UtnIO+7EPf2ptJ8tjPNAB96TcFV/RQCqjx6qPfr9NjC096kib69o0l/P5OVj7PcymK
         JHny3BEWhmPkHNxT3AQezPTeTAMrPX7sGn+62ubdC9x8SMYsPaMbPz7vQnHOcoXcqyw0
         K8oGeuM80XGPxIguR5Mof1iHyLBjLS18u/OnQWaiGeklFoUkCv0OOjMEHM1U56UiAP5e
         +IM4A0hCyzo5qpGPNUGwu4ZPh1mmW03FyS8e28Zr+/TaipsNa8zzY4pjX6KXYfbLJsPQ
         08GGWLvcUqA1zgLNWOjFxu36pAIo3C0E3lIUDNFZNR+HwENyquvjoUP+LoWV7EpMpk5C
         wxnw==
X-Gm-Message-State: AOAM530mmHAdzVhmu4824dhdPgob1Ka22H4nMX86u73e83xbAEvYQ3Im
        Y4AlZUEAB5cu+LkOeMiLg8M=
X-Google-Smtp-Source: ABdhPJyOGgpslq5R4gMR1MgO6MjdRE1S/WlNt6I5QD123/kUBIx0wctMwYzn5pgwZLMQcqJQHs2+kg==
X-Received: by 2002:a1c:a592:: with SMTP id o140mr4326468wme.10.1637681892879;
        Tue, 23 Nov 2021 07:38:12 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id h15sm1959273wmq.32.2021.11.23.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:12 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 3/7] PCI: kirin: Prefer of_device_get_match_data() over of_match_device()
Date:   Tue, 23 Nov 2021 16:37:58 +0100
Message-Id: <68f844d7a481ade650c9bcce77f553efb9df01b4.1637678104.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637678103.git.ffclaire1224@gmail.com>
References: <cover.1637678103.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The kirin PCI controller driver only needs "enum pcie_kirin_phy_type"
during probe(). Replace of_match_device(), which returns "struct
of_device_id *", with of_device_get_match_data(), and cast to long type,
referring "enum pcie_kirin_phy_type".

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 095afbccf9c1..8d6e241bd171 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -773,7 +773,6 @@ static const struct of_device_id kirin_pcie_match[] = {
 static int kirin_pcie_probe(struct platform_device *pdev)
 {
 	enum pcie_kirin_phy_type phy_type;
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct kirin_pcie *kirin_pcie;
 	struct dw_pcie *pci;
@@ -784,13 +783,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	of_id = of_match_device(kirin_pcie_match, dev);
-	if (!of_id) {
+	phy_type = (long)of_device_get_match_data(dev);
+	if (!phy_type) {
 		dev_err(dev, "OF data missing\n");
 		return -EINVAL;
 	}
 
-	phy_type = (long)of_id->data;
 
 	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
 	if (!kirin_pcie)
-- 
2.25.1


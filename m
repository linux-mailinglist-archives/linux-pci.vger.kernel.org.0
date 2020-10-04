Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA4282C1A
	for <lists+linux-pci@lfdr.de>; Sun,  4 Oct 2020 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJDSAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgJDSAa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2020 14:00:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B00C0613CE;
        Sun,  4 Oct 2020 11:00:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so6988522edt.4;
        Sun, 04 Oct 2020 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdhMI4lYm4U9Gn9W3t4+uBt18XpMNvp15ZAaFoLeG4g=;
        b=GAl6O4InbEtFPumIYfjAyh30DTfFqKgtr7Sq/L+G2Xsu4UmThzOjHuxWn4Ty3WOshe
         25fUVo4GJmfohTpHHERiAMWPGffOzRBI4b2+TK666F59PX24q7alhkTKEGuaYmVrlg3Q
         8kPhnCQNkPgAxbmppGvPZGWT3ZJENMJN1+vGkk2WWwul/73LVoC3R3Ar50SA8s4Pdhaz
         D9hwEz6Y+2Z6GZil0W3ciMgNQK3n+uo/Ik6LEbti/QBW0inAUBulQHy3REWCzPb2/dbm
         8s9yDAgPgrYpvmQrXIjY1mNhreJ3VyWyVXAznMX2XpAIiO3eQsDGWMrQBAhDKNBJPXW2
         +N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdhMI4lYm4U9Gn9W3t4+uBt18XpMNvp15ZAaFoLeG4g=;
        b=EOqhNAUQUmzBDZCnMPSY7Y463nowpgQj4bXxAgqh6/ItVLhMH1rZ3f3VDK1bmEuOst
         DzxVu4K+PEEJgYFp2yq3ilnvr+upHvP5zQk2oT6BC59oSFalKtyda2+blOOUbUe7WExj
         UqJHYZfJi08aw1+lbi6O62Mn8OspmwzhiE5K+NVGAfcrh3SiBciYkiuf5eZSN2kcgj2Q
         AAXP+PTO03+GPI8Hfgkenfzx2o350zIU5wUQ0cj8VEhYN/QTqYfIqXrGyvLghcd3hc93
         11xfUWAuvtqxzXGStQqDfj/EB+powkoMMenZ2HKJWiAuyK4X2vlx9aORXhqkPmNu8CnP
         KHNQ==
X-Gm-Message-State: AOAM531HpteWyiVmDs8UsjktM4W5xhPb1sLpfxRDYPfVYOyAYtpCdl8h
        MT/LRGTfIfza2dEwxm64rAIPLUIx/vs=
X-Google-Smtp-Source: ABdhPJxNIdi2effBMCyvjbegYSqu0lmlYJPe9ipBbUHK1Gk/bnfeoZnzI/x8eTAIXy9ON561PQbmOQ==
X-Received: by 2002:a05:6402:17ed:: with SMTP id t13mr13685510edy.163.1601834427677;
        Sun, 04 Oct 2020 11:00:27 -0700 (PDT)
Received: from localhost.localdomain (p4fc3e21a.dip0.t-ipconnect.de. [79.195.226.26])
        by smtp.googlemail.com with ESMTPSA id n11sm6065906ejs.38.2020.10.04.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 11:00:27 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, robh+dt@kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH 1/3] PCI: Add the IDs for Etron EJ168 and EJ188
Date:   Sun,  4 Oct 2020 18:29:06 +0200
Message-Id: <20201004162908.3216898-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the vendor ID for Etron Technology, Inc. as well as the device IDs
for the two USB xHCI controllers EJ168 and EJ188.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/linux/pci_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1ab1e24bcbce..1c8370aa4b95 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2587,6 +2587,10 @@
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
+#define PCI_VENDOR_ID_ETRON		0x1b6f
+#define PCI_DEVICE_ID_ETRON_EJ168	0x7023
+#define PCI_DEVICE_ID_ETRON_EJ188	0x7052
+
 #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
 
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
-- 
2.28.0


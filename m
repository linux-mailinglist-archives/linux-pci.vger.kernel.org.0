Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA741D2229
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 00:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgEMWjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 18:39:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37757 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgEMWjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 18:39:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so818693oto.4
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2020 15:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/fu8TLz8jMdgWXPjJ647tXyxXzNUWdC9h5Gz1jMuvU=;
        b=sIqOpDpvSCFABMpYFfa5oUI8I6lgFdyanTemg6INhHX4+3oq7p9Diu1qF2Lf5qEX6a
         JSbfZrtuwwvVZFFtEq7AAbLyiDtAS81+ghBFGe+LZOkdDBbwwl+5DADopQgpO5mRigli
         TDuEGLKTNQzdQ/if5OEA01KUd3Rbb0LaV+cBuJrK7s87VdLnRm/qWZMHIXHnsFuQg+Ti
         QQTfT+AgozOa6rR+tdWKOmt8dutBb3OlCuJ5jZQvgrz8Sv1yz9GOhp4ysfvVAPbjAPRI
         JA37VYvsZ6HHvDALOu2W5sHrnqW4ZKUtyi2jPGZjnSzEJNgkTSv360AUTPUw6sl3Zsir
         OZbw==
X-Gm-Message-State: AOAM5308D9t2hidZc1eoyG8jb8PLbbYguOgwd9FEnm2Arei2zpQua1x2
        qTrXbnVBAAEYUt29iOxlGw==
X-Google-Smtp-Source: ABdhPJyUBHCW4ulIK1t15H0Of7z+gix2mM+CaVhZqFvtT83AKz2nxQc8mLsuH+u0RUcgAp7kGzQZoQ==
X-Received: by 2002:a05:6830:138c:: with SMTP id d12mr1398056otq.310.1589409542578;
        Wed, 13 May 2020 15:39:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s13sm6406090oic.27.2020.05.13.15.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 15:39:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] PCI: Fix pci_host_bridge struct device release/free handling
Date:   Wed, 13 May 2020 17:38:59 -0500
Message-Id: <20200513223859.11295-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513223859.11295-1-robh@kernel.org>
References: <20200513223859.11295-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI code has several paths where the struct pci_host_bridge is freed
directly. This is wrong because it contains a struct device which is
refcounted and should be freed using put_device(). This can result in
use-after-free errors. I think this problem has existed since 2012 with
commit 7b5436635800 ("PCI: add generic device into pci_host_bridge
struct"). It generally hasn't mattered as most host bridge drivers are
still built-in and can't unbind.

The problem is a struct device should never be freed directly once
device_initialize() is called and a ref is held, but that doesn't happen
until pci_register_host_bridge(). There's then a window between
allocating the host bridge and pci_register_host_bridge() where kfree
should be used. This is fragile and requires callers to do the right
thing. To fix this, we need to split device_register() into
device_initialize() and device_add() calls, so that the host bridge
struct is always freed by using a put_device().

devm_pci_alloc_host_bridge() is using devm_kzalloc() to allocate struct
pci_host_bridge which will be freed directly. Instead, we can use a
custom devres action to call put_device().

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/probe.c  | 36 +++++++++++++++++++-----------------
 drivers/pci/remove.c |  2 +-
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e21dc71b1907..e064ded6fbec 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -565,7 +565,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	return b;
 }
 
-static void devm_pci_release_host_bridge_dev(struct device *dev)
+static void pci_release_host_bridge_dev(struct device *dev)
 {
 	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
 
@@ -574,12 +574,7 @@ static void devm_pci_release_host_bridge_dev(struct device *dev)
 
 	pci_free_resource_list(&bridge->windows);
 	pci_free_resource_list(&bridge->dma_ranges);
-}
-
-static void pci_release_host_bridge_dev(struct device *dev)
-{
-	devm_pci_release_host_bridge_dev(dev);
-	kfree(to_pci_host_bridge(dev));
+	kfree(bridge);
 }
 
 static void pci_init_host_bridge(struct pci_host_bridge *bridge)
@@ -599,6 +594,8 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+
+	device_initialize(&bridge->dev);
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
@@ -616,17 +613,25 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 }
 EXPORT_SYMBOL(pci_alloc_host_bridge);
 
+static void devm_pci_alloc_host_bridge_release(void *data)
+{
+	pci_free_host_bridge(data);
+}
+
 struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 						   size_t priv)
 {
+	int ret;
 	struct pci_host_bridge *bridge;
 
-	bridge = devm_kzalloc(dev, sizeof(*bridge) + priv, GFP_KERNEL);
+	bridge = pci_alloc_host_bridge(priv);
 	if (!bridge)
 		return NULL;
 
-	pci_init_host_bridge(bridge);
-	bridge->dev.release = devm_pci_release_host_bridge_dev;
+	ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
+				       bridge);
+	if (ret)
+		return NULL;
 
 	return bridge;
 }
@@ -634,10 +639,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
-	pci_free_resource_list(&bridge->windows);
-	pci_free_resource_list(&bridge->dma_ranges);
-
-	kfree(bridge);
+	put_device(&bridge->dev);
 }
 EXPORT_SYMBOL(pci_free_host_bridge);
 
@@ -908,7 +910,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (err)
 		goto free;
 
-	err = device_register(&bridge->dev);
+	err = device_add(&bridge->dev);
 	if (err) {
 		put_device(&bridge->dev);
 		goto free;
@@ -978,7 +980,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 unregister:
 	put_device(&bridge->dev);
-	device_unregister(&bridge->dev);
+	device_del(&bridge->dev);
 
 free:
 	kfree(bus);
@@ -2953,7 +2955,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	return bridge->bus;
 
 err_out:
-	kfree(bridge);
+	put_device(&bridge->dev);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e9c6b120cf45..95dec03d9f2a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -160,6 +160,6 @@ void pci_remove_root_bus(struct pci_bus *bus)
 	host_bridge->bus = NULL;
 
 	/* remove the host bridge */
-	device_unregister(&host_bridge->dev);
+	device_del(&host_bridge->dev);
 }
 EXPORT_SYMBOL_GPL(pci_remove_root_bus);
-- 
2.20.1


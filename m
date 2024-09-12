Return-Path: <linux-pci+bounces-13065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E5976055
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 07:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B991F234C9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 05:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDB146A6F;
	Thu, 12 Sep 2024 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFtSTXGh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C82C80
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726119043; cv=none; b=AMofyyRs2sf8GbuWy02vKU2qnjdCzaFNsyue4K/5wd8Vil2gYmk9pEUuc+YEOZwJlaWHrsIQ7tEEXTjUmcYmve4wlxHFLmnDp2l9r4TWGWEOE8DQS/sP9ty6OqmNsRSRfK7FMp1JePZsE8DV0P/GPBmqGsAxc82+UNKzYIPfdWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726119043; c=relaxed/simple;
	bh=zvdkoE3BvaRWBAJT+6hVKQfvf0deVHtcNW73hBtJNzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qi5I3YWL8TkKXMzfPYV6EDivCOHm/VFGJzBbGoNUny+6cbxepNxTA+BNWhEWk70VSq2BCAykRcrYWLegB6Gz3NbpYUfo/lkkIU1omuYckcC2Ip+JM0hQKXorxJSPgKzoHmK2xH3vVSG0CbtpxOCY3mjDFMlN1ywpl7FLAoEtmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AFtSTXGh; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e03974b6a5so256505b6e.3
        for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726119040; x=1726723840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DkPd0Cr7x8f24pxEWoJCTBS7zwjsrOd1iZVMDN4zQlE=;
        b=AFtSTXGhYAtfrcO6leA6Nhp0mZbWTJfXxp8M8SSq6lw73rYRmMobhJklUyb9igHpPo
         HGKgrwF+SqfohWrDNnQSLKgNmKVXB1YBeTp76TJm4+2Iv5XvExi2h/jD6eYSgOwupgQi
         uRODCoOD8oAdtTyhRtyQ4ivtE+Ciy7Kg1NKJuz+AYITpZahKhlZd6gP4wN7p6rhz6iHi
         D+phZihTJOsQe99AMSJzjptZqHLaZBmd2xC9IVTy9utThGGWDHskSery1b9kkIURWk7+
         w8S6BPjKUmCh9X5+HY7fShV9a8zvxU2FbqwZAIVQ4cHUKktKMJFFhHKO9wPYmkd9NC40
         csuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726119040; x=1726723840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkPd0Cr7x8f24pxEWoJCTBS7zwjsrOd1iZVMDN4zQlE=;
        b=ZAKz0OQLIozUToElNQnGG50gJzNZOpj4lCAumKdHjMSi8ZQlI1MHZOIfj9WG2b1GuX
         C0XMqGc3BT/0HuJdEOCEcR69nZXNsmOeJYUg8Y9bFUYCET5GN9G/ZhKVqJULTc5EqRbV
         9JW7Zjm083VFLhG0ISv5bMgX9egXNqBHKQs4Usb0skdkZetPTzK/OyRqbRExh27mlLnC
         N++tqRl9wfPDSj7VfQaTmYiLszEH0jYkx3wILZ3hQCDjWkqgWPllcE7EaRwMBYQi64tO
         /lpC/7e9IRLN9zGW8zc/Vx7Kd1oo4bSgegjvSi0f+Q6qkduRwmpnA6CfWNZFGMGFAIgp
         TcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO3ve2wQkVaXvESAGscQmpg78OfqEVve4B+xe9/n1BWeDHdrGWj062pPWvEfxQ4vlZXjruqY7TOpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6J7FUu89QeXux61m+Exbkaj96oDvnOxA3tX87O4zFMePPbFGF
	nf7ZrW+fJMDkoeJiCoHJTh1z4b2edObF6iKy+cjC4/qZWXbbdeuDLNKPwvi6Ow==
X-Google-Smtp-Source: AGHT+IHU8FR+L/XU0vdhAEGs/bYRvW8pdSvNBRYhhxU+psuWfbVZBWUIot9yMuEwen0zemMyw1h03w==
X-Received: by 2002:a05:6808:159e:b0:3e0:391f:dc83 with SMTP id 5614622812f47-3e071ae75f2mr1029644b6e.36.1726119040485;
        Wed, 11 Sep 2024 22:30:40 -0700 (PDT)
Received: from localhost.localdomain ([120.60.130.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbbeecasm916935a12.42.2024.09.11.22.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 22:30:39 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com,
	kw@linux.com
Cc: kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] PCI: Pass domain number explicitly to pci_bus_release_domain_nr() API
Date: Thu, 12 Sep 2024 11:00:25 +0530
Message-Id: <20240912053025.25314-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_bus_release_domain_nr() API is supposed to free the domain number
allocated by pci_bus_find_domain_nr(). Most of the callers of
pci_bus_find_domain_nr(), store the domain number in pci_bus::domain_nr.

So pci_bus_release_domain_nr() implicitly frees the domain number by
dereferencing 'struct pci_bus'. But one of the callers of this API, PCI
endpoint subsystem doesn't have 'struct pci_bus', so it only passes NULL.
Due to this, the API will end up dereferencing the NULL pointer.

To fix this issue, let's just pass the domain number explicitly to this
API. Since 'struct pci_bus' is not used for any other purposes in this API
other than extracting the domain number, it makes sense to pass the domain
number directly.

Fixes: 0328947c5032 ("PCI: endpoint: Assign PCI domain number for endpoint controllers")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pci/c0c40ddb-bf64-4b22-9dd1-8dbb18aa2813@stanley.mountain
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c |  2 +-
 drivers/pci/pci.c                   | 14 +++++++-------
 drivers/pci/probe.c                 |  2 +-
 drivers/pci/remove.c                |  2 +-
 include/linux/pci.h                 |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 085a2de8b923..17f007109255 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -840,7 +840,7 @@ void pci_epc_destroy(struct pci_epc *epc)
 	device_unregister(&epc->dev);
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	pci_bus_release_domain_nr(NULL, &epc->dev);
+	pci_bus_release_domain_nr(&epc->dev, epc->domain_nr);
 #endif
 }
 EXPORT_SYMBOL_GPL(pci_epc_destroy);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..b86693c91753 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6801,16 +6801,16 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
 }
 
-static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
+static void of_pci_bus_release_domain_nr(struct device *parent, int domain_nr)
 {
-	if (bus->domain_nr < 0)
+	if (domain_nr < 0)
 		return;
 
 	/* Release domain from IDA where it was allocated. */
-	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
-		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
+	if (of_get_pci_domain_nr(parent->of_node) == domain_nr)
+		ida_free(&pci_domain_nr_static_ida, domain_nr);
 	else
-		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
+		ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
 }
 
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
@@ -6819,11 +6819,11 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 			       acpi_pci_bus_find_domain_nr(bus);
 }
 
-void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
+void pci_bus_release_domain_nr(struct device *parent, int domain_nr)
 {
 	if (!acpi_disabled)
 		return;
-	of_pci_bus_release_domain_nr(bus, parent);
+	of_pci_bus_release_domain_nr(parent, domain_nr);
 }
 #endif
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..e9e56bbb3b59 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1061,7 +1061,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	pci_bus_release_domain_nr(bus, parent);
+	pci_bus_release_domain_nr(parent, bus->domain_nr);
 #endif
 	kfree(bus);
 	return err;
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 910387e5bdbf..d2523fdf9bae 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -163,7 +163,7 @@ void pci_remove_root_bus(struct pci_bus *bus)
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	/* Release domain_nr if it was dynamically allocated */
 	if (host_bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
-		pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
+		pci_bus_release_domain_nr(host_bridge->dev.parent, bus->domain_nr);
 #endif
 
 	pci_remove_bus(bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..37d97bef060f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1884,7 +1884,7 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 { return 0; }
 #endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
-void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent);
+void pci_bus_release_domain_nr(struct device *parent, int domain_nr);
 #endif
 
 /* Some architectures require additional setup to direct VGA traffic */
-- 
2.25.1



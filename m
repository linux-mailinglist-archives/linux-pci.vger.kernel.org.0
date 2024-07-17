Return-Path: <linux-pci+bounces-10420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A8A933605
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 06:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E09F28449B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 04:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE78469D;
	Wed, 17 Jul 2024 04:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEAVasDS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A879FD
	for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 04:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721190482; cv=none; b=ryLitpRRMNfG8imUWF6r7sA9p+Zgn4MaOVjFNa+cRruvruCB00wGQGoozC8nYJVKohZh30BGqRqeqiX6P7wg7zAIFKbies0+ZvAVA9GL2baxfPH3qhhK4NY02JeG6gtdtPouOfs5EGm9nDM44imrAHxleEKtZNFDJeq18M+cJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721190482; c=relaxed/simple;
	bh=5yvr1C3OyUG6Njd+0y6Sd8Bq9qPSsr9WMtTbIENi7r8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s+U1W60WEBv8JPlqo+UGg0GrUap7QGOranThRVDuZ85TJbchfHQ7T8O+Jj9OjCr+EouS3AoTBM/seUE1hjP24Guc9eqEdKgJLNPbSwznRnjuWLEXMR/BIUjsg+6BmQCp/QZ948lpatr1VWNBs6YMfiY26jh7fM1Euc8IRUTByTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xEAVasDS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso4741313b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 21:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721190480; x=1721795280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pt6gY0086xG9hv3Wd3+MWNDnw87cQj+/HrgKVsB7LW8=;
        b=xEAVasDSJUd++l5iya2spUhSkmpQ5xbaDqoEJbIsW1dZ1KQt9W5QeMqE/QmG9PUHTO
         sGI5URgmR2ESVJgGjhYjd7btx5fJno7l8h9cx/lLySo3yFWXcb/95gXmMkF+5ii/aO+L
         52JJMYRb7AuL2OgEJ9wDJTyhTsvkrCY+1kkhh8jTAvc9hBawcht11qvkLS3N1whjioAS
         /oFGDifehvzuZ+ZRVv3n+V+8gpa1nzJb/apAcw9WbuSuuQOx48nof+hjt04KLl0KaTZ1
         4A4lCJ0WDfUDDDmxfHZa6rB3XkZPoGC/0vFhTA0J4vDE8cMacJ1FE5Zcl8qwcaWPTkXr
         1pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721190480; x=1721795280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt6gY0086xG9hv3Wd3+MWNDnw87cQj+/HrgKVsB7LW8=;
        b=HHgb87xfRK4LlPBN1founYXyYZBmg6ztoFmoDj8sDaR2TQ15uYUSQQFHwEMWnblw0L
         3Qh6wI6B4HM624RsvwrhFRdgxfMYkpqfz1I00nxJIOYp77HdlmcTjpOirR2lldwBEvNN
         EHXZTSUyGpj69mfG4iUhqpNQmsLI7Aof3tSH2v+HSFHJB+EgJvF/ud51+2785sX1LkU2
         KRRV2EBokrVLkgztRMcHc6roTSMWo0eOGDv0cfVvqSxIF4dwoZXwMIMD7Y/p1qL8qC1y
         rqluDTYV7962djseDI6o6I9Z5a2wf42BJUuEMh3ReJzufJ0D1dSFHG+KZti4BlR3N3d2
         1tIA==
X-Forwarded-Encrypted: i=1; AJvYcCXnHxl+CXeS/woLYjVloNMfAF8xNfj6/UwvKHxJOWW5a2l9EwpJwX3r8HS8rE0v+pN2G+8Ll/sKyPGrYqUjYiYfg6uc1IYgYdbG
X-Gm-Message-State: AOJu0YwGTF55/myfcKVnpG0+dkt2UXY0GbrX/lHlFAgDl0x+E9ywyvJ3
	VlPbBWaobeAqjckydFSH6IZFCqvk031TFiG42j4sOcgyyVIyp0kbECN1kspLew==
X-Google-Smtp-Source: AGHT+IF2r67aEOlDm8IfXFlJ7mPLmcBYBY5HxMG4efU7XKetTNpJekMsfas9W/sdXDxqUueT8mTqcQ==
X-Received: by 2002:a05:6a00:2381:b0:706:7943:b9aa with SMTP id d2e1a72fcca58-70ce4e8d73fmr719467b3a.5.1721190479851;
        Tue, 16 Jul 2024 21:27:59 -0700 (PDT)
Received: from localhost.localdomain ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d517sm7196738b3a.127.2024.07.16.21.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 21:27:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] PCI: Check for the existence of 'dev.of_node' before calling of_platform_populate()
Date: Wed, 17 Jul 2024 09:57:46 +0530
Message-Id: <20240717042746.8766-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 50b040ef3732 ("PCI/pwrctl: only call of_platform_populate() if
CONFIG_OF is enabled") added the CONFIG_OF guard for the
of_platform_populate() API. But it missed the fact that the CONFIG_OF
platforms can also run on ACPI without devicetree (so dev.of_node will be
NULL). In those cases, of_platform_populate() will fail with below error
messages as seen on the Ampere Altra box:

pci 000c:00:01.0: failed to populate child OF nodes (-22)
pci 000c:00:02.0: failed to populate child OF nodes (-22)

Fix this by checking for the existence of 'dev.of_node' before calling the
of_platform_populate() API. This also warrants the removal of CONFIG_OF
check, since dev_of_node() helper will return NULL if CONFIG_OF is not
enabled.

While at it, let's also use dev_of_node() to pass device OF node pointer
to of_platform_populate().

Fixes: 50b040ef3732 ("PCI/pwrctl: only call of_platform_populate() if CONFIG_OF is enabled")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/linux-arm-msm/CAHk-=wjcO_9dkNf-bNda6bzykb5ZXWtAYA97p7oDsXPHmMRi6g@mail.gmail.com
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Dropped CONFIG_OF check (Linus)
* Used dev_of_node() to pass np to of_platform_populate() (Bart)
* Slightly modified commit message
* Collected review tag

 drivers/pci/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3bab78cc68f7..55c853686051 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -350,8 +350,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	pci_dev_assign_added(dev, true);
 
-	if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
-		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
+		retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
 					      &dev->dev);
 		if (retval)
 			pci_err(dev, "failed to populate child OF nodes (%d)\n",
-- 
2.25.1



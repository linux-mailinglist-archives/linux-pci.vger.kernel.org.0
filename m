Return-Path: <linux-pci+bounces-2036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0882A918
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 09:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53681285051
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333608814;
	Thu, 11 Jan 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJoEy5cG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B304EAD6;
	Thu, 11 Jan 2024 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e60e13799so2033235e9.2;
        Thu, 11 Jan 2024 00:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704961627; x=1705566427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XG+5LYoTfM19+HCSh2Sxdy2rjn8YuyVWQvJzeP4kCnM=;
        b=RJoEy5cGKsUijiTWmS4jT88It8VPHebfnAqBmDq8NX26VfC+vOYCnM6+QSMWvS/bNP
         RNqyS4rXPiF8vkEf6kv3tEZ9PHbZk0DgFUevPRnUNxRnY7UkHARJ5U+rP8a9gN3R9ICL
         DDwKG++BlWGaj7E/MxKUcBmgzVxQKFSUoYwBJ5+ZABsh+dab034FY4Bgu6oqTnpEEisA
         +EcXkLgw0nbr+3qTldfGzGH+gOup+xue23/PO71tKAgL/YhN7NqvhkLzsJ+zcCxkNvfC
         2QK3Iuutygjwzxe3v3bMfi9zJVo6kUQC4yUEiKcIg1ApLxBwttc3NsCqGJFN+gx10wPw
         bUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704961627; x=1705566427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XG+5LYoTfM19+HCSh2Sxdy2rjn8YuyVWQvJzeP4kCnM=;
        b=nN+vySACqSljeAHUtwBcKprHPRP8yDS3+0au6WAJycTL2ltyQ9BRp4cQd+OiYhRNiX
         bT8RmelEMguvDb7boX01d28m63ud/SfjMfkyWQcOS83mLXUjnBy0UlZG809FMA34mDzB
         UEhOIvBsiv0CiY7ErV8DasGjSm5z8D9KF/G5Y2Xx+bbeBn6SKikevoZ729kCCOAv3KH8
         LilGH7MOk6nFk9YjGxreIXpv2edFau2RNl0psoX2rg6Si29ZcZMyWhVDSIHj8L1aNs7s
         7kgQ5BBSy/8wMmR/Un6JjPHg0hyb7MVyPGvCxyoPaGANuWkvTn5qkxQqhwHggBFL15+T
         uECw==
X-Gm-Message-State: AOJu0YxNsrEUS2CNhnUBsX4Fkm7fBRpWeHMFysqi7SLvtn9b2HEpYU9H
	ZUpVS6cwrrh+lY59L1g6ldLMXlptZgA=
X-Google-Smtp-Source: AGHT+IGoHE88PnZkOefJgr4PQyBMdDPvYPBdgLpyCha13BLRcXAiFUo/jkisxliGZgfOAaqZetm8Ww==
X-Received: by 2002:a05:600c:2d51:b0:40e:4861:b3f6 with SMTP id a17-20020a05600c2d5100b0040e4861b3f6mr170775wmg.48.1704961627170;
        Thu, 11 Jan 2024 00:27:07 -0800 (PST)
Received: from localhost.localdomain (141.red-88-10-53.dynamicip.rima-tde.net. [88.10.53.141])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b0040e4ca7fcb4sm967868wms.37.2024.01.11.00.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:27:06 -0800 (PST)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI: mt7621: Fix possible string truncation in snprintf
Date: Thu, 11 Jan 2024 09:27:04 +0100
Message-Id: <20240111082704.2259450-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following warning appears when driver is compiled with W=1.

CC      drivers/pci/controller/pcie-mt7621.o
drivers/pci/controller/pcie-mt7621.c: In function ‘mt7621_pcie_probe’:
drivers/pci/controller/pcie-mt7621.c:228:49: error: ‘snprintf’ output may
be truncated before the last format character [-Werror=format-truncation=]
228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
    |                                                 ^
drivers/pci/controller/pcie-mt7621.c:228:9: note: ‘snprintf’ output between
10 and 11 bytes into a destination of size 10
228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
    |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Clean this up increasing destination buffer one byte.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20240110212302.GA2123146@bhelgaas/T/#t
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 79e225edb42a..d97b956e6e57 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -202,7 +202,7 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
 	struct mt7621_pcie_port *port;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	char name[10];
+	char name[11];
 	int err;
 
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-- 
2.25.1



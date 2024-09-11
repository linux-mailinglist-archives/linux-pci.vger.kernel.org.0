Return-Path: <linux-pci+bounces-13056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C982B975914
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 19:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED891F26FAC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B805C1ABEC9;
	Wed, 11 Sep 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpnFAkMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56742A94;
	Wed, 11 Sep 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074736; cv=none; b=SOAFWVWNKSlPnAw1QJDLNGb5K49TbvG2JxX/9+b6J9N+hgMhRWrWESipLxWQdX+wl+aUgoeVOxcdA3dUkLOpaMKERjmqvAfwTh4+0StWeoTATyw4rYRKocnYTWckuWtPzJn2ZAjaXBpgqHn/4lf3Gu+q+gtCPbDYa2GTtpVk1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074736; c=relaxed/simple;
	bh=28aqfpBmczL2qL3N4PcWXgfXmd+sa3neIRFO5MVhRbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjT7pzZt8LkfjRBXOAGwlewanlcn8xP8v6qb3KS1Qpo8SG0VUzk/zQRTxOu3tH+t5/8ZY9fYc082qgROIhBPqsqjZw/n5G1hMK/36UxCjtH3sLlRlfZGk6GtCTdYaGU0ni9lWpODC98ZD9NcGPoMEgI/ersPLzhOfOMF/wvR8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpnFAkMA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db19de6346so72166a12.2;
        Wed, 11 Sep 2024 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726074734; x=1726679534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6xlgjjvIv4Tu6d6E5+S2TBi3KJntXgaOfCvHBzY5Ik=;
        b=CpnFAkMA6CdmnbRE17RdZCFNmnwFkPCCS+pKk/QgP8RFJ8n/KCB4WOAC6AjcBL/YBL
         wmyeD6ExuWpcUtcYHdQIjmISmOyxCp7llOkV9zv+b+GNlW7xSk/wqqoF29B8//FJPDKg
         +Fd/OgGi0hUD/pAFMRQKv+2KY8BXaBwJtitdZltRqCLq5sD78aKk2LvSA5ZG1/aKfudg
         Wh7bXCHsMlUfVguvcwHt48NvXTSfZlXNAxeeeZroMdc8800kbPveQYh6wpoe/3o0b8Vs
         FkrVIWV+5yqStx+xxOV0aAXJYbtxTPC68zUv8Egg5aNXyRcGNEDj4GQjGDD7hFp5Fap8
         wpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726074734; x=1726679534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6xlgjjvIv4Tu6d6E5+S2TBi3KJntXgaOfCvHBzY5Ik=;
        b=wPvbv6nAYo0yDpZpja4FFGDylEn8YlJmO8cC/G6+YIob2EGvjwRdw2b0aEYsXa3ov1
         mnxyQ91ShGNWDzkti6xSkfsfZFWTebfBW/SMgfNOwK7wq68To9NleSTeQ/t0Pi9kUc1Z
         NCss++wJZgBGsVhkWyVN3UvnjtPAmKaLz2Of/ilnBDtUqG81s0oJmVUuc/9auSkJBRf/
         K+vMCOjNdhjSuwemnFZ8G1tU7gRRGKhBNMxqPIoqoT2IHdUeSBZb0pOJr0eidtPdmhrj
         udjXuQSXZa573Pyd2gUkUwEpzeE1K16FGETlZpjo1qncM5zFs3yxmlPytOc+ijGMntPw
         lqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa97xYqYOoTFIeXHzMia3D6RTbWRTkblKbjEl+IaeER9nLWQz6meKjUzyqt8YFke6noKhrQVDdLLCx/w==@vger.kernel.org, AJvYcCVxAXB7apKZPa/Vfm4X8bcnki/M51gCBOpUbOJOF13+ObK+K/CIt85yIoARhoU7Ooh+2A87j0zM9/BWOys=@vger.kernel.org, AJvYcCXFhY1oaITDOUPTnXJcxVe5dTxmQqu/wa0NqQxABlslT48iSpVQ350UkQ5vhQlOm7LDktzhKxPBrErb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vL7XZ+CO11fiGAPUKKTJSBEO6AV2pshgd1qR6k/7TjSthpf2
	ITMRJ8BUtJ1sCbSBKjHTAg/+cCbXV07cqAyGpZ2+IOS+d6OMgx/k
X-Google-Smtp-Source: AGHT+IEd9DUYp7cewHHHvNv74waHQ4dQOFb6ONOUbfu4/MofpupHbJr5iv8/iTXTvi/uirT/M2eDAw==
X-Received: by 2002:a05:6a21:e8f:b0:1cf:513f:f1cb with SMTP id adf61e73a8af0-1cf5e03398amr7177453637.4.1726074734275;
        Wed, 11 Sep 2024 10:12:14 -0700 (PDT)
Received: from fedora.. ([106.219.162.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c9b08sm3193102b3a.207.2024.09.11.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:12:13 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: vigneshr@ti.com,
	s-vadapalli@ti.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: kishon@kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] PCI: dra7xx: Added error handling in probe function when devm_phy_get() fails
Date: Wed, 11 Sep 2024 22:41:13 +0530
Message-ID: <20240911171112.46322-2-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While creation of device link, if devm_phy_get() function fails then it directly
returns PTR_ERR without any cleanup of previous added device links.
Added goto statement when devm_phy_get() fails, to handle the cleanup of already
added device links.

Fixes: 7a4db656a635 (PCI: dra7xx: Create functional dependency between PCIe and PHY)
Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4fe3b0cb72ec..c329d107b811 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -762,8 +762,10 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i]))
-			return PTR_ERR(phy[i]);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_link;
+		}
 
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {
-- 
2.46.0



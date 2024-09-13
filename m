Return-Path: <linux-pci+bounces-13191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D6F9787F5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F4A1C246A1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF313B58F;
	Fri, 13 Sep 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ilt/Ipsv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04313B2A4
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252410; cv=none; b=e9ov8T4He5CMH6QEIYPE2HOUoATXmm593cFGlRhuRu2jxLJIYDS3NaOrv9WSZj0orckao7ePL1wDnez/P725zS3moEYB9be8ipTUxrkI+MdPFBIr1TLbmsxXJ4x6U13HPVnoYRM6iaR760TX5sEpL+J61aLoBmxlEkDMS3FP9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252410; c=relaxed/simple;
	bh=KWGgAMhSiiyP8L31h701ZTjtJNsOy0WoTQfM158fupU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F17L2u2+6t4qHB5sYBw3ZngUmUjym/ZdqjCNJdgCShaMM1FneGhysXG6elINQvXrKtu/zfmThv1qH/nsnfiz5pfdVDsoKKlBqZM6eZ2/MWigL1jybGG1dVsfgT8F4fZwzESooYa8jd5ZIEcRivbHCAZ38ZawA3OSVnjg9JZSLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ilt/Ipsv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-456930b9202so16210041cf.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726252407; x=1726857207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2v0+dGtW112yh7kuPl9jbngDqDOI2CHxz8mSzSdgOgk=;
        b=Ilt/IpsvgH7nywcfAmar9EChYlPG/WaDk8pNHxHYrG8cDXcicnSGPF86dAejeTfMW5
         uXt5pDCoWTs2HhQOe2Ddaqx4+ZSPknOrDawcpyHCTK/ZU+3tZpcMi/uOckGPTu+Th2oV
         RQ2eSBCtIw8BQNBqzEfvzETJYzoVboYgeDzuqL+hCGva1tnN0r7XLJ5f1p5H5geEXjVe
         4wDSvkPnP+SWd8SzEIiQVtHmuBIk2qRq3Lpt1MYZ60lydbdIxAVaqDRqQrQ/NvWxbbSa
         qUPR4SqHvQPKWfBqQOsdzQvNyisQ09sREL72jJWRv6y3s5cQQzOtL7ZH4HDeX6+GXNGZ
         THRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726252407; x=1726857207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2v0+dGtW112yh7kuPl9jbngDqDOI2CHxz8mSzSdgOgk=;
        b=UViIiISMzu7tQc+VZoQFKmpabtxYViCQWAISe4+xRr7VkQ/lc/WuskvpLlpeJb7GA/
         oWyeFr5QfFu6xoShG/auqhHSzmmOOlzlOFcl0d2plsNZx36g2AvG4pwElT4UVwhte7e5
         UDsh0o67VW9gu3MkQR2cX30IUDu3snnEzw3HU9fFuojRjqQ9zJzaRacxkWtElVC575bG
         rqu+44ZQmtGXeXSF3BKK065kx8XOsUmA4/Gx9nhc4Yd2L5iJpkH2k0mXDEuyydmL/N6R
         AGh06I3UXoFOc3Fn5jtV6Kv8VX5y9jxrqBHDoB7mWKiirKrx+vl1TaQ/adTVGuM16A/J
         XkKg==
X-Gm-Message-State: AOJu0YztV54EHmrhdZFb3Y/ByCbL6KTtXOTLASJdiuBC99z8i77VO0Te
	YDithWWATu7DZwMNzzamTrV68Z2JEoYNa0fp98osvSoe7N4WPWQBBw1ntQmHncQyR3OjBivZK/Z
	2
X-Google-Smtp-Source: AGHT+IGvC/54/kqTEqx6TS/kP3pJhDLE6A7PbErUo3HvjAsjov75/IPAU3sCI8+hL1thXWjQYgmYEQ==
X-Received: by 2002:ac8:584d:0:b0:458:35fe:51d with SMTP id d75a77b69052e-4586045e50cmr79001221cf.60.1726252407607;
        Fri, 13 Sep 2024 11:33:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f61ac7sm68596801cf.71.2024.09.13.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:33:27 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-pci@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH] pci/doe: add a 1 second retry window to pci_doe
Date: Fri, 13 Sep 2024 14:32:41 -0400
Message-ID: <20240913183241.17320-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on the device, sometimes firmware clears the busy flag
later than expected.  This can cause the device to appear busy when
calling multiple commands in quick sucession. Add a 1 second retry
window to all doe commands that end with -EBUSY.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/pci/doe.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 652d63df9d22..5573fa1a0008 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -647,12 +647,16 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 		.private = &c,
 	};
 	int rc;
+	unsigned long timeout_jiffies = jiffies + (PCI_DOE_TIMEOUT * 1);
 
-	rc = pci_doe_submit_task(doe_mb, &task);
-	if (rc)
-		return rc;
+	do {
+		rc = pci_doe_submit_task(doe_mb, &task);
+
+		if (rc)
+			return rc;
 
-	wait_for_completion(&c);
+		wait_for_completion(&c);
+	} while (task.rv == -EBUSY && !time_after(jiffies, timeout_jiffies));
 
 	return task.rv;
 }
-- 
2.43.0



Return-Path: <linux-pci+bounces-13561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D9987432
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D7DB20C28
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F1EEB7;
	Thu, 26 Sep 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r46eVRZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8284E57D
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356176; cv=none; b=sjiXyz2Wb/g6C+oOyQTx57v8HFGJcEfmIgT+EyxEwD2Urz1fjzy61SPlcq468f29HBDT1vRJ61/E8zA9ymH2ElSTn7XRK8mzaj8p4Dq3I2Y55hUnnqeW/qwchMwTQQ4UAMuh0NNQE8NDF+xSEA4QsIFFps31hZDYH3NuMivWt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356176; c=relaxed/simple;
	bh=CaUFkRJKWaaKqA9MSqRJEqe3VnRZ8CyqyyW3qoMkx9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihUSwKvT+Yk0PFNLfeu71nfZPnI05lmkPz1iAtfuE9b7i0q+TjGcoFVTsM+UTsmG76GF0yWtsP6wFryiSEtCyHxlHKsFdlbs6vpiRNo69UUVzSY1uDqfCze4qK6npycm5YnH/bo+75rbLnFP+dAXCGYLJD5oiMCgTFrpUN/aci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r46eVRZP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so9096765e9.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727356173; x=1727960973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGV+BX5NNyCiftaKgnNecXWQwtjbfWYcYZF3fnBBXYk=;
        b=r46eVRZP3dSKFfC8I2tP1G1kCOAIpGgNE7xIYmXacLhNTHMSoon0Nwania1x+M0b1r
         IH1wmWGY3wqwoB55rSmrRsMWOWjqWbFt1iQDBy6i6wnpg7ATs4p+FBhQ0E6Hfy768bCh
         5E3WVfX+k7CIcHhWleeuIYxyq3XEF9kVtJjiFi3Ai3kz0YecNYkzh4tVwuH0Bz1YzjiN
         7Gkd+9bgpPaXNTZhaarKxgNCOL219cmFIeQN3pYVJ0H2afQyRzuk0hC6YmfCM8g18DEh
         X1G6oc8Tj6KDJqJdqQj5yYifqRabeT5U7mboBg53ZJ13IT08ocPZAgpYxKnuvPyFZVNI
         Ek4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727356173; x=1727960973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGV+BX5NNyCiftaKgnNecXWQwtjbfWYcYZF3fnBBXYk=;
        b=IvlIoAKEcAZt+gq1iSZTPii2CRUwkNT+I28g/b113WbePMVAKonZcpFluRqpV0QzsD
         tdNRYtpJOmFhoNg7kkpVNNodv6ULsXS1wmBqDOFP5RC2Kq7sVCwsF7Dh7VRQkxDloWh6
         6FgWJm8pgPKRg+QrLChl28FRdCOqH335CYiZnWy15kKSyk92cqhhQXl0JAfAkqjq5LTs
         jF87J36N6STVZD8H1CXUIe9l1qaQw2ErYNuAkiSm1JUUOrBkqRxGzlVYTnkxAnsy38W6
         KySL1O2YQh5dmEV9/aw9a8gyAIRJb+QniqUlytZYuREDV4BUmIuVOYb4yy9MW+n7jXTB
         4mow==
X-Gm-Message-State: AOJu0YxyUnKqSxGiKz1Y+lZWCH2YQLMyskFTlpsXafkYpwdJjEBsQ0wt
	mSUeV0jizlyhbD9t4shvlawg9CQ5gB8pI+Bi7s2MV0byvDDW0cWPzwMTCYiYgyc=
X-Google-Smtp-Source: AGHT+IEf86LLRp+GATfILRTa306z4YTyHtaIGF70cZQgBAcZdmzLeKQViClJ8kYsw67Qe/redspdrA==
X-Received: by 2002:a05:600c:35c3:b0:42c:b309:8d1a with SMTP id 5b1f17b1804b1-42e9610ba91mr40959295e9.13.1727356173028;
        Thu, 26 Sep 2024 06:09:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3ea0:4f4d:3a9f:2951])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36760sm47109335e9.30.2024.09.26.06.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:09:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH] PCI: take the rescan lock when adding devices during host probe
Date: Thu, 26 Sep 2024 15:09:23 +0200
Message-ID: <20240926130924.36409-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since adding the PCI power control code, we may end up with a race
between the pwrctl platform device rescanning the bus and the host
controller probe function. The latter needs to take the rescan lock when
adding devices or may crash.

Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..f1615805f5b0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 
+	pci_lock_rescan_remove();
 	pci_bus_add_devices(bus);
+	pci_unlock_rescan_remove();
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);
-- 
2.30.2



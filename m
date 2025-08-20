Return-Path: <linux-pci+bounces-34401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F6CB2E3F8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972371C8593D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94E3375BD;
	Wed, 20 Aug 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMEQ6+o2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5C1E7C12
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710800; cv=none; b=JiMRAyPw3g5nqvUxryFEWeNgy58ezM7AZbn4NiM2x6/jD57jlwOFA5sH31AxZmLKytihyQEE/XoNvVfL6jBOaQwHo8W0WJpNFvDvd+N2CVJEKYIo/1Vwt5ERr0wP6mhEjyDiNXk+Ix2EDAs9c8QyJG+yFiU4pyLBITUBTXLai34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710800; c=relaxed/simple;
	bh=Q/jdaiM+kgJ5R5FKhEvQDUDNp4Rjp1tV7zovBjIkSS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOStOC+/P/bKAh8Db+5+HR4OF8XrzxFBI+27G8Oko3CD2XwaMxhN5CJH1EHd4lLVaoZYw/jep7F+fBHw1MF+n6ERWxVZcGHIyDk92guCeklgZJoIXdYNjivOGH9QCF9LACtP4dYhcbbhSQA3R5FU1FYeEWhcHcs6F491wqdmYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YMEQ6+o2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e563b25c4so148305b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755710798; x=1756315598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JeiRrdVegjLxsA+/HodUZYtkAW20pYDME1GTqkfc9k=;
        b=YMEQ6+o2XklB6VOsup27KmJHRRiaYJqpp/CN5nAKdczf3kaBVp6QddLLc/p9dI5jRS
         Fdmd2USEUzhr7s2qWbU4x1jxQUwj8ixeHCBBXIqRsr18zNJ5trZaOVcAmrC9cXppp8SB
         ziorirC0tfty4x0UstQqCRaT9vBKHCXexXdZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755710798; x=1756315598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JeiRrdVegjLxsA+/HodUZYtkAW20pYDME1GTqkfc9k=;
        b=be/6z8pBqJOw06SXjbnhhrGeCL0Tbm9QBPcV6F72X6Uo7aIuY8fmzKMFHUp18KYXLx
         lzJ0toa7ruJWGLi4tS3C03pi8dI1aWi41T8IjTXhvTLz7ZuxFDukGlruElVqWSnZyL3X
         xwzmWC85JSHx2LyBTbXiOFSSGdzSmeK1oCTKH/rH/FVfPZJfKOVNgXfFUqmf9PUArTxf
         KPCLuOZShR5QNUYWmRXlYrON9gp/RuhQTCamonvJJKunKF98DUUXUmmt9cUTX3NFMx4J
         UW7F+TFlUVVAz29K0ANuwVwHkfQ7+YYtfS0nwqa4Xx0INZ8ZhvsYEQEwvqFD4tvqZGK1
         sWPg==
X-Forwarded-Encrypted: i=1; AJvYcCUesjDTYAgTCJiFaEwgEvzu8WD/4M4wykgjo+tMf0xgZeJA3pN0LRmYgReh40bd6jDflUKrNeJUKaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjy3E6ICMmduL1FcBDdIcPVibXD2ppF8ADl7q/6SSW4MJtfiL
	31jT9KLwXGhMdjR8wyAdHR0RocoUTMj27dVuhHia9SL3mLygzROZ2lxVLE+obio+ow==
X-Gm-Gg: ASbGncutnmXsYTLaiw/4Yrf/PtOGQmAQl09WdDdaOPVzQ5z2RfneCY2nqdNIFKM7y9m
	tz7GrVaX1m1pPJRu+T+QWwfoGQUIYsteUTW8AbV6MubgxfFOK2Ku8UkAEUIc9aGDKRt9dYVJBby
	gWPklzjeua0h53Hew+zlad5Nz1rcLDHNKGFQkagwBIjV7zzqaoX2+NgqQxUzbpO9vBrwkj13MaZ
	FEdIhn/waxXuQ777BVzZGZ/TE/j0BO5VMNW4bwzLBMlP5c8Qa/bZuzLWT5B+sfnOXVTBUhG9H3a
	KoiDwoXwXryxjDH0hMExfhcBtF9EUUnbu58Rgmdv5KbyC46k/o6EmsgWjbcdSD7B6H3IgP/b8uq
	7H9mzTKMypRUfJwXfdtlKpbl5KTQ3TxjuhxUWJKirE7cXbDdUuBgl9P9R+jDn
X-Google-Smtp-Source: AGHT+IETJ+xPBqhU4+maX5eUwNiVCa9GIut+/TM1ucGF0aqZzfLGdLF7Hth81w5j8Rptxhmmo/r1xA==
X-Received: by 2002:a05:6a20:7f8e:b0:243:78a:8284 with SMTP id adf61e73a8af0-2431ba55cb3mr6389305637.60.1755710798151;
        Wed, 20 Aug 2025 10:26:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:635f:74c7:be17:bd29])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4763fe3047sm2735821a12.17.2025.08.20.10.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 10:26:37 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Date: Wed, 20 Aug 2025 10:26:08 -0700
Message-ID: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

max_link_speed, max_link_width, current_link_speed, current_link_width,
secondary_bus_number, and subordinate_bus_number all access config
registers, but they don't check the runtime PM state. If the device is
in D3cold, we may see -EINVAL or even bogus values.

Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
rest of the similar sysfs attributes.

Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5eea14c1f7f5..160df897dc5e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	pci_config_pm_runtime_get(pdev);
 
-	return sysfs_emit(buf, "%s\n",
-			  pci_speed_string(pcie_get_speed_cap(pdev)));
+	ret = sysfs_emit(buf, "%s\n",
+			 pci_speed_string(pcie_get_speed_cap(pdev)));
+
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
@@ -201,8 +208,15 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	pci_config_pm_runtime_get(pdev);
+
+	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
 
-	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -214,7 +228,10 @@ static ssize_t current_link_speed_show(struct device *dev,
 	int err;
 	enum pci_bus_speed speed;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -231,7 +248,10 @@ static ssize_t current_link_width_show(struct device *dev,
 	u16 linkstat;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -247,7 +267,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	u8 sec_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -263,7 +286,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	u8 sub_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
-- 
2.51.0.rc1.193.gad69d77794-goog



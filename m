Return-Path: <linux-pci+bounces-31757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA847AFE25E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 10:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88241C426DE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858823C50D;
	Wed,  9 Jul 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2SG0hPHr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE0625
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049254; cv=none; b=VKxJCTnQwy+U/If7CtEAwake65Y0wtQcclITLQxACJLB0WcllilebatBhSGNSCxcZ7O4oCOm89VBN9osnmJayZ4risWZpRe6pzMUiscxAjZDoAFSiXmmzFNTe7qlXAX8KUd37GNivQwjA80TS19PtvtnNLBrPD8BIpHiKGfkLWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049254; c=relaxed/simple;
	bh=EHXyuAgrfEFtwOLv535hfHlLjgXTXtcDgMefdBRIoPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bbGCK3Nx7aJp+Q3pWyBhkjEHSOEiTPajepMbMWXc0lZ/w8TWTiM252ZutlHnxB5glEcMVQ2j0qNvGCRZHRKIaQWoLN0WMpnZLsOKn7g+Geg1JgZj7nctIvOaGDjXgO9VhB9vSzKzraQdsxmiV+e0+E6VZcW+RlUHOZVDezdfhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2SG0hPHr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4530921461aso37886135e9.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752049251; x=1752654051; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7B3VRXc09cS8APvBj52bRVQerXwb1XuAJdQMIRIyeh0=;
        b=2SG0hPHrilVOq4DA3BKH5i1rPpqRffRqRzSyw9rMKTEbQVL5Z4ozarjiNEHoz4EtCX
         +O2RdPsLYRsGuM/dkY8+tWNqRnq6qxLuA720mFsAQmApHaSmQMvnLbOX7CQosf8y0wHU
         xoAzGIVutXY7UMomrAAG3CA1zPSEr6SwXvS/YurD70W8ldEXrdTWcT5Uxdg/a8X6Sbd8
         w5na3R/UnGn2k6ZHg46gu0pql7IGwiIIftn4tmbQx1cxcktXmih1yURTntm9tDN/sJPF
         U6GDmlY2E/2UWhEnP2tsO62vHJcuAoPp5NRgfDZn0JjKL+WfxtDUjarI72iQu7kEu1zV
         plHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049251; x=1752654051;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B3VRXc09cS8APvBj52bRVQerXwb1XuAJdQMIRIyeh0=;
        b=fVk9oZqpfRCVLhB3gJNo98eW8N/RrFW8eMCvRyVZvlHKAc8uiQXJ8iusvfwvrMz/4k
         k6LagegF3L5t+hBaSdAPV6AhN5WbQ+WcDAHdWoUygOsNKAojxmlWr6cIrAgt6aWlsmyc
         nJBxqHGLbEIuVzfm8R015boGdYgXzGv3QS7RAzeyNk6wvld5jbrLxFdR8VgZsvOCn92m
         JN9wrNpWI9EmIsEksym4Gz20gxHKQBIXeH0nTVQx+ePJf/RblEb4/e4oVhL71x8j0CnH
         fgODbjE50WniHvHjILfnlxjzcb85Oq4WI4QwWo+xhHekNd7IKTUwQWNqa0In4QswWIdk
         rHrg==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZJIQv5NlPtEZXlWPJ//CylxG3wJNxG0OPZiLtW15y3Lp2kCwQaEaS1VqLUbJs41KjKlSLenECQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEHIji+OQqbo3ZZ7FDyFmjxBtHCLqlAcvx7gClSnNvGKdvzzO
	Fdeyo0SZpjJQRIc+k6hTQDHBLmFOnc4a0xofnDJretx3ey9s11WtuzeKeX3rRLIh2uk=
X-Gm-Gg: ASbGnct6/dr0/77nLqAmpKJ8W7cNj2fnqy+RnO+aLmK1S4gzIjsBljmIbwxWf1z9y/T
	otQ0omgGV/qbXUEI1ix1T0nqyZZUkNE6h3E/0jsjZpFBzRJM1pqQil6dupNTmDELOaVIxLfIsG+
	D6blWAanWiKE7nasJwMNyt3fhS21+WWky0BqZYaglKZjwbSbeOCV20t8mzaa5Dscsy6l9hruWZc
	eZTaF2/crhyY3CImZIPpN/XiRCtZaqdvxydT7rOr0/A0Sasd9ELESV3xx7r2oiTo2LNMg60+NzP
	FaPm1T+4IAvOaVGk0Z2HEPkySLFXZZaqsvykEvAgK93lt5RwGHdtgXk50b98TRKnWnUbQHUTl2P
	6
X-Google-Smtp-Source: AGHT+IEYNIjq5nVtF5eCRGm3USKuYX5yMn/POeyEHko97pwQhmn9XFmaUb7lW9CY6jfvANHnKvBFuA==
X-Received: by 2002:a05:600c:8207:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-454d52db33bmr12806645e9.5.1752049250612;
        Wed, 09 Jul 2025 01:20:50 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:6015:b265:edf6:227e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454d50527acsm14451965e9.14.2025.07.09.01.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:20:50 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 09 Jul 2025 10:20:39 +0200
Subject: [PATCH v2] PCI: endpoint: pci-epf-vntb: fix MW2 configfs ID
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-vntb-mw-fixup-v2-1-27c14df6ed5b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFYmbmgC/3WMyw6CMBBFf4XM2jHtIKKu/A/DoqWjTCKPtFglp
 P9uZe/y3JtzVgjshQNcihU8RwkyDhloV0DbmeHBKC4zkKJK1eqEcZgt9m+8y+c1oW1LZUqmszp
 qyM7kOR9b79Zk7iTMo1+2fNS/9V8patRI5EylNR1qdldrlqdYz/t27KFJKX0BM1iVQq0AAAA=
X-Change-ID: 20250708-vntb-mw-fixup-bc30a3e29061
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=EHXyuAgrfEFtwOLv535hfHlLjgXTXtcDgMefdBRIoPk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBobiZgAHnLRl3ismay6Ijxwcw0NreYakccQ7CuM
 G8WL55cG12JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaG4mYAAKCRDm/A8cN/La
 hdQcD/4+7GOPlvQ76ACj1f381w9IvlRgSLLe23LmFHIojk/yzji+2mVS4UgXKKuCVJcI912W2t9
 j1rvTxqb8Ss4o/cc3yv2VN5GjuyMdGvKVnrrueGZc2Gt5/8SKmbpW+JAx9dSRDxUGCQwa9Q3Lju
 QmyRKT4LulS9ciV3sTr2yw4GAcsCQH+qxWVHWASl82uVPtP3yporWKaBDbMljrgXeum+P8rLo8N
 zYfW4P9TR/Or2RzxBhwJlmouxQP2X+v84BvCC7V/01W24J0OigOu1eCgoAeaSiLnmjDBsVOkdjK
 YXM5R5vB4bv33RDY3cbPRKtpPcEePz8Pr6Pk+cfO7Mvr7TUJ0sLJoK2dRlF4NcXH4S3xwLEqdg6
 70U3m7STxKnWVEeinuCP7vUNfKovh2txQcC5OQmdnwOi3kE3vwkfakpEesnSqA91viLUASY2iwv
 UaQdOisDcNO3WaCwD22f/mM/NVGKSZIv4B5ja25cqmhIZHDdNcR5IYDAvoHpmkVBL5NW5lLHHFv
 HC9N95EbjXtdri83ib4Iz3pRo18GUYeLYMFnrmxRaTZJEJ+JvO0n9RVTxxI7v+g7OTaOLlrlb1O
 qmBHWgQEqgjrl9uhrxGiIB4ntwvG/GB0w+T6jVt8OlLAvmyFEEtdDNZeiQNmtz9Hperk6JkTIqf
 b63n2sQ/LYoKrOQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The ID associated with MW2 configfs entry is wrong.

Trying to use MW2 will overwrite the existing BAR setup associated with
MW1.

Just put the correct ID for MW2 to fix the situation

Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Changes in v2:
- Minor edit to the change description
- Link to v1: https://lore.kernel.org/r/20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 41b297b16574558e7ab99fb047204ac29f6f3391..ac83a6dc6116be190f955adc46a30d065d3724fd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -993,8 +993,8 @@ EPF_NTB_BAR_R(db_bar, BAR_DB)
 EPF_NTB_BAR_W(db_bar, BAR_DB)
 EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
 EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
-EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
-EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
+EPF_NTB_BAR_R(mw2_bar, BAR_MW2)
+EPF_NTB_BAR_W(mw2_bar, BAR_MW2)
 EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)

---
base-commit: 38be2ac97d2df0c248b57e19b9a35b30d1388852
change-id: 20250708-vntb-mw-fixup-bc30a3e29061

Best regards,
-- 
Jerome



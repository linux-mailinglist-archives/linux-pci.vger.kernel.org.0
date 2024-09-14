Return-Path: <linux-pci+bounces-13212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC699792B7
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 19:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915001F22026
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338B7604F;
	Sat, 14 Sep 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOCi4FX6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912E522F;
	Sat, 14 Sep 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726335972; cv=none; b=O5e2Q4H04BBCSO7ijMbqyk2PQp8xLc67q/xe41VL1XPpoPEQOGPdoJk5z80MEiq3d2y7wun1wgZhGH0JvogV68lDx6ZSdrfkg9NG5cZ+SB60h+5xGofI1RJcIUYqgM1Tan23MCYSCYNVExg18p8hY3bBnm54/r5nIwIckUPbSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726335972; c=relaxed/simple;
	bh=xdsRpfxRInmPg4q7y9hC1YTNqmCPfKPBOSYVrCk7+oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNGR9v4u245iC8DdlsYM6mALpgXq++JAw67Z66uHINOdczluP3UKOQ8dVbXrYT+ApXaEvFfud4MOpJROzcnuQ+2xrVX4I/pGhH779F/pFHpH0jjcyCS3RjlZWH1mupbvs4f/fZOLC7/HgsUhN2oSVHRVp24753yLM6ZwGI1+suM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOCi4FX6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d704704aso2959049b3a.3;
        Sat, 14 Sep 2024 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726335970; x=1726940770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHBpOvx+l+y5X2KaI6opgE4I/Foj2cPkSFAdvhEr8s8=;
        b=DOCi4FX6Zfqiy2xATQvgUhT5KAEicvy1WY9JkRKYk04HASC3AqFo5DZZ0+FKK8h7ub
         JSmYkjLxx05i4L4ALAGhMU6FVA1ArEkA2/AZVCzxqGKtn/gmig/2eVCAW1sLc3LQqeKp
         Zh6dsvoWyVQCpDUVIN8TFbiwCqOq5APAHdewNfov6UGoF0ChxnQ+ks7rONaVkgNyYH8J
         1wJcSt2jI0XjuQbpRtKSBRq7QIojSiAzFZ0JjG7yZe2zERWtkUo1Ue11CRVI0opSIqgG
         U6r7rwCOXrPuDvp7ZW3w0u5f1nKUaXpQ5sFSLyxdGevx21G512/0bEDB3exF3Rc3+Dcx
         mmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726335970; x=1726940770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHBpOvx+l+y5X2KaI6opgE4I/Foj2cPkSFAdvhEr8s8=;
        b=r4vkVnyTiEsgkJEgZgQcE+KMUzBFWw0PAKsYJlhrM6jn4SJERjm0LhPujzZpL4uy0x
         cHbBdxJLwgOmXi9kywdKsWagGxzJIulQzMq5+MyNcBUB11G6Noi+8Q2bH01Sif5hgLxc
         ZutXpvo2iEkI6PZ62GHNnv6wa79OETeUuC6qgI9NkfI5zRqaPo6qRQOXzrO9ClUssYmN
         UNj5p6tV96jTs0FB1pyfB0fW87Hv9mJwFiZFXbN03xidwSfI04DZEB3HBNXLVrqa3u7n
         4G63zwVDELy5fmnauBFpat7y4flmKLmsQugnqxUDL2Sn4BMWlGI2xt5qc31IK2ZHXlIf
         B3tg==
X-Forwarded-Encrypted: i=1; AJvYcCVkZY9hEyFVsWLTe2dpTZNS1466KCsvFSOfiJqOOQ8N0FDnphK4NOY+2Vg6f+g/JSZ8WsDN7NyAQIV2ujQ=@vger.kernel.org, AJvYcCWOddAdEw9Ot0fahvnLr8ZERvHYuDr4+n3yxPl69BcOJs4V4r/jD3eeeMYAKwEri+h9OFLR2AC2Ga02@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3lj4wY39BTRIZbx338+6Mlkh4GcFX6dDe/1cHGgB3IyuMHAmN
	PwEtc0JNGFGNC0H/ZNYhLycYWaQEE0FIS/XLWLhHhNDT7bKKwHt0uR52jA==
X-Google-Smtp-Source: AGHT+IFFwVHfyzHkNJ0FwA/uSGeJi+5YOEebxs28rbGUObKeRIQqNU9Bebdt7dkiX+RHG3u3k1xcLg==
X-Received: by 2002:a05:6a00:1ad2:b0:717:8f4b:afd6 with SMTP id d2e1a72fcca58-719261e777dmr15875574b3a.20.1726335969815;
        Sat, 14 Sep 2024 10:46:09 -0700 (PDT)
Received: from localhost.localdomain ([187.120.158.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a97415sm1212997b3a.21.2024.09.14.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 10:46:09 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: bhelgaas@google.com
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: remove uneccessary if() and assignment
Date: Sat, 14 Sep 2024 14:45:53 -0300
Message-ID: <20240914174554.98975-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This second if is uneccesary, because, the first if is equals.
The assignment os return pci_revert_fw_address() to ret variable is uneccessary to.
Then, the second if() was removed and the return function is the return of pci_revert_fw_address()

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/pci/setup-res.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c6d933ddfd46..8ca1007cb6b3 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -352,12 +352,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	 */
 	if (ret < 0) {
 		pci_info(dev, "%s %pR: can't assign; no space\n", res_name, res);
-		ret = pci_revert_fw_address(res, dev, resno, size);
-	}
-
-	if (ret < 0) {
-		pci_info(dev, "%s %pR: failed to assign\n", res_name, res);
-		return ret;
+		return pci_revert_fw_address(res, dev, resno, size);
 	}
 
 	res->flags &= ~IORESOURCE_UNSET;
-- 
2.46.0



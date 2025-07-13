Return-Path: <linux-pci+bounces-32008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B43B02E56
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 03:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F807AFC8D
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 01:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291C94B5AE;
	Sun, 13 Jul 2025 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRmi0c7D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB05225D6;
	Sun, 13 Jul 2025 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752369439; cv=none; b=H7Lj8aTIfFfOAt7LAB741++o0OJ5DvV9jV8VRoFyky1cM0/Z4RHzLrKCLEG0Z3VaRe/+/8ffmTiHKN6zLJ9T692aj4pVc7FJ+V7Babp6dJq3u3xPhlFL9xyBCcwdJht22n2/XEGXCjMgTEJgMiJhMmw2lxxeDgQwUhtwUaD5WDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752369439; c=relaxed/simple;
	bh=jkVEUKEjutwjuBXTyyTODBl5MA5+Z+1HsUGKy8rQwXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY1N7wgd8+UQCVCmqmuBmxTJ4+JlW6UtoyiRKsFqSa9PbjeCkUZJ8V39MmyXOokBqU80Zp9yqkUAtHBEGEjr4A+fkzKKR66G3r59SRqGXY/VVrjSkHk+FXjJallSkzAKIWMJ5QvaWK7KqyWVdHrHgNEWem9GOGzFxDu19/2HbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRmi0c7D; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2531367a12.3;
        Sat, 12 Jul 2025 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752369437; x=1752974237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyAwl7MTAdKGbA9lEwMJ6Kwhn5OsQcN0Me/hhvfZbls=;
        b=CRmi0c7Dv8dYBXqbXSAwUWrfrqVp7Hur470Y+7GN5xXUQgmckECKqorknQ+gRHr7o0
         By2DIok9Sj+04yd8SNYcqDp/dqsKyxZaGSDZSRBb67o3u4pWvePAg0oZnGW6gUlQB1Ck
         QgkD8gjhCZVZ6lwe4mLhda7bAlZYlKPYzvwxWK3MOy/JprRKt9nqHINr9ss3uk6WMgro
         xjk+bexQyNs1hA1EMgbwvHsxI09YhK9X7fKIm3EMovz7pGnFIU114fWiKOSqFluqcgvc
         KVgg3GQGEMe4gZRUyYBP9XmXUAzyfljhXM3SraLTcJqLX6hVG+HM32zj6BuF92hQ0wNx
         DAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752369437; x=1752974237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyAwl7MTAdKGbA9lEwMJ6Kwhn5OsQcN0Me/hhvfZbls=;
        b=dTFkW25eklydM0ivrT5gyyNZE3XNxRRD08/0gz/ONSmtc2GIXX0fsGqeD/ZOzlsw98
         aOIM5ibdckU+dlHtyrCMLinjnV74lnVbYE9GGrAe0pXedMOzXFKNwxv11etyQ4Cb5Jmb
         HZeD0h6v1zNdWhjxdCFN1QBfEcKhD1W3VMas+9carm3Qqu/UHDOJTTG9XkzKDyxbZnO/
         kvhIBUBbArojZWP9svvWKhDtL4ovL6O8JBPRk7EWjLS1Om6GTRadxQBsxAriV1mAvb4g
         c4KD0c5KyJB+gOn+S+votaRLfhoTe0r928d0pgC3HBrWYVJuKJzWT0qgmSRdQF6EjqhA
         PSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF8wM4S3R+A3ZhRWF3hPPJynhWfN4ZuhoED5Wp+Fw5CcqqETwQWcgObpUNxs7Tlzj31tr2RqHeE3lUrWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIje8YaZ+iKsMTFSQQ+L0DcZJehiqq31jgZ8yTxNmuFCTco8B
	kZZ5zqXo9GBF9z80z9L9B00c6XL+gO7h3N6UD1YTarZ6owhs6fimt3fRgKVVSA==
X-Gm-Gg: ASbGnctugFVgxk+7NYsOy6YjnJNS7MkyPnOLJR4tkFYqoFqSot9AO/IoSXRmCfP9uzG
	Ytw/BPvFx6Cy035J9U5K+NLozZgKq13O1gb06067JJQFYZIrxRgMKvbHJBIaavHvduqsMPxzZkj
	9GdsoKzik5FB4PGTEf5YMBgmjhNkpEBrkTGUQmC30uLZtL2bKcKaj2xRuLjf0IaV2NjhCBFmwkY
	/Bnsn0gZnoxGwWh/FDdDJFoO+3vZkOaSaeqfFLskJwdCZfUSyZlimYuiCllz9uEbzvG8vAIzy6E
	otJbYuZXpfqDdeT/KL8J7F3I/R2V1SGtqi1Q+bIy3I+fVXZz/F2q/CPe+Qd92WB5yw9V+1CbaG/
	sEQ7B+jt40Yk4Xcc6vC6HuOkHISSG
X-Google-Smtp-Source: AGHT+IH96KbBlQ8fvWg/0eJ0Vz6bU6PBWGET/o2f3civACzcVCeGSqz5mURh8wQ+RmH29ml2sFhRAg==
X-Received: by 2002:a05:6a20:914e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-2317dbd4f1dmr10831209637.9.1752369436744;
        Sat, 12 Jul 2025 18:17:16 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bd98bsm7497765a12.45.2025.07.12.18.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 18:17:16 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH pci-next v1 1/1] PCI/sysfs: Expose PCIe device serial number
Date: Sat, 12 Jul 2025 18:17:13 -0700
Message-ID: <20250713011714.384621-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250713011714.384621-1-thepacketgeek@gmail.com>
References: <20250713011714.384621-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only interface for reading PCIe device serial
numbers from userspace in a programmatic way. This device attribute
uses the same 2-byte dashed formatting as lspci serial number capability
output.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/pci/pci-sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..72bc266388d4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(current_link_width);
 
+static ssize_t device_serial_number_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u64 dsn;
+
+	dsn = pci_get_dsn(pci_dev);
+	if (!dsn)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx\n",
+		dsn >> 56, (dsn >> 48) & 0xff, (dsn >> 40) & 0xff, (dsn >> 32) & 0xff,
+		(dsn >> 24) & 0xff, (dsn >> 16) & 0xff, (dsn >> 8) & 0xff, dsn & 0xff);
+}
+static DEVICE_ATTR_RO(device_serial_number);
+
 static ssize_t secondary_bus_number_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -660,6 +676,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_device_serial_number.attr,
 	NULL,
 };
 
-- 
2.50.0



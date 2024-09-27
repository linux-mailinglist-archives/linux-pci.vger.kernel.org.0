Return-Path: <linux-pci+bounces-13592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25566988149
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 11:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50C81F2169D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C61BAEEB;
	Fri, 27 Sep 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF5cGAn9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0D16D9B8;
	Fri, 27 Sep 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429096; cv=none; b=ketDMOX2EgSbI2/BFbDva2yLO5RpWF/tHyPq/Zh/teooNaxOZ7s60A3WtzVOm0L0YyToqVCrg/1z39yZP19BQyQIFKXh4BxAKVDGec5BZ40oJ6qcbZh88eEt3n/RnELjdGZGBKbnQ2nf/1EOe33PyQ6zshaLdkZgntMPzA3znwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429096; c=relaxed/simple;
	bh=y1yeiT+rifySbDZrsNczQQ8jpJCujtuGcNQPagD6zzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CD/Oir3Nvy7e2pQeNCVEoC8f8stRaQ79CpuS7dnMv8eMJ+6v+snDlQGB4O2y2+Em9t2cAMFNzn2Ny0zPHcbsSSQcnsM2Q5QHjzcC2OGyHzDq1LuAs6Rhs1bQqd19rOIb70ZIzoIJHk+L3HmGHzeaRu16m/K2a8QvtiuXmg17kcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF5cGAn9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so17764285e9.3;
        Fri, 27 Sep 2024 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727429092; x=1728033892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RTT5aJJwYQeDfzc5Aoy2fETEx6khrTlU5RyNlFgzMY=;
        b=mF5cGAn9PrERsnWB7joABixrQwrq9OB5UUOIQ4LsJXqSRfQf+n/H53hmOcT9d8GoWO
         g4/31qpZwK2r9l49VyUSm+kFLaSoHFqNd1FMQmEZ2NSIq69WOERqrLh/UOORxpuZaOdE
         DIBB4v4QrgTAxIK+qpzEgSHawDNMcIdKfQekXlUEgXjvwOE8gExgIi62EkMBS0dklNEZ
         ngfHo/JA4E2B+OiTdY8RFeGf17480Ogn5Sw6EmnhHqQ0d1VqhXPzVSbtauC/1DhLdeMp
         TP1gHZ8hsj4wDJ44nrJ/OgC2p+M+OV/XFo9TdJPUfU6FO9UIhMCIcMzvoxNlUUgUrbeE
         4KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727429092; x=1728033892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RTT5aJJwYQeDfzc5Aoy2fETEx6khrTlU5RyNlFgzMY=;
        b=JW32M+5R1CtwSCnoKszXz0ncLVjkiuCO4bCZ2qtD6Ji1CNW0oxzRuIF75TLLAyJPEx
         yFSA6gMFi/VPtIXj0qFqFBhxCks6S42FJt9WypsbyyOGYSG761XQLE8gOyjcirjMuGbS
         Tdwvu8eqBZsEjxtTpVtYR7dyUh3DJvYkJjcBpm9TKi48BlvyMyOFf8Y6AhDTcWKwofBY
         0yXvuPcjvdDrqD1sDeGJpdzphAbuUd+jaE/oKjB0KJJl39uQxkZkrF8TAYGh3q8yVi1H
         Ld4nWCL9iXd8atIk6Xxwru9476xZDuuDkxkTyNWlxgcrWAp0RQySH454I3H9f6a2K7nM
         CSfA==
X-Forwarded-Encrypted: i=1; AJvYcCUVY3HRqs1CHuUujrdBb7iMmAI9+qpnnSPinIQfbTraYLyltCeW5bWz3V8IvlEFMUMSCUiw9ZjzDwIC@vger.kernel.org, AJvYcCWVHy8R6D4h9ukitBrnhIRB4ZKrUbXZJfqQtSzbQgZV+DC2rge4ZYSAQSlTRq0y5lIYgNvFpxUHdVvO6PnE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fEEn7TWZkXH+1BlNyFZb9LEXl1tDk+pP3xN3F6ksXM2kuF61
	0yW1Wn8nqj8w60YDrCeLiKyO3D3N4ie6jpScG6qGxtIALv59DlFGIX7/Gg==
X-Google-Smtp-Source: AGHT+IGpXpThTma6QJO1S+zAhN6KHrK6GEj4426UT+ny0xvzEoHGIZ6hAyI9Ihj1vpMmcRj2h6wDmw==
X-Received: by 2002:a05:600c:3b11:b0:42c:b63e:fea6 with SMTP id 5b1f17b1804b1-42f58497f1dmr19294635e9.22.1727429091826;
        Fri, 27 Sep 2024 02:24:51 -0700 (PDT)
Received: from localhost.localdomain (158.red-88-11-182.dynamicip.rima-tde.net. [88.11.182.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6665sm1942996f8f.54.2024.09.27.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:24:50 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-pci@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: acpiphp_ampere_altra: Switch back to struct platform_driver::remove()
Date: Fri, 27 Sep 2024 11:24:49 +0200
Message-Id: <20240927092449.44628-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all PCI controller drivers to use .remove(), with the eventual goal
to drop struct platform_driver::remove_new(). As .remove() and .remove_new()
have the same prototypes, conversion is done by just changing the structure
member name in the driver initializer.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/hotplug/acpiphp_ampere_altra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Bjorn,

This is the last 'remove_new' inside 'drivers/pci' folder. Since it is
not in controller I preferred to sent this patch alone.

Thanks,
   Sergio Paracuellos

diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
index f5c9e741c1d4..70dbc0431fc6 100644
--- a/drivers/pci/hotplug/acpiphp_ampere_altra.c
+++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
@@ -119,7 +119,7 @@ static struct platform_driver altra_led_driver = {
 		.acpi_match_table = altra_led_ids,
 	},
 	.probe = altra_led_probe,
-	.remove_new = altra_led_remove,
+	.remove = altra_led_remove,
 };
 module_platform_driver(altra_led_driver);
 
-- 
2.25.1



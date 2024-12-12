Return-Path: <linux-pci+bounces-18258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBAC9EE4A5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF499283130
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C321146F;
	Thu, 12 Dec 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR/NFUX8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3639211467;
	Thu, 12 Dec 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001363; cv=none; b=g0rCX8VZzUg6rgvzu0MmQpMSw0HqzJ6iI5UeYleXFv92W/EBYFqt6NpJyazcYshnGFOb3MNuYjjmiT1luLCfz8lVzWaVa39GkIq7CtifTIKpPPeKwZHESZ5aG/gIhFS0bNbQwM4RzEIwm9maBNbTc+4wgSQJMa/jNlRK+cCxIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001363; c=relaxed/simple;
	bh=qAUGg3igamS5aggQF6++zFN3fZRAeWNNqwHFVdcfvAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FytNAJaHRyOm7eD0+YAkwjeWwA9Z49MH36Zf2Pe4h5rUS85+chBNvKQsobyTDxkzWEH9/AGG4uWwXGCcU97Fd9049Xi/SPUcQPi1E6ZdkGFLC9bm49pIp8JF5GZ+SHjPzn96kg0flKXNo5lR+mc6m8didze6kpZoOqT3ztY24jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR/NFUX8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724d23df764so352817b3a.1;
        Thu, 12 Dec 2024 03:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734001361; x=1734606161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roq0jjNW+0dJq9LFOZyLd+OgpvWNVcBi+LZaoyb9Brs=;
        b=iR/NFUX8s0dQRmSioIb5f3Vji8tSDrCIDFtg9imscRS4+XCKP2azBmWCHdzig7v1ZG
         cwJzg00BcsubIPu34NHmdm58TFIeUhESs/nyPFPLHbRGW0E9KwvOWKmAGP6lP9wA5op7
         /oL2QHxJ9qltPUuTAEvmHaRo2R8cyXDIosu878GSCBVUGqvsueyWHzIxVuZevx+pRu+B
         nGU+wf+UyGKxMU8atcax7k2E9+TOXMe3+EXpQ3Wa8GuQZuov0Gw6U6VldWDV0Y5F3o6W
         AmpfoquqJJisVKRl0bdKVC+qCnnFcHWmaARbkm3Lc9AhJ4WkndHJLGZw02ZHpicFL1S7
         WYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001361; x=1734606161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roq0jjNW+0dJq9LFOZyLd+OgpvWNVcBi+LZaoyb9Brs=;
        b=XnswCpWmDfBbnGplGPWi4Y4ErgHKV1k1etcTQlRsRYhHWtN1hp8RNu1lYcNdKeT9R7
         CxCdDBm1XgYrkjtGOTNebgiA1Zlu8gWoK+5Kewzyx2Kv4kKaonVaOPZiPuqwijZcrHAx
         Jx3vxZ41wxVwldHJETuld31pYSbxTYbaRz8loT5DjploTUKo2Cy7Z5rdP1tqWsjE0M2k
         lPaQZ10VIIMW3CgdGXxbZQWKrZ1hFQsQ9Qa6zFwbiVJc3as+lSxmt0EyjWZxgdUJlAkQ
         q1PolDEL7RmQfGiSqhcZ7fwK6o7m9nMLHl5fvvgi+GsvSSW9pAPZT8vS1Zliwlc2EHSM
         PPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjVQpcnaC/3zwA7rv98ZmSOQITY3f4Bgh1wTqJ4YI4PfGv31KP56b9v0mB13SwaOF3t74/M+tL8BtxinU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhljTd1eUIk+WFVzZdkwriUjGFAfTKde+B/sRcO+28W5YNuoB
	y7ny2rwFCyuBlfdssBSCiYIq+OPknYbRpFqEh8rhYtVU3Co2o4ft
X-Gm-Gg: ASbGncvhCm/mGtsKp14gz/cHhBi6+sepzkGoiRldYlvRhU5T/PRl5qPK4SbyUy1jmMY
	tXy/BatRtQSpAqVeVEofUGRT9k30DvexIKWNNXnVIrln+sctaoZEUVoLh9yeBcaeoDoLvorn/pF
	DFbjFZJ3Yn/p5Mty4BGzb0vMzMhdQQCYBZOh5XVQimMJwkotAyvQHqfBgoj5DeM6I78Jsn25K9K
	6NzIxY+JD4+Jv5784WQZW47rhJrdnTf+5iG5QY5bu8H4Gx6uXYvDqj5bSTnK9c=
X-Google-Smtp-Source: AGHT+IEfJBOEkgrtAA3+eD8b2ElmqcJZ19D6T3WBFafyU1LnwEaUksQfvNUvXJ4KpIIn/w8x7b44sw==
X-Received: by 2002:a05:6a00:17a7:b0:725:f1ca:fd76 with SMTP id d2e1a72fcca58-728fa863bf2mr4133891b3a.0.1734001360936;
        Thu, 12 Dec 2024 03:02:40 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eb14091fsm7335922b3a.9.2024.12.12.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:02:40 -0800 (PST)
From: guilherme giacomo simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com,
	namcao@linutronix.de,
	trintaeoitogc@gmail.com,
	ngn@ngn.tf
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] PCI: remove already resolved TODO
Date: Thu, 12 Dec 2024 08:02:33 -0300
Message-Id: <20241212110233.787581-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_power and set_power fields is used, and only hardware_test is
really not used. So, after commit
5b036cada481a7a3bf30d333298f6d83dfb19bed ("PCI: cpcihp: Remove unused
struct cpci_hp_controller_ops.hardware_test") this TODO is completed.

Signed-off-by: guilherme giacomo simoes <trintaeoitogc@gmail.com>
---
 drivers/pci/hotplug/TODO | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index 92e6e20e8595..7397374af171 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -2,10 +2,6 @@ Contributions are solicited in particular to remedy the following issues:
 
 cpcihp:
 
-* There are no implementations of the ->hardware_test, ->get_power and
-  ->set_power callbacks in struct cpci_hp_controller_ops.  Why were they
-  introduced?  Can they be removed from the struct?
-
 * Returned code from pci_hp_add_bridge() is not checked.
 
 cpqphp:
-- 
2.34.1



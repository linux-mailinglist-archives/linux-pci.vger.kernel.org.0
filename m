Return-Path: <linux-pci+bounces-32411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E72B091A0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666AC16BF5D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF732F8C36;
	Thu, 17 Jul 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVwQ4ywj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630F204F8B;
	Thu, 17 Jul 2025 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769364; cv=none; b=CWCOSotJvYTyCuD52zwp1me5o75OPnPu33Iv31KMchsMWrHkDahG2s5GeWd50t0HKEBVOZuKC8fPS/KIelqDa/C15x8/Ly1hm1VkflDBNECCfDYNIXNCTJmj98w8r9d+otiUISfX2AD5XTBIKfzVLbMPLSS5bjXi9OilM3NV4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769364; c=relaxed/simple;
	bh=joK5l4nAFeBogzgih6ugtfRfS/lwf2F2gFNZEzyH2oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LT0kPLf2JmI5t5uYEq905HPUDyP6auFEvt4QbaZEpp0uTqLeFEs486UkX56qh0f+H3/CMJP3DiAQGeqqOfJNxO31SLihy6iOXBbuivnmgRs8xsbjAQMxlNUCUoGjlh6r0FRvsmo3hniMATGBeKpfhImza+gS+W/6jJjxElJcdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVwQ4ywj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-236470b2dceso10050035ad.0;
        Thu, 17 Jul 2025 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752769362; x=1753374162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3chhfnIFWg2q3Kmk+pYjIH7D8dXZu6jh32Z7UgtC1M=;
        b=YVwQ4ywjFWn/UO5b4WgOPGvUelb8IhPmlDz5CTdYbF0vnakaaS/oQP8oiW5VroFclx
         UY+0B68vr/j3234H8ZpuU3VBqmytlr36ghB9w5exMYp3ATJXgljnPYui+dB0ejTo2WGZ
         rDCsbmpacoj9Qp+shKflax7sBTdx1KeAfwPvvBObRdFn9YwSdONGg9Vr/lFIIdqLpV2R
         xe8qjIJ9FEMfipbDpt66P84vG5GSuQloO+zkDP4w9LFAO4OT3SQ8g8drC58FqZclP2MO
         RXHv+MLVKELxhc7V86tCWR4lf8K5bgnp61ftMLiINaM5Ue/zh6KAwWYlTs66AdJOsOR2
         u9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769362; x=1753374162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3chhfnIFWg2q3Kmk+pYjIH7D8dXZu6jh32Z7UgtC1M=;
        b=w9G56Sp2lBtzQAt46ZWZOXTzTRkGuWiEzcXFqu5tPIuf9GcNJHRaQvf4tfuYNnQL1P
         8BHNbXxCu0ni4qyBzJTWyBgwRZcIgkHU769m32FHlnLB56hNygQoR/JuQrbhItQBW/d9
         vbVhrGBi6Wl9iP8QQpF8urC+v0P/gSAWQCPHrKE92s01+/CrnVcbkK4TxLXUkCq8vKee
         tTjSqODUZzQDESjVPJrFcx+vmR3RMNc9vOU30D5qyGLkP9XLmGQ/qw5qS8q/LMwhBOxM
         hlouhbm9yVW27OKFI0S17avjBLwctqlVN4ugAGeWdexiDKZl+JDj41gl17iwLCO+TRNW
         ooWw==
X-Forwarded-Encrypted: i=1; AJvYcCUHdjJLbn4wLxnxOEBX4LTzQat9BWM6Lfgo5C9i+Qkf6x6MFF3lTwoayo4KURDr0InzxtqpSBRGJtLU@vger.kernel.org, AJvYcCW0pnyOsrrtXUBGP5mLedYdH+C4TMHx326S+tmmyseAg6Zu9rfaJlWg8JIQfcHV1RalNDltUYCt2MIQF/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwODSmo428+IyaVGHpAAgfIblP/9MXMwAGFYb+iJfZkYpYhUP1M
	T3lHRuecB+RrlGAIr/yFuppflxcuRTkG9X40LiFUzfMvy75Ph5MqxVOESe9g1g==
X-Gm-Gg: ASbGncs5V/Pxr2Sty1hWvuX0h6Qt8cRHpZLuB/h+mrjp4z6g7HvL4Htw57RYT2LdVpK
	XEeMHooqq6QbeIAK1oEa5idmdXJJ5eF1WNSwDHgML4kqAMSENFmfolFgMQlk5Xld27LEbGhN1bk
	y1hv19FHUvHYBh1TKbjgOVPxp31VVdicVg6MCbpE/KcIoC60qwCgfAkMlMFc9pl/hFgSHUDYdQ6
	XLfGCsAKNdd4elWMFDLA/WZWYYouOr7aDzSIgkeToa725kPRrMjGAMbwFUz1i2O04QlwL3VmI5I
	e4U8PjXyBi/3tkddlqUSqjlq/0DIFy+CzW1zDnNqdRs2tT7Bi09dSaW/pZsa9Ho9gAT0yFtdU4V
	wovq540U+VYTfP8/11DIx5hAAIE8a8Y9qMW74OQg=
X-Google-Smtp-Source: AGHT+IEX1e1H04bR/uRlXyS7o4hwZpN+MsLD5ZNyPP8F38qeRWSqFEX2upZklybtjx8gcj8JujXN6A==
X-Received: by 2002:a17:902:da8a:b0:23c:8f21:ac59 with SMTP id d9443c01a7336-23e2572b0c0mr113058355ad.29.1752769361832;
        Thu, 17 Jul 2025 09:22:41 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434c264sm146145065ad.201.2025.07.17.09.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:22:41 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Thu, 17 Jul 2025 09:22:38 -0700
Message-ID: <20250717162240.512045-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only, admin-only interface for reading PCIe device
serial numbers from userspace, using the same hexadecimal 1-byte dashed
formatting as lspci serial number capability output:

    more /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0/0000:ef:00.0/serial_number
    00-80-ee-00-00-00-41-80

If a device doesn't support the serial number capability, the
serial_number sysfs attribute will not be visible.

Comparing serial number format to lspci output:

    sudo lspci -vvv -s ef:00.0
        ef:00.0 Serial Attached SCSI controller: Broadcom / LSI PCIe Switch management endpoint (rev b0)
            Subsystem: Broadcom / LSI Device 0144
            ...
            Capabilities: [100 v1] Device Serial Number 00-80-ee-00-00-00-41-80
            ...

This PCIe device sysfs attribute eliminates the need for parsing lspci
output (e.g. regexp) for userspace applications that utilize serial
numbers.

Matthew Wood (1):
  PCI/sysfs: Expose PCIe device serial number

 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 26 ++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.50.0



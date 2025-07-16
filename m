Return-Path: <linux-pci+bounces-32300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4314DB07B38
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866FE1777E0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4D1C8604;
	Wed, 16 Jul 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0MGJiYd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988C18BBAE;
	Wed, 16 Jul 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683538; cv=none; b=ZzkEBaDEaLM1Nb1bS8k8N5+bgx3eXo4oFr4lzS9ioyp/Ytaiut6Bmn8TEYhZWxAOCxrPVo+YqsA4O07a15x0SgE13l19fxWYbKjbWxjdTmj+BjHW90Gjmr0Ls30ouiC+xQ+T/SqJLhY8On/rS9pOcZEr/811+jWjJoEAC9Kf0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683538; c=relaxed/simple;
	bh=/ZzmXeNhUznHB2X+KabNlhRqaE62vp0Sz1+HLJdk5I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0GzTrZH5D5eFrvr89YiPXMh0+u1wqZ3tLEpGblyVj1W/pbnT//6tMcl66bZ+VuwPIMdwf5mRLAHFOCPm+wWiOdSDEAo2FYHLaB2YuqaqdUGUNUvEc6TJcw3IQoJpnXHeMR2dTUnwj81LeR79I2vE12gxjMlg3/Wui/22TRG8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0MGJiYd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748f5a4a423so105898b3a.1;
        Wed, 16 Jul 2025 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752683536; x=1753288336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TuLNkirkC3GiQ+ujqr54iBz38MwAirabSdPAD1WNvRE=;
        b=b0MGJiYd8DtWiELL7qdudZXHgoYffnB24qlu0PaeIupe64GTd4cAfz04Bgu8LM+GNi
         mI1HzjDrLNpBnXub5HNzNGl0G1ETFhCd3uchtOp2VvKIrfNhQuTK3vUq/kRJOij1kcn6
         p+eaLE2FW3IIINsC0mNF5DRM+5ySZt71GBdScRRFwIICg7a7MlRRsoKAEkv3ZN9M5Gu5
         oHSHHNvmu2qpM3ls+2L+e0jPMYSNNYEnFhr0dOKv945ub2QlqTvRKKrpV3iQEElw1j3N
         dg6adoOLMnPrSd5Xht8DVtwvxSZSv0kZ2e+C/6MBOiBJLn85yXR3HtLlotFJ4w1tY0rL
         s5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752683536; x=1753288336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuLNkirkC3GiQ+ujqr54iBz38MwAirabSdPAD1WNvRE=;
        b=LtY3Y7hcZwDTMfJ6uJvi/7amTt8dJfl3pGpoBbeOrC+KOfVQIJzibH2t9zHYAHLvF4
         AWDRFoYmHuMyvfRxmXPJWGonurntZcnAWaaayg+Aey2ZmCGo0lhAOYBzPp2J2kZYTZ2A
         TDdOXi6zivC6pdW1qRA0pKjYOk1cVaoLyqTKqcMDeLQHcoTsHNwiLq2g91zfDfcKYeTE
         TrEMC2VBJGG2GzfzTUh9dIyeVzqOo8nB4G+nNbylHyr2Drp4lBFm049ytEY0hQULUryM
         TyVrXEc5ADE4oVfS3iP8l29c8QbmT4631SqodzE5WVY7ne3KBOzCYSZ7BeucCYXkXyhd
         xGfA==
X-Forwarded-Encrypted: i=1; AJvYcCVPCP2lfQ0L036WDX3vp65aS4H2xvxrEkBZRZRVkwJhumvaEJH05CUF5x/d0LDDkeoVpGlo1rLGmz1+@vger.kernel.org, AJvYcCWTL2DB6LsoLAueWqO/NP+XxHCbd7bVif1DJ85JIQf0rxMTIWmPscOR944UJdtjZS7PTtYbRcRvJdQVfVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCR3Do5NVImz92beS3SkWDj1kgYAP+m/90svwcZ2bRtkljvD3e
	xjHuxWxmxGxOdqXiMGYIWsFPN19uSHfR9FM416A4RBd+YJ/HnCUneRCO
X-Gm-Gg: ASbGncsPREbhXjzk9DuT0i3i71YDrb4AO+6xdBGgdCqZ8qAgXLTc5LWkqEEgPU/67lE
	ZhXI22KGw4rwmXJtuz/N3nfzw9LoB2aOP3Klb0Y/piGM7AJ7Tm4kXCuPPFynfxeJWydUxO2aB6K
	LvVqWrl8gig88oak/Xh/yRtLndFcHwow7Poi1tLj19oJ00+5/4zAkLoyDTs+hPr6rMAEumR5IZE
	6qJRFzPNm7/GNL1ux11rcvB75CVdqYJfmtZY1f2a5UcuIYZLZb1aeim6djPbqBPvAtTiDJjgJjo
	C1m+YrHJLL1AadIidO+/DKxu+42BqRCcdLNVxs5/61HA7nvzGoR7y2GuAZouohHWnrkrCQ2IkBI
	bs0GuOMGDd3TzChBpEOrJtxXu7phv
X-Google-Smtp-Source: AGHT+IHV/AhcMGahDWIaBaMJbYETpIiwN2IzHNXR9A4GVOvbhW8cXcha6C7gHZX6JgW/h7JriRh0Bg==
X-Received: by 2002:a05:6a00:23d6:b0:740:afda:a742 with SMTP id d2e1a72fcca58-7571f81b8b2mr4411045b3a.0.1752683535788;
        Wed, 16 Jul 2025 09:32:15 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b2f6sm15143440b3a.99.2025.07.16.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:32:14 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Wed, 16 Jul 2025 09:32:10 -0700
Message-ID: <20250716163213.469226-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single sysfs read-only interface for reading PCIe device serial
numbers from userspace, using the same hexadecimal 1-byte dashed
formatting as lspci serial number capability output:

    more /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0/0000:cc:00.0/device_serial_number
    00-80-ee-00-00-00-41-80

If a device doesn't support the serial number capability, the
device_serial_number sysfs attribute will not be visible.

Comparing serial number format to lspci output:

    sudo lspci -vvv -s cc:00.0
        cc:00.0 Serial Attached SCSI controller: Broadcom / LSI PCIe Switch management endpoint (rev b0)
            Subsystem: Broadcom / LSI Device 0144
            ...
            Capabilities: [100 v1] Device Serial Number 00-80-ee-00-00-00-41-80
            ...

This PCIe device sysfs attribute eliminates the need for parsing lspci
output (e.g. regexp) for userspace applications that utilize serial
numbers.


Matthew Wood (1):
  PCI/sysfs: Expose PCIe device serial number

 Documentation/ABI/testing/sysfs-bus-pci |  7 +++++++
 drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.50.0



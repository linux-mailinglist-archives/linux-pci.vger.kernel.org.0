Return-Path: <linux-pci+bounces-32563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A08B0AAB7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 21:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA561C42CB6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF1420485B;
	Fri, 18 Jul 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZptMabC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA61B0F23;
	Fri, 18 Jul 2025 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867154; cv=none; b=PMVkqvVuBOy9lWs9E1ZHbNO8A7pmISyaFydVdGMl+aQfyrrRjF8k9t9diIf3pzta0+b6wdZ0YhfenpiB+qvcIkCnDrHVZJIwhlFpXm2Zy1o7ekaqpMOsBUcd9pNDfk1k55XG8Mf1tsqv9ZaeEL9eg/ve2mg5VTU5GYCPQm7oVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867154; c=relaxed/simple;
	bh=gh69TMq8lWBk7FqSWI9JzBENY/XMfjBBSlvlf+/rK8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nma72Tpo8JEP0l+HcLSNpcEHTog3Yg6eJqeJqMR/THeD55mfjur5+xdrRVqTOCVa9cNipTMFwZnd/kj9PweCySRqTInC0R20qlz+VYXtjwE/oYCVC/V9Y+hTXExJrbHsZ3oaVpZ3aqyomJuK+NrvaFjV55sZjf/ohuhNtdXDmrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZptMabC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3172903b3a.2;
        Fri, 18 Jul 2025 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752867152; x=1753471952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KK8GSCQWREr7qk4g17XfUgcgKnE4Sv+WuDgA7WFvmSY=;
        b=aZptMabCisXAHZnoOKBj+S7ULZr3ImP4/MxFsnJ88hxfboxkN/QQZNIC6D1xCxDIwP
         GwF6rIpQrIJnXaXA6nNatVmw/w++N3SRB+2E9582MXeY3GAVLR/SQAIkt0urQepd3GBN
         0e4tgMXPmDlrq+XEzUE3MmaCv3MxFHdbahbQAJBHE0sz5+4nrsM/3Y9ntg8/rfj1GCRs
         b8tIWKb74gBVLxEK3OFCNjca+wSHmEPGTcYoyFdlkipOtPwYiZXqNvlTRbBmLAugDVHn
         MukjxmDO4mQD+IVh+HTfYMYaHoXvwQj6MM/kXpmg9iWjLSQxlP41V+h13q80gNe2mdVw
         +U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752867152; x=1753471952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK8GSCQWREr7qk4g17XfUgcgKnE4Sv+WuDgA7WFvmSY=;
        b=XD/cI7yp8gEbJ1ii9u7msB25b7dxDtN3mZ2HhPLwO4wZWEL9sALqmAhpLr9j+Figs4
         gnWOukAefUHSkvNOeN4crCAH9/tgrlVfCfxpDV4yA1o2Mzi1WIZ4JMtUOgGuIRw+kRED
         HzxjJkrELydfWMvzU5GpjGfKIGi8wIlG3EnYu5zc/Fu4kkOR1dc+aOcfK1Vxoq7uMRjP
         d7ZYncoTJvTm2EAcZpqshvy+tOBh18tiQvmdC8lCP4XfPSKAx7j1T87vmD3vzTHM/j7P
         LrkpyGRUH2toMlcXdRL5NqtH0d9PRjRPm/qN/EF+6ZSvifZ8MO6V27vVlk3vbHTw6qSx
         otiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSA+7fyJ3rHUwRa7P2KYBIWBhU4Lt88ihoxQBn+LgmMElKrn8fo2G22L0PmwdCjzen5dwwDCc8KbZyP78=@vger.kernel.org, AJvYcCUyu2as9Y6fQ7FpdCWx/CL37nJXKx3X3pemyB5OY5PBIjAx8T1ZnCH6jiO9DxF30kxw4ijJ+93dljS1@vger.kernel.org
X-Gm-Message-State: AOJu0YykVEblU0LduYgzzXXlpTrlnS5f4a1eXRf9jzf43RvYOGGZpsWE
	YbrsQSQv/+6kJQ0WEeGBWAShNnnvfd8LYeWYk/W+W0NJoV7IaRSdObpWuPdCjg==
X-Gm-Gg: ASbGncuNwXtc//Yy3xpjSTaWpspXPKujP+x69PfUyrYaVMFje6PqpN3vZkV3//wq0Xv
	AlATYq8XxcOnXSxPn1lQHEsdOgiEtMTYWkqCcMbDM8bXqtUjnHgiduvlVyZmEa5ZUlwqxhjjcTl
	xryYaVes+jsY+uryAGnxLb0K22MC+DFnWK5krBF7XtNFypY0ybCIwyz8nEZcgp0mEztQPTJKqL4
	F0aDhF8p7dscmFdhl2Yka2WrVIsB5YdqTSQJCIKyIy/E4sHWd41+ruy34WhP1a2Kkp1PSdRfA7L
	/IALPJHOivzSct6AEkte0ELvwBYzFJT9dMq1vqgDwj6fnf4dcjdLcMDSJgMwtDjnI5QY3RmCQvl
	eVoOwXO47LS4wSLo+iAhiO3w+YcM6TfxOiRsp/6s=
X-Google-Smtp-Source: AGHT+IFu3ZOIqYcUqJ0SsyHaNvxYPpIemyqno7Bihw01lmLrjf8T+dxyRbP77P3YwfF7BTWhi8AOIg==
X-Received: by 2002:a05:6a00:1407:b0:748:2ff7:5e22 with SMTP id d2e1a72fcca58-7572316d8bemr15615715b3a.10.1752867151987;
        Fri, 18 Jul 2025 12:32:31 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8ea7bsm1610609a12.21.2025.07.18.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 12:32:31 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Fri, 18 Jul 2025 12:32:28 -0700
Message-ID: <20250718193230.300055-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.1
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

    sudo cat /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0/0000:ef:00.0/serial_number
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
 drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.50.1



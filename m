Return-Path: <linux-pci+bounces-33313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 970DDB18735
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 20:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2686D1C2669E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19F1DF749;
	Fri,  1 Aug 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/7xBOXb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1B41C62;
	Fri,  1 Aug 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072009; cv=none; b=TDSrLZtQ4oFrQY9qCT818ewJowtz8JKMDxfdSh6TRt+cG1V5FNRX88ASNUddh/+iG6wzf2aeOfFp5L0R128pCsoE/eljdn8AD6h0TnS5VoK4YfU83iNP5djAjZbJ/VTplwBPFa9yz9JdDNl6Up2fhfP8OW8gYc1ATvKBkeGcNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072009; c=relaxed/simple;
	bh=WHrQ6Gg6pBrhILOkRRqv/KOq2/5S428AZOzBp+M+eK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rezF5ruj+aIUmogR+ctVcgoNIsSvJo6jFMDr30rQMjj49JOoAxG7Ps3FiGDQQ6eZCPfwq++2ol4opMKOaQQsII5AuP9LhRgqoDolaHEt6BquW0KqkkG+371k0bWlmAs1VcJCPk/qSo1+ZGHw2tGV+EFhpA3GBOTL/HC0Iok6gyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/7xBOXb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76b0724d64bso2299768b3a.1;
        Fri, 01 Aug 2025 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754072008; x=1754676808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oCT4jlRxx6XlxVgq/Yifca+o2fVNIJXQCE6jB6QlCHo=;
        b=N/7xBOXbjmuYHAUsMrzPvssEdSbIPeZHUJQU1f4RMNPTE7Vif0RP1bORW/397YJghQ
         wySp5VSM6avLSjZuhrDm8CaTFwAGSHfw9W3ScPwX7IOXUq5dI/gMppaqieh72wr0U7Bv
         HhI+hML0/fm9P4uovc+ioAjxXgS13zL5RM2aEMEG8F989j0q8CmnyvXa93fhIJhVBwOn
         GWeZnFBqcYiP3jK1kc8+Mf0ng3awGIFX/T+hsNwoardcPPGdYN/uGwUk83mzBON8gRk6
         A3FqOqqcl13srVLUWVYkMxkMFLUHoxauRru6PpwG8wF0WKLycWPmkRl7c9JT6GJjf9Uz
         v6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754072008; x=1754676808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCT4jlRxx6XlxVgq/Yifca+o2fVNIJXQCE6jB6QlCHo=;
        b=UvtViPouLaanUjrVXmGQKttnpIx4suyGwO9/iMJmsdgGv/31ECgvieNdtdlp4Azgrn
         HzPmiOhiNxp2Zr4XvO6VBhswBYSHvuulzfHc9wWm4LuEXMyOSpx1vU8/yDcE7OJnrbFa
         CmxT7aQUe8PB/dDHqzJYeNhlk0dmrweb+J3W9BIX7HsKyxc5L+NyCR4buKktqFd/57cR
         3umOHScxUDGJUDK909lAvXqJqrnUqEYH8V5/OlfmzBzukX11yNkzG4qt0ZzwniIY2ss6
         Uh7VJXJIgSeJjrPs2TxsfYwMM97t3AG0OmzgS5EY53torP+ArJsR/w1r8+48YA5OO/Ti
         BR+g==
X-Forwarded-Encrypted: i=1; AJvYcCUgGlRBrJWdjU2qGnadQBbFvjco78tPaWBrSc+vkZAc0/G75x7/bmh7NXLqGgdWZnsNcqa93opphP3q@vger.kernel.org, AJvYcCVS0wahxC+ZSW92LG+36GQGDar+gTRhEsCdHT81h1CJ49P0dPDtw46qvoHI2OwyWYHrtiafYe6Wp4+wdA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtZlV4y8xLuswVgZFmXLXrg8BAz8y2NNkg6g1k6rhF5RBzooc
	yM6Er7IYGpo1J6ivQy9VLxcBAkVYhs7YRyBNwdIUg8BZkLTSHYAy9whXia/MYg==
X-Gm-Gg: ASbGncskyDTpkt1GU80nNzE8YyujlKnt2ctxiY102lre1pYQ7VbWUkK6gBNPsJMj0fj
	qYUR/cA9U9moCG/rb6++UKRCuSoKon3T/3XAFTzRutfwJ+Z4IT6v4gqAXciaX3bwpBKmMJ3XWaR
	685Qquy2FzzdXhE7KPwz9+GDriUGhiA5YVI27biV9M+A/I9PEfeHYHDaYPr9TFv2SiPWfRbdEGb
	jZph+n24OboPrsMcMLnL+w9fy8J2DA2w2AB+rfWbaP4Y+tPgk4+jacsk0Dn7wP8Nt//B8ubN/7A
	7GoMMaqJY1JfgeBXJIaSztqmM8Te0/kEH6Rav8CLLRvpbogmJIGD8eEbtOc5IlQ8xIjGIXfPxOZ
	Ln+xj21eb/lZzA3Yan3jmgk9rzYHX
X-Google-Smtp-Source: AGHT+IF4FN2EJA0tUwha33dJ+k0HFK4QaDSyrY00NVedYXAy6NxXc37fRMQnfLyg+cLIFFPu5wDaBw==
X-Received: by 2002:a05:6a20:3d08:b0:23d:7b87:2c88 with SMTP id adf61e73a8af0-23df8f6d4c8mr867846637.9.1754072007771;
        Fri, 01 Aug 2025 11:13:27 -0700 (PDT)
Received: from localhost ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcee7sm4680272b3a.66.2025.08.01.11.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:13:27 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Mario Limonciello" <superm1@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/1] PCI/sysfs: Expose PCIe device serial number
Date: Fri,  1 Aug 2025 11:13:23 -0700
Message-ID: <20250801181326.1782789-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,
It looks like this missed the cutoff for 6.17; do you have any objections for the patch
or do you think including it in 6.18 is feasible?

----

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

v7:
  Updated docs to change kernel introduction date to December 2025 (6.18)

Matthew Wood (1):
  PCI/sysfs: Expose PCIe device serial number

 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.50.1



Return-Path: <linux-pci+bounces-7745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE618CBF10
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A209F1C219F4
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F3824AD;
	Wed, 22 May 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXTJnBZp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDA824A3;
	Wed, 22 May 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372749; cv=none; b=t8mKZ3tY8H9bc0YZdqOfQ7ARYF9J9cjUJ9XAbe6gBXP62Fp+h/PqzJdum4bKr7siDzigs3hlSTXNCnAReLomCI36j6rSQP6glibbE7CuaRaQjdWu6k4tsLWit0XXYOSRDlAzYdk2iSdUvOCsZPHMPFghjNGjgF5C1pKOPI5pDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372749; c=relaxed/simple;
	bh=nf38RgXKckNA//++U+fbpqBoqTwnk26oCDdREN9SisU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ/hfU3YsPjBLfJJdkTj9GAKLnDto8CwVXd5/cht1HLDXNDMh3fpiF7V2TRyfvvoaZXP0E1CkufMi3W8C3Ipc9d5YDcVZsmybsw+8NyFaf4R11pun0lwmWjEXY/R5kpN/OVujCxDU9CZEzsy8xMDArOEjBR1fNXY5BDb4+naGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXTJnBZp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c3aa8938so110663205ad.1;
        Wed, 22 May 2024 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716372747; x=1716977547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH0CAgEAzY3nt8fx/klVxthc1x5d0RrIHXtq1pEypB4=;
        b=WXTJnBZpyLoYb3eQb9MXYxfBZ4bQWN9dzJS6VxQNU+u6KbNWtnlVXuL0QaISoENVjV
         hmmx3dtrlmhptJFrDABAhAw5v9B/uqWKqRezJL0DEUqbzlcWv6015Q8uZ2FiC1rkrJPi
         RN4/m9SMYkN/e9JOsFQHKBCXEhISLAK3neLzBPNZfIhcY+W/Yc/I+w4iZJ8fmRb3zvEH
         M5UHtAY87x7QUSHwaR/WBmZWTKbYyCCQRYOasp70Bk/22h0ekhC+6McGvUFjy12lHQeU
         AKgUKCh2q+/nsVH04HcopHMP8ITITfrR9qut9FfwSOTL8htIpUfuZ5Ql5URFb3ebtgjg
         N7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372747; x=1716977547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH0CAgEAzY3nt8fx/klVxthc1x5d0RrIHXtq1pEypB4=;
        b=VMSYldo021kOUTmCn3Ll8o0dK6iy02IrzZ8RfmTPy5C+L1Mmy/7bRENE0lRLqrXErE
         QtVHMkPySe2P4oD9ckBQb/4isDTyP72niVPj2r34PvGuarMTXP3UVigUG5MziBwx1X2O
         oyGddX+aYs37Lwy8MP3jU4sNXqYLQMMzQf0CfPCgZjOTmRfDnpEIplIVDLIBteGQGLng
         zEm49gvUJzfWYN1YHJJrowb+TmAbvkRlzCO+5TQkPL/kAdczk3qIAn8R/clYIGV/6+nu
         qrZ/UZm3nm+1srrHctDmVQHos4QU/PVu7Y0TDwUmJSQZ9AKeDpxr9ds2cDPLyeTV7Po+
         OHJg==
X-Forwarded-Encrypted: i=1; AJvYcCUigWbknPCcRHw1NfmGAFL0Puo5OXswV3VhxRxB8/+8r9Mr696JNCWpNsy6y7JfruFDCH9gD07nyWlNJUzCiqEopkJcp3X+/3kajXIJyZjbvBXPEDt5L2q0gwpCWbLyG4iPNyNVQP2p
X-Gm-Message-State: AOJu0YyQldKeBPrR8FEOfMoJSDL0Y+yw6biWUmdo748koLhb84Q7Hjos
	E6OLUklBPUrO0lkYz+yJOKdokrJx0Fs+nmyCLf7M13SqZmUk1awFOSnKXEHb
X-Google-Smtp-Source: AGHT+IHpksIRmXfsImJ7MYH7YyiaSifjcCmeIkdi/gPHDwUvQdkcXd8lJftUc8jSlXbwqUSg0qjzMw==
X-Received: by 2002:a17:902:da92:b0:1ea:5ac0:ce46 with SMTP id d9443c01a7336-1f31ca4dc02mr17194485ad.66.1716372747195;
        Wed, 22 May 2024 03:12:27 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-f22f-74ff-fe1e-41ce.ip6.aussiebb.net. [2403:580b:97e8:0:f22f:74ff:fe1e:41ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3066594bdsm44593235ad.303.2024.05.22.03.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:12:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: alex.williamson@redhat.com,
	christian.koenig@amd.com,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	logang@deltatee.com,
	linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v10 4/4] PCI/DOE: Allow enabling DOE without CXL
Date: Wed, 22 May 2024 20:11:42 +1000
Message-ID: <20240522101142.559733-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522101142.559733-1-alistair.francis@wdc.com>
References: <20240522101142.559733-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe devices (not CXL) can support DOE as well, so allow DOE to be
enabled even if CXL isn't.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v9:
 - No changes
v8:
 - No changes
v7:
 - Initial patch

 drivers/pci/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index d35001589d88..09d3f5c8555c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -122,7 +122,10 @@ config PCI_ATS
 	bool
 
 config PCI_DOE
-	bool
+	bool "Enable PCI Data Object Exchange (DOE) support"
+	help
+	  Say Y here if you want be able to communicate with PCIe DOE
+	  mailboxes.
 
 config PCI_ECAM
 	bool
-- 
2.45.1



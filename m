Return-Path: <linux-pci+bounces-9266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A188B9177CD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 07:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F581C21117
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 05:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCD139D10;
	Wed, 26 Jun 2024 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D37DAw8N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6E1411E6;
	Wed, 26 Jun 2024 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378046; cv=none; b=LQ0IZs1J5S/dsIEatHfI++bqyp+zitBG7G9L9PIWzVkBUUmnVgQMYFzdkBKrmB9CRWQwU1jjCdJsmu8RzkYfUVZX1RjQ+u43LEDqcf7O+86A1XvujZlOXcJSgpfo6mHreOOEO/RPTMZ8ouU48jslGOCAMWVPX4dZA6U9EVP6BYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378046; c=relaxed/simple;
	bh=ZNdxnGPfETJa9uUYOCiuRxUSQF8J7Opi/FFw5TRGvIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkRqIhWIw6PG2H03onWF5pTLaEPmzRG4JU4HtVjh3czwuZ6v8G3hmBK8QuAPgZXC+a6ttWyV3UbWYJvcGQucduubfUurPkYD2jOxJeTp4xJbxCTdd3ik+fygMLEAtPhBcHCACWJoGjF0Jv9zeNSE2DdIKtWqjwmFZyi8/ccgXUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D37DAw8N; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7024d571d8eso4911859b3a.0;
        Tue, 25 Jun 2024 22:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719378044; x=1719982844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbE0aIHExF+1pl24Q0B2lrRdlvYWUhpDzJPWc86zCWQ=;
        b=D37DAw8N4YMqEdD7QB6vYW0VZ+Zpuzd7QDSILWde2L0RcksstgYh/HH6t/xJNqLHoY
         Nvax7jo6U0t1OpUF2ki6M9pPViaq1SpHZtoWnVBko2Jzq9f5NCT7++5jMPZ1aSXyTPOG
         0o9GDsme6vYXpHFXoz/5xLt05bXpOQ4FQROGhgwwuiUILdEgQF39SqReJMP1ytdKLwGR
         U8cwvUU8piAZF7Qso+eNP4IZn0+gR3hQWNSSRwrqcYA3CYlVMrf1A5nNbbzMSCc5MFax
         6+2cqkSk1r1MrfyFGyyfDLTzWRUSRsvpLukDM012Y7kAgX3zHFJb3xCju/spkd7Z0e9B
         TupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378044; x=1719982844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbE0aIHExF+1pl24Q0B2lrRdlvYWUhpDzJPWc86zCWQ=;
        b=WEEthg0u5o2Z+8gc6i+Ocd8zZHZva02zuzWVoaT/FzuIBqjBylJTsWzuGQaXPy2y2B
         ezq9csQHB4cMYKMNmdMJNy87Rjdk4Jue2ikhvhLQxxijHTio076GrQarXKZvwRxTI78W
         R9rR5t6QQmaDnVGMUnHYBjmTt/BTLcTRfWDAZGJsRQ4nUYPPKoS8x27NaWB5j1vNKN7D
         /gfopryn8D2DldcTiq/3YzkkuhkC3hZB44FG6a3W0S5x4JZiGVdKXnF2I94fVc4OChIC
         jZhduXUoepgymRO0urY+hDMSFAuAET37K5YqY9Cw/O0Y2c7E9URowdoifHn97inFCfu5
         BNuA==
X-Forwarded-Encrypted: i=1; AJvYcCVrioZIgy/DTPtXc5KmnENeDht8OiKkct4+J36f5Wmxpdsz27qQlX70pb6Vqdav/7kbRumrqPQEhoXLPSGx3hZ2h8O8DzuXfWfvJQlBmSbS8QR9F3WT8wR7YScZ/3haHD6oodwiOC2D
X-Gm-Message-State: AOJu0Yy9Rbdk0YaLDNVGOvkV0/suHuoygcvdBgRIIW32rURKmc5Q9MK8
	c60Hc7LtJ5xN+/w64On7aX90aZrvxTuJTvlG60s++CxsLtmxTLUb
X-Google-Smtp-Source: AGHT+IFnELHLZrfBMpm1zXtceVdzR+9e2Sv7U6q8ces4omaehRBwdO8Iyy1NaTmd2EHunKJ6NR3wEA==
X-Received: by 2002:a05:6a00:2d9b:b0:6ed:cd4c:cc1a with SMTP id d2e1a72fcca58-706745be4bamr11947722b3a.8.1719378014524;
        Tue, 25 Jun 2024 22:00:14 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066f30caa6sm6673382b3a.119.2024.06.25.22.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:00:14 -0700 (PDT)
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
Subject: [PATCH v12 4/4] PCI/DOE: Allow enabling DOE without CXL
Date: Wed, 26 Jun 2024 14:59:26 +1000
Message-ID: <20240626045926.680380-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626045926.680380-1-alistair.francis@wdc.com>
References: <20240626045926.680380-1-alistair.francis@wdc.com>
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
2.45.2



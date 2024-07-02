Return-Path: <linux-pci+bounces-9555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756CE91EEC1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 08:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D79C1F22F56
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAEC12D205;
	Tue,  2 Jul 2024 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARJsxFGO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653A12C54A;
	Tue,  2 Jul 2024 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719900310; cv=none; b=tuMuiQxwuzZJ2SHM0URlca919bcvD+JLXSOJGCZ+ezucYxaLEMQarEyTJAiZBYXTEtK/A4BF+tOWZZsK3p5y+msF1xcyDHLCtLDo02Q3YsQl4gP7smRH/AXPuCQcKzg7TvCU4XQqNC1iiAhB1AlqfI70FxDkguCmtmsJbp4LY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719900310; c=relaxed/simple;
	bh=ZNdxnGPfETJa9uUYOCiuRxUSQF8J7Opi/FFw5TRGvIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR6k37l5YFa1x5XJSl8txO5stwT8+YADV4qFLlaLlXUV7sRaWfVlmGod5zLIe3iiN3KGyS/9hUCtFfhjaNPols+QPXzq2yz3yL0Nt2q59MV7vyBcnSR2KfzmgiIJOMZcVfYr7I2iaArl8PLeieSgoppIhuXRXKFuqpT7TeUOrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARJsxFGO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f480624d0dso29163545ad.1;
        Mon, 01 Jul 2024 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719900308; x=1720505108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbE0aIHExF+1pl24Q0B2lrRdlvYWUhpDzJPWc86zCWQ=;
        b=ARJsxFGOFRMWCxE1bSNDwTJg4z+VEiqCoeBCfj69Yn0K3mcsRQkClC5l0B2IAP+kc4
         FLWVHk+FS0EuGJAf17oMkCT0DxNi4jmWIaMHjMF717e0MEY5jfMdS2KzV0nUhWVM0H1y
         vouJ1xN2fsejan+6E/zCOgZYgubLRG30RQSX9nc0KBrq+lacyskxFbCvkCdOj0Sz850U
         Mn/B/yD0xY1Zs870H0t2t6lrLkmL+Q/Uv//0Nt+iyyCZJ7nZ3QIAa3Qf8908LrRcdEuY
         OERHkvxDOfBgq57KdmzRDIqQ7csxvKNIes0QjMJ7WgyeqDSeb1vXlj4HEQ78zAwAJBf0
         PqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719900308; x=1720505108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbE0aIHExF+1pl24Q0B2lrRdlvYWUhpDzJPWc86zCWQ=;
        b=vtEe+TZlvO5qv379sgDDybJFsTpph3g/YxQaxYNNewbpZpMSnG0P6LeGAnzyuesOQ0
         0u0Dr0TP6y6yjx97TmdtY/3VT6d7z03lYPMbikVyQuJgTK3OdTCUyAqMFGJF4ZPCSHhk
         yTh6Fh8j/5s2dn0tZ5EMVrKc/Xd5hjD4RdqZF7lKQ3PLZsxEP6wE2cnsNBSWG4lr/tNZ
         YSAVPZu3EE0j0LUWBcUMvSOcCD6rD52XBbdxgWdcDLR5KpqejNHpVKkQrUA/EzTYUddl
         ZyAQxI+cX71nzt8SSmPYAgPUV2DnGlivd8rf56WQyQzB52LGSy6hhgaubVoZ6jOcJiaT
         7J+g==
X-Forwarded-Encrypted: i=1; AJvYcCXBNA5+gfcq6mOfjRVyMgKcKYUkZ3yCkLUV9KqKaQEY9PmqQYY+vgCHI57EBeaNRO2ccHrs/vUhMQDzH9KeTwkKNgLWR0axZNXUg6gWuLgXmpQeoIU93GmMu5/Fjtg4cY8JqwIR46RB
X-Gm-Message-State: AOJu0YxxlcYY+uwT8ve1unA1zh6DGucJ1Nopd0nKIoGIc/YaNjE4YIHY
	o7/kP1uf34RZbi47esyAtLFB/FdR3wZRZMzKkofi4FzCQLWPQraU
X-Google-Smtp-Source: AGHT+IFw23N44QYbnBt7D/dVDlYpnki+jkjcVK85ZTXmGeCz/nIS1a1XbqHQMMMEJIQp5JbG80HwZQ==
X-Received: by 2002:a17:903:2308:b0:1fa:1d37:700b with SMTP id d9443c01a7336-1fadbce6a01mr68705095ad.45.1719900308217;
        Mon, 01 Jul 2024 23:05:08 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d23edsm75484225ad.58.2024.07.01.23.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:05:07 -0700 (PDT)
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
Subject: [PATCH v13 4/4] PCI/DOE: Allow enabling DOE without CXL
Date: Tue,  2 Jul 2024 16:04:18 +1000
Message-ID: <20240702060418.387500-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702060418.387500-1-alistair.francis@wdc.com>
References: <20240702060418.387500-1-alistair.francis@wdc.com>
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



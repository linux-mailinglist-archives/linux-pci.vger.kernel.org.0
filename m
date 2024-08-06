Return-Path: <linux-pci+bounces-11401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D612D949BC2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 01:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91496288908
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 23:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3557176AD0;
	Tue,  6 Aug 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbSgrCGk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5DC176AC2;
	Tue,  6 Aug 2024 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985316; cv=none; b=qCi0wI3+ctJ3UnUF3AN6qVa+PoDkeZNA/Qe8w7k1hvYn4DSDHX9I5LSf3wS8s8djY4wEQrPjysArYQibO/XFbhKOYP0Vb2XiO7Y42sdoPyOuhvecW5/qixveyyTfmlnfnPM0kUZLRyhnzCoaiyoGYaAirbzDQf6YTrygThkb8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985316; c=relaxed/simple;
	bh=E7F+jikrY1ea4Cg2U9hTgk3SA6CkkasrCnZSU7WQ9+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9MtnwP1QKF7ulEP+5QszlnzlaN2vajZFB6+IDvVgOH8wYbYvnMUhrmnc2JB4oKFTxg0ZrDx5rNyzU848aKhogRuRVjw9DCa1GUmau4fTuYlVYSqCVNp9ymvOEzcgEipJxiU8EX0xjFfRgaBPy4sYGGXLMU8zB0lf1S4rM03T5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbSgrCGk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc5296e214so11376615ad.0;
        Tue, 06 Aug 2024 16:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722985314; x=1723590114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdVJJdDCqZKalivgmtRZB9cyZ9uUV+RhJk3mCj9v4vU=;
        b=WbSgrCGksCNYdvQGk25pRDrHACJKcrgaX96Ezp7eHvhjOxR16vuUqvy7Cpfd5pBrWR
         e6YHQxcuuHfm1nuKanWITBJ5LwQORACyvCKv2MKbcDxKF0Vkd4H2yw+cFLnCHfrd0Y3v
         ERLFwjVHk4r/wp+4xalsgyKVKh4LACdXAUIraDOXpcuoy/EjZ59/eg7Gn28Gkj10fjeM
         B8FY0DcUAmaoieHuYs0754gO5Iw6iHSWEz5R29SH3ihMKLHGizw4v652zBaUXml27J39
         mJwFczYewGjC8+3RwSRwfmHuxdyjzt1YA9rCg6WSX+uKPieysQjXCI7WDgPSocSDn6o9
         5Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722985314; x=1723590114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdVJJdDCqZKalivgmtRZB9cyZ9uUV+RhJk3mCj9v4vU=;
        b=ASbmMDeYRcuhe0Fl/wzAqO11EewQgAEYFGPeTukV+353iY7C5KVjBZx+45P3IP29hl
         zGAY98Gp07bb3sqaIjb28HGIGw6EQqAb0eqXsBwLcGLYCAQgOLUqtvnqNtCitc3Mpih8
         vbK1rJOfKYuT6QB7kJa4vombDC7cTNaWJJoz1h7S3qNjWPyDaxtIHNayzcxX8BuoIGA/
         i22lpTE/tfTX8Xx/F7kPMVGGvmgJuHxLXuuXePE60HeaLXNlS4ZC/8+57MghqKATlkTA
         1nISMc40OXAwnFTsuxYAM2BvBFH9Dneo+2mzJ+S0AeixIRVS6nWU1tkVyQT0sBu0pdga
         RWqA==
X-Forwarded-Encrypted: i=1; AJvYcCW8aAVjcV5JU/QB/4RdhXIJG5Exa/IG0a+eGtapcQRoryJKOEhNrH5+/bhVhaYoalGvqXc1aXarycR1fNyfv/1S57GYxlaS2vws9JzjW/KXaOuTtoPjOBdxdWeMs+RDP1oivfu++kNK
X-Gm-Message-State: AOJu0Yyxlm74JpBpOyoD5y+HaaEaR5OmIFPEvjq/Bgg4kBbXXNRi3d0c
	nk39b+exn975vNGeIlvFxQIqzaHUr02zZIRac5QmahgFYNTTtSsA
X-Google-Smtp-Source: AGHT+IGKu6Uu5p66KKRw86KqLzb0kdhVrY7CZb8sOV5pguHraF37uyOcTxKsqC18hMgJMQrSsoYZmg==
X-Received: by 2002:a17:903:41cf:b0:1fc:5820:8940 with SMTP id d9443c01a7336-1ff57274b55mr215231055ad.20.1722985314508;
        Tue, 06 Aug 2024 16:01:54 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b3997sm92780755ad.294.2024.08.06.16.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 16:01:54 -0700 (PDT)
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
Subject: [PATCH v15 4/4] PCI/DOE: Allow enabling DOE without CXL
Date: Wed,  7 Aug 2024 09:01:18 +1000
Message-ID: <20240806230118.1332763-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806230118.1332763-1-alistair.francis@wdc.com>
References: <20240806230118.1332763-1-alistair.francis@wdc.com>
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
index aa4d1833f442..173dbcfc3b47 100644
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



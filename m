Return-Path: <linux-pci+bounces-23892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEABA636B8
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57098188FBAD
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE22AD02;
	Sun, 16 Mar 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA0CsycX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBD1A23B8;
	Sun, 16 Mar 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145197; cv=none; b=dHTkU/oWat8d7s6fM5ly3oxUyNJZ8QiQs6x4jt+uzqNnBN5OQ8aIcYdBzrH4OCom8+COOgq5r5brgi+HrWBMZ5ZjB20GVOgF1k4Q68wcXjypZgWc84D3Yx+tOggAVeiK6BK/ud0xKstY9jqnj1oT8AhnOY86QB6uzoqr4siCvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145197; c=relaxed/simple;
	bh=vBsxJ1biiJKtT4IBunR3eLVJtZ8OZKPt4xbxtLfBH/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1k80OC6fAZi2a1ZM8cq4yEbVkOMiNLQytGnwl0NR8FRCjwfzK7mOIFJIR0dAm2vwcjznJrJQcRIMHW7W4ogeZ1JOUshzRf7i2X2gyQllkmRQ6OMnly1Hl72JKcEB0RLu7joaSc/PuQifsb1tCp604Q5IaH6Nc2Hvw6KevNOG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA0CsycX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de12bso15371045ad.2;
        Sun, 16 Mar 2025 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742145195; x=1742749995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeuaJLj4d1tbxkJ8unWVbFFLio+tlIRdtkFlEPSaRSw=;
        b=IA0CsycXWGuk7gEGOy18sYmZIg7i8iihBZBDDnMnwRVmWF8ug7u3C+XxCmVcAnD7/f
         qc44+obcHhh6/e+NWdSmz7qOVOyoSCaQXekw5IiskUJSBhrXSGFKpzerSHpuu9Zgm0ZW
         Xw4Ik788JUjf2K1g5CS6+AtZTnZnpclXJU0igQ3Qmc8iYoBGz5Dpbo223tWNEMh25PO3
         mLNEllLEx+cZO8VhW4gzQyZRPistCbKNU8kIhT3DgNKNzRyZh6qd/cvhLO/OPLq6sALD
         MydTjyUac+STknHV+CIgKQKOJwjkq+H54J5TcIQEqMFtQPdox4LSVFrb19M8/jmX+SPy
         5aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742145195; x=1742749995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeuaJLj4d1tbxkJ8unWVbFFLio+tlIRdtkFlEPSaRSw=;
        b=rBgtC91CInLYckMrwEStCjG9McsweImg4+9bnI76Tvwwugl6zPTLrF2AZ0UbeDhOmF
         7XTSYKm6xaQeY/CPmlBNa/udj46C8N3lEyr2zH4D6JnHa0WWKKI8ikxUI0macB2/C5x6
         RdMuIcLOJQvL/EJT5WzENGWmyhJrzoVmDL/3ykYzCeE6kG2ihZmv/uwtFXgYv+bN7kFz
         3QpjjENUmDC46ytRkbRRbgV5s8g517yhn1FCaq/X5NNFGkMK47Vq36LMoVPRwKOd0m2l
         S9NCmMsNF36tIcIKhQ4moFDg2h3JZVqu4J5VdceCzzGiNjrJ7n8Wz5206/vjvRHzo0M/
         FcCg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCsjvyyOPTgpQVAbUKh4oyY1RkrINf+/a2yBA77xZcDxOsNcKFs4TEv6rUKxmBI9cbUh3DsK5YWCI@vger.kernel.org, AJvYcCUgMVIWYFTuzDYoB316Mv1iRtBqfBkTOrGhk4XcF26cMD3mJ6kqk1PbXnZTbmb96Tpx74LNs1OQF0IkoMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYhGTLF2+tQKo86p19SqMZ+D6oGvZrnGob03ncEsOWlLkObEU
	BvYyCSopAKhqyRAHvqM4MfwOdqYQ3PmW684snrI7alaxx8cku/Hd
X-Gm-Gg: ASbGncuLCaYC/EZcRovA5UkR8/EvfaTx2hu3AZSeA/w5lKOk5AtWE4viwmthrDCkokQ
	jbXZDHJMKHkm3DZ5V448GP1izIbM9aw/3QV4UYHUxoeunkWlTUfhRMcr+dS7COIV7MBUkYbY8ek
	pdUFjhMAVdCQz9QOYvjT7ZHL8NGCRNVc4zLwAvu5kqjBxE2NYIVwskjdu0gFwHKm9k4aDHL5vUW
	SzxxXpnEAZPoqgWrDnq4dHDWBocj1uQ9AkITbzUytq3CFKLtV+yFFzvysrCEnfXMQjFAR1e35qm
	l0p7oaW84zRaCfXVMVo4z2XUdCxCR5Pgthq+hF53pDWAhxfVGjuQCxSBU88=
X-Google-Smtp-Source: AGHT+IHtRKZOHJaTqaMZSKvrVXGVdYFJliq5UYT7x0gQkheb65z8FhDuAJJUZNqiQKIWLSE026TVQQ==
X-Received: by 2002:a17:903:1a26:b0:220:c86d:d7eb with SMTP id d9443c01a7336-225e0b19478mr126844875ad.36.1742145195217;
        Sun, 16 Mar 2025 10:13:15 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4063sm60189635ad.65.2025.03.16.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 10:13:14 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Mason Huo <mason.huo@starfivetech.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR PLDA PCIE IP),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 2/2] PCI: starfive: Simplify event doorbell bitmap initialization in pcie-starfive
Date: Sun, 16 Mar 2025 22:42:46 +0530
Message-ID: <20250316171250.5901-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316171250.5901-1-linux.amoon@gmail.com>
References: <20250316171250.5901-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The events_bitmap initialization in starfive_pcie_probe() previously
masked out the PLDA_AXI_DOORBELL and PLDA_PCIE_DOORBELL events.

These masking has been removed, allowing these events to be included
in the bitmap. With this change ensures that all interrupt events are
properly accounted for and may be necessary for handling doorbell
events in certain use cases.

PCIe Doorbell Events: These are typically used to notify a device about
an event or to trigger an action. For example, a host system can write
to a doorbell register on a PCIe device to signal that new data is
available or that an operation should start12.

AXI-PCIe Bridge: This bridge acts as a protocol converter between AXI
(Advanced eXtensible Interface) and PCIe (Peripheral Component Interconnect
Express) domains. It allows transactions to be converted and communicated
between these two different protocols3.

Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
Cc: Minda Chen <minda.chen@starfivetech.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: new patch
---
 drivers/pci/controller/plda/pcie-starfive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index e73c1b7bc8efc..d2c2a8e039e10 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -410,9 +410,7 @@ static int starfive_pcie_probe(struct platform_device *pdev)
 	plda->host_ops = &sf_host_ops;
 	plda->num_events = PLDA_MAX_EVENT_NUM;
 	/* mask doorbell event */
-	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
-			     & ~BIT(PLDA_AXI_DOORBELL)
-			     & ~BIT(PLDA_PCIE_DOORBELL);
+	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0);
 	plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
 	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
 				  &stf_pcie_event);
-- 
2.48.1



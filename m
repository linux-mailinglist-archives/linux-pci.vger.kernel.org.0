Return-Path: <linux-pci+bounces-15748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3359B8392
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 20:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E59F1F22107
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B413C3C2;
	Thu, 31 Oct 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf998KMt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ACD8C0B;
	Thu, 31 Oct 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403678; cv=none; b=MftF7duWJbx2rhM5A+c2OhP7lRQJgJZpuNsCux7o2r5h187YMZ9GdfzInPgC9hcR+s01xiDwvG8RwD30BL8uG8doTPCBwUdbwEdCVeodPb4EuwqvgtL55FBJHuhVVpPyLf3pT761nnEWpPUHdy3n5wejWgXNw6z3GAGn3Uc1KN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403678; c=relaxed/simple;
	bh=JsM585WluehrN5H1BS8Ef1eqRWVfkvFHTb1kx9Sz8AE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ZoDmIKjquye/p5zwhhOzJDmHJsKtqxfjil2LfKQ0ManCPvOcVhWNv05FlBGfH/jd9/e9gMAv2Pg7bUdadReDlA2iSZ/fxW9Ao4yeKuv3U82DHY9iKx/sduMTUwIvQMoufkqqCuP4RJuwIesXYhY8divHkiONWoPPAqi/QbEEUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf998KMt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99cc265e0aso198377566b.3;
        Thu, 31 Oct 2024 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730403674; x=1731008474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzNYu0/AjzJL7XVmohx4A6iJPqW08FCWPl6HVe70NGk=;
        b=Zf998KMtjYlD2sJgHyMj/0x4xrM2TCZgWdfRw5kTGXP2J6xURmgp/RpLKfkP4XNVpb
         eWTgGf7ZsQfAvdQy5LV+KY4v/AU/0YE1GtDZYAKmSeEnVvsp49M26D8zVJRhaAIUOpLt
         pA9LJaUMIQKnLG3W/oP3fFBnEvUjQ9S74NZl9rj1p6Loe1mibKPe5QCuFe1DZE7UVByX
         OJVe9Cc/vm7P2Ua2BTkv/gCVixOMKVOrOZY5qnXRaiHwD+gkjs2BrHLMYrl7qOQoLZd0
         BeEhmaaKKuCKCDbJiMS9rQR9z8bsgV/nAS+J/NhaB+rHOszl9n8smrk6k5JZUEzFNuZk
         5KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730403674; x=1731008474;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzNYu0/AjzJL7XVmohx4A6iJPqW08FCWPl6HVe70NGk=;
        b=ATY2NFiYkb94fGc2KgMowesPoOiWlHiim2rcdDshTBuGdkQ6fiB24sRszf9PoT8E3Q
         grfVSk53YY4Kmp7maHzjdbVQJXW7ejdPJXWbkubvEFYkw4CQ6GBI3yrMfu3b7/G6r7kK
         yByTjZwA2r5+AreawZevsaJFoFdhi6Mah3PoYWnAXRo27+bWAyYolGPuxqOj6z1WDaQg
         wTXes4WgtYiREDzbYA725eQSn0J3ap8pYOY29S3HJo4YdlTtKQ/cf7t46EZdl3gI/hnv
         57P2JEmdRna4ReVumQRhVhN7WQof8nj71IicMxOtwJYjbw6KRhIMXYmL6ADiQfBFGSYL
         rG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIMOam4S8FOAbskeBTShiD2ULodM3lJmLeuIdmYs1tfcCGm8zevFAZ/7gFRkbVkw/Z7il9Ffwqdio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yychf9bVaf/tP65R2BYtHXJoNCjIy/gT8qFy4DDocXOCuvrkIUg
	t8YHV2T4bRrxpHJOdRfKJPsbcobuH4IgCFx305GwUneE23nFthrp
X-Google-Smtp-Source: AGHT+IEkuXnrlxaCLjBLuYBguXJvces8GJgRGw1VoOzt+Jdq+aXyJiQCMpD5N87u8AmT0eczcgfS1A==
X-Received: by 2002:a17:907:948c:b0:a99:f8db:68b2 with SMTP id a640c23a62f3a-a9de5ecca55mr2152582566b.18.1730403674181;
        Thu, 31 Oct 2024 12:41:14 -0700 (PDT)
Received: from ?IPV6:2a02:3100:af9e:3f00:f876:f664:2bd5:aff4? (dynamic-2a02-3100-af9e-3f00-f876-f664-2bd5-aff4.310.pool.telefonica.de. [2a02:3100:af9e:3f00:f876:f664:2bd5:aff4])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e566845c1sm97028166b.210.2024.10.31.12.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 12:41:13 -0700 (PDT)
Message-ID: <11c60429-9435-4666-8e27-77160abef68e@gmail.com>
Date: Thu, 31 Oct 2024 20:41:12 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] ALSA: hda: intel: Switch to pci_alloc_irq_vectors API
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, Philipp Stanner <pstanner@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Switch from legacy pci_msi_enable()/pci_intx() API to the
pci_alloc_irq_vectors API.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 sound/pci/hda/hda_intel.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9fc5e6c5d..fc329b6a7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -773,6 +773,14 @@ static void azx_clear_irq_pending(struct azx *chip)
 static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 {
 	struct hdac_bus *bus = azx_bus(chip);
+	int ret;
+
+	if (!chip->msi || pci_alloc_irq_vectors(chip->pci, 1, 1, PCI_IRQ_MSI) < 0) {
+		ret = pci_alloc_irq_vectors(chip->pci, 1, 1, PCI_IRQ_INTX);
+		if (ret < 0)
+			return ret;
+		chip->msi = 0;
+	}
 
 	if (request_irq(chip->pci->irq, azx_interrupt,
 			chip->msi ? 0 : IRQF_SHARED,
@@ -786,7 +794,6 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 	}
 	bus->irq = chip->pci->irq;
 	chip->card->sync_irq = bus->irq;
-	pci_intx(chip->pci, !chip->msi);
 	return 0;
 }
 
@@ -1879,13 +1886,9 @@ static int azx_first_init(struct azx *chip)
 		chip->gts_present = true;
 #endif
 
-	if (chip->msi) {
-		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
-			dev_dbg(card->dev, "Disabling 64bit MSI\n");
-			pci->no_64bit_msi = true;
-		}
-		if (pci_enable_msi(pci) < 0)
-			chip->msi = 0;
+	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
+		dev_dbg(card->dev, "Disabling 64bit MSI\n");
+		pci->no_64bit_msi = true;
 	}
 
 	pci_set_master(pci);
@@ -2037,7 +2040,7 @@ static int disable_msi_reset_irq(struct azx *chip)
 	free_irq(bus->irq, chip);
 	bus->irq = -1;
 	chip->card->sync_irq = -1;
-	pci_disable_msi(chip->pci);
+	pci_free_irq_vectors(chip->pci);
 	chip->msi = 0;
 	err = azx_acquire_irq(chip, 1);
 	if (err < 0)
-- 
2.47.0



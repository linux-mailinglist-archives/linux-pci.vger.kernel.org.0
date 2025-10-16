Return-Path: <linux-pci+bounces-38308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E79BE21E5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110F818A46C6
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 08:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4102303A02;
	Thu, 16 Oct 2025 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtN+P3+w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A82303A03
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602754; cv=none; b=X4RdANv4A3nTndyusBhCRt/5gDcWDbbXeFluOd/hFkAD9cRZdFeFwhEoqIr1cexryYkWm0K+KndmF97myHmmE6qxfnEU2X2Il3z5HtY4w6P7f94gxA9caHzoP1jXJ7gpzahMy1qNAChXBzNjscUqAwNHVdyBlTOJ/qzJx0UxoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602754; c=relaxed/simple;
	bh=8cVKadBnNqQelkNfiWowVZi0bC+Sd9kYaA6vARK1Cdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WtWAm8U7Q/6Ppjs9Tri++Hs0tZnMA6WBCbO1qyiejnai2eUBMRtlQMdyxxtL6fxO5ceWLAPi1+yeATseYl+6KDBHqAzdb+txnU4CecJd+Q3ljQ9MxbEvI/gc8AokwIMqqnclSDRvrchSpuYdbfpvCk9JTrQe9Zqsr4qfBhluoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtN+P3+w; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso452073b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760602753; x=1761207553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNn+teilF/m2S5Y0Gs7r6IivDfLkDWPYH0vOCAjEYEI=;
        b=MtN+P3+wWuyIoD12cb9U673AUsuJ9teTgGHN7QaTYcDLP58Szno9BTZwSlE+Q3KGea
         WBs6M4S5eXgjWeMTJzmmfK7evKt1UdODGO6X9m8UEgu4YA1ej0YroElr9zUlsRUp4mL2
         jBOWLlFmZi5o/cXVBAaBmET2tKGWruk30pw1NohCNpkYUrteOOt4BWP4/EnKV3V4AFdn
         0GFq7RGIT9K9sJFF4URA9rev0l1gHOWekwSsmH+13119og19LTUukaOiFGt+hVR9sgly
         78b2ElWXjMTZ0GfiDkL4Ocgp5nW31BvJtYAytZQwnC78BnopDs1Ol6t0Qy0CUJTbrh6M
         FeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760602753; x=1761207553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNn+teilF/m2S5Y0Gs7r6IivDfLkDWPYH0vOCAjEYEI=;
        b=fmR9oN4a9eD+xNexw/6HhBysevPnfNFMI7qLuv9XFbjXyQCAn+x0gmkeSdjKK6/viW
         Px7+/kueFtLh1DxzJCzpDGymqfQuJ/F/5GDtPwIf6LP42Mgo+deE/gfwOt30zl91N1c8
         qtdk6uGER3QCgHO0Cnq4xtnQxyDuK7Ahq9TQzGRyCmsT0Pf4Q8EHwn6BGu1WhZtSirIA
         W+G7+p1zgPq2mk1gsEJvWS3GFAecEuiKMzpSXHn6Nrh/0K1ZIk8mIXP0NnzUXB3Ks7os
         dVB7wxW79HHF7RWYITppayG2YI0crOzf0j/5DsAbe8hnM9hilYN772jWZt43dmMf6rML
         THHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaql2RqhvEoLR6gQemoTVr0y0Z1P2oXVR5DbTSd3LmSVNO6ZZuVBwQhXhrSR8gdo1CC16d1bPVoGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3QIiGGyaOH0As1ZsLqoDJ7lAhGGEPqq5saatqL7y/rbRIrFl
	v3AqYQNRrOV1KdhF0+yQd8HfoxSDnjtTT3XTLg36oK0pvFPGkviYqr4=
X-Gm-Gg: ASbGncuoQvD6kzjFqmaCtMruL9v3fsNJobXUN7GeCqSxzaox61ySdTXUwjg9Yqf3tUg
	hJsfUgJVVz4xCbf28welF/F1FTjSHDnr1xVtf3npgn3jUng+fFEd8YfmKmPtmS1qxuBYjhiEkBR
	NvD50RQQmxk+iquD4AGBMfEno3gmm+peNMYiEDhUUwg9mZGbyWZWEfbkQ7yzZRpuo8lCt8X/NAX
	3Y6g1KyL2sY1bcnH+HE6wzCGXQGsyb4C3ZRImun95gC7LZzdnQbeB47GWtSBeXAAJLacBDLTXoS
	DZvH+kR6jbDDt7HR7MxAXFUjmANXP+6f+l8/h8OH67NEGpkoWvpx99YxRehWlle7CGkJWPFWFf6
	beaq7yvkG6ZaANiE391dMIwAjbSpamzWc/Nz0D7625uCJLDNxhHQEQDDR05OIdBdxDw/uK4f3+B
	Y6zHG90w==
X-Google-Smtp-Source: AGHT+IEsXtrMGo2lro2BmjiMPP+RR1rwWwgZU12zOACeOUGh+HQJMzgQiRxJdGRfDEBihQlF/0H8Sg==
X-Received: by 2002:a05:6a00:3d54:b0:781:be:277e with SMTP id d2e1a72fcca58-7938513618fmr35273590b3a.4.1760602752628;
        Thu, 16 Oct 2025 01:19:12 -0700 (PDT)
Received: from kotori-desktop ([139.227.17.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b065ac2sm21232797b3a.16.2025.10.16.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:19:11 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Tomita Moeko <tomitamoeko@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/pci: Check signature before assigning shadow ROM
Date: Thu, 16 Oct 2025 16:19:00 +0800
Message-ID: <20251016081900.7129-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent IGD platforms without VBIOS or UEFI CSM support do not contain
VGA ROM at 0xC0000. Check whether the VGA ROM region is a valid PCI
option ROM with 0xAA55 signature before assigning the shadow ROM to
the default PCI VGA controller.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
Changelog:
v2:
* Use memmap() instead of iomap() as the shadow ROM is copied to RAM by
  BIOS
* Only map the first 2 bytes for the signature check.
Link: https://lore.kernel.org/all/20250406090835.7721-1-tomitamoeko@gmail.com/

 arch/x86/pci/fixup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 25076a5acd96..10dce90e0e00 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -357,6 +357,18 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	struct pci_bus *bus;
 	u16 config;
 	struct resource *res;
+	void *rom;
+	u16 sig;
+
+	/* Does VBIOS region contain a valid PCI ROM? */
+	rom = memremap(0xC0000, sizeof(sig), MEMREMAP_WB);
+	if (!rom)
+		return;
+
+	memcpy(&sig, rom, sizeof(sig));
+	memunmap(rom);
+	if (sig != 0xAA55)
+		return;
 
 	/* Is VGA routed to us? */
 	bus = pdev->bus;
-- 
2.51.0



Return-Path: <linux-pci+bounces-42883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7249CB2D22
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 12:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044B530B0961
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC43009C1;
	Wed, 10 Dec 2025 11:25:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C22FB978
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365956; cv=none; b=Lr4MtbHQ5RGP4uwarKOEl2759YDaXieTCFjtoL2Jf8vCVqjnSu0aN9b7WscWRcf5mYc01/dsKN7im+CJiWHfyiq5JJXqx7Tde9Dfqdx7wbXFSUftGFVHqd5PTh1k66+vX9Dq5ctMQWxy2PAe/QrREq3hBcJ/YWczncnLDVvjVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365956; c=relaxed/simple;
	bh=NxaejPVy5zX3CAISSbHdAuh5rBKgsRi2//Wnojr6Zxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQulQakRmOUUJ7j9CaKeUGjOLPKrsTkFdc/1iN6mYerTuyr6R1qs47yGiKVKdCiMnUoo6UdYguH10p7fiRC3F/segCbzS09kQRKQqjs/JIn7/xQgn661cSDVgWgzyZ9UYFXgGiSPWhwA3IvH4fd9xClRuhpd2VDnESKv3UJ0oTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7636c96b9aso972298066b.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 03:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365953; x=1765970753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhKA/M8ILyto7eBkY1icHzY0SmIbHoLL7uqqcVLehkQ=;
        b=pLU/3oN4AN/cQC6ZO0X7wZvsUPprJcPtWT7PAOeI+vNPqVlvLAOmgnhQ2fWPjfkKI2
         QdDqzmlXRWOyP/6ntXqVIrVE/Faa/bKqYv81ctHpVuqeVgFbcC3fGeOcJZFFN6UspG+4
         Hpdv5YuBHD1bZ5gfXofgP5tj01l8VSjsSkPUJR62w7deQV69iHlZ9NRrXbJua4WNgo8n
         vu0QnKimsjn4JAyrkdKmcyYEp7rnMWQD2zjfgva1PiFpRCCaSgah+PoOo0o/nfdVGid8
         IVbjt+McYbJieEGoCBq9eN+KQp14Fuvluw35/KA/+QCXL/gjrDMbn3udTEXJvQVPJb0e
         9WHA==
X-Gm-Message-State: AOJu0YySKK8Val4Nrb2dCaAu1bg/hSbgk2ndqB655FGDRq/V+zbp+NWL
	VtWA9+QfwSf4RyIqTaZczXRPaytvHCQrKWrugkVOtYbT/e8inyNfR2DSmBpWxh10MkA=
X-Gm-Gg: ASbGnctAWBaY21beaRCjJn6K06fuSEfufgiTfZhFCPcJxpQl/ROxIcInhrQ9NgG6jll
	68A6xGyG4pH5LyDFisNwoWlkV5nMsxS8dpfFa/CaQTQCF46kdfKSjMnJf0DwmLDp4ildSwJ7L5C
	EeHSmcJ8pxXQjKyH8KHRHhggU6mPm81AyFXK28mo88Bn7Q87Lmzj7ocqR+qsFBJG/AquL1woJIo
	zey0C6FHrD2KWr0GR+HnveKF+6dCi8cbA5rNA4Gi1C3D3fX6kDqh4C8YP5lFj1+QLkBJxVOzJM+
	2VFfkemEmdVzgzQIVzeNgEUy60OiKhpmvgkMZyPuO4UFZ4Vq2aSKi67ye/GZ+6tQ1VGjFetQ8jl
	dJo11T/9vJQVoxBFpNhjjCvxywzzWToG4VY1eO1uPK/D+O8nRM69kbqbKVg56yU/LQZ2X7i1nxF
	vY1Uowy0+n8MycEJ7x8LgTRrV8XaW80Ry8XnnKgDuFrl8ddsnHWKg=
X-Google-Smtp-Source: AGHT+IENi1ktbPcvqm8o67r+a0ZkfTe1GJgMQHe0nCoe1GbJgKTbUpT8P6okldqfK7WtN9cYy2O6sQ==
X-Received: by 2002:a17:907:60cf:b0:b72:91bc:9b35 with SMTP id a640c23a62f3a-b7ce83c40b1mr202143966b.39.1765365953201;
        Wed, 10 Dec 2025 03:25:53 -0800 (PST)
Received: from vps.markoturk.info (cpe-109-60-37-145.st4.cable.xnet.hr. [109.60.37.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49d841bsm1657032766b.56.2025.12.10.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:25:52 -0800 (PST)
Date: Wed, 10 Dec 2025 12:25:51 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	miguel.ojeda.sandonis@gmail.com, dirk.behme@de.bosch.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, mt@markoturk.info
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Marko Turk <mt@markoturk.info>
Subject: [PATCH 2/2] samples: rust: fix endianness issue in rust_driver_pci
Message-ID: <20251210112503.62925-2-mt@markoturk.info>
References: <20251210112503.62925-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210112503.62925-1-mt@markoturk.info>
X-Mailer: git-send-email 2.51.0

MMIO backend of PCI Bar always assumes little-endian devices and
will convert to CPU endianness automatically. Remove the u32::from_le
conversion which would cause a bug on big-endian machines.

Signed-off-by: Marko Turk <mt@markoturk.info>
Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")
---
 samples/rust/rust_driver_pci.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 5823787bea8e..fa677991a5c4 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -48,7 +48,7 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
         // Select the test.
         bar.write8(index.0, Regs::TEST);
 
-        let offset = u32::from_le(bar.read32(Regs::OFFSET)) as usize;
+        let offset = bar.read32(Regs::OFFSET) as usize;
         let data = bar.read8(Regs::DATA);
 
         // Write `data` to `offset` to increase `count` by one.
-- 
2.51.0



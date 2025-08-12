Return-Path: <linux-pci+bounces-33849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD5B2222A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 10:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FF9723B9F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10182E719A;
	Tue, 12 Aug 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cYazT4E0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F22E62B5
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988534; cv=none; b=S1H+y37yfHs8sveFauHQ0P3cbA49fZW0lLwXyW2DAcxzK+9K2y9t/sL/NJ6FJvr2PQUjejEKzRVjxNElOyI7TcNaQ0dN0PxiHhCOHwH2CI8Kv9XkyE2Y3uaiQS3KolBsrQQieKKSuJbILF5reT9IUlRqQNU2oXULYHMwmo17mRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988534; c=relaxed/simple;
	bh=aFBF5dW26m6Z+lOf9QzPL7466+Foa5N95p4seNu5zUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJvL4CUmE9/GQ16SyhyVCjYDK+5KcjLpd7ATHfzUQwdCH7d+JrpHtMzTpDk9uu+Zg+AS/3UTajx8+2Z+1K78/nmrTguuXZyMN4btJJs5x77n/4DwCLAytABlJBFk2kz+/GaweRo9H4VAKMLq2eNg2ucdn2cuuOA27cq4C7drEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cYazT4E0; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so8154992a12.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754988530; x=1755593330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0CFpq1HCuyeYFLbDR8k9bWBZ4oNvj1i296rXTBH/70=;
        b=cYazT4E0MMtqGBX9s2zmIqO4LOH0HheT/sseXh61GRUfUAkg2Lv3E++8t3vqWpIxfb
         Ku7FPCSh/4S7MsTXFqiVvlh2c9cNy39fDHjLD/6AX4MrvPU6KV7WQcsNl7dbgZwPalvN
         oPJ25Je98xpZ35PsTYvxugW0OQ7DyObwXgtU9Aapuu61/rfv1Hf1aG6bGEMjoE/sUnP3
         Z6/MqCh7UFQWVoZQkSpzLWCZFQAMYoFa9qYzU8CpKBGf2n22/wrThWduWnD427yDZLMF
         JW5kkgKkU2txC8kwvFFlRDgdmv5vYhFA8MrHlUg8Kd9vHb4qfX2Oo8iGrMzYmOXvqMg2
         dNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988530; x=1755593330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0CFpq1HCuyeYFLbDR8k9bWBZ4oNvj1i296rXTBH/70=;
        b=rqo9ShLncOA8QmQl3AThTjjWqAefNC99yJe9WlBjJipO/q4Yk+VbDhTF9ND9FNQBYN
         1R8bweGKzlZ9kNUqtVb2QX05GRG9ypyGZEdolnI3HTV5cVoqmsnxDvbPPYpW3x6JP2mc
         otRjoKrb3F/9ulRwA66GEqoaJ4saabsQo1Oc+lgZLLzUlU11DTdAqt6pifDSuKBx0jwy
         6YfZUcxHbFMhqo/IeXVf1ByT5gwrSppgcU6UdC9bN7YjeA1sRePFGAORRXtdd3yOEOdg
         jsoTekkIt36KOJAiPkKTia1UMuDkljKDnOlUCVfOqV7qPY6cPLQS8U8CCGFmu4Mn3yM3
         EboQ==
X-Forwarded-Encrypted: i=1; AJvYcCVexQ/AV70N5BNyUnoAHb4C7FDeXkRocEv+YRd6ue+HzUyjm3DyLuE+Jrb5OCDJPOhA9TeEcWK/9MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJUgJ8/wdNfce1Yk+aTMx4SgFTlCF+vBAje660DYCzd6b4Gn1
	pp1siWHnqwEKememlpYOphGHYMTYW/JfTaR3t2eeTo0GNGyIKkdv0kFroo/AHhQwQm0=
X-Gm-Gg: ASbGncsp8NEnoJ/Pbt78cZaKHoxk/xi2O1QxuOZ8mgJkZphHU2IBYK8HpV8O6Or1H27
	JKMAbhsqqBYL0oJwzWupH4YNi7lSFiQVNVK9CHtB77gm+YT4aprTuwdmtuJTnk9W0lISiMBzIAT
	nXg0bKtRYvyoCtYSQJIa/SZlw+JX2nYFo/7JpIjp7tPYkQRSfGx02pmXmoLoL2DJcRBBHNcUrVk
	2mn5bGSeS8l5ZQe12GutKIqq30zhnidWLYa3FmSd4C9fui2pLOhD20AEc5v9/9hNQ5vkdtrfV0b
	7Q1d5OdvgBAmx9rLfHjceYAh71J+QOJRxMpdTy/VkgX41+gqjy0QxtqPCEzCVdAGnuidsdAvYRM
	MvqaWvbIO3wMk5kni78q1PjSkw3IlPx2a6ROlQUiZobR2O95p4Bo7JGgMmD1xU7v12g==
X-Google-Smtp-Source: AGHT+IHtFs8w0fVJyzS1M1cginNB7x2BJdFDZRxDj5MXgzQYeyqcq0scZCRhd7hs7865IgJzSU8QUg==
X-Received: by 2002:a05:6402:3111:b0:614:fead:3d56 with SMTP id 4fb4d7f45d1cf-617e2e8fc4amr8958140a12.32.1754988530010;
        Tue, 12 Aug 2025 01:48:50 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-617df37d061sm7754871a12.40.2025.08.12.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:48:49 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Jim Quinlan <jim2101024@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dt-bindings: pci: brcmstb: Add rp1-nexus node to fix DTC warning
Date: Tue, 12 Aug 2025 10:50:37 +0200
Message-ID: <20250812085037.13517-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devicetree compiler is complaining as follows:

arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warning (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or ranges property, but no unit name
/home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('rp1_nexus' was unexpected)

Add the optional node that fix this to the DT binding.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.baJDYBT4-lkp@intel.com/
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 812ef5957cfc..7d8ba920b652 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -126,6 +126,15 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2712-pcie
+    then:
+      properties:
+        rp1_nexus:
+          $ref: /schemas/misc/pci1de4,1.yaml
   - if:
       properties:
         compatible:
-- 
2.35.3



Return-Path: <linux-pci+bounces-1317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D181D620
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 19:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0C1F21204
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D9412E5E;
	Sat, 23 Dec 2023 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXmiyKJb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F928FC1D;
	Sat, 23 Dec 2023 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9af1f12e8so90697b3a.1;
        Sat, 23 Dec 2023 10:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703357116; x=1703961916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SSYy1HqaQVyEn5ka5c1mnu4H1PoZtaN3vm6W8mKM4g=;
        b=ZXmiyKJbRylw2NG2itapmPQf8wRKpkVufZWwcXfr6RJFwIKBa94kQcSFuz76nVgl45
         r5ygyKGmOL5y5DqzN24sN9NJALe2TP6W2nyOBDBNLMG2i3EtwDEEPA+Tuj8QO11+apBa
         /YA72RMOT7G2THRZRlVRE+UfEXAK7bgqYWaYaKoUZetKmh9g69reKihVGjqKzX5NJKT8
         ILhYpo4vx70utlCrDdKLz6KEp7Etq7mpAE+uRzev73bQWxyXjSC/yugBsIWbySjsN3kw
         RfEq08nv4RodxQ+bKBI2z57k2hZXW21zAOiyXeMqWL6dGgMfZjaPrjriTDezTlphsX6u
         3ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703357116; x=1703961916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SSYy1HqaQVyEn5ka5c1mnu4H1PoZtaN3vm6W8mKM4g=;
        b=kPgknXXQiWNRym9n05j5vLWLN5Sp5+z7Jt8dCviCuChkxjl4kEvNl+qHaUDeG3bMCs
         ki250DSLelGk77swyHUO8AOxTK5EbETnnNYaUOvlV3geuWJv2ncHXfyeaWF0KcqEbyHj
         1JuELlLfEFzBRKB1z4y5EGGt/BFeI7G6rc4w7sxrdQ7VpkP/L1Xw3wYECzy1041RjsYy
         O2+3o5CfHiKMjOztOfbBetG3iBX696XM2r3O0MiiiPmASvRNQ7x8vIE9Q15O2qURZD97
         wizWnkCKSpFitXyXVGmf7NnMQZ7defRnaP/ZxP4GUEyaEnJ2a92Sd4jguPDLJUbhsxg9
         GGfQ==
X-Gm-Message-State: AOJu0YwHTRm+C3w7YuOKY3aaHkF8hXlUjpWHfnX6irZR5dtOYKNA+ETD
	HBRED+MdN8Y0uZqK/c0IFu2aR/pIJ0GAFg==
X-Google-Smtp-Source: AGHT+IEC3bjlaGUgsa1xELzYnFrHXQ/5w8hD7NDYLZ75MXkqw2mq8iwq/8wA2vPl+4O3yTpUwV6cjA==
X-Received: by 2002:a05:6a00:2196:b0:6d0:8895:2c8 with SMTP id h22-20020a056a00219600b006d0889502c8mr1603684pfi.36.1703357115458;
        Sat, 23 Dec 2023 10:45:15 -0800 (PST)
Received: from attreyee-HP-Pavilion-Laptop-14-ec0xxx.. ([27.5.150.118])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b006ce7e65159bsm5406672pfa.28.2023.12.23.10.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 10:45:15 -0800 (PST)
From: attreyee-muk <tintinm2017@gmail.com>
To: bhelgaas@google.com,
	corbet@lwn.net
Cc: attreyee-muk <tintinm2017@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/PCI: fix spelling mistake in boot-interrupts
Date: Sun, 24 Dec 2023 00:14:13 +0530
Message-Id: <20231223184412.25598-1-tintinm2017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct to “re-enabled” from “reenabled”.

Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
---
 Documentation/PCI/boot-interrupts.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/boot-interrupts.rst b/Documentation/PCI/boot-interrupts.rst
index 2ec70121bfca..931077bb0953 100644
--- a/Documentation/PCI/boot-interrupts.rst
+++ b/Documentation/PCI/boot-interrupts.rst
@@ -61,7 +61,7 @@ Conditions
 ==========
 
 The use of threaded interrupts is the most likely condition to trigger
-this problem today. Threaded interrupts may not be reenabled after the IRQ
+this problem today. Threaded interrupts may not be re-enabled after the IRQ
 handler wakes. These "one shot" conditions mean that the threaded interrupt
 needs to keep the interrupt line masked until the threaded handler has run.
 Especially when dealing with high data rate interrupts, the thread needs to
-- 
2.34.1



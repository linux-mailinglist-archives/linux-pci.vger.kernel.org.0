Return-Path: <linux-pci+bounces-1318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4316E81D624
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 19:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BD2282A9E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9612E47;
	Sat, 23 Dec 2023 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjSMg9kk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9A12E5E;
	Sat, 23 Dec 2023 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dbbd2bc34aso1675403a34.1;
        Sat, 23 Dec 2023 10:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703357312; x=1703962112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQfqOgut4GoBKIPaZpxyJj1WflP+s8iSQCalnfhq6Y8=;
        b=OjSMg9kkZwkrnogRgTywj6FOwGmMNoT037v/+R07agnkit318KFC/A7c8K1wMjn3Uu
         V90MoIGjmXyqOuBRMfLCUXZJPw7tGGW/ITPngYqG0ImZz1l1N0uXduUPm6heoTybNWos
         WdBMmPZiwYu9hFRdUDXJOqxnkQ4+Sgr4jES482c8aSBWRgIwpuVdeXgWEuYmDUV9bsXz
         KKV3MYsFZi92SK/X4WB1Cdr3AaX1yulmji9/e3qjYB1TNUwXv2Af4ULI05GLPbpRPJX7
         oWBM6VEBJgpu1DvLLo8g6ADe3/Di4lHbxLY2HS93g2q+QZ6RK9qqFSFLbWjehiAaYSss
         u5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703357312; x=1703962112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQfqOgut4GoBKIPaZpxyJj1WflP+s8iSQCalnfhq6Y8=;
        b=fo2zJYHqVJBSvkA2s7raGOe6S5sQ/w6QzlYUnuD/xXnZreZmhiOqIiqdCKsIqXovxE
         AWc0gZbVjZzq403mjdSjqk9ZHbX+Vxyb/xZfWuQgfy9hKnkJBlKC4HewPW3eKJ1qoAWw
         dZ9XmPeQhArNSSk94uSzTxrOnaJ0zc1WGKP5ZLt3FhuB7+q2pFlXp59DYQbO3GcM9Sbb
         fD/x1B7MLK87H0cezOtvn8aGPKODfftX3WqrHT/W55qdijnQAxlQ+/lgt//aJTruFL0R
         pFOrPcq1ksQSJfsx1JL+NhmKZ2Dc92x6t5MIHIorHoonSPjT1eNmpal7L5oP8MUQ1mcR
         Dlvg==
X-Gm-Message-State: AOJu0YyjHQNAF+QPuQ/HzQ+Ah7J2dlHzkL7IZXADn4FdPLKOxkDibr9m
	vk7xDDIWoQgfeoc/RHVDRrs=
X-Google-Smtp-Source: AGHT+IEMKD21RWWP8LAu28WSJYFjJJYNjlwLWCZ6CEB9clc5Jlt3GsjbKIxE+O9axIsYmAQxzb94QQ==
X-Received: by 2002:a9d:6755:0:b0:6d9:d2ef:f923 with SMTP id w21-20020a9d6755000000b006d9d2eff923mr3209884otm.74.1703357312235;
        Sat, 23 Dec 2023 10:48:32 -0800 (PST)
Received: from attreyee-HP-Pavilion-Laptop-14-ec0xxx.. ([27.5.150.118])
        by smtp.gmail.com with ESMTPSA id j26-20020aa78d1a000000b006d974fe1b0esm4935542pfe.7.2023.12.23.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 10:48:31 -0800 (PST)
From: attreyee-muk <tintinm2017@gmail.com>
To: bhelgaas@google.com,
	corbet@lwn.net
Cc: attreyee-muk <tintinm2017@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/PCI: fix spelling mistake in msi-howto
Date: Sun, 24 Dec 2023 00:17:20 +0530
Message-Id: <20231223184720.25645-1-tintinm2017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "buses" from "busses" in msi-howto.rst

Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
---
 Documentation/PCI/msi-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index c9400f02333b..783d30b7bb42 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -236,7 +236,7 @@ including a full 'lspci -v' so we can add the quirks to the kernel.
 Disabling MSIs below a bridge
 -----------------------------
 
-Some PCI bridges are not able to route MSIs between busses properly.
+Some PCI bridges are not able to route MSIs between buses properly.
 In this case, MSIs must be disabled on all devices behind the bridge.
 
 Some bridges allow you to enable MSIs by changing some bits in their
-- 
2.34.1



Return-Path: <linux-pci+bounces-6924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA68B84DB
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE121F23A02
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F943FB8B;
	Wed,  1 May 2024 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUIQv5XM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5403D57A;
	Wed,  1 May 2024 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537739; cv=none; b=ij1gC0VQRnK0f0aFCmSkZhhP5xCoZsTq0sj2VJ4wQtsk1G9atzfF5S0tWX6OXk52k3Fi9e9rb6+zxkCGBjEHhheZt5RhWCM4wXdEe0iogixfPMoEGMU1Q8JHApyIFs1OjXc8YBefp61/rLVr6stJjOA8AwfxLTNvrMMNdSqoAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537739; c=relaxed/simple;
	bh=/LW5UP24d3M9gnDJHKsZY3AjzrEnrgPIA21IZxGWV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bd/axRhicAZU2P5vsBHX280A9Of5BccZe44Gq94eDU+nfxcsTmFlxG9MA/KlighU8OZtGjx817YNw5gdrYdJCSrKhDtsorIh+VaY/PsvWRItuwGuzVMv+yiCvuUtVHN7UXHDd7ZfsitDrOeDxbz4vgWpVdZ6XKwiH+yxczIjA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUIQv5XM; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23d41245bd9so488562fac.2;
        Tue, 30 Apr 2024 21:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537737; x=1715142537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=iUIQv5XM/Ne3+7HXKkVMhTN2Q086GFXKPEdOOGjlwUpMfbiydOJ4ScHbe0y68l3UtM
         7wjMROCP1Z5qc6vPFQ6VUD+nYUPebO55TdkFsEdMXVjScWEu93JugMmXHeCiuPC8nV4W
         H3AvSEE/lwbnoPngdrOKU/bXD+rPl0U2ZBTIPC8j5YC/H225FnO7DcZ8MTYZfWqbd/aD
         HI5rKdMNDTu1//F/BaJ9R2m9yJA5MSwSYVnVE0NOLh2JbR1UTktXFIvGjhjSfUNcz/uC
         msy5GQC1HA9vH9AGk16rrx0rW6+yCLwALMCB9sbS586SOlYWjFG7d9duO6zc7vJr4MuQ
         p9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537737; x=1715142537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQII4bd5vU3iEBUOJRNxIf3Y2tkmIxs3qzEGZCMfEv8=;
        b=qxIV2WE9YA+MBD15cutSLo5blZs5hcprAwZyKAZho7EcyNQOXchyXu8W3Y51osCxhm
         43AMdLyklq2a3wv8liwjiK0H+MCQQFUV5mMgsNZaa8AkQgwcVR6xkN7zhJ6HZOa5nkEb
         kUrwuuTtSShTfMwubbG4ogwK6sXuxatw4AcrBcM559fCfZPTcqavcwjnys+gV/a2XMya
         D8KgjuzsucLv4gZsI4yR2eFjtmRa16P+RZ84q3sg/pjHO5a4fIOLOjTFRCk2VUUXvY/Q
         10/pUNqW3otagGDBMCquLZpb4OyxuRF5En5dJEYXhKS1gSX8tpEkfs34d1BicNjeiynJ
         T58g==
X-Forwarded-Encrypted: i=1; AJvYcCWxHvXgoxPhHmHh90UahfhvqSBiXc7cHpslMow4JSaK6jOUOnGIiwu/E/u5FJ14hP4YEWaZ4op8iLd6zWSkcNZZEnGUjTEPxifViOwoiJ0LDFJSvL/Q6u5ZHT4PSchQAv69KjXudKcuhkyZenBYpJ09gKlkLy6iLrcVOtgBnLZ37vR8y6RY3IRp3Fw64H8W7MZPBCI9qyQhsovTKTsqGPikPFbPiNLjZZdgr57DM99bk5YjIg3pb2nVLgbMirA=
X-Gm-Message-State: AOJu0YwiktnEQ1d6nf/l8VVUCHImazpQyXKfuT2H5xp1xkVJ2OyDvoXG
	5CMnsP1Jhr4vV11Jql6Rq7h1TGzgKVNI/Jl/LyZGBr9VcJZMOigY
X-Google-Smtp-Source: AGHT+IF0dxKW/JwgcvWoMmwvXBPtDjQ9wZTIqZg0eca+QzYjkqbSejIEdI6TQZ632LMaz009pBLE0g==
X-Received: by 2002:a05:6870:ec90:b0:22e:8fe3:a9f3 with SMTP id eo16-20020a056870ec9000b0022e8fe3a9f3mr1560608oab.17.1714537737603;
        Tue, 30 Apr 2024 21:28:57 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id do26-20020a0568300e1a00b006ed6dc9fd54sm2719058otb.25.2024.04.30.21.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:28:57 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 RESEND 1/8] dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
Date: Tue, 30 Apr 2024 23:28:40 -0500
Message-Id: <20240501042847.1545145-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the missing PCIe PIPE clocks.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 08fd3a37acaa..52123c5a09fa 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -216,4 +216,8 @@
 #define GCC_CRYPTO_AHB_CLK				207
 #define GCC_USB0_PIPE_CLK				208
 #define GCC_USB0_SLEEP_CLK				209
+#define GCC_PCIE0_PIPE_CLK				210
+#define GCC_PCIE1_PIPE_CLK				211
+#define GCC_PCIE2_PIPE_CLK				212
+#define GCC_PCIE3_PIPE_CLK				213
 #endif
-- 
2.40.1



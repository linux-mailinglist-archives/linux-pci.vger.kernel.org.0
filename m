Return-Path: <linux-pci+bounces-8441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C10C900150
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 12:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D216283FBA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502B615748C;
	Fri,  7 Jun 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NoDbbT+p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64041581F2
	for <linux-pci@vger.kernel.org>; Fri,  7 Jun 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757896; cv=none; b=iyA9Vq5ssXs1BpAFMVHH8alNxPZytyxEjSD/te5yzAVN01tAiYuceDCxQVkSA3WLX8SfonAMulR4PSYtoAP3CydFNUd2bQAoLHkVitUCjG7OeMxiNDw1EQO+tp4yfcvUiPg0xxUzWZYupvnA7lgOxTN3899HzHr/NvlA7+gntyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757896; c=relaxed/simple;
	bh=ycQv3nbAr7OcSxmuMzMW9XRFydQt5R7zli+aLK774Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYNmtHOQajG1Bb6Nt8SwAIz9gHP3U+IsRjA0Rs5V3PSYU0QecrPZDB8lsHnxcpwym1ojgfPeEiM1Uo3tjkqJ19/rVP2Yvy9iyVhTVKZ1ugMu+dc67dZKjbSje/vEwrbJEIbaCBkKdH+0XZ5wBiS50ZRAu2V/kInFmcG8uRzWaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NoDbbT+p; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42163fa630aso9515535e9.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Jun 2024 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757893; x=1718362693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGKUPLlaqu34zNkRMuwZus3nvKRpkYIBrcHRGCQDW/8=;
        b=NoDbbT+pdNil8HYGtuzjvYWi5sFvib3a4zU7ByWToY5/9QZXFuMZ1kYiJspovsmshc
         7yC11cj4dTmQXDZQ3TIG2TAFYp22T094IP3gsFlR3ylORJDJAal5su/EN29fQLoul+Hf
         ysx2UZmbA6ihfWhZOx4W9JS6kh5HTU0Z3OoM1P70uJ6ye2BZGhJcugxmAGKSXBNv/tTy
         m2Ek5gf8Wqt8hnXZdDgOhkCmFlB7hjQpEQwCTB4fUdnUtylrGiiTOwpROqo7807ZFNS+
         QFKp+OJcGmQcb7ogpz60KnTMkfRTtMDeXhFa1ns2HZALzRBzYqPgZ3M1+KfhZKdPgq+R
         QeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757893; x=1718362693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGKUPLlaqu34zNkRMuwZus3nvKRpkYIBrcHRGCQDW/8=;
        b=Er1yufxD5LwgSR8afhmPNdClBq6zgu2+L0PyetfQKhzXBphyPKiu7u0YU+3w+SGckb
         FkiHXDs0lSgPbMAlBTHQ0H4ijSES5Xj5YHpuuq3vh/TVOrxI5Od9PtGd86fFpz9cdm1r
         kITHjtfNQGcFDtsW2RPFJY7+yknZzyCz1Ka8wQVg6YWYJ6dlxqiJm3Hvcz4Z4kcCw/9I
         0y0k5pBPzlIWUuUnfuwVYx3XDDbsxMgLvkkpQb2+XPLQyhrlO7v6ihj5FJBIvkGFMQNX
         Uh2NFJGX309lsiyEt3V4hjcfMz8DZNMO0O4GeowSBShDAogaGO9Sz6AnDFHBVedOAsRa
         vydA==
X-Forwarded-Encrypted: i=1; AJvYcCUtfB6GvfxQzmTPGka/aOmoJCcspmfZpAyfcVH5iZJDA3IO0bksam+/5mNs8ziAVvYZ/GlV45l2ZYttGJ/oyDXPAxWevWVp7Ghe
X-Gm-Message-State: AOJu0YyMOfm5l6YCXxhKI2nJIoysfBRuVMp6O12lZvaunnrmCR0+rBpT
	Mta6cbiJyXR37SNVzNZAkxHTiGIWTPD1vh2kTUEKaNIWUDvbvcWvjYQlJCsVhSQ=
X-Google-Smtp-Source: AGHT+IEq05dxkoUz5lyUwdXJILrFcWqbbvwqZompyFbB5WoQMQiG2JPbouhAI/2QDSQs2s1tVNVLaA==
X-Received: by 2002:a5d:4bd0:0:b0:35e:7dc9:49d5 with SMTP id ffacd0b85a97d-35efedf2a1emr1381990f8f.43.1717757892978;
        Fri, 07 Jun 2024 03:58:12 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fd1c5fsm3739485f8f.113.2024.06.07.03.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:58:12 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 0/3] Enable PCIe ATS for devicetree boot
Date: Fri,  7 Jun 2024 11:54:13 +0100
Message-ID: <20240607105415.2501934-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before enabling Address Translation Support (ATS) in endpoints, the OS
needs to confirm that the Root Complex supports it. Obtain this
information from the firmware description since there is no architected
method. ACPI provides a bit via IORT tables, so add the devicetree
equivalent.

Since v1 [1] I added the review and ack tags, thanks all. This should be
ready to go via the IOMMU tree.

[1] https://lore.kernel.org/all/20240429113938.192706-2-jean-philippe@linaro.org/

Jean-Philippe Brucker (3):
  dt-bindings: PCI: generic: Add ats-supported property
  iommu/of: Support ats-supported device-tree property
  arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP

 .../devicetree/bindings/pci/host-generic-pci.yaml        | 6 ++++++
 drivers/iommu/of_iommu.c                                 | 9 +++++++++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts                | 1 +
 3 files changed, 16 insertions(+)

-- 
2.45.2



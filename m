Return-Path: <linux-pci+bounces-9893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D7929833
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 15:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F961C20A58
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2221345;
	Sun,  7 Jul 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjLMVxwc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D131E532;
	Sun,  7 Jul 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720360455; cv=none; b=aRl500JnAvgzaFaEP5fW1xRRNN+zQ0XF0e56oQsbbc+z+HqebaYDyB5XTxjod12yLFdvx+Y5sJIh1LDiIRmc+67IjDZNrHTqxLz+sotWDmJ16t34XmubUqg/LsfUr3M4hya+aBrdXiB1qjI2D0NptLHZUl0r/YRy1M6AEmABPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720360455; c=relaxed/simple;
	bh=1dKlQO4wGI6Bmh4Kk42Q8QE+Ynhz/UihyldzXeyqZVo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gma7SZpjusxmk7SMES5XZmLeCo3v1XkFa9E8HXWkVIfqsBkKx3J8VKfDtGr8m0oYEO6s1xTm9ZenfqGPn7AaQrSTelICdV8OjyXIzQwvYzTcyG1rRhjbE5C/LfruMhuPstdD0lBVcwVQ+1hn/f9YIesp2jRvkarEQzoPQVgnCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjLMVxwc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42666fd6261so2341595e9.3;
        Sun, 07 Jul 2024 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720360452; x=1720965252; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QamPIeb2ulP2v+viFyxNqj6Z6PsQ7JsthoBDWMeRgE=;
        b=cjLMVxwcs8ZAeJmwFuTUC1OG1/cNKfW2ykh/cpzbG9Yy4aH+A96y82pneELmS7Y7Zl
         q9d7XYACWMIkDBjGRWUa3GVxklOBbSGkuXv+bNTY+p4bAxDHmtGJk0AObjTj+zv2rGPm
         M63/bY8fliZxEP3pyYfLW9dAZ6z4IzzU53B0oOCzf7H1deYAxFg4OiENgEN6m+i3rgBW
         cG1vilzptBMDeo/2bMH4mUn0rXhg9AqY7V91tuY820x/RXjzsYeb1Jn1brUcaw+QQTeZ
         rWNoz8nUlJ5QHoB5PlFHrQvI8VnS2Jo+Cjt59jfB5ki2Yrrnt7MTPs/pNI+oCRsFvy3N
         0uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720360452; x=1720965252;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QamPIeb2ulP2v+viFyxNqj6Z6PsQ7JsthoBDWMeRgE=;
        b=T6G2LmrH89cye9Mcz07XFOQTDZ31PhkV6MuCgu1UXqv0zVSPBpECRcds+QWHVdp6bo
         S1nXgKmayGpJkcXi3pIPH4T4BeX1Vrbf5LZiW5E1108yOSc1ikaKe0h29KPwKXgk2+bC
         NJTt2DgKZMRFhaqp2QpiIgHKVDtey6HXIJ4pp9VdCf8ogUdtbwNTVLp9xGFReQaTauO+
         IBVoY1bzrl8qMuMyJlvLi5pGeRLFMdDIQd99/+0Z9lqkGqSxp+Qb+nY8BN9tV9u/1ilo
         E/IKWLEeMLFUVmQzzbgVYyUgfvLUvk4Vdw1dtTLhPoqVhZfsFMj/YhImJNrusi/fj85g
         iY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSdmjokWEOdtcaP+xpwVMGkoRIzT++TivHL18CGax95TeTisz5ZZFBulp/PAgjZMyZRajN2kyQXT0GO77FpVQU1YMJgY3PsTo+QyDF
X-Gm-Message-State: AOJu0Yxsp1/IvT4+kxCYZcglOlU04gQZAOA8zon4HF7+ynxy8diYpim9
	pPSyvbSx0YEloBkgaSbbUcRqMQGeMv2ZNYLFkOFhdQB9Dob97Cup
X-Google-Smtp-Source: AGHT+IESzT1XUgVRMF488izUXht3+igsQhXI+ukrLyeh7D4Yw6XJibWUnht1jr2UA7/arYTX1I+7HQ==
X-Received: by 2002:a05:600c:68c5:b0:426:60bc:8f4e with SMTP id 5b1f17b1804b1-42660bc9349mr19671835e9.5.1720360451994;
        Sun, 07 Jul 2024 06:54:11 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-768b-c763-2748-445c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:768b:c763:2748:445c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc49fsm129684005e9.39.2024.07.07.06.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 06:54:11 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] PCI: kirin: cleanup (dev_err_probe() and scoped
 loop)
Date: Sun, 07 Jul 2024 15:54:00 +0200
Message-Id: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPidimYC/3WNyw6CMBBFf4XM2jEF5eXK/zCEQJnCRKFkahoN6
 b9bSVy6PCe5527gSJgcXJINhDw7tkuE7JCAnrplJOQhMmQqO6tS5bhqJryz8IID+ZZE2lVsT6h
 0rU55WlXG1BDnq5Dh156+NZEndk8r7/3Jp1/7ixb/oz5FhXkxmLIuTV8RXce548dR2xmaEMIHe
 FjmfcAAAAA=
To: Xiaowei Song <songxiaowei@hisilicon.com>, 
 Binghui Wang <wangbinghui@hisilicon.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720360450; l=1033;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=1dKlQO4wGI6Bmh4Kk42Q8QE+Ynhz/UihyldzXeyqZVo=;
 b=Gg1vVXlPiJb15gdFQ0og90C9bOYQYuLKjSE10dlwDTTQn7NKh52JFelv0Yquld59XSdJ5aneo
 mRUu1ZDSWgTDcOu4bC5wyh+qG+Zb8VnZUrcEEofE5LuQNL6rlvIAhkx
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series removes some patterns that require multiple steps to achieve
what single calls can achieve.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Remove error value from the message "failed to parse devfn: %d\n", as
  it is already handled by dev_err_probe().
- Fix capitalization in error messages.
- Return -ENODEV and provide more appropriate error message if no
  dev->of_node is available.
- Link to v1: https://lore.kernel.org/r/20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com

---
Javier Carrasco (2):
      PCI: kirin: use dev_err_probe() in probe error paths
      PCI: kirin: use for_each_available_child_of_node_scoped()

 drivers/pci/controller/dwc/pcie-kirin.c | 54 ++++++++++++---------------------
 1 file changed, 20 insertions(+), 34 deletions(-)
---
base-commit: 412d6f897b7a494b373986e63a14a94d0fbd0fdb
change-id: 20240705-pcie-kirin-dev_err_probe-0c9035188ff9

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>



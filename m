Return-Path: <linux-pci+bounces-27184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40423AA9ADE
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A572916A2C8
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043826C3A4;
	Mon,  5 May 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cmxkyxgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3D154425
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466929; cv=none; b=KoAknVN/8wX/HyKsZA94bEhRGhX/psBs9TDpuItp7cici2rElCIGEdCpgr2LfMQqO6IJLSJQeH0916GJdeSoTB10QHKe5Umx3bQAY/qNAKlRbpfjYlrLS+c5ktUTCf7wAFWxEW2Cxg/g429o/1UAFTjQCqk0LSwH/Cz6nlzyy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466929; c=relaxed/simple;
	bh=AsnF99CU35lEfuVMfrn7Lp4KdhCC232j/sCNefqZr3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dd0NSqKJ71Y8cU3v/sE0sqzT91EKqmQGRbUDF4gOPlMUFETGYQQn0MeleZ/2D0UvMei892qE0XSa3GaUllTsT4l5DESHwxS0iLHopR+elhVRDl/wJBVSQCn82Kde9RkgYs8KD7i+hIYUZeuLJ0xKgq7Nl789ZzU9TO/gHXj5EYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cmxkyxgS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a07a7b517dso2973760f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746466925; x=1747071725; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a8lN06DriQHOm0MH+gzUsFuR9Qtpx1gu9egDvR4xGbA=;
        b=cmxkyxgSpckRJbS+5QXE8UNLLnZjNjqcp1yx8wunw2ZCXxGlSaY6sGGPsFXpZ9N8Lj
         CHzzXI23q+4UmLDzOJecBDRGrjOUJehbj/fWlorEZlDaWLGqHq+HQE2vhGdiQj16CrP/
         Z+O4dlTmxt/8/6+H/twL9f6J8uqAPiBvrVJo7lQSrFUWdvHm4WS8Jj/yF/bHny3B50PG
         7q32mB/ZeCZJbIPP/NSaECb9NwpA0JIg10OJv3VXLJCCcJoMz212Qk8KwJFD7ZjJYnvg
         vNlEClx9u5STSB1kc8UqEes4OhoQsu7oYaomtGtL0nJVVPa0NrK0+4bxCqf3nnq4wND6
         68zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466925; x=1747071725;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8lN06DriQHOm0MH+gzUsFuR9Qtpx1gu9egDvR4xGbA=;
        b=Ue43mIpb3FQzljXwpIBg24IvY+zf+LuA6dpufo+r10dlrJrzSjPFp1WmBPCJ7eLbp1
         2wye9BYK+mtZRzALcG/NRxlsoVJf5w6zrFMsqddH+os9bti7QvMzCGkZY/YR1L8YSc8U
         Mo9E1dxbzFm9vGV+spnG4BknIOy+rohE5xdsXheJ+MyoRXpncx4x+OsbXR7uJwFr2Av9
         1Ib6Qi6YENkhi6EX1/hMqE5lZ3dTufiMgwEAQ5Dpl2zMmcX6o8Z2240/wwOnesUNi/gw
         qin5YZdIPEuiVenaLnZhAb65Vh8WFmCWAifI4J5mPu2O7i4/5w4P/t+gmGCZCIAXBkjn
         gLxA==
X-Forwarded-Encrypted: i=1; AJvYcCW2imdkfEHPWYpk45TR8mMk2sMDpHQ4Is/2FhkFdMks4NT4z5GJ/Z+hiPBxiKannmYky08clRpyg2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyooylZT8pia1v8b75fG0NT9xBLn7wz55AdMMMwMsBPKEhfVuWh
	bY8dgJnMHI+Tg6Q3tmf3N59oB2WfG21exuAPN8AY7LQtJfBeFiLakOJLFTi50Sf8AKVE2QIlFhs
	p
X-Gm-Gg: ASbGnctYtje2g57t+UF9UvBp56cRTTKI4QsW/7eUTpsAtXgxdtAZIyD1aNukEnxHgyg
	YF8uKhDj+ntQs0/FeIhlti0xOqZsh+ckL6ybcKEhJa4iZ5qMK9TOyT55pcD3+QIvYC0U3foIH9N
	29TXNRN63tp8TN0n4rdWbyyfFkwFK+SblJy0ID2zsgtPuafiHvktf8YRQBt1MzVrXdPS8RFAC2J
	syu6BgGPv60XsVPtpU6EylXyDSuGEV3WQfYAYSD9/9CMfqGZFVs4sytsWPKinRAuZxiRDk2YnO7
	aFuw8nwPSj6q8dx+4q1gXflH+nQS9xwiX3a06rDRyt96wyEiymD6Ew==
X-Google-Smtp-Source: AGHT+IGZTv4ioURW03KoxJEJiMQI2V2RSz7/MViAATIEMWP7dqmwgv1DmXDoWV1GLXdDM837hIaNZg==
X-Received: by 2002:a05:6000:552:b0:39f:4d62:c5fc with SMTP id ffacd0b85a97d-3a09cec0d32mr6471699f8f.35.1746466925370;
        Mon, 05 May 2025 10:42:05 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dc81:e7a:3a49:7a3b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm11345829f8f.69.2025.05.05.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:42:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/4] PCI: endpoint: pci-epf-vntb: allow arbitrary BAR
 mapping
Date: Mon, 05 May 2025 19:41:46 +0200
Message-Id: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFr4GGgC/x2MywqAIBAAf0X23IJpD+hXooPZWnvIRCMC8d+Tm
 NMcZjIkikwJJpEh0sOJL1+lbQTYw/idkLfqoKTqZQWDZXz8veJqIp4mBPY7amu1c4PqaBygpiG
 S4/ffzkspH5fOc81mAAAA
X-Change-ID: 20250505-pci-vntb-bar-mapping-3cc3ff624e76
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=AsnF99CU35lEfuVMfrn7Lp4KdhCC232j/sCNefqZr3k=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoGPhnjMJJUFbkNyE+Myn4/5qoh0JDrCSI4U1Yb
 3C1VImsl9uJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaBj4ZwAKCRDm/A8cN/La
 hZaxD/4gzoR3ebjbcFwNjqhGZIEm0jjPTXFv7MhwqYvOV2CzJZZVy9j2vRZs93xpUdbll2xCn+4
 b5WEEKmzG6Tfi5LPSEoI6rz1bAiLp4yAq83TfH326Dwj1WCSDRqnb3/aoL6vtpep30/Q06RIxHE
 Mky/g6K5BKCg3cJiQeBLw0ezY1uD4W2c+zwrfYF3btL25ujhBx7MaEG8AWjTmBcEqCyL8kna8YK
 EyTGRigGB3V+HdJ0ovYj1p1H54X0Iyv3mLYc25bkDyNnuVOtEz2Sg/6fbbd02icglmO/i1/Bz4Z
 gJYRDd//eGpinDRylsYw97YOTGHtG4f2MiHurzVJCEGcUWdEKghLN/0w8yihFCxyJ+WStP8dtGL
 Dxl/G7EcFcuKS6zr+QE44MXwuTcTaccT5VKkEDDmFonCpxJnh4fBuiw0H+5qxxSG6ak4wZznLGq
 8aVjkMGQQPpTP8/Ka4+BPe58FduvGxOVL3qMFS591lg+sOhpnUGfgy37Z+NccCU6QWXJWi/Gs54
 sy7A8MtT//QNQ72VqMo+8dUCZD6YTnzpLtWq87/mc31cGh9BTnLg5X31bLaDDMYhnCEYtq5eZpT
 jZb1e7S/CFqzYhFy/yfeOi5XWSv6Lit+DzwQxEwmo137avHgg/sO7zUvSnrVl6qtAM5aTMQXQHH
 MR4Gn+bgf22HGdg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The patchset allows arbitrary BAR mapping for vNTB PCI endpoint function.

This was developed for the Renesas platform with requires a mapping that
was not possible before:
* BAR0 (1MB):  CTRL+SPAD
* BAR2 (1MB):  MW0
* BAR4 (256B): Doorbell

It is possible to setup the host side driver with mapping above without any
functional change but it makes to also arbitrary mapping there.

The patchset should not change anything for existing users.

Possible next steps:
- Align the NTB endpoint function: I'd be happy to propose something there
  but I would only be able to compile test it since I do not have the HW
  to test it.
- Expose BAR configuration in the CTRL registers: I've been doodling with
  the idea to add a few extra registers in the CTRL region to describe
  the BAR mapping of the other regions. That way, there would less chance
  for the 2 sides to become mis-aligned. I'm not certain it makes sense and
  would welcome others opinion on this :)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (4):
      PCI: endpoint: pci-epf-vntb: return an error code on bar init
      PCI: endpoint: pci-epf-vntb: align mw naming with config names
      PCI: endpoint: pci-epf-vntb: allow arbitrary BAR configuration
      NTB: epf: Allow arbitrary BAR mapping

 drivers/ntb/hw/epf/ntb_hw_epf.c               | 108 ++++++++++----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 138 +++++++++++++++++++++++---
 2 files changed, 181 insertions(+), 65 deletions(-)
---
base-commit: 1fa7eab22df331bcc7942a9c0b4569bebc11593b
change-id: 20250505-pci-vntb-bar-mapping-3cc3ff624e76

Best regards,
-- 
Jerome



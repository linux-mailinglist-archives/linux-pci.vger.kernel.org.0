Return-Path: <linux-pci+bounces-5167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C222788BFDA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60C61C267E1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B26FB8;
	Tue, 26 Mar 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrVQOr2L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCE06139
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450141; cv=none; b=sWRanzl24GYaJVh1RboQcQixswmrWmCPu/ZhI+0DaTA+wVDaPICXNxd5Un5hQ9tFoZyXZCVkj7888kTPeoC+GOYswY8gDRFhrUkMgh20u9oJO8o27mPVQsapV6be6QUibPGkw2JUWPMmhrguOIB51SfYYKWwhesHpjGreiP4o2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450141; c=relaxed/simple;
	bh=Quu2ymINlKU4yHz9XCUOSf2MmaIXC8OKwWUG58V6qmY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cmVmfGrcPZZT9hrOCBMkxfuQM6YAepZwQRWd9BKl3haWTIYaeLZfyRRh8i2xz/eNOPM3SImxdc4bc2OxNgFZVLwZQjqSK74Mi/ZXdld/Q+0+TlkXsEGAlibDXa6vCskSxZfXZ8pkrNp8NYI2hv+jvDvDRonv6RHCIxxVpGUC1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FrVQOr2L; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso3562811a91.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711450138; x=1712054938; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lu5XW39jfKieYvY9e44qY2nbX2Dc2adOhkKMWS7V+LQ=;
        b=FrVQOr2LeWUxOzOxe1SEKRXHaa18JBdt4EBYx8ReMVOy/hCm9uB+dFdkATvBi578IV
         QLjPROvkD6OWTaDKVy/evp4vYKRibFRfJxT/ABkBP5kflxSPS5ULuPvZOKwyEUtcBIh5
         FrZLcFzlxbZ8qveGjQ3vYhdCKRh2+t4IplpA3gQR27E9GlNza4CxsF8fh7ZUEEvVcs8n
         mCt3qFFeB1o6Rprk1eGku0AF17JOvxdhVQl1iEvCxUM/Uu0Vq7ohM2H0RudRDBA5P3Ow
         qu8+Ern7h/nQrvLMB91GQPuiw6R13W5+0ws+LCN0C/7iWKMTpetnzEf1ii/4zD9DONtA
         ay9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450138; x=1712054938;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu5XW39jfKieYvY9e44qY2nbX2Dc2adOhkKMWS7V+LQ=;
        b=Md4pBgtrntbilycjXLmTjV/q8nW/T6PBLVkyIrYJ4nunh718bh4qqvrgvKQzPWBYOo
         +Ju/xgt4sKjBP0FE+aMylYdEiEPi/nUnn2keg6N5mbHoy5NqtodJJ/2f2RPe+xcUWfKD
         iqAYnpTPmet/kkY3ZjrOUmKPtK6Wa8pIiVtpXajtLkLptxFJI/V2NcH9dCFs5CbsqihS
         noScxmnuT4ViGTfupvLwQnQa9u/HyuwjRwQJ/HJVL1x73fS/u11ZjHP2BizfxoxvL+4w
         P+7L3vkXN535AHycmKHnYcFz9taaUlyJsDkW4blnur9rA5AnarevqV0u3KKAOAC2ktUt
         BdLA==
X-Gm-Message-State: AOJu0YwJTY4zHW+xJ/5n73uF/oocxtV8r/1aNtaUOh/yfnl8xabIbKC7
	dDiw80KckOKeYOpnHOmljmR9lOODPFhPYXwpCFr/MJd/xMIZPvf3pcQ0zloHoA==
X-Google-Smtp-Source: AGHT+IEYhGb2tzcCBqOeDdi6ZxnHj56quq33L5PEplYX6ITxamInSFkkmLP4eQFDkqH4b1D+qBzuSQ==
X-Received: by 2002:a17:90a:16c2:b0:29a:3c70:1525 with SMTP id y2-20020a17090a16c200b0029a3c701525mr6243586pje.45.1711450137313;
        Tue, 26 Mar 2024 03:48:57 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090a059600b0029fc196159bsm8777218pji.30.2024.03.26.03.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:48:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
Date: Tue, 26 Mar 2024 16:18:16 +0530
Message-Id: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPCnAmYC/x2MywqAIBAAf0X2nCCrh+pXooOPrfZiohCB+O8tH
 YdhpkOjytRgVR0qPdz4zgJuUhAvn0/SnIQBDTpj0egSWYfKSUyy2ixIGMhHZ2eQplQ6+P1/2z7
 GB1LLpNFfAAAA
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Quu2ymINlKU4yHz9XCUOSf2MmaIXC8OKwWUG58V6qmY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmAqgLrh1ZLSbLHQnMLmmH/XWQVAbSZYIjeRmCJ
 yQxU2iewZiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgKoCwAKCRBVnxHm/pHO
 9eoFB/sHE3fRENc586KUomjQlcZIlS4RY8z1ZbLLhf8wH1B63b0Tyhsyp0GzfwD66KlDiNiNeLm
 HeJNlR80fxEq94/9tajFIrWOkZgtvuwJ65uYyAoOdBQBaBaC2nmQls7tLY1cWWgffdSeEFwQsB2
 DLT+i+HtoajIzoMVX3j5K0D2bUuYFSunStiarb9BPOhWCRPsBYdJRlT4LoGfdR8Wg1d/rxQiGfq
 9MucCWLYP8Jd0kK8fpRtQeD6WsqtFD8aalqsEeS/uEfbZFb+aFLYb2qqGCUbWiCSyRlVxh3yBPd
 RKcmkw3X27HB3lz7fxYJfd/zriPQ572lU2wDuCtjoedFqdb2
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hi,

This series allows D3Hot for PCI bridges in Devicetree based platforms.
Even though most of the bridges in Devicetree platforms support D3Hot, PCI
core will allow D3Hot only when one of the following conditions are met:

1. Platform is ACPI based
2. Thunderbolt controller is used
3. pcie_port_pm=force passed in cmdline

While options 1 and 2 do not apply to most of the DT based platforms,
option 3 will make the life harder for distro maintainers.

Initially, I tried to fix this issue by using a Devicetree property [1], but
that was rejected by Bjorn and it was concluded that D3Hot should be allowed by
default for all the Devicetree based platforms.

During the review of v3 series, Bjorn noted several shortcomings of the
pci_bridge_d3_possible() API [2] and I tried to address them in this series as
well.

But please note that the patches 2 and 3 needs closer review from ACPI and x86
folks since I've splitted the D3Hot and D3Cold handling based on my little
understanding of the code.

Testing
=======

This series is tested on SM8450 based development board on top of [3].

- Mani

[1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org/
[2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
[3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org/

Changes in v4:
- Added pci_bridge_d3_possible() rework based on comments from Bjorn
- Got rid of the DT property and allowed D3Hot by default on all DT platforms

Changes in v3:
- Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
- Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org

Changes in v2:
- Switched to DT based approach as suggested by Lukas.
- Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (4):
      PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3 possibility
      PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
      PCI: Decouple D3Hot and D3Cold handling for bridges
      PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms

 drivers/pci/bus.c          |  2 +-
 drivers/pci/pci-acpi.c     |  9 ++---
 drivers/pci/pci-sysfs.c    |  2 +-
 drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++--------------
 drivers/pci/pci.h          | 12 ++++---
 drivers/pci/pcie/portdrv.c | 16 ++++-----
 drivers/pci/remove.c       |  2 +-
 include/linux/pci.h        |  3 +-
 8 files changed, 89 insertions(+), 47 deletions(-)
---
base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
change-id: 20240320-pci-bridge-d3-092e2beac438

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



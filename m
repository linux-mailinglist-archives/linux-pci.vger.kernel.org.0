Return-Path: <linux-pci+bounces-4822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116C87BFD1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AB01F223E8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B471B37;
	Thu, 14 Mar 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlYqSTHf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9FA7175F
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429849; cv=none; b=AoHNKumdpmrdEd28kWmHMdvUTv8D0hvEGFUvfvfifjg3yR5deEaTERmtAoATKVPVK2eEN6cRtEuF8fv1jUyna6wrdjhVDU1LSdSKUrdoxrGQJ2cegbTlHYX6fSnZYQwnlM755auU+pzw2E69dGp9eNPjL52P8FANf3s7VZ62gK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429849; c=relaxed/simple;
	bh=+XqMRpYE8HYIeYnArh9TOIJOZHL3dBFs8VCBPD9Q15c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jHAy1rlh4Otnxj8/pUaMKfQYbsc30QEKrDS6CHV977Og/hLpxPBl9gZNxIkehXpk+ti9sSmUlMGYMR/lrfdjdfgWRHVacQiYMvXbznqC65HyRJFmHUNGSODOFJ0mFghlCQgZKZFUpEzNlvPOw/Kc8zKnhGW5YQEpkI5NzrhiIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BlYqSTHf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso340886b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429846; x=1711034646; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uipF2nWjwEvJ8FinmI/99ZEfUz9FMdfPX7qMJmCrSQo=;
        b=BlYqSTHfD9UyaO7QVLhiSf54KlVc81u084CL0d6bDiHMVx3Qds5aFDQ+qTDpErSu2D
         XlsgTVI4RKjJVl3UMQktfDuibqduqOrh1HGRbdLv75+58BKu63/lUGl5jZhh+LuGrVLs
         8kpUs91JFZ+pfZUqE8+qm/rDtiTKciCLiRsD8O+HI+vtJ/KpVxNc2zfqKLDYN/40kpwD
         3oWLUx15fqU9rXyhUW7NKKBqoX5elZUesr90pwDIwyR/XrH9T9agOWbd4tynlBEo7H3t
         fTgegKj4w9RFNTSUWX97cUYfkHQhJSFpsxWMNnwlE72cPxLUDAkPfjtXOj2yfVGrKzCV
         3s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429846; x=1711034646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uipF2nWjwEvJ8FinmI/99ZEfUz9FMdfPX7qMJmCrSQo=;
        b=DMmyjhH0mSIoo8ro4LnrZFcnRRItj33RJtnBRd/WtBPkCn4HFporZOEIYIjD7T6Bnp
         rItvPN9gJIHDeiZQOCJ8gqVsBAArXa+bnH2lol9OHijTItwCg7diOQ0FxcSf6mT1cGhr
         j8qRSG/rnKDGkFXkXXRrBxHgYBANL+n9r0ErmDPH3CTiyhbHN8ljD1zwpyB19+YdxihG
         17vG7Q1ppHZWbmcsII5kzkbK4KHE8zEH1f6CdGirBBf4+f+GaQrgg/XrcaP45dj0vE5o
         ugSFma3vJZmZ9GBncqPn1mxs61W1Ew7zzln0GqXvFk/Z0i3ImdRcL55ffTBeBZAcTudL
         ESFg==
X-Gm-Message-State: AOJu0Yz6j2n7cQd8UhjoxUuZogwtRlonlcebt6v8yu2p2ue5Ix+ANY+3
	/PN2h7s849LosgA8TmNL5M2oieHLndRfY5a2rihdiUvs23IeAntg50PtxTH1yg==
X-Google-Smtp-Source: AGHT+IFklPwK5lYnqo3cgyMR3pbXaUxnP8BhUJMkvG0Mpsc5bJGrHi6YT+MWzcxtRkOPSBXX0DpvhA==
X-Received: by 2002:a05:6a21:99a2:b0:1a1:5a12:9119 with SMTP id ve34-20020a056a2199a200b001a15a129119mr8387816pzb.3.1710429846330;
        Thu, 14 Mar 2024 08:24:06 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/11] PCI: endpoint: Make host reboot handling more robust
Date: Thu, 14 Mar 2024 20:53:39 +0530
Message-Id: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsW82UC/x3MQQqAIBBA0avIrBtQs6KuEi2sphqCkhEqCO+et
 HyL/1+IJEwROvWC0MWRzyPDFAqmzR8rIc/ZYLV1ujQOw8RIYUGh+5QdfU11NRpd+qaFHAWhhZ9
 /2A8pfYuAfZ5gAAAA
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+XqMRpYE8HYIeYnArh9TOIJOZHL3dBFs8VCBPD9Q15c=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaJsDnRXWXOn639N6QSYpQWMRYVyNmaaXhJa
 fn0bkPxFe2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWiQAKCRBVnxHm/pHO
 9aycB/9b/o4Li6j8PqMVlSnWfc7wdfhcraMkEMFGScwUc/THnarLDa5UEMcMICzCyb9OLOWRndt
 oCBxFCx4BL1ZKDe4PUbQUdo47vJm12TLIoq5bnXsy8rl7eUSaxklwzQaG1HxCbenXX6Ob93oo3M
 nOaWZ/FWBuLztkGRERM5PsXEcw0ViOcPwn3IlQ/1qBvKdBCQ+bJEtrJFih8ES1wXtxMCeeeBMem
 0kVbsWosc0pA5xP6Q8EKQfQRX3VLIpRuoL1MmkEA+yQTL03Au8rJS8JowKwbh/MjtDwv+XSiSUu
 Xx+afP9RJhNfpvDPNHIJ/UKyy2Hhztd6xfR07xVMgfhQgjzZ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This is the follow up series of [1], to improve the handling of host reboot in
the endpoint subsystem. This involves refining the PERST# and Link Down event
handling in both the controller and function drivers.

Testing
=======

This series is tested on Qcom SM8450 based development board with both MHI_EPF
and EPF_TEST function drivers.

Dependency
==========

This series depends on [1].

- Mani

[1] https://lore.kernel.org/linux-pci/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (11):
      PCI: qcom-ep: Disable resources unconditionally during PERST# assert
      PCI: endpoint: Decouple EPC and PCIe bus specific events
      PCI: endpoint: Rename core_init() callback in 'struct pci_epc_event_ops' to init()
      PCI: epf-test: Refactor pci_epf_test_unbind() function
      PCI: epf-{mhi/test}: Move DMA initialization to EPC init callback
      PCI: endpoint: Introduce EPC 'deinit' event and notify the EPF drivers
      PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: epf-test: Handle Link Down event
      PCI: qcom-ep: Rework {start/stop}_link() callbacks implementation
      PCI: tegra194: Rework {start/stop}_link() callbacks implementation

 drivers/pci/controller/dwc/pcie-designware-ep.c |  93 +++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  30 +++----
 drivers/pci/controller/dwc/pcie-tegra194.c      |  25 +++---
 drivers/pci/endpoint/functions/pci-epf-mhi.c    |  47 ++++++++---
 drivers/pci/endpoint/functions/pci-epf-test.c   | 108 +++++++++++++++++-------
 drivers/pci/endpoint/pci-epc-core.c             |  53 +++++++++---
 include/linux/pci-epc.h                         |   1 +
 include/linux/pci-epf.h                         |  27 ++++--
 9 files changed, 265 insertions(+), 124 deletions(-)
---
base-commit: d65c75fc384ada26392a975c351689ec4e069c50
change-id: 20240314-pci-epf-rework-a6e65b103a79

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



Return-Path: <linux-pci+bounces-17447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DCA9DC16E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2037628344E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF2183CB8;
	Fri, 29 Nov 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPJBIuDy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A417C990
	for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872295; cv=none; b=YJQV/RyrUNNcnweoEbKuL8vchlm8L+SMlzUI66vsVF9DWKg1khP1jcLekqPDx0Zc0adLiy8DcZh2BzeyMXizq/OqvmRS6LJ4y1oM9Latf65STnenl4zrusRWQTUFpmrkCk/6GaXOq+uITymRPPcyPvSRQeL9zDqFvrKcqd744/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872295; c=relaxed/simple;
	bh=EPOYQ7J1AVICpIBlMdqjCNQqUq72xOGPxY+KH3eq9Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s4JGeIiLs1J2XKHI3RqTmjvF9zuZEGHoAc2duFVBmV4+Ej4vIeyDoc1I08CEWlaMStkwR+XTqOK7ubeLVsmOb0Z0S8ZkgXyMcKfDXcbCgcyQSbL2VYGZexktI403bQJDJNkQHcnYH2ZUbWSR16Dp3KByuP97R56du5qFu5r0Az8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rPJBIuDy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-212a3067b11so16136225ad.3
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 01:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732872292; x=1733477092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBFDhI7b5AWyeGsQ8ROQM0HPo6lilFuo1cxDwHWp2j4=;
        b=rPJBIuDy8t0tvF9/sdcNnocRfFprgCkyH6dYf7d4V7wjIcD/R87qjPn0Dz1grwMybg
         h4UF+e9xEQqjZCrB42g3xDJJIrTWwQaxeM+9QUdlde+hI9x1FdLVy3Nnm5cUNK9c44gA
         LkOuuIJw9umURNn6/Pf7ZakiGnMlAspAQXHT2uqa0STrfF/wTK99kP7EqdwJ5jLVaTcn
         KL3bHmzl2MgfTgwWvIzAKJUHHQZOSM14VMSeCZvZwgBPDT5oilLjnp55pgjpOB/VGdTv
         nLHk4MOqT3JWejQmlAXywc69q1gM/JAo8e82BBR+KEaaW3jaVE43mDDJC5YN86Lx+y/2
         obzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732872292; x=1733477092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBFDhI7b5AWyeGsQ8ROQM0HPo6lilFuo1cxDwHWp2j4=;
        b=B3HRCJk2HLUCIf+ubDLQq0//Wva10E6vYSbXjZYoyCEemnd2fXGG62qiRz4NEAFIhB
         0WvCZvtrOPtExngW3emstx2FFgkBL4GNINU8j+lhGxgoMYL1Iyz1UV/ZO+GCZasy5SjG
         JO49tiNnWHMRnw+IVIMg0ZtVzjo5mgoQWLY9CdJKA+d8LNWCi93XNIv1NfJ+8om2AXu4
         3JCfMpvl4vnkeGYT/4hvDnKKeWlEKpWA+L34CHu1FfQuahRhTUZ2cg2Na8JDh6SLyvdN
         qB4R/v347JQTbwi7nLrYssAelGQt2PFGCOwBrmYMLa71Wf0A2MdXQ+SH34z2g8RZXmJE
         mPfg==
X-Forwarded-Encrypted: i=1; AJvYcCU7pxpFhsmN0c8BBJPqxmrxDupxa4Hqlp1nOjJwwSbezjzuE9iWUQqPtFNAsLLLIVF6LT+PNDjhN3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7+7oiQ/+hbmcLWrqa7AS75xPq+O68hFia14dRNLLSKs99db1
	eQuz36qdygZ9xdo1ehQEUqolSH84lFtxk/ApRkr/cVou41nBe0J9AZs5VYo24g==
X-Gm-Gg: ASbGncsgcn9VYsEPcCpfLZCMg1rPY2EuebmmxrX5CaM8h9Fde3mGOrQtDQzO6vFDXkx
	WC1P/22OeQgAn8egbEcD7FW7c1ym+6EqMcSF0rpcc+dk1wQEKUJB7AAwWN/X9pNcmJgA3PE7QWB
	3YLI/cl1955dRHOyxYdr632tEiuxuARK7NeswMd1T1KdpbCFvFyL70ChV5vJcWHCAwzabpp04/X
	EikZv2xzj9JhaXtcFuk+Hehccgz5K8pRNArA9PtTe3dI71TEQHL8zLjNBML2u9IdpIhRtbV5TeZ
	DQ==
X-Google-Smtp-Source: AGHT+IHPe3gGy8eM2V3S8JdaC3ZbTmVhZZjGLDLxeNc1ht3ObEkED7tiuJvhJ7t3tIl145CCUFCMfA==
X-Received: by 2002:a17:903:228b:b0:20b:8ef3:67a with SMTP id d9443c01a7336-215010861bamr135066985ad.7.1732872292327;
        Fri, 29 Nov 2024 01:24:52 -0800 (PST)
Received: from localhost.localdomain ([117.213.97.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521987f17sm26648115ad.211.2024.11.29.01.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:24:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	aman1.gupta@samsung.com,
	p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Date: Fri, 29 Nov 2024 14:54:11 +0530
Message-Id: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series carries forward the effort to add Kselftest for PCI Endpoint
Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
based on another patch that fixes the return values of IOCTLs in
pci_endpoint_test driver and did many cleanups. Since the resulting work
modified the initial version substantially, I took over the authorship.

This series also incorporates the review comment by Shuah Khan [2] to move the
existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
migrating to Kselftest framework. I made sure that the tests are executable in
each commit and updated documentation accordingly.

NOTE: Patch 1 is strictly not related to this series, but necessary to execute
Kselftests with Qualcomm Endpoint devices. So this can be merged separately.

- Mani

[1] https://lore.kernel.org/linux-pci/20221007053934.5188-1-aman1.gupta@samsung.com
[2] https://lore.kernel.org/linux-pci/b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org

Changes in v2:

* Added a patch that fixes return values of IOCTL in pci_endpoint_test driver
* Moved the existing tests to new location before migrating
* Added a fix for BARs on Qcom devices
* Updated documentation and also added fixture variants for memcpy & DMA modes

Manivannan Sadhasivam (4):
  PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
  misc: pci_endpoint_test: Fix the return value of IOCTL
  selftests: Move PCI Endpoint tests from tools/pci to Kselftests
  selftests: pci_endpoint: Migrate to Kselftest framework

 Documentation/PCI/endpoint/pci-test-howto.rst | 144 +++-------
 MAINTAINERS                                   |   2 +-
 drivers/misc/pci_endpoint_test.c              | 236 ++++++++---------
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +
 tools/pci/Build                               |   1 -
 tools/pci/Makefile                            |  58 ----
 tools/pci/pcitest.c                           | 250 ------------------
 tools/pci/pcitest.sh                          |  72 -----
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/pci_endpoint/.gitignore |   2 +
 tools/testing/selftests/pci_endpoint/Makefile |   7 +
 tools/testing/selftests/pci_endpoint/config   |   4 +
 .../pci_endpoint/pci_endpoint_test.c          | 186 +++++++++++++
 13 files changed, 365 insertions(+), 602 deletions(-)
 delete mode 100644 tools/pci/Build
 delete mode 100644 tools/pci/Makefile
 delete mode 100644 tools/pci/pcitest.c
 delete mode 100644 tools/pci/pcitest.sh
 create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
 create mode 100644 tools/testing/selftests/pci_endpoint/Makefile
 create mode 100644 tools/testing/selftests/pci_endpoint/config
 create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c

-- 
2.25.1



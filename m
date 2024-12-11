Return-Path: <linux-pci+bounces-18095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBC29EC64E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6654F188157A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97621C5F3D;
	Wed, 11 Dec 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kw9QLeIG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F971C5CD6
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904095; cv=none; b=QrvasyJmouNX5kRq9WNFkYa1qCM5MuridJ9APFQIr2hcIwPkcIDW/ZSMvFDRs+r8PvCpsMna9rMOiGEs6zwLFCpV1/njv+yW6xACDGCaAX+ayvyqbFtTzw3uOUQNpwyvGooIoIX0gK6iK1PVmCpHiboFroAztPeUsMKoMv6q3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904095; c=relaxed/simple;
	bh=QDCClO9+ruB6VB/58Ynw02ygmft+gwI7j3Au7lq3IGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXi1B5rRg9ALEhK0KnnWcrxNqPy8rGmT1dG5qSMJOeBkzNUcHwwbqH0nKvR/N3Lus4qlgdepOAXmT4GZSb3zXYjSpI6aCMQBKFPzq8Wc0RikNFMjm+cOGAcZFOlse8qIuLIjBVLb6IrjKcdPcGLQvk4oUcCbh/gZgAx2QWcVyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kw9QLeIG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so343347a91.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 00:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904093; x=1734508893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEGhXU+QLmJOzGqN5qm96MkDiJr/KItzUXBN99PYXic=;
        b=Kw9QLeIGLVBhc/sFBNOd/koF+J7e7iofTdd3cKtJy5akBc14RHKsVd0Jzy5jgidxTA
         aFmNJ43oPSrEF2jQfyIxyRn+M4evk2CLGUm1qa1G9Bn3xpI8GjjQlTr2utiPWvAojg9M
         CWD1YBryWRu1kLH4NPjKQ9XHpZYO4TcZgRkVTxOBBLmiLEkxvXEivsx4wAin4CuRZquV
         Sylj1ZWyX+hl8zTGkxNruJ3hnbeVemJu8HEKrPHN/pmue0Td5b+84846GJH8TRam74Iy
         D/64YFOyV/zO66lnJbU4Cf+4m4fumOddtCtj8CyVRx0vA41DOaxaHy/Pv0ziSNak6tw1
         9dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904093; x=1734508893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEGhXU+QLmJOzGqN5qm96MkDiJr/KItzUXBN99PYXic=;
        b=pKVkGFXkylBi5ekDBmDvzhCi3GaI0utoDFRCoLrY7T0VU5+deuRz7t4QHrKrUzA5nf
         6hOjxJ8MB808Lc/Xwc2Qe4i/sMGTlgC9EG1iV1SBcCd3QjkL8JS5I+EcVeQZNnZxCck8
         F7Wn4mWz0IubAcGB77uomONzchkwlNVJKP7QVpUwgiaC43TaRYPpDk5FIZ7Zsryu4ZqE
         fsjJKgN7oYJsb/pk76zMOBcsjIKiIyKJcb4egdY9V+VC+UXjNDn/OpmgmXGBjvK7RewV
         pdAoglrhGiF0OYOjEhxw6ARcBZcGfHRiVnK9CiRnRjur7U+cYeJv9dYWzIxBL+sZHNg6
         fM9A==
X-Forwarded-Encrypted: i=1; AJvYcCXED4C1krhQovgi/R/IqRkMAdeU1UfOlnaPBRoKmBlIUmTag2pNFaiA3ygTwJWbiwGmXvXSItYyzBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDtuYEevfC6R0YodmSxm8NJHUys/mt+icajCgYtD9W4Esbt4F
	EKo5N11GVQwreC3H2NrEKOZcyZOVYC3W2dLyXbGw/MlBIyO/3tsS9RaQ4mi26Q==
X-Gm-Gg: ASbGnctVX0tGzdTSyQt8rciUA2Uc0Mp8qKrw2u77/HKon5UMrm+zmm4DdWdgPog+Ree
	JHlaq91EmhB/qJFkT3fxFFhd848yksimtYyNssPl05SAhmfu0VhVUvazB5BWbkhbw+tTGdb6i8Z
	5sE0QeCUMlJHfvlmJAbAIF4f269hHhh4+bW7baq0WkSTZbq92mGbpwuP6WHTRAgn8HI9mmyx0N6
	Uaezpbaygf67Ytb1oPS9Yc/kx0iJCXEiJuQSPf6TQh/zbp0yt1atVn8mYPB1HcrTxMDz9mOAKkZ
	lWVF
X-Google-Smtp-Source: AGHT+IEjpYTPZZfgdWB4UyzQkMZqnr6AOgFIDYrlPTj+b2+sChMPtg1c+as/xrmzdknyus1FwtOTkA==
X-Received: by 2002:a17:90b:1f90:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-2f1287a38a2mr2651334a91.8.1733904093408;
        Wed, 11 Dec 2024 00:01:33 -0800 (PST)
Received: from localhost.localdomain ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b93dsm12929775a91.51.2024.12.11.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:01:32 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Date: Wed, 11 Dec 2024 13:31:01 +0530
Message-Id: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
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

Changes in v3:

* Collected tags.
* Added a note about failing testcase 10 and command to skip it in
  documentation.
* Removed Aman Gupta and Padmanabhan Rajanbabu from CC as their addresses are
  bouncing.

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

 Documentation/PCI/endpoint/pci-test-howto.rst | 152 ++++-------
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
 13 files changed, 373 insertions(+), 602 deletions(-)
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



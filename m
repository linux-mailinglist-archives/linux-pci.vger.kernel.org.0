Return-Path: <linux-pci+bounces-19994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA2A1407E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DB016B18D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC8D22DF95;
	Thu, 16 Jan 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyE9E+71"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7E22A7F9
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047828; cv=none; b=CcKcuIw7o5oPzFvrjq2a3CjE7rkeRAcIq7Wge9o6l5tj7t0SHL9IihWk31khdaTKeCf0X7CBCe2tzZIWeNUpRtse48nR0YBs6/OPOFkarW7AAnanVkQyzDry69pMUacrH+I2eO2+LDuJ9EpTzju4cVXqFwuvwj7UIN0bGqfXsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047828; c=relaxed/simple;
	bh=Cfls029jt6+1ViuA9omlvupSKnHGsOVELSd35jNeE50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JBY36HEYad3TIdjya2UK14Ajg50SimS8YVJeTpmccmCuQBpPByHMPLZSVRvCg1bS76aHopKYKg+0FXhsD17jNRhlDoNFfBZ8U0jDnfLbHS9YxFv6pxGY++LOcxD9i7AJmiWTgSDaDGEhG649hnrKLyBN8knN670p7gVSV8dTUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jyE9E+71; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21628b3fe7dso22482325ad.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737047825; x=1737652625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfmKxAUKcXZh1619YtkrCCyWijhCyYLpsgHJ3rMHb7w=;
        b=jyE9E+71SoJ+JhA+9wA/PxCkbh0c90ex8MWW4y6MPT4Vl5NRs6FoyevbTM17xEbtXp
         clOawCyi1boGuL84okCDU3xtjP+1kj0t2eJRNvhKZ8LtYTfnUX6VLES2spmcmAzbbVTg
         6NXK9gW+8mPeqhk04Q2btgAB6Vi0R/Ys11NvchSVhqyYH46l28jYegLY9eLMmyX7uKqe
         p1QPzOhpicI81mjkKXHlD1Wh1816VKOAehhBE9g76GtGa31AvIOYiHjRQBn9EMnXNaR7
         aurQ6Kd6XZCf1kvNk5fv5eiNvNQ6MwcpskQwWVpPzyV1ciVWI8PZtOrX8jmaDeTnOmtW
         3PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047825; x=1737652625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfmKxAUKcXZh1619YtkrCCyWijhCyYLpsgHJ3rMHb7w=;
        b=QiJksdNsqQlwvwNi78JnJRWa24vBAhhnYHC8Ge3g7TcHXw1z5q76O0L7EimjihZ3um
         N1mDbWiNEhYfh9DjteaJYp48cSalbUww73FwJHRvmgV+uoj3SAc7I3EaRzI9qYazZhHi
         CeXIhWHdFSRPXVii1ij1g8RdEEfZ0eqw+N6n6EY8eTHL4CUjq5Yf+4yfJYJTuL8W7TVr
         pZ7nmEE+dC06tvE2RBKEFW0ePlj6m+yhUiR0zLfID9TlQWEY9NOlzWuNZhNu71rA1tTq
         J6EJrBYfQbbLd3Uz3j7kbAk0WZt3l+K35KP/ajkIx0m9u7+3L/6OA0ti9FROPFJTWxB0
         C7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVUh8H1GuR1Kydi1fPuqHSn4hQj6+sm20UEIrLTLNR1RixZK7FLaleiP/zVvh8HbWw5bWaJ4Rm6Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZkUViTW/hrzNcUE03cV+pZ7ambW8Mq+m9VjgMVCI5wQcxpa2
	fqODnlcIEW7e5C8KEY081YEnCt34epR0HNCNDTMEEoe/UJOfkaMIaW7+Bfdfxg==
X-Gm-Gg: ASbGnct+DRxRj6Ior9oboRhSpvTYHYnm/3CMgZtYAqP2p7SnNeQMcUOlsFt2yjCnSIe
	ONXnvId15rpMcwZTjvNsRxuBymAuqYm+JktQUjWmwqiSEMOR+RgiTj+5DmBLaxPllg2gXpjQOy2
	Q2snplGOgPesrjaz7Mtwi47w6d5WHWvwtZDOS/BpvC1JCZ5dM1YxsmCsERNNglYLpLamCtf0bZt
	Y3lysu3/5wOnNhRv46cNMQDZit4Gf/KoK0droqMS5lNqNTA/80pC5lEz4YcH0JdFHxnBHfFHGdx
	S7BQS5WXlQOvKM8wUd5hEw==
X-Google-Smtp-Source: AGHT+IGHCqVnUp8laxBsrAyjTEfGfl8hihKER1EIrc5smmXCIpNgLm5tAWS5wI017Ij/vv1nkBYrHA==
X-Received: by 2002:a05:6a00:1bca:b0:725:e015:9082 with SMTP id d2e1a72fcca58-72d21f11f2dmr41551752b3a.5.1737047825224;
        Thu, 16 Jan 2025 09:17:05 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f1846sm275155b3a.15.2025.01.16.09.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:17:04 -0800 (PST)
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
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Date: Thu, 16 Jan 2025 22:46:46 +0530
Message-Id: <20250116171650.33585-1-manivannan.sadhasivam@linaro.org>
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

- Mani

[1] https://lore.kernel.org/linux-pci/20221007053934.5188-1-aman1.gupta@samsung.com
[2] https://lore.kernel.org/linux-pci/b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org

Changes in v6:

* Fixed the documentation to pass max MSI and MSI-X count to configfs
* Collected tags

Changes in v5:

* Incorporated comments from Niklas
* Added a patch to fix the DMA MEMCPY check in pci-epf-test driver
* Collected tags
* Rebased on top of pci/next 0333f56dbbf7ef6bb46d2906766c3e1b2a04a94d

Changes in v4:

* Dropped the BAR fix patches and submitted them separately:
  https://lore.kernel.org/linux-pci/20241231130224.38206-1-manivannan.sadhasivam@linaro.org/
* Rebased on top of pci/next 9e1b45d7a5bc0ad20f6b5267992da422884b916e

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
  PCI: endpoint: pci-epf-test: Fix the check for DMA MEMCPY test
  misc: pci_endpoint_test: Fix the return value of IOCTL
  selftests: Move PCI Endpoint tests from tools/pci to Kselftests
  selftests: pci_endpoint: Migrate to Kselftest framework

 Documentation/PCI/endpoint/pci-test-howto.rst | 174 +++++-------
 MAINTAINERS                                   |   2 +-
 drivers/misc/pci_endpoint_test.c              | 255 +++++++++--------
 drivers/pci/endpoint/functions/pci-epf-test.c |   4 +-
 tools/pci/Build                               |   1 -
 tools/pci/Makefile                            |  58 ----
 tools/pci/pcitest.c                           | 264 ------------------
 tools/pci/pcitest.sh                          |  73 -----
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/pci_endpoint/.gitignore |   2 +
 tools/testing/selftests/pci_endpoint/Makefile |   7 +
 tools/testing/selftests/pci_endpoint/config   |   4 +
 .../pci_endpoint/pci_endpoint_test.c          | 221 +++++++++++++++
 13 files changed, 437 insertions(+), 629 deletions(-)
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



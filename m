Return-Path: <linux-pci+bounces-19961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D88A13B32
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163CC188BB6A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487F22B59D;
	Thu, 16 Jan 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1Tq+YWy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F522B594
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035493; cv=none; b=ni/rpKAE+3grvA8hUUwZknCpgsnzZiLeJwavSpz/ybWGQ/+DKIdtMsRWwiUysEixkxddNGEyiVLC5oIPTY0x5IAwdeiAG2Tz6SKpxD88xcC8l8Y4iSbD2Xfwm3h43nLjnTqu4X9+OMZPnIacPFBzIh0N2zWBcrrzIVg1QJauq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035493; c=relaxed/simple;
	bh=rUp8au/mlBU5RQbAnAVoSzPC4lKhXO94PCSwv3MUeLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lB2osWGsbHHGcuJBL+3E6mhgdQBnFkg6KdsZKNZJZqjTduOuaQi8QAoJ+YtzEnWbc89e8+up5Vog8MrbRNvgTVkBDqeGfFw6afdeR0opfeZg0MG5PyZwL6SVXgOMPsG4ND5kZQ4WuX1Jp+N7B+3EVBT7+b5E45gZ0p+wD/+K9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G1Tq+YWy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee74291415so1351271a91.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 05:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737035491; x=1737640291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yDAroObl81+EbrVfBlBT3/KwKlJ8oI8mcGbXGzIBkQ=;
        b=G1Tq+YWyeYsAQt++vlL1XJoygqcxEqEa4asBxYBqQgQ6m1xAyaWUa9tsoTl7xnu2WH
         Sn+FkzfCmw35/o5mTmANdTaXoNq1U/ywi0zxcKrZInWlos1TAdeVTOI9MPCQPat6YiiT
         TgjD/cQQhshNW6nwchEduTedx17xs8rJ0Em/2EUac3Z/EhUFAS91V6XAsFZlnJMHuhCk
         TO6ALP3SD2iUjs6V5e745lYY2NEFq+dafqTaoQj0FWB4fXftapZeiVUanh2sLoX6xp5N
         jHLqIuqreBTcQfJ8fxb5Zz1+fOWVZ6Ybx9ZB71ZvDiIVNBmSbednr4M9qiGw/Owq3t5d
         8cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737035491; x=1737640291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yDAroObl81+EbrVfBlBT3/KwKlJ8oI8mcGbXGzIBkQ=;
        b=u1ukjm+XJn5ON43JGnhdB6NAJaFAh6SGCGT40/sk00CprEh8cHvSGUGGdIl1H19GZI
         xXCUUGb9q5shXBB97aPrPaHALRzU1nWpBog5wJOJ+9TO4oI0UKY8lUeZz0DRxBRT2JMD
         aqcTh292wQnjxi3hhgcxBYL+27MKcz5jNd16FEDxKW9Ka2K7FrzP7pF765/d36TzJzM9
         +VpzeTtdvyhWwXMpeKToxBi7XGxCFYrKP65g2OnUWADNG07RaWdB/gznlY3+L4UqX08n
         dvVd5blbQobe/R/TkrYAzJzMOQF3f2gPyXNIV5IRaDo+a4e39NxXW4Z4RPNcnr6Xc9su
         HwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkBhV69DviXQ8XH6A+Bkvh6A9DZ5MSg7ZcbIGkfKQY8kLWciVQ+bd72aTQq+uhCaw+ocA3AVvzCug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTSBx+uFHaulLknKmd3foinwyZJ4xSSA9g+BOR9md6CwbxHpz
	k62Igw3X1Xgh713bbQCbHMvwVZrgthfF+qL6sKAEnZtWBfRCDvikMLtxfMWEEw==
X-Gm-Gg: ASbGncuxT5MwD3WoCZbCutnvb7BLjxelhAi5LnOst9yveePwYk9Gryc40S8A7rcn0Eo
	FkU5ygbkoWDHfWW9NPWWdF2d8eZ/7Iz/UFh6lIZ2eDqobqII9PsFpkGzHMGE8yr13Sae8yvnNnx
	f3E8aP5vjdTvtXWazV/JuUCL50JQcj3tg4HwYZzq4i+Slo7jewfscY0lOxcP/1Kb+jjmrh+6vow
	v+WpkNWUbEUPDDZvC8XnuCDfzUS2yF4ux8pXgXZgm1gMCjIPh7dVsCsMhk3DIs4kminUvVieA0w
	L3rzRnAY
X-Google-Smtp-Source: AGHT+IGfsxiOyI9MXUFJUJDJh/D8O9xdElBVOkU0GQewPrAZlSi1sf3zNBlNdZuKU5JnZChqLjmaJA==
X-Received: by 2002:a17:90b:2e06:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-2f548f44812mr45308189a91.27.1737035491543;
        Thu, 16 Jan 2025 05:51:31 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cba9csm3341229a91.24.2025.01.16.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:51:31 -0800 (PST)
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
Subject: [PATCH v5 3/4] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
Date: Thu, 16 Jan 2025 19:21:05 +0530
Message-Id: <20250116135106.19143-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just moves the existing tests under tools/pci to
tools/testing/selftests/pci_endpoint and adjusts the paths in Makefile
accordingly. Migration to Kselftest framework will be done in subsequent
commits.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/PCI/endpoint/pci-test-howto.rst          |  9 +++++----
 MAINTAINERS                                            |  2 +-
 tools/testing/selftests/pci_endpoint/.gitignore        |  3 +++
 tools/{pci => testing/selftests/pci_endpoint}/Build    |  0
 tools/{pci => testing/selftests/pci_endpoint}/Makefile | 10 +++++-----
 .../{pci => testing/selftests/pci_endpoint}/pcitest.c  |  0
 .../{pci => testing/selftests/pci_endpoint}/pcitest.sh |  0
 7 files changed, 14 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
 rename tools/{pci => testing/selftests/pci_endpoint}/Build (100%)
 rename tools/{pci => testing/selftests/pci_endpoint}/Makefile (83%)
 rename tools/{pci => testing/selftests/pci_endpoint}/pcitest.c (100%)
 rename tools/{pci => testing/selftests/pci_endpoint}/pcitest.sh (100%)

diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
index 909f770a07d6..c4ae7af50ede 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.rst
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -123,16 +123,17 @@ above::
 Using Endpoint Test function Device
 -----------------------------------
 
-pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
-tests. To compile this tool the following commands should be used::
+pcitest.sh added in tools/testing/selftests/pci_endpoint can be used to run all
+the default PCI endpoint tests. To compile this tool the following commands
+should be used::
 
 	# cd <kernel-dir>
-	# make -C tools/pci
+	# make -C tools/testing/selftests/pci_endpoint
 
 or if you desire to compile and install in your system::
 
 	# cd <kernel-dir>
-	# make -C tools/pci install
+	# make -C tools/testing/selftests/pci_endpoint install
 
 The tool and script will be located in <rootfs>/usr/bin/
 
diff --git a/MAINTAINERS b/MAINTAINERS
index e0fcdd8b6434..e96e80d8486d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18002,7 +18002,7 @@ F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
-F:	tools/pci/
+F:	tools/testing/selftests/pci_endpoint/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
 M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
diff --git a/tools/testing/selftests/pci_endpoint/.gitignore b/tools/testing/selftests/pci_endpoint/.gitignore
new file mode 100644
index 000000000000..29ab47c48484
--- /dev/null
+++ b/tools/testing/selftests/pci_endpoint/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+*.o
+pcitest
diff --git a/tools/pci/Build b/tools/testing/selftests/pci_endpoint/Build
similarity index 100%
rename from tools/pci/Build
rename to tools/testing/selftests/pci_endpoint/Build
diff --git a/tools/pci/Makefile b/tools/testing/selftests/pci_endpoint/Makefile
similarity index 83%
rename from tools/pci/Makefile
rename to tools/testing/selftests/pci_endpoint/Makefile
index 62d41f1a1e2c..3c6fe18e32cc 100644
--- a/tools/pci/Makefile
+++ b/tools/testing/selftests/pci_endpoint/Makefile
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
-include ../scripts/Makefile.include
+include ../../../scripts/Makefile.include
 
 bindir ?= /usr/bin
 
 ifeq ($(srctree),)
-srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
 # Do not use make's built-in rules
@@ -27,10 +26,11 @@ include $(srctree)/tools/build/Makefile.include
 #
 # We need the following to be outside of kernel tree
 #
-$(OUTPUT)include/linux/: ../../include/uapi/linux/
+$(OUTPUT)include/linux/: ../../../../include/uapi/linux/
 	mkdir -p $(OUTPUT)include/linux/ 2>&1 || true
-	ln -sf $(CURDIR)/../../include/uapi/linux/pcitest.h $@
+	ln -sf $(CURDIR)/../../../../include/uapi/linux/pcitest.h $@
 
+$(info ${CURDIR})
 prepare: $(OUTPUT)include/linux/
 
 PCITEST_IN := $(OUTPUT)pcitest-in.o
diff --git a/tools/pci/pcitest.c b/tools/testing/selftests/pci_endpoint/pcitest.c
similarity index 100%
rename from tools/pci/pcitest.c
rename to tools/testing/selftests/pci_endpoint/pcitest.c
diff --git a/tools/pci/pcitest.sh b/tools/testing/selftests/pci_endpoint/pcitest.sh
similarity index 100%
rename from tools/pci/pcitest.sh
rename to tools/testing/selftests/pci_endpoint/pcitest.sh
-- 
2.25.1



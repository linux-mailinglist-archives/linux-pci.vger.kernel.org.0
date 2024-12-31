Return-Path: <linux-pci+bounces-19123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B79FEF91
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 14:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DE41622D2
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371619E967;
	Tue, 31 Dec 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZPkARi5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53A19E96B
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735650851; cv=none; b=lh6JAOj86JvuzeGQ4KNvekqqLj0CnwdO3nlhqout6tuDDu0ofY4zy7a5zt3+c8SGK7bJvcyYDBqiXWxup7q6mI5R1/6ouxf5hHt/EVf417kl4P8m2pjWGl6hGrKwcwjZZEN/gjRqcUW9bfaRUH3W3M4H9E0qOXv0wXMCgtteyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735650851; c=relaxed/simple;
	bh=v8whFl/jk7+v9u73VH0q13g2zK6IQeJsS/9Wvy4ZCpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOFoDJIP/y03oj2k6BzzPibz7xLowA1VQnFrI4OHnoF6wry4EH86j1LFDp8yrGiQeWU6siGp1sFB9xtBNZfRP2o4Dy/qPmb/sjnMlXfXe40eCz5un1azFYJTZ8sCumbjfn19N68PdJ0XBQuUwPpZe+QPWKJeqM2OGbjql+8RaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iZPkARi5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21a1e6fd923so81976945ad.1
        for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735650849; x=1736255649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa1jN/asG74sjrgB8hwyWegLPzfHxpGYS7ycWDuiTK0=;
        b=iZPkARi5ILpnlbjIA6sF6rkZRFmUSmelceldXdyim1pBlkmujFr054ET4conjc9LcM
         jqFL9If4hDJ6C6YLkmHdFrGQKuLbvni14/KfTX58cuVi86lyEK2Wp4RIa1/NG6lusp5e
         XtvevibR+Dx5SDgH+w7VtLtnsKf6qioMik8av+n3Vcq01lI5QCo96cwS/VyNqPtTpyp3
         6LNazUmJ3dk79peWBZG2/yiui8hVJ2ca71JI5mJMmjZyoPBgNKp6GDDpGjhV1C+p3u/L
         NOn6oyYO73uoF/BXF1K/FyrRC3Hk1qoWdKDUSPNQWuLeJ4vJYba3PbZDLWs/427azYH8
         29Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735650849; x=1736255649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa1jN/asG74sjrgB8hwyWegLPzfHxpGYS7ycWDuiTK0=;
        b=woIWeTYdyzGmHuIQewmdvEDSbP3p/e69XRoawmoA80/mzqhzebAXFwZaSykP/LeEas
         1qB6EectgFmX7D/R+7ztW0AMp07wtvHcgXG8CgizrdqNPDTnlYchlI/89ZzUMbO19Pam
         51IJogymGJa/1ysQ/kgY8S9on9Vuf96bb2oHjN6U71ZOGqdnC33F5nhsbQQUscC6b0/z
         4TR5MCQbYKbTdHymauXFZpLfOTIx7+qFY7CMn98+uox+S+f4RRIEaGMSEYXILQLnO1Wj
         FHFJ0swlUu2Ww9jn7OY9+5tSxjycpnVP06Q7iYNRMMPpMi3rdii+VYm/KFwm/bM4k0Aw
         kL1A==
X-Forwarded-Encrypted: i=1; AJvYcCVnpep7lgdU8+OqDuB9U0+mKrOENv1JeN2Xb9Yfn8pL7AOau9AhJpRxt4VCbCvMHS3+4oBs6f3z4z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zj/A/CV2EKHEdA0Nbmd1QSPC7aUFw+QgDE9D0MBJCb4gbONO
	nitTl8zx77PiaI0bsqlcret9zXyUxlIxAvxvR8lyr/gJDx40q4kGpdgzuZ6f+w==
X-Gm-Gg: ASbGnctzq1aFp9M2P2gxGplMZMORqa1P5bU430NXO1luMbv6SHHXjvFC6dEkoaDtLkd
	S52wcyHLVEaindmTyAIbKpMyNwUXCgzXfhcE965nz6rBoX+HxPcZ/Z3XoM3HKO6Ef84zmBUqx0R
	6fQUghzcRRASTyCsFmpmCUKZpDEkXF0eJv/iYIc85gH3lT7CZRMqzpsCfvGGzkcBHcLIhQktAqJ
	qjWZTgxqup8elIvSuonplHFPYGMA2OZoQofnCFpXCAduYGtH45x6Vk/ZAUXr7mKfu2iIK91fGgk
	ZYdHTfDnUOE=
X-Google-Smtp-Source: AGHT+IGZUa+Nt5saRgpUAg+RSZhQyxrVDXNDUEbMn6mYhhN1yi9azaKToiDiWgeEgiAtKmbQZ/2U4A==
X-Received: by 2002:a05:6a00:124a:b0:725:f282:1f04 with SMTP id d2e1a72fcca58-72abde846e5mr55442921b3a.18.1735650849549;
        Tue, 31 Dec 2024 05:14:09 -0800 (PST)
Received: from localhost.localdomain ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad6cc885sm20994862b3a.0.2024.12.31.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 05:14:09 -0800 (PST)
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
Subject: [PATCH v4 2/3] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
Date: Tue, 31 Dec 2024 18:43:40 +0530
Message-Id: <20241231131341.39292-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
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
index 1e930c7a58b1..0e611b845d50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18003,7 +18003,7 @@ F:	Documentation/PCI/endpoint/*
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



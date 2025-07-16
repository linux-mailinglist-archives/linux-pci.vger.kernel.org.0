Return-Path: <linux-pci+bounces-32317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE5B07D59
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C1F175BDD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F70280337;
	Wed, 16 Jul 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z45pRkru"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7C28507C
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692599; cv=none; b=L4i1M8d6IpkSMzate2nFRZjSTOrPP3JeXEia9YtUhlqHVUjbgSCjxso/HgicIOxIOw9XOR2oOh4UJ7tLomrcJrhc3/ok2VrgtY0PJ9CvCbDFI25JNuoCClilqRP3gMnwUeLg9UhIQiVeZw35L4VZHmgRzG1I8RTqo9RUkO5Glbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692599; c=relaxed/simple;
	bh=ivY47/GYKwGaQEPPG0RfTdlXuRde0zntBolMB9MqsI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgW39zf6E9bVHE8iGQfGawstxjD60SOL34LK3jyLLtwukrPcbngYdwnA6I3vJYzvvsez3d6OSXHwTr6qdOcUqW3zUTWA6k+WFOEgyeeno1o533BQuplZ7aJ2cBzdpN3ssOoyDPIzbihp+z1j5DDj41G90LjPvdZmQ6CMkpXsJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z45pRkru; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23636167afeso1324545ad.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752692596; x=1753297396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esbHWpgGirzF4l/IzcAptgYdePVrXyCl3+CZXm+eA8U=;
        b=Z45pRkruPBNL5v7cZoKMFU0zKF7zliYmrit4scpTW9qGvdrfbS9GEb5m8ihH5zIWix
         MvTMidir4WBetIuZgeBrX9viXZEObV4uCYk+Zd6ndXZodHHUpj7OYsgBUBcsUMkoDiXS
         vK8d32A3hTON3/5kD35UZILSWcq7m/iviRoHy43xuf7+FOil5BwG5p19SUdtBJnO/qZv
         RL5GLBTrGjFermG8S7+qkAwKKLkR7Aa9ENb3Feiv1q2A1x/F77++DXdyck7AT4dczXU7
         aSnEeAaBGceQ4SYlcjvxInhNhD0WCz6QWx4gH2i9Z02NPJys1dLp3HzMMVO1xk2IOFU9
         LVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752692596; x=1753297396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esbHWpgGirzF4l/IzcAptgYdePVrXyCl3+CZXm+eA8U=;
        b=luPbQKwzjTS87Vs/SAC21egOYwsBuY2p6GWSp4iPjsWXP3WrE5Y6CFY2/uDfbCwyfl
         JrfD8d5eT5Hl6T7yFhT88Z48k+ttyWrw9BTmTbiP6ku5XzN1c8v6fJs/TrOBeVYt5dbH
         h7H+hQLnLsLiPF7EZ+oNefgIKkjJAMOCbHEiuBxSOKxXC+9RWO/St4aw81YLvaE2FtQY
         OdaAfRjjPVp7qsucY9elUCBRf5kUg0GkyTI7Fovs+IecHkkhdAHzwNWajyr3KYP0zcal
         /OKJmZ63nzavzR4SbntA98YPOazTerBVR/3lkRuvfy3J3muVyz8OcA4QtHQmd7CIPoAM
         hPGg==
X-Gm-Message-State: AOJu0YwNypuwQVLJTEwhi2SqhNLLFzNuAc8F+szB/LioJ+gcm+C2WeGt
	7hF8H9GotaLy8sOfP0WkkILfKhGFTcigqy2wiV5BVAqVqx3q7dLt1swWqZ3sPC6xdaLXbzcbAa/
	+R0nANVfST/I0018vJN1GGI8MZ3MJ0MckohAwyvFqE4xWDFrSj+3ple+ort0Hdwz7Re13kXo2ML
	zlDhBeIRdWSb15MXuVCqkG8wMcI2plwJK2FwhzbfzV9pqWmQ==
X-Gm-Gg: ASbGncvj9CJQ2RFvsQA+tPnBbQ61nhYy3Ctu3z8WOaHktdka6RRlSYlDArl8EYPprm9
	9upukXyv7W2dNUKxMpHuQn4pKMAtyL56Mz3bkKb6dR3BFBm3L8j+z+eom5HjICFifXqnLzAONsK
	9oCF+Ffav2vyWEkLlD+SQih71I+s43Zz5Zv7R6sSx9SlPjU2HhBIKCjWbmObu+lre8qIZcbGRRT
	0doFnIBRD+eWkxZnw8v876dGEFEJJ11+4DgxwgChpcX8pp5xF445So0oGP2mzCLXi/9DzDLYizP
	jWZpQVbUaC/va/95HVtEzjpJUK0w0VyOvdwwgi2I0Dkwr+K6g6foWZ0gz5kjvrSLrv+d+WS7x4u
	/5zbUZBs9ZiNGto38Wuxr5O5YzqqdVkNxGDkYspr+iBNYTepb
X-Google-Smtp-Source: AGHT+IHbAxnFhb0yYqj+SzQuAdo26cdqHbJhM4mxL3Mje3wwGe95xsdKDi3h4X0hhIGfhbu6S8wzIA==
X-Received: by 2002:a17:903:238e:b0:234:bca7:2920 with SMTP id d9443c01a7336-23e2572aae9mr76788715ad.24.1752692595945;
        Wed, 16 Jul 2025 12:03:15 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de42864a8sm130323405ad.42.2025.07.16.12.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:03:15 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	ashishk@purestorage.com,
	macro@orcam.me.uk,
	bamstadt@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 1/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove pcie_failed_link_retrain
Date: Wed, 16 Jul 2025 13:02:06 -0600
Message-ID: <20250716190206.15269-2-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250716190206.15269-1-mattc@purestorage.com>
References: <20250716190206.15269-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is desirable to be able to remove pcie_failed_link_retrain for some
systems which are known to have PCIe devices with good LTSSM behavior
or a high degree of compatibility and which may be required to endure
large numbers of hot-plug events or DPC triggers & always arrive at the
maximum link speed. It appears that there is a degree of variability
in DSP/RP behavior in terms of setting the LBMS bit & therefore
difficult to tune pcie_failed_link_retrain with a very high degree
of accuracy in terms of never forcing a device to Gen1 that would
be able to arrive at its maximum speed on its own.

Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
---
 drivers/pci/Kconfig  | 9 +++++++++
 drivers/pci/pci.h    | 8 +++++++-
 drivers/pci/quirks.c | 3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9c0e4aaf4e8c..8f01808231f7 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -68,6 +68,15 @@ config PCI_QUIRKS
 	  Disable this only if your target machine is unaffected by PCI
 	  quirks.
 
+config PCI_NOSPEED_QUIRK
+	default n
+	bool "Remove forced Gen1 link speed Gen1 quirk" if EXPERT
+	help
+	  This disables a workaround that will guide the PCIe link to
+	  2.5GT/s speed if it thinks the link has failed to train. Enable
+	  this if you think this workaround is forcing the link to 2.5GT/s
+	  when it should not.
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on DEBUG_KERNEL
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..51fddc6419f3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -785,7 +785,6 @@ void pci_acs_init(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
-int pcie_failed_link_retrain(struct pci_dev *dev);
 #else
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 					       u16 acs_flags)
@@ -800,11 +799,18 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 {
 	return -ENOTTY;
 }
+#endif
+
+#ifdef CONFIG_PCI_QUIRKS
+#ifndef CONFIG_PCI_NOSPEED_QUIRK
+int pcie_failed_link_retrain(struct pci_dev *dev);
+#else
 static inline int pcie_failed_link_retrain(struct pci_dev *dev)
 {
 	return -ENOTTY;
 }
 #endif
+#endif
 
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 39bb0c025119..d2d06f9ec983 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -36,6 +36,8 @@
 #include <linux/switchtec.h>
 #include "pci.h"
 
+#ifndef CONFIG_PCI_NOSPEED_QUIRK
+
 static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
 {
 	if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
@@ -140,6 +142,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 	return ret;
 }
+#endif
 
 static ktime_t fixup_debug_start(struct pci_dev *dev,
 				 void (*fn)(struct pci_dev *dev))
-- 
2.46.0



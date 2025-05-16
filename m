Return-Path: <linux-pci+bounces-27880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E764ABA16C
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDA03B5DE1
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B2223DC6;
	Fri, 16 May 2025 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HwewPV4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2D2222575;
	Fri, 16 May 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414573; cv=none; b=oqTeNw4vRv8120INf459vGW2N1KOM1VdyBeQlV2klm/5cd1JcKWGogBzLC3ZLnDM6tt1Kn6s4Hd+GzCuF+O2joUWonNggBjOIYNsKs8lpL8lAw/TrIg2h5geo1XasSU9fXnIawZBe+M+ybteTmfHKC+rOgXvO8DR73k7tf6/rlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414573; c=relaxed/simple;
	bh=O3ayu8ZONqiJqL6w00/UKDCzUfhRK5ZW38N2QgYe358=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZrVhuPi66pAWk1Gy+djPsQmrxKUra+2JteNWxGetl11su8ZWUwD48iOqMJvq0AnIoYKEqxr7vxIBOZilTjpz9oQkx/Cp+rwRdhnAYeC0YMFA7iE4VfhrRPN5Cju+FQFHmrpAudJfaORqwDZJMG13M/UQ7S74KoYwSsTUu9ox6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HwewPV4V; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8Q
	nkpC7DXTTaoBj8cG/gGZoH/93W5gjIXcCK742TD6s=; b=HwewPV4VfITRmslAMM
	3rjbozB+mhgs+Jcyz+QrF3aXobswi55iDa2sQX9YFmqBPfXa5gXrBgImjwC28McD
	Q62RCrs9Le2YFwa3Ta8AzBkum8/jVL7Z74ZAzJcSoV95SBMp+pbinzh5xzbaEhNv
	Xl5ork5AIz7XUMaNMSQ2v/vhQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3lOX6bSdoVElgBw--.64634S3;
	Sat, 17 May 2025 00:55:23 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	mahesh@linux.ibm.com
Cc: oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/4] pci: implement "pci=aer_panic"
Date: Sat, 17 May 2025 00:55:15 +0800
Message-Id: <20250516165518.125495-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516165518.125495-1-18255117159@163.com>
References: <20250516165518.125495-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3lOX6bSdoVElgBw--.64634S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw18uw48XFW7Aw18XF1kXwb_yoW8Wr48pr
	4DK39Iga93Jw1Yk3WDAFWIga4jva93C34rG3ykJw1Fq3s0kFyjqw4aqr43uFWkW3409F45
	AFZIqa4jkw1xAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pixuc_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwpPo2gnaDaNOAAAsN

Add a new "aer_panic" parameter to force kernel panic on unrecoverable
PCIe Advanced Error Reporting (AER) errors. This is designed for systems
where unresolved PCIe bus hangs require immediate reboot to maintain
service availability.

The option can be enabled via "pci=aer_panic" on the kernel command line.
It prepares for safer error handling in mission-critical environments
by bypassing indefinite hangs and triggering controlled panic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8f75ec177399..a4a221bb1636 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4679,6 +4679,13 @@
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		aer_panic	[PCIE] Force kernel panic on unrecoverable
+				PCIe Advanced Error Reporting (AER) errors when
+				device recovery fails. This is recommended for
+				systems where bus hangs from unresolved errors
+				require immediate reboot. Use with caution as
+				this bypasses normal error recovery procedures.
+				Requires CONFIG_PCIEAER.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
-- 
2.25.1



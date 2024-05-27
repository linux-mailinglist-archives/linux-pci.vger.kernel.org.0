Return-Path: <linux-pci+bounces-7853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9575F8D0086
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 14:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76261C22702
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0E15E5CF;
	Mon, 27 May 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6fBQ7AP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674FC15E5D3;
	Mon, 27 May 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814576; cv=none; b=YR/1HAK4aNJpHguXh3dmUKL60Jbwfr6XitV4Zt18WYyQVvihYpJ3U+tt9bDwWVzh0NENeTwVI+HnMibPxu0x78MVsB5zFr+nocbRtHiD1ZIYfA/Ihh4sb3IJNIoZXULZxgo5Wd2F1wPbpYAa23bTbrJXV5vnGVoRCRKA4WsRhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814576; c=relaxed/simple;
	bh=/GjJOKz80/OPeh1IZUhwdO/jTNvJXvgYw28YHmRy+ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNQG7vRekUmJ/uqpUNpYvcICQzrJlU8Y46YcjfLsbOPw2Ioj94/yLhpvqi+VPYHc8OrTO7teAiDHLwPAY6ffEI4TYB0IzmDnVrov/dRj7vB6NfDFAb3/GkyrX4Owz+VvWact6QPmhfVpJWKcR3HLOKmqyTO8ozMCkJyzsb5qr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6fBQ7AP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716814575; x=1748350575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/GjJOKz80/OPeh1IZUhwdO/jTNvJXvgYw28YHmRy+ms=;
  b=C6fBQ7APfwSBeLJAAHvcER9gRT0GvWewU8VFqqsbX86HwIrziDsbCCmu
   i2pyXyZq9fgEaY/i4m4Nzvl0TkoivccnEQRrHGLjYGF+8WmMRhexHwTXr
   mXCgxEcVtfMZC2GfYYnNTz1p/8YIJiLZZJTOZDzUc5AgsyAnzqn7Eh/y+
   Yp+zoojyQRXZYftcJGrXUSpUeHLXGbO+op2DBSfe2GkiX1npncBrlhUZM
   0HziXJqXlti+SKLS5mWFm4UZu1At0mli9O6L/W02GEmLCMSuIPNo3LdUA
   nZFNCViqSLsKh2Twn4sxtBEMcCiA5pZtYo5FEwg3LqBNVhypejYSXsT4y
   A==;
X-CSE-ConnectionGUID: 2ld25707RwKfE20KOgWoDw==
X-CSE-MsgGUID: DplWkrMzR6yOEunlIGD3cA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23734142"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="23734142"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:56:14 -0700
X-CSE-ConnectionGUID: YFWi0+SrQV+rzQS/udVCIg==
X-CSE-MsgGUID: ZBHpgWfbTRyNJw3j2NIY2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34643688"
Received: from unknown (HELO localhost) ([10.245.247.139])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:56:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ian Campbell <ian.campbell@citrix.com>,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] x86/pci/xen: Fix PCIBIOS_* return code handling
Date: Mon, 27 May 2024 15:55:37 +0300
Message-Id: <20240527125538.13620-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
References: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xen_pcifront_enable_irq() uses pci_read_config_byte() that returns
PCIBIOS_* codes. The error handling, however, assumes the codes are
normal errnos because it checks for < 0.

xen_pcifront_enable_irq() also returns the PCIBIOS_* code back to the
caller but the function is used as the (*pcibios_enable_irq) function
which should return normal errnos.

Convert the error check to plain non-zero check which works for
PCIBIOS_* return codes and convert the PCIBIOS_* return code using
pcibios_err_to_errno() into normal errno before returning it.

Fixes: 3f2a230caf21 ("xen: handled remapped IRQs when enabling a pcifront PCI device.")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/pci/xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 652cd53e77f6..0f2fe524f60d 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -38,10 +38,10 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
 	u8 gsi;
 
 	rc = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (rc < 0) {
+	if (rc) {
 		dev_warn(&dev->dev, "Xen PCI: failed to read interrupt line: %d\n",
 			 rc);
-		return rc;
+		return pcibios_err_to_errno(rc);
 	}
 	/* In PV DomU the Xen PCI backend puts the PIRQ in the interrupt line.*/
 	pirq = gsi;
-- 
2.39.2



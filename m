Return-Path: <linux-pci+bounces-19272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC038A0121D
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 04:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC02163F88
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 03:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CD184E1C;
	Sat,  4 Jan 2025 03:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ny4iM3xx"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF902F5E;
	Sat,  4 Jan 2025 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735962526; cv=none; b=gSABkmZmGvPXMbz7y3Oj2WYXirFhAifzklCx7xuLCRPmGR8XAmnrjV9L9ia/GRQDmPwGiZPra4/wnvjwRl4lfyV8VU/8hIYRVE4dzWa4NsGU/rQgydb2550MmQRsmQEyOoxf9iO7NThWd9oCK73cTq7DDEln+CpulsDjyPX9aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735962526; c=relaxed/simple;
	bh=yxbHv6iUD/29XP5ATke3cUX5MX2RLlXScgkZO1u6t8M=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Jd0zLEp2X14XaI2p1/3VXxlle6PpI9G1QrrRaQ2KcZphvmcZ6qUjaqepGWYNNJCPUyld8zzL2i0Obf21HXRecvO/iJNV575CRnntD1Grxg4GHS6KlGzz7490pT2P0ZF8JFnL3rzlY8annwjA5NzTY1HAuPD/tb/sUlY2COUtnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ny4iM3xx; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1735962511; bh=2AtSQaRyqne9GadOORx0ISm1RZ5idyeG/5MtQGu253o=;
	h=From:To:Cc:Subject:Date;
	b=ny4iM3xxRak6giHg8Ir+L9afMFSILij2bQLgoAaFzzRBtTKL/VaPdxIBgI4gQS8Kz
	 yHjPcpxRNmPQrHXmFJv1DlIWx46JMgyr29PVsJD66nGDTJ2YExi22Y6+E5SU3lWPUT
	 WK+Y4ELMx9uVnZzJTCkjCWkREPxBwr3YfwDeUvdU=
Received: from Dev.. ([219.142.145.136])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id A0B0B4F2; Sat, 04 Jan 2025 11:40:11 +0800
X-QQ-mid: xmsmtpt1735962011t26eww8fi
Message-ID: <tencent_59625EFD404130F5900D6FB48840AD428F05@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeiehXmH5jtx9iHsk3b9fXCJOCnqV3YqWQrseClcXHj9ebboRN55o/
	 5e9NSR/+j1S4ZGJ+tTWxlWAn/UbaXpxUAEfVQ/VyyLV40Z6Ed3nY332qs34+hLl5y3xGrjUmOeA4
	 +a1ilFETBgM0YNE5m0GOoLk0+ENCRJCCKLC1eM49P9KJ5aT+Tm2JAOLq51CrPMbD9y88xmZgCu8R
	 mY451QC8MTwEWheEg6RfhwgMlwlS/3NR/dG1gEoDGY30pirU+cHyU4Glx6/KC3AJIg5HZRoE0i66
	 d0w547v9BiiVye/z6V3Lusg2gTyvwYfA+h+6Nm3yAVDCgcXQwaWlJ3q+LsKWoGrzM/8ORUzh81wM
	 WiCKhnINUXQhLACK4zmnwqk9R7vdt7UJ7lt8aD8hsn4eVQC9r9yaYWFwsTUVMcoba4jhMeKYXxnZ
	 HR/lS1Od616CG2S2HCBv/euXR4rW7z42rmBRpJLnH8aY3saaishUITmtT+JTXhpEkDf+4PzWnzwE
	 uKr0ed6VpsJOjan/u3DeVCg2KhWXJhcSJnnu8RdmiatTGHrK/4yPqJIagNFU3ovnmc8XkRkoSPi8
	 eVIJC6KLdys8vhgAuSPF3nS88C/KD2f/OWYC5mkLBDus+g4G1Lzp3to8RDk6tZiV5Z1jIuSnpemp
	 4svmE9WY0UOFgoHiMLZnNxWAhnh2GR3IxUfFiv7cusEjOFSv2C8W28SpbcUL6rRt9vc3UAD9Teaq
	 er4wTJQVP9kgEvJ/SxWDAgYZPNjogcr9kM2jYdJZEYOSYs2FTBtteyAeLmkIoP4ui8ozFAXcapz1
	 SgxE9W104unGyotAhLH9zfU539RcyVADMmqkoM5cb0AsWneVYjPfDi6KXur38/uCCXX0Kn03Q/c5
	 fYmQVKse7v2FqfyYtI8rqXh8JPBi+vW5dzAP0Aqer4Oljp94zjv8bwJj/5q/LM/BNC9DqXTUnGrB
	 BltjWcofJRxRamb37FWlvrvgsCYj0Q
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: kingdix10@qq.com
To: marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	King Dix <kingdix10@qq.com>
Subject: [PATCH] PCI: rcar-ep: Fix the issue of the name parameter when calling devm_request_mem_region
Date: Sat,  4 Jan 2025 11:39:41 +0800
X-OQ-MSGID: <20250104033941.2782-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: King Dix <kingdix10@qq.com>

When using devm_request_mem_region to request a resource, if the passed
variable is a stack string variable, it will lead to an oops issue when
eecuting the command cat /proc/iomem.

Fix this by replacing outbound_name with the name of the previously
requested resource.

Signed-off-by: King Dix <kingdix10@qq.com>
---
 drivers/pci/controller/pcie-rcar-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 047e2cef5afc..464f8f29390c 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
 		}
 		if (!devm_request_mem_region(&pdev->dev, res->start,
 					     resource_size(res),
-					     outbound_name)) {
+						 res->name)) {
 			dev_err(pcie->dev, "Cannot request memory region %s.\n",
 				outbound_name);
 			return -EIO;
-- 
2.43.0



Return-Path: <linux-pci+bounces-19306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5756DA0183F
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 06:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9996B1883901
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 05:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632FD824A0;
	Sun,  5 Jan 2025 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ngkpQC1r"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7BB13212A
	for <linux-pci@vger.kernel.org>; Sun,  5 Jan 2025 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736055059; cv=none; b=E9Toa9ZTf3X7YhuVvSDYxeLnCCZ+XlE+7iY4q/2lieWyrwqUhpqtWeI+7MR1vzuMPLDXoR+pH3M6Z1HSCrL5vRHipyb9AwyzoOqhY+B0bk7ci2778CcW1uviqSzyv0vWrDfAEqMN/y3WJoMkkWr7EEbtmAuYA4sdMsc288OItDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736055059; c=relaxed/simple;
	bh=rV2jVt0eES/IyyCrcdsRyU7qU/OJYDActRaJ71OGtBg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NswxKnj/80Na+6wSTpi/vsvXSQW0wypakR06CZ9lAYhOa2xKVOnZPW8f6Vo4l1aHqhLImMAxl2ncDA2ned2Y2JKD/hZ/uazJps9dtS5A+yrVpO75dk7jESdQTceN1nR7LRPxRDwBjkIum9WfG+IsHNEkQTCWzC80+DkJ5dgtMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ngkpQC1r; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736055042; bh=kXJ77ocDyH6H/rvkyIGugrDmq/6rjLTtQizxiisBX5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ngkpQC1rNbRZu5k8zEEH39ejTTp5xCAwtVdF4c86ljD0jfMYATOIQI6IWsYPIWL7z
	 fVvD9CdobtTgQ41UsmJirsF/bi1Cwwd9ky955JcZ1PmBoZx3S+1cQe6b1w7HcLB/HN
	 VUgTLounkahM9uCMcKFGhPmtKR8EJ8/5iT0iBWGo=
Received: from Ubuntu.. ([240e:305:25d4:e300:e2d9:1fb6:5f8b:3c3f])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 7A9142EE; Sun, 05 Jan 2025 13:30:41 +0800
X-QQ-mid: xmsmtpt1736055041t8bqu56yd
Message-ID: <tencent_0202E11515E9ABE9E949CEA71C9C0A161D0A@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeah5QyvsfMDJNR97iUvE0/EzwzJuqYkeO0Uz9tqracrn5cxaSeHyG
	 m4/AT3GsXYJLnj06zknyeALzDm6lD3b7a31ufoFU4R9o4CBXPfs29eCLylnbh6Yeh3OmboSYUVCs
	 2pPNXpwWH3kRMj0NXfA+QkWD93bLI0URO9LJ1rr+MA6Ng0Psm8pnlJNa4UQotepSfJzCJnCI+jRv
	 y/nOz2rUnavk5vvVoBkx6Lgw4HZbO6hbCyuvccjZRHK/v50T7r+IsTNRzdjwZXulqzg5mDsTVHlN
	 7eWOqqQqDSNQJ8GZMlnJxhJegdkbPRy9+Yu8iyrjYMmFK1hy0gbIA3jRx62o2tL/vX0z5s8VJDdH
	 Sk3i1Rk0I7WupeBYL/4TFDmfeqo/PxSe/6uS5BTLw36gmI5A9UHDigkPq44/mncY/eCdgHahPim/
	 j0SVJhsMWsK0GuBVc8BZuH2LNVxFikbq0LJFDtvngCip4Q+Ma2xGHFUVSzVHyc5AoQHeGJfW7m38
	 NHHG4cfTumDQISj0h7MLhfC0NPpw3tb7MsDvVMoScGtGCZEfgUr52KqefMt91F3Sc9SL1stay1zt
	 m9CI6taHAxRIy6NS1vkibMos3n9EoeTKsA4LgXdDPrWlHCV+K+ZuP9/kJ6c0hwpUA2HkVH2g7dzZ
	 dTBQL0m6LuVOiuQ123hcIph0PZ2ciNqpmyAG8HLh+8FiA11EjGm252N/SpJLuF5lydXEimXXBYxX
	 8re1IbyKAt5Afqa9kzWr+igkwHdcHvvnpfA9fEjVJvlSCgw54DUJiAgWtw/NJrLQNUxrytExDAM6
	 95nkNxtx3D7LeX7IRwEgSiXp+3U0ZGzPloutOLLfRliuUnWYoSZHsW4iS2+zZrLvKr2Cq4xPTaHw
	 dZjm690ublATxDnztvmtlRl5vlcGRTgSc6Z8ZDskN78u9BH/mtK4IBFE7YYgFUQxdftrQr5QqWOG
	 9u4goPJGDKKaWZDV2WhRTp2ExDkdzK4JUNwjE50jRL+TQPz6ivumnHSMfAaFQTehUZb8FqWOyXRL
	 dLnStDSwNZA4zliK7NfjQemJ16W5R6BZ07ahO5KQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: kingdix10@qq.com
To: kingdix10@qq.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] Original Patch Title
Date: Sun,  5 Jan 2025 13:30:39 +0800
X-OQ-MSGID: <20250105053039.175128-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_59625EFD404130F5900D6FB48840AD428F05@qq.com>
References: <tencent_59625EFD404130F5900D6FB48840AD428F05@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From mboxrd@z Thu Jan  1 00:00:00 1970
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
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ny4iM3xx"
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
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
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


fdaskldfas



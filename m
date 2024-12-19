Return-Path: <linux-pci+bounces-18758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF69F7709
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 09:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CCA16213C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B31217706;
	Thu, 19 Dec 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W+koAYU6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808BC217672;
	Thu, 19 Dec 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734596132; cv=none; b=ntWuz+8blmJL8BDTUyjvvW8c3TQp2psfdgFiPNDeRk69kLJT6h4M5hqEGCrUxlZ/XwcI0ugTMdpoOrl/iU2DSyH41tPiiCECcxecFkxyS+BEj4L3hLDxrpkYgeXBHr3oZnNAVeY4cYECVPaSGQu1L3Ut16TkBE8zBeAZXlSXFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734596132; c=relaxed/simple;
	bh=8I4d5N/a31vB1NH9TLNh6GnZ+3HcbpvR9DDSv1kaHzg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=i8PbFTKzRcYxGQuFPmYxfXs+R0nEuv/r13uSG5VOPQxfI4q0Zbky6lvwGJDBbkMxWJEqtGXY7OYwnlnXtEEd7bv1Y8wiuCA2Qv3e5OJ76gkopbRwlqHzoYZUFQebUgQ3sz9SOsfDcIX3wN7VInvixpY/Q4svlhvbSe/K6QAnrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W+koAYU6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=D0bV0dTrWNgE0o2VrB
	ETwtSmloZ9EiLOfOcSxLwVzfk=; b=W+koAYU6NqSDm5ta4WJl4/0MJE2v3pbuJY
	1KXXJCiMC+AxhO61vK/rrh3ZIGO+KmVMadT2LLiwslqEy1+SEwS0OCB24AFx056y
	FNh9mF5SrJPCri8f0lVc+kHiiafWCE8ioiONPWjkepsSDTlKSsKA2j5nR9/6auNB
	HXtDBdAjc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAnPwUB1mNnT5DTAA--.12113S2;
	Thu, 19 Dec 2024 16:14:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s-vadapalli@ti.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return value.
Date: Thu, 19 Dec 2024 03:14:52 -0500
Message-Id: <20241219081452.32035-1-18255117159@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAnPwUB1mNnT5DTAA--.12113S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW7KryDXw4UAryfArW5KFg_yoW3AFXE9w
	1rZF4IyFs8W3sIyayayw1rXFyqvasFq3Wjgan7tF15AF1xGw1DAFn5Ar1UZa48W3WrJFyY
	vw1qq3WUAFy3AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjku43UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwO6o2dj1eoCuAAAsU
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

If the PCIe link never came up, the enumeration process
should not be run.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..3887b55c2160 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -517,7 +517,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
 
-	return 0;
+	return ret;
 }
 
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
-- 
2.17.1



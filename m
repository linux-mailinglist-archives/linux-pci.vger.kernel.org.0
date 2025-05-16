Return-Path: <linux-pci+bounces-27869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FFDAB9F08
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3183AB4C9
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEFE15747D;
	Fri, 16 May 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZAP66Zmb"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6BB189906;
	Fri, 16 May 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407388; cv=none; b=pBoJt/QUiIcKhqWS9LZ5SFyns/2nXrJjmM1Xz3YnWnortQPwOIKTGFkdq7u2vUBW+PaccvWe0lcGulqJilm1AUkd5mFXJTPv+P11ZadGdVHysZWyISfe435/ASjB5MJjlFkmyhCsGvsaJBTv4W8jIqMC3IhjWGZ0YF6kSQmQr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407388; c=relaxed/simple;
	bh=fj+CsMRTdhR1fX9gY8RgTc+l5nN9Ow3NT2nQ+WxKZ50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSZahTujQv+Q4wDOHL2KwlifqHPv+xK1Gvrnw4n4BmZvIxOu5E4+qwLQhDeIL31Zvlv6DtOmQ2J1AukxybAH0s7H6/WF4EmByNd4s23v0NPYk/q19Q7UPWY0hIC4Xw9zGtPORP1fsu7wmUfgGXALWeA6YVA1B2TQZ+6W5q79rGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZAP66Zmb; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OK
	C2LPdw3n8i6eOmbAF8IdjSTk4530z62vZdkc/GbAE=; b=ZAP66Zmbdeg2ELRjmX
	rjTqQUpbJ7br5GB/+zmH5QBtEK+FNUKBBjqyWp0gAGERH4kbAfCYsUOtC7M+Zcta
	ikPVzOCqgxPUp4U2LC/q8elaeU7NgkS1II1B51g1RtGwskcZgjdjIGKik/XNbHEs
	icMTj/9Vmi/JpCikJobFkV1Zk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXtfDyUSdoaTNOBw--.62835S3;
	Fri, 16 May 2025 22:55:48 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	manivannan.sadhasivam@linaro.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/3] PCI: rockchip-host: Fix "Unexpected Completion" log message
Date: Fri, 16 May 2025 22:55:42 +0800
Message-Id: <20250516145544.110516-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516145544.110516-1-18255117159@163.com>
References: <20250516145544.110516-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXtfDyUSdoaTNOBw--.62835S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWrWF4xXF4kArW3Cw1fCrg_yoWkGrcE9r
	n8u3W7Aw45KrW3A3Wqy3yxtryrAas09a1IkayrtF1ayas2vr10q34kZ3y8JF15ur1DXF9r
	Kw1qyr47WwnrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAzV1UUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwNPo2gnTiJ5TQAAs3

Fix the debug message for the PCIE_CORE_INT_UCR interrupt to clearly
indicate "Unexpected Completion" instead of a duplicate "malformed TLP"
message. This improves error log accuracy.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 6a46be17aa91..2804980bab86 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -439,7 +439,7 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 			dev_dbg(dev, "malformed TLP received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_UCR)
-			dev_dbg(dev, "malformed TLP received from the link\n");
+			dev_dbg(dev, "Unexpected Completion received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_FCE)
 			dev_dbg(dev, "an error was observed in the flow control advertisements from the other side\n");
-- 
2.25.1



Return-Path: <linux-pci+bounces-27511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3EAB199D
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B07A40B85
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DED2356BE;
	Fri,  9 May 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gOwPULun"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301D232392;
	Fri,  9 May 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806128; cv=none; b=NrUxUv9g66taHdUvFXG4AacaEpbkiovFXY+I6k80RCxdeO2fDeMWbkL+oVzJeBrcSttwCM7U25dQuGqZy/8X32Hf8897BvkjIG3m+UiJJaAG9SFg71ijnyMRvqPf6fQ3MNB2Xn3YkZeeQkhybqbimHYu5gSE+mWon3QQvzhm/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806128; c=relaxed/simple;
	bh=vhN+ImOy8KRaI78dZocl4WHS52lE85WkEwXdjDJrqhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W9jVXbdidU46uxOBnvI2edclLlohhOfeGuiIu1bjroZ3gLQy5PBwfNe7pddaC1S96rTuDr6yb17tKYTlwmXsOK2mPRwufIVqvotKS5fY2TC/+3AG0opffZthX7rm+7Ua/H50MP+mTtQr1ZC0yXlI2LB3IS58vVUL/Aw+eNYQrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gOwPULun; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NV
	bpERAjIqWtGSniTRHflTs2M1hcr5AP4OxgREVbezc=; b=gOwPULunz7dFgKVusc
	NTBToAeQjm2TLdz9xQkUfL3q+1wORCm5YCQB96DO9lK5Vnuhu0W11zkBj4zI27rG
	rYUVn9IvTqYAJGs6ycZ/3Bl/bQFSmb+kdG1o2lGr/9HI3iadmKCpFoi55ooko9uc
	Mp83/02z03D202AEfAXhH9vLU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCH+a9CJR5oqYT+AA--.23731S2;
	Fri, 09 May 2025 23:54:43 +0800 (CST)
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
Subject: [PATCH 0/4] Fix interrupt log message
Date: Fri,  9 May 2025 23:53:58 +0800
Message-Id: <20250509155402.377923-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH+a9CJR5oqYT+AA--.23731S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3Kw48KF1DGw1fAFW3Awb_yoWfXFX_Xa
	4fX3W7Gw48CasIy3y5X39rKr9xCwnFkr1UAFs0yF1DtFnrZrs5X3s5Z3y8uFyvqws0yF9a
	grnFqry0grn8GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZiSl7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx5Io2geIgCRigAAs1

1. PCI: rockchip-host: Fix "Unexpected Completion" log message
2. PCI: rockchip-host: Correct non-fatal error log message
3. PCI: rockchip-host: Refactor IRQ handling with info arrays
4. PCI: rockchip-host: Remove unused header includes

---
Dear Maintainers,

Detailed descriptions of interrupts can be seen from RK3399 TRM doc.
I found two errors, optimized the code and cleaned up the driver by the way.
---

Hans Zhang (4):
  PCI: rockchip-host: Fix "Unexpected Completion" log message
  PCI: rockchip-host: Correct non-fatal error log message
  PCI: rockchip-host: Refactor IRQ handling with info arrays
  PCI: rockchip-host: Remove unused header includes

 drivers/pci/controller/pcie-rockchip-host.c | 119 ++++++++------------
 1 file changed, 48 insertions(+), 71 deletions(-)


base-commit: 01f95500a162fca88cefab9ed64ceded5afabc12
-- 
2.25.1



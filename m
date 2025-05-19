Return-Path: <linux-pci+bounces-27999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7152DABC493
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 18:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE487A902D
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3FD288C2A;
	Mon, 19 May 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DZGfBp2h"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F98288503;
	Mon, 19 May 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672357; cv=none; b=sc4pW0+To4CXHy/fc2dZoVWL3UlpywVGee+Bzh+TEnk045cJWTP++sxpZU0CtmKDSpfyI9xwVC/ycwwHCMEFaqfTj19EptUp9HWR8yxvdGodTpo6XquXKWIlOnH1NfkyxpLbFZ3DWHEePSO3lwib4pm3de18BUqkMvRgYNwTYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672357; c=relaxed/simple;
	bh=H7wDwel0re9GO1dno0YqLQ+D3CK0Xo2XFnoe8dJh/60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hsKzzk5goTnn7DgqOql1R9dR1qJ9h1aw1N8s2mTunkd+rYsMkDdrXtOfzgzMfpZbuIQrhz1j+a5Tu9eGekkyZ88HQLcZ07Tcm2wC+8YPjm9UFig3Cp62KuXWk5S8rrbSclDL1SoHzDGQ+JLvjQ049SnR4qSdhWXkp/4yxh+aSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DZGfBp2h; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8Q
	o+vUjMkLVvouDppHhMA1ElL0zWu6omF/GhbdA/+k4=; b=DZGfBp2hL9cJnoKDrX
	fgjRFAS8CzF5whtge4XlVTQvL4CzZBL1J6r96m+Q0t6aIEuzi4j+hheCfNvE+j/5
	EDxVQFoEmT1yQ5PyUw7N2MO/FWOQTZJde38gkVxJkAZtfsqFEIUMr8B3wmm+HBZ1
	siSeJeNWVYvVZ+kA0aicH50Aw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3vJ4CXStoPbk5Cg--.56045S2;
	Tue, 20 May 2025 00:32:03 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/3] PCIe: Refactor link speed configuration with unified macro
Date: Tue, 20 May 2025 00:31:53 +0800
Message-Id: <20250519163156.217567-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3vJ4CXStoPbk5Cg--.56045S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWxZF48JF4Dtr1fCFW5Awb_yoWfAFXE9F
	yaqFy2kr4UtrW3ZFySyr4avry5ZayUWF15AF18Kw4rJFW7CF4DGr4kurZrXa4kWFsxG3yD
	JFn8Zr1rAw1xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRu89NDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgdSo2grWzwjMAAAs7

This series standardizes PCIe link speed handling across multiple drivers
by introducing a common conversion macro PCIE_SPEED2LNKCTL2_TLS_ENC. The
changes eliminate redundant speed-to-register mappings and simplify code
maintenance:

The refactoring improves code consistency and reduces conditional
branching, while maintaining full backward compatibility with existing
speed settings.

Hans Zhang (3):
  PCI: Add PCIE_SPEED2LNKCTL2_TLS_ENC conversion macro
  PCI: dwc: Simplify link speed configuration with macro
  PCI/bwctrl: Replace legacy speed conversion with shared macro

 drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
 drivers/pci/pci.h                            |  9 +++++++++
 drivers/pci/pcie/bwctrl.c                    | 19 +------------------
 3 files changed, 13 insertions(+), 33 deletions(-)


base-commit: fee3e843b309444f48157e2188efa6818bae85cf
-- 
2.25.1



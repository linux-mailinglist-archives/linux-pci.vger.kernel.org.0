Return-Path: <linux-pci+bounces-27996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52CABC3F9
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 18:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D713817EC54
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB728C87A;
	Mon, 19 May 2025 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fOzwOBIs"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112AE28C5D6;
	Mon, 19 May 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670736; cv=none; b=dT+MYvNPnxG+JJtW8DEBUJSXqPBiGYkEGDIGwRZoC6+yTKejmMuP77yJlbWbFbrGQzBHl3MjFj5tzoSibuCc+bchuiAg0rw3mVU1EWwC7WVWx0/CCmowKfwDAbRs9UxFDvrZ5UFn7qLQTHO0fL7tpwBg5fj/oqucqYdy7npQBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670736; c=relaxed/simple;
	bh=4rkOMpvboA4bqkGU/KoxpZYtamjteNUs9xHAUuSSMiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNU8KTJz90vps+s+U3YKBllF6EIxHkFuwbJgcTA3aP6T/ocjDkz8CB8aWhQyyf3wuIJihm/4N8ihcGCcg1tHIZY9zKNyVcAXalP7VCwIRHlR/yREDxu2rtg+tjh07VW+S0FjzAIQ28sgqEtwyWyZVa4CMVTjalxsrskMEvkwnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fOzwOBIs; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jH
	vaX9YB/20lBOtBtYQ8vti6dWBiuMXx3X707zJ7qMg=; b=fOzwOBIsa9hlNlVN6P
	5COqnGG6+i7nxKWkiEA/K7hg3dNT4e3Fc9KVeKCyjvjCerXxAmMCamoCIuSgwzur
	Sf/3XMhXTqXXrg7hbXltFG48uRbzPEvv/OsYmgSvJmDfVWvUM4EQBAhqd56MJ68P
	4V7Ic6jjCk4jQIaYSBLjIOxic=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHWSeiVitokozvCQ--.46206S2;
	Tue, 20 May 2025 00:04:51 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/3] Relax max-link-speed check to support PCIe Gen5/Gen6
Date: Tue, 20 May 2025 00:04:45 +0800
Message-Id: <20250519160448.209461-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHWSeiVitokozvCQ--.46206S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4UJF18JrWxtr1rCF4DArb_yoW8CrWDpF
	ZxCry8tF1xuw15Xw4xZ3ZY9Fy7WFn5Xa13trs8W3srJFnxGa4ftFWI9F1fXF9rWF4fur1x
	Xa1avws5Ga48Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEdWFUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxNSo2grTN7iCAAAsW

This patch series extends PCIe Gen5/Gen6 support for the max-link-speed
property across device tree bindings and kernel validation logic.

With PCIe 6.0 now supported in the Linux kernel and industry IP providers
like Synopsys/Cadence offering PCIe 6.0-compatible IPs, existing device
tree bindings and checks for max-link-speed (limited to Gen1~Gen4) no
longer align with hardware capabilities.

Documentation updates:

Patch 1/3 extends the PCI host controller binding (pci.txt) to explicitly
include Gen5/Gen6.

Patch 2/3 updates the PCI endpoint binding (pci-ep.yaml) with the same
extension.

Kernel validation fix:

Patch 3/3 relaxes the max-link-speed check in of_pci_get_max_link_speed()
to accept values up to 6, ensuring compatibility with newer generations.

These changes ensure that device tree configurations for modern PCIe
controllers (e.g., Synopsys/Cadence IP-based designs) can fully utilize
Gen5/Gen6 speeds without DT validation errors.

---
In my impression, they have already obtained the relevant certifications.

e.g.:
Synopsys:
https://www.synopsys.com/dw/ipdir.php?ds=dwc_pcie6_controller

Cadence:
https://www.cadence.com/en_US/home/tools/silicon-solutions/protocol-ip/pcie-and-compute-express-link/controller-for-pcie-and-cxl/controller-for-pcie.html
---

Hans Zhang (3):
  dt-bindings: PCI: Extend max-link-speed to support PCIe Gen5/Gen6
  dt-bindings: PCI: pci-ep: Extend max-link-speed to PCIe Gen5/Gen6
  PCI: of: Relax max-link-speed check to support PCIe Gen5/Gen6

 Documentation/devicetree/bindings/pci/pci-ep.yaml | 2 +-
 Documentation/devicetree/bindings/pci/pci.txt     | 5 +++--
 drivers/pci/of.c                                  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)


base-commit: fee3e843b309444f48157e2188efa6818bae85cf
-- 
2.25.1



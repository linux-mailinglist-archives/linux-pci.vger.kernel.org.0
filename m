Return-Path: <linux-pci+bounces-28522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD82AC75B5
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 04:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CC33AAF92
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFE245033;
	Thu, 29 May 2025 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B1k6D/5b"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368D242925;
	Thu, 29 May 2025 02:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484675; cv=none; b=h5PrAXSGwLewqBa6lmaPmMAjXqxiWbBBsKXwXMF/uF8rHcNMj1DjOzTwjBLOnVpJKXvivOewTI0ZvF+2kv3YgwnE1SSLun++oWDdEdUKyyUCAZD/FfNeDxQy9mV4VHoxzrLnDhgpaEqXdVS059dSl39jgfb8a5kwU1vTzK8xdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484675; c=relaxed/simple;
	bh=/kpo9SQ1vYV93fww5bfHNNFHwJ4Hgoj4NQu1ArmQ6EU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0adRaGZeBhIStj2zTSPxk+PCV/JHJ39egU8RgkzvU1y/e8FpPPUzzhnkJsDm9nET87FadeXzECmlYWq8QHhn6zioyE84flwT6WytcT2Zst0lKt607Ox1g4dEaIabsVOQ1OGlQfXv7IkZlZHaS+pa22KPKvMtYVT84FjvnFA7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B1k6D/5b; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HX
	kroScO731YysIkRwX3d9/C26ywtwVZT6POrVn7TVg=; b=B1k6D/5bgLH9YGy/8l
	pqv7YodeP92aFLUKJ000rqTCdajnRO0xGGhTli46wk5lfu7ab2B83MwaaqV3x7ar
	z5EIVyG2X2GP2lGbDjim1Zwp+P6t6QvSyrU247XAoKCTe0XDOk8p9zcjo+oiKrkg
	UZpQ77Hm52XmlZrokEp5rWLwY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3we4Uwjdot_dqEg--.40331S2;
	Thu, 29 May 2025 10:10:30 +0800 (CST)
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
Subject: [PATCH v2 0/3] Relax max-link-speed check to support PCIe Gen5/Gen6
Date: Thu, 29 May 2025 10:10:23 +0800
Message-Id: <20250529021026.475861-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3we4Uwjdot_dqEg--.40331S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4UJF18JrWxtr1rCF4DArb_yoW8ur18pF
	W3Gry8tF18Cw15XwsrZ3WF9FyUWFn3Aa1rtr15W3srJ3ZxGFyftFWIvF1fXF9rWFWfur1x
	ZF4jvwn3GFy8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMoGHUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxxco2g3vlq9+gAAsQ

This patch series extends PCIe Gen5/Gen6 support for the max-link-speed
property across device tree bindings and kernel validation logic.

With PCIe 6.0 now supported in the Linux kernel and industry IP providers
like Synopsys/Cadence offering PCIe 6.0-compatible IPs, existing device
tree bindings and checks for max-link-speed (limited to Gen1~Gen4) no
longer align with hardware capabilities.

Documentation updates:

Patch 1/3 extends the PCI host controller binding (pci-bus-common.yaml) to
explicitly include Gen5/Gen6.

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

---
Changes for v2:
- The following files have been deleted:
  Documentation/devicetree/bindings/pci/pci.txt

  Update to this file again:
  dtschema/schemas/pci/pci-bus-common.yaml
---

Hans Zhang (3):
  dt-bindings: PCI: Extend max-link-speed to support PCIe Gen5/Gen6
  dt-bindings: PCI: pci-ep: Extend max-link-speed to PCIe Gen5/Gen6
  PCI: of: Relax max-link-speed check to support PCIe Gen5/Gen6

 dtschema/schemas/pci/pci-bus-common.yaml          | 2 +-
 Documentation/devicetree/bindings/pci/pci.txt     | 5 +++--
 drivers/pci/of.c                                  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)


base-commit: fee3e843b309444f48157e2188efa6818bae85cf
-- 
2.25.1



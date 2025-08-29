Return-Path: <linux-pci+bounces-35089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC6B3B5DC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 10:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34ECF56605B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76343273811;
	Fri, 29 Aug 2025 08:20:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62BF1E8324;
	Fri, 29 Aug 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455658; cv=none; b=bFGcj7oj13x6MnJd0vOmriiNuff8ay8ajdbUKQjVSniIh5qGGVqLwZDCeBkL/r7bI8sjg+V4gAs8HU4reeC6OnD5vgYHhKtkvoUHPT0n6FLOx8cq6Zua4JubATxBKeMybuF4h2EiJXoUH3pCYrLOak2yaZSnc8ovSwvl5R/Sllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455658; c=relaxed/simple;
	bh=xGsG7p9LCdPXrjEdh5XO/vK4HrJFG0WsCRHaptfIK30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXQN8nkE/L/ofksXI+7zIsqtmfHvJ7jE/dReV4A2LaRnBHUj8Ydxx2GBsF2z0lyxxs1OZUtvjNVaSGkRvSJzI07qsZw4MJ4BSp1q84JSBaeOITwsgvX6WtUTZ5ltdofIslKsLV/Y1bpifuUudeMtnx8ZTqqLb4NTI9aTnHZt734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app2 (Coremail) with SMTP id TQJkCgAHppTOYrFoZgfFAA--.58076S2;
	Fri, 29 Aug 2025 16:20:34 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	johan+linaro@kernel.org,
	quic_schintav@quicinc.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	thippeswamy.havalige@amd.com,
	mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v2 0/2] Add driver support for Eswin EIC7700 SoC PCIe controller
Date: Fri, 29 Aug 2025 16:20:21 +0800
Message-ID: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHppTOYrFoZgfFAA--.58076S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWkAFy7KF1rCrykKF1xZrb_yoW8uFyDpa
	yDKr1YkF18Jr47XwsxJa10kr43XFsxJFy3Gw1Igw17Xay3uas2q3sagFyYvFy7ArsrXw4Y
	qF1YqF4rKFy3AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRuHqcUUUUU=
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

This series depends on the vendor prefix [1] and config option patch [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250825&id=ac29e4487aa20a21b7c3facbd1f14f5093835dc9
[2] https://lore.kernel.org/all/20250825132427.1618089-3-pinkesh.vaghela@einfochips.com/

Changes in v2:
- Updates: eswin,eic7700-pcie.yaml
  - Optimize the naming of "clock-names" and "reset-names".
  - Add a reference to "$ref: /schemas/pci/pci-host-bridge.yaml#".
    (The name of the reset attribute in the "snps,dw-pcie-common.yaml"
    file is different from our reset attribute and "snps,dw-pcie.yaml"
    file cannot be directly referenced)
  - Follow DTS coding style to optimize yaml attributes.
  - Remove status = "disabled" from yaml.

- Updates: pcie-eic7700.c
  - Remove unnecessary imported header files.
  - Use dev_err instead of pr_err and remove the WARN_ON function.
  - The eswin_evb_socket_power_on function is removed and not supported.
  - The eswin_pcie_remove function is placed after the probe function.
  - Optimize function alignment.
  - Manage the clock using the devm_clk_bulk_get_all_enabled function.
  - Handle the release of resources after the dw_pcie_host_init function
    call fails.
  - Remove the dev_dbg function and remove __exit_p.
  - Add support for the system pm function.
- Link to V1: https://lore.kernel.org/all/20250516094057.1300-1-zhangsenchuan@eswincomputing.com/

Senchuan Zhang (2):
  dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe host controller
  PCI: eic7700: Add Eswin eic7700 PCIe host controller driver

 .../bindings/pci/eswin,eic7700-pcie.yaml      | 142 +++++++
 drivers/pci/controller/dwc/Kconfig            |  12 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-eic7700.c     | 350 ++++++++++++++++++
 4 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c

--
2.25.1



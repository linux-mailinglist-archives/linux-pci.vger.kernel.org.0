Return-Path: <linux-pci+bounces-27842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C4AB990D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 11:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090AD1BC0C9E
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423E230BDC;
	Fri, 16 May 2025 09:42:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E2E163;
	Fri, 16 May 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388536; cv=none; b=luooCuaQ7fMeRQgUReNmcT6uuvR7sULXUko52xf3ItDbEErKNamNTmqQLtYC4vTp4YXq/CN9WmkrMNjC28EzJ2/+sVY2WSelNNTVrDT6C5TlieN1ml2IJRwHkmxBc30SpX/llg6TM4vjFiu5O87gTk+f75LILZnG+5QNRH1d8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388536; c=relaxed/simple;
	bh=IqfzZXm9B32jb9GH4WHkt1Mnc8xHk9lHE94NXNBgzB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLYkIEljAXQkGatXtozqcJsrHcNDzmg72bOdzqB6edvccUfTqAe1Fw00PV5BbGcAcJuVTxEnJuC4EHk6RbKiOT+GOS6S1p0h1wUUhgLrxneVCaWxoq5bBpp9FqRu87fyT4W5fAwr9e1UvksknZCrqubFbzjxy1f8VyHumIUmq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app2 (Coremail) with SMTP id TQJkCgBnBpVeCCdodNR8AA--.23978S2;
	Fri, 16 May 2025 17:41:52 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	johan+linaro@kernel.org,
	quic_schintav@quicinc.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	thippeswamy.havalige@amd.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v1 0/2] Add driver support for Eswin eic7700 SoC PCIe controller
Date: Fri, 16 May 2025 17:40:56 +0800
Message-ID: <20250516094057.1300-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBnBpVeCCdodNR8AA--.23978S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF1fuFy8tr17Xr4fCF43Awb_yoW8Jry5pa
	yDKF4YyFn7GrW3Jw4fJ3W0kr43J3Z7JFy5Awsag347tFnxC34kXryft3WftFy7Gr1xXrya
	vry5t3W8GF17AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRByxiUUUUU=
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

     Support for the Eswin eic7700 PCIe driver control program has been
    added to the Linux kernel, which is part of the Eswin SoC family.

    Features:
     Implements support for the Eswin eic7700 SoC PCIe controller,
    It is a high-speed data transmission interface, which can
    enhance the speed and performance of computers,It can be used
    to connect different types of devices.

    Supported chips:
     Eswin eic7700 series SoC.

    Test:
     Tested this patch on the Sifive HiFive Premier P550 (which uses the
    EIC7700 SoC),The pcie driver controller operates normally through
    the nvme peripheral test.

Senchuan Zhang (2):
  dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe host controller
  PCI: eic7700: Add Eswin eic7700 PCIe host controller driver

 .../bindings/pci/eswin,eic7700-pcie.yaml      | 171 +++++++
 drivers/pci/controller/dwc/Kconfig            |  12 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-eic7700.c     | 437 ++++++++++++++++++
 4 files changed, 621 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c

--
2.25.1



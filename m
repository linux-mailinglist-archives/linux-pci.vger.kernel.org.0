Return-Path: <linux-pci+bounces-34376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A230B2DB8C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFDD176A42
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78FB1E51F1;
	Wed, 20 Aug 2025 11:47:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09B2BE7BE
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690436; cv=none; b=DcQSjZJXz5x6Bg923vfHT12X188djE2pgKdQBsWomq3fYOjUNdHAyJz4tu3W6pY5rVoC4e14gQHXR70csr1tIg7Ms5/qlN3TlxSAsbl4uUeUWnQv26CRcB9qOdjBFc0y/ebYlYMJ1SrvTIODQYraxRSZosRc2ij6NcrSKXx1RLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690436; c=relaxed/simple;
	bh=GiiYbBS8xZFbAF94hHLqhAp0dR6q3MbCj6wKxxBALKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MYuRyiVB6Zic14Hpswny2Hxif4Ydy4O+gmISyAYRvdGbtxewpUzV9nv6XXzA+l3paFDKdxUBKsBXkR8M9YeC6iax2H8C9SibiqREwmKQUFGBqzhNDKaPitM7cAdCqFB2q80JTDdZF89j+PPhSluDR7Lx5uFYjLa7770L09EuWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 57KBJ5Ix018980
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:19:05 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 57KBIqZ0018796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 19:18:52 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Aug 2025
 19:18:52 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-pci@vger.kernel.org>
CC: <ben717@andestech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>,
        Randolph Lin <randolph@andestech.com>
Subject: [PATCH 0/6] Add support for Andes Qilai SoC PCIe controller
Date: Wed, 20 Aug 2025 19:18:37 +0800
Message-ID: <20250820111843.811481-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 57KBJ5Ix018980

Add support for Andes Qilai SoC PCIe controller

These patches introduce driver support for the PCIe controller on the
Andes Qilai SoC.

Randolph Lin (6):
  riscv: dts: andes: Define dma-ranges for coherent port
  PCI: dwc: Add outbound ATU range check callback
  dt-bindings: Add Andes QiLai PCIe support
  riscv: dts: andes: Add PCIe node into the QiLai SoC
  PCI: andes: Add Andes QiLai SoC PCIe host driver support
  MAINTAINERS: Add maintainers for Andes QiLai PCIe driver

 .../bindings/pci/andestech,qilai-pcie.yaml    | 146 +++++++++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/andes/qilai.dtsi          |  77 ++++++
 drivers/pci/controller/dwc/Kconfig            |  13 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 227 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |  18 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   3 +
 8 files changed, 487 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

-- 
2.34.1



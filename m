Return-Path: <linux-pci+bounces-7659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12218C9F0A
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17D91C21B4F
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E80E1369B1;
	Mon, 20 May 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kW7+iekB"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B88136673
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216857; cv=none; b=YbMqJ199poRHrnGSYlNXSCVaknquH5jrsvvIyYo+cYyKAWE4CXI1RlZwYLDvEcC4RHfPnTuFMqzMj4qqcDeuRYDi80Udm1VIp2ZF7TK11lHOVwuFZ7EjDXZNT5jXzDt6Q5ispw2djrDI4KZArpV5zhfAnW4qfYjXnf8vTxnvAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216857; c=relaxed/simple;
	bh=IGoXuzhEewN0WiDN4wZvChE7YzHTsgmvn+wDiFNDyig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nRVXeXUA5Fq9Nm/4cp5YmGWSITVnFzXRjl792beE0I26smK8jxJ3B80SOcHt8+C4m4q70/7UVEmJw9UlIgy4AL9MqwYjn+x99pkttC6Xf+ZDwtCtncNPsrcraQIfo+/270wCMIOQrTQRDyRLL6GUDAi7dsG2JyhQNhj/qiZv/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kW7+iekB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716216852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w1h/xR/QccO1Eert9Isb8A9fPFsSylLSp7IZB8Olt3o=;
	b=kW7+iekB97Kle4UEBLetMFA3K+gkpRyBCG/sZ/6cu0q/OnlA1xFFy5rWIkbPl1IDdHw+jt
	4gcGqSKezSkT+0Ao9p5SdkoXYwBk7oAWfsLOjJuxVxKwuZSOCqy14v+P+OP6ETqR90cyqB
	0s7adWTxfurczQZ3O+2hPPePUZAy39w=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Envelope-To: bharat.kumar.gogada@xilinx.com
X-Envelope-To: bharatku@xilinx.com
X-Envelope-To: helgaas@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: krzysztof.kozlowski+dt@linaro.org
X-Envelope-To: lorenzo.pieralisi@arm.com
X-Envelope-To: michal.simek@xilinx.com
X-Envelope-To: devicetree@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/7] PCI: xilinx-nwl: Add phy support
Date: Mon, 20 May 2024 10:53:55 -0400
Message-Id: <20240520145402.2526481-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add phy subsystem support for the xilinx-nwl PCIe controller. This
series also includes several small fixes and improvements.

Changes in v3:
- Document phys property
- Expand off-by-one commit message

Changes in v2:
- Remove phy-names
- Add an example
- Get phys by index and not by name

Sean Anderson (7):
  dt-bindings: pci: xilinx-nwl: Add phys
  PCI: xilinx-nwl: Fix off-by-one in IRQ handler
  PCI: xilinx-nwl: Fix register misspelling
  PCI: xilinx-nwl: Rate-limit misc interrupt messages
  PCI: xilinx-nwl: Clean up clock on probe failure/removal
  PCI: xilinx-nwl: Add phy support
  arm64: zynqmp: Add PCIe phys

 .../bindings/pci/xlnx,nwl-pcie.yaml           |   7 +
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   1 +
 drivers/pci/controller/pcie-xilinx-nwl.c      | 122 ++++++++++++++----
 3 files changed, 107 insertions(+), 23 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty



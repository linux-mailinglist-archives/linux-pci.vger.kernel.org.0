Return-Path: <linux-pci+bounces-11980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986ED95ADDD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 08:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E32D28179B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815B21494BA;
	Thu, 22 Aug 2024 06:45:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F313B5AE;
	Thu, 22 Aug 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309105; cv=none; b=BRev2G13L1UaF5YgQZ3Wu4oct0hoG93tJIxcyMHu42uhPkWEMDonJ/QZgE8R1xIKvznIe1F1BQy/MlQmLmW91H2Dcs+RknGIkmp1P1uqE7LkUudaIFhcpIknszly1wNmy+dcDPNaRQjvdsHrgeiI0lAnrQmas4605hvHvhD2/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309105; c=relaxed/simple;
	bh=UoiscaqvEmnMfzaQUl8ryIPywzTvN2Kt9DLWSSqOOdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EgsZKVGLQ4w+/+GFanJXL3tTfiRXUdhfaN1Z6q02y0se6xAprlraBWQszHIcWPvHgvQjR5Hp7XAOIjeqOap9DLYCc41/n9Ag8SoRpUo5BL/geIjxK8uk5Rh1CP1Zv56hGGmkG6Naxjl1danLeBw/UjfnAfFvprJkT/o+1GJaUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.10,166,1719846000"; 
   d="scan'208";a="216265994"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Aug 2024 15:45:01 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8ABA441890E4;
	Thu, 22 Aug 2024 15:45:01 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: marek.vasut+renesas@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] PCI: rcar-gen4: Add R-Car V4M support
Date: Thu, 22 Aug 2024 15:44:57 +0900
Message-Id: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the pcie-rcar-gen4 driver can reuse r8a779h0 (R-Car V4M) without
any driver modification. So, just add compatible to the dt bindings doc.

Yoshihiro Shimoda (2):
  dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4M compatible
  dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4M compatible

 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml   | 1 +
 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 1 +
 2 files changed, 2 insertions(+)

-- 
2.25.1



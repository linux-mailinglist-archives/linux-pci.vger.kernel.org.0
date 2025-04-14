Return-Path: <linux-pci+bounces-25846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DDA88745
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BB05606D3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339B274658;
	Mon, 14 Apr 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iZD/OC4K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15586.qiye.163.com (mail-m15586.qiye.163.com [101.71.155.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789A42A92;
	Mon, 14 Apr 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644412; cv=none; b=mf3GYP0cTTakZaw92yrYFUyHQUOmI9j45AX/Puohb5v2KebjJHxAaxL9GBZHgP1bIEazvCcKeZzXg6qjeyIqvuAzVpywhRMLTwZVyMEGUX9Sup6y+XM+0HnpLwQwTZIX9YPYekkWxN8yzlsawikbNY7dxuuxusFmaROf5+EEEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644412; c=relaxed/simple;
	bh=1iiEALXoYkJLnXjqez/9uboLZ8pTi6TNO0dFLtbhpQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LfKcJc9j857kfAY3xwrygtlK9zkiYsADVlM4mbaLu1K07bwqQ5mwEV9RnHcCizGhvR1LMktZ41easxUrpeMr6RKW3J1UeCSl6g9Li2XfSFN6t63kQuwffbPeY7RqmR29tzF+oPpxVyO5jljYRRxv+sqHeQzvW6ntBFCYkEq9dvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iZD/OC4K; arc=none smtp.client-ip=101.71.155.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [124.72.37.3])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11d4dc641;
	Mon, 14 Apr 2025 22:51:12 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: andersson@kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 0/2] rockchip: Add rk3576 pcie dts nodes
Date: Mon, 14 Apr 2025 22:51:08 +0800
Message-Id: <20250414145110.11275-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEoZVkpMGEhLGENCQ0JLGFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSExVSFlXWRYaDxIVHRRZQVlPS0hVSktJSEJIQ1VKS0tVSk
	JLS1kG
X-HM-Tid: 0a9634c86d2a03afkunm11d4dc641
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6PAw*KjIBKCIRSgs#EkwX
	FU8aCgNVSlVKTE9PTU9JSUxIQ0lMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKSU9VTElVSExVSFlXWQgBWUFJTUhNNwY+
DKIM-Signature:a=rsa-sha256;
	b=iZD/OC4KppITphC8tbsX4PwJw6hHwNbJFgEM5bNyDTHCWkMwnb49j42ECGwPfTJxzV0sU7PDBpN+M9E8u2qZ6Spy1SLAQdizv6R3P15UPNkVUgw5OtuTQBgffFfuboRQvs2DNH/0wi+MUuR0C4oTH+slONI4ZTJ+wVFyDOsi2ko=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=CXlbWKegeuuphuVD8v7XhITmdjJpr+DU67mdolnYNJ8=;
	h=date:mime-version:subject:message-id:from;


Hi Bjorn,

This patch set adds support for rk3576 pcie by adding the dts node,
and this series is a re-base on v6.15-rc1 and collect tags without code
change.

Please help take the dt-binding to PCI tree if there is no more change request.

Thanks,
Kever


Changes in v9:
- Collect review tag
- rebase on 6.15-rc1
- Add test tag

Changes in v8:
- Collect review tag and add Co-developed-by tag.

Changes in v7:
- Move the rk3576 device specific schema out of common.yaml
- re-order the properties.

Changes in v6:
- Fix make dt_binding_check and make CHECK_DTBS=y

Changes in v5:
- Add constraints per device for interrupt-names due to the interrupt is
different from rk3588.

Changes in v4:
- Fix wrong indentation in dt_binding_check report by Rob

Changes in v3:
- Fix dtb check broken on rk3588
- Update commit message
- Update the subject

Changes in v2:
- remove required 'msi-map'
- add interrupt name 'msi'
- Update clock and reset names and sequence to pass DTB check

Kever Yang (2):
  dt-bindings: PCI: dw: rockchip: Add rk3576 support
  arm64: dts: rockchip: Add rk3576 pcie nodes

 .../bindings/pci/rockchip-dw-pcie-common.yaml |  10 +-
 .../bindings/pci/rockchip-dw-pcie.yaml        |  55 ++++++++-
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 108 ++++++++++++++++++
 3 files changed, 165 insertions(+), 8 deletions(-)

-- 
2.25.1



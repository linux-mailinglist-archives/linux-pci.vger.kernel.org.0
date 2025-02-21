Return-Path: <linux-pci+bounces-21978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5272BA3F2D1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 12:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB17919C0633
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8AD1F03F3;
	Fri, 21 Feb 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HT9z0/UE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731120.qiye.163.com (mail-m19731120.qiye.163.com [220.197.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D202AE89;
	Fri, 21 Feb 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136793; cv=none; b=nQ/HXWrcXT3aKV/v7jJq8ZQlxOn3x+PRPjjVubj6vI12Mwji4tM08VZbqbaWio4qMdl46/lwle0H2rjOPFp1eTeBHVN8uCMe2zMjuNoBJXcCVUuZTylOTcPDv+OIplApfq+VR4oH3WKWIoSU6wwzJDk76PEsz/7CxT8m8zpRHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136793; c=relaxed/simple;
	bh=f9WF6evS4MjxH2ZHrpW80u609CheGo8MZRRa7Tv+w28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+rKtcS/N1EwpA1zCMoBqOKTuB9gQXi/1d1BP3DtxGEIxnq3LwxuRDq7yCgZj7KWE6zkMMZqUsP84yfYjUtsrNG2VXiDkrQWqD78Y5Bt7cNUq/jVvcsQkSlHg/6PbkdO6rqsU+cHTEGcQoZCaOSXl0MqnRpbX1cT27HbO9RJxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HT9z0/UE; arc=none smtp.client-ip=220.197.31.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bca250ad;
	Fri, 21 Feb 2025 18:44:11 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Liang Chen <cl@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v6 0/2] Add rk3576 pcie dts nodes
Date: Fri, 21 Feb 2025 18:43:55 +0800
Message-Id: <20250221104357.1514128-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxNHVZPQhlLGB9LQx9PGktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95281b96a803afkunmbca250ad
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Ggw5IzIIShkMCQw6GEIj
	Lj9PCxVVSlVKTE9LSkhPTU5IT0NJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTElNNwY+
DKIM-Signature:a=rsa-sha256;
	b=HT9z0/UERvinc9PmYjW0D0SzSA9ITQBv0zkT2adlyUV4vd/bJhX6cixa3U9sVXs5MRg3fCc7xAf8HKOs/jr6ArUgtsv0CQyPTaZEYfUropfK407CPzngO5ZQyL8Gobf+L2L90ZFRi8p0JsOX5wlcJvWseEHSgLEzvaCo5wuJeOc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=MT6Zk1Iwr6eslt5Pp/o6g6qSvge4hDtsWAuflUPzc98=;
	h=date:mime-version:subject:message-id:from;


The make dt_binding_check test has pass.
But I got error for make CHECK_DTBS=y as below
  DTC [C] arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dtb
  DTC [C] arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb
/home/kever/src/kernel-mainline/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pcie@2a200000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err', 'msi'] is too long
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
/home/kever/src/kernel-mainline/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: pcie@2a210000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err', 'msi'] is too long
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
  DTC [C] arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb
/home/kever/src/kernel-mainline/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb: pcie@2a200000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err', 'msi'] is too long
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
/home/kever/src/kernel-mainline/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb: pcie@2a210000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err', 'msi'] is too long
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
  DTC [C] arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb
/home/kever/src/kernel-mainline/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: pcie-ep@fe150000: interrupt-names: ['sys', 'pmc', 'msg', 'legacy', 'err', 'dma0', 'dma1', 'dma2', 'dma3'] is too long
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#

Could anyone told me why, the rk3568 has pass the test, but the rk3572
and rk3588 failed.
How can I debug the yaml check failure? Why the check rule does not go to
the if branch I defined for rk3572 and rk3588?


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

 .../bindings/pci/rockchip-dw-pcie-common.yaml |  59 ++++++++--
 .../bindings/pci/rockchip-dw-pcie.yaml        |   4 +-
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 109 ++++++++++++++++++
 3 files changed, 159 insertions(+), 13 deletions(-)

-- 
2.25.1



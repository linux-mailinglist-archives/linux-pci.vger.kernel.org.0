Return-Path: <linux-pci+bounces-43493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39CDCD4CEA
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BEA63007FF8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D8327798;
	Mon, 22 Dec 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfCgpAH8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F561A9F87;
	Mon, 22 Dec 2025 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766385745; cv=none; b=WYtbWEY2RaQN8ww9mP4LQqpZMHElozvnx49ySaOvVNfhioYUctpEGDWdOjxa01jSTk05TINdtCHvxEYmKdt0ytJohzKDrXAt13qHnnmUF9nBqtDrltD4FwMR8Vrf/ok7D7uDROy1yOxl3btWQ77mEKp3VM8zFLuB3WojweZ7nIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766385745; c=relaxed/simple;
	bh=j/mEMdNJlnAjwrnihLKGYdQ3OZVjJQVBvrLHExhr67I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMLvlfXhiXkGir6xbzFEA9hlhTfWpxBs+4fY+G2XmS0bDVcL9bRGyJy3l4RFHIBJ9IvQLNr7QJ7OHbmT5xkc+8PufsTU921CHRLpCw6O2hYWGHeBbHxsHCkklIopjOiX0gsSwe5e+YOSkN3SBfb372GpaIB4ofQDam/CJe0HgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfCgpAH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F7C4CEF1;
	Mon, 22 Dec 2025 06:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766385744;
	bh=j/mEMdNJlnAjwrnihLKGYdQ3OZVjJQVBvrLHExhr67I=;
	h=From:To:Cc:Subject:Date:From;
	b=IfCgpAH8IAGbJyxYrETz1YYvyP0FIGZ2lg+1Hgdv0Ez+FHajVjZm+RFALf/CXLELF
	 5iCRDuqdGAslhE9nnRKBi7sbPPgSCgkyzQnHBn//SPVwDWfAhELCMmE8bg9ZoNgT4v
	 Pu3M1al55TbDY4Pue0hhu0t05TeNAsvyQq6WH7Vns2MRFmW8tl1Uk9fY4TJR5eBJKI
	 EQPCg+Iuti6xOPdFWlWeUK8iCDSid4YajJOKe5ApYRcRm0X8ZJpsJVlxWwUnSgXLRa
	 kKwm+QYx0HqpS+ext8hPDO5gaqOsadYmu7/aYzPmcpjPzOeA8dG6EJmVAWnUNfrYYa
	 WdcohC/k6ZkZw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/6] PCI: dwc: Revert Link Up IRQ support
Date: Mon, 22 Dec 2025 07:42:07 +0100
Message-ID: <20251222064207.3246632-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3817; i=cassel@kernel.org; h=from:subject; bh=j/mEMdNJlnAjwrnihLKGYdQ3OZVjJQVBvrLHExhr67I=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI9Xtj/ZN8jXWwic1qlhM3JUqik+9IE8+OrHEI5VwbV7 dzfrlffUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIn8K2RkuDvz6PbDOq8Lj9/d nn3papF6/vUz8y79q6s5pP2b+YWCYQ8jw+XEkuTZV5cvXvl06fKjYs6zOO4tZj/5qGf3VlXvdUn sN1gA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Revert all patches related to pcie-designware Root Complex Link Up IRQ
support.

While this fake hotplugging was a nice idea, it has shown that this feature
does not handle PCIe switches correctly:
pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46

During the initial scan, PCI core doesn't see the switch and since the Root
Port is not hot plug capable, the secondary bus number gets assigned as the
subordinate bus number. This means, the PCI core assumes that only one bus
will appear behind the Root Port since the Root Port is not hot plug
capable.

This works perfectly fine for PCIe endpoints connected to the Root Port,
since they don't extend the bus. However, if a PCIe switch is connected,
then there is a problem when the downstream busses starts showing up and
the PCI core doesn't extend the subordinate bus number after initial scan
during boot.

The long term plan is to migrate this driver to the pwrctrl framework,
once it adds proper support for powering up and enumerating PCIe switches.


Changes since v1:
-Rebased against latest pci/controller/dwc
-Picked up tags.


Niklas Cassel (6):
  Revert "PCI: dw-rockchip: Don't wait for link since we can detect Link
    Up"
  Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up
    IRQ"
  Revert "PCI: qcom: Don't wait for link if we can detect Link Up"
  Revert "PCI: qcom: Enable MSI interrupts together with Link up if
    'Global IRQ' is supported"
  Revert "PCI: qcom: Enumerate endpoints based on Link up event in
    'global_irq' interrupt"
  Revert "PCI: dwc: Don't wait for link up if driver can detect Link Up
    event"

 .../pci/controller/dwc/pcie-designware-host.c | 10 +--
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 60 +-----------------
 drivers/pci/controller/dwc/pcie-qcom.c        | 63 +------------------
 4 files changed, 6 insertions(+), 128 deletions(-)


base-commit: cfd2fdfd0a8da2e5bbfdc4009b9c4b8bf164c937
-- 
2.52.0



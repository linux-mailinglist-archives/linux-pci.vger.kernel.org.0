Return-Path: <linux-pci+bounces-40871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C29C4D39E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 11:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AAB18C11AB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C94350D79;
	Tue, 11 Nov 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5WyiygA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CF350D6A;
	Tue, 11 Nov 2025 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858272; cv=none; b=hQDg1IGR9ZLaSr+tvWUF5VGikRKy+ESH5qmpOFaOCoSPcz7XJx4DNXBjGA0iNpf6DYINCVK2NxGDlyQR4orPFrN0WH6Ym9NOWfSjm0rjM/8CY1Jv7y+pPey1qJSnmolBVtvBo8bwU+6HzRrU67JqDo7jSWYZzQOMSxyqWXaBQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858272; c=relaxed/simple;
	bh=yF3LwFR3UteEXs0R1GhkOZ+SlpXP1QamBYPNI3i0IcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+GMEAfUos9UaofYskrgbzHHnSmASRXCuzxWp/nFTs+FEyHdTr++78Jr9Lrtp5zLDJx85w3EnTHZOQXfGBQhM0gfvTq10Q/FHFZ+CgpF7/lDtJGqEzPVjXXtFd2k29BONXVWvSr/xRnWbzp3OMqQcwFbwW0Zx/P2kIYjk95JK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5WyiygA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA5EC2BCB0;
	Tue, 11 Nov 2025 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858271;
	bh=yF3LwFR3UteEXs0R1GhkOZ+SlpXP1QamBYPNI3i0IcY=;
	h=From:To:Cc:Subject:Date:From;
	b=A5WyiygAjAvJsU+uxfKwX/RBa16Igu09c3rbMJfzahbCwEl89D0RLqRW0Na82P3d3
	 pciqRPjjNCIyg7sqzS1B3OxheyAG9SZjDdYtH5R6A+7lyDKfp0k+1VBXKG6Ci1H8CM
	 iR6GMlGJF1AG5fqI8FXC+nPqCHDadsVME5n3SgSIjdxztnm3i0XIXPHlisBLlm+Xz+
	 Wm/Phe8uSOctrR+TFCkjnym6X6NXvhaQmggdgiGiBlnH9Do8t1YJ7sDyPHX0iipRFB
	 pWVbB39nFRyptmH2i0gahPDrI5xgkf+iJV9oulaua/dkgcNdEW5sEIBG2gk7lXbNX9
	 S4JUCEF+ph2tw==
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
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Date: Tue, 11 Nov 2025 11:51:00 +0100
Message-ID: <20251111105100.869997-8-cassel@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3673; i=cassel@kernel.org; h=from:subject; bh=yF3LwFR3UteEXs0R1GhkOZ+SlpXP1QamBYPNI3i0IcY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKFRUUm7tLPDVxjMnfplsCDqi8v+cpmZL4s4F1+Up1bR fNI5xuLjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzk2GZGho6JxU2nNjPkHE/6 FPbf8T+/4/maGFkF3uk24T5M+bftHRj+Fwn1Oj5hZ2+NPrymbnNI+Z3iEpkw1p+FdrM33ozaf6K XEwA=
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

-- 
2.51.1



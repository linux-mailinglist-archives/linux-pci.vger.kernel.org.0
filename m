Return-Path: <linux-pci+bounces-18017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536049EAD3B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F982886EB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21213B59E;
	Tue, 10 Dec 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC+g9xfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464A23DEB3;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824555; cv=none; b=ApijAFsDQgT/YEM8FUY8fUnusw0TAjw1z8qkC9i7KLK7NxUMrRCCGYVETqs7G+Ij5BBXBDUuc7dpLbff/ax4DnIEgsrS9Xtuu4bD7J3Uc59SzQTUndlYlZxn+2UIey+WwPeGS3w5tE6XgZNrrC2iya6z41oP5w10LPMJB7lM//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824555; c=relaxed/simple;
	bh=+l6+PgCSsvhi/o5m5hkIbcumue3jqzFt3YigC1EsKH8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fcd986zN02W+8hmx5DgF8Lv29F+mR2toNrqgju4VLkPBmAQjLw70fnfsaw9ih0/+geiLGlw7mRS7zvMlPVBY+9TOAqq/YazWGGigJmNCu2/Jkcqd03dcQy+23hF/NOvM5hFOaE8aSMmhWXykRSQwl0CqVSn/PWs5UPObUxSRcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC+g9xfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F23C4CED6;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733824555;
	bh=+l6+PgCSsvhi/o5m5hkIbcumue3jqzFt3YigC1EsKH8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MC+g9xfIa/vfC5Johpv/CHpfwOPUN8V4JCPTV8aMPQz3EMsEJN+O5gXi5blrsf7dZ
	 0B9e3DuM67uhWGfS053qp6sFTPOVeEWuNp7LPbj2/zl1RSZ2kLusqjdlrDnsfJmzSO
	 JJQX+lM3WgkQdSoCl2l4ie7BpiGsbzmQHCU0TRRKX08UkPU5Wo9r7EmsW35dqtx8xY
	 F+wEwjtOmE/SbL0RYpClLxJNycb36AWpdYl2CmTKaWvcdYg/QjVyT1iFWsr3BYVKcu
	 NZUCRoOMtAolAJFmpk3hizZk/+pjF8fZnGVjMchvbUtXWNZTQ3Q+3ydVKWjR8HEDtO
	 B1WGEQLwgAjSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DEDE77181;
	Tue, 10 Dec 2024 09:55:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH 0/4] PCI/pwrctrl: Rework pwrctrl driver integration and add
 driver for PCI slot
Date: Tue, 10 Dec 2024 15:25:23 +0530
Message-Id: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsQWGcC/x3MwQpAQBCA4VfRnE3tDlFeRQ4as0yJbVYoeXeb4
 3f4/weSmEqCrnjA5NSk+5bhywJ4GbdZUKdsIEe1J+8wsmK8jA9bMa37gY7YCTeVbylAzqJJ0Pt
 f9sP7fgk5qKRiAAAA
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukas Wunner <lukas@wunner.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2923;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+l6+PgCSsvhi/o5m5hkIbcumue3jqzFt3YigC1EsKH8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnWBAjLpiuUdDrkByW3wrJIXuZYkU8mJgsiJzhU
 moZyrwXFKmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ1gQIwAKCRBVnxHm/pHO
 9eJVCACgiwSSquLOVEVQYPD4+QUxVEWIGX3jVgoeLnDkOqrNl+SEPzdULv2NRW205l0ezlh5x4R
 pa7c+K9LqxvlqnOGsuW/930KDR6j5UZN36pS+cVirgomWjlKWX7s+ngGk9/EFKw9Y6FAXDmqsZ7
 roQAqJvCSIBdwLbIp8d8NSH/xI+PsgTKzzsUT5dFQQK5ci4OcZGE8AZURjBaEcr7YvCSo+T81KC
 CD8zB7PZWrb2092TfjUSKlGTCKjYN0uBVOdGXNqm5B6Q0YJ06ltNKYpRlb1Tr3rnswCjwIbfILF
 QBypsKmxk5/6mEHiHqCCc2rrIFotOkO4+7c+S+QdbIrnVGmq
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series reworks the PCI pwrctrl integration (again) by moving the creation
and removal of pwrctrl devices to pci_scan_device() and pci_destroy_dev() APIs.
This is based on the suggestion provided by Lukas Wunner [1][2]. With this
change, it is now possible to create pwrctrl devices for PCI bridges as well.
This is required to control the power state of the PCI slots in a system. Since
the PCI slots are not explicitly defined in devicetree, the agreement is to
define the supplies for PCI slots in PCI bridge nodes itself [3].

Based on this, a pwrctrl driver to control the supplies of PCI slots are also
added in patch 4. With this driver, it is now possible to control the voltage
regulators powering the PCI slots defined in PCI bridge nodes as below:

```
pcie@0 {
	compatible "pciclass,0604"
	...

	vpcie12v-supply = <&vpcie12v_reg>;
	vpcie3v3-supply = <&vpcie3v3_reg>;
	vpcie3v3aux-supply = <&vpcie3v3aux_reg>;
};
```

To make use of this driver, the PCI bridge DT node should also have the
compatible "pciclass,0604". But adding this compatible triggers the following
checkpatch warning:

WARNING: DT compatible string vendor "pciclass" appears un-documented --
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml

For fixing it, I added patch 3. But due to some reason, checkpatch is not
picking the 'pciclass' vendor prefix alone, and requires adding the full
compatible 'pciclass,0604' in the vendor-prefixes list. Since my perl skills are
not great, I'm leaving it in the hands of Rob to fix the checkpatch script.

[1] https://lore.kernel.org/linux-pci/Z0yLDBMAsh0yKWf2@wunner.de
[2] https://lore.kernel.org/linux-pci/Z0xAdQ2ozspEnV5g@wunner.de
[3] https://github.com/devicetree-org/dt-schema/issues/145

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (4):
      PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()
      PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()
      dt-bindings: vendor-prefixes: Document the 'pciclass' prefix
      PCI/pwrctrl: Add pwrctrl driver for PCI Slots

 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +-
 drivers/pci/bus.c                                  | 43 ----------
 drivers/pci/probe.c                                | 34 ++++++++
 drivers/pci/pwrctrl/Kconfig                        | 11 +++
 drivers/pci/pwrctrl/Makefile                       |  3 +
 drivers/pci/pwrctrl/core.c                         |  2 +-
 drivers/pci/pwrctrl/slot.c                         | 93 ++++++++++++++++++++++
 drivers/pci/remove.c                               |  2 +-
 8 files changed, 144 insertions(+), 46 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241210-pci-pwrctrl-slot-02c0ec63172f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>




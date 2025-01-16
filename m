Return-Path: <linux-pci+bounces-19966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA2A13BCE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CCF1882466
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841F22B8C0;
	Thu, 16 Jan 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoKgPhtQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BEE22B8A0;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036560; cv=none; b=CBSFQDjVTGADRaiGu2F0FUkVocQfK5QPGWaNN3lEbZef550t0V9uT44P6QMfzEEk7kFjpFIrc2BqYehVSAJoWbshAwiEQ+HLgF8vJenRo13ddOvT6KQyJPXaI9HBOhOQCUUKGNQkEUYy0v+p52vAu/QH3v/OdPL5GUBodLE8HuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036560; c=relaxed/simple;
	bh=d32Y8ya8jL+ULXXbLr4QB/QI6XLp7Oo0AcqFQN1IDQw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oL+ienSkp2fnUOtStAIBIxG8PXkhbVqtpq66GWd7082F/3Uq4xFM0uGvMphsL695UHT+en7Lhqzry6M7PmNyvbB/CJ7QfjoHOGSYs8VYGOeMeDbAG9C559007NLod34N5DmccVNTjoul/7I8MZldxA847RVN3//F1UFJ35oHcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoKgPhtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 793CCC4CED6;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737036559;
	bh=d32Y8ya8jL+ULXXbLr4QB/QI6XLp7Oo0AcqFQN1IDQw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aoKgPhtQAcJq/C5L121gyCDVgQqboGFbXDPTBvv0WHAkNFErIV4+tXK5IYzdG2VzF
	 mJQqQQSdO9NtGNAn187f4T7NLDqXjUu2T4FMuQ+vVF5tXgdA728D0BfPyGQcsx9XYd
	 feFwqqQ3T5ydsc2aPhu9Vhuawp1K6ROCR/daaT2YFTyvVwFO6M7c7cixbMA+beosMS
	 loXSWlgdHr3gtYKfkunDLH3+dUAUWtBoeThK2MYsbFfLN3KxipE8ZnJB5cxqzJa+lY
	 wK+jE+eHIbbG19RI6pJCh5lBXddMdJgZyAxAy6ua8ONgR8JcqzEf63Liea7B8hKJig
	 n9f4o5WyA7esQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD7C02187;
	Thu, 16 Jan 2025 14:09:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v3 0/5] PCI/pwrctrl: Rework pwrctrl driver integration and
 add driver for PCI slot
Date: Thu, 16 Jan 2025 19:39:10 +0530
Message-Id: <20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAYTiWcC/32NQQ6CMBBFr0Jm7ZhpqUpccQ/DoqkDTEIomZKqI
 dzdygFcvpf89zdIrMIJ7tUGylmSxLlAfaogjH4eGOVZGCxZZ6whXILg8tKw6oRpiiuSDcThWpu
 b7aHMFuVe3kfy0RUeJa1RP8dDNj/7J5YNErJnd2HXNOSonWT2Gs9RB+j2ff8CtdsNkrEAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukas Wunner <lukas@wunner.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3486;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=d32Y8ya8jL+ULXXbLr4QB/QI6XLp7Oo0AcqFQN1IDQw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBniRML9/YkDU3ck+xoWOFje58AxDDajMHV6pMrD
 Jvob5t/DNaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ4kTCwAKCRBVnxHm/pHO
 9WFLB/43+VASUO9CgoplbEcO9UQM06la6OubEUHjeuwMQrmK8fJO1mrPtr7adDeHPkmWv1ri6Oj
 4Qk/34QC1sVj0PHLFiQttDyyhr2InEdT8sfUS9opkurbNMNnmTW9GoeFHfzc9MT+zLFywbi3i5l
 dw5VxBLsYTkHwg65Xj4hTW+j6XRXhwP7prXomRwvnSYHo2bDmTFZIDPl8w7e7rA0E9okCuYRRHA
 fZ2UODNyHnUECFpp5YePR/Ylxi8NdHsd5q9heHfHxNWKVjrt1A8aZZ22ghB2qP5qGDqRNVsqJ9b
 OVgmNt7S57PqB/cgPgQ4b9ril0eVCTwpmCRJ+x4Wkjp2iPyX
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
Changes in v3:
- Fixed the Kbuild bot issue with a regulator patch and submitted it separately
  along with one more regulator patch from this series. Both patches got merged
  and are in linux-next.
- Collected tags

Changes in v2:
- Added new patch to skip the device scan if pwrctrl device is found
- Added a new patch to fix the build issue
- Collected tags
- Link to v1: https://lore.kernel.org/r/20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org

---
Manivannan Sadhasivam (5):
      PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()
      PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()
      PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created
      dt-bindings: vendor-prefixes: Document the 'pciclass' prefix
      PCI/pwrctrl: Add pwrctrl driver for PCI Slots

 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +-
 drivers/pci/bus.c                                  | 43 ----------
 drivers/pci/probe.c                                | 41 ++++++++++
 drivers/pci/pwrctrl/Kconfig                        | 11 +++
 drivers/pci/pwrctrl/Makefile                       |  3 +
 drivers/pci/pwrctrl/core.c                         |  2 +-
 drivers/pci/pwrctrl/slot.c                         | 93 ++++++++++++++++++++++
 drivers/pci/remove.c                               |  2 +-
 8 files changed, 151 insertions(+), 46 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241210-pci-pwrctrl-slot-02c0ec63172f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>




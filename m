Return-Path: <linux-pci+bounces-24511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C98D9A6D801
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 11:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964497A5588
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421725DAF0;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dguEe5Yl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5622339;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810678; cv=none; b=DuPXuUcX+wH9i3tyG8wg9gdnIE5fWSEMcB6uD7JABm+yNWjh6PkepBH8ndMqIWzbu4J4NtCCL75qPJsgFNBM0YgeYtEGcK91/CmPPl0HdJcma0/W0hLFk6JxxksrrvUW4YrHbCyapK6D4wGCw/f74gH8ep6WZEgH5RV7hmN8krc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810678; c=relaxed/simple;
	bh=2YzndqjPYZtO24UsGSXBDXw/XTK3KIe4lsm6degtopA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ngqAGJ1krE1rP/9nc2aXuS4xNX3LViQnPSkv/pkGxz2+pcxrQGfmeAPVOIlERAt1mR1R0eWyNnx6YPqrS50lBzsMyyoEXW/RNzLoPF0G0dVeCujk0if/SpM3Q9gcbDeY+QNcCTMfZxRbKyKvprglxwO+rEJD0WEwQMewADtKCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dguEe5Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11AACC4CEDD;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742810678;
	bh=2YzndqjPYZtO24UsGSXBDXw/XTK3KIe4lsm6degtopA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dguEe5YllTNdyFnOJoOjvAf4aG3VWVmUTsFzAPx9Xziw8PeHEDbpIUttRhuwx7n/G
	 kBWA7qodpZjxN4mQDxwDr0hzDKF3POwYtyEtBSKYs8364IvzUqP7pzUP0+1iLEl+CX
	 bhT7TTYf1Fqd2v7rp9T7jFm+DNimuJr/BmImp2AWBFnfp/q13cZZHfF2oHUReo3Z49
	 uVkiVEcCwY/ClmiqJrf6Oqv2hE9SCT5DtQswzyDAl0njlhJcE1uJG2c5Rnj2WtNcR9
	 prMNCjEWKqmY3IAXRtsAlNrKnmKlWDm6nqTBkL9VCYAy7LsqmjFjQBKMjKahCo87l9
	 nYzk8yw4+PFtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E8C36002;
	Mon, 24 Mar 2025 10:04:37 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v2 0/3] PCI: Add PTM sysfs support
Date: Mon, 24 Mar 2025 15:34:34 +0530
Message-Id: <20250324-pcie-ptm-v2-0-c7d8c3644b4a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADIu4WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMT3YLkzFTdgpJc3VRz0yTLJKO0tOS0JCWg8oKi1LTMCrBR0bG1tQA
 JftiHWgAAAA==
X-Change-ID: 20250324-pcie-ptm-e75b9b2ffcfb
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3419;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=2YzndqjPYZtO24UsGSXBDXw/XTK3KIe4lsm6degtopA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn4S4zvOHOf5c9xVh0GG6JM1Q9A3czgGvOAcZbH
 S1Ll0Aw/ayJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ+EuMwAKCRBVnxHm/pHO
 9cwzB/9uiEOi3CSoNq8pYCiP8oeJJZE5yK15c3WbCVKN52oQujU/KsAh4Aqw0g15hasr5dOkz1j
 DlAaorGqvHxOj7EB4acC4GNGPyHQv13RijpGfEUhWhLDYJsBA/Dps25pZKO/VAbwC83VzseWeuU
 F9+psruO5YtMS5H20UbDTv1nGOjghyXZHW4U++7NnXOSleWZHUiGCX4hF+AICSoQ0GDmVwqufhE
 gZajFxJ4RtrRAf8gTqI4KWKVRx443jYZpVS7ROm+HiBpMSOd1deS2ASGWujXkKrzuDXBE5mPeNg
 /1IqpLwe7+8cTpqWRVVZj4CPQ+8cTQIlhxAvy2SoqQPqHRNw
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series adds sysfs support to expose the PTM context available in the
capable PCIe controllers. Support for enabling PTM in the requester/responder is
already available in drivers/pci/pcie/ptm.c and this series expands that file to
add sysfs support for the PTM context info.

The controller drivers are expected to call pcie_ptm_create_sysfs() with
'pcie_ptm_ops' callbacks populated to create the sysfs entries and call
pcie_ptm_destroy_sysfs() to destroy them.

Patch 1 adds the necessary code in the drivers/pci/pcie/ptm.c to expose PTM
context over sysfs and patch 2 adds PTM support in the DWC drivers (host and
endpoint). Finally, patch 3 masks the PTM_UPDATING interrupt in the pcie-qcom-ep
driver to avoid processing the interrupt for each PTM context update.

Testing
=======

This series is tested on Qcom SA8775p Ride Mx platform where one SA8775p acts as
RC and another as EP with following instructions:

RC
--

$ echo 1 > /sys/devices/platform/1c10000.pcie/ptm/context_valid

EP
--

$ echo auto > /sys/devices/platform/1c10000.pcie-ep/ptm/context_update

$ cat /sys/devices/platform/1c10000.pcie-ep/ptm/local_clock
159612570424

$ cat /sys/devices/platform/1c10000.pcie-ep/ptm/master_clock
159609466232

$ cat /sys/devices/platform/1c10000.pcie-ep/ptm/t1
159609466112

$ cat /sys/devices/platform/1c10000.pcie-ep/ptm/t4
159609466518

NOTE: To make use of the PTM feature, the host PCIe client driver has to call
'pci_enable_ptm()' API during probe. This series was tested with enabling PTM in
the MHI host driver with a local change (which will be upstreamed later).
Technically, PTM could also be enabled in the pci_endpoint_test driver, but I
didn't add the change as I'm not sure we'd want to add random PCIe features in
the test driver without corresponding code in pci-epf-test driver.

Changes in v2:

* Dropped the VSEC changes that got merged
* Moved the PTM sysfs code from drivers/pci/controller/dwc to
  drivers/pci/pcie/ptm to make it generic so that other controller drivers could
  also benefit from it.
* Rebased on top of pci/controller/dwc

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (3):
      PCI: Add sysfs support for exposing PTM context
      PCI: dwc: Add sysfs support for PTM context
      PCI: qcom-ep: Mask PTM_UPDATING interrupt

 Documentation/ABI/testing/sysfs-platform-pcie-ptm  |  70 ++++++
 MAINTAINERS                                        |   1 +
 drivers/pci/controller/dwc/Makefile                |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   3 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |   3 +
 drivers/pci/controller/dwc/pcie-designware-sysfs.c | 254 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c       |   6 +
 drivers/pci/controller/dwc/pcie-designware.h       |  21 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   8 +
 drivers/pci/pcie/ptm.c                             | 268 +++++++++++++++++++++
 include/linux/pci.h                                |  35 +++
 include/linux/pcie-dwc.h                           |   8 +
 12 files changed, 678 insertions(+), 1 deletion(-)
---
base-commit: 1f5a69f1b3132054d8d82b8d7546d0af6a2ed4f6
change-id: 20250324-pcie-ptm-e75b9b2ffcfb

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>




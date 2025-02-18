Return-Path: <linux-pci+bounces-21737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BB6A3A034
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E93B5F9D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD126B0A1;
	Tue, 18 Feb 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV/8NlDs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7326AA8E;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889418; cv=none; b=mT+rSeu92gUKckW3q+xfAmH9l8tllsHgL9BLNLVLgZE9rMxEex9dlic2G2T9GEMWGVPHZ4yBbaSTQUjFy/Ii9Iv0+ppqyr5jS+w3DkZ1KwwOEiletLsAZZ3eF0EUn+gLilOAex8+LELH0jPx5yNR/Lfea1/Q6nuLcLVuJgFTMME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889418; c=relaxed/simple;
	bh=JomdOoiQ17paEXI4f+PdfOHyWq+hd8mMOpVRmJpqAqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=noTEc3doFWRXmtJVdeOP7erVyZuhuUmOdHF2XZkHUadgfnkHDGNW30JCtllHvSXRwECGx5bL72EawBi8pUpf9NiPIh9yoh4TFeEk9oeqnL7tfboMmaGARDiaNNNIeWJ+IFu3/HY7INbVCTxB9dNq6R5Kl/Xa9dha8X0uSkzX4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV/8NlDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E999C4CEE2;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889418;
	bh=JomdOoiQ17paEXI4f+PdfOHyWq+hd8mMOpVRmJpqAqk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sV/8NlDsG7hDLXzrOchAa5HKlL/GKdnU0iXRBEPJx8HHjUTaYZ8JLaKeJErQhYOIM
	 aEC/K9YsvKPpdJ8iRdfF9JB6N1nvt2X1/nL1NGhf0scDmwE9gzLpndVSzMzltxYg2u
	 hZunI9y3hzXLIydeUEB+qLcmY73ZNIB+z1FuMWjgiCPd7OTk+rL7PkFQrtXGbUCGZ8
	 xXBc73fXVz4ESqEwjrA3y8b+CHDs2TY02RAMewvI4J0oMtMRSI6ptRAj0/dQVDggRI
	 81+poiRg1OQ8bM1QrjAeR7fR01yHoAXEJqFHUhH7oTccuBsEdgHaRPX6yFTOwDMs06
	 1HkDEyghT1OHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186FDC02198;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH 0/4] PCI: dwc: Add PTM sysfs support
Date: Tue, 18 Feb 2025 20:06:39 +0530
Message-Id: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPeatGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ML3YLkzFTdwuT8XN2CklzdpDQzS1OjNNNkk1RTJaCegqLUtMwKsHn
 RsbW1ADxCJLNfAAAA
To: Shuai Xue <xueshuai@linux.alibaba.com>, 
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3647;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=JomdOoiQ17paEXI4f+PdfOHyWq+hd8mMOpVRmJpqAqk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBntJsCRFv6m9eazV1uDz0AhPMpFELd3Ewc3zgXo
 +fhwihHEpuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ7SbAgAKCRBVnxHm/pHO
 9bJICACZnuPkpD/+2MJa10YW7L52k2KZ9u9IjOvhXxIj2mVM8PULlDt3iUY4gLBw7c+1SWVf0r/
 x22opFo0IspCHMj11sYpyfq5huuUizvadSYKa5mS9wr4EWwHP9m32Q0yRVvc1R0u+Z9Iks9mDTy
 5lCWYYs5SRez6erms0QnXTbV6lYimtHrkqy7B3qcUURXDOsBsDGzAVJRnKG/S2vXp28U06zMHlI
 4BK4kWsWvl1i8ai4bkGEYOKvaicCm2aXZ1yuwb+7TYyDZNZd2WII4jFA4D/F2zlwpg8p0pYJaXZ
 N1Yu5D/wUOytbANzHVEmTmCyFWJMVtLaLjz7MmEVEh3Nkc36
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series adds sysfs support for PCIe PTM in Synopsys Designware IPs.

First patch moves the common DWC struct definitions (dwc_pcie_vsec_id) to
include/pci/pcie-dwc.h from dwc-pcie-pmu driver. This allows reusing the same
definitions in pcie-designware-sysfs driver introduced in this series and also
in the debugfs series by Shradha [1].

Second patch adds support for searching the Vendor Specific Extended Capability
(VSEC) in the pcie-designware driver. This patch was originally based on
Shradha's patch [2], but modified to accept 'struct dwc_pcie_vsec_id' to avoid
iterating through the vsec_ids in the driver.

Third patch adds the actual sysfs support for PTM in a new file
pcie-designware-sysfs.c built along with pcie-designware.c.

Finally, fourth patch masks the PTM_UPDATING interrupt in the pcie-qcom-ep
driver to avoid processing the interrupt for each PTM context update.

Testing
=======

This series is tested on Qcom SA8775p Ride Mx platform where one SA8775p acts as
RC and another as EP with following instructions:

RC
--

$ echo 1 > /sys/devices/platform/1c10000.pcie/dwc/ptm/ptm_context_valid

EP
--

$ echo auto > /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_context_update

$ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_local_clock
159612570424

$ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_master_clock
159609466232

$ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_t1
159609466112

$ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_t4
159609466518

NOTE: To make use of the PTM feature, the host PCIe client driver has to call
'pci_enable_ptm()' API during probe. This series was tested with enabling PTM in
the MHI host driver with a local change (which will be upstreamed later).
Technically, PTM could also be enabled in the pci_endpoint_test driver, but I
didn't add the change as I'm not sure we'd want to add random PCIe features in
the test driver without corresponding code in pci-epf-test driver.

Merging Strategy
================

I'd like to have an ACK from the perf maintainers to take the whole series
through PCI tree.

[1] https://lore.kernel.org/linux-pci/20250214105007.97582-1-shradha.t@samsung.com
[2] https://lore.kernel.org/linux-pci/20250214105007.97582-2-shradha.t@samsung.com

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (4):
      perf/dwc_pcie: Move common DWC struct definitions to 'pcie-dwc.h'
      PCI: dwc: Add helper to find the Vendor Specific Extended Capability (VSEC)
      PCI: dwc: Add sysfs support for PTM
      PCI: qcom-ep: Mask PTM_UPDATING interrupt

 Documentation/ABI/testing/sysfs-platform-dwc-pcie  |  70 ++++++
 MAINTAINERS                                        |   2 +
 drivers/pci/controller/dwc/Makefile                |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   3 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware-sysfs.c | 278 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c       |  46 ++++
 drivers/pci/controller/dwc/pcie-designware.h       |  22 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   8 +
 drivers/perf/dwc_pcie_pmu.c                        |  23 +-
 include/linux/pcie-dwc.h                           |  42 ++++
 11 files changed, 478 insertions(+), 22 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250218-pcie-qcom-ptm-bf6952f5c4e5

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>




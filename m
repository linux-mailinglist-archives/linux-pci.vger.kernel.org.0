Return-Path: <linux-pci+bounces-11785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D97955595
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 07:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC1284FBD
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 05:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433212DD8A;
	Sat, 17 Aug 2024 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcOiw5D1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3194B12CDAE;
	Sat, 17 Aug 2024 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723873150; cv=none; b=BPwbONsNs1zP2WQRZf44mYJu7TFf3JSb/hX7Gkb1lHuEQ5bzLqy3SYEyCsVAudBK7FfkMyvoZSMBzo/El4Q4qJP0rQd2BEn8nVVIruipjp8JzscBt6lYyfCfU9vHwJ2k76ENX4UQhVmjNwnY+1wsb0xvVW3zQS87BlKqDaGzp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723873150; c=relaxed/simple;
	bh=yf9FdTdpAmRzTboazqCuWYiQmHn0VcsXn9pYUoXpsI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldyhZe/WfR4wOjSkBfxXyGx7sMlkvEPwDAhNrHDgq36mEUa7qXDmgoh5k+v1SmCksSUTWlDXxxk+trhgNtauAjmuZJGIAfmeWr+nxwaUYtZeDPRRwAx2bLsOp5YNAyz/yHtSoiF0IXyu050ANP846aLst2+bp/kgtBzKZhuy+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcOiw5D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EED45C4AF0D;
	Sat, 17 Aug 2024 05:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723873150;
	bh=yf9FdTdpAmRzTboazqCuWYiQmHn0VcsXn9pYUoXpsI0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pcOiw5D1oaq3hZEfD5Kuf0RDeUIKxlNtVarcdO7vzsoi6BlH3tqaOppmFKdWfanP5
	 5P4Cq+HuzOws5NyNWdlmpm1MqK7VLrl3bejNaT12aKn+n2YulBiYjvTsTG9kK5BepB
	 cFcTCbmzMVfIuFyyWOLJRYOW8lFSFu1XuYDBonERYhOeHyPv3XvU/9txszYg5wcxPp
	 1dJfckEs00Z48hl4Hfqt0TyrdbkhOF1hr55pgCtSsJXmpHzmYo7sV7zt9Y/MTlU2E2
	 AysESoT5KfvLf1EJOrpIoN06MyK2RbCMD2M58P06SwDUJMYsaLqk34VGMkfjoyQpYY
	 w6CsQFozsZJiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC97C531DC;
	Sat, 17 Aug 2024 05:39:08 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Sat, 17 Aug 2024 11:09:03 +0530
Subject: [PATCH 1/2] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-pci-qcom-ep-cleanup-v1-1-d6b958226559@linaro.org>
References: <20240817-pci-qcom-ep-cleanup-v1-0-d6b958226559@linaro.org>
In-Reply-To: <20240817-pci-qcom-ep-cleanup-v1-0-d6b958226559@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=nvYCXsJUQRNDkqxK/5DBlZ4jMTQnZ2mxPzwj87Woaa0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmwDd5ePjMmYbGHoJRMqAkEyHBuWUKDeDATP5+w
 WMHgGtevCiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZsA3eQAKCRBVnxHm/pHO
 9VOpB/91/N2nyY5n8uTAftgnS5juJq4oggVmjQnDI7XsNORmjlPDF1LLdGkbQc6QHqmfzVfgK7d
 JwBIW3vZ6eWm38vHFHTRmqgMieA6jOvjtIduaxVFm3PxWv0tieA9vR38EUyZ5qv7kSPZGcbopFK
 oVtiXHA8Kn0dl7zlwnPWgyk6AoKmuUaQJYL3jD67d5pJYFJ68SdHEQEOpCZH4GkeYG2cscEH9a2
 0StE0TzFf/8dIfynpqqANOz9U5aBCncRZyUCrRUxUjgW+iYIxgxv8vbsHb3OB8NZtpa+crsDEIH
 Ik5Wmxww9YynsitHpa3IUXiD9/Q3/EkWszY58pz7zXpQWxF1
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
deinit notify function pci_epc_deinit_notify() are called during the
execution of qcom_pcie_perst_assert() i.e., when the host has asserted
PERST#. But quickly after this step, refclk will also be disabled by the
host.

All of the Qcom endpoint SoCs supported as of now depend on the refclk from
the host for keeping the controller operational. Due to this limitation,
any access to the hardware registers in the absence of refclk will result
in a whole endpoint crash. Unfortunately, most of the controller cleanups
require accessing the hardware registers (like eDMA cleanup performed in
dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
functions are currently causing the crash in the endpoint SoC once host
asserts PERST#.

One way to address this issue is by generating the refclk in the endpoint
itself and not depending on the host. But that is not always possible as
some of the endpoint designs do require the endpoint to consume refclk from
the host (as I was told by the Qcom engineers).

So let's fix this crash by moving the controller cleanups to the start of
the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
called whenever the host has deasserted PERST# and it is guaranteed that
the refclk would be active at this point. So at the start of this function
(after enabling resources), the controller cleanup can be performed. Once
finished, rest of the code execution for PERST# deassert can continue as
usual.

Fixes: 473b2cf9c4d1 ("PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers")
Fixes: 570d7715eed8 ("PCI: dwc: ep: Introduce dw_pcie_ep_cleanup() API for drivers supporting PERST#")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..5d31285685b6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -389,6 +389,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		return ret;
 	}
 
+	/* Perform cleanup that requires refclk */
+	pci_epc_deinit_notify(pci->ep.epc);
+	dw_pcie_ep_cleanup(&pci->ep);
+
 	/* Assert WAKE# to RC to indicate device is ready */
 	gpiod_set_value_cansleep(pcie_ep->wake, 1);
 	usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
@@ -522,8 +526,6 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
 
-	pci_epc_deinit_notify(pci->ep.epc);
-	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
 }

-- 
2.25.1




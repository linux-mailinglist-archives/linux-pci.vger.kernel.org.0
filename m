Return-Path: <linux-pci+bounces-34674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315EB3491F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 19:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F8D7AC3F3
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D275A308F38;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ5BPOJQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936BA304BBD;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143890; cv=none; b=ugkT81zo1yuf1q8vYPHpwmm4xWl2QAiUEeu9ISsM0IlM//9uzyK5UHnAri+o3+5Cs6L4q+nE47dzQwpzsJRVkvZ2kViE2sw3bHC7peKqmVbRjd0Z9jdWL2B2EgXDJlH2EyHTr12+RjNdk3mpfPEX9481ckYIeNY8pNigvnw9/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143890; c=relaxed/simple;
	bh=/VL/puEcwU9JE6/bvQ6RKj2xqu8KqDM0xfb43tkQD9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O35VSojKfohnDxY+cp3RcFYiR7UPr0rSkygtXAS3aJX5+GidRzGhEUizROYZ+hPZ7otPXs5cajO9/XX7TZ+vvtnRConxeCEbQcmkacv7FtqRNghdIf0AxjoUmlBThhqibSfs+CFZMiPIBSeqlyXXxzkFx9fQm6T8+DNSL2WRsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ5BPOJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 506D3C19422;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143890;
	bh=/VL/puEcwU9JE6/bvQ6RKj2xqu8KqDM0xfb43tkQD9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lZ5BPOJQc4SY0eMAd0OTFWvBRepMDTEO+CWEtcEhXckc98ik6kHU1q/wokjGnbQN/
	 rILsujRc8cREJcoS08NbJ3zMeFKXyq0AtHAmE7cUo7upemiZkxIbCP+GKKXVcZ7Xxh
	 XIXt8Z50W5bumJUKM/kj/jZD1xPyNfwiRjjLg4ZA3WqDG60TebCZYMI2Q/wffQxwTC
	 Lc1nDtkTb1/2GzW+XuwumDFe5NL22u8Eni+R6HuWcIjd5rrtPuHabZfw9hskriibYa
	 aS02jW58X8jhxchWsUEiEtct5LH/GiMa0dEMVmgIUT2xpuwWUvTGbNP9fv9+Z5vsWM
	 mkKVyaSPko6mA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47984CA0FE8;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 25 Aug 2025 23:14:39 +0530
Subject: [PATCH v2 4/8] PCI/ASPM: Improve the kernel-doc for
 pci_disable_link_state*() APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-ath-aspm-fix-v2-4-61b2f2db7d89@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
In-Reply-To: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
 ath10k@lists.infradead.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Tfz/vnVvMAdBE04yo1wOWEyY0vLu4AnSJ/u3erLU3u0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorKEPSRZmDz2JU+1YrKPan8RUFHp8+J+c+0yFz
 pCiZnYzQ+KJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKyhDwAKCRBVnxHm/pHO
 9Q0zB/90j6LoYGJLsGfXcFdL1JD6pFL/6/W6X/cf9fNO+v2sWTL78ffGUtwe7stNZfUljUo1neF
 FDjmXwhJzoYiJWjDhYxrusOSLBNu7xgvLUtOP79yXhHK8PuJPz8xO2tnjGmWYIaSoCyrcWy3Nrn
 paqoC+BEneBcCDTBQC7IaNbIkhDpj0X7+Nr9eCr9tFIm0pbg0ZPTApS2sX1C2YCcVUJYc9KsjD/
 80y9wlwfTHK5RTkEOap1Cc37/BChZcfosDtlMkFdeKxu/sBU1Oq+yuiyfij6hNXKjh6PZvtlkzw
 EcEWa4XsUO6a1YePFDMJnD3+aa2Mb9+elsGN7+ZCei0IViEA
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add kernel-doc for pci_disable_link_state_locked() API and fix the
kernel-doc for pci_disable_link_state() API.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1243715bc054f859af175143a7ffaef0971f097a..3c8101023e80d3c0550136f729782c0e0a3e28cf 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1415,6 +1415,17 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 	return 0;
 }
 
+/**
+ * pci_disable_link_state_locked - Disable device's link state
+ * @pdev: PCI device
+ * @state: ASPM link state to disable
+ *
+ * Disable device's link state so the link will never enter specific states.
+ *
+ * Context: Caller holds pci_bus_sem read lock.
+ *
+ * Return: 0 on success, a negative errno otherwise.
+ */
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
 	lockdep_assert_held_read(&pci_bus_sem);

-- 
2.45.2




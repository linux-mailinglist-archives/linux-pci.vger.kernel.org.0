Return-Path: <linux-pci+bounces-43288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA2ACCBB8A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08DEE302B13E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6578832E154;
	Thu, 18 Dec 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSLKg+6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82432E125;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059495; cv=none; b=UjiABsqdW3tMye/+mVwzdYFEtBp2s7PU4KjsSsrrBcwA+cZDDXV6lN2vljLysagWfCvEyYHdypSvuYDbmNETABniBQbD8zzESh1EFYl0N4cmMaW0z27NmgbrHbQUZcgkBxvYvCznORX1TNF5wzsYS8C7wrsDQen5H4vFEY4eUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059495; c=relaxed/simple;
	bh=C0J8oGxG5D8j+AS06y9xcZtwDLJm3/yoCsvNjt7rWdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlZnvtqFlz86xbQ3/zJ8aOSVdiArX3Su2LbMy661Z/F85mPCWut0BSnUwPJ9MQ4z0WxawGighv/anEPSOvOugtXp6/0mHFAKEkXR9/JHEth/30zLrN5vinW/y4OhoCWgcA832HHzJ/w+e0dSn9yCPwJyUe8xIjtjyH0wiOx+sP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSLKg+6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB9D0C19423;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766059494;
	bh=C0J8oGxG5D8j+AS06y9xcZtwDLJm3/yoCsvNjt7rWdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pSLKg+6NgJ6teqzRjt6EN1E6Ub7BM5pwH8cV9oCDqsXuhQseiLFqxp47RXl8ZhL35
	 yvSnCq/x2nAhplQ3KFoAdf8ZlhFaam4yW/XLSyUbfpHNRD11heU/AxH47ehJFcMSAH
	 /MdEBM0kwHjcs7JTdjNYaRhVU1sjKqPdsV6MgdXZ44xTMDqlH1dCS4pU+yjc+6Syhi
	 P5O5eZmbQs/beXKxXtXik2XLzxqx62+kBRcwkRu7pxUx5N/O4nz+zpa1ju/4pbXp3+
	 HJaggtXBtcfJbwggFAx8skXHlRsGOhkew1uyHnMoKFMA9TL1eu4ZPirFRlpR6+zJcI
	 DzNk6vYVA0xTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD998D6ACEE;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 18 Dec 2025 17:34:53 +0530
Subject: [PATCH v2 2/2] PCI: dwc: Do not return failure if link is in
 Detect.Quiet/Active states
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
In-Reply-To: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=D2MBlxbTAfw057cQLiitH+T4lD/EKzE736CiStKl0vQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpQ+3lWTFs8FC7hQKkTIRIHEtEPIQGu0zYHqUgo
 wDtrFZH+7aJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaUPt5QAKCRBVnxHm/pHO
 9QdoB/9jpC+5JFgFx4xfgXRsSqBywS7cW4VhUKTHW7wjwnU/3eM9Dd9+L4redzxZZn1DwVxxPVd
 Pyb7HzxWOUrUJW1Kz9syDYn5IvB1PxsPe+kXHotiEjuGVVkmBFC1XlKqcfyKMC2K/bbVwVYwQGi
 I26J8rxxub/pgVM0Sjo3isN10WiREH1hLFYoej7JdRUm0yoS2/aeS1WeiA4v0hWiArhHzkFcIDz
 mji7x/2E2/9vpmOSyZnoAx9Gx/XFV8am5NFLiIarVnT/lUneNMUW0a/G9bmZnzR96YkNstbaRF2
 bn0fd9ua5oqePX8jqdc/979LH2qbOc+IqZAr8EZHYQ3yzs6Y
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

dw_pcie_wait_for_link() API waits for the link to be up and returns failure
if the link is not up within the 1 second interval. But if there was no
device connected to the bus, then the link up failure would be expected.
In that case, the callers might want to skip the failure in a hope that the
link will be up later when a device gets connected.

One of the callers, dw_pcie_host_init() is currently skipping the failure
irrespective of the link state, in an assumption that the link may come up
later. But this assumption is wrong, since LTSSM states other than
Detect.Quiet and Detect.Active during link training phase are considered to
be fatal and the link needs to be retrained.

So to avoid callers making wrong assumptions, skip returning failure from
dw_pcie_wait_for_link() only if the link is in Detect.Quiet or
Detect.Active states after timeout and also check the return value of the
API in dw_pcie_host_init().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
 drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 43d091128ef7..ef6d9ae6eddb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -670,9 +670,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	 * If there is no Link Up IRQ, we should not bypass the delay
 	 * because that would require users to manually rescan for devices.
 	 */
-	if (!pp->use_linkup_irq)
-		/* Ignore errors, the link may come up later */
-		dw_pcie_wait_for_link(pci);
+	if (!pp->use_linkup_irq) {
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret)
+			goto err_stop_link;
+	}
 
 	ret = pci_host_probe(bridge);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 75fc8b767fcc..b58baf26ce58 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -641,7 +641,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
-	u32 offset, val;
+	u32 offset, val, ltssm;
 	int retries;
 
 	/* Check if the link is up or not */
@@ -653,6 +653,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	}
 
 	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
+		/*
+		 * If the link is in Detect.Quiet or Detect.Active state, it
+		 * indicates that no device is detected. So return success to
+		 * allow the device to show up later.
+		 */
+		ltssm = dw_pcie_get_ltssm(pci);
+		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
+		    ltssm == DW_PCIE_LTSSM_DETECT_ACT)
+			return 0;
+
 		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}

-- 
2.48.1




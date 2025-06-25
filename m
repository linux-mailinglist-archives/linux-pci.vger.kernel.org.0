Return-Path: <linux-pci+bounces-30606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE15AE7F14
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E541F3A9213
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234FF29ACE4;
	Wed, 25 Jun 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhTkAvVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704629AB0F
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847050; cv=none; b=iHicsP2LIfet84HcL/AL1Ms35kMT6QyyR4zzbqOyVH5waZUHZJVDoQ7X/lXyxrOPHetvUvv9UvJUSzc6v87SbZyNVm9RUTKVRVJCAbkWNSy0HiZ1MI/CgaofrVT1CBH39oM5khDCXjFLe8aU6Mc+qXIlkoAYs6CAlMy8VcOA7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847050; c=relaxed/simple;
	bh=NcvadeASU1rPWQ5FwZ45N+1iUE6XOd5snI+N1gvGleI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2LuVR12A0CnX+ClKKSbCLXiTW+CFVAhcZztcEGJu38Rh6rmI86juV0z7gNRZIelDpiE9jWMfn8OVVtxn+n4GSvjwh4uyPc9jHwYG76ksSDOVOCK+wNMLbEL88IsMOuy1YQpKd3woWy9gi+fEN/7l/C/bD+h9tuUnW6HqYihTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhTkAvVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48948C4CEEA;
	Wed, 25 Jun 2025 10:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847049;
	bh=NcvadeASU1rPWQ5FwZ45N+1iUE6XOd5snI+N1gvGleI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nhTkAvVV4OvHt4ZBkeUaellW/9qBuWMJkZbAzl0fFrIzq5Rm8fHQusGf2PDRnQORu
	 /L2ylVRJt+oEOPAYKGjeaRtoNSNx3JXeLWKpswC9er70AfeFmM/2Xfr9z683z1RPSc
	 lsMWljel2HbRCQa0f24L2fjf2UfFC4dHAtR5AefGZABDYNI4KHWRgpw1BFiRu3RubI
	 hWxWyJd1UpGNVeAE/2iWfSnJExkxhfoTRSCdHLPo8KKQRGeIsiD+DpRn4g7x/fPwKL
	 PRLLvvTkVFWS95nCUS7BNZbxysQLR2fFxB7+pWmRdNc/dyGYF5WRxVKqNJk1x6Yq3u
	 zD9JkCEZ671ew==
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 1/7] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
Date: Wed, 25 Jun 2025 12:23:47 +0200
Message-ID: <20250625102347.1205584-10-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625102347.1205584-9-cassel@kernel.org>
References: <20250625102347.1205584-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=cassel@kernel.org; h=from:subject; bh=NcvadeASU1rPWQ5FwZ45N+1iUE6XOd5snI+N1gvGleI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKiz1m4BT2W2LHrbHbp3fLDl+We/JD7W6Xw3XH1lojVO /uKNm3d0lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJfFZjZPgfKHK5dldWc3Xh r28lq89mXjsu+eFVxKVTXyt38MStemLD8L/+naXAS7at3GbSa9dlmEid+sCz+kXN4T3NcyzTt02 IEeUEAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/plda/pcie-starfive.c | 2 +-
 drivers/pci/pci.h                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index e73c1b7bc8ef..3caf53c6c082 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -368,7 +368,7 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 	 * of 100ms following exit from a conventional reset before
 	 * sending a configuration request to the device.
 	 */
-	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
 	if (starfive_pcie_host_wait_for_link(pcie))
 		dev_info(dev, "port link down\n");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..98d6fccb383e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -61,7 +61,7 @@ struct pcie_tlp_log;
  *    completes before sending a Configuration Request to the device
  *    immediately below that Port."
  */
-#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+#define PCIE_RESET_CONFIG_WAIT_MS	100
 
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
-- 
2.49.0



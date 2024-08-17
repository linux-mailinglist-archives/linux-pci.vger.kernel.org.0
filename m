Return-Path: <linux-pci+bounces-11786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C47B95559A
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 07:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E291F23136
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 05:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC613664E;
	Sat, 17 Aug 2024 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA+g27nS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BD12FB0A;
	Sat, 17 Aug 2024 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723873150; cv=none; b=Albf8nPisZSBlTJMTTGP82JwrHrGsGEYsII/skh0s5ypOekigvsgyU5r85R9WYJd5jf3ul0mTZ11jnv/3LvJHAXW/8+6BS/oH0KjJR84aEZ0xJ21N0j9dZGTbbov312YSF4FrB3c7AwoOdWw0YYo+t0ZGShSdhdecQUkqX0qMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723873150; c=relaxed/simple;
	bh=L/27oyOVLbdmCNH9AknEU1c/3ghg8UF/LJ6ONoZ4cx4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t4CwFua+LQfWZHgq68H3YZaN4H5H+fdUc5DWfzwOFt6f9QsKqGaIV+rJlXMfPTPHuTRZhR7TQS+PCTn5zWEdDJJrEuE5WIU14b6v2sEUbJU5DPl6TUgIxw7jKOFftAsPHGz9CflGgZEdBJDWHytO0ToZlschefMdS28upC5V8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA+g27nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDA6CC4AF0F;
	Sat, 17 Aug 2024 05:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723873149;
	bh=L/27oyOVLbdmCNH9AknEU1c/3ghg8UF/LJ6ONoZ4cx4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GA+g27nSGJyvwV98rp+I2FTrd3esE38DlJHaQxgwNFf/qZoSB9eGxll0OD1LyW2OC
	 Z6TY+iF4QP4pLtoxsS4YPATeyywISDTruws+/wVEndamCapc35mliHgj9zNhGfy8Oi
	 8CtCbENfZ/2nzEtOssoHMhiNQ2iOQHdNkYOwaVVyKPaqt013hWvA93O4OQI4xzwXeN
	 JO4YCNtltKCRiHqmMV/YpBkjbUGqPeXNGgAcYxoQCCG0MZBfSs9FjeTlPZo+Qcg7I7
	 sD7HED61pY0AKNsjdvCSBkYwkSzQtJscHXgWH4nr3kYPyrgmaXQSnKTLgbg1yfIUjF
	 bx3FjnH1VGweA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD783C52D7F;
	Sat, 17 Aug 2024 05:39:08 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH 0/2] PCI: {qcom-ep/tegra194}: Move endpoint cleanups to
 PERST# deassert handler
Date: Sat, 17 Aug 2024 11:09:02 +0530
Message-Id: <20240817-pci-qcom-ep-cleanup-v1-0-d6b958226559@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHY3wGYC/x3MQQqAIBBA0avErBtQMZSuEi1CpxooNaUIorsnL
 d/i/wcKZaYCffNAposLx1Ah2wbcOoWFkH01KKG0sNJgcoyHiztSQrfRFM6ERgujO1LSWwO1TJl
 mvv/rML7vB4Z5YAFlAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=L/27oyOVLbdmCNH9AknEU1c/3ghg8UF/LJ6ONoZ4cx4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmwDd5oSWJNpFaLg/slHpFuZZnWAOUt1u//hPmY
 mKDHR5xbhuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZsA3eQAKCRBVnxHm/pHO
 9d1sB/0WCIUlcJV87RKQ5qCtkHnD2ovZLEYil0rw3RCSmWyK//H4Tzkm9kMpbjxaISonGlWLOnm
 ThYAn02ruelSxvKg7TJOHjpRgtJ6CzXGfSammhX3XpzUgTL3ABNUpUgInAS60cHyyp4J3w4bzp3
 L+FWiGeX2mRVyt34Q1P7NgAiH8v2PGGYamFooJOYWTodSNEObHGoKZlZvrgaR9KrO9ODIox6Qm7
 zfSPmFIoKAO3uqB8ZNjkCGl2OcB26VQA7fKpr/LTqJo/82aU84DvZaqFa2/0r2mvHdiLrZdMOp2
 fMm/7p9QsGr5f3u2IhcFpTtLrxHqijs42qulAHGwT7e6B21a
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series moves the call to endpoint cleanup functions (dw_pcie_ep_cleanup()
pci_epc_deinit_notify()) to PERST# deassert handler in qcom-ep and tegra194
drivers. It aims to fix a crash that is seen with Qcom endpoint SoCs when host
asserts PERST# and the cleanup functions are called without refclk.

During the review of v1 [1], Bjorn suggested fixing up tegra194 driver as well
as both drivers share the same design and require refclk from host for
operation.

Testing
=======

The Qcom patch is tested on SM8450 development board. For tegra194, I'm
expecting someone in the Cc list or the community will do the testing.

[1] https://lore.kernel.org/linux-pci/20240815224717.GA53536@bhelgaas/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (2):
      PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()
      PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()

 drivers/pci/controller/dwc/pcie-qcom-ep.c  | 6 ++++--
 drivers/pci/controller/dwc/pcie-tegra194.c | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240817-pci-qcom-ep-cleanup-740745e21d87

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>




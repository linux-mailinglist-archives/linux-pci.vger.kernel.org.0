Return-Path: <linux-pci+bounces-14999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D09AA00D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 12:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C8B22188
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59A19ABB7;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZhy6w9T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94314198842;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592882; cv=none; b=ZiKPSgoX2eWwqC/Mkh8b9Ht8EdqicVPD+DE4FW29gg7aC1I+KKpGPZFdaNKpC0i04ditrJx2vEwABfkkegD3e5E2VuLW5F1+fw0t2BdL5wy4T68/mdj+/Kdxd9csUdG2amWNBAwhnkZgszdjkqFT+pTSYmane/fkKxhG/82+TGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592882; c=relaxed/simple;
	bh=6ZLo//vlVw/cpstTFieW8KdXJ1ymTE0OxNpZC2aia6w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gbRq/UYLvseuAvHTlaJnK20CtRuj2oJuxuEVpQxgNKbLiHSziWHrUc27ywaDuhNKFaC1mfuqvOrr7bLW+CBZPlZIraBpeUBClTduOx/doE/EeqImkZmOKtuw/eDlGAtg6KijlYp1x0KmGkUzkya3MDkPnIl4wKE+ZGWZ1wY+SD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZhy6w9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3570FC4CEC3;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729592882;
	bh=6ZLo//vlVw/cpstTFieW8KdXJ1ymTE0OxNpZC2aia6w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rZhy6w9T5RmumGBtyEqUy8EoiBWr+s1DUi2pOE3saBOyBtvgywA2JG0r/S73PWqvq
	 tlOVA0F4Ncrdc2EHxdUBPnOwT2i6Vq/EJuivzQ07JB4rH2s9K+Zj9snKXTW9WBkvie
	 1+kHS6KQHgSUPGCPw59iVUwr8QsI2dfbH1mKXBMr8bOaPKangth7iMYCeLUzIFOYMB
	 BXedvdRBgqF3JLTqTpSKLspzYUobI4y1fAfoyGdCKQLpcOXiL+jDfLfanM132xZ+kj
	 L1xAszCgD9b2Q3DJpPQ/SMTLMIBybYBN4QkqDWm+rhhT7arHdWJeSCksOXu5KKRVuQ
	 97LAc7IWx4bUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC16D1CDD5;
	Tue, 22 Oct 2024 10:28:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH 0/5] PCI/pwrctl: Ensure that the pwrctl drivers are probed
 before PCI client drivers
Date: Tue, 22 Oct 2024 15:57:28 +0530
Message-Id: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABB+F2cC/x2MQQqAIBAAvxJ7bkElIfpKdCjbailM1sgg+nvWc
 RhmbogkTBGa4gahkyPvPoMuC3BL72dCHjODUabSyhgMjjEkcceGQmmXFXs9fNLW1lrIXRCa+Pq
 fbfc8L9a+InxjAAAA
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=6ZLo//vlVw/cpstTFieW8KdXJ1ymTE0OxNpZC2aia6w=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnF34u2ysVPAWfHEd/oykozMn0K7bPPcLmD1CXs
 49HCtvqZkqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxd+LgAKCRBVnxHm/pHO
 9XOkB/0U5taKt3+UYFHDZ7AaIxuqZpxsuNgJyD4TemD9BXMfO8b5ZhURh3kpeEo0q5SKlYWKfgt
 75N0oGi0QbnToJckFFljdF63od9c1xvrTCZmjpZdxTRqlWFReDA/6oZfr6tDcvyHNl5KQOLC239
 5eDPFCfz/B3W72ok8eQlQ4qni3syMszntnus75F/hloPO3sFMB8bJsvUa0Qk11oMfHLSQ/hRIn5
 FTaUnWhhL7AhJgLG0NDJsYRUPcZY869hJbdL36AYIsCPxNrxN6kWJstAetGiJDhexAXQeN4eQxX
 u/oPbiH7WfGVsrnzzXybcx6uabQBH5F10BDfdh/4TOquU+4R
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series reworks the PCI/pwrctl integration to ensure that the pwrctl drivers
are always probed before the PCI client drivers. This series addresses a race
condition when both pwrctl and pwrctl/pwrseq drivers probe parallely (even when
the later one probes last). One such issue was reported for the Qcom X13s
platform with WLAN module and fixed with 'commit a9aaf1ff88a8 ("power:
sequencing: request the WLAN enable GPIO as-is")'.

Though the issue was fixed with a hack in the pwrseq driver, it was clear that
the issue is applicable to all pwrctl drivers. Hence, this series tries to
address the issue in the PCI/pwrctl integration.

- Mani

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (5):
      PCI/pwrctl: Use of_platform_device_create() to create pwrctl devices
      PCI/pwrctl: Create pwrctl devices only if at least one power supply is present
      PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers
      PCI/pwrctl: Move pwrctl device creation to its own helper function
      PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent

 drivers/pci/bus.c         | 64 +++++++++++++++++++++++++++++++++++++++++------
 drivers/pci/of.c          | 27 ++++++++++++++++++++
 drivers/pci/pci.h         |  5 ++++
 drivers/pci/pwrctl/core.c | 10 --------
 drivers/pci/remove.c      | 17 ++++++-------
 5 files changed, 96 insertions(+), 27 deletions(-)
---
base-commit: 48dc7986beb60522eb217c0016f999cc7afaf0b7
change-id: 20241022-pci-pwrctl-rework-a1b024158555

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>




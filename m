Return-Path: <linux-pci+bounces-15269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2799AFB8E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88121F23E4A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD821C07E4;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unKwLtUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485E165F01;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842902; cv=none; b=SQQhEyJuT85wgXCpgRfAGPpl5hsV4wdwgnddT3QzxlWbdxvvsHAoixDGZAkBnCVGnmuQctyjXLyMZCcGdk0Oif2cEHZEhXfck6D2IP0dIBdCmslZacFrdsl1zENrCJg6/gHH9AM+t7r+ogZaHcQcIc9kSg2z7SIO7pV9Eru8aJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842902; c=relaxed/simple;
	bh=/P9q2KbiK+vcSshfBjILffb3hynuvF5fiM7tfFtChPU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PMNxX7ecOqh8/nEZsm0XwyuG+bjp//vwhLzENFtgIBdAZDdqybUsWd9OMpyHcgwqEKyCfn530DNKhnbviMNJIp+C+79mA9hutgfs0h74bh+sINrw7fCFnFJP6pUnkckwJT/3GEOuP/E2AHYdlY53CPopBuBZ69irqzpxduTV/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unKwLtUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E676C4CEC3;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729842902;
	bh=/P9q2KbiK+vcSshfBjILffb3hynuvF5fiM7tfFtChPU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=unKwLtUYbvMAaxxDDaj46kDvk6obQPVAC/rnCe6cWZXUIr6yLcl6dE/8qGtyApsot
	 /pW++6RbNZ5Wr664GEWcgLLWGVkiCOCitP4Wqq6lV4V997PghAc8qnKRe9n3lBc9dF
	 LLaSHDhEBgduhEZO4zhggCBcEP4NeWQFVFq/Bl2RB3zLzvdwm1Y0Teh3N5Rwqr+gOH
	 hzxTghUaDxepTIJC93ouZsYIceBv/JyGQ93G210XkK2Sa+Xe9+BNUai64vRnLJ1wC8
	 nco5JAkI8C/Xn6qwQWthvOdYvq8HZ25GLUgJYNdtwFpNkBrYpVkZrw6sd4fGug1vbN
	 cURnq0HEWUp8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E2ED1171B;
	Fri, 25 Oct 2024 07:55:02 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v2 0/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before PCI client drivers
Date: Fri, 25 Oct 2024 13:24:50 +0530
Message-Id: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpOG2cC/32NQQqDMBBFryKz7pQkGKpd9R7iIk1HHSpGJhJbx
 Ls3eoAu3//89zeIJEwR7sUGQokjhymDuRTgBzf1hPzKDEaZUitjcPaM8yp+GVFoDfJGp59HaSt
 rLeTdLNTx53Q2beaB4xLke14kfaT/bEmjwrp0N6pVZytvHyNPTsI1SA/tvu8/7mwmobMAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=/P9q2KbiK+vcSshfBjILffb3hynuvF5fiM7tfFtChPU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnG07Swl0G4ixBGpbr+vGMdccGZh0t6UayFam6Z
 lb+jRhARDOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZxtO0gAKCRBVnxHm/pHO
 9ULRCACW7PS0HfebJvSt6rB4hkHg2sIdTDJJxVgdVvmfX0motvf7zRQpEVsBhCBakf83kuwdNh/
 +wiKL2PimBQbnxReXcmmQjCqRufHCSPxaPdl4KnnNCPr0fNxigeXBcU1WUJctymADBjSIS6T6yZ
 eG8r1IeyCmoq2lQWSwsEykPRg11bTyDzQ02810G26b4x7c5V3jQrQWE4GLzKgJxjeqIStwj7XL7
 M3pYz4hPauk0aHMqvhB6b/FfutLh1VdwTD9Gje+zLj9yHTp8U6RKOCq3bFxlLiXniUh2UcFddsx
 /4ml60f5t44g+dPvAUYYkoRBkqdMS8soTXSfT98GaOjRZtmA
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
Changes in v2:
- Used for_each_available_child_of_node_scoped() to iterate over child nodes
  (Bartosz)
- Collected tags
- Link to v1: https://lore.kernel.org/r/20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org

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




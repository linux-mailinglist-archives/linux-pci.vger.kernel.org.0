Return-Path: <linux-pci+bounces-27161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8113AA96C5
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB08B188981E
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637125C6F0;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWgIK4yx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702425A349;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457142; cv=none; b=ko+IXIzr4+d12PA3e+565+qyLa1t+i0S6SnX1q/MxuyHWrJuHkOTiF5ujEKatSQp2nUTlsqS8gJ8OrUU04HhNdM456N6uJ+31ejltcUdA+MjEcb0qu4c16TKcp3L59AVQHg43fE3DYvmxBx3557w0LGZg0Xpj75P3JY2bYEcaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457142; c=relaxed/simple;
	bh=HnQHwXod2wutRRoHv2wgXPVJV7pOW/ivP71cpImY1i4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a3i89ox2Askp0DFLRubJMC1g4dteZRTw8zRRnq13Jt03L6/12E69YLBzLq2NkfrpfbIPcX0My/OVMYf/oXOLQ7iyiJcbY2FrfERrtkixmp4SNHtOUPNdmyhvgmxr/xYRFLq1wlZbqYBuup5hD1MuyTBR6dyiWQ0n0Sy2iZCjays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWgIK4yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 390E2C4CEE4;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746457142;
	bh=HnQHwXod2wutRRoHv2wgXPVJV7pOW/ivP71cpImY1i4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JWgIK4yxUiIf4OUkUjyWfN9849jDAgrjoyxOZdHfufrC5ezbUgnRoBzvqOG9TjWZP
	 r2V+9IpvwLZtOhBLFxxk1CnbhgksOHzsdTbmFG61oXr1BjYp/f+I0MF+fygD/OkfiD
	 4hywZ0RhLInyJ/R/2+pJIrv1NyP10AcSR335aMQiN8jFSQkfrxlhU5aXLJQ6AlS72P
	 zaU0cGiJuo8hiT33kFdKAn8a3tCeg+sWH8MAesR81RWH8TiGDHeDFAKQmZqI1Thr2h
	 v5TjeXa7T0MlPQwPSADz4nN/ju+QDtd28r8AatRCaiU74NTcVldEqXkLcl6TJC5U97
	 ro3iHXaX0Ghkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FE3C3ABB0;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v4 0/4] PCI: tegra: Allow building as a module
Date: Mon, 05 May 2025 09:58:57 -0500
Message-Id: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHSGGgC/23NTQ6CMBRG0a2Qjq3pLwVH7sM4KG2BJkBJi42Gs
 HcLDiTK8L7knW8GwXhrArhkM/Am2mDdkIKdMqBaOTQGWp0aEEQ4opjCUVk4mcZL2Dv96AwUqtJ
 YcSOQrEF6G72p7XMjb/fUrQ2T869tIeL1+sEYQf9YxBBBhSSuizTGmbw2vbTdWbkerFgke6A4A
 MgKYCxZVWLCWP4L0C/AETkAaAI4zyUrBSVaoD2wLMsbQH+4AjIBAAA=
X-Change-ID: 20250313-pci-tegra-module-7cbd1c5e70af
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746457141; l=1327;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=HnQHwXod2wutRRoHv2wgXPVJV7pOW/ivP71cpImY1i4=;
 b=/3JyDtE7aHyipMrD8Ry8sTJ7wN5U14qjqgqGMloBCJNHtRtCyeXCnybsSN8Wx5CJfndayNX5H
 WoU+oOZShmJDpcV2sYryLPabyII2xUyxKebLTZAkaEhGg1ILTVcemQu
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v4:
- Updated commit messages for patches 1 and 2, per review
- Link to v3: https://lore.kernel.org/r/20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com

Changes in v3:
- Add patch to drop remove callback, per request
- Link to v2: https://lore.kernel.org/r/20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com

Changes in v2:
- Add patch to export tegra_cpuidle_pcie_irqs_in_use as required when
  building pci-tegra as a module for arm
- Drop module exit to prevent module unloading, as requested
- Link to v1: https://lore.kernel.org/r/20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com

---
Aaron Kling (4):
      irqdomain: Export irq_domain_free_irqs
      cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
      PCI: tegra: Allow building as a module
      PCI: tegra: Drop unused remove callback

 drivers/cpuidle/cpuidle-tegra.c    |  1 +
 drivers/pci/controller/Kconfig     |  2 +-
 drivers/pci/controller/pci-tegra.c | 24 ++++++------------------
 kernel/irq/irqdomain.c             |  1 +
 4 files changed, 9 insertions(+), 19 deletions(-)
---
base-commit: 18352e73612d60b81790d2437845276ae499b64a
change-id: 20250313-pci-tegra-module-7cbd1c5e70af

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>




Return-Path: <linux-pci+bounces-27408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C9AAF194
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 05:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5515C7B5EB3
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 03:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532D1FBE8A;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duGg0xtR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F851F181F;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674754; cv=none; b=frY2dmc8ZurF9W0cm3N3j5mxu17KwYunXqouDALHGqJI0u91TPP3wH6tf3XDx4vOa9Aq+4R4qN0nDZaBZWiLAwhRABFL1OgaxH+rn6uQPWwZzTPYQSssji57EY8mAKEtZRvBXUyDAJJJMPAyUUtqPBfe/f0+oOuNEGqKr+PgVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674754; c=relaxed/simple;
	bh=0pcAJu24LCSnOoE0alnDTb7LX09SzOwDg3pSbDn2Ii8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hUvq6yFYyW7X9R6ve05ci+9ztMIBD/cn48ACHYMOyJZ4arUeoHEHEQFvmSiFZZT7Dt/zwbp4+0Adp3VkYOS1ESd16yhNEnxWnTns8KUzZ+Tbm8hjbD0WVfK4sN8WZmN3l3UNRT0URJ2+jAKiShXxM9wT9pBV3bH9uwxY5UqpnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duGg0xtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C5EDC4CEE8;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746674754;
	bh=0pcAJu24LCSnOoE0alnDTb7LX09SzOwDg3pSbDn2Ii8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=duGg0xtRQEpaxG6c6mCX25iD6rC2FR+xj4+oipUaBBVhbxyxITe9bG/y2bevlP4ae
	 8vtC8bVnyGYeM0PO0zT1eeduO/Nhq56/CB2okOt092JIzf+TzNjGzi54FfR+nLhZDM
	 wKX6oj/i0bKzEuDHStC3dhzA2tIKQwkYtG3KfQaida8Sqtoh79XkDZScCmBNsVFCFV
	 XoDgRat0ny7aOPtyCkbvWUpzuv9sjx1vxpddsPS+njZVfdBlBN/lvCIpram1/e+GLc
	 Uek36gM8Wt2uF7qgIJpR4VRf5F9hR7P5TPoVbHO8mqDCVdfXR4dJ6oq0JBpgYi+Uqv
	 9+n+04TuEIxCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB86C3ABBE;
	Thu,  8 May 2025 03:25:53 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v6 0/3] PCI: tegra: Allow building as a module
Date: Wed, 07 May 2025 22:25:51 -0500
Message-Id: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8kHGgC/4XPQW7CMBAF0KsgrzEajz2x01XvUXUxdpxgiRDk0
 KgVyt3rwKIUIrH8X5r3NRcxxpziKN42F5HjlMY0HEuothsR9nzsokxNyQIBCbTS8hSSPMcus+y
 H5usQpQ2+UYGiBW5FOTvl2KbvK/nxWfI+jech/1wXJrW0N8wgPGOTkiADsGpdGSPD713P6bALQ
 y8WbMJ7wK0AuABKsfG1QmOqR0D/AQS4AugCEFVsaquxsfAImHuAVgBTAHDOE2EwXj29QK8AKoB
 Dy8yhrp3/B8zz/AuxzBD0tAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746674753; l=1783;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=0pcAJu24LCSnOoE0alnDTb7LX09SzOwDg3pSbDn2Ii8=;
 b=5vI6/OkRPTKlzXe3vVbMLbMax/WLtUua8eriSFeb3LmCylg7E0sqz4CFjwIwr0huTUaKGwQA6
 x5guMxskE33BGyaQTk/iUqrLiuhTyRck/5TsXnB7nfr24uc/0wnRJ+y
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v6:
- Remove unused debugfs cleanup function, as caught by kernel ci
- Link to v5: https://lore.kernel.org/r/20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com

Changes in v5:
- Copy commit message exactly word for word on patch 1, as required by reviewer
- Delete remove callback in patch 3, per request
- Don't clean up debugfs, per request, which drops patch 4 entirely
- Link to v4: https://lore.kernel.org/r/20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com

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
Aaron Kling (3):
      irqdomain: Export irq_domain_free_irqs
      cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use
      PCI: tegra: Allow building as a module

 drivers/cpuidle/cpuidle-tegra.c    |  1 +
 drivers/pci/controller/Kconfig     |  2 +-
 drivers/pci/controller/pci-tegra.c | 35 ++++-------------------------------
 kernel/irq/irqdomain.c             |  1 +
 4 files changed, 7 insertions(+), 32 deletions(-)
---
base-commit: 18352e73612d60b81790d2437845276ae499b64a
change-id: 20250313-pci-tegra-module-7cbd1c5e70af

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>




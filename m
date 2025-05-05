Return-Path: <linux-pci+bounces-27250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582DFAAB53F
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF3B4E0C9B
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 05:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AE3A8824;
	Tue,  6 May 2025 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b79HvWEm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814493A80FC;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487041; cv=none; b=GTjs6arqIBOTpr1myGmxS3POcdeXKLZ48A6xFyNxUckc25SU5W0u24tJemFlgTHzNbZs0JSCRfSrHfUTmSYsiAsAt2KWfcR3EwYFxDS1mgHqmLtcOw+2fr0ypV7mX60RWUF9oj+INBVomioRyg9qZU5Tgyro8gQqdZhMgAw+ZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487041; c=relaxed/simple;
	bh=eUfjuqWwgzc7HEzgfWaIoJCRqEYULkjhX5zB3ZSy8Ts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iTdBJzp7X6mmUmbvnYE/YXWzqBrTEu69lEbde0nayAQkoHPEkuAzTcrANL+JMEAJx0tqovOMVD+s2mSvDLCuRgGbNQH/WSekN6xWZCu9qKRmyXpivNH/oQHVG4czv+0wpv5eM732+eahh+miQPMq15sFjcKUGk4P/TmZV69x7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b79HvWEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54ABBC4CEEE;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487041;
	bh=eUfjuqWwgzc7HEzgfWaIoJCRqEYULkjhX5zB3ZSy8Ts=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=b79HvWEmOgjvCrM3BDAPa2gI30QcgO4pbzLHgnyJAAZG6R8ww/QoXocZw9202IB7z
	 mKWiaSbAEh67S40nmAv79NnsYxmQN2d+ST0RqOR+73xPKkhh1QGe5Lfg9twZLhjuJV
	 Q70UT0noss7qnTlgfgVknkznocX5s4PEHiUZAyQkmIammg5NGBti4zAG0d6GWK3ov9
	 1xYKzbzYogCtla/YGah9pxFA0X61dsQQCjhihVxR2In79HGi2Hm+MkxN3ncUBbwzd5
	 e1aMvbYw0MOM9HrTOc8K1nrDUY6THSgngV175I2Yzjw3zGtyRbA3TzjG+YtanKKAo+
	 KlOgivg3MSvOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4318FC3ABB6;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v5 0/3] PCI: tegra: Allow building as a module
Date: Mon, 05 May 2025 18:17:19 -0500
Message-Id: <20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP9GGWgC/23PTQ6CMBAF4KuYrq2Zmc4IuvIexkUpBZuImKJEY
 7i7RRf+sXwvme9l7qrzMfhOrWd3FX0futAeU5D5TLm9PdZehzJlRUACBo0+uaDPvo5WN215OXi
 duaJEJz4DW6l0doq+Ctcnud2lvA/duY2350KPY/vCmOAf61GDdmCxytOYsN3UjQ2HhWsbNWI9f
 QL5BEAjgGi5WCExL38B8wYEaAIwCRBZWl5lhsoMfgH+BGQC4ARAnhci5LjArxeGYXgAwJpL2HM
 BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746487040; l=1598;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=eUfjuqWwgzc7HEzgfWaIoJCRqEYULkjhX5zB3ZSy8Ts=;
 b=PPOCuy8fWxrudoIzuE1qc7uG79iuQLKGG/jVPH4ve4vcbV36e3ZeLTq9Ho3LNkHHYIoECpcYS
 oV33CYQ4v5iDW9PE+038JE4R2iUQU/1eoEnSjdQL8SghnA82UDOro5j
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
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
 drivers/pci/controller/pci-tegra.c | 29 ++++-------------------------
 kernel/irq/irqdomain.c             |  1 +
 4 files changed, 7 insertions(+), 26 deletions(-)
---
base-commit: 18352e73612d60b81790d2437845276ae499b64a
change-id: 20250313-pci-tegra-module-7cbd1c5e70af

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>




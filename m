Return-Path: <linux-pci+bounces-27106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A6AA79B3
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F803BF04E
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBA1EF0B4;
	Fri,  2 May 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1hAeUd3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A817A31D;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212445; cv=none; b=DthoJ4zZZehktimG5ITOBNa+qOoyZ6nVWjs3yd1kwRxo8uwpTjSe2NBFW1AYkB3Z5gewdmQkjQz7JfQo+aF3YuutWNESYE32TTDN0PdnPQr45KuwYwAlCkWnHVINf4PVKo06axMZr8vepSl1noK7sIDdrzcwrIJgflDLri7/U48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212445; c=relaxed/simple;
	bh=so9xiW1S4t/puW+TSopXdW0I81Cxz+S5s0PV6OPTll8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FO3qJ5vZlPgxpfoHQubaLgxLZT7SXCpPFLeJpdwdQvEarACAJPS1GGbJbP5NjnTKngVeZfbtEvMHb6vjCYxdhF7oUhdz6hAvdY7etSEnjCbB6dI+xlziwA9hVfmgKvbmEd0s1P7TTgsaSDaO7QdN/I7H/HN/DI9/0flQ4xELgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1hAeUd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89DCCC4CEE4;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746212444;
	bh=so9xiW1S4t/puW+TSopXdW0I81Cxz+S5s0PV6OPTll8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=A1hAeUd3OZWDQZh+v+j/tLjigeBAAgfsVPmHdHY8EDt3JMMfApOESVmoaFjjwuR1Z
	 oUQRB+lpXb/XiHVCa+UaVm501Fsk7kbCxg6KM48AyKJ26LDsUH8juSc4fprdJBkVSr
	 YPP3svc3Zc0g+ZAq91TGh7B+kNObQm/Rhu5ax2nt/LyV7giLDTI+Idae5kK5/B7J75
	 0w/2JNPBtYAOEMCey9k+fcxhDjLFgNgliCHXvj74TR/F7+nMOXrug6fgM3cz0MxxpS
	 3Kly3J4rTlgKG/JG6n8aKigpHbJbJQiOYbvFbVJ1yQ6WQ5Hx0W3m9E8oP14JqJjETe
	 te8B7/BBa2v8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC20C3ABAC;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v3 0/4] PCI: tegra: Allow building as a module
Date: Fri, 02 May 2025 14:00:28 -0500
Message-Id: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwWFWgC/23NQQ6CMBCF4auQrq3plCLIynsYF6UMMAlQ0mKjI
 dzdghsSXf6TzPcW5tERelYmC3MYyJMdY6SnhJlOjy1yqmMzKWQmUkj5ZIjP2DrNB1s/e+S5qWo
 wGeZCNyy+TQ4beu3k/RG7Iz9b994XAmzXL6ak+MUCcMGN0NAUcSxT+tYOmvqzsQPbsCCPQPEHk
 BsAoFV1BanU5Qis6/oBPXKM7PEAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746212443; l=1155;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=so9xiW1S4t/puW+TSopXdW0I81Cxz+S5s0PV6OPTll8=;
 b=jzbeQQRcoQ48RuQVHs8LZsVlZt97xOuoIiLY7mWldxO2XwgDv7bAYx6iCFKObhSCmBYyE5M51
 sYUM+fvmnBcAY+OCeefnCILMrYh42bVKd5IoTmfeBmEnRt7bSZRAahy
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
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




Return-Path: <linux-pci+bounces-26970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF50EA9FEC1
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 03:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC3D3AAE3C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D515F330;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkGRm+So"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDB2110E;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888750; cv=none; b=HOwpbxaEuEXfelOapX2lnRamfFzG8QjXsqWdBmBc+qoP7nFu6uOgpyLX4bZG75sw/J/j6aExVsaghZPq1FlRcE5VPBEZz3QlQGPZOup0jaTc1IeWdMSkg+8EIw0XeCeUWdlyfm3m0GmIA+aCzHnpCOHkS1uARkczg2qqYzj3F/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888750; c=relaxed/simple;
	bh=azkGwqj5YKIYK7EJNW3OFVdb6KdfeAoqBb9yl+/OaqA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E61fjxcbkYr7UUmbQpWhMQt9fz6DZ3dxRLBDzbjdDa02LXOHa+XXMnKnGW+9gVBcbw8KDVJ1S/t8ExFdxF3DyofMbQaEoHjKM3hr3LyGfP4nvFGTj2B6WQlXkrZSIYxNzfOdigly9X8ro32S3rDomM5As9FPDNBO5As2IXS8464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkGRm+So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12BA7C4CEE4;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745888750;
	bh=azkGwqj5YKIYK7EJNW3OFVdb6KdfeAoqBb9yl+/OaqA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fkGRm+SoluyeV1QvrkY+dg8CY7u5a8XnuALbRAFoZesdT+tTg4cyR4DsVSst6nX/l
	 n1CW2AqxqU3F3U3E5HufkBq9/k1CyrjbPQcsYjW52YhlVV69eEIi0wA9Xr4rA2/JQD
	 jCHR47Lm63m0jffcHh78IprucZuGpq80FNu0hmpvnLi0lHWHtkRfymHB+IiB6+tpxJ
	 ivJwb9YaXqkzXoDxXt3kZxAQEK/gNESxyM1YX055MRfq2mvOkC73S6nvzv6GVtmt89
	 l1JZCFfJSJs+ZKy07NWWRVmbh2dTfaTCu1wx2gmuSQmbTd+rPjoZjkQ7SElndv/4pr
	 X6yr/8sM886Jg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EADC369D5;
	Tue, 29 Apr 2025 01:05:49 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] PCI: tegra: Allow building as a module
Date: Mon, 28 Apr 2025 20:05:45 -0500
Message-Id: <20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOklEGgC/2WNQQ6CMBBFr0Jm7Zi20GBceQ/DorZDmYRS0iLRE
 O5uxaXL95P/3gaZElOGa7VBopUzx6mAOlVgBzN5QnaFQQmlRS1rnC3jQj4ZDNE9R8LWPpy0mlp
 heii3OVHPr0N57woPnJeY3kdhld/1J2uU+JetEgVaYWR/KTHdmJsPhsezjQG6fd8/5O+7HrAAA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745888749; l=921;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=azkGwqj5YKIYK7EJNW3OFVdb6KdfeAoqBb9yl+/OaqA=;
 b=ZE/GiDvh1iRFBMpZV3wJ/hJ4XtBiP7ap/31NXwh8msKIu/JPbjEzCAm0yNaxzMEM7GnGBDgt0
 48lt2rC4jZJDvgW/BX2FCRLedq4JgJ1UqRcJA7H6qV6HKatawbWRQEl
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
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

 drivers/cpuidle/cpuidle-tegra.c    | 1 +
 drivers/pci/controller/Kconfig     | 2 +-
 drivers/pci/controller/pci-tegra.c | 5 ++++-
 kernel/irq/irqdomain.c             | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 18352e73612d60b81790d2437845276ae499b64a
change-id: 20250313-pci-tegra-module-7cbd1c5e70af

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>




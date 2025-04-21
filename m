Return-Path: <linux-pci+bounces-26319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5699A94B39
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 04:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23733B02F5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF988256C99;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbeBXRGm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1A347C7;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204359; cv=none; b=gsV1CR1Af3fc+zeCg9Q8Bp5hI+keV6EQIH4xt/sKHfGOdDllEnVeMiIGMT3kH5k1fpGMuywY9tRXlwueuFuB5KxZptAsp9dlxXe/6Dbaibl4dS9un/umXB0Yh9ACLWC7v4mVSu2z6XL+1VgRRq1PAKW0chRKOOg42kbP69mtQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204359; c=relaxed/simple;
	bh=R9f74YRgz6IRKppd90adUHI/amHmTouOI9UziGWcAyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nWcNIP7gWvNccZeCRbXlnjo706dmQTDpcYbJZSDjRCJcSWW/u6MKK/f4UqXmAXrDspym54a6l7xE2KENFeWrXMJNnDBGkrRmb8ZXvB0LXjZIle8uKvJ9HL5j9t82yMAqj9GIdp3LJObh4vsw1lSTT2qG2zDCtXu9jOBjg6k/bDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbeBXRGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE5CDC4CEE2;
	Mon, 21 Apr 2025 02:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745204359;
	bh=R9f74YRgz6IRKppd90adUHI/amHmTouOI9UziGWcAyg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JbeBXRGmr7iJX32wa+oOffQbo/b4Up3aGvABXBseKrwLLdK9XCLLDph7bKStoUU8/
	 wEMMNEArYxLDijjXHFaN7rZyv7lw1Xqrp1eQXWqxTGZZ1CMVFDr9f4szRe5DH56JnE
	 ENa0VXMepQWYS/h3o2Z4UMS8uA5SOeIVFZyzBH2HyviQJuYXEMgGDyXT0LppOgAvF+
	 NwrZuP41VnoKpfAFtFq7n4xbZ26MG5CZaPCXsMe7T8kkd+vI5Bw9/wCZAz3hOcep9A
	 AtT3FwTHGTY/VbibXzoCq+9+ECHsSfPuSZOdpu2hY2/5dmnRkaatOoUPUKOcJ37ClX
	 MW5TmxzsEcfiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E9DC369C2;
	Mon, 21 Apr 2025 02:59:18 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH 0/2] PCI: tegra: Allow building as a module
Date: Sun, 20 Apr 2025 21:59:04 -0500
Message-Id: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHm0BWgC/x3MQQqAIBBA0avIrBvQIoSuEi1MJxsoFa0IorsnL
 d/i/wcKZaYCg3gg08WFY6hQjQC7muAJ2VVDK9tedqrDZBkP8tngHt25EWo7O2V70tIsULOUaeH
 7X47T+35omWfOYgAAAA==
X-Change-ID: 20250313-pci-tegra-module-7cbd1c5e70af
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745204358; l=521;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=R9f74YRgz6IRKppd90adUHI/amHmTouOI9UziGWcAyg=;
 b=oPIZvsec7gz9+Yjz6nVopaeusWi4sC2rXNfF4YLwe/3YlkRuaGmDo7ET7bXC2NEttI69zAzRs
 ro2SrwYOeDHD0FsEymlQ4goP2h5ZazxAB3qsPNxnwaNkAzz3HSFg+CA
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Aaron Kling (2):
      irqdomain: Export irq_domain_free_irqs
      PCI: tegra: Allow building as a module

 drivers/pci/controller/Kconfig     | 2 +-
 drivers/pci/controller/pci-tegra.c | 3 +++
 kernel/irq/irqdomain.c             | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: e3a854b577cb05ceb77c0eba54bfef98a03278fa
change-id: 20250313-pci-tegra-module-7cbd1c5e70af

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>




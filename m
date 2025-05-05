Return-Path: <linux-pci+bounces-27208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097EAAA445
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493FC1A87754
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C52882C2;
	Mon,  5 May 2025 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx0qi3MK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3932882C0;
	Mon,  5 May 2025 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483964; cv=none; b=EqM59gtvPZBhU80SfDktNL6tv3fI/x422wjdQ1w3O1Af4BdKeg1TJhBvVYKa2OxLiA6FlhR3P/acUDnAJ/iY8F2jZuz9uugyCmYZIAbphsxqsYpSRlNPlzVPu3+DuLl9AQ/E7v9hosgDF3qj4349rRcK/w1CSQ2sKgBNBeZxzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483964; c=relaxed/simple;
	bh=oWo5y1RaFIe1LD0KY9udUqxhUFVnrrcknEQyAbOi8pE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Exbkn9/pVyqSthm7uWvdIaImBYNVL8Ve/YTB6D39GBUPcGYV8P+5yWnUAwH2nIFVjQHlArgU5ewBjMw21FWWD1qo79JOIgKTE0aasoNRiBKqc5Bl4ldntOYAXLpKjw8L19056YbCUs2MiS4IXukBfhUInNYXXyUMSnxt0m87GKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx0qi3MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A493AC4CEEE;
	Mon,  5 May 2025 22:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483964;
	bh=oWo5y1RaFIe1LD0KY9udUqxhUFVnrrcknEQyAbOi8pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kx0qi3MKKGU02G4NZKnD83DCbGCWByvNO73B85uJMUmJCAhbo14+LYnQfF8FHPxo1
	 kL6E4xBLzDXosf5LeVlsxjZQLyr1oQkpMbUbItKiJsOfkn56sHgCwm+E6fbMr/1Th2
	 YYCo9emnnQX+xzwWBj40FlEPe4GsM1f0BUZslOYZtb/2AerPZxbci6gZeqGucwJ/kl
	 JNXfrx9hvhfeBncpopvmXlOaaus3bBo1nZSj8a8Wr62dL2d98J1yZoLQVpQzdArk8d
	 kwVcSh7lu2JKKhPZEhWa08FWQnSR386FaFg/GOdOLyG34IOc9EHHUDrrWOcGE4wWNx
	 S7sL69sKXyK6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stanimir Varbanov <svarbanov@suse.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jim2101024@gmail.com,
	nsaenz@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 294/642] PCI: brcmstb: Add a softdep to MIP MSI-X driver
Date: Mon,  5 May 2025 18:08:30 -0400
Message-Id: <20250505221419.2672473-294-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Stanimir Varbanov <svarbanov@suse.de>

[ Upstream commit 2294059118c550464dd8906286324d90c33b152b ]

Then the brcmstb PCIe driver and MIP MSI-X interrupt controller
drivers are built as modules there could be a race in probing.

To avoid this, add a softdep to MIP driver to guarantee that
MIP driver will be load first.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Link: https://lore.kernel.org/r/20250224083559.47645-5-svarbanov@suse.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index ff217a0b80ad3..bae226c779a50 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1947,3 +1947,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
-- 
2.39.5



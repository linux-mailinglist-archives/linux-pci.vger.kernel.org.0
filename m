Return-Path: <linux-pci+bounces-27240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B356AAB01B
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 05:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C9C3A3FA2
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3E289E38;
	Mon,  5 May 2025 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqmWeQFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A045680;
	Mon,  5 May 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487211; cv=none; b=OnM7JQOsWgkygjpQOOhAMSPpGZQ0PydEISZxY8vzUXef0woxHykV/zA4sBxXbbrHftl9g4iEK9fbqNmc3ZDznkIqnrvURqe5OblRG2yTDk1c8o0D8T0Gx8azUmqWGsoQUHVYufC84BRLqa2j/t1noDos9L483ky4CPbaHVkxPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487211; c=relaxed/simple;
	bh=ENgbqkBgGMa5Coy1KnyAD6orBWru8MWNRBgdgyZkbhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioZliPmSTRuOt2vPehx3VJpLnN5UNtWNVf5GittLDRqu8Mzgyg1BIiCqP7ttT6NnQKHCNfgDXh1zHGiEzks5V7k1zeLQxVclr0H0XXeQZF5SpdPM4xa2nWUOMVEiVr/udu4LYXl0MDaI9fBWpk96ZttyjJSY4BkXIFqxSpcHBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqmWeQFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84861C4CEF2;
	Mon,  5 May 2025 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487209;
	bh=ENgbqkBgGMa5Coy1KnyAD6orBWru8MWNRBgdgyZkbhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqmWeQFx35XWQUmQmo8mn0s5l6ZuuRCWuXXtiFGKb5H0IIhdDMHWej37V6QJbLqD3
	 mBt5epxgvqiKMfXb/XMJox5Oo7UBp7TKUMiZR8bhxm+3bwoo6dcTZfEWsCHeDXKxE9
	 UzJ1TZliidGTlM9WWWkExE/1Ol8dy3ues3+Y/H8wWltuiEbngABiDZFQpxXhKD15RG
	 BOZjGizW4Loh/O1hF9ZWlAEqtEABIz6JRTVv9UJi3msRcTXcZZPNZ9nwx23nANv9VJ
	 C8Kq13so5pWZ+zb/8HcPycYKSNnyrGH4/WzfFgmaqhujqyFfSEYxZbPwwSdrZTxFjX
	 PdYVAHiOtHhPg==
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
Subject: [PATCH AUTOSEL 5.10 058/114] PCI: brcmstb: Add a softdep to MIP MSI-X driver
Date: Mon,  5 May 2025 19:17:21 -0400
Message-Id: <20250505231817.2697367-58-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 2fc4fe23e6bbf..85be07e8b418a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1326,3 +1326,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
-- 
2.39.5



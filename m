Return-Path: <linux-pci+bounces-27244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C6AAB31D
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 06:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EF217DB52
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93AA218ACA;
	Tue,  6 May 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmSqBLW2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F338B4CA;
	Mon,  5 May 2025 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486074; cv=none; b=qlw5XHfsxsUIIwBjh8sj/IuZSuI+pHb5621sV6XnovY1x7GYPMW8aOkqHH/qK2jZm9ChEqRNNx7ddEKNFRgJc6XGWi7KT1gKpeorPAJqvsN5Bdyy8aNeCIaYrulz6RD5H2NJK1eSglvP1mqct/1aHcAM45r1xhhJLcNvGAoQprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486074; c=relaxed/simple;
	bh=8Nhg1ffeN3yPY9Tc4uln2i2CXIJkjjf8aWFSD20mPIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYMHa475Sha466j64uojtcY5yCFz6YWMdPi6EnzqWWyYbe0wgH49S+addqB/hTxI75wmRq6Oi8N+2PMjEvqpiTZMjqEZJgVXCDbyF5oYbHYZ8RkhziqmeaGnMbciD7SF4lWFMWQ1T0Ji1Gqw9cijpr9gcOZ7uDIzGAd2rN8zAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmSqBLW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F85C4CEEF;
	Mon,  5 May 2025 23:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486074;
	bh=8Nhg1ffeN3yPY9Tc4uln2i2CXIJkjjf8aWFSD20mPIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmSqBLW2BfqOUuGsjf2JSiTho+CcjRKDcydzJgf0oaa6K4GGIxfTFPx6Pcc19WzWH
	 Zv6430xeWeFfVgX+o6WJROteM56KTaEu9szCBHJcNfrDxHHufzzfCFBsRMSxiFZ6hw
	 0plJ0rRp4V9WjQdqQxhJwEbQF0g1Nl9LRxBvdkmq3Pa+tWjJIKLWTVFv+g4MjkZ3FH
	 m0TZsfajKdTH1d+u5W9wJn5eczN/igimJJfgo8+c+77kolNgR183iHITIVEmb4gwwu
	 yAad78+L/9bX7BFSLTHYN00iladRQto0mRJ+5iSHzpZkJ5D3ZZF5tFI7JKuKx6qyEo
	 LHOrmKivVm6kg==
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
Subject: [PATCH AUTOSEL 6.6 141/294] PCI: brcmstb: Add a softdep to MIP MSI-X driver
Date: Mon,  5 May 2025 18:54:01 -0400
Message-Id: <20250505225634.2688578-141-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 8b88e30db7447..9bcf4c68058eb 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1632,3 +1632,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
-- 
2.39.5



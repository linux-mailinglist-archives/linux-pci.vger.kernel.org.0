Return-Path: <linux-pci+bounces-27247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1155AAB449
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB803B1DD5
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F347473A;
	Tue,  6 May 2025 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh5mCCp8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1172EEBC3;
	Mon,  5 May 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486600; cv=none; b=AUeAo1yxbDZ+ruRDgPaGxmLfYUf8SsUqX9jGOqFn+rsi7np2ncAOPe2ZnszMqtaFncsQS1P+GXWdDTZC5ZceCHYMCdvzhTDjC0QVjEaiOhEN7ixx8It/6DrXADT1uqiPbh0rGpdOkbTvmnCaXCVFqReinAhlg5nTEBbKJ+sswZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486600; c=relaxed/simple;
	bh=jHrv6jf5BhecfcyDAtC7C0iKtIoXl+aJkKi5SvQn2NU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyHZUaqp+2jEVfpik8nJU0phWE1cIWKrwueUlY23oYPbtFJtRN7vrnHQOv2JPVr+FBdZhUxF6ZsTbPbqrCLbHmB2j5kv+qxwmjF47ZP0pFBIbd5yOX8gUI4325VFeY+nNv8TOAG2SfEFyUXeiTliw5Uq1652kfaCEx0AwXHEyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh5mCCp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072E4C4CEEF;
	Mon,  5 May 2025 23:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486600;
	bh=jHrv6jf5BhecfcyDAtC7C0iKtIoXl+aJkKi5SvQn2NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uh5mCCp8zy5RgdDL3lQo4DTyujd9ngv/snLLK5FMvxVHbwXqTtldyykecHspHihwU
	 cMB5ketieVbfO8OLIARCVbxVcKtShOeZMqPA5WcvGGML80hhySX8H8FMgZdXsO/+4H
	 By6m+5lzf6q4M5kGzOyIi+UV3AvVTW/NCYihpdKCjezLAFUpTb/ubVVcdl/AcVRFpp
	 3+Rd8sd+Vpu7JfkOzWjrbotn/7QkY9UciV6qWta/ae9Ds9ysxh/NCJQUwi3VlREk7t
	 ZT4vdp1h7ZwObmA7p71seh++DFZnkWu0VMWD1xe9T/fcUJMB5WKpLkLcwftm9A0xOo
	 K586RBANdWMQA==
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
Subject: [PATCH AUTOSEL 6.1 111/212] PCI: brcmstb: Add a softdep to MIP MSI-X driver
Date: Mon,  5 May 2025 19:04:43 -0400
Message-Id: <20250505230624.2692522-111-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index fe37bd28761a8..c89ad1f92a07f 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1619,3 +1619,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
-- 
2.39.5



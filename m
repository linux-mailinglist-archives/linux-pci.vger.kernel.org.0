Return-Path: <linux-pci+bounces-27225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E737AAAAF3
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E7C188D0C6
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C8B2F15F3;
	Mon,  5 May 2025 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX9OEldP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7738B4C3;
	Mon,  5 May 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486074; cv=none; b=imGinKyAofqN4FhFjb2gGnb73TaAbjnydqLNTC3z6Xdc+W++up5ExJ+TiQubjMmZkRWPe01br/3P30HmInRx0M6wxPGf/Jjo/bBWgxpGoLEdXyhKhgkeumYssOzlDTIfYeLwSEZwwnI9IewvH2hzT8K5SJ3SV/TiMfEd7NXFjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486074; c=relaxed/simple;
	bh=Tg0oO72UEuWrNhyBlLj2lqOxWmKsDt6D3xHET3569wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UihwjR1oE3GtCmg61eziXKeFjvImveoCxKSotsuQUF9S9DV+LmFnG3qh7++430b/pn/pLzkitfWjFTSgZ7tjPodl6WD8uHCyXb5/xVz2u/AlswSRDAMgQ6hemqlzk26TjKJxi3Em+qx4IKvaU94nURS5zELOfcs+R00ddcyA7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX9OEldP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5937C4CEEE;
	Mon,  5 May 2025 23:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486072;
	bh=Tg0oO72UEuWrNhyBlLj2lqOxWmKsDt6D3xHET3569wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dX9OEldPO4FHfk4M8pcYJDKhtchTVfvuOH0Mc2cwhCUFe1kYjsbX23bMJ5PHtdtAa
	 FvtJotMG21qkv4VkWJ4UrrN4/FL4AayywWo5M6Ocax1MUiR03CrR3URxBGXGGTsN3b
	 OZvgqjRNakeiSPZM4UL/t+Y9DTDz9JfZvpb0OlT4pnn6m2BPKVh0s5k6lalZMsV6m5
	 4hH7vXsRQq8Mmr3WvkMfmCSj4Np6AnB2f3k4fwMk8cGtabDIGyVxv1fjDUDDIppubc
	 6KtuLFMEs1SWjzo5SltpUCLjd2qw48skbYU8Q1+G68t6bauEaIyU/k6DPvoRnjoLmz
	 CN9qRFG5ehY2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stanimir Varbanov <svarbanov@suse.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jim2101024@gmail.com,
	nsaenz@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 140/294] PCI: brcmstb: Expand inbound window size up to 64GB
Date: Mon,  5 May 2025 18:54:00 -0400
Message-Id: <20250505225634.2688578-140-sashal@kernel.org>
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

[ Upstream commit 25a98c727015638baffcfa236e3f37b70cedcf87 ]

The BCM2712 memory map can support up to 64GB of system memory, thus
expand the inbound window size in calculation helper function.

The change is safe for the currently supported SoCs that have smaller
inbound window sizes.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Jim Quinlan <james.quinlan@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Link: https://lore.kernel.org/r/20250224083559.47645-7-svarbanov@suse.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 940af934ce1bb..8b88e30db7447 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -284,8 +284,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
 	if (log2_in >= 12 && log2_in <= 15)
 		/* Covers 4KB to 32KB (inclusive) */
 		return (log2_in - 12) + 0x1c;
-	else if (log2_in >= 16 && log2_in <= 35)
-		/* Covers 64KB to 32GB, (inclusive) */
+	else if (log2_in >= 16 && log2_in <= 36)
+		/* Covers 64KB to 64GB, (inclusive) */
 		return log2_in - 15;
 	/* Something is awry so disable */
 	return 0;
-- 
2.39.5



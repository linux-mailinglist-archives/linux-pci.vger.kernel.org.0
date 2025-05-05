Return-Path: <linux-pci+bounces-27201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D35AA9FE0
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 00:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E0D1894A4C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70728B4E5;
	Mon,  5 May 2025 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoN9btCq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FE28B4E3;
	Mon,  5 May 2025 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483364; cv=none; b=cQiHXnwbBiAD2JkLAPof9wU+ZZacFFNDl0uXsDFj6IbrP7nlUVgMaHzfb1XFi1sh1a8h4obhBHaj8vmEMT4Uc8NaF43KVUJxjZwkIPGK+XilrBbI0rgC5ts9eN0B4LsoBWpyujRsgDDdhw6vMwfzj3WVp+BgdwO9zAG+rSYcaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483364; c=relaxed/simple;
	bh=aJBhqLkBwb4yvuEypiYyoVhdKgEw4V7w2elPmnAG+JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMFZzTj0/XEVRVodxtTi/A3iCtRP1obQsRDF3B68wkUxfKt1s22x+/um5+cR4t7CwbBCsuZlqlgiUelA8aXPPYRWX+J91DYcGULsGaK6VZcIpp/NKVSsTwFhuQQOn+wmc/zHMPsp1r2D7WzSszhQrTA4VK/bi8F6Yfgm7P771p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoN9btCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12795C4CEF1;
	Mon,  5 May 2025 22:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483363;
	bh=aJBhqLkBwb4yvuEypiYyoVhdKgEw4V7w2elPmnAG+JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoN9btCqDM1rIjhagwaQT27aILpZlXEHM4/qJ7eMkV8JDlJiSpiV0iQv5yziIFs3+
	 3RYl2dpuzm6ggpvITv4H7ow148MIvl/uqAs3yBoGmjRRpCYbQsy/lqWsxVkp8ae9dx
	 +5Uk4vYKiB8cH7hU1Rd3VJ+6x79cEGb6qIlvEqVuocsdtEsRU4ID0HpX06Vu4V8uPd
	 y8k+bzrezx7BISfF7JbznHe0pdoTWodySaGcZmOvhMCWjyniLH4uZQlYyRysPXS9HA
	 6D+GoAi7u1XrKm6FV3YJsSu6tBqkk6lCRxgfAYh/Z0KkY7MZq+tCGGUIScy8gxTzcm
	 x4ftSh++CsTCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bharat.kumar.gogada@amd.com,
	michal.simek@amd.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 055/642] PCI: xilinx-cpm: Add cpm_csr register mapping for CPM5_HOST1 variant
Date: Mon,  5 May 2025 18:04:31 -0400
Message-Id: <20250505221419.2672473-55-sashal@kernel.org>
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

From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

[ Upstream commit 9e141923cf86b2e1c83d21b87fb4de3d14a20c99 ]

Update the CPM5 check to include CPM5_HOST1 variant. Previously, only
CPM5 was considered when mapping the "cpm_csr" register.

With this change, CPM5_HOST1 is also supported, ensuring proper
resource mapping for this variant.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Link: https://lore.kernel.org/r/20250317124136.1317723-1-thippeswamy.havalige@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index dc8ecdbee56c8..163d805673d6d 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -538,7 +538,8 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
 	if (IS_ERR(port->cfg))
 		return PTR_ERR(port->cfg);
 
-	if (port->variant->version == CPM5) {
+	if (port->variant->version == CPM5 ||
+	    port->variant->version == CPM5_HOST1) {
 		port->reg_base = devm_platform_ioremap_resource_byname(pdev,
 								    "cpm_csr");
 		if (IS_ERR(port->reg_base))
-- 
2.39.5



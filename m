Return-Path: <linux-pci+bounces-27235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CC5AAAC9D
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5E54C589B
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C92FED04;
	Mon,  5 May 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Z+ssIn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41542F4F52;
	Mon,  5 May 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486961; cv=none; b=hP4YNjzpISPtyOA7hhtDJmMW/rHCtYqIPYXhgjD8Rfo+iA47kpETRdu/93wPPEgvy0IZET0hAGXCqJax+dLm4MFMczHtkogXdxKJKUoU/Clr4qee9Td75LMBJN7PiHGah10+cIBoATIK5eYm2PXNqvWWi4LMdaf/mILoFlWYzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486961; c=relaxed/simple;
	bh=4CF8p/SGNJQs7tFPYOJpkOsU0jTsZmmINaE1h/xGbNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW38u9C+2H9xta7/5z/p/VK2zhZ4u0e17icKFLDseI2DY6LLUBWgxlruw7gyKpNGOYTFtI8a2VahhW0Nfukr+I5WH1RpZlPw0OEndOs2YCk6lw6dRLhFZL4fj+5ObjHm1DPoXASKo4TTmrm4FvP6XQs/qZRb2fXng8v5RXfcWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8Z+ssIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CDDC4CEEF;
	Mon,  5 May 2025 23:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486960;
	bh=4CF8p/SGNJQs7tFPYOJpkOsU0jTsZmmINaE1h/xGbNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8Z+ssInw1SAV8sN1wCk2eN38pBfzz91IXSDcvRcHAq76fxnRtb36xxbm1wciQJ02
	 WhpmvnaCcpBylpIKmHZaq4bvDCQM0X9N2ggJ+mTVcawA5BY083a1AMGdvU8TlGvKfL
	 S/4bbf4NX4DBLAZCOVQEnzPrfAUkeoGU3VflcbeQhO3jgjHKy/ZkzprFyuRApZWdvX
	 37mH2twf+KveTk5vKRJ+QP4hqWV8ni7TOJnqPy0iL++gxOPpSMpg8v97wjEPFjprIy
	 mWyR0tKsouAde6/kvI60MEGe+cPfRJwhcfvPFW7S6HXWzrlMskhaocUVNrtMPyVS8d
	 0dpSvOVFs/F8A==
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
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 080/153] PCI: brcmstb: Add a softdep to MIP MSI-X driver
Date: Mon,  5 May 2025 19:12:07 -0400
Message-Id: <20250505231320.2695319-80-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 7121270787899..e984b57dd0d89 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1352,3 +1352,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
-- 
2.39.5



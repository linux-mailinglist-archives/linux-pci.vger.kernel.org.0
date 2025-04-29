Return-Path: <linux-pci+bounces-26995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0DAA0B43
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 14:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322DF3B3887
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372A2C17A9;
	Tue, 29 Apr 2025 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bNJhQN+S"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66B2C2589;
	Tue, 29 Apr 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928711; cv=none; b=u3OqYx61IliyPIFLJhRe00JmfQzenzjyJSSTPFQO4VceM9Ex1uOyahaWPQ1jDgRKQ6i9JLC7OBCsnS6xL+uNUzayG0I2VRTYxMmdMgbQJ0lm824z6xkYzXdFl9gti/1x+6VSNmS3hJgNxoeKyDH3NIiGZuXXh5DJL7X5w/Uhs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928711; c=relaxed/simple;
	bh=ClPZna7i5122Wr09xYbtgoqUCmhyRpCbBMozYYurono=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hw23mJ67pV90FRNQEpenCdzFwBJmbuUQdn0MoGZHgAbmQAmaRE+dxv9ZoC8+L0SihBmAUeObPDmcwv05ozyd2RuhHLXEUp1u9yISAtS7hVxZI9/vusKYnFPuoZMBpRnVz3aoA0PkgD08ILieQNNfzu/e82gWesKghl5mlI7Ib10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bNJhQN+S; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0l6Sm
	MR9BzhKNVS+UMt/7W8m+RHOtktucSCIuVkRrGU=; b=bNJhQN+S4PJO7yOxwi7JQ
	I3uu4TnYFgFsLDS8GBN+9SoqTkinmuD/1OjApfTeN18rCWmkMiXlPrIAsJEX1HPx
	8qio/IyUfMuMq/ZZDoTUGoKhncK8C2xAt2TpEjRLC8xz6rVniY0VD9UOvGHLvMVd
	NZZyDFmGJYF7/giVV8hpAQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHUkXjwRBoU_m0DA--.22532S5;
	Tue, 29 Apr 2025 20:11:22 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org
Cc: cassel@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 3/3] PCI: cadence: Simplify j721e link status check
Date: Tue, 29 Apr 2025 20:11:09 +0800
Message-Id: <20250429121109.16864-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250429121109.16864-1-18255117159@163.com>
References: <20250429121109.16864-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHUkXjwRBoU_m0DA--.22532S5
X-Coremail-Antispam: 1Uf129KBjvdXoWruryDKrWxAr1kJF15ZFW5ZFb_yoWDArc_ZF
	1rZF4IyFsrurZIkFy2yF4ayFyrAayIva12ga93tF15AFyxJr4UCF1UZrWDWa4xua15AFn8
	Aw1qqFn8AryjyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUBbk7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwI+o2gQwOcdMQAAsj

Replace explicit if-else condition with direct return statement in
j721e_pcie_link_up(). This reduces code verbosity while maintaining
the same logic for detecting PCIe link completion.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ef1cfdae33bb..bea1944a7eb2 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -153,11 +153,7 @@ static bool j721e_pcie_link_up(struct cdns_pcie *cdns_pcie)
 	u32 reg;
 
 	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_LINKSTATUS);
-	reg &= LINK_STATUS;
-	if (reg == LINK_UP_DL_COMPLETED)
-		return true;
-
-	return false;
+	return (reg & LINK_STATUS) == LINK_UP_DL_COMPLETED;
 }
 
 static const struct cdns_pcie_ops j721e_pcie_ops = {
-- 
2.25.1



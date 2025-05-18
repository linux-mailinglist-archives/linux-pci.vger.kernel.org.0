Return-Path: <linux-pci+bounces-27926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156EDABB9B5
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4969C1B61A2C
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AEA26FDB4;
	Mon, 19 May 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L/RVJ+Wm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279526FDB6
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646961; cv=none; b=gAPGIbYYlFD2m5Wh/eoX9kDNLZMbeAdL1tlNhWTWj2tYUAUOK/xptBB3cqSPOj+ogbNB+EwAYCtSX3OY5LoKx0h3Od7WJsJpAh6X6/YJGF6WwmVCbFHL8dmNK/qWMDC7Jgs8f4F8VQ10ViejZuEabSucRfPGVFtiUugmhelXejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646961; c=relaxed/simple;
	bh=DjgRCEdJ83elEzSvGykMTo6aeQJl5+Vqze7Lag7Gvho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=CXg+2SYwxC/ZLv1otGlfaxg+IZ1X1XxC6q/Yj9QbjXsalOB0Z72+CewR7LXwyU7DCYn+H4xDd7+FbVS4twQ3SbX3WXls1qfK3Q8ueSUOWe+5pbAljPHsLU4iWZQatxYCYCMQqllfk5+TzQND9b9cpkqNsfcXwN5tOwRjWMXtlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L/RVJ+Wm; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250519092917epoutp020424e65a062ccc26db3dc3ba9385bed8~A46YACWNg0670506705epoutp02g
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250519092917epoutp020424e65a062ccc26db3dc3ba9385bed8~A46YACWNg0670506705epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747646957;
	bh=hyCYV5tKTc12SwshmyJzcHUJ5CSInB31JwFZiJ35RyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/RVJ+WmnF96JHVNFe0+ng4FE/5lFVX1zpPcfpmzNf6Z/GkFcrcyAVS3WhTpWt2Fe
	 hSHqQHohli5Crd13u3La/XW1wX8F3DH4STiUQKJXdbg9hyzBrLHSPTj0gWcwiC024t
	 lX/7K9u7WpNMdswguMCxZazFOiO92oJspsqb0hto=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250519092916epcas5p1f944d982a0b8d7b7f94b8e9145e1268b~A46XDOp1s1962019620epcas5p15;
	Mon, 19 May 2025 09:29:16 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.183]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b1C7G1Yrdz6B9mJ; Mon, 19 May
	2025 09:29:14 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250518193230epcas5p3dfb178a6528556c55e9b694ca8f8ad6c~Atfwy15Xp1682016820epcas5p36;
	Sun, 18 May 2025 19:32:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250518193230epsmtrp184b5daf49957acd8fd047704d2f70457~AtfwyAvh82445124451epsmtrp1b;
	Sun, 18 May 2025 19:32:30 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-61-682a35ce3ed9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.39.19478.EC53A286; Mon, 19 May 2025 04:32:30 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193227epsmtip1824ce2e47b768b1b9d1560fcc5809d57~Atft8GoVD0974409744epsmtip1f;
	Sun, 18 May 2025 19:32:27 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, Shradha Todi
	<shradha.t@samsung.com>, Hrishikesh Dileep <hrishikesh.d@samsung.com>
Subject: [PATCH 02/10] PCI: exynos: Remove unused MACROs in exynos PCI file
Date: Mon, 19 May 2025 01:01:44 +0530
Message-ID: <20250518193152.63476-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518193152.63476-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnO45U60Mgxc3WSwezNvGZvF30jF2
	iyVNGRZr9p5jsph/5Byrxc2zu9ktbvxqY7VY8WUmu8XR1v/MFi9n3WOzaOj5zWqx6fE1VovL
	u+awWZydd5zNYsKqbywWZ78vYLJo+dPCYrH2yF12i7stnawW//fsYLfoPVxrsfPOCWYHMY/f
	vyYxeuycdZfdY8GmUo9NqzrZPO5c28Pm8eTKdCaPzUvqPfq2rGL0OPJ1OovH501yAVxRXDYp
	qTmZZalF+nYJXBlXtq9kKpjDXvG/o5WlgXEWWxcjJ4eEgInEtctnmLsYuTiEBLYzSjz/8IQJ
	IiEp8fniOihbWGLlv+fsILaQwCdGiaa5FiA2m4CWROPXLmYQW0TgBKNE3y1LkEHMAvOZJRqa
	v4E1Cwt4S6x495wVxGYRUJWYs70FLM4rYCVx7OlboKEcQAvkJfo7JEDCnALWEtvWT2WC2GUl
	sfDJTkaIckGJkzOfsIDYzEDlzVtnM09gFJiFJDULSWoBI9MqRtHUguLc9NzkAkO94sTc4tK8
	dL3k/NxNjOBo1Arawbhs/V+9Q4xMHIyHGCU4mJVEeFdt1sgQ4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYCpYl/vJ5syNgIY7jZns8a0JIatnvN93/lhE
	0LU8Uf1NQdwX7lj+U598WTXZcMWFvD9z1l+KDoo3sHj9w5GVTW3Hvz/6MwSrfTNZ2b/ozfx9
	kn/WhdZaoYY/eyJv8B1Qtpqr8fzMqfoZPcIFns3Wp7RsTHa2heilqJb7L2E6Nzf1n2/sCfmP
	HkZiAeo23o8ybn9v8Xr3dqJ9/s3f0ws43bSrth9KWDYj61iRTIZXSqm4i4BDpOWWlseuO5Nm
	bT8hG3tjWd22iBn28cVff9w4duMbWx1TZ8kLH7G6XVk7u24zSLUt58qYt9L53P43YXdO1ZUk
	6ybNbFTa7DJd12/9zRV1BznUJk22/HTE1uqflxJLcUaioRZzUXEiAOa88Dk1AwAA
X-CMS-MailID: 20250518193230epcas5p3dfb178a6528556c55e9b694ca8f8ad6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193230epcas5p3dfb178a6528556c55e9b694ca8f8ad6c
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193230epcas5p3dfb178a6528556c55e9b694ca8f8ad6c@epcas5p3.samsung.com>

Some MACROs are defined in the exynos PCI file but are
not used anywhere within the file. Remove such unused
MACROs.

Suggested-by: Hrishikesh Dileep <hrishikesh.d@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 1c70b036376d..990aaa16b132 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -31,8 +31,6 @@
 #define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
 #define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
 #define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
-#define EXYNOS_PCIE_IRQ_LEVEL			0x004
-#define EXYNOS_PCIE_IRQ_SPECIAL		0x008
 #define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
 #define EXYNOS_PCIE_IRQ_EN_LEVEL		0x010
 #define EXYNOS_PCIE_IRQ_EN_SPECIAL		0x014
-- 
2.49.0



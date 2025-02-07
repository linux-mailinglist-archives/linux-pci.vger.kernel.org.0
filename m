Return-Path: <linux-pci+bounces-20882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB094A2C0B6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20FB3A7C53
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA391DE3B6;
	Fri,  7 Feb 2025 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FjZdW4L/"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3A1547F8;
	Fri,  7 Feb 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924735; cv=none; b=Mvh1q47BpPEXhWia0OiwOQrfxhH3m/2Rjj84fZ/DJAZNL1d4hST7ecQLCmP4qwIwtVUkIyzZKTwVMtxlVK1oZJE3rcviw9hsOrUJciX4QYpYNddgWpvHEM/03fzzlneiXF/xeJj0dnwIP+6Lnbk81amrJb20lHMcAW7/EDIJXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924735; c=relaxed/simple;
	bh=AjQmVnWtw8F5HofRM0sXBi7i5Mahhq6ucirVF6AS0rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSbFBKIurQD8w9or+spIuu4X8+p8gBhY8P49lookIM4G+Sc4ZTW5S6LKxbGbfqTW7ErlV4aA/7RDzfGLm4x/DA69NLMiE2OhA7yVRKLRqrb/UnMk6qpKo1Fm7+7HEsLF6KBTuLBNaNJpiefcGQBBsxfZQ7+ECVj8XxGMeMsI0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FjZdW4L/; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XeFo3
	i6QthcUbUcb1/Cr1T2tbBVsvF+gxHzd92ZIAMs=; b=FjZdW4L/fXB1Mn49dAyv7
	KrpQTWcAbkdfi0rvIPb3cMvW/dEWMMxypso0t7spHhs+EieFOmc9utIIVuVqiO7q
	F1atWgcx44qSbzeVoNM5NgCIkY5Eo3kSOucTGoHHZZnUF4VSc17LhQMfBGPKQCed
	mRMV0VDYC3FdeK728whoIM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHBVuI4qVn3ILoKA--.28738S2;
	Fri, 07 Feb 2025 18:38:02 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	bwawrzyn@cisco.com,
	cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>,
	"hans . zhang" <hans.zhang@cixtech.com>
Subject: [v2] PCI: cadence: Fix sending message with data or without data
Date: Fri,  7 Feb 2025 18:37:57 +0800
Message-Id: <20250207103757.31958-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHBVuI4qVn3ILoKA--.28738S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr13Cw1fJw45CF4rtw48tFb_yoW8CF1UpF
	yUGrySy3WxXrWavan5Z3WDWF13JFn3tF9rJw4v934fuF17u34UGFy2yFyrGFW5GrWvqr17
	uw1DtF9rGF4fA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE4E_JUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwrso2el4eYKdAAAsl

View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
Registers below:

axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.

Signed-off-by: hans.zhang <hans.zhang@cixtech.com>
---
Changes since v1:
- Change email number
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
 drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..0bf4cde34f51 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 	spin_unlock_irqrestore(&ep->lock, flags);
 
 	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
-		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
-		 CDNS_PCIE_MSG_NO_DATA;
+		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..39ee9945c903 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
 #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
 	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
-#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+#define CDNS_PCIE_MSG_DATA			BIT(16)
 
 struct cdns_pcie;
 

base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
-- 
2.47.1



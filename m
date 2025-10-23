Return-Path: <linux-pci+bounces-39141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12064C010D9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 14:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC9F6508A2A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6830FF20;
	Thu, 23 Oct 2025 12:13:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A84311C15;
	Thu, 23 Oct 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221607; cv=none; b=E/gThOTvxtEp8gBhl/raUFJoXJar8t49argCGUSnFnDgpnZyWE/OnrMvX0CHLiwWwfZXEl0dRfwVe+8xJQSmYe/F3Cv4NiD8adyNvWAYmWGq7O4rhv8MQP0kE57/jBmd3hMSd+rzHHHpKLXk15uZbzH1pWVn7hLVeiUHYLif+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221607; c=relaxed/simple;
	bh=xU6nY5nIW50uvgpEnX6GNOjl4w/8ijNw+CyrECbJLiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDN7yJ40ydrS7AZ1IJeIPh3FZGjJbIShPxxMSwafnfKaF7KHtCIb1rchmE8QUupIrSy588llF/sTLgXg0vyIwJskEt0DqUcuoMnaWIwHjnBe2K2tku9T9ShDuYu9jkXToZN0RQB9fvH8uFc4PrSZx6CHJckN9Utr9gNIFD93P88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 59NC9hWC039378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 20:09:43 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Thu, 23 Oct 2025
 20:09:43 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v9 4/4] MAINTAINERS: Add maintainers for Andes QiLai PCIe driver
Date: Thu, 23 Oct 2025 20:09:33 +0800
Message-ID: <20251023120933.2427946-5-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023120933.2427946-1-randolph@andestech.com>
References: <20251023120933.2427946-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59NC9hWC039378

Here add maintainer information for Andes QiLai PCIe driver.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25463fa36508..d21af8c3da0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19603,6 +19603,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 F:	drivers/pci/controller/pcie-altera.c
 
+PCI DRIVER FOR ANDES QILAI PCIE
+M:	Randolph Lin <randolph@andestech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-andes-qilai.c
+
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
-- 
2.34.1



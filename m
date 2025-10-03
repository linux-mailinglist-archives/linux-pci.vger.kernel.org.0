Return-Path: <linux-pci+bounces-37501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5287BB5D17
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 04:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F29B3AFE73
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D52DC771;
	Fri,  3 Oct 2025 02:40:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE672DC33B;
	Fri,  3 Oct 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759459233; cv=none; b=jvuEt6+Gnsp4at8JI1a77ZxBi4sR4jB2Np9FNHV8U4bU04tqz9SwVa2/UZihj6izf/c6zNtMNPICY9ZalhekNjwR3f6+ztQuCAKgxv35y+3S0OuoAFbnBc24OMdlk/4Cqd8D/xay9FAfkAdLkR7zz/vKduoSL+OP7MJkvirU88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759459233; c=relaxed/simple;
	bh=udodIbL6v5L3ARkdqtvidUF2a323b6DgbAovYb/w62k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ai/CylZv1eD6OJqK0JS+b7UVhNx+WzcgusLJzv4akmN5+cYBbnHACBYE4+aApUNxf9LPRWXeDhgRqziw7ypptO2PBZS/dE6uCSJKcacPkzF3m23F5dUozv3w/Tuilg0jXWxc5/lJ158hk7y17jyeV/7pxPG4J7pxgL+ykllrx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 5932Zgjx070324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Oct 2025 10:35:42 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 3 Oct 2025
 10:35:41 +0800
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
Subject: [PATCH v6 5/5] MAINTAINERS: Add maintainers for Andes QiLai PCIe driver
Date: Fri, 3 Oct 2025 10:35:27 +0800
Message-ID: <20251003023527.3284787-6-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003023527.3284787-1-randolph@andestech.com>
References: <20251003023527.3284787-1-randolph@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 5932Zgjx070324

Here add maintainer information for Andes QiLai PCIe driver.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49aace3381cd..6f6021863e7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19401,6 +19401,13 @@ S:	Supported
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



Return-Path: <linux-pci+bounces-31709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B459BAFD566
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B75564BD4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C62E6D30;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk6AEc+p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2782E6D0A;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996051; cv=none; b=FBTuuNZp4DRP0jiS041vnd8a9psh5uEu/GJnSdbdKzRFQ534wzHKeSORbUf0DydbXbGWfmpQ7ul9gC9QoHKpokQ5jE3t82BJLtONHcQwf2M4v9Tm1zA8/voB5T0ELSXthCljb5NWS+XVRWiZvimd+Uw++3orYQ4bWIfsB/U3fiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996051; c=relaxed/simple;
	bh=zWAmwKnV6f1cwbtaUPgrJ1lIE+Rc2XJQ33KR+f1+GBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tc3ilkt5pJE9/R15uxyQUshoAHScteWBP6aNV2kq+0wrpMUS6FDSXVpd5neqyiQmjrOk3sAXDo0bmhcV7ip4Vtenvj8y48sUA+TaNlfzXMsb9NjGPYMJt8K61FrAU0Ykd6WUUBsWmZw68pWhGhqOClqIi9SlpL1+p0cdsIz0R2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk6AEc+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748F6C4CEED;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996051;
	bh=zWAmwKnV6f1cwbtaUPgrJ1lIE+Rc2XJQ33KR+f1+GBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lk6AEc+pwSSa+6W1orB9UPtYr+5as8dQlcw92PkFHIS9ReJX4+jIoRaoNLr8bWezK
	 24hexua/XsO18wygcvBn01f2hMKsjWl57Es0lBicNtMBk5NjcAjusqioZQSqop7z6n
	 WAN7jspqfMTFam6mkvcxJVISPIo+e2NoRJoBbD2AISWrzl7IJq68Hr8rPmalWtkP2f
	 KkX31v8A5O5ky7TvJnvk+MlRLNLOyMzghVn6vqRYUamnSKYjLbCSDrchGyBz8Ejo5/
	 HhndG0C7xCxtKycWWmGUo172CXRemaj7NwZbgKAeaPYIpazxAWiK6ZmblPx0xXRQpY
	 XNPzgMNdNijJg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCn-00Dqhw-Ch;
	Tue, 08 Jul 2025 18:34:09 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 04/13] PCI: xgene: Drop XGENE_PCIE_IP_VER_UNKN
Date: Tue,  8 Jul 2025 18:33:55 +0100
Message-Id: <20250708173404.1278635-5-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250708173404.1278635-1-maz@kernel.org>
References: <20250708173404.1278635-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, toan@os.amperecomputing.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

XGENE_PCIE_IP_VER_UNKN is only refered to when probing for the
original XGene PCIe implementation, and get immediately overridden
if the device has the "apm,xgene-pcie" compatible string.

Given that the only way to get there is by finding this very string in
the DT, it is obvious that we will always ovwrite the version with
XGENE_PCIE_IP_VER_1.

Drop the whole thing.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index a848f98203ae4..b95afa35201d0 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -54,7 +54,6 @@
 #define XGENE_V1_PCI_EXP_CAP		0x40
 
 /* PCIe IP version */
-#define XGENE_PCIE_IP_VER_UNKN		0
 #define XGENE_PCIE_IP_VER_1		1
 #define XGENE_PCIE_IP_VER_2		2
 
@@ -630,10 +629,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 
 	port->node = of_node_get(dn);
 	port->dev = dev;
-
-	port->version = XGENE_PCIE_IP_VER_UNKN;
-	if (of_device_is_compatible(port->node, "apm,xgene-pcie"))
-		port->version = XGENE_PCIE_IP_VER_1;
+	port->version = XGENE_PCIE_IP_VER_1;
 
 	ret = xgene_pcie_map_reg(port, pdev);
 	if (ret)
-- 
2.39.2



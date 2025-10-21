Return-Path: <linux-pci+bounces-38888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903BBF67EA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA25188D24E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E233343C;
	Tue, 21 Oct 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEm0zSa0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03205333427;
	Tue, 21 Oct 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050486; cv=none; b=FdKPo4/HDQ4PY2ZpP8lvmDQF2afTjy6X9xSFqtJ3sHTWP/0KEtGcPfTW/XswfcZ7JfUg5u8lpleFwRPtDtDyfu9zrev+Kw2ubpVGv4G1tjqp42bi0u0TGL9ExAE8dXdUCqu216kXbgFYTr1XL99N0ZgOhIoNSkBoU7g+mSz8D+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050486; c=relaxed/simple;
	bh=ZdCUUMchR3IZHrUpOETZdGuUsxzbyMb4ecC2yoA5/tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKiSj3VXnxqt7UNWu82CM5xVp7OKg3tqbiJxl03Zz80wbaiE/eS8bQUagp4M54lK1BSOzIHOqFDg+Mhy9MrC93eUAdrjRGabs9hAGnwep9wwo72kdiHJdw7A76ci1852V8KIdIf6hG/pudpbrk0Xpn4ThhwTm1UMpboO6j8UT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEm0zSa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E432C4CEF1;
	Tue, 21 Oct 2025 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050485;
	bh=ZdCUUMchR3IZHrUpOETZdGuUsxzbyMb4ecC2yoA5/tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEm0zSa0zJ6EnD5StWuKbGLFC0eDn3fHQFlf+4FSbpIc3KBJcWeNm73cMpaaEAeXn
	 itPOwyLtd+G0Hq+qMxmqgbtN65fSldGQxAktR0BI6Ohaeb4+1K8trUVYPApig3HGZr
	 S06gptoO3CVkhIDPrNUeLHu877VE1DXIEZUI6KAbNRT0zGlNglCfiYjCyQMZYTlL0m
	 moEJ72WdLXOkCib/2IiRgFpkoqJ0GPPGokkp2RWmKqpAjvGklHU5Og1FbyK+SqSFb5
	 bgtoqBx9nFkNwXTzVDW/r6Mspx8Ro3mm8hr3W6j43W3lCqHhUAwDhUerFklH6ckKBs
	 aIsEl2zXnKLqg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 3/5] of/irq: Export of_msi_xlate() for module usage
Date: Tue, 21 Oct 2025 14:41:01 +0200
Message-ID: <20251021124103.198419-4-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021124103.198419-1-lpieralisi@kernel.org>
References: <20251021124103.198419-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_msi_xlate() is required by drivers that can be configured
as modular, export the symbol.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index ee7d5f0842e8..1cd93549d093 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -733,6 +733,7 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 	}
 	return id_out;
 }
+EXPORT_SYMBOL_GPL(of_msi_xlate);
 
 /**
  * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
-- 
2.50.1



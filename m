Return-Path: <linux-pci+bounces-30035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5B0ADE86D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA734169F9B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B9128751E;
	Wed, 18 Jun 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHB7OwA+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD225286D6F;
	Wed, 18 Jun 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241921; cv=none; b=NU+8nrr/sWGsV5b/8qrCJrNi7v7/pWd8Fj9+bckMokG0g83ugNUWNbsCZROrDhX6TYyCrlp3NiiCPyGhiQ0okoeF6+OT3gsRHcBhLtZ2EC7O39wCOQ1qdasemzvFCJ0tQ8EDFolACfMYrimsQ7QZgS/ClqEx20SHsrQzQtNGo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241921; c=relaxed/simple;
	bh=GGu0BlNfPd3BbcRNatWFSy8vlHfdSkuub7faaglQhI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSiaV0UUNXP0qdPbxzpmTIFLFkXx/D/L3Bvr4RESxDZGjiEnJjmCxiaJ6r7anQGWtrzfwzuB5t1cR7Z1o9v12ZADpk4sskLrZaYla+pYLBle3w1UA+1e8g3uvDSLv6Pm4/oiiJGIRC0imHpjddFueg+uMHtKA8K1XWUmUIHdM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHB7OwA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609BCC4CEF1;
	Wed, 18 Jun 2025 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750241921;
	bh=GGu0BlNfPd3BbcRNatWFSy8vlHfdSkuub7faaglQhI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FHB7OwA+w8SnABB9cxmbp8iqjI0yAtqXbo1FIAmvIKU9lpEM9oUTScVdLB7EzFjMZ
	 79KbO5JZ+sgM1YLaSJMLxHIJWJ+QXhR1BBsZQQGRxa4wbAsfuBHup4QX7U6rCuopp/
	 aUA40BTrzzA7q6t5NGMQru/NbLhe0NSijZQUXe2gTLeMiQuncoaZwm5xe5vueLCFJB
	 d7/vWweKD/unZWpvx6idw+XWJ21Il2Ya3Crnwey+l8z3mGNTa3sBlhL9YTmWYyxpZR
	 TFreasDfb8scOXtwzUBZNMvRkbxF2fvZ9ZcOPR11mCl6VNx0vbec3MN38hW/biD/9D
	 6E12hOmOEU3PA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 18 Jun 2025 12:17:25 +0200
Subject: [PATCH v5 10/27] arm64/sysreg: Add ICC_PCR_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-gicv5-host-v5-10-d9e622ac5539@kernel.org>
References: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
In-Reply-To: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

Add ICC_PCR_EL1 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index ebbb22ed2301..5e15d69093d1 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3527,6 +3527,11 @@ Res0	31:1
 Field	0	EN
 EndSysreg
 
+Sysreg	ICC_PCR_EL1	3	1	12	0	2
+Res0	63:5
+Field	4:0	PRIORITY
+EndSysreg
+
 Sysreg	CSSELR_EL1	3	2	0	0	0
 Res0	63:5
 Field	4	TnD

-- 
2.48.0



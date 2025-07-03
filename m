Return-Path: <linux-pci+bounces-31382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E6AF7071
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080783BA129
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AB2ED86E;
	Thu,  3 Jul 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYiDKkib"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AA2ED85C;
	Thu,  3 Jul 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538486; cv=none; b=LPqSgm2gEMaaH1ZaVRJGK1Vj9fOTMt93+B2Chd54yqVgHMVdpYeoKd8jd1YxbNUFLawQXLR3IH+PfL+DrYx4wuZT3VijnQl6EwSjC9UATQt44uLUNYx0eEA+zxi2MnpMgqPseb6wTS99AglB0g1cqrgbV+HSu/WyKTpeGKf1Uxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538486; c=relaxed/simple;
	bh=W/C4b3BY2gqbZVQ+W28M+ecYH4Ph9mXAsDV/aos0XlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hxq7PV+5Dpb3eH7USfuqlCqUeyQ7nt171xdmHsM9WTLEzMCbAiYGzl0byawlTkLWzcWR3aFLPuYdvX7B2E0ZrPuky9qIZzrepHqqK5Eok/TZfExOQMtHH5mJYszjCXulFZ44dx9mKq8svzuXjbkZ8gvpdoclhiucaOML2YwZ+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYiDKkib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7968C4CEF3;
	Thu,  3 Jul 2025 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538485;
	bh=W/C4b3BY2gqbZVQ+W28M+ecYH4Ph9mXAsDV/aos0XlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BYiDKkibLsr7oj7tfP/jdvaECF/8F81Uy/9i2B+qpAnJxPYXfnIsDLx4NqEIRwX7A
	 IboCL3ZHok1OqAFcIh1nOQRCR00oAOAFyJsP4PzKxO6NcTp72Q1UYPH0lv55YnJSHc
	 7WnYXWeHvfQlLAjG4OVls66xxXjLpGAdH4RlotAfvyFbVxxck4UKPxn280Bjvx6ZR7
	 fdBYFzE+I62ByCsMK66f73g0ZPBF3PK3+sa9PoRI/p2yWSs+MLGUz18HBQOiQTBl77
	 zjz8QTE3VgxQwpX6FMpbx9euTFaWgXPPGqziLKUjrTWTgsEepktLdWg+3xwp0PzJrO
	 cH9oLSjwlaFgA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:21 +0200
Subject: [PATCH v7 31/31] arm64: Kconfig: Enable GICv5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-31-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
In-Reply-To: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
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

Enable GICv5 driver code for the ARM64 architecture.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 55fc331af337..5ff757cb7cd2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -129,6 +129,7 @@ config ARM64
 	select ARM_GIC_V2M if PCI
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
+	select ARM_GIC_V5
 	select ARM_PSCI_FW
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS

-- 
2.48.0



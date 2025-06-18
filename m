Return-Path: <linux-pci+bounces-30052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21ABADE8B3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E266A168608
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DA12E4241;
	Wed, 18 Jun 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlNAm78g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4082874FD;
	Wed, 18 Jun 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242014; cv=none; b=QAKlkjezwCA9XJ9Hjhwz7fCtTZVWUcBuD3RiAGCmbLgRMBKc3gc9mfnqGbX7+G1WG2TOvJbu2YaSIKOgEEeuh521aDpDZCTiI1QkqLWJGTwR5M3QoHk8i1pwG0Muupdzy72AM8bDwO0l0IlUQqnBQxsN5un0YAmRR/j9pK58OAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242014; c=relaxed/simple;
	bh=AE5qEvFqtJU+4ZCRYFV782k0O7SoTYBIs/KLVihEjS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YE5ya3I2pEzeUEEnZnCzeVmMuyGGs8QvCbkC9IDfnRhvsxlDqH5hC3fak8DCTP8svCKEGREBkl7/9dAKdSQXelxCS8+1J5eyR3pvvwLNK0KJwTR0Pb9PiJ7/iUNCLpCEFI3Mutgw0Xj3QJuvoHQq4UEwv9gzu+2EEF+YybtJD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlNAm78g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1053CC4CEE7;
	Wed, 18 Jun 2025 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750242014;
	bh=AE5qEvFqtJU+4ZCRYFV782k0O7SoTYBIs/KLVihEjS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WlNAm78gfHAsH6aPCOzZfZbZI/gpFgIvlOyCbVMipzWE4wv7R/TR51Mg2ah5obRuW
	 cPfJpcamlN93IzPjJuxUM6IE599nUxgX947WWz51rNEtTxSQbCygFmV0iK64fCdg3z
	 8ovKrXxjS9gI9SEeanUbHDUva6GdwFjFx4cxIZKrIAhXWmt4DqvXjeJjipeZtgl/8x
	 QWm6rGysJ5VkiO8N0verNrurhzn79/cOwsWZ1NHgJ8y1i7Z5fV+OISnaGQ2mTiMXlA
	 yTF7Ud4++YhCnO09whvXpisZj7NOUd0b4qHzvGlxpIKcbFYh+9n9wDmn4fY84bU4W2
	 aNEx3mm8p/m7Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 18 Jun 2025 12:17:42 +0200
Subject: [PATCH v5 27/27] arm64: Kconfig: Enable GICv5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-gicv5-host-v5-27-d9e622ac5539@kernel.org>
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

Enable GICv5 driver code for the ARM64 architecture.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
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



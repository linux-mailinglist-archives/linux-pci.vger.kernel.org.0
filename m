Return-Path: <linux-pci+bounces-31353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2213AF6FFA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3CD3AD354
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3D2E336C;
	Thu,  3 Jul 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTC92IJd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BEB2E2F1F;
	Thu,  3 Jul 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538324; cv=none; b=sWGDDoaYuQWAsCneXC8W1eCZY88DcOPdRQ5OqUDuRKw7YzdA9e0F5EPy+bTwCUMhpZVDhaX7eTPdAkvJRrm9JxUP2ESWipK2Oz/6lE1Qyy6S21qE51JqiPBNROVhtNlxRBXaY2kDGPuiAaVwoj4nW49wYFIoPoeI6r3HG3Y5sgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538324; c=relaxed/simple;
	bh=DVrlQl7knEfTTRJf6B4kPW+doH90DFZNcs/PwxMLaDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0E7GS52LunreiOxIe4Mk59C9pQN9/vNM1t3SyjioGu2BP3IVQQpGU41kq0tiCMbfaZxnhkoUe1ZneIYQm/hpnhBQnPvfWk8yrBkirhksdLygH7EX7HkjcG2Y+27FykzYJjVIPGRbO/DI2yqMgGVANkVKBwj0STE3ydh7wd6jNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTC92IJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30097C4CEE3;
	Thu,  3 Jul 2025 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538324;
	bh=DVrlQl7knEfTTRJf6B4kPW+doH90DFZNcs/PwxMLaDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gTC92IJd8oeqpHpKuv9FODRFNo+kmATOj63So9/UbUd50BFsXN5UXWpnr4lt1h9K6
	 +IZgSRlOs+zcdPK7JapvprVqv8xBykup/74g1CX/YmYrPyDaJYXo0GQS5rumNBqq89
	 jgUs+9SbBAAXuBJkA82GfOYEspn6DUgPXmUZvg+lt9tkMz2oejNSCxpQ2WwtP3NycP
	 57n6LgYAUrmAoVGMPeWVKzXZ+39/dYvqNc5QRv721JR1PN7ODqMdqYv/QvEIeNF8p/
	 P3Tw1FUV5e4fXVMk82boBq6VgOuLG/IuHu3rvpzFu1in66s5FE/FFZ23YhnSX6aAwz
	 Is8Ne/3ZhYLDQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:24:52 +0200
Subject: [PATCH v7 02/31] arm64/sysreg: Add GCIE field to ID_AA64PFR2_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-2-12e71f1b3528@kernel.org>
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

Add field reporting the GCIE feature to ID_AA64PFR2_EL1 sysreg.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8a8cf6874298..fb5bddc700b3 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1314,7 +1314,10 @@ UnsignedEnum	19:16	UINJ
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	15:12
+UnsignedEnum	15:12	GCIE
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	11:8	MTEFAR
 	0b0000	NI
 	0b0001	IMP

-- 
2.48.0



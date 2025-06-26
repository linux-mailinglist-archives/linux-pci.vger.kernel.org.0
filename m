Return-Path: <linux-pci+bounces-30708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FEAE9B2F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCD13B32A6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221A25C70D;
	Thu, 26 Jun 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVwNLxNn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925823815D;
	Thu, 26 Jun 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933598; cv=none; b=WR76FVxFHR9zAA/FkAyDX3tXvtstYsIzh3vBI3NHZLeSp1THlciWD/PLeeCrz55+gH32qHGjtBgDNdiOGidCKb3pNrkhhYFGxzijGq4oz5KQk4Sv959/nAYPEoDEEIR6iCC0jRcLBx9D4uLg3xzC9D+W/vIf9nyAeVzl98U3nGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933598; c=relaxed/simple;
	bh=QNHkLfR6Ay7P8R1eJuPcNkSPmq37GNIrESv5YU/xMD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDHoGxCkoDnzF9Vn0fMCOW+BSgXE6iVonwKRQnyhnPeMliqXF+GX8m3+wYtpO3l8s18O8qVZwYzAwMZ3rXyVIKWC7VoBz7HaJyeNJqmN6wHSU61xpN5/ZdKQJMwDHSjN4qOyqGo/EKArDDXZ4GNyKqBIUzizfc3HnDfMsob7fJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVwNLxNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD87CC4CEF4;
	Thu, 26 Jun 2025 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933597;
	bh=QNHkLfR6Ay7P8R1eJuPcNkSPmq37GNIrESv5YU/xMD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QVwNLxNnhShbikBx2czV8ZnGv22dITUv4Lzzo8wqsD0qzVlRaLM76Wosqd9ttHQ0y
	 SNreQlHOmgcpEXTYciVz4KCmSZg8GpLioEIP6hyGZpH0EuA9ERFJnC6Ipjx1+h6Faq
	 cM2ReY9Kvy4anEtKJmVLrg5FMazHVjDFqtOdQrM4xjr0o3TwPA5w+qa30ZL/cV0+1S
	 qgn4izM7esjgqy3vhWOll8c9fJ4JnuwMkhEBZuDLsarFQSnF6eOiV5Pqw2Ln31Woqo
	 pkmWGRe/ffek7SAKNVRBIK8aWm1KhFeqZrjB67UIRmG3+fxQCit4l4cVNovusg4VLJ
	 50EOU6ceCitYQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:25:53 +0200
Subject: [PATCH v6 02/31] arm64/sysreg: Add GCIE field to ID_AA64PFR2_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-2-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
In-Reply-To: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
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



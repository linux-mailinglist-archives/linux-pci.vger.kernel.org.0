Return-Path: <linux-pci+bounces-30710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E98AE9B37
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF843BC726
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD824259C9A;
	Thu, 26 Jun 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9YUouQd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1481258CDF;
	Thu, 26 Jun 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933608; cv=none; b=TAQ2VGFANAzAGoOzHXNpe2B4vGjURvnJ/ep5otq5XUQ/zJfqOYQRtXMmNHRRkeLixj3tN+61jQ4LRhPz9vOeAjcd4ZlZCwFCC6uTKsEm5/ReXl6EKyJ/1WAltf1FuhwjVqdbWoOViagGXNMCm34u6zTXvBuy71IrgEpFbKYCyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933608; c=relaxed/simple;
	bh=tRKFfC9HrDSF598h4BQsZtNeEtZI1IT9Ixq8S352lh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJYSwMs/uD5H7gqhx67E/f4sYK9mlgbsN8n4cvVX+6MGk5noMFCRpRe4I/bYw9Af4cToPGwe9w6VKkJhrfUKTGW8RijiP0C60td2IJjuFSIHc4LmJeH3Vz0hwfuYFwF+XKPFlU0wMhBPJGIYP0HHjzFawcwYIdOmBYse0Gra5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9YUouQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E7EC4CEEE;
	Thu, 26 Jun 2025 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933608;
	bh=tRKFfC9HrDSF598h4BQsZtNeEtZI1IT9Ixq8S352lh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s9YUouQdw56PGfF6b9amz96v3ykt4m1wl5fCvmw5OvTpLkPnUOjpCG2oN+liTD0qx
	 MylsWrUVZfrcRpAkoPviDZUEvuv88VccACF8R14bx20illqAx1Sqz3R+l7asxkWBQn
	 Jj7W2Kttiq1liJBfAvDnIEC2xbNBwmxW5iY6yZMTaWf6G9k+EVaRrvzTHVxpotYA17
	 W4EMMZtfpJKAmb38r4fS9U2i3+Tzi9XHO38IEalTxvDb5IgTPV97CH+o08Ur+Vmd0e
	 Mq3YCrlaXARy0GHP6++jwpDGMAAueC24E9SCMKNqSSJ8GqVpLvMuCekhV8847YmFNQ
	 lX+3teZ8sVLxw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:25:55 +0200
Subject: [PATCH v6 04/31] arm64/sysreg: Add ICC_ICSR_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-4-48e046af4642@kernel.org>
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

Add ICC_ICSR_EL1 register sysreg description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index fc17e19a738d..81b32f567ce3 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3024,6 +3024,20 @@ Sysreg	PMIAR_EL1	3	0	9	14	7
 Field	63:0	ADDRESS
 EndSysreg
 
+Sysreg	ICC_ICSR_EL1	3	0	12	10	4
+Res0	63:48
+Field	47:32	IAFFID
+Res0	31:16
+Field	15:11	Priority
+Res0	10:6
+Field	5	HM
+Field	4	Active
+Field	3	IRM
+Field	2	Pending
+Field	1	Enabled
+Field	0	F
+EndSysreg
+
 SysregFields	ICC_PPI_PRIORITYRx_EL1
 Res0	63:61
 Field	60:56	Priority7

-- 
2.48.0



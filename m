Return-Path: <linux-pci+bounces-31358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ADEAF700B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53021C480C6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8E2E338D;
	Thu,  3 Jul 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgs424TN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A102E337E;
	Thu,  3 Jul 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538351; cv=none; b=iIsJaOm5jFbdRwI2CIKawCpW6Nr5Z82r5nHw5nv1KMD6TLlst2Hu0kOWofjjM3JLHrVXBb8hGtsimeBteInCXrWEaJgF+T6AmBX6ufsUjZzZYnPgzeDe3EfIFeCA7MIjIZGCmg/CTPUyatf6GOvYRCUDrR9Na3coaA/mbrkdC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538351; c=relaxed/simple;
	bh=chydQxXcGR8/rPWKQhdfhuVdKgKCKmATlQG6keW9CpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dYIbE9UvSEOuLTRltyiXDlvHsD/pYw3HY5P8cVu6P8qgXohhid0vEGWXT92fUGgVrf2cLREk72ECZCI/0uCe/rUQfLIYs3sfzt2y7LZ6rkEAUsYxXrpV0HxGJb34ZnDuf8c3Xcme3mZgwpMe5Q6RpgPvESD28xKhetSHgtSvbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgs424TN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910FBC4CEE3;
	Thu,  3 Jul 2025 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538351;
	bh=chydQxXcGR8/rPWKQhdfhuVdKgKCKmATlQG6keW9CpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zgs424TNZImaYIXJxO59cIEt8frm3mtcn4jc3rus1qqT/r5E748rvuZJdO1Isxybs
	 fByDxSeRWLeYBiZzQKssUqAtJIVCp2M4VbL6xEd0/NlBlV8phfQ/+o5jjAws5G81ct
	 NH8Z+cVpDVsGexOwOkY7NX67+z5MkAuyTJHAPJph8GAo/aTrKVoWmAcPlmAI+w4YYT
	 /gkZ2jGgx7vitU/aj8a+u61LEeWJa6EXIjm+Zq2erpQKczW7u+pPGFJnIqLowWb61i
	 y54Z6Lp8Jfj8Nlmw7NSu4MGAEN+sznUprgLFGFjLi9JJ5KPx81otbhjDL1geLpSwMh
	 FNiqyibHij9rg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:24:57 +0200
Subject: [PATCH v7 07/31] arm64/sysreg: Add ICC_PPI_{C/S}ACTIVER<n>_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-7-12e71f1b3528@kernel.org>
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

Add ICC_PPI_{C/S}ACTIVER<n>_EL1 registers description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 728223df482d..f1650034e348 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3188,6 +3188,89 @@ Sysreg	ICC_PPI_ENABLER1_EL1	3	0	12	10	7
 Fields ICC_PPI_ENABLERx_EL1
 EndSysreg
 
+SysregFields	ICC_PPI_ACTIVERx_EL1
+Field	63	Active63
+Field	62	Active62
+Field	61	Active61
+Field	60	Active60
+Field	59	Active59
+Field	58	Active58
+Field	57	Active57
+Field	56	Active56
+Field	55	Active55
+Field	54	Active54
+Field	53	Active53
+Field	52	Active52
+Field	51	Active51
+Field	50	Active50
+Field	49	Active49
+Field	48	Active48
+Field	47	Active47
+Field	46	Active46
+Field	45	Active45
+Field	44	Active44
+Field	43	Active43
+Field	42	Active42
+Field	41	Active41
+Field	40	Active40
+Field	39	Active39
+Field	38	Active38
+Field	37	Active37
+Field	36	Active36
+Field	35	Active35
+Field	34	Active34
+Field	33	Active33
+Field	32	Active32
+Field	31	Active31
+Field	30	Active30
+Field	29	Active29
+Field	28	Active28
+Field	27	Active27
+Field	26	Active26
+Field	25	Active25
+Field	24	Active24
+Field	23	Active23
+Field	22	Active22
+Field	21	Active21
+Field	20	Active20
+Field	19	Active19
+Field	18	Active18
+Field	17	Active17
+Field	16	Active16
+Field	15	Active15
+Field	14	Active14
+Field	13	Active13
+Field	12	Active12
+Field	11	Active11
+Field	10	Active10
+Field	9	Active9
+Field	8	Active8
+Field	7	Active7
+Field	6	Active6
+Field	5	Active5
+Field	4	Active4
+Field	3	Active3
+Field	2	Active2
+Field	1	Active1
+Field	0	Active0
+EndSysregFields
+
+Sysreg	ICC_PPI_CACTIVER0_EL1	3	0	12	13	0
+Fields ICC_PPI_ACTIVERx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_CACTIVER1_EL1	3	0	12	13	1
+Fields ICC_PPI_ACTIVERx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_SACTIVER0_EL1	3	0	12	13	2
+Fields ICC_PPI_ACTIVERx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_SACTIVER1_EL1	3	0	12	13	3
+Fields ICC_PPI_ACTIVERx_EL1
+EndSysreg
+
 SysregFields	ICC_PPI_PRIORITYRx_EL1
 Res0	63:61
 Field	60:56	Priority7

-- 
2.48.0



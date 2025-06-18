Return-Path: <linux-pci+bounces-30033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DCEADE869
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AD2189EA57
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9202289808;
	Wed, 18 Jun 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWzs6gRD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9802874E2;
	Wed, 18 Jun 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241910; cv=none; b=X5QHPKgEBgBt+8HweT16vpB6llXAO3c/dWVdqd6vgA/VuLa7Bce4b0PVpxqINJT7HHtlM2cIrcYPMFe74o1M9YZqFfbkvimV5/PZB8arRq052IjHGNZQ3tqotPEXlcc7+tVQkmkb+MMB2Z6wv18Wh+HHLy7gwpGc7pl0qA6jaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241910; c=relaxed/simple;
	bh=S2l0YFAo3c+hXigjqX+JLCeY8JmSN+GlekAbKtYA8Uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+wtTvrlaauuiDDy9e+RYEZMTpADWSeQPjoSFeHZn/8cc6ytoNmUIM5bv1pxN8d1rBV/WMAywy6e94xXt6DB+JbtW821BEZGnsf2/oUgNUoGIcc2JJkmrLNinEWgLSSHQh03+BrgNXbbcEng+lxCJ33wdKj3RpUcye3tcbQh4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWzs6gRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC3FC4CEF0;
	Wed, 18 Jun 2025 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750241910;
	bh=S2l0YFAo3c+hXigjqX+JLCeY8JmSN+GlekAbKtYA8Uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TWzs6gRD+wARiYZyjAXvMruOfKMWREEmRVULXcIVdPB4WCqAEL/Sqw0GovMidGU32
	 P1B8prLUoDuSubTfHVhHbZI/tf2zFENmcvDlSV9zfc3+WVZKnlRY+hrqajBLzu5Owt
	 uViG6OnEq/bifg16va+ylNy6Lbv15WUb/7vJlHPN2rJc3awMBYJ71YUc2437+As77Y
	 1uBLrmE48+KzcVzmNBFs6O+WM/dTbvJHHC4E/UP9AqjTXXEtSG5aG4ZMt98hXQpsz/
	 U63/r6pVdTSxn8zVapCE4iYC7F2O9EyUDIncYj1PODaavh38B/q5hZUqCmusAle4O5
	 Z1DIbGyRF6XoQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 18 Jun 2025 12:17:23 +0200
Subject: [PATCH v5 08/27] arm64/sysreg: Add ICC_PPI_{C/S}PENDR<n>_EL1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-gicv5-host-v5-8-d9e622ac5539@kernel.org>
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

Add ICC_PPI_{C/S}PENDR<n>_EL1 registers description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index f1650034e348..78a51fbf3a99 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3271,6 +3271,89 @@ Sysreg	ICC_PPI_SACTIVER1_EL1	3	0	12	13	3
 Fields ICC_PPI_ACTIVERx_EL1
 EndSysreg
 
+SysregFields	ICC_PPI_PENDRx_EL1
+Field	63	Pend63
+Field	62	Pend62
+Field	61	Pend61
+Field	60	Pend60
+Field	59	Pend59
+Field	58	Pend58
+Field	57	Pend57
+Field	56	Pend56
+Field	55	Pend55
+Field	54	Pend54
+Field	53	Pend53
+Field	52	Pend52
+Field	51	Pend51
+Field	50	Pend50
+Field	49	Pend49
+Field	48	Pend48
+Field	47	Pend47
+Field	46	Pend46
+Field	45	Pend45
+Field	44	Pend44
+Field	43	Pend43
+Field	42	Pend42
+Field	41	Pend41
+Field	40	Pend40
+Field	39	Pend39
+Field	38	Pend38
+Field	37	Pend37
+Field	36	Pend36
+Field	35	Pend35
+Field	34	Pend34
+Field	33	Pend33
+Field	32	Pend32
+Field	31	Pend31
+Field	30	Pend30
+Field	29	Pend29
+Field	28	Pend28
+Field	27	Pend27
+Field	26	Pend26
+Field	25	Pend25
+Field	24	Pend24
+Field	23	Pend23
+Field	22	Pend22
+Field	21	Pend21
+Field	20	Pend20
+Field	19	Pend19
+Field	18	Pend18
+Field	17	Pend17
+Field	16	Pend16
+Field	15	Pend15
+Field	14	Pend14
+Field	13	Pend13
+Field	12	Pend12
+Field	11	Pend11
+Field	10	Pend10
+Field	9	Pend9
+Field	8	Pend8
+Field	7	Pend7
+Field	6	Pend6
+Field	5	Pend5
+Field	4	Pend4
+Field	3	Pend3
+Field	2	Pend2
+Field	1	Pend1
+Field	0	Pend0
+EndSysregFields
+
+Sysreg	ICC_PPI_CPENDR0_EL1	3	0	12	13	4
+Fields ICC_PPI_PENDRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_CPENDR1_EL1	3	0	12	13	5
+Fields ICC_PPI_PENDRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_SPENDR0_EL1	3	0	12	13	6
+Fields ICC_PPI_PENDRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_SPENDR1_EL1	3	0	12	13	7
+Fields ICC_PPI_PENDRx_EL1
+EndSysreg
+
 SysregFields	ICC_PPI_PRIORITYRx_EL1
 Res0	63:61
 Field	60:56	Priority7

-- 
2.48.0



Return-Path: <linux-pci+bounces-3935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA286159F
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000361F257FC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A685C53;
	Fri, 23 Feb 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiMkzcS5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F882897;
	Fri, 23 Feb 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701788; cv=none; b=i+v1w9TE4n32L/Vns6i+Pfb9R6aNjEw3ttjbeUvy96Cw4dlu4Slc/rBEmYzc0NGb8AhuEMA/C+xZM9UWAsd/GxfmCx9lmuOB7s8+hVUC7GLJMZr3BAVCnpnJKEXynWEhoVsJv0dw0umUd+XS5XghEN9GMNOSly9Yiy2s4HSjwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701788; c=relaxed/simple;
	bh=gJZHjSh3y+j7s4q6gU9xs2cqQ5VjywqHBbKDaqt8bfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjL9OCuZLrvwXPKJBDUnoS5igpjZYuA91F4zumxkbn5vX3j5CKXGZc1VqrhrRrCew68rW7FCtayy33AsVyP0kX/YkvvKdEfLd0B+AEHb6pZ51lSuFlo/E28z2Ce84B2C7WqDtOH4Mg6g6eTJXMXOrCDPuEpUlg1kJsOZwjrK1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiMkzcS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC6BC43330;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=gJZHjSh3y+j7s4q6gU9xs2cqQ5VjywqHBbKDaqt8bfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiMkzcS5oV2wh7PEl8kSNanLJNv9U7lFD6i8q8LVXxXNHLUXjNvxiuc0rYsong6Wc
	 ssaUlKFv2vUQxAvUh5ohXotOVix5xcW6mw0RzrerVcMqjFetoIlEERDmqr5mce6Qcc
	 XwnYtEkq/uLvlQRpceVaADrgfs9Imbm+dGSZqIgHIwtBcxkdEhBRt0N2VYIrLO/Vt0
	 sp8ZyJ78zBABDxRmwmdR2VcxdeiT5HdliQYerU4Hz/Jv+sqYfnLXkbCs/sq2yCSsQL
	 bzIviGKvXSsQ3QW8HIMa+y5YX0YE+ktaMj0f6cCVBqChoIby88UN58LnYLyJeNguVV
	 LGkJxduKxYYHQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005Fd-0t1U;
	Fri, 23 Feb 2024 16:23:11 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 05/12] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
Date: Fri, 23 Feb 2024 16:21:17 +0100
Message-ID: <20240223152124.20042-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223152124.20042-1-johan+linaro@kernel.org>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing PCIe CX performance level votes to avoid relying on
other drivers (e.g. USB or UFS) to maintain the nominal performance
level required for Gen3 speeds.

Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")
Cc: stable@vger.kernel.org      # 6.2
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0a40b8dec14e..95c7b746407f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1780,6 +1780,7 @@ pcie4: pcie@1c00000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_4_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie4_phy>;
 			phy-names = "pciephy";
@@ -1878,6 +1879,7 @@ pcie3b: pcie@1c08000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_3B_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie3b_phy>;
 			phy-names = "pciephy";
@@ -1976,6 +1978,7 @@ pcie3a: pcie@1c10000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_3A_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie3a_phy>;
 			phy-names = "pciephy";
@@ -2077,6 +2080,7 @@ pcie2b: pcie@1c18000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_2B_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie2b_phy>;
 			phy-names = "pciephy";
@@ -2175,6 +2179,7 @@ pcie2a: pcie@1c20000 {
 			reset-names = "pci";
 
 			power-domains = <&gcc PCIE_2A_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			phys = <&pcie2a_phy>;
 			phy-names = "pciephy";
-- 
2.43.0



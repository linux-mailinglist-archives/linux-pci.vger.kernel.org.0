Return-Path: <linux-pci+bounces-3930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C52E86157B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B049DB244F3
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F4684A28;
	Fri, 23 Feb 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq1iHvpQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74B839E9;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701787; cv=none; b=YdGkCuFaZra5ZMJzCCTvbQuWkfuvs18TZzYdaqUkuDpUs0ADA7N4fNuK3EDGyRnfJiWGCy1WPKOz4Gg1Uv+lBMeNRR8DQPZWn/bRbe1m+olsLEV1ob0R6LpB7tAldbMnuRnsc64UxP+QCesVx6EX0sNdbjNGCbpFbpG5z73KwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701787; c=relaxed/simple;
	bh=z+xNJkOnkPu4NA9y+sepSglA9ZK8sFGfzstRMLlnHqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTwki4s50OhCAup6esaRyE15X/5fVKUsji5Q5eivZDhJcTKLtUnG2GaPUtXMrEPV9vU+7djJl7GhOO28FbNGv3Qo7wKr0qBX0/P07p1Az9tb+H7muDFj8agrocakebzmVhwIOR1VLb+YO5DVnna3xpb1hetQRWjam3OChW2f15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq1iHvpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817F6C433F1;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=z+xNJkOnkPu4NA9y+sepSglA9ZK8sFGfzstRMLlnHqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pq1iHvpQPJc25pdkX9izR9+w19YL7duFOwQjdtKPK6T/7leudryEtHQTE18kUOt2u
	 YgVZ0BLfP0vp5uYqyf/4j7iQ5ojoXzfBJF+W5v+hTZ5GoLJG1m1GIkpbVFVzdadG7f
	 MtJEgh/MU+HhMudb9puj6DK6tpx2KlLYVvEZdpa1KM3WqshTckQs/SCePQtPIxc1v9
	 Q3UrDhyPz7F78EseRUNulsY2artyR9UdCedcqrKS19eyGWBsDN1J56YVLCRaYcdRas
	 cMHRX3TlYssE4a9jsovqSrHGVzNIQZ6rS5R65dh30LDWhnCpHmGUY9OnHhZ7h8akKm
	 KVbL4NqELE2RQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOJ-000000005Ft-2wsE;
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
Subject: [PATCH v2 11/12] arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for NVMe and modem
Date: Fri, 23 Feb 2024 16:21:23 +0100
Message-ID: <20240223152124.20042-12-johan+linaro@kernel.org>
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

There are indications that ASPM L0s is not working very well on this
machine so disable it also for the NVMe and modem controllers for now.

Note that this is done as a precaution based on problems with the Wi-Fi
on the X13s as well as the NVMe, modem and Wi-Fi on the sc8280xp-crd
reference design (the NVMe controller on my X13s does not support L0 and
the machine lacks a modem).

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Cc: stable@vger.kernel.org      # 6.7
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 70824294108e..06fc88d5d025 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -730,6 +730,8 @@ keyboard@68 {
 };
 
 &pcie2a {
+	aspm-no-l0s;
+
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
 
@@ -749,6 +751,8 @@ &pcie2a_phy {
 };
 
 &pcie3a {
+	aspm-no-l0s;
+
 	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0



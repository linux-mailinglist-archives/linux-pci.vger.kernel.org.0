Return-Path: <linux-pci+bounces-3359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3585851A2E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D608B1C22473
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086783F8FB;
	Mon, 12 Feb 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8rGL4pv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723D3D996;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=XCdlHDIyKMnbFwFlelDuLCAimX83J3ZAQQGhQfpxZ6kRL+tXFVyEGHkvpBqnYuXQx2R36TTOAla5X1sWpczHRFpI33qeEpUoh5CTcMZ1Q8qg+Zb4OdoVj5GfljjQZScVThxJmAInzObXoAiksBWqVCJ1fqmVRrtONwForKhtrwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=nc3KMv6LaxhZJZMcRLz/F3lbKNxPeRWIM/UQNUFhBwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/Qpxm+PCN0D7/CnolXMmdGdNhj8wbSx6ThI4qbRMJlhLkJ8RK7GrNu1U/Rl+ROahTucW3cNkSm5ZsTqw7G9Yob6eDw4U7aaQNXYK+lHQzxgrzcRJ1G/nWhhLzSIBEO5doqyTtijQt5e8V/GTj6QXkIRjt8gWQUQL7+2ci97Zkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8rGL4pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF1C32781;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=nc3KMv6LaxhZJZMcRLz/F3lbKNxPeRWIM/UQNUFhBwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8rGL4pvSvJ8SJXhzR6YZt4uxpFW2O6EKr/IfVHspDA6tIcbJiTJkUU3+xp0RmEVM
	 YX/rEdOmlQbCoxEOpN3zcbnDtwF6NKzych7w9+JDth73pWQdZiEQV9n5wuyM8LTxHT
	 HmKIhddBIRGWm16YTuw1GfFRvit6ch806/mWpcBk3lF5NjbhzwBc44So/YJy+pu09r
	 hddkBd+sPF7dJR76fOMHh4PECQYNrGuYPqoj11F5EOAUqDDcJrcA+qIGO32P7zEBY+
	 G5MWve+W9ziqS6B391s1ScXfw1ivWxxichFfAi+uBdS2uQNLpfTd76uOxFzfiBZ2mW
	 /dXCBhAp8neDg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007NF-4AyO;
	Mon, 12 Feb 2024 17:53:53 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [RFC 09/10] arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for NVMe
Date: Mon, 12 Feb 2024 17:50:42 +0100
Message-ID: <20240212165043.26961-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212165043.26961-1-johan+linaro@kernel.org>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling ASPM L0s on the CRD results in a large amount of Correctable
Errors (Timeout) when accessing the NVMe controller so disable it for
now.

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 8c1fccf8847a..a428ba624ce1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -525,6 +525,8 @@ keyboard@68 {
 };
 
 &pcie2a {
+	aspm-no-l0s;
+
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0



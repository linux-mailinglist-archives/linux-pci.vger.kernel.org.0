Return-Path: <linux-pci+bounces-7666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA878C9F1C
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7851C21B4D
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B11138482;
	Mon, 20 May 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BkY1enSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E2137C34
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216869; cv=none; b=jVZwLC80nJ1/b8BNHJ/uCvPdG7H3nx5GYTwWeMMVEgbWcf7NCv6FzqKMZGDa3cka1pcFFu3VlJwb5xWQeIbKF6xHXSjnuQnMUi/MIEPv9BN7X1UUGtxCjFMKStzZfMapnXbkxEoPqimU/whDDf+nAGbxmSvRJ7T3rafIo0a1zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216869; c=relaxed/simple;
	bh=jvMliZyp5b79r8W0ZhbR9tXovMVqI+2d9dyyz9g1J6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sizu78BtpEva8m+F4A8lCItkniWZfYNI3Zgb11jHf7a22bSq+1EoSyUrcZa6vTSZQAIkMtcc1nLDfYZ5ITw1zTQ8VAAr4brEuKRVWOY9PC5Tgou3ZNKG/nL3A2AIfPpK5+zWldeNZkok5uUAfEeTEcKEaNev+5zBJyjVvErwt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BkY1enSM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716216866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBzV40mF6T/nwZNSQ5a6icyFUiLmHUNqTXGAGDGS/rc=;
	b=BkY1enSMesoupvQV3VJmFH6uOsyEur3jxfmWpBAIXWZOtSAzK12EwcEF/bzn5kCEIzz/9C
	KU2NPAJQy0Mq98o86gVlUE4VzqNTQZp1AW88LeoOtFntnsVH+EasX6Ni5ck+oPtvpt7jci
	xBGfLvL3Qf9jTHUJzxY0Mfdqy/fncCk=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 7/7] arm64: zynqmp: Add PCIe phys
Date: Mon, 20 May 2024 10:54:02 -0400
Message-Id: <20240520145402.2526481-8-sean.anderson@linux.dev>
In-Reply-To: <20240520145402.2526481-1-sean.anderson@linux.dev>
References: <20240520145402.2526481-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add PCIe phy bindings for the ZCU102.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Tested-by: thippeswamy.havalige@amd.com
---

(no changes since v2)

Changes in v2:
- Remove phy-names

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index ad8f23a0ec67..d2175f3dd099 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -941,6 +941,7 @@ conf-pull-none {
 
 &pcie {
 	status = "okay";
+	phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
 };
 
 &psgtr {
-- 
2.35.1.1320.gc452695387.dirty



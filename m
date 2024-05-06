Return-Path: <linux-pci+bounces-7131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9B8BD257
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 18:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D6F283C2E
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332DB15746E;
	Mon,  6 May 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UpPf7Ox7"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1488157E94
	for <linux-pci@vger.kernel.org>; Mon,  6 May 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012143; cv=none; b=GGPqZi5I2cVV4V1bSr+/AqJzQycbpTSQi3Dl0gB/R2dv3B2FWyDPk6/hlytA2ejpPHLJU2UNg1umzu0HXIoZu/KoqfVkIGn4fZLfTt/RMn6E91Tc9vd6o+q6y8I6/YF3mWVM3+phgQlqX7Ht9kPUCpxHd7LOhxd7UMfFF8o+WFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012143; c=relaxed/simple;
	bh=T1+Rbt7S+pNf5q3CRHOo4VcokJLF+gGx7h9sjDgMKpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhCQIkmjpMzTnv9ASZR4ZOZhETlfb5aM6Wi3d0qzTHll2BmRlpfJvQTnvJH62Kaoi0YWQDk9ynH6hh2qfV3VTARuySD9ZSsz+GB+mFUcnney54PeM+NXK0ks7DRQEy8uytO/KHR4osqypDcIjAtTaMYAzh12qLzH0enw8GbP1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UpPf7Ox7; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715012140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck8JgZysAqiIqlF+N+8+WdMTAZK/jkIRufdhwHxvwE4=;
	b=UpPf7Ox7SFE6/WLTzUKvDVSsuy/M5WEJuFj+ZO70agQ5WPL0K2MGVALnPQTfs09ZEJGbEd
	HprA8xSjWt++oRwyvMRXQ7ULv9gX/siwXF8ZJJVJlLmBIpKTYbsCyhsWl7B0YtmMuNkDIM
	yQxX3tO1Qfr0Tvl43E3cmXJ0c8Fm38U=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 7/7] arm64: zynqmp: Add PCIe phys
Date: Mon,  6 May 2024 12:15:10 -0400
Message-Id: <20240506161510.2841755-8-sean.anderson@linux.dev>
In-Reply-To: <20240506161510.2841755-1-sean.anderson@linux.dev>
References: <20240506161510.2841755-1-sean.anderson@linux.dev>
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



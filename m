Return-Path: <linux-pci+bounces-20414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F4A1DB6D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0327A43CA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A318FDDE;
	Mon, 27 Jan 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPXZ5/b8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646818B47D;
	Mon, 27 Jan 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999565; cv=none; b=C1VCjGF02K+N1gjGKlGJzk3m4MsQhuuYKq/4h/CTnYe680Do8IQDz4u5rlw/aGKCZyM3BgK2UtzzxLFJDnMIPByZn6NACwD24GXV35jYRZLKTJ+5FvipjIAhhuXecG2zAuijMCmcKGjscR9E6FD1FogXM39ZnyefhzHyAobgJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999565; c=relaxed/simple;
	bh=lNb8JDsH41zRgxYMUIjSya9K5SMuyfqwPF7qvuGBD3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6TQtBORzsYm1yJ6yTSjLp/qbnkYvRU8dRMJiUst4HtjeiWwBHeEl7nO5keeNlnQrkeCYa6KCNNKZs2LbSXg6QL2IWXB9G285fdPjNtDDB0PubMxCjPRCUeq7t8Q73YrLrcq4m1PRrhXVWZzVhEdCMAzyiNlqPu07+VaYpY9lQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPXZ5/b8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737999563; x=1769535563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNb8JDsH41zRgxYMUIjSya9K5SMuyfqwPF7qvuGBD3Q=;
  b=aPXZ5/b8vocV+QpReXd3N/0bzgM+iT0g+SYyB3ywc+ZqP2n9aA71gKcO
   TaD8yxatb7smf2kIXZ9PrZhmc9edZeSAlj3uQiI8Qq612SXONB5rMWvXi
   rnO7u9zD+RzQyo2zsL1mEzGSzjKxsWa/HkM9Et+mrKUMcVbOFF8BVRT7Y
   krWV5bzkbNpItO4NJmOyXvJ5BNT3IGDl59CEt+LhjM6Hrk7+2STt7moT9
   7EPLwFtzS+48b3yD+cqtLBcDdbC6J/7UnxgPvtEu3tF2+FbSCaw1QmEz/
   puStWJyy6XTp1vjHlamzikMNb0CHD7wPAMIUlcCHYaHv21319WvQF/QJb
   g==;
X-CSE-ConnectionGUID: Zx2aZSqXTpytz2lh2BTD9w==
X-CSE-MsgGUID: ec2Pz1OiQVy97aMcoCHTWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="26069476"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="26069476"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:22 -0800
X-CSE-ConnectionGUID: Dp2jkliyQOaCf83pMywFQA==
X-CSE-MsgGUID: RMb9iF8rQqSLf+rbvGExwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113124906"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:21 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com,
	peter.colberg@altera.com,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v5 2/5] arm64: dts: agilex: add soc0 label
Date: Mon, 27 Jan 2025 11:35:47 -0600
Message-Id: <20250127173550.1222427-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a label to the soc@0 device tree node.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3:
 - Remove accepted patches from patch set.
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 1235ba5a9865..144fe74e929e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -152,7 +152,7 @@ usbphy0: usbphy {
 		compatible = "usb-nop-xceiv";
 	};
 
-	soc@0 {
+	soc0: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-- 
2.34.1



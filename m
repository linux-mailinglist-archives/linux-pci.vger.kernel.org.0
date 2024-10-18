Return-Path: <linux-pci+bounces-14864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC59A4195
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1956F1C247D2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3942010EE;
	Fri, 18 Oct 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqtpwFO9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876A200CB8;
	Fri, 18 Oct 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262912; cv=none; b=d7rz+vALOrypiFnFpY3dayKyEV/Lavu0KPR5XuLrNTfTEk3tG/F3WyPjL3sVHqb01T2+Zmrh5bcNx58zN6VsCQxRFIW+MDR75M++EY7q19R5YRdLiVLBDzE+NcfdMjLEQR7nDgVgQGM4sBXJa8nIJ1SZrO+K58x/1T0H8Alw9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262912; c=relaxed/simple;
	bh=DlMv1MbTan41VzmOrQ04+mc8hraTENCiEUVtWinjsT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYwSzKll7LvDBdwUHE7OgR8uL1PuCdNlOUMEXkvebuAuCoqhiQDNxZJSIvPaZouCAQMh8zxhWLmsR7Dtu755l3jvSNxqZ8LLqOrMXCK6KlbgWdn+MB2L7w79k50T2M0GWBkWk0kCky3OwSq8ThXtQEd9CLkeqtsH6K4n91PVRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqtpwFO9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729262910; x=1760798910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DlMv1MbTan41VzmOrQ04+mc8hraTENCiEUVtWinjsT0=;
  b=MqtpwFO9K3kNe7smMRfpd5J35EPBDceBtkvDHGzxousvNGiJ+ue6HZNw
   +Krg5tjPBKAEF5AWccCoE7/itfL+VzhT98QT6mlq5pf9q1HpEdQ6h8wpS
   gNM4H2jIfWntSV1iWDqulEMDJJbIq9y3bhHifTiuaFLgWJpGsou8zkfXh
   BBJ7jG1evQ06Ma+jaGW0O7cp4EnmbNdBUCcnjhF9j0Wtq/y3eakVgfCqP
   qPqmXeaFCsGV/Kab65Kwv/zZk1yIuvxCH5603trzbKvVwhBOAiHmlmsdY
   ZcclBOEjCbzobwJjSbYHrr5gCSvUYpzE9cTzI7JazyhCYGeYN3PGJh8f+
   g==;
X-CSE-ConnectionGUID: cW0FkppmQsio7LwNFOuuOw==
X-CSE-MsgGUID: oTwnmrtjRZWiVORPlyc7VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="46296834"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="46296834"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:48:29 -0700
X-CSE-ConnectionGUID: jJB+MDW6Rd6hmWeSO42tGg==
X-CSE-MsgGUID: LIzzA/n4Rg2pX9bw4jGO1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83658164"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:48:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 1/9] Documentation PCI: Reformat RMW ops documentation
Date: Fri, 18 Oct 2024 17:47:47 +0300
Message-Id: <20241018144755.7875-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extract the list of RMW protected PCIe Capability registers into a
bullet list to make them easier to pick up on a glance. An upcoming
change is going to add one more register among them so it will be much
cleaner to have them as bullets.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/PCI/pciebus-howto.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
index f344452651e1..e48d01422efc 100644
--- a/Documentation/PCI/pciebus-howto.rst
+++ b/Documentation/PCI/pciebus-howto.rst
@@ -217,8 +217,11 @@ capability structure except the PCI Express capability structure,
 that is shared between many drivers including the service drivers.
 RMW Capability accessors (pcie_capability_clear_and_set_word(),
 pcie_capability_set_word(), and pcie_capability_clear_word()) protect
-a selected set of PCI Express Capability Registers (Link Control
-Register and Root Control Register). Any change to those registers
-should be performed using RMW accessors to avoid problems due to
-concurrent updates. For the up-to-date list of protected registers,
-see pcie_capability_clear_and_set_word().
+a selected set of PCI Express Capability Registers:
+
+* Link Control Register
+* Root Control Register
+
+Any change to those registers should be performed using RMW accessors to
+avoid problems due to concurrent updates. For the up-to-date list of
+protected registers, see pcie_capability_clear_and_set_word().
-- 
2.39.5



Return-Path: <linux-pci+bounces-14865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193C99A4197
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE96B288CFF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FAD1FF619;
	Fri, 18 Oct 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfvLY5SS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692B1D89E9;
	Fri, 18 Oct 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262924; cv=none; b=rElCqI6/fM7lkqQpmd5nSV4kIFBvuOej18jtG4IAcfySm9bAUhYEm+d3r3h6jz/HgDTDRrXvlW8yXhpXEFEgBfD4AvwzQ/8mTzxPAMTEdTKK6xCS/zrjm+av0D7GRRoV7HMX+PmH2ClftufHdg/XDYrg5dl90oxnS9B2q0j8v6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262924; c=relaxed/simple;
	bh=enj3apdFKIyA6OP7YEjvfHBzRLKFQzhuPD2E+YIIFQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEtcc2zwcWuoQHrE/TMn5hWId7o6ru1AvK/omUhuy35yE0o/opG0jvOqYKYnWOKQ03NLoPrNjCim5yrA8p4e3Lu/wtOGeaf0RO+M3ZupYe7xV0R9byAinNir29CgvLD9U7UqilA53n4Ggqb2/ltXFHnCxWy4DrLvXo8xh3wQatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfvLY5SS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729262922; x=1760798922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=enj3apdFKIyA6OP7YEjvfHBzRLKFQzhuPD2E+YIIFQg=;
  b=gfvLY5SSZm2J2/d8GRwRjeCSO6DJnnqBnprfebu4LFaBOxUQPJ/JRUqx
   edWTXlV9aeHpvB8vrE8KY2utSnT9f+8g73mvUB/7eeUKrWk0BKBESFNLG
   5Gykjvq50BJhsZOpZaUnpvUbR50UuKTJKXGw/IaeTITwmHA+OJtH4QRuU
   tTKCLY6e+tmWzbJLN15z1HamXCiXGge3nXPef0ULtZvaPNFbfu/8JdV2G
   NZ7SxAbnpJ6UGBybbtNq2IKJF3pTUZV09xwODpXphPlO0cIPaDFGgW2mO
   3DoJ12ZeW1dpFgUxziuWPlP5ylPwP9slm+ne9/Yyua8lhsNl9FHrf7ibf
   w==;
X-CSE-ConnectionGUID: +0MAju29Qn+27AtjVc7mnQ==
X-CSE-MsgGUID: wI8fAAiXSr20YkaVspljhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="46296873"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="46296873"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:48:41 -0700
X-CSE-ConnectionGUID: lC5zwN+VRBCPix1cvLaxog==
X-CSE-MsgGUID: 2nFw/PSfQ5eRN26cWWSCfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109708567"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:48:35 -0700
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
Subject: [PATCH v9 2/9] PCI: Protect Link Control 2 Register with RMW locking
Date: Fri, 18 Oct 2024 17:47:48 +0300
Message-Id: <20241018144755.7875-3-ilpo.jarvinen@linux.intel.com>
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

PCIe Bandwidth Controller performs RMW accesses the Link Control 2
Register which can occur concurrently to other sources of Link Control
2 Register writes. Therefore, add Link Control 2 Register among the PCI
Express Capability Registers that need RMW locking.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/PCI/pciebus-howto.rst | 1 +
 include/linux/pci.h                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
index e48d01422efc..375d9ce171f6 100644
--- a/Documentation/PCI/pciebus-howto.rst
+++ b/Documentation/PCI/pciebus-howto.rst
@@ -221,6 +221,7 @@ a selected set of PCI Express Capability Registers:
 
 * Link Control Register
 * Root Control Register
+* Link Control 2 Register
 
 Any change to those registers should be performed using RMW accessors to
 avoid problems due to concurrent updates. For the up-to-date list of
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..be5ed534c39c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1274,6 +1274,7 @@ static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
 {
 	switch (pos) {
 	case PCI_EXP_LNKCTL:
+	case PCI_EXP_LNKCTL2:
 	case PCI_EXP_RTCTL:
 		return pcie_capability_clear_and_set_word_locked(dev, pos,
 								 clear, set);
-- 
2.39.5



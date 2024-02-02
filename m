Return-Path: <linux-pci+bounces-3016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E698470F3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B689289135
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EB632C88;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9YLGXzd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC2210E8;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879821; cv=none; b=UTQVfyuxAvdx9Eu5baeg2V3tsp2PSTL4c02XlZ/DCHnDvMhpfETDFohG/XjWym+BN+0gF/Yc2JTNMuURb7PkXHE558cqBm6W9Vorz5kOuztoDaVaSQmzmqcl1071MuNMeamFAE7pqRrhetNaD4lv94tpBp6rPpC1Rd8h77iJJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879821; c=relaxed/simple;
	bh=pQa5GqFFhWP6E0eHNkeenZm+JxeqakAa6yaQyxaEveI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqWLjRwTIttPZTx7xEVY0hQLkIB8Znc14ux3mhZvvDwG/zQ7Qr4AGq/CJwurSGreaTsJ9Zw3fn4l1i1Sspts3hGLwQRophGreTcfnLGii4oCtyf3Veg1E9PcpSMrz/kgGAECGsicBkqzKIZcTE7dd6x0j7OsJ3UBpwRYSc9f/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9YLGXzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602AAC43394;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706879821;
	bh=pQa5GqFFhWP6E0eHNkeenZm+JxeqakAa6yaQyxaEveI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9YLGXzdaGNwtkIyYzcf4FQRf38C1puU4CUUPFVRM34DSdzKHcTF7U5Ku/RaR57H2
	 BoA6cnRu/jjoomxH39X9VdCq3Rxv0zJ7TFXuJWP+14xdB8FgLBuY0wNFHJ2U8+GCmX
	 BE6bjCtiSmIVv1/9IvO+W2litxPBYC0N9x4A+kPsOcX2MJOW2c1I6bfsw2lwLyEkZS
	 USNHMY960yTcWXV4d5OgCW+62XJvqQZhYnBlQZzTxupMF3KE0GN0Oq5jVTkO6k246D
	 rUw6c/+wxNYiXJoUQPjtEr4/jcFxA6b2BzsGHWYomo/NmC5LOCRHOlZh5hVbkfHJft
	 p4Pbl7qj3kGqQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rVtPk-000000002yM-2zXd;
	Fri, 02 Feb 2024 14:17:04 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] PCI/AER: Fix rootport attribute paths in ABI docs
Date: Fri,  2 Feb 2024 14:16:34 +0100
Message-ID: <20240202131635.11405-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202131635.11405-1-johan+linaro@kernel.org>
References: <20240202131635.11405-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'aer_stats' directory never made it into the sixth and final
revision of the series adding the AER attributes.

Fixes: 12833017e581 ("PCI/AER: Add sysfs attributes for rootport cumulative stats")
Link: https://lore.kernel.org/lkml/20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com/
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 860db53037a5..24087d5fd417 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -100,19 +100,19 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
 Date:		July 2018
 KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-- 
2.43.0



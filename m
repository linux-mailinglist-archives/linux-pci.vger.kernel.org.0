Return-Path: <linux-pci+bounces-3017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B608470F2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0381F292EB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E742772A;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbXuRMrs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE920F7;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879821; cv=none; b=K4d9BiwD2dv5sxH9R/bhGi6Uvkca1XJBDs5hz5EJayZRPrn8McOv4Sh6ZpCYE6RFQzmcUsZOXT8+yEJeqIQAV2XEBKKxh1jBrk0yy7jdxeGXZVVx8YZFfrY44NdejhWieWYQGOjNmzD0tMALW5VuhxfI0Ve98XMVqvgPi9Xk/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879821; c=relaxed/simple;
	bh=7/Uy18fGzKFm8Z+4xRV0UmfKaJZhCd1LBnAYDNOzf2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8b8ENUOIUE/JWTGl/jBbruGy/AzxC0sHT2VtmbFNDI5e4F5YPyMSdmYVozQ59mhFYZWDoUu7srkMmDTOBkyIxOMt6B5NnU8sPC8m0lTkZw88RV38Kb0a+pmujiK9YhP3xYpC+zM/VUG3B9SnwG/dv1T4e/rsOQ5Ad9QeqlPgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbXuRMrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE29C433F1;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706879821;
	bh=7/Uy18fGzKFm8Z+4xRV0UmfKaJZhCd1LBnAYDNOzf2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbXuRMrs5aoqSlAZUuE08hlT967dJwDR/x7mcXFs8qh14W9o4PrtZmc+eusPkC9EL
	 VDdmZ9TPKyvdEj3D8mKNjjptdOBkVjIGtayV15sm3rnXeGtDUek1P0EoQm71QFbaXc
	 NOxcEP84YRyOOA0T1PPCtByDkEuBang/TiVl/FrL74IEQZVsNdQnvAlZnbo1mz8d+7
	 VwLMRzFUklWrgZASit+ItnZtxxn/JVb4PLPDoO+l2ia/tb40H40vc8XIuY9FOvvGqJ
	 YNv+q1ib+GVYQlMWu3fkqjHhrTOvO07iVoQY66CsF1Sf0vkkaFwPmYqN4iFV8gCTIt
	 S3hiccgG8Og7Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rVtPk-000000002yO-3Jds;
	Fri, 02 Feb 2024 14:17:04 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] PCI/AER: Clean up version indentation in ABI docs
Date: Fri,  2 Feb 2024 14:16:35 +0100
Message-ID: <20240202131635.11405-3-johan+linaro@kernel.org>
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

The 'KernelVersion' lines use a single space as separator instead of a
tab so the values are not aligned with the other AER attribute fields.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../ABI/testing/sysfs-bus-pci-devices-aer_stats      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 24087d5fd417..d1f67bb81d5d 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -11,7 +11,7 @@ saw any problems).
 
 What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
 Date:		July 2018
-KernelVersion: 4.19.0
+KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	List of correctable errors seen and reported by this
 		PCI device using ERR_COR. Note that since multiple errors may
@@ -32,7 +32,7 @@ Description:	List of correctable errors seen and reported by this
 
 What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
 Date:		July 2018
-KernelVersion: 4.19.0
+KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	List of uncorrectable fatal errors seen and reported by this
 		PCI device using ERR_FATAL. Note that since multiple errors may
@@ -62,7 +62,7 @@ Description:	List of uncorrectable fatal errors seen and reported by this
 
 What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
 Date:		July 2018
-KernelVersion: 4.19.0
+KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	List of uncorrectable nonfatal errors seen and reported by this
 		PCI device using ERR_NONFATAL. Note that since multiple errors
@@ -102,18 +102,18 @@ messages on the PCI hierarchy originating at that root port.
 
 What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
 Date:		July 2018
-KernelVersion: 4.19.0
+KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
 What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
 Date:		July 2018
-KernelVersion: 4.19.0
+KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
 What:		/sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
 Date:		July 2018
-KernelVersion: 4.19.0
+KernelVersion:	4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_NONFATAL messages reported to rootport.
-- 
2.43.0



Return-Path: <linux-pci+bounces-8552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F44902918
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91118B22DC6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC186A332;
	Mon, 10 Jun 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zoz8o9c+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5E1C694;
	Mon, 10 Jun 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047140; cv=none; b=Zag/aAWeBbdj5bsXCXP0WqpPgLnIlRwi8n98FXjsNeAA9lWm0W3NaxP/SwejimsC8BOVp6SuNt9pMp/hPqFiERxyVZOukj8uAu1GFP1eb6rEIjny8Jk5jvmC4ZC6XmRIJP4IBD/DipQx5A6SMWth4q1j8dPCjW5sYwWXg4hSvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047140; c=relaxed/simple;
	bh=mN2jxTYj3SWlXwYCvQfIm+FqE9ospkqoU7cSqnRH1Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6F4eZxVlzvHbS8Y0sdo4wpeJzTL+Om6urCd+ynMxlh7QDz4n9thdnW4ANq8SbtlkpWh8dYKw6OHOaWMKQuFEuLrpJWl0OwWEGkShK3oDbdTypAABqnIVg3QQjurWD2U9niL2Pq2h4+CuFvrnh1+UgaFPYpq+G6WQBLUwr6gmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zoz8o9c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0869C2BBFC;
	Mon, 10 Jun 2024 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718047139;
	bh=mN2jxTYj3SWlXwYCvQfIm+FqE9ospkqoU7cSqnRH1Wo=;
	h=From:To:Cc:Subject:Date:From;
	b=Zoz8o9c+Kr123qiV3RNthMkXHBmqhlPsCrO+DYtEHPKqLfPKJXiO1CIALkkYhPfrQ
	 aqb3R1XdlQwTIYG83bssU0POe9Ig/yFswMK44ZNZU9KpOH6K4SLoyzpcO3JU/2y1CL
	 Eu6rUKyyiIKYPPBENrFzuMEMFpKfnMGlXUMKDBZ8BtJrjFKMULCCgjQw/GEFEz/Bly
	 uhemnO6/9bYyh5YnrS45jMUUT9XjxDC/GNBCdn9yl2ZJLLXSU+U2pl3WdJ9lOHKjfx
	 JG0oBgtVlgFAyN/p4ejn6JogsL9ogzkMg1HH+iQHm4Q97dtuKAOM9Kgnf5c/GqcgxE
	 KiB8c78AmG+SA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Orphan Synopsys DesignWare xData traffic generator
Date: Mon, 10 Jun 2024 14:18:48 -0500
Message-Id: <20240610191848.955767-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Gustavo Pimentel <gustavo.pimentel@synopsys.com> is listed as the
maintainer of the Synopsys DesignWare xData traffic generator, but he's no
longer at Synopsys, and nobody has stepped up to maintain it.

Mark Synopsys DesignWare xData traffic generator as orphaned and add it to
Gustavo's entry in CREDITS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 CREDITS     | 1 +
 MAINTAINERS | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 0107047f807b..7f26123146c5 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3149,6 +3149,7 @@ S: Germany
 N: Gustavo Pimental
 E: gustavo.pimentel@synopsys.com
 D: PCI driver for Synopsys DesignWare
+D: Synopsys DesignWare xData traffic generator
 
 N: Emanuel Pirker
 E: epirker@edu.uni-klu.ac.at
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..6883761eb34f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6239,9 +6239,8 @@ S:	Maintained
 F:	drivers/usb/dwc3/
 
 DESIGNWARE XDATA IP DRIVER
-M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/misc-devices/dw-xdata-pcie.rst
 F:	drivers/misc/dw-xdata-pcie.c
 
-- 
2.34.1



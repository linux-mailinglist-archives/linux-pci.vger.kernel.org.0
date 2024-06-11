Return-Path: <linux-pci+bounces-8594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D895904007
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2136B241EE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483191E531;
	Tue, 11 Jun 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swpmyNeG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65E1BC49;
	Tue, 11 Jun 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119873; cv=none; b=NyfLs/VGkAWq1lBjdWUs1N8p1dVVab5jPHuV5VbGLLWC0m5MZ4r9Ud7aoaT0C8XxGO/PCw2gAkbUN7Ausb1WUW5XEUlzeXc7cICigPsm7017Qh36E1uEDDyBYR1O0/b706Tb959z4XAbnckjfd7RKUFnhrfwbtrHHZF4dPw6rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119873; c=relaxed/simple;
	bh=nWa2I0ni1x7CGVYOo94IphoV/DczlpKorbYMn55PJyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fscCXXfkuSZxPlOi4Eb4HjU2bfjwYgKlLHh+g/2L/MBBcRSuzxfgwYPKxMT9jjII2skFKWStrdlou2+WY0iRadeQmO0QDP/TQ0ro/fALlXCKhXW1G73QX1hD0UaxTsfzdIWJ+ijo98zCFjsrfpaC/4eKXvtVbyIggIaLM2eOVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swpmyNeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65632C2BD10;
	Tue, 11 Jun 2024 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718119872;
	bh=nWa2I0ni1x7CGVYOo94IphoV/DczlpKorbYMn55PJyk=;
	h=From:To:Cc:Subject:Date:From;
	b=swpmyNeGUgHczBgu008nXjZabG7e4l5N+gP8RvzLiGm9iXCY4bu7eNgkY1KCqvrml
	 q6Mj6RKPdasyRqHmZM1je0poRZB9y1pjXigzOvOiTcDw7RI4U4ToMXRBrYCyd2xrUH
	 LcjCUtgaAaBKcNnpsufp9FQ32Z2amM4XLUhUnV24mgYV87OJMrAhD6psItsQc8PbCV
	 nBjocIYOIzbVuWhwl+dYCEuV14HKd6IXkZKgAJ3AlHLmAqy5DNLc57JhU9MW77wDqk
	 f8dhXSsbshNLPhCACoKhHjYebLUBjnV3i08Swje4UbVUd0KYq9k91WKW25cBxk6oxw
	 2y/hfc3G3Kw0g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] CREDITS: Add Synopsys DesignWare eDMA driver for Gustavo Pimentel
Date: Tue, 11 Jun 2024 10:30:59 -0500
Message-Id: <20240611153059.983667-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Add the Synopsys DesignWare eDMA driver to CREDITS for Gustavo.  See
7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 CREDITS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/CREDITS b/CREDITS
index 3a331f5fcd7a..8446e60cb78a 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3149,6 +3149,7 @@ S: Germany
 N: Gustavo Pimentel
 E: gustavo.pimentel@synopsys.com
 D: PCI driver for Synopsys DesignWare
+D: Synopsys DesignWare eDMA driver
 D: Synopsys DesignWare xData traffic generator
 
 N: Emanuel Pirker
-- 
2.34.1



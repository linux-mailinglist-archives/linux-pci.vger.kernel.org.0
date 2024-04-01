Return-Path: <linux-pci+bounces-5479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F5893AD7
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 14:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35C11F210C7
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CCF3716F;
	Mon,  1 Apr 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqwbhnnH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA537144;
	Mon,  1 Apr 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711973980; cv=none; b=Wk2WMUHvUaQgEAV7ZTKtAeZx4nmArXbT3oxaSz5iNjBc7CRJAM53r2eCPJ0WPO4+JtrsUs5XwDgJFDZGrsFGBMstteClZI358+Dk7oYotYIh3salXjLh8LlfDbMFDj4yReyRebeeT7LyhJwbM837IzKwySirUHcPSeeq7i99YBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711973980; c=relaxed/simple;
	bh=X1mhUSfY/UmiQnf7P2IuWSUfMdU420ZMt4UGK6V3MtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qmw1hrK7jbyV7A1F9OTJNP6UiGmz75y+uPoIU2y8UlMm7CVAgfK6kd6TlqzRoe+kyLwQ/euG24Q8GcgTH5OtgAiKKN4y5L0jNEG+ILmaT0IdC4BNGKTLQr5fzciSpjKHMbGz/iAt6XaXqwMfOUUJpz6TIGBzkSPzsA6Wfdj/15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqwbhnnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D95C433F1;
	Mon,  1 Apr 2024 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711973979;
	bh=X1mhUSfY/UmiQnf7P2IuWSUfMdU420ZMt4UGK6V3MtM=;
	h=From:To:Cc:Subject:Date:From;
	b=gqwbhnnH49escZvZsVPEfbsABxbKhYwEflWpgtKQJdsO4fB/g/EziMyMgBL8aXhky
	 V/mtoOaCA++UTwIo3LpwFdEgVnOqhBmE04b8dQOsDYtY0wJ3I2uWWw33PZYjgvWFK8
	 63Vq+jtzJm9U0jATGuMqIOHS0TD2cnggWi9gkDLxhr6avvDjoB7n0CyV4aMrGEq9qj
	 4yUFZd8GSehqJ3lhiQIjCzGlqsEy2xZd5keV+XmJBPaO+q7hBVObuIJralTSnX/70v
	 r4s4/owgArKoRopSIPM49JaagAJNUEvlk/r4zc6arSUp9xkWJsx+PrKtspbmNUMobV
	 qrwzb/DID03wQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rrGdV-000HqT-1d;
	Mon, 01 Apr 2024 13:19:37 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: apple: Fix dependency on 16kB pages
Date: Mon,  1 Apr 2024 13:19:33 +0100
Message-Id: <20240401121933.600977-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

While d3e5bab923d3 consolidated the various definitions for page sizes,
it ended up breaking the Apple PCIe driver, which still depends on
ARM64_PAGE_SHIFT. Switch over to HAVE_PAGE_SIZE_16KB to make the driver
selectable again.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Fixes: d3e5bab923d3 ("arch: simplify architecture specific page size configuration")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index efb5043f106a..fbcf1ff522b8 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -39,7 +39,7 @@ config PCIE_APPLE
 	depends on ARCH_APPLE || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI
-	depends on ARM64_PAGE_SHIFT = 14 || COMPILE_TEST
+	depends on HAVE_PAGE_SIZE_16KB || COMPILE_TEST
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want to enable PCIe controller support on Apple
-- 
2.39.2



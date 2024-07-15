Return-Path: <linux-pci+bounces-10253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA1931368
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 13:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E752856A4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4735D189F5F;
	Mon, 15 Jul 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TghSId/D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23623189F5E
	for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044140; cv=none; b=jyLk+9K8+Gi9+Qyh9ucoWKBAxjdZRycaoSE05nFdGFL4BmLKuH4JZRQ0SkiJD4EailS3eNvpdeQI2AGpmcYphYsx3nwUP8VWTbcr7+H2GUyjm2beglqCEbf1+d7zEfq6Tu/AE4HQk9cbZ6SgWCQGdq30YHVhB8NwHd9rKsIUUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044140; c=relaxed/simple;
	bh=MDof9J/kUGH2faUxwOMBUgghYmmAZQ9YCtpL4z5Ewq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jfJ5ggm0gvR9ez/Qi+npY3XJEF1HpXp/SkDSJANNGxZoegrVCaTsjotbR/CN0xzHgeqXLOutveMfcs4jDy4RjkO2cE4yv0EZ4EjSd/vsOD9t37gID0Q7gCfutqaKNDMYg3Up9fsq/ahh4c31s81DL0lbuc+VP6fyfnB6RGZh8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TghSId/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C863C32782;
	Mon, 15 Jul 2024 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721044139;
	bh=MDof9J/kUGH2faUxwOMBUgghYmmAZQ9YCtpL4z5Ewq4=;
	h=From:To:Cc:Subject:Date:From;
	b=TghSId/DtTD+ExUQaQ5NBfHN6OAFR9Re4ogo/y9vZRUHhLnmAYTJlsndHng427Nce
	 F5Uh0Km5rU2bbbyEWiZzBVtYfutBh1weZ7a43JWpTEvNuve/rVfr+5m43O+o+Ge8JU
	 xsiEFF40CWUhhM6u4AFTD3raynDeo9bdnvl2Hg6p691/cf5hyrmjZChHXfF6yJc5Au
	 CmLcGHnBetOJoZ4TxxHm0RQka1H11U+S0EBR/VOmveMD8zuhhkOUzyWq5NE/Gx/Haa
	 f991BFmghZALvTVPdgOjgwhUOMQ2PCZzSMifRCon2NqJRp53N4SceXNXJX6mJzhM/P
	 UeyWmF80GBjKQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 0/2] PCI: mvebu: Dispose INTx IRQs before to removing INTx domain
Date: Mon, 15 Jul 2024 13:48:52 +0200
Message-ID: <20240715114854.4792-1-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Bjorn, Thomas, Ilpo et al.

I've split the patch into two: the first introduces the new helper
function, pci_remove_irq_domain(), and the second uses this new function
instead of irq_domain_remove() in the pci-mvebu controller driver.

Marek

Marek Behún (1):
  PCI: Add pci_remove_irq_domain() helper

Pali Rohár (1):
  PCI: mvebu: Dispose INTx IRQs before to removing INTx domain

 drivers/pci/controller/pci-mvebu.c |  2 +-
 drivers/pci/irq.c                  | 21 +++++++++++++++++++++
 drivers/pci/pci.h                  |  7 +++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.44.2



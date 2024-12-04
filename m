Return-Path: <linux-pci+bounces-17658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350439E3E05
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241AAB2CD04
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBB20ADCE;
	Wed,  4 Dec 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLICcAwN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909A1B21BA;
	Wed,  4 Dec 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324511; cv=none; b=tSMhm/CL6GJ0hDvGS8ILo2sFpAcXuw0K0VEi7Y6IbmqWShpcxzYwLNdlHjK7m3TSXwnNhArTlUx9yR2vcVoCXFn7rVxD0F7/8gQewIB/imXc6jk6tVCBM9w5oGdbngaDvoWfLKf1nAscrSPsqBrMmNqKOGDC/fzZZRwi/h3gh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324511; c=relaxed/simple;
	bh=ZgmW1sBTfwJr9tj+mXvEmq9zW0CWL1uawNJ9/cc4h+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ljv+IZhNs8/gf9alXROAMSMMujpjeDEO29kQMaQzChU4ilKUqoDAkn1M30iWUaHjnHO8s+KhM8IKG5fXdgwZHYGFBEmv+r2/i7wjHJDDec9KS+tdw1pBb5MJlSCymtUDh3JbVIXkZjQUkAyTuxMqL0nJGn3ueHCF5uQYhSJ32bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLICcAwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E70C4CECD;
	Wed,  4 Dec 2024 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733324510;
	bh=ZgmW1sBTfwJr9tj+mXvEmq9zW0CWL1uawNJ9/cc4h+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=hLICcAwNyBQPVbBe1H4HFth55jRSywxIhAKDEYYsIoAv+h1uY1VksFb3r7spAWmD6
	 o/rrNu4tBkKcyeHiPwVsmB23m4CEHPHINIEk7u3J+GEpgGogpQ1IwoSX4NKZ/yCSYV
	 A7tJ8Bkk45ETaETagN+O4UUQJrWrvLQ7A7gEnFBN/t5H6mnD9jApPTSf7XBJwTWYIM
	 G8QgZ37A/vUcBdjB8XlzVU47Te0tRDEzdgN/FY/7yv3LRt3cZcy8vQO3qI8dHffY0J
	 Is+e/KWVMVr4881ubXJdq9578vCQ+qVNYWtDOUyJJJj4eP+FWVbR2ZncJ2YJIemECb
	 2ySoenyMq0exg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIqsu-000TvG-Q5;
	Wed, 04 Dec 2024 15:01:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] PCI: Convert the Apple controller to host bridge hooks
Date: Wed,  4 Dec 2024 15:01:43 +0000
Message-Id: <20241204150145.800408-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, alyssa@rosenzweig.io, Frank.Li@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The Apple PCIe controller requires some additional attention when
enabling an endpoint device, so that the RID gets correctly mapped to
a SID on its way to the IOMMU.

So far, we have need relying on a custom bus notifier to perform this
task, but Frank Li's series [1] is a better approach as it puts the
complexity in the core code instead of the host controller driver, and
this series builds on that:

- allow the new {en,dis}able_device() to be provided via pci_ecam_ops

- convert the Apple PCIe driver to that infrastructure

Patches on top of 6.13-rc1, plus Frank's v7 series.

[1] https://lore.kernel.org/r/20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com

Marc Zyngier (2):
  PCI: host-generic: Allow {en,dis}able_device() to be provided via
    pci_ecam_ops
  PCI: apple: Convert to {en,dis}able_device() callbacks

 drivers/pci/controller/pci-host-common.c |  2 +
 drivers/pci/controller/pcie-apple.c      | 75 +++++-------------------
 include/linux/pci-ecam.h                 |  4 ++
 3 files changed, 21 insertions(+), 60 deletions(-)

-- 
2.39.2



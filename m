Return-Path: <linux-pci+bounces-2830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BBD842CCC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2701F2681B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C17B3C4;
	Tue, 30 Jan 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B10Rrz0J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302627B3D2;
	Tue, 30 Jan 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643156; cv=none; b=Y3NofwRIdiF2MHgc2vUZTk5M7EU/4p45Qvm1J9VaSH4seIHJYEG7J5/BLmC9NsKDN+uQS5r85pEN7EPJaQik3qf8nw1CtqSngQEhYWD9c7jCfJyNhzW1oSf/bTJhWhVssOIngiQnokxfxSbRYpUC/K9D3Fz1EmFdBFpS6w2wf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643156; c=relaxed/simple;
	bh=hm4LhuNgl5dLYj2xElxFQYLFGgJUstMtN6A+7+93TIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ond2MkTJRwMdBJtdG8U3Gz7YUC6n/s1MV1PKdFIWq7yLkknyRv0ZhV6afJlFhjpHxunCPvejZyr/P9Tz32Ku5hUB18WoUDEzLn1Uvvb46S4/4MaiFbvGTDutePrjDC/QTmeaoTfo/MON7nf6gYAXuTcXmNPi/u5GXpHwWETCkqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B10Rrz0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE7DC433F1;
	Tue, 30 Jan 2024 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643155;
	bh=hm4LhuNgl5dLYj2xElxFQYLFGgJUstMtN6A+7+93TIo=;
	h=From:To:Cc:Subject:Date:From;
	b=B10Rrz0JCLTYqcNvBLQRrsC6acBJ+PScuAp6ToPS8JQTi4J7eDKRp2bRDRtcAa+ZF
	 YvwfrqRZul5GsTWgB3B9jMz/xkR/BeA9T+puX+RFPvVKNA4zfavk6LYpN+lPW2b8qV
	 7XdQ2C5T5an4xl6ojS6LJr9OdvGXD/3yldbgdI/F2vDGRJUZ8l9FJVXDGPzG6szuc3
	 7SHInZQmCXxUY/zAY++CN5KaWPJ/Re94Gzx08RzP60ZlOj5jANdSUgbTII2K5IGCUo
	 0+IBzbG0qI+lZKTayNZrp1cHQz9GpI8qzIybsiEfYuL0Nx1QeKMRpmlThXdUlx59bM
	 ONrtbaUMQ9CZw==
From: Niklas Cassel <cassel@kernel.org>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/3] pci_epf_alloc_space() cleanups
Date: Tue, 30 Jan 2024 20:32:08 +0100
Message-ID: <20240130193214.713739-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

Here comes some cleanups related to pci_epf_alloc_space().

Kind regards,
Niklas


Niklas Cassel (3):
  PCI: endpoint: refactor pci_epf_alloc_space()
  PCI: endpoint: improve pci_epf_alloc_space()
  PCI: endpoint: pci-epf-vntb: remove superfluous checks

 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++-----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 ++-------------
 drivers/pci/endpoint/pci-epf-core.c           | 16 +++++++++++++---
 include/linux/pci-epf.h                       |  4 +++-
 5 files changed, 21 insertions(+), 29 deletions(-)

-- 
2.43.0



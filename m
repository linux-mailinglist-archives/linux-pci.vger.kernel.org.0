Return-Path: <linux-pci+bounces-21012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B769A2D3EF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 06:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C591D16B88D
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 05:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C17B188006;
	Sat,  8 Feb 2025 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW9h8Za6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416BA41;
	Sat,  8 Feb 2025 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738991014; cv=none; b=fHYDr3Sjq8BoNniX4Arp6LMRR6Gwxj+fU+6GSdYTwiP5UEhMP9kVGYStGlfVFp+7nLUxYboCHnhyUjCC2v3pVVUHxX6dXeD0hbXAVa++9zpL3ZecDxBuZzE4qgHha2d41vYxpWvCB/KpINGupWqeNyCL0sJ5BNcQvo3BfCfZFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738991014; c=relaxed/simple;
	bh=2ODyCk+gKJrnseQ6g1H+QXVp8LXA5ZinHiJQ8be5+pI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gy+QBkRbuBy+63iP0RhEyIbMx5l2dD6A4iiwwabUcReVcJAZ4qYP0+2IBw5Cf0icw5Ue6YLXjjXCOTEUcWb8Yy+Ly5wr/6pihkt/VPiRnoYF7NoFBc5Q5KbRj2Vi6HtVMw/yJsWo36S9LelcB4K2NGJh0DGmZHq/GKYi6GFoqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW9h8Za6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582BAC4CED6;
	Sat,  8 Feb 2025 05:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738991013;
	bh=2ODyCk+gKJrnseQ6g1H+QXVp8LXA5ZinHiJQ8be5+pI=;
	h=From:To:Cc:Subject:Date:From;
	b=SW9h8Za6Lc76MUxTeFAyeb81vf6sLc8s74eAUK7rVJ7tNdoOOCH+Iyih1yKU1ORnu
	 oRuq9uhqHkMqwUXBK2hNxNuzbIuUmplMubpCuFwXYldf+Obvn9id1WO0oLE4jvb4dj
	 IC3jyA9eyu59GtPl1oP9lcHdcEetx9HEwfSMGBSu5rFclmZMHCAi2tVU3KL3MHlADR
	 UXzKU6lI481bZzQe8yVNYVmGBO7qHpCJxn8I+kaiWg4rZOBhqumLWGJRAUYt0ZCZpz
	 vklAGsjL8Rw58GH8nqHK0ENlkRZGueyqmgAu2mOb2XikrJeDtSZX4H5AoQxLm5U4BP
	 OxWk8iBeLKx0g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: Avoid capability searches in save/restore state
Date: Fri,  7 Feb 2025 23:03:27 -0600
Message-Id: <20250208050329.1092214-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Reduce the number of times we search config space for PCI capabilities when
saving and restoring device state.

Bjorn Helgaas (2):
  PCI: Avoid pointless capability searches
  PCI: Cache offset of Resizable BAR capability

 drivers/pci/pci.c       | 36 +++++++++++++++++++++---------------
 drivers/pci/pci.h       |  1 +
 drivers/pci/pcie/aspm.c | 15 ++++++++-------
 drivers/pci/probe.c     |  1 +
 drivers/pci/vc.c        | 22 +++++++++++-----------
 include/linux/pci.h     |  1 +
 6 files changed, 43 insertions(+), 33 deletions(-)

-- 
2.34.1



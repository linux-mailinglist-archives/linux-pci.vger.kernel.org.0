Return-Path: <linux-pci+bounces-19258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33BA00FD8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5AF1882859
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85651C1F30;
	Fri,  3 Jan 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn3C9Y4n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802641C1F13;
	Fri,  3 Jan 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939897; cv=none; b=cc79j3GXVe+L0PPfdw8UjQwV+wOZ+Dfww/lOPHsjPEkJMYqD3i4DRDduSDkTh2PWdVjIjzjrNeGWP3WFNhxiCBoKdopCzoDF6GtCsw8RWJdVcC0Lm4HGJ2jZj0Qnf7vCnV1oB4cfIpCLEUWt3dxb546cxJmQexN/FsONnT0gBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939897; c=relaxed/simple;
	bh=nRKRLieoD4MJzJcW6U24tBShsNyJKPnuSiQ2LZElBUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qVaIv1O+rK9fdVhNqT7Qe6UyP4k6JYhk8ikMCkpcKfLIPHHgM0nPCbizdahu18AA/CXO9VbMn3yxkt6x3zo8dzVEGUKRVKRkyxQ6mhuqWfwE3x2g8qQ2G6DhZffSQ79Mey+EFMePLxzWeiCKEdESJ4JD+2y83YchUvNkkb3XrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn3C9Y4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769EFC4CECE;
	Fri,  3 Jan 2025 21:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735939896;
	bh=nRKRLieoD4MJzJcW6U24tBShsNyJKPnuSiQ2LZElBUc=;
	h=From:To:Cc:Subject:Date:From;
	b=Qn3C9Y4nUaekskAFuIWZXKs03f8Y6LMsi2cLlcWw4gErvh1XbC9UVK2IkSMzpF5sy
	 KYncJ4QYHrVFGTu/WjvDlrS3AR+4CMDtv1+tizd0KV7hg4df0t+4NZjJSQbdinuNA1
	 RfXP1Heplc4rd+ipHrZe1+RPvC13KTsaPKPd9rybPcX9Nt9S4gfNglF/xLh92CCTza
	 Ws0+KTXMry1M3Zsa4C5+TRmstRHl767r16YXo9OZKxobmVAZM+ontmXAfKhzUzBj2j
	 e2dJX3DgUBPVZlwjgCHRRVMYtalo4pS4P3eLp8W9tqjwg1msM+4iG/+fmJHlqvEZO+
	 0UFhhdqDhFOoQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI: Simplify bus range parsing
Date: Fri,  3 Jan 2025 15:31:26 -0600
Message-Id: <20250103213129.5182-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Unexport of_pci_parse_bus_range() since it's only used in drivers/pci/of.c.

Drop bus range parameters from devm_of_pci_get_host_bridge_resources()
since they're always the same values.

Update a sparc comment that referred to of_pci_get_host_bridge_resources(),
which no longer exists.

Bjorn Helgaas (3):
  PCI: Unexport of_pci_parse_bus_range()
  PCI: of: Simplify bus range parsing
  sparc/PCI: Update reference to devm_of_pci_get_host_bridge_resources()

 arch/sparc/kernel/pci_common.c |  2 +-
 drivers/pci/of.c               | 13 +++++--------
 drivers/pci/pci.h              |  7 -------
 3 files changed, 6 insertions(+), 16 deletions(-)

-- 
2.34.1



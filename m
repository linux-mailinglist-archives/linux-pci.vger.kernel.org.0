Return-Path: <linux-pci+bounces-12909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2196FC34
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 21:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63C01F277CA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265A51D47AF;
	Fri,  6 Sep 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmkRasOb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F401D4611;
	Fri,  6 Sep 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651462; cv=none; b=G1vn65jHrxgRvrbEcj7yRn9ptq933WXjyrG7Xr6u4g7GDOHntZVeyIoyvA6riTosXzU0nI7Uz0AIoPmHTFAr04o+SeV4HJ6810f0ggMzt4mqkE3AuiAWIRqkMAY24tBIi6vXd+ssZHVvq2DXvLf4y4mI5amcowTz0Upm+SWx+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651462; c=relaxed/simple;
	bh=7gSozHxOKN1b4oBqdqqH/vQTTFlC58/kfdK0diKksbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SuBFYp4/km2w7k7b7iexNJ5z6cinf44xauTcO8Epa5iMHiURZOcPxEHiVV5mCEFU18s2WKogRY/jpY46O0gnvEfkuxGEtf8GzqvNRhqe+nwWx/9w6eCkbPoNaiT/v9jhiV1tphc5VOV69+dqOxcvj9y+Ey6QHF1KEuhFsH2XMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmkRasOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69842C4CEC7;
	Fri,  6 Sep 2024 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725651461;
	bh=7gSozHxOKN1b4oBqdqqH/vQTTFlC58/kfdK0diKksbE=;
	h=Date:From:To:Cc:Subject:From;
	b=tmkRasOb0b85VQdW8BCa0UrERccpUeO3Yf8b+ACzB9XgCXw99idlOuTJMTPwM61r3
	 56NZwEAvktbG3l33O2OCx8PM/aZHGg/45h1/VMoGRdBL8+J/6fdDUCPeLi4RPDFaSM
	 6UPzGUeOtp2qXfJiSlLD+WXFn6x/gHbhm5k0v1IEgNUYEqsR7Ob0QXcc9CXU9zdi8u
	 UoE/eUbqM8deX+oAbGONulu/iSBuWpqCNdvdtU2kLXg7Rrtauz/cvwuMpWNz0l0ktz
	 /WTEHqa90RD8ZxfC+8b/57WkTXJZKXD2AfgxQhSdqApMk9HrIKah5Xro5jAQqEEKAt
	 8WoLMzfmJGLgw==
Date: Fri, 6 Sep 2024 14:37:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] PCI fixes for v6.11
Message-ID: <20240906193739.GA431645@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.11-fixes-3

for you to fetch changes up to 8f62819aaace77dd85037ae766eb767f8c4417ce:

  PCI/pwrctl: Rescan bus on a separate thread (2024-09-03 17:11:05 -0500)

These are fixes to commits merged during the v6.11 merge window.
----------------------------------------------------------------
- Unregister platform devices for child nodes when stopping a PCI device,
  even if the PCI core has already cleared the OF_POPULATED bit and
  of_platform_depopulate() doesn't do anything (Bartosz Golaszewski)

- Rescan the bus from a separate thread so we don't deadlock when
  triggering rescan from sysfs (Bartosz Golaszewski)

----------------------------------------------------------------
Bartosz Golaszewski (2):
      PCI: Don't rely on of_platform_depopulate() for reused OF-nodes
      PCI/pwrctl: Rescan bus on a separate thread

 drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
 drivers/pci/remove.c                   | 18 +++++++++++++++++-
 include/linux/pci-pwrctl.h             |  3 +++
 4 files changed, 44 insertions(+), 5 deletions(-)


Return-Path: <linux-pci+bounces-21532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CEDA36934
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 00:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FA91895FB1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 23:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924981FC7D0;
	Fri, 14 Feb 2025 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+oQalFX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B71FC0FC;
	Fri, 14 Feb 2025 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576946; cv=none; b=Gu7d+ScTnIvZvvE2+02pMz8nvOVgXgIVBhGzfoyKeqTnSk9cLoAw4T9OHRho1SIrqqhWvIhgNhiqfFJpVt3gTGzG5iV4ZeYwV7LyIvrJMazc+A6E6HD54022zTLcZXZ0qUTuXim/OhgThLpDbeHe+440lr+BudUCyeP4V/5AX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576946; c=relaxed/simple;
	bh=NHKzuo0Hc3Gclm/kbNpZ50VcBVY7WS+gvm9+b1Kjkcw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GTVXq8okUs6Cz0Q+CNlLX2O/7sRgtKhUbFOPhvN9FPsaL5KHlYI1t3A8Tak8NtIi9QM2uJkNDZLAlvSDdDEI/0CO2gO3Ky/SfPpV+W+GEBr2UDrbLWnH5pejEF0cDO+Hr2MDvNK5Q3+Vz67zMNZRBqX2U7W9DZQ1ZeE/ZbVdOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+oQalFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D16C4CED1;
	Fri, 14 Feb 2025 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739576946;
	bh=NHKzuo0Hc3Gclm/kbNpZ50VcBVY7WS+gvm9+b1Kjkcw=;
	h=Date:From:To:Cc:Subject:From;
	b=q+oQalFXEZqMRDKqPTt6CMQsprVR/QKthhmZKa+HhBL79EorifPWU8XssYcZ6hTfS
	 YjeyPMbG3w7udOhWPg0okoHTH2D8uV1YqL0Is1bs7iA25SFF1niVWENT375d6L1Syc
	 THGPwSr8rZf2SfI2T+yyJXSx0yX3wluMeqSjbG+qnVlFxSMf7qcVip9nJkREiPXX0h
	 oJvjuet1CYnLVVK8mZ17lseSy9Oz7FEIhQBjLu02J6trLCf8wJ6OzPhoZ9xmsI9Dlk
	 AKLHBKS3YbET69EcWgCLBk8jHsNjN/3+tPYO55ZtkBl9cRv6obPkplAliWpmHbQieh
	 i/E0FLHe5J1eA==
Date: Fri, 14 Feb 2025 17:49:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [GIT PULL] PCI fixes for v6.14
Message-ID: <20250214234904.GA174406@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-fixes-3

for you to fetch changes up to 81f64e925c29fe6e99f04b131fac1935ac931e81:

  PCI: Avoid FLR for Mediatek MT7922 WiFi (2025-02-13 08:36:54 -0600)

----------------------------------------------------------------
- Update a BUILD_BUG_ON() usage that works on current compilers, but breaks
  compilation on gcc 5.3.1 (Alex Williamson)

- Avoid use of FLR for Mediatek MT7922 WiFi; the device previously worked
  after a long timeout and fallback to SBR, but after a recent RRS change
  it doesn't work at all after FLR (Bjorn Helgaas)

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Fix BUILD_BUG_ON usage for old gcc

Bjorn Helgaas (1):
      PCI: Avoid FLR for Mediatek MT7922 WiFi

 drivers/pci/probe.c  | 5 +++--
 drivers/pci/quirks.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)


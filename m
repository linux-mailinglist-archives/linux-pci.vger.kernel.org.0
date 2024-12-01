Return-Path: <linux-pci+bounces-17496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB639DF42E
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 01:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E733BB211EB
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 00:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77060635;
	Sun,  1 Dec 2024 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYcagYr2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED0382;
	Sun,  1 Dec 2024 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733012086; cv=none; b=VHzBBmZiMT00PwN/jbXa3eA/r41W9AofotRDt1BxD8+atXDsyx3EEpteltdYzErRQEsh6wl0hj4UFLiv4FIoaEl/wSIuMIiR0dca1O17WbeO3G7Qx3vaUgs3hatrHhqKIYTcd0DRS/VhTrDbvBUNKRE/zPM+1cfot1it6bhisgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733012086; c=relaxed/simple;
	bh=p5HuDYXwD2uf2+Z1MhsbORsTifXEbMMXkKiZ072Qufs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CqoD8VpQP6HENg2JbDX3+Iw7ZcdSoFOu9lxWr1XJNB6UtUsIKc3iCq2jybdxWU75VVWIhkmkH0A/fP6scAvhZT9uzxSXhhWXN7vQdwNXFRo7uTviEdRD33B0jBx8L/5qbTYr25TVypZMX9vM09fJhAFIMwzz6DaoaFIRvHEmvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYcagYr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3B7C4CECC;
	Sun,  1 Dec 2024 00:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733012085;
	bh=p5HuDYXwD2uf2+Z1MhsbORsTifXEbMMXkKiZ072Qufs=;
	h=Date:From:To:Cc:Subject:From;
	b=oYcagYr2ynM0yjtz+/iEKGxaE7otJMqgMiVwDacaVK5i+fXHn8ktXbJ/HMchgRtBD
	 MoWjsA6N10gGdJdHG5wwIAhTM4gFMOheOZvNzAQpb5LP9BT7N/OgEMm8NzA8IaLElp
	 6D1m2vl01vB3fTdN3F01a11mzr0oxGRTvkMuxLRqYWm+xW60Z3kepP7yChOlgG5gzt
	 4fNL1+2mM3VceM/fNVc4SJfNTaIOnbTE4O2kPXbPU4K8CURXIY/xABs0mLSLjffpg+
	 tVtMcZNVull9czFpoOJgUsrYfZzmKN42cYul+yAgdaSrIDruAKxu/x+Eqg2K+N80hF
	 nCUjhK47gSEvg==
Date: Sat, 30 Nov 2024 18:14:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [GIT PULL] PCI fixes for v6.13
Message-ID: <20241201001444.GA2843588@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 10099266dec8275a6899e6a27dcdfebbcc726cc7:

  Merge branch 'pci/typos' (2024-11-25 13:41:00 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-1

for you to fetch changes up to 5c8418cf4025388bedd4d65ada993f7d3786cc3a:

  PCI/pwrctrl: Unregister platform device only if one actually exists (2024-11-30 11:41:25 -0600)

----------------------------------------------------------------
- When removing a PCI device, only look up and remove a platform device
  if there is an associated device node for which there could be a platform
  device, to fix a merge window regression (Brian Norris)

----------------------------------------------------------------
Brian Norris (1):
      PCI/pwrctrl: Unregister platform device only if one actually exists

 drivers/pci/remove.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)


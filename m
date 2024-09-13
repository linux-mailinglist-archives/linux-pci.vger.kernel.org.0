Return-Path: <linux-pci+bounces-13192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F229789E9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 22:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC1B1F26313
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289BE146A9F;
	Fri, 13 Sep 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyKu+iLO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B38126BE6;
	Fri, 13 Sep 2024 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259242; cv=none; b=F80YyBfxkbAaxGBBayQ1qRlJc2s9MkDkVk8M5pzsBhyV7VBeMEjgJn5OkibNVjcACqVeLl8X3jw7XLPQx5erwArDfq2Gys7tfXQimD/dlUID7VvvKLItSXVNUCg3BKi95gyhtcYkOz/a0jwDRWk/7yY0NmcAT2x3b3NdM2sEU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259242; c=relaxed/simple;
	bh=O5zkE70KT6deyUOS29B+4GelYOBik+3Ro20FthjactA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gwx3utWrNFZ3I5TaLaNAC1gnFkBV++s3omVNaayqLV5vfASRnjZjQzdC/MijXbUVpYPi98fm8h5mhh1dZL0Wh3kKArIlp3ao+7R7008zuSn8xFiTOBJ12ZXg2ThtPUrgSFqkmn6M0jIChukCHY6nJl63dtpK2mf/229tXvThxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyKu+iLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EEDC4CEC0;
	Fri, 13 Sep 2024 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726259241;
	bh=O5zkE70KT6deyUOS29B+4GelYOBik+3Ro20FthjactA=;
	h=Date:From:To:Cc:Subject:From;
	b=RyKu+iLO5OrIE4g0puqN1xel8wUYOCm4+DbfV/46B2IFe/7XN2NXPyRAe8VcOb7Ml
	 itnNJuDJZbOKOwnmH90ZuO7ZaAty0CFhqGfZbU/o6KWhzWyP+nuB5hjH7SZWIJDgT5
	 2Q0ahvErekuu9vDdeyeFNX3iNUUyCFmVNbboRAY30rCi4GgyoW+dXUJyDxsftT0mWB
	 yiYNYuUZKRiY8QqU8l2ulaUbna1NypYKLomq3S/2+eRNWPdMBJyyoTeYkM1aUYyH4Z
	 dZl3Vf+elYfj7Qp0tf8jqtSRVvPmsy+RDpy7S0ZOuG+8CQ5UfctDJgpwK+v0vUONBx
	 vJCGrND7Vdhgg==
Date: Fri, 13 Sep 2024 15:27:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [GIT PULL] PCI fixes for v6.11
Message-ID: <20240913202717.GA723839@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-fixes-4

for you to fetch changes up to fc8c818e756991f5f50b8dfab07f970a18da2556:

  PCI: Fix potential deadlock in pcim_intx() (2024-09-12 07:52:50 -0500)

Another fix to a commit merged during the v6.11 merge window.
----------------------------------------------------------------
- Prevent a possible deadlock (reported by lockdep) when a driver
  relinquishes a pci_dev, another driver claims it, and one uses
  managed pcim_enable_device() and the other doesn't (Philipp Stanner)

----------------------------------------------------------------
Philipp Stanner (1):
      PCI: Fix potential deadlock in pcim_intx()

 drivers/pci/devres.c | 2 ++
 1 file changed, 2 insertions(+)


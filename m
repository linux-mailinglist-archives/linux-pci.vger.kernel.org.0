Return-Path: <linux-pci+bounces-26152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A55A92D5A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 00:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582D0462C3B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BD921506C;
	Thu, 17 Apr 2025 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnVpmrT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8F20F087;
	Thu, 17 Apr 2025 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929706; cv=none; b=tJnpTdPUspy8XUmuTr/8dcHsS+LCNQVjLqa2nVv3RqrcLmBvvvcm/Lv/3Fri+zr5c1Rw7rJ1QG7Q4smcVBxNMLrLbDk2z3DAlZYcyeP6O+o8+PiW3b5JuMtXU9vKCjq7i/ocG0uec5FFLpvLbpT0PnWWswSMASYPzDTUCJhsDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929706; c=relaxed/simple;
	bh=iKwNcD0DbzhorP0+qFpuIvv37gAC6gf0TUKIy5g8bSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pGGuyJiRc+W6D/YiN0PWKfJPHbejoPOFXg0346+jcbdjuaixMvC5/X3LY2Pj8H6oMBJnUKvyEnSJvlTVKgWH2zWjNAS1dkZW/Rovc5X/6uJT5J3xdRvD4SNlOuGsrmrPKx1UXd2/WD4/wlTvFYsFkqj8Jxy+tDzGGOHg0fJMLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnVpmrT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A5DC4CEE4;
	Thu, 17 Apr 2025 22:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744929705;
	bh=iKwNcD0DbzhorP0+qFpuIvv37gAC6gf0TUKIy5g8bSQ=;
	h=Date:From:To:Cc:Subject:From;
	b=UnVpmrT3UfnmDP/lv999LzOeY4Z2Xqo2XNuwdMKt4C+jF1vG2sCt7oFAmaMa2drBr
	 b/Q8gyfj35K/WYgmxNW59IAB+jp8PsQARFaHOtJ1SLbW2/WE8GFHaFYJcxbULvLrzE
	 7L6MMSjeuzraJmG5h4vqzpGp/N3E4OzHtrykeSCfMeuJDOnTwGhgyCehJPWc/QN20s
	 3q4z7WzU0YrDum/q7EV0YhlgAc1kB61dYim+ID+wBGZhIXlcKINUVHBvkVoMQSp943
	 98OEXEJsSzcjz66T+D0/L5bjd7PaeFzzaH4LEInr4u7xlpBC9PwLL1zKYofG/agU0i
	 FbMwIEBuxvuew==
Date: Thu, 17 Apr 2025 17:41:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cal Peake <cp@absolutedigital.net>,
	Athul Krishna <athul.krishna.kr@protonmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nishanth Aravamudan <naravamudan@nvidia.com>
Subject: [GIT PULL] PCI fixes for v6.15
Message-ID: <20250417224143.GA134013@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-fixes-2

for you to fetch changes up to bc0b828ef6e561081ebc4c758d0c4d166bb9829c:

  Revert "PCI: Avoid reset when disabled via sysfs" (2025-04-15 17:27:40 -0500)

----------------------------------------------------------------

- Revert a reset patch that broke VFIO passthrough because devices ended up
  with no available reset mechanisms (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      Revert "PCI: Avoid reset when disabled via sysfs"

 drivers/pci/pci.c | 4 ----
 1 file changed, 4 deletions(-)


Return-Path: <linux-pci+bounces-33642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FFBB1EDA8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5617C585993
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F7286D6F;
	Fri,  8 Aug 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR9VK3pB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB423AB8A;
	Fri,  8 Aug 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673242; cv=none; b=R+6nTBpTUiycnhGPpgSb0Pjmj13fqXyPfZExkmojogj1DLYnUhaHN1Wn5hoDldnhbDVU2jlsIDoJ7VEB/n6x1ye+6Cmj8Sve9q4gVVE1KgKOuzCiULE2bC/UqpuNbW6rUOuy62IEWF/U/U6+ImfnrKA2YUpkhMXdJbUFTY2YvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673242; c=relaxed/simple;
	bh=rQmwMDzWQz54H7vq9OiRnnWfOYUPtrw0kcRO5kw4zMY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KRyicUQrAjx7Pg6AFk/rpDnxoZESysiVSeYZoaw7V98uFwuVT+/0tFYskNs+sj0V2QNQ/ahADoXEVZ4uHbr0tvA4TcajSoat61Q6fCTjvb+aZPbEi4QK+uP/G4afEYZfKqhTUZiKibnBEycl7eBzanqXXwt0yk76ptCNw7VBi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR9VK3pB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D28C4CEED;
	Fri,  8 Aug 2025 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754673241;
	bh=rQmwMDzWQz54H7vq9OiRnnWfOYUPtrw0kcRO5kw4zMY=;
	h=Date:From:To:Cc:Subject:From;
	b=YR9VK3pBsVfgBT3KUONo8ZIarEnM8VKSDuNmeLlb4weXWZHcbDCiiNWjMZq3UKCGx
	 oQohy63p3T6kFqzb7uncT2W6i75bo1a8J8v7Fl76qkreRqdoHBP2g7f5Rg91b5cEzz
	 +yZ5DvdjlyyG945gWVkObiG9eCzBzNHEqrfDYTy/CDnOTmve1SJEx5gelv9foXSq4f
	 OdFCPtjVOxJA0dDCbwD+7orIsDjupGcJoyOHd/pW3k+4JyzmiasW8CFFnL0/2hCeR0
	 x0IFSZR/SmuFAxKX1dwH970JH+2XLKD2yrhLQgccLvwAZseKSKK4oZ/1f8KyA8iozT
	 mu2RVXjOGiluQ==
Date: Fri, 8 Aug 2025 12:14:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nam Cao <namcao@linutronix.de>, Kenneth Crudup <kenny@panix.com>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [GIT PULL] PCI fixes for v6.17
Message-ID: <20250808171400.GA95044@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0bd0a41a5120f78685a132834865b0a631b9026a:

  Merge tag 'pci-v6.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2025-08-01 13:59:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-1

for you to fetch changes up to d5c647b08ee02cb7fa50d89414ed0f5dc7c1ca0e:

  PCI: vmd: Fix wrong kfree() in vmd_msi_free() (2025-08-07 11:30:12 -0500)

----------------------------------------------------------------

- Fix vmd MSI interrupt domain restructure that caused crash early in boot
  (Nam Cao)

----------------------------------------------------------------
Nam Cao (1):
      PCI: vmd: Fix wrong kfree() in vmd_msi_free()

 drivers/pci/controller/vmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


Return-Path: <linux-pci+bounces-30277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D2AE22F9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 21:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EDB3BAF5D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D32236E5;
	Fri, 20 Jun 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhQc/S03"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD65221FBF;
	Fri, 20 Jun 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750448989; cv=none; b=V6oB/vlqZu5rGX+SdhnrxE+dFoPzc0Ivae8XKxc5t7IKeaFVeg/A9dYgfxipKtZgX5PZeWdyGWkZJLgOXaX071Njg0664zW8sKhsHsu9SNUZUTqDx1+UbROakZvOpoY45Iso9ftha2UZWsqPgLN6OIrI9XfJp88zDpblqE2Y+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750448989; c=relaxed/simple;
	bh=z+HfKDdsyzsrpnsoLJvtgubg3CCA3Ue1+63lfUDySZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kj+uUjv7JQjehaxIzcxd6RGODe59ML6YY9vpqtjaeFDEu+giBR8xwOGcZEjNPIKNhAN8kX/URsw6sG1CEzDPwk2OCZC/U1QRJijDjbkWrNqmiXfEMfYVD+OyWM2F63eeDr4kynq7CR/D/XCF9lfE55k7aF0zRs2TcwCOJv+Icdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhQc/S03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F499C4CEED;
	Fri, 20 Jun 2025 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750448989;
	bh=z+HfKDdsyzsrpnsoLJvtgubg3CCA3Ue1+63lfUDySZI=;
	h=Date:From:To:Cc:Subject:From;
	b=DhQc/S03WVGLEuYA0WHsMALbHN0I+FjpCcxQivpMEIFSl1ywqChIvJ4g3l9JeJNHp
	 +j1KhC6nu9RmuzOfrawbE4gYDehN+xYl9C/AaTt93wrTDJBoNRkmHQLqZn34p6zaVF
	 Ht3mmktQu2vJr23lCTgxfQKvYCGSn/2EglOuqrLyYFjnyqzaHv9YeBVL58mIs2ATWl
	 72Q3S8yCUKA7YyBbeIvsi8FgUSgWnnqTmumAAuNZjGEsGTelXTMLAougv4LxgcALdP
	 cwTMuaa3MEXHooFOiH8NC/DOuIdkLAQG9bZx1nqiNykUnS2zWxc93yIG5uBC7CNA0P
	 5SuIJmNTkg6HA==
Date: Fri, 20 Jun 2025 14:49:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?B?TMawxqFuZyBWaeG7h3QgSG/DoG5n?= <tcm4095@gmail.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [GIT PULL] PCI fixes for v6.16
Message-ID: <20250620194947.GA1311741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-1

for you to fetch changes up to bbf10cd686835d5a4b8566dc73a3b00b4cd7932a:

  PCI: pciehp: Ignore belated Presence Detect Changed caused by DPC (2025-06-18 10:10:19 -0500)

----------------------------------------------------------------

- Set up runtime PM even for devices that lack a PM Capability as we did
  before 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
  initializing"), which broke resume in some VFIO scenarios (Mario
  Limonciello)

- Ignore pciehp Presence Detect Changed events caused by DPC, even if they
  occur after a Data Link Layer State Changed event, to fix a VFIO GPU
  passthrough regression in v6.13 (Lukas Wunner)

----------------------------------------------------------------
Lukas Wunner (1):
      PCI: pciehp: Ignore belated Presence Detect Changed caused by DPC

Mario Limonciello (1):
      PCI/PM: Set up runtime PM even for devices without PCI PM

 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 drivers/pci/pci.c                | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)


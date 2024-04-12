Return-Path: <linux-pci+bounces-6188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B28A3438
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777AB285D2D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBC114B093;
	Fri, 12 Apr 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHzal/Li"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9914AD17;
	Fri, 12 Apr 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941188; cv=none; b=W5WpAfIA5oi7ktHywL/aIfacE2cKEAsZEGL1KSqjOCjY4zYJ6Ug6+bj0FzBuwODYI0fasc/HuhDeUIGt7TzZl3FEtRgvCcKV7guLtMHXQFokVgKHCjXAQaqR1qOnjp410ulBSyGkKYhJoTjjaZWqbKaBwRgQZsX/5JTiIL5lnYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941188; c=relaxed/simple;
	bh=qb8b7mSbwJyS8ETnO/Xg6oCFvhGOYwOX6gR2VBV/lHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NpEULxmeoFt9wZSwzMDYrp3upZnB/+J9UEbCOcESL9L/bb8/SPuLy5pymLvc2vw2udpxpH9f4cT8pAPRO7MyysLMCoM0y+VMGmQf3bVqHZ6zB8VX8LqdrOd2pe+ktjTIPvmoqrWI3ZpIFqqoTTo4Ip2U+uKGSphoD0r7vk36ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHzal/Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7043C113CC;
	Fri, 12 Apr 2024 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712941187;
	bh=qb8b7mSbwJyS8ETnO/Xg6oCFvhGOYwOX6gR2VBV/lHo=;
	h=Date:From:To:Cc:Subject:From;
	b=dHzal/LiMS3Wf/DtMmhmagyVbo7tZbWiufIXe3JdcKe/+/M0gfQchNat9IHTZmuc8
	 z8l867ucXJdHawhWvp2bec4n9G8bPX20Mt4t+tlAhdy3Su+U/qOaEEPENzPmBr4MxC
	 Wfmp+tEpWVGECpzgdKXACvH0eK2nw0tIhyS+93gq3K+tG/Mxf1Jqs55CJgV0Fzsu71
	 PaJdOwfTnSBGlKXJTfveuvOlHJFNdHgMumptOPWY7FPw6r1bon8P0s4f2Qo1dgQQDc
	 YIfmsujyeAOBxzMYFnJI01V5NPgLaLhxhWeTVWpCnRcVEmSaqH+scA9+fb+8kSgTh5
	 fG9ikYRTCmIBg==
Date: Fri, 12 Apr 2024 11:59:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Edmund Raile <edmund.raile@proton.me>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [GIT PULL] PCI fixes for v6.9
Message-ID: <20240412165945.GA6532@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.9-fixes-1

for you to fetch changes up to 302b84e84d108b878efc56ebfea09474159be56b:

  Revert "PCI: Mark LSI FW643 to avoid bus reset" (2024-03-29 11:57:12 -0500)

----------------------------------------------------------------
- Revert a quirk that prevented Secondary Bus Reset for LSI / Agere FW643.
  We thought the device was broken, but the reset does work correctly on
  other platforms, and the reset avoids leaking data out of VMs (Bjorn
  Helgaas)

- Update MAINTAINERS to reflect that Gustavo Pimentel is no longer
  reachable (Manivannan Sadhasivam)

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI: Mark LSI FW643 to avoid bus reset"

Manivannan Sadhasivam (1):
      MAINTAINERS: Drop Gustavo Pimentel as PCI DWC Maintainer

 CREDITS              | 4 ++++
 MAINTAINERS          | 1 -
 drivers/pci/quirks.c | 8 --------
 3 files changed, 4 insertions(+), 9 deletions(-)


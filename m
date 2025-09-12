Return-Path: <linux-pci+bounces-36041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC01B5538D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 17:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8F11D680E3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1880221F09;
	Fri, 12 Sep 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cshk9sz/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D781ACA;
	Fri, 12 Sep 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690924; cv=none; b=i+qCY5uMIYeTfiUYoBBCS7bxTPdUJpIWrdIbyGorQjNPfPvbVVNl/sXjBXoBnHG19t77h1L8LiwcqnjVen2Q6mrUKAhSsZjqdMH6VSkFdHhpWLAP4wyGsXYaAfiO4Alj9YgjJtjgFpHaQmxh/jmxDmcCUAfJaGVZuqwjh69uSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690924; c=relaxed/simple;
	bh=zkrlxh87Pfqa6odbArry9+vOqn1frQ7KIL3iHO0zQro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RDtTLBZPwaxivmzFFCeOcdNhLli6G9Civh9wQnMH8O7IMLj95ooebCM8bLm7e/pJswLKSycgkNzfw2PxoJkY3XcBEyIkaBce9e2hVr8dahGtcF9vEc5EsL08PA4nC9NyEQH0kCS/bRwMKSpWalqpxJc1sHXhgmj3CRqlQkln3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cshk9sz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBCAC4CEF1;
	Fri, 12 Sep 2025 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757690924;
	bh=zkrlxh87Pfqa6odbArry9+vOqn1frQ7KIL3iHO0zQro=;
	h=Date:From:To:Cc:Subject:From;
	b=cshk9sz/SWdyq3FMcX/MWeO7YUhptJ/dlgMkYzth4svS5p+BizTs+5OLHlecbNRI4
	 awoRkyHhS/YvZ9q8ZITod4PolnLKJSczKEjb+ekWSsZ8WBTraJKUwXYrd6YXh2IPdz
	 Zvg80ghAfrn5MqhkqwPwFzPqBat9wRGJJdB4GKYYsdTxaumlK0eGYsMkG/vZBeNpUq
	 vJ3wyPkK+X/dWexkodPl8eOxMrDx9wETLXbOgzzdEHf5x3xUZV3nhTgyzrk6VQ95qJ
	 GelGJnGUcQx4tx2q/iV2riSBu48d7JWU9SmangsUC4Otm3J8vxnVwWQ1fIoBTjekS7
	 uLwkN869zb3RA==
Date: Fri, 12 Sep 2025 10:28:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Jan Palus <jpalus@fastmail.com>, Tony Dinh <mibodhi@gmail.com>,
	Rob Herring <robh@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.17
Message-ID: <20250912152842.GA1625331@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-3

for you to fetch changes up to b816265396daf1beb915e0ffbfd7f3906c2bf4a4:

  PCI: mvebu: Fix use of for_each_of_range() iterator (2025-09-08 14:40:27 -0500)

----------------------------------------------------------------

- Fix mvebu PCI enumeration regression caused by converting to
  for_each_of_range() iterator (Klaus Kudielka)

----------------------------------------------------------------
Klaus Kudielka (1):
      PCI: mvebu: Fix use of for_each_of_range() iterator

 drivers/pci/controller/pci-mvebu.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)


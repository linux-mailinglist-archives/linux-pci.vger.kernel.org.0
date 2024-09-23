Return-Path: <linux-pci+bounces-13395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D44983A23
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 01:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3025B1C21C57
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330DE12C499;
	Mon, 23 Sep 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlEs+M1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9112BF24;
	Mon, 23 Sep 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130874; cv=none; b=eK1I+lBCtOqR7vzEMUo87VaDcf/XAUcUqwiVrmHTnJPhVVXLu6R8BGPLSlCTCLEQu2oMSmvevfLAHgaIcmoooSrUgjbozcqoHkKwlTujW7AbyoV0mH/oM2RtlsbO7C76SzdPjkuQCfpP3g277GJNekUyB42pncqFf9IS2VhQrNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130874; c=relaxed/simple;
	bh=y5dt/MVlrx0PACCiCHbfqirF1qUGQFNGB3bz55BUHKI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dkvsHuiZo2pcb9CDhUZrXPBR9C7lEIR7EIr/ISapz+RzxNNURt+FFUu/q+8+VnUvih/yHhDbJ68Svzy8lkjGYU9ufDwO66J4akMqKOdURJiv5NT7tljxpJm7W6rJJob2hYlM3dEfd51tq2EmyJ+EZJWjwZV+Djl/nbPNhnkGpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlEs+M1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB632C4CEC4;
	Mon, 23 Sep 2024 22:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130873;
	bh=y5dt/MVlrx0PACCiCHbfqirF1qUGQFNGB3bz55BUHKI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZlEs+M1zV8rUpDi0Vx7vY8SjsEn240gN53UjPKzTDAVLjOp4MSwB+MiPRT/R3gMCk
	 iuuCwsjV4ofeX3PrIzKvwQ2bAH0597NOdEMMUOzistqDvnbUJsu50xYcn/KupJrh14
	 jaJFTlCxqp+Tr8HImVkQqSOEFw/tcvLSeiz2GpKzxDMM0qzWcyGurGvY2C1TS5RSGB
	 pAZtseGDkFIhGq30VYEAKghA0EmEXlSH+ormNQZVDfODL0BnDXwv4xlXybnDhQtVkR
	 CbXvbXvgfFTiyqatU7J5sB1C4ySTlCuQ/DwgWg2TP6tqQyVdGg9RE3eLEAnCxTAemd
	 pQYhUFRbSkuOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71AE63809A8F;
	Mon, 23 Sep 2024 22:34:37 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240919194514.GA1025547@bhelgaas>
References: <20240919194514.GA1025547@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240919194514.GA1025547@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-changes
X-PR-Tracked-Commit-Id: 81e53c0da8f8b153e049036e5ca5ca20e811c0c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a37872316c2e3288e09a1322221c83e5929768d
Message-Id: <172713087605.3509221.1221270159850509209.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:36 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 14:45:14 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a37872316c2e3288e09a1322221c83e5929768d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


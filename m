Return-Path: <linux-pci+bounces-13195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C103978A76
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 23:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431F7284C6C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710B11494CE;
	Fri, 13 Sep 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a14hLSyE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A438148317;
	Fri, 13 Sep 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261973; cv=none; b=UAXLNQfTtMKCimhlFbVZ2OfL1eFA49JjIFp9r0EZn4iNrABAez8qJ+3KfMBM7Xs1GOxWTsAUGestbUia5bLxIFYFbeQtQblRZzUBorQapaEhO3TuO2ZHqYB7OxDQmx3AfyMMJxXq4jrf2dApW8HYDyNoQvF4EeGU2sww2YcQzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261973; c=relaxed/simple;
	bh=0rgobgxlR4/tRsYuQtv3j7pdOGp9TXAlKOCmM6HGdBU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SthSa6Vx9qfDYmigpjvKglSypjrDzZkAs6Su0seN3iF5I3yPi2mddPSXo2nRhYqf5KBXrWeAjBvOi+2CIKzthZTOGYu6dtqFMCG0Bqw/vz/6NNbkyHk9Nd8bMF751InXRkJhxBb+nu7Gl24VjhBFqtnq1A5syGmoBSrqv+AaQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a14hLSyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BAAC4CEC0;
	Fri, 13 Sep 2024 21:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726261972;
	bh=0rgobgxlR4/tRsYuQtv3j7pdOGp9TXAlKOCmM6HGdBU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a14hLSyEYJ+U6xI75+CX3cXzsSTy8Q27X5dCcPnus5KfGHtokIevb0/X1+nEDi0Eq
	 rdnp4A/XSV91nFYpHktdREL5jks5q5Grp+T5q/jKb62/nAspiqpNjJyPWEt26n14wV
	 XCtfdszPvIG2sMjDNWkGFmL0lpvFrLTir0N1jxHtn0XBwwN52vb9mhNdqVKomi0gIU
	 N0nPMMwImtmaDfsjDegdTipU6Lgqo78acTpmEejqfEmjqKbod7XNV4wvwiBfRVLn/4
	 hoiWwhso40n98dC/Dfyy4XWsdlk2cARnIElB1yXcnr3HbEaMRHbmuzUENt5RIL9Z9K
	 6Da7VaCx0oCPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FB23806655;
	Fri, 13 Sep 2024 21:12:55 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913202717.GA723839@bhelgaas>
References: <20240913202717.GA723839@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913202717.GA723839@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-fixes-4
X-PR-Tracked-Commit-Id: fc8c818e756991f5f50b8dfab07f970a18da2556
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7718454f937f50f44f98c1222f5135eaef29132
Message-Id: <172626197398.2371719.2209380286408778427.pr-tracker-bot@kernel.org>
Date: Fri, 13 Sep 2024 21:12:53 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Philipp Stanner <pstanner@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 15:27:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7718454f937f50f44f98c1222f5135eaef29132

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <linux-pci+bounces-18934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ACA9FA210
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 19:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B9B161D64
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0081D190497;
	Sat, 21 Dec 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu22x0fc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C317838C;
	Sat, 21 Dec 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734807400; cv=none; b=U7wL47X7bGsDsrkpmSw2QPvdqeAjKWFYjqd05SoYGVjyVS5m+xhkd032PdG2iM/nlJFlMvPifoQW0JSu5mA+4H88cka2aiQNhtw726CiKpQm4EE3tbnrWZpUsZqoPqw6rxe4rH26WK0EK5CjZEut8xKPkjQLBbDcr6nbjlUYAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734807400; c=relaxed/simple;
	bh=9nxMp1J22zloSjt+gxz0skZepMZrf56UT9qGZGSO2Mg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QmNwKbclsW2gq1SnGIHyo/1ZwKchVGTyw4nP58KgrzXLbsRwgoqfIz8+fzHvHEh1VfhwwhfPhLH8+42+IW/OmXgnNW+0M8wfU/JHd4SaR9It9wJYblBUSn1/uzFTaTzwKuJUYA+5RSaiZMIKpwsbcca7z/eCVdkp2vmNjgKwZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu22x0fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FA7C4CECE;
	Sat, 21 Dec 2024 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734807400;
	bh=9nxMp1J22zloSjt+gxz0skZepMZrf56UT9qGZGSO2Mg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Uu22x0fcIzLTICYY9U/JRz5LY4BO1rAKG1FXzl6LDyK61KV3t7nDG8979cQ9cP+JV
	 +1XdSi5I943fevGqBf5vcFQor1oLO/cVWY2wEJ50pdiSVoF7yqRSNSTr/pkbg+DpQR
	 XbXxGTGlItpDaYBkc3DLxostL7MozUVmiUfUcN4jPi3hSxUuBEUMApa+Y5rI4r+ie0
	 7Y2dapOU4hq8aG8srCaqs/lBSqoGG4wTRgNV1MB52cJg9TqoN1/Rba+/6Bnbsfoz3c
	 t6AP585vvu+25oTwHCG4ib9laSEtU9cs/I9rVe+wLrOxaEkXgG3FqAPa9XFXx77OcE
	 E2BlNnTWOgi3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD673806656;
	Sat, 21 Dec 2024 18:56:59 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241221131251.GA1086543@rocinante>
References: <20241221131251.GA1086543@rocinante>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241221131251.GA1086543@rocinante>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-2
X-PR-Tracked-Commit-Id: 774c71c52aa487001c7da9f93b10cedc9985c371
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a99b4a369a5495dbb625e1dfb5cd7a5ff6ba4bd5
Message-Id: <173480741818.3207643.11704178580635152654.pr-tracker-bot@kernel.org>
Date: Sat, 21 Dec 2024 18:56:58 +0000
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, Niklas Schnelle <niks@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Dec 2024 22:12:51 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a99b4a369a5495dbb625e1dfb5cd7a5ff6ba4bd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <linux-pci+bounces-7726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5808CB359
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC146282B62
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12FD38FB0;
	Tue, 21 May 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecq0Q1T6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C341C698;
	Tue, 21 May 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315222; cv=none; b=mU/Qtp0GS7kJedsYQMHMY4e2zRhUAPPIsRrb0T5fg31yFeFlVY9WmLC33i9bKOLcAd/EjjrD3IgGOFDP/pK5PUwZ6GpHcuFA/jrpKyUYYXwQuzgK9sGa3UIKgQ3MrbgG2YNz3nPfgf7xAssEPrryTlJWa6aL5SVVJTWnXwqqFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315222; c=relaxed/simple;
	bh=ctFPJ4umT4wRgEUwb+naeP0z/QeKfUEcsunB47oHxpY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qsdLeCaQdtQkvLZpr5ajxvqfc4a1j6YZB5u2ju9vlbdScZgM0+luSxI66hGn9KYBfzUD8laP70TfpG4nwd0shVzEIF5fmAL/1ESgyUdYu7aPrGTURR50Ini4JOrSUdeOvqfG624HIOEqV4jlWZZ6y+GuRp92ueRU9zD9osSyNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecq0Q1T6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52190C32786;
	Tue, 21 May 2024 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716315222;
	bh=ctFPJ4umT4wRgEUwb+naeP0z/QeKfUEcsunB47oHxpY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ecq0Q1T6zBn88ltx+h400V7jhJRKbWGAhB7kUS+r5sc/JLRogPaItHqVcGG7wR4yG
	 r4K8FFslxnLOjDsGPpw/meSESNPDzUykMwMfgWq9vZ+W082VSX8pzPk5qkAQnxLsly
	 y2Op1LlB9jtlrcwaDiqx7MFhTmkGzJ/Ti6Yr+p8DAjFPFnWwEJHHsruBymGWBfUk/7
	 e5Nfaecm4mghJKttRMlSD4Y3uQql5uu350hbObNn2nZvVYRkMryEbN5vEPaV8gB/AQ
	 f90+TWBpP6lymFb+hzaRZ2/SU1QZLuPpDkwARJRXXu2iDha5ntHYEHsLq3Q4M6BgyW
	 NeHQzleUtEG7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47179C54BB2;
	Tue, 21 May 2024 18:13:42 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240520222943.GA7973@bhelgaas>
References: <20240520222943.GA7973@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240520222943.GA7973@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.10-changes
X-PR-Tracked-Commit-Id: 7ecf13fd35feed2e888686320d378769305b8322
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0bae243b2bcf2b160ae547463bf542762beef8f
Message-Id: <171631522228.20025.2848232395697067115.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:13:42 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 17:29:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.10-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0bae243b2bcf2b160ae547463bf542762beef8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


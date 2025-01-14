Return-Path: <linux-pci+bounces-19756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA8A11187
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0182116639A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 19:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48520897A;
	Tue, 14 Jan 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XydbI3NY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EF1FECC6;
	Tue, 14 Jan 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884484; cv=none; b=efzP5XDyZ0ptcg8zo60jv500nHllCRURAS2FZ0JuAII5zrQTvWnUSmL5LBb4zbz9+kpcwEipe/WQxY0ETz8/BQDe80DubqsWVYSXwKX/JL6Lb5v3yunaBiGxW4u7Kw9bLzjzm3rBhUe54ESCQqCQzI/fn+jbM3C46E+oTVEPYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884484; c=relaxed/simple;
	bh=294lTJfAY6T3krsiwY1onfO7AQ3K5vjnnwoKoxHIVo4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SsWpdVppfv81b+UssCi7UqCjIztx1gYxLZgRWkw8vjG4uV5S7wRbhpK0+maE8veh1Y14JFJdE55zPLAOd1T5AJpr7VlKr4nYJ/9rRqk65xfBgnN4Txk3oLCSe7f5I0r2N2XByF66zylKUUk9roAz6oT14XgsC3hdi1jlrDACbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XydbI3NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8777BC4CEE0;
	Tue, 14 Jan 2025 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736884483;
	bh=294lTJfAY6T3krsiwY1onfO7AQ3K5vjnnwoKoxHIVo4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XydbI3NYUopkmVJyDA7I/TVHK8EOCAWx5wkVQWSCWvegPEmgVlNMMlM19HJD1bwR/
	 BMAgEY9TJtc5K/50/YmtXSeuB1acY9RY5PlKu8ZGyvZwnw2mhhVirWNMx1Re1JzaCY
	 tqQSS0/WIaj7tG2JudiX3oBLMqMwej5fy1h/55jNGmXdvo6Y7JPLAWcHyKHXklx6mz
	 Zd9iKmALlY1a3iDYeTaRkbbFRE65wJbRgmNkB+Zx8OUgTKlO+Kqq91echw8ygsnUvc
	 bM1A9uH9cPNxcH4MzLs7mpipG6+zaoOPgOz1x4ZqEu2BI25QtNouPpIXq0WMQTL9Xb
	 +dzOeF8MXxGvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713DB380AA5F;
	Tue, 14 Jan 2025 19:55:07 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250114185629.GA477417@bhelgaas>
References: <20250114185629.GA477417@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250114185629.GA477417@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-3
X-PR-Tracked-Commit-Id: 15b8968dcb90f194d44501468b230e6e0d816d4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2
Message-Id: <173688450616.118545.158722672533196821.pr-tracker-bot@kernel.org>
Date: Tue, 14 Jan 2025 19:55:06 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lukas Wunner <lukas@wunner.de>, Evert Vorster <evorster@gmail.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Jan 2025 12:56:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f5b6a8ec18e3add4c74682f60b90c31bdf849f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <linux-pci+bounces-37623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53261BBEF46
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 20:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5011F189BDAD
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1AA2DE70E;
	Mon,  6 Oct 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QupWDp8D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6ED2D8DA6;
	Mon,  6 Oct 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775351; cv=none; b=hDfaDPveOniD14pjPGcaQRFu2jKPHDmMqLf7c6H9vIJqMpNQDF2EDxXT1+jz6GLmx1b1nO5sDJsemA49DR0lZTJXCxqv6adIPeWAhgjj8zpSQn6+V5PsWJLIvcSdtFs9CL8VB0es4RU8phbDwLXCPjxB4k7YVGk8lOBSBdrOgTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775351; c=relaxed/simple;
	bh=5ooOlWaOfW4KsyQHF8xArsJ/7sq0FETgAFci5I1u3ZU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g8RWSW0mOhKPwDXa9EVkc7XpUT+fo9xqh8I77pL3kouHDmEROoAqKT5Q3dYkXln2vZVFB5VKiSIaiWZbNt/AWBm/eXPYXhwsTTX+393DLWllM1WsHGf+Y7b0L+FAtaMz5Ay5gFLA454L246LLx7Wap7tanbJf5bgGFNMnMyigto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QupWDp8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E5EC4CEF5;
	Mon,  6 Oct 2025 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775350;
	bh=5ooOlWaOfW4KsyQHF8xArsJ/7sq0FETgAFci5I1u3ZU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QupWDp8D+kH38+dxV8NDpndwgTvlYaj9AT01wjsBwKSPKMDi1+vhXOAjMXSkob0Ak
	 aZHHr3PP9gflXp0n5E1ihIcXaUs1CMV1JcU5AoqC/uhredFnlFpnmqoixwNqBjyu6C
	 MAzE8ovkz0hlkCOK8jbbNwCky+z71YhYuuQrORzfDnFPVKhQLm+XWUyq2C/K+o2Bdp
	 UbrteXUEygdZF0rpyh8qXxj3Ci5iwV0WxcelYuBx3/Jdp6W0QoV+dGVUaDfb8owUwf
	 7+Hc54Og+CiHBBhRg+FK74ddWiVJ9Az6AvwOYvlYW1Z4vCGotyPsvEjcY6eIW771bd
	 WbpoV8sqznsiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEEC39D0C1A;
	Mon,  6 Oct 2025 18:29:01 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251006160918.GA521548@bhelgaas>
References: <20251006160918.GA521548@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251006160918.GA521548@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-changes
X-PR-Tracked-Commit-Id: 51204faa4273a64b7066b5c1b5383e9b20d58caa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
Message-Id: <175977534038.1510490.17534093334537568587.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 18:29:00 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 6 Oct 2025 11:09:18 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


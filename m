Return-Path: <linux-pci+bounces-3044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E349847AE2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 22:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1CA2846DA
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E381746;
	Fri,  2 Feb 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bymvZGh8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A08173D;
	Fri,  2 Feb 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907618; cv=none; b=eqXo9RFKYWRtfcdTm/q7d5PDrTVzRQ1qJatVEoeHIagaDoL51CrJLnK5AuuUtkFWawvGns+p450Bc/MzvqXfOZxs4ZE0R7bvlsnqakR92OVBWFpfjQtwaxdJpgB+fW9XtwzhxeozOFks5Z6Cg7EcIRn0kPzfsJSQvoRvyM8Pvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907618; c=relaxed/simple;
	bh=6ibsa5lJN6xxg57AW7ch1LjZlcCUxcKOg2T7MUqyzOc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=flHQmfT9noKDvKYwfGIMlqhPzQnlJEIcHpeVzLQZCL/BlG7Fwb6oO0psl5lVliVw+6wJNefhgWYpjzaGzXgrX4PB9IDTTZEZI+iEr9jADtpxj5exwOCfYiypegONHc8f2X581l9Iz1gb7mexUvu8IhEgQaJ/uLTvo2Ve7czbwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bymvZGh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3EDDC43390;
	Fri,  2 Feb 2024 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907617;
	bh=6ibsa5lJN6xxg57AW7ch1LjZlcCUxcKOg2T7MUqyzOc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bymvZGh8ajNe4ayyQ07qbO3yXp4joOVwmNkLbIODfqbXeADTUTB029UNdv4udYmU8
	 KAIECAsoHMVBnBtRKSQ/3x9afxyBhAtKFrvMtBYa28yl4zl7F1jUhuivtuIXNS5qic
	 bO7uSfasFFrHQaqZ89IHUgNqNLQdjRZkkcCDr1tGLeNLZOZM4oSb4aKb4unX8/G88E
	 b8Ka7FR8CYEmToqka2qppAoSyfoPq3+OyaaNL43ql5VR/E/tnS4LLy9HnWtLqAf9Sd
	 /8VuvHj0E4lDO7tfCS651Gl3WV7MUEhF71ss9uE9oWZbXeDKUdlX7RqeqHqP7fsaMx
	 nZGBwOhwfxOsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA689C04E27;
	Fri,  2 Feb 2024 21:00:17 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240202205118.GA690750@bhelgaas>
References: <20240202205118.GA690750@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240202205118.GA690750@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-1
X-PR-Tracked-Commit-Id: 925bd5e08106bd5bfbd1cb8e124c89a0b4003569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1dd6c26bca4acc145c61f98febadba64eba1877
Message-Id: <170690761769.8980.13644791476976778954.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 21:00:17 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Johan Hovold <johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Feb 2024 14:51:18 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1dd6c26bca4acc145c61f98febadba64eba1877

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


Return-Path: <linux-pci+bounces-39305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC1C08589
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 01:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A00633543B0
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37430CDAA;
	Fri, 24 Oct 2025 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlqnJiIY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D4303A1A;
	Fri, 24 Oct 2025 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349740; cv=none; b=KOphZUr/ijAN3srM86hFLdxPkuITZmjzN7riHqm9UxXhsEWqDh4B7EiKWjYUICIcln3LzINGaeOjmplt80i8lYq6WjTfZNJ9otWqPoNSDSghoMSKFrtXEnmMn55wcQ/DS7H8S5gX3NRPI99tFlpcVa0+de0Lb8RwrsvPrU2r8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349740; c=relaxed/simple;
	bh=ZyFTDKIxNzvgRWtwrO/yjPr6c+qow1NEKp1HamVZbPI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tIXvXeJVp5DhD3+1ibEWF8NVWbmpJVe0NI0vQEH5i+ABrrLtLdp8PgzFO/b1nsDd3Eg0vriOghwzfz4OLQF6Tnq6ge7SNloZWnUcUmsECllTestwS/jR1vS7Cbi+KWEp8gQlXzRh5IJsg45g5BeJ9LsRV+tXInrudLRYuU5R7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlqnJiIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53466C4CEF1;
	Fri, 24 Oct 2025 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761349740;
	bh=ZyFTDKIxNzvgRWtwrO/yjPr6c+qow1NEKp1HamVZbPI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XlqnJiIYRxG7jDUGlrgYqJuNEyP3QmS68eJ7m8d2MnKUZmQmUwBXHTaojivtAIF7K
	 da6IGCn8dcXFNtL+ve5Q7ealoLlvAWuzzQcg/QW7GYLli7O9Pm7p28kqKMxiscHP97
	 h+JT2tDXQa/UYdhuUY28UgLvVrlcM+aOIS8CotyFn1f/4hdEqnXZ/ht8n6py9E9E5A
	 ZiGh8BrtAYD6BAffx2l+kEHQksGaGKzKbzZon4BTa53+tpL6GsdSJUriDJq85J6Fgg
	 DbgUIxsl9eEj6NfJ1Zmq1OKhqcb207aMPbZBTG252rxtRC6D0bFwK92Pf535lNeTbK
	 FE9dbDbBFcwWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34216380AA54;
	Fri, 24 Oct 2025 23:48:41 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251024192903.GA1360890@bhelgaas>
References: <20251024192903.GA1360890@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251024192903.GA1360890@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-3
X-PR-Tracked-Commit-Id: df5192d9bb0e38bf831fb93e8026e346aa017ca8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31009296f8ff7f4cc8feec9bc02b87573b2aceeb
Message-Id: <176134971993.4096869.5906045247298146805.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 23:48:39 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Ron Economos <re@w6rz.net>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Christian Zigotzky <chzigotzky@xenosoft.de>, FUKAUMI Naoki <naoki@radxa.com>, Herve Codina <herve.codina@bootlin.com>, Diederik de Haas <diederik@cknow-tech.com>, Dragan Simic <dsimic@manjaro.org>, Johan Hovold <johan@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org, linux-mips@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 14:29:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31009296f8ff7f4cc8feec9bc02b87573b2aceeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


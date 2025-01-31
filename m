Return-Path: <linux-pci+bounces-20613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69514A245BC
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 00:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F291D1889F24
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 23:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C11F3FCE;
	Fri, 31 Jan 2025 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6c0MW7L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B61F3FC7;
	Fri, 31 Jan 2025 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738367305; cv=none; b=jPwU1mC4WYTnvHDbVEjs4ZE6nPhAZmdPX4d9yjz94zfXTi42Wr4ZWl7hFyFrptp7h5RXU/ajoCMlZPD9KfWml7Ym2byux0iIwpZ5F6dFtynNUbiq4+NFdhLlXcdip1AKdwpVERlEW5p92XTGE3GxGRwcddfTWUufhK07g1nKmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738367305; c=relaxed/simple;
	bh=AFpBlq0RB/rhkVycS7JARqYp+wFJ19GTEZozWT1/X3w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c5NFIK4VbJR2oohnJ7SeHLtItJmBOQsukmzo96OGfg6+9JnbQzhyeWRBGWrH0aXiX5+UBa20T+yukwTrCx3aFKG0XF+C+HWK01hHWELOyNPhbQ0rbI/aZztGNb2sslpmHBl54k0ECzw0S4sYq9/j20UCxOJifWwd1vZVXbZhtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6c0MW7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82BBC4CED1;
	Fri, 31 Jan 2025 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738367305;
	bh=AFpBlq0RB/rhkVycS7JARqYp+wFJ19GTEZozWT1/X3w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t6c0MW7LMrHsBdA3PTPMgaxq4D1PdyGk7Gpc/6ul9MWV/RJtTt2vket7RhbJNXrlY
	 Qpo+ciy6E4OPlh2JkVJZXXo5JI4ElBb6hcvxM5HdY2axCmonngbMCEDJll1qNFnOdt
	 BTOpcGU/xjSWuHlCxv1Ic0J2GDAhMBz7sYxxKyIFhMmYBpWUnhO2mePmVTvQY89+Ox
	 tIOT3HqmVjJ3oF+IrMmbbjbmxF4Wh3N0czjQ7JWBwvgs23yV4jLT5DZdWMWkIfKyOV
	 cTthSoIYBYbJz+qC0wo+3kFIkqfTTsAKGEaGNnfEF+upLmNXbWfqgUFkJHwpnm/YZW
	 zGbZvN5Q3xtag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7F380AA7D;
	Fri, 31 Jan 2025 23:48:53 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250131203417.GA697126@bhelgaas>
References: <20250131203417.GA697126@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250131203417.GA697126@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.14-fixes-1
X-PR-Tracked-Commit-Id: d555ed45a5a10a813528c7685f432369d536ae3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c0746f9dcd6f42e742d2813f9044e12f1497f8a
Message-Id: <173836733211.1763875.13223422037076748104.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 23:48:52 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Takashi Iwai <tiwai@suse.de>, Philipp Stanner <pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jan 2025 14:34:17 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.14-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c0746f9dcd6f42e742d2813f9044e12f1497f8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


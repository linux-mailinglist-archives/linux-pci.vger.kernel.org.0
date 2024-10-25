Return-Path: <linux-pci+bounces-15348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3CB9B0CC0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BE2816B0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01520EA54;
	Fri, 25 Oct 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFgs6fp2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3E20EA49;
	Fri, 25 Oct 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879825; cv=none; b=YPFq7dlmKq9Ayo52t4/6YM5zqMiprcpNU+nJb1Vs//osx+ZH4YpQNrUVKzIFkYM6YNX9CW5bgCXrTNyzd+kXmif9AGGnO52Ba6UptmMVmIUBYtWgRW9OXUQkvcnb8Z7U2pob1ow6mOWTrdWxoWXPqjeNIZcwFFVyosYSaDs74aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879825; c=relaxed/simple;
	bh=N/HqBWv1rhU1fpzWzESaOlnjbfMHKkp5mywlg7ij2YI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TB0xWynklQwPwM5/Kukpl/pmcxWOtBO6VfzZ/DsSSOJGTgWqrUZMqNRMUYyRIsBTW8NAj+3UvwRNjw52ckBvdbuTsaHQdmyi/iV0afVNVLgH6bFhFTV22sIBQ4TcVmod9SSCpjeXqx+Zu+NIZaXU/dCt9vESBIuocRQtxhLg65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFgs6fp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B7DC4CEE6;
	Fri, 25 Oct 2024 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729879824;
	bh=N/HqBWv1rhU1fpzWzESaOlnjbfMHKkp5mywlg7ij2YI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mFgs6fp28vBJantX8MJBYwD9uW/EbYYtNQnvNInkzeB4s8XE8ah8ZK48FRDrnRX0x
	 lCGDhE57nOtyx42vTZmJX/8/ZR5sqLzXmHUOzbnQyRDnSbNLtVG594mMaBpjYsxfgi
	 t8uubzGRjRvsC+18IYovLxtXb600u6zZ4TUIeTetHv/4mLQri0H1B/dLXYPJXmPDl9
	 kdCkvnlkyQjhC8+uuyLMzr5TTW2/qPlJGDqvawuZMSTJKbL6msPgpvI1nn1Toi3km/
	 kQCjAAOd9/HeBZgtv1gWlQoJx+FB+Or1jOrrytaiXWBk+vqHQqU9l8CWlzbFP2eXMs
	 eP6OPpKxJIJPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E39B53809A8B;
	Fri, 25 Oct 2024 18:10:32 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241025173125.GA1026995@bhelgaas>
References: <20241025173125.GA1026995@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241025173125.GA1026995@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-fixes-1
X-PR-Tracked-Commit-Id: ad783b9f8e78572fff3b04b6caee7bea3821eea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48005a5a74d83cac0bf6cab03342c3ae7ef975ef
Message-Id: <172987983177.2993589.15609622702744515330.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 18:10:31 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 12:31:25 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48005a5a74d83cac0bf6cab03342c3ae7ef975ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

